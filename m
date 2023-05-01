Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192276F35F5
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjEASmD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjEASmB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 14:42:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD470170B;
        Mon,  1 May 2023 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682966509; x=1714502509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7gRIibylatl/e9p3WJdVc9TetgnfpstOWdGwSXOHJCo=;
  b=kMoQkS/930d+2MeOdaMkBe4SeN/RLqZh3/3kUuy9EPZfXopxrl2KykoX
   qgd2AqsgXB8eiiCSez/m+iytONwmu3ZyGhpgNOHbUjy7HZQOFrMp0jIc5
   Bgm16NyoVbgRQZA1nxOW5jEGRFYVbM/3dREd7VhvnESN/bxIJse4iP79v
   ID4CdiMgA4CsLaDek3jja8YRnO8btNkHXoGSAxrTwF1NJurshj6nk0fIr
   gzuXLoO5FGqAU8DhggWNwX46+VL/0FSyhTwLXeFIqerF4+ZPouwgZec7E
   vgH29o+V/Nef/ffh4YvbwPTju+GhdSA8wwk2kkOVzGNWDp/eYIYGx2hUQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="351180253"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="351180253"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="728631218"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="728631218"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2023 11:41:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:41:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:41:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 11:41:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 11:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnoqMjEnfSfYM7yGAc2tsyuL8DWjaJBTpl/b9OMMMs2bkqVqJEUdppvBEwptgwpCA0HZKlgLpFaf0EzAzV2WsIjPTYPONlLPFD9BRV+iMb/DM6JSim6XzrtcxdpU1OCoLNXS3b3FHoEbJTvL1XrHGu0lEzILKC18eltb3FXyhzPkBlt1OFlJ9cJTELaIUo/PhFWk/kUbZz6DY6Qkdy7keYsnAH2bTRqlcfA8n1RVYiVxv/LK/8+odRimT2ruBrL3MH4gITOrF0zU86Z709LRQQvishyUtDBmGf6ARvHxNp+GPRBMbU8KPp9gB8jKueQxRIYXs5DNEuDVv0WpxdNsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkOls3IvxnG+cj9CXW5XG0vjhasoDdCnd8uH2hf/WCU=;
 b=Sf2uTkX7SnVRgxpLQfK6mAOD00UTQTWBjCIo9YCF4hdc3JadTnzqA3akt33zxHwOQSUOvqiHFi3bTrAhxJOXAbrbTN6Symt//yXkeFqZAauJdT6gXWNPe1ZrKNBAzNyrsH4AY9GEGVBGTnUArhC9W0nI8CqBu0FgPemYD44r9k6O3OTS2FV11KWNuyiNu8JycfHJcv18Qbpf1CtQIAOobIfSXG90LhRhHTik+KtYwo/ZA6bUwlLPw6uE7s6mpS4bQ51ZsqJQOx2Jn/CtpyyrYCUjKNX5eO63wsc0VUNEkOUn478OogKyeP90J1p+NiMuS0A7ylYJqFGjUAO7wbIa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:41:45 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:41:45 +0000
Message-ID: <0d32b234-ace2-0490-6db4-a4e42796ff3e@intel.com>
Date:   Mon, 1 May 2023 11:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 05/15] dmaengine: idxd: Export wq resource management
 functions
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <giovanni.cabiddu@intel.com>,
        <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-6-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-6-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR1PR80CA0196.lamprd80.prod.outlook.com
 (2603:10d6:202:2d::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c020b8-6576-4680-0579-08db4a73b6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1sgOkaBnMHNEW1pEndi9/F8Gmg7NPLukT10CKn8FMlTYjQcmXvH3unv24WO7Upt1IS9ass4Hhf1TjDwu0CyG32GtQYlTEY2S77DyknwML65JcVaXtHXtF6/Ttk56jZ6c9uaaNI+7Qjnc0ayiF4fQ47a8L5nNw2u8eq86GPZYLbyOb687PHqkVDRlSluT2psoOpzditp0D+z85+bTc6WZlKnsDUqHZQ/HRC7j261GmZZImvppeoz72yMHSjYy3uhvugddDhiWOx1O5KxwS3oh/7gWDbb0Vz6STNvEIOx9S73P5Qg1F3FJ2OkglW2XaLenHCt4yMB668bx5WYB4LUUvBz8Op3ys4WsZXAy7yt3LwkhOkQi2UfG7CBRGRzUKq9rDZBod+fSRlZ84LXIBW69MB5PuPzEq+q4vq2jh9aQQx2PYdaj+nBKgqD8T88E9Zc30yPjm3zbBd9ma3bcycoD0DxBbBAubwThEQ8VWI9GGia3FzwfpcMkm6mB+sYwnSjNFoyvBN/L37Fonhpcf9VojJzYfnAY7Ol9ZIjr8LNRO3RRyE9T5a+NwfcL48X5OFzvfhri4Kx21oLfe4bUfkqVIMkJuO0l7I6TBahl4ubcsUlAGNZ6Ul/aGD/djIyoI7LSP/0AAJtEsdJuvm+eEPC8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(86362001)(82960400001)(31696002)(38100700002)(31686004)(2906002)(44832011)(6666004)(478600001)(558084003)(36756003)(6486002)(186003)(26005)(53546011)(6506007)(316002)(66476007)(66556008)(66946007)(6512007)(4326008)(5660300002)(8676002)(8936002)(41300700001)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VVbE1Ra3dFVE5OZ055T3RDTnZsc1Z4ZUFoWUZaQTZsVm1McjhsRW0zUHJ4?=
 =?utf-8?B?NHE4VktGYVRiV3hpelN5amhLbTd1SWdHUUZJeXlTK2xZZkRhOTJZRmkxY1R5?=
 =?utf-8?B?amtPUlNZZ3lkWWN3R0I2RWFUbVRvMXlEb3I0amVkNHVrYnlaNmhnM0pmZzJO?=
 =?utf-8?B?cmt0UE9tbjRPalFnMExQTXlISWh0YmxuQWZidWgrK0JJK3pUbDhjVWhMRUpO?=
 =?utf-8?B?MVJXNHBnSG8wS2VEb0NRbDN0VEZJTlZOenlEa0ZOTXhWNk9wSGRvVnRUajRS?=
 =?utf-8?B?SkJ0OFozSmRoR1FPREd1K0VoaEk0Z3BHK1VCYnZ2VEgyZldoVCs5T3lCMnVM?=
 =?utf-8?B?YUQ2WlQzV3puZ2tRN3pEamtERlYyN2RNM0FPZTUvVEZ6enI1blE0SlR1cHBR?=
 =?utf-8?B?bnZ0cE1WbVVtbUVlZkhFYkM3WXhJY1doT1ZkSWxrUHZMa3JRcTYyRU1CS0FE?=
 =?utf-8?B?bW9pSEFkYzRKTFJkTWFrcys5d09EVTNCUTJGRk5pUlU1R0RXU1Avd3dYVzJJ?=
 =?utf-8?B?OUU0YVMrZCtxUXp5aTJleVhzbzMvYUZjSkZKYTErbjhQbnZHR25yTVJxN3hw?=
 =?utf-8?B?ajRhL2prck9QYmtmYjV2VFNZZVBwZy9CRVhTRWM1ODdmUDQ5K3ZwV1RzcXpi?=
 =?utf-8?B?Z3dLT2lZNXRDeDh6VWplNXlIQzBpWjRkdE1CZ3BJWlJLczdyU2JodmZHdTVq?=
 =?utf-8?B?VVBxUGpVUFJUOU9EWi9zNTVRZ1BHcHBLVDRSL2k3d1o2NytXZm9SRkwzYUJR?=
 =?utf-8?B?bjg5UlVGZGMzWU45Zm5xZmMyd1NZTWZ6dmVHMXJrd0o4Z1I2U1lmVUluQ3pi?=
 =?utf-8?B?Qi9Ea2QrU0hWQm5ULzdEdCsyT0s1dVJqWjlhbmZQZnNpbU5oZTlLU0IxRUZp?=
 =?utf-8?B?NDZYNG1KdDFkTm9CMmN2Q3pYZVdVUHpmK0Q2QVpINHZIekxqZTlPeFdRdGI4?=
 =?utf-8?B?K3F6YVhORDVOL05VdGZtdmltM0JnU0ViQWJDRGd0OGFKazdMWXVMeXZPbFdD?=
 =?utf-8?B?TmJqdksxeWJBbDkxeGJPOFhycFV4S2xmVndHS016cVg0b3Zud04rbXhxUXhR?=
 =?utf-8?B?aVpXdFVmNkVtQ1U0Y2NHNDZ1djF3VE1ZUHNOL3E3VlgwZzJ4VWVNUHlpc2FZ?=
 =?utf-8?B?aUNDS2J2RnRuREpUeWI0eWpWVUVpci9qVHlmYUJxbnV6Q3lIYUhXeTZ6L1Zp?=
 =?utf-8?B?RjhUT1l6WGUrbWZBN2c1eGpQV3hHREowY0V4S0tORUh2d0x1dXlTblROYmFp?=
 =?utf-8?B?VjBYUkpFTDFuaTdvTmJ4T3lXQ0J1VzNaakNnTTRNaVllVTcvRHl4Yndmd2FY?=
 =?utf-8?B?Vm9rUDA2eVFmd1JaSmVJT2sxTzBKcE5XbkdxRVhRUnJraW15SDI3YXBJcW5V?=
 =?utf-8?B?QTgzakZYWjZDWU5DM2lIeWRubmVTTUFXd3BxWGRRNmtDMWpqd1J1b0JNSDdI?=
 =?utf-8?B?RG5iU1N2WUVSVXhmR0xNcVdETFNGaXVHeEJHL21RdUpIUDNzdVpZMGFUemVU?=
 =?utf-8?B?UE41c0I1Yy9VOElrbXZCaEFrYStFZWpVbEpJQnB3em5keDJGOHk2eXlzdi9O?=
 =?utf-8?B?Z0JlOVhOeFdKZjRQbmxZemNnL0gwSGpGQkpRWVFmM1Y4SDlnU2I0VWxkWHhw?=
 =?utf-8?B?ajJ3ZXJkcXhQVlM2NzljS2F2eHF6c09Fa1ZSL2tBYkRGY0xVVGEwcDVYVUZp?=
 =?utf-8?B?YmNRT0l1RDByby84Q3BpZ1VrZGJyakhVYUxGcWlpZWhhd0dEYnlyN2w2Q2Rn?=
 =?utf-8?B?ZXBaQm9yWDV1b0pWOVhDZjllckFGTm1WcE9xa1BReXNPdU9NbnhEOEpDVHkr?=
 =?utf-8?B?OVVwYVdQb2gvWEV6Qy8rTzVNTzRxTEhSQVc3SUJzQ2FmYkpxMTZXS2lCaENo?=
 =?utf-8?B?SFI3LzVUSy9qY2dSemtaOU1VRlAxazRVdldzaWY1S29FTFIwZkNsbFROWnlM?=
 =?utf-8?B?UnRUWUlyQ0NPMVI3UHp2VmxOQlNKRVJhblhpMkF0aWV4UWdkNUN4d3MzZ3JH?=
 =?utf-8?B?Snd4VHpIVG1YaW1BdldGZlorSUxqcUlHNEJjNzYxTTNXTHlNTlk1Z29hOFVS?=
 =?utf-8?B?ZDJ4bG45NDBLUzJmUkphUTd6cHVncnl6Z2IrK1lVdGp2WnloV1BNSVhTZlU4?=
 =?utf-8?Q?Yf3FNh4qMWb9T5arKSSOIazZe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c020b8-6576-4680-0579-08db4a73b6bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:41:45.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVTCrxPQ6NqVLB4EFyQ9PxDTbzpz/B8oXNDH2sx7Ix4LlQoK6eog/soVf3a2OJLxhjRJbgQkquSYyXykrMTOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/28/23 13:55, Tom Zanussi wrote:
> To allow idxd sub-drivers to access the wq resource management
> functions, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
