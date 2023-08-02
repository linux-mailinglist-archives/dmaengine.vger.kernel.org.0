Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AD76D1BD
	for <lists+dmaengine@lfdr.de>; Wed,  2 Aug 2023 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjHBPWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Aug 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjHBPWM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Aug 2023 11:22:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C73C05;
        Wed,  2 Aug 2023 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989530; x=1722525530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Y6vZdrpEuRqCGKT2qxnJbGiST+Vn8iwEdziufTppyU=;
  b=CqYvvO2u/werY7KCaPirwJaTYCftfIP5ukFxJEhj4J6dtYEw0qxfbF96
   BG61XwjZprSZpvljkn6mEUoaPTmr8Sw+62oBQVhF6AMDdzfV/Fdx3NNqA
   GHyV8p+BnTQHU5TDJ2xWFLeh9zS/CSbGViyKhBIdNEk7P47p50aoZpvUg
   MviiSaCvob2xqxM92gLf7sR1qX6HQkljBKXnkT9Lh3UZwBpztC50Mj4W7
   XBgRfcmyLIKw7BmBp5Tfa4rzZ5I3Rw6iHr3D29YZFO+2cDzI/WofPxDUY
   XaMoaIsZV/eW8IitFeec6OmCdIuVKA26VZWNtaoXWNcfMXH+7BunDQ3Ld
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433453837"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433453837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706211787"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="706211787"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 08:17:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:17:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:17:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 08:17:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 08:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZM99w5TYkcQQ+X/yXcIXfaAl7LASLbaoTi6Ww/vj56oGo7dMJSauG8St2s0FYWjDuvJoBQLKzSqqj0P/mBoiyuEyQ85esEcaO38g7MMV36/w22IEhXDztOitcDS3NPeJDLikbzDwi1qgDq9A9FOx0Jq8s0vIAZV+2wj2sxE5BwDZNShDGyOBspOUUhqcjqS9Y8UPO3E6Dg9UC7Jrbc8SZOPreePEguWS1rmMwq2ejwe4vkVoB6JrJfypOVm/K6hBMwjodADz9j5fZbzZ8kMwzuH+ML1P1QJpRtbD91rFwpI9013VCBdsVN7MOfU1w9lf/+TXCCm5Sn7xHB0V+1eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qnGuMmppvfMmd88X6IgfDbcW/XDUloaKZl0b7E8bw4=;
 b=HjBOuN6sBlzhmM9nnuztVEDYW7uFreA6+9iikK56XIyzlf9AuyJhcrP3XJVy3FH24AqL8a/QD5IPIzubM3pLevjJVlAQTF7yta02njot+VkuNLLxiTVhUq0E99cA1spVAq07tteCZrk2/uuMBbTFSRxbLDnyFNeZKZDYBjZARxUKTV+kAG0zOHU9bIKkmJxtsA39z9a8GZ6Os+MWJ5Qs1a/jT7H/uTu31VWEAH9jOCsA1dcOMBsNB0GeVKHA96JBMyTUTtNPDRb+AOQ3J8CHga+BH3C6D5GFDCqp+EMoZ6tHbrbPG37zvuIBanpEZOZiaFi430winqc9t14WOOawRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 2 Aug
 2023 15:17:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:17:44 +0000
Message-ID: <ee824cb3-ad6a-01d0-90a5-aebc9fb4b12e@intel.com>
Date:   Wed, 2 Aug 2023 08:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 01/14] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <vinodh.gopal@intel.com>,
        <giovanni.cabiddu@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: a421f279-9b3b-4550-26b3-08db936b9ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lncqw9moBw6Cb9JqNUF7tscGSTa/60+gIn/4s0mJbprEqvhuaXnSk8Bjj7AWRE9A8BGlYR2q1u+H+Ae6ncQogC0nSxSKHivs+juDD77ETpfUZKa9q/sMH8lKmJzlPLgqYX0oWpSf3MtFuOFne9FawsT1KGb6JOFvnaionTO56q3Yg0ohPZ0hcb/rHMEgHI+vzX2pabb1XV7xl7vk5YxmyX++7aXcpCzqqo4TSYkcqMK/mLKRLMUaq4lNZiiZKrfdcUaRMhbl5WivM5TcLX35jV5+0tSrWrtbwAOJGh6LVP5xJv1XTRzxNsudOIhDWLvzV91rHF41KeAlbmCcFIxW82IO3hxR6K6O5e5DDTzJgg96CmG5TGNLia11vNNPUNbPX/IdOq3BRutP2+U8v/hzTeeRZ15pY66pecVQU0L17ZjFqMTMUQBRUKhbKiuh1RZ8kEkMHy0Yah7WZF3wnTa38F3MFYvANwfn6KvCqxDQ5FCckunOz5BLTOGQ9InrxGmkDgQ3QrFeFxW5RKUXgNZ0RP1qBNzf/Jsrm74ebwCvfkkX6rngcFYnphbSC5sXfaU8ib3JmSSiYb6mOFyoFupyfIv3WJoFrJwT4Bw76ZrWvcQB/Jf+TdDWrShCOvtPJou8YShDYjvyzV5kt3sv6apRBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(44832011)(82960400001)(2906002)(2616005)(4744005)(6666004)(6486002)(53546011)(26005)(6512007)(86362001)(478600001)(38100700002)(5660300002)(41300700001)(66556008)(6506007)(66946007)(316002)(31696002)(31686004)(8936002)(36756003)(4326008)(8676002)(186003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpRNjlQVXIzK2RVREhrZExpZURPYS81cytYNG80OTI1TktNenpoUkFWelFw?=
 =?utf-8?B?RHMvVm9EalBiNlBZeE45dzk1Y2NuK1FLUFA3dnJsWnlvYmIxM3Z2WXJtUUlP?=
 =?utf-8?B?STdhcENFYWI1a1loMTdDRTloYnJ2TkZJMHBrRDV3UFlwK2lKcTVjOTRwWGhj?=
 =?utf-8?B?Y2w5Y2V2bW9HREtja3JaZ1dMSUtTY2VOZWFKbVlPQy9hUnlTeGdDZ3N3UXZH?=
 =?utf-8?B?R2ltcVIrYTBOT3RLc3FHUnR0dDdScXVEMkdXcFNUSWNYWkdiU3Y3ODY3VDRq?=
 =?utf-8?B?OXlKaXplaWRMYU8xTWZVallwN2ZPR05ZUWVLd3BaTkU1SUVkZVRUY2NuVE0w?=
 =?utf-8?B?bTNjNVVvNWdHTHMxbTNwa0dSNHo0S3ZYYUszSTl3eExYZGtLQTN4RUdQZDFl?=
 =?utf-8?B?NlVreWsrYVlyNGh2VG5DNUFBS1lXSVRBSGo4R2JOSnB1cVUwa2lOMTRlQk1s?=
 =?utf-8?B?Nll5dmhQU2lOdHZYZE5xb3FpWmhLMndjOWc2Q21tcWZHOENDT2JlNUtqb05D?=
 =?utf-8?B?OW5oYnppWXpQUXVyVDc4dGtUWkNRYlZoeS9EdlIzZW5CTEwyUFIyaUhQcGJU?=
 =?utf-8?B?YzBUbUhwR2cxVnRsOGVETS9zbHlHVDcxWEpxbTVkWTlDQlBmSGlLSDU5UU9P?=
 =?utf-8?B?aXk0WVdIK0lJY2xmYWlPQ0U3OHhwZ1ZtQWN5VGJ3OTRlZlh0TGIwYVVCeFpZ?=
 =?utf-8?B?d0dFUktvbHBZS2JpeDJBamRGZXpYSElNaW15RWR5K0JGMGM0cVFHVE53Ky92?=
 =?utf-8?B?QkkvZGp1R1g4ZXZSNFExMHVKWGUvZ3Y0Zmk5OVlObkpMNVpUVGpBMWZaZFIr?=
 =?utf-8?B?VGtzcm1qR2xlTlBTLzJrNTVnMHo0V0xoMjIwQWM5bVFhcGpTZWJKM1RyT2c0?=
 =?utf-8?B?MmtkVVY3UENTRVd2bUpSdjFYaHB6dU91am5CMXJXa1QwNXZPY2tPZm1CcVBl?=
 =?utf-8?B?MitMM0prcmgweFRoV3NNT1pTYWQxS3BMTTNaSUlZd2F0MzgzY3NUb3ZYVXBS?=
 =?utf-8?B?cnJWUXE3azJvQXV0T3BWaWV2cU03QXF6NUN2YU5TQW1KRmRhY093dVJJWGRr?=
 =?utf-8?B?OE5SbnVpcWN1VFVYYnFZajhlY2NIY1ExSnUzWmZ1MnJTd1FBVHJjMW40UjJ4?=
 =?utf-8?B?VWw2VWl6NjFDN3BLYWtRVFdDOWJHcjNPby9hWWc4cy9UNmFNK2xiVXJ6c1Nj?=
 =?utf-8?B?TTV6bUNMeHZodnUvQ1U4dWhQZUZtOHh0eU9qRjRKRWJhMUpyS1R0OUtsZnZT?=
 =?utf-8?B?ZXdBbHh6SVdhblBST1Bhb1ZYQlZLU1ArYUtNdVVoREZIbXVuelFWb0xLUjhS?=
 =?utf-8?B?bXQrUTQ2QW1GYzlKa1VvL2E5MmdSeTFrcTdHc3IrRVVvM3kvRWIrVXBHL1o2?=
 =?utf-8?B?VlVPS2NReDAvZURnWFdOTVp1MW5oYmthSmdjR3FHdjlWKzgycTMwVmU0K2o1?=
 =?utf-8?B?QVI5SHM2eldEanpmcXhNaHBVS3I0M0tLRlhrQUlJYXVpSlNXU2IrTkJac2Q4?=
 =?utf-8?B?blZ4TTFUaGlNaUdLcVdsaEhjZnZWQk5NdStSMHNCd3E4ZDNlMzV6OUs2Vjg2?=
 =?utf-8?B?MENKQUw2SlRWWTVKK3NLVEtqWVpaUEtOdjNDV2ZvZjBMdXcvRmtTcVBOYXNU?=
 =?utf-8?B?YU9aUHd3K1ZDakxmNmtZdUJ4TlorK1dmSmV2OGZpYkZhdGx1UWdYQ1hubVNF?=
 =?utf-8?B?Zi83R1UvWEJyKzhCQlJlOEQxNXlDVE9vcEZySStKaFltVkRGWjVidDVJZm1B?=
 =?utf-8?B?UlZuVTBLbWdHU0J1dWFGK1FLYnI5N2xkVk5pQktjeFRLNnIrekZWWW9IMnl3?=
 =?utf-8?B?YTBJVUhQeERJY2lBd1oyUmc1cWhkOHloYlhHWXBEREl6ZDJqNFpOb1pqek5q?=
 =?utf-8?B?YkFHVkVFOXdVT2tpMU1mVlFjcEloM05wSlJlYjFLSmhuMGZhVWdMTlBNN3A3?=
 =?utf-8?B?ekNwTEEwRmVWdGJQZ1NZRzhQeTFWTTVvTmtZd3NSWit4T0NVSkhwQno4eGVm?=
 =?utf-8?B?OXhWOVBoeXR2Y29hWUtIMkE0L0hhNG8zM2o0b09xNmcwZWhVaFpsbkdPRDdL?=
 =?utf-8?B?TDRaRWNJVzBXTHl6UFVON2ptaGpLUU84cklLRTJPYzRzQXUydWJqeDdnQUh2?=
 =?utf-8?Q?w5eU0vG9qD1hl5Fz6Ga/FNgWh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a421f279-9b3b-4550-26b3-08db936b9ecd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:17:44.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL/t1BY5YEfK92lDHm/5lEnvbK9zXQ5aG1WkwGoXlqDn/v+Wqlk/NnvKy4ojr4RGklExcatgmRl4FKdB8aQVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
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



On 7/31/23 14:29, Tom Zanussi wrote:
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

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
