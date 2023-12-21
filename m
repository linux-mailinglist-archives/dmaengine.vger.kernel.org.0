Return-Path: <dmaengine+bounces-591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102E81AC0F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 02:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEC32860FA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817363D5;
	Thu, 21 Dec 2023 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/xaRo6U"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E063A1
	for <dmaengine@vger.kernel.org>; Thu, 21 Dec 2023 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703121448; x=1734657448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=unbOBMSbadbDrzlPJt4rAX5QggHK+nbXIl/XwYe+Y20=;
  b=V/xaRo6UO1x3F/vlTXMdsZAKKSPGRDw/1Y9XytoJimIkSGtbPBVWNWVC
   79rl+yiN5Wx4gja7FbXxS5rODh7tgkp8nZr81ucUUcoLsqoY6zUKj1N3q
   BkmCdmYgPgrUmYPqBflLwbFdyzCNiTcPUw81sR+k57mJOlWoakuzle7VM
   UC0WaGp6SfSZprVQIadSs50o9pRYfPOaTcTmgcmNThvD3ibGE/Iq5RDcS
   ufwoyGzpiEOx19j+nf8S9SRXSDvE02WRIQBKPCP8fU10KK6bVAVtQ6XUv
   yvZHHShWjKNC4jrWZvJTpfKVnSSlIAirfsjxoeZvvcvw/NMCsUURON++t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730442"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730442"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 17:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="949718932"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="949718932"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 17:17:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 17:17:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 17:17:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 17:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRNHyGdGjT8BkaO+SepsWPMxlYEPp1ufFzetXA1W/NDlgnwTFlKoN9WVeUjJ3JikSxFCPrHCfxZEIcE1Ag7lTO+p6TNBV3ZZxJ7nlJnNeb50QIuPxkZzxUGEHvUFydeGt4a64S/0nYMfqyleIKMVfaBPa/NgRLORTpmt4CV5/hPkDVMMXT9IEJUpKU12hOZaX/MuoFCE63l+8DGg1abaD17CzE8EetuhtyqoWXP7UnIJD4iXlUHT3fF4Gq8zgmS9IcuOvcv14hLAtQnvll6GbdKbuxeCn7vkoa/Sp/u8mwQ1SLiLGE0UULL2azcGKtBA70o5ECgi27sdHw0thsHHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFFRJILniVTKl60ihvhpy1FVDEDaapKOxX7RLdpXKWU=;
 b=IstxLPMJMZAg9crEo1Urx5qlGV1twe9kUnzKf9/8f2luqFIV3leCK+jANo6wnAzSP7Aj68oSsVAKlsb/OOe41LNMvP/j8ghpPA/j2L0+e9M6WMdO6iVFhXSlSdXuvx7Udz711jhFgC5gD2ekJBd5PVn8Q4gZ94pVch+fuNXG1OchLvK1TT6AObRZhHr28Xva1isnBIKdo/tDnhpZpakLFh5wZ3WIcvkT1KVvkw7tf+AzdqcuLvUzomC3yHMOzoqJaeuR74bQ61eRknt5anZ/b6sed/7LtfQmRGJkFCO7iTh/IagQ1G/wGKYHha+rcxVQaegfSSRXfAxdt+MowcIwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by CH0PR11MB5705.namprd11.prod.outlook.com (2603:10b6:610:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 01:17:24 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7%2]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 01:17:24 +0000
Message-ID: <511cbc9a-632b-4a7e-a57d-01a21ba904a6@intel.com>
Date: Wed, 20 Dec 2023 19:17:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Convert spinlock to mutex to lock evl
 workqueue
To: Rex Zhang <rex.zhang@intel.com>, <dmaengine@vger.kernel.org>,
	<vkoul@kernel.org>
CC: <dave.jiang@intel.com>, <fenghua.yu@intel.com>
References: <20231220035310.883595-1-rex.zhang@intel.com>
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20231220035310.883595-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D0B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:b) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|CH0PR11MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce1ffcd-be59-49ed-9bea-08dc01c29670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vMJqx3ABuATvKwkjAty23nMk+BX7tYu2VA+aZx/RjjCb/o22kT/nKXGWvHFgGubtsHVeghi++8+WBPpsixUJOxL3tpnqwZlmTczg6LFxNMBPxtDHExMACi+tYPkHVYBFjCIK63jSylHbhEeq0ZpM3KCuk9G3ikrtbvWyhJtirPue4rqgZcb84JEcScqdv5Q/conaiJABf4j4z/mtU8ZCyHSQptje+K4eA8xoJF8XUg4lLVuGIFVCwvBnWo6CnVA5cezOT2joyXQ1FFFIDIS7jykAf9z7nWCrLqaDR/dOFDgLlSjUjIyMR2v5LrkIdxG2cMkP1aM5rYKRQ6iJ9ZAsTseyfDh6+UWxsOObjVtQz5liNr5aisYvV3KZdOjwcNUoO6SZhJxQllW8F+7xTll3qwSiL5pn1FFl178NarKn2/eY+xNTwv2bKip8LV5YYJ27w2z7tEhUFG4Z4LCvJ8Kscv9HhDhctWvF4+2UwhKCs210MKR8b+giI9DoGDhZByOdbfhTsGe54xTDXLsEwCVhhtEE43WgSPNCJ50aNRTwhCdHShT2KHd2y8obMTlHz5UBXcXTaveBUmK47T6c3xY1t5QdtKaQewmcMhXIAuJ+Ecij/rw+kTBdfoGI/92TbGrXvGThID6PBmkBgLp4k7MuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(83380400001)(53546011)(66556008)(66476007)(5660300002)(8936002)(8676002)(2906002)(4326008)(44832011)(107886003)(66946007)(6506007)(6666004)(6512007)(26005)(31686004)(478600001)(2616005)(6486002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJVMWtoVGZuSlZVcHdQcWliR3ZFa3FESm8zTTJBSHZ5NDlXc3pYcHA0OWVH?=
 =?utf-8?B?Tk1QRUdBS1BWZDhOQy9rM24rWnpqL04vQVhhZmlDUjRYUzUxV2xYam9adEQ3?=
 =?utf-8?B?Qm1lK0dsdFUxdmFmTmhQVFBCUmdJd1ZRc0kvODRZUmNLYW83Qm1pWkZtK3BF?=
 =?utf-8?B?UDdnbjZiV2lTS2JPeXcyaEdneWdpUXlPRngxUCtjZmpWMlRuVGxDODZxUVda?=
 =?utf-8?B?blBSb215enBCWFpUdlN0OUlDZWxhN2lmRWRTM2VjUDF3L1k4c25BZVVOLzA1?=
 =?utf-8?B?bndIdzRwK2JjWDc3dVdjV3UyK1Z5UDhFeTJiamFvRnRBekFTRUxmRUVXUUQ5?=
 =?utf-8?B?VW5zMFNSeVBVMGcya0VmMG9leTZvTlpqZkpSRVQ2Rk5qRWV0dVFKS0Uvd2hy?=
 =?utf-8?B?M0toVGZheWplTmpNa2F5TytEYVVlSDBUcWNVZ1BKZlBPY0Q2enlBMlVEVGt5?=
 =?utf-8?B?REprUU96ZDhUa245Z21pSnNmWEEweHowRmx5c211TjJ5U2IvWitYK2VSbUw2?=
 =?utf-8?B?YVVNenFFNk1TRlVDZTJNSkkvbzlQVlhnMnN6KzhRckE3Mk12RDM3d3Awd0pi?=
 =?utf-8?B?MEMvVFlhN1FWVGY0RmROenJqbGdPVWpPM2lEOHl6ME90aFNtOG9xYU5xc0Fy?=
 =?utf-8?B?c3dLWFRkMWYxcDJFbFRWamEvaDZEd2F6TE1QL24rRlIvbDdSNWNheHJ3NFE0?=
 =?utf-8?B?dXhFOWpUaHA5dzZOY3NhbWU3VGxzQVM3UWFFZ2FkZEoycmJ0dGQ5UnZweWlF?=
 =?utf-8?B?Zk93c3dIZzNKVGJhcFoybWplZnNUUmhJSC96UEU3Z1l3cXVxNU9KK0YwQWt3?=
 =?utf-8?B?TmhDSzFJUVc0Mm03OUJKc0N5QlBkUkFodjR5a2w4ckptSmNXK3VJbkkrd0NV?=
 =?utf-8?B?bzlxdHBTZkRORC9ONmk2ekd2cDMzUmI5ZkVvb2hXMExFUGNDS3A0Tm13bUFp?=
 =?utf-8?B?dmxSVElnTzAzN3kveEtDbUlERU5xcU12OXV2TGJLcGpKUE8zVktxZFFTNnoz?=
 =?utf-8?B?ZVBzRldxN25MWWMxNldrcE41RlZ2NDdrNXYzaVp4MHJNZlVrM00xa1FXZGpn?=
 =?utf-8?B?dkhremNoV2lOTkdmMzNWWjBmQjNNT3NFY3JGTUkzSTI2Q2tqQkx2Y0hSL0kz?=
 =?utf-8?B?U1dKZndtc2J3ZlRDeEtRc0REekV6TVRFUFEvSU9MKzkwREh0S1kwaG9LMEw4?=
 =?utf-8?B?S2tDbDdLRDgwOHJxQ2tPOFkzRFF4WFhNTkpMWnBBclVkVElMMUVlb0Zoajli?=
 =?utf-8?B?dmRkN1lrc3hVd1hZbHlBdEhValdoZ2Y2VFFIdk5QZ3BJNUpqUDBEbUY2Q3Z0?=
 =?utf-8?B?R0sxQkNMbXlXc3dNMmFvQXZqNkVVR0Z0UkZIRVYyTEFIa3llVk42ZG5sUGE0?=
 =?utf-8?B?RWZ3dVdpcWJibHlrbFdMMDJsdWIvejVmeWx3WmlLSnpFUk5RaHV5NWtCKzd1?=
 =?utf-8?B?bDNRWTE3aUdTQnRmS1NSU0RJbWNRRlpNS1hyakRWNmhrK0ZNYm9qcFFCbHE0?=
 =?utf-8?B?dlc1WVFyMDQvczZqaTBwR2MvRWF4cXd3L3FRL3FNUTdaWnY1OFJZODNxQ1Z5?=
 =?utf-8?B?a2dMVzZubVYraEU2UWwzVGVVN0c3L2c1VjJPSVRVVi9Mb2VYS0FvL0Z0bkhS?=
 =?utf-8?B?QzlXZmcyenlaeW9yeTZMNm10NjdZSHIvRjlXZ3hDbFZJL2tTVzRpLzMwRUw1?=
 =?utf-8?B?Q2Z6elhpdUdFM3RNQjBsVkRzVWtCSThpS09BaU4zdloyODBjcW80aUp5Tlhv?=
 =?utf-8?B?YWRycm9NY2xmSTRyZDhDUllEUm5KV2s0TXBMaFp6b1l3SGJJWWxHNnBrM0xt?=
 =?utf-8?B?eE5WQ044NmJyU2ZFaWlLMC9qMitHOGdhMmpudEZ6L2srcWdHeGZ1L1RlSCtY?=
 =?utf-8?B?YXQ0YlhXQ054TDVCV0NIa0dsVXdwN0VOTkhNQjR5Mnp2VEZocExXVFhWVGw1?=
 =?utf-8?B?MnpacnNxRC92WjdRY2dReS9BMVp1R3R4c2g0alZQK3ZSeDMrZHhBZmVRdFFI?=
 =?utf-8?B?Q01HbmZNWUNXbmhSN2c5SytXeEkzYUFkSWs5NlNzZWoxRXRXQkhLM0xSWkkr?=
 =?utf-8?B?emcxYURRMjZvRDdZTXA5QUpBQjJ0eTFuN0JMc0V1VHhRL2RtcUhUYjFtMWR6?=
 =?utf-8?Q?T0T+MAnLUv+u7Xm+VDL93TcG+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce1ffcd-be59-49ed-9bea-08dc01c29670
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 01:17:24.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub1DiYFB/hI1YbsQeHFlzVc8vblVvYNZ2+YTWi9APs1G4WFzKg0NJixYdtKidQz9MbZAPwWJ4Js30zbqPahUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5705
X-OriginatorOrg: intel.com



On 12/19/2023 9:53 PM, Rex Zhang wrote:
> The drain_workqueue() is not in a locked context. In the multi-task case,
> it's possible to call queue_work() when drain_workqueue() is ongoing, then
> it can cause Call Trace due to pushing a work into a draining workqueue:
>      Call Trace:
>      <TASK>
>      ? __warn+0x7d/0x140
>      ? __queue_work+0x2b2/0x440
>      ? report_bug+0x1f8/0x200
>      ? handle_bug+0x3c/0x70
>      ? exc_invalid_op+0x18/0x70
>      ? asm_exc_invalid_op+0x1a/0x20
>      ? __queue_work+0x2b2/0x440
>      queue_work_on+0x28/0x30
>      idxd_misc_thread+0x303/0x5a0 [idxd]
>      ? __schedule+0x369/0xb40
>      ? __pfx_irq_thread_fn+0x10/0x10
>      ? irq_thread+0xbc/0x1b0
>      irq_thread_fn+0x21/0x70
>      irq_thread+0x102/0x1b0
>      ? preempt_count_add+0x74/0xa0
>      ? __pfx_irq_thread_dtor+0x10/0x10
>      ? __pfx_irq_thread+0x10/0x10
>      kthread+0x103/0x140
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x31/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1b/0x30
>      </TASK>
> The original locker for event log was spinlock, drain_workqueue() can't

s/locker/lock

Other than that,

Tested-by: Lijun Pan <lijun.pan@intel.com>
Reviewed-by: Lijun Pan <lijun.pan@intel.com>

> be in a spinlocked context because it may cause task rescheduling. The
> spinlock was called in thread and irq thread context, the current usages
> does not require a spinlock for event log, so it's feasible to convert
> spinlock to mutex.
> For putting drain_workqueue() into a locked context, convert the spinlock
> to mutex, then lock drain_workqueue() by mutex.
> 
> Fixes: c40bd7d9737b ("dmaengine: idxd: process user page faults for completion record")
> Signed-off-by: Rex Zhang <rex.zhang@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   drivers/dma/idxd/cdev.c    | 5 ++---
>   drivers/dma/idxd/debugfs.c | 4 ++--
>   drivers/dma/idxd/device.c  | 8 ++++----
>   drivers/dma/idxd/idxd.h    | 2 +-
>   drivers/dma/idxd/init.c    | 2 +-
>   drivers/dma/idxd/irq.c     | 4 ++--
>   6 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0423655f5a88..556cac187612 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -342,7 +342,7 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
>   	if (!evl)
>   		return;
>   
> -	spin_lock(&evl->lock);
> +	mutex_lock(&evl->lock);
>   	status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
>   	t = status.tail;
>   	h = evl->head;
> @@ -354,9 +354,8 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
>   			set_bit(h, evl->bmap);
>   		h = (h + 1) % size;
>   	}
> -	spin_unlock(&evl->lock);
> -
>   	drain_workqueue(wq->wq);
> +	mutex_unlock(&evl->lock);
>   }
>   
>   static int idxd_cdev_release(struct inode *node, struct file *filep)
> diff --git a/drivers/dma/idxd/debugfs.c b/drivers/dma/idxd/debugfs.c
> index 9cfbd9b14c4c..7f689b3aff65 100644
> --- a/drivers/dma/idxd/debugfs.c
> +++ b/drivers/dma/idxd/debugfs.c
> @@ -66,7 +66,7 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
>   	if (!evl || !evl->log)
>   		return 0;
>   
> -	spin_lock(&evl->lock);
> +	mutex_lock(&evl->lock);
>   
>   	h = evl->head;
>   	evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
> @@ -87,7 +87,7 @@ static int debugfs_evl_show(struct seq_file *s, void *d)
>   		dump_event_entry(idxd, s, i, &count, processed);
>   	}
>   
> -	spin_unlock(&evl->lock);
> +	mutex_unlock(&evl->lock);
>   	return 0;
>   }
>   
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 8f754f922217..042e076a6f2a 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -770,7 +770,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>   		goto err_alloc;
>   	}
>   
> -	spin_lock(&evl->lock);
> +	mutex_lock(&evl->lock);
>   	evl->log = addr;
>   	evl->dma = dma_addr;
>   	evl->log_size = size;
> @@ -791,7 +791,7 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>   	gencfg.evl_en = 1;
>   	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
>   
> -	spin_unlock(&evl->lock);
> +	mutex_unlock(&evl->lock);
>   	return 0;
>   
>   err_alloc:
> @@ -811,7 +811,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
>   	if (!gencfg.evl_en)
>   		return;
>   
> -	spin_lock(&evl->lock);
> +	mutex_lock(&evl->lock);
>   	gencfg.evl_en = 0;
>   	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
>   
> @@ -826,7 +826,7 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
>   	bitmap_free(evl->bmap);
>   	evl->log = NULL;
>   	evl->size = IDXD_EVL_SIZE_MIN;
> -	spin_unlock(&evl->lock);
> +	mutex_unlock(&evl->lock);
>   }
>   
>   static void idxd_group_config_write(struct idxd_group *group)
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 1e89c80a07fc..b925c972b99b 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -283,7 +283,7 @@ struct idxd_driver_data {
>   
>   struct idxd_evl {
>   	/* Lock to protect event log access. */
> -	spinlock_t lock;
> +	struct mutex lock;
>   	void *log;
>   	dma_addr_t dma;
>   	/* Total size of event log = number of entries * entry size. */
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0eb1c827a215..611101f99405 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -351,7 +351,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
>   	if (!evl)
>   		return -ENOMEM;
>   
> -	spin_lock_init(&evl->lock);
> +	mutex_init(&evl->lock);
>   	evl->size = IDXD_EVL_SIZE_MIN;
>   
>   	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 2183d7f9cdbd..3037eda986de 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -363,7 +363,7 @@ static void process_evl_entries(struct idxd_device *idxd)
>   	evl_status.bits = 0;
>   	evl_status.int_pending = 1;
>   
> -	spin_lock(&evl->lock);
> +	mutex_lock(&evl->lock);
>   	/* Clear interrupt pending bit */
>   	iowrite32(evl_status.bits_upper32,
>   		  idxd->reg_base + IDXD_EVLSTATUS_OFFSET + sizeof(u32));
> @@ -381,7 +381,7 @@ static void process_evl_entries(struct idxd_device *idxd)
>   	evl->head = h;
>   	evl_status.head = h;
>   	iowrite32(evl_status.bits_lower32, idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
> -	spin_unlock(&evl->lock);
> +	mutex_unlock(&evl->lock);
>   }
>   
>   irqreturn_t idxd_misc_thread(int vec, void *data)

