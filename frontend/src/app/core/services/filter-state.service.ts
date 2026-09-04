import { Injectable } from '@angular/core';

export interface MatrixFilterState {
  filterText: string;
  filterProject: string;
  filterModule: string;
  filterActionStatus?: string;
  sortColumn: string;
  sortDirection: 'asc' | 'desc';
}

export interface ActivationFilterState {
  filterText: string;
  filterProject: string;
  filterModule: string;
  filterStatus: string;
  sortColumn: string;
  sortDirection: 'asc' | 'desc';
}

export interface FollowUpFilterState {
  filterText: string;
  filterProject: string;
  filterStatus: string;
  filterPriority: string;
  filterOwner: string;
  sortColumn: string;
  sortDirection: 'asc' | 'desc';
}

export interface SettingsFilterState {
  activeTab: 'projects' | 'releases' | 'units' | 'catalogs' | 'people';
  releaseFilterProject: string;
  releaseSortColumn: string;
  releaseSortDirection: 'asc' | 'desc';
  unitFilterText: string;
  unitFilterProject: string;
  unitFilterModule: string;
  unitFilterRelease: string;
  unitSortColumn: string;
  unitSortDirection: 'asc' | 'desc';
}

@Injectable({
  providedIn: 'root'
})
export class FilterStateService {
  private readonly STORAGE_KEYS = {
    matrix: 'rc_filters_matrix',
    activation: 'rc_filters_activation',
    followUps: 'rc_filters_followups',
    settings: 'rc_filters_settings'
  };

  // Matrix Filter State
  getMatrixState(): MatrixFilterState {
    const saved = localStorage.getItem(this.STORAGE_KEYS.matrix);
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error('Failed to parse matrix filter state', e);
      }
    }
    return {
      filterText: '',
      filterProject: 'all',
      filterModule: 'all',
      filterActionStatus: 'all',
      sortColumn: 'title',
      sortDirection: 'asc'
    };
  }

  saveMatrixState(state: Partial<MatrixFilterState>): void {
    const current = this.getMatrixState();
    const updated = { ...current, ...state };
    localStorage.setItem(this.STORAGE_KEYS.matrix, JSON.stringify(updated));
  }

  resetMatrixState(): MatrixFilterState {
    const defaultState: MatrixFilterState = {
      filterText: '',
      filterProject: 'all',
      filterModule: 'all',
      filterActionStatus: 'all',
      sortColumn: 'title',
      sortDirection: 'asc'
    };
    localStorage.setItem(this.STORAGE_KEYS.matrix, JSON.stringify(defaultState));
    return defaultState;
  }

  // Activation Filter State
  getActivationState(): ActivationFilterState {
    const saved = localStorage.getItem(this.STORAGE_KEYS.activation);
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error('Failed to parse activation filter state', e);
      }
    }
    return {
      filterText: '',
      filterProject: 'all',
      filterModule: 'all',
      filterStatus: 'all',
      sortColumn: 'title',
      sortDirection: 'asc'
    };
  }

  saveActivationState(state: Partial<ActivationFilterState>): void {
    const current = this.getActivationState();
    const updated = { ...current, ...state };
    localStorage.setItem(this.STORAGE_KEYS.activation, JSON.stringify(updated));
  }

  resetActivationState(): ActivationFilterState {
    const defaultState: ActivationFilterState = {
      filterText: '',
      filterProject: 'all',
      filterModule: 'all',
      filterStatus: 'all',
      sortColumn: 'title',
      sortDirection: 'asc'
    };
    localStorage.setItem(this.STORAGE_KEYS.activation, JSON.stringify(defaultState));
    return defaultState;
  }

  // Follow-ups Filter State
  getFollowUpsState(): FollowUpFilterState {
    const saved = localStorage.getItem(this.STORAGE_KEYS.followUps);
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error('Failed to parse follow-ups filter state', e);
      }
    }
    return {
      filterText: '',
      filterProject: 'all',
      filterStatus: 'all',
      filterPriority: 'all',
      filterOwner: 'all',
      sortColumn: 'action',
      sortDirection: 'asc'
    };
  }

  saveFollowUpsState(state: Partial<FollowUpFilterState>): void {
    const current = this.getFollowUpsState();
    const updated = { ...current, ...state };
    localStorage.setItem(this.STORAGE_KEYS.followUps, JSON.stringify(updated));
  }

  resetFollowUpsState(): FollowUpFilterState {
    const defaultState: FollowUpFilterState = {
      filterText: '',
      filterProject: 'all',
      filterStatus: 'all',
      filterPriority: 'all',
      filterOwner: 'all',
      sortColumn: 'action',
      sortDirection: 'asc'
    };
    localStorage.setItem(this.STORAGE_KEYS.followUps, JSON.stringify(defaultState));
    return defaultState;
  }

  // Settings Filter & Tab State
  getSettingsState(): SettingsFilterState {
    const saved = localStorage.getItem(this.STORAGE_KEYS.settings);
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.error('Failed to parse settings filter state', e);
      }
    }
    return {
      activeTab: 'projects',
      releaseFilterProject: 'all',
      releaseSortColumn: 'id',
      releaseSortDirection: 'asc',
      unitFilterText: '',
      unitFilterProject: 'all',
      unitFilterModule: 'all',
      unitFilterRelease: 'all',
      unitSortColumn: 'id',
      unitSortDirection: 'asc'
    };
  }

  saveSettingsState(state: Partial<SettingsFilterState>): void {
    const current = this.getSettingsState();
    const updated = { ...current, ...state };
    localStorage.setItem(this.STORAGE_KEYS.settings, JSON.stringify(updated));
  }

  resetUnitSettingsState(): void {
    const current = this.getSettingsState();
    current.unitFilterText = '';
    current.unitFilterProject = 'all';
    current.unitFilterModule = 'all';
    current.unitFilterRelease = 'all';
    localStorage.setItem(this.STORAGE_KEYS.settings, JSON.stringify(current));
  }
}
