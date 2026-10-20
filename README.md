# 🎵 ChordFlow AI — Cloud Music Studio & Song Companion Platform

**ChordFlow AI** is a professional, cloud-connected personal music library, lyrics & chord editor, audio recognition engine, and live performance platform for musicians, worship leaders, gigging bands, and songwriters.

It fuses the best elements of **Reference A** (lyrics/chord player with integrated metronome, 12-key transposition bar, font-size zoom, smart scroll, and YouTube video embed) and **Reference B** (Spotify-style music dashboard with purple gradient hero header, mood & genre category tags, and clean track library table).

---

## 🌟 Key Features

### 1. 🎸 Personal Cloud Song Library & Dashboard
- **Spotify-Style Music Hub**: Purple-to-indigo gradient banner with quick stats, play/shuffle controls, and mood/genre tags (*Worship, Hindi, Acoustic, Peaceful, Rock*).
- **Structured Song Catalog**: Stores original key, current key, capo position, tempo (BPM), time signature, duration, cover art, and difficulty.
- **Demo Library Preloaded**: Features *"Sang Tere"* (Key of D, 120 BPM, Bridge Music India) matching Reference A, alongside classics like *"Amazing Grace"* and *"Stand By Me"*.
- **Collections & Setlists**: Group songs into custom sets (*Acoustic Sunday*, *Rehearsal Set*, *Favorites*, *Hindi Worship*).
- **Full Undo/Redo & Cloud Sync**: 30-step history stack with automatic Supabase PostgreSQL cloud sync and offline LocalStorage fallback.

### 2. 🎼 Advanced Lyrics & Chord Editor (Reference A)
- **Click-to-Place Syllable Positioning**: Position chords precisely above lyric syllables.
- **12-Key Transposition Bar**: Transpose up/down chromatically with 1 click across all 12 keys while preserving lyrics completely unaltered.
- **Audio-Synced Metronome**: Sample-accurate Web Audio API click scheduler.
- **Capo Offset Calculations**: Automatically calculates open chord fingering shapes when using a capo (e.g., *Capo 2 with G shapes sounds in Key A*).
- **Guitar Chord SVG Voicings**: Dynamic fretboard fingerings with frets, strings, barre markers, and open/muted strings.
- **Embedded YouTube Video**: Synchronized video player panel directly below song controls.

### 3. 🥁 Band Setup & Gear Notes (`/setup`)
- **Beat & Drum Presets**: Beat style (e.g. *4/4 Ambient Driving Ballad*), drum machine/software preset (e.g. *Superior Drummer 3 — Tight Kit*), and groove description.
- **Keyboard & Plugin Chains**: Hardware models (*Nord Stage 3*), patches (*Imperial Grand + Warm Analog Pad*), VST plugins (*Keyscape*, *Valhalla VintageVerb*), reverb/delay settings, and split/layer configs.
- **Arrangement Cue Sheets**: Section-by-section band entry points, dropouts, transitions, and dynamic markings (*p → mp → f → ff → p*).
- **Preset Management**: Save, duplicate, or export band gear setups for different venues or Sunday services.

### 4. 🔬 Song Analysis Studio (`/analysis`)
- **Audio File Analyzer**: Drag & drop `.mp3`, `.wav`, or `.m4a` files to decode audio waveforms and estimate BPM.
- **Live Microphone Pitch Tracker**: Autocorrelation pitch detector tracks voice/whistle frequencies in real-time, mapping Hz to musical notes (`D4`, `F#3`).
- **HTML5 Canvas Visualizer**: Real-time frequency spectrum and waveform monitors.
- **Stored vs. Detected Discrepancy Matrix**: Detects key and tempo drift between library records and recorded audio with confidence scores.
- **1-Click Reconciliation**: "Apply Detected to Song" instantly updates current key and BPM; or "Keep Stored Values" to retain existing library data.
- **BPM Click Audition**: Metronome comparison player to audition stored vs detected tempo side-by-side.
- **Gemini AI Harmonic Analysis**: Analyzes chord progressions, cadences, voice leading, and Roman numeral theory.

### 5. 🎤 Stage Live Performance Mode & BPM Scrolling
- **Mathematical BPM Scrolling Engine**:
  - Exact beat interval math: At 140 BPM, $1\text{ beat} = 60000 / 140 = 428.6\text{ ms}$.
  - Measure duration in 4/4: $1\text{ bar} = 4 \times 428.57 = 1714\text{ ms}$.
- **3 Synchronization Modes**:
  1. *BPM-Driven*: Automatic tempo progression with customizable beats assigned to each line.
  2. *Manual Tap Sync*: Real-time stage tap-tempo synchronization.
  3. *Audio Synced*: Follows recorded timestamps.
- **Hands-Free Active-Line Highlighting**: Eye-level auto-scrolling keeps current lyrics centered and highlighted.
- **Screen Wake Lock**: Prevents mobile and tablet screens from sleeping during stage performance (`navigator.wakeLock`).

### 6. 🎙️ Library-First Voice & Humming Recognition (`/identify`)
- **Strict Library-First Filter**: Searches the user's private songs first by hummed notes, sung melodies, or spoken lyrics before ever presenting external catalog options.
- **Zero Catalog Leak**: In library-only mode, unrecognized audio returns clean empty states without injecting unrelated songs.
- **Multi-Engine Audio Fingerprinting**: Integrated with ACRCloud (Query-by-Humming) and AudD APIs with clear setup alerts if credentials are missing.

---

## 🔌 API Status & Categorization Guide

During audit and deployment, live connectivity was verified against user-provided API credentials. Here is the categorized breakdown:

### A. Essential APIs (Required for Core Cloud & AI Features)
| API / Service | Key / Environment Variable | Verified Status | Purpose |
|---|---|---|---|
| **Supabase PostgreSQL & Auth** | `NEXT_PUBLIC_SUPABASE_URL`<br>`NEXT_PUBLIC_SUPABASE_ANON_KEY` | ✅ **Active** | Cloud database, Row Level Security (RLS), multi-device sync, and user authentication. |
| **Google Gemini AI** | `GEMINI_API_KEY` | ✅ **Active** (200 OK) | AI lyrics arrangement, chord theory breakdown, and harmonic progression analysis (`gemini-2.5-flash` & `gemini-1.5-flash`). |

### B. Optional APIs (Catalog Discovery & Fingerprinting)
| API / Service | Key / Environment Variable | Verified Status | Purpose |
|---|---|---|---|
| **YouTube Data API v3** | `YOUTUBE_DATA_API_KEY`<br>`YOUTUBE_API_KEY` | ✅ **Active** (200 OK) | Searching and linking official videos, lyric videos, and music videos. |
| **AudD Music Recognition** | `AUDD_API_TOKEN` | ✅ **Active** (200 OK) | Audio fingerprinting for recorded song identification. |
| **ACRCloud Recognition** | `ACRCLOUD_HOST`<br>`ACRCLOUD_ACCESS_KEY`<br>`ACRCLOUD_ACCESS_SECRET` | ⚠️ **Configured** | Query-by-Humming and audio recognition. HMAC-SHA1 signature generator active. |
| **Google Cloud Project** | `GOOGLE_CLOUD_PROJECT_ID` | ℹ️ **Optional** | Speech-to-text cloud quota. *(Web Speech API provides free browser-native speech recognition).* |

### C. Recommended Additional APIs (To Further Elevate ChordFlow AI)
1. **Spotify Web API** (`SPOTIFY_CLIENT_ID`, `SPOTIFY_CLIENT_SECRET`):
   - *Why add it*: Enables full in-app Spotify playback controls and automated setlist playlist export.
   - *Where to get*: [developer.spotify.com/dashboard](https://developer.spotify.com/dashboard)
2. **MusicBrainz / AcoustID**:
   - *Why add it*: Free, open-source audio fingerprinting and global music metadata lookup.

---

## 🧪 Automated Acceptance Test Suite (Tests A – S)

ChordFlow AI includes an automated test suite verifying all 19 functional criteria specified in Section 18:

```bash
npm test
```

### Verified Test Results (19 / 19 Tests Passed):
- **TEST A**: Account creation, sign in, and dashboard initialization.
- **TEST B**: Create and save song with lyrics and chord structures.
- **TEST C**: Persistence across page refreshes via LocalStorage & Zustand hydration.
- **TEST D**: Transpose chords while lyrics remain completely unchanged.
- **TEST E**: 140 BPM calculation ($428.6\text{ ms/beat}$, $1714\text{ ms/bar}$ in 4/4).
- **TEST F**: Assign 4 beats to a lyric line in 4/4 and verify duration.
- **TEST G**: Pause and resume scrolling without losing scroll position.
- **TEST H**: Tap-sync several lyric lines and verify timestamp persistence.
- **TEST I**: YouTube video ID extraction and Spotify streaming link persistence.
- **TEST J**: Spoken lyric search matches library song with 100% precision.
- **TEST K**: Humming recognition strictly searches user library first.
- **TEST L**: Library-only mode isolates results and avoids external catalog leak.
- **TEST M**: Band Setup record persistence (drum presets, keyboard models, cue notes).
- **TEST N**: Multi-session authentication and data hydration.
- **TEST O**: Private song isolation enforced via PostgreSQL Row Level Security (RLS).
- **TEST P**: Theme switching between Studio Dark and Light modes.
- **TEST Q**: Production deployment health check & route registration (`/setup`, `/analysis`, `/api/health`).
- **TEST R**: Missing API credentials return explicit error messages without fabricated results.
- **TEST S**: Mobile responsive layouts and PWA installation manifest.

---

## 🚀 Local Development & Production Server

### Running with Node.js
```bash
# 1. Install dependencies
npm install

# 2. Run automated test suite
npm test

# 3. Build optimized production bundle
npm run build

# 4. Start production server
npm start
```

### Windows Batch Launcher
Double-click `start-server.bat` in the project root to automatically initialize environment paths and launch the production server on `http://localhost:3000`.

### Health Check Endpoint
Query `http://localhost:3000/api/health` to inspect cloud service connectivity:
```json
{
  "status": "healthy",
  "application": "ChordFlow AI",
  "version": "2.0.0",
  "environment": "production",
  "services": {
    "supabase": true,
    "gemini": true,
    "youtube": true,
    "acrcloud": true,
    "audd": true
  }
}
```

---

## 🗄️ Database Setup (Supabase PostgreSQL)

1. Open your [Supabase Dashboard](https://supabase.com/dashboard).
2. Navigate to the **SQL Editor**.
3. Open `supabase/schema.sql` and run the script.
4. The schema automatically creates:
   - `profiles` with trigger on user sign-up
   - `songs`, `song_sections`, `chord_placements`
   - `band_setups` (Section 11 gear records)
   - `song_analyses` (Section 9 audio comparison audit records)
   - `collections`, `arrangements`, `external_links`
   - Complete multi-tenant **Row Level Security (RLS)** policies ensuring user data isolation.

---

## 🚢 Cloud Deployment (Vercel)

1. Push this repository to GitHub.
2. Link the repository on [Vercel](https://vercel.com).
3. Add the environment variables from `.env.local` in **Project Settings → Environment Variables**.
4. Click **Deploy**. Vercel will build the Next.js static pages and serverless API routes.
#   c h o r d f l o w  
 