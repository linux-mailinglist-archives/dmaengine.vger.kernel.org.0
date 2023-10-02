Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77757B5BF0
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJBUZZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUZY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 16:25:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1CB8;
        Mon,  2 Oct 2023 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696278321; x=1727814321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKGGZVcBX9xbjceWOjzPxTutCea4iH2SGwAjAkgaoJQ=;
  b=KLbTma9Ke9LGpmc1FWCTv5B56jZBZ7PI1xceRQ0iq1DvTNssDVCs1jfL
   W8lao0aGvE/1Bzu79RSt00TsJ1swikIF75Z7vkp3Qa5Erd190R9oZWTUs
   apFNLj9cibkzMLVI4OiWMHWkzYcrYjYEkGkbVVV6EmBsJy12ZBSjvSg5k
   EGaq47ZUWEOLL6kbCwax8YCCUcvSNUdWedHfLO3WG4LCGC39iTWQvyeOC
   lOoRqQXS0lNPzFm3GTAGY2FLP4rhDBeH+hXOQXGoMOck9REtrpR4sI3u1
   uMcufYcM2lC0haden4CaEOyZzaWaMTlcX981sXgvVhbHbAs7E8TacMdBS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1321911"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1321911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 13:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="820991335"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820991335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 13:25:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 13:25:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 13:25:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 13:25:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 13:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGrWtPNEyV5so9jraJ0RIsziDsqhCkN7WUYRt4C1i6p3u+90kF6qbW8nCi0F76rEMbUYDc1R+Ti2csdm1RkjdHVBO/Htyr+Q4oEEKCt4w3Pqdys3GUy8Y4fJ8pIox2/rvkRsRzt+RqP+jjbEsciAKQVNXr1FSieXt2n86wmD/9qMUPWF3zIaQInhHXfjPLi8ACZLUsCbnnTjOrjxn7kwe9xv9yIM7kjcbd3AgeIjSEHH/mGyD728LC8ZGrpVIHT7qrtiOsmJLxLeTQycDLMT3zUn0MlS4Xnyq2h8jooTIH1MnzediT9mKrtFubwDUZpWfCsl9S0MLuLZ2YZ3lXrZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNveHoB3OUy5RFQwBk6dPDndLUnzAs5L6Ok0618XCgk=;
 b=D/Ko1MqPqq0YeSruFxIdpnFyGolDV8lNx6BL9fcinVlrqmEcJ0tDXdZUuwOhsnXc2dGcdGWcRINO6gFmB8vuj7kMrUTq73Rp3xOwKbE1nHK+gMUkXpn6+zkFtxXqq9X49ucurMg/62pa/Ejx6tU08Z4K1Sf0sd5aJ+a7+8lJytbDM/+QwI6zMJWBT+k6q7p1L/LJKm27KU6sjEB7UM/JofIkF/B6sJNJffBGsb1AbxHMEqjQ0sao+Fb2AZz83JKpnHDeZE1ZztdaChHNfulIpFCs9MQ3pswt9BLfg0NMdGnmyC9qNEfo8u05UJcw2FOUgzjwzNfiYFgjWdWX/PXrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5360.namprd11.prod.outlook.com (2603:10b6:5:397::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 20:25:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Mon, 2 Oct 2023
 20:25:08 +0000
Message-ID: <6b75b244-0575-ac34-4c7d-c2e070918e62@intel.com>
Date:   Mon, 2 Oct 2023 13:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <20230908201045.4115614-1-fenghua.yu@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230908201045.4115614-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 688cdee9-4ece-44ee-5477-08dbc385ac03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXKSmQCWkeyZcFWoTju1cWvWziaayk4aD0BLMybHuqElUNHRe4df7MOkjWWMMSriZ/G1LxQPTy2vIKDDXXCq4Y1G7vSZyAfQUHk24+4iqQCiTT5cejpYnI1PKU7ttodb3oe+5sxvKemwQgwAMFfP/zGcL9+cnUrizh9jOFFhz405tweRvl0ZS7WUVkvIawCNSxnl1TtQaR7gs41FxT8CvWhmB1HhFRN7DKeaLovwAv5AI143Heu7dv0GqdMAavFqEzy4/pkSgRwIYaKBKa/SeA9fDFxi6uMV8aJ8hPU5WNw7kV6b1mpc4o622evZb3goY2UgLlxEANDwTtZkKEuYbpAGb8LpqPpdWVPXcM8BwmW/0sEAOBR0HZw+IzsFKPw2HeaaaAEtobZVmzldcoYB5ErYwTJ9cWd7D/mcB8W0Muv7cvCf0c2w1kyNdzs3iBr26jblbmsRMCy66BS9MFTndKa50MH85/IOGIkqjaWZFJmad30s9Cb8iRl6bGB79kR7gTKFivlRVF5kXd/PyEaBh5v/LoNr0RjiKcWifFJ9c590jGrzybL5NAR7hzivZxNcK/iYs4f75dlzi8XKDS+rS+1YDsFn7XE8lOZs7ARptNtD0U63FQdFTkQbI7QGv+B6ZRmT5bFQKwk1R/Fv4TmcZ6u954urpVFPHoVFFkWQEjues+UNHtoiSppmEEd7k2hA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(53546011)(6666004)(478600001)(2906002)(6506007)(6486002)(966005)(8936002)(38100700002)(6512007)(26005)(31696002)(66946007)(110136005)(86362001)(2616005)(36756003)(83380400001)(54906003)(6636002)(41300700001)(82960400001)(66556008)(8676002)(66476007)(5660300002)(44832011)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBMZXo3TGR3ZVl0bmk1UnhTKzd4T0gveDJNb3FIbkJYdUNDNW82S1dON1M2?=
 =?utf-8?B?d25wMXhjaGdGWkNCMGp1NlVlUDMzTWVTWDQzcGNNeTVhUUVxL0dCZnlqcks0?=
 =?utf-8?B?c3JDVmtLaGFxWS9FRFdVajVRMG94aHpaVzk5elhFOEJhOG9qWUkrQUZjMTRi?=
 =?utf-8?B?eGtEOURlUHJSNmptWjlvdkRGV1FkN1FqbUZyYmhYaDk1MEJzRnczTWJVd21W?=
 =?utf-8?B?dmhzV2dsY1R1OFVGSzFvclVYRHlmOWVIRWxyeXA1UWFWWlc2Z25UNEpQaXpB?=
 =?utf-8?B?aFhJcmU0QVRFK3l5NjdGZFVpRkJMdndpVXVNbXkwUFhna1BaeU5QSXpFblpC?=
 =?utf-8?B?aEZrYkxnSE8zcDRoYWV0WWg2Tk5hTktybmxiYnI3TlNhc1ExN1Fnb0ZrY3lL?=
 =?utf-8?B?TVpJN0Z4NkU3SmhFYXpSbGpqRkU2eE1BOTAxZ2JVdkVXTDU3WEdWRnlSbVZF?=
 =?utf-8?B?K1p5UkZkZC9ydUk4MHhleDRoTVZjU2k2dklvRDZUbVhrcjlKY3ZzTEd1WVBE?=
 =?utf-8?B?Q1VTVXlkZTNscTQ3bDFSSTlFdE9sOTBZZllSZXZtL2czVVNoWEI3T2FBVDYz?=
 =?utf-8?B?cURRblRqVEwxWkVEMU9hcmdqVmh4SitYZkFVQUY5MkpPRitaaWlNRVh4aWNR?=
 =?utf-8?B?QWMwUCsyQVQvU2h0SVJqNkd2bjJ4TFdXRWFRUGJFWGRPeWVqY1VzQWdQTmFj?=
 =?utf-8?B?R0ZMcXd6RHNwS3dMTTFKdEZQL1dGYVFGMEF2YXEvQytyYmw5OEljMW9qczI3?=
 =?utf-8?B?VTRKTlhDcndHSEx2SlFHT2pYMmhDSnRHZnlnUE5LQnBwSkxwSS96TUxHS0FU?=
 =?utf-8?B?YjFqT3A3WDAxa0ZSZzh3TnlYRUhoVWlUOEp0eDJxemlSZGlDVStZdk1OV1FY?=
 =?utf-8?B?N0NsY3NuYklzYnEvQnlLczNPWlZlM3RCV2x4NG1QVjVLeDVBbXV1eHNpZzdJ?=
 =?utf-8?B?Vk1OOTZHRUhOcHNiQmdlTmluVDIrNE5RR3VXcmJ0eGh6WnhBVGIxbWRPQXBs?=
 =?utf-8?B?ZDViNDM5V1h3cGFycVhXSm1qdnU1M3cwZFY1c3g2M3VjeWUzUWV5QUJzQko0?=
 =?utf-8?B?SW42c3JZRFVKbiszL1hyVXBRcEw1dVlqYTNjUVZ1VFI4Q2hFL1NuRHo1YVNN?=
 =?utf-8?B?SHVJeHl6eUkrL1JWWERTaTdVUUZuaGdiR0xIMDczWHZFYm9jOVJsZGs4Lzc3?=
 =?utf-8?B?eXBkRUU3eHdFTVB2Y1AxZ2pNSk9ySTZ3VGVvcGVGWnRjTndyWmJhRUsweEJo?=
 =?utf-8?B?WmpPaGF3ZHJ6Nnp0Z01BV3VBY1EyeTVmQ0pEeTRiUWZSMXNwbUttaEE0YnZ6?=
 =?utf-8?B?L2tudHU4UDI0OThNOENkeDB0d0pCSnZ2eG94eG1pUjQwblNSZjd5Y0o0UGsv?=
 =?utf-8?B?ZVBqelRkSDRCbXdWYlVDaDlPcTJRSkRiREV0S0ZkM0NhYW9oVzA1QzdsUGdU?=
 =?utf-8?B?cGIyYW9tSVdPRnhKdmwwam1TZWFycGQ1amtrc0dJZ3lqbHQ1UmJOaFdEVjZ0?=
 =?utf-8?B?UDFOMmlQKzRFdVlkN1pta2dqalNyalV1MitoWjN2bjFHblZUZ2FRaVlyWGtP?=
 =?utf-8?B?RnQ0WUZVNlI4RWxYWGlBVkU4REg5M1hQQW1Cbk1janpBYVpTQ1p5aStzZTky?=
 =?utf-8?B?QmdUdHI3Rlo0TDBmR2pQUzdDdlg1d2VSNXF3NkNYSzhROVNHWGlxY3lNVFZ4?=
 =?utf-8?B?Q2gwSDFUTnQyZ1FvcndTOXhnNWhkbUcyeVlPREZFZnltWkJnU0xnaXJmR3J0?=
 =?utf-8?B?OWllaytkUXpKcE5jZFVVOW05WkVzWmxVZ0JadmU2aHorbWV1Q0MvdWtITnFU?=
 =?utf-8?B?UTdJcWY3MVVGczZ1ZEJ0SzBLeEVCcXQxSHRaRUdCTEd1a3J0Y0U3Z2VzSnpZ?=
 =?utf-8?B?cjNtbUk4VSs0RVBTNE1UODNMSk1LLzgvQXNBL2s0MTltRDFOK0xucDVjUnVq?=
 =?utf-8?B?cGVPUVQwekhNSVk3VVE0aUVNMFpNOHNYbEFoc1F6M3N3K04xTzlFUTVGUnVE?=
 =?utf-8?B?SURIUDlBdXNXaWRpS0hSRGtTRVo4Wm1XZzlqQk0wSDFhMUxZLzB1SEtQZVN2?=
 =?utf-8?B?eUJEd1U2Um9rOC9reUNaRGNWdS9haGxpUVUyVUF5RUc4ckVYS1lUN2N6cHRB?=
 =?utf-8?Q?r6vxLkMA6uFgvZOqgAul6Cfsw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 688cdee9-4ece-44ee-5477-08dbc385ac03
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:25:08.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIgaI0P0zuJcqOt+HFAQ+KjkPOKi68GCeF/pm1LOi+wt1mt/6VNyoHqvv1Q4WmIsQIBDrJbDudDNf6KwwJS43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5360
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

I see you applied a couple of IDXD patches to dmaengine tree last week. 
Really appreciate that!

This patch and another patch that fixes a split lock issue: 
https://lore.kernel.org/dmaengine/20230916060619.3744220-1-rex.zhang@intel.com/ 
are not applied yet.

Any concern on these two patches? Are they good to be applied to 
dmaengine tree?

Thank you very much!

-Fenghua


On 9/8/23 13:10, Fenghua Yu wrote:
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
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Hi, Vinod,
> 
> This patch is part of IAA crypto patch series:
> https://lore.kernel.org/all/20230731212939.1391453-2-tom.zanussi@linux.intel.com/
> I'm sending this patch indepentantly here because:
> 1. the IAA crypto patch series is unlikely to be merged into 6.7
> 2. this patch is useful by itself in a few other places
> 3. this patch doesn't depend on the IAA crypto patch set and can
>     be used and applied cleanly by itself
> 4. this patch has only dmaengine code
> 
> So it would be good to merge this patch into 6.7 first. An updated
> IAA crypto patch set will be submitted later after 6.7 time frame
> and merged in a later kernel version.
> 
>   .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
>   drivers/dma/idxd/cdev.c                       |  7 ++++
>   drivers/dma/idxd/dma.c                        |  6 ++++
>   drivers/dma/idxd/idxd.h                       |  9 +++++
>   drivers/dma/idxd/sysfs.c                      | 34 +++++++++++++++++++
>   include/uapi/linux/idxd.h                     |  1 +
>   6 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 825e619250bf..982e9f3b80e2 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -270,6 +270,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
>   		correlates to the operations allowed. It's visible only
>   		on platforms that support the capability.
>   
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
> +Date:		Sept 8, 2023
> +KernelVersion:	6.7.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	Name of driver to be bounded to the wq.
> +
>   What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
>   Date:           Oct 25, 2019
>   KernelVersion:  5.6.0
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index d32deb9b4e3d..0423655f5a88 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -509,6 +509,7 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
>   
>   static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
>   {
> +	struct device *dev = &idxd_dev->conf_dev;
>   	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
>   	struct idxd_device *idxd = wq->idxd;
>   	int rc;
> @@ -536,6 +537,12 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
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
> index 07623fb0f52f..47a01893cfdb 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -306,6 +306,12 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
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
> index e269ca1f4862..1e89c80a07fc 100644
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
> @@ -646,6 +650,11 @@ static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wq
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
> index 7caba90d85b3..523ae0dff7d4 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1259,6 +1259,39 @@ static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *a
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
> +	char *input, *pos;
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	if (strlen(buf) > DRIVER_NAME_SIZE || strlen(buf) == 0)
> +		return -EINVAL;
> +
> +	input = kstrndup(buf, count, GFP_KERNEL);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	pos = strim(input);
> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> +	sprintf(wq->driver_name, "%s", pos);
> +	kfree(input);
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_wq_driver_name =
> +		__ATTR(driver_name, 0644, wq_driver_name_show, wq_driver_name_store);
> +
>   static struct attribute *idxd_wq_attributes[] = {
>   	&dev_attr_wq_clients.attr,
>   	&dev_attr_wq_state.attr,
> @@ -1278,6 +1311,7 @@ static struct attribute *idxd_wq_attributes[] = {
>   	&dev_attr_wq_occupancy.attr,
>   	&dev_attr_wq_enqcmds_retries.attr,
>   	&dev_attr_wq_op_config.attr,
> +	&dev_attr_wq_driver_name.attr,
>   	NULL,
>   };
>   
> diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
> index 606b52e88ce3..3d1987e1bb2d 100644
> --- a/include/uapi/linux/idxd.h
> +++ b/include/uapi/linux/idxd.h
> @@ -31,6 +31,7 @@ enum idxd_scmd_stat {
>   	IDXD_SCMD_WQ_IRQ_ERR = 0x80100000,
>   	IDXD_SCMD_WQ_USER_NO_IOMMU = 0x80110000,
>   	IDXD_SCMD_DEV_EVL_ERR = 0x80120000,
> +	IDXD_SCMD_WQ_NO_DRV_NAME = 0x80200000,
>   };
>   
>   #define IDXD_SCMD_SOFTERR_MASK	0x80000000
