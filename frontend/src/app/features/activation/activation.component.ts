import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService, ReleaseItem, CatalogValue, Person, Project, Module } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';

@Component({
  selector: 'app-activation',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="activation-page">
      <div class="header-banner">
        <div>
          <h1 class="page-title">Client Activation Tracker</h1>
          <p class="page-subtitle">Track client-facing feature enablement for release units deployed to Production.</p>
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
            <label class="filter-label">PROJECT:</label>
            <select class="filter-select" [(ngModel)]="filterProject" (change)="onProjectChange()">
              <option value="all">All Projects</option>
              <option *ngFor="let p of projectsList" [value]="p.name">{{ p.name }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">MODULE:</label>
            <select class="filter-select" [(ngModel)]="filterModule">
              <option value="all">All Modules</option>
              <option *ngFor="let m of filteredModules" [value]="m.name">{{ m.name }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">ACTIVATION STATUS:</label>
            <select class="filter-select" [(ngModel)]="filterStatus">
              <option value="all">All Statuses</option>
              <option *ngFor="let s of activationCatalogs" [value]="s.code">{{ s.label }}</option>
            </select>
          </div>

          <button class="btn btn-outline btn-sm reset-btn" *ngIf="hasActiveFilters()" (click)="resetFilters()">Reset Filters</button>
        </div>

        <div class="table-responsive" *ngIf="processedItems.length > 0; else emptyState">
          <table class="data-table">
            <thead>
              <tr>
                <th (click)="toggleSort('title')" class="sortable">
                  RELEASE UNIT <span class="sort-icon" *ngIf="sortColumn === 'title'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>PROD DEPLOYMENT</th>
                <th (click)="toggleSort('status')" class="sortable">
                  CLIENT ACTIVATION STATUS <span class="sort-icon" *ngIf="sortColumn === 'status'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('scope_type')" class="sortable">
                  SCOPE TYPE <span class="sort-icon" *ngIf="sortColumn === 'scope_type'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>SCOPE DETAILS</th>
                <th (click)="toggleSort('confirmed_by')" class="sortable">
                  CONFIRMED BY <span class="sort-icon" *ngIf="sortColumn === 'confirmed_by'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>ACTION</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let item of processedItems">
                <td>
                  <div class="item-title">{{ item.title }}</div>
                  <div class="item-sub">{{ item.module?.name }} • {{ item.release?.name || item.release?.code }}</div>
                </td>
                <td>
                  <span class="status-badge" [style.color]="getProdStateColor(item)">
                    {{ getProdStateLabel(item) }}
                  </span>
                </td>
                <td>
                  <span class="status-badge" [style.color]="item.client_activation?.status?.color || '#9CA3AF'">
                    {{ item.client_activation?.status?.label || 'Not Set' }}
                  </span>
                </td>
                <td>
                  <span class="capitalize">{{ item.client_activation?.scope_type || '—' }}</span>
                </td>
                <td>{{ item.client_activation?.scope_description || '—' }}</td>
                <td>{{ item.client_activation?.confirmed_by_person?.display_name || item.client_activation?.confirmed_by_text || '—' }}</td>
                <td>
                  <button class="btn btn-action" (click)="openActivationModal(item)">
                    Update Activation
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <ng-template #emptyState>
          <div class="empty-state">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <div class="empty-title">No Activation Records Found</div>
            <div class="empty-sub">There are no release units matching your filter criteria or deployed to Production.</div>
          </div>
        </ng-template>
      </div>

      <!-- Update Activation Modal -->
      <div class="modal-overlay" *ngIf="selectedItem">
        <div class="modal-content">
          <div class="modal-header">
            <h3>Update Client Activation: {{ selectedItem.title }}</h3>
            <button class="close-btn" (click)="closeModal()">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Activation Status <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="activationForm.status_id">
                <option *ngFor="let s of activationCatalogs" [ngValue]="s.id">{{ s.label }} — {{ s.description }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Enablement Scope Type <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="activationForm.scope_type">
                <option value="global">Global (Enabled for all clients)</option>
                <option value="selective">Selective (Enabled for specific clients)</option>
                <option value="off">Off (Disabled globally)</option>
                <option value="not_applicable">Not Applicable</option>
                <option value="unknown">Unconfirmed</option>
              </select>
            </div>

            <div class="form-group">
              <label>Scope Details / Target Companies</label>
              <input type="text" class="form-control" [(ngModel)]="activationForm.scope_description" placeholder="e.g. Enabled for Enterprise Plan clients only">
            </div>

            <div class="form-group">
              <label>Source of Confirmation</label>
              <input type="text" class="form-control" [(ngModel)]="activationForm.source_summary" placeholder="e.g. Email confirmation from Ameet">
            </div>

            <div class="form-group">
              <label>Confirmed By (Person) <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="activationForm.confirmed_by_person_id">
                <option [ngValue]="null">Select Person</option>
                <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
              </select>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeModal()">Cancel</button>
            <button class="btn btn-primary" (click)="saveActivation()">Save Activation</button>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .activation-page { display: flex; flex-direction: column; gap: 1.5rem; }
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
    .data-table { width: 100%; border-collapse: collapse; }
    .data-table th {
      padding: 0.85rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted);
      border-bottom: 1px solid var(--bg-surface-border); user-select: none;
    }
    .data-table th.sortable { cursor: pointer; transition: color 0.15s ease; }
    .data-table th.sortable:hover { color: #FFF; }
    .sort-icon { color: var(--accent-primary); font-weight: 700; margin-left: 0.25rem; font-size: 0.85rem; }

    .data-table td { padding: 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.04); font-size: 0.85rem; vertical-align: middle; }
    .item-title { font-weight: 600; color: #FFF; }
    .item-sub { font-size: 0.75rem; color: var(--text-subtle); margin-top: 0.2rem; }

    .capitalize { text-transform: capitalize; font-weight: 500; }

    .empty-state { text-align: center; padding: 3rem 1.5rem; color: var(--text-muted); }
    .empty-title { font-size: 1.1rem; font-weight: 600; color: #FFF; margin-top: 0.75rem; }
    .empty-sub { font-size: 0.85rem; color: var(--text-muted); margin-top: 0.35rem; }
    .required-star { color: #EF4444; font-weight: bold; margin-left: 0.15rem; }

    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
    .modal-header h3 { font-size: 1.1rem; color: #FFF; }
    .close-btn { background: none; border: none; color: var(--text-muted); font-size: 1.5rem; cursor: pointer; }
    .modal-footer { display: flex; justify-content: flex-end; gap: 0.75rem; margin-top: 1.5rem; }
  `]
})
export class ActivationComponent implements OnInit {
  items: ReleaseItem[] = [];
  activationCatalogs: CatalogValue[] = [];
  people: Person[] = [];
  projectsList: Project[] = [];
  modulesList: Module[] = [];

  // Filter & Sorting state
  filterText: string = '';
  filterProject: string = 'all';
  filterModule: string = 'all';
  filterStatus: string = 'all';
  sortColumn: string = 'title';
  sortDirection: 'asc' | 'desc' = 'asc';

  selectedItem: ReleaseItem | null = null;
  activationForm = {
    status_id: 0,
    scope_type: 'unknown',
    scope_description: '',
    source_summary: '',
    confirmed_by_person_id: null as number | null,
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
      this.items = res.filter(item => {
        const prodState = item.environment_states?.find((st: any) => st.project_environment?.environment?.code === 'PROD');
        const code = prodState?.status?.code;
        return code === 'deployed' || code === 'approved';
      });
    });

    this.apiService.getCatalogs().subscribe(res => {
      this.activationCatalogs = res.catalogs['activation_status'] || [];
      this.people = res.people || [];
    });

    this.apiService.getProjects().subscribe(projects => {
      this.projectsList = projects;
    });

    this.apiService.getModules().subscribe(modules => {
      this.modulesList = modules;
    });
  }

  get filteredModules(): Module[] {
    if (this.filterProject === 'all') {
      return this.modulesList;
    }
    const matchedProj = this.projectsList.find(p => p.name === this.filterProject);
    if (!matchedProj) return this.modulesList;
    return this.modulesList.filter(m => m.project_id === matchedProj.id);
  }

  onProjectChange(): void {
    const availNames = this.filteredModules.map(m => m.name);
    if (this.filterModule !== 'all' && !availNames.includes(this.filterModule)) {
      this.filterModule = 'all';
    }
  }

  get processedItems(): ReleaseItem[] {
    let list = [...this.items];

    if (this.filterText.trim()) {
      const q = this.filterText.toLowerCase();
      list = list.filter(i => i.title.toLowerCase().includes(q) || (i.client_activation?.scope_description && i.client_activation.scope_description.toLowerCase().includes(q)));
    }

    if (this.filterProject !== 'all') {
      list = list.filter(i => i.project?.name === this.filterProject || i.module?.project?.name === this.filterProject);
    }

    if (this.filterModule !== 'all') {
      list = list.filter(i => i.module?.name === this.filterModule);
    }

    if (this.filterStatus !== 'all') {
      list = list.filter(i => i.client_activation?.status?.code === this.filterStatus);
    }

    list.sort((a, b) => {
      let valA: any = '';
      let valB: any = '';

      switch (this.sortColumn) {
        case 'title':
          valA = a.title || '';
          valB = b.title || '';
          break;
        case 'status':
          valA = a.client_activation?.status?.sort_order || 99;
          valB = b.client_activation?.status?.sort_order || 99;
          break;
        case 'scope_type':
          valA = a.client_activation?.scope_type || '';
          valB = b.client_activation?.scope_type || '';
          break;
        case 'confirmed_by':
          valA = a.client_activation?.confirmed_by_person?.display_name || a.client_activation?.confirmed_by_text || '';
          valB = b.client_activation?.confirmed_by_person?.display_name || b.client_activation?.confirmed_by_text || '';
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
    return !!this.filterText || this.filterProject !== 'all' || this.filterModule !== 'all' || this.filterStatus !== 'all';
  }

  resetFilters(): void {
    this.filterText = '';
    this.filterProject = 'all';
    this.filterModule = 'all';
    this.filterStatus = 'all';
  }

  getProdStateLabel(item: ReleaseItem): string {
    const s = item.environment_states?.find((st: any) => st.project_environment?.environment?.code === 'PROD');
    return s?.status?.label || 'X - Not reached';
  }

  getProdStateColor(item: ReleaseItem): string {
    const s = item.environment_states?.find((st: any) => st.project_environment?.environment?.code === 'PROD');
    return s?.status?.color || '#4B5563';
  }

  openActivationModal(item: ReleaseItem): void {
    this.selectedItem = item;
    const act = item.client_activation;

    this.activationForm = {
      status_id: act?.status_id ? Number(act.status_id) : (this.activationCatalogs[0]?.id || 0),
      scope_type: act?.scope_type || 'unconfirmed',
      scope_description: act?.scope_description || '',
      source_summary: act?.source_summary || 'Verification meeting',
      confirmed_by_person_id: act?.confirmed_by_person_id ? Number(act.confirmed_by_person_id) : null,
    };
  }

  closeModal(): void {
    this.selectedItem = null;
  }

  saveActivation(): void {
    if (!this.selectedItem) return;

    this.apiService.updateClientActivation(this.selectedItem.id, this.activationForm).subscribe(() => {
      this.closeModal();
      this.toastService.success('Client activation status updated successfully!');
      this.loadData();
    });
  }
}
