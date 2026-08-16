import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService, ReleaseItem, CatalogValue, Person } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';

@Component({
  selector: 'app-matrix',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="matrix-page">
      <div class="header-banner">
        <div>
          <h1 class="page-title">Environment Tracking Matrix</h1>
          <p class="page-subtitle">Interactive grid tracking release units across MOJA, TATU, SITA, and PROD. Click any environment cell to update status.</p>
        </div>
      </div>

      <div class="glass-card table-section">
        <!-- Filter Toolbar -->
        <div class="filter-toolbar">
          <div class="filter-group search-box">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" class="filter-input" placeholder="Search by release unit name..." [(ngModel)]="filterText">
          </div>

          <div class="filter-group">
            <label class="filter-label">Module:</label>
            <select class="filter-select" [(ngModel)]="filterModule">
              <option value="all">All Modules</option>
              <option *ngFor="let m of modules" [value]="m">{{ m }}</option>
            </select>
          </div>

          <button class="btn btn-outline btn-sm reset-btn" *ngIf="hasActiveFilters()" (click)="resetFilters()">Reset Filters</button>
        </div>

        <div class="table-responsive" *ngIf="processedItems.length > 0; else emptyState">
          <table class="matrix-table">
            <thead>
              <tr>
                <th (click)="toggleSort('title')" class="sortable">
                  SCOPE / RELEASE UNIT <span class="sort-icon" *ngIf="sortColumn === 'title'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>MOJA</th>
                <th>TATU</th>
                <th>SITA</th>
                <th>PROD</th>
                <th (click)="toggleSort('next_action')" class="sortable">
                  NEXT ACTION <span class="sort-icon" *ngIf="sortColumn === 'next_action'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('verified')" class="sortable">
                  LAST VERIFIED <span class="sort-icon" *ngIf="sortColumn === 'verified'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let item of processedItems">
                <td>
                  <div class="item-title" [title]="item.description || item.title">{{ item.title }}</div>
                  <div class="item-sub" [title]="item.module?.description || item.module?.name">{{ item.module?.name }}</div>
                </td>
                <td *ngFor="let envCode of ['MOJA', 'TATU', 'SITA', 'PROD']">
                  <div class="state-cell" (click)="openPromotionModal(item, envCode)" title="Click to update {{ envCode }} status">
                    <div class="status-indicator">
                      <span class="status-dot" [style.background-color]="getEnvStateColor(item, envCode)"></span>
                      <span class="state-text" [style.color]="getEnvStateColor(item, envCode)">
                        {{ getEnvStateLabel(item, envCode) }}
                      </span>
                    </div>
                    <span class="state-conf" *ngIf="getEnvConfirmer(item, envCode)">
                      By: {{ getEnvConfirmer(item, envCode) }}
                    </span>
                  </div>
                </td>
                <td class="action-cell">
                  <div *ngIf="getActionPoints(item).length > 0; else noAction" class="action-points-list">
                    <div
                      *ngFor="let ap of getActionPoints(item)"
                      class="action-point-item clickable-action"
                      [class.is-blocker]="ap.isBlocker"
                      (click)="openEditActionModal(item, ap)"
                      title="Click to edit Action Item: {{ ap.text }}"
                    >
                      <span class="action-bullet" [class.blocker-bullet]="ap.isBlocker">•</span>
                      <span class="blocker-tag" *ngIf="ap.isBlocker">BLOCKER</span>
                      <span class="action-text action-link">{{ ap.text }}</span>
                      <span class="action-owner" *ngIf="ap.ownerName">({{ ap.ownerName }})</span>
                      <svg class="edit-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                    </div>
                  </div>
                  <ng-template #noAction>
                    <span class="no-action-text">N/A</span>
                  </ng-template>
                </td>
                <td class="verified-cell">{{ getLatestVerifiedDate(item) | date:'yyyy-MM-dd' }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <ng-template #emptyState>
          <div class="empty-state">
            <p>No release units match the filter criteria.</p>
          </div>
        </ng-template>
      </div>

      <!-- Promotion Modal Dialog -->
      <div class="modal-overlay" *ngIf="selectedItem">
        <div class="modal-content">
          <div class="modal-header">
            <h3>Update Environment Status: {{ selectedEnvCode }}</h3>
            <button class="close-btn" (click)="closeModal()">×</button>
          </div>
          <div class="modal-body">
            <p class="modal-item-title">{{ selectedItem.title }}</p>

            <div class="form-group">
              <label>Environment Status ({{ selectedEnvCode }})</label>
              <select class="form-control" [(ngModel)]="promotionForm.status_id">
                <option *ngFor="let s of envStateCatalogs" [value]="s.id">{{ s.label }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Source / Verification Reference</label>
              <input type="text" class="form-control" [(ngModel)]="promotionForm.source_summary" placeholder="e.g. Meeting with Ximena / QA Report">
            </div>

            <div class="form-group">
              <label>Confirmed By (Person)</label>
              <select class="form-control" [(ngModel)]="promotionForm.confirmed_by_person_id">
                <option [value]="null">Select Person</option>
                <option *ngFor="let p of people" [value]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
              </select>
            </div>

            <div class="form-group">
              <label>Notes / Context</label>
              <textarea class="form-control" [(ngModel)]="promotionForm.notes" rows="2"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeModal()">Cancel</button>
            <button class="btn btn-primary" (click)="savePromotion()">Save Status Change</button>
          </div>
        </div>
      </div>

      <!-- Action Item Quick Edit Modal -->
      <div class="modal-overlay" *ngIf="selectedActionPoint">
        <div class="modal-content">
          <div class="modal-header">
            <h3>Edit Action Point</h3>
            <button class="close-btn" (click)="closeActionModal()">×</button>
          </div>
          <div class="modal-body">
            <p class="modal-item-title">{{ selectedActionItemTitle }}</p>

            <div class="form-group">
              <label>Required Action *</label>
              <input type="text" class="form-control" [(ngModel)]="actionEditForm.action">
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Status</label>
                <select class="form-control" [(ngModel)]="actionEditForm.status_id">
                  <option *ngFor="let s of statusCatalogs" [value]="s.id">{{ s.label }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Priority</label>
                <select class="form-control" [(ngModel)]="actionEditForm.priority_id">
                  <option *ngFor="let p of priorityCatalogs" [value]="p.id">{{ p.label }}</option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Owner / Assigned Lead</label>
                <select class="form-control" [(ngModel)]="actionEditForm.owner_person_id">
                  <option [value]="null">Unassigned</option>
                  <option *ngFor="let p of people" [value]="p.id">{{ p.display_name }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Target Date</label>
                <input type="date" class="form-control" [(ngModel)]="actionEditForm.due_date" placeholder="yyyy-mm-dd">
              </div>
            </div>

            <div class="form-group">
              <label class="checkbox-label">
                <input type="checkbox" [(ngModel)]="actionEditForm.is_blocker">
                <span class="font-bold text-red">Mark as Release Blocker</span>
              </label>
            </div>

            <div class="form-group">
              <label>Outcome / Notes</label>
              <textarea class="form-control" [(ngModel)]="actionEditForm.notes" rows="2" placeholder="Summary of progress, outcome, or findings..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeActionModal()">Cancel</button>
            <button class="btn btn-primary" (click)="saveActionPoint()">Save Action Item</button>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .matrix-page { display: flex; flex-direction: column; gap: 1.5rem; }
    .header-banner { margin-bottom: 0.5rem; }
    .page-title { font-size: 1.75rem; font-weight: 700; color: #FFF; }
    .page-subtitle { color: var(--text-muted); font-size: 0.9rem; }

    /* Filter Toolbar */
    .filter-toolbar {
      display: flex; flex-wrap: wrap; align-items: center; gap: 1rem;
      padding-bottom: 1.25rem; margin-bottom: 1rem; border-bottom: 1px solid var(--bg-surface-border);
    }
    .filter-group { display: flex; align-items: center; gap: 0.4rem; }
    .search-box {
      position: relative; background: #0F172A; border: 1px solid var(--bg-surface-border);
      border-radius: var(--radius-md); padding: 0.35rem 0.65rem; display: flex; align-items: center; gap: 0.5rem; min-width: 240px;
    }
    .search-box svg { color: var(--text-muted); }
    .filter-input { background: none; border: none; outline: none; color: #FFF; font-size: 0.825rem; width: 100%; }
    .filter-label { font-size: 0.75rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; }
    .filter-select {
      background: #0F172A; border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md);
      color: #FFF; font-size: 0.8rem; padding: 0.35rem 0.6rem; outline: none;
    }
    .reset-btn { font-size: 0.75rem; padding: 0.3rem 0.6rem; }

    /* Column Header Sorting */
    .matrix-table { width: 100%; border-collapse: collapse; }
    .matrix-table th {
      padding: 0.85rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted);
      border-bottom: 1px solid var(--bg-surface-border); user-select: none;
    }
    .matrix-table th.sortable { cursor: pointer; transition: color 0.15s ease; }
    .matrix-table th.sortable:hover { color: #FFF; }
    .sort-icon { color: var(--accent-primary); font-weight: 700; margin-left: 0.25rem; font-size: 0.85rem; }

    .matrix-table td { padding: 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.04); font-size: 0.85rem; vertical-align: middle; }
    .item-title { font-weight: 600; color: #FFF; font-size: 0.9rem; }
    .item-sub { font-size: 0.75rem; color: var(--text-subtle); margin-top: 0.2rem; }

    .state-cell { background: rgba(15, 23, 42, 0.3); border-radius: 6px; padding: 0.45rem 0.6rem; cursor: pointer; transition: var(--transition-fast); border: 1px solid transparent; }
    .state-cell:hover { background: rgba(99, 102, 241, 0.1); border-color: rgba(99, 102, 241, 0.3); }
    .state-text { font-weight: 600; font-size: 0.82rem; }
    .state-conf { font-size: 0.7rem; color: var(--text-subtle); display: block; margin-top: 0.2rem; }

    .action-cell { min-width: 250px; max-width: 380px; vertical-align: top; padding: 0.6rem 0.85rem !important; }
    .action-points-list { display: flex; flex-direction: column; gap: 0.4rem; }
    .action-point-item { display: flex; align-items: flex-start; gap: 0.35rem; font-size: 0.82rem; line-height: 1.35; color: var(--text-main); }
    .action-point-item.is-blocker { color: #FCA5A5; font-weight: 600; background: rgba(239, 68, 68, 0.12); padding: 0.25rem 0.45rem; border-radius: 4px; border-left: 3px solid #EF4444; }
    .action-bullet { color: var(--accent-primary); font-weight: bold; font-size: 1.1rem; line-height: 1; flex-shrink: 0; margin-right: 0.1rem; }
    .blocker-bullet { color: #EF4444; }
    .blocker-tag { font-size: 0.65rem; font-weight: 800; background: #EF4444; color: #FFF; padding: 0.05rem 0.35rem; border-radius: 3px; letter-spacing: 0.03em; margin-right: 0.2rem; flex-shrink: 0; }
    .action-text { flex: 1; word-break: break-word; }
    .action-owner { font-size: 0.75rem; color: var(--text-muted); font-weight: 400; flex-shrink: 0; margin-left: 0.2rem; }
    .clickable-action { cursor: pointer; transition: var(--transition-fast); border-radius: 4px; padding: 0.15rem 0.35rem; }
    .clickable-action:hover { background: rgba(99, 102, 241, 0.18); }
    .clickable-action:hover .action-text { text-decoration: underline; color: #818CF8; }
    .clickable-action:hover .edit-icon { opacity: 1; transform: scale(1.1); }
    .edit-icon { opacity: 0.3; color: var(--text-muted); margin-left: auto; transition: var(--transition-fast); flex-shrink: 0; }
    .form-row { display: flex; gap: 1rem; }
    .form-row .col { flex: 1; }
    .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; user-select: none; }
    .text-red { color: #EF4444; }
    .no-action-text { color: var(--text-subtle); font-style: italic; font-size: 0.8rem; }
    .verified-cell { color: var(--text-subtle); font-size: 0.8rem; }
    .empty-state { text-align: center; padding: 2.5rem 1rem; color: var(--text-muted); font-style: italic; }

    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
    .modal-header h3 { font-size: 1.1rem; color: #FFF; }
    .close-btn { background: none; border: none; color: var(--text-muted); font-size: 1.5rem; cursor: pointer; }
    .modal-item-title { font-weight: 600; color: var(--accent-primary); margin-bottom: 1.25rem; }
    .modal-footer { display: flex; justify-content: flex-end; gap: 0.75rem; margin-top: 1.5rem; }
  `]
})
export class MatrixComponent implements OnInit {
  items: ReleaseItem[] = [];
  envStateCatalogs: CatalogValue[] = [];
  statusCatalogs: CatalogValue[] = [];
  priorityCatalogs: CatalogValue[] = [];
  people: Person[] = [];
  projEnvs: any[] = [];
  modules: string[] = [];

  // Filter & Sort state
  filterText: string = '';
  filterModule: string = 'all';
  sortColumn: string = 'title';
  sortDirection: 'asc' | 'desc' = 'asc';

  selectedItem: ReleaseItem | null = null;
  selectedEnvCode: string = '';
  promotionForm = {
    project_environment_id: 0,
    status_id: 0,
    source_summary: '',
    confirmed_by_person_id: null as number | null,
    notes: '',
  };

  // Action Point Edit Modal State
  selectedActionPoint: any = null;
  selectedActionItemTitle: string = '';
  selectedActionItemId: number = 0;
  actionEditForm = {
    action: '',
    status_id: 0,
    priority_id: 0,
    owner_person_id: null as number | null,
    due_date: '',
    is_blocker: false,
    notes: ''
  };

  constructor(
    private apiService: ApiService,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.apiService.getReleaseItems().subscribe(res => {
      this.items = res;
      this.modules = Array.from(new Set(res.map(i => i.module?.name).filter((n): n is string => !!n)));
    });

    this.apiService.getCatalogs().subscribe(res => {
      this.envStateCatalogs = res.catalogs['environment_state'] || [];
      this.statusCatalogs = res.catalogs['follow_up_status'] || [];
      this.priorityCatalogs = res.catalogs['follow_up_priority'] || [];
      this.people = res.people || [];
    });

    this.apiService.getProjects().subscribe(projects => {
      if (projects.length > 0) {
        this.projEnvs = projects[0].project_environments || [];
      }
    });
  }

  get processedItems(): ReleaseItem[] {
    let list = [...this.items];

    if (this.filterText.trim()) {
      const q = this.filterText.toLowerCase();
      list = list.filter(i => i.title.toLowerCase().includes(q) || (i.next_action && i.next_action.toLowerCase().includes(q)));
    }

    if (this.filterModule !== 'all') {
      list = list.filter(i => i.module?.name === this.filterModule);
    }

    list.sort((a, b) => {
      let valA: any = '';
      let valB: any = '';

      switch (this.sortColumn) {
        case 'title':
          valA = a.title || '';
          valB = b.title || '';
          break;
        case 'next_action':
          valA = a.next_action || '';
          valB = b.next_action || '';
          break;
        case 'verified':
          valA = this.getLatestVerifiedDate(a);
          valB = this.getLatestVerifiedDate(b);
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
    return !!this.filterText || this.filterModule !== 'all';
  }

  resetFilters(): void {
    this.filterText = '';
    this.filterModule = 'all';
  }

  getEnvState(item: ReleaseItem, envCode: string) {
    return item.environment_states?.find((s: any) => s.project_environment?.environment?.code === envCode);
  }

  getEnvStateLabel(item: ReleaseItem, envCode: string): string {
    const s = this.getEnvState(item, envCode);
    return s?.status?.label || 'X - Not reached';
  }

  getEnvStateColor(item: ReleaseItem, envCode: string): string {
    const s = this.getEnvState(item, envCode);
    return s?.status?.color || '#9CA3AF';
  }

  getEnvConfirmer(item: ReleaseItem, envCode: string): string {
    const s = this.getEnvState(item, envCode);
    return s?.confirmed_by_person?.display_name || s?.confirmed_by_text || '';
  }

  getLatestVerifiedDate(item: ReleaseItem): string {
    const dates = item.environment_states?.map((s: any) => s.verified_at).filter(Boolean) || [];
    return dates.length > 0 ? dates[0] : '';
  }

  getActionPoints(item: ReleaseItem): { id?: number; text: string; isBlocker: boolean; ownerName?: string; rawFollowUp?: any }[] {
    const results: { id?: number; text: string; isBlocker: boolean; ownerName?: string; rawFollowUp?: any }[] = [];

    if (item.follow_ups && item.follow_ups.length > 0) {
      // Sort follow-ups so blockers appear first
      const sorted = [...item.follow_ups].sort((a: any, b: any) => {
        if (a.is_blocker && !b.is_blocker) return -1;
        if (!a.is_blocker && b.is_blocker) return 1;
        return 0;
      });

      for (const fu of sorted) {
        if (fu.action) {
          results.push({
            id: fu.id,
            text: fu.action,
            isBlocker: !!fu.is_blocker,
            ownerName: fu.owner?.display_name,
            rawFollowUp: fu
          });
        }
      }
    }

    if (item.next_action && !results.some(r => r.text === item.next_action)) {
      results.push({
        text: item.next_action,
        isBlocker: false
      });
    }

    return results;
  }

  openEditActionModal(item: ReleaseItem, ap: any): void {
    this.selectedActionPoint = ap;
    this.selectedActionItemTitle = item.title;
    this.selectedActionItemId = item.id;

    if (ap.rawFollowUp) {
      const fu = ap.rawFollowUp;
      this.actionEditForm = {
        action: fu.action,
        status_id: fu.status_id,
        priority_id: fu.priority_id,
        owner_person_id: fu.owner_person_id || null,
        due_date: fu.due_date || '',
        is_blocker: !!fu.is_blocker,
        notes: fu.notes || ''
      };
    } else {
      this.actionEditForm = {
        action: ap.text,
        status_id: this.statusCatalogs[0]?.id || 0,
        priority_id: this.priorityCatalogs[0]?.id || 0,
        owner_person_id: item.owner_person_id || null,
        due_date: new Date().toISOString().split('T')[0],
        is_blocker: false,
        notes: ''
      };
    }
  }

  closeActionModal(): void {
    this.selectedActionPoint = null;
  }

  saveActionPoint(): void {
    if (!this.selectedActionPoint) return;

    if (this.selectedActionPoint.rawFollowUp) {
      const id = this.selectedActionPoint.rawFollowUp.id;
      this.apiService.updateFollowUp(id, this.actionEditForm).subscribe(() => {
        this.closeActionModal();
        this.toastService.success('Action Item updated successfully!');
        this.loadData();
      });
    } else {
      const payload = {
        release_item_id: this.selectedActionItemId,
        ...this.actionEditForm
      };
      this.apiService.createFollowUp(payload).subscribe(() => {
        this.closeActionModal();
        this.toastService.success('Action Point created successfully!');
        this.loadData();
      });
    }
  }

  openPromotionModal(item: ReleaseItem, envCode: string): void {
    this.selectedItem = item;
    this.selectedEnvCode = envCode;

    const penv = this.projEnvs.find((p: any) => p.environment?.code === envCode);
    const existing = this.getEnvState(item, envCode);

    this.promotionForm = {
      project_environment_id: penv ? penv.id : 0,
      status_id: existing?.status_id || (this.envStateCatalogs[0]?.id || 0),
      source_summary: existing?.source_summary || 'Verified in meeting',
      confirmed_by_person_id: existing?.confirmed_by_person_id || null,
      notes: existing?.notes || '',
    };
  }

  closeModal(): void {
    this.selectedItem = null;
  }

  savePromotion(): void {
    if (!this.selectedItem) return;

    this.apiService.updateEnvironmentState(this.selectedItem.id, this.promotionForm).subscribe(() => {
      const code = this.selectedEnvCode;
      this.closeModal();
      this.toastService.success(`Environment ${code} status updated successfully!`);
      this.loadData();
    });
  }
}
