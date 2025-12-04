# GitHub Setup Guide

This guide will help you share your WGS pipeline on GitHub.

## Step 1: Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. Choose a repository name (e.g., `wgs-pipeline` or `whole-genome-sequencing-pipeline`)
5. Add a description (optional): "Pipeline for shallow Whole Genome Sequencing analysis"
6. Choose visibility (Public or Private)
7. **DO NOT** initialize with README, .gitignore, or license (we already have these)
8. Click "Create repository"

## Step 2: Add Files to Git

Run these commands in your terminal:

```bash
# Navigate to your scripts directory
cd "/Users/asadr/Library/CloudStorage/OneDrive-TheInstituteofCancerResearch/PCE Lab/Manuscript/Manuscript_1/Nature Comms/Data availability/Raw Data and Code/Whole Genome Sequencing/Scripts"

# Add all files to git
git add .

# Check what will be committed
git status

# Commit the files
git commit -m "Initial commit: WGS analysis pipeline"
```

## Step 3: Connect to GitHub and Push

After creating your repository on GitHub, GitHub will show you commands. Use these (replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your actual values):

```bash
# Add the remote repository (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Rename default branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 4: Verify Upload

1. Go to your GitHub repository page
2. Verify all files are present:
   - README.md
   - .gitignore
   - All shell scripts (*.sh)
   - QDNAseq_Analysis.R
   - Whole Genome Sequencing Analysis Pipeline.md

## Important Notes

### Before Pushing

1. **Review your scripts**: Make sure no sensitive information (passwords, API keys, patient data paths) is included
2. **Update paths**: Consider making paths configurable or clearly documenting them in README
3. **Check .gitignore**: Ensure sensitive data files are excluded

### Making Future Updates

When you make changes to your pipeline:

```bash
# Stage changes
git add .

# Commit changes
git commit -m "Description of your changes"

# Push to GitHub
git push
```

### Making Scripts More Shareable (Optional)

Consider creating a `config.sh` file for user-specific paths:

```bash
# config.sh
export PARENT_DIR=/path/to/your/data
export REF_GENOME=/path/to/reference/genome.fasta
export OUTPUT_DIR=/path/to/output
```

Then source it in your scripts:
```bash
source config.sh
```

**Note**: Add `config.sh` to `.gitignore` if it contains sensitive paths, and provide a `config.sh.example` template instead.

## Troubleshooting

### Authentication Issues

If you encounter authentication errors:
- Use GitHub Personal Access Token instead of password
- Or set up SSH keys: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

### Large Files

If you have large files (>100MB), consider:
- Using Git LFS: `git lfs install` and `git lfs track "*.bam"`
- Or excluding them via .gitignore (already done)

### Updating README

Remember to update the README.md with:
- Your actual GitHub repository URL
- Your contact information
- Your manuscript citation
- License information

