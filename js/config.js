// STAGING CONFIG — this file must only ever exist on the `staging` branch
// (and branches based on it). Never merge changes to this file into `main`.
//
// Fill these in once you've created the staging Supabase project
// (Project Settings → API). The anon key is safe to expose in frontend
// code — it only grants what your Row Level Security policies allow.
window.SUPABASE_CONFIG = {
  url: "https://hiouybvrqzgsjqufpnun.supabase.co",
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhpb3V5YnZycXpnc2pxdWZwbnVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQxOTI5NzcsImV4cCI6MjA5OTc2ODk3N30.l4Njr56TbCurCEpxgOytQy9P7MirHhktmft6cCN29Sg",
};

// Batch (cohort) start dates are no longer set here — manage them from
// /admin.html → "Batches & Teams" so staff never need to edit this file.

// Fill this in once you push the `staging` branch and Vercel creates its
// preview deployment for it (check the Vercel dashboard for the URL, or
// the deployment comment on the branch/PR).
window.API_BASE_URL = "YOUR_STAGING_VERCEL_PREVIEW_URL";
