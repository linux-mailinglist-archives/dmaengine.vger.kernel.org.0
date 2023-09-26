Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF87AF1B1
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjIZRX0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZRX0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 13:23:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2B126;
        Tue, 26 Sep 2023 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695748999; x=1727284999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/XHIWj2IjKEBGi/eS5O+cXb7Yo7aw662hO/uzO147b4=;
  b=ZMztokIOaxq9PAhssAvwY6VlbhdA1Ux01aM+bh4Q485LxxGVaR9Gdmwx
   0MgpPSCIJflrxdW/hioHkIe3/i2JjmBo7gZc+PY8eReWwb+o719kuTyDl
   PCXA9u+gz9erslxOwyEmJKzbtnxWCH9Dkn3tYeCKmvXw6s/XS4W527uNq
   6vi8sMBIW9EaqoRaz3FB5UImKS/eI/17yApwBf+EWBcAEJV1RDAuJvvVe
   7pxZqj1kQVCXnUGODqcpF0JuPrzf68rhwkZB8jKhe1LhfnvEtmEZ1OirX
   dxnfQnx+Fo5APfB3BUYARszg6epNRDkK1G7raxylRnnfPAY9OkRjRzzzz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467909447"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="467909447"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698544866"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="698544866"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 10:23:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 10:23:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 10:23:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 10:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scp/0WSwrQZlKOYs2OWIFCBdEUFlehCWDmepwX0MmCGFy9+GyylyctdAlPnvIiDx5cebbpdyJwTo7oWQtb/6uR+5WjhuGZlHe7IyLGGycyLeirWIKXRWSLYzblQECamjWliQfU1woaUg6FuZzF8QFFfUVfTs2kM+zmw+vGd1lryz9fAev46NKf5rhkxdbt2/DP9ukdzWU2cEVWi2GuT0GqRBafNZhuHzvb1z7Z9jRh0MscWH4xqsoH9mO7dFe5vdvoFnIfagjaoamgmcglB5HOfm2IOVbaLU30AQUZXvhabbN4UpvZYWHay0jWNIq3+MEYR8BsGJBThmNPcz0tIUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geD+ozL0fUZhalTeMPaFGV0b0Wk8i5SKeIOB531JhiM=;
 b=iFICSqmYjYwKrELz3SbSR5Oi0yayYNNXIh+Qm+57/dvCT6yifcne2dDiSXt/QDlroUHG9jGcaZ09AofjTwcguMllb5VAcGY/SZWn/8BQ4c1kPTJJ8l59t5dk/0cS+Yu8R3Lh81o8T40tbUhDsEq3Gmh6zJDlQ5mG/xgAdJc5H9zApYtMYD6lVuFdhtRSB4lvo1q4D2ZOapSI2dhOGG/O+jAljyaoeydN4vFkY+ws/9rEI7Wr4Mmapp77beU9iqCa36XOtLBoCtr5qWSndHsL5N8e7M15N54QQEYcUz7zOvYYwwn4iVwb+mDbS1F1mDdRa7oMBkGRnXxivIxZfccljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB8229.namprd11.prod.outlook.com (2603:10b6:8:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 17:23:08 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 17:23:08 +0000
Message-ID: <983b5c76-f611-ffa3-683a-f754efab9d4c@intel.com>
Date:   Tue, 26 Sep 2023 10:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: idxd: Register dsa_bus_type before registering
 idxd sub-drivers
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Prinke <michael.prinke@intel.com>
References: <20230924162232.1409454-1-fenghua.yu@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230924162232.1409454-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f037781-2e0d-4125-1a9b-08dbbeb5403d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IFCWGoqb9VT6IIFLGiy32EjXyfec9Ff5udejijS9y0DEhYkYIlm92zWlBx1u4A+R4W8RIENItKmbxfJFn9FycKm02WaqZBVRhHdUBgvbBtw5z3cydwx9fDv7ZumlUI9r7c4os3+yaoA5HzA5sGz+7fUloWsUfNF+MQc6alIUyJlAuRrnxmq4HQiJqzq2MOj6dagCmJX2CRQbvmMb6mQRsUEldDkzXGdNGZAgi3mu3mJJ1SIXyB//8f9LJLTxS/TeR6jKfnBG4S8+JY1iYCpWyo8NhNK56/2yXAYpRZwE8iv7gf8sGyQ0W9CV69dRACB1KQzvdLN/0lXnD1nwCJ5z4J66zSedYOVtahWTBIqPucFzIETqNskYlDhKEYfnezRfnuJiWBioqDa3z708cZAor7KQcB1xLjaz9yy+aNahnsPuHUl3jL/a8SG9c4YlZIWV4JN8IP5xGdACMjhSwpoUg8K7l3SXgLsTR+/Dw/841+AKa/6FTYxWGTTLm+caelHKc7t//9G1uHlIRGOBv2wiZUVt3vXAIqojGnOFzbXi1IcCjPL9KaD7thTMcxkvcLFAMq2uWg7S4J0LZ05hrNC7/OzmY+UzCvTAw399P9NrI44qAePrrDERjFDA8zltO1raiqBfES54yMgRYiQrY0UVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(110136005)(6486002)(66556008)(66476007)(54906003)(316002)(53546011)(36756003)(66946007)(6512007)(6666004)(6506007)(44832011)(478600001)(31696002)(2906002)(82960400001)(5660300002)(38100700002)(2616005)(8676002)(4326008)(83380400001)(8936002)(107886003)(31686004)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlHdk9FemVQR0RBSnNMZzN0SmFndi9zcWpmdHZSdUNuYnlhMld0SjlvS2wy?=
 =?utf-8?B?SUljOWxIVFRBVVpRZ3Z0QUZoMkNMSkl0cHRpMUxUZGMwYkZUZ3lzZ0MyN2xq?=
 =?utf-8?B?YjZ6WWJkSXpMRkc0aXNXYkh3eHMrWHoxUjBRK3hrT0p0cHNlNTFFbGNzUkVw?=
 =?utf-8?B?V244L2dueDdUelAzZUEvS3IrVTZIQklYb3dicUxqZXFVQ25ack81VjBBTDZK?=
 =?utf-8?B?OUFtdERreE5QcHczRjJOQllYazEvVDc0STFLVVRqVmcxOHppZS9HR21qQXJ1?=
 =?utf-8?B?UlRMV1lQUXM1aSt4UmVTNzYzV3pLZ1dhckd4cG9UbXpSU0J2ejFEVCtKYzE0?=
 =?utf-8?B?cmp2RytQMlFoazJXalV4djJ1cEZSb3dTYzRVQXJadkhVekF2OEhmUnJLUmRz?=
 =?utf-8?B?aVVLUVU4US9qOG9samNzdWVIL2NOcmFTYVN4NFlIZ3pXbCt4UTBwb0pGN2pl?=
 =?utf-8?B?c0ZkSlJ5U2EyRnhNdlVHZlg4cm80M0ZGUlBibHU3SjArUzAvVEtzWnJUcWNR?=
 =?utf-8?B?cmRCMVpIV1NrSFJYZEdOSk5QTU4xL21XamFaT2xhZ3FuejFwekVEVUVYeWNF?=
 =?utf-8?B?UUM1NVBFN3hKUnc1elNvWUp0REM5TUNrTlNnOEh6bTZwaHJVMXdtUWNNT3Uy?=
 =?utf-8?B?M2lENXJ0dFFNd2xXN045Y0tDZXZKQ2YwbEdHREsvWjVzUjVyT3RSQm9rV3U1?=
 =?utf-8?B?WUtmdEQ4YlVjamlkUFpQbEtHVVRuc3l0ODRNSGxhTC92OU8xTEdzekhaL1RL?=
 =?utf-8?B?UThLR2ZQVnd0OU5xZXNWbFdLNEhCSkNtaUNLYW1HRCtOMVdNOWowaVhacE1Q?=
 =?utf-8?B?WWRTMzZZOFlVblMwL0FzLzF4d1czSFRhTElMUmlZL2pXL045dTBnWWtRdjFC?=
 =?utf-8?B?TlFrRTdQOTVraXpYT1d5K1ZNd29wMGQvK0d2TFhGUnFNMmJEMytaQXlaTlBD?=
 =?utf-8?B?eTREa0pnZGVFdkRHNDJFdzdpeWFsQ0xzaUx6OVYwcUNiL3hCN3JlU3RnSGtB?=
 =?utf-8?B?L3R4eFhGV0p0QVliY2ZldGk4SVEwK2N6RGtxOHkyb2JrODkxa3kwRnhIU0xu?=
 =?utf-8?B?UzJtaVpIZHBDSDZmbXl4Uzk2UjJBaWtLK1l3Y0YxbDNMaWYya0d2M0lFdXd0?=
 =?utf-8?B?UnE1TXd6aXlYMStEanlsRXpTSlNQV3d2bG5zZU5iVkJPTGRCNWZrQncveVZi?=
 =?utf-8?B?S2VEQmU3ZlVaeXUzMllJb1ZDbGpYb3JZVFFRSEZMNnRUY3puRkVVY3RjNmk3?=
 =?utf-8?B?OXY3T0JweU5nSHlxbUZRM2d2ajZsdG5ZdlVvelozT2xCQnpLME5ZS3hVeU5O?=
 =?utf-8?B?dUhvZmoyZ1ZyK1pLR3BnbklwWU5uOHFmdXhWN3hiMWt3K1MwNDRoeFVYSTdj?=
 =?utf-8?B?dDdDVk1wQ1M3ei9rOGYvVk1rYXg3azFlNzk2SHpxVW9PV2JGa2VxTlE5aGJs?=
 =?utf-8?B?anF5T0d2cG9sRmszMUJJcmJpTU9Dc0s3VGFYN3h6RVd0eWJNMEhVdFk0Tm83?=
 =?utf-8?B?LzlTaGZJOVJacmxFZmV3NG9qTTRxbVdGVEk3Um9xNE1kQTZienVvYVlpamtX?=
 =?utf-8?B?U3o2S25HdngxTUVaN1JMei9FTythaEhFYUEwM1dybW1CaU9ObjhFcGhzdGky?=
 =?utf-8?B?ME9pZGtFZUhwOVQ3blB2eUVIMy9PVjNiZEs2WjNNWmRISzhSVE1oaXRZbFlO?=
 =?utf-8?B?UEdiM3JJeU0wSktpMHhScWUyVnBsRHJhNWFrb3VSQVVkSHZsRU1sTTgwQTJw?=
 =?utf-8?B?N25SZlp4WG5RTkNzTDkzNGoyMCtwN3lvWGhpUFNaUDlFK0lPYjU3Z0ZkWnFN?=
 =?utf-8?B?Q2pjeEo0TGh5eUNFY2xKWmRDQldxT1NZL040MEUwOTZNOTg5ZytVSmtnNVZB?=
 =?utf-8?B?TFJJK3F2d2oxZTE3SkRPODZmOVhld25mYXVsTmRmbWNReFhGTFk2TUJUbUo3?=
 =?utf-8?B?UmU2NEtEay9tcTNRNEtjMmJ5Z0wzcE1QRElMN3dodVlVbWpIZk5ZZ2t0MzJu?=
 =?utf-8?B?MENkWW1hZEVRNGRzQXh6NENWZHZGcW0wYlZsS1hQMnJGT0lwZmFaVlFJYXBH?=
 =?utf-8?B?M3hxSTNJc2xTdGQzZ0ZYbU1haStFMDdFdktRMzhMUjExSGIzd1M5N2UvYyth?=
 =?utf-8?Q?BJk/yY37EmAqcCkkZ7cfkx5ZZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f037781-2e0d-4125-1a9b-08dbbeb5403d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:23:08.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J78+xoCUwIJDgCsxZKXR0D1c42WXae+I1RJGKXzofb+DbNRt4lKPsTOVG3Tnl09zJj9GVMnF9rLwumMp2dl/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/23 09:22, Fenghua Yu wrote:
> idxd sub-drivers belong to bus dsa_bus_type. Thus, dsa_bus_type must be
> registered in dsa bus init before idxd drivers can be registered.
> 
> But the order is wrong when both idxd and idxd_bus are builtin drivers.
> In this case, idxd driver is compiled and linked before idxd_bus driver.
> Since the initcall order is determined by the link order, idxd sub-drivers
> are registered in idxd initcall before dsa_bus_type is registered
> in idxd_bus initcall. idxd initcall fails:
> 
> [   21.562803] calling  idxd_init_module+0x0/0x110 @ 1
> [   21.570761] Driver 'idxd' was unable to register with bus_type 'dsa' because the bus was not initialized.
> [   21.586475] initcall idxd_init_module+0x0/0x110 returned -22 after 15717 usecs
> [   21.597178] calling  dsa_bus_init+0x0/0x20 @ 1
> 
> To fix the issue, compile and link idxd_bus driver before idxd driver
> to ensure the right registration order.
> 
> Fixes: d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone")
> Reported-by: Michael Prinke <michael.prinke@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> index dc096839ac63..c5e679070e46 100644
> --- a/drivers/dma/idxd/Makefile
> +++ b/drivers/dma/idxd/Makefile
> @@ -1,12 +1,12 @@
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
>  
> +obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
> +idxd_bus-y := bus.o
> +
>  obj-$(CONFIG_INTEL_IDXD) += idxd.o
>  idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
>  
>  idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
>  
> -obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
> -idxd_bus-y := bus.o
> -
>  obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
>  idxd_compat-y := compat.o
