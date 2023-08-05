const jwt=require('jsonwebtoken');
const User=require('../models/user');

const admin = async (req,res,next)=>{
    try{
        const token= await req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg:"No auth token, access deniend"});
        }
        const varifed = jwt.verify(token,'passwordKey');
        if(!varifed)return res.status(401).json({msg:"Token verification failed, access deniend"});
        const user=await User.findById(varifed.id);

        if(user.type=='user'|| user.type=='seller'){
            res.status(401).json({msg:'You are not an admin!'});
        }
        req.user = varifed.id;
        req.token = token;
        next();
    
    } catch (e){
        res.status(500).json({error: e.message});
    }

}

module.exports=admin;