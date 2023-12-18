Return-Path: <dmaengine+bounces-570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C937817CEF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1209D1C21825
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E974E15;
	Mon, 18 Dec 2023 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvKiW1vV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F074E19;
	Mon, 18 Dec 2023 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936094; x=1734472094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sefLvKZx6YgE/6B2uqKuiRZjx+oHLyieNEbZcOiO+sM=;
  b=OvKiW1vVKk8vVeoimrc7xnTN+p1JQBSz/n5oW58bgwo22c6Rnp1AK+fD
   LsZwMKVqbpv9gsdKYUSH3JFDSUZ/0eQHugeocpBiIZUAnJ7FTNyOVzo6h
   18iNDz/JLiBaUOw3L2QaN0xHvxd412/C0S98KPZXpDnkwdHLUzD/g6gO9
   7vcHk0nhKx8+2CVqDODFNVeDAP3Ii4tX4YW86r2+rU1GCnmp+Mc4sKlQ+
   fKPKiT7arYdjKwPsFhMcGvDo2bTjdcON6XD9WLq+510yJM0DK1w3Kg6wr
   nZAHRELKhl3HTFj+15xOw0fCQsilR3uoKswNs1i1k3ayXDZ1RGfvWvByZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="385991035"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="385991035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809976372"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809976372"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:48:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:48:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1q6C89AweWJJU0+kfwikOO0MKevezJMtzH34NEmJp/iP0D9rB+FeNT4aNTF3L93QXVx3BErMt2M7OXHJ7hWBtc3GevTpWPeUp/oB8TY7EDZY7jRc6LLqaRObUHlBRh6MiEyia/QamOCzMYzWIBcSuHQuzhFny/kbggi/QTGd3rU9AfNZpyRCcr/wq9BWvzF2IgwzBZkGP9nx/DefcEdrw7JSdCAnFMde9dXQEP443pJd71ONqozyQlybN+gDLfRuJj85DCGWyFiqQxJNC35RTnEqpENTa/fMDUSXeEhN2zpMn7myTa2gOZ666ZH8z47jjyIcY30Mw8+wfTv/NFgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSZIe55CgPnxH8g7eCC7rwAY4e/FozlJTgUHqWFOADc=;
 b=FtJhdkrap6VuEE7KfvnQg7MUvmm89c4CNL4+Xo/rNbiDYPdA6k7D6oRH0mQZdzIJ7eMB5lGnXvWaV2BngjxQ4NpaMT5wNzfJTvIM/JrPfpNgqVO0X5iRv/jISJ4IhIy3YZL6vPCC5AspwvIh6iKDMoG6lrNTiVt7qkoTzjwQzuJEgtJlvgu70ZxiwF8Kg+I0L2p2c+AxcyvSjkb51dLzRAzveEO0t6CRCw4O3E2ngbsIdozHWya730fzjJzldlDl5Mn2nsuBcd6lYidWksrq5gzKe4jx30lopMRBiBZ5qsDuoEsWqAedfel+Ubhpnb2/RAhJ6y1jCYwMul9kJHl9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:48:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:48:09 +0000
Message-ID: <0943be26-f646-4e73-bf21-006774ca1dfc@intel.com>
Date: Mon, 18 Dec 2023 14:48:08 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] crypto: iaa - Remove unneeded newline in
 update_max_adecomp_delay_ns()
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <fenghua.yu@intel.com>
CC: <tony.luck@intel.com>, <jacob.jun.pan@intel.com>,
	<christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
 <20231218204715.220299-3-tom.zanussi@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231218204715.220299-3-tom.zanussi@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b220a47-90fe-430a-8282-08dc001306bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5+HKVlkstoBuwvl12RyeHKjGJbsWbQqem4rUj2p3BQGOVG+v7HJ5gt0ZfuB5EyYskrBCESqci4MBRudOZOAoPx6ME3rqyEDSPWvcakbQ7pTan1TXok7Ck2BAJw0KEssQElr8nV65Qadgz4bU99igmuqMfl7H87kOPVFIeE/FMcMa91vhiWNd67rpQJhyfq95HkASidNSj2C3A6Uz93fUYSMAr+u5bWQE0OzO6uK3FBHKoJbq5lcV9pMmQ6unV7MK0FKtOawgb5f2qprcp9c3uHQaC5qOX0VYPFdh/td0EqJiLidjOoOp7sn5CZvDDICiqeQZW+pkmNM/pPgyTWpK/2Pw37FTaKjFtdSBUsAaAeHwR1g9esdb0Tb0QC4fAiJrhPO3/wOTCoczIOTVlP7w3Wfe5Frl00pcC18dslX4jyW/OsEwNz+5FqTqy1dOcpwbAB0PxBAudXiJAj3XOAlBZT5myYsuXABrEr26plFIpat5YMQvwZxyj/ex3skCKSRMFDh332sp6A0nwXuy6gBNnfifecsFwb97bDrxNbKbe2Z/rV5rpIXQIVuaNcwxZSQpOVuNwr00ZMPI56VziIGHpdn5Z4vSIDF8o4QXsUxaLpVvWJcIw8JDQZ0PgRmm2Dc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(66556008)(66946007)(6636002)(316002)(83380400001)(4744005)(66476007)(44832011)(15650500001)(5660300002)(4326008)(8936002)(8676002)(6506007)(6512007)(53546011)(26005)(6486002)(478600001)(2616005)(31696002)(86362001)(41300700001)(36756003)(31686004)(82960400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVYzYUVyeGh4ZFdhelMvcGdaQmsvcStxL1lkalRWbmNycDNMYU1ramlJYTBH?=
 =?utf-8?B?R3NxeDZKZzdBSk1kUjRuR1JoWmNGMEcwUFhEV05rOVlIRktGNmtNUmE5MU9q?=
 =?utf-8?B?ZTBFSUMvU0toeGV1UmJpZ0NtaDM2aHlUclkzajZrNHp2RS96K3BuOGp4Y2Zk?=
 =?utf-8?B?azMxMTNhRFE2cUxMRHhmaTZvZ3ZTczdoWlNyR2NwOEUyb3Q2Z3NsZ1QzTzZo?=
 =?utf-8?B?TklOYVprQ0trcE1IVW5ibUlmV3RKY3NrVEFjYTNKd1NUMWFLT0NtME02Wnhz?=
 =?utf-8?B?VUUwR1k0L1pJMlRpS3JpTVFqSi82NU5kKzR2c1lDRkhZVWRHVEdHQy9tOS92?=
 =?utf-8?B?OFFoR3FnVG5BZTlnWXpLelBscW1FSlFFOVlvNUZzOWhydnJPa1lLd2p6Zy8v?=
 =?utf-8?B?YVR2NlpXM2toYjF1ZHhIUFBQTGtnaDExOHR1dEtjQW1JaWpnSE0vdHQ0T2pU?=
 =?utf-8?B?UHBGdFdVRjhZelZQL2xaVFdtbWJub2VMZE4zUHpscXJQbko4Q2FiUVlORkds?=
 =?utf-8?B?b0pSNno0WTc3RU5FdDR1REdJYzZkYWFBc2ZJaDV4WlpOdVhqRzhLSWV2VmJE?=
 =?utf-8?B?ampaM0VqWFg4SjdUNHpiSzFkblhPcjhidHNDRDd5YytYdmR6bitXRW04d294?=
 =?utf-8?B?K0lCRGRZbmVTdmhIZ1JibWsvRzdSSENQWDFGTFk1VUpZS1crVzVSNlh2NXo4?=
 =?utf-8?B?eWlPQW03MlNlL1p4aHVsblMzR1lwVkZ5RW1obXV1ZEdEWXhMOFRGdTRFQUJz?=
 =?utf-8?B?MjVKVkxDZU1ENjd6bXkyVDNaZS84TUNoejZkaVhtVklQRk5UMmlnYnZQODI5?=
 =?utf-8?B?Lzh4azBnVmZPVHJYWFJkMnJraXc1TGVzY3ljTFlSZGpHTDR5SjdSVmJXektN?=
 =?utf-8?B?TFJQL3BRcTgwL2g3SFFCODd1anN1dWdNelMzY2U2RlltN1FKeEc2Uzg2OGpv?=
 =?utf-8?B?VUgreFcxckVPdXI3aHJYQXNaVHJMTmR4K3lmOTdxUmtWbkFGb1o3QlNYUVpj?=
 =?utf-8?B?YVhYT0hmVFJKM21QTzh0N2pOVUsybTNqS1RRZm5GeEhWdk5iYS9sd0Ezc2tF?=
 =?utf-8?B?cHY5N3lLOGlQK0VyNmFWSXlqd1RPaGQrSThJZVg1MXJCQnBQWi9acUx5ZHhB?=
 =?utf-8?B?ZGpXaS9sb3M3V1JYaUVkM3lic1FEdUV6d0tKOEhGeXRRbzRJMXVhT3ZqQ1RL?=
 =?utf-8?B?ckc4eXIyQ24rL2YvOE9KRzcreDFxNnBHZmxVTlZoc2UvZm92NStvUGpCdmli?=
 =?utf-8?B?cWFNekNxdWhFVEY2aXJvWkVsU2ltaG1tbFFiRDhyU1BRWHBoZUpadEE2eUYz?=
 =?utf-8?B?YXJsVC9Vb0ovNW5LWDYwL001ZElFVFVQZnA0ZnVpWVBYWW5Zb2xCWmFyYThm?=
 =?utf-8?B?RTlYN1pGMGJuT0dLNklxTU13emNFYzE2MHBjNnptMDlBSXJhc3VKUktTL3Fj?=
 =?utf-8?B?RHJzMkRhS3hSNWVmMTZyL3ZzNDFvL1B0YWc5d0RXTGhFcTFkbDg1dXJLM3hH?=
 =?utf-8?B?V2l2bmRCVFVzN0F5ZW5haEU0OUM3aWF4VWVvK05RYUgyemJHS29CYUpMOUU4?=
 =?utf-8?B?RzZhSEtlNlU5bnR2K2VQOWIwdnJQRkJwTml6bHlNN0ZBS3ZueSs0N2Q1UVA1?=
 =?utf-8?B?OEF1ZmxSdUVEcmtMZ0FsSkFzcWUyM3V4NEp0Lzg1R1ZsNmV5M01EQTluWEVU?=
 =?utf-8?B?dGdIRi9mbnFsdUkvdUJSNnA2VjBnenJRYkRrcHpyQ3lwbmFjUGRRTXRaTDVu?=
 =?utf-8?B?eUhpalF1ZkU5QmdsS2J6Mnk4WEViYUVxNHFlSzlkT3VoWUxpMkhLQ3oxMENI?=
 =?utf-8?B?dS9LMys3MzB1d1RFNmNoVnlVV3hZL3pGWnNtZUFiWjRkQm1BR25KRms2NXEx?=
 =?utf-8?B?SnRTSUlEbmttQ2l2ZEN4eXBqaDdwKzdrVHBDbFBtcEFTWjZiam9RTmplK0ZZ?=
 =?utf-8?B?Qkxhai81VkVIbVNqRGgyeTYyckRNbDlLeDBlNTc0VEVWQ0ZiWUJISlZBSit0?=
 =?utf-8?B?cGczQXBLdjhUZmNKdzdNelQzU0RLNHQ3N3JzL2RyZmlXSjRiSkpLTWdNOHd3?=
 =?utf-8?B?RE8weEdHSTJ6SFNSRFoyQ0NzcG54bkxQK2lkQXZ5MlFpWDl6WDNxRUpsZU90?=
 =?utf-8?Q?qORoNxHLEFDG3VSrgP/6zEOuQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b220a47-90fe-430a-8282-08dc001306bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:48:09.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5zdq6mtFQ/wsJsv6QbVvXTnIh8GvICFj2cu4kK/OV2LmyqhXYYsanfXEhgE/Bpm3E1Iy1euJRqHICWbg7WrgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com



On 12/18/23 13:47, Tom Zanussi wrote:
> Remove a stray newline in update_max_adecomp_delay_ns().
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> index 0279edc6194e..2e3b7b73af20 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> @@ -109,7 +109,6 @@ void update_max_adecomp_delay_ns(u64 start_time_ns)
>  	time_diff = ktime_get_ns() - start_time_ns;
>  
>  	if (time_diff > max_adecomp_delay_ns)
> -
>  		max_adecomp_delay_ns = time_diff;
>  }
>  

