Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E044BC24D
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 22:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiBRVso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 16:48:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiBRVsn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 16:48:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AB54FB6
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220902; x=1676756902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kE2PNchpYVyL29iMNIwtd6QvDWUhF30onOHXzxOpNvI=;
  b=kMEiq5GGpm3x+tSS2mf8ggQ1cGhEo0uo7EFcy4IF7Xzu90jE4H1y1CDG
   girtzmdc+JJ/oahjLaRwxzU9u/gBr8PNxPBNmZBm0/0463Fm5tu36M3kr
   8sMa11Rq9RP6/y0FotoT1IpheE8n77VpEurR2PCETbQWd6DXfM2bYsFME
   7nEOPf7+aAqhEKgUqDb/CqdqlHt9joq++VyCBK2t+7BABYNo467GqvaR9
   5j8Icb4mjLfzFUxq/MEMHR15ynYx4aYoDsL7bIKRF0uSVVtUC1aoOh06c
   fRZukcwT4KmHi/ienDpOGdcs0viqCXEW9g92bMwfto7usDlQV74jvsU+d
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="250989422"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250989422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626756148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 13:48:20 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:48:19 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:48:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 13:48:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 13:48:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwdfZ2SlsqoWGKNlvrEOZK1fsDT6Y5ze2K2QaVAosId2Tie4X4daW8eCv812GmNvwnzbSBxJ3Az66y1GIUdEoiU0gTGGZrTC862DRR/RxYS523OSMHPezERsNqEQX6B+y06DC5AWLICTjKB/LlWoHBXFaW8vt1bSkQdCSgWOMmXrhlU3zK+wOq630YvLjwPVT3QOkwzUufH1SATnjkHsLnwywPY8NYy0ev8mgfPLPsBgjcVD9UmyP4y8mH4m9ipk1OaBg0ZvYQRmMJeHOrYpgpnUkVB8yleFCowawRwJJ+PUY4SR4JlxHVVR7+ByMAfZS1I/2MMmsTRVq8TOFkG5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vLAO1Wy3aovZy16XoLzcLtKPp3eu86q41RRZmzNkOg=;
 b=UxzXSvgfuDwpvVvfU371t7TnqmOX80RvHWFKLkW2kJ6ycSjgRewstPESJTbVn1ffY6VCn7wnQlPKGSx1CNSXrVuh3WqXpJnBocZyjh6KqXYX3Xjr2YPtX+Is1BmJH9C9WteTDBYHaXcGMDMlrGb1ECERMXuaCfIQYAzz9WegwdYiI69MkKXpuJ1/o0kDGXwRPSr1HXEe6iHdYE/IX7N8FruF9p3ZVw2v7v5PPSLiIeBZBYqIbuQAOM7x5qbyBbQAErUQtIiNdGso/Z+IBeWilp7zaiv0V+ziISj6sl3i98Y9Cp5Ih6aNShAv5zzxc9fsenzyHSJ97jBEZp8HuKacNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by BL0PR11MB3315.namprd11.prod.outlook.com (2603:10b6:208:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 21:48:11 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888%2]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 21:48:11 +0000
Message-ID: <49e39fea-79e2-4c87-cc97-47d98f00746c@intel.com>
Date:   Fri, 18 Feb 2022 14:48:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset,
 treat value as a single byte
Content-Language: en-US
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <okaya@kernel.org>, <dave.jiang@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20220218205557.486208-1-benjamin.walker@intel.com>
 <20220218205557.486208-4-benjamin.walker@intel.com>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <20220218205557.486208-4-benjamin.walker@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd9ba561-db74-42fb-4b12-08d9f3285b8d
X-MS-TrafficTypeDiagnostic: BL0PR11MB3315:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB33150C6234F8139E5BFEC6BAEF379@BL0PR11MB3315.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FwgeOLhBNa2ki35OE8aE1PifDgZtA5xzKoC6p8dt8GRdIYo+iEmh5HGuKAiqPUYcGd45s7MegbmrYUEzydH1eEQW0wQ9hYa5JJM8KQuAnyEOlD0nQscGjiDywxeZqc32L457BEiqb5+yUjQ2bwm90MwXXZXxbpLa63gokQ8uZCtMpwPcwUrDKJ4bsBKlA3+PCGYH631OwHkieLG2qqgG1HSiZWlb8mcGrS6KEBI0Z81iLYgrXhtDLNvI9Tj1oM13dVwd9P6R6UJMMXTKWyO5aqnJ3R6mPBuXYZBgxWC8hEUfxkH/kCimC+j7BuzS05vcaRJ47nJJtDlOxHkkqFd9kqxfBDbkbCtsR3/L1xHqCGqm82SHBagJiDBXm+sZBTkkYVNJtoQJ+z5tbGcprM3p95Dgr91jYe7hvGqjPLIu/+DPrUFUJ39kN4m6mqLEOJGPpHAw68PA3TkNzXY8W4XNGfYvXyuCIMv2grnHzvRkHkSxUxUfx8iVoA4jUiz3Zipt7Lg2cTw7YHC+vFm7QQlTyKt6cDBM7v2j9QRAmFxlG/rkxS5xgBmMA3gHl3h0fnKAKiyXqfpVCHwEOENJiRQ7WyW8QtQVkpJKS8oVMRSckAxJYkVvU0NqHmFh2YL4x+MVZcC9kqtNpGbbTiYDiAfNCABJmo8Co7zoFnBGeIg89g+1rGpOpXhKGekoyRcp+H0mQ0oj11GBLgTA3bDEJO0/TQ2/ESKy01fMPY99zwGEWcjCYllHRXFOGupbUfPSe1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(8676002)(66556008)(66476007)(2616005)(5660300002)(2906002)(66946007)(82960400001)(6486002)(8936002)(36756003)(31686004)(86362001)(316002)(31696002)(6916009)(6506007)(6512007)(186003)(26005)(38100700002)(6666004)(53546011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5CT0c3aXEyMkRHa01va01YRkVCYmJ3amFuZGhUUXBDNmtoalNQaHZjajRL?=
 =?utf-8?B?aUZzZXg3amU4OS9CRXhOb2QvVE93b2t1d0N4NkQ5RFRjcFNjUVpycCtFbE4r?=
 =?utf-8?B?a1ZwVlBKTkowWFh4RjZBeWlrNzNON1JZSlJ1SU8xVE1JbExMTXBxci9RU1J4?=
 =?utf-8?B?L0dOakkrRHE4cnNaTFNrZHR2RTQzTTJJWnJXdS82dGZrTGxRNVdLTTFYUXVl?=
 =?utf-8?B?YjFHSXFwYlhGQ3FlMzhudHY5RnhVbi92NTNYZGU2cjZWSGJ3T2xCKzV5NWwv?=
 =?utf-8?B?ZFltYzNJcnRoVW9BR1ZrM2xHMlVqS2hVa3YrYmEwL3FFM0VjRHNyRloxNnpm?=
 =?utf-8?B?c2NZajB0N2l1aXFjOWN6UEE2cnpsK1pVNENFUUV5YlFzV2MxbFNWM2dBenYr?=
 =?utf-8?B?Q014RVUvODV0d0M0MnordVBLL1ZqQThmWjRGK2ltc1daVzdxY2x2WEQ0Ri9X?=
 =?utf-8?B?QTl3U3RsMG16VURxc09TU1BPcE5VOS9EQXhOL096eTJGZXV0RkdYcUV3UTY3?=
 =?utf-8?B?VGd2STRvM2x1aktrcW5rblVmUEE3STQ2ZExuSzdzNHY4SjJtWXI5R1NVUXI0?=
 =?utf-8?B?VVptcm5LcFU2a3p3Qk8wNzNOV2lEZ3N1NW1vMjJxRFB4dDA0d0JIeXkxWXpD?=
 =?utf-8?B?VjlmcjNYeEdrQ1RTK0lFWURvUFNOeDU0aUsxck90dGhOQ2hNeXJpbEtKM0Rn?=
 =?utf-8?B?WnppVVMxU2xvYk8yWmU4SzNRQnhvRTVFdWZRamNvM0ZwaXllYzBSY0lYS3ps?=
 =?utf-8?B?b3FkUzF3MGVFRXFVMEdhTVZDZ1l0c3hhTkhyNUI5YUJvZTlDaG9zcFg3bll6?=
 =?utf-8?B?M3NRL3MvcUE0UXA3b212WEJtaGNIRysvaUVybE50SHBxMW1VS2dOOG9ya1No?=
 =?utf-8?B?Qk5kSitmb3I1aTRzYU5aK2M0UG1nM0pqbjIvTzVEbjFTOHVtNm1IaG1oYUtY?=
 =?utf-8?B?eHN0NlJSeWpxbjEyN1BqQ0NabHZmcm4yTm1jNTNwcitGSGQzS3VsdFU4MWhY?=
 =?utf-8?B?SnBXNjRWdEYzbnR0V0lLSDVUSXdOa3dzQmZEK1FEQ2ludGZWZFFDOHBnWTZU?=
 =?utf-8?B?SHBaNVZzNjhrSy9ZZnErbHhmNjk5UlNjUDRUYVlzNzNRYWIzalZUY1lveUJs?=
 =?utf-8?B?ZDJuYUpTc1JOZStpOUlsWjZmeFJnQzBuN1ZFcEJUMkV1T3JVdXM4NUYrRHJ4?=
 =?utf-8?B?eHJzbTFLTEZkQnM3bUdGVzE0bXU1U3EzMThFY28yVi90djFyaHM0T2lPNnBT?=
 =?utf-8?B?K3NQazVSSy92U1o2OUFreFRXdGpSQkpDQWFQSDQ1VHE5cm03bndIR3Y2WXQy?=
 =?utf-8?B?WElLYldBRHZwT3ZyVG9ReVBSREpRTzYrZ29LbnB6MzFTTlBTZ1pVaU1kR1RZ?=
 =?utf-8?B?VHgrc2Z0bG5GTDBYOXczVER5czFWZGE2K3cydnhBcUMra0Rady9vNUhJM3U0?=
 =?utf-8?B?cWplWmRSUndlK1lwZVJ6V1ZJL3hxUEF5SzRuR0trbmRSTzBhTzVhMmVZdGJR?=
 =?utf-8?B?b0pCdzlBQmdoaEpnZDJSYmI3T2RJbkpDazJuTzhCaHVIdGRqZWtod01oRzVX?=
 =?utf-8?B?ZjJQNmtKL29mbnorOXI1L3JnQ3FEMHlVaUpaUTBWeTM5bFNrcEMveGtZSFg1?=
 =?utf-8?B?SVlJS1hySjcwUTBYN3pwTFdnc3IxSXM4SHA1UFYrTnNqaTZxSTUwbkVlY2Ju?=
 =?utf-8?B?enp4Z3Z5OVpkd3Y0eS9UMEd6UUlPU20xU0VlUXRzbjVjZWwySlVRc1o5bjJt?=
 =?utf-8?B?RkV0NlYxQzVqR3Q5UWxOYmJFeDdHVHZYN2FaY0pKZWpCMjZDelZaRjZUd01h?=
 =?utf-8?B?b25BYi9rZEpxUy9uUi9nU25rZFg1SzVtbU9McFYzaVpWeDBHUTJ1QkdaT3Vw?=
 =?utf-8?B?TXl3OG5lQ2cyMGMrbXhJOFNpQVNhMFZvZk4wTi9TSFNoUmYvSGI4WTREbEdp?=
 =?utf-8?B?RlZSRUltakFBT01hWXpMdmRtWjZMNGFzTi9Tbm1RaHNGbzl5S1VhZDRvZWJQ?=
 =?utf-8?B?N1ErMUVuUzRnWlZPY1RNR3JONTdrQXhhZ2FQVDROanhMUzNLOG5RQVN0cVRM?=
 =?utf-8?B?NWFLZlM0cUI0TjN2UGlNamFjTUZ0c1pocXN5RmFGNVN1NUo4K2xNejg2Sk5m?=
 =?utf-8?B?MjFhZUtTbk1OTndTbUFZU0RJV01tZVRaTitpWGozYk5yUVB5UHcyV0YvVU5y?=
 =?utf-8?B?aE9aYWlWQ3Nqd1JCU1RCQUxRU2x3blFLWTJ6MVZad2RBTjhVNzNSby90SllP?=
 =?utf-8?Q?pi2Gcj94eoB6hP3BFOOfhi36NBsC7yta/z2IvrjI4M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9ba561-db74-42fb-4b12-08d9f3285b8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:48:11.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwPKujxqcEkGIBKml0Uq682tV2AUgDM7We3uYauLKVTaUnx0QcEMIXYLq5xK83MAJC1J4Kg63nQinT8Vhxlu+G8NJNJjsvjgo6wW+ZpTZ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/18/2022 1:55 PM, Ben Walker wrote:
> The value passed in to .prep_dma_memset is to be treated as a single
> byte repeating pattern.
> 
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   drivers/dma/at_xdmac.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index a1da2b4b6d732..547778fc6445b 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1202,6 +1202,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
>   	unsigned long		flags;
>   	size_t			ublen;
>   	u32			dwidth;
> +	unsigned char		pattern;
>   	/*
>   	 * WARNING: The channel configuration is set here since there is no
>   	 * dmaengine_slave_config call in this case. Moreover we don't know the
> @@ -1244,10 +1245,16 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
>   
>   	chan_cc |= AT_XDMAC_CC_DWIDTH(dwidth);
>   
> +	/* Only the first byte of value is to be used according to dmaengine */
> +	pattern = (unsigned char)value;

I need to change this to signed as well.

> +
>   	ublen = len >> dwidth;
>   
>   	desc->lld.mbr_da = dst_addr;
> -	desc->lld.mbr_ds = value;
> +	desc->lld.mbr_ds = (pattern << 24) |
> +			   (pattern << 16) |
> +			   (pattern << 8) |
> +			   pattern;
>   	desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV3
>   		| AT_XDMAC_MBR_UBC_NDEN
>   		| AT_XDMAC_MBR_UBC_NSEN
