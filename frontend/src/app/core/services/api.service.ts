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
  is_system?: boolean;
  is_active?: boolean;
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
  is_active?: boolean;
}

export interface Project {
  id: number;
  name: string;
  code: string;
  description?: string;
  status_id: number;
  owner_person_id?: number;
  status?: CatalogValue;
  owner?: Person;
  modules?: Module[];
  project_environments?: any[];
}

export interface Module {
  id: number;
  project_id: number;
  name: string;
  code: string;
  description?: string;
  status_id: number;
  owner_person_id?: number;
  project?: Project;
  status?: CatalogValue;
  owner?: Person;
}

export interface Release {
  id: number;
  project_id: number;
  name: string;
  code: string;
  scope?: string;
  status_id: number;
  owner_person_id?: number;
  target_date?: string;
  release_notes_url?: string;
  notes?: string;
  project?: Project;
  status?: CatalogValue;
  owner?: Person;
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
  target_date?: string;
  project?: Project;
  module?: Module;
  release?: Release;
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

  // Dashboard & Catalogs
  getDashboard(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/dashboard`);
  }

  getCatalogs(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/catalogs`);
  }

  createCatalogValue(data: any): Observable<CatalogValue> {
    return this.http.post<CatalogValue>(`${this.apiUrl}/catalogs/values`, data);
  }

  updateCatalogValue(id: number, data: any): Observable<CatalogValue> {
    return this.http.put<CatalogValue>(`${this.apiUrl}/catalogs/values/${id}`, data);
  }

  deleteCatalogValue(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/catalogs/values/${id}`);
  }

  // Projects CRUD
  getProjects(): Observable<Project[]> {
    return this.http.get<Project[]>(`${this.apiUrl}/projects`);
  }

  createProject(data: any): Observable<Project> {
    return this.http.post<Project>(`${this.apiUrl}/projects`, data);
  }

  updateProject(id: number, data: any): Observable<Project> {
    return this.http.put<Project>(`${this.apiUrl}/projects/${id}`, data);
  }

  deleteProject(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/projects/${id}`);
  }

  // Modules CRUD
  getModules(projectId?: number): Observable<Module[]> {
    const url = projectId ? `${this.apiUrl}/modules?project_id=${projectId}` : `${this.apiUrl}/modules`;
    return this.http.get<Module[]>(url);
  }

  createModule(data: any): Observable<Module> {
    return this.http.post<Module>(`${this.apiUrl}/modules`, data);
  }

  updateModule(id: number, data: any): Observable<Module> {
    return this.http.put<Module>(`${this.apiUrl}/modules/${id}`, data);
  }

  deleteModule(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/modules/${id}`);
  }

  // Releases CRUD
  getReleases(projectId?: number): Observable<Release[]> {
    const url = projectId ? `${this.apiUrl}/releases?project_id=${projectId}` : `${this.apiUrl}/releases`;
    return this.http.get<Release[]>(url);
  }

  createRelease(data: any): Observable<Release> {
    return this.http.post<Release>(`${this.apiUrl}/releases`, data);
  }

  updateRelease(id: number, data: any): Observable<Release> {
    return this.http.put<Release>(`${this.apiUrl}/releases/${id}`, data);
  }

  deleteRelease(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/releases/${id}`);
  }

  // Release Items CRUD
  getReleaseItems(projectId?: number): Observable<ReleaseItem[]> {
    const url = projectId ? `${this.apiUrl}/release-items?project_id=${projectId}` : `${this.apiUrl}/release-items`;
    return this.http.get<ReleaseItem[]>(url);
  }

  getReleaseItem(id: number): Observable<ReleaseItem> {
    return this.http.get<ReleaseItem>(`${this.apiUrl}/release-items/${id}`);
  }

  createReleaseItem(data: any): Observable<ReleaseItem> {
    return this.http.post<ReleaseItem>(`${this.apiUrl}/release-items`, data);
  }

  updateReleaseItem(id: number, data: any): Observable<ReleaseItem> {
    return this.http.put<ReleaseItem>(`${this.apiUrl}/release-items/${id}`, data);
  }

  deleteReleaseItem(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/release-items/${id}`);
  }

  // State Updates
  updateEnvironmentState(itemId: number, data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/release-items/${itemId}/environment-states`, data);
  }

  updateClientActivation(itemId: number, data: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/release-items/${itemId}/client-activation`, data);
  }

  // People CRUD
  getPeople(): Observable<Person[]> {
    return this.http.get<Person[]>(`${this.apiUrl}/people`);
  }

  createPerson(data: any): Observable<Person> {
    return this.http.post<Person>(`${this.apiUrl}/people`, data);
  }

  updatePerson(id: number, data: any): Observable<Person> {
    return this.http.put<Person>(`${this.apiUrl}/people/${id}`, data);
  }

  deletePerson(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/people/${id}`);
  }

  // Follow Ups CRUD
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

  // Audit Events
  getAuditEvents(entityId?: number): Observable<AuditEvent[]> {
    const url = entityId ? `${this.apiUrl}/audit-events?entity_id=${entityId}` : `${this.apiUrl}/audit-events`;
    return this.http.get<AuditEvent[]>(url);
  }
}
