
# Post RSS Feeds in IRC




#### setting clon

```bash
export PATH="$HOME/.rbenv/bin:$PATH"

*/5 * * * * /bin/bash -c 'eval "$(rbenv init -)"; cd /path/to/; ruby feeds.rb;'
```




