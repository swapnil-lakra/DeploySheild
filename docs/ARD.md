Date - 11/06/2026
# 1. Code Repository Decision making 

### | Gitlab | Bitcucket | Github |

### Decision

GitHub was selected as the source code management and collaboration platform for this project.

### Rationale

GitHub provides the largest developer ecosystem, mature collaboration workflows, native CI/CD capabilities through GitHub Actions, and strong integration with the modern cloud-native tooling stack. It also serves as an industry-standard platform, reducing onboarding friction for contributors and increasing project visibility.

### Trade-offs Accepted

By choosing GitHub, the project accepts the following trade-offs:

* Reduced self-hosting flexibility compared to GitLab's self-managed offerings.
* Less tightly coupled integration with the Atlassian ecosystem compared to Bitbucket.
* Dependence on GitHub-specific services such as GitHub Actions and repository workflows.
* Some advanced enterprise governance and compliance features available in GitLab may require additional configuration or paid GitHub plans.

### Consequences

The decision enables faster collaboration, simpler CI/CD implementation, better community accessibility, and stronger portfolio visibility. The accepted trade-offs are considered acceptable because the project prioritizes developer productivity, industry-standard workflows, and ease of adoption over deep self-hosting customization or Atlassian-centric integrations.

---

# 2. CI/CD Pipleline Decision Making

### | Github Actions | Gitlab CI/CD | Bitbucket Pipelines | Jenkins CI/CD |

### Decision

GitHub Actions was selected as the CI/CD platform for this project.

### Rationale

GitHub Actions provides native integration with GitHub repositories, event-driven workflows, a large marketplace of reusable actions, and simplified CI/CD setup with minimal operational overhead. It enables rapid implementation of automated testing, security scanning, infrastructure provisioning, and deployment pipelines directly within the source control platform.

### Trade-offs Accepted

By choosing GitHub Actions, the project accepts the following trade-offs:

* Reduced pipeline customization and extensibility compared to Jenkins' plugin-driven ecosystem.
* Less mature enterprise-grade CI/CD capabilities than GitLab CI/CD for highly complex deployment workflows.
* Increased dependence on the GitHub ecosystem and GitHub-hosted services.
* Limited control over managed runners compared to fully self-hosted Jenkins environments.
* Potential scaling and execution cost constraints for large-volume build and deployment workloads.

### Consequences

This decision reduces operational complexity, accelerates CI/CD implementation, and improves maintainability by consolidating source control and automation within a single platform. The accepted trade-offs are considered reasonable because the project prioritizes simplicity, rapid delivery, lower maintenance overhead, and developer productivity over maximum customization and self-managed infrastructure control.

---

# 3. Containerization tool Decision Making

### | Docker | Podman | Buildah | Kaniko |

### Decision

Docker was selected as the containerization platform for this project.

### Rationale

Docker provides the most mature container ecosystem, extensive community support, broad industry adoption, and seamless integration with modern CI/CD platforms, cloud providers, and container orchestration systems. Its standardized image format, developer-friendly tooling, and large ecosystem of pre-built images accelerate application packaging, testing, and deployment workflows.

### Trade-offs Accepted

By choosing Docker, the project accepts the following trade-offs:

* Higher resource overhead compared to daemonless container tools such as Podman and Buildah.
* Dependence on the Docker daemon architecture, which introduces an additional service layer to manage.
* Larger attack surface compared to rootless container runtimes.
* Less flexibility for specialized image-building workflows where Buildah or Kaniko may provide finer control.
* Potential vendor dependency on Docker-specific tooling and workflows within the development lifecycle.

### Consequences

This decision enables faster developer onboarding, consistent local and CI/CD environments, simplified container image management, and broad compatibility across cloud-native platforms. The accepted trade-offs are considered acceptable because the project prioritizes ecosystem maturity, operational simplicity, portability, and industry-standard workflows over daemonless execution models and highly specialized container build processes.

# 4. Central Image registry Decision Making #1

### | Cloud Provider Native Registries (ECR, GCR, ACR) | Git & SaaS Integrated Registries (GitHub Container Registry, GitLab Container Registry, Bitbucket Container Registry) | Public & Universal Registries (Docker Hub, Quay.io) | 

### Decision

Amazon Elastic Container Registry (ECR) was selected as the container image registry for this project.

### Rationale

Amazon ECR provides native integration with the AWS ecosystem, including ECS, EKS, Lambda, IAM, CloudTrail, and AWS security services. Since the project's infrastructure is deployed on AWS, ECR simplifies container image storage, authentication, access control, and deployment workflows while reducing operational complexity. The service also provides high availability, managed scalability, vulnerability scanning, and seamless integration with the CI/CD pipeline.

### Trade-offs Accepted

By choosing Amazon ECR, the project accepts the following trade-offs:

* Increased dependency on the AWS ecosystem compared to cloud-agnostic registries such as Docker Hub or Quay.io.
* Reduced portability if future migration to another cloud provider becomes necessary.
* Potentially higher long-term storage and data transfer costs compared to some public registry solutions.
* Less platform neutrality than GitHub Container Registry or GitLab Container Registry.
* Reliance on AWS IAM and AWS-specific authentication mechanisms rather than universally supported registry authentication workflows.

### Consequences

This decision simplifies operational management, improves security through centralized IAM-based access control, and enables tighter integration with AWS-native deployment services. The accepted trade-offs are considered acceptable because the project prioritizes operational efficiency, security, and seamless AWS integration over multi-cloud portability and platform-independent registry management.

### Justification for Choosing ECR
The project is already AWS-native; therefore, optimizing for operational simplicity, security, and ecosystem integration provides greater value than maintaining cloud-agnostic container registry portability.

Date - 14/06/2026

Date - 15/06/2026

# 5. Central Image registry Decision Making #2

### | GHCR (GitHub Container Registory) | Docker Hub | GitLab Container Registory |

### Decision

GitHub Container Registry (GHCR) was selected as the container image registry for this project.

### Rationale

GHCR provides seamless integration with the existing GitHub-based development workflow while eliminating the need for additional registry accounts and credential management. Authentication can be handled using GitHub Personal Access Tokens (PATs), simplifying operational setup and developer onboarding.

The registry also offers free storage and distribution for public container images, making it a cost-effective solution for open-source and portfolio projects. Since the source code, CI/CD workflows, and container images are all managed within the GitHub ecosystem, GHCR reduces operational complexity and streamlines the software delivery process.

### Trade-offs Accepted

By choosing GHCR, the project accepts the following trade-offs:

* Increased dependency on the GitHub ecosystem compared to registry-agnostic solutions.
* Less cloud-native integration than provider-managed registries such as Amazon ECR, Google Artifact Registry, or Azure Container Registry.
* Fewer enterprise governance and compliance capabilities compared to some dedicated container registry platforms.
* Reduced flexibility if the project is migrated away from GitHub in the future.
* Potential limitations in advanced registry features available in specialized enterprise container registries.

### Consequences

This decision simplifies container image management by consolidating source control, CI/CD pipelines, and container artifacts within a single platform. It reduces operational overhead, eliminates additional registry administration requirements, and minimizes infrastructure costs for public container images. The accepted trade-offs are considered acceptable because the project prioritizes simplicity, developer productivity, cost efficiency, and seamless integration with the existing GitHub-based development workflow.

Date - 20/06/2026

# 6. Load Balancer Decision Making

### Nginx | HAProxy | Trafik | Caddy | Envoy

### Decision

Nginx was selected as the reverse proxy and traffic routing solution for this project.

### Rationale

The application is deployed on a resource-constrained EC2 instance with only 1 GB of memory, where multiple services including Next.js, FastAPI, MySQL, and supporting infrastructure components run simultaneously. Under these constraints, minimizing memory and CPU consumption is a critical architectural requirement.

Nginx was selected because it provides a lightweight, high-performance reverse proxy capable of efficiently routing traffic between frontend and backend services while maintaining a minimal resource footprint. It also offers mature support for HTTP proxying, load balancing, SSL termination, health checks, and blue-green deployment traffic switching without introducing significant operational overhead.

### Trade-offs Accepted

By choosing Nginx, the project accepts the following trade-offs:

* Less dynamic service discovery and automatic configuration compared to Traefik.
* Fewer advanced Layer 7 traffic management capabilities than Envoy.
* Reduced observability and service mesh integration features compared to Envoy-based architectures.
* Less specialized load-balancing functionality than HAProxy for highly complex traffic-routing scenarios.
* More manual configuration management compared to modern auto-discovery reverse proxies.

### Consequences

This decision minimizes infrastructure resource consumption while providing reliable reverse proxy and traffic routing capabilities. The lightweight footprint helps preserve memory and CPU resources for core application services, reducing the risk of resource exhaustion on the 1 GB EC2 instance. Although advanced traffic management and service discovery capabilities are sacrificed, the selected solution adequately satisfies the project's current scalability, deployment, and operational requirements while maintaining architectural simplicity.


