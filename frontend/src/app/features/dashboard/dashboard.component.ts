import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ApiService } from '../../core/services/api.service';
import { ToastService } from '../../core/services/toast.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterLink],
  template: `
    <div class="dashboard-page" *ngIf="data">
      <!-- Header Banner -->
      <div class="header-banner">
        <div>
          <h1 class="page-title">Portfolio Executive Dashboard</h1>
          <p class="page-subtitle">Central source of truth for Reports release progress, environment states, and follow-ups.</p>
        </div>
        <div class="header-actions">
          <span class="last-updated">Last refreshed: {{ data.last_updated_at | date:'yyyy-MM-dd HH:mm:ss' }}</span>
          <button class="btn btn-outline" (click)="loadDashboard(true)">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 4v6h-6M1 20v-6h6"/><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/></svg>
            Refresh
          </button>
        </div>
      </div>

      <!-- KPI Summary Cards Grid -->
      <div class="kpi-grid">
        <div class="kpi-card">
          <div class="kpi-icon icon-indigo">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M9 3v18"/></svg>
          </div>
          <div class="kpi-content">
            <span class="kpi-label">Total Release Units</span>
            <span class="kpi-value">{{ data.metrics.total_release_units }}</span>
          </div>
        </div>

        <div class="kpi-card">
          <div class="kpi-icon icon-emerald">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
          </div>
          <div class="kpi-content">
            <span class="kpi-label">In Production</span>
            <span class="kpi-value">{{ data.metrics.in_production }}</span>
          </div>
        </div>

        <div class="kpi-card">
          <div class="kpi-icon icon-amber">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
          </div>
          <div class="kpi-content">
            <span class="kpi-label">Needs Follow-up</span>
            <span class="kpi-value">{{ data.metrics.needs_follow_up }}</span>
          </div>
        </div>

        <div class="kpi-card">
          <div class="kpi-icon icon-rose">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          </div>
          <div class="kpi-content">
            <span class="kpi-label">Open Action Items</span>
            <span class="kpi-value">{{ data.metrics.open_actions }}</span>
          </div>
        </div>
      </div>

      <!-- Main Section: Full Width Release Units Health Table -->
      <div class="glass-card table-section">
        <div class="section-header">
          <h3>Reports Release Units ({{ data.items.length }})</h3>
          <a routerLink="/matrix" class="link-btn">View Full Matrix →</a>
        </div>

        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>Scope / Unit</th>
                <th>Module</th>
                <th>MOJA</th>
                <th>TATU</th>
                <th>SITA</th>
                <th>PROD</th>
                <th>Client Activation</th>
                <th>Calculated Health</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let item of data.items">
                <td class="font-semibold" [title]="item.description || item.title">{{ item.title }}</td>
                <td><span class="module-chip" [title]="item.module?.description || item.module?.name">{{ item.module?.name }}</span></td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="getEnvStateColor(item, 'MOJA')"></span>
                    <span>{{ getEnvStateLabel(item, 'MOJA') }}</span>
                  </div>
                </td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="getEnvStateColor(item, 'TATU')"></span>
                    <span>{{ getEnvStateLabel(item, 'TATU') }}</span>
                  </div>
                </td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="getEnvStateColor(item, 'SITA')"></span>
                    <span>{{ getEnvStateLabel(item, 'SITA') }}</span>
                  </div>
                </td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="getEnvStateColor(item, 'PROD')"></span>
                    <span>{{ getEnvStateLabel(item, 'PROD') }}</span>
                  </div>
                </td>
                <td>
                  <div class="status-indicator">
                    <span class="status-dot" [style.background-color]="item.client_activation?.status?.color || '#9CA3AF'"></span>
                    <span [style.color]="item.client_activation?.status?.color || '#9CA3AF'">
                      {{ item.client_activation?.status?.label || 'N/A' }}
                    </span>
                  </div>
                </td>
                <td>
                  <span class="badge" [style.background-color]="item.health?.color + '22'" [style.color]="item.health?.color" [style.border-color]="item.health?.color + '55'">
                    <span class="badge-dot" [style.background-color]="item.health?.color"></span>
                    {{ item.health?.label }}
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Bottom Widgets Grid (Side-by-side) -->
      <div class="bottom-widgets">
        <!-- Overdue Follow-ups Widget -->
        <div class="glass-card widget-card">
          <div class="section-header">
            <h3>Overdue Follow-ups</h3>
            <a routerLink="/follow-ups" class="link-btn">View All →</a>
          </div>
          <div class="overdue-list" *ngIf="data.overdue_follow_ups.length > 0; else noOverdue">
            <div class="overdue-item" *ngFor="let f of data.overdue_follow_ups">
              <div class="overdue-header">
                <span class="priority-tag">{{ f.priority?.label }}</span>
                <span class="due-tag">Due: {{ f.due_date }}</span>
              </div>
              <div class="overdue-title">{{ f.action }}</div>
              <div class="overdue-footer">
                <span>Owner: {{ f.owner?.display_name || 'Unassigned' }}</span>
                <span>Contact: {{ f.contact?.display_name || 'N/A' }}</span>
              </div>
            </div>
          </div>
          <ng-template #noOverdue>
            <div class="empty-state">
              <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#10B981" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
              <p>No overdue follow-ups! All commitments are up to date.</p>
            </div>
          </ng-template>
        </div>

        <!-- System Summary Widget -->
        <div class="glass-card widget-card">
          <div class="section-header">
            <h3>Environment Distribution</h3>
            <a routerLink="/matrix" class="link-btn">Environment Matrix →</a>
          </div>
          <div class="env-distribution">
            <div class="env-dist-item">
              <span class="env-name">MOJA (Development)</span>
              <span class="env-badge badge-moja">Active</span>
            </div>
            <div class="env-dist-item">
              <span class="env-name">TATU (QA Validation)</span>
              <span class="env-badge badge-tatu">Active</span>
            </div>
            <div class="env-dist-item">
              <span class="env-name">SITA (Staging / Pre-Prod)</span>
              <span class="env-badge badge-sita">Active</span>
            </div>
            <div class="env-dist-item">
              <span class="env-name">PROD (Production)</span>
              <span class="env-badge badge-prod">Active</span>
            </div>
          </div>
        </div>
      </div>

    </div>
  `,
  styles: [`
    .dashboard-page { display: flex; flex-direction: column; gap: 1.5rem; width: 100%; }
    .header-banner { display: flex; justify-content: space-between; align-items: flex-end; }
    .page-title { font-size: 1.75rem; font-weight: 700; color: #FFF; margin-bottom: 0.25rem; }
    .page-subtitle { color: var(--text-muted); font-size: 0.9rem; }
    .header-actions { display: flex; align-items: center; gap: 1rem; }
    .last-updated { font-size: 0.75rem; color: var(--text-subtle); }

    .kpi-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.25rem; width: 100%; }
    @media (max-width: 1024px) { .kpi-grid { grid-template-columns: repeat(2, 1fr); } }
    @media (max-width: 640px) { .kpi-grid { grid-template-columns: 1fr; } }

    .kpi-card { background: var(--bg-card); border: 1px solid var(--bg-surface-border); border-radius: var(--radius-lg); padding: 1.25rem; display: flex; align-items: center; gap: 1rem; box-shadow: var(--shadow-card); }
    .kpi-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
    .icon-indigo { background: rgba(99, 102, 241, 0.15); color: #818CF8; }
    .icon-emerald { background: rgba(16, 185, 129, 0.15); color: #34D399; }
    .icon-amber { background: rgba(245, 158, 11, 0.15); color: #FBBF24; }
    .icon-rose { background: rgba(239, 68, 68, 0.15); color: #F87171; }
    .kpi-content { display: flex; flex-direction: column; gap: 0.35rem; }
    .kpi-label { font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; font-weight: 600; letter-spacing: 0.03em; }
    .kpi-value { font-size: 1.75rem; font-weight: 700; color: #FFF; font-family: var(--font-heading); line-height: 1; }

    .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; }
    .section-header h3 { font-size: 1.1rem; color: #FFF; }
    .link-btn { font-size: 0.85rem; font-weight: 600; }

    .table-responsive { overflow-x: auto; width: 100%; }
    .data-table { width: 100%; border-collapse: collapse; text-align: left; }
    .data-table th { padding: 0.85rem 1rem; font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted); border-bottom: 1px solid var(--bg-surface-border); }
    .data-table td { padding: 0.95rem 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.04); font-size: 0.85rem; vertical-align: middle; }
    .data-table tr:hover { background: rgba(255, 255, 255, 0.02); }

    .module-chip { background: rgba(255,255,255,0.06); padding: 0.2rem 0.55rem; border-radius: 4px; font-size: 0.75rem; color: var(--text-muted); }

    /* Bottom Widgets Side-by-Side */
    .bottom-widgets { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; width: 100%; }
    @media (max-width: 900px) { .bottom-widgets { grid-template-columns: 1fr; } }

    .overdue-list { display: flex; flex-direction: column; gap: 0.75rem; margin-top: 0.5rem; }
    .overdue-item { background: rgba(15, 23, 42, 0.6); border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md); padding: 0.85rem; }
    .overdue-header { display: flex; justify-content: space-between; font-size: 0.7rem; font-weight: 600; margin-bottom: 0.4rem; }
    .priority-tag { color: #FCA5A5; }
    .due-tag { color: #FCD34D; }
    .overdue-title { font-size: 0.85rem; font-weight: 500; color: #FFF; margin-bottom: 0.5rem; }
    .overdue-footer { display: flex; justify-content: space-between; font-size: 0.75rem; color: var(--text-subtle); }
    .empty-state { text-align: center; padding: 2rem 1rem; color: var(--text-muted); }
    .empty-state p { margin-top: 0.5rem; font-size: 0.85rem; }

    .env-distribution { display: flex; flex-direction: column; gap: 0.85rem; margin-top: 0.5rem; }
    .env-dist-item { display: flex; justify-content: space-between; align-items: center; padding: 0.6rem 0.85rem; background: rgba(15, 23, 42, 0.5); border-radius: 6px; border: 1px solid var(--bg-surface-border); }
    .env-name { font-size: 0.85rem; color: #FFF; font-weight: 500; }
    .env-badge { font-size: 0.75rem; font-weight: 600; padding: 0.15rem 0.5rem; border-radius: 4px; }
    .badge-moja { background: rgba(16, 185, 129, 0.15); color: #34D399; }
    .badge-tatu { background: rgba(59, 130, 246, 0.15); color: #60A5FA; }
    .badge-sita { background: rgba(168, 85, 247, 0.15); color: #C084FC; }
    .badge-prod { background: rgba(245, 158, 11, 0.15); color: #FBBF24; }
  `]
})
export class DashboardComponent implements OnInit {
  data: any = null;

  constructor(
    private apiService: ApiService,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadDashboard();
  }

  loadDashboard(notify: boolean = false): void {
    this.apiService.getDashboard().subscribe(res => {
      this.data = res;
      if (notify) {
        this.toastService.success('Dashboard data refreshed successfully!');
      }
    });
  }

  getEnvStateLabel(item: any, envCode: string): string {
    const state = item.environment_states?.find((s: any) => s.project_environment?.environment?.code === envCode);
    return state?.status?.label || 'X - Not reached';
  }

  getEnvStateColor(item: any, envCode: string): string {
    const state = item.environment_states?.find((s: any) => s.project_environment?.environment?.code === envCode);
    return state?.status?.color || '#9CA3AF';
  }
}
