Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126A607D95
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUReE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Oct 2022 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJUReB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Oct 2022 13:34:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC79263951;
        Fri, 21 Oct 2022 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666373640; x=1697909640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Yk4G74KAy8BRpgqm/QcpsBGHm9XsCeE6fsG2TpQF2s=;
  b=mFzYr8rO4O6+VGMDLsCN+gNDCW5rcT718BHK6XUputB94WJUm+F/8Huf
   yOB6U/H2dcifAsvWOA//5VR3iEpWCUEdJaGO5aW618aYAcpKCb24U81I1
   gP97TsySpqHLshd94zICpnWcjIdTLSgvGmaGK7A8TuO/zRXPrRvT6Rj2V
   uhFvpYeRFOacYJb7diJ3GzCADglpKCTyjBDPRTpZalW7HhJu/4YerztKp
   gh0DVGQiQVYSYknKDQexk0wpZL8mZm/LhHVuOEDhvd7ZpAg+uEMZ/OEd9
   no6LiKfxQBhWrUA6MZ6gqH+VIZStAJU6pfyilqJUx3LqtOJ1ZylxWo4JK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="294459349"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="294459349"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959728395"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="959728395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2022 10:33:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:33:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 10:33:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 10:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbPcN9wtJ5LVLWFYXz4jqyCVbuMeKp5IkvY0gVOfdmGVQC0DwEFGwWR01wFMYJmTnK8yOYxIyph+AeiecH/PA6wQPCEr4MLQVuKh+7O5mnU/Zjf2K/759dqJP3m+7zLP+LV1i+IuxdNZd6q2OfrO2dnYWx2b4w8JQyv19W/u+foH7L2OpKzKLji2sGsXSYrANBaK+CSLS/BKYCk1mhf2kR9bsHqk/29rR0xwD0zrLVw7W8xgIjnDYT5AQQQ0LTfUJIphwTTHQu1DczJ4goPZ7rxb3GOoMVKwwepSUT1TFq/L1HuknZP6OR6bWM2Ulreqo83gsRfkKThwxsQoqAVz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEE2mtEbyh2JzRWMv2xI5mQOWbih11Nv37KwZ4TIMJo=;
 b=KqCLct4awrUaeguggxJP1UDgDddlfK4H/8/J0zcoJI0crF/qupiosIXEdNSyzenIvEeAUchp7o5me2ncQf0/b0LY6Y0BZfvv57a670aA9Hyt4iSTEdL6QTHk2kvYpS/pXRuHzfPU5eKfyo/+Rfzz3yneJjlcSXs+YW8uwjxFbxwyYouy5thPWT5bT/bkQGRTuApQ9JXi2Y0ymZvyDyn0XdPzAyiu9YPvO9odqz2TR2Eka9majGsv/P0aaRrEsaRmkBq8HYMf7yKRkcZNrf4Alad8DksZz4+tx30mE43Xlrht7blTbQ2zLiv0Xac224Hh8zUCjJ6T7hQVW4A6ns9SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 17:33:57 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 17:33:57 +0000
Message-ID: <14399464-919f-3834-5dea-e3b80635f0e0@intel.com>
Date:   Fri, 21 Oct 2022 10:33:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.1
Subject: Re: [PATCH v5 4/7] dmaengine: Add provider documentation on cookie
 assignment
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-5-benjamin.walker@intel.com> <Y1Am/RpgWv3PAVaU@matsya>
 <297dff63-e199-d14b-7148-916888030740@intel.com> <Y1DKpnOdP5MbSGeO@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <Y1DKpnOdP5MbSGeO@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2824:EE_|SJ0PR11MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb61fbd-9bda-4f39-ffb3-08dab38a6eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VA1an6LmJaKeu+bCYgBXNLRJBwYZ6gO/c46k89oxfHwsedrh5Z3z2DTbUdb+3VoUN2lkypQCGGNdROdLkAIw+7/2XpoJ3zW8cpJhoJ5oax2IBXMNM7AFksVAxmLrOlg/isr/Ol32vC+cMbgX4Lusx5LlenfMBNyBAP2BUuC5hEsTWzhQbTbAzG72LfvBHdJHtd6eYVBHAgbDXrz2Z0w5bAgPyBDo5+EaxJNldZGncY9lWa5YCZ56AmLvfhaSi5fnVe3rs4g7Sw0yYJksKms2bLeRV+H7pHl9xaNoa3tz4rLK6nfE2qg5bzjSsqtbV3CN7j+vhzdbh9Ks5RLcRlpwtwp3zziTtUV4w0sVFrc9hF9ECcTq5T9ySjCiu97E9IH59LLOFck0vW8Lnb8ZwHlr8SSvybGidi3GDaAh01HoFfDB2+4UXGjnGt//GXsAzK/9g5on4IvCma18oEVNLyOHN8Bqz0ZG4yQHI4YIEHIZ5yWoWrnz026CkCg+eg0o/w7dSnxAhO7klIrbnpIiW+VOtPz3OThNft2H8mgUFyK6PORpz3hzK/B3/pK7oPW4rDtaIbLIurIsrPHMCI+tohxXcR12HlCQoBlBsAYtYLjV7mzDznjJG6IIP/5sXfmrv4sh5z3RklYP8Gv6t/9Dk3zUCh25Awq3MicDIWd7P8nSJnuLtHxTj8Ef7+rNbUE/z4g0EFn9cBQnN4WQZWAalt0kOVdRWZIT06JOMxju2sSW8J6efebMHEg7TrZiw907zSa/PQVT0DD1g0f3EeU9FyMnVW89ICIhvd+mZaEhHdba0FI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(82960400001)(6486002)(478600001)(4326008)(38100700002)(31686004)(83380400001)(8936002)(316002)(6512007)(31696002)(6916009)(41300700001)(53546011)(6506007)(36756003)(66556008)(2906002)(186003)(8676002)(2616005)(6666004)(66946007)(5660300002)(66476007)(86362001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEM1dFZxS0hrdDJEZTZFdmtUTU5MSVgxaGp2YnN0VHAzdnpYNmtDZWRDMjJl?=
 =?utf-8?B?QmQvaGFyS1JINXVXYmhtbkxVMTRuS2dLWEdiWVJMbEU3KzI2aXRuT25PQnlj?=
 =?utf-8?B?emJnaVFKajlNREZwMXZLblBsNGhSeE9HM0UvTzc3b2U4WGdjdFJEQ3N5c0xj?=
 =?utf-8?B?b0FYdDJEcjgwWjBremxya3VrTE1OMWtremRpdzRSZHJodnhTb1N1bVIrUHgv?=
 =?utf-8?B?NDdKR3RuNk1yUXQ0R25TYXNwR1lMYUFVSnFiYmN1K0FVWnJFZ2lMY1NhaEQ4?=
 =?utf-8?B?U25VVStUQ1VUcnNGcCs2dWIyZXRtSFcwNHJQcldLQjlYTFFEa1VFbVNWTkEr?=
 =?utf-8?B?REoxenBDTjlwZzdJNDM3RElmUmRiTDZkWXFsUk8zRGFvSlpONSs3a2Q5QjY5?=
 =?utf-8?B?S21LU2RrU002M3hKN1RpV0xGMEJjbDRKY1l3Z3RNVHFWbG5HMGdFdEN3ZGhJ?=
 =?utf-8?B?alhJUkNheWZxZ3N5UVg0UkZyeUFpSkZVNUJ5eUpUeEVxOTk3a2RVUEJMZlZE?=
 =?utf-8?B?elo0bGlPVTlleWx3OUg4OTlTSmx5WTB4OEFBdDUrRnd3R05ML0d0SlpWTm14?=
 =?utf-8?B?SkdvK3FwQnZ1Wm5QM1RGdGRyQ29XRC9HNE1wVUhYT3lVREVndWJnUHFKa0Vl?=
 =?utf-8?B?bnMxSVZHWWI5amVoakRwTmJTemkreDVSNVlNN1Z4Yksram9oRVptZlZaalJn?=
 =?utf-8?B?TzRxUlR5MXhnREQxVzQ1dzAvcUhMS3ppcG5PZExyL0dlc1hKQlhrK0t6Qmpx?=
 =?utf-8?B?WHRneS9XOWZiMUpiZjNrWm00MFMwZjljekdja1hKMVBuaHltdGVXcWVUK0pJ?=
 =?utf-8?B?RTRxclB0WlFTT0hJbTkyaVBPSm1RMnhCeFpFL2tmd1RQd01IU3RERkV2VWpz?=
 =?utf-8?B?NnRzNThUSm5KeXJCRjBVUyswb0hPU0RCek5tMEpxM2g1Z0UvRXhjWllybnFk?=
 =?utf-8?B?aW5UaVQ3R0xZc1ZBVHJvUkdNTmhXRTZxVkhjV3RLbDlJR0lCeDRvV3pkQjRJ?=
 =?utf-8?B?OFZDcVRsTXZEdlYxUTdoRlFydWs3VW9OZ1NKcjdXVnVRa1pvek9RQVR2RU93?=
 =?utf-8?B?SGF1VzRVYUVmZjllNjNUZFZQZ25SU2hkbHNaODZSdFdFWDBCVVhrZnFIVjYx?=
 =?utf-8?B?aTkrRVF2dGNrQS9tNWt6RCtSMXVkM3NJTERRZmNPdHFDZDdhU2ZQTTRhMUZP?=
 =?utf-8?B?RVZCT3dCSUtDM3BOejNaOVRSalpVWHBMSVNOempzcmxxL1hLVVlMWkJpSDg0?=
 =?utf-8?B?aC85VVRpMkVqUEUrelhZbk5sSjVwUGdTTHM1Z2UrV081cE5NeW9KVmJZbm90?=
 =?utf-8?B?YTZWU1lXaEd2NmE4M0VFWkFWU3Izd2wwRVlEd2g5UEFuczlQVVVrWmU4NlpX?=
 =?utf-8?B?UEdXN0xQTm8rZFQyTE9sU0N0TEpNcmd4cm1sSVZUZVNDQW5DbkhFL1U2OHBx?=
 =?utf-8?B?d0NyMytSQTZhUWpyUXhxMGpDTkhMeFAyUEk5ak9LYWRTVnQxTXlGMThhdks5?=
 =?utf-8?B?RWFmT1dHTnNML0xUcmo3RXlCbFFCTXBkMjNKcHV2dGNDams4ODQvdC9BbkU0?=
 =?utf-8?B?ai9xVDd6MmRWdG9UNHIzdmRaRXY2NDllSTdGTFRFMzVTdW9oRnU2b0tlNjdL?=
 =?utf-8?B?Tks3bmFFdXhiY1U5MkE1NkdYTHFpbDhoQnA2RWhMTnhzWkpCU1hHeDR2bmtN?=
 =?utf-8?B?SGRhbmh6VDI0bUxpWWFjOEU4b2Qrb2M3Uk9OVUxUVUFndGNVYnZzWkhPOGdV?=
 =?utf-8?B?Yk54NGN5OEFWdlZyOEVUcDVCYUxnNlExRXNOK09LWk0rdEg2aGFxaTM4a3pR?=
 =?utf-8?B?K1MwQXI2Tk5lT0JXOERVUnIyTnNrcVBRdUF0WmpmZTQ2ZTh3S1B3RmpYSEVM?=
 =?utf-8?B?bWZ0OGh5WlcxdEJuVldpQmUwYWg1c3p4ZHBzakE2TWlUN1dlKzdXYUJQaDh0?=
 =?utf-8?B?Z21kQm9DRXI2RjZnN0Y2SytTYnltS1pIQmVxYlBCdS94Yk1Eaks0MmRHUWh4?=
 =?utf-8?B?YmhHaXk5TmIwYmtYWnB2QUtXVE1CYVpCV3R6STdhckQrelZRM21QWHNzSHQw?=
 =?utf-8?B?ZDNSVDBSZWMzeVk0amYwUSs1bVNJYzg2QlNXZTdlaUNJVU9GcDRXZ0VyWkxW?=
 =?utf-8?B?WWc4c2RnY2creFA4dFQ3K2FmUkx2RlBtQUtPUWhvdGY4OUZydGRIUWYyZkhE?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb61fbd-9bda-4f39-ffb3-08dab38a6eb7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:33:57.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb68QDNRIeZiIRBZnitKMqxBErO1SNz82EWPBQSMRa1wlgnX8l8o3C4aLKGFNNesIfXnvCgiJwgZZ8lY23+8M0CFpZ39NBE1MXXfJfgUOZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/19/2022 9:12 PM, Vinod Koul wrote:
> On 19-10-22, 10:21, Walker, Benjamin wrote:
>> On 10/19/2022 9:34 AM, Vinod Koul wrote:
>>> On 29-08-22, 13:35, Ben Walker wrote:
>>>> Clarify the rules on assigning cookies to DMA transactions.
>>>>
>>>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>>>> ---
>>>>    .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
>>>>    1 file changed, 37 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>>>> index 1d0da2777921d..a5539f816d125 100644
>>>> --- a/Documentation/driver-api/dmaengine/provider.rst
>>>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>>>> @@ -417,7 +417,9 @@ supported.
>>>>        - tx_submit: A pointer to a function you have to implement,
>>>>          that is supposed to push the current transaction descriptor to a
>>>> -      pending queue, waiting for issue_pending to be called.
>>>> +      pending queue, waiting for issue_pending to be called. Each
>>>> +      descriptor is given a cookie to identify it. See the section
>>>> +      "Cookie Management" below.
>>>>      - In this structure the function pointer callback_result can be
>>>>        initialized in order for the submitter to be notified that a
>>>> @@ -522,6 +524,40 @@ supported.
>>>>      - May sleep.
>>>> +Cookie Management
>>>> +------------------
>>>> +
>>>> +When a transaction is queued for submission via tx_submit(), the provider
>>>> +must assign that transaction a cookie (dma_cookie_t) to uniquely identify it.
>>>> +The provider is allowed to perform this assignment however it wants, but for
>>>
>>> We assumes that we have monotonically increasing cookie and
>>> if cookie 10 is marked complete cookie 8 is assumed complete too...
>>
>> That's exactly what this patch series is changing. The earlier patches make
>> changes to no longer report to the client the "last" or "used" cookie (to
>> compare against) in the client APIs, and it turns out that nothing in the
>> kernel actually cares about this behavior. So it's simply a documentation
>> change to indicate that the client no longer has any visibility into the
>> cookie behavior.
> 
> Not really, there are some engines which will notify that descriptor X
> completed which also implies that all descriptors before X have
> completed as well...
> 
> If we change the default behaviour, we risk breaking those.

I actually don't believe it's true that any clients rely on this 
behavior today. Certainly, that's the defined behavior prior to this 
patch series and a client could have relied on that. But I did a big 
audit and I don't believe any of them actually do. Prior to submitting 
this patch series I was thinking I needed to create new APIs that code 
could opt into and convert over to gradually, but it seems we're 
fortunate enough to get away with just changing the documentation.

As a quick justification, it's worth doing the work to audit and confirm 
all of this because this is such an important change for the future 
usefulness of the dmaengine framework. Modern DMA devices are best used 
by polling for completions, and they certainly can complete out of 
order. As more of the kernel moves to performing asynchronous operations 
(mostly via io_uring), this is becoming very important. The rest of this 
email is me repeating my big audit and taking notes along the way. I 
apologize if it's long, but it's important to document the findings.

If we look at the client-facing API, we can identify all of the points 
at which a cookie is returned to the user or consumed by the the API as 
input.


As input:
dma_submit_error
dmaengine_tx_status
dma_async_is_tx_complete
dmaengine_is_tx_complete
dma_sync_wait

As a returned value:
dmaengine_submit
dmaengine_tx_status (via the returned state parameter)
dma_async_is_tx_complete (via last/user parameters)

It's also in the following data structures (which are visible to clients):
dma_chan
dma_async_tx_descriptor (returned from the tx_submit function pointer)
dma_tx_state (only returned by dmaengine_tx_status)

So auditing all of those uses:
- dma_submit_error doesn't assume it's monotonically increasing

- dmaengine_tx_status itself doesn't assume (in the generic dmaengine 
code) it's monotonically increasing. Providers implementing this call 
may assume that, but they're in control of making it so. This call can 
also return cookies via the optional state parameter. Except every call 
either passes NULL for state to ignore it, or allocates state on the 
stack and never stores it outside of the local function. Within those 
functions, only state.residue is ever used - the cookies are never touched.

- dma_sync_wait is called in 5 places. In 3 places it's called 
immediately after a dmaengine_submit and the cookie is only ever on the 
stack and never compared to anything. The other two spots are during 
shutdown in ntb_transport_free_queue(). All it's doing here is waiting 
for the last *submitted* cookie to finish, then aborting anything that 
is still outstanding. This driver already works with devices that 
complete out of order (idxd), so it has a comment saying that waiting 
for the last submitted may not wait for all, and that's why it does the 
abort. No issue there.

- dmaengine_is_tx_complete isn't used anywhere. We just added it in this 
series. It's intended to replace dma_async_is_tx_complete.

- dma_async_is_tx_complete is called in 4 places:
-- stm32-hash.c calls dmaengine_submit to get a cookie, then calls 
dma_async_is_tx_complete with that value. The cookie only exists on the 
stack and it's value is never compared with anything. The last/used 
return values are not used.

-- rio_mport_cdev.c calls dmaengine_submit and stores the cookie into a 
request object. That's then passed into dma_async_is_tx_complete later 
and the last/used parameters are not captured. This cookie is only 
compared to other cookies using equality, so this one is safe.

-- omap_vout_vrfb.c is the same story as stm32-hash.c. The cookie is 
only used within a single function and it's never compared to another 
cookie.

-- pxa_camera.c does appear to rely on cookie values monotonically 
increasing. Except we get off easy here, because this driver only works 
with dma channels for one specific provider. It can't use just any 
provider. This particular provider elects to make it's cookies 
monotonically increasing still, so nothing breaks. In general, I have 
some real concerns on layering in this driver since the DMA engine it's 
using does not appear to be generic and instead only works with this 
particular camera device. I don't feel like it should be using the 
dmaengine framework at all.

- dmaengine_submit returns a cookie to the user, and the remaining uses 
of the cookie are embedded into structs. To audit these I created a 
patch that changes the type of dma_cookie_t to a struct like so:

typedef struct {
     s32 val;
} dma_cookie_t;

I then fixed up the utility functions in the dmaengine framework, 
commented out all of the printk stuff that was complaining about casting 
a struct to %d, and let the compiler find all of the places where math 
or comparisons were performed on it. Filtering out comparisons against 0 
to detect errors, assignments to negative values, equality comparisons 
to other cookies, and any uses by DMA providers, which all still work 
after this patch series, we're left with... nothing.

So the summary is:

- pxa_camera is the only client that cares about the cookie behavior, 
but it's tied in to exactly one provider that happens to do the cookies 
the way it wants. This patch series doesn't force any provider to change 
what it does currently.

It really is the case that none of the clients care about the cookie 
behavior, and we really can just make a documentation change to modify 
cookies to become opaque handles.

>>
>> Immediately below here the documentation then says that there's some
>> convenience functions that providers can use that do produce monotonically
>> increasing cookies. These are now optional for providers to use, if they
>> find them useful, rather than the required way to manage the cookies.
>>
>>>
>>> Completion is always in order unless we specify DMA_COMPLETION_NO_ORDER
>>
>> The final patch in this series eliminates DMA_COMPLETION_NO_ORDER entirely.
>> It was only used by the IDXD driver, and the reason I'm doing these patches
>> is so that we can poll the IDXD driver for completions even though it can
>> complete out of order.

