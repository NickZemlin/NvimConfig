-- plugins/lsps/proto.lua
-- Protobuf language server (Buf) configuration.
-- Provides go-to-definition, hover, references, etc. for .proto files.
--
-- Requires the `buf` CLI (installed via Mason as the `buf` package).
-- Cross-file go-to-definition (e.g. on imported types like
-- `hotelscommon.v1.Image`) relies on Buf resolving import paths, which
-- normally comes from a `buf.yaml` / `buf.work.yaml` in the workspace root.

vim.lsp.config("buf_ls", {})
vim.lsp.enable("buf_ls")
