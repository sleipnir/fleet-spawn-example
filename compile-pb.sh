#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

protoc --elixir_out=gen_descriptors=true:./lib/fleet/domain --proto_path=priv/protos/fleet priv/protos/fleet/geometry.proto
protoc --elixir_out=gen_descriptors=true:./lib/fleet/domain --proto_path=priv/protos/fleet priv/protos/fleet/delivery.proto
protoc --elixir_out=gen_descriptors=true:./lib/fleet/domain --proto_path=priv/protos/fleet priv/protos/fleet/driver.proto
protoc --elixir_out=gen_descriptors=true:./lib/fleet/domain --proto_path=priv/protos/fleet priv/protos/fleet/offer.proto
protoc --elixir_out=gen_descriptors=true:./lib/fleet/domain --proto_path=priv/protos/fleet priv/protos/fleet/brain.proto
