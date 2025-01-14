# Copyright (c) 2023, Benjamin Shropshire,
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

load("@bazel_skylib//lib:unittest.bzl", "asserts", "analysistest")
load("@bazel_skylib//lib:sets.bzl", "sets")
load("@com_github_bcsgh_fail_test//fail_test:fail_test.bzl", "fail_test")
load("//latex:role_call_test.bzl", "role_call_test")

##### SUCCESS case

def _role_call_test_contents_test_impl(ctx):
    env = analysistest.begin(ctx)

    target_under_test = analysistest.target_under_test(env)
    asserts.set_equals(env,
        sets.make(["role_call_test_pass_test.sh"]),
        sets.make([f.basename for f in target_under_test[DefaultInfo].files.to_list()]))
    return analysistest.end(env)

role_call_test_contents_test = analysistest.make(_role_call_test_contents_test_impl)

##### Go

def role_call_test_suite(name):
    # Success
    role_call_test(
        name = "role_call_test_pass_test",
        root = "gen_latex_test.tex",
        inputs = [
            "//latex:spelling.tex",
            ":fixed.tex",
        ],
        extra = [":git_stamp.tex"],
    )

    role_call_test_contents_test(
        name = "role_call_test_contents_test",
        target_under_test = ":role_call_test_pass_test",
    )

    # Failure
    role_call_test(
        name = "role_call_test_fail_test",
        root = "gen_latex_test.tex",
        inputs = [
            ":ref_error.tex",
            "loop.tex",
        ],
        tags = ["manual"],
    )

    fail_test(
        name = "role_call_test_failure_test",
        msgs = [
            "Missing \\input{tests/ref_error}",
            "Missing file latex/spelling.tex",
            "Missing file tests/git_stamp.tex",
            "Missing file tests/fixed.tex",
            "tests/loop unreachable from root (tests/gen_latex_test.tex)",
            "Found cycle(s) in \\input{}s.\nFiles include:\ntests/loop.tex",
        ],
        test = ":role_call_test_fail_test",
    )

    # Suit
    native.test_suite(
        name = name,
        tests = [
            ":role_call_test_contents_test",
            ":role_call_test_failure_test",
            ":role_call_test_pass_test",
        ],
    )
