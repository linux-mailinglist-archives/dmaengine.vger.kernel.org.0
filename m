Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD186B815C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCMTHN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMTHM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 15:07:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0E5BCA2;
        Mon, 13 Mar 2023 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678734431; x=1710270431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKHwYsFWqG/j7b6aIEvmM7hh1EVoT0TTFGuaoQwjoFM=;
  b=f2UffZY2ZCinWcSnoyipA39RAMau/JmapnJMGwTk/jFYh1xdF87/1Osg
   SCwjUiUoDzX7erdOpkJlwOSfgjwl2iOayTs1RTvJfGuwgScrj4dOsjWnf
   ha8O208DHnYoBY7T7EKrBPiELLg8oSVlwdF19NqbAMpF1rnEPPN6jO+pT
   SoaOV96CuCetFz/c43NjeAMQH2phrdR29w55I4Jz7S5kA0k4ITzZ1H1Jl
   RDBRlyBSFQyduMjMAOsWAUY7+Evu3RlSUR+0TFnkoWRCH8rHSQKQAS0wX
   EmL0Uru4uxPOAfLc3H7Qd70dCNdQjz8dbY5hlnh8kQHLaCMHqKvReOf32
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339602053"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="339602053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 12:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822067070"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="822067070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 12:07:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 12:07:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 12:07:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 12:07:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 12:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2PoOeXJp7yKTjlhb9D9RTVPu6WGV9OHLwaK/A/rDRnHKqZfLs9yVn+trcwNQeezLVOg2jfw5xPSi2rqExR+SxuZhgP315LVU9gwuKQiPj6cIOatD3NWEkcRxjryUxEsbytW7jW+51zWfUNaWjRGYVbsT/UglXogZJHQTe7aHrH/8j75anjvqweBLsp1zZU6rL33GECJp3lnPewRO7eQ9CKcCa6WkHikFzyY/jZsa844aGGh9V75qhS601dYkyax1lEWW+hUPzvfeZStMnxFd+KxT111Qf1hGGrW2A0FDfk1+tKt/qczzdtQGaZIL/ufq7DVsEMd7LnjURIXn6TUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnGzBd+W+1U4Tx+XHjkAMrbPKL2bO1g0hiP3hjNs5tg=;
 b=XDDNS0CeNmJMAkd5aPGTpW6en3/xdvBVKahemsPCYbUkasnqW3/z2Xi5fQdDPQ0yI4dbCh3lk/mwRefwLKk5ioJaUtpSKcPMcMH2UR5MODcLvoQHB5d9buVvQ1oopvloDrAX3NO3OAvJM7BioZLC4Y1V8H2V/Slk9jiVlDiGwZw+yESH8nIiKbUl80fBKRbqRcobWS1rZa9JqP7j117gIkkd1WaArMnW9CfmqXxMmydpuThM/rDRceBeo2+Q1oadAHLCUA9MSE7YgD4yeuDFGzZS+9EhNL7pHuvHz5q1bGbibuZarBBoQjyccr1qSQz4GxxMqJevRjd+iwZpHzVp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 19:07:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 19:07:07 +0000
Message-ID: <76db3d98-2d09-54de-ab46-0ec9d743e05d@intel.com>
Date:   Mon, 13 Mar 2023 12:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230313182918.1312597-32-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0186.namprd05.prod.outlook.com
 (2603:10b6:a03:330::11) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 267fec8d-ecc1-48f6-e28f-08db23f623c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYQIYfpxBlinMulznfmBAI9jzvtRCnjbijLOq22mpGlJIjlDEEgBlk45Fmr5fdkvAxkRpQJSijAaeucYB0Y9RYE3/fhERMbnbRvT2uaVo7kr0aI4ZJuHroaKGMATKAQ7mytIv6ebpwFzGGp/bQ4xmR0Lastk00p5W0kx0r7eLI2EpLM/2oaVhiPbKJxGtGc7AyXDtBqoPNw4uSzNYn9L7M+vPklDgwsuHXt3LUteRL91Pjd/IZPGv+gpFrikdI/B45cy/a05UDaVksjTtJqxPg3Nd8ecmWOY4HBaCc5Ti/QPoJHtlQibPp3BalM3ALhBEvtcxRrZeg0hEL9Cwz1oAN5iMATbhRymNgY6Phi0lgfO0sFH7DpJiXPZf9AKyNZNs+mj3miUAOkfz+bkgLeh622UroWe99rLtdF3vlMu5soflC+7zdhtmYg00XoYsXRw1Lbsy+TlnQrkYkjYaBvOEWkKQd3HM+pVGI3f0FMvKX6u6PSRQ1vTHsOGFnwY5OQL5tU+3h/DoHCSuFbnbbMstQ6GjtkNYRX5+TCk0O0RV+XBisSFvI6c1pHr6na/z+eqXRZl64JTYtbcXa2mhXKC4wFH4jSDpwGh+YQu3JeBXSI19VH00WoQ38UwlquCICupbAEK6sKHBwaYCB//Wl07w0M/IQu2nJ/7CfqxEkktEYlX1ajsOMjrX3Fzg1HMPR7VzlVpyT4ejNBKX33YNawYEVW5LWjCij1mHbMpfx1YVBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(36756003)(86362001)(31696002)(26005)(186003)(41300700001)(6512007)(6506007)(53546011)(5660300002)(4326008)(2616005)(8936002)(54906003)(316002)(478600001)(8676002)(66556008)(66476007)(66946007)(6486002)(82960400001)(6666004)(38100700002)(2906002)(44832011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRIbGk1U2o3aXQrL010c3JaT2ZDcVg5VmRvaWN5b3hOblR3NjlQaENJSlR0?=
 =?utf-8?B?bFIwQkhaVXk5SEFWT0p5Q2lwNVdGWnhEc242T1NDQVJuMFdlS21oZTVjVzIz?=
 =?utf-8?B?OU5QajJRVkhKU3pMWEYwVkFFemg2dEJFV041RnF4bjhwTWVwbDRIMXVCajl4?=
 =?utf-8?B?UWtTWUZmU2NuSHcySHY4Q2N0RUpHeGExL1NuQllVdkVSbElibHRURENNNjA5?=
 =?utf-8?B?Y2RXck0xdnJUSFliY1lQQVBKbnVqNDBPMzQ5ZWxhNTkwRUtTS1ZiQkZoK2Zx?=
 =?utf-8?B?YjNnN1kyVk1zZmR5SlhTSS9CZnJRZWNNcmZydkNjQU5WVkc3TG1SRFh1bktw?=
 =?utf-8?B?K2lMd2p2RVIvVnlLZzMzbWlleG1NYnFvdVZPUm9NYVVMWXFYWE9GV1BCQitV?=
 =?utf-8?B?NlNzbStFRGErZEFaRmhjSHpDYm5ZK0NSdjNxZVVVcmIwanEyMjNJTWNWK1BP?=
 =?utf-8?B?bjl1Si9IMXdKb0ZJbXhyTnJOeGFRTEVENTdjMmV3WkJkbmtENUpwR2t2NzR6?=
 =?utf-8?B?Y1dVRWhEMXlmZ0EyYmc4eklwU0pkcHlhQ1ZPV29XaVlzYVhmc1RJTVc4NWtX?=
 =?utf-8?B?RGZVVDhONXlaanBsdFlMQ2tlbzBPanVRenA3aDBpYlByQ1dkcG1QSDZQUXNx?=
 =?utf-8?B?aTlXeWJOOFlYYWZuUHBBT2pRTG8rQUdvTlF2OTUyTWQrelpyRGZEcmZBQmlr?=
 =?utf-8?B?blhQcytwOHlOcmJHeXBDaE5Rd2tCTHBHQ056ZGtkWkhyK092YVRJNzJTdEZF?=
 =?utf-8?B?SERNSCs2Yk5Vd1hLdUQ5NUMyYzQ0b1VPRzRSWnhSc004M2Fka25pNG10N0Nk?=
 =?utf-8?B?TGxnWFdpTXFPZk9LUUovcmYwN2lvc3VkbXQ3NU9yZzZSb29VQXNYSEs3S0E5?=
 =?utf-8?B?b2JRM2xrQTA0UUowVWIzMmRXYjc1R0FiYzRla0Jtak5WRXJUL3A5aHF2SmFv?=
 =?utf-8?B?aVAybzBVM3Jrb1FEa0tUcHJYc2tTZzZkd3JqL3FHY3o5dmlwekhDS1pNODhS?=
 =?utf-8?B?OHBpS1JSRnpxYlN2d0s0UWZNaVozSEFQT0QydmZHR2NQM3pRZ1VqYUlHTjVp?=
 =?utf-8?B?M3VXZnhkdjdsT3IraVNTYnRqUXdqUGFaVDFkMHFQaFdyZGlMZENWbkN2OVdV?=
 =?utf-8?B?ZUE0UEVwNi96SFYwdjNic3dlVHNhRWEwVnVXVzVwMWo5SDdQbytOeDB4OUlT?=
 =?utf-8?B?QzM1MXV1Z3FKRlZHSEtrRi9hUkxtM1JBbWNoL28wd3EyajNSWWhJSngwWHlO?=
 =?utf-8?B?QXhSS3loN3NLZnozUjVkeEJDNmVxV3dTb1NCZFFQcnlTUjBpVVh3YkVkQkpn?=
 =?utf-8?B?Mlc0YlBBSnBMS1pGUWd1MnBBMnpqbm9qS2tQRDFJcXhLZ3dxVml0S1V0OFJM?=
 =?utf-8?B?K0pZS21HQkxzWUd1TTZzUk5UdUw1a1l4K2x6N0JNUVA3NnRoQjFTVHc4Znds?=
 =?utf-8?B?aEIzY3ZNbXh0b2xwbXpwTFFiMElxdEhWQnBDTXZEUlVmak1JR05SVFJrNGVC?=
 =?utf-8?B?Rk5vcStQczZPYndVNXA4cFE3SnpZa3J1UVVMVmc1MGt6ZStLT3hHTU1ZdnlF?=
 =?utf-8?B?SGRGM3FwZXNEdTM2KzVUemJBM09wakJzdXpZdm5URTIxck80WWE1OGt4cHNl?=
 =?utf-8?B?N29nZUtnSEgyMElpdEpDcnV5d056Y25xYTNrZDJhbW9mT09jK3RwYTNQb2cv?=
 =?utf-8?B?QlYzZ2hCT01LUFUxaW9DMExEazNjbTdkQ0J4V09oaTZWSE93SFltTU9VcWhE?=
 =?utf-8?B?Zi82ZGNqWUF4S1lpVmFQTzJ4UWNmY0tXSGp2RDNOdzlLY3dneUxORkJTNldr?=
 =?utf-8?B?R3ZmcWErZ2VIZXRMVlpncFVCd3NTa2ZDR0VSZ0pCdWlMSEd2OGc0V3VYZjM5?=
 =?utf-8?B?TTB2MjFxN1NwTUdxZ3Q3SHdVVmg1VmtQWUdGb1AwU1FGWGNSeFRoRGNJVlMw?=
 =?utf-8?B?V2tlRFI3bFFOQzdoc2dVWTltSVgwQTlKMEJTS05zZTVtUEI0M2ZIUlBNWG1R?=
 =?utf-8?B?V242eWRvOVg4Rmw1UjZITDEyTUdUNWhyQ3RXdXhBd0t6MEticGhRZkNXNDVq?=
 =?utf-8?B?RmxjT2ZmbEtzVEZUYWhSelhRZEllbjRGZ3hYOVkyNS91dUQ3NFBNcWk2MXZp?=
 =?utf-8?Q?GXLBrZwGqLdVF2yqpX8102il1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 267fec8d-ecc1-48f6-e28f-08db23f623c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 19:07:07.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOzT+uLlaGiVG39YueDwQcHxchzvQgsKevFpCk33lnf0wzpqmgrPIr7EhBh68iAspPqaKnvguaaIArrlS7B2pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Greg,

On 3/13/23 11:29, Greg Kroah-Hartman wrote:
> In the functions unbind_store() and bind_store(), a struct bus_type *
> should be a const one, as the driver core bus functions used by this
> variable are expecting the pointer to be constant, and these functions
> do not modify the pointer at all.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
> 
>   drivers/dma/idxd/compat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> index 3df21615f888..5fd38d1b9d28 100644
> --- a/drivers/dma/idxd/compat.c
> +++ b/drivers/dma/idxd/compat.c
> @@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
>   
>   static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
>   {
> -	struct bus_type *bus = drv->bus;
> +	const struct bus_type *bus = drv->bus;
>   	struct device *dev;
>   	int rc = -ENODEV;
>   
> @@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
>   
>   static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
>   {
> -	struct bus_type *bus = drv->bus;
> +	const struct bus_type *bus = drv->bus;
>   	struct device *dev;
>   	struct device_driver *alt_drv = NULL;
>   	int rc = -ENODEV;

After applying this patch, warning is reported:

drivers/dma/idxd/compat.c: In function ‘bind_store’:
drivers/dma/idxd/compat.c:47:47: warning: passing argument 2 of 
‘driver_find’ discards ‘const’ qualifier from pointer target type 
[-Wdiscarded-qualifiers]
    47 |                 alt_drv = driver_find("idxd", bus);
       |                                               ^~~
In file included from ./include/linux/device.h:32,
                  from drivers/dma/idxd/compat.c:6:
./include/linux/device/driver.h:129:59: note: expected ‘struct bus_type 
*’ but argument is of type ‘const struct bus_type *’
   129 |                                          struct bus_type *bus);
       |                                          ~~~~~~~~~~~~~~~~~^~~

Should the "bus" parameter in driver_find() definition be changed to 
const as well to avoid the warning?

Thanks.

-Fenghua
