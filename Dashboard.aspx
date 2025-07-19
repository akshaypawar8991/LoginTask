<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TwoWayLogin.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dasboard</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
  <div class="d-flex" style="min-height: 100vh;">
        <!-- Sidebar Navigation -->
        <nav class="bg-dark text-white p-3" style="width: 220px;">
            <h4 class="mb-4">Navigation</h4>
            <a href="#" class="nav-link text-white">Master</a>
            <a href="#" class="nav-link text-white">Settings</a>
            <a href="#" class="nav-link text-white">Vouchers</a>
        </nav>

        <!-- Main Content -->
        <div class="flex-grow-1 p-4">

            <!-- Create Button -->
            <div class="text-right mb-3">
                <button class="btn btn-primary">Create</button>
            </div>

            <!-- Status Panels -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Pending</h5>
                            <p class="card-text">Tasks waiting to be processed</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-info mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Pending for HOD</h5>
                            <p class="card-text">Awaiting Head of Department approval</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-secondary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Pending for HR</h5>
                            <p class="card-text">Waiting for HR review</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Closed</h5>
                            <p class="card-text">Completed and approved</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
