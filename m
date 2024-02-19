Return-Path: <dmaengine+bounces-1040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11D85A9CE
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91101F22340
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BC446C4;
	Mon, 19 Feb 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iopo+4MV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909727714;
	Mon, 19 Feb 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363256; cv=fail; b=gMy41F4+hjrU8tOlHeLsaK98V9f6gViWQl7AR+zarSF9VDW6kNnPRB+DwpHrf1rBbFF4IsyA+F9wjMDG8VrCtUR2zw+SzjMKOWcZygt+3G6VWRqophySg26v7uJF8XKiKQxtnZZPEklnZmitbMj3gQOp5Wr7kNZaEa5Nvw31mvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363256; c=relaxed/simple;
	bh=mTF3N52Nb/oMdp7ie6MNuJ9d3KWyAvuPjBpFpcmeB28=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrqB7qWu4+7CD2MePxCiZOOOUe8fcMuG+hDUyvkmvaxN4GIR+Xwp4jB9M4RoAmCPi1mNzocow6hdtkN11I7S03ko2VVxZ7UlXaeDwCkOIwnLYNoAiVvxG9L4Oox4M7/DKO4jy6cxKVr0+2qLn8FhtXj9lO8jJ5FJz2lm+sgxttE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iopo+4MV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708363255; x=1739899255;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mTF3N52Nb/oMdp7ie6MNuJ9d3KWyAvuPjBpFpcmeB28=;
  b=Iopo+4MVNYXkZwkM/ZZXCGyO7D8j8H7s0hOfOGy1KkGCIm9No87kVi5o
   kVOpLa7ehDMT2PTEQHW1OxRYfYiXe0U1Xkzue12nf6G0MBP6+2tkKumC8
   amBWmPBJEk7XLoV9nb5H71bT90KP9jKwZQvmWY15R4PX+9r48zYWgaClI
   G/MNS0FJDcvUnKU4PNegToUAAgj9/y/PFKFebJIG+AEx1iSlFoXiyMWFH
   e5+bomFBd+Q2EJR+/odgQeNyYj/pZKXjzoYB5tzjtxpQMcVwlD9L5oAXH
   WATAF9IKw8GxPOpwdrm6XbJTEcKIYTGjqTJbyRZT2STiQoV1znOHbOqSL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2316208"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2316208"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4934627"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 09:20:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 09:20:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 09:20:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 09:20:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 09:20:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICkS79zYAn4QdDG1C9hhACtRrtZt9RakU5rhwCNKJqzwJjFSdxWwuxbiamzyjquvtCjPOCM0EhVMZ+Gb/1gBbQv42NnQ7xg3dKyiLUBWGjS26ZtmyxuLZKZ9t7a08dMQLYkFyzC7mLNCrZ8Xl7gck1CSH4FRV432GTm2HGiBubiyyvGvRzd3XoTnNDG5hy1Tc6zIf5ffciI9oo4W145IJNHkIlEgqMIXPGHNGBvsU4wbIFe9pTGl1/x1VaVt3XNnHQ9AZB7Qsn+EHTaKdN7OZYkomHz93ChyVR8gx6CJytUPuTdmTMwiJViMX+YOqC0Imen0IbZIWB8f8ARI7xslQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGuUxbwz1fJwhw7VX0FBL8VQvGX2KJOQy7CTwXVDpz4=;
 b=RSmDoKE8pkirayjSxeLszwAfJqa04wcnWu8d/OX7OTlnd+MNotG2+kC1hY6WkNyekZwEh81yviSo7/iA2qdKoQA2cwu/raTaZrtvWyLyYkkgP6Vft6Fk7v/t2J9/3oJa+2JJR6xRFBikrO2TyZDA98Qq8kc1jjrHVlTaUuAOkxGkDHXTxehRCI5pwCBdIYmd/IkOreHKUJjPXGf9+4exQTLbpG3guW5SiQZsCv6Hoj/+t6CP5o0vKFhN/hi0FNd8KZjIcqHxgovsi9cYx8//B66ZXG0P9rHbP+dAkwux1HBeNlkJGE9v8XXKZrFn4h2hMLE1ynl/oz2YWB/mhy0LuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 17:20:51 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9c3:d61a:c2c9:109f]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9c3:d61a:c2c9:109f%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 17:20:50 +0000
Message-ID: <82d6f21b-3bc6-2094-385c-f9ff849203dc@intel.com>
Date: Mon, 19 Feb 2024 09:20:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
Content-Language: en-US
From: Fenghua Yu <fenghua.yu@intel.com>
To: Lijun Pan <lijun.pan@intel.com>, Vinod Koul <vkoul@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Tony Zhu <tony.zhu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
 <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
 <5012d165-e726-e3c7-2a5a-02745dd44f3e@intel.com>
In-Reply-To: <5012d165-e726-e3c7-2a5a-02745dd44f3e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BN9PR11MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf2e7d6-8ff3-4057-39ff-08dc316f1ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTDCWgPtxUGTvraVTDDKh1s72mX3ZqN9EI5Zo+P4FgbvJcvbiEOvMiAVQhg7M9N0GkfdsnyAXhZ0dBMLQ5Wtw2gIuaowj6kDM4foqbme4RN7GiBcjPc/k/ZNpRv0eR9Mh/G8dJfEYEMU06q+J+MkgKBq8j2zB+noMfq5jA85wNoDMEWGFMzzFjIzZv/F3OhO3UNgjOgd4lL/uXSruFgTq/T14YQ+4VYxaeoJtQ+MgNt1i+ZEE9QAj5wK4sMJg94y7i2fVKysfCB+MHVVM9YZlUY85JXXbfEQneAU1zyw3pUFXYM2cvDawcw5ZA6Z5bjNSLKL826SsWiCWfAKZ6rAT7AQXqijXr1l+AT8dzzi4taKl1HlCXuyNeAP8cMcNszWAvxFD+6URxt6wWt134dJgvLQZ0LQuxUOMBz8wwAQKJp3u+evol0PSF+H1fuMuwhiL5fPtT68KAaslxHoE2tqfi499dJyxR5C7xkUuHQcyCfva2fhfPi26XQz/6Rm9kiH7VpWc8n+RmCbI3yBIl5vcYoIRz8mQBA8ucaNeJvLS2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0N5M002SUNYb0pFOFl5WDNCSUVDZ2JadmVkVUp6QWRUYUw4Q2c3OUNxVEky?=
 =?utf-8?B?TkpkdUhSYzJSSmo3Q3hLUnpGWjRPMW0vNituZXl2MTcyZmU3Z0NxUi9JMmpE?=
 =?utf-8?B?bTdhMnlEL2hLbEZtOFZJVTFOeUdSS3lPeUpxNHJqaGJuOFVLUWtBbnFaNFda?=
 =?utf-8?B?aE16L3dDc2hSakN0d2pmYzgwQnAydURFWlhzaXRYVGtvc0F3QzNQcEVDRU92?=
 =?utf-8?B?TklQVWZvTkZkbXV5MTU3SUpxaWUwV1VVV0VTNnhhVjFDQ01EWEhSUFA5RWV2?=
 =?utf-8?B?RGVCU01nQTNSTExOMVM2SFNZNkFWaitvZzdsTHNsNlZOTmU2OWhxNVYreVR1?=
 =?utf-8?B?K1dKaS91ZXpLNDNpU1dqTHl1dHNpb1k5VTlobFRhSkNvcDM0YU4rZVEyN2pv?=
 =?utf-8?B?eGVpWk9NRUE3TG5kTU9UNE9vSVV6NFJtdERkeTFqSkNGa2VnL2xXd1kxdDdj?=
 =?utf-8?B?OTdhNkJmUUF5cFNxcFJWNXQzR3phMldvN1RLTzltYWZFMWVKd1UvQjkySmto?=
 =?utf-8?B?UnpsU2xFUlBYWldVUDlUZWs5a01hcC9OcjF6bzhzeXhWVTBUcGlNZGhUV002?=
 =?utf-8?B?MHI5NVhzSmNNbGxsQzkyUXcxMy9GamFNUVpkMmRIUXd3dEE0ZDhyeHdtK0or?=
 =?utf-8?B?am9ncVNYajViM2tDbk96a1owb2xVNE12SEhHWEZNSkRpU1N1ZnlCRlJDK1Qz?=
 =?utf-8?B?dXNYSHRvWm90RUdpZ0ZKcWlnSkh0WXhQeWhCb25pZnhyNytBTE1MbCtVUFpw?=
 =?utf-8?B?bzBSRmtiZmVuUWxlbEFqZjh6QlFoZHZERHVxTXFkRUlITmozaEllWkdBN0xl?=
 =?utf-8?B?R3lXcExweWVJdHlteHVnOHhYL2oyNTVla3o1TXVFUTd1NzlNOVVNd1NWbFlW?=
 =?utf-8?B?UExVZmdoRmJHcWtZVlNvVHhpQjJwZ1E0aGcrLytWOWxKTFprdnMvYjh4Yndp?=
 =?utf-8?B?ZWplQmNzMEI0c0hCTGNVZTUvM1kxN2VnYndMTWpNdkxQbG1SZzNCcWlhWWgr?=
 =?utf-8?B?TnloU280UFVDdXF1M1BqelcrQ3ZEcysxa1lPQTFaZUVmMGVwWHdZc0c1WmlL?=
 =?utf-8?B?Rjl4NmFjZ09TdVZ5TEZkcjNOWWhDTmZhb2RDNExkSkg1ekpXaGRjRnRhVHo3?=
 =?utf-8?B?dzhNSFc5MlM1ZElrNDJJdXhDTlNLdUFDVzVMTi9sU3NjTzBEeEUybUNhakRQ?=
 =?utf-8?B?YjF3aTB0Z3o1T0Rua050UnI2aUxiMis5bGlReG56M29SRmRmVWdWN3Zod0JD?=
 =?utf-8?B?ZmdramZ2TSt0ZlMydEswMGwyUkplOTVLQVcxUVFsaXhZcmZrQ0FsRmkrY05y?=
 =?utf-8?B?QlJkbm9CdENheXdZWEV1SFpoT2dGcUQ1bHRMaGRjZUtoNUMvVHhqWjgvQVdX?=
 =?utf-8?B?WklRTElOSGJxWmEvcVFpMWwxcmpXM3g4OHBjdnBxYnc2alZwcDVPbCtka1lz?=
 =?utf-8?B?NlNNTkJScE50K0NaMkxPQ0tNb1RtOVErVUVDTldIbitSNFc2RTZ5ZHg5Y3RJ?=
 =?utf-8?B?M0ZuTjZkTFRmZFFaZTZXSWJSTng5d3lhWVdJdDU4WFZQYWRUNHhkUkl6Z20w?=
 =?utf-8?B?QjF0YWhDUUF6UnBMeVFUbWszc1JSb2Z2bDJhSDJGdEZIc1Z3b1Q4WUNMOTdw?=
 =?utf-8?B?L3B2NE1qNThsNUhrS0J1bG9jSTJwNnJRRHZjYXJJZ2RCZDZXaC81SHZQS05p?=
 =?utf-8?B?YjJ3YlNud2JvVkNHQjBiNWh4N2tPU2pjTTRuZnJuRVNHcHhsMkRnTWNsQnpj?=
 =?utf-8?B?OVNOMU4rcEljUDhuTlN6OWJxckVkeCtlL20rOGV2cVpLTmJKWENIZ0dLb3JP?=
 =?utf-8?B?VEk0c2xXa0JLUEx1YXRqVWtuamEwWFMrck5NMlpFQW1EU2dvdXpMb0dHUUwy?=
 =?utf-8?B?Zzk5ZFl4OWFCMUcrVi9zZTdQWDN0RHhrNytCbUtMbU1TcWRiSGw4VisrS0hI?=
 =?utf-8?B?ZG44akRyV0E5bHdBblRoc1U3U1lVLzFQYjR1K0JjUXA0MVZ3dU8xZmhsOUZy?=
 =?utf-8?B?Y2hMTzNqQ0NGK01vS1ltaTdxcXZhR2RGeXJSeGxEc1VTZG5hS2Y1dUtzK2ha?=
 =?utf-8?B?LzBXaVlBYVNsTk9LTGRnRFI5R1dzbVo2VHdpYmdFVkZFL0J1dWdPNVhYZ2t5?=
 =?utf-8?Q?scN+3Z2npsTNK9xJ4xdnkA9MI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf2e7d6-8ff3-4057-39ff-08dc316f1ebb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:20:50.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkUl9U5weGQJRF2CMnS6dYS8lpq0MP25gEEalM51u7H97mnzy01gQnx2s/IobCHY1ZAtmAshlUW4b4w53657vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
X-OriginatorOrg: intel.com

Hi, Vinod,

On 2/9/24 16:20, Fenghua Yu wrote:
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

Since Dave gave Reviewed-by already and the comment from Lijun is 
invalid and won't be addressed, could you please apply this patch to 
dmaengine tree for upstream inclusion?

Thank you very much!

-Fenghua

