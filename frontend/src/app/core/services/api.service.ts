import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface CatalogValue {
  id: number;
  category: string;
  code: string;
  label: string;
  description?: string;
  sort_order?: number;
  color?: string;
}

export interface Environment {
  id: number;
  code: string;
  name: string;
  default_sequence: number;
}

export interface Person {
  id: number;
  display_name: string;
  email?: string;
  role_title?: string;
  team?: string;
}

export interface EnvironmentState {
  id: number;
  project_id: number;
  release_item_id: number;
  project_environment_id: number;
  status_id: number;
  status_changed_at: string;
  verified_at: string;
  confirmed_by_person_id?: number;
  confirmed_by_text?: string;
  source_summary: string;
  notes?: string;
  status?: CatalogValue;
  confirmed_by_person?: Person;
  project_environment?: {
    id: number;
    sequence: number;
    environment: Environment;
  };
}

export interface ClientActivation {
  id: number;
  release_item_id: number;
  status_id: number;
  scope_type: string;
  scope_description?: string;
  activated_at?: string;
  verified_at: string;
  confirmed_by_person_id?: number;
  confirmed_by_text?: string;
  source_summary: string;
  notes?: string;
  status?: CatalogValue;
  confirmed_by_person?: Person;
}

export interface FollowUp {
  id: number;
  release_item_id: number;
  action: string;
  status_id: number;
  priority_id: number;
  owner_person_id?: number;
  contact_person_id?: number;
  due_date?: string;
  is_blocker: boolean;
  notes?: string;
  outcome?: string;
  completed_at?: string;
  status?: CatalogValue;
  priority?: CatalogValue;
  owner?: Person;
  contact?: Person;
  release_item?: any;
}

export interface HealthStatus {
  code: string;
  label: string;
  color: string;
  rank: number;
  reasons: string[];
}

export interface ReleaseItem {
  id: number;
  project_id: number;
  release_id: number;
  module_id: number;
  title: string;
  description?: string;
  item_type_id: number;
  status_id: number;
  priority_id: number;
  owner_person_id?: number;
  jira_key?: string;
  jira_url?: string;
  next_action: string;
  target_date?: string;
  project?: any;
  module?: any;
  release?: any;
  item_type?: CatalogValue;
  status?: CatalogValue;
  priority?: CatalogValue;
  owner?: Person;
  environment_states?: EnvironmentState[];
  client_activation?: ClientActivation;
  follow_ups?: FollowUp[];
  health?: HealthStatus;
}

export interface AuditEvent {
  id: number;
  entity_type: string;
  entity_id: number;
  event_type: string;
  changes?: any;
  context?: any;
  actor_name: string;
  occurred_at: string;
}

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private apiUrl = 'http://127.0.0.1:8001/api';

  constructor(private http: HttpClient) {}

  getDashboard(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/dashboard`);
  }

  getCatalogs(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/catalogs`);
  }

  getProjects(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/projects`);
  }

  getReleaseItems(projectId?: number): Observable<ReleaseItem[]> {
    const url = projectId ? `${this.apiUrl}/release-items?project_id=${projectId}` : `${this.apiUrl}/release-items`;
    return this.http.get<ReleaseItem[]>(url);
  }

  getReleaseItem(id: number): Observable<ReleaseItem> {
    return this.http.get<ReleaseItem>(`${this.apiUrl}/release-items/${id}`);
  }

  updateEnvironmentState(itemId: number, data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/release-items/${itemId}/environment-states`, data);
  }

  updateClientActivation(itemId: number, data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/release-items/${itemId}/client-activation`, data);
  }

  getFollowUps(params?: any): Observable<FollowUp[]> {
    let url = `${this.apiUrl}/follow-ups`;
    if (params) {
      const searchParams = new URLSearchParams(params);
      url += `?${searchParams.toString()}`;
    }
    return this.http.get<FollowUp[]>(url);
  }

  createFollowUp(data: any): Observable<FollowUp> {
    return this.http.post<FollowUp>(`${this.apiUrl}/follow-ups`, data);
  }

  updateFollowUp(id: number, data: any): Observable<FollowUp> {
    return this.http.put<FollowUp>(`${this.apiUrl}/follow-ups/${id}`, data);
  }

  getAuditEvents(entityId?: number): Observable<AuditEvent[]> {
    const url = entityId ? `${this.apiUrl}/audit-events?entity_id=${entityId}` : `${this.apiUrl}/audit-events`;
    return this.http.get<AuditEvent[]>(url);
  }
}
