<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TwoWayLogin.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   

    <style>
        body {
            background: linear-gradient(to bottom right, #007BFF, #00C6FF);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        .profile-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: block;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #007BFF;
        }
        .btn-primary {
            background-color: #007BFF;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .form-label {
            font-weight: bold;
        }
        .link {
            color: #007BFF;
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
        .dark-mode {
         background: #121212 !important;
         color: #f1f1f1 !important;
     }
     .dark-mode .card {
         background: #1e1e1e;
         color: #f1f1f1;
     }
        .toggle-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        .custom-modal {
  display: none;
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.5);
}

.custom-modal-content {
  background-color: #fff;
  margin: 15% auto;
  padding: 20px;
  border-radius: 8px;
  width: 300px;
  text-align: center;
  box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.close-btn {
  float: right;
  font-size: 20px;
  font-weight: bold;
  cursor: pointer;
}

#okBtn {
  margin-top: 15px;
  padding: 8px 16px;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

    </style>
</head>
<body>
       <!-- Custom Modal -->
<div id="customModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:9999;">
  <div style="background:#fff; padding:20px; border-radius:8px; width:300px; margin:15% auto; text-align:center;">
    <span id="closeModal" style="float:right; cursor:pointer; font-size:20px;">&times;</span>
   
    <p>Your password has been reset successfully!</p>
    <button id="okBtn">OK</button>
  </div>
</div>


<!-- Modal Script -->
<script>

    function showCustomModal() {
        $('#customModal').fadeIn();
        setTimeout(function () {
            window.location.href = 'Login.aspx';
        }, 3000); // Redirect after 3 seconds
    }

    $(document).ready(function () {
        $('#closeModal, #okBtn').click(function () {
            $('#customModal').fadeOut();
        });
    });
</script>
    <button class="toggle-btn" onclick="toggleDarkMode()">🌙 Dark Mode</button>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

       <div class="card p-5 mx-auto" style="width: 100%; max-width: 1050px;">
            <img src="Img/profile.png" alt="Profile" class="profile-img" />
           
            <%-- Login Panel --%>
            <asp:Panel ID="pnlLogin" runat="server" Visible="true">
                <h4 class="text-center mb-4">Login</h4>
                <div class="mb-3">
                    <asp:TextBox ID="txt_empcode" runat="server" CssClass="form-control" placeholder="Employee Code" />
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txt_Password" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password" />
                </div>
                <div class="d-grid mb-3">
                    <asp:Button ID="Btn_Login" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="Btn_Login_Click" />
                </div>
                <div class="text-center">
                    <asp:LinkButton ID="lnkForgotPassword" runat="server" CssClass="link" OnClick="lnkForgotPassword_Click">Forgot Password?</asp:LinkButton>
                </div>
            </asp:Panel>

            <%-- OTP Panel --%>
            <asp:Panel ID="pnlotp" runat="server" Visible="false">
                <h4 class="text-center mb-4">Reset Password</h4>
                <div class="mb-3">
                    <asp:TextBox ID="txt_VerifyOtp" runat="server" CssClass="form-control" placeholder="Entry 4-Digit OTP" />
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txt_SetNewPassword" runat="server" CssClass="form-control" placeholder="Set New Password" TextMode="Password" />
                </div>
                <div class="d-grid mb-3">
                    <asp:Button ID="Btn_Submit" runat="server" Text="Reset Password ➝" CssClass="btn btn-primary" OnClick="Btn_Submit_Clik" />
                </div>
               <%-- <button onclick="showCustomModal()">Test Modal</button>--%>

            </asp:Panel>
            <%-- Message Label --%>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger text-center d-block mt-2"></asp:Label>
        </div>
    </form>

    <!-- Bootstrap JS (optional for components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
        }
    </script>


</body>
</html>
