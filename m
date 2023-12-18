Return-Path: <dmaengine+bounces-569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF6817CEB
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 22:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ED61F26126
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F854740B2;
	Mon, 18 Dec 2023 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3qaJ9L/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A474087;
	Mon, 18 Dec 2023 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936084; x=1734472084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3jn2oFRL8E+la1lDd4+JZrBn4E4wx02kJ9/a4NxFgMs=;
  b=b3qaJ9L/nZI/RKFehsOJV3r5jQ7+5FKM5BZDtZZLGQZ2BJiP4RSjoB7b
   CfvOZWlLmsdfZl0RKnfrcWIFqtsE8yNFDTfovqYEOfB9ZnNw3vkMWS2Vg
   HXBUDqaF4ZHqe+x0l9v6n8OGla6LsDcSZT2BWSONeUedvMWBncHNDMLWV
   zu0U7XTyzdPOvqfEFTEMtqPfUjhnzKh40OVF82feNJ75sICwmoRggPkDb
   1ty2KfmDngxLXsWiXgDNHjEoJMKZ62rPQcSC6Os3IT8kTM2hWL1FPsSzY
   RGwa5Ib1CCRt+Zu9flYzS5TK3jNPkw//Nn+x7IXoGhI9zMB5MFrrkFI0A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="385990977"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="385990977"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809976325"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809976325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:48:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:48:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boAUgs2puXyAjjmNmvgmCk4dEt8yAPVDR2fDTeeJh8gDEpRC7LRnqRAfvesnNQWTGvxjzkAYaQ9/AFIVximyh+zye+FankwdUmbtGMxXbP2xUoLW6Za4v6bR/n/HihgKfyaD4duCTcEclk5cF33OSPUn7Cj/L8s+b33YmBTznfeAfaSvQ+wYUVMQ0ktODRZpPC8QFII5pJqLWeiSITZqRt44ArEqMgdl4waZhPWwP6weddhvIN3KVTTpSZmIIxUXMvpP8rHlh0LW4OWD2xVf4bwTfhRcPmKDRyBFYGIkYG/+z3kaTtTvX659Mbmll/zUk6jZvfGhtRY51tpij7Ab+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uqvlljo9f+AuzK+rQQzzRlt8AEKojMt+eJwDHIyjmE=;
 b=IJfPFpvlbsMu7GWB6jm+Z3f52NXL2RTaepdNXu242eh8vT5E9jQLmJUyJtjYN0xl6ptt/xNXNJadmE7JYu1gTT5PqkSVazv9A+1lhpacvi33D3PBT3V2pGjpzr6doYvt6d0ezw44cn449DMErSx/X3M5F5IGjXYeVCSGkncLF9nY2Fr0gGdLe99F3b4++T2rCiKYrU4/9e8i4gnPh3ZRYm+uzUK+Z013XWv+03eKk+lwuEI2Lefhxv6aHJzzsJrnnrKhkVDJQl4vtfWvzefl+6dmQX/H0bfYmX1818ChUVhfRUvWYKdb16ReQsiYxnKx5cPYokR+FyIvFRkMwe5gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:47:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:47:59 +0000
Message-ID: <ee935fd4-d8be-4a1d-9ea9-2f75e157c782@intel.com>
Date: Mon, 18 Dec 2023 14:47:56 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] crypto: iaa - Change desc->priv to 0
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <fenghua.yu@intel.com>
CC: <tony.luck@intel.com>, <jacob.jun.pan@intel.com>,
	<christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
 <20231218204715.220299-2-tom.zanussi@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231218204715.220299-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: ce91a70f-b6e0-41af-c66f-08dc001300ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+MiLWweQf5RVMFsJIRw1oyYjh8853qcnF1b1bX2MLmhbIPeHtiPBBlqITP+p4Yrmqh7qClhOX1UQ7ido0ftrzA4iqpUA/WOGvtG4nuxjf0XHHj4Z/NcyqiCW7L/UMYi+Sfm2iEFNtHdhR4a5UvmWmj+CjcvUjtPb2OZxAcNgMEIVPLDZx6b5g6SmnDtSlrfvNYMviGFgdiTgIxW8mVHfCbpQ9F2C8U+6f/bhi1qX/kmXMuWU9SJPCEXlGQx7/Fxtwu0y1DfRjYXLu9dzefzl00Be2LYiXXOvmjt43Ay5JlT65zvgB9e6gy983RuQDAK5Bp2oLLDzCFqTvVeeHPUp+0g6TlliiHwCzwqkkPLJjS/oIJMK0xGeaKEtH28FMN5xb75MkRlOPDcRRq3Jdx05Bn1xWc7e1n8GgGQlEHLLaCWr4zVSoeilDscmfjEn5+8QcERihc9VIuA4CRDck9pHVm8QlMWY9fwnlaYP9H2nFm79NDe2ljJaH0KrzBdabXeFmNnM0C/oGjGCsKKpKsu8ozYreOuzJFrGJCP3kVVWi0/v2XwvGjnSaGAh5+lmSHO4r2UCI3wP5Iy4pgNp10yApgQdPosebExgLPiZcGY4MY1tM66pCZzYBcCJRgvuP1H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(66556008)(66946007)(6636002)(316002)(83380400001)(66476007)(44832011)(5660300002)(4326008)(8936002)(8676002)(6666004)(6506007)(6512007)(53546011)(26005)(6486002)(478600001)(2616005)(31696002)(86362001)(41300700001)(36756003)(31686004)(82960400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajdqUEUxYSt0KzgrM2xiY2ZwVlFUVmtYSVB2c0xoTTZSeGxPOVMyRFFZUUNm?=
 =?utf-8?B?emNuT0dlaVE2YURwT1UwN3lYbWp6cittazI3dUVaVjNyczFmSHdodXdvclBz?=
 =?utf-8?B?RHNUM3Bsd3JtY1BMUUx1WWRGcE1Ecnp0MzNXcWF3SHQzUWlPWkZWUTI3TG8v?=
 =?utf-8?B?Zmt6NWxVNFJUZ1ZXalFaS09UWHhCbTZQd3VCY3FqcktTZEhrSURFbTI3K1dX?=
 =?utf-8?B?ZUZiM2c0ZXZGNnVxWmgycHdIaTVLcGtMcGx4U0VqR1BCaGZLczhnWnZQTk5H?=
 =?utf-8?B?UkdDMmwwVWFJeVBkbDM4OHRmVytMQTl6N3BJdTUxUzc1eXhBMHljNHpwWEl4?=
 =?utf-8?B?WHlNeCtib2M0Q2NtbVFoM0JVSzdUQjJndk5aZGplTWphNXlEV1Y4N2tudnh6?=
 =?utf-8?B?Um1TcWlPK0xrMFR1VXFvMnptTGF3VEE5N1g3R3FXUlQrL05HakE2SUNDZmxN?=
 =?utf-8?B?R0JNU0tDd3pHVkVBdDNGV0hmZEZ2RmJSS2R0SEEzR2JwL3VzZ3FoVTQvR1o0?=
 =?utf-8?B?ZC9wUWV0RVZXMkNRWXFQWjZPRktBVFFEb1haRGtucnYzV2lucXdDc2JVeHpa?=
 =?utf-8?B?TTR6VDU3R3V0blhHK0QxeWtRd3VwZU5oQi9MTURSZi91cHJDZ21tTUoyRUQv?=
 =?utf-8?B?NXlrU1VDUThFdEg4SnpqQ0xEaGZrbmxIU2tjUXRsQ3RoV0VkamVNYWNLelBr?=
 =?utf-8?B?NEpPaFdIS2p6TXNOZjlyOHVVN01BZW1ScUx0aTA5Q1dtL2YzeS9TUVhmS0dj?=
 =?utf-8?B?QTUzVTFzMzF5eVB2bDg5TGlPSysreHBIZ3k3cjVwb240b0lsbDZtSi8wTWZF?=
 =?utf-8?B?c2FQdjNNR3RJelVYUGRvaDUvdWlkTWJoK1ZHa29xOGJuNkxtOHAwMXkrMk8z?=
 =?utf-8?B?alN5bTl6WmhWM3FmS01Qem9rQlpTekltb0xoK2RPRWg2ZDJCT256U0dhVDRr?=
 =?utf-8?B?SFB1UWdtYkpKWDdqWE1WZGI4RjFmY3ZxU3E5K294ZWdDYkdYRjRkTUxad0Vx?=
 =?utf-8?B?a0tmOG5KZ2ZJd3lmYlAxcHRyWW9iWkhqWklNZnZiTjFvVWN0N3daQUdFMDFZ?=
 =?utf-8?B?K0M5Z0s0K21XOEg0YnEvQ0dBUCtDT1R4YjRCWVVWQTZMUjNoSDFJLzgweU56?=
 =?utf-8?B?eHh3aC90blpPSnd6MmxKWUE1WDhranBmWDVnd3pPY1JjWVo4V2RHWkNaWHhs?=
 =?utf-8?B?QkordTlaSUtudFc1K0xITjBTWk5CV2RjVnoxL1RUcXlGUVNpTHBLWXJIUGha?=
 =?utf-8?B?Q0xocG5tNzZKOGk0S2ExeWJwL1lTeTU1RlhjVDBIQmthU2NuWkNzbnhtcngz?=
 =?utf-8?B?bCt6UnNIUE54OHhNcFdYdThBQjY3THR1dldwOTR3VStENlFUV29rRmJTSUJI?=
 =?utf-8?B?eEZhTlVoTEpMUGozbTh6YWFhRUVhelBqTS85YWg2VTFiSFprTUFWdFlXbHFx?=
 =?utf-8?B?a3RDYk42UVNsdU1vMHcySUQ5TGsrRWdlVm44aGZndUpxeEVoYUJGZms4bUZu?=
 =?utf-8?B?cFNNYkN5WXVOYXpVU211WFY0amFFQWpUNEtWZ1NGTTkxWEhFc0hkc0Y3VHYz?=
 =?utf-8?B?U1c1SDZSbXF6d2ZIS1VNUVZENUpsUGgwUTlVR0IwN2RjZjVUekZ6K0ZIY3ln?=
 =?utf-8?B?QXJ5NjFra0I0TUJoVlNFWE9TR29CK0RrSGxsK2U0OWkzeEVlUFpkbUhsZS8x?=
 =?utf-8?B?b2lvYnRnOWZHei93MGt4Vm1WNEViYUp6YzlIdWVjNmx0TVhhZ2Z0VU5NUWtZ?=
 =?utf-8?B?M04zS0xLaWVsT1J1eU9vU3FQUXYwWmZQOVJlKzRxR0tXSlFTRzdwaGlEeTVt?=
 =?utf-8?B?SnNCS3hJWmxxMDQxTXM0NVhDaG00OUlSd1lXWTJhOU9TTmorVk1HWE9JOGMx?=
 =?utf-8?B?Ty82YzdLS1VPN3cwcjJNVjZJWWFXNW5PQ3JnNUZwTXhuWm9BY0M3MWxlOTgx?=
 =?utf-8?B?V0J0WUlRSE1udmFoZnBNaEUxNWQ1VzdlZTFYUTdSUS9IOVBTRVlNWEVPZGZl?=
 =?utf-8?B?VkZQczc1eDZSOWVDa25xOFFrbThYMTIzdEtIRHFqTGRSRXlyOWtDd2JrUTds?=
 =?utf-8?B?M1FraVVIaThsWmpYS3psTXZsL25rMFMyYjJDczZFQkhzVFpKYUx0S0NjdEp1?=
 =?utf-8?Q?kGR43Vuh4d50yojuJB8iwfpLK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce91a70f-b6e0-41af-c66f-08dc001300ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:47:59.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI5s0hluh0X6fwPrOrMBZaRrHrpD9iXmwGmqRn9LCyRLHQlz8etHBy4gRJWibkBq4mq+YABYCmVV0eMM9Gw6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com



On 12/18/23 13:47, Tom Zanussi wrote:
> In order for shared workqeues to work properly, desc->priv should be
> set to 0 rather than 1.  The need for this is described in commit
> f5ccf55e1028 (dmaengine/idxd: Re-enable kernel workqueue under DMA
> API), so we need to make IAA consistent with IOMMU settings, otherwise
> we get:
> 
>   [  141.948389] IOMMU: dmar15: Page request in Privilege Mode
>   [  141.948394] dmar15: Invalid page request: 2000026a100101 ffffb167
> 
> Dedicated workqueues ignore this field and are unaffected.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index eafa2dd7a5bb..5093361b0107 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -484,7 +484,7 @@ static int decompress_header(struct iaa_device_compression_mode *device_mode,
>  
>  	desc->decompr_flags = mode->gen_decomp_table_flags;
>  
> -	desc->priv = 1;
> +	desc->priv = 0;
>  
>  	desc->completion_addr = idxd_desc->compl_dma;
>  
> @@ -1255,7 +1255,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
>  		IDXD_OP_FLAG_RD_SRC2_AECS | IDXD_OP_FLAG_CC;
>  	desc->opcode = IAX_OPCODE_COMPRESS;
>  	desc->compr_flags = IAA_COMP_FLAGS;
> -	desc->priv = 1;
> +	desc->priv = 0;
>  
>  	desc->src1_addr = (u64)src_addr;
>  	desc->src1_size = slen;
> @@ -1409,7 +1409,7 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
>  	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
>  	desc->opcode = IAX_OPCODE_DECOMPRESS;
>  	desc->decompr_flags = IAA_DECOMP_FLAGS | IAA_DECOMP_SUPPRESS_OUTPUT;
> -	desc->priv = 1;
> +	desc->priv = 0;
>  
>  	desc->src1_addr = (u64)dst_addr;
>  	desc->src1_size = *dlen;
> @@ -1495,7 +1495,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
>  	desc->opcode = IAX_OPCODE_DECOMPRESS;
>  	desc->max_dst_size = PAGE_SIZE;
>  	desc->decompr_flags = IAA_DECOMP_FLAGS;
> -	desc->priv = 1;
> +	desc->priv = 0;
>  
>  	desc->src1_addr = (u64)src_addr;
>  	desc->dst_addr = (u64)dst_addr;

