# Mixed AWS Providers in Terraform

This project demonstrates the usage of both standard AWS provider and AWS Cloud Control (AWSCC) provider. Here are important considerations and differences between these providers.

## Important Considerations When Using Mixed Providers

### 1. Resource Dependencies
- Resources created by different providers can reference each other, but this creates implicit dependencies
- When destroying infrastructure, ensure proper destruction order to avoid dependency conflicts
- Consider using `depends_on` for explicit dependency management

### 2. State Management
- Both providers store state in the same Terraform state file
- However, they use different internal formats for resource representation
- Be cautious when moving resources between providers as it may require state manipulation

### 3. Resource Deletion
- When resources from different providers depend on each other, deletion order becomes critical
- Always remove dependent resources first before removing their dependencies
- Consider using `lifecycle` rules to handle deletion order

## Differences Between AWS and AWSCC Providers

### Standard AWS Provider
- Uses traditional AWS API
- More mature and widely used
- Supports all AWS services
- Resource attributes follow AWS API naming conventions
- Tags are managed as key-value maps
- More flexible and feature-rich
- Better documentation and community support

### AWS Cloud Control (AWSCC) Provider
- Uses AWS Cloud Control API
- Newer implementation
- Limited to services supported by Cloud Control API
- Different attribute naming conventions
- Tags require specific format (list of key-value pairs)
- More consistent across different AWS services
- Faster support for new AWS features
- More standardized approach to resource management

## Best Practices
1. Use single provider type for related resources when possible
2. Document dependencies between resources from different providers
3. Test destruction order in non-production environment first
4. Keep track of which provider is used for each resource
5. Consider migration strategy if moving between providers

## Example in This Project
This project uses:
- AWSCC provider for Security Group creation
- Both providers for EC2 instances
- Demonstrates cross-provider resource references
- Shows different tag formatting requirements

Remember to handle these resources carefully, especially during infrastructure updates or deletion.