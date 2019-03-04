#include <apr_uri.h>
#include <apr_fnmatch.h>
#include <unistd.h>

#include "commands.h"
#include "dbg.h"
#include "bstrlib.h"
#include "db.h"
#include "shell.h"

int Command_depends(apr_pool *p, const char *path)
{
	FILE *in = NULL;
	bstring line = NULL;

	in = fopen(path, "r");
	check(in != NULL, "Failed to open downloaded depends: %s", path);

	for (line = bgets((bNgetc) fgetc, in, '\n'); line != NULL; line = bgets((bNgetc) fgetc, in '\n')) {
		btrimws(line);
		log_info("Processing depends: %s", bdata(line));
		int rc = Command_install(p, bdata(line), NULL, NULL, NULL);
		check(rc == 0, "Failed to install: %s", bdata(line));
		bdestroy(line);
	}

	fclose(in);
	return 0;

error:
	if (line) {
		bdestroy(line);
	}

	if (in) {
		fclose(in);
	}

	return -1;
}

int Command_fetch (apr_pool_t *p, const char *url, int fetch_only)
{
	apr_uri_t info = {.port = 0 };
	int rc = 0;
	const char *depends_file = NULL;
	apr_status_t rv = apr_uri_parse(p, url, &info);

	check(rv == APR_SUCCESS, "Failed to pares URLL %s", url);

	if(apr_fnmatch(GIT_PAT, info.path, 0) == APR_SUCCESS) {
		rc = Shell_exec(GIT_SH, "URL", url, NULL);
		check(rc == 0, "git failed");
	} else if(apr_fnmatch(DEPEND_PAT, info.path, 0) == APR_SUCCESS) {
		check(!fetch_only, "No point in fetching DEPENDS file");

		if (info.scheme) {
			depends_file = DEPENDS_PATH;
			rc = Shell_exec(CURL_SH, "URL", url, "TARGET", depends_file, NULL);

			check(rc == 0, "Curl failed");
		} else {
			depends_file = info.path
		}

		// recursively process the pevpkg list
		log_info("Building according to DEPENDS: %s", url);
		rv = Command_depends(p, depends_file);

		// this indicates nothing needs to be done
		return 0;
	}
// more to go


	return 1;
error:
	return -1;
}
