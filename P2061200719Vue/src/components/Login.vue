<template>
    <div class="login">
        <img v-for="index of 16" :key="index" src="../assets/小花瓣.png"/>
        <h1 style="color: rgb(221, 106, 126); text-align: center; padding: 100px;">斯普锐布特课程管理系统</h1>
        <div id="login">
            <el-input placeholder="请输入内容" v-model="loginData.admin" clearable></el-input>
            <el-input placeholder="请输入密码" v-model="loginData.password" show-password></el-input>
            <el-button @click="login" type="primary" round>登 录</el-button>
        </div>
    </div>
</template>

<script>
export default {
    name:'Login',
    data(){
        return{
            loginData:{
                admin:'',
                password:''
            }
        }
    },
    methods:{
        //登录
        login(){
            this.$axios.post(`/login`,this.loginData).then(res=>{
                if(res.data.code === "200"){
                    this.$message({
                        showClose:true,
                        type:'success',
                        message:"登录成功！"
                    })
                    sessionStorage.setItem("token",res.data.data)
                    this.$router.push('/manage')
                }else{
                    this.$message.error(res.data.msg)
                }
            }).catch(error=>{
                this.$message.error('网络错误！！！')
            })
        }
    },
    created(){
        this.loginData = {
            admin:'admin',
            password:'000000'
        }
    }
}
</script>

<style scoped>
    .login{
        background-image: url('../assets/gldzkd_banner_xk.jpg');
        background-size: cover;
        min-height: 720px;
        overflow: hidden;
    }
    #login{
        width: 300px;
        text-align: center;
        margin: auto;
        background-color: rgba(255, 255, 255, 0.7);
        padding: 20px;
        border-radius: 10px;
    }
    #login *{
        margin-top: 10px;
        margin-bottom: 10px;
        width: 290px;
    }

    /**可叹！花瓣飘零*/
    img{
        width: 20px;
        height: 20px;
        position: absolute;
    }
    @keyframes animate{
        0%{
            opacity: 0; top: -10px;
            transform: translateX(20px) rotate(0deg);
        }
        10%{
            opacity: 1;
        }
        20%{
            transform: translateX(-20px) rotate(45deg);
        }
        40%{
            transform: translateX(-20px) rotate(90deg);
        }
        60%{
            transform: translateX(-20px) rotate(180deg);
        }
        80%{
            transform: translateX(-20px) rotate(45deg);
        }
        100%{
            top: 96%;
            transform: translateX(20px) rotate(225deg);
        }
    }
    .login img:nth-child(1){
        left: 20%;
        animation: animate 20s linear infinite;
    }
    .login img:nth-child(2){
        left: 50%;
        animation: animate 14s -2s linear infinite;
    }
    .login img:nth-child(3){
        left: 70%;
        animation: animate 12s -3s linear infinite;
    }
    .login img:nth-child(4){
        left: 5%;
        animation: animate 15s -2s linear infinite;
    }
    .login img:nth-child(5){
        left: 80%;
        animation: animate 18s -1s linear infinite;
    }
    .login img:nth-child(6){
        left: 90%;
        animation: animate 12s -1s linear infinite;
    }
    .login img:nth-child(7){
        left: 15%;
        animation: animate 14s -2s linear infinite;
    }
    .login img:nth-child(8){
        left: 60%;
        animation: animate 15s -1s linear infinite;
    }
    .login img:nth-child(9){
        left: 40%;
        animation: animate 10s -2s linear infinite;
    }
    .login img:nth-child(10){
        left: 55%;
        animation: animate 11s -1s linear infinite;
    }


    .login img:nth-child(11){
        left: 15%;
        animation: animate 7s -1s linear infinite;
    }
    .login img:nth-child(12){
        left: 35%;
        animation: animate 10s -1s linear infinite;
    }
    .login img:nth-child(13){
        left: 45%;
        animation: animate 8s -1s linear infinite;
    }
    .login img:nth-child(14){
        left: 75%;
        animation: animate 16s -1s linear infinite;
    }
    .login img:nth-child(15){
        left: 95%;
        animation: animate 19s -1s linear infinite;
    }
    .login img:nth-child(16){
        left: 65%;
        animation: animate 13s -1s linear infinite;
    }
</style>