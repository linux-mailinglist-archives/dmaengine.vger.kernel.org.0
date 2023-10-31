Return-Path: <dmaengine+bounces-19-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DF7DC472
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849B61C20AC7
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E2469F;
	Tue, 31 Oct 2023 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh85d4Aw"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BD468C
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:29:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1729E;
	Mon, 30 Oct 2023 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698719384; x=1730255384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mfkkv/zFfUCvLGt2clHbmsojCg+0znGxL4UpwZ/q1s0=;
  b=dh85d4AwffnN/ZZ4oLefn5Ce3+WeVU0QRn9lGXHmWp8o8Nl3GhHKzFr8
   eMTBe5+sFpgf+XevNOvS4KAQHxvYLhPRBLQMkj3Kt6HH8NXD0XbBs48Tm
   nKVXeUtbx8QSZaPX1tGfWW9M3+7/WGg3EW23bMomtfbKOyMSpoRnZ1ovB
   1uhMaHGtItxGzhaeM9wmj6guwXCwGCxblt8KFKg0Al2QNyxZdscSt+fQK
   e9uzoUBHAhbuNkzctR+WhsVTvtkZWt7fev9EmNRlalJv+TFWPIqvuu8lu
   TZURfEj4nktJfSxyE/S+ST+l1OhHVa4uvNWJRqnocvzj6NR6aa0E9esGz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452473976"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="452473976"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="830893855"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="830893855"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 19:29:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:29:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:29:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:29:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc2JbcA6A98VNdTuDyXIRde4B8sl7vjgv/Vogeo323vn8uQP8eTYSGVgQLGHxzEctSaDFaH+6JJHo+WAPalwCBIvDsWLb4ai6Rn7lxofSVnsNlwWCyXLXid3+72JHA0JacYWBKcoCVJT98mRj37Z3MEtYeG4JGjsFEMmiJlKuEbtveuLYWIMe79l4Ahh1UQrPzTh7ONlQwszqCUQ+so5TCWHZ9qMMbd8QcXLdPI5IHsEJOEVJ0kvk3RqtQxa2yZSuyrT+bmV+0F8LzTAqsp6Qu0bCe88WKK6ocZRhXu8PeVVn9mnzVm2VDSoHFNCmzct2CXSZtGCtKe3zPswg8NoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUW3fT/BDDHqlofLuf/CgGpY1ZJwMTRfKB137fIlkPk=;
 b=XnH9CRQAUqc5FS1S54VfZqcVAe3kbiiFYIYTbc2hZaBcZLva6X/TPMpEv1zM9R/oN1fktStS87okT7vnCGax8aFYMcIvL2IvIPtFb0K3QFvBU/715NmHvEwto88Gtp0wPiDDYfaO2cJHUldSrH0PnwnCH1OK0leOqLDHYi79P4hf1Hf2azYAi+L7oI5YEeu3o1TCjM6GFI32NvIhq0jM7sCq0FX9W2pvg4KmGEH+5X3YH76XNVcX3CMTMYLiiyS8a2hI9ynXB61LtangBbahBnc1Bv6IfelE80ot3hf/rNS5AnkZO1znJ+iwtxVS1fjlWEdx4svBO2HRIr0z4r53Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7678.namprd11.prod.outlook.com (2603:10b6:208:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 02:29:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 02:29:40 +0000
Message-ID: <2083190b-725b-f0e4-5d61-fe194eb31c5e@intel.com>
Date: Mon, 30 Oct 2023 19:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: Fix incorrect descriptions for
 GRPCFG register
Content-Language: en-US
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231031022017.1515471-1-guanjun@linux.alibaba.com>
 <20231031022017.1515471-3-guanjun@linux.alibaba.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231031022017.1515471-3-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: de392094-0c78-4a70-b870-08dbd9b93b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adOwsEkD8xnYYbyFAIXmWvJKCoKLJV0aG8rVFknlmZJJ82fOCRlZvthAUFXd/KYYTXhNvs8GitaXipvb2HSS91aICkIdGYG/Sw+lpwsmKUbSU5brdt9dmrQ+/y/abmoH7hDg4sNPJOFe/lL+rZVovJhtdr6TU1ZWEVvKJ1UNSx8/ePgIh8sMQJpfyeP7T38ggaKrlCz9ksF3vDQRWGaVprZEzycu1kcNP0erJuaJJK9huqJJrx7XCvf0ixe3gcThexQm80G6Z2bIUflHKm/YdqNzhHY3BtQV1FhskQeDwKxDjZfz3RYo5ulZ9B4iKvm46bFg0NO4woh4224jTFB/eDpLeeelIEMfFqxDR5r4vlgc2AQCRBE1EE5PVztr8ju8pCzLRgvGyqYAbW/3S9+hLF3dXWZeT8Hhn3XSfpJOHgj2zYxXzxZWaNN2p60Z7mgluN/bqWzviOC4rXw70b/zRBnUx41DS9T4+DFa5Svmfe4eHGUJPUbRH2d/BxSB51TKf45G63/GU00bGgh9RFZeVFZtd8Djm40QJc8jhKHdOUrlOQGG8MHs6Xm4NHjMO7ZfbtxCXlqF6prgzi1+ZIpuN3gm5yS/WSirniggAU/+cRTH2i/fS8H8H5P3NNBlnAfIwxXeUEjhdeCvJ5B3mabSmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(41300700001)(6506007)(53546011)(6666004)(6512007)(6486002)(478600001)(83380400001)(26005)(2616005)(2906002)(66946007)(66556008)(66476007)(4326008)(316002)(44832011)(8936002)(8676002)(5660300002)(6636002)(36756003)(31696002)(86362001)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hON2RYN00xU1A5b05HSE1FUWk0cnVVeEFYbGdLRWttdFZEWmdJSE5LdzQ5?=
 =?utf-8?B?bHR2VGlyRUs5WDFRK1BVVzFCeVZyOVJHL296Q2pwVFUxbFloa1YrYis4NUww?=
 =?utf-8?B?Y2FrTHZYV1BCS1AzUUd5dXQ3WTZzWWVOOWgwZGFObFVnNGJuQ0xNYm5OOHlR?=
 =?utf-8?B?NU5zZ0lWdVJUdXU0b3daVG1LZ25IWGtrMmRYTFdpYlZNUEhyMnJMN0JDNzM5?=
 =?utf-8?B?UFJ2SkZvczlaWm1oUUVjQ3FDY3Q3SWNTdmEwd3lnbUo5ZnFUQVJWYUtMc0Fv?=
 =?utf-8?B?ejdxWXA5LzdRTGtVdklQUzB6UVJWeTBjYXMrU3Z3YjlTNnhTM3dLcXFGcSt5?=
 =?utf-8?B?L0llS3Bpang0c1FiVEZHQk1leUxnQXJTWVJpb2xaRnVwOVB2VHloOGduR0NO?=
 =?utf-8?B?bk95YXl3UTJidU4raDA0TW9WRm5oVWdFbzhWa1lvZ0p4dStyVFc1ZUdHN2dY?=
 =?utf-8?B?c3dHVXNhNXdiYXZUeWdLSVZ4bjBSTURla2tGaElsSlVyKzJhbXhHTGRPWlFT?=
 =?utf-8?B?VmR5QmduejIrNldYOXQ0OWVqeHBQQmZheEZGVElEY3lkNVFaSDhqQnV5SERx?=
 =?utf-8?B?Z0Q2bitJUGd4K0FWTWRoVFRuS3VYSnArUDdGaHA4Y1RIZ0JXamRCOVJHa25i?=
 =?utf-8?B?NWovKzBZWTA4VXQ0WnIvMUJKQk1nQzJUUDhoakZMWHkrQmZLZGhmOTZYREJR?=
 =?utf-8?B?cGJUK0E3cGlTU3lTMG1DSVdZdTFnUjg5ZWs3K2JmSmV3SDB0WWJzdHB6bW5x?=
 =?utf-8?B?QjdLb3ZKWmdpcGdtQ3NHVmdJVmk4U3BqVHRxVDJzTDhlZ3RraGE4MGlQenp6?=
 =?utf-8?B?akhqR1VVOWNFbUZaTnE1a2JYYTdGK3owOHVTUEdUa2ZLaC9jbEwrSXVVUFg2?=
 =?utf-8?B?bWcyL2FZUThWTmhmWmxuc1NyYS9NU3NOb3RLYWhySDRYN0VRM2d2bVBmYURn?=
 =?utf-8?B?Zlhoa09zNHJrTzI5dmdxTEJHQ092T2Y3QXMzTERkZ21MRUI1YnEvTWlEQnBE?=
 =?utf-8?B?RTV5Y2wzWGg0Y0NtbjZ3QzFaTmxHdmlLM3dncEthdlF4dGFHU2tscXJmQWN6?=
 =?utf-8?B?QzJTWlJYalVjL1B0dUluUS81bzkzbmVWY2tzVFMzWUFVeC82WDFHcXFNeTVq?=
 =?utf-8?B?am5XNlFHVEgrb0RaUHk3SC93ZjA1QndwOHlMN0R4bGxRQnpJMHp0WjRJRmhC?=
 =?utf-8?B?NTBPYUFOSVZBdUlhbk5UQSttdXE4QjRhT1l0QVAxcEEzcmpqWm1GSU1xbXFM?=
 =?utf-8?B?VDI4Kzk0SFhQZkdHbVpESWd2ZTN3SzAwZUEyS2tacGxWUS9kekJEdkdVSzM0?=
 =?utf-8?B?UUUxWnYveUhYQXJIM2o3SU5JeDNTUzB0NDdmQjY4cWo2a21rR0tFU0p1ME1G?=
 =?utf-8?B?Mm1jSVgyWWFCV2pvNU53QjFSN3J3ck9QeWE3MUtLd1ltOXQ3WDFlKy9iVW5J?=
 =?utf-8?B?cnlCV0pTVFBlZHF0WnI1RE5PMFhQTkFtWXJnTEFjYk0xOHY1b1BpcGdEWk9j?=
 =?utf-8?B?UkFoOXlEd3JMOVlvYTJQNEpuNVNuQVhRT2hyclZrT2hjb3V2aVU2YnlaRjJW?=
 =?utf-8?B?Rjg4SEpWbHZUTHQ1dzYvODJsSzVxUVBrR2VOWjZ2RTcydFMzeG9nNnMxUmJW?=
 =?utf-8?B?VlFiTVRBaVJwUTJyYi9pdVZVMlcrQWhCcU9LTlgxd1FwMU9GUEs4YnBmWUR3?=
 =?utf-8?B?V2xJUUpSMjQ3NEtpa3oyTGhBVzhONHNuNWM3ZEROeWEvdXlHcjVjSFM0MWtS?=
 =?utf-8?B?WklnWnhrb2tzR1JKdFAvM2x0elArdnlEN01kT2JZZUIwRXZ2dEtRTk9nenRl?=
 =?utf-8?B?WDJkaDA5b3dUYjhpVzluWlZQb2xxZWFPaU54amRnTSswTEMrNTJ2L1VCYS9P?=
 =?utf-8?B?NmxpQ0xKaWhoVTZoVWtSYTFSU256VEtmRHNoUkFkRzdWdTlVeXd0ZXJJSEVt?=
 =?utf-8?B?RkJYZW1PZExlQWZBN2x6Vm4vSURLMENKcDZsMHRTd2U1M2pUaE1KdGRGUEhu?=
 =?utf-8?B?YzVhQndUYWY5YjZhL1JrSXJuc1lmMXU2YldJSkV4WTlCWExaWDhHd25vcTdQ?=
 =?utf-8?B?OEtQU3BtYkdEOVJoM3czRzlIVXlUQmxKeEpJT1oyU2QwekJnaXpYUk8wdEhR?=
 =?utf-8?Q?sIW6N390JMQ4E2/C+atgqJwwe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de392094-0c78-4a70-b870-08dbd9b93b8e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:29:39.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoOYqerrWquj7zKT3UQX1nW+bYGbgfsCoztw7V0a0BUsjRq0U1XIx2JcojCQ6Didz1JhAEFmyt7Mi9F7heyYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7678
X-OriginatorOrg: intel.com

Hi, Guanjun,

On 10/30/23 19:20, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Fix incorrect descriptions for the GRPCFG register which has three
> sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
> No functional changes
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/registers.h | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 7b54a3939ea1..133bd0c170ae 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -440,12 +440,15 @@ union wqcfg {
>   /*
>    * This macro calculates the offset into the GRPCFG register
>    * idxd - struct idxd *
> - * n - wq id
> - * ofs - the index of the 32b dword for the config register
> + * n - group id
> + * ofs - the index of the 64b qword for the config register
>    *
> - * The WQCFG register block is divided into groups per each wq. The n index
> - * allows us to move to the register group that's for that particular wq.
> - * Each register is 32bits. The ofs gives us the number of register to access.
> + * The GRPCFG register block is divided into three sub-registers, which
> + * are GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index in each group

s/in each group//

> + * allows us to move to the register group that's for that contains the

s/group/block/

s/that's for//

> + * three sub-registers.
> + * Each register is 64bits. And the ofs in GRPWQCFG gives us the offset

s/Each register/Each register block/

s/GRPWQCFG//

> + * within the GRPCFG register to access.
>    */
>   #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
>   					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))

Thanks.

-Fenghua

