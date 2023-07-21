Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAE75CDCC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGUQOw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjGUQOf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 12:14:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157D4233;
        Fri, 21 Jul 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689956046; x=1721492046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5AfdzEEXYlZ5R59gSPra71OuWCNcEWLd4yM/PpBFF3w=;
  b=GRZScfbtmFooZk+8IInNZ0qqNdEMsVPH+oPbKrjNsG4sVtyGpt/+wdGw
   +4fvsPpKFxV4n8XgPq7mi4E53HY8K+04ltcCoPem7kl9NXM68Gr8sA6AE
   gji1NmQxsrE7H58xHZxyHZ0um5F6P9PIWZrdkPXpBhZmsWVD0GqcLPeDO
   dSWD11hfwR1dPNRDJHQyfU/MaMRR8uJ6ZzN3jWnoBUSiyHb8j9GdSzPBY
   D5af/lzPJ0hghpwpUIeh0p+Ozy8w3nrZdnWpVHZQPM4O7i8oK3EAPWDig
   RTm8/wSaO+hXAVuNa9H6zmccV9FJXj5wMQ6ABZYF/2r6uQNnmifmoxqwd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369729269"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369729269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="790245742"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="790245742"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2023 09:13:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:13:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:13:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCHmPhTGKF/V9y5vGY4fhTin43K7cUH9OnipBDAYf7jAEs4Ga6Ac8P1h2reTERAuDYJzHBuau4xGGU3QpIg4FvM2QPnMToi91v8KZ+21b+IxRgJe0BZwP9rJKW7P09JTQpa1YdKoDCy7aCs024f9ej6zStKHuKVnkOMUGPLnafGbg2TzmEMYzamfZUJgFvDS2Neq6/wG4BHqGSVwVFresdLixqVQUHB9XLHbjGtW9ygHbRwk+pX2zsNR26PjbhWPb898bjUKDhR1ZOZurgWB0/WOoH2zwwxrHZVQwOUKWIpEvGTwPAFuoO9gt4sSsit/jaJBOmVXrdLKAqnrWvFiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwjduiO1oWqDfL91OvO+ZqXuILIMQdqS8+6qvbkWAjM=;
 b=IBcVK6ApvB3GSYTl+WNptzDejEBgPcpx+JMJ6M54PUVJRrhUw6xFLssKwhVPz7DuDoWklDmDLwKzVhtDTO3y5D7GOdO8qIz244evQaQLTibZYVFzDT8vxMSnz4oj9/dLfevCaeZRkrjF9DMsW9NmG/9OsmIKlF+SiB33EEM89uBYFEd1ha5JFVpGHo0Eg2kEOK09IAUTNyE19g3ThmdguHWc21L29qmJADqDatnWoIfeysGwP1QcHjBjThIczjCIkX0mqpGeBqG7LkesjI+3VljX06ATHiRo18dRDhLcOBjSUMqYnePk7yE4070W1/9GEiHkH4JttalWKfvL7tCjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 16:13:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 16:13:04 +0000
Message-ID: <45b605b3-00ad-d3f6-ed4f-453caaaa6586@intel.com>
Date:   Fri, 21 Jul 2023 09:13:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
To:     <sunran001@208suo.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
References: <20230721073440.5402-1-xujianghui@cdjrlc.com>
 <0bd20a5f09b3419e1d4d8c2b6786e886@208suo.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0bd20a5f09b3419e1d4d8c2b6786e886@208suo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c92fea6-901f-4116-59d3-08db8a055d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaJqZOtNSMKvi6lRqt4jhj0cMVI+3OsIGdQjCsNAmnIGPiUEyoF8tqa2zK5HC1sZF/dEOKFO0XQBs88uzGRmTP914bWxd0DYd3bnUW1wUyJORgKsAODr3gorZBo4lGCYJHvX4mzMu34SthOghAGECunQt82Ei+i8cHLCL4e3huRRqsa5NpAtY8MEvpU+qOayFa2yZnMvbGNIRK6rK7a7bbUgzLzF2Dr9awHwP5dTyBKiFLuyyRiAf9q2d9eE2LUxzhDpBc/iyPv9gws0r+mEVkdEurZSO/bhgj9qC3i3/pFBtlebppBo6bvx+ZzcKmcI8IBTulOgjtZ5jCiweuOMySjvLmRUodNnsrNq4ZH9Qbqb5GE9ssYp2yhjb+GURP4TBDV4vaFbJGeOumMGxi5RORM0nKCl1lgfS3NqG56nEJbh1fxZYCtIKCdCheLhX9UrtQfJ55M/i7Ly8tq78p54a2NVDSdo4vgKes0XAgqOQ0llasvbKR2NJ1BDq9d5aqTg1ntpqE8cojgC0N3blTHlEcPGGjdxcEsTiiXS904Ibq5SgJGz7x5P5Ge2Tmjx1+5MA0QD42q7DYmXnHnDSZBghk0SONbF6w4U32AxeoiusDKe0W2IzCOs+2eZ5dvj2kW65G+/oULumzz89CNhD0vVYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(82960400001)(478600001)(8936002)(38100700002)(8676002)(6486002)(6666004)(316002)(4326008)(41300700001)(66476007)(66556008)(66946007)(2906002)(186003)(26005)(36756003)(6506007)(53546011)(2616005)(86362001)(31696002)(83380400001)(4744005)(5660300002)(6512007)(31686004)(44832011)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhGcDFmQ2ZmdVdsYWlyVjhNYlBTU2o1VUpFV1pPdzdZa1o4clMxUDRzQzEr?=
 =?utf-8?B?WkhMQmhiSzh6WFZSbWJRdXo3QlRaTUViM0RzTTJmbVp2dTU2OFpQOE9taHJl?=
 =?utf-8?B?ODBkSncxZGxqRDFKd3lEaEthTk95L3IvNzM1Nk5NUFNZdWlKTHhNQVcrT3BM?=
 =?utf-8?B?WDd1YTgyVHBaQ2w5Q3poTTduanNoL2M3WjNaWWtDSDN6eXdXZ3dpRkhHRXZJ?=
 =?utf-8?B?SVBqUlNMR1lSSSswZ255VVAxbHA3VzVhN3VnY2NsQ2pCT1l5Q2EvY3hZOVBM?=
 =?utf-8?B?Y1U3MXZsV25XaXpNenVqUURsT295THFUREEvOWc1a3VVUVhJdXZFSWdlNXk3?=
 =?utf-8?B?SnZDK2VLZGIyVUNOZ29UVXJiZmNNUFUrZUdlR3N3MG9DOUYyM0JJcUpKRTFR?=
 =?utf-8?B?SkxOSG56dmcrcENSRVllWW5kWFM4OVRERzRocE5QZk1wam9rYXZTRHZZcVlq?=
 =?utf-8?B?VU5VVjM0OFBwTThHR3BqdnorUXFwa3ZjSW1NVmhOWSt2bjBiWktKRUo3d3dK?=
 =?utf-8?B?V2E3MFBlT21KRVJSSVk0VWF0dE96cllsYVZKTWFRbEswMXpaVENra201QWtL?=
 =?utf-8?B?ajVoV2VzYkwxQUJEdlR1c3JBUnYrdzZtTTJMSXpxSm8ycno0d2x1Wm9mZlBB?=
 =?utf-8?B?SEEzQ1dnczVVSXBTeXRzbUN3aC9ZSnIzZ1pVTUh0N1Z5N3NscG1NTnNDYnRt?=
 =?utf-8?B?bzBjcnBPZEpvWE9PVzRGMU5FZFFBNmVWcWE0YzE0dUtIdHZIZUcxYUhBTy9y?=
 =?utf-8?B?ZTRvaDdHbTBwMm56TFp1UWpLM2xCVlp0b0toRHJmUkZuRCt1ZCtEdm42UUxK?=
 =?utf-8?B?ZEI3YVo4OEhqc0dRNGdOcTdEWnBxUzhnOW02U0J4NFZocGF5alJBakRNK2sw?=
 =?utf-8?B?YVFNbFAzeWcva0JJRE9vRk52a21OYVFLcnVrTTJTZWhzbmxEaGp4b3hIUjFn?=
 =?utf-8?B?aWV1K0VCa3lTdll6R1ZhMXpNOTNLSWFQNjVybzc5UmVNV2Nrbi9sNFE0M2Q3?=
 =?utf-8?B?emd3NG9VeU1RTkNmbW9Eb1NaZWMzVjFWZko0OTVKejVyN2xGWVNFQ2tubi9m?=
 =?utf-8?B?VWpKVmJQT1NnSlgzaUhKRGJKOTZxdk5UcnNBa0U1R1hNcUhvUnVDYU1BMGZ6?=
 =?utf-8?B?NVVaR0ErR25iREsweVdGYVBlM2ZvaFpJeTlNYWRvV29VZjA2eVV4V2pDa3RD?=
 =?utf-8?B?aXBaWVdOem5BN0Q1TmdENTVvLzVjbTNyMU1YZzcwZkc4aHNhU3lwaklPSWNP?=
 =?utf-8?B?SnhYMmdjYTlIL3h5dkxWaGR3bFR3bDh0Q3VIYW9JdW5oMTc0cHBSd3hvS0dU?=
 =?utf-8?B?VTExOFpuS3VuY05SM3FDVUlzSG44Smk2c3RLbXdSZ2I2MWxGbmR6VkpDRURN?=
 =?utf-8?B?RHZvYURaYzNVVkZyZWxXalJ5OXF0dHNzc3hZWkpZWGhpZUR6V1M1L2dNakNp?=
 =?utf-8?B?SW9Ka0lEOXdSZ29FMWQ1ME9UMDJzVFYxSTl5Z1ZRemIrMlNkZ0lYRzZXRDk5?=
 =?utf-8?B?c2pFZ2JrN3hMbmZzZkRTcmM3V3RQOHduZi9LeCttL1YwcTFZQmlOL25SeUtj?=
 =?utf-8?B?bmdzNzVPcUVPWjRJeWN4ckg2VjNRMWgybXZMQnNJQzd3S3pJVGVsSTZQM2JG?=
 =?utf-8?B?NmpmM0psM1Nmd1ZORTZxUFhUZHN3K3NVMHJpdGRHRWNuaUtxdzhrbzNRdTBE?=
 =?utf-8?B?dnFOdlR2ZGxtdmxLVmhoR3IyWVlVYTZhbGxtY25kRXJPVlhhVlRacUxmaXpJ?=
 =?utf-8?B?UXQ3SDE0aVBHU3dRWUhrdVlxT0JDeDd1bWJoajE3VEwyM1VjSXcxbGZvR3Vi?=
 =?utf-8?B?UVZpNGxmTkFDeFZJQjJhZzRFS3ZqZmlYSGVNTE5tcmxYY0UxYXdWcDlRZzQx?=
 =?utf-8?B?cDhRakFrTzQzc3Uxc1NuN1VLdjBUb3JtRy9tMXEwcUdXL0YzNSt4YmlZYlU0?=
 =?utf-8?B?Y1VHa2E0Rmx0WUJxVnJCVTFlMUIvZ2RkR3MrVmJRcm1uNng3LytzR21kV3pt?=
 =?utf-8?B?WGlGTUlocDFSSWI0elJGekVsNXBsY0tXdzIxN2xuOW11YjVrQUtLL3JzMzZm?=
 =?utf-8?B?cXNOWDNZQk1XZ3hjeDZaNWlaOXJmYXNKK0VsckdKTjlXNUtJb1RnZ0R1VEUw?=
 =?utf-8?Q?dUHqj3Tet3a41mU9s19r1lpE+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92fea6-901f-4116-59d3-08db8a055d23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:13:04.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikiL7+cCAQwWyYLRlfqX1RKQBfegqynsteWS5CpzyjYhM48hdpFDvxAFPrdngANlELVVOpBHBPsu3y+N7Ke13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/21/23 00:35, sunran001@208suo.com wrote:
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/device.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 7c74bc60f582..72330876d40a 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -792,7 +792,6 @@ static int idxd_device_evl_setup(struct idxd_device 
> *idxd)
>       evl->log_size = size;
>       evl->bmap = bmap;
> 
> -    memset(&evlcfg, 0, sizeof(evlcfg));
>       evlcfg.bits[0] = dma_addr & GENMASK(63, 12);
>       evlcfg.size = evl->size;
