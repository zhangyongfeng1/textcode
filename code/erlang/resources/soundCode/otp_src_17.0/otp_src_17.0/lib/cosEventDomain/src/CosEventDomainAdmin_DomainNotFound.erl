%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosEventDomainAdmin_DomainNotFound
%% Source: /net/isildur/ldisk/daily_build/17_prebuild_master-opu_o.2014-04-07_20/otp_src_17/lib/cosEventDomain/src/CosEventDomainAdmin.idl
%% IC vsn: 4.3.5
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosEventDomainAdmin_DomainNotFound').
-ic_compiled("4_3_5").


-include("CosEventDomainAdmin.hrl").

-export([tc/0,id/0,name/0]).



%% returns type code
tc() -> {tk_except,"IDL:omg.org/CosEventDomainAdmin/DomainNotFound:1.0",
                   "DomainNotFound",[]}.

%% returns id
id() -> "IDL:omg.org/CosEventDomainAdmin/DomainNotFound:1.0".

%% returns name
name() -> "CosEventDomainAdmin_DomainNotFound".


