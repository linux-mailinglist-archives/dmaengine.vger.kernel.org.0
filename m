Return-Path: <dmaengine+bounces-280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BA7FC581
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 21:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67325282D87
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB45D4B8;
	Tue, 28 Nov 2023 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBOXhTri"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6491BC6;
	Tue, 28 Nov 2023 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701203574; x=1732739574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hEXDAu4sHfmxspSwffJNQh7bGl85aWGLbiz2Ky67R8I=;
  b=CBOXhTri1cFBCE5HnMPJ1HsM7SDHFOdgW3P7BhJdNzZHAjhET3aluCXG
   N2DU3ZEyAxkuvde+7IHlpDljQYL0O7DbHTHcCqq8wY0efGLOim5t3gMmC
   Nvc7GAX15TO9RbQFD00zDeuzbTfEltoQDQYS9T26fKvxK1JJxsVqUpPUo
   srrp5ckKNM/baFNCrCHBdrKlddUzFIm9fzquhhGko7WMOOvx3nDZ9oFFC
   HE2hJk+/C1MNLjuHvBbpW4xb0thlWBj/dckL8JBoqKnw9eZLM6r6ja/wq
   +YWUQrYPxL16iS6BTzMxycl3JIEkwPTWqqkfrlCQ4uSUiFnFMKZosPq3a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390178312"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="390178312"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:31:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016036030"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016036030"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 12:31:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 12:31:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 12:31:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 12:31:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjtOKMeVJCMs2Ig1jNDmLv03BIcfFhbUkm3si1/ZDWXBnL1OW0YlzzYtfGL5QXLRci5HsrXN02MKd7WqGXNvgMFwx2ztos6tpdzhBQnL4F1G8aTjyDtlcrlGO40O4HBMt0e7AJsog3pljI227WCKsET5gq0CJ3VPFs8qMf1ITS3trOlDBhFlzqj4iAyUYln/TU2v8APIbpkOagvkAuWP18Fil9vVvhc9Ja19Y5R1k47ETld74u5uCsr4oJ/WcnVuIQCJ1WJcNQS/V9gbIoqbjLOw6a2KPYbWQk92oC7PKHaaFBCvTNSgokPOHYTCGlF9h+fCmQLAfXHhcB/wYZ3TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e65dlCIjrSll5KW7AfDYUsCR1Ue49mZ9Mm5CE5oW18E=;
 b=iMUhRMw3YwpzaGrefrpjWPuxTPQbAmQNJHom7HxgaK3b8zsZaLB7PcE1RXJNxczaGfCTVyxwupdFsE83xjGYx305rxfdIc+i0vqIpBpfP33hoGWzhrVld8O2xKfa70dnvycowWPPszC4/NYVrsBCKi6tUhLV50WWHDvHj32viyEZfBpqvYwm1bUgEg3dG6pQ3X8C9cp8vmjnknzxUz8s/hQ13Rc0kiRCnpNroM1ekRcvJkDw0YpIkQkFb8Tj3TTpWtSGyaN95gPypIzTYb1z1fbj64MWgxpUIhziAQQhJ2yU7KrpYyY35jSr8p8l9RdzxcS1n+cKqgpef8tsXzsUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 20:31:41 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 20:31:40 +0000
Message-ID: <00aa3b9f-d81e-3dc2-3fb0-bb79e16564d3@intel.com>
Date: Tue, 28 Nov 2023 12:31:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
Content-Language: en-US
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <vkoul@kernel.org>
CC: <dave.jiang@intel.com>, <tony.luck@intel.com>,
	<wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
	<kanchana.p.sridhar@intel.com>, <vinodh.gopal@intel.com>,
	<giovanni.cabiddu@intel.com>, <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
 <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 51908d38-68dc-4f71-ca79-08dbf0510701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fPoQeS5ufhgEunp3kXoS5GHEXr8CIPwZ9/xrZrHpMkLZtrN/gLeU0N1EP1eKWK5cagKQonX+qOcitCE+xY4XxRFXhevCHV5G0oMoqW3qbImuehjZQxcqit4sfNKd1fAArITplo0Sqyz+h2gVfO36aLi6ctWQWIXQd8Eyx7lzm3A4X3Ta1u6mRAPr+7SY9eycCnVtlqgcMZ0D5ag4qrnMHRjXFEGaVxnUC4oFvaM4rYu5wRo3N78ECc7iyur14CSKJNnmF/A2XezQH2b62AinMG2V9az5e0XQAuXOeXLXxuQjLnJ0m8vxN1qDuI62/OPfSlWaGh05vk0/piNgGljc6bszQ4XF7tqK1NdWvvEIcWmEbOYX5jlgzJ778ROH7cKIgSFDjaih/aD+j5bGcOeldKIa/CBSHd5g0kgxgE1wqu397kpSDFolZxtYe3HVyKDYGh2HFo5nSb7Zz3yAjeTH5Nh05+app3CfiTGoWT1Fma7v+EgETi+ck2Ggd69dslKfcwR9XD0cifwGSWmbxWRHugNlGYOc3H51DN3ck4CSuNAcwK91ye7Kg2ufFaPqYR3lKJ8ETblLucXfgdqkMmyTM2azXkSR9x+4+6fm5JV9BktPcLWqm/2N1SasJpKj6lQd8L6a+QA/b7QLsl+3moKcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6666004)(2616005)(6512007)(26005)(478600001)(53546011)(83380400001)(2906002)(41300700001)(44832011)(6486002)(6506007)(66946007)(8936002)(8676002)(5660300002)(4326008)(66476007)(66556008)(316002)(82960400001)(38100700002)(86362001)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9kMjJWcVYxWnE4aStucXV6c1h3WTVVUlZhUFhwb21wNUhzcnNsVk9ZNGFt?=
 =?utf-8?B?Y1RmZFVtbGdjZmY2blNxbW55aG8xN3VtYm9Lb0QwYjhSL3JQbmVrK2ZJWVJR?=
 =?utf-8?B?NU91UFJpRGRSZGlNR1ZuWnJqMGYwc3RzN0RPRG14Q09LRXVtY2hKYjcwMzNr?=
 =?utf-8?B?QjFtbWtxSlRVaWxEemU3Szh5TWwrSjBrZ2szckdPUy9mQXRjRUE1TlhDN1pr?=
 =?utf-8?B?M0VRVVRoWG5nY2VEQVVDQjhzcGErOE0zUEdHRm0rRFZUUVhoYm5yMzFjRkNn?=
 =?utf-8?B?WFB5RWVGTHFDbll2NmtNSGI0eVd1bFZDcE9XYXEyUkEyRjRyUG1yTHR6cmdF?=
 =?utf-8?B?alc3LzdxMGJpRWxaQzQ4cURqdVl3OVRxa1ZHTDQ3Y0xNUzZOQlI0dEJEdVpi?=
 =?utf-8?B?U0dUMlJsMTM1UHhzRGlHZis3Ni80RDRPb09pRzJnMEd1Y2U2My9WYVFrRitI?=
 =?utf-8?B?S0lqcU1QeEl2cnpSOStGMXRnU1F1RkdscE5GZFEwcjZ1N3FrajZUNU1yMDZK?=
 =?utf-8?B?em5Qa1RhWGJtb3IxZEdaVTJmOVFEYVJtMW9vK1FIbXA3RlR2dVFHL1p4RFRW?=
 =?utf-8?B?eVZ0UDR3SE5tWlpIQ25Ua0hPM1RCNStGN05XVFJvUTd0N0R4NG1rOEdPOUpl?=
 =?utf-8?B?L3FSdjdPTDN3WHlDN09wZUpDVHRWWHBGWTdNUzk4NFFCT2V1d3c5UWNkZmZ0?=
 =?utf-8?B?WXNlNEtOU00zeFlRN1A5MFdIWExlK3VsRitQYTdpMUVKdDRWQU8yTGVoWGUz?=
 =?utf-8?B?ZndlckJZVGRxeGs1d1k4OFROczh5MXFBRWhpM3FnNG8zQTBOS29RY2JKQngw?=
 =?utf-8?B?QUVhVk53SytHK1hkQXhyM2lOU01GSE1YMGZVbHNxYW1wclNuZk9IQ3o5Rjdu?=
 =?utf-8?B?eVQ4aXJEV3hMdXkwNjdKdUlLRjllbUZzajVKU2xMT1pRdjJmazlXTGp2NDYx?=
 =?utf-8?B?TkZnelRyQytwTjA4M0JXK3hkSXBWVUlUb0ZDcjVxY0szaVNpQ2g2eUsxSXJH?=
 =?utf-8?B?WE5KTUZDeG1ObFFnNENZcDgyaWs0NEJzUHlzeS9ZLzhTMVhaYnBDblNWR1ZM?=
 =?utf-8?B?a0l2eStMeTd3NHlKdjhLMGkwTEI5bm1meHNxSElGQk9pV1E2bTJMaENOTEJ5?=
 =?utf-8?B?QXVUQXpDOGJwaFZYdUF2cGY5aXI0czcvV3ZPdzhROXFSMGwrd0NVSWlOODJk?=
 =?utf-8?B?bjZBRHBmT1FNeVFrV2dDWW5rMTRmcENFM2RkcXlOMjVCM1p1Y0NsbTk3S0ps?=
 =?utf-8?B?TmtMME9JTWRxa05WNytwNGVxVjBYZkV6UEtvMXJ3K3ltMXdqcnFoVE1lM2VG?=
 =?utf-8?B?VmNQcExheWU4ckdRaU5TQ05vVjRUVUlsVnUzZnRPWkJha2doQ2ZOdmVmVDJV?=
 =?utf-8?B?NWE5Qnpjb2p1bUE2OUZkdnMvdDcycWEzT2pWOWpJSmdZZEJya1hoR0lJNkVV?=
 =?utf-8?B?VW1IaHZwdHI1ME54VVE0a1cvdUZGbEZ5d2JYOEZya24yajdhTmNSRmV1cUNQ?=
 =?utf-8?B?SW9qNDZSYnNVdmF6aGczcmNqZjkyUXphckFUcXF0QTZqOXBqcUJGbFp3S04r?=
 =?utf-8?B?ZG91NXlQVWhRWGp1eEJBeEs2UFk3OVBFWndMWXBKN29KVmtocVJsRDEvVS8w?=
 =?utf-8?B?L1UyWmJkV25VSm9qKzQ0SmovQU12R0hhTW1kNmhvVmNwbDlDZk8xUy9yeG1s?=
 =?utf-8?B?V2VqczQ1dDNSZmxqVlBNQ25FN29iaHhjUndsdXhxK1hLY2lOZzVWdHpnTXNY?=
 =?utf-8?B?NzM1bTVXdks0RXRDajRvb2F2ZjBobUE2dkNXY2hZdDhMSjdUQ0U3eTUyc2Uz?=
 =?utf-8?B?dyt2UWw2WEp2Q01yK2QxSW9WMFZ1aXBOempZV1VFMUwxU0dDWndhdmMyMWVz?=
 =?utf-8?B?aURsN3BmdHdTVTh5VTFDT1oydlZybHhJY2lOaVQzTS9COGFza3ZPMHpZWWJP?=
 =?utf-8?B?RlRVZzdPeWhnWjRrYm9sRWk3YjhkYXVNZDRwV2R6bmF0UnJjdVQrdmZsNTBa?=
 =?utf-8?B?UWlpNDdxTk1EY05TSEQ0UnZaQlFWOE9YaFlDeVJMeUpOaVMyRW4rMWtiajRU?=
 =?utf-8?B?a2JFUTVEZU1oZnQ4QmVrYWZOY1h4UFlIenc2NWhDbmJISENQQzFOS0NlaWJo?=
 =?utf-8?Q?kCz0lPO7RMEpuReFMalW0lJuc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51908d38-68dc-4f71-ca79-08dbf0510701
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:31:40.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CakinPRrUBO4V2oumGQFyh/hWFfFWxZ0Jm4jKrGeoQU5ryeVpF1uVo4OVjSWVAknZmOrNkeJffMwnVUB6okUQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5373
X-OriginatorOrg: intel.com

Hi, Tom,

On 11/27/23 12:27, Tom Zanussi wrote:
> Add a load_device_defaults() function pointer to struct
> idxd_driver_data, which if defined, will be called when an idxd device
> is probed and will allow the idxd device to be configured with default
> values.
> 
> The load_device_defaults() function is passed an idxd device to work
> with to set specific device attributes.
> 
> Also add a load_device_defaults() implementation IAA devices; future
> patches would add default functions for other device types such as
> DSA.
> 
> The way idxd device probing works, if the device configuration is
> valid at that point e.g. at least one workqueue and engine is properly
> configured then the device will be enabled and ready to go.
> 
> The IAA implementation, idxd_load_iaa_device_defaults(), configures a
> single workqueue (wq0) for each device with the following default
> values:
> 
>        mode     	        "dedicated"
>        threshold		0
>        size		16

Why is it 16?

If wqcap supports less than 16, configuring wq size 16 will fail.
If wqcap supports more than 16, wq size 16 uses less wq size than 
capable and less performance.

Is it better to set wq size as total wq size reported in wqcap?
>        priority		10
>        type		IDXD_WQT_KERNEL
>        group		0
>        name              "iaa_crypto"
>        driver_name       "crypto"
> 
> Note that this now adds another configuration step for any users that
> want to configure their own devices/workqueus with something different
> in that they'll first need to disable (in the case of IAA) wq0 and the
> device itself before they can set their own attributes and re-enable,
> since they've been already been auto-enabled.  Note also that in order
> for the new configuration to be applied to the deflate-iaa crypto
> algorithm the iaa_crypto module needs to unregister the old version,
> which is accomplished by removing the iaa_crypto module, and
> re-registering it with the new configuration by reinserting the
> iaa_crypto module.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   drivers/dma/idxd/Makefile   |  2 +-
>   drivers/dma/idxd/defaults.c | 53 +++++++++++++++++++++++++++++++++++++
>   drivers/dma/idxd/idxd.h     |  4 +++
>   drivers/dma/idxd/init.c     |  7 +++++
>   4 files changed, 65 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/dma/idxd/defaults.c
> 
> diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> index c5e679070e46..2b4a0d406e1e 100644
> --- a/drivers/dma/idxd/Makefile
> +++ b/drivers/dma/idxd/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
>   idxd_bus-y := bus.o
>   
>   obj-$(CONFIG_INTEL_IDXD) += idxd.o
> -idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
> +idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o defaults.o
>   
>   idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
>   
> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
> new file mode 100644
> index 000000000000..a0c9faad8efe
> --- /dev/null
> +++ b/drivers/dma/idxd/defaults.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
> +#include <linux/kernel.h>
> +#include "idxd.h"
> +
> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct idxd_group *group;
> +	struct idxd_wq *wq;
> +
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return 0;
> +
> +	wq = idxd->wqs[0];
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	/* set mode to "dedicated" */
> +	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
> +	wq->threshold = 0;
> +
> +	/* set size to 16 */
> +	wq->size = 16;
> +
> +	/* set priority to 10 */
> +	wq->priority = 10;
> +
> +	/* set type to "kernel" */
> +	wq->type = IDXD_WQT_KERNEL;
> +
> +	/* set wq group to 0 */
> +	group = idxd->groups[0];
> +	wq->group = group;
> +	group->num_wqs++;
> +
> +	/* set name to "iaa_crypto" */
> +	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> +	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);

Is strcpy(wq->name, "iaa_crypto") simpler than memset() and strscpy()?

> +
> +	/* set driver_name to "crypto" */
> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> +	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);

Is strcpy(wq->driver_name, "crypto") simpler?

> +
> +	engine = idxd->engines[0];
> +
> +	/* set engine group to 0 */
> +	engine->group = idxd->groups[0];
> +	engine->group->num_engines++;
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 62ea21b25906..47de3f93ff1e 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -277,6 +277,8 @@ struct idxd_dma_dev {
>   	struct dma_device dma;
>   };
>   
> +typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
> +
>   struct idxd_driver_data {
>   	const char *name_prefix;
>   	enum idxd_type type;
> @@ -286,6 +288,7 @@ struct idxd_driver_data {
>   	int evl_cr_off;
>   	int cr_status_off;
>   	int cr_result_off;
> +	load_device_defaults_fn_t load_device_defaults;
>   };
>   
>   struct idxd_evl {
> @@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
>   void idxd_wqs_quiesce(struct idxd_device *idxd);
>   bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>   void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
>   
>   /* device interrupt control */
>   irqreturn_t idxd_misc_thread(int vec, void *data);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0eb1c827a215..14df1f1347a8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
>   		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
>   		.cr_status_off = offsetof(struct iax_completion_record, status),
>   		.cr_result_off = offsetof(struct iax_completion_record, error_code),
> +		.load_device_defaults = idxd_load_iaa_device_defaults,
>   	},
>   };
>   
> @@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		goto err;
>   	}
>   
> +	if (data->load_device_defaults) {
> +		rc = data->load_device_defaults(idxd);
> +		if (rc)
> +			dev_warn(dev, "IDXD loading device defaults failed\n");
> +	}
> +
>   	rc = idxd_register_devices(idxd);
>   	if (rc) {
>   		dev_err(dev, "IDXD sysfs setup failed\n");

Thanks.

-Fenghua

