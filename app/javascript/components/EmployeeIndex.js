import React, { useState, useEffect } from 'react';
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, Typography, Badge } from '@mui/material';
import AddIcon from '@mui/icons-material/Add';

const columns = [
  { field: 'full_name', headerName: 'Name', flex: 1 },
  { field: 'job_title', headerName: 'Job Title', flex: 1 },
  { field: 'salary', headerName: 'Salary', width: 150, type: 'number' },
  { field: 'address', headerName: 'Address', flex: 1.5 },
];

const EmployeeGrid = () => {
  const [rows, setRows] = useState({});
  const [rowCount, setRowCount] = useState(0);
  const [paginationModel, setPaginationModel] = useState({
    page: 1,
    pageSize: 20,
  });
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchRows = async () => {
      setLoading(true);
      const response = await fetch(`/employees?page=${paginationModel.page + 1}`, {
        method: 'GET',  
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      const data = await response.json();
      
      setRows(data.employees);
      setRowCount(data.meta.total_count);
      setLoading(false);
    };

    fetchRows();
  }, [paginationModel.page]);

  return (
    <Box sx={{ height: 600, width: '100%', p: 4 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 2 }}>
        <Typography variant="h4">Employees</Typography>
        <Box>
          <Button variant="contained" startIcon={<AddIcon />} href="/employees/new">
            New Employee
          </Button>
        </Box>
      </Box>

      <DataGrid
        rows={rows}
        columns={columns}
        rowCount={rowCount}
        loading={loading}
        pageSizeOptions={[20]}
        paginationModel={paginationModel}
        paginationMode="server"
        onPaginationModelChange={setPaginationModel}
        sx={{ border: 1, borderColor: 'divider' }}
      />
    </Box>
  );
};

export default EmployeeGrid;