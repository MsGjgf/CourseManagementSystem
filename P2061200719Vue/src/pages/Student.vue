<template>
    <div class="student">
        <h2>学生管理</h2>
        
        <!-- 学生信息表单 -->
        <el-table :data="tableData" style="width: 100%">
            <el-table-column label="学号" prop="studentNumber"></el-table-column>
            <el-table-column label="姓名" prop="name"></el-table-column>
            <el-table-column label="性别" prop="sex"></el-table-column>
            <el-table-column label="班级" prop="grade"></el-table-column>
            <el-table-column label="手机" prop="phone"></el-table-column>
            <el-table-column label="专业" prop="major"></el-table-column>
            <el-table-column align="right">
            <template slot="header" slot-scope="scope">
                <el-input v-model.trim="searchChange" size="mini" placeholder="按学生姓名查询"/>
                <el-button @click="openAddDialog" size="mini" type="primary">添加</el-button>
                <el-button @click="handSearch" size="mini" type="primary">查询</el-button>
                <el-button @click="handleSearchAll" size="mini" type="primary">查全</el-button>
            </template>
            <template slot-scope="scope">
                <el-button size="mini" @click="openEditDialog(scope.$index, scope.row)">编辑</el-button>
                <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
            </template>
            </el-table-column>
        </el-table>
        
        <!-- 分页 -->
        <el-pagination @current-change="onCurrentChange" :current-page.sync="currentPage" :page-size="pageSize" :total="total" background layout="prev, pager, next" style="text-align: center;"></el-pagination>
        
        <!-- 添加内嵌Form -->
        <el-dialog title="添加学生信息" :visible.sync="addDialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="ruleForm.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex">
                    <el-radio-group v-model="ruleForm.sex">
                    <el-radio label="男"></el-radio>
                    <el-radio label="女"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="班级" prop="grade">
                    <el-input v-model="ruleForm.grade"></el-input>
                </el-form-item>
                <el-form-item label="手机号码" prop="phone">
                    <el-input v-model="ruleForm.phone"></el-input>
                </el-form-item>
                <el-form-item label="专业" prop="major">
                    <el-input v-model="ruleForm.major"></el-input>
                </el-form-item>                
                <el-form-item>
                    <el-button type="primary" @click="handleAdd('ruleForm')">添加</el-button>
                    <el-button @click="addDialogFormVisible=false">取消</el-button>
                </el-form-item>
                </el-form>
        </el-dialog>

        <!-- 编辑内嵌Form -->
        <el-dialog title="编辑学生信息" :visible.sync="editDialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="学号" prop="studentNumber">
                    <el-input v-model="ruleForm.studentNumber" disabled></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="ruleForm.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex">
                    <el-radio-group v-model="ruleForm.sex">
                    <el-radio label="男"></el-radio>
                    <el-radio label="女"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="班级" prop="grade">
                    <el-input v-model="ruleForm.grade"></el-input>
                </el-form-item>
                <el-form-item label="手机号码" prop="phone">
                    <el-input v-model="ruleForm.phone"></el-input>
                </el-form-item>
                <el-form-item label="专业" prop="major">
                    <el-input v-model="ruleForm.major"></el-input>
                </el-form-item>                
                <el-form-item>
                    <el-button type="primary" @click="handleEdit('ruleForm')">确定修改</el-button>
                    <el-button @click="editDialogFormVisible=false">取消</el-button>
                </el-form-item>
                </el-form>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name:'Student',
    data(){
        return{
            tableData: [],
            searchChange: '',   //搜索框变动值
            search:'',          //搜索框固定值
            pageSize:5,         //每页条数
            total:0,            //总条数
            currentPage:1,      //当前页
                
            addDialogFormVisible: false,    //添加弹层
            editDialogFormVisible:false,    //编辑弹层
            ruleForm: {
                studentNumber:'null',
                name: '',
                sex: '',
                grade: '',
                phone: '',
                major: ''
            },
            // 输入规则校验
            rules: {
                // studentNumber: [
                //     { required: true, message: '请输入学号', trigger: 'blur' }
                // ],
                sex: [
                    { required: true, message: '请选择性别', trigger: 'change' }
                ],
                name: [
                    { required: true, message: '请输入姓名', trigger: 'blur' }
                ],
                grade: [
                    { required: true, message: '请输入班级', trigger: 'blur' }
                ],
                phone: [
                    { required: true, message: '请输入手机号码', trigger: 'blur' }
                ],
                major: [
                    { required: true, message: '请输入专业', trigger: 'blur' }
                ]
            }
        }
    },
    methods:{
        // 打开添加弹层
        openAddDialog(){
            this.addDialogFormVisible = true
            this.ruleForm = {   //置空
                studentNumber:'',
                name: '',
                sex: '',
                grade: '',
                phone: '',
                major: ''
            }
        },
        // 添加学生
        handleAdd(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.$axios.post(`/student/add`,this.ruleForm).then(res=>{
                        if(res.data.code == "200"){
                            this.$message({
                                type:'success',
                                message:res.data.msg
                            })
                            this.addDialogFormVisible = false  //关闭弹层
                            this.handleSearchAll()          //刷新数据
                        }else{
                            this.$message.error(res.data.msg)
                        }
                    })
                } else {
                    this.$message({
                        type:'warning',
                        message:'请输入完整的信息！'
                    })
                    return false;
                }
            })
        },
        // 打开编辑弹层
        openEditDialog(index, row){
            this.editDialogFormVisible = true
            this.ruleForm = row
        },
        // 编辑学生
        handleEdit(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.$axios.put(`/student/upd`,this.ruleForm).then(res=>{
                        if(res.data.code == "200"){
                            this.$message({
                                type:'success',
                                message:res.data.msg
                            })
                            this.editDialogFormVisible = false  //关闭弹层
                            this.handleSearchAll()          //刷新数据
                        }else{
                            this.$message.error(res.data.msg)
                        }
                    })
                } else {
                    this.$message({
                        type:'warning',
                        message:'请输入完整的信息！'
                    })
                    return false;
                }
            })
        },
        // 删除学生
        handleDelete(index, row) {
            this.$axios.delete(`/student/del?studentNumber=${row.studentNumber}`).then(res=>{
                if(res.data.code == "200"){
                    this.$message({
                        type:'success',
                        message:res.data.msg
                    })
                    this.handleSearchAll()    //刷新数据
                }else{
                    this.$message.error(res.data.msg)
                }
            })
        },
        // 当前页改变时
        onCurrentChange(){
            this.pageSubmit(this.currentPage,this.pageSize,this.search)
        },
        // 当前页改变时向后端发请求(所有请求)
        pageSubmit(currentPage,pageSize,search){
            this.$axios.get(`/student/findPage?currentPage=${currentPage}&pageSize=${pageSize}&search=${search}`).then(res=>{
                this.tableData = res.data.data.records
                this.total = res.data.data.total
                this.currentPage = res.data.data.current
            })
        },
        // 关键字查询
        handSearch(){
            if(this.searchChange==""){
                this.$message({
                    type:'warning',
                    message:'请输入关键字！'
                })
                return
            }
            // 先将search固定
            this.search = this.searchChange
            // 开始查询
            this.pageSubmit(1,this.pageSize,this.search)
        },
        // 查询全部
        handleSearchAll(){
            this.search = this.searchChange = ''    //清空搜索值
            this.pageSubmit(1,this.pageSize,'')
        }
    },
    created(){
        this.pageSubmit(1,this.pageSize,'')
    }
}
</script>

<style>

</style>