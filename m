Return-Path: <dmaengine+bounces-37-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2B7DD180
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7969AB20E9F
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE320300;
	Tue, 31 Oct 2023 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt2zxQNt"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1F3D6B
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 16:24:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92965A6;
	Tue, 31 Oct 2023 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698769441; x=1730305441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=efbA5tZ6sRGRMW2BO7eATxjcr6nDSsi6dqlmBjohQa8=;
  b=Vt2zxQNtUij58EJ/q65DxN+WSxnyeYRirtiYuOq9hotDajGtvmRsS0mY
   qPXHxBKlybhBjTB9eMZ/vOOcvJMmydgBthgWw+zNziuts+/qr6vGVbMyz
   WVnHzYFM+WNNOUogXjpiFRBatW1hJJNBdASlAgpfd3fsArNh+iocYWvDt
   hRmWpVZtYNOxmAZ7WCJ/lJuSnhJKJmYEcnWWu2jHdKGep0TBm1jiWSzQx
   kARen5uIn/trauoKjLJHpOUud4gut04QbT5BGfFAtaqO2YNDCe40lszWn
   FO03FbEo8TAOFhhdtqjgqc58psryOe0iI+/vrHhEPq49Q1Hkbe8TNASBs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385510189"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385510189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754187688"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754187688"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 09:23:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 09:23:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 09:23:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 09:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Ij1KT3f5gKdn3p6CbF+t0jpy0EbcVYt8KaW08CuLOEGsTs/rE+AP/L72rxlQINv7w3PeAoj+ZJ4FxTEAsWzzK4kTkaxAd7/l17vz4prT75rbFyRCvTi26elZ0+VhKp/LNGmn0V/ZAl9o2iG+4kKLq3E2WREOSGrxBtNtDdMgY+MvEgBfVmUusuicq9WkqcxTqVdRsxxdrEAkM026JvKQvg7cJpPlqkyttu9YCqGtjd8yR1MU/z7s1vgyv+JNGY8Mm16qq9pMDbbQ2DWdrYdONmNvVozcnwwFXvZ4gsTyrjZ4OjbHzhL6DJml0fkavhYzMjIm8qltD2TWGh3aGn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6OUI3weJf4YNp3gKPvMsG3I3gebxyDA9/8qMQAG4QI=;
 b=ZPbIxxwGbyJgTg4pHOr0aG6mh010+IKw/mQB9IulnqMTwudtsxzljBxtsT0b8xpkl6J1oG7SiIrlaa+hx1e6JWJMvHrTNeyCqgDpc+6enXtW27mMaMH9T5ZUqgnPBxRK2iy/XTK0Y5kDa/mKab+TsRj5/woaq2XzmD7Ch/YDmU8eNuC5K775ORG+//jgFoayxyb6RQ2JoBKWcaE/vI/ZYbZ9VRoHieB0zANl823oRkhcgj67sICSfXjzgUfhVyMew/aXJUquu6kF5hUJatUrWEVGJFGdmdHsI4Et2KIiy9VnA8y1Idd5svYGrSYxwu6cbp9uh8Dge514WoDc+9WXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 16:23:18 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::3db4:cdd5:b541:b435]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::3db4:cdd5:b541:b435%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 16:23:18 +0000
Message-ID: <50ac3b6b-7d96-ca7e-637a-109e29e74911@intel.com>
Date: Tue, 31 Oct 2023 11:23:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] dmaengine: idxd: Fix incorrect descriptions for
 GRPCFG register
Content-Language: en-US
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>, <fenghua.yu@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231031025511.1516342-1-guanjun@linux.alibaba.com>
 <20231031025511.1516342-3-guanjun@linux.alibaba.com>
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20231031025511.1516342-3-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d96a1ce-d04d-42ac-1469-08dbda2db0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T90piVpflOiaP53+jsQwu7roAwyrqvo4rwDfuQ12X5ZFbIzmwRMYc42dQZ+Xvzj/LB8I6xcpgstSW05x2EGFHJR3eSAFn4WdlddTlKKYs5YjAaQak0UsDt8Gcm07Sb3ZHWjk+45Ijlxg7SqCL+OdHvr+ZU44HmkRASYpThG5nlZLQoPrWBMGGRnHR5uaEB02/ljrEu6GnhEmdmu4Iz72HHZnPFD+a9mmAV33zbdiBuvOXG4fjBaQrvQS28rSdA8z7pIbof1bDnNpU2ZI+FV1/jprGnwfSBuvZmvSZPdE3P6R4Wwk+bFs90MSgMgnUfC+dCSVv6YxMWrRhQtTaDy82jyl+XKiq0tedxzN3gW3/umDtPUPcp0xxELyKGXtPjujBPYS6MMnAbK3UXuz4JsQOWXb9rN2VP1e/xR5dcAG843feFiLMD8ZKXW/RY7Ey1XGCM+K6iPdyIbcWHB5GeD+vzYZT1oMg4SPvWQ1Hxend4vF1VQvMKfjRWJmeOcm3jYg5j7Glbuehs8wtBgKQI9KE9Q6ruj7Ej8RUUQOyFj0LW7AhynTRuTQCn5nvaFXLy0hekpbKz0vnOAlxQ7DZM1RtsHdW1WSXSOabZkzDW1+4ct9TyuVtp8to2jZb+iBmYbg7Q0r50z6xOf0atAjR5zewQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(6512007)(26005)(38100700002)(36756003)(86362001)(31696002)(82960400001)(2906002)(83380400001)(478600001)(6506007)(53546011)(6666004)(44832011)(8936002)(2616005)(8676002)(66476007)(6486002)(6636002)(316002)(4326008)(41300700001)(5660300002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVjVFh3OXpGbkNEcFp3Q0hkWllzeXlxTXBQM1J6Yk05dXhlQVZKNWZqTXl1?=
 =?utf-8?B?ZHdIR0NOYm4vdHZ1ckMxZTI2dXVMVTRrSEhkOStMeFVCMDFZZ0M1RVRtT2Nr?=
 =?utf-8?B?R2JGT3ZZSjdpaERjYnoxZkhpNlYrZmZJeUJWSytmVDBVZVhhVFNuZ3lHdlMw?=
 =?utf-8?B?aXVCUlA0dkRHbWdkb3JZWFFsUThZOUtuYTA5cFc3TzRCNDJxck5LZVhmanQr?=
 =?utf-8?B?eW9pSTdWZGVhWTY2MGc0czR4VE9TWDdXeTVZZ3dsejgwTmpiM0dna0h5Z1Yy?=
 =?utf-8?B?Qy90L3Joc09DcS9FVDQ5ZWhkM2V4ZWI0VE9QWTZ1WHFxZlZYRVhpOXJWNU9h?=
 =?utf-8?B?Vm91TVVTeHNqNi9NWmh0UWhma1pNaTh1enNYYkErdWt0Z0JrYk5wZ2FXZmxV?=
 =?utf-8?B?cUhFV2FaWThFUk9WeFNHcmJ5SEdkSUo3SGN6ZnlXN3ViSk45aGE0TFlFcG9w?=
 =?utf-8?B?YVEzYUNxa1k3YVVKL2pTd3JXcmtOVk9VNFI2MkNkV3Y3RmRYcVdQVmdkaGZi?=
 =?utf-8?B?STIvaDV6ZlZ2eGNKNVBvQlhEMkY3RFVSaHoyMHlaOThSbUplZ1FxRXZSdHI4?=
 =?utf-8?B?bE9ETUF0M1B3cW5oQzM1bGtpOTdBdFJvZXZJOWV2cDF0VkQrTEJVRGRORElO?=
 =?utf-8?B?Q09hTFZjN2k4c2w5N3BzVXZIcDZ6dXlpUjBOZmIzNFg5SmozMHVvZ3U5V1RD?=
 =?utf-8?B?UFE3bytXallYRXlZd1ozc2V6ajgrRnBCc21RSXhOL3ZPeWpMR2lBeGZpblRJ?=
 =?utf-8?B?d3UrVkt0b3QyR2ZYTHRzS2NDSlVTSS91OVNQWXV0WmZRbzV4bmpFcDVJVVhW?=
 =?utf-8?B?YjUxdG9Sd29ONUtNRk5TbTBuM1pDVHJKdVNXZm5FZ0Q0SkpmdVE1dmRvMFRW?=
 =?utf-8?B?d0FJMmc5UUZrZ0FjZ2dFQ3I2OXJndU03bXNqSE9MNjBuYjhPK3UrREtsc0R6?=
 =?utf-8?B?MDUxaUFNSjRIOHNLSGRCNStjVHFmdTVkbjlYaWM4dWR2c0thQk16djBnR0FJ?=
 =?utf-8?B?TDdmMnR3TWVIQ0lMUTBzTTFaSUJBYTlnT3ViTnpJb1VnVTFjQzNuQjdCV0Nj?=
 =?utf-8?B?YlFScll6NjZqSnNPODVvQXgvUHB0REVzV1NPNmZZYTZtTGk1b2F5MVlUWlJM?=
 =?utf-8?B?citWSTUyU2tyNTJPT29Kb1hKcVhRaWhZMWY2Tkw2cUMyMjJmdnNFZnl6ZWla?=
 =?utf-8?B?aytmc1E3ZFFiYXlhb3JHVjkvVGo5RDFaSTFwZElYaUlITmh3LzAxeXMvMFFL?=
 =?utf-8?B?d0s4UFlEQXEreHZFVngzS1JGYzdnNlVUZHhXVCtTS1NBRk1oZ0RxRnBLTHhM?=
 =?utf-8?B?dUFRS0lCQUs4Wk5xRnJWUmRHamxNdVVBWnNxWmk3TVVWUlE0TzB1U1VRYXVm?=
 =?utf-8?B?U3pFZjdvUkxlYTRHWEtSVDMvN3BTNGswWHlweTl2eFp0YmdvRDI4NzZ2UVN4?=
 =?utf-8?B?Z1hpZG9oQ0JlVE1IVThQMm9NblNCQmxVNktrYWFGQmVZT0JyMDVWcDZtanps?=
 =?utf-8?B?WFQ5NklQUm1iM0V0L05YTkdxZ1Y3RFR4V2t6c0Z2RXMzdXZnMkJZUG5lT1Va?=
 =?utf-8?B?QjhzZnNIcHFNc2s4R2E0UDBFWEZnWkhGc0ljQmppeWtyQXR5T29GS2RNZ3VQ?=
 =?utf-8?B?OU9hQi9LRVlseDRqY1hSZzllYXduMmlYZ1k5bVNrOTBmb1RqMGpucFppMzM2?=
 =?utf-8?B?SzVQU3pnRytuUzRyVWVRejMxYzU5WHNqQ3hmUjlpZXlrL1lXeSszVjhGNU5i?=
 =?utf-8?B?VXliajczbERpeTl3WlBZZWppd0s2MDBtVVcySEQrUkt5bE9odkdrbmF6Mms3?=
 =?utf-8?B?SnZ3a0VoOW11NGMwcGJscUtoYjJleEdCQm5oQ2s3cjYrMG9KRnh0YmJPK1dM?=
 =?utf-8?B?cElHdVlNYXU4a1lMeFFJVmg0c1YzMlIzeGNOb0tlUUdGUS96VFA0bGNBdGVO?=
 =?utf-8?B?WUMyYldia2pOcklFT3BFNmdLc0k4S2o0dFl6ZXBLTGcxUW1CS2xRNlJlWTlN?=
 =?utf-8?B?aXRlTlFPcjFMa0ZVSkQrbGNvNkpQVm5mclYyYVdMUEVyN3hNZGsxUzNPUlZh?=
 =?utf-8?B?bnZCVEtuUDB1TGV6ck9LUW1veERMdjdpSGVpdkd6a2ZwL0tsM0duaVJ5Mks5?=
 =?utf-8?Q?nMGYawPZXUJsXZHET4mlcVjNF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96a1ce-d04d-42ac-1469-08dbda2db0f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:23:18.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dElLkD2U7I1ldrJsQaKGQuscZ3m6Rv6QV9GoLadKRK4/KXEzEyi3JLfwCQJEUQ4i/dt0nUaeZ4Z0apx1gOVsAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com



On 10/30/2023 9:55 PM, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Fix incorrect descriptions for the GRPCFG register which has three
> sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
> No functional changes
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---

Acked-by: Lijun Pan <lijun.pan@intel.com>

>   drivers/dma/idxd/registers.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 7b54a3939ea1..315c004f58e4 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -440,12 +440,14 @@ union wqcfg {
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
> + * are GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index allows us to move
> + * to the register block that contains the three sub-registers.
> + * Each register block is 64bits. And the ofs gives us the offset
> + * within the GRPWQCFG register to access.
>    */
>   #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
>   					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))

