Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594077AF0B8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjIZQbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQbH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 12:31:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D511F;
        Tue, 26 Sep 2023 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745861; x=1727281861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YxVeY2QZ05LrkRzguBoEVEoN6sOCZV0GoksOuiAuQYY=;
  b=c6xSUhwcIzmR76Pr+8zgNLJn3QhInHlZPxE6jI7QDfj2x99Pj7h4xG4i
   lIxKJQVXmSklel6l8z4H+c/89lIkMCEFVkOmLIQY17tgyqiBhG344syVy
   dFkgCpVQg53pRyVb9fa0hy3oLlSTtFqp/M83Lru1UA/u3sgqf83b8IoFW
   9UACfzh8yOwoS0chtNnEb1W6UKnbM2KmtD7XTyUaOZmefBWmwrLxQwIpT
   ITqc1sh+re0XaPB4t3ehfdStTZWoqHOS41ShYHGygB0e+0c23CulV0me7
   s6ZQHtOHIl2a9vtjegd4pI1skk06LwkCIZd/CQcqvjtfKo8zZ/Et5+qy6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="360988945"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="360988945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752245037"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752245037"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 09:31:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 09:31:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 09:30:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 09:30:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 09:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMW6QDom2e+U3K9l65DPfkpYlyMxeuxG1W1FBTmw7bp85YM8TcGIopvDfD/pLVqkZ452JccmjfnyUQ07SUKxtli4ZjxX1XrRQpDDcOl0glyAtlxvdhTVFF5WaE2H8mmk6s8IzEKITv/pR4Ck3sHKXZK5V/R38Obize3BnRv+EOHww+cosy8n76aglQam17FdWo53ReN6pL0xS0l4mLtRmLAWLSsqmbEB53rZRJlxJnb5HTA+82j9LucYVTnU6T96ls5uZoqr0fo6yxKIoLj8ie3bV0Jv30tV8Zl/WyWUHSBiJbHxLGYmNs6j5Vt0sT2FFYFskzJe7Lc/eRgZeTUFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+Q/AyBqXywhnNcRqzOHHO+tbozwxycPKVT00dpUqaE=;
 b=Or+AxgExYb2E8HG14BcM6gvKXq4S4DTMD+eAPH0q73AwXQnpRDRBU9nyGjISHqFBU4Bt1GShT/o/c6Oy29sXiizN/bY+BynyuxKwmxAVtVvQxk6okx2+LR55XkYuubYfsghsrj8IOaZRl7jFyMGYPUHYjMHp6/kV2Xb9Z3S4x28CckSKYeNxS4es+DwsppF5BlkBj50uXoQ8fmLfo/siS76BezduFDjQMDqBagKUxBu5oc4GGsil3SnqXdHVuyqQgCu/W9+pOND4FVVPMv50HfW/ujphuBI20rlGHa/FhRuBys74m5bycXkbFiFWBehK6AmnRf7sDz96NE+7JlEWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 16:30:57 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::5678:c77c:3510:5b4]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::5678:c77c:3510:5b4%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 16:30:57 +0000
Message-ID: <8199226c-9642-e089-8dce-64ac8483efea@intel.com>
Date:   Tue, 26 Sep 2023 11:30:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: idxd: rate limit printk in misc interrupt
 thread
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
References: <20230924002347.1117757-1-fenghua.yu@intel.com>
From:   Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20230924002347.1117757-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: f55a0057-30a0-497c-9fe7-08dbbeadf5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsjhk9JQQdX8AdmI68st8yljoGC58nkcIV0tg4ujrFx1uxqt8vPHXP7+m84nxyIOJEXqSz0flqPYMqIobM3sM6h88T+BWn4fKugQWuaYfowiVIZOC0il3/QWkjRzUX8QZ5QT0F0gEMzw7A7hhDcNX2crJqtFNOGHDR8TQCqmkKdACUXgH4BFaS/NT6G6yt+/axtbWfEJ4LpN8E2CLGq/PWdjjD3bipuDorjJJgPTH7nHMz9XhTsc1bmacQDr6UwyOetu9SRcww/64rmMTenrDwjNlz0jtviPXrUAJnyEVFeF+Dc4fn9oE4MlJ4I1ndn0815iGDaGWDW11VURSXtmqWLHtg2aLWGCEnjHlsjUfRrcd4bdYcg5CoCPIpmZ/b3C3PXGYmKopXlxlTLOUY/zI8cRvKpHJ8gfdrdkoHXTu9QxUPeCxUk6XcgQyjbGvbrL82jEHhpFXxzNqO+eXUPxuI602DA0Xgqhv9/MHxdoaPJhVRq5PLXy+5+yGH6uNdRe0vwRldXkdAXZIE7JPDUsUOg+Chf2sGjd9oCFIPEVCe0fCQDUunLYMyXdVZ9pUh4N6pjDE0x2Y7VHBhYPmveVhDO3XSECxsx0CrKQjqIrpp3ZVpVnHl6nCHgcPywfAUOFBq+LINt9CnoFHfM+BuKuUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(31686004)(2906002)(316002)(41300700001)(8676002)(8936002)(4326008)(36756003)(44832011)(5660300002)(66556008)(66476007)(54906003)(31696002)(110136005)(66946007)(86362001)(6666004)(53546011)(6486002)(6506007)(6512007)(107886003)(38100700002)(2616005)(82960400001)(26005)(83380400001)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEp0aU16bHRueU0wNU1ZSjVUMmRLWEtOUjJVYnByOE9idkJZYmtrZjhJUlc1?=
 =?utf-8?B?YUk5ancyVGhXRFlkbDZzMGtvZ24xVXRjTGM1TDEvbUJhelBZc0VIVXJicWFV?=
 =?utf-8?B?VU5maExEdjZyVjZvaGlZZ3Fua2pVMi9QMjBGUmlUZSt4VTUwL2FQV2xGRUp5?=
 =?utf-8?B?ZmRIMlNlazBoWTdERDFEem1uVUp6ZFlMYjVpcEFhZVlzK3A3elZ5NEM4bjhS?=
 =?utf-8?B?KzlHRHAwZjNkZ2pwbVpiNW5HY2hhY09oOGtZNEYybFIwdkp1RGtJTWlwbURX?=
 =?utf-8?B?MzdlUDRhSE1nYUlheTBydEJTV2lCbFl0OFJDR0R5V3k2a05TeWp5Y1Z6cjM5?=
 =?utf-8?B?MGdvaDhnd2FkS1JHUXZUcWhYVU1ja3JDRjUvazlSbWc2VGhjWVdGTDE3bSs4?=
 =?utf-8?B?dldXQlZKRkd2QUIwS1ROV1NmRDNNa2t6SWtLcUh4ZkNid0Y2WkVwTEJLeFJs?=
 =?utf-8?B?b2crcm4zMmJ1YjRwV0x2dlBXZkJtQlRXamNNK3dXeDNHTHNZL0FzNitwY3Qx?=
 =?utf-8?B?R2kwWWk1MVJWeDNHRlVpTUNIR0t6RTRIUkVlZG9Jc3RUbEsvWW1WNHlscEQ2?=
 =?utf-8?B?WG5JWFgydE1SN2lHMlM5SWp6dzdrNmNNcjhrY3VLSVNLN1J4Ryt1bDlwUWN0?=
 =?utf-8?B?WXNkOEdDZ09EM1VrVFpGcUFYWjZ5bmpLM2lSbjFWVUxzbkwxM0c5aVRWUWMw?=
 =?utf-8?B?MmF1K1U2bEpUb1h3RFltaWhSMzNQNUxrTmkzVGVsczJPNDd1YllnQ0kwdHg5?=
 =?utf-8?B?V3REU214TkxERXRFdEdjSnh4dGhYNFJZUGp1TU9Qc0llUUVabTFUc1JVUjg3?=
 =?utf-8?B?b0NiMUpPY3RpaExBQnJWazRUQ0lvWnpxVXJseU92MVBaMDJ1cGVSMFpIRU5C?=
 =?utf-8?B?OWo1M2ZnMHFPNTJJbmMxQ2luMzNORXE0NlF4eDkzSm4yWmkyN1kvcTIrR2hx?=
 =?utf-8?B?U1VoUmw5TGNPTGs2RmxOajIwaHY2ZXhBUmRaMWZEdDFzRXdvaEZySTRnYmJJ?=
 =?utf-8?B?d0tOYWhRSS9qL0ZQQmthOE1mQTlkcWJSWDZlcERvbFFXWjF0MVViWDhtT2JT?=
 =?utf-8?B?aVpMd2pzVFUzZDJQZDJjVFVkKzhheE8vaHI1WDVtWlg0Yys4a1RWZkk2VWEz?=
 =?utf-8?B?d3dET3VZL0hCNlUvbm9sSSthdmZsRG5CT3JNcm4zbERFTFRzZmR6S0FHZk1G?=
 =?utf-8?B?NU01SUNQNUdOc2QwUElPVnE3d1BsTDM1bVJuRGVkZkV2TEUrRjBod1RTeEVp?=
 =?utf-8?B?OURCbWYzbCtTOW4yZEgwenJabmJHSmlJMDhQaTdtQldRdWsxOVRiS09VVVZX?=
 =?utf-8?B?UGJnMW0yQmR5UzJmTVdRU1BNNk9zNEJ1ZE9WdmFjaEVXK1M1ZndOb1JzdGg3?=
 =?utf-8?B?OCtqYUwzbVdhR05xMGJpc2g0Y0pxQThhVHFhNUUwL0QrQk9seGVHbUFHdS96?=
 =?utf-8?B?dUV1SFNQbEs2Q2tDa0ZwREtKK2Z5bWtFUEdqbktRTkxDRGRUMmxybi9xZllR?=
 =?utf-8?B?RWxPNitSUjdDYlhWaFhyRHBoeFVFY3NGdXR4L0w1UnFXT2lhY3ZUcVVQZUlX?=
 =?utf-8?B?T1RYL1UxcmZIclFoRlNhVmJJNHdCSitwQ0JPd1lzaVlidWhpcWI4RW9yeGdo?=
 =?utf-8?B?QS9PKzJZVFpnZjc4V1BYd3Q2S2JFb3hobjVmQzNNeVdIUEIvaW5nZU5xQWZq?=
 =?utf-8?B?aGx2NzN0bm1HbE5TR3N4K2JidDdNc0dDNVBMRDIrdktmQ1d6SjZTcENxS0do?=
 =?utf-8?B?dVZvZ3dqQk9vb0lIaVczeHlJNVFyc2FSYXZTc1lqUDNicFNhVWE5aXM2UjVG?=
 =?utf-8?B?aVBVNWVuTERrNDNXQXFHRHJ1M2g5S0FSdnVuaEQ1WDYxQjZ2QXhoZ1lRMDd5?=
 =?utf-8?B?U1V5NkV4T2NpM3pNM0dZV3RXMmFvTzQydERjSDBQWUlCbVdVak12d2RjNlBz?=
 =?utf-8?B?Y3pxakpDcllIYU9qSy9xNHZ0Z2p4RFRrVVZrQlJHeW9SdHBkT3Y1M3Fsb0R2?=
 =?utf-8?B?S0p1NkxuRUx0cnlPYTg1UjRlVWtpMDAwMkEvS1BzQ0ZUKzBkK1VSNm5FWlFp?=
 =?utf-8?B?dkV1eUNxMi85U0ZZTkUrYmNvSHlYN1IyZWFpTCs4eFdtU28vaTZqS0JMQnZ1?=
 =?utf-8?Q?YrFWhokXp7oVSlcwVyOQDjjf6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a0057-30a0-497c-9fe7-08dbbeadf5f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:30:57.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ1m/kJin/0sBrw0jewCGI5wW8E2XfJ6+I0aguOIPiaVPyvOaZmYczL54i0DOAN1Me7O3/VPzJAW9DIzO4BXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
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



On 9/23/2023 7:23 PM, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add rate limit to the dev_warn() call in the misc interrupt thread. This
> limits dmesg getting spammed if a descriptor submitter is spamming bad
> descriptors with invalid completion records and resulting the errors being
> continuously reported by the misc interrupt handling thread.
> 
> Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---

Acked-by: Lijun Pan <lijun.pan@intel.com>

> 
> This patch was sent to dmaengine mailing list before:
> https://lore.kernel.org/all/165125377735.312075.15715853788802098990.stgit@djiang5-desk3.ch.intel.com/
> But it hasn't be merged into upstream yet. Add my Reviewed-by tag
> and re-send it. No code or commit message change.
> 
>   drivers/dma/idxd/irq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 041be6a4dec4..8e895a1e1881 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -430,8 +430,8 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>   		val |= IDXD_INTC_ERR;
>   
>   		for (i = 0; i < 4; i++)
> -			dev_warn(dev, "err[%d]: %#16.16llx\n",
> -				 i, idxd->sw_err.bits[i]);
> +			dev_warn_ratelimited(dev, "err[%d]: %#16.16llx\n",
> +					     i, idxd->sw_err.bits[i]);
>   		err = true;
>   	}
>   
