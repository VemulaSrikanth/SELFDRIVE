using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SelfDrive
{
    public class DbAccess
    {
        private string constr = ConfigurationManager.ConnectionStrings["ReadOnly"].ToString();
        private static string _agent = string.Empty;
        internal static string Agent
        {
            set { _agent = value; }
            get { return _agent; }
        }

        private static void LogDataBaseTransaction(string CustomMessage, string storedProcName, string FunctionName, ref DbCommand dbCmd)
        {
            if (!AppLog.LogDebugMessages) return;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("Exec " + storedProcName + " ");
            for (int i = 0; i < dbCmd.Parameters.Count; i++)
            {
                sb.Append(dbCmd.Parameters[i].ParameterName);
                sb.Append("=");
                sb.Append(dbCmd.Parameters[i].Value);
                sb.Append(",");
            }
            sb.Remove(sb.Length - 1, 1);
            AppLog.Debug(CustomMessage + FunctionName + ": " + sb.ToString());
        }
        public DataTable GetAllEmployees(string CompanyId, string UserProfileId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("A_getAllEmployees", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@UserProfileId", UserProfileId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllVehicleMaster(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllVehicleSegmentMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllLocationsMaster(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllLocationsMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllActiveLocations(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActiveLocations", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllActiveBranches(string CompanyId,string slid)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActiveBranches", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@slid", slid);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllActiveVehMakes(string CompanyId, string VehSegid)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActiveVehMakes", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@VehSegid", VehSegid);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllActivePackages(string CompanyId, string SerLocId, string VehSegid)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActivePackages", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@slid", SerLocId);
                    com.Parameters.AddWithValue("@VehSegid", VehSegid);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllAccessories(string CompanyId, string VehSegid)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllAccessories", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@VehSegid", VehSegid);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllStates(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllStates", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllCompanies()
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllCompanies", con);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllBranches(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllBranchMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllSuppliers(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllSupplierMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllVehicleMasterWithVehiclemake(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllVehicleMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllPackages(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                AppLog.Info("Calling SP : S_GetAllPackages");
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllPackages", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllBookings(string CompanyId, DateTime fromdate, DateTime todate)
        {
            DataTable dt = null;
            try
            {
                AppLog.Info("Calling SP : S_GetAllBookings");
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllBookings", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@fromdate", fromdate);
                    com.Parameters.AddWithValue("@todate", todate);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetSelBookings(string CompanyId,DateTime fromdate, DateTime todate,string bookingstatus,string serloc)
        {
            DataTable dt = null;
            try
            {
                AppLog.Info("Calling SP : S_GetSelectedBookings");
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetSelectedBookings", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.Parameters.AddWithValue("@fromdate", fromdate);
                    com.Parameters.AddWithValue("@todate", todate);
                    com.Parameters.AddWithValue("@bookingstatus", bookingstatus);
                    com.Parameters.AddWithValue("@Serloc", serloc);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }

        public DataTable GetAllAccessoriesMaster(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllAccessoriesMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllVehicleMakeMaster(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllVehicleMakeMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllActiveVehicleMakeMaster(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActiveVehicleMakeMaster", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public DataTable GetAllActiveVehicleSegments(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_GetAllActiveVehicleSegments", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public string InsertVehicleSegMasterData(string Flag, string VehicleSegId, string Name, string Status, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehicleSegMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@vehiclesegid", VehicleSegId);
                    com.Parameters.AddWithValue("@vehiclename", Name);
                   
                    com.Parameters.AddWithValue("@Status", Status);
                    
                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertStateMasterData(string Flag, string StateID, string Name, string gstcode, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_StateMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@stateid", StateID);
                    com.Parameters.AddWithValue("@statename", Name);

                    com.Parameters.AddWithValue("@gstcode", gstcode);

                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }


        public string InsertCompanyMasterData(string flag, string companyname, string add1, string add2,
            string city, string pincode, string colorlogo, string blacklogo, string panno, string gstno, string status)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_InsertCompanyMaster", con);
                    com.Parameters.AddWithValue("@flag", flag);
                    com.Parameters.AddWithValue("@companyname", companyname);
                    com.Parameters.AddWithValue("@add1", add1);
                    com.Parameters.AddWithValue("@add2", add2);
                    com.Parameters.AddWithValue("@city", city);
                    com.Parameters.AddWithValue("@pincode", pincode);

                    com.Parameters.AddWithValue("@colorlogo", colorlogo);
                    com.Parameters.AddWithValue("@blacklogo", blacklogo);
                    com.Parameters.AddWithValue("@panno", panno);
                    com.Parameters.AddWithValue("@gstno", gstno);
                    com.Parameters.AddWithValue("@status", status);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertLocationMasterData(string Flag, string LocationID, string LocationName, string stateid, string locationcode, string status, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_LocationMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@LocationID", LocationID);
                    com.Parameters.AddWithValue("@LocationName", LocationName);

                    com.Parameters.AddWithValue("@stateid", stateid);
                    com.Parameters.AddWithValue("@locationcode", locationcode);
                    com.Parameters.AddWithValue("@status", status);

                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

       

        public string InsertBranchMasterData(string Flag, string branchid, string branchname, string slid, string brcode, string Address1, string Address2, string PinCode, string Phonenum, double longitude, double latitude, string status, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_BranchMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@branchid", branchid);
                    com.Parameters.AddWithValue("@branchname", branchname);

                    com.Parameters.AddWithValue("@slid", slid);
                    com.Parameters.AddWithValue("@brcode", brcode);

                    com.Parameters.AddWithValue("@Address1", Address1);
                    com.Parameters.AddWithValue("@Address2", Address2);
                    com.Parameters.AddWithValue("@PinCode", PinCode);
                    com.Parameters.AddWithValue("@Phonenum", Phonenum);
                    com.Parameters.AddWithValue("@longitude", longitude);
                    com.Parameters.AddWithValue("@latitude", latitude);

                    com.Parameters.AddWithValue("@status", status);

                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertSupplierMasterData(string Flag, string supplierid, string suppliername, string Address1, string Address2, string city, string contactname, string contactemail, string Phonenum, string gstid, string gstin, string gststatus, double tdsperc, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_SupplierMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@supplierid", supplierid);
                    com.Parameters.AddWithValue("@suppliername", suppliername);
                    com.Parameters.AddWithValue("@Address1", Address1);
                    com.Parameters.AddWithValue("@Address2", Address2);

                    com.Parameters.AddWithValue("@city", city);
                    com.Parameters.AddWithValue("@contactname", contactname);


                    com.Parameters.AddWithValue("@contactemail", contactemail);
                    com.Parameters.AddWithValue("@Phonenum", Phonenum);
                    com.Parameters.AddWithValue("@gstid", gstid);
                    com.Parameters.AddWithValue("@gstin", gstin);

                    com.Parameters.AddWithValue("@gststatus", gststatus);
                    com.Parameters.AddWithValue("@tdsperc", tdsperc);

                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }
        
        public string InsertVehMasterData(string Flag, string vrid, string supplier, string vehmake, string vehno, double avgmilage, string chasisno, string engineno, string status, string CompanyId,string slid,string brid)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehicleMasterDataInsert", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@vrid", vrid);
                    com.Parameters.AddWithValue("@suppid", supplier);
                    com.Parameters.AddWithValue("@vehmake", vehmake);
                    com.Parameters.AddWithValue("@vehno", vehno);

                    com.Parameters.AddWithValue("@avgmilage", avgmilage);
                    com.Parameters.AddWithValue("@chasisno", chasisno);
                    
                    com.Parameters.AddWithValue("@engineno", engineno);
                    com.Parameters.AddWithValue("@status", status);
                    
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.Parameters.AddWithValue("@slid", slid);
                    com.Parameters.AddWithValue("@brid", brid);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InserPackageMasterData(string Flag, string tariffid, string packagename, string tariffstatus, string slid, string segid, string preparedbyid, int allowedkms, double allowedhrs, double gracehrs,double gracehrrate, double extrakmrate, double basicrate,string ratetype,string fuelcoststatus,double securitydeposit, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_PackageMasterDataInsert", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@tariffid", tariffid);
                    com.Parameters.AddWithValue("@packagename", packagename);
                    com.Parameters.AddWithValue("@tariffstatus", tariffstatus);
                    com.Parameters.AddWithValue("@slid", slid);

                    com.Parameters.AddWithValue("@segid", segid);
                    com.Parameters.AddWithValue("@preparedby", preparedbyid);

                    com.Parameters.AddWithValue("@allowedkms", allowedkms);
                    com.Parameters.AddWithValue("@allowedhrs", allowedhrs);
                    com.Parameters.AddWithValue("@gracehrs", gracehrs);
                    com.Parameters.AddWithValue("@gracehrrate", gracehrrate);
                    com.Parameters.AddWithValue("@extrakmrate", extrakmrate);
                    com.Parameters.AddWithValue("@basicrate", basicrate);
                    com.Parameters.AddWithValue("@ratetype", ratetype);
                    com.Parameters.AddWithValue("@fuelcoststatus", fuelcoststatus);
                    com.Parameters.AddWithValue("@securitydeposit", securitydeposit);
          
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    
                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertBookingData(string Flag, string bookingid, DateTime bookingdate, string customerid, DateTime fromdate, DateTime Todate, TimeSpan fromtime, TimeSpan Totime, string vehsegid,string status,
            string slid,string vehmakeid,string bookedby, string bookedbymobile,string bookedbyemail,string guest,string guestmobile,string guestEmail, 
            double AdvanceAmt,string discstatus, double discount, string SecDepStatus,double SecDepAmt, string preparedbyid, string CompanyId,string tariffid,string accessoriesStatus,string accsids)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_BookingDataInsert", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@bookingid", bookingid);
                    com.Parameters.AddWithValue("@bookingdate", bookingdate);
                    com.Parameters.AddWithValue("@customerid", customerid);
                    com.Parameters.AddWithValue("@fromdate", fromdate);
                    com.Parameters.AddWithValue("@Todate", Todate);
                    com.Parameters.AddWithValue("@fromtime", fromtime);
                    com.Parameters.AddWithValue("@Totime", Totime);

                    com.Parameters.AddWithValue("@vehsegid", vehsegid);
                    com.Parameters.AddWithValue("@status", status);
                    com.Parameters.AddWithValue("@slid", slid);
                    
                    com.Parameters.AddWithValue("@vehmakeid", vehmakeid);
                    com.Parameters.AddWithValue("@bookedby", bookedby);
                    com.Parameters.AddWithValue("@bookedbymobile", bookedbymobile);
                    com.Parameters.AddWithValue("@bookedbyemail", bookedbyemail);
                    com.Parameters.AddWithValue("@guest", guest);
                    com.Parameters.AddWithValue("@guestmobile", guestmobile);
                    com.Parameters.AddWithValue("@guestEmail", guestEmail);
                    com.Parameters.AddWithValue("@AdvanceAmt", AdvanceAmt);
                    com.Parameters.AddWithValue("@discstatus", discstatus);
                    com.Parameters.AddWithValue("@discount", discount);
                    com.Parameters.AddWithValue("@SecDepStatus", SecDepStatus);
                    com.Parameters.AddWithValue("@SecDepAmt", SecDepAmt);

                    com.Parameters.AddWithValue("@preparedby", preparedbyid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.Parameters.AddWithValue("@tariffid", tariffid);
                    com.Parameters.AddWithValue("@accessoriesStatus", accessoriesStatus);
                    com.Parameters.AddWithValue("@accsids", accsids);
                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertAccessoriesMasterData(string Flag, string Accessid, string Name, string AccessDesc, string Status, string vehiclesegids, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_AccessoriesMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@accsid", Accessid);
                    com.Parameters.AddWithValue("@accsname", Name);
                    com.Parameters.AddWithValue("@accsdescription", AccessDesc);
                    com.Parameters.AddWithValue("@status", Status);
                    com.Parameters.AddWithValue("@vehiclesegids", vehiclesegids);
                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }

        public string InsertVehMakeMasterData(string Flag, string vehmakeid, string vehmakeName, string AcNonAc, string Status, string vehiclesegids, string CompanyId)
        {
            string Count = "";
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehMakeMasterData", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@vehmakeid", vehmakeid);
                    com.Parameters.AddWithValue("@vehmake", vehmakeName);
                    com.Parameters.AddWithValue("@acnonac", AcNonAc);
                    com.Parameters.AddWithValue("@status", Status);
                    com.Parameters.AddWithValue("@vehsegid", vehiclesegids);
                    com.Parameters.AddWithValue("@companyid", CompanyId);

                    com.Parameters.Add(new SqlParameter("@count", SqlDbType.NVarChar, 50));

                    com.Parameters["@count"].Direction = ParameterDirection.Output;
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();

                    Count = (string)com.Parameters["@count"].Value;
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;
        }
        public void DeleteVehicleSegById(string vehsegId, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehicleSegMasterDataDelete", con);
                    com.Parameters.AddWithValue("@vehiclesegid", vehsegId);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void DeleteStateById(string vehsegId, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_StateMasterDataDelete", con);
                    com.Parameters.AddWithValue("@stateid", vehsegId);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }

        public void DeleteCompanyById( string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_CompanyDelete", con);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }

        public void DeleteLocationById(string locid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_LocationMasterDataDelete", con);
                    com.Parameters.AddWithValue("@locationid", locid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void DeleteBranchById(string branchid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_BranchMasterDataDelete", con);
                    com.Parameters.AddWithValue("@branchid", branchid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void DeleteSupplierById(string supplierid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_SupplierMasterDataDelete", con);
                    com.Parameters.AddWithValue("@supid", supplierid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }

        public void DeleteVehMasterById(string vrid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehMasterDataDelete", con);
                    com.Parameters.AddWithValue("@vrid", vrid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }

        public void DeleteBookingById(string bookingid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_BookingDataDelete", con);
                    com.Parameters.AddWithValue("@bookingid", bookingid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }

        public void DeletePackageById(string tariffId, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_PackageMasterDataDelete", con);
                    com.Parameters.AddWithValue("@tariffid", tariffId);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void DeleteAccessoriesMasterById(string accId, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_AccessoriesMasterDataDelete", con);
                    com.Parameters.AddWithValue("@accid", accId);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void DeletevehicleMakeMasterById(string vehmakeid, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("S_VehicleMakeMasterDataDelete", con);
                    com.Parameters.AddWithValue("@vehmakeid", vehmakeid);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public Int32 UserNameIsExist(string ID, string CompanyId, string name)
        {
            int Count = 0;
            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("H_validateUserName", con);
                    com.Parameters.AddWithValue("@ID", ID);
                    com.Parameters.AddWithValue("@name", name);
                    com.Parameters.AddWithValue("@companyid", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.Add(new SqlParameter("@IsCount", SqlDbType.Int, 10));
                    com.Parameters["@IsCount"].Direction = ParameterDirection.Output;

                    if (con.State == ConnectionState.Closed) { con.Open(); }
                    com.ExecuteNonQuery();
                    Count = (Int32)com.Parameters["@IsCount"].Value;

                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;

        }
        public void Insertesipfpercandlimitdetails(string Flag,decimal esiperc, decimal esilimit, decimal pfperc, decimal pflimit,int fmonth,int fyear,
            string preparedby,string companyid)
        {
            
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();

                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("A_Insertesipfperclimitdetails", con);
                    com.Parameters.AddWithValue("@Flag", Flag);
                    com.Parameters.AddWithValue("@esiperc", esiperc);
                    com.Parameters.AddWithValue("@esilimit", esilimit);
                    com.Parameters.AddWithValue("@pfperc", pfperc);
                    com.Parameters.AddWithValue("@pflimit", pflimit);
                    com.Parameters.AddWithValue("@fmonth", fmonth);
                    com.Parameters.AddWithValue("@fyear", fyear);
                    com.Parameters.AddWithValue("@preparedby", preparedby);
                    com.Parameters.AddWithValue("@companyid", companyid);

                    
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }            
        }
        public DataTable GetAllesipfpercandlimitdetails(string CompanyId)
        {
            DataTable dt = null;
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                dt = new DataTable();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("A_getAllesipfpercandlimitdetails", con);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    da.SelectCommand = com;
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return dt;
        }
        public Int32 UserMonthyearIsExist(string Flag,Int32 fmonth, Int32 fyear, string companyid)
        {
            int Count = 0;
            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("A_validatemonthyear", con);
                    com.Parameters.AddWithValue("@flag", Flag);
                    com.Parameters.AddWithValue("@fmonth", fmonth);
                    com.Parameters.AddWithValue("@fyear", fyear);
                    com.Parameters.AddWithValue("@companyid", companyid);
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.Add(new SqlParameter("@IsCount", SqlDbType.Int, 10));
                    com.Parameters["@IsCount"].Direction = ParameterDirection.Output;

                    if (con.State == ConnectionState.Closed) { con.Open(); }
                    com.ExecuteNonQuery();
                    Count = (Int32)com.Parameters["@IsCount"].Value;

                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return Count;

        }
        public void Deleteesipfperlimit(Int32 fmonth,Int32 fyear, string CompanyId)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com;
                    com = new SqlCommand("A_Deleteesipfpercandlimit", con);
                    com.Parameters.AddWithValue("@fmonth", fmonth);
                    com.Parameters.AddWithValue("@fyear", fyear);
                    com.Parameters.AddWithValue("@CompanyId", CompanyId);
                    com.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    int i = com.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
        public void ChangePassword(string companyid, string profileid, string pwd)
        {

            try
            {
                SqlDataAdapter da = new SqlDataAdapter();
                using (SqlConnection con = new SqlConnection(constr))
                {
                    SqlCommand com = new SqlCommand("T_ChangePwd", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@companyid", companyid);
                    com.Parameters.AddWithValue("@profileid", profileid);
                    com.Parameters.AddWithValue("@pwd", pwd);
                    if (con.State == ConnectionState.Closed) { con.Open(); }
                    com.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }

        }
    }
}