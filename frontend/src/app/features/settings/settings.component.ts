import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService, Project, Module, Release, ReleaseItem, CatalogValue, Person } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';

@Component({
  selector: 'app-settings',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="settings-page">
      <div class="header-banner">
        <div>
          <h1 class="page-title">Master Data & Settings</h1>
          <p class="page-subtitle">Central management for Projects, Modules, Releases, Release Units, Catalogs, and Team Members.</p>
        </div>
      </div>

      <!-- Navigation Tabs -->
      <div class="tabs-header">
        <button class="tab-btn" [class.active]="activeTab === 'units'" (click)="activeTab = 'units'">
          <span>Release Units</span>
          <span class="tab-count">{{ items.length }}</span>
        </button>
        <button class="tab-btn" [class.active]="activeTab === 'projects'" (click)="activeTab = 'projects'">
          <span>Projects & Modules</span>
          <span class="tab-count">{{ projects.length }}</span>
        </button>
        <button class="tab-btn" [class.active]="activeTab === 'releases'" (click)="activeTab = 'releases'">
          <span>Releases</span>
          <span class="tab-count">{{ releases.length }}</span>
        </button>
        <button class="tab-btn" [class.active]="activeTab === 'catalogs'" (click)="activeTab = 'catalogs'">
          <span>Catalog Values</span>
        </button>
        <button class="tab-btn" [class.active]="activeTab === 'people'" (click)="activeTab = 'people'">
          <span>Team Members</span>
          <span class="tab-count">{{ people.length }}</span>
        </button>
      </div>

      <!-- TAB 1: RELEASE UNITS -->
      <div class="tab-content glass-card" *ngIf="activeTab === 'units'">
        <div class="tab-banner">
          <h3>Release Units (Release Items)</h3>
          <button class="btn btn-action-lg" (click)="openUnitModal()">+ New Release Unit</button>
        </div>

        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Module</th>
                <th>Release</th>
                <th>Type</th>
                <th>Priority</th>
                <th>Owner</th>
                <th>Jira Key</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let item of items">
                <td>#{{ item.id }}</td>
                <td class="font-semibold" [title]="item.description || item.title">{{ item.title }}</td>
                <td>{{ item.module?.name }}</td>
                <td>{{ item.release?.code }}</td>
                <td>{{ item.item_type?.label }}</td>
                <td><span [style.color]="item.priority?.color" class="font-bold">{{ item.priority?.label }}</span></td>
                <td>{{ item.owner?.display_name || 'Unassigned' }}</td>
                <td><a *ngIf="item.jira_url" [href]="item.jira_url" target="_blank" class="jira-link">{{ item.jira_key || 'Jira' }}</a><span *ngIf="!item.jira_url">—</span></td>
                <td class="actions-cell">
                  <button class="btn btn-outline btn-sm" (click)="openUnitModal(item)">Edit</button>
                  <button class="btn btn-danger-sm" (click)="confirmDelete('unit', item.id, item.title)">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- TAB 2: PROJECTS & MODULES -->
      <div class="tab-content glass-card" *ngIf="activeTab === 'projects'">
        <div class="tab-banner">
          <h3>Projects & Modules</h3>
          <div class="banner-actions">
            <button class="btn btn-action-lg" (click)="openModuleModal()">+ New Module</button>
            <button class="btn btn-primary" (click)="openProjectModal()">+ New Project</button>
          </div>
        </div>

        <div class="projects-list">
          <div class="project-block" *ngFor="let p of projects">
            <div class="project-header">
              <div>
                <div class="project-title-row">
                  <span class="project-title">{{ p.name }} ({{ p.code }})</span>
                  <span class="status-badge" [style.color]="p.status?.color || '#10B981'">{{ p.status?.label || 'Active' }}</span>
                  <span class="owner-pill" *ngIf="p.owner">PO: {{ p.owner.display_name }}</span>
                </div>
                <span class="project-desc">{{ p.description }}</span>
              </div>
              <div class="actions-cell">
                <button class="btn btn-outline btn-sm" (click)="openProjectModal(p)">Edit Project</button>
                <button class="btn btn-danger-sm" (click)="confirmDelete('project', p.id, p.name)">Delete Project</button>
              </div>
            </div>

            <div class="modules-grid">
              <div class="module-card" *ngFor="let m of p.modules">
                <div class="module-info">
                  <span class="module-name" [title]="m.description || m.name">{{ m.name }}</span>
                  <span class="module-code">Code: {{ m.code }}</span>
                </div>
                <div class="actions-cell">
                  <button class="btn btn-outline btn-sm" (click)="openModuleModal(m)">Edit</button>
                  <button class="btn btn-danger-sm" (click)="confirmDelete('module', m.id, m.name)">Delete</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- TAB 3: RELEASES -->
      <div class="tab-content glass-card" *ngIf="activeTab === 'releases'">
        <div class="tab-banner">
          <h3>Release Packages</h3>
          <button class="btn btn-action-lg" (click)="openReleaseModal()">+ New Release Package</button>
        </div>

        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Release Code</th>
                <th>Release Name</th>
                <th>Target Date</th>
                <th>Status</th>
                <th>Owner</th>
                <th>Scope Description</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let r of releases">
                <td>#{{ r.id }}</td>
                <td class="font-bold">{{ r.code }}</td>
                <td>{{ r.name }}</td>
                <td>{{ r.target_date || 'Not Set' }}</td>
                <td><span class="status-badge" [style.color]="r.status?.color">{{ r.status?.label }}</span></td>
                <td>{{ r.owner?.display_name || 'Unassigned' }}</td>
                <td class="max-w-desc">{{ r.scope || '—' }}</td>
                <td class="actions-cell">
                  <button class="btn btn-outline btn-sm" (click)="openReleaseModal(r)">Edit</button>
                  <button class="btn btn-danger-sm" (click)="confirmDelete('release', r.id, r.name)">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- TAB 4: CATALOG VALUES -->
      <div class="tab-content glass-card" *ngIf="activeTab === 'catalogs'">
        <div class="tab-banner">
          <h3>Controlled Catalog Values</h3>
          <button class="btn btn-action-lg" (click)="openCatalogModal()">+ New Catalog Value</button>
        </div>

        <div class="catalog-categories">
          <div class="category-block" *ngFor="let catKey of catalogCategories">
            <h4 class="category-title">{{ getCategoryLabel(catKey) }} ({{ catalogMap[catKey].length }})</h4>
            <table class="data-table">
              <thead>
                <tr>
                  <th>Code</th>
                  <th>Label</th>
                  <th>Description</th>
                  <th>Hex Color</th>
                  <th>Order</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr *ngFor="let c of catalogMap[catKey]">
                  <td><code>{{ c.code }}</code></td>
                  <td class="font-bold">{{ c.label }}</td>
                  <td>{{ c.description || '—' }}</td>
                  <td>
                    <span class="color-sample" [style.background-color]="c.color"></span>
                    <span>{{ c.color }}</span>
                  </td>
                  <td>{{ c.sort_order }}</td>
                  <td class="actions-cell">
                    <button class="btn btn-outline btn-sm" (click)="openCatalogModal(c)">Edit</button>
                    <button class="btn btn-danger-sm" *ngIf="!c.is_system" (click)="confirmDelete('catalog', c.id, c.label)">Delete</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- TAB 5: TEAM MEMBERS -->
      <div class="tab-content glass-card" *ngIf="activeTab === 'people'">
        <div class="tab-banner">
          <h3>Team Members</h3>
          <button class="btn btn-action-lg" (click)="openPersonModal()">+ Add Team Member</button>
        </div>

        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Display Name</th>
                <th>Role Title</th>
                <th>Team</th>
                <th>Email</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let p of people">
                <td>#{{ p.id }}</td>
                <td class="font-bold">{{ p.display_name }}</td>
                <td>{{ p.role_title || '—' }}</td>
                <td>{{ p.team || '—' }}</td>
                <td>{{ p.email || '—' }}</td>
                <td class="actions-cell">
                  <button class="btn btn-outline btn-sm" (click)="openPersonModal(p)">Edit</button>
                  <button class="btn btn-danger-sm" (click)="confirmDelete('person', p.id, p.display_name)">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- MODALS -->

      <!-- Unit Modal -->
      <div class="modal-overlay" *ngIf="showUnitModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingUnitId ? 'Edit Release Unit' : 'New Release Unit' }}</h3>
            <button class="close-btn" (click)="showUnitModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Title <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="unitForm.title">
            </div>
            <div class="form-group">
              <label>Description</label>
              <textarea class="form-control" [(ngModel)]="unitForm.description" rows="2" placeholder="Detailed description or scope of this release unit..."></textarea>
            </div>
            <div class="form-row">
              <div class="form-group col">
                <label>Module <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="unitForm.module_id">
                  <option *ngFor="let m of modulesList" [ngValue]="m.id">{{ m.name }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Release Package <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="unitForm.release_id">
                  <option *ngFor="let r of releases" [ngValue]="r.id">{{ r.name }}</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col">
                <label>Type <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="unitForm.item_type_id">
                  <option *ngFor="let t of catalogMap['release_item_type']" [ngValue]="t.id">{{ t.label }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Priority <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="unitForm.priority_id">
                  <option *ngFor="let p of catalogMap['priority']" [ngValue]="p.id">{{ p.label }}</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col">
                <label>Owner (Developer)</label>
                <select class="form-control" [(ngModel)]="unitForm.owner_person_id">
                  <option [ngValue]="null">Unassigned</option>
                  <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Jira Key</label>
                <input type="text" class="form-control" [(ngModel)]="unitForm.jira_key" placeholder="e.g. RPT-104">
              </div>
            </div>
            <div class="form-group">
              <label>Next Action</label>
              <input type="text" class="form-control" [(ngModel)]="unitForm.next_action" placeholder="Describe next coordination step">
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showUnitModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="saveUnit()">Save Unit</button>
          </div>
        </div>
      </div>

      <!-- Project Modal -->
      <div class="modal-overlay" *ngIf="showProjectModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingProjectId ? 'Edit Project' : 'New Project' }}</h3>
            <button class="close-btn" (click)="showProjectModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Project Name <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="projectForm.name" placeholder="e.g. Reports">
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Project Code <span class="required-star">*</span></label>
                <input type="text" class="form-control" [(ngModel)]="projectForm.code" placeholder="e.g. REPORTS">
              </div>
              <div class="form-group col">
                <label>Project Status <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="projectForm.status_id">
                  <option *ngFor="let s of catalogMap['project_status']" [ngValue]="s.id">{{ s.label }}</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label>Project Owner / PO</label>
              <select class="form-control" [(ngModel)]="projectForm.owner_person_id">
                <option [ngValue]="null">Unassigned</option>
                <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
              </select>
            </div>

            <div class="form-group">
              <label>Description</label>
              <textarea class="form-control" [(ngModel)]="projectForm.description" rows="2" placeholder="Overall project scope and purpose..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showProjectModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="saveProject()">Save Project</button>
          </div>
        </div>
      </div>

      <!-- Module Modal -->
      <div class="modal-overlay" *ngIf="showModuleModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingModuleId ? 'Edit Module' : 'New Module' }}</h3>
            <button class="close-btn" (click)="showModuleModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Project <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="moduleForm.project_id">
                <option *ngFor="let p of projects" [ngValue]="p.id">{{ p.name }}</option>
              </select>
            </div>
            <div class="form-group">
              <label>Module Name <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="moduleForm.name" placeholder="e.g. Payrun History">
            </div>
            <div class="form-group">
              <label>Module Code <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="moduleForm.code" placeholder="e.g. PH">
            </div>
            <div class="form-group">
              <label>Description</label>
              <textarea class="form-control" [(ngModel)]="moduleForm.description" rows="2" placeholder="Detailed description of this functional module..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showModuleModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="saveModule()">Save Module</button>
          </div>
        </div>
      </div>

      <!-- Release Modal -->
      <div class="modal-overlay" *ngIf="showReleaseModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingReleaseId ? 'Edit Release Package' : 'New Release Package' }}</h3>
            <button class="close-btn" (click)="showReleaseModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-row">
              <div class="form-group col">
                <label>Project <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="releaseForm.project_id">
                  <option *ngFor="let p of projects" [ngValue]="p.id">{{ p.name }}</option>
                </select>
              </div>
              <div class="form-group col">
                <label>Status <span class="required-star">*</span></label>
                <select class="form-control" [(ngModel)]="releaseForm.status_id">
                  <option *ngFor="let s of catalogMap['release_status']" [ngValue]="s.id">{{ s.label }}</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label>Release Name <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="releaseForm.name" placeholder="e.g. Reports 2026.08 Summary & ePay">
            </div>

            <div class="form-row">
              <div class="form-group col">
                <label>Release Code <span class="required-star">*</span></label>
                <input type="text" class="form-control" [(ngModel)]="releaseForm.code" placeholder="e.g. REL-RPT-202608">
              </div>
              <div class="form-group col">
                <label>Target Date (yyyy-mm-dd)</label>
                <input type="date" class="form-control" [(ngModel)]="releaseForm.target_date" placeholder="yyyy-mm-dd">
              </div>
            </div>

            <div class="form-group">
              <label>Owner (Release Lead)</label>
              <select class="form-control" [(ngModel)]="releaseForm.owner_person_id">
                <option [ngValue]="null">Unassigned</option>
                <option *ngFor="let p of people" [ngValue]="p.id">{{ p.display_name }} ({{ p.role_title }})</option>
              </select>
            </div>

            <div class="form-group">
              <label>Release Notes URL</label>
              <input type="text" class="form-control" [(ngModel)]="releaseForm.release_notes_url" placeholder="e.g. https://confluence.company.com/display/RPT/Release+Notes">
            </div>

            <div class="form-group">
              <label>Scope Description (max 500 chars)</label>
              <textarea class="form-control" [(ngModel)]="releaseForm.scope" rows="2" maxlength="500" placeholder="Summary of scope included in this release package..."></textarea>
            </div>

            <div class="form-group">
              <label>Notes / Context (max 500 chars)</label>
              <textarea class="form-control" [(ngModel)]="releaseForm.notes" rows="2" maxlength="500" placeholder="Additional release package notes or deployment instructions..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showReleaseModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="saveRelease()">Save Release Package</button>
          </div>
        </div>
      </div>

      <!-- Catalog Modal -->
      <div class="modal-overlay" *ngIf="showCatalogModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingCatalogId ? 'Edit Catalog Value' : 'New Catalog Value' }}</h3>
            <button class="close-btn" (click)="showCatalogModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Category <span class="required-star">*</span></label>
              <select class="form-control" [(ngModel)]="catalogForm.category" [disabled]="!!editingCatalogId">
                <option *ngFor="let catKey of catalogCategories" [value]="catKey">{{ getCategoryLabel(catKey) }}</option>
              </select>
            </div>
            <div class="form-group">
              <label>Code <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="catalogForm.code" placeholder="e.g. ready_for_qa" [disabled]="!!editingCatalogId">
            </div>
            <div class="form-group">
              <label>Label <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="catalogForm.label" placeholder="e.g. Ready for QA">
            </div>
            <div class="form-group">
              <label>Hex Color</label>
              <input type="color" class="form-control color-input" [(ngModel)]="catalogForm.color">
            </div>
            <div class="form-group">
              <label>Description</label>
              <textarea class="form-control" [(ngModel)]="catalogForm.description" rows="2"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showCatalogModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="saveCatalog()">Save Catalog Value</button>
          </div>
        </div>
      </div>

      <!-- Person Modal -->
      <div class="modal-overlay" *ngIf="showPersonModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>{{ editingPersonId ? 'Edit Team Member' : 'New Team Member' }}</h3>
            <button class="close-btn" (click)="showPersonModal = false">×</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>Display Name <span class="required-star">*</span></label>
              <input type="text" class="form-control" [(ngModel)]="personForm.display_name" placeholder="e.g. Alexis (Frontend Dev)">
            </div>
            <div class="form-group">
              <label>Role Title</label>
              <input type="text" class="form-control" [(ngModel)]="personForm.role_title" placeholder="e.g. Frontend Developer">
            </div>
            <div class="form-group">
              <label>Team</label>
              <input type="text" class="form-control" [(ngModel)]="personForm.team" placeholder="e.g. Operations">
            </div>
            <div class="form-group">
              <label>Email</label>
              <input type="email" class="form-control" [(ngModel)]="personForm.email">
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="showPersonModal = false">Cancel</button>
            <button class="btn btn-primary" (click)="savePerson()">Save Person</button>
          </div>
        </div>
      </div>

      <!-- Universal Soft Delete Confirmation Modal -->
      <div class="modal-overlay" *ngIf="showDeleteModal">
        <div class="modal-content border-red">
          <div class="modal-header">
            <h3 class="delete-modal-title">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#EF4444" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                <line x1="12" y1="9" x2="12" y2="13"></line>
                <line x1="12" y1="17" x2="12.01" y2="17"></line>
              </svg>
              <span>Confirm Soft Delete</span>
            </h3>
            <button class="close-btn" (click)="closeDeleteModal()">×</button>
          </div>
          <div class="modal-body">
            <p class="delete-msg">Are you sure you want to soft-delete <strong>"{{ deleteTargetName }}"</strong>?</p>
            <p class="delete-sub">This record will be soft-deleted from active views while preserving historical audit logs in MariaDB.</p>
          </div>
          <div class="modal-footer">
            <button class="btn btn-outline" (click)="closeDeleteModal()">Cancel</button>
            <button class="btn btn-danger-action" (click)="confirmSoftDelete()">Confirm Soft Delete</button>
          </div>
        </div>
      </div>

    </div>
  `,
  styles: [`
    .settings-page { display: flex; flex-direction: column; gap: 1.5rem; }
    .page-title { font-size: 1.75rem; font-weight: 700; color: #FFF; }
    .page-subtitle { color: var(--text-muted); font-size: 0.9rem; }

    .border-red { border-color: rgba(239, 68, 68, 0.4); }
    .btn-danger-action {
      background: #EF4444; color: #FFF; border: 1px solid #DC2626;
      padding: 0.5rem 1rem; border-radius: var(--radius-md); font-weight: 600; cursor: pointer;
      box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4); transition: var(--transition-fast);
    }
    .btn-danger-action:hover { background: #DC2626; transform: translateY(-1px); }

    .delete-modal-title { color: #F87171; display: flex; align-items: center; gap: 0.5rem; font-size: 1.15rem; }
    .delete-msg { font-size: 0.95rem; color: #FFF; margin-bottom: 0.5rem; }
    .delete-sub { font-size: 0.8rem; color: var(--text-muted); }

    .tabs-header { display: flex; gap: 0.75rem; border-bottom: 1px solid var(--bg-surface-border); padding-bottom: 0.5rem; }
    .tab-btn {
      display: flex; align-items: center; gap: 0.5rem; padding: 0.6rem 1.1rem;
      background: transparent; border: none; border-radius: var(--radius-md);
      color: var(--text-muted); font-weight: 600; font-size: 0.875rem; cursor: pointer; transition: var(--transition-fast);
    }
    .tab-btn:hover { color: #FFF; background: rgba(255, 255, 255, 0.05); }
    .tab-btn.active { color: #FFF; background: var(--accent-primary); box-shadow: 0 4px 12px var(--accent-glow); }
    .tab-count { background: rgba(255, 255, 255, 0.2); padding: 0.1rem 0.45rem; border-radius: 9999px; font-size: 0.75rem; }

    .tab-banner { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; }
    .tab-banner h3 { font-size: 1.2rem; color: #FFF; }
    .banner-actions { display: flex; gap: 0.75rem; }

    .btn-action-lg {
      display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.5rem 1rem;
      border-radius: var(--radius-md); background: linear-gradient(135deg, #6366F1 0%, #4F46E5 100%);
      color: #FFF; font-weight: 600; font-size: 0.85rem; border: 1px solid rgba(129, 140, 248, 0.4);
      box-shadow: 0 3px 10px rgba(99, 102, 241, 0.35); cursor: pointer; transition: var(--transition-fast);
    }
    .btn-danger-sm {
      background: rgba(239, 68, 68, 0.15); color: #F87171; border: 1px solid rgba(239, 68, 68, 0.3);
      padding: 0.25rem 0.55rem; border-radius: 4px; font-size: 0.75rem; cursor: pointer;
    }
    .btn-danger-sm:hover { background: #EF4444; color: #FFF; }

    .data-table { width: 100%; border-collapse: collapse; }
    .data-table th { padding: 0.85rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted); border-bottom: 1px solid var(--bg-surface-border); }
    .data-table td { padding: 0.85rem 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.04); font-size: 0.85rem; vertical-align: middle; }

    .actions-cell { display: flex; gap: 0.4rem; }
    .jira-link { font-weight: 600; color: #60A5FA; }

    /* Projects list */
    .projects-list { display: flex; flex-direction: column; gap: 1.25rem; }
    .required-star { color: #EF4444; font-weight: bold; margin-left: 0.15rem; }
    .project-block { background: rgba(15, 23, 42, 0.5); border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md); padding: 1.25rem; }
    .project-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 1rem; }
    .project-title-row { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.25rem; }
    .project-title { font-size: 1.1rem; font-weight: 700; color: #FFF; }
    .status-badge { font-weight: 700; font-size: 0.8rem; background: rgba(255,255,255,0.06); padding: 0.15rem 0.5rem; border-radius: 4px; }
    .owner-pill { font-size: 0.75rem; color: var(--accent-primary); font-weight: 600; background: rgba(99, 102, 241, 0.12); padding: 0.15rem 0.5rem; border-radius: 4px; }
    .project-desc { font-size: 0.8rem; color: var(--text-muted); display: block; }

    .modules-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 0.75rem; }
    .module-card { background: rgba(30, 41, 59, 0.7); border: 1px solid var(--bg-surface-border); border-radius: 8px; padding: 0.75rem 1rem; display: flex; justify-content: space-between; align-items: center; }
    .module-name { font-weight: 600; color: #FFF; display: block; font-size: 0.9rem; }
    .module-code { font-size: 0.75rem; color: var(--text-subtle); }

    /* Catalog categories */
    .catalog-categories { display: flex; flex-direction: column; gap: 1.5rem; }
    .category-block { background: rgba(15, 23, 42, 0.4); border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md); padding: 1rem; }
    .category-title { font-size: 1rem; color: var(--accent-primary); margin-bottom: 0.75rem; text-transform: uppercase; letter-spacing: 0.03em; }
    .color-sample { display: inline-block; width: 14px; height: 14px; border-radius: 50%; margin-right: 0.4rem; vertical-align: middle; }

    .form-row { display: flex; gap: 1rem; }
    .form-row .col { flex: 1; }
    .color-input { height: 40px; padding: 0.2rem; cursor: pointer; }

    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; }
    .modal-header h3 { font-size: 1.1rem; color: #FFF; }
    .close-btn { background: none; border: none; color: var(--text-muted); font-size: 1.5rem; cursor: pointer; }
    .modal-footer { display: flex; justify-content: flex-end; gap: 0.75rem; margin-top: 1.5rem; }
  `]
})
export class SettingsComponent implements OnInit {
  activeTab: 'units' | 'projects' | 'releases' | 'catalogs' | 'people' = 'units';

  items: ReleaseItem[] = [];
  projects: Project[] = [];
  modulesList: Module[] = [];
  releases: Release[] = [];
  people: Person[] = [];
  catalogMap: { [key: string]: CatalogValue[] } = {};

  // Modals state
  showUnitModal = false;
  editingUnitId: number | null = null;
  unitForm = { title: '', description: '', module_id: 0, release_id: 0, item_type_id: 0, priority_id: 0, owner_person_id: null as number | null, jira_key: '', next_action: '' };

  showProjectModal = false;
  editingProjectId: number | null = null;
  projectForm = { name: '', code: '', description: '', status_id: 0, owner_person_id: null as number | null };

  showModuleModal = false;
  editingModuleId: number | null = null;
  moduleForm = { project_id: 0, name: '', code: '', description: '' };

  showReleaseModal = false;
  editingReleaseId: number | null = null;
  releaseForm = {
    project_id: 0,
    name: '',
    code: '',
    status_id: 0,
    owner_person_id: null as number | null,
    target_date: '',
    scope: '',
    release_notes_url: '',
    notes: ''
  };

  showCatalogModal = false;
  editingCatalogId: number | null = null;
  catalogForm = { category: 'environment_state', code: '', label: '', color: '#3B82F6', description: '' };

  showPersonModal = false;
  editingPersonId: number | null = null;
  personForm = { display_name: '', role_title: '', team: '', email: '' };

  constructor(
    private apiService: ApiService,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadAllData();
  }

  loadAllData(): void {
    this.apiService.getReleaseItems().subscribe(res => this.items = res);
    this.apiService.getProjects().subscribe(res => this.projects = res);
    this.apiService.getModules().subscribe(res => this.modulesList = res);
    this.apiService.getReleases().subscribe(res => this.releases = res);
    this.apiService.getPeople().subscribe(res => this.people = res);
    this.apiService.getCatalogs().subscribe(res => this.catalogMap = res.catalogs || {});
  }

  get catalogCategories(): string[] {
    return Object.keys(this.catalogMap);
  }

  getCategoryLabel(key: string): string {
    const labels: { [k: string]: string } = {
      'environment_state': 'Environment States',
      'activation_status': 'Client Activation Statuses',
      'priority': 'Priorities',
      'follow_up_status': 'Follow-up Statuses',
      'release_item_type': 'Release Item Types',
      'release_status': 'Release Package Statuses',
      'project_status': 'Project Statuses',
      'module_status': 'Module Statuses',
    };
    return labels[key] || key;
  }

  // --- RELEASE UNIT CRUD ---
  openUnitModal(item?: ReleaseItem): void {
    if (item) {
      this.editingUnitId = item.id;
      this.unitForm = {
        title: item.title,
        description: item.description || '',
        module_id: item.module_id,
        release_id: item.release_id,
        item_type_id: item.item_type_id,
        priority_id: item.priority_id,
        owner_person_id: item.owner_person_id || null,
        jira_key: item.jira_key || '',
        next_action: item.next_action || '',
      };
    } else {
      this.editingUnitId = null;
      this.unitForm = {
        title: '',
        description: '',
        module_id: this.modulesList[0]?.id || 0,
        release_id: this.releases[0]?.id || 0,
        item_type_id: this.catalogMap['release_item_type']?.[0]?.id || 0,
        priority_id: this.catalogMap['priority']?.[0]?.id || 0,
        owner_person_id: null,
        jira_key: '',
        next_action: '',
      };
    }
    this.showUnitModal = true;
  }

  saveUnit(): void {
    if (this.editingUnitId) {
      this.apiService.updateReleaseItem(this.editingUnitId, this.unitForm).subscribe(() => {
        this.showUnitModal = false;
        this.toastService.success('Release unit updated successfully!');
        this.loadAllData();
      });
    } else {
      const payload = { ...this.unitForm, project_id: this.projects[0]?.id || 1 };
      this.apiService.createReleaseItem(payload).subscribe(() => {
        this.showUnitModal = false;
        this.toastService.success('New Release unit created successfully!');
        this.loadAllData();
      });
    }
  }

  deleteUnit(id: number): void {
    if (confirm('Are you sure you want to delete this Release Unit?')) {
      this.apiService.deleteReleaseItem(id).subscribe(() => {
        this.toastService.info('Release unit deleted');
        this.loadAllData();
      });
    }
  }

  // --- PROJECT CRUD ---
  openProjectModal(p?: Project): void {
    if (p) {
      this.editingProjectId = p.id;
      this.projectForm = {
        name: p.name,
        code: p.code,
        description: p.description || '',
        status_id: p.status_id,
        owner_person_id: p.owner_person_id || null
      };
    } else {
      this.editingProjectId = null;
      this.projectForm = {
        name: '',
        code: '',
        description: '',
        status_id: this.catalogMap['project_status']?.[0]?.id || 0,
        owner_person_id: this.people[0]?.id || null
      };
    }
    this.showProjectModal = true;
  }

  saveProject(): void {
    if (this.editingProjectId) {
      this.apiService.updateProject(this.editingProjectId, this.projectForm).subscribe(() => {
        this.showProjectModal = false;
        this.toastService.success('Project updated successfully!');
        this.loadAllData();
      });
    } else {
      this.apiService.createProject(this.projectForm).subscribe(() => {
        this.showProjectModal = false;
        this.toastService.success('New Project created successfully!');
        this.loadAllData();
      });
    }
  }

  // --- MODULE CRUD ---
  openModuleModal(m?: Module): void {
    if (m) {
      this.editingModuleId = m.id;
      this.moduleForm = { project_id: m.project_id, name: m.name, code: m.code, description: m.description || '' };
    } else {
      this.editingModuleId = null;
      this.moduleForm = { project_id: this.projects[0]?.id || 1, name: '', code: '', description: '' };
    }
    this.showModuleModal = true;
  }

  saveModule(): void {
    const payload = {
      ...this.moduleForm,
      project_id: Number(this.moduleForm.project_id)
    };
    if (this.editingModuleId) {
      this.apiService.updateModule(this.editingModuleId, payload).subscribe(() => {
        this.showModuleModal = false;
        this.toastService.success('Module updated successfully!');
        this.loadAllData();
      });
    } else {
      this.apiService.createModule(payload).subscribe(() => {
        this.showModuleModal = false;
        this.toastService.success('New Module created successfully!');
        this.loadAllData();
      });
    }
  }

  deleteModule(id: number): void {
    if (confirm('Delete this module?')) {
      this.apiService.deleteModule(id).subscribe(() => {
        this.toastService.info('Module deleted');
        this.loadAllData();
      });
    }
  }

  // --- RELEASE CRUD ---
  openReleaseModal(r?: Release): void {
    if (r) {
      this.editingReleaseId = r.id;
      this.releaseForm = {
        project_id: r.project_id,
        name: r.name,
        code: r.code,
        status_id: r.status_id,
        owner_person_id: r.owner_person_id || null,
        target_date: r.target_date || '',
        scope: r.scope || '',
        release_notes_url: r.release_notes_url || '',
        notes: r.notes || ''
      };
    } else {
      this.editingReleaseId = null;
      this.releaseForm = {
        project_id: this.projects[0]?.id || 1,
        name: '',
        code: '',
        status_id: this.catalogMap['release_status']?.[0]?.id || 0,
        owner_person_id: null,
        target_date: '',
        scope: '',
        release_notes_url: '',
        notes: ''
      };
    }
    this.showReleaseModal = true;
  }

  saveRelease(): void {
    if (this.editingReleaseId) {
      this.apiService.updateRelease(this.editingReleaseId, this.releaseForm).subscribe(() => {
        this.showReleaseModal = false;
        this.toastService.success('Release package updated successfully!');
        this.loadAllData();
      });
    } else {
      this.apiService.createRelease(this.releaseForm).subscribe(() => {
        this.showReleaseModal = false;
        this.toastService.success('New Release package created successfully!');
        this.loadAllData();
      });
    }
  }

  // --- SOFT DELETE CONFIRMATION ---
  showDeleteModal = false;
  deleteTargetType: 'unit' | 'project' | 'module' | 'release' | 'catalog' | 'person' | null = null;
  deleteTargetId: number | null = null;
  deleteTargetName: string = '';

  confirmDelete(type: 'unit' | 'project' | 'module' | 'release' | 'catalog' | 'person', id: number, name: string): void {
    this.deleteTargetType = type;
    this.deleteTargetId = id;
    this.deleteTargetName = name;
    this.showDeleteModal = true;
  }

  closeDeleteModal(): void {
    this.showDeleteModal = false;
    this.deleteTargetType = null;
    this.deleteTargetId = null;
    this.deleteTargetName = '';
  }

  confirmSoftDelete(): void {
    if (!this.deleteTargetType || !this.deleteTargetId) return;

    const id = this.deleteTargetId;
    const type = this.deleteTargetType;

    switch (type) {
      case 'unit':
        this.apiService.deleteReleaseItem(id).subscribe(() => {
          this.toastService.info('Release unit soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
      case 'project':
        this.apiService.deleteProject(id).subscribe(() => {
          this.toastService.info('Project soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
      case 'module':
        this.apiService.deleteModule(id).subscribe(() => {
          this.toastService.info('Module soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
      case 'release':
        this.apiService.deleteRelease(id).subscribe(() => {
          this.toastService.info('Release package soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
      case 'catalog':
        this.apiService.deleteCatalogValue(id).subscribe(() => {
          this.toastService.info('Catalog value soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
      case 'person':
        this.apiService.deletePerson(id).subscribe(() => {
          this.toastService.info('Team member soft-deleted');
          this.closeDeleteModal();
          this.loadAllData();
        });
        break;
    }
  }

  // --- CATALOG CRUD ---
  openCatalogModal(c?: CatalogValue): void {
    if (c) {
      this.editingCatalogId = c.id;
      this.catalogForm = { category: c.category, code: c.code, label: c.label, color: c.color || '#3B82F6', description: c.description || '' };
    } else {
      this.editingCatalogId = null;
      this.catalogForm = { category: 'environment_state', code: '', label: '', color: '#3B82F6', description: '' };
    }
    this.showCatalogModal = true;
  }

  saveCatalog(): void {
    if (this.editingCatalogId) {
      this.apiService.updateCatalogValue(this.editingCatalogId, this.catalogForm).subscribe(() => {
        this.showCatalogModal = false;
        this.toastService.success('Catalog value updated successfully!');
        this.loadAllData();
      });
    } else {
      this.apiService.createCatalogValue(this.catalogForm).subscribe(() => {
        this.showCatalogModal = false;
        this.toastService.success('New Catalog value created successfully!');
        this.loadAllData();
      });
    }
  }

  // --- PERSON CRUD ---
  openPersonModal(p?: Person): void {
    if (p) {
      this.editingPersonId = p.id;
      this.personForm = { display_name: p.display_name, role_title: p.role_title || '', team: p.team || '', email: p.email || '' };
    } else {
      this.editingPersonId = null;
      this.personForm = { display_name: '', role_title: '', team: '', email: '' };
    }
    this.showPersonModal = true;
  }

  savePerson(): void {
    if (this.editingPersonId) {
      this.apiService.updatePerson(this.editingPersonId, this.personForm).subscribe(() => {
        this.showPersonModal = false;
        this.toastService.success('Team member updated successfully!');
        this.loadAllData();
      });
    } else {
      this.apiService.createPerson(this.personForm).subscribe(() => {
        this.showPersonModal = false;
        this.toastService.success('New Team member added successfully!');
        this.loadAllData();
      });
    }
  }
}
