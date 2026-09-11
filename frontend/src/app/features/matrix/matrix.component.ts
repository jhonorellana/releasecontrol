import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService, ReleaseItem, CatalogValue, Person, Project } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';
import { FilterStateService } from '../../core/services/filter-state.service';

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
            <input type="text" class="filter-input" placeholder="Search by release unit name..." [(ngModel)]="filterText" (ngModelChange)="onFilterTextChange()">
          </div>

          <div class="filter-group">
            <label class="filter-label">Project:</label>
            <select class="filter-select" [(ngModel)]="filterProject" (change)="onProjectFilterChange()">
              <option value="all">All Projects</option>
              <option *ngFor="let p of projectsList" [value]="p.name">{{ p.name }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">Module:</label>
            <select class="filter-select" [(ngModel)]="filterModule" (change)="onModuleFilterChange()">
              <option value="all">All Modules</option>
              <option *ngFor="let m of filteredModules" [value]="m">{{ m }}</option>
            </select>
          </div>

          <div class="filter-group">
            <label class="filter-label">Action Items:</label>
            <select class="filter-select" [(ngModel)]="filterActionStatus" (change)="onActionStatusFilterChange()">
              <option value="all">All Units (Both)</option>
              <option value="with_actions">With Active Actions</option>
              <option value="without_actions">Without Active Actions</option>
            </select>
          </div>

          <button class="btn btn-outline btn-sm reset-btn" *ngIf="hasActiveFilters()" (click)="resetFilters()">Reset Filters</button>
        </div>

        <div class="table-responsive" *ngIf="processedItems.length > 0; else emptyState">
          <table class="matrix-table">
            <thead>
              <tr>
                <th (click)="toggleSort('id')" class="sortable">
                  ID <span class="sort-icon" *ngIf="sortColumn === 'id'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('title')" class="sortable">
                  SCOPE / RELEASE UNIT <span class="sort-icon" *ngIf="sortColumn === 'title'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th>MOJA</th>
                <th>TATU</th>
                <th>SITA</th>
                <th>PROD</th>
                <th>NEXT ACTION</th>
                <th (click)="toggleSort('owner')" class="sortable th-owner" style="width: 105px; text-align: center;">
                  OWNER <span class="sort-icon" *ngIf="sortColumn === 'owner'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('age')" class="sortable th-age" style="width: 85px; text-align: center;">
                  AGE <span class="sort-icon" *ngIf="sortColumn === 'age'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
                <th (click)="toggleSort('verified')" class="sortable">
                  LAST VERIFIED <span class="sort-icon" *ngIf="sortColumn === 'verified'">{{ sortDirection === 'asc' ? '↑' : '↓' }}</span>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let item of processedItems">
                <td><span class="action-id">#{{ item.id }}</span></td>
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
                <td class="action-group-cell" colspan="3">
                  <div class="action-points-container">
                    <div *ngIf="getActionPoints(item).length > 0" class="action-rows-list">
                      <div *ngFor="let ap of getActionPoints(item)" class="action-row-grid">
                        <div
                          class="action-point-item clickable-action"
                          [class.is-blocker]="ap.isBlocker"
                          (click)="openEditActionModal(item, ap)"
                          title="Click to edit Action Item: {{ ap.text }}"
                        >
                          <span class="action-bullet" [style.color]="ap.priorityColor">•</span>
                          <span class="blocker-tag" *ngIf="ap.isBlocker">BLOCKER</span>
                          <span class="action-text action-link" [style.color]="ap.isBlocker ? '#FCA5A5' : ap.priorityColor">{{ ap.text }}</span>
                          <svg class="edit-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                        </div>
                        <div class="action-owner-col">
                          <span class="action-owner" *ngIf="ap.ownerName">({{ ap.ownerName }})</span>
                        </div>
                        <div class="action-age-col">
                          <span class="action-age-badge" *ngIf="ap.ageText" [class.age-stale]="(ap.ageDays || 0) > 7" title="Age: {{ ap.ageText }}">🕒 {{ ap.ageText }}</span>
                        </div>
                      </div>
                    </div>

                    <button class="btn-add-action" (click)="openNewActionModal(item)" title="Add new action point for {{ item.title }}">
                      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                      <span>Add Action</span>
                    </button>
                  </div>
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
              <label>Environment Status ({{ selectedEnvCode }}) <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="promotionForm.status_id">
                <option *ngFor="let s of envStateCatalogs" [ngValue]="s.id">{{ s.label }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Source / Verification Reference</label>
              <input type="text" class="form-control" [(ngModel)]="promotionForm.source_summary" placeholder="e.g. Meeting with Ximena / QA Report">
            </div>

            <div class="form-group">
              <label>Confirmed By (Person) <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="promotionForm.confirmed_by_person_id">
                <option [ngValue]="null">Select Person</option>
                <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
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
            <h3>{{ (selectedActionPoint && selectedActionPoint.isNew) ? 'New Action Point' : 'Edit Action Point' }}</h3>
            <button class="close-btn" (click)="closeActionModal()">×</button>
          </div>
          <div class="modal-body">
            <p class="modal-item-title">{{ selectedActionItemTitle }}</p>

            <div class="form-group">
              <label>Required Action <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="actionEditForm.action">
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Status <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="actionEditForm.status_id">
                  <option *ngFor="let s of statusCatalogs" [ngValue]="s.id">{{ s.label }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Priority <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="actionEditForm.priority_id">
                  <option *ngFor="let p of priorityCatalogs" [ngValue]="p.id">{{ p.label }}</option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Owner / Assigned Lead <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="actionEditForm.owner_person_id">
                  <option [ngValue]="null">Unassigned</option>
                  <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }}</option>
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

    /* Column Header Sorting & Row Demarcation */
    .matrix-table { width: 100%; border-collapse: collapse; }
    .matrix-table th {
      padding: 0.9rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted);
      border-bottom: 2px solid rgba(255, 255, 255, 0.12); user-select: none; background: rgba(15, 23, 42, 0.4);
    }
    .matrix-table th.sortable { cursor: pointer; transition: color 0.15s ease; }
    .matrix-table th.sortable:hover { color: #FFF; }
    .sort-icon { color: var(--accent-primary); font-weight: 700; margin-left: 0.25rem; font-size: 0.85rem; }

    .matrix-table tbody tr {
      transition: background-color 0.15s ease-in-out;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .matrix-table tbody tr:nth-child(even) {
      background-color: rgba(255, 255, 255, 0.025);
    }
    .matrix-table tbody tr:hover {
      background-color: rgba(99, 102, 241, 0.08) !important;
    }
    .matrix-table td { padding: 1.1rem 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.1); font-size: 0.85rem; vertical-align: middle; }
    .item-id-cell { font-family: monospace; font-weight: 700; color: var(--accent-primary); font-size: 0.85rem; }
    .item-title { font-weight: 600; color: #FFF; font-size: 0.9rem; }
    .item-sub { font-size: 0.75rem; color: var(--text-subtle); margin-top: 0.2rem; }

    .state-cell { background: rgba(15, 23, 42, 0.3); border-radius: 6px; padding: 0.45rem 0.6rem; cursor: pointer; transition: var(--transition-fast); border: 1px solid transparent; }
    .state-cell:hover { background: rgba(99, 102, 241, 0.1); border-color: rgba(99, 102, 241, 0.3); }
    .state-text { font-weight: 600; font-size: 0.82rem; }
    .state-conf { font-size: 0.7rem; color: var(--text-subtle); display: block; margin-top: 0.2rem; }

    .action-cell { min-width: 260px; max-width: 380px; vertical-align: top; padding: 0.6rem 0.85rem !important; }
    .action-points-container { display: flex; flex-direction: column; gap: 0.45rem; align-items: flex-start; }
    .action-points-list { display: flex; flex-direction: column; gap: 0.4rem; width: 100%; }
    .btn-add-action {
      display: inline-flex;
      align-items: center;
      gap: 0.35rem;
      padding: 0.2rem 0.55rem;
      border-radius: var(--radius-sm);
      background: rgba(99, 102, 241, 0.12);
      border: 1px dashed rgba(129, 140, 248, 0.35);
      color: #A5B4FC;
      font-size: 0.725rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.15s ease;
      margin-top: 0.15rem;
    }
    .btn-add-action:hover {
      background: rgba(99, 102, 241, 0.28);
      border-color: rgba(129, 140, 248, 0.6);
      color: #FFF;
      transform: translateY(-1px);
    }
    .action-group-cell { padding: 0.85rem 0.65rem; vertical-align: top; }
    .action-rows-list { display: flex; flex-direction: column; gap: 0.45rem; width: 100%; }
    .action-row-grid {
      display: grid;
      grid-template-columns: 1fr 105px 85px;
      align-items: center;
      gap: 0.5rem;
      padding: 0.25rem 0;
      border-bottom: 1px dashed rgba(255, 255, 255, 0.06);
    }
    .action-row-grid:last-child { border-bottom: none; }
    .action-point-item { display: flex; align-items: flex-start; gap: 0.35rem; font-size: 0.82rem; line-height: 1.35; color: var(--text-main); }
    .action-point-item.is-blocker { color: #FCA5A5; font-weight: 600; background: rgba(239, 68, 68, 0.12); padding: 0.25rem 0.45rem; border-radius: 4px; border-left: 3px solid #EF4444; }
    .action-bullet { color: var(--accent-primary); font-weight: bold; font-size: 1.1rem; line-height: 1; flex-shrink: 0; margin-right: 0.1rem; }
    .blocker-bullet { color: #EF4444; }
    .blocker-tag { font-size: 0.65rem; font-weight: 800; background: #EF4444; color: #FFF; padding: 0.05rem 0.35rem; border-radius: 3px; letter-spacing: 0.03em; margin-right: 0.2rem; flex-shrink: 0; }
    .action-owner-col { display: flex; align-items: center; justify-content: center; white-space: nowrap; }
    .action-age-col { display: flex; align-items: center; justify-content: center; white-space: nowrap; }
    .action-text { flex: 1; word-break: break-word; }
    .action-owner { font-size: 0.78rem; color: #94A3B8; font-weight: 500; }
    .action-age-badge { font-size: 0.75rem; color: #94A3B8; background: rgba(15, 23, 42, 0.6); padding: 0.15rem 0.45rem; border-radius: 4px; font-weight: 600; border: 1px solid rgba(255, 255, 255, 0.08); display: inline-flex; align-items: center; gap: 0.25rem; }
    .action-age-badge.age-stale { color: #F59E0B; background: rgba(245, 158, 11, 0.1); border-color: rgba(245, 158, 11, 0.3); }
    .clickable-action { cursor: pointer; transition: var(--transition-fast); border-radius: 4px; padding: 0.15rem 0.35rem; }
    .clickable-action:hover { background: rgba(99, 102, 241, 0.18); }
    .clickable-action:hover .action-text { text-decoration: underline; color: #818CF8; }
    .clickable-action:hover .edit-icon { opacity: 1; transform: scale(1.1); }
    .edit-icon { opacity: 0.3; color: var(--text-muted); margin-left: auto; transition: var(--transition-fast); flex-shrink: 0; }
    .form-row { display: flex; gap: 1rem; }
    .form-row .col { flex: 1; }
    .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; user-select: none; }
    .text-red { color: #EF4444; }
    .required-star { color: #EF4444; font-weight: bold; margin-left: 0.15rem; }
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
  projectsList: Project[] = [];
  projEnvs: any[] = [];
  modules: string[] = [];

  // Filter & Sort state
  filterText: string = '';
  filterProject: string = 'all';
  filterModule: string = 'all';
  filterActionStatus: string = 'all';
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
    private toastService: ToastService,
    private filterStateService: FilterStateService
  ) {}

  ngOnInit(): void {
    this.restoreFilterState();
    this.loadData();
  }

  restoreFilterState(): void {
    const saved = this.filterStateService.getMatrixState();
    this.filterText = saved.filterText || '';
    this.filterProject = saved.filterProject || 'all';
    this.filterModule = saved.filterModule || 'all';
    this.filterActionStatus = saved.filterActionStatus || 'all';
    this.sortColumn = saved.sortColumn || 'title';
    this.sortDirection = saved.sortDirection || 'asc';
  }

  saveFilterState(): void {
    this.filterStateService.saveMatrixState({
      filterText: this.filterText,
      filterProject: this.filterProject,
      filterModule: this.filterModule,
      filterActionStatus: this.filterActionStatus,
      sortColumn: this.sortColumn,
      sortDirection: this.sortDirection
    });
  }

  onFilterTextChange(): void {
    this.saveFilterState();
  }

  onProjectFilterChange(): void {
    if (this.filterModule !== 'all' && !this.filteredModules.includes(this.filterModule)) {
      this.filterModule = 'all';
    }
    this.saveFilterState();
  }

  onModuleFilterChange(): void {
    this.saveFilterState();
  }

  onActionStatusFilterChange(): void {
    this.saveFilterState();
  }

  toggleSort(column: string): void {
    if (this.sortColumn === column) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortColumn = column;
      this.sortDirection = 'asc';
    }
    this.saveFilterState();
  }

  hasActiveFilters(): boolean {
    return !!this.filterText || this.filterProject !== 'all' || this.filterModule !== 'all' || this.filterActionStatus !== 'all';
  }

  resetFilters(): void {
    const defaultState = this.filterStateService.resetMatrixState();
    this.filterText = defaultState.filterText;
    this.filterProject = defaultState.filterProject;
    this.filterModule = defaultState.filterModule;
    this.filterActionStatus = defaultState.filterActionStatus || 'all';
    this.sortColumn = defaultState.sortColumn;
    this.sortDirection = defaultState.sortDirection;
  }

  loadData(): void {
    this.apiService.getReleaseItems().subscribe(res => {
      this.items = res;
      this.modules = Array.from(new Set(res.map(i => i.module?.name).filter((n): n is string => !!n)));
    });

    this.apiService.getCatalogs().subscribe(res => {
      this.envStateCatalogs = res.catalogs['environment_state'] || [];
      this.statusCatalogs = res.catalogs['follow_up_status'] || [];
      this.priorityCatalogs = res.catalogs['priority'] || res.catalogs['follow_up_priority'] || [];
      this.people = res.people || [];
    });

    this.apiService.getProjects().subscribe(projects => {
      this.projectsList = projects;
      if (projects.length > 0) {
        this.projEnvs = projects[0].project_environments || [];
      }
    });
  }

  get filteredModules(): string[] {
    if (this.filterProject === 'all') {
      return this.modules;
    }
    const matchedProj = this.projectsList.find(p => p.name === this.filterProject);
    if (!matchedProj || !matchedProj.modules) {
      return this.modules;
    }
    const projModuleNames = matchedProj.modules.map(m => m.name);
    return this.modules.filter(m => projModuleNames.includes(m));
  }

  get processedItems(): ReleaseItem[] {
    let list = [...this.items];

    if (this.filterText.trim()) {
      const q = this.filterText.toLowerCase();
      list = list.filter(i =>
        i.title.toLowerCase().includes(q) ||
        (i.module?.name && i.module.name.toLowerCase().includes(q)) ||
        (i.follow_ups && i.follow_ups.some(f => f.action && f.action.toLowerCase().includes(q)))
      );
    }

    if (this.filterProject !== 'all') {
      list = list.filter(i => i.project?.name === this.filterProject);
    }

    if (this.filterModule !== 'all') {
      list = list.filter(i => i.module?.name === this.filterModule);
    }

    if (this.filterActionStatus === 'with_actions') {
      list = list.filter(i => this.getActionPoints(i).length > 0);
    } else if (this.filterActionStatus === 'without_actions') {
      list = list.filter(i => this.getActionPoints(i).length === 0);
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
          valA = a.title || '';
          valB = b.title || '';
          break;
        case 'next_action':
          valA = this.getActionPoints(a)[0]?.text || '';
          valB = this.getActionPoints(b)[0]?.text || '';
          break;
        case 'owner':
          valA = this.getActionPoints(a)[0]?.ownerName || '';
          valB = this.getActionPoints(b)[0]?.ownerName || '';
          break;
        case 'age':
          valA = this.getActionPoints(a)[0]?.ageDays ?? -1;
          valB = this.getActionPoints(b)[0]?.ageDays ?? -1;
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

  getEnvState(item: ReleaseItem, envCode: string) {
    const projId = item.project?.id || item.module?.project_id;
    return item.environment_states?.find((s: any) =>
      s.project_environment?.environment?.code === envCode &&
      (!projId || s.project_environment?.project_id === projId)
    );
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
    const dates: string[] = [];

    // 1. Gather update/creation dates from related action points (follow_ups)
    if (item.follow_ups && item.follow_ups.length > 0) {
      for (const fu of item.follow_ups) {
        if (fu.updated_at) dates.push(fu.updated_at);
        else if (fu.created_at) dates.push(fu.created_at);
      }
    }

    // 2. Fallback to environment states verified_at if no follow-ups exist
    if (dates.length === 0 && item.environment_states) {
      for (const s of item.environment_states) {
        if (s.verified_at) dates.push(s.verified_at);
      }
    }

    // 3. Fallback to item updated_at / created_at
    if (dates.length === 0) {
      if (item.updated_at) dates.push(item.updated_at);
      else if (item.created_at) dates.push(item.created_at);
    }

    if (dates.length === 0) return '';

    // Sort descending to find the latest date
    dates.sort((a, b) => new Date(b).getTime() - new Date(a).getTime());
    return dates[0];
  }

  isClosedStatus(fu: any): boolean {
    if (!fu) return false;
    const code = (fu.status?.code || '').toLowerCase();
    const label = (fu.status?.label || '').toLowerCase();

    if (code === 'completed' || code === 'cancelled' || code === 'canceled' ||
        label.includes('completed') || label.includes('cancelled') || label.includes('completad') || label.includes('cancelad')) {
      return true;
    }

    if (fu.status_id && this.statusCatalogs.length > 0) {
      const cat = this.statusCatalogs.find(s => s.id === fu.status_id);
      if (cat) {
        const cCode = (cat.code || '').toLowerCase();
        const cLabel = (cat.label || '').toLowerCase();
        if (cCode === 'completed' || cCode === 'cancelled' || cCode === 'canceled' ||
            cLabel.includes('completed') || cLabel.includes('cancelled') || cLabel.includes('completad') || cLabel.includes('cancelad')) {
          return true;
        }
      }
    }
    return false;
  }

  getItemAgeDays(createdAt?: string): number {
    if (!createdAt) return 0;
    const created = new Date(createdAt);
    const now = new Date();
    const diffTime = Math.abs(now.getTime() - created.getTime());
    return Math.floor(diffTime / (1000 * 60 * 60 * 24));
  }

  getItemAgeLabel(createdAt?: string): string {
    const days = this.getItemAgeDays(createdAt);
    if (days === 0) return 'Today';
    if (days === 1) return '1d';
    return `${days}d`;
  }

  getActionPoints(item: ReleaseItem): { id?: number; text: string; isBlocker: boolean; priorityColor: string; priorityLabel?: string; ownerName?: string; ageText?: string; ageDays?: number; rawFollowUp?: any }[] {
    const results: { id?: number; text: string; isBlocker: boolean; priorityColor: string; priorityLabel?: string; ownerName?: string; ageText?: string; ageDays?: number; rawFollowUp?: any }[] = [];

    if (item.follow_ups && item.follow_ups.length > 0) {
      // Sort follow-ups so blockers appear first, then by priority
      const sorted = [...item.follow_ups].sort((a: any, b: any) => {
        if (a.is_blocker && !b.is_blocker) return -1;
        if (!a.is_blocker && b.is_blocker) return 1;
        const orderA = a.priority?.sort_order ?? 99;
        const orderB = b.priority?.sort_order ?? 99;
        return orderA - orderB;
      });

      for (const fu of sorted) {
        if (this.isClosedStatus(fu)) {
          continue;
        }
        if (fu.action) {
          let pColor = fu.priority?.color;
          if (!pColor) {
            if (fu.is_blocker) pColor = '#EF4444';
            else if (fu.priority_id && this.priorityCatalogs.length > 0) {
              const cat = this.priorityCatalogs.find(p => p.id === fu.priority_id);
              pColor = cat?.color || '#3B82F6';
            } else {
              pColor = '#3B82F6';
            }
          }
          if (fu.is_blocker) pColor = '#EF4444';

          results.push({
            id: fu.id,
            text: fu.action,
            isBlocker: !!fu.is_blocker,
            priorityColor: pColor,
            priorityLabel: fu.priority?.label || '',
            ownerName: fu.owner?.display_name,
            ageText: this.getItemAgeLabel(fu.created_at),
            ageDays: this.getItemAgeDays(fu.created_at),
            rawFollowUp: fu
          });
        }
      }
    }

    return results;
  }

  openNewActionModal(item: ReleaseItem): void {
    const defaultStatus = this.statusCatalogs.find(s => s.code === 'pending')?.id || (this.statusCatalogs[0]?.id || 18);
    const defaultPriority = this.priorityCatalogs.find(p => p.code === 'high')?.id || (this.priorityCatalogs[0]?.id || 20);

    this.selectedActionPoint = { isNew: true };
    this.selectedActionItemTitle = item.title;
    this.selectedActionItemId = item.id;

    this.actionEditForm = {
      action: '',
      status_id: defaultStatus,
      priority_id: defaultPriority,
      owner_person_id: item.owner_person_id ? Number(item.owner_person_id) : null,
      due_date: new Date().toISOString().split('T')[0],
      is_blocker: false,
      notes: ''
    };
  }

  openEditActionModal(item: ReleaseItem, ap: any): void {
    this.selectedActionPoint = ap;
    this.selectedActionItemTitle = item.title;
    this.selectedActionItemId = item.id;

    const defaultStatus = this.statusCatalogs.find(s => s.code === 'pending')?.id || (this.statusCatalogs[0]?.id || 18);
    const defaultPriority = this.priorityCatalogs.find(p => p.code === 'high')?.id || (this.priorityCatalogs[0]?.id || 20);

    if (ap.rawFollowUp) {
      const fu = ap.rawFollowUp;
      let formattedDate = '';
      if (fu.due_date) {
        formattedDate = String(fu.due_date).split('T')[0];
      }

      this.actionEditForm = {
        action: fu.action,
        status_id: fu.status_id ? Number(fu.status_id) : defaultStatus,
        priority_id: fu.priority_id ? Number(fu.priority_id) : defaultPriority,
        owner_person_id: fu.owner_person_id ? Number(fu.owner_person_id) : null,
        due_date: formattedDate,
        is_blocker: !!fu.is_blocker,
        notes: fu.notes || ''
      };
    } else {
      this.actionEditForm = {
        action: ap.text,
        status_id: defaultStatus,
        priority_id: defaultPriority,
        owner_person_id: item.owner_person_id ? Number(item.owner_person_id) : null,
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
    if (!this.actionEditForm.action || !this.actionEditForm.action.trim()) {
      this.toastService.error('Required action title cannot be empty.');
      return;
    }

    const payload = {
      action: this.actionEditForm.action.trim(),
      status_id: Number(this.actionEditForm.status_id) || (this.statusCatalogs[0]?.id || 0),
      priority_id: Number(this.actionEditForm.priority_id) || (this.priorityCatalogs[0]?.id || 0),
      owner_person_id: this.actionEditForm.owner_person_id ? Number(this.actionEditForm.owner_person_id) : null,
      due_date: this.actionEditForm.due_date ? String(this.actionEditForm.due_date).split('T')[0] : null,
      is_blocker: Boolean(this.actionEditForm.is_blocker),
      notes: this.actionEditForm.notes || null,
    };

    if (this.selectedActionPoint.rawFollowUp && !this.selectedActionPoint.isNew) {
      const id = this.selectedActionPoint.rawFollowUp.id;
      this.apiService.updateFollowUp(id, payload).subscribe({
        next: () => {
          this.closeActionModal();
          this.toastService.success('Action Item updated successfully!');
          this.loadData();
        },
        error: (err) => {
          console.error('Failed to update action item:', err);
          this.toastService.error('Failed to update action item. Please check all fields.');
        }
      });
    } else {
      const createPayload = {
        release_item_id: this.selectedActionItemId,
        ...payload
      };
      this.apiService.createFollowUp(createPayload).subscribe({
        next: () => {
          this.closeActionModal();
          this.toastService.success('Action Point added successfully!');
          this.loadData();
        },
        error: (err) => {
          console.error('Failed to create action item:', err);
          this.toastService.error('Failed to create action item. Please check all fields.');
        }
      });
    }
  }

  openPromotionModal(item: ReleaseItem, envCode: string): void {
    this.selectedItem = item;
    this.selectedEnvCode = envCode;

    const projId = item.project?.id || item.module?.project_id;
    const project = this.projectsList.find(p => p.id === projId) || this.projectsList[0];
    const projectEnvs = project?.project_environments || [];

    const penv = projectEnvs.find((p: any) => p.environment?.code === envCode);
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
