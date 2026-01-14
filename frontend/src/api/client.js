import axios from 'axios';
const API_BASE = import.meta.env.VITE_API_URL || 'http://localhost:3000';
const client = axios.create({ baseURL: API_BASE, headers: { 'Content-Type': 'application/json' } });
client.interceptors.request.use((config) => { const token = localStorage.getItem('token'); if (token) config.headers.Authorization = `Bearer ${token}`; return config; });
client.interceptors.response.use((r) => r, (e) => { if (e.response?.status === 401) { localStorage.removeItem('token'); window.location.href = '/login'; } return Promise.reject(e); });

export const auth = {
  register: (data) => client.post('/auth/register', data),
  login: (data) => client.post('/auth/login', data),
  me: () => client.get('/auth/me'),
};
export const templates = { list: () => client.get('/templates'), get: (id) => client.get(`/templates/${id}`) };
export const projects = { list: () => client.get('/projects'), generate: (templateId, config) => client.post('/projects/generate', { template_id: templateId, config }, { responseType: 'blob' }) };
export default client;
