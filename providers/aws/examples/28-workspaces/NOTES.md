# Terraform Workspaces

## Purpose
Terraform workspaces are primarily used for testing and managing multiple environments within the same configuration.

## Workspace Commands

```sh
# Show the current workspace
tf workspace show

# List all available workspaces
tf workspace list

# Create a new workspace and switch to it
tf workspace new <name>

# Select a specific workspace
tf workspace select <name>

# Delete a specific workspace
tf workspace delete <name>
```

## Understanding Terraform Workspaces
- When you create a new workspace, Terraform creates an environment in the state file (`.tfstate`) to manage workspace-specific resources.
- You can retrieve the name of the current workspace using:

```hcl
${terraform.workspace}
```

## Deleting a Workspace
### Important Considerations
- You **cannot** delete the workspace you are currently using. You must first switch to another workspace before deletion.
- If the workspace contains deployed resources, Terraform will notify you that you must destroy the infrastructure before deletion.

### Steps to Delete a Workspace
1. Destroy all deployed resources in the workspace.
2. Switch to a different workspace (e.g., `default`).
3. Delete the target workspace.

```sh
# Switch to the default workspace
tf workspace select default

# Delete the target workspace
tf workspace delete <name>
```

If you force delete a workspace with existing resources:
```sh
tf workspace delete test -force
```
Terraform will delete the workspace, but the resources will still exist, potentially leading to orphaned infrastructure.

---