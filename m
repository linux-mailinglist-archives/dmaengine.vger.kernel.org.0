Return-Path: <dmaengine+bounces-10-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A27DBD43
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CCC281520
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7618C08;
	Mon, 30 Oct 2023 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvD6VDHf"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57A18C17
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 16:00:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1EE8;
	Mon, 30 Oct 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681612; x=1730217612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2HVZn2QShUf8XlBwHHEHBL3Ge1IYT3BjDxh2BPbfbjo=;
  b=LvD6VDHf4TwQA/s2WErxfVT+coPB3KfeRUqL7de/RkKqfSbE3JsHHSla
   1f28cXMQ9L3KgxxtVhSLwbpSGEdAjENWq4BpkDXgLSNO7GJQqzmTTp4OZ
   jh4v4u/3/3FQexDonR24LIv3doXM8nE/Z2HRLXXbn6VhZ8ZPEGUUukS32
   lqqz3GRtpSXsp49QE7yHeSRcDY91yiSTly5yx8lC9YYiDU5nY+6keecjl
   Cml0p4ENzONtLkhQnYZDQMpH1JQv3YBhoREcX3diNriLDZh/jWonyw34/
   IPkST3qw2wjZZPG23Zj1dsOd9wUmZc359seOiMFMMa/T9ci0/rp45bzQm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474342862"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="474342862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1542445"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 09:00:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 09:00:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 09:00:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 09:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHwrUZnvblRUDIkrkSUFZqzsrlL66zGI/b/8GZHAm28IE7wAlc7hU6mNXk+i1zhSS896sqmc+WnKmWLQmk6BjFxySIs4tL+oBaUg3GwUu1AElPuIjP/QyRyo2z3+aJG8D90ywpS/MMqFMnhcgPQy1FXiemi3yJdN/fOMdwj18zn416lYhs0/ocJBtc69htwPa+u6PjFCZnJ/PyNb+hXdXXF0JxlQyByj9AmwVFmllKiEDzZBczrsSlTWQEIWu1+NgQVTDGKHxLi8Ef8YFXocitEibnj6/LzfYrQsGNz62/gf2ir0vidNievLvq9IlwTFBUAfbqOJLkN5A6+A/1gwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8+IinUfUSa5onvZPN78jEG3w2m+7A4ZdHfZvztUxpI=;
 b=lFfh5dZxTElA0nX4uwGU5fVkO26JhtdB6tBVe/rb1JI44zY5wdMCYSKu3HLEI9JrAy/62tVTS3Af3D8Uk6bOzXqNQ9fDAcArkqT48pezMpoJsomrVgKBF8SULUzPbwZz3zCxNQI/07ZeqhDE5F6tvGvvwfgUp7P32I6rekeFvxjJg1QFHYIst/wmZK//ZKAgJuNmNVzTFEjSCQ3u3cssXw9kZA13SjSgancsIKMn92yRznoBAlJyTc2GLDiYty3MUCBQPSTh8JPlluZ+htsoZ8cZuqn9+q2jj0oVk49eMa5F2Qmd/JaRmo6u9CNfvNUB0nBkO73BtPz7ahdg/9fRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 16:00:07 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa%6]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:00:06 +0000
Message-ID: <6b352a15-5b5e-4773-a32b-8dcefadc1297@intel.com>
Date: Mon, 30 Oct 2023 09:00:04 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v1 2/2] dmaengine: idxd: Fix the incorrect descriptions
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vkoul@kernel.org>, <tony.luck@intel.com>,
	<fenghua.yu@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
 <20231029080049.1482701-3-guanjun@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231029080049.1482701-3-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7f7428-69a8-4c35-1828-08dbd961491f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpaXRDVfxIXJd5BWHq6m00jHCYfWc0myG/KSSIe7O1kN+0pcer8AWcYkHDAkPTzxIUcKBjGbcd21E2LC3lCXZwMivIEjkuqtsuuve4/hw0FXxUBrXJjmp0VqMUZqTy3ysUt5TIrjqd2t1rFyRyR/1AZbCdmzErYcjcEHfsOt5efeEDlHNrb1T2oxNDug4H/uhW0lvP++DUf/7ADp9ZIdttu0pPGNB0sjhwYwnMoHcrUItDDD+SOOrWTkbt9nHlkZywelse6yYCluNwqPCTW8g6VSbeNy4rr3J4JLX2CK6IUHCeVvfx6tMF31jPWg+cH0ZENEDcEcfMcj48PJoU3Fojml6bUXA2kO5UcpVtMPlvDuAM5I+tzVcUht9jyjZytYSXqUHsGOxb69lZnqKv0Fi0XoH6n+xzV+BrQE4H0PYKAQ0Ngy05zNbX4gAbVVHFu9t/aI/D7ffACmiHvG0UNgabJ8xPaRCuaC8WBJjvj/EljuVN5tCTjQenyGlIIZqFaK7E4mAcwB6m6+5TF7xAXum4QK/HEH5vHVAZdqWxv86yhv+9w6ZUT3AjrlC8NLm8yIAolyr44uwzmCwnIK9Jx+bmnPnCyO1hPJdz4vgkf0FcN3VtPJvsUwMfVgFoXrWyUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(86362001)(31696002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(44832011)(36756003)(478600001)(31686004)(6486002)(6512007)(38100700002)(6506007)(53546011)(6636002)(316002)(66556008)(66476007)(26005)(66946007)(82960400001)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVvUjcxS05VTGRSekhCT3o4L2g0MFMySXE3SDlMY2NMU21zd1M0SFlaNDgw?=
 =?utf-8?B?Y3JyNUYxRE9VNmZHZ0xLMTQyN24rS1BrVjVFOHdxTDd6M2R3dExlOWdRSWJO?=
 =?utf-8?B?anNBQWhmbCtXMC9NSWZqVTYwUkMzdDFvQjlDaFd0U1lZRGlMUCtUTXNBQnZR?=
 =?utf-8?B?eXcwbmJZa1I3bWtJNGhYcVRzZG1GY2VsUjE0dTJsdndNc0tvMDlzelJEMHdV?=
 =?utf-8?B?TkNGVVJPTkVBbWpTcjJqSVlmZDhucmxIMU4rMGkxV2QvZ2FKTm1JNmNLaGVZ?=
 =?utf-8?B?ZTlmTWtNbngwUzFOa2k5UzBiMVVQSVRaL0tJOWM2empOMWVLdDVyY3JCYTJi?=
 =?utf-8?B?NS9JdkpETHV2alhSSHVBSDZzKzY1cW9GTS81dDZBaHFiaWJ1S3dtZTYxWU5q?=
 =?utf-8?B?N3RDbTFGRnVXZGFTMDMwQ0dDcGRuNFBhaUgrYittK0ZMVDViUFJLRzdhbnRx?=
 =?utf-8?B?THpTenBUU1lVMlVnenBjaHkzVXNrSVNzWE94bVVJTUxZdGhsU0lDcks0aFFM?=
 =?utf-8?B?UVZkS2krelZuNG1lS1hiNjMxcWVjOEo1SXRkNGRZU0owNHc2MHd3SU8vR3dP?=
 =?utf-8?B?MzM2S2d0VE1PZ1dZOHpyZ3NPZjYyUElNd3l6V2NOLzRiRkl2NzJDU2h0NXJS?=
 =?utf-8?B?bERLa2ZLd0tSdkxjN1F2MnVpUXVpQnB5R2hFQnhSa1FRMkpYWmhHeFZMa3RL?=
 =?utf-8?B?VXJsbS9vcXVYcXJuMW5USmtRV3BvSHZLOHU5eFYvSWlhck9PN2tpbnk5RWxE?=
 =?utf-8?B?TjJiZjhsc1Q1SS8xZUR2VEdOS0N1R0UxNEF1WEJtdHRrdnF1cCtqQlB0WEhl?=
 =?utf-8?B?c09FRWxyck1veWJvWWpLbytBQnlHQ285UEgrdCtreGY0ektpb3FmSE9pSGlk?=
 =?utf-8?B?d0FoN3EvL0p2Tm5GMUlBc2FBMUZKWDRvU3AxV2EydTZaU3Q3YkRUOFV6eDFn?=
 =?utf-8?B?VGsybHpkTWVpeDRNY3JUb1VCZnNVMHJCUCtFWnFhMXM5UFdYUkJ5ZHF6SFhs?=
 =?utf-8?B?MXhWeHVrRkxjR0gyNGt3TGZZdFZpMEw4eUliZ05SN01JZUZWNm04NUdmc2Fh?=
 =?utf-8?B?NnhqSHZ1T3FpYjl3OEVzTHM5VHo5OGlQdXorUzhPVXVWY2pqcmxZYXpOeW41?=
 =?utf-8?B?TzU1Yk5EY0w0VHNDcnRMSlBDTjZsS0tQVU0rbk5ONzFsUVhoazRZRzlYUWRL?=
 =?utf-8?B?OUJ6S2hjWS9hdDJSRFJtYkkzbnI2WnZ3cTVGNWxIL0ZsMm5pUTQ4QlhJSEQ4?=
 =?utf-8?B?aGNCV1h2Z0h0OG0yMFc2U0h6RjdmZUVNRldEWkNUUWdmSlRRdkVQMENhYmhQ?=
 =?utf-8?B?cG15SnJzME9hWTg4YmdoaEJuTVpvdXRxbjdjWWpycStSV01oSVZDR015dWRG?=
 =?utf-8?B?N3B5cGI2ZE9QUU8wVzJhME9KZlllZndTV0tZTzU2UFV5OERoazJSUWNPbVlw?=
 =?utf-8?B?SktMRHVqZ1N2dFVnUERCdWRqRi81TFZLdGJDL1NJUVdiMWhUZ3d1L1BDb2Fy?=
 =?utf-8?B?OGM3K1hKTlpaUWpXUmpBTVc2VnVCaE55ZFBCWVlRWDRvM2V6T3B3YnJDZE1n?=
 =?utf-8?B?ckprdXhsaXFpRGNQNFE1clIxZ2FYQ21UYlRBcUJpb1ZYaTlrOENCOTBHcngz?=
 =?utf-8?B?THVnWlhoR0h6Uk80Z1lEU1p3VzAzRDc5dEExUWlVb1dUdW9pNVVlRUxhZGha?=
 =?utf-8?B?VnlpbXZ2VVpDOCtQYTY3R2pPSzNjcUk0MWkwa0o3dDRRN3h3MkQ1WGR2OUZt?=
 =?utf-8?B?WXRwenBrL2Z2TWYvbXR0Q0pXbWNQQXVuRXlja296SU9uUyt6MnVBalJVanBV?=
 =?utf-8?B?aGFEL2E4SlZ3UDU4c0RlOWhRRnZhUzhoMncyNXhyV1VNa0JJeW16d0RkQnh4?=
 =?utf-8?B?Y1JzMEQ2MTMvWE0rVVVwZVoveFl3TG1sWElkSm1tVEQ2TkdtY0hTMloxVTl2?=
 =?utf-8?B?MWNMZUJ0aisyeHlBQjNBV3BqeGQrUFgrVzEzS21KSElJc0hFWkV0dno0NElm?=
 =?utf-8?B?d0JvSythQnAzS29QUGpuaWlEL054SmlnRjZ4eU0valNXQVBHVDRpQ21qNzcr?=
 =?utf-8?B?b25oZGRkT3A1NnpWOVhidWJwRGszRXZGUzJoYkFDZnpzcGxYdVdJamtoZXVH?=
 =?utf-8?Q?/XidFsUploRVQRB4EythKGENe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7f7428-69a8-4c35-1828-08dbd961491f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:00:06.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyPOYmuE28EcKHTdLRM2n2vqSKXf20zW3dc3dMO+g5bS3gYsPZw/PobDZC7FpiRymmgnXTtkHrNITCWvZ68c8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com



On 10/29/23 01:00, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Fix the incorrect descriptions for the GRPCFG register.
> No functional changes
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

> ---
>  drivers/dma/idxd/registers.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 7b54a3939ea1..385a162a55f2 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -440,12 +440,15 @@ union wqcfg {
>  /*
>   * This macro calculates the offset into the GRPCFG register
>   * idxd - struct idxd *
> - * n - wq id
> - * ofs - the index of the 32b dword for the config register
> + * n - group id
> + * ofs - the index of the 64b qword for the config register
>   *
> - * The WQCFG register block is divided into groups per each wq. The n index
> - * allows us to move to the register group that's for that particular wq.
> - * Each register is 32bits. The ofs gives us the number of register to access.
> + * The GRPCFG register block is divided into three different types, that
> + * includes GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index in each group
> + * allows us to move to the register group that's for that particular wq,
> + * engine or group flag.
> + * Each register is 64bits. And the ofs in GRPWQCFG gives us the number
> + * of register to access.
>   */
>  #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
>  					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))

