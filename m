Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC1604E7F
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJSRVl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJSRVj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 13:21:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE611703A;
        Wed, 19 Oct 2022 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200097; x=1697736097;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yvOdrtidjsVWdjNTUXTi9UwPSe1DVoJnN5CHeM3e0c=;
  b=QcmrnMPAVOJ9LZNc1vtyPdSHGRPGrbgFtxR+dXxv0K0xBTwlSbu/qoem
   WgwuS+wdJho5Ty6nm6Ynf5cAqlgMslf5xSWjlKLnsFDbkvMQyW42J7mxY
   9UUP0t2o3CwV0m6Pg7R+qYeH+XWlfEPf0aneJeA0kfTsuoPM/4QwlOCl5
   gyHUXpC3xkbe7HcdUNsn2whKUPffG27dgjtu1yRBrRolWoTTAMVxw/3HH
   kC3pKJNAUMrkEc05PxdcFBiq5jmSo9ZFTXyu59OLEVm6tG7TEGgNFHXR8
   UCB7DAK6vkAL/vhsEhR3pE/9vkNx/UnmhDffDI/DPxcqM3P8wb9I1mB9L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="392782264"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392782264"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607199430"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607199430"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 10:21:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:21:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 10:21:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 10:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX9F1+DOjwQP79grxLzu0MOmbcsMUeNHSsz2P4gygZ7Vhc78chKzc3T0PjHoSoZ9Hj6Dd6acXM4O3jEbnYNCAlb4VYpzVNETUT/XleT0n9epXARJrcgpOFukunZSc1BTD9TZ1MqzvaPZW4HWo5udDgcbOJOzZ+PTe05u2K/SYnRJTLtq2Zi/2IK5KaRkYIu7/xNZiIjVz3lbURXDaJuFqi5uOX9Xg5tzU8dv2TWhTYqayX664vcvYYefHUlPCH58svFvEWf58Ra6B0yl5XBtViTlumwyYpgcJTb27OG/ufxffaN8Y1PBk3sz//box+uH8ng9TUQJW91NjAJcsmeC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9olobFUpLpROYdi7+d/QUAz143NGYIZAhzKXf42o8IY=;
 b=l9prId4v8gsnRmUFzTmWpt6D6BYS/ru2+knJOys0r+1Nk+V+CchlpbPVNnEjMEyhSbLJETxD9IZwDnl/2HLBi4kBkWvmO0P4R7d5Vv3Nh25VoI/w1yvTWhgvVrMAIh/o7m1PmcDYaCQY8crtbvN5yqqBYkpjFqN7Z1ZoKi8AvAVx0K/DaUavC5CYNOeWpQWFq6o7Tnhd6qq1GR//eI/OAdnz6lhfrAOXeMIhMaUvGvzs0CJjRG6H4c+jLBrr0rylfY9nNdvzx+RQWLSXEinIC57htIQljy29N0dWNR1tw/EipBKp2QMeXTF52uo04Wsulfu4CeB54+5wp5PUzX2m+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 17:21:21 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 17:21:21 +0000
Message-ID: <297dff63-e199-d14b-7148-916888030740@intel.com>
Date:   Wed, 19 Oct 2022 10:21:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/7] dmaengine: Add provider documentation on cookie
 assignment
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-5-benjamin.walker@intel.com> <Y1Am/RpgWv3PAVaU@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <Y1Am/RpgWv3PAVaU@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2824:EE_|PH0PR11MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf86be4-1ccc-4e1c-e0dc-08dab1f65770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTWHlw6vulilRS3zOnE0Dj0EygxfKWbrYKtX/7AbXpoOZPWYA1fYOOSTOVxGLHTNfDKeryGVLtmxNWZBDvt2QK5PBbogOrTRpYj+GWLJjL64qGlgLDLZebbQj6udu0X+0vMnhko/KGvAPmiZu7zJGOvOm53Cr3e/uwTWTDLs6/K5aV6DkyB9IDML0L4dvPrYN8RmOFRSZtjIqj/+3znCpTeNVj4Pek0D/0V3i8V10325AnxCLKrnzpqpcD4bz8Ptvk52aQFHdRzt10smf/6g6965dE437FeuWI4pieO+ycuhHW6WSu1J3Xv5xGZjmQzhHHgt8K938RWTsVXq/CRVgxNR+nHgrCuAbBS4jwtAopvg0m+abhSn8o6wMrbb0k7TJyFjQWZ/VjzsNUYPOqB8yLX35bo2wverc5Vku8EaMxJCWp7rOq0JpC6K0pXmFRK7i9sn572maiO2u2zWi14rGcCJVUshPmHR94BCItv5GPPY7JnRe1cFwSIGoR9YEC2SKchHB/KJ2WLuKhhQqUxpsPLzeW7g8+3nxTxPM7qmbtJI7ykn+o6MYwXhnyUKJwQcYdEna0qlqW1AipMSJSAXNliXW6C8YcNR8aSxA3PIx2T+y03bWRSq5dyTiJD3moyQCwKEoTUHIiwuTdoS8WH3+ryDCSThHvYhWVEnVS37/haKmSXIiGS+o1xDmBg9iKigzDOqziOzG7pINMvvf7/zaCBkU9prnuwCcxM28sTlyFOlptq90UgxEPFXlEy/RzCXnSbPOxLC/3I7bjayTfnYmofSSl2FZtzHQF5YZaL6XBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(6916009)(186003)(2616005)(83380400001)(26005)(31696002)(86362001)(82960400001)(5660300002)(2906002)(38100700002)(8936002)(4326008)(8676002)(478600001)(6486002)(6506007)(53546011)(316002)(41300700001)(66946007)(66476007)(6512007)(66556008)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpKRHVLWHluWjVZTTFGMExJYUsybkhVZjBIUEplRU1PY0hnUUdRN2ZZeFJS?=
 =?utf-8?B?ekxSdkkvSkx0bXlkWk9aSi9DNmZ4dnM3UmJsMjRTSG1XSkx2L3AzVFR3WEJ6?=
 =?utf-8?B?N3NMemg3WjJxSnowcnFqNDZFT0ZmRVAvaThDU3VZTWFsZHIxdy9nVm50Q3Z3?=
 =?utf-8?B?VjJpTDJqSTVGRlFkOGZSY3ZObXBJWWZtNThtZ2pPd0s2QVRjcHdtU1JtbitV?=
 =?utf-8?B?bCtyMS9zNFVnZHFRZCtoRjhnUDd1K1dmY2pxVVBkRnV5KzdzdUhOUjRGekQw?=
 =?utf-8?B?aEtyK0xadjIvcmcya3FTVnU5T1hBazE1V2pDVGY5MDFRN2lYNHBnenZwZGdP?=
 =?utf-8?B?clZoblFrcmtsRzVVVjFjczBwcFVuL1BzL2xjOXhEZTBaRUhXRlZnNStIOUxr?=
 =?utf-8?B?RU5Lb1EyN3ZwcjNsSkhIcTZjMThzRUdsQlBHcTUzQ2t2a3JNN0ZqR2NPQjQ1?=
 =?utf-8?B?cTJadzlvbmJjR0YvQmVmUG1JWFdxaVdXUUQzSkRxUWNBemFPRTlNeEw2NGRZ?=
 =?utf-8?B?dDV2NFZoWG1EV2xYNE5jazhqenhVMWo2bFF0bmdCMTc4QWIrakZiWVlaSmc3?=
 =?utf-8?B?dmM0SEg1TkZZZDdVMTY5eUYyWFZJUlhUcmtOMHE0QjFXMVdYZGgwNDZJSXRx?=
 =?utf-8?B?Wm9XbDA3K2pSanNGWkZDUnhpSUgxcDFINGVrZ0l2OE9LSllHUkVqdkhWYnBF?=
 =?utf-8?B?TVBaUzlpWGJhUkwwTjhuSVdmejNJTlRjV2wxUE03aUN2Z2FEUUJJM1R2Mzdh?=
 =?utf-8?B?Rm1RckcwVnJZREp4Q0FaM3dtaHFCaWFCN01Hc2NlTlVPQk1GQ3hOTnhjayta?=
 =?utf-8?B?ZjVzZ1hHWUdVU1oxM3JtQXhqSVhKSTdnbzJIeVc1eStCY1gra0YyQ1BTdGRS?=
 =?utf-8?B?UGMrVHVWMDl6RUJhS3FBQmtGT0xwT3JUMDRXbGNWdWJxd0hGK201cnpzSkFs?=
 =?utf-8?B?ZCt5bUJyVnpqZ3p0aDM0WXVlK3BnNEdwaGN4RlZGVGh2cDlZTlhxWS9seTZy?=
 =?utf-8?B?VlBuYm9nVlNjc1BHRGFKa3Fjei9uOW9zMVVzZzdZeEdQRG40RlIxUy9BUlA3?=
 =?utf-8?B?WWtLRE9tNnhPR0hpL21WYkJkbisvU2dERnEzYWkrOERRSktVYmgvQ0JLS2Ni?=
 =?utf-8?B?MnBSVWFEOUFaVEtPc0tRYWRtUUtNUGlLWnVrcXM3eG0vOHVDSy9VRXZpWFBk?=
 =?utf-8?B?WkFTbUprdHJnTjBHZ1dNSXBxL2RnUWszVHliWnk1azIrMkJwZk1aZy9ONW9n?=
 =?utf-8?B?bWFxd21STjVKZnZKVmZpbEh2Yk10ZVc4YVk5eUtuQnRvaDRJV1Y2WUdsQjBT?=
 =?utf-8?B?ODQzQS9wSS8valpOeURKVG9udjhLeFEwcE44Tk9JbEM4T2tCM1lYZE1JT3Nj?=
 =?utf-8?B?TU0zZEx5Ull6eVpDcHF5eGN2YVpJUm1nZkM5aGt4VTRJOVJPTHQyOXAxUkNG?=
 =?utf-8?B?UFBnV1MwYlViT3JqeDEyUmdQVURpOFRQMlFDSGo2dkJlQ0EzbnlhZml3YlZw?=
 =?utf-8?B?RHNZNmd2V2l0MFphL0I4dmlLVDVSazBKSDNudkdCc25ZU2JyTzZjMjFoQ0c2?=
 =?utf-8?B?NkRGUGhyczZQcDlwdEpSeVFpb3FHK1VJa3B4T21Wd2tSY2JVNFpNQ3hGcmha?=
 =?utf-8?B?Rm41eldzeWVDdFRSUk4xNDBid2pGR2UvZWpxcXk4dGdCYnRRYjluREVsVERi?=
 =?utf-8?B?TE5SblVMOHE0REt5NEJ5UUp6eUVraXdKM1RIOEY4NEhsS0ZJM2RWamlUZlF4?=
 =?utf-8?B?UzRiLzFSVGdHdFpSVFhGV0ltanVlYU9zSzVxMjBXRHQxWjlDV3BjdDd0dVZD?=
 =?utf-8?B?cHFqY3U1MjYxQmxjemVYWlBLMTBSMXdmOUNGNzdES0Z3VHU1TFJ4N2FleE1B?=
 =?utf-8?B?UHdUTmtkZ0hoTWxrZnVaR1AzRnlEcjhSckVHb2ZFRzRyejhlaDVjM3BvQk9Z?=
 =?utf-8?B?VXpNenBhZklta1VKU2pQeW9zeWc5aVdFYkpPODc4d2RXeFRCYkZ2VkhYZ0Iw?=
 =?utf-8?B?WTNjMDk5Z3k4b1RvNFZCNWJVSFVOLzViMkVtdE9XTjU5R3VPRkRsMlBXd0JK?=
 =?utf-8?B?dStuN0xOVE9MdVg0MksxZXNWdlI5bU9pMlVKcFlOVmlXaHhJY1BnaUxsbXJn?=
 =?utf-8?B?c0gya2NFTHpSQmZUZFl0b3Z3cnJmUExDaXRXdGJLREhQWXg1Ti9YaTJrYWVo?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf86be4-1ccc-4e1c-e0dc-08dab1f65770
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 17:21:21.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZG8xwIDMwzHqP64iMaWncd5VbzrH2P+jl5z5OgDk/jpw7k/x/NF6xlbwcI1hfzSn4gU2bZwOuJNUV89PCJ0cUbgk2dmPd/IPBJTE3cTH5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/19/2022 9:34 AM, Vinod Koul wrote:
> On 29-08-22, 13:35, Ben Walker wrote:
>> Clarify the rules on assigning cookies to DMA transactions.
>>
>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>> ---
>>   .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>> index 1d0da2777921d..a5539f816d125 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -417,7 +417,9 @@ supported.
>>   
>>       - tx_submit: A pointer to a function you have to implement,
>>         that is supposed to push the current transaction descriptor to a
>> -      pending queue, waiting for issue_pending to be called.
>> +      pending queue, waiting for issue_pending to be called. Each
>> +      descriptor is given a cookie to identify it. See the section
>> +      "Cookie Management" below.
>>   
>>     - In this structure the function pointer callback_result can be
>>       initialized in order for the submitter to be notified that a
>> @@ -522,6 +524,40 @@ supported.
>>   
>>     - May sleep.
>>   
>> +Cookie Management
>> +------------------
>> +
>> +When a transaction is queued for submission via tx_submit(), the provider
>> +must assign that transaction a cookie (dma_cookie_t) to uniquely identify it.
>> +The provider is allowed to perform this assignment however it wants, but for
> 
> We assumes that we have monotonically increasing cookie and
> if cookie 10 is marked complete cookie 8 is assumed complete too...

That's exactly what this patch series is changing. The earlier patches 
make changes to no longer report to the client the "last" or "used" 
cookie (to compare against) in the client APIs, and it turns out that 
nothing in the kernel actually cares about this behavior. So it's simply 
a documentation change to indicate that the client no longer has any 
visibility into the cookie behavior.

Immediately below here the documentation then says that there's some 
convenience functions that providers can use that do produce 
monotonically increasing cookies. These are now optional for providers 
to use, if they find them useful, rather than the required way to manage 
the cookies.

> 
> Completion is always in order unless we specify DMA_COMPLETION_NO_ORDER

The final patch in this series eliminates DMA_COMPLETION_NO_ORDER 
entirely. It was only used by the IDXD driver, and the reason I'm doing 
these patches is so that we can poll the IDXD driver for completions 
even though it can complete out of order.

> 
>> +convenience the following utility functions are available to create
>> +monotonically increasing cookies
>> +
>> +  .. code-block:: c
>> +
>> +    void dma_cookie_init(struct dma_chan *chan);
>> +
>> +  Called once at channel creation
>> +
>> +  .. code-block:: c
>> +
>> +    dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx);
>> +
>> +  Assign a cookie to the given descriptor
>> +
>> +  .. code-block:: c
>> +
>> +    void dma_cookie_complete(struct dma_async_tx_descriptor *tx);
>> +
>> +  Mark the descriptor as complete and invalidate the cookie
>> +
>> +  .. code-block:: c
>> +
>> +    enum dma_status dma_cookie_status(struct dma_chan *chan,
>> +      dma_cookie_t cookie, struct dma_tx_state *state);
>> +
>> +  Report the status of the cookie and filling in state, if not NULL.
>> +
>>   
>>   Misc notes
>>   ==========
>> @@ -537,13 +573,6 @@ where to put them)
>>   - Makes sure that dependent operations are run before marking it
>>     as complete.
>>   
>> -dma_cookie_t
>> -
>> -- it's a DMA transaction ID.
>> -
>> -- The value can be chosen by the provider, or use the helper APIs
>> -  such as dma_cookie_assign() and dma_cookie_complete().
>> -
>>   DMA_CTRL_ACK
>>   
>>   - If clear, the descriptor cannot be reused by provider until the
>> -- 
>> 2.37.1
> 

