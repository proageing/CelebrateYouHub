// Requires config.js to be loaded first, and the Supabase CDN script:
// <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
const supabaseClient = supabase.createClient(
  window.SUPABASE_CONFIG.url,
  window.SUPABASE_CONFIG.anonKey
);

// Redirects to index.html if nobody is signed in. Returns the session.
async function requireSession() {
  const { data: { session } } = await supabaseClient.auth.getSession();
  if (!session) {
    window.location.href = "index.html";
    return null;
  }
  return session;
}

// Fetches (and lazily waits for) the caller's own profile row.
async function getMyProfile() {
  const { data: { user } } = await supabaseClient.auth.getUser();
  if (!user) return null;
  const { data, error } = await supabaseClient
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();
  if (error) {
    console.error("Failed to load profile", error);
    return null;
  }
  return data;
}

async function signOut() {
  await supabaseClient.auth.signOut();
  window.location.href = "index.html";
}

// Working out which week (1-8) the programme is currently on, based on
// PROGRAM_START_DATE from config.js. Participants can still open earlier
// weeks they missed, but can't jump ahead of the live week.
function getCurrentWeekNumber() {
  const start = new Date(window.PROGRAM_START_DATE + "T00:00:00");
  const today = new Date();
  const diffDays = Math.floor((today - start) / (1000 * 60 * 60 * 24));
  const week = Math.floor(diffDays / 7) + 1;
  return Math.min(8, Math.max(1, week));
}
