# iridium

[![Build Status](https://secure.travis-ci.org/lspitzner/iridium.svg)](http://travis-ci.org/lspitzner/iridium)
[![Hackage](https://img.shields.io/hackage/v/iridium.svg)](https://hackage.haskell.org/package/iridium)

# Introduction

iridium is a fancy wrapper around `cabal upload`. It aims to automate
several typical steps when releasing a new package version to hackage.

Steps currently include:

- Compilation and running tests using multiple compiler versions.
  (the different compilers must already be installed.)

- Checking that the changelog mentions the latest version.

- Checking that the upper bounds of dependencies
  are up-to-date by making use of stackage snapshots.

- Uploading of both the package itself and the documentation.

iridium does all testing locally, in contrast to e.g. github's travis. 

The output on errors is certainly not optimal; for example the stackage
upper bound checking will print a typical, hard-to-consume cabal hell error
message. iridium's aim is only to note _if_ something is wrong.

# Usage

Install iridium, run iridium in the directory containing the cabal package.
It won't do anything without confirmation.

~~~~
$ iridium
Checking compilation with different compiler versions
  Checking with compiler ghc-7.8.4:                                   clear.
Checking upper bounds using stackage:                                 clear.
Checking documentation:                                               clear.
Checking basic compilation:                                           clear.
Checking that all dependencies have a lower bound:                    clear.
Checking that all dependencies have an upper bound:                   clear.
Checking package validity:                                            clear.
Testing the source distribution package:                              clear.
Testing if the changelog mentions the latest version:                 clear.
Comparing local version to hackage version:                           clear.
[git]
  Testing for uncommitted changes:                                    clear.
Summary:
  Package:                iridium
  Version:                0.1.5.1
  Warning count:          0
  Error   count:          0
  Not -Wall clean:        []
  [git]
    Branch:               master
  Actions:                Tag the current commit with "0.1.5.1"
                          Push current branch and tag to upstream repo
                          Upload package
                          Upload documentation
> Continue [y]es [n]o? > y
Performing upload..
Building source dist for iridium-0.1.2.0...
Preprocessing library iridium-0.1.2.0...
Preprocessing executable 'iridium' for iridium-0.1.2.0...
Source tarball created: dist/iridium-0.1.2.0.tar.gz
Hackage password:
Uploading dist/iridium-0.1.2.0.tar.gz...
Ok
Upload successful.
Performing doc upload..
[.. some haddock spam ..]
Documentation tarball created: dist/iridium-0.1.2.0-docs.tar.gz
Hackage password:
Uploading documentation dist/iridium-0.1.2.0-docs.tar.gz...
Ok
Documentation upload successful.
$
~~~~

# Configuration

An `iridium.yaml` file will be created on first invocation.

# Tests

| Test | Description |
| --- | --- |
| hlint | `forM_ hs-source-dirs $ \dir -> (\dir -> call "hlint " ++ dir)` |
| testsuites | run `cabal test` when compiling. |
| upper-bounds-stackage | Check that upper bounds are up-to-date by using a stackage cabal.config. This is not the best way, because not all packages are on stackage, but it is better than nothing. |
| lower-bounds-exist | Check that all dependencies have a lower bound. |
| upper-bounds-exist | Check that all dependencies have an upper bound. (You _do_ want to conform with the PVP, right?) |
| documentation | Check that haddocks can be created without problems (calling `cabal haddock`). |
| changelog | Check if the changelog mentions (contains) the latest version. |
| package-sdist | Check that all necessary stuff is contained in the source distribution by installing the packaged package. |
| compiler-versions | Compile and run tests for several compiler versions (other than the default compiler on $PATH). |
