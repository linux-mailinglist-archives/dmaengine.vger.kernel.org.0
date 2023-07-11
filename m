Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C474F77A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGKRtr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGKRtp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 13:49:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66895E5C;
        Tue, 11 Jul 2023 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689097784; x=1720633784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=axf1gFOtwrMmy1RdkB84joFhh2Nk/kcJOTZCuGlxkvY=;
  b=mQhHS0S7MSViHQkroH3f1X/nA2epK77pnDtsnu0IXMKgYEX6Bs5W4r8B
   rK/ZH0TodNsz+Y03aLqw7QmpSUoddXr9e29FLyxgFUZtCMXi+lHJORW+G
   x2KiiFagN3crnyG3cDHoKa/51rqR5Pd4V3aDmfpFiSpdi7ONYRuxHpEkU
   b8bMTJ5Znp4YVauvKUG/X4CKl2hSDMIMBhgKz138po8N6NR38b9o6xTTk
   1XxF2UwRleUuFFTS0Z3vMNNyQ2nkF84RFJ6j1uVkHJ0NelHyHzOG5c3xi
   DNbI14TctaKfASxcW13jBwaGXJCgYdGzh5MyIjVmiyozY14sGlmvMtqDf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363553740"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363553740"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786693180"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="786693180"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 10:49:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:49:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 10:49:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 10:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfNxa2FQWoXwf+ybesRtHJY4FWxE8zPFQioqZCmeNegbYQ8ffe+Owem6gEjrCDjQgOHvt1QGWYsmAVUukJAi2MBax+KYFsBqKASEv8Gka7QK8d3TXVPubW09HQIbSWn3UM5SLU6Bil4TaPJjlNN7zz76Q67I90K0NIm+EaPJrCqWXS9nwNekfHKwYIBBtvaiIhBwn3Nwc0RGllH5HYNoccTN8mL33JVgnF4k3YcuI5RSgmaEx/gjMH75PfjyN5FlA0RYJ+0iMePHMeThi8Ki4u8eLuikwTCUKFWHZ4aFRos4wR1OtmOc2dgwLCqr+3yc2z10LpQEvGz6cAoCXBvRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFZiq2fBomGlXZYRMW00uXQ8ktBaMq08CrrOBpSREMw=;
 b=oHmXae/1aU7BO2G5HMtRt2M5SkGcjSRvymPdarLxIXVO5fpj6RsOZScqlUMwEqiOo/F4t3BrDlC3r3eFpQjHayc+hkBg5r0w0ghR/k2FqU78sraLF5YymG4ewf2ebdE+nc+F1aoHMDSffO/93P/ucU3IHF/I24kCbcQ6k0YcJKKAQyU9vr3Ojwq+ctyL7B6gutseIuSCvKG4TikUF+zL9vMQZcXLnQQW327NRmZSv2wbNBbACOpFnyjThQN992lNvlG64iu45hPatKoNUv8nkNaSAlo4wC+4SScAUf7RVmf+l9f7vp9mW/FvWaPladKOY80N5lQWmpKpn9UloVIc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 17:49:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:49:40 +0000
Message-ID: <8e51fc0d-1c5c-e1d2-b8fb-e7c6c247c74c@intel.com>
Date:   Tue, 11 Jul 2023 10:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <vinodh.gopal@intel.com>,
        <giovanni.cabiddu@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
 <20230710190654.299639-2-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230710190654.299639-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA3PR11MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: e0df8553-3448-45c7-2f75-08db8237336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87puyXSMcSaPf7RxJ+picLP6kgtwe9SOrjKIF7UfYjg7PhyFPFsKCD0qxB24nCCopoAFmvrCE8a/cwJVxpdduZpBsJkErwYn6vlQwiOuNCsq6Me28K8GMdE5bxq7gj+5/2j9ike0AQ9/Zvb3amu/jPFPnJ60F2RszwM8gGhkwLIeE2cEjvXmUvTzfBxrkQzUtJlRT5HtWIYE2vOFaeS2kwXG9LbbExLHgJZzNoQ4WHrgDkNMDpcoXvVuIykvbx9NIsPu3f5JreRz4Cvp7K9prDGTwfYIyQWQKyJdbZvCEUBsJ+/OZd8qhOjIwkFohu1XWF/ulLBRGLr9GeGwlBJdQsrk+FUmWCK6yQIFlCBz66FPeukMTBTu/A2DfvJBF4rGe4B6XQJAgvTOblBJ6Bjt4NvUQR1QGEMPNa8oHcyF00SCl0PKUQdA9YjAuDKaMfJ17c+tHvsFKHATZWNxfAJKqhewEQpV8+D5lzgeR4LoLxcpzKPRFzhfusW/t5xH1qD9lSJgQXxHB9/gx78kGlbUxBWxc1uwD70m4SAN92OJfCU6e5l72CWR2g2qTkzntx/wxfX2bP5sKTBlwUbggOx2OJwUKfu4udafEMzWLMiMtVsxF2BEfsDCOQFLF5KXbDfvQOxNO7GmOLhp+zT2NnZcjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(5660300002)(41300700001)(8676002)(44832011)(8936002)(31686004)(4326008)(316002)(66476007)(66556008)(66946007)(2906002)(83380400001)(478600001)(31696002)(36756003)(6512007)(6486002)(86362001)(82960400001)(186003)(38100700002)(53546011)(6666004)(2616005)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlsZmhxb290cHUzd29GUXp6a2tXQU9CaCtSYm10YjZSQU9jaHdNNm53cEJw?=
 =?utf-8?B?Qm9tTVlVRGNuZ0N1WmdxenYzdmtCd05JalhZcW0xT3FqWDNVMSt5cnBydlYy?=
 =?utf-8?B?OEgzb1RnczNXVE9xZ2ZrK2FwbkM1NWh5aVhVZU1XdjVsMVVPdUhpVDNlOFd1?=
 =?utf-8?B?TzA4Qk4zNXd1dEd2TXRONkEzalRVR0h1cyt5OGt3YlFpVkNDaDl5NU4zUnpo?=
 =?utf-8?B?ZWxxdDRPZUpQU0JPRjhZMDNlR0tzWUExN3lDaUJQRE5PN2FBaFRvWVJUVlp0?=
 =?utf-8?B?bE1XZFMyM29WbUF1eUVFOHFKNGNaK29xbXZ6OVhPcjFEcXZETi9yY3BZM3p3?=
 =?utf-8?B?RjREbzZLZXNMbUJsWFZsMURvaHBYa2JFUXJRT3Z4c3M2WVRrLzVCTUpOUXJD?=
 =?utf-8?B?WWp1UlB3cUFGRUlmOGIxcVQ1Y09GcFBSR1NldzZpUHl3b1hFa20vZ0FBeHM3?=
 =?utf-8?B?ZHZGSDIvRGd0cUtoMnNnR1BSOUVENmIramJodlIxVk1pZjN4S3llVDRNeGQ1?=
 =?utf-8?B?eHJvWDlKR0c2eE42REZyZEdIa0J4dDVrcUpLK2lHZG5SRnQ5cWpXaGFxRkQy?=
 =?utf-8?B?clNxcDdxTnhGTm1yMGJHa3RYZDRGSE1JSXNHWkdRbjRDYWZkNTJYKzlKc25L?=
 =?utf-8?B?MDUxYXVRVE40SWkyWVZlNHdsZXJMd2VzS203RG5lUTFGUmI0blJNZ0pDUFkr?=
 =?utf-8?B?Umxuc0M0UFkrRTRkOWNOb2hzeERib1hrMGZLK21sdm01NXVVbmlxZG1XbmRW?=
 =?utf-8?B?dlhabDRPby90dm9mdUtDTUV6Wmk3MHFzNFlVbk1FWWFHOHl4Z1l3L3JScUVj?=
 =?utf-8?B?SzRhcFQ5NTVrNVVaNmRsb3ZVUDRYaFNMMjdaQnlndEgrMmx3ZFZnQ3A4Tk1w?=
 =?utf-8?B?M1pPeVM4cmtBSTVaM3NUMENNS2FvTnZWL1pRTXJyR3gzQjFyRTFmbUtJYTNp?=
 =?utf-8?B?dkIxNkFaMjFCLzM0VjAvM3dsQ3pQdDREbzNra0hWV3RjYjdFTlJmZ3BlRzdS?=
 =?utf-8?B?SFlvclY0MEIrSnRrYXQ1d0gxVmlQdEQ4N0F1WUNXMlZYOWhWWTdubGdpbi9u?=
 =?utf-8?B?cVZTbFU4cG9jNzVOdmNpc280NCtuZGhIeEwrelBxSDJjNlZ3czJjY1dOZWs4?=
 =?utf-8?B?cTdVT3FSMHlrNkdIS3V3ZWw2Z2VXVE43Y0lYT25RbXNGRHUwSkJCME0yL3RJ?=
 =?utf-8?B?S1BtTHl4TFRUQ044Rmgxb1NuTE4rL29ub3RST3FrY2o4dnkyMnRjUDhRQktJ?=
 =?utf-8?B?UmRVeWRab2oyaTFoUjBHMXhPVHIyT2ZieUdhTjJkUzhOTnBKbXhjWlZVWnMy?=
 =?utf-8?B?UFFyaTdOcnUrUFRQZ2YzMGFJSWc1bzNQdEQvMHl0V3lPcWl0dWxGNzdQZmRT?=
 =?utf-8?B?SzFwNXVMdUg4a3VjeDdNK3lNV0ZmM0NSeFB4UDl0V3o1ZFQyK051SE9IamZX?=
 =?utf-8?B?VitTc1N0MVFpemFXdEF4MmI2Qnh6ZVZUdjNnT29LeU9LWDdSYjFCdE05bkl2?=
 =?utf-8?B?cU5UNFVXYzZPNEpwOEFDOGFMWHlKL21iSmFMbXpDV1FtNDA5ejJNTDE5aWZD?=
 =?utf-8?B?NXQ3SFBwTk5XeUE1S0M5NGtzVjZ5K3p1cXI5cUttU1VDOGk3R2QreHJiWVh1?=
 =?utf-8?B?TU4wYjNmMm9RQ0pLamtnaDRSdHM2cUpwOGdYdzR4Zzd0eFdMcW84YUpmV0VX?=
 =?utf-8?B?ejl6a0VKQVdEbXNiclRGNFU1d21Jd0hnMzFybkdUa1E2R1YyM3BtV0FIVmor?=
 =?utf-8?B?UWs3TkovUFRUcjRGZVNGVHlGOURYbS9QcVdJeWtXMGY2WnFPOVVlK3JFNktF?=
 =?utf-8?B?YkpTbHg0Z0pRU2sySnFXQVZtc21WeFF0aUcwM3N3QVV6cXM2MVdyZk5ZRnZo?=
 =?utf-8?B?cnZleVRaUDkyVmVOYzFkRElOMmRVOGtTbjJYakcyS3h4Vlg0Ylc5NVJEMTZ2?=
 =?utf-8?B?OUJhTXJqWGxPSmJuSWhIc014eEVDakR0L0JVaU5sNm1FZDZYOXNYa01RUWQv?=
 =?utf-8?B?cThMRmYzUmlHS1UvdlBhTUxpZlArcUhjdFF6QVJOT0g1MlMvaVNReVlFTXRZ?=
 =?utf-8?B?b2lpS3BnV1AyTmFOSlVybDlaaUUzWUpCZFJBRGZGSisralRIWXplQW95QTRq?=
 =?utf-8?Q?jSyY0HdiyKybAr7/og/aMfQm5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0df8553-3448-45c7-2f75-08db8237336d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:49:40.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZcYPjQCvq3/FMzfOOAmAibR8WTPUDnHNm9WgetkeFhtJUMmTfqPXJlwmw76d39dTVSPrhyFzm4GL4cEd+Ebow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Tom,

On 7/10/23 12:06, Tom Zanussi wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> With the possibility of multiple wq drivers that can be bound to the wq,
> the user config tool accel-config needs a way to know which wq driver to
> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
> can indicate the driver to be bound to the wq. This allows accel-config to
> just bind to the driver using wq->driver_name.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
>   drivers/dma/idxd/cdev.c                       |  7 +++++
>   drivers/dma/idxd/dma.c                        |  6 ++++
>   drivers/dma/idxd/idxd.h                       |  9 ++++++
>   drivers/dma/idxd/sysfs.c                      | 28 +++++++++++++++++++
>   include/uapi/linux/idxd.h                     |  1 +
>   6 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 534b7a3d59fc..0e577209bee2 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -270,6 +270,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
>   		correlates to the operations allowed. It's visible only
>   		on platforms that support the capability.
>   
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
> +Date:		Mar 27, 2023
> +KernelVersion:	6.6.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	Name of driver to be bounded to the wq.
> +
>   What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
>   Date:           Oct 25, 2019
>   KernelVersion:  5.6.0
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ecbf67c2ad2b..b1ecfb71d95e 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -510,6 +510,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
>   
>   static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>   {
> +	struct device *dev = &idxd_dev->conf_dev;
>   	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
>   	struct idxd_device *idxd = wq->idxd;
>   	int rc;
> @@ -537,6 +538,12 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>   
>   	mutex_lock(&wq->wq_lock);
>   
> +	if (!idxd_wq_driver_name_match(wq, dev)) {
> +		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
> +		rc = -ENODEV;
> +		goto wq_err;
> +	}
> +
>   	wq->wq = create_workqueue(dev_name(wq_confdev(wq)));
>   	if (!wq->wq) {
>   		rc = -ENOMEM;
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index eb35ca313684..8bb7e7ff8d6a 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -305,6 +305,12 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
>   		return -ENXIO;
>   
>   	mutex_lock(&wq->wq_lock);
> +	if (!idxd_wq_driver_name_match(wq, dev)) {
> +		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
> +		rc = -ENODEV;
> +		goto err;
> +	}
> +
>   	wq->type = IDXD_WQT_KERNEL;
>   
>   	rc = drv_enable_wq(wq);
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 5428a2e1b1ec..c62c78e1c9fa 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -159,6 +159,8 @@ struct idxd_cdev {
>   	int minor;
>   };
>   
> +#define DRIVER_NAME_SIZE		128
> +
>   #define IDXD_ALLOCATED_BATCH_SIZE	128U
>   #define WQ_NAME_SIZE   1024
>   #define WQ_TYPE_SIZE   10
> @@ -227,6 +229,8 @@ struct idxd_wq {
>   	/* Lock to protect upasid_xa access. */
>   	struct mutex uc_lock;
>   	struct xarray upasid_xa;
> +
> +	char driver_name[DRIVER_NAME_SIZE + 1];
>   };
>   
>   struct idxd_engine {
> @@ -637,6 +641,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
>   		wqcfg->max_batch_shift = max_batch_shift;
>   }
>   
> +static inline int idxd_wq_driver_name_match(struct idxd_wq *wq, struct device *dev)
> +{
> +	return (strncmp(wq->driver_name, dev->driver->name, strlen(dev->driver->name)) == 0);
> +}
> +
>   int __must_check __idxd_driver_register(struct idxd_device_driver *idxd_drv,
>   					struct module *module, const char *mod_name);
>   #define idxd_driver_register(driver) \
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 293739ac5596..6caad044f506 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1266,6 +1266,33 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
>   static struct device_attribute dev_attr_wq_op_config =
>   		__ATTR(op_config, 0644, wq_op_config_show, wq_op_config_store);
>   
> +static ssize_t wq_driver_name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_wq *wq = confdev_to_wq(dev);
> +
> +	return sysfs_emit(buf, "%s\n", wq->driver_name);
> +}
> +
> +static ssize_t wq_driver_name_store(struct device *dev, struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct idxd_wq *wq = confdev_to_wq(dev);
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	if (strlen(buf) > DRIVER_NAME_SIZE || strlen(buf) == 0)
> +		return -EINVAL;
> +
> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> +	strncpy(wq->driver_name, buf, DRIVER_NAME_SIZE);
> +	strreplace(wq->name, '\n', '\0');

If user inputs "dmaengine    " (with the trailing white spaces), the 
trailing white spaces will be copied to wq->driver_name. Later driver 
name match will always fail.

A better way is using strim() to remove the trailing white spaces before 
copying the buffer to wq->driver_name. So wq->driver_name is "dmaengine" 
(without the trailing white spaces).

Thanks.

-Fenghua
