M = {}

function M.isNix()
    return tonumber(vim.env.NVIM_HOME_MANAGER) == 1
end

function M.isNotNix()
    return not M.isNix()
end

--Return left value when not on Nix (home manager)
--Return right or nil when on Nix 
--@overload fun(left: any): any|nil
--@overload fun(left: any, right:any): any
function M.lazyEither(left, right)
    if M.isNix then
        return right
    else
        return left
    end
end

return M
