import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService, FollowUp, ReleaseItem, CatalogValue, Person } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';

@Component({
  selector: 'app-follow-ups',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="follow-ups-page">
      <!-- Header Banner with Create Button -->
      <div class="header-banner">
        <div>
          <h1 class="page-title">Action Items Inbox</h1>
          <p class="page-subtitle">Track, assign, and close coordination follow-ups with owners and target dates.</p>
        </div>
        <button class="btn btn-action-lg" (click)="openCreateModal()">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
          <span>New Action Point</span>
        </button>
      </div>

      <div class="glass-card table-section">
        <!-- Filter Toolbar -->
        <div class="filter-toolbar">
          <div class="filter-group search-box">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" class="filter-input" placeholder="Search unit or action..." [(ngModel)]="filterText">
          </div>

          <div class="filter-group">
            <label class="filter-label">Status:</label>
            <select class="filter-select" [(ngModel)]="filterStatus">
              <option value="all">All Statuses</option>
              <option *ngFor="let s of statusCatalogs" [value]="s.code">{{ s.label }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">Priority:</label>
            <select class="filter-select" [(ngModel)]="filterPriority">
              <option value="all">All Priorities</option>
              <option *ngFor="let p of priorityCatalogs" [value]="p.code">{{ p.label }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">Owner:</label>
            <select class="filter-select" [(ngModel)]="filterOwner">
              <option value="all">All Owners</option>
              <option *ngFor="let p of people" [value]="p.display_name">{{ p.display_name }}</option>
            </select>
          </div>

          <div class="filter-group checkbox-filter">
            <label class="filter-checkbox-label">
              <input type="checkbox" [(ngModel)]="filterBlockerOnly">
              <span>Blockers Only</span>
            </label>
          </div>

          <button class="btn btn-outline btn-sm reset-btn" *ngIf="hasActiveFilters()" (click)="resetFilters()">Reset Filters</button>
        </div>

        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th (click)="toggleSort('id')" class="sortable">
                  ACTION ID <span class="sort-icon" *ngIf="sortColumn === 'id'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('title')" class="sortable">
                  RELEASE UNIT <span class="sort-icon" *ngIf="sortColumn === 'title'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('action')" class="sortable">
                  REQUIRED ACTION <span class="sort-icon" *ngIf="sortColumn === 'action'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('priority')" class="sortable">
                  PRIORITY <span class="sort-icon" *ngIf="sortColumn === 'priority'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('owner')" class="sortable">
                  OWNER <span class="sort-icon" *ngIf="sortColumn === 'owner'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>CONTACT / DEPENDENCY</th>
                <th (click)="toggleSort('due_date')" class="sortable">
                  TARGET DATE <span class="sort-icon" *ngIf="sortColumn === 'due_date'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('status')" class="sortable">
                  STATUS <span class="sort-icon" *ngIf="sortColumn === 'status'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let f of processedFollowUps" [class.row-overdue]="isOverdue(f)">
                <td><span class="action-id">#{{ f.id }}</span></td>
                <td><span class="item-link" [title]="f.release_item?.description || f.release_item?.title">{{ f.release_item?.title }}</span></td>
                <td class="action-text">
                  <span class="blocker-pill" *ngIf="f.is_blocker">BLOCKER</span>
                  {{ f.action }}
                </td>
                <td>
                  <span class="priority-badge" [style.color]="f.priority?.color">
                    {{ f.priority?.label }}
                  </span>
                </td>
                <td>{{ f.owner?.display_name || 'Unassigned' }}</td>
                <td>{{ f.contact?.display_name || 'N/A' }}</td>
                <td>
                  <span [class.text-danger]="isOverdue(f)">{{ f.due_date || 'Not Set' }}</span>
                </td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="f.status?.color || '#9CA3AF'"></span>
                    <span class="status-text" [style.color]="f.status?.color || '#9CA3AF'">
                      {{ f.status?.label }}
                    </span>
                  </div>
                </td>
                <td>
                  <button class="btn btn-action" (click)="openEditModal(f)">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                      <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                      <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                    <span>Edit / Close</span>
                  </button>
                </td>
              </tr>
              <tr *ngIf="processedFollowUps.length === 0">
                <td colspan="9" class="empty-table-cell">
                  No action items match the selected filter criteria.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Create New Action Point Modal -->
      <div class="modal-overlay" *ngIf="showCreateModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>New Action Point</h3>
            <button class="close-btn" (click)="closeCreateModal()">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Release Unit <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="createForm.release_item_id">
                <option [ngValue]="0" disabled selected>Select Target Release Unit</option>
                <option *ngFor="let item of releaseItems" [ngValue]="item.id">{{ item.title }} ({{ item.module?.name }})</option>
              </select>
            </div>

            <div class="form-group">
              <label>Required Action <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="createForm.action" placeholder="Describe the required coordination action or task">
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Priority <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="createForm.priority_id">
                  <option *ngFor="let p of priorityCatalogs" [ngValue]="p.id">{{ p.label }}</option>
                </select>
              </div>

              <div class="form-group col">
                <label>Initial Status <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="createForm.status_id">
                  <option *ngFor="let s of statusCatalogs" [ngValue]="s.id">{{ s.label }}</option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Action Owner (Assignee)</label>
                <select class="form-control" [(ngModel)]="createForm.owner_person_id">
                  <option [ngValue]="null">Unassigned</option>
                  <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
                </select>
              </div>

              <div class="form-group col">
                <label>Contact / Dependency</label>
                <select class="form-control" [(ngModel)]="createForm.contact_person_id">
                  <option [ngValue]="null">Select Contact</option>
                  <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Target Completion Date (yyyy-mm-dd)</label>
                <input type="date" class="form-control" [(ngModel)]="createForm.due_date" placeholder="yyyy-mm-dd">
              </div>

              <div class="form-group col checkbox-group">
                <label class="checkbox-label">
                  <input type="checkbox" [(ngModel)]="createForm.is_blocker">
                  <span>Is Release Blocker?</span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label>Notes / Context</label>
              <textarea class="form-control" [(ngModel)]="createForm.notes" rows="2" placeholder="Additional background or dependencies..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeCreateModal()">Cancel</button>
            <button class="btn btn-primary" (click)="submitCreate()" [disabled]="!createForm.release_item_id || !createForm.action">Create Action Point</button>
          </div>
        </div>
      </div>

      <!-- Edit Modal -->
      <div class="modal-overlay" *ngIf="selectedFollowUp">
        <div class="modal-content">
          <div class="modal-header">
            <h3>Update Action Item #{{ selectedFollowUp.id }}</h3>
            <button class="close-btn" (click)="closeEditModal()">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Action Description <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="editForm.action">
            </div>

            <div class="form-group">
              <label>Status <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="editForm.status_id">
                <option *ngFor="let s of statusCatalogs" [ngValue]="s.id">{{ s.label }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Target Completion Date (yyyy-mm-dd)</label>
              <input type="date" class="form-control" [(ngModel)]="editForm.due_date" placeholder="yyyy-mm-dd">
            </div>

            <div class="form-group">
              <label>Contact / Dependency Person</label>
              <select class="form-control" [(ngModel)]="editForm.contact_person_id">
                <option [ngValue]="null">Select Contact</option>
                <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
              </select>
            </div>

            <div class="form-group">
              <label>Outcome / Resolution Notes</label>
              <textarea class="form-control" [(ngModel)]="editForm.outcome" rows="3" placeholder="Describe the result or confirmation evidence when closing"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeEditModal()">Cancel</button>
            <button class="btn btn-primary" (click)="saveFollowUp()">Save Changes</button>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .follow-ups-page { display: flex; flex-direction: column; gap: 1.5rem; }
    .header-banner { display: flex; justify-content: space-between; align-items: flex-end; }
    .page-title { font-size: 1.75rem; font-weight: 700; color: #FFF; }
    .page-subtitle { color: var(--text-muted); font-size: 0.9rem; }
    .required-star { color: #EF4444; font-weight: bold; margin-left: 0.15rem; }

    .btn-action-lg {
      display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.6rem 1.1rem;
      border-radius: var(--radius-md); background: linear-gradient(135deg, #6366F1 0%, #4F46E5 100%);
      color: #FFF; font-weight: 600; font-size: 0.875rem; border: 1px solid rgba(129, 140, 248, 0.4);
      box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4); cursor: pointer; transition: var(--transition-fast);
    }
    .btn-action-lg:hover { transform: translateY(-1px); box-shadow: 0 6px 18px rgba(99, 102, 241, 0.5); }

    /* Filter Toolbar Styles */
    .filter-toolbar {
      display: flex; flex-wrap: wrap; align-items: center; gap: 1rem;
      padding-bottom: 1.25rem; margin-bottom: 1rem; border-bottom: 1px solid var(--bg-surface-border);
    }
    .filter-group { display: flex; align-items: center; gap: 0.4rem; }
    .search-box {
      position: relative; background: #0F172A; border: 1px solid var(--bg-surface-border);
      border-radius: var(--radius-md); padding: 0.35rem 0.65rem; display: flex; align-items: center; gap: 0.5rem; min-width: 220px;
    }
    .search-box svg { color: var(--text-muted); }
    .filter-input { background: none; border: none; outline: none; color: #FFF; font-size: 0.825rem; width: 100%; }
    .filter-label { font-size: 0.75rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; }
    .filter-select {
      background: #0F172A; border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md);
      color: #FFF; font-size: 0.8rem; padding: 0.35rem 0.6rem; outline: none;
    }
    .checkbox-filter { margin-left: 0.25rem; }
    .filter-checkbox-label { display: flex; align-items: center; gap: 0.4rem; font-size: 0.8rem; color: #FFF; cursor: pointer; font-weight: 500; }
    .reset-btn { font-size: 0.75rem; padding: 0.3rem 0.6rem; }

    /* Column Header Sorting Styles */
    .data-table { width: 100%; border-collapse: collapse; }
    .data-table th {
      padding: 0.85rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted);
      border-bottom: 1px solid var(--bg-surface-border); user-select: none;
    }
    .data-table th.sortable { cursor: pointer; transition: color 0.15s ease; }
    .data-table th.sortable:hover { color: #FFF; }
    .sort-icon { color: var(--accent-primary); font-weight: 700; margin-left: 0.25rem; font-size: 0.85rem; }

    .data-table td { padding: 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.04); font-size: 0.85rem; vertical-align: middle; }
    .row-overdue { background: rgba(239, 68, 68, 0.05); }

    .action-id { font-family: monospace; font-weight: 700; color: var(--text-subtle); font-size: 0.75rem; }
    .item-link { font-weight: 600; color: #FFF; }
    .action-text { max-width: 280px; color: var(--text-main); }
    .blocker-pill { background: #EF4444; color: #FFF; font-size: 0.65rem; font-weight: 800; padding: 0.1rem 0.4rem; border-radius: 4px; margin-right: 0.4rem; }
    .priority-badge { font-weight: 700; font-size: 0.8rem; }
    .text-danger { color: #F87171; font-weight: 700; }

    .empty-table-cell { text-align: center; color: var(--text-muted); padding: 2.5rem 1rem; font-style: italic; }

    .form-row { display: flex; gap: 1rem; }
    .form-row .col { flex: 1; }
    .checkbox-group { display: flex; align-items: flex-end; padding-bottom: 0.5rem; }
    .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; font-size: 0.85rem; color: #FFF; font-weight: 500; }

    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
    .modal-header h3 { font-size: 1.1rem; color: #FFF; }
    .close-btn { background: none; border: none; color: var(--text-muted); font-size: 1.5rem; cursor: pointer; }
    .modal-footer { display: flex; justify-content: flex-end; gap: 0.75rem; margin-top: 1.5rem; }
  `]
})
export class FollowUpsComponent implements OnInit {
  followUps: FollowUp[] = [];
  releaseItems: ReleaseItem[] = [];
  statusCatalogs: CatalogValue[] = [];
  priorityCatalogs: CatalogValue[] = [];
  people: Person[] = [];

  // Filter & Sorting state
  filterText: string = '';
  filterStatus: string = 'all';
  filterPriority: string = 'all';
  filterOwner: string = 'all';
  filterBlockerOnly: boolean = false;

  sortColumn: string = 'id';
  sortDirection: 'asc' | 'desc' = 'asc';

  showCreateModal = false;
  createForm = {
    release_item_id: 0,
    action: '',
    status_id: 0,
    priority_id: 0,
    owner_person_id: 1 as number | null,
    contact_person_id: null as number | null,
    due_date: '',
    is_blocker: false,
    notes: '',
  };

  selectedFollowUp: FollowUp | null = null;
  editForm = {
    action: '',
    status_id: 0,
    due_date: '',
    contact_person_id: null as number | null,
    outcome: '',
  };

  constructor(
    private apiService: ApiService,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.apiService.getFollowUps().subscribe(res => {
      this.followUps = res;
    });

    this.apiService.getReleaseItems().subscribe(res => {
      this.releaseItems = res;
    });

    this.apiService.getCatalogs().subscribe(res => {
      this.statusCatalogs = res.catalogs['follow_up_status'] || [];
      this.priorityCatalogs = res.catalogs['priority'] || [];
      this.people = res.people || [];
    });
  }

  get processedFollowUps(): FollowUp[] {
    let list = [...this.followUps];

    if (this.filterText.trim()) {
      const q = this.filterText.toLowerCase();
      list = list.filter(f =>
        (f.release_item?.title && f.release_item.title.toLowerCase().includes(q)) ||
        (f.action && f.action.toLowerCase().includes(q)) ||
        (f.owner?.display_name && f.owner.display_name.toLowerCase().includes(q))
      );
    }

    if (this.filterStatus !== 'all') {
      list = list.filter(f => f.status?.code === this.filterStatus);
    }

    if (this.filterPriority !== 'all') {
      list = list.filter(f => f.priority?.code === this.filterPriority);
    }

    if (this.filterOwner !== 'all') {
      list = list.filter(f => f.owner?.display_name === this.filterOwner);
    }

    if (this.filterBlockerOnly) {
      list = list.filter(f => f.is_blocker);
    }

    list.sort((a, b) => {
      let valA: any = '';
      let valB: any = '';

      switch (this.sortColumn) {
        case 'id':
          valA = a.id;
          valB = b.id;
          break;
        case 'title':
          valA = a.release_item?.title || '';
          valB = b.release_item?.title || '';
          break;
        case 'action':
          valA = a.action || '';
          valB = b.action || '';
          break;
        case 'priority':
          valA = a.priority?.sort_order || 99;
          valB = b.priority?.sort_order || 99;
          break;
        case 'owner':
          valA = a.owner?.display_name || '';
          valB = b.owner?.display_name || '';
          break;
        case 'due_date':
          valA = a.due_date || '9999-12-31';
          valB = b.due_date || '9999-12-31';
          break;
        case 'status':
          valA = a.status?.sort_order || 99;
          valB = b.status?.sort_order || 99;
          break;
      }

      if (valA < valB) return this.sortDirection === 'asc' ? -1 : 1;
      if (valA > valB) return this.sortDirection === 'asc' ? 1 : -1;
      return 0;
    });

    return list;
  }

  toggleSort(column: string): void {
    if (this.sortColumn === column) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortColumn = column;
      this.sortDirection = 'asc';
    }
  }

  hasActiveFilters(): boolean {
    return !!this.filterText || this.filterStatus !== 'all' || this.filterPriority !== 'all' || this.filterOwner !== 'all' || this.filterBlockerOnly;
  }

  resetFilters(): void {
    this.filterText = '';
    this.filterStatus = 'all';
    this.filterPriority = 'all';
    this.filterOwner = 'all';
    this.filterBlockerOnly = false;
  }

  isOverdue(f: FollowUp): boolean {
    if (!f.due_date) return false;
    const today = new Date().toISOString().split('T')[0];
    const isCompleted = f.status?.code === 'completed' || f.status?.code === 'cancelled';
    return f.due_date < today && !isCompleted;
  }

  openCreateModal(): void {
    const defaultStatus = this.statusCatalogs.find(s => s.code === 'pending')?.id || (this.statusCatalogs[0]?.id || 0);
    const defaultPriority = this.priorityCatalogs.find(p => p.code === 'high')?.id || (this.priorityCatalogs[0]?.id || 0);
    const defaultDueDate = new Date(Date.now() + 7 * 86400000).toISOString().split('T')[0];

    this.createForm = {
      release_item_id: this.releaseItems[0]?.id || 0,
      action: '',
      status_id: defaultStatus,
      priority_id: defaultPriority,
      owner_person_id: 1,
      contact_person_id: null,
      due_date: defaultDueDate,
      is_blocker: false,
      notes: '',
    };
    this.showCreateModal = true;
  }

  closeCreateModal(): void {
    this.showCreateModal = false;
  }

  submitCreate(): void {
    if (!this.createForm.release_item_id || !this.createForm.action) return;

    this.apiService.createFollowUp(this.createForm).subscribe(() => {
      this.closeCreateModal();
      this.toastService.success('New Action Point created successfully!');
      this.loadData();
    });
  }

  openEditModal(f: FollowUp): void {
    this.selectedFollowUp = f;
    this.editForm = {
      action: f.action,
      status_id: f.status_id,
      due_date: f.due_date || '',
      contact_person_id: f.contact_person_id || null,
      outcome: f.outcome || '',
    };
  }

  closeEditModal(): void {
    this.selectedFollowUp = null;
  }

  saveFollowUp(): void {
    if (!this.selectedFollowUp) return;

    this.apiService.updateFollowUp(this.selectedFollowUp.id, this.editForm).subscribe(() => {
      this.closeEditModal();
      this.toastService.success('Action Item updated successfully!');
      this.loadData();
    });
  }
}
