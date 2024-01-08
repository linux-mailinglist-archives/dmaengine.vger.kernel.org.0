Return-Path: <dmaengine+bounces-705-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2395827B4B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 00:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B6C285132
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43B53E1A;
	Mon,  8 Jan 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujp5thpA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1741A85;
	Mon,  8 Jan 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704755248; x=1736291248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLRAE5v+D1gq2v3TUdz+WwggrGJtRxNSxHcm83S2+Y4=;
  b=Ujp5thpAe6uSkmiwfie9bsu3rbCtsGnuh+4lCvAWkp1ayQT1kJtkYdDh
   h1ehQoNCnGR8/OgLSIHWOtJZtRLT+wjaO7N0XZ7v9+qJnuTH8pdLKO4Kp
   a/cxM1ybubEpzAkR7XnogWfGXdEgwGJ44QnncRxzE6hgrnh14ON2vUcwJ
   kGPH/JcnO8FyU/+BGp4mudZtC2gt4KZHx2I0p/sAJjljeqB6NjRENhmc6
   xJVgEuvu0h0h6oSIToFd6afbFLNfreMctHZDFwNv4gDvZQURpSJqM9m1D
   wkJY0031fWEauAIiKyopNHvbBXCpQXnlaoPQ4IQu/9BQUTVRFoWknEnL9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464423821"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="464423821"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 15:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="904959777"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="904959777"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 15:07:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 15:07:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 15:07:27 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 15:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5FCWSc5/7ySCR7VWTLDsbfF0nVPMx1TiMGG2q9SeoyKX9aeAtevTmtIWcDeQBzBne6Vg8/HUr7tlzZGrzzBHx3QuSLjunyvTnDI/LQZjT5SYiSfLNeWOJwkvBF+XUiPNbCFSOBftThMhTLZbtYKuivuwcao3BPPljQ/JL1xIp+ek7FyWixdL+QQPXy9r+mJC0GacdEj0GEA9dLNtU14eWUhygnZCBQ4CBboY8b92Un+8ERgltdefDJQNAmGoqEZIPlAx9RYJdWXhjFLrRGSo90XUScihGFLPrWA+qaAxUgjxtJzjJNDpFOwogk6+m1J96YgRUU/lqtoPMHk42pAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhPDdUJ/I3KKFz5JjKpo+NIDnoIUHyEHQoB1zf0XyhM=;
 b=FM/zJ9n9TTVq95tW4pXZ1UFM+VM/Q0Ikf2YVI5x4OoNiKci68hlsXrfdU5cJYRt7IhPXXIFvppuyQ3JoVq2LhwwGIckKJS39ppC7OcsHmo5mShcPOjQDiJceWbCKsjnZ4hkQjr2fb3siGaT5VUnJhvMSoBueT6FM3tZYkvyTsxnidjl+XffQjZp8rr2UjBHZQgWEkOMu+3N06UH77P1VP0GTr9r5TLu5KM5SJYs2eg3OURygZXlm3Saby2f9is8KbzoSHCnRD5fiCfmY/lRpGAkMRFDjcdpVaG1xmsHNTO8xqNK2hlCHxhONDFcBfHAWrIXdJ/HkWyKxRnmrUMZP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 23:07:24 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:07:24 +0000
Message-ID: <563b1dd6-8e91-4cb1-8981-5f18dc1d7130@intel.com>
Date: Mon, 8 Jan 2024 16:07:20 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] crypto: iaa - Remove header table code
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <fenghua.yu@intel.com>
CC: <dan.carpenter@linaro.org>, <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <8bde35bf981a1e490114c6b50fc4755a64da55a5.camel@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <8bde35bf981a1e490114c6b50fc4755a64da55a5.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 510b98c9-bc92-4fd9-8223-08dc109e932a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnSlA/J2ozajhbe8oW0VCLJuprYywRGRmu01aDL/YKB+6fBJ6QExAS/gJjiMyc9HJ78DCeQRaj5l4N1a7UuGV9C9ENJABziKp2iIUOpdZyR9PuOhYDYKB1nR/YcRI9sKmUVqZQeB2ehQL2Gz+jiyrVgG8cqXXvA7lJFIqiyvgM/J4ojF1DM/Rztb8oZ5eTtM+OMJEq0C6QT4oqapMREBwbWIbWnlmJXE1fs+wtFsTbJIRKm3FAWhiWaC2R6+8Z0MgKBzcHAJX9PhmsTXGN8Mp/GHt0n5XWtfSWVBToV4wocbVU0M481OGuBQBwSQsKr4oRnDpOtwCfsGIfoOG3z0zCTbEDj+gJFSuZEit0kQ7ZdBf94/DyqJmMerXgkmCxQkjvKvJ4DGELdz9za8JYW+mhoY1+1o+MzHIdaC2hpP/JwigXEC9VZtC+cK1ebQR7Hnoap9+6HWu7bs0bnZxLE8DgXzhTiJie9ZRFwCRyOhPAU9Ma2+jPuN7KOlmns8tFkfIZaPw1aX1nfpVJJjMvxwZZQWN+Lm2Gvm4nwlR1UISbvtzi8fM9+MhIjngwZIUtuZIZlsriVjdK2eT7bMXugoqU2/dFEdvRVxPdJlWuyBOBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66946007)(66556008)(66476007)(2906002)(5660300002)(44832011)(316002)(6666004)(8676002)(8936002)(41300700001)(6636002)(4326008)(478600001)(82960400001)(36756003)(86362001)(31696002)(38100700002)(966005)(2616005)(26005)(53546011)(6486002)(6506007)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFjdVJnRTRKUWNwYzZIN3JhdnJQbFYydTFOaWZzajVCdFNtLzdHbEtMbWQy?=
 =?utf-8?B?RGlxUkcyMksyTFRDZWc1N3U1K0dJdW9VUlEwSGNiUmlocWNCZnl6N2FoRURG?=
 =?utf-8?B?M0pRMWVMTnJqbDRueE51U3ZKcXAzRVZ4TnV2UzZiZi9SUG5yOU1reUdRREZ6?=
 =?utf-8?B?VERSTlpzMERQQ0F5YkppNzhnbnBoa3BXVktwRU40S3RGUlZIRmJ1Y0ZIdkNW?=
 =?utf-8?B?ZmxiZjVMYUVIRkhnRUl4ZTFnWnQ0YUg1NitMNDQ2MzBBNFltaWxMT2VtdUow?=
 =?utf-8?B?M1BNUC96VmRRYkN2Rm1pdnVnelV2WllNK0RnZTIxcnh3bWdNdVJVeXo0U2p4?=
 =?utf-8?B?Qlp5QU9kcDg4d1JDQ0tEdnNqZDI1dzM4QkpWYkZ1UlU5dEFvOUlCcU5VU3Zi?=
 =?utf-8?B?YkNNMU5Fa0xZb3NJdS81bnVFSmluN3FCaGRWRUdKVXVZRi9JRXNFZ1hRamVp?=
 =?utf-8?B?U2srWEVzQkJJcDl1cUJVZ01RTms1dTFkbmFwUitPV0ZtRGJrenFNS2psVlM4?=
 =?utf-8?B?WWl6SndXaW1WNGlHQXBnNG8yUlBHbGR4U0ZPSm5jYitUb0paWTZsazAyQytm?=
 =?utf-8?B?SzczWDVPdEd2dFZPOHY4M3FCcVYzTHEyNkN1S0ZSODlCWmFpZXVoUGRvVnpq?=
 =?utf-8?B?VzVPbmppeFpVVCtnZFNzSDh1cTNwdnk0bmprVXZJUmo0eS9aaDlnQnZvWlNr?=
 =?utf-8?B?d1BXdHplZ2RSM0JGM094d0JDcFlyL2NuazVCTzJGWjQra1UvQlRxS2JUT0E4?=
 =?utf-8?B?Mk5SZFB6bTRIVVV2M3JpdVQ4RHFCbHdhaU1jTmRDWkUxT2Q5UC8yWUxldHNX?=
 =?utf-8?B?UTYxdUdmQ2RLdnYzWFo2eUFBYm1ZRGh2MVc1K21kVFA0RFp4azFFMkt6U2NQ?=
 =?utf-8?B?SFVUUy9CZC9HNEQzN0hsSHJMRHh4WGx5MGNvYVY1dHgxSHJmdW9sTEs0aUt2?=
 =?utf-8?B?QjJGZFRJeHE1K3JhNm1WV2FOdUxhd0ZCSmUxd3dIWmZqRVNUd3R3VFBER0hD?=
 =?utf-8?B?V21Cd1lLeGpYQXlqRURwNUlidjF2SkxOQW0wVjVUUVNsVk1aUzI3QW9PZFBH?=
 =?utf-8?B?WFUzam1XOVJiOGxreDdBN2tlV2x3UXNENTc3TXRNYXRQdUh2dzB1TnJZUnZr?=
 =?utf-8?B?aW1JaTdkOTIvWGc3VkdaRWpxY2o4d0VYNXFjK0tacXU2OW5kMzFWUUU3YUY1?=
 =?utf-8?B?YUhYd3c3T2JRTm52SkdNYVpCWDU4bGhyam5GT2gxbVdRL2xIUE5OWkVRRlBT?=
 =?utf-8?B?aW9kQk5wWG8vOHVXUnJMRU1pdHJwcWRwd2dmSGN5MHZoa0Q1ODl2aE1HMHAy?=
 =?utf-8?B?Z2xQZnpOWG9RY3V4aysvR1JjUGNZSkNDTnlCQW1oYklrOXU5KzlWQVFPTjBt?=
 =?utf-8?B?cnNzWHd3UmpBd2ZYOCtPUkxhb252RFNMQTlQK2wxNmFXc3ZhZDV5bE81WGda?=
 =?utf-8?B?a3ZCLzVnYXZETmZUNS9ESll3MzFJaC9zQytGQ3hEZmN4Rk1qdWg1ZmpuU3pV?=
 =?utf-8?B?bEtBS0IxZkp0K0xrcmplY1FoVlZVME5XZzhNK25jUm16S1drMnFEM1oyOTFO?=
 =?utf-8?B?SUNMQ3RJWlVBZ2JWa3FYaWROeEt4OEJIRVFXZm43dTNpWVJJb25VRGRxM0FY?=
 =?utf-8?B?Szk1Nlk2OWNQVWw0dzEvK1g4UGVEK2d2UTFFWEZZN1lscStkVHFEVnRPSlBM?=
 =?utf-8?B?b21TY29qb2lHN0Z1S25IMVRDTDQ3TDBsYjVrNnhjY2RvdllzSWtMQ3IzQjlz?=
 =?utf-8?B?Z0dEaEdGMVVEWnFvOWg2YXgvNnJDYTFMbGxmWGtnbFpVenNwL285VUhLZm1H?=
 =?utf-8?B?UlRwS1h1amdnb3Z4SkdJWXd0Q0JUV3VkL1llb0dpbTdjNmhJazgrRjhISTBB?=
 =?utf-8?B?MUdoRlY5YlR1d3QvclRvWXpNV0Z0RjFEVWFpWDdkcFV5S3A0OVNzbVN3Zi9W?=
 =?utf-8?B?UE9tWXBSbmVoY2cvdHJMVXZJbVA1ZTE3RUlRdWo1SjNzN1F6eG1YYStqZ3Zj?=
 =?utf-8?B?TTBoWlJOOHQ4eUJnZU8wYUVVQVJTT2pKSnBzaHBFVURVM01UVWNsdU43Mlhs?=
 =?utf-8?B?MkdwaGlmS0s5QXY3QTl6cC9tL3ZqdzJIRmVvY0dNWU5HMElEdHlMODAxam9a?=
 =?utf-8?Q?xNMamMtDksL9zdI8p3k8xIbzG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b98c9-bc92-4fd9-8223-08dc109e932a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:07:24.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXyWX/8+nOVdDYk3wT/0Z20RICOXCPWm/QgEfAyQkgzR3nWrD3KWje0zrnIuc4JcggchFsUTGCPuaVg5wpNSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-OriginatorOrg: intel.com



On 1/8/24 15:53, Tom Zanussi wrote:
> The header table and related code is currently unused - it was
> included and used for canned mode, but canned mode has been removed,
> so this code can be safely removed as well.
> 
> This indirectly fixes a bug reported by Dan Carpenter.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-crypto/b2e0bd974981291e16882686a2b9b1db3986abe4.camel@linux.intel.com/T/#m4403253d6a4347a925fab4fc1cdb4ef7c095fb86
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/crypto/intel/iaa/iaa_crypto.h         |  25 ----
>  .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   1 -
>  drivers/crypto/intel/iaa/iaa_crypto_main.c    | 108 +-----------------
>  3 files changed, 3 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
> index 014420f7beb0..2524091a5f70 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto.h
> +++ b/drivers/crypto/intel/iaa/iaa_crypto.h
> @@ -59,10 +59,8 @@ struct iaa_device_compression_mode {
>  	const char			*name;
>  
>  	struct aecs_comp_table_record	*aecs_comp_table;
> -	struct aecs_decomp_table_record	*aecs_decomp_table;
>  
>  	dma_addr_t			aecs_comp_table_dma_addr;
> -	dma_addr_t			aecs_decomp_table_dma_addr;
>  };
>  
>  /* Representation of IAA device with wqs, populated by probe */
> @@ -107,23 +105,6 @@ struct aecs_comp_table_record {
>  	u32 reserved_padding[2];
>  } __packed;
>  
> -/* AECS for decompress */
> -struct aecs_decomp_table_record {
> -	u32 crc;
> -	u32 xor_checksum;
> -	u32 low_filter_param;
> -	u32 high_filter_param;
> -	u32 output_mod_idx;
> -	u32 drop_init_decomp_out_bytes;
> -	u32 reserved[36];
> -	u32 output_accum_data[2];
> -	u32 out_bits_valid;
> -	u32 bit_off_indexing;
> -	u32 input_accum_data[64];
> -	u8  size_qw[32];
> -	u32 decomp_state[1220];
> -} __packed;
> -
>  int iaa_aecs_init_fixed(void);
>  void iaa_aecs_cleanup_fixed(void);
>  
> @@ -136,9 +117,6 @@ struct iaa_compression_mode {
>  	int			ll_table_size;
>  	u32			*d_table;
>  	int			d_table_size;
> -	u32			*header_table;
> -	int			header_table_size;
> -	u16			gen_decomp_table_flags;
>  	iaa_dev_comp_init_fn_t	init;
>  	iaa_dev_comp_free_fn_t	free;
>  };
> @@ -148,9 +126,6 @@ int add_iaa_compression_mode(const char *name,
>  			     int ll_table_size,
>  			     const u32 *d_table,
>  			     int d_table_size,
> -			     const u8 *header_table,
> -			     int header_table_size,
> -			     u16 gen_decomp_table_flags,
>  			     iaa_dev_comp_init_fn_t init,
>  			     iaa_dev_comp_free_fn_t free);
>  
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
> index 45cf5d74f0fb..19d9a333ac49 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
> @@ -78,7 +78,6 @@ int iaa_aecs_init_fixed(void)
>  				       sizeof(fixed_ll_sym),
>  				       fixed_d_sym,
>  				       sizeof(fixed_d_sym),
> -				       NULL, 0, 0,
>  				       init_fixed_mode, NULL);
>  	if (!ret)
>  		pr_debug("IAA fixed compression mode initialized\n");
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index dfd3baf0a8d8..39a5fc905c4d 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -258,16 +258,14 @@ static void free_iaa_compression_mode(struct iaa_compression_mode *mode)
>  	kfree(mode->name);
>  	kfree(mode->ll_table);
>  	kfree(mode->d_table);
> -	kfree(mode->header_table);
>  
>  	kfree(mode);
>  }
>  
>  /*
> - * IAA Compression modes are defined by an ll_table, a d_table, and an
> - * optional header_table.  These tables are typically generated and
> - * captured using statistics collected from running actual
> - * compress/decompress workloads.
> + * IAA Compression modes are defined by an ll_table and a d_table.
> + * These tables are typically generated and captured using statistics
> + * collected from running actual compress/decompress workloads.
>   *
>   * A module or other kernel code can add and remove compression modes
>   * with a given name using the exported @add_iaa_compression_mode()
> @@ -315,9 +313,6 @@ EXPORT_SYMBOL_GPL(remove_iaa_compression_mode);
>   * @ll_table_size: The ll table size in bytes
>   * @d_table: The d table
>   * @d_table_size: The d table size in bytes
> - * @header_table: Optional header table
> - * @header_table_size: Optional header table size in bytes
> - * @gen_decomp_table_flags: Otional flags used to generate the decomp table
>   * @init: Optional callback function to init the compression mode data
>   * @free: Optional callback function to free the compression mode data
>   *
> @@ -330,9 +325,6 @@ int add_iaa_compression_mode(const char *name,
>  			     int ll_table_size,
>  			     const u32 *d_table,
>  			     int d_table_size,
> -			     const u8 *header_table,
> -			     int header_table_size,
> -			     u16 gen_decomp_table_flags,
>  			     iaa_dev_comp_init_fn_t init,
>  			     iaa_dev_comp_free_fn_t free)
>  {
> @@ -370,16 +362,6 @@ int add_iaa_compression_mode(const char *name,
>  		mode->d_table_size = d_table_size;
>  	}
>  
> -	if (header_table) {
> -		mode->header_table = kzalloc(header_table_size, GFP_KERNEL);
> -		if (!mode->header_table)
> -			goto free;
> -		memcpy(mode->header_table, header_table, header_table_size);
> -		mode->header_table_size = header_table_size;
> -	}
> -
> -	mode->gen_decomp_table_flags = gen_decomp_table_flags;
> -
>  	mode->init = init;
>  	mode->free = free;
>  
> @@ -420,10 +402,6 @@ static void free_device_compression_mode(struct iaa_device *iaa_device,
>  	if (device_mode->aecs_comp_table)
>  		dma_free_coherent(dev, size, device_mode->aecs_comp_table,
>  				  device_mode->aecs_comp_table_dma_addr);
> -	if (device_mode->aecs_decomp_table)
> -		dma_free_coherent(dev, size, device_mode->aecs_decomp_table,
> -				  device_mode->aecs_decomp_table_dma_addr);
> -
>  	kfree(device_mode);
>  }
>  
> @@ -440,73 +418,6 @@ static int check_completion(struct device *dev,
>  			    bool compress,
>  			    bool only_once);
>  
> -static int decompress_header(struct iaa_device_compression_mode *device_mode,
> -			     struct iaa_compression_mode *mode,
> -			     struct idxd_wq *wq)
> -{
> -	dma_addr_t src_addr, src2_addr;
> -	struct idxd_desc *idxd_desc;
> -	struct iax_hw_desc *desc;
> -	struct device *dev;
> -	int ret = 0;
> -
> -	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
> -	if (IS_ERR(idxd_desc))
> -		return PTR_ERR(idxd_desc);
> -
> -	desc = idxd_desc->iax_hw;
> -
> -	dev = &wq->idxd->pdev->dev;
> -
> -	src_addr = dma_map_single(dev, (void *)mode->header_table,
> -				  mode->header_table_size, DMA_TO_DEVICE);
> -	dev_dbg(dev, "%s: mode->name %s, src_addr %llx, dev %p, src %p, slen %d\n",
> -		__func__, mode->name, src_addr,	dev,
> -		mode->header_table, mode->header_table_size);
> -	if (unlikely(dma_mapping_error(dev, src_addr))) {
> -		dev_dbg(dev, "dma_map_single err, exiting\n");
> -		ret = -ENOMEM;
> -		return ret;
> -	}
> -
> -	desc->flags = IAX_AECS_GEN_FLAG;
> -	desc->opcode = IAX_OPCODE_DECOMPRESS;
> -
> -	desc->src1_addr = (u64)src_addr;
> -	desc->src1_size = mode->header_table_size;
> -
> -	src2_addr = device_mode->aecs_decomp_table_dma_addr;
> -	desc->src2_addr = (u64)src2_addr;
> -	desc->src2_size = 1088;
> -	dev_dbg(dev, "%s: mode->name %s, src2_addr %llx, dev %p, src2_size %d\n",
> -		__func__, mode->name, desc->src2_addr, dev, desc->src2_size);
> -	desc->max_dst_size = 0; // suppressed output
> -
> -	desc->decompr_flags = mode->gen_decomp_table_flags;
> -
> -	desc->priv = 0;
> -
> -	desc->completion_addr = idxd_desc->compl_dma;
> -
> -	ret = idxd_submit_desc(wq, idxd_desc);
> -	if (ret) {
> -		pr_err("%s: submit_desc failed ret=0x%x\n", __func__, ret);
> -		goto out;
> -	}
> -
> -	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
> -	if (ret)
> -		dev_dbg(dev, "%s: mode->name %s check_completion failed ret=%d\n",
> -			__func__, mode->name, ret);
> -	else
> -		dev_dbg(dev, "%s: mode->name %s succeeded\n", __func__,
> -			mode->name);
> -out:
> -	dma_unmap_single(dev, src_addr, 1088, DMA_TO_DEVICE);
> -
> -	return ret;
> -}
> -
>  static int init_device_compression_mode(struct iaa_device *iaa_device,
>  					struct iaa_compression_mode *mode,
>  					int idx, struct idxd_wq *wq)
> @@ -529,24 +440,11 @@ static int init_device_compression_mode(struct iaa_device *iaa_device,
>  	if (!device_mode->aecs_comp_table)
>  		goto free;
>  
> -	device_mode->aecs_decomp_table = dma_alloc_coherent(dev, size,
> -							    &device_mode->aecs_decomp_table_dma_addr, GFP_KERNEL);
> -	if (!device_mode->aecs_decomp_table)
> -		goto free;
> -
>  	/* Add Huffman table to aecs */
>  	memset(device_mode->aecs_comp_table, 0, sizeof(*device_mode->aecs_comp_table));
>  	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_table_size);
>  	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_size);
>  
> -	if (mode->header_table) {
> -		ret = decompress_header(device_mode, mode, wq);
> -		if (ret) {
> -			pr_debug("iaa header decompression failed: ret=%d\n", ret);
> -			goto free;
> -		}
> -	}
> -
>  	if (mode->init) {
>  		ret = mode->init(device_mode);
>  		if (ret)

