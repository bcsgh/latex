<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Bazle/skylark rule(s) to process LaTeX.

## `MODULE.bazel`

```
bazel_dep(
    name = "com_github_bcsgh_latex_rules",
    version = ...,
)
```

And either:

```
# Use ctx.which to look things up.
latex_toolchain_repository = use_repo_rule("@com_github_bcsgh_latex_rules//latex:repo.bzl", "latex_toolchain_repository")
latex_toolchain_repository(name="local_latex_toolchain")
register_toolchains("@local_latex_toolchain//:local_latex")
```

Or:

```
# Blindly assumes default paths
register_toolchains("@com_github_bcsgh_latex_rules//latex:linux_texlive")
```

<a id="latex_toolchain_repository"></a>

## latex_toolchain_repository

<pre>
load("@com_github_bcsgh_latex_rules//latex:repo.bzl", "latex_toolchain_repository")

latex_toolchain_repository(<a href="#latex_toolchain_repository-name">name</a>, <a href="#latex_toolchain_repository-repo_mapping">repo_mapping</a>)
</pre>

Build a @com_github_bcsgh_latex_rules//latex:toolchain_type based on the current PATH.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="latex_toolchain_repository-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="latex_toolchain_repository-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |


<a id="detex"></a>

## detex

<pre>
load("@com_github_bcsgh_latex_rules//latex:latex.bzl", "detex")

detex(<a href="#detex-name">name</a>, <a href="#detex-src">src</a>, <a href="#detex-out">out</a>, <a href="#detex-post_sed">post_sed</a>, <a href="#detex-process">process</a>)
</pre>

Process a .tex file into a text file that approximates the text from the input.

This can be usefull as a pre-processing step for tests like spell checking.
Note, the input doesn't need to be a complete tex document.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="detex-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="detex-src"></a>src |  The root source file.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="detex-out"></a>out |  The output file name.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="detex-post_sed"></a>post_sed |  Depricated, prefer process. A sed script applied to remove or process custom markup.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="detex-process"></a>process |  A JSON file of rule to apply to the .tex file before passing to detex. The expected format is: [{"re":"...","sub":"..."},...]   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |


<a id="latex_toolchain"></a>

## latex_toolchain

<pre>
load("@com_github_bcsgh_latex_rules//latex:latex.bzl", "latex_toolchain")

latex_toolchain(<a href="#latex_toolchain-name">name</a>, <a href="#latex_toolchain-detex">detex</a>, <a href="#latex_toolchain-pdflatex">pdflatex</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="latex_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="latex_toolchain-detex"></a>detex |  -   | String | required |  |
| <a id="latex_toolchain-pdflatex"></a>pdflatex |  -   | String | required |  |


<a id="tex_to_pdf"></a>

## tex_to_pdf

<pre>
load("@com_github_bcsgh_latex_rules//latex:latex.bzl", "tex_to_pdf")

tex_to_pdf(<a href="#tex_to_pdf-name">name</a>, <a href="#tex_to_pdf-src">src</a>, <a href="#tex_to_pdf-data">data</a>, <a href="#tex_to_pdf-outs">outs</a>, <a href="#tex_to_pdf-debug_internals">debug_internals</a>, <a href="#tex_to_pdf-extra_outs">extra_outs</a>, <a href="#tex_to_pdf-jobname">jobname</a>, <a href="#tex_to_pdf-pdf">pdf</a>, <a href="#tex_to_pdf-reprocess">reprocess</a>,
           <a href="#tex_to_pdf-reprocess_tools">reprocess_tools</a>, <a href="#tex_to_pdf-runs">runs</a>, <a href="#tex_to_pdf-wrap_width">wrap_width</a>)
</pre>

Process a .tex file into a .pdf file.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="tex_to_pdf-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="tex_to_pdf-src"></a>src |  The root source file.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="tex_to_pdf-data"></a>data |  Other input files needed by pdflatex.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="tex_to_pdf-outs"></a>outs |  Arbitrary aditional filenames to include in the result set.   | List of labels | optional |  `[]`  |
| <a id="tex_to_pdf-debug_internals"></a>debug_internals |  Dump more of what's going on. This will make the rule always generate output even on success. NOT recomended as a regular thing.   | Boolean | optional |  `False`  |
| <a id="tex_to_pdf-extra_outs"></a>extra_outs |  DEPRECATED: Aditional filename extention to include in the result set.   | List of strings | optional |  `[]`  |
| <a id="tex_to_pdf-jobname"></a>jobname |  The value for \jobname.   | String | optional |  `""`  |
| <a id="tex_to_pdf-pdf"></a>pdf |  The output file name.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="tex_to_pdf-reprocess"></a>reprocess |  Extra shell commands to run between invocation of pdflatex.   | List of strings | optional |  `[]`  |
| <a id="tex_to_pdf-reprocess_tools"></a>reprocess_tools |  Other input files needed by the reprocessing steps.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="tex_to_pdf-runs"></a>runs |  How many times to run. (Yes, re-running latex mutiple times is still a thing.)   | Integer | optional |  `2`  |
| <a id="tex_to_pdf-wrap_width"></a>wrap_width |  Wrap log output lines width. 0 'disables' wrapping.   | Integer | optional |  `0`  |


<a id="git_stamp"></a>

## git_stamp

<pre>
load("@com_github_bcsgh_latex_rules//latex:git_stamp.bzl", "git_stamp")

git_stamp(<a href="#git_stamp-name">name</a>, <a href="#git_stamp-tex">tex</a>)
</pre>

Generate a .tex file defining the command \GitCommit to give the current git commit hash.

Note: for this to work the WORKSPACE must include a few repositories:

  load("//latex:git_stamp_deps.bzl", git_stamp_deps = "get_deps")
  git_stamp_deps()

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="git_stamp-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="git_stamp-tex"></a>tex |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |


<a id="LaTeXInfo"></a>

## LaTeXInfo

<pre>
load("@com_github_bcsgh_latex_rules//latex:latex.bzl", "LaTeXInfo")

LaTeXInfo(<a href="#LaTeXInfo-pdflatex">pdflatex</a>, <a href="#LaTeXInfo-detex">detex</a>)
</pre>

Information about how to invoke LaTeX tools.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="LaTeXInfo-pdflatex"></a>pdflatex |  -    |
| <a id="LaTeXInfo-detex"></a>detex |  -    |


<a id="latex_ref_test"></a>

## latex_ref_test

<pre>
load("@com_github_bcsgh_latex_rules//latex:ref_test.bzl", "latex_ref_test")

latex_ref_test(<a href="#latex_ref_test-name">name</a>, <a href="#latex_ref_test-src">src</a>, <a href="#latex_ref_test-externs">externs</a>, <a href="#latex_ref_test-ignore_dups">ignore_dups</a>)
</pre>

Test for missing label references.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="latex_ref_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="latex_ref_test-src"></a>src |  The tex_to_pdf to get the .log and .aux files from.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="latex_ref_test-externs"></a>externs |  Lables to ignore missing refernces to.   | List of strings | optional |  `[]`  |
| <a id="latex_ref_test-ignore_dups"></a>ignore_dups |  Suppress check for duplicate labels.   | Boolean | optional |  `False`  |


<a id="role_call_test"></a>

## role_call_test

<pre>
load("@com_github_bcsgh_latex_rules//latex:role_call_test.bzl", "role_call_test")

role_call_test(<a href="#role_call_test-name">name</a>, <a href="#role_call_test-extra">extra</a>, <a href="#role_call_test-ignore_re">ignore_re</a>, <a href="#role_call_test-inputs">inputs</a>, <a href="#role_call_test-root">root</a>)
</pre>

Test that the expected inputs exist and are used.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="role_call_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="role_call_test-extra"></a>extra |  Files that might be read but aren't tested for.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="role_call_test-ignore_re"></a>ignore_re |  Patterns to ignore as input arguments. (Uses python regex syntax.)   | List of strings | optional |  `[]`  |
| <a id="role_call_test-inputs"></a>inputs |  The files that should be reachable and can be used.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="role_call_test-root"></a>root |  The root file that the inputs should be reachable from.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


## Setup (for development)
To configure the git hooks, run `./.git_hooks/setup.sh`
