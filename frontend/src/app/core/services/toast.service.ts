import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

export interface ToastMessage {
  id: number;
  type: 'success' | 'error' | 'info' | 'warning';
  title?: string;
  message: string;
}

@Injectable({
  providedIn: 'root'
})
export class ToastService {
  private toastsSubject = new BehaviorSubject<ToastMessage[]>([]);
  toasts$ = this.toastsSubject.asObservable();
  private nextId = 1;

  show(message: string, type: 'success' | 'error' | 'info' | 'warning' = 'success', title?: string): void {
    const toast: ToastMessage = {
      id: this.nextId++,
      type,
      title,
      message
    };
    const current = this.toastsSubject.getValue();
    this.toastsSubject.next([...current, toast]);

    setTimeout(() => {
      this.remove(toast.id);
    }, 4000);
  }

  success(message: string, title: string = 'Success'): void {
    this.show(message, 'success', title);
  }

  error(message: string, title: string = 'Error'): void {
    this.show(message, 'error', title);
  }

  info(message: string, title: string = 'Info'): void {
    this.show(message, 'info', title);
  }

  remove(id: number): void {
    const current = this.toastsSubject.getValue();
    this.toastsSubject.next(current.filter(t => t.id !== id));
  }
}
