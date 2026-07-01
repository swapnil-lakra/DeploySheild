import type { Product } from "../types";

const rawBase = import.meta.env.VITE_API_URL ?? '';

const API_BASE = rawBase.replace(/\/+$/, '');

class APIError extends Error {
  status: number;
  data: any;
  constructor(message: string, status: number, data: any) {
    super(message);
    this.name = 'APIError';
    this.status = status;
    this.data = data;
  }
}

function buildUrl(endpoint: string) {
  // endpoint may start with '/': keep it as absolute path when no API_BASE set.
  if (!API_BASE) return endpoint;
  // ensure single slash between base and endpoint
  if (endpoint.startsWith('/')) return `${API_BASE}${endpoint}`;
  return `${API_BASE}/${endpoint}`;
}

async function request<T>(endpoint: string, options?: RequestInit): Promise<T> {
  const url = buildUrl(endpoint);
  const response = await fetch(url, {
    ...options,
    headers: { 'Content-Type': 'application/json', ...options?.headers },
  });

  const contentType = response.headers.get('content-type') ?? '';

  // If server returned non-JSON (e.g., HTML index.html) treat it as an error
  if (!contentType.includes('application/json')) {
    const text = await response.text().catch(() => null);
    const snippet = typeof text === 'string' ? text.slice(0, 300) : text;
    throw new APIError(`Expected JSON response but got ${contentType || 'no content-type'}`, response.status, snippet);
  }

  const data = await response.json().catch(() => null);

  if (!response.ok) {
    throw new APIError(data?.detail || data?.message || 'API Error', response.status, data);
  }

  return data as T;
}

export const api = {
  get: <T>(endpoint: string, params?: Record<string, any>) => {
    const query = params ? `?${new URLSearchParams(params).toString()}` : '';
    return request<T>(`${endpoint}${query}`);
  },
};

export const productAPI = {
  // endpoints are kept as absolute paths; buildUrl handles API_BASE prefixing
  getAll: (params?: any) => api.get<Product[]>('/api/products/', params),
  getFeatured: (limit = 8) => api.get<Product[]>(`/api/products/featured?limit=${limit}`),
  getById: (id: number) => api.get<Product>(`/api/products/${id}`),
  getBySlug: (slug: string) => api.get<Product>(`/api/products/slug/${slug}`),
};