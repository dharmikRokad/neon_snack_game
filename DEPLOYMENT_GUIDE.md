# 🎮 How to Share Your Neon Snake Game

## ✅ Build Completed!
Your web game has been built and is ready to deploy in the `build/web` folder.

## 🚀 Deployment Options

### **Option 1: GitHub Pages (Recommended - FREE & Easy)**

#### Prerequisites:
- A GitHub account
- Git installed on your computer

#### Steps:

1. **Initialize Git Repository** (if not already done):
   ```bash
   cd /Users/mac4/Desktop/Dahrmik/experiments/snake_game_flame
   git init
   git add .
   git commit -m "Initial commit - Neon Snake Game"
   ```

2. **Create a GitHub Repository**:
   - Go to https://github.com/new
   - Name it: `neon-snake-game` (or any name you like)
   - Don't initialize with README
   - Click "Create repository"

3. **Push Your Code**:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/neon-snake-game.git
   git branch -M main
   git push -u origin main
   ```

4. **Deploy to GitHub Pages**:
   ```bash
   # Install gh-pages Node package globally
   npm install -g gh-pages
   
   # Deploy the build/web folder
   gh-pages -d build/web
   ```

5. **Enable GitHub Pages**:
   - Go to your repo settings on GitHub
   - Navigate to "Pages" section
   - Source: Select "gh-pages" branch
   - Save

6. **Your game will be live at**:
   ```
   https://YOUR_USERNAME.github.io/neon-snake-game/
   ```

---

### **Option 2: Firebase Hosting (FREE & Fast)**

#### Prerequisites:
- Firebase account (Google account)
- Firebase CLI installed

#### Steps:

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project**:
   ```bash
   cd /Users/mac4/Desktop/Dahrmik/experiments/snake_game_flame
   firebase init hosting
   ```
   - Select "Create a new project" or use existing
   - Set public directory to: `build/web`
   - Configure as single-page app: Yes
   - Don't overwrite index.html

4. **Deploy**:
   ```bash
   firebase deploy
   ```

5. **Your game will be live at**:
   ```
   https://YOUR-PROJECT-ID.web.app
   ```

---

### **Option 3: Netlify (FREE & Drag & Drop)**

#### Easiest Method - No Command Line:

1. Go to https://app.netlify.com/drop
2. Drag and drop your `build/web` folder
3. Your game is instantly live!
4. Netlify gives you a URL like: `https://random-name-12345.netlify.app`
5. You can customize the URL in settings

---

### **Option 4: Vercel (FREE & Fast)**

1. Go to https://vercel.com
2. Sign up/login
3. Click "New Project"
4. Import your GitHub repository (or upload `build/web` folder)
5. Deploy!

---

## 📱 Sharing Your Game

Once deployed, just share the URL with your friends:
- Copy the deployment URL
- Share via WhatsApp, Discord, email, etc.
- They can play directly in their browser (mobile or desktop)

## 🔄 Updating Your Game

When you make changes:

1. **Rebuild**:
   ```bash
   flutter build web --release --base-href "/neon_snack_game/"
   ```

2. **Redeploy**:
   - **GitHub Pages**: `gh-pages -d build/web`
   - **Firebase**: `firebase deploy`
   - **Netlify**: Drag & drop new `build/web` folder
   - **Vercel**: Push to GitHub (auto-deploys)

## 💡 Pro Tips

### Make it Better:
- **Custom Domain**: Buy a domain (like `neonsnake.games`) and connect it
- **PWA**: Your game already works as a Progressive Web App (can be installed on phones!)
- **Analytics**: Add Google Analytics to see how many people play
- **High Scores**: Add a global leaderboard with Firebase

### SEO & Sharing:
Your game already has good meta tags for social sharing. When someone shares your link, it will look professional on social media!

## 🎯 Quick Start Command

If you just want the fastest deployment, run:
```bash
# Option 1: Quick GitHub Pages
git init
git add .
git commit -m "Neon Snake Game"
# Then create repo on GitHub and push

# Option 2: Quick Netlify (after installing CLI)
npx netlify-cli deploy --prod --dir=build/web
```

---

## ❓ Need Help?

- Can't access the game? Check browser console for errors
- Blank page? Make sure `--base-href` matches your deployment path
- Assets not loading? Check your hosting service's configuration

**Note**: The game requires a modern browser with WebGL support. Works on all major browsers (Chrome, Firefox, Safari, Edge).
