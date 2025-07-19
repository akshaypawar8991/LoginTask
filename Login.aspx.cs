using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Reflection.Emit;
using System.Data;
using System.Text.RegularExpressions;

namespace TwoWayLogin
{
    public partial class Login : System.Web.UI.Page
    {
        string conn;
        String HRMS_ConString = ConfigurationManager.ConnectionStrings["HRMS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                GenerateOTP();
            }
            //GenerateOTP();
        }

        protected void lnkForgotPassword_Click(object sender, EventArgs e)
        {
            

            string empcode = txt_empcode.Text;
            if (empcode != null)
            { 
                lblMessage.Text = "Invalid Employee Code.";    
            }
            string email = GetEmailByEmpCode(empcode);

            if (!string.IsNullOrEmpty(email))
            {
                string otp = GenerateOTP();
                SendEmail(email, otp);
                Session["OTP"] = otp;
                lblMessage.Text = "OTP Send Your Registered Mail ID";

                pnlLogin.Visible=false;
                pnlotp.Visible=true;
            }
            else
            {
                lblMessage.Text = "Invalid Employee Code";
                pnlotp.Visible = false;
                pnlLogin.Visible = true;
            }
        }
        //protected void Btn_ResendOTP_Click(object sender, EventArgs e)
        //{
        //    string email = GetEmailByEmpCode(txt_EmpCode.Text);
        //    if (!string.IsNullOrEmpty(email))
        //    {
        //        string newOtp = GenerateOTP();
        //        SendEmail(email, newOtp);
        //        lblMessage.Text = "New OTP sent successfully.";
        //    }
        //    else
        //    {
        //        lblMessage.Text = "Invalid Employee Code.";
        //    }
        //}


        private string GenerateOTP()
        {
            Random random = new Random();
            string generateOtp = random.Next(1000, 9999).ToString(); // for 6 digit code

            Session["OTP"] = generateOtp;
            Session["OTP_GenerationTime"] = DateTime.Now;
            return generateOtp;
        }


        private void SendEmail(string toEmail, string otp)
        {
            //System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            var fromAddress = new MailAddress("noreply@jayinst.com", "Inventory Management");
            var toAddress = new MailAddress(toEmail);
            const string fromPassword = "No@2023##";
            const string subject = "Login OTP";
            string body = $"Your OTP is: {otp}";

            var smtp = new SmtpClient
            {
                Host = "smtp.office365.com",
                Port = 587,
                EnableSsl = true,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }

        }

        private string GetEmailByEmpCode(string empcode)
        {
            //con = new SqlConnection(HRMS_ConString);
            //con.Open();

            //con.Close();
            string email = null;
            //string connectionString = "HRMS";

            using (SqlConnection conn = new SqlConnection(HRMS_ConString))
            {
                string query = "Select OfficeEmail From EmployeeDetails where EmployeeCode=@Employee_Code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Employee_Code", empcode);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    email = reader["OfficeEmail"].ToString();
                }
            }

            return email;

        }
        //protected void Btn_Submit_Clik(object sender, EventArgs e) 
        //{
        //    using (SqlConnection conn = new SqlConnection(HRMS_ConString))
        //    {

        //        string query = "update EmployeeDetails set PASSWORD=@password Where EmployeeCode=@EmployeeCode  ";
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@EmployeeCode", txt_empcode.Text);
        //        cmd.Parameters.AddWithValue("@password", txt_SetNewPassword.Text);
        //        conn.Open();
        //        cmd.ExecuteNonQuery();
        //        conn.Close();

        //        lblMessage.Text = "Password Set successful!";
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showCustomModal();", true);

        //        //Response.Redirect("~/Login.aspx");

        //    }

        //}

        protected void Btn_Submit_Clik(object sender, EventArgs e)
        {
            string input = txt_SetNewPassword.Text;
            string pattern = @"^(?=.*[@#])(?!.*1234)[a-zA-Z0-9@#]{1,6}$";

            if (Regex.IsMatch(input, pattern))
            {
                using (SqlConnection conn = new SqlConnection(HRMS_ConString))
                {
                    string query = "UPDATE EmployeeDetails SET PASSWORD = @password WHERE EmployeeCode = @EmployeeCode";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmployeeCode", txt_empcode.Text.Trim());
                    cmd.Parameters.AddWithValue("@password", txt_SetNewPassword.Text.Trim());

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    lblMessage.Text = "Password Set successful!";

                    // Show modal and redirect after 3 seconds
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModalRedirect", "showCustomModal();", true);
                }
            }
            else
            {
                string alertMessage = "Ue Combination of letters, digits, @ or # only.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", $"alert('{alertMessage}');", true);

            }
        }



        protected void Btn_Login_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(HRMS_ConString))
            {
                
                string query = "Select * From EmployeeDetails Where EmployeeCode=@EmployeeCode and PASSWORD=@password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmployeeCode", txt_empcode.Text);
                cmd.Parameters.AddWithValue("@password", txt_Password.Text);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblMessage.Text = "Login successful!";
                    Response.Redirect("~/Dashboard.aspx");
                }
                else 
                {

                    lblMessage.Text = "Invalid Employee ID and Password";
                    //Response.Redirect("~/Login.aspx");
                }


                    //string enteredOtp = Txt_Otp.Text;
                    //string sessionOtp = Session["OTP"] != null ? Session["OTP"].ToString() : null;

                    //// Retrieve OTP generation time from session
                    //DateTime? generationTime = Session["OTP_GenerationTime"] as DateTime?;

                    //if (generationTime == null || string.IsNullOrEmpty(sessionOtp))
                    //{
                    //    // OTP has expired or not generated
                    //    lblMessage.Text = "OTP has expired. Please try again.";
                    //}
                    //else
                    //{
                    //    // Check if the OTP is still valid (expires after 60 seconds)
                    //    if ((DateTime.Now - generationTime.Value).TotalSeconds <= 120)
                    //    {
                    //        // Validate the entered OTP
                    //        if (enteredOtp == sessionOtp)
                    //        {
                    //            lblMessage.Text = "Login successfully";
                    //            Response.Redirect("Contact.aspx");
                    //        }
                    //        else
                    //        {
                    //            lblMessage.Text = "Invalid OTP. Please try again.";
                    //        }
                    //    }
                    //    else
                    //    {
                    //        lblMessage.Text = "OTP has expired. Please try again.";
                    //     }

             }
        }

    }
}