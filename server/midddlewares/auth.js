const jwt = require('jsonwebtoken');

const auth =  async (req,res,next) => {

try{
    const token= await req.header('x-auth-token');
    if(!token){
        return res.status(401).json({msg:"No auth token, access deniend"});
    }
    const varifed = jwt.verify(token,'passwordKey');
    if(!varifed)return res.status(401).json({msg:"Token verification failed, access deniend"});

    req.user = varifed.id;
    req.token = token;
    next();

} catch (e){
    res.status(500).json({error: e.message});
}
}

module.exports=auth;