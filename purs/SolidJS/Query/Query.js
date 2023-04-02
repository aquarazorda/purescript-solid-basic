import { QueryClient, QueryClientProvider, createQuery as cQ } from '@tanstack/solid-query';
import { createComponent } from 'solid-js';

export const getQueryClient = () => new QueryClient();

export const queryClientProvider = (client) => (children) =>
  createComponent(QueryClientProvider, {
    client,
    get children() {
      return children();
    }
  });

export const createQuery_ = (queryArr) => (query) => cQ(() => queryArr, query, {
  suspense: true
});