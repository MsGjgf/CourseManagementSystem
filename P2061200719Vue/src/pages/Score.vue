<template>
    <div class="score">
        <h2>成绩管理</h2>
        
        <!-- 成绩信息表单 -->
        <el-table :data="tableData" style="width: 100%">
            <el-table-column label="课程号" prop="courseNumber"></el-table-column>
            <el-table-column label="学号" prop="studentNumber"></el-table-column>
            <el-table-column label="学生姓名" prop="studentName"></el-table-column>
            <el-table-column label="课程名称" prop="courseName"></el-table-column>
            <el-table-column label="成绩" prop="score"></el-table-column>
            <el-table-column align="right">
            <template slot="header" slot-scope="scope">
                <el-input v-model.trim="searchStudentNameChange" size="mini" placeholder="按学生姓名查询"/>
                <el-input v-model.trim="searchCourseNameChange" size="mini" placeholder="按课程名称查询"/>
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
        <el-dialog title="添加成绩信息" :visible.sync="addDialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="学号" prop="studentNumber">
                    <el-select v-model="ruleForm.studentNumber" filterable placeholder="请选择学号">
                        <el-option v-for="item in optionsStudent" :key="item.studentNumber" :label="item.studentNumber" :value="item.studentNumber">
                            <span style="float: left">{{ item.studentNumber }}</span>
                            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.name }}</span>
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="课程号" prop="courseNumber">
                    <el-select v-model="ruleForm.courseNumber" filterable placeholder="请选择课程号">
                        <el-option v-for="item in optionsCourse" :key="item.courseNumber" :label="item.courseNumber" :value="item.courseNumber">
                            <span style="float: left">{{ item.courseNumber }}</span>
                            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.courseName }}</span>
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="成绩" prop="score">
                    <el-input v-model.trim="ruleForm.score"></el-input>
                </el-form-item>              
                <el-form-item>
                    <el-button type="primary" @click="handleAdd('ruleForm')">添加</el-button>
                    <el-button @click="addDialogFormVisible=false">取消</el-button>
                </el-form-item>
                </el-form>
        </el-dialog>

        <!-- 编辑内嵌Form -->
        <el-dialog title="编辑成绩信息" :visible.sync="editDialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="学号" prop="studentNumber">
                    <el-input v-model="ruleForm.studentNumber" disabled></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="studentName">
                    <el-input v-model="ruleForm.studentName" disabled></el-input>
                </el-form-item>
                <el-form-item label="课号" prop="courseNumber">
                    <el-input v-model="ruleForm.courseNumber" disabled></el-input>
                </el-form-item>
                <el-form-item label="课程名称" prop="courseName">
                    <el-input v-model="ruleForm.courseName" disabled></el-input>
                </el-form-item>
                <el-form-item label="成绩" prop="score">
                    <el-input v-model.trim="ruleForm.score"></el-input>
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
    name:'Score',
    data(){
        return{
            tableData: [],

            searchStudentNameChange: '',//搜索框变动值
            searchCourseNameChange:'',

            searchStudentName:'',       //搜索框固定值
            searchCourseName:'',
            
            pageSize:5,                 //每页条数
            total:0,                    //总条数
            currentPage:1,              //当前页
                
            addDialogFormVisible: false,    //添加弹层
            editDialogFormVisible:false,    //编辑弹层

            optionsStudent:[],  //学生信息
            optionsCourse:[],   //课程信息

            ruleForm:{},
            // 输入规则校验
            rules: {
                studentNumber: [
                    { required: true, message: '请选择学号', trigger: 'change' }
                ],
                courseNumber: [
                    { required: true, message: '请选择课程号', trigger: 'change' }
                ],
                score: [
                    { required: true, message: '成绩不能为空', trigger: 'blur'}
                ]
            }
        }
    },
    methods:{
        // 打开添加弹层，获取数据
        openAddDialog(){
            this.addDialogFormVisible = true
            this.ruleForm = {   //置空
                studentNumber:'',
                courseNumber:'',
                score:''
            }
            // 获取学生信息
            this.$axios.get(`/student/getStudentInfo`).then(res=>{
                this.optionsStudent= res.data.data
            })
            // 获取课程信息
            this.$axios.get(`/course/getCourseInfo`).then(res=>{
                this.optionsCourse = res.data.data
            })
        },
        // 添加成绩
        handleAdd(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    if(!(/^-?\d+\.\d+$/.test(this.ruleForm.score))){    //正则判断浮点
                        this.$message({
                            type:'warning',
                            message:'应该是浮点型叭！'
                        })
                        return;
                    }
                    this.$axios.post(`/score/add`,this.ruleForm).then(res=>{
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
        // 编辑成绩
        handleEdit(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    if(!(/^-?\d+\.\d+$/.test(this.ruleForm.score))){    //正则判断浮点
                        this.$message({
                            type:'warning',
                            message:'应该是浮点型叭！'
                        })
                        return;
                    }
                    this.$axios.put(`/score/upd?studentNumber=${this.ruleForm.studentNumber}&courseNumber=${this.ruleForm.courseNumber}&score=${this.ruleForm.score}`)
                    .then(res=>{
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
            this.$axios.delete(`/score/del?studentNumber=${row.studentNumber}&courseNumber=${row.courseNumber}`)
            .then(res=>{
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
            this.pageSubmit(this.currentPage,this.pageSize,this.searchCourseName,this.searchStudentName)
        },
        // 当前页改变时向后端发请求(所有请求)
        pageSubmit(currentPage,pageSize,courseName,studentName){
            this.$axios.get(`/score/findPage?currentPage=${currentPage}&pageSize=${pageSize}&courseName=${courseName}&studentName=${studentName}`)
            .then(res=>{
                this.tableData = res.data.data.records
                this.total = res.data.data.total
                this.currentPage = res.data.data.current
            })
        },
        // 关键字查询
        handSearch(){
            if(this.searchCourseNameChange=="" && this.searchStudentNameChange==""){
                this.$message({
                    type:'warning',
                    message:'至少一个关键字还是要的叭o_O!'
                })
                return
            }
            // 先将search%固定
            this.searchCourseName = this.searchCourseNameChange
            this.searchStudentName = this.searchStudentNameChange
            // 开始查询
            this.pageSubmit(1,this.pageSize,this.searchCourseName,this.searchStudentName)
        },
        // 查询全部
        handleSearchAll(){
            //清空搜索值(排队-_-!)
            this.searchCourseName = this.searchStudentName = this.searchCourseNameChange = this.searchStudentNameChange = ''
            this.pageSubmit(1,this.pageSize,'','')
        }
    },
    created(){
        this.pageSubmit(1,this.pageSize,'','')
    }
}
</script>

<style>

</style>