import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService, AuditEvent } from '../../core/services/api.service';

@Component({
  selector: 'app-history',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="history-page">
      <div class="header-banner">
        <div>
          <h1 class="page-title">Immutable Audit Trail</h1>
          <p class="page-subtitle">Historical log of all status promotions, activations, and release modifications.</p>
        </div>
      </div>

      <div class="glass-card table-section">
        <div class="timeline">
          <div class="timeline-item" *ngFor="let ev of events">
            <div class="timeline-badge">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div class="timeline-content">
              <div class="timeline-header">
                <span class="event-type">{{ ev.event_type }}</span>
                <span class="event-date">{{ ev.occurred_at | date:'medium' }}</span>
              </div>
              <div class="timeline-body">
                <div class="event-actor">Actor: <strong>{{ ev.actor_name }}</strong></div>
                <div class="event-details" *ngIf="ev.changes">
                  <pre class="json-preview">{{ ev.changes | json }}</pre>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .history-page { display: flex; flex-direction: column; gap: 1.5rem; }
    .page-title { font-size: 1.75rem; font-weight: 700; color: #FFF; }
    .page-subtitle { color: var(--text-muted); font-size: 0.9rem; }

    .timeline { display: flex; flex-direction: column; gap: 1.25rem; position: relative; padding-left: 1.5rem; }
    .timeline::before { content: ''; position: absolute; left: 7px; top: 10px; bottom: 10px; width: 2px; background: var(--bg-surface-border); }

    .timeline-item { position: relative; display: flex; gap: 1rem; }
    .timeline-badge { position: absolute; left: -1.5rem; width: 16px; height: 16px; border-radius: 50%; background: var(--accent-primary); color: #FFF; display: flex; align-items: center; justify-content: center; }

    .timeline-content { background: rgba(15, 23, 42, 0.6); border: 1px solid var(--bg-surface-border); border-radius: var(--radius-md); padding: 1rem; width: 100%; }
    .timeline-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem; }
    .event-type { font-weight: 700; color: var(--accent-primary); font-size: 0.85rem; text-transform: uppercase; }
    .event-date { font-size: 0.75rem; color: var(--text-subtle); }
    .event-actor { font-size: 0.85rem; color: var(--text-muted); }
    .json-preview { background: #0F172A; padding: 0.65rem; border-radius: 6px; font-size: 0.75rem; color: #A5B4FC; margin-top: 0.5rem; overflow-x: auto; font-family: monospace; }
  `]
})
export class HistoryComponent implements OnInit {
  events: AuditEvent[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    this.apiService.getAuditEvents().subscribe(res => {
      this.events = res;
    });
  }
}
