Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18FE6AF707
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCGU5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 15:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCGU5H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 15:57:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88934ABB33;
        Tue,  7 Mar 2023 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678222624; x=1709758624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YogK9AUsmpJDreLh+K9BngGNDn7j0OMsnFrfiaIakmo=;
  b=LdKc9gVAMRXzd6i4DejPXMDQla3WWKaaLLMgnYPhLoQOq8sAVIC+g9xF
   RGA/P/lqMozWkP86YJPwApKH84GrgtcVl/zPXzeqsQzrKkkQUkfXbl0cY
   3eDaD2UwPpi4TRZbqEGcd+QySvLNMmBpynhN1AxszRNRQwIrxpVQ2Skxm
   FjJdFvJNy72aPV1i3wk5XsyoJSnCUp5xZ6iPLTbqsvW1+nmxHidAqjGt5
   00zTZHMYsNnANbO7c2RbouI41V6PC31sDjcTpV2EcupvbwGX44nZXGk/v
   YDIglcFtH6yn6HLoWw1il1CtAUVNtGMdywOJnYqWpwB4D26+f5ORxmCAC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="335992296"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="335992296"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745651279"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="745651279"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 12:57:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 12:57:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 12:57:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 12:57:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0mhRedkdZyvsO6j31ZU7qWfYvKnBqRypIQvJ/J3dJP6cUhHVS8ZCMe/bmb/bJeT/QF6o3MJkuovQk1etChsLYndhd1UlMbvBDWIA8flC56eLncBKAvSM75CcHTQOJJs9OOmf+dgLQKRcRMM9DRzOA6aYi7Wj7qtObNEpXj2RZX44mDZbeli7QBAUzU9rczIS6/Ck9FzUWl4dPC/4GKWF6cd709dFfad1lzQivDtr0aTjL86yhHM6DN+RszENxdBWpChDny/VXUiC4hJoBNWMdOSWDNa5Ax+5Zrj0VyEQUFj8Oz8KAYdgqmt2ryjLQUDQ2lrsmHd4GN5xha0JkiZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+GIhP361WYvL4uI5RPg6uzA64Rl7rXeMeQT4SR/o6M=;
 b=AEkwoW9IG/eKL1HOOaM+A+TS53ErMeUGN+ZWOE9oriMDYLvN5yjbMDiRJ79f4VK5GoNv8+hlGP+hqKB2e2ejqH21mw9fzX/2Qztn3hB5A7MsyIr+Ql9RiG3ZqlX39pjPqL4qYyPdmmqre/MUbWD8xAiSSB0R97jfaHLrqMjDTMccTT7CNdY/Kh6EZqG6e+WvRPxRsOo1z1WmFMvV38fSFuHDnhYKPHipvjrf5WIot+q35bknkWLgiDuaAgCHTKlI56c3xbHjgRMKpFXMnXmfQaT6mJbbWSLgoLUMC32fACf44mqusalYFZfQ3b8Hx1TKln8eCmper1cbGeWKfSJ9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 7 Mar
 2023 20:57:02 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:57:02 +0000
Message-ID: <dd764412-d600-7bfb-b596-e5c41c73bfd1@intel.com>
Date:   Tue, 7 Mar 2023 12:56:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dmaengine: idxd: Remove unnecessary aer.h include
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230307192655.874008-1-helgaas@kernel.org>
 <20230307192655.874008-3-helgaas@kernel.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230307192655.874008-3-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fa78d1-aab9-4cdd-bd19-08db1f4e7ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XN6BzAgl6R1rhsmD/RN40uhN75+QaekVHRts+hgg7Jz0zMXvYmzzbkE0/Z9Ihz+M4CET75Gq4yZOa6iK47VZIgNv0sZ8gIaSPqkzgWQ5FAoJRKOyPaewJvNjFq/Y7i1Ks9avSlnzVjmLgB867+5Ro28u3xuBi4UfEOJLJPo8hJYRVEYSAvDNcaqDA3GJiRaDAcybydvgM723l2QHQ5KvQ+MdvFocu6H8GF6fqgowM0HiXoggd8FFqVo6JruYqeftcmSBlX0OvaEyincJKIZjP8KrI7zY25e3Chn4/wxUOYVQKM0+Y4pisFasFfrXt0jb+M0Lr0w4yPd+CFt/2EVxfwYAitdIobh0luty7cB8a7Enf+u0IJZATVUA4H+Jju5WCCAJWv27J8G45xzidgZdgdxntL+ylKkcOYQtTBq6Z4ok6KedxCRNA57aIelUFB6WFa5UO+LoyYeD3bHi7cP/emK+vAY3idYgdU3nxkR7CtxE6qzY9o5Vl7EEAoLPKZNRGdbCVrD4AvTpSz6nM5/OXutUzDc0Fmfc8KVLOblioa3gPPBUGmttjdMSYn2/jwZKYBRzgpE0FYUw+Ul5dUawhuIu4qPs5qqaDzbkaS8vES/VlE2jjxgk1KFUYBm5udEmIv/rSEL/8V7QEg3POFguGUVi0i/S37dTkklCl+yYC6CNvFPgOoXN7p1YY3iL+XNeFXhjzoLhiQRqwr3q2ExnervGnhnRm7W23K5owWg3Vs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199018)(82960400001)(54906003)(36756003)(110136005)(316002)(6666004)(6506007)(107886003)(53546011)(2616005)(6486002)(186003)(2906002)(478600001)(26005)(41300700001)(6512007)(86362001)(44832011)(8676002)(31696002)(8936002)(5660300002)(38100700002)(66946007)(66556008)(4326008)(4744005)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9ySmlYWmdpdzJZK2s1U1luYTJpS1JSZktBbXhRT252ZHFJamltc3F6d2FE?=
 =?utf-8?B?YTBQMk5OZW8vL2hBajZzRTFYSlpwWTVqRnF4TWR0YTg1UEM5UVN4TVgxYUlM?=
 =?utf-8?B?TSt1QVIyU0ExbVp6OTNWV3FNdnMvc0hvN2RjZnhucXNodE9uejJFdmRxbGdC?=
 =?utf-8?B?b3FKb20wSnBTU2lwMlpadEhXZjVtQktseklRSi9oMTVxU0VWS21FVDVHaTNy?=
 =?utf-8?B?amxPNzVRa0h6VFpjZHU0a1d6WVBINFdmc3djQXFwdDVCNnNvSU92eVBoQjBT?=
 =?utf-8?B?Tms4cWphR3o3RDFWZjg1aXozSmJ5ZnRURDhNRGtzZGtSR2g4WGtVRlpScDQx?=
 =?utf-8?B?bzlsT2RJcy9YZDJwWTJXclpuQVJYU3gyTWJvck1kYzR6SzBqY0hOYkpwMS9H?=
 =?utf-8?B?UmhWbnlXaEdRUlhhTTl3RVhhQW9IQlprUFNrNUxmMGFuWGpBVno1Y2dGRlpZ?=
 =?utf-8?B?VzV6UEpOcGZrcEZ4MEJrUDR5OUcrdkhOeDY5TktJWkNnQTBCVTRnMFNFQUZR?=
 =?utf-8?B?aVV6ZE9IVGQ5RGlGTVJMOWFMV2J0TXBENFBXM05xcTJZdnpxZEZNL00xWHZZ?=
 =?utf-8?B?aVVGR29pSmJMcXAvdU1tekVDa05VRktpTkdBZTJZaHQzSGVtck8yc3VOMU9s?=
 =?utf-8?B?OW8zcDF5Y3FkNHpQelZLQzByWkVKVVdFc2ZGeTZJRmZJTDl1aUk0aGw4RklO?=
 =?utf-8?B?OHhKYzZGZzRUWVNuN21EZnQzdW5wS001Zm1wRDA5TkN6QU5Wd1pNektwNTg3?=
 =?utf-8?B?TkQyaTNva3V4MGxiVjYvN2c0S0Jsd016S01SaHU4YjBmZ243bkZaNkVlazJV?=
 =?utf-8?B?M1p3ZGFDdE9IYUNLTFZnUnVpdU5yNVlZOXk5RW5NVnJJOXlyMDlXR0FYcldl?=
 =?utf-8?B?ME80MnFNeW40dTNTeUJCN2lDZGNMMm1vSzI5ZkJ0bnFhb1RhSTJBcUhYVksr?=
 =?utf-8?B?OWV3OTJwYmd0YU9wdXJybkFIaitWRE9FWlplbitQU1J5THArN3ZWa0srWVh2?=
 =?utf-8?B?Qm96UytCcmZ6Wm1aVTZsSUs0cGxZSjJ6U3EyZnhZZzhMR0xLZmJSMHl3VEda?=
 =?utf-8?B?Njk1S0RDdkNCYXNxV1dYTms0K0xBK3ovdTdGOHMraVdVNEtIcnNpY2x1Vjd3?=
 =?utf-8?B?OGlCMW16WnMyb1RXU1U0ZHNvNzRzSjlCQTBxTUQ5cldzNTlYZFBBSS9jdVRh?=
 =?utf-8?B?UGp1SzdKcUJDRXpuTmFrRHFUUlNJZ1pLQ1FCSjd4bll1VmlJdHp1Q00rZWdl?=
 =?utf-8?B?M1JTSUtzRjg4aEZsN0xvNTlLRkRQTlJuaG1qVnJma0YzSjRJZzl3UnE2TmRr?=
 =?utf-8?B?eXF2Q1dRdXNBUG5wM1BBL2gxQUg1YnRidHJSVkh3YnFSNVFvd1d6ajc1QVEy?=
 =?utf-8?B?T0t4ZnZnamdDQXIwaHhuZnl2R3MvYVRzcVd4amsyb3drd2ZtODU0b3hJbUJs?=
 =?utf-8?B?ZzBTQXRGd0JPc3B5K3BxME45bWpYVEV0dC9CUmJ5WDI2cHhxUDJxNEp2cjZp?=
 =?utf-8?B?SURab0p1U2JnMGUrZ1R1dEdmYTBLT1M2SFdEcHo0Sm1FZDdtMks5UkNxNUtI?=
 =?utf-8?B?d0s0d1VxSUtwWkRGQi91MnFFOEN2WXd2eVVPaEFQajlHNWFCK1UyOWVGVk82?=
 =?utf-8?B?QUtCWGdzSGJGRzArUncvQXJiVGNSMThKL3JPYlJPUDZ6ZUk5WG11Umsram11?=
 =?utf-8?B?UEhWREo4WExKbVIvMWc0RTZCd29GZWVHSkkzWDNQVjFuTWl5YktoUHBoNzNv?=
 =?utf-8?B?VUwra0JVQkN2WlpHTWsvNDR5bWxaVFFMNGQvQ1hKRzkvd2Q5bXZqaG8yVDhT?=
 =?utf-8?B?Y2dvMEI2WTJhaGtYUU03Yml5S0pKTUptR1VVTkEzUG5QZXpuUnJiajQ3Q21j?=
 =?utf-8?B?QzF5ZjN4aVd4dUtVVlFCdmRTVEREL01DanlQUG5oWW9vVWlBb2lXWjRoVTU1?=
 =?utf-8?B?SEFXQlQ1ZXNWa0d5UmMxZmNKZDUvbDJvM2dOemIxbTQ4WnVoMzZmMnZVSUFs?=
 =?utf-8?B?VCtaMFdoaHlFcEo1bTlqSkFxaVc0MGk0WkpVQ1dsYUk3Z3p3bzNsWCtKelBU?=
 =?utf-8?B?bVlQZkhZK3JkT2UwL3BpODRGYXlMUURFQVFjUTFHeTNPR2QwWDdpWEw4c25u?=
 =?utf-8?Q?Ys8cbrj+wnsMy1qYjQYTlUFef?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fa78d1-aab9-4cdd-bd19-08db1f4e7ff0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:57:02.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKtKbHvcT6Kf9IqXn7JBYnbdICKoaT0crrW26jTN/H7n8jvrfx/V1qhHfB3ScKfF0ezbyue7CE733q6tF7pMNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/7/23 11:26, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
