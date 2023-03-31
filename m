Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8396D247F
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjCaP47 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCaP46 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:56:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275286E86;
        Fri, 31 Mar 2023 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680278218; x=1711814218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zxzQEwDlIn8VM2/sFnFkabHi5pkTYl8nnlTHImTuZX8=;
  b=ezm/qOkpNgeNBChB9pIlI3kZAdf0UlvzGZemtmO9qwkiKU1DDP8/aewu
   NO5HGLDgjJyU+fyM6mjdaupaxKdhs0oTwaXaxC8rwG6R6QsjOMMl/b7rL
   KBIG2mwlHJJb2sYenPKrMnIswYOdgCJ2u/2HZmiR8JmC9ieijLgdms6Ub
   SqKsMLhFFDeilHZ6YV5hNb23vQXsj0NEIWEzfhWbR9EFntgMCzQISI0SO
   TYwZiR05p0lVawvdjlq24+aIhomc4H+QerNHRjZYQEYpM0S0EwP4i9+7r
   eAxhhkiZ7wLi1ymtgsUGJ8wpDZfZExrtDqEAJjTvsnYFNkuMVGBh1KKIj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343151320"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343151320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="749689159"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="749689159"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 31 Mar 2023 08:56:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:56:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 08:56:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 08:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K53qqC6coOzjI6UC6VAFz2ayyFj2O4vlyqXAXcPZvFJhzH5I+LPkouUx5Eo2zTTihhOxhEQruVLzWK8eajWJ5iHvQwqPhQpilZ5b2aoNQhEa16tCuC2m5iqYsL48GNcrHUFs/NhXSIMa/bVAZahSCTmkJrNFXnSGimxtMctGPsryYX1DtqPNp8Dz1iXAkj4aKgDI5tP3U7Bp3zoIFUQWktPTadhgG6Tpo0UxExZty/AjN6Y4V0LwV5IpVrcwwm4Fp5znKVgM/LKyS4CWj8+FHLR0owHBkKMejnF1nmKyT5vDPeRmAcWF5JsXvK4tcKXfUlEZ1bCLXYXokHwoX9GrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FowUzTtR7nokAXyNFxVDbEWaZk7iqjkvO2RpPks2J/s=;
 b=GFMsNKmkprSzhkqhpTP/6awoy8wkmek9VhosinUdsJPEseJjl7Au+v1NTJhMY54MC3x0VxbX65jQOrE/ofHQAr86ko7O2CNfXt1048COUacVFGQ2IVZ51mzxFC2aoKbMkjfP4ZI8XiNr14dI0XvkEQNg9ENHqCmr8fxuW0edz4Wf93cOI7YwO8ZJqL169pV7ZctfoMd7aFISHx4RfefZmNcMrY8icMxkckZSZ64rlvFi+FZx8kk1QspOkFcfhshUT514FZTvhk8x5wXlRPvozssHjbjcY9FGQ5cyuWjB8wDA4qXONo97kPdNE9isdQrUMIoM4mIQEaAQToCXzlG19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) by
 MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 15:56:54 +0000
Received: from DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d]) by DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d%6]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 15:56:54 +0000
Message-ID: <497e281f-e2f8-ed95-1487-06bb983b31d9@intel.com>
Date:   Fri, 31 Mar 2023 08:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Expose IAA 2.0 device capabilities
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230303213732.3357494-1-fenghua.yu@intel.com>
 <ZCbKj7zyUXwpjctZ@matsya>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZCbKj7zyUXwpjctZ@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To DS7PR11MB6103.namprd11.prod.outlook.com
 (2603:10b6:8:84::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6103:EE_|MW4PR11MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f98a716-f8b1-4ec1-e702-08db32008cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nt2s3NVhNv/GeUFT0kQoLlUuPZ9KqKaq8xY3gJB23AM3cDj+9vynUDtpslwZz7bFK8FfhjBFfkQQ3puxtH9OiXdJGyLjWxIDvD4TiE6kHdrLTD/bVuValNC916JoIRHg0EomJAVlC1EqD3hNFDgxK0WHgOqu81MAA+4mioJvF+vJLj3uwI/pg5Lxz3/S537YaV3IBLdGBOiv8hlP1uqSOdgev82B+lnp2gyVkbwtQqD3RaWS37all7+zwqEgUnH4gK+HP3w1Qu6zFtRRZd41dodZmacL+2F4PL4ff8m9K0pr78ZohPn+w8okIrMads+pQoV6ocS+QmtP5YyKLfjH4+Zeiz6JO1Ny3Wbczr7XRyHuAx7mEqT4QhHvdznuZPj8WWHqPZ9pjbaNJjKTRsxGRmNLqrbrlNRIRdcTN1cREuhtK12tbxRxjMJVAnLgGU/0PwUyBgUNZNMHk2ChcB4Q0/pAZsqyGMA/xtNDVzfIjvB4seCQyvQ4QHsyBQMpHezLJgHJa2Tji/8jA7dptXfKYCtogWNh5WyvsgU58YiqNYxaZwjQ7pclVasefunMCfp0jCA8l/o10KtZglbD4mCEOfJ90odlODT1l6ndVeF9T27RRHKnuLdiUDzrlGDYqds5Apk6npJd3E4/NGPNWaHTOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(31686004)(186003)(6506007)(6666004)(6512007)(53546011)(8936002)(31696002)(86362001)(4744005)(5660300002)(44832011)(66476007)(478600001)(316002)(41300700001)(54906003)(2616005)(66946007)(26005)(66556008)(82960400001)(2906002)(36756003)(4326008)(38100700002)(6916009)(8676002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBBOHB6cG9zRXhWeFg0YTYxcDFlRHB1MDFGYnB0UmtJc0tYNFo2a0NHQ2pj?=
 =?utf-8?B?bDFwRWY4VVFWaXNaMm1rVDh4L1V2U2hCSHgvbnpSRTNSNjNVY0lYc1FSSWRW?=
 =?utf-8?B?Y1NldldiNDllWS9kMk9VZW9OR2t0WVFrZEltM2liNjlVeFQ1KzUrMXlUYkds?=
 =?utf-8?B?UTZJUDAxWmQ0T3A1NENDcmRLYWFQU25sNVprTWNvWU9Uc3I4VTFWUGRqbnkw?=
 =?utf-8?B?R1NtbE5MUnFtcnQwVmQ0RHJpM0l0THVJSGtPZlRmVWNwWjhXWTEreVJvdVFu?=
 =?utf-8?B?MGZkM0R4UGw2dHliWUpIcEFnZ1hETUphbS9Mb1dTNmRYQytYQ1lhVkZDa1Y0?=
 =?utf-8?B?Z3d5SjZYZjM1TDlrZis1NnFWZDJPSDljTnlMUU1KUFhURzVZT1lYTFBUL2Zo?=
 =?utf-8?B?b2YrNnIzNm82ZlpWVEM1Q0laQ25SYllrQVhqN0E3TE5qcGM1N21iNFZSWHdh?=
 =?utf-8?B?OGNHNU5Nb3dnaVo5RThrS0pxYzBNenJkWjZMTnVqYk56NDc0MW5tRk1RY0s4?=
 =?utf-8?B?dW9KSUVsajFCVG5WVVJTM1hxR0tidUlSNkxtT2dYYjlUN2YwYlVkSlpQMkRw?=
 =?utf-8?B?RFlVVUlpWEJ5MFVVb1dyQStzcFNDMmhQTmJPbE5DRFh3TzkvT0J5bTF0NXB5?=
 =?utf-8?B?aDk4cGlrdEx6WUQ3dDRaTkhtb2xuTEFjRGk4OWVIbDgrZGhqeENaSU4xUlFu?=
 =?utf-8?B?WXRMdjNBRnZGUE4xSldBSHBTZjdzOEg2U3Z3Ty9TLzdCOXVINjJFY3FKNzVF?=
 =?utf-8?B?UThlc2wxUG4zZnNrK1RLVWk4dVZ0RU8vc211Ujg1Y0psQi82N0VKd0ZjZ3Z2?=
 =?utf-8?B?ckEwd3NvVWVzTUNiWXRiU1k1NHZIajJvR3pMM0pEY0JuMmlpMW9lUXZoY1Rv?=
 =?utf-8?B?bUVndW5UekJ2bTkzT3FuNmRmaEVqTURnRVA1YzN6ODhWMTFFblV2UWpxT2Ev?=
 =?utf-8?B?RmhaaTFmMmdTaTJqMUl4YmhEMndEV2ZSK3paWGI2VG12U3k4b09NZVF6YnZD?=
 =?utf-8?B?QUdpSGR0ZXZHOGRiMjJzeGMzaTIzNGFCVDR6NzhTQ3M1dU1EL3RjTWpUd3ln?=
 =?utf-8?B?L3FHODZLMWdHMjN6OGhSUDFMRTlZSzBhWXBXT09kTnBSRTZla3dFYjRBVFg5?=
 =?utf-8?B?WWpwNi84U3pXeGpka3pIUDdlallTa0Y3cE9nMG9PaFZBQU5CK1FtOGJoNFdB?=
 =?utf-8?B?WFZZOXZwRllqcWs3dCtXWVg4VGZMbSt1cXpLa2crMkJMNGJWVmJQRThPRmhj?=
 =?utf-8?B?SnpRZk9XQUNJajR1c21DNUU4U2pjSWs2L2hiUFBsZWhPSlZCa3dZQ3BOQXZv?=
 =?utf-8?B?UndVKzRNNWM2VkdoejBxa2NVcExGdjRpQWFkdVIwdnpBOWlndnBQQ2dVeGFj?=
 =?utf-8?B?cGljaTkwYmhxS2RDYThPOVJlSkZZZU5veFNQVG1pN09lOUlUMjJFK1JMSGZD?=
 =?utf-8?B?U05hcFhEeHRUVytOL1M4TGZCaU1SU2ZUaURhNjE0cWJ5Y0U2bHgrYi8wbitI?=
 =?utf-8?B?cW8vYk5BT2haS0MxRUw1clJFVlFLbjdaVzNyRjJ6c3h6d09jdlpCaEZBUXhv?=
 =?utf-8?B?cXp4S0V0SXg0RERTT09rK2xKK00rbncrVGpmYStpSkZMZVd5VHUrU2N5M1Jp?=
 =?utf-8?B?SGtHSDVlcTNqbUVnVjVuNjNISVV1KzhoYlUweDc4WFQ5aTZCSERnQWZtb0xp?=
 =?utf-8?B?ZHRYSU1oNHYrMi93MXgzS1hpV3FHS2gyaGRvQlFGbjV5Yi8veU1NU0lZVzVi?=
 =?utf-8?B?dWlvWVZTUG5sVS96SkR3R1VFNWtreU9CK0VvMDZFS1ZlNmxhNUNGcHNoQS9i?=
 =?utf-8?B?cmRaVTVCaitaMVlCMzhVSENuaU9mRW95eVp1SnlCSzBxZkxiZGRGK2U4SGpF?=
 =?utf-8?B?Qk1NbWtGaXVQZyttWUZzOERTeXZVQ21RUkhjSzV5L2lsUVhJQnhJOWZwaFNx?=
 =?utf-8?B?aVF4WUFuZDZFTDRyUTUrSjlFN2picU5JdXNuakl4RVg2clBrT1VKeGQ5di9K?=
 =?utf-8?B?Ymh2akNSQVV6YWQzcE8rQlFEMEpiTWxvakpDZDFJVitVY29pMFM1NkZva1JO?=
 =?utf-8?B?MVVpZ1pjUzZxaWJ0RVpQSWJqdWt1Y0VTWkg2MVJ0QWcyb29OVGdoY1ZJdndY?=
 =?utf-8?Q?zlinyJFlYN4ibS+o8t1IRdVRg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f98a716-f8b1-4ec1-e702-08db32008cae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:56:54.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E0I3xqMCVnEWflksiWeZnNcTOabWjT/4ecu3bAzzv6mOCW+ezytP0XLPz0h+oWb4y8dzrDSK+uXND1HEA6KXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/31/23 04:57, Vinod Koul wrote:
> On 03-03-23, 13:37, Fenghua Yu wrote:
>> In-memory Analytics Accelerator (IAA) 2.0 [1] introduces General
>> Capabilities Register (GENCAP). Add a sysfs attribute to expose the
>> register to applications.
>>
>> This series is applied cleanly on top of DSA 2.0 Event Log and Completion
>> Record Faulting series:
>> https://lore.kernel.org/dmaengine/20230103163505.1569356-1-fenghua.yu@intel.com/T/#m13ba6167994f3add6446d2d7e242ecb637c54426
> 
> Applied, thanks
> 
Thank you, Vinod!

-Fenghua
