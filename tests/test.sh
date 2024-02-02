#!/bin/bash

pathToFolder=$1
owner=$2
token=$3
expectedPackageName=$4

function oneTimeSetUp() {
    script="./findRepoPackageName.sh"
}

function testNoArgumentsProvide() {
    assertEquals "$($script)" "You should provide the path, the owner of the repo and the token with the correct access rights"
}

function testOnlyThePathIsProvided() {
    assertEquals "$($script "$pathToFolder")" "You should provide the owner as the second argument and the token as the third argument"
}

function testPathAndNameOfOwnerAreProvided() {
    assertEquals "$($script "$pathToFolder" "$owner")" "You should provide the token with the correct access rigths as the third argument"
}

function testExpectedNameOfPackage() {
    assertEquals "$("$script" "$pathToFolder" "$owner" "$token")" "$expectedPackageName"
}

shift $#

source shunit2