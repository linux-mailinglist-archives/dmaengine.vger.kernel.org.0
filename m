Return-Path: <dmaengine+bounces-1044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9D85B099
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 02:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48991C2160B
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E49535B9;
	Tue, 20 Feb 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWH9M3Px"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44D535A6;
	Tue, 20 Feb 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393437; cv=fail; b=sucis+jYiVjeiwJ9/Cf/lZ9djX2hH4sAGujzNxV5I9pxsJHnjDd3lQdLT7cVPW1Srp09iN590FUiGmAQjGO6lpwAw0sLuNQlW/T831RvEhcDzftCZiYvnDAgKQ99+XolHsJk/+IDGYrHnWrfNxvNYkvisfo2QqvbsCc3k76B0kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393437; c=relaxed/simple;
	bh=tDDdS1nxbz5KUfGaqUVL5kSg/6e4L7UgRBazCk1SWhU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhTAIkk2vQzwEiCn1KaqY1/B1pehc2aFq9/vznDgEusHRQTq1pvIp0mwSeE/sFKIVnd34x/xMcgssuVRUx3GrZp+fnebB3G717Pl6ACHML61yIonXJtUlz1oacHEcW3LBQNG8/paMCGstimSPH7jdauNlYffZaOXo2LbgW0s6z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWH9M3Px; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708393436; x=1739929436;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tDDdS1nxbz5KUfGaqUVL5kSg/6e4L7UgRBazCk1SWhU=;
  b=CWH9M3PxAFwtDrwpM5NM5gJ5bD1rJzQPKIKgWaBly4O3fITfK8XmABWt
   JOauuP7/4a+pMaPdC4TLREJE9mcxwCwCoIoCT+um4DgXaXiU5eWfa3ouz
   K8ZBXFypwIyjsHjMnnVJ5uP7e4FXBD5lLVL9EeB6RbgrKu9I0sBmlY33p
   Ft+oYy8nv92hnInVxOS15h5XAr06YPFnKbe/q5bAHPXcEGNoW6ORzK/+B
   RbbvxtKQE+Q4xHEh3V9/6pJbT6ySbnYJTfCPDv7U11ggsAXW46CriPWVJ
   kToASJnZHlJ1olaFarhJCjzuqXw2N3moi94jIuw1K3Xg82E4eD5voH2I1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13032007"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="13032007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 17:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912975349"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="912975349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 17:43:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:43:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:43:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 17:43:54 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 17:43:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8hazGXPRpUJEr9SsMTILykL2ep8jczP1Cxj/01zcvj291UVonMnYlz3v7jmsL1TUl3bxEC//rr3kue6pWDU45FxzsFqdBCuTH7rdk3IYBOrIDQDUlnnOwuIpo403byWSaJYq8JWvHcNJ5tShyomkggkmUwoq2rBUz96QQ4+J8ObIvdMZTALSq8nKhf4BAYNrAZSFx19uCa8D2Jjk7HjMGWEeu6SPlKzmrQ0JROz150FV6iIgxrPLFRYa2ZhSJkK27W4wFXtjoq0/gO8LfMkhpcx6J/gel6T3Ih8LdNd7u5sWUDRjwnqQ+YQF/9IF9Q9UymPOIOgJtxxb8eYJD71EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhX9yC/FT6O2uvoztiGJugZkz/SfDgD+aIifB743uw0=;
 b=HYSVoL8wryOzrgeA7taK2CkfdhCCrLoo3mUtCggID30YSlsWEy5Ul8rXfs20TyRMOqfc4sfCQqzSsJYjzNWp0waXKIfK43GJYlNdPjj2HJwKlrzR40GZcktoVFkV1IPTMXF0mLVN6O+HpSMfov5pUiFFXxUyLBEC6mQi/r3n8via0EkK+n1YHMNXku/qZS5trun7XFQrVbSmBut4mGyEAr1aLZxseiUvo5sy7Le3fVCYyDJmEfpllTGwOSjCqYXxjgr/f5V6Kc/psG0ydiCJq3sAOdNZBi7V1O50uJmJPrjcQAxwa/cWwq1FARZ6J1D11KzmjqtpUSalg/NKPSGn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 01:43:43 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::40e:3440:595c:9041]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::40e:3440:595c:9041%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 01:43:43 +0000
Message-ID: <b606216c-dae9-4bd9-a1a8-91bce67c211b@intel.com>
Date: Tue, 20 Feb 2024 09:43:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Tony Zhu <tony.zhu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
 <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
In-Reply-To: <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 378442f8-1e88-4c1c-e5fb-08dc31b55f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YCAHUGxJnek3tYUirx1CCsysjBqh/9EQYfs76USzAIbD+c5xYb8iFyTNZjx756Q+VMt2OvMmLsT8JBhPcRM08h9+Av1YddEfnOV6mRvnPU3Y8DsPaB++oQVlMPp1PnJLOrHlkoBhVJg6EWkfeqhPEnMXh4Qj+4L3mTgW6pkJA3YK49O/UoIQ6obn/+SHvQrhTMvk+/V09tcqe7ijuE0ZXYLzZMPk7R3YH/3+BuYjTLNi39f3CC2uewzlWNXtlzwekGLYtBzuntThjuAnD/CkHsEI9ZuwLroI658plsnjcoHUWZACzCmHRpJUdzjLhOUOPzQzR6LZgXfstsVbF5Iwpcrxtzb9Sh4rm7vGao1x87ig6BGCfmbgFJ029ZCZLwMiEY1WOFS0i/hFhuvAjxw7hqbhrIaW+x6ddZRsvqKFDHmDg5A8j7DlN/8SopAOh/NSA2w0/RGBPMN4jeM+F9EAu8fdpd2Jp6G1Aqth8jdBsUZXRaJRIV2bjyDs/sRhgXNJ4ZHJPT25VA/gA6VA43iAqQGAs6Xv6CT+3Cu4DDYU6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGUxaERyT3NyQzRHZHBKd3dCbUdDcUZQRzZZN0RORTlVaGgrMXdTUUQxblRj?=
 =?utf-8?B?dXd3UnNXbE5GT2JXMTJrUkJBTGhnOWs0WDFlcnd5NDNmV2ZTK3p0NzlzcDBY?=
 =?utf-8?B?ejAwRmtKM3NYWmg5NUNVbUdxaE9WY0JjMXA3Tm0rWmNLbkl4SHpZQVpGUGZF?=
 =?utf-8?B?dWdtZE1kNlZ4NEF5VFJ5a2h0ZTM1aS9PeE53dlRtUmFsUk1MWG92NUEwQ3Rm?=
 =?utf-8?B?QW4zaTJXL3RiRlp2Q0UrVHlkVGowSDlPUWxaeE1YVXlhZDdZSVoxREVMd0hU?=
 =?utf-8?B?bitVT0pjRWwraVVqUlUva3VYZkhzbEFOelhlYW9lMGx1S2pUbjZpRkFVYjN1?=
 =?utf-8?B?blFQblBCK2JjblRUMGRXaEVlTDhyTzA4YzY0anJkdzU5REFtS0h1OTljc2R4?=
 =?utf-8?B?aHVnWi8rOWhYeVFabnl3b2h1NVhGaklkZ3lQa1BNMkRXMEZhbmxBTlVJcFNk?=
 =?utf-8?B?VlprV3JiNzBVRlh2cytvaVFtZWxKa0hQQlRENHRzK1VRdDJJeTJUZFdHR29O?=
 =?utf-8?B?R3RzRlN5NjljWUc0b1VhMDFNY1htbWh0dHBXQ1M3aTZlcXlsZDhmdy9QbE5D?=
 =?utf-8?B?VHZkTmxEUWx3MTl3QmFidG1qaVVDZG5scXRKVjRLd2J5NlBlYjJBRGFsV1ZM?=
 =?utf-8?B?a3YzSms3RUNzRUR4SjkySUJaUThhaVNnZytqRmtjNWpNNTNHUHFWNnFWOVpt?=
 =?utf-8?B?b1ZQZ3p4Q3F5akJjdXk4MVlLZ3hINi80TXlBN1VMNFZDeTdRRlpwb2NQeXg5?=
 =?utf-8?B?OTRQZ3d1bGpoNVV0dEFzMlAwR0RaM2dUWlpJc1N5c3JVZy9hMGVQY09PMHJW?=
 =?utf-8?B?Zkc2czdmcCsrUGVDampuQXczRm9WMTlubUVIc2N6WTdob3NmSFJVWlI1RmJS?=
 =?utf-8?B?RVFySldGZ3JDcEtuTFBLSXhVa0x5NFUxT1BYZkxtUUZwQnRtZ2N4N2owbitH?=
 =?utf-8?B?RUN4N3dkV1pWV090TVRMbkxlbzJPUkNSQnRncGVmTDB0RFdFYU8rU3hweUZG?=
 =?utf-8?B?SElhd3NxQS96LzltNEtpQWgvUGx4cG1MV2VHZ0xZYnAzYjBudms4SnVyb1N3?=
 =?utf-8?B?REpoeDVhVm9TNzgxSEN3Zy9vSWhvZ2tmZG85LzlBM3hua2NXZEIrVmhCKzNt?=
 =?utf-8?B?Y3BVQnl5bkhKZHpkTzJTWGhPY0lDOE5NdDVMMkZ6L3B1V3FVTE9lRGUyNkdR?=
 =?utf-8?B?N20rVnpVRkhoNWxqZHFiUUhCUm8xdjVQcWZqSWx2YVdCMXFpWjNuVGd6ejk3?=
 =?utf-8?B?dGRjL01RaThLV3MwY3djblBIUEs4Rmw2aWhKNXpLcTN1SVcxS1JqOU9RTklV?=
 =?utf-8?B?a0RvU1hwUjQvb0gwcmJmNmxLekpuUERpTVBVYXlBTThObnRyVVROdUx5MFQx?=
 =?utf-8?B?TmFoNm9CRUNqMlJlZEtocUdTREpaTkJaWEY5OVcxZDhyeFRkNnlEbXdIL0Vs?=
 =?utf-8?B?UndVVjhWSytsWXRWd0JVeGV3dUtRdmxoUlRoT1RmdjJwdG9rT0JXN00wUytq?=
 =?utf-8?B?cWFrWTQ5T2NGS2p5cVc3Wjd2ZndqTWdGSHl1cnhVZEdKVmlkUjhET2xnaThj?=
 =?utf-8?B?MU5sUXFoT0VnUStBSFNBYzIwYVVwRTZWVGN1bDVVcmowdFJ4NEQ4UVpUU0Vz?=
 =?utf-8?B?WUpHR0JYdXRhYWFmcGRlbkRZQnZTbHZ1VDVYZkNRS0Jpa3U0NURCZ2pIMExH?=
 =?utf-8?B?elNyQjZiNkNMTlBFcmFtdjFOaHArNzlnTkVLTlExL2c0c080Qms0ODAvcytM?=
 =?utf-8?B?M205c1FiOXN0UktkMHdXNStPMVhlN3Nad2hjMTRSSCtkZlBIQk9FUVkrd1Jv?=
 =?utf-8?B?QUx5aFJUTnJITWxXQW1YWGowcXExT0VoM0NSUFNmUWowS0tCTDBiaDQvcnNL?=
 =?utf-8?B?OHpBaW15b3dtdndoeDFCcVdHbTZpZVN2T3RuRVhiTjdsSmUrd256TzRyaXlt?=
 =?utf-8?B?am9vcHdzYU83a3lUdk9hOEwrTzdrbzUwQk9MdjFWNk9YTEp2dEdidHErSkZU?=
 =?utf-8?B?YzYxTG1xZTNyWXFDQ2NibWVyYUVLMnlXTUl2VUlUSGM2N2tzRWQ3OVUrVlhK?=
 =?utf-8?B?bE50U0JYeWZUYjB0ekFaVVNtNitaUjFYbm5BRjEzaVFxeWFCU1phVTJBOHVu?=
 =?utf-8?Q?7zEMe3lvhaOjqM6GEN/ydXnsy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 378442f8-1e88-4c1c-e5fb-08dc31b55f0e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:43:43.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol5R/K7r5fPoWx8+8vWIUF4ExMjqduUVJ7PDmStTwD5j/18rDX97kcUX5w8qdqZhoJ81N0w02Kh/sTCLaavdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com



On 2/10/2024 5:53 AM, Lijun Pan wrote:
> 
> 
> On 2/10/2024 3:14 AM, Fenghua Yu wrote:
>> If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
>> event log cache to user triggers a kernel bug.
>>
>> [ 1987.159822] usercopy: Kernel memory exposure attempt detected from 
>> SLUB object 'dsa0' (offset 74, size 31)!
>> [ 1987.170845] ------------[ cut here ]------------
>> [ 1987.176086] kernel BUG at mm/usercopy.c:102!
>> [ 1987.180946] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [ 1987.186866] CPU: 17 PID: 528 Comm: kworker/17:1 Not tainted 
>> 6.8.0-rc2+ #5
>> [ 1987.194537] Hardware name: Intel Corporation AvenueCity/AvenueCity, 
>> BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
>> [ 1987.206405] Workqueue: wq0.0 idxd_evl_fault_work [idxd]
>> [ 1987.212338] RIP: 0010:usercopy_abort+0x72/0x90
>> [ 1987.217381] Code: 58 65 9c 50 48 c7 c2 17 85 61 9c 57 48 c7 c7 98 
>> fd 6b 9c 48 0f 44 d6 48 c7 c6 b3 08 62 9c 4c 89 d1 49 0f 44 f3 e8 1e 
>> 2e d5 ff <0f> 0b 49 c7 c1 9e 42 61 9c 4c 89 cf 4d 89 c8 eb a9 66 66 2e 
>> 0f 1f
>> [ 1987.238505] RSP: 0018:ff62f5cf20607d60 EFLAGS: 00010246
>> [ 1987.244423] RAX: 000000000000005f RBX: 000000000000001f RCX: 
>> 0000000000000000
>> [ 1987.252480] RDX: 0000000000000000 RSI: ffffffff9c61429e RDI: 
>> 00000000ffffffff
>> [ 1987.260538] RBP: ff62f5cf20607d78 R08: ff2a6a89ef3fffe8 R09: 
>> 00000000fffeffff
>> [ 1987.268595] R10: ff2a6a89eed00000 R11: 0000000000000003 R12: 
>> ff2a66934849c89a
>> [ 1987.276652] R13: 0000000000000001 R14: ff2a66934849c8b9 R15: 
>> ff2a66934849c899
>> [ 1987.284710] FS:  0000000000000000(0000) GS:ff2a66b22fe40000(0000) 
>> knlGS:0000000000000000
>> [ 1987.293850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1987.300355] CR2: 00007fe291a37000 CR3: 000000010fbd4005 CR4: 
>> 0000000000f71ef0
>> [ 1987.308413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [ 1987.316470] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
>> 0000000000000400
>> [ 1987.324527] PKRU: 55555554
>> [ 1987.327622] Call Trace:
>> [ 1987.330424]  <TASK>
>> [ 1987.332826]  ? show_regs+0x6e/0x80
>> [ 1987.336703]  ? die+0x3c/0xa0
>> [ 1987.339988]  ? do_trap+0xd4/0xf0
>> [ 1987.343662]  ? do_error_trap+0x75/0xa0
>> [ 1987.347922]  ? usercopy_abort+0x72/0x90
>> [ 1987.352277]  ? exc_invalid_op+0x57/0x80
>> [ 1987.356634]  ? usercopy_abort+0x72/0x90
>> [ 1987.360988]  ? asm_exc_invalid_op+0x1f/0x30
>> [ 1987.365734]  ? usercopy_abort+0x72/0x90
>> [ 1987.370088]  __check_heap_object+0xb7/0xd0
>> [ 1987.374739]  __check_object_size+0x175/0x2d0
>> [ 1987.379588]  idxd_copy_cr+0xa9/0x130 [idxd]
>> [ 1987.384341]  idxd_evl_fault_work+0x127/0x390 [idxd]
>> [ 1987.389878]  process_one_work+0x13e/0x300
>> [ 1987.394435]  ? __pfx_worker_thread+0x10/0x10
>> [ 1987.399284]  worker_thread+0x2f7/0x420
>> [ 1987.403544]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
>> [ 1987.409171]  ? __pfx_worker_thread+0x10/0x10
>> [ 1987.414019]  kthread+0x107/0x140
>> [ 1987.417693]  ? __pfx_kthread+0x10/0x10
>> [ 1987.421954]  ret_from_fork+0x3d/0x60
>> [ 1987.426019]  ? __pfx_kthread+0x10/0x10
>> [ 1987.430281]  ret_from_fork_asm+0x1b/0x30
>> [ 1987.434744]  </TASK>
>>
>> The issue arises because event log cache is created using
>> kmem_cache_create() which is not suitable for user copy.
>>
>> Fix the issue by creating event log cache with
>> kmem_cache_create_usercopy(), ensuring safe user copy.
> s/, ensuring/ to ensure

It is not a big deal if you really want keep original wording.

Lijun

> 
> 
> 
>>
>> Fixes: c2f156bf168f ("dmaengine: idxd: create kmem cache for event log 
>> fault items")
>> Reported-by: Tony Zhu <tony.zhu@intel.com>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Reviewed-by: Lijun Pan <lijun.pan@intel.com>
> 

