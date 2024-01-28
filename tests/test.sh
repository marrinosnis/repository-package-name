#!/bin/bash

pathToFolder=$1
owner=$2
token=$3
expectedPackageName=$4

function oneTimeSetUp() {
    script="./findRepoPackageName.sh"
}

function testNoArgumentsProvide() {
    assertEquals "$($script "$pathToFolder")" "You should provide the owner of the repo and the token with the correct access rights"
}

function testOnlyTheNameOfOwnerIsProvided() {
    assertEquals "$($script "$pathToFolder" "$owner")" "You should provide also the token as the second argument"
}

function testExpectedNameOfPackage() {
    assertEquals "$("$script" "$pathToFolder" "$owner" "$token")" "$expectedPackageName"
}

shift $#

source shunit2