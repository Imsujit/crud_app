<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Error | MVC Registry</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .error-container { margin-top: 80px; max-width: 700px; }
        .card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .error-icon { font-size: 4rem; color: #dc3545; margin-bottom: 20px; }
        .stack-trace {
            background-color: #212529;
            color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.85rem;
            max-height: 200px;
            overflow-y: auto;
        }
    </style>
</head>
<body>

<div class="container error-container text-center">
<jsp:include page="header.jsp" />
    <div class="card p-5">
        <div class="card-body">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>

            <h2 class="fw-bold text-dark">Oops! Something went wrong</h2>
            <p class="text-muted mb-4">The application encountered an unexpected error during the MVC lifecycle.</p>

            <%
                String errorMessage = (String)request.getAttribute("errorMessage");
                Throwable cause = (Throwable)request.getAttribute("cause");
                // The implicit 'exception' object is available because isErrorPage="true"
            %>

            <div class="alert alert-danger border-0 py-3 mb-4">
                <strong><i class="fas fa-bug me-2"></i>Error:</strong>
                <%= (errorMessage != null) ? errorMessage : "An unspecified execution error occurred." %>
            </div>

            <div class="accordion mb-4" id="errorAccordion">
                <div class="accordion-item border-0 shadow-sm">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed fw-semibold text-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDetails">
                            <i class="fas fa-code me-2"></i> View Technical Details
                        </button>
                    </h2>
                    <div id="collapseDetails" class="accordion-collapse collapse" data-bs-parent="#errorAccordion">
                        <div class="accordion-body text-start">
                            <p class="small mb-1 text-uppercase fw-bold text-muted">Exception Cause:</p>
                            <div class="stack-trace mb-3">
                                <%= (cause != null) ? cause : (exception != null ? exception.getMessage() : "No trace available") %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                <a href="student" class="btn btn-dark btn-lg px-4 gap-3">
                    <i class="fas fa-home me-2"></i>Return to Registry
                </a>
                <button onclick="location.reload()" class="btn btn-outline-secondary btn-lg px-4">
                    <i class="fas fa-sync me-2"></i>Retry
                </button>
            </div>
        </div>

        <div class="card-footer bg-transparent border-0 text-muted small mt-3">
            Error handled by MVC Controller Dispatcher
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>