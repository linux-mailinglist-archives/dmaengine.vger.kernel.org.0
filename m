Return-Path: <dmaengine+bounces-513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A29811A2A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 17:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E897B1F2190F
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539D35F0F;
	Wed, 13 Dec 2023 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgOShYqM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DCDD0;
	Wed, 13 Dec 2023 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702486522; x=1734022522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6YC6aCPDxU42a4qt+JoaUd94uuWHnHRRaz7zBFO2jSE=;
  b=SgOShYqMevgbOKjXckh4QoJv0CUEP+CFnntlqdQWQPLDEpYoGwj7XxpH
   ysDL70CW15Rx1S9/PjLMRH9uRTjj0+y2p+zUWjAMEeF2R3KuEdR1DcQg5
   08b3dNbXLwE0RDltAOWM6A00YWgvh9c+yQ+xYaqpEw//NzJyHosZi6uUD
   tR7ly7g9aLLDSf3HajKc4NON7Ua1yb5R4A/8g56+TWUALp+P6m8aTGi8P
   kjGz+tFYdD/vSTjFcsPDkCD3tJxrggT91f/pputaZQB5D6yeYQ0r6iDIn
   hw05hzLlIRczHE89090tnGvTCYozNymZKZZIxJkdQzdOoU1mzXczzjQkI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8384567"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8384567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947244346"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="947244346"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 08:55:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 08:55:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 08:55:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 08:55:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 08:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3hDDZ8xz4xM91AhzmMvYYfz3TgOPFLLdUg/2DgMvWGl9cai5/R8CRC0kG/+kouEvjwdjFLg0qEHxlgAgLJ1v0fh8T9wibE7gl+2KELS3qHL6PyFNqZO/plwT1rRlistEm4MbbWFdnX2UMnVBcoAS/IVeRrroK9OtW2zkjG7Mzsq2iFaTRI1XT6bQ6eif0kzqFMEQxx0YGPcjgnILBYB2iCjVo/DiZBYVe3QMO8m0k5cQamET4QwsbfKX50ikYBe1mQNcHrs8Dtr3Cit3mGVldnOo2DYYz4p2hnrE3guATaEqIBaKPkBO6EWHIxogKZjHffijeNgULGTU8x8Bk+I2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbR/v2yJSgpgG274eAYXGKVkjXju8YPUQL75GLcXMmw=;
 b=ee1nKy1umCGN46rRDPIIGStkGoXfjH1BywByZd3QG8g/JWxPFYSUx7mWAnFzUwUHhF4VzAl0JHUYskoB+8JSt0qdCR2t2J05n8ZErN8/EP7vQ+UlxIRDNTTQWPvH75bInnT1VAoEAvYE5NHyMTqcmtL4nbGKKYj9eWXyhzgPnItGRuPlgG50AGdRzJKapjkmuUN4EwT53VOqNTvg6cHSgGUkc9dRxIMa3nLNvjKK4bEfRJlCmVoQsIuStM5QmVk3jhO/RuC/6vXdseTisQ5leMoBzBuQwzZfQ8bhnB1Zrw2lk/Vkxg6oc0RGNg4Q/83j4UC/oee3XJqcJqtHnYpWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.37; Wed, 13 Dec
 2023 16:55:12 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:55:12 +0000
Message-ID: <be59d5ac-fabb-4a05-99d4-fb281f7ea507@intel.com>
Date: Wed, 13 Dec 2023 09:55:08 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] dmaengine: fix NULL pointer in channel unregistration
 function
To: Amelie Delaunay <amelie.delaunay@foss.st.com>, Vinod Koul
	<vkoul@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20231213160452.2598073-1-amelie.delaunay@foss.st.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231213160452.2598073-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 5596d7ac-654b-4b78-8e42-08dbfbfc4571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2KSco+GIORbfLvCldrtSABhiN4ScwcwNo2C0ph29B+Rt4iPyyH1qPKFqkCj5gcidAcH2Jpwj0EPFjLHB6/fN2Aymhdwc4pWdoapvlft2zYt4WBAbPIZIIAc0p8NXfnNMaDZ6ZeYs17h+zvwCv84T1kgw47kQ2t9ptoIQ0gKmPp5WmYREwI5ST1hkioa3JtNtwBCCDhuTsXWtSK3fmHBFtBnm01A5JbQ/Do5BD5Kyy+LlNiVUP9ei9U3W7WjPUN7cNb4h6TEmc8Rcq2FBOSrURUQgDa0cTLazzrRIt4HvObgZZz+TSBRRbpA22t78zx1dXlPJJCZZJ7c+n7MTsOf7Iwt/YfM9QDKroT99ksJ+eNgo0LxpQcy2pPpunLpflP9sfnAiOX7zyl5qGn+/FkwxrnwhM1x9UFfsAbWX47ewwwMtWuDJ0muY3HzoPlH/13uPQyu+2nFCuHC/8TJP3q02RTuqhdviRtxR19HUnxPwZwqaISk+Yjts9xL/P57XfRAOe2fjbjpwHWNDOGAvTKOkefo2s5lDY55RxRv6CvK65JXVuLrUH4D7sNoQHXlOG3dV5cngQPquMc/ws1JFbCEdBR0m+sjygQh96daivHMFXQ6zPz+emaJqJN8CZUlTqei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(6506007)(6486002)(38100700002)(31686004)(26005)(83380400001)(2616005)(316002)(6512007)(53546011)(4326008)(8936002)(5660300002)(8676002)(86362001)(2906002)(41300700001)(31696002)(36756003)(44832011)(6666004)(82960400001)(66946007)(110136005)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHd2a2N4UFFsQ3Bud09vNE1iUU4yQWdmM2NJclZYSnlpRjR0L0dkSTVsSksv?=
 =?utf-8?B?MWF2MTIyb3JZYXJuRDlyUTZXLzc1TnRjWk1HVjNFWW4vSWdrMk9hNWQzbTZt?=
 =?utf-8?B?dEdCSkE3WGJMdzM3UmhyUUpZU01ORHNPKzNLUTV5c2U2ZitrTXBCOWxJK0Ft?=
 =?utf-8?B?Q0l1bTVJbWEyOUhQYkI1N0FESEMzZWRYMUpCQlZoeXFVclRlUkJYUGRhRFFa?=
 =?utf-8?B?RW00TUNGdXZTRSsyWlRlZi95V1ljYjJ5Y2R5YmJQd2Y0Yk51M2UrMHVuSits?=
 =?utf-8?B?c3I4Y2Z6aGpvK1FuVEt6cnhBV0U1R1U4VkhBbDV5VmlLQVp3MUswN2xOQnQx?=
 =?utf-8?B?K2F3MEtyU1dQRlZmd2xMTFhON1dYRW5oZ2lJa0dIL3U1U0t4UU5Ta3VjaDJm?=
 =?utf-8?B?bFc2MFJXUGt0MlVjWHlZeEQ1Y0pZc3lVRjFFRjV5eDBudU40aHdpTEVWYUY1?=
 =?utf-8?B?SkxCSTBWRE1oOVRGWmNscXdZQXo4eFp4cGFpS296U3hEN1VSd2VUemorZzdh?=
 =?utf-8?B?QVJKWThtSjk1SkZFWDJyL0JyUHJNZno1RUZlbkVadTBxYlhhTTNsTmRuc1B5?=
 =?utf-8?B?S2tIOXdQWStXbm5uWGF6SG5RQVJNbG15RVRtdjJFb0ptdEVxVGJ4YnNhdnpF?=
 =?utf-8?B?RDFVWWxhYXFrVXRKQmNQZmZRK1FEalNKamkreHNEUCt5dHJlZ0pIYndERzkx?=
 =?utf-8?B?VG93SUlmMTVXekJXWHlCZWF4VDBVWlRoZHBpaGtmdFRPc29sQ3FwSlI5L3N4?=
 =?utf-8?B?Rk9nYlZSSmxtQVJCVHlTZGoreElHMUNwbWVJTE1NMTRRb2NpT2o4czBVQnQr?=
 =?utf-8?B?dWNqemh5bG4xTG4vdU5WQTFmTXpVbExNK2pUeWwxZkJsZGV4blVvWmx4YVIv?=
 =?utf-8?B?S0VLQ2pJOEZ5VmtDNHRSUkZ0Z0lCRUxveElGTld0TW8wYWlRb2RQMW1PVjZ6?=
 =?utf-8?B?NkVDc2JXK1VIVkpIcUQxQXNaU1NlRS81WkI0Um9YS2l6RTF4NGtKcHZXdWRH?=
 =?utf-8?B?V1JGckl1TVVJNGhLalEveUozMDR4Z2EwZ3JRZXByN0dNWkg1QVVtZmt5QThW?=
 =?utf-8?B?dkM2Ykcxa0JBeTFzUW5nWWZMa2tDb1U4Wk9GRzFBdzdYMDJVbSszN2NLRUFu?=
 =?utf-8?B?ZCtXTlhNemFrdGpwcW5XaHV5RnF5VmtWdTlhMlR2T3pzUTN1cW5saFk0aHBE?=
 =?utf-8?B?MHlOQ0JFbERBVThJZ1RBZk0yWkZXemt4V3pmVFFMYXRkTURWRHpVRVRDQjhP?=
 =?utf-8?B?OVE0VnJZMnZITWpJR3p2T1RVL3UyWnZIaEFEYmpIRUZ5T0hqN3dBNE5LdTFI?=
 =?utf-8?B?dEo1L0RDajBHb2F3Y2FUQTFieEwvR3NOaHlFMHR0Z3ZSN0hzQSt0ZHV5R0N6?=
 =?utf-8?B?VjZRcVhzeFEweHYwZDZjVVZIaDQvQzN2K0haL2dEbDc1bEF4VHlzZENsUFVC?=
 =?utf-8?B?YnljelBiWFFvYTBIbFpQYVV4bXdYckxxSHhsZnhPcTVRZmtPRS9FZFJYbUZu?=
 =?utf-8?B?aHhxWUg1R1BVcW9JMlNNY3dWTmQ0SDF3VXEwcGpsRUFTTkpJMzRXeGtTUDVj?=
 =?utf-8?B?SW96L0JnUk0xeDNRMVl0UWRQZVkvT2hOY3FkcGh2QXZ5Ym9venArajRXZ3hm?=
 =?utf-8?B?SHQrZ0U2MnlET1U1bFJMclBrVFFFRTQ4MVYvcHhDUnM5ME1OMTcrVCtTTnpi?=
 =?utf-8?B?ZWoyYTZwZzUwRFU2ZVRGVDlDbDNpc2prUWVpRmszV3kvZWdkUWNIQWNHcDI1?=
 =?utf-8?B?aUVwdXpSL3d0MnZhT3pLMENudVRMYmRneUl0TVJlYVp6TS8wanBHVXJuOXNI?=
 =?utf-8?B?NEZ6aTEzTGt0eFFEZHpzWVk1SnZrbFM2OFFmNTNENkhHWnkwQytHaFRKZ0FE?=
 =?utf-8?B?Mzk3TFVodFlJQWg1VFVjeExZN29zekNiMThPSTA4MU0rbWVTSkc2VWt0Tjhh?=
 =?utf-8?B?dVVzcVVKTmFSRi9GTnN0cGlCbnBQM0NEdVZQSGRqQmgrSW16K2NCMnRTK1Ja?=
 =?utf-8?B?TVlDdDVIa2p2QTQrYXd1R09jdVMvaFNPamhRQmF4dWxnVzU0MzdiS1JBWVVC?=
 =?utf-8?B?Q1ZwOUVOMUJBdXUrSDYzS3B3RVl3V3J2dlQ4MzVhbS9xaVBVWkU0dW40QmVP?=
 =?utf-8?Q?SHkfH0cm2UlHxbRHp/nSTpiyp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5596d7ac-654b-4b78-8e42-08dbfbfc4571
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:55:12.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjYGiwlLCROQp538OSVKKHYoQ+9geoljcDu0kKxTjQ439yaQfwFvHE6Q1cgd30XOZwPCmWMrgclpgGhC+0d1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com



On 12/13/23 09:04, Amelie Delaunay wrote:
> __dma_async_device_channel_register() can fail. In case of failure,
> chan->local is freed (with free_percpu()), and chan->local is nullified.
> When dma_async_device_unregister() is called (because of managed API or
> intentionally by DMA controller driver), channels are unconditionally
> unregistered, leading to this NULL pointer:
> [    1.318693] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> [...]
> [    1.484499] Call trace:
> [    1.486930]  device_del+0x40/0x394
> [    1.490314]  device_unregister+0x20/0x7c
> [    1.494220]  __dma_async_device_channel_unregister+0x68/0xc0
> 
> Look at dma_async_device_register() function error path, channel device
> unregistration is done only if chan->local is not NULL.
> 
> Then add the same condition at the beginning of
> __dma_async_device_channel_unregister() function, to avoid NULL pointer
> issue whatever the API used to reach this function.
> 
> Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/dmaengine.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b7388ae62d7f..491b22240221 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1103,6 +1103,9 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
>  static void __dma_async_device_channel_unregister(struct dma_device *device,
>  						  struct dma_chan *chan)
>  {
> +	if (chan->local == NULL)
> +		return;
> +
>  	WARN_ONCE(!device->device_release && chan->client_count,
>  		  "%s called while %d clients hold a reference\n",
>  		  __func__, chan->client_count);

