import Vue from "vue"
import Router from 'vue-router'

import Login from '@/components/Login'
import Manage from '@/components/Manage'
import Student from '@/pages/Student'
import Course from '@/pages/Course'
import Score from '@/pages/Score'

Vue.use(Router)

const router = new Router({
    mode:'history',
    routes:[
        {
            path:'/login',
            name:'登录',
            component:Login
        },
        {
            path:'/manage',
            name:'管理系统',
            component:Manage,
            children:[
                {
                    path:'/student',
                    name:'学生管理',
                    component:Student
                },
                {
                    path:'/course',
                    name:'课程管理',
                    component:Course
                },
                {
                    path:'/score',
                    name:'成绩管理',
                    component:Score
                }
            ]
        }
    ]
})

// 路由守卫/路由拦截/导航守卫
router.beforeEach((to, from, next) => {
    //  验证token
    if(sessionStorage.getItem("token") || to.path === "/login"){
        next()
    }else{
        next("/login")
    }
})

export default router