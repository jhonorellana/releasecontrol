import { Routes } from '@angular/router';
import { DashboardComponent } from './features/dashboard/dashboard.component';
import { MatrixComponent } from './features/matrix/matrix.component';
import { ActivationComponent } from './features/activation/activation.component';
import { FollowUpsComponent } from './features/follow-ups/follow-ups.component';
import { HistoryComponent } from './features/history/history.component';

export const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'matrix', component: MatrixComponent },
  { path: 'activation', component: ActivationComponent },
  { path: 'follow-ups', component: FollowUpsComponent },
  { path: 'history', component: HistoryComponent },
  { path: '**', redirectTo: 'dashboard' }
];
