Return-Path: <dmaengine+bounces-36-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630117DD110
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857131C20BC6
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7B134A2;
	Tue, 31 Oct 2023 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Crgi5y1m"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E183D6B
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 15:58:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64B98;
	Tue, 31 Oct 2023 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698767883; x=1730303883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q8wxOofkkN0NCFiGpANUJpMUDCszjmqXINC1hNMgNRQ=;
  b=Crgi5y1mfcmF6uucIlw4X5DnjRAI3f6DyIXVm00zXKETa6FElO7o9n9l
   f412qXuWaEjFT9LC2xgvkAGDzLqyCxAVoHV+p/l/Eof5OHKYMc9G00PXC
   TP1tZVcMOhZtxLqKA/jdez83icY3D/IzPsH5P9ykZhPi8mdsXw+R1k2II
   JxL8Z453iCqV080TDd/65BVN5k3hDdupn1Dk6ez2ZzXVMaF712c2Kvm2/
   VWD3TfoXvB1Xk3GSgNGcFvOuBgTAS8rj2W/Un+1LW54WXgZ/RjyyFOEKl
   LhquifibPzYlSCTaKeucAQp+fn0ohEhgWQsPbQ3ITo8YBvIA0J1uk1lz5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368522091"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="368522091"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 08:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1818816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 08:57:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 08:57:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 08:57:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 08:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM0K0yisJiT2VIbWFzZdkfSzI74WRauVqBt8/D9lrXn9dxlKSoR4+cteMEjfBNGo0LRYGNKGErsUmkbTzYVUtvgJxZB2bwXpGpEAkc9U2reo2Atnm56ywNhl2cvhRjTpEHnFJmLN8K17DzVaufuNNIzVQmkMJS/XFj/CDixHNx9Er9MQdXaie/CHGZH4kIvHURW1m5Abx3S2oCkim4kb97W9owzZ4anbavvqV7SihU/z+KfOVFyLmsfmwhG+XFWpMfCBDRVXvJojW2c/KpW9dMuohvRBzrX3CZWiaTOoqxb/m/6sopkgVE9SHFQoE55lqIQr+S3HDDBFHZh9eCZSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVVYnrPkEyc5S1ouMVTI+bv2mVdrAj52K7UCNQ9IVCs=;
 b=CRii8ITthOJlZNH2hS/9giyMPxV7LvSNowqsWW2o3866RGGoH9nH8RBMe1wFgsJ+S7mJmwxWUne3dagCKpKYx4Gut6Kfp2qi1VPFXXfnK9kwZZiwanMiOs7Uz2v2Uq4xL47DAGkkEAu/nv4f5FW1XRCAOmBI+cMzWAdxuyeCjTivLxzTSrZus8HrTM4TDVhMs5jsrb2llVKmxl5R4MY289i53FcK94c3CJtAQWuYzdErAiRfrNmR9NaCRDM1eozOTcu7dWWoarpoWvfAM0vyvDkD8wKcDTzdB7kusQtVTLWnluaKx/4w/gVpm1pQ+qqA6wlyT0z/gowVqlLRhS38Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 15:57:52 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::3db4:cdd5:b541:b435]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::3db4:cdd5:b541:b435%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 15:57:52 +0000
Message-ID: <5dca6853-cd14-a8fc-ce1b-b64b1b8b3412@intel.com>
Date: Tue, 31 Oct 2023 10:57:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] dmaengine: idxd: Protect int_handle field in hw
 descriptor
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>, <fenghua.yu@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231031025511.1516342-1-guanjun@linux.alibaba.com>
 <20231031025511.1516342-2-guanjun@linux.alibaba.com>
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20231031025511.1516342-2-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|SA2PR11MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc6880b-c23a-4991-0e03-08dbda2a2304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rSHnViFVLylMZ1uR5huaoT3yqhTXGQpAE4CSRRUJVog2eCZYCdisUZFkS4QRou9ejiMDckzKZY9EfOw7MKSG6V18Ls9zKe583VQIMJgxl5S1IsoAFliFjrUkhlwb0Q6mvONF4FEE24Jt4qFJqfDJ3fiRwDOpo1SpBQUuFJrGdlRaF/EYWyHAl3ont9qYl8h8x+BZaz+Kpq9h/p8ElzjeKp1y6qSjTekffz0CxLce04dVy0appitL2VJDH6RAJzwVsvANFU6MTJFTr+G4mJGj7iUmZqpxx98u3NETLA4L3RfXmLXfFWvLvsXqUVCyRMArmw1yFNmZywjMKmxnF1qBJoskEexswH+1fR1wNOk7JNDWIiRMzIqQL9A1wi+Q2gsnRuTq6URUaGeJqp2wy3E5hlW17gtPWrI5P2eGutXCJFHsPanznI2pnQi6QrHMbp3QlqBuV2sQmLsAwg7BGrCyiUVVNNywW60IraXvdE4mcBCA9tPQucW+M7OQ1N3uwXWN9biseJh/l+7SWECIcYVXdkAYUflr+9FyA9HbCDheI1YlJvdlqR+HeiPe1mNl37lDQckaVg9p2c4lyS1tzWtOPOCdYW/VJ4ndA4Gc1L3MR47+H25ft+RvLEOtXCCdxvvWujkHtEQWW7N7qTRgxODYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(6512007)(31696002)(31686004)(6666004)(6486002)(478600001)(82960400001)(44832011)(53546011)(38100700002)(6506007)(2906002)(36756003)(2616005)(41300700001)(6636002)(66476007)(66556008)(26005)(316002)(66946007)(8936002)(83380400001)(4326008)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkoxYUM1LzJqcE4vazRKVmFwd1NjTnZZZGZQNmRaK2dCNWhRVVZYNUE2U0xq?=
 =?utf-8?B?dTkzWVFZTUJ3dS92eVZkbG5idlRhYWZFaldFOC9lSi9NV1QxaDZWaG9JZ1Er?=
 =?utf-8?B?T01LbG41amt1bEdacnZOeUdoVnVlU1lmZVQ3ZVFvWU1tOWFpRGhLY2xtVDBG?=
 =?utf-8?B?a1ZiTGlSZzRuQ1RZR1FackJGZDMzM2gra0pOTUZLSTQrb2RIL1NLbHlXNk5v?=
 =?utf-8?B?VnNlb3MreGV6TzBjZXFkM29zbCtwaGlLWWIvazRZTUVNS3NVTjNrMGEydkpL?=
 =?utf-8?B?TXR2U3VTdFFxL3BVWUNaNFpWZTdyUGtHV2RjaUNNTXlsSWpmcjZ6Mmw4ZEV3?=
 =?utf-8?B?MEl5UE9WN3c4ZU92bStrSWcyR3VGTzVudi9JSURzUi9TaFRzYzM3VHFhVnJs?=
 =?utf-8?B?UjBJU2V4TWhic3FkVlFRczJjR3Q4cGpwd0JRNlp6RkVyR0M1ZzhISDZOVmJu?=
 =?utf-8?B?UnlCVXFBY1gvVk5sb0MyaTdYVkEyOE5CdUh3bC8yTC85RXZBNWUvVllNdTZF?=
 =?utf-8?B?UmZrZ2dEYzNVVmRyOEVKRm45OGZYSnJmVzBHMkp2VEJ5TStkaEVacUlVQXNr?=
 =?utf-8?B?UnI0OVNXRFpmbmk0UEFCR3FzNnR0b1d6NGFvd2Z3TXlZcmdEeWJKMUNLNUFM?=
 =?utf-8?B?TnZVRmxkVEF4cDZNeG1BblZ3REhqTXY5TmJpN3YvVlZ2ZHJ1VXZmZi8wbE1S?=
 =?utf-8?B?d1lEV1ZBOWVQWlJQWk9SeG9CaUhyc0FJSk5WM0d2eGxaWnJNMHE0OHNSYjZ1?=
 =?utf-8?B?aUJ0UUpMRGNCQWtDM3FmeSswMzFLd3I5RFh3YmhsQjR6c05DeTlFb2pKU09H?=
 =?utf-8?B?R0dPa1JwS2ZzKzFrOGw2OE1hbEgxdTlobThlY1lHeDY0RkxpYStvSTFVS2dF?=
 =?utf-8?B?QTNDaXQzRk1DT0Y5V3I4RUFpY2IxNXJRb05Scy9MTmhnNGRCN2pDbUp4SDFu?=
 =?utf-8?B?ZGRkcHdvU0dJRERPSzRMek5sa3Z2NSs2REtqdVd0TFg5WDg0b2d0Rk51cU95?=
 =?utf-8?B?Y2dVeWF4Wjk4QVdKcDlSc1VGNXZsU2VVWGtRcExvODJJWDhtZkdlTEFCVnlO?=
 =?utf-8?B?Ym9QUzMycFVlTlN4Z0VFbXJyN2VQZWdFSXdEbXpaUHBlLzJ1SytKQkRoa1FD?=
 =?utf-8?B?cWYxVGRPOWozODVlSzZ0UlZDbWozeWFzRlREdEJVY1cwRytBNmUzN2trcnBP?=
 =?utf-8?B?V1RDZWZ4azhNK0JqK3Zhc2YzOURLUVRVRklkKzNyVXVQMmR1dEE3NEtIdWJD?=
 =?utf-8?B?V001L3hncGJWdFZEL05CM3RWOW5tT3FtTnV6WGlzWTdpYjg4VmZROTZwbWg0?=
 =?utf-8?B?R2RaR1dtZHlOOVN1NFJ4TzZpMHNCTDEvYjZyZWVVZ01rdHZlelVpRGdabXlT?=
 =?utf-8?B?bG42Wms2NEdNem5BTTFUb0FXQk1LR0pGVE93RVFHOVE2MGNXK0p6MWNtN0ZT?=
 =?utf-8?B?MWRtWjRzeUl2cnhlaFI2T2kyTEpsV3lhZHhueWRzV2ZXNE1WTXYxaEZXTFFy?=
 =?utf-8?B?QmExWkVaRmFHN0ZuMzVLa1FDbjcveVM5NDRwaVg0cVZ1S2pueUd0dE9SRDVs?=
 =?utf-8?B?U2RBd1JIaHkyai9SYmJSa3hmUlpQMlE5Sk16N0tGRjd4d05xaGU5bnpVcGZO?=
 =?utf-8?B?SC9UaVluYzF5alFleTgwdWJ3Y0kvZFpkL2o4cm53cGFrcW1vaVlsNFAzYWRS?=
 =?utf-8?B?bXBMM205RnlLcmZ1amZ1dG5Gd2taWWhEY0FnaTBXbC9vOGU3T1ZTMzQyOUU1?=
 =?utf-8?B?QXNYRHlDbEZUU003aTA2bkN4MFUvNTMwdUIwU1RvWkxVeUxzNWViRGVUQjVE?=
 =?utf-8?B?TXA0WlFScGxqM1VGRlhEbkk4a1VVNmQ5MFNSbVJCM1kxaWlZSWhKN0Z4dHcr?=
 =?utf-8?B?QTN1b0VTczNyTWVKM3JNVi93QXRVZmt1Sk1lczFLRUErZEcwYVhHa2JVWjBE?=
 =?utf-8?B?MjFvV2pJWEtKRkhUWW5IdlFib3ptc0Z3OHk2ampROHVXSWI5dlJmZWExMjZ1?=
 =?utf-8?B?K2RaNU9XZHc0OEYxcURhRHhTNUlrMXcvQS9vQUZSeDlVUXRTcER3cDV5aXp0?=
 =?utf-8?B?eEZwc0J0NEpFZUZwVDJvZ0hIbzVvRlNKVVN5RmRRbHYxc2ZBblNYdVFXQWtG?=
 =?utf-8?Q?G7z9RrLXxD+iBgkfiiWlq2oRd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc6880b-c23a-4991-0e03-08dbda2a2304
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:57:51.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAKDGkE7efkGO/jQxpkLBvhchubwuoFlYkEordBFsAy5vhkzzgBRWAdB2NmBBvpwXOMLV3Gc6Pyg5a6ear80IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com



On 10/30/2023 9:55 PM, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> The int_handle field in hw descriptor should also be protected
> by wmb() before possibly triggering a DMA read.
> 
> Fixes: ec0d64231615 (dmaengine: idxd: embed irq_entry in idxd_wq struct)

I think the direct fix is to eb0cf33a91b4 which moves the interrupt 
handle assignment to idxd_submit_desc() and has a write to 
desc->hw->int_handle before submission of desc->hw.

Fixes: eb0cf33a91b4 ("dmaengine: idxd: move interrupt handle assignment")

Other than that,
Reviewed-by: Lijun Pan <lijun.pan@intel.com>


> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   drivers/dma/idxd/submit.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index c01db23e3333..3f922518e3a5 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -182,13 +182,6 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>   
>   	portal = idxd_wq_portal_addr(wq);
>   
> -	/*
> -	 * The wmb() flushes writes to coherent DMA data before
> -	 * possibly triggering a DMA read. The wmb() is necessary
> -	 * even on UP because the recipient is a device.
> -	 */
> -	wmb();
> -
>   	/*
>   	 * Pending the descriptor to the lockless list for the irq_entry
>   	 * that we designated the descriptor to.
> @@ -199,6 +192,13 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>   		llist_add(&desc->llnode, &ie->pending_llist);
>   	}
>   
> +	/*
> +	 * The wmb() flushes writes to coherent DMA data before
> +	 * possibly triggering a DMA read. The wmb() is necessary
> +	 * even on UP because the recipient is a device.
> +	 */
> +	wmb();
> +
>   	if (wq_dedicated(wq)) {
>   		iosubmit_cmds512(portal, desc->hw, 1);
>   	} else {

