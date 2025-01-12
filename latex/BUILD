load("@rules_python//python:py_binary.bzl", "py_binary")
load(":latex.bzl", "latex_toolchain")

exports_files([
  "detex.json",
  "detex.py",
  "git_stamp.bzl",
  "git_stamp.tpl",
  "latex.bzl",
  "latex.py",
  "ref_test.bzl",
  "repo.bzl",
  "role_call_test.bzl",
  "spelling.tex",
])

py_binary(
    name = "ref_test_py",
    srcs = ["ref_test.py"],
    main = "ref_test.py",
)

py_binary(
    name = "role_call_py",
    srcs = ["role_call.py"],
    main = "role_call.py",
)

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

latex_toolchain(
    name = "linux_local_texlive_toolchain",
    pdflatex = "/usr/bin/pdflatex",
    detex = "/usr/bin/detex",
)

toolchain(
    name = "linux_texlive",
    # Blindly asssume this is avalable if registered.
    # exec_compatible_with = ["@platforms//os:linux"], # TODO Would this be more correct?
    target_compatible_with = [], # Output is OS/CPU agnostic
    toolchain = ":linux_local_texlive_toolchain",
    toolchain_type = ":toolchain_type",
)
