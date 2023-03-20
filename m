Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283716C06D0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCTA0M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Mar 2023 20:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTA0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Mar 2023 20:26:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9EC93FC
        for <dmaengine@vger.kernel.org>; Sun, 19 Mar 2023 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679271970; x=1710807970;
  h=message-id:date:from:to:cc:subject:
   content-transfer-encoding:mime-version;
  bh=I7oM5e9+VgkiWdFso4nQEGGIrhPR4kJQ4k+1TFppqX4=;
  b=GMTZRlz8dhrI5ysZcZKqqjWN1tqkz6AI2w0Kttq9rXdWvikqKOZejdOC
   1JAde+0hkStVfoxwMIJwPdOnO5MeESouUHaF8tQ2VA52rwfD5KwDveySA
   oZPONXTmq6/UDwK+nakivS7enjaJjVTj6y1JrY9ts5/kwTdiclW9xC0j3
   hJcWrB3dHbvYoLkReWOrPBFeICTCWeukPLTQilEq4F03T+zt5GHt6IQuI
   wgYT4WRK5chXQ7MycppWLUIg8RF9/SnlaEQJA49ibZa2wC5TYOZrmekbc
   zlQg+8TgJec1X6vQAYVLIsY2WGyzs5xj8zdD6Wn1jB7Zar8wbHapOBU7c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="401127186"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="401127186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 17:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="711126319"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="711126319"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2023 17:26:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 17:26:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 17:26:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 19 Mar 2023 17:26:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 19 Mar 2023 17:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjDP/+uVx2ogBb12U6Og6yGOqK+/CQiDe1p536uxLRV8RFhhCkh8+w1ZBe9wFszSWsYeURhZrhuWygbnvLdKxKcybsu3Uom/kHGINj3cux/7SP6YGAf5dfI9lVlW5p2gzYqBCAAn2MqLBgsvTEbxJw7yjIfyuOOniuiHt2jZpH7vPivXnkeN9lZN4IhSrvWpmE+VngK47Ul0mRFpgQaTuP8iKfDSP4HQDLKldMks5tQ6IUJa4MDqETPslFjejAu0Mb8BjHtR//X5RKgUctjsvm3aAcWcRZkKTKS9ms4BVT2ljC9oJ7+2Bb3dXtIWvinT9zAsrjtiXTbqbqTKQTyA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7rPhzgIPZo/rl6TsE1W37oO2B0cFDIV5YitrCYAHjk=;
 b=HMXC4s6Zap+VbJ09d86O2sD/WVsUZDLZVLsA+tBmJzay0NYKkYsyVUNG8zjj8fa8FzNmehGH3aW49gh+H1fHpnhvW2JSSSgLUaAvgwZG17xPETgME0yYjj/Y5dJ6Ic6n4r/Ddj1NaH50Rd8dRzPOviGTN23twIn2jSKGpsmkO/AIpX0hHKXSWJ1S0Ife7AlO4lx6yGlxdqcpGON/EqDcLbLmrFrG6gT6gfJT0XWlm5cwaJTSkMM4LfmbsypZDrewhcJ0F4Svd1slZFUGTOQ2iAj3hVyOrwDbyNbpOKb3CyISU7OBTMr9rzO4YurY+AMzeLEilCBudBfkeWVtA2NVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 00:26:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 00:26:06 +0000
Message-ID: <88886677-838d-82a2-8f2c-429d38d1b958@intel.com>
Date:   Sun, 19 Mar 2023 17:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>
Subject: Three DSA/IAA patch sets for 6.4 inclusion
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: f078ec94-1d32-4198-d62d-08db28d9b211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkhiGu0wJ7YMdVs1Bv0AcdRMTw/EPvpfN32ItxpTuisSQVUmd9UDHFqCXCZOySIV/wf9yNcU7UBi8N3+/SzAuQX6oVccrcAN83ocjS1qWak0bEGZePrpIuoGqCKVsMZCN9Z0LRE3kKKpVlEg+fWd8y0srgJa5iwVmVcSZyJhcQ6FyNlqYAFqOSKZ3M+Kift86pwaXevjFPw1U8aS97mztI9zY0RLRDfWkqepAXwrLVNzPS6WUEgWRdKWg8XMn+4h3tqWXINtbom3pbggikLYYsVsG97ffp+wChSh/GQe7rhNH0muQ9+tDoC8Ryuqv2Z2rMD4p6yisjTfoVB34xR5pcrecEhP+tA7kIMekI1u1tMuDFVxtyYE8eg9mEpPkkJjxQC5buYl526b/6yub+qViS78R3cOac8Z4RW4C7BnNGXvcdTq9MO5Hj3BAMkB/wCdnBXTkU9JdzJGlO5oFdlUaM1v8m6RDmtGlj+1kyximaJurrOnUd72288pA4WwQWwgCtl0EQttIUL9ElsUiE4JUe99/S0pGgGtg2w15oin9nBPwEB/gynD1Gr0Qb1rOcjavUZD97SW++vjJAf5nuDozJTNY3j+fMJ2lsvF3tOJNvbva7o9j9AQvw9rGautaO35DZQDOQRuWsvGMjdXSqj0U4bzSg3WMKwjer04YQzMFJkM90mcBUyOgGgC2xtBWoUxK+jrFWVfJmPOleCzj1NlMZFD+rE0gugvcEaBZUMdYBtfkYvmdhZQwT+pBnMeuI3ddwt+FtpzqAcFEhT41IjY8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(31686004)(41300700001)(44832011)(5660300002)(4744005)(8936002)(2906002)(36756003)(31696002)(86362001)(82960400001)(38100700002)(478600001)(8676002)(6916009)(66556008)(66476007)(66946007)(966005)(6486002)(6666004)(6506007)(4326008)(83380400001)(316002)(26005)(186003)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJGaWZOOVY0RU5uYWhUZ0VlSytyUnJpSnc4ZlUyTkFJcE1pVU4vQktrTGRD?=
 =?utf-8?B?K1VKR3IvcElRQXpaMGFRTUF4L0U5WjJIMlVCL3JhN3d2UVJCYjJ2RWkrRHNq?=
 =?utf-8?B?NWl1WVY2RFZDa3p3Nmx0MlJvWHRuaVR5ekZtUXhSaWRrMCt2QW9yUHYvSWRQ?=
 =?utf-8?B?eks2UGlON0o3WkJwTkFqMEI0aTNOQ2hQL1haU1F1ZVZydFZrTGU1cDlBVXJa?=
 =?utf-8?B?T2NjTmdSemdUN2Q4Z0RhSEJ4NjhWQ3lLMmx2WnJIRHZPdUF1cjNTdmR6b3Y0?=
 =?utf-8?B?ejlMcjFaUlRCU1JFM1RubjRoZmRTcFJoazB0Q0xLTjFPOGo3ZG1hdWxjR2dv?=
 =?utf-8?B?USs1Nk1JQzBVWkFuY1FUdjJBelJNR3hSb0ZGOFQrcnhsUEF0bngvVm42bkFt?=
 =?utf-8?B?ZmhFTzJpUFFpQjNiWisxZ1VkQ04wcWsxSEEyM2ZpQXJ5NUNWdkI0Z2h5WW5R?=
 =?utf-8?B?SVZnM290SVJXWFlVVFZHVnBLUW5IOVN4ZUpKZVdzOEdCK2lUTWpGeVFtNFVW?=
 =?utf-8?B?Mkczc3BhMTdTOWd6SUNHZi90SlNyc2FrWE0xcWpBdlRtN2o5ZmVxNXNQd3Ay?=
 =?utf-8?B?QjlyOFpNMXpVVWswVjg5aVVaaGVaN1NHTElVMzF5ZjYxbHlteVJ3aDRoaFVL?=
 =?utf-8?B?aDlmak9ueXczeU85UnpzWU1yL2lyZVY0bDFTQjhXTGVkTkw2Vno2TlpNMk0z?=
 =?utf-8?B?R3o5VVRxSHY5M1BZck9EbEJ1WTdyb3hQcytTTDB0aHBkZnM1MnYyODI4a0VF?=
 =?utf-8?B?OFVzblcxWVRtQkRhWkhGVGFmR05UL3JrdE5KTmF6MVNmNWZkNVRERnFCcEdI?=
 =?utf-8?B?THZtbXBkWTRrT0dHSWtvYzRaMzRHWExMd0xZeE5mVlFJeTNNVUpjNkY0Qzl0?=
 =?utf-8?B?K1B1ZXpkNmxiVDNJb2kyYjc5NVptU1RWNHJuTGJZVkpXUlBZbGphV0J5YTZC?=
 =?utf-8?B?VnEwczNJZHAzNFNnOURIRUtWaG9ZZjRNbnEzOEZJTGVXYjROTW8xSGl6UHV6?=
 =?utf-8?B?ak9oWXVrdmErbTVTdVBmamNSbDlZUjUzMlRrUnQxTGs5OS9MOXlUZ1dlL1Qv?=
 =?utf-8?B?NFp2M0RKZnJOT09ha2t0VXQrejVESCtRd2pTdnlkeEJEV0tUS3BKV0tJdFVr?=
 =?utf-8?B?RDdvUG9JYS9RNE16a2pZMnVhNHptTUFYeWMraVFvaUxFTDIwblg4amRWZkpT?=
 =?utf-8?B?MEF4ZlJzalJ3VmpwRmpsa1E1U094ZmlvbmFKdmswcDdYUGlHNFVBY0FSNTF0?=
 =?utf-8?B?cEQ3bXI0RlU4SXEyTUJRbWtiblNkRFNrbXJSUGVWQ0Z0N01WVmRqQUs3N0g0?=
 =?utf-8?B?QUpvWmhDQmlSa0tpM25RWHJYd3o1OEpMWVFmWDNOY1BPRG1YWVJIQkxZbHBa?=
 =?utf-8?B?M2p1Vk5OaFM2cVlnU0ZVck9md0R0V2gvRlVuZHZ1Y2xBQktoOCs3Y251Q3pi?=
 =?utf-8?B?ZmdYREFMa0xmc1pJcDhLc0JValVMWk5oVTVTTXh4R1ZJR25OdFJRSVova3VH?=
 =?utf-8?B?WWRFalVMbkU2dUlxNUJVdlBvOEV6Q2JNSjBzdnFBZ0d4YU13dk9oam5mTjRM?=
 =?utf-8?B?dTlFbUpWclJpMVZBWGsrSEFwbUhzak9pMzQ5aHlQdFE0dUdXL0VvQWZwck00?=
 =?utf-8?B?VjVPaWs1NEE4TnhMaWxWenpxbklrZ1JwY0JVK1ViWWtyYkpkbExOMEtJak9M?=
 =?utf-8?B?Unc4UDByZ2N1VVRkVFhKTlFqK2FkazZ1cjdDYlJlV0lRUjU1SlViRzZkaWxN?=
 =?utf-8?B?UFBpMTZiR1BOc2tLa3FZSFN3ZU9wMEhCdGlxalgxRXQ3TUJIdW1tanRFVFRN?=
 =?utf-8?B?QWpqUWFZK0Q0OWhjV3N3bEtPNWVOZ2U5TVRXaXlqVTBOUVFEVy9ZMlAxNU12?=
 =?utf-8?B?UDZySHFKSUtNOHQzOTJxUGI0ZnhYOGxyaE5vcHBnT1hWQStOeXlKS1FlMC9i?=
 =?utf-8?B?bm9lZWpiVElCazJjZEwra3hWbVovTXlyNzBJaTYzbHZJRlpUOHV3cUdZMFFX?=
 =?utf-8?B?MENrSG1WRmpJbE5xaElyN3k2UTlYSS81MGYzUGE1cmpFazBwUE5HZHdBSzVO?=
 =?utf-8?B?bWVDenhac0dUZy9takplQ040UUM4dGxTeitteThQRFJQaUJLQXhRUUUwcGlk?=
 =?utf-8?Q?wrSYT9p4AW0eWac6WcN9xyANy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f078ec94-1d32-4198-d62d-08db28d9b211
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 00:26:06.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNL11hEY+iitpkU2C9W6TnaPz35IQ0YOmYk28E/HdlICtXbghty42peLc5sDjtgPLSYPSDQCUnHLuK1VSOrSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

Recently I sent three DSA/IAA patch sets for 6.4 cycle:

1. IAA 2.0 v2: 
https://lore.kernel.org/lkml/20230303213732.3357494-1-fenghua.yu@intel.com/
2. DSA new operations v2: 
https://lore.kernel.org/lkml/20230303213413.3357431-1-fenghua.yu@intel.com/
3. DSA 2.0 Event Log v3: 
https://lore.kernel.org/lkml/20230313170219.1956012-1-fenghua.yu@intel.com/

To apply cleanly, #3 needs to be applied on top of #1 due to a small 
conflict.

There hasn't been any comment on the patch sets yet for at least one week.

Any comment on the patch sets? Would you please pick them up?

Thank you very much in advance!

-Fenghua
