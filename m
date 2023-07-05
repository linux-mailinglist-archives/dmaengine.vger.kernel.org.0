Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEB7486F5
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGEOyz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjGEOyw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 10:54:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A31BEF;
        Wed,  5 Jul 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688568873; x=1720104873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bVRnwFep0pPsx+rnY+sJ9KZQ3GUfYXapglkfHc/C+T8=;
  b=XPyXfhyywHUah9Op69i0yFzEiPuQJhUMOKX4zmNQryTc06IoLsWgLAXs
   uDFK4wPEzMDXvTxqBuUfF6rCxKDgQy+SXcOiLYDV52On2VgbjNkIiZIKD
   A71axRr93lFEK08iLLVEB4gflbuSyiHE77KEogZpKWBpS2W/WX/n6maUW
   a8C4jL1vFZAMXmQkD4rM7lI2InV7WG6wWnYfiQySJmvlW4O6x7ar8dGCf
   n7H9uwzNnwtOP4h0QTzKGjecFeRlwtWUxpqkzJxFBXxdFbBaHCBf/e1SU
   ajRTGlBDHMV3giXIXYsUyRIUQof6C08Q1kiguyw/JFeP76GUHk3GY8iKG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362228892"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362228892"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="722431762"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="722431762"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2023 07:53:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 07:53:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 07:53:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 07:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjdOxqjvF6etjCPAkLDbLwLFTBSEIPrHXLEOhcK+ake2FvM4qcIwFEYf6d6kXfN8aRZ+rwj2RXT1F1uN3TQHR131UY6fHvAqpLnwxUp4PM/5yvhuM5xq5xvSqGAYWkxOvbLylFLhkiV5Pjz0WzREc17QWvmkWEkpVyrf9kXHc9WkmntpXfnDu/wgCZ/mZVAKsiq8Vlogvh35YNZJ5ue/yrSQAPmyH6SBJdsjy51LIPOJecjP4usw0nn12u2AQOlKiSm4D4/UvnIlj4jz+Xs10tHsh3OUmGsuWTvvfGOfdLihBEAw+0TLc542XznYKgLszJ97V7qjIwi9v9BBSeDv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gnm7g60diNlSureZZC9/4TVq5UbnAA2WKs5mWrRQ3s=;
 b=KyS/YBUQq4cYforUXOOztiTc8wpybFIWZlSjBnRxOp36T11v/kd19hZXZPlz42vNC3nVKhuhbBG8Opa1zJhdj4ijhPkObke9fGPRlZKfkjPprbI09D9Mbc9iO+oKY++e5w5oRNuZartH8Z85bVhiAQjNqNwp85jtM1SPkJO+JWsArrp4qm+jnMEv7kHzFS8/yuh02XM5Lv+1wuF0uo4dxDuY8r7GbjYeECDAxejT5zkIpUsK1qMllREolc6SZazmPq5XVcXNdLlCEC2v82rNZIiwlBmUfQ1ez9bT6YDlcybK2Jqk1rxk/1hPstdnF7DuCbj0BOvrRj900TxvoCxHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 5 Jul
 2023 14:53:22 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 14:53:21 +0000
Message-ID: <e816aa75-4588-dae4-2d01-6f5ba9d4a4f3@intel.com>
Date:   Wed, 5 Jul 2023 07:53:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] dmaengine:idxd: Use local64_try_cmpxchg in
 perfmon_pmu_event_update
To:     Uros Bizjak <ubizjak@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20230703145346.5206-1-ubizjak@gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230703145346.5206-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 7289277d-c584-4f5e-355a-08db7d6793b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cArrZPIACVI/uslgccOf45+ujTb3jJjOiE2j/IT9CEgMQDkbfocZ3zxrkEzXoQQEqCBOK9hWpLfffuZvta2tO/dkZaIUZgnsZt07hmg2IRhlEn4y7dEh2sjvVWsyQV/EpsCLs0vsKcVBSdcLkALmz/nCp/8+FDwwVJLSfMdiVEHIQe1HpCwO1Mtxdm7Zjyx9U/+pek7KKV5j/bVZC5jJXwn3K+sAsPHCSKRmE0MuIOWK/7GzVR6EuHuFkYG9U0xQRshZOEe4Cc6PNDCg90dCKOfYCS6w6xplzxZkUR+q/KxOJynnagCI4IQOyEoU1aeBwYsMpCuwEJ4asPGLl/r1dVfuGGLzWsGym0GT/n0a1qHSo/7ae6nNa7nHlZL1FmNbR/5jhT5QAig4BXpaY7bHL+i4inAuM8fqQJcX2gJ4s8rRfdxgkwlCeoPU7apLeR52v2Ashw/uFt3ALmrjLJKFTx4PNQROTVo/DMHIebWW+d2d72yhm9Jcp9N0jL/qYsLxBdg57oZx/MILcP6qljBIfY6rE+B2ho0T4IViQ9I3d1BQuOGHiSqjDIfk9uYSH2Z4FDTR1MRnY1bpzH/dnt0FVbELIYBxGlpclhK6Uq52fBlObPuA+Le0gflM0QwgHliaJQIzjKdVFSg18tXGYZodeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(66476007)(54906003)(36756003)(5660300002)(107886003)(478600001)(8936002)(41300700001)(316002)(4326008)(6486002)(31696002)(26005)(86362001)(66946007)(66556008)(44832011)(6512007)(31686004)(53546011)(186003)(6666004)(6506007)(8676002)(2616005)(83380400001)(38100700002)(2906002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRIa2pKMmd0WGVKUUhZd0RnYkNBelVhNFd1bTM4RjFLeGtCUmV5MzJhbExz?=
 =?utf-8?B?UDFLVkYxTWYxVmJSeGV5dDFDVXVQWmdUbHYvTWQvcit2aVdEVXJyTFZvUmRh?=
 =?utf-8?B?RVVsdnRWZzRPYVJkWGxTNENzSXBSL09lR2NmdmpoNXdDNFFMdlJkU0dsK2Ns?=
 =?utf-8?B?eURodlRKYUlvQXRsUzMvY2x2VUpqUFRJc2czM2hSd3NNc2xiNUtEd3R5Qmdw?=
 =?utf-8?B?OXMzbkJ4M09ITmtNa05sVzhzUUJteHZ1eGtDa0t3OVZtVEJ3NytrT3RsMk1i?=
 =?utf-8?B?S254ZFE3dVNBVW9kaXR5RWhJMkxpSWoyNlU4VERRV1FFU254SHkyMjk0YzdY?=
 =?utf-8?B?Lzh1L2JrM0lmSndYZmdPa1BlQnJJUmVKaFBuN1pHWmxWcFU3SGpxOWhqREU4?=
 =?utf-8?B?L1VWbGx0Zi9JdGdvaTFhYkxuQjJObCszS0w4azUwMTN0THlZamI4RVRHazVx?=
 =?utf-8?B?VTN4RFRKUENpU0xoWFh2Qy9xOXovVUFZQ3RBbkNkQUVLS2FnMXQyNFhHOVho?=
 =?utf-8?B?RGNMVmxqQ3RBSkJXUW85YXNuZmFSMEtORGdkMUI2NUI3bjNOSk9KN0JBK1Bh?=
 =?utf-8?B?ZG93OWFtZksxN1lhU3cyamxIdXg5UW1oaFB0MzBib2c2SlE2c1ViRVdIWElY?=
 =?utf-8?B?b1hqRmQ3c25jbi9SSXlMQXVNWmt2eE9uUFJyVXhZcjJKTEphRm8wQ2FYVnk3?=
 =?utf-8?B?OUVEd0xLKzd6Z1NHa1hvQkc1ZGJjQy9jemdGTnpWV1RXczVJOHR5U3pTc0xX?=
 =?utf-8?B?eHpEbkMvUEs3Y08yMk05VW8reitYY1g5ZTNyT1BsZ2JWcTBYR3E5VlFxUW5Q?=
 =?utf-8?B?azVTSkU1VzRNT0FsMzdjMGo5THNSU3EweVN5TG5PZVBkeTlodS9ZV3lOUUg3?=
 =?utf-8?B?UVFDUFFqSnVZc09aOU9lVmpSWW44aFdYLzhSTWdySVFHS0VEZ3R3VEcyTFNi?=
 =?utf-8?B?aEh2WWVpckkya2pvMHRpWTFTZnpMVWV3OE0xUVlBUGhkaEUxZVRWc2hNME9r?=
 =?utf-8?B?SWZDdGl3ZEVzR3B3NENpc2MwNEFGT2xRUGJyWlB0UWJSWGx6Z0VGL3lDL0d5?=
 =?utf-8?B?MXcrY1pRTWNrK2MzdGx4OWM0ZVcveCtHdnZDcGYrOFV0Q25aNklSS3hBM3Aw?=
 =?utf-8?B?bnExUFJ2TUluUEtHUTJUZG9qbmJIcnhJV3BWRll1ZzJTZERScFlpUldQWTc5?=
 =?utf-8?B?RXVQTnV5TFN4RENZS1JuTVY3NlpLUUw1YzB1bVhyNjh5eG5mV3NzNWlUMDI5?=
 =?utf-8?B?d0FGMW1aQXhRbk9EWXZaTUdwYWo3b3cyOGcxUStFdGxtdWhnZ1daSHhIZUw3?=
 =?utf-8?B?N3Y0N1gzQ3lvZkpYU0p3YnRKcE5zUmdnOWQydHM3cnJiaTNjUm5VbHNTc28y?=
 =?utf-8?B?Tll3bXBvRVNma3hlRHY2emI0Nk5yUjJaYyt2T3pGOFBLZWVCK0diMU5PU3dp?=
 =?utf-8?B?SVRBV1U4RG8wN3p3cnI1cnlWVnE0RWpJOXhJZnRyQkVQZlA4WHE1Mk1qckRI?=
 =?utf-8?B?VFhLWXp1SFBsSVZ1Smx5RGVIR2tsVlI0NkxyZW9wZ2ZCK3NVQnFTRlcvMjRJ?=
 =?utf-8?B?TXd2RmI0cmZSc29CejNoRWZLNzh0UDlPaVdic21wb1FkUlh5SzRuanVWa0xY?=
 =?utf-8?B?Y1B3SXVCcU93czNkRVA3VWIxeDBZZTc3dGpRT2ZadmxIWGdoQ3BJNTBHNWRO?=
 =?utf-8?B?eDlXckZEN20zTFZ5K2wwQ1FjYUtPNUU0SWFsbFpZUXZ2czZ4WGVtS1gvTUF2?=
 =?utf-8?B?SjRYK2RDNWZYNGRnc085UTY4NmcxTW5weXUwUUtvVTNBbGlRa0pNY0s0NzNE?=
 =?utf-8?B?YTYvSS8xbStvV1V2dTNPMDc0MC83NUxaQzgyOFExNm9KWmc5V2FtczI3ZlRx?=
 =?utf-8?B?SEFteElreVdHcjZqMFRUckR0dTFKRnR3N1dCbDYza0F5ZFN5MlpYNURDSTR2?=
 =?utf-8?B?WlpiTzlIRVRtWHNvVkFCQThLSnBsUk94ZnY2eDNzTUdNdE1NdDZyV0NydjJS?=
 =?utf-8?B?R3J2b09iMHI4SHVEQ1FpSFRsZXo0NFJZSmc0MTgwWlk4VEZhT1JwWVVEbTAy?=
 =?utf-8?B?RUVRQzAzMnhaWXdxbkhuNzVTTUx0bXdQd1ZSTWR3RGljSmJDQ0ZRNUExUlhS?=
 =?utf-8?Q?vL537DWYGk30lW70Kel+cbOOo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7289277d-c584-4f5e-355a-08db7d6793b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:53:21.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opl/Hv8SOheLGSnu4LHKsifjlkCXRdewfeIzRIHtJhrfOQC7uMAVZUWOIkefLr0zaCeObLuE6rCm5s64rCEeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/3/23 07:52, Uros Bizjak wrote:
> Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
> in perfmon_pmu_event_update.  x86 CMPXCHG instruction returns success in
> ZF flag, so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
> 
> No functional change intended.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>


Cc: Tom Zanussi

Tom do you mind review this patch? Thanks!

> ---
>   drivers/dma/idxd/perfmon.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index d73004f47cf4..fdda6d604262 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -245,12 +245,11 @@ static void perfmon_pmu_event_update(struct perf_event *event)
>   	int shift = 64 - idxd->idxd_pmu->counter_width;
>   	struct hw_perf_event *hwc = &event->hw;
>   
> +	prev_raw_count = local64_read(&hwc->prev_count);
>   	do {
> -		prev_raw_count = local64_read(&hwc->prev_count);
>   		new_raw_count = perfmon_pmu_read_counter(event);
> -	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> -			new_raw_count) != prev_raw_count);
> -
> +	} while (!local64_try_cmpxchg(&hwc->prev_count,
> +				      &prev_raw_count, new_raw_count));
>   	n = (new_raw_count << shift);
>   	p = (prev_raw_count << shift);
>   
