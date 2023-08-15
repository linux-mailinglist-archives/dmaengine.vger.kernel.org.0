Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989CE77CFDA
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHOQFT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjHOQFJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 12:05:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE5C5;
        Tue, 15 Aug 2023 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692115508; x=1723651508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ekUp0c6d7+wfD0nGDBpYL1k17AOaTe9cYxAVBwQv8jc=;
  b=kMDUEkxphEKDBStok7Zd8etSyBROZoLsShZFRKAEfrFf+May7QZmMmlO
   Wnu5wlVlO7cOXd14vTyUNhxgyoUL0F36v8RU/kxpjxArTyIPVD3VawIET
   FFFg6Bamkk8ycBktye/BCQfZTObHSQkPxUtX/6H0Dbl/3p9ZwtIvP37Ag
   i+VDPTItch1rmjGuIdJyNMz2Nq/fuyGXihJc3vV2eTpiKSry+EwQs+ONs
   pGX0ZLkDb317SSwHl2tbi8rm5pxw/G6x/KUMaO/XR/BcCqfzPhCncC5rA
   LyjuthwDcdjufVmHsi7c09KASyvG4vgRJbtZxGTlOJPHMNhO+kLRaRn0g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458664836"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="458664836"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683704092"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683704092"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 09:04:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 09:04:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 09:04:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 09:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGz6dfEZxf4rAlqcJp3j60cf309MA53br8/tndFUDmvhfVW5NzZMEoXmBjSAorDAf4d2whr0VdiH9F3Yv8UYLonC3PbNWAw5MEZ465p2swtypTzsD9Q46hrJWDEt001Q3ned1wnZkNeIyBOwpA3djt1z50CSPnEoUbMXbgWFBgBAnK9nbQE2bIAHZitHSZEqQ0eQsZjNbTKizUf+n4WIkdf1XvbDcL6V/NPHWoQLlz7kGc5l8UMXfiUynYxfXv/LN7w+ouKJ+iBfdfebUz1VZb1TUkDJqvb3qbvhh7Sx+BRKBkdBH+mWVBAo+86ogHflyLIo0Ok2259xlLGe9mnStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr4vTgzsvV68EMSkKLkS/wzKBfGuDi0dE0niQevWDY8=;
 b=BV/jvrxL2wLYvCw+S7xpwoweqGvFYjUCsoWsg3fRiPxR9y8eQGOZbyG0SFEh7Kw6fa3YshrDgljQEO4TtjbNo8dolM/XKRcj4oslmsQ5AcyXmq7FIUwRG1pIaBeG/wYd0YPlK/5s9YExCVPYhJ+Q69KLTF+RRui3NZv8cB/svI8KzbISCtZci3Ym+Q18Jvvf8g+mveMSGhFFW+dHamxPdtTgV2HUv374KSUAq9AIVZmVOfnx38BintOu6jjvjpRijL2Y7Qx4ozdjofgCEEO9P7MXSmkNZodLh4o3BnvEXeyWuO0jketGVX9OklvGeXsq/ykOgliqmON/CCuI7QvGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:04:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:04:10 +0000
Message-ID: <0b821549-cf4a-7de3-9eb7-aee4eacc3185@intel.com>
Date:   Tue, 15 Aug 2023 09:04:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: Simplify dma_async_device_register()
To:     Yajun Deng <yajun.deng@linux.dev>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230815072346.2798927-1-yajun.deng@linux.dev>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230815072346.2798927-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b4097a89-43df-4fc5-54ce-08db9da94340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvD1nHEw+Xuo7NCWnh+9xialtkaP/WWW0f87203UiuBgnzD2NbNU0X5G5oYTwwZCgT3kSzwauf3LWtQV1o/nnCpYrxOtF///SwJ6U5GMO0xwyzAQsjFOAfPiiF2PcxzxRLRLHZ3MGzf4LsoMZn5zujvJ/oLyCHhMECbhTEgEz7MgZNtrK6/fRtg7XahHD/JIVidcSxmUZE/VD37R8Usng9SKRwOJmi3SidGxbeTzfSsw3FdzSKcVLV4nSHTxIyjeLRlMzXxYfVPav5UZoDbHgrlph3ZPLdkZPIp3FCP1NdqWDVWNYKkSjq/8BMXvbo7E7mSinuraCO62Hnqx2fv4/vHAUj8mZj3FSDjSZiF8fpor3nJgyD7PL1cZNBS9IhAHZTT8Cr7F//LIeVXJa8Q+NWsTfjbwm0Pb6ZhLvX3pDsElLSfxLHw6e/tSwafu+WUyZ7fV+WeQVOSlQhjRGIhVWGqE2U1m54cgaikHu0dukGHYedDZ2o4f7dDfsgkYOHyi9fA8EVoTvtl7vOfeZPtyuNCKkEd0wtpapHsNWdQ1sDAsn/ZnLfgvXJ9tIY4eTaWze7xCdoDq6w1LQcPcDRMyiwy/3AVenw5lkC9KLbqtGKtkU5j9+gjzCJy0iU3+772NPAO54fx9xq0LRUdypLSDGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(53546011)(31696002)(26005)(2616005)(31686004)(38100700002)(82960400001)(8936002)(44832011)(6506007)(8676002)(478600001)(66946007)(2906002)(86362001)(66556008)(36756003)(66476007)(83380400001)(6666004)(5660300002)(41300700001)(6512007)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdSMnkwajkvV0ZqT0ZSNFM5YUorcnNIOWZyK0ZVWDNKU2IvYWNOK1ZBV1lu?=
 =?utf-8?B?MDhOVk85Ukx1Q3RKL3dDai9TMzN5dEwxaFhXN0tmYWN2dXowVUZKbVAxWTdU?=
 =?utf-8?B?Uno2ZG5VeWxMeXpFRkhHSVgyS1ZRWTRzbkNtZkt0aFZtdThObldva1FpdUdh?=
 =?utf-8?B?YlFsK2lrQldrWWZYOUx2YTB5WkZsRFB3SXZRSGw5VXJhak9KcmFOWHZVcHA2?=
 =?utf-8?B?Q1kxVllmenpVcStIMUFrcldkVVhlck0vc001MndWVFJlb2ppY1RvSVNrT0VB?=
 =?utf-8?B?d2tsbGRpOCt1VnRzWXRYYzc5eWl4MmNwT2g0QlQvQzRLVHZVZW5KU0FDM0V4?=
 =?utf-8?B?Wm5ZWGJHS3YxWE14WWt2aGtlTE1vNFJmZENQclVLOFcreWR0eStVT0Z5enBa?=
 =?utf-8?B?WG9Ya1pYYjF2eUdUZkcxUDMrRWdZdEZMWXV5WFlVSnh3RWRLVHRNaCtkWXFJ?=
 =?utf-8?B?Tis0bi9yQjRNQ1A2YXlVOHB2QmpvdW1YYmlwUXp1c3U1R3RzaE5rSjg0YjNq?=
 =?utf-8?B?Z0hWR0N1akhrd21TQTlZZ3B2YXB1Z0p1OG1NN09RcFFKTE5kY0l1WnVQTHg3?=
 =?utf-8?B?SEdWZXNwdS9sTTYzMU5ZMnE5OGdEZTNEOGF4QlZIaDN2VjBNUjNxL0prc3FV?=
 =?utf-8?B?UVY2VXBIUmpYVmZMQ0pBcEtLUHZ2QWd4dFpKWk84Y0daSFlNeVZycHRtckwx?=
 =?utf-8?B?QW9YbEVDdloxa0NnUHloSzZITlZ0Z3BiM2REQWJlRTUyZTdsL3FUd3VQdUlI?=
 =?utf-8?B?Y2t4OFRPVUJRODEzUDFqTlhEM0lGWVBwZFNuTVk3b2pJbWwrUTlHc0toWEh2?=
 =?utf-8?B?ckRWeG9CV3ZKcnFGWXk3VHZ3SHlDZFhrMFY5WUlaa093R0ZhUE1OY0w5U2FQ?=
 =?utf-8?B?ZzlHSDl5STRJa2FCNjBrUkVLWURKUnFTbklCZzJLNXBaWGlnSU9jVURTMEJx?=
 =?utf-8?B?MHlFLzdJYlRodFNzdDNDUGtRZjZXa0ZreVBRY3lCdmxQbnY3WUZwU3R0MXdI?=
 =?utf-8?B?TkkrUmlLR0lKbjJrTXdiNnQyYlBPU2NRNXEzc0l1d0RTUC9GTjQzYkJDMkU1?=
 =?utf-8?B?bFdZblpjS0xqMnpqejFLRnU0UVJXdUlFUklVMHhTUmE0c3RtMjVtRWNkUFAv?=
 =?utf-8?B?SSsyZ2dwU0JISllETFRxSHl0NU1UOEpMV2RtdkI5NjFtVktBOENWUzNQVVZ4?=
 =?utf-8?B?L2MybXZuejhoZXBZNDFrQlhkb1Q1THRraTNQMjBsSmNTRkZ2WGRPTHkxUGNk?=
 =?utf-8?B?Ry9rYitaaElleEY5SWFFSGNvdmxlcWxRUTg5Qmg5NVhUUXo2S29MUE5kNSth?=
 =?utf-8?B?YTBPYUczNXQ0Tzd6Q2xZQzk5ZFFOVDhwNytZVStJcFEwcTVPeXV5RGdFV2xH?=
 =?utf-8?B?R2FCTHJhVk5nNW1uNXgrOUpRUTVydWtaWmJDUWlqZW0xaFVtak96RXZ1cW5S?=
 =?utf-8?B?OFBiVG8xdjNmMVFmZytCblUwVGVZMlNrRFdHODhrN3B3SmJ1QmRZOGF2U3BK?=
 =?utf-8?B?QStZaU1iVWdhcStRQVJTNS9PZFNGTXhHVWx0OHEwTlVJTEdJVmtHcGpJNU5L?=
 =?utf-8?B?NUdpUmVJakVicFNVZXliQy9McCttUklGRlJ0VTRkZk04RWVrVHZhZEZsekR0?=
 =?utf-8?B?RU5oU1kzL2s0dkNvaUN0UGRsUm84YkFKTkFZcmsvVnYrNEFFa2JHRUUvUnNV?=
 =?utf-8?B?SG1oM0lablk5NC9YT2premkzQ3c2c1ZnVVZ4OE8rOU5RUytCSzVWUzNTeDNv?=
 =?utf-8?B?MS8zdzJqSDBJZTRZY2p0aGlSNU9uSm03UnpwTVQzZ1dCZ1NHT25SSFp4VTF5?=
 =?utf-8?B?RXJ4cTlOeWpFU2R6U1kxYVRqYmtIbXhUeWZaNTVVVFlieUZqd3NERVI1YlBn?=
 =?utf-8?B?WTJVUXgya1ZMM05NNStrc3ZqbWhTQVRjaEtUQW4vVkNpaUJBaFlUWmx3bTAx?=
 =?utf-8?B?L21hN0FkcTh2cUk3K1dWeDJiM3JMTWNiWHQvQjFIT2hhVlNBM3haeTJVRnVD?=
 =?utf-8?B?S2c3WW5zQjk1OW5LdmwrQTFmalR6eEUzUTBtd25nZ1VpclhHZUo1Zm9TTEE2?=
 =?utf-8?B?bTBWWUFYa3VTZHAxRzV1RHJtV1BCR052aVpxSjRtZ05xY1gzZFlNYkFrYVR0?=
 =?utf-8?Q?vNMa2J3MbTCVScdvjm4x6alYh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4097a89-43df-4fc5-54ce-08db9da94340
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:04:10.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAUGYyoP2n8bg+hSX1efSFwIN914yPmUh37mQM8zfhs78JiBcVDSExShNv8YyT5hwAvV6SkXhTA1VGXu/gLF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/15/23 00:23, Yajun Deng wrote:
> There are a lot of duplicate codes for checking if the dma has some
> capability.
> 
> Define a temporary macro that is used to check if the dma claims some
> capability and if the corresponding function is implemented.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/dmaengine.c | 82 ++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 826b98284fa1..b7388ae62d7f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1147,69 +1147,27 @@ int dma_async_device_register(struct dma_device *device)
>   
>   	device->owner = device->dev->driver->owner;
>   
> -	if (dma_has_cap(DMA_MEMCPY, device->cap_mask) && !device->device_prep_dma_memcpy) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_MEMCPY");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_XOR");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_XOR_VAL, device->cap_mask) && !device->device_prep_dma_xor_val) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_XOR_VAL");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_PQ, device->cap_mask) && !device->device_prep_dma_pq) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_PQ");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_PQ_VAL, device->cap_mask) && !device->device_prep_dma_pq_val) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_PQ_VAL");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_MEMSET, device->cap_mask) && !device->device_prep_dma_memset) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_MEMSET");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_INTERRUPT, device->cap_mask) && !device->device_prep_dma_interrupt) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_INTERRUPT");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_CYCLIC, device->cap_mask) && !device->device_prep_dma_cyclic) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_CYCLIC");
> -		return -EIO;
> -	}
> -
> -	if (dma_has_cap(DMA_INTERLEAVE, device->cap_mask) && !device->device_prep_interleaved_dma) {
> -		dev_err(device->dev,
> -			"Device claims capability %s, but op is not defined\n",
> -			"DMA_INTERLEAVE");
> -		return -EIO;
> -	}
> +#define CHECK_CAP(_name, _type)								\
> +{											\
> +	if (dma_has_cap(_type, device->cap_mask) && !device->device_prep_##_name) {	\
> +		dev_err(device->dev,							\
> +			"Device claims capability %s, but op is not defined\n",		\
> +			__stringify(_type));						\
> +		return -EIO;								\
> +	}										\
> +}
>   
> +	CHECK_CAP(dma_memcpy,      DMA_MEMCPY);
> +	CHECK_CAP(dma_xor,         DMA_XOR);
> +	CHECK_CAP(dma_xor_val,     DMA_XOR_VAL);
> +	CHECK_CAP(dma_pq,          DMA_PQ);
> +	CHECK_CAP(dma_pq_val,      DMA_PQ_VAL);
> +	CHECK_CAP(dma_memset,      DMA_MEMSET);
> +	CHECK_CAP(dma_interrupt,   DMA_INTERRUPT);
> +	CHECK_CAP(dma_cyclic,      DMA_CYCLIC);
> +	CHECK_CAP(interleaved_dma, DMA_INTERLEAVE);
> +
> +#undef CHECK_CAP
>   
>   	if (!device->device_tx_status) {
>   		dev_err(device->dev, "Device tx_status is not defined\n");
