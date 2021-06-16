import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import httpClient from '../services/configurations/axios.config';

function guard(to, from, next) {
  // if (localStorage.getItem('LoggedUser'))
  //   isAuthenticated = true;
  // else
  //   isAuthenticated = false;
  if (localStorage.getItem('user')) {
    const data = JSON.parse(localStorage.getItem('user'));
    const token = `Bearer ${data.access_token}`;
    httpClient.interceptors.request.use(req => {
      req.headers.authorization = token
      return req;
    });
    next();
  } else {
    if (from.path !== '/login')
      next('/login'); // go to '/login';
  }
}

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    beforeEnter: guard,
  },
  {
    path: '/preview',
    name: 'Preview',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "preview" */ '../views/Preview.vue'),
    beforeEnter: guard,
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "login" */ '../views/Login.vue')
  },
  {
    path: '/formBuilder',
    name: 'FormBuilder',
    component: () => import(/* webpackChunkName: "formBuilder" */ '../views/FormBuilder.vue'),
    beforeEnter: guard,
  }
]

const router = new VueRouter({
  routes
})

export default router
