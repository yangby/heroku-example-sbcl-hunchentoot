#!/usr/bin/env bash
# -*- coding: utf-8; mode: Shell-script; fill-column: 76; tab-width: 4; -*-
# Brief: Start the web server.

export VIRTUAL_ROOT="$(cd `dirname $0` && pwd)/root"
export SBCL_HOME="${VIRTUAL_ROOT}/lib/sbcl"
export PATH="${VIRTUAL_ROOT}/bin:${PATH}"
export ASDF_OUTPUT_TRANSLATIONS=/:

sbcl --script web-launcher.lisp
