FROM squidfunk/mkdocs-material:8.5.10

# Copy project files to the new image.
COPY . .

# Install Caddy web server.
RUN apk add --no-cache caddy

# Install MkDocs plugins and dependencies.
RUN pip install --no-cache-dir \
      "mkdocs-minify-plugin" \
      "mkdocs-redirects" \
      "mkdocs-section-index" \
      "mkdocs-autolinks-plugin" \
      "mkdocs-tooltips" \
      "mkdocs-img2fig-plugin" \
      "pillow" \
      "cairosvg";

# Build MkDocs site with the mkdocs CLI tool.
RUN mkdocs build

# Expose MkDocs development server port
EXPOSE 8000

# Set working directory
WORKDIR /docs

# Start development server by default
ENTRYPOINT ["caddy", "run"]
