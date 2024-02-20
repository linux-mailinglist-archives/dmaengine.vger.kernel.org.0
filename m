Return-Path: <dmaengine+bounces-1043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B280085B096
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 02:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604F6282D5A
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDB2E401;
	Tue, 20 Feb 2024 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4wEozJN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F638466;
	Tue, 20 Feb 2024 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393383; cv=fail; b=i/CpD9NhfYfNj94fvgzH3/bxwLBXUHxChXn4eSCzGW8bpFCMOoKVbvRKWHTxVzFTNor2vbmfXYZJ7TKzveY79nl1PovSbUkhXuHrZ5dK0IO994RS11EuCTHuYp+9L16VdzB8QjPxZ2qNL5mxrp6st+5BjyuazizXADZ55ezEMN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393383; c=relaxed/simple;
	bh=gHqnvWspFUizUV4CrkmjPEUwPsz0LGHT01C/vJ80ZNc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NFB/Z12r8StD+4bOG+XozFE20jrVblac/bnbOy7SElBZTNV3KmZtNBpku6IUrjOXoyEK+vcKbVGcWIStJAri8bZTCpoNF/X+qtgr1cQ2/nH87HYfHtmaAjb/ZeWM2PBuO22w343psgrgwQTqiATfD468m3p9e9HxSggVbiklIhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4wEozJN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708393381; x=1739929381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gHqnvWspFUizUV4CrkmjPEUwPsz0LGHT01C/vJ80ZNc=;
  b=d4wEozJNc0U5RWd3Y4UxMU5/WOGNfGup8WxunU18jY4oAseWZ8KMptNX
   lAHMZo+T0WpYFPPvIeMYc212KtBT22n5Lw6l7wlhlPb8OR8r3FeMtQkWv
   fvOSHZMoTyb4sH2H6HUS2+zdV1RF/DwDgkm6j5g226vd3Zw3qDsqW6lvO
   kOX3oyyHGXQQVDR/666hYhB2HvAwi5CXr54aN7gwy0wejRx0b9qI7f2iH
   d4IBHFdHmym9Jiexef5CjQ3JB9p9Nv67S0ZVKJuphB7KtSbdZrVZXznqJ
   PfTbO3nxo+Db7lg+Wy+TuHIkSe92gH0Q6JLroZC5oszPpX7q2SnreDmcR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2935269"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2935269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 17:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4606473"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 17:43:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:42:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:42:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 17:42:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 17:42:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY5COqGVT9ASKF1qS1ZlXU7WjTT94EUb+Wu/Kn8bJH5DHPGkSBYzmMmPFT55e0ybg4fY5SU4ldUbR01RAmL9wEZyDqIWzBzNv1nOdKNCXVaRzWLkCPWPOM17rgcCn+ovyOBUfpMAsXiohRQjJFMD1jIG/22glMYT95zzZAGrOfq0aOGFT67wcc7RtYtqzXjpKO6ptq2owv39ysDz5sbJIRXxTKE36K3VshiROo2MC2XUDonKT9SmjF487/+FzMhDATZG9GTZefGvZzWlkmAVyb7eCYsHOKbl28wFj0sWRY8HvVUJIum9AZ7Ri8YWnDQH0adY4KXEOjIGwhFJlN2TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKDOtxCsmtqe+9+Kgp1e7dY6B0azLl796AQgbJNMn+s=;
 b=JoQTsMp9IT0p/EAP+T1fPHTPr+SzA/0HcOV73aauhQrpdKmaAyTA7ujgy34VeubMtFOHYIzTjBKVizecN6WNG+JoipZebuiG5+ATtV5OQTpKehhTOGi8rLafhpBtqxudf/Al26q3/6bTJs6wd9TZmIPI8i1BMLGS8J/wscLL75ADugWtqkBPuKn0reiosNOg5yMPORnWFKIySBHakWUBvK8QtPc7BOkI9mOkmLiUrDEiGJ7fY8ouELl+/hplIn9kKWtUzwRmshYvDtoaRj1CcBVtPgTDmvTDTAndcTyyfwF9k5/ZR3NGtc0i09FrtaK+yqoTXCY613/OZwNWYe1YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 01:42:57 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::40e:3440:595c:9041]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::40e:3440:595c:9041%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 01:42:57 +0000
Message-ID: <30dee686-894b-40fb-8e4c-5f3f1922600f@intel.com>
Date: Tue, 20 Feb 2024 09:42:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Tony Zhu <tony.zhu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
 <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
 <5012d165-e726-e3c7-2a5a-02745dd44f3e@intel.com>
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <5012d165-e726-e3c7-2a5a-02745dd44f3e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|BL1PR11MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d27d664-1ec9-4b5c-10d1-08dc31b54371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIp6kLi0MQj4v3k4xSrKhjN4tnyP3lQy4sQ5qZs2XJGLhZTJU71GOxeGX3SocVECisB1pGCkUMPNn93Y5A4v7GEtOeQv59OyNGT4chGLBqtdmfe+6pTE46hruOUKkFpy0RICY8HAJ7u1tPtah0kdbm5okpd2kKzxz1XflFRu5qMIYCaVcUqAHKIkppAFxnVmLBTAMB0V1BzTwQ0Fzk/OsPtdFgUh3MvgUfz/m8uX5MkIxyL/e8BZc8slPIk01qOmMW82FvSF8nDL8hTgfFgDEY0DQDBRT28uF6d7gwHXLo3D3o7GOAbr/B1zF4o+z2gyGoVNC+pixoBzR7l1RUX2+Zt3ijPyrEWEirwVBeJxFbnQfMtRRBtRwQ1Il/B5OQ3l2UM5oUzYSP0xqWwTh1PkvmXZQmr4qnr97QJ8zyA0srBsGhdoCCbdYrxk4PzpcjXgXHcpZDfeba7KhBB82/yZZHF2bMUX0ltGXu1+UK8nldunYEo+9T2ldmYgqdcPB1uZaE0cFkJYMZ6P7ynpuCrgI3YB+GChev5Ak1YYQKN8Bzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDltaTZCSDhGVk16eDVXV2c1TlVZRUtPbUx1aFlCb2I2azIrM21ZblczWFdS?=
 =?utf-8?B?QXFBeUppOXp5dDNWbExIcllYNnV4cTY1YVJZaVZ4U3dMWlk2QXMzVndLNUZv?=
 =?utf-8?B?RjlQTEZQM1hUMjNNNTVwMndIMjFxbnFwTENjNVJIVS9PdTVoTk1VUnN4ZzF0?=
 =?utf-8?B?WDB2M3dHRXdxVExEMnNyd0psdEgzblRnMnBxNnJTc1VJZldZdWx4QytzN0NJ?=
 =?utf-8?B?SExNNFhPTTZYR3JkNUNIS3NzNmN5R2c1UGdWNVpvQnFQSVFDcGNLTlhIR1ZL?=
 =?utf-8?B?TWxPOElReHhTVXRSNnJJRFYrM0R2TS9OZXd2b1o1bXJnMk5iRXFhbWV2U2Q2?=
 =?utf-8?B?VkJCTlUwY0FOK2haRytlK3piamJCbVdocjd3alBvU2UwSFJNVHBTYnBIeVZx?=
 =?utf-8?B?dWJtcDVQUlBQS3pubWtScVhvOERqWWtUeHJsVWloWXVJaCtncyt4NUl3UW1O?=
 =?utf-8?B?aXhxV2dCWlVSMnBBWW1DMU1HYndCNnpQWDU1REhUV3JGRERTcHlBNXBhL2Ez?=
 =?utf-8?B?QUZYWVhpRUpjSDVySWpwTlRjdTB3elUwTU1QL2RYcVN3OEZtQnVGZHhqTytF?=
 =?utf-8?B?UVV0UmhuY0dPZTdxWDVoVHorZW9jTGtORDVoVmNOQ256c29OMFZGTUU1UTMy?=
 =?utf-8?B?NGhGSGZMWGtPR3BLbnZRaHN2SmhLWTJKdFVaQ2pGdTUrUldycjlHSElmYklI?=
 =?utf-8?B?NEttek9yRnFLOTF4d3g0Y01NZldDWlM1dG9IeHRkVFprOGRRUXFIbTRXRURz?=
 =?utf-8?B?eUd5V2VIMkpvZmZ6S2JEVjdsc0pGVUlsOURUc0dFODdkVFpNZU1rNFVTaEhx?=
 =?utf-8?B?WjZUVDdvVHNmc01qZXY4YTRwRVZYK3ZNa21oaWhWTlJIYnJGN2hHUGcxTzkv?=
 =?utf-8?B?L2YzMWJHNWduWFMrWjY1aU96TkRoOHdCb2txZU1iQko5UTVFVEtXdkJWTVdJ?=
 =?utf-8?B?bnFVTStkVUszYk5neU5pTlI5WldmZDJVRjVyeHZPMDhYYzNrVmxLQldoVUUv?=
 =?utf-8?B?Y20xdGUwcnAwa0V1azBLaENINndHNDYxZEI0UEcyVE9ycTNBV25Rb2VFSnBj?=
 =?utf-8?B?TEcwRnpNSWR3QWNuZ21YTmt5ZWFIU3FPcXplUVV0OXJ1K0RsUU9TcnhLbzNM?=
 =?utf-8?B?ZEZKVWZKM2piT09kdjA3Slc1TFFRQzNEaFNIY0JZZFhjdnlBY29ZaU5qS1NJ?=
 =?utf-8?B?dHVhR3VEeDFjN29FbzZaZTEveHBZdXUycDVFQ2J3Q1BSTTF0ZG94TUU2VjB0?=
 =?utf-8?B?SXNMVTQrbk1jZ2w4c3lOMHJ2eEZjOVRDa1pXZ3FuV3ZXTy9yMkswanpPUkVn?=
 =?utf-8?B?b2dzeDVjTytoSXgzVStucncrNDliZUh1dGNNdzNYa1JOTHpjNThwa0djM1Aw?=
 =?utf-8?B?N2grS04wVmgyWS9NYkFIVkFtSXpnVXM3RGwzNVc3TUk3U3JkdW1JNXJhcUY2?=
 =?utf-8?B?MnlnMnlVa09qbnlOajJVaFFDNHFBcGVDMjI4cGpVUGJjSHdnZHpqaTNuak9u?=
 =?utf-8?B?dHJmaW1TbEM4YVlKRklTd1BZSHpZdnFoV3hKMDE3aWxkcjYwUnJVRTkxZG50?=
 =?utf-8?B?MEFaZTE2MFpxOXNMVVdmQmdYcWQ2UDN3K3hpcVI0bkl6anFrZURBaERJSVpZ?=
 =?utf-8?B?Rm8rLzYzRlRXMCtVdGt1Z1EzSnJRcnoyQ3BRaUhueTdxN21CaHFwVngrMnZj?=
 =?utf-8?B?S0pMQnJ0V0lEK0lUSEQwSEhyaUt3ZVBwTHoycHFaT1JIaDROamozclZBcTI4?=
 =?utf-8?B?M253VlFHWGhIZWQ4M0RydjhOSDFyUXFHTnhsRWJVTTBPK3JISGdrMzBXRGdU?=
 =?utf-8?B?WEJTL2tMVzI4Nm9mUmlTRFhMc1ZiOHc0Q0VKc0F3SlFWNFFrZTNqenBtV2dL?=
 =?utf-8?B?c2RlcFdmUkdueTRIZ3BSN1Yza1B3di8xc2NSSnJPRFhPSC9hZEwwSXltQjhk?=
 =?utf-8?B?OHlXaTFLM1JoKzhuSVpPZzRkOUlvOUNUSjlOR0NkVmtzUUhDL0dha3hFOW5N?=
 =?utf-8?B?b1BxRXVCOU45UDBCK2xJUzlaMExrdEUveGlDQkxqNWRTNkI4bGQyTE84NFFU?=
 =?utf-8?B?czlVYng0ckppNWQrOGU0dHNRNEdiYUtNSXBqM1RZNnFwVndSWVhQcjNQdjBw?=
 =?utf-8?Q?LIIrF4mALG/thPS7jU94X1Owc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d27d664-1ec9-4b5c-10d1-08dc31b54371
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:42:57.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oPm+wgZeFFcbUyVm0ch+lAwBsVMoX+LU0UbrW1G+nBKLdWitmdnl9zJ6pcWX/JoRxM71CX4VbAHDMI2gGT4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com



On 2/10/2024 8:20 AM, Fenghua Yu wrote:
> Hi, Lijun,
> 
> On 2/9/24 13:53, Lijun Pan wrote:
>>
>>
>> On 2/10/2024 3:14 AM, Fenghua Yu wrote:
>>> If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
>>> event log cache to user triggers a kernel bug.
> 
> ...
> 
>>> Fixes: c2f156bf168f ("dmaengine: idxd: create kmem cache for event 
>>> log fault items")
>>> Reported-by: Tony Zhu <tony.zhu@intel.com>
>>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>
>> Reviewed-by: Lijun Pan <lijun.pan@intel.com>
>>
>>> ---
>>>   drivers/dma/idxd/init.c | 15 ++++++++++++---
>>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index 14df1f1347a8..4954adc6bb60 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -343,7 +343,9 @@ static void idxd_cleanup_internals(struct 
>>> idxd_device *idxd)
>>>   static int idxd_init_evl(struct idxd_device *idxd)
>>>   {
>>>       struct device *dev = &idxd->pdev->dev;
>>> +    unsigned int evl_cache_size;
>>>       struct idxd_evl *evl;
>>> +    const char *idxd_name;
>>>       if (idxd->hw.gen_cap.evl_support == 0)
>>>           return 0;
>>> @@ -355,9 +357,16 @@ static int idxd_init_evl(struct idxd_device *idxd)
>>>       spin_lock_init(&evl->lock);
>>>       evl->size = IDXD_EVL_SIZE_MIN;
>>> -    idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
>>> -                        sizeof(struct idxd_evl_fault) + 
>>> evl_ent_size(idxd),
>>> -                        0, 0, NULL);
>>> +    idxd_name = dev_name(idxd_confdev(idxd));
>>> +    evl_cache_size = sizeof(struct idxd_evl_fault) + 
>>> evl_ent_size(idxd);
>>> +    /*
>>> +     * Since completion record in evl_cache will be copied to user
>>> +     * when handling completion record page fault, need to create
>>> +     * the cache suitable for user copy.
>>> +     */
>>
>> Maybe briefly compare kmem_cache_create() with 
>> kmem_cache_create_usercopy() and add up to the above comments. If you 
>> think it too verbose, then forget about it.
> 
> It's improper to add comment to compare the two functions here because:
> 1. When people look into this code in init.c, they have no idea why 
> compare the functions here when only kmem_cache_create_usercopy() is 
> used. The comparison is only meaningful in this patch's context and has 
> been explained in the patch commit message.
> 
> 2. Comparison or any details of the function can be found easily in the 
> function implementation. No need to add more details on top of the 
> current comment which covers enough info (i.e. why call this function) 
> already.
> 
> Given the above reasons, I will keep the current comment and patch 
> without change.
> 


That's fine.

Lijun

