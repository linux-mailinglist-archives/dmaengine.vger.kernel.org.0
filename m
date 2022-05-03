Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2AA518B97
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiECSAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbiECSAE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 14:00:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823C3E5E7
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651600590; x=1683136590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cAGTD3QnGIQ4Gu62fqn8ANulKCybspaBSaZLAxCst6U=;
  b=P7VwMddTwfaAxS7um2BpxEz5dv1Q0HZ8cTIGM/MU1ODP8U/EF9Mrnhae
   m9DCbGuXVTDz96GSsXU4aqjSF4mBE8LbyYIVIo5Pjg4YSrs+3B3mCw4jo
   HlE+Nbbbfrh7aaXZhXosXYMS5MwSHoLxnsqDiGA8lsXoBDi/bmM6/8w5w
   Z2Rraj2+3kzus4l/YH3jgL5PZ2hBxHyxaVlp/L+rMGC7lXzyP7fFEijjQ
   7VkG58Lr62qIopk0xb2sTihaJEVScABqYHwyEh2MEvPg35MInmXo6Al9z
   S2hMNRUI8J2m7MJkShYXysc5hnnNPAqDZYAW0cNx4/Nc/8X25g16bZ1bT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330532261"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="330532261"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 10:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="810768582"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2022 10:56:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 10:56:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 3 May 2022 10:56:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 3 May 2022 10:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUXH2PGEuJw4KGuSsY8fWb70ZHCygFo+OEhnZ90G7KIghblGnGExHKm57SwAlUZC1DYY/7D59VyQPCxjFXW7SI6GixBX5PZ+0iLClqrlWw6hcvNS+XTW6XelT+Ji6ah3OZ53gZOPlWTvmp3TlUfAMAX5YNmixAW1WoAxZwchFyvlAb8RHNH1D30/iMn4gEPe/LVYoAdKADGcxGm9F/1yp4U0Zlys/+BvqHCdMkjixPpyynTW9v/AKrWLWam5eXfmzZ06SLr0Rnm6XILsBdOKkFjRWhrqc4qncEfK/RVzQ1BGUbtsvBQFVow/BfJDWyJQonplaSXv34u+HIsx+cTBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRO7mKBLADzuvxbV84GNbK1BCsWr5FmTu1WXQQnHinU=;
 b=TjMvCiSFP5snL+CxsTalXIpsRW6jm4FLsKOs4h/pr9yeLX95C4ayklmuhfj8lnVqrtUWzPgTQouxqDZqiodkSMZGVJ/b9ftrLB/MEud9dkDpYON1OiCENYs2M2/iMgLWINOr+tP6JUs7zwPHiRCnc+NEc+/8rEzGphJ56cQ4EwKi7dmNAUcMFDed2rRfIu+FO0qy4J5fUkUmzaEXE+fNyOLS8SCo/Ovm3AKVcSUgK4kH49SF0MGIMMRhTAUOxwR1Qd84E1bJ2UCUcl639VtAlE0qgnXht25khgaqOxB4AeA7zvjpFfSs+ysH2blokR/utxy0BNBgLjl0nZHIsmosvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by DM5PR11MB1497.namprd11.prod.outlook.com (2603:10b6:4:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 17:56:27 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::b92d:4523:d758:69cf]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::b92d:4523:d758:69cf%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 17:56:27 +0000
Message-ID: <abfd086d-0a43-5d68-3f14-07ec4e8f5da1@intel.com>
Date:   Tue, 3 May 2022 10:56:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [RESEND 03/10] dmaengine: Remove the last, used parameters in
 dma_async_is_tx_complete
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dave.jiang@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
 <20220201203813.3951461-4-benjamin.walker@intel.com>
 <YnE4jLGSOupviRWQ@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <YnE4jLGSOupviRWQ@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2df7cb33-66b3-499f-b09f-08da2d2e3eca
X-MS-TrafficTypeDiagnostic: DM5PR11MB1497:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1497E96AC079F4FBD639B58AEFC09@DM5PR11MB1497.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo55r/oVNqIMwrSdz6Qw0KtiTvTiZfAqXL4v/ta/137NMI+ScA9jRViJtQM9dMrS/xnBcaz+Ff5TjICScr0MjTvwwVe9u87YET08GXPMLjldV+e/jMmqkQ96GJHL1vtXdcOSnm/lao+hqBwUQ3t3Pe2BiRZfKgwvjG46iq7Icm09Ri9c1Bs4C5Y4VMC9DcPMxfj8ydhaI867z7y/KxRTb51kXG7zKZqEXH65/wRQGNUeb0ayS6AubkOCsAOko/qkUbtSi5zx0FNwOlJ7NMew01sJ/nJ2fqLu5KFcFwbu7awQ2uvjEKtA8ajOblotmPMip2nGXFqXOnpt4/Ab8W7Uu6SfwONSkERXXfxMqRxYSjNdW7kEobmR/5wuoGXi7DAIJnKO0KqsFPDSWrjSraY7LxJJudQAU5WHWWwD14GOc7/f79usuQW33k/gfqZaMWyJa7NKocUsJSFnccMM2w5LXMGeqWxYdjqZeUPoH/Ty36ZE+PrnIALOVUuXJ6yed+As1GVj7xdjJWTk6vcwk9jBDx1gX1WW4fwBIDA58SZ09qIVGn7hFklv/t2q2BzJsOCveKTNzWBfLoehiSKBhgzujvT/TNLwDBzi5nHsICrabPo9zPFzV6P5qHRFYjeQw6mKzeSfoIHaMnzG/TcDf2GczAlv4OCPXkkl7iNmhhWvRwYZPVErS+E/L1ONWox0v6cFz4HRl8i+W6FaRWlzWxlIu/SYXgFUpYIBk1sg+jhR7Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(66556008)(4326008)(66946007)(8676002)(66476007)(316002)(5660300002)(83380400001)(8936002)(6916009)(6486002)(508600001)(36756003)(2906002)(6512007)(86362001)(31696002)(26005)(6506007)(53546011)(38100700002)(107886003)(2616005)(186003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9YdWFLcERKMzV2WXhTa0xyZHJ3TUNTV09oSFU1L1RueHJMYlRhVzgyMUFT?=
 =?utf-8?B?TXd2KzYzRVFZVnc0aEI4cWRaK2xpOFFYTUdZZlJrZUhLVDRnR3c3NjhZT3Zr?=
 =?utf-8?B?MWJXUUQ0RU5rVE1HZlUxdk5zaW9jQzUvQ1JTYjhLMkZaRVlwbldxMUZuZk1D?=
 =?utf-8?B?cjVVU3dyTmFPZWxiRkw1ckx6QzUvTmdueUVvNFI1cm0wdWpsZkswdDdGWlpQ?=
 =?utf-8?B?enhCcXNpMzlBeFdBcE9veHF0ZXpvRnh2RVIyQjJYaXVielJmMUxoRlRTQXRl?=
 =?utf-8?B?aWphM1dYeDFuRncrTU0zdHVtR0h1anJGT1JXTzdBNHBHTngwa0hwcEJ4d0Ju?=
 =?utf-8?B?aVVpY0JIZjdQaVRNeWpoaG1iK0ZGSGJKbWlwMGdHVXo2dmJ5NFBVUHJlVi9Q?=
 =?utf-8?B?RDRJZTR6U1Z4U3pBN3RBUVd3WTVBaFpXTmh1b0tQUmNTWDRtaW9iSVpZU0g4?=
 =?utf-8?B?bHJSWXBPaklBejRwZEcyUEQ2c2VCaEtLZjRQSjJ1bGxENlVsR05yd3dzZEU2?=
 =?utf-8?B?NStGc0xKOFRiK0xBVXdjd1NyTHlSK1NIYk5rR2FRVERUWmlNVVRTQzl2NXNm?=
 =?utf-8?B?RnB0OU5YWUVxeHlYQllGY2NKbm91VjBzNW5KZ0Q2RVdLb1dhQldxenQ1SmNX?=
 =?utf-8?B?bmQ3c1dGdTJwSXV6enpwQWpQSWl5a2doVjhZRWFlUzlEdHl1VVhVNmtMc2RP?=
 =?utf-8?B?Q3AwWFZqWFkyRzJWOWl2ZndodHl5SGhqMThySkozL1h2SE11dDk0REZacGEr?=
 =?utf-8?B?VFdFS0w0SGpnaEF4d3d6UUFOdGxPRmQ4b1JkWkdLWlJvVjZuaUt5UjB6Y0ov?=
 =?utf-8?B?ZUtqdnZVNnhHUmlyV2F5SlNEMkJIU21wYWR5eGJzbzlaYlVEbkNnbXBjVHhR?=
 =?utf-8?B?SUUvRU94RG5tZVMxWTdHeVpGKytodkFOc1BKZ2NmeVF3L3JoWmFBTXM1c3FG?=
 =?utf-8?B?T2U5cjQ1WDM1Q3hMc1JxcklYTUNpeFBScU56NmdadmNZK2JpWXpIZVlNTksv?=
 =?utf-8?B?SVozZXJQNHhaa2UyVHZOOXhSQmpaVCszKytkdjUyMmxOWDFvaUlSaXdCekh4?=
 =?utf-8?B?NG03RHdpT01pRGE0TVRGN0pyNlN0Y3VkNE1RUGpjbE0zUG5hTERnRkNyeGRs?=
 =?utf-8?B?WUR0WWZXa3FhdWZ6ZVBGdUdJL1FDbWFkb1creVpMK05scXVuNEUxaU1rZlRC?=
 =?utf-8?B?TzhWcE5aY21EbUhabFdET3hDcmZSYzkrTVljb0ltNXVJNXFHY1FwZ29OMUl2?=
 =?utf-8?B?RWVCd2FkcjhvMlhqdW0zN2NMMTcwQ0pKSUtmclVBVkZVbzVTQnh0VlNOUVFq?=
 =?utf-8?B?WGNqMlpFWkxrNCtTZzBZRUFPNXE2RXVORXlsbVhYTmtzenBsd1pDRUdPVnJE?=
 =?utf-8?B?U1NNa3ZjTjIzazJrWDFkNDdCL3VWOE41a29xbDRyZ0xwbnA5a3lLSnZhQWth?=
 =?utf-8?B?djNHZ1g5MEhSOUtENEtrem5HemNpQXJCSzgrVy9aWHk5VGdlOUI1NUM0NUdx?=
 =?utf-8?B?aEY5dTZDV2FUVmZja1pOYUFwY1E3RGF6anFaSFJJOHJueWl2TFBNQU85QW94?=
 =?utf-8?B?T0hGTVBoZ1ZxK0d3K2l0TlZqbFVHMHozS2lxb3hIQ0J3a2pTaURNSEl4K24w?=
 =?utf-8?B?RGhiY2Q5aVVvVVZnak5iaFhzalV1MzJnNExLdFp0bTdWMGg5Vm1HVWhRWHYy?=
 =?utf-8?B?VjF3UHpQUU00U29scGpxeGcvYnRsNGNNZGFzbkVwYlJVRm1jL0wxUmRpRWJw?=
 =?utf-8?B?Um1ucUlCWWdJRDc1Rkk1VFMvdGZpZjhUUC9PZ1JuU2FYZE0yK210NWkxNUto?=
 =?utf-8?B?NXVlaC8zeEpQNndnMEphbDc1eVVQTDdxNmxvVXdycm9kVW5nQjhTTnJSWGh6?=
 =?utf-8?B?UWFicUVldi9KSUcxMkI0ZnZsMWR3TTg1Nks1RHJKQTZsUXJMN0dJTnNNaGJR?=
 =?utf-8?B?SHArcDJLRGw3MkFkYzN6WSs3aDQvTk9Va2xYZ2ZWa01JL3FITUZzbUduQjRP?=
 =?utf-8?B?NWc4M21YbzBsRmtpc3NVajFDOEYwdU42WkE0aTZzQ1AvRzFqN0cwTG11RDJR?=
 =?utf-8?B?K3BKOUQ3alBWWnhuNHNpWGhscmRMU01vaHBCV1Z3ejI3aGk0THJWZHU3YnNZ?=
 =?utf-8?B?VlRWeWZ5QUt5cVlZOWplblZIRkdsZlArYUJnS3V3TXBBbmROV0NwL2lJSVMr?=
 =?utf-8?B?VjZHNTJ2VDg4elhsNjZTMkVnT3NQbTdheUtNaFJnOG9nTHR2UXl4ZW5ZNFFN?=
 =?utf-8?B?amlTQ0dyRTFmb002d2ZsSXQ0NEN1MUVDU0t0WTlhR2ZDbWJzSmgvL244QjNB?=
 =?utf-8?B?anVNSGdudlI2czQ2dkN6cER0RElNaFFHUkRld2pEazNoMGZXU1BmR0RNTElZ?=
 =?utf-8?Q?HUhlvnjvXLgLKy9U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df7cb33-66b3-499f-b09f-08da2d2e3eca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 17:56:27.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoxtPy3fy42x2iOEoNtL+4FSA9P27NsuxOO7pGrtb8zbka7HTbGMwaVK6I3KwI9iXkmwXo49Bay9g+skp8NSeMFQEGesDy7H8yxiG8dIkWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/3/2022 7:13 AM, Vinod Koul wrote:
> On 01-02-22, 13:38, Ben Walker wrote:
>> These are only used by a single driver (pxa_camera) which knows exactly
>> which DMA engine it is dealing with and therefore knows the behavior
>> of the cookie values. It can grab the value it needs directly from
>> the dma_chan instead. No other DMA client assumes anything about
>> the behavior of the cookie values, so the cookie becomes an opaque
>> handle after this patch.
>>
>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>> ---
>>   Documentation/driver-api/dmaengine/client.rst  | 17 +++--------------
>>   .../driver-api/dmaengine/provider.rst          |  6 +++---
>>   drivers/crypto/stm32/stm32-hash.c              |  3 +--
>>   drivers/dma/dmaengine.c                        |  2 +-
>>   drivers/dma/dmatest.c                          |  3 +--
>>   drivers/media/platform/omap/omap_vout_vrfb.c   |  2 +-
>>   drivers/media/platform/pxa_camera.c            | 13 +++++++++++--
>>   drivers/rapidio/devices/rio_mport_cdev.c       |  3 +--
>>   include/linux/dmaengine.h                      | 18 +++---------------
> 
> This needs to be split per subsysytem and cc respective maintainers so
> that they can review and ack it...

Ack. Will split.

> 
>>   9 files changed, 25 insertions(+), 42 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
>> index 85ecec2c40005..6e43c9c428e68 100644
>> --- a/Documentation/driver-api/dmaengine/client.rst
>> +++ b/Documentation/driver-api/dmaengine/client.rst
>> @@ -259,8 +259,8 @@ The details of these operations are:
>>   
>>         dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
>>   
>> -   This returns a cookie can be used to check the progress of DMA engine
>> -   activity via other DMA engine calls not covered in this document.
>> +   This returns a cookie that can be used to check the progress of a transaction
>> +   via dma_async_is_tx_complete().
>>   
>>      dmaengine_submit() will not start the DMA operation, it merely adds
>>      it to the pending queue. For this, see step 5, dma_async_issue_pending.
>> @@ -340,22 +340,11 @@ Further APIs
>>      .. code-block:: c
>>   
>>         enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
>> -		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
>> -
>> -   This can be used to check the status of the channel. Please see
>> -   the documentation in include/linux/dmaengine.h for a more complete
>> -   description of this API.
>> +		dma_cookie_t cookie)
>>   
>>      This can be used with the cookie returned from dmaengine_submit()
>>      to check for completion of a specific DMA transaction.
>>   
>> -   .. note::
>> -
>> -      Not all DMA engine drivers can return reliable information for
>> -      a running DMA channel. It is recommended that DMA engine users
>> -      pause or stop (via dmaengine_terminate_all()) the channel before
>> -      using this API.
>> -
>>   5. Synchronize termination API
>>   
>>      .. code-block:: c
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>> index 0072c9c7efd34..e9e9de18d6b02 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -543,10 +543,10 @@ where to put them)
>>   
>>   dma_cookie_t
>>   
>> -- it's a DMA transaction ID that will increment over time.
>> +- it's a DMA transaction ID.
> 
> why drop this?

The exact behavior of the cookie (incrementing over time) is no longer a 
part of the API after this is removed. It becomes an opaque handle.

> 
>>   
>> -- Not really relevant any more since the introduction of ``virt-dma``
>> -  that abstracts it away.
>> +- The value can be chosen by the provider, or use the helper APIs
>> +  such as dma_cookie_assign() and dma_cookie_complete().
>>   
>>   DMA_CTRL_ACK
>>   
>> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
>> index d33006d43f761..9c3b6526e39f8 100644
>> --- a/drivers/crypto/stm32/stm32-hash.c
>> +++ b/drivers/crypto/stm32/stm32-hash.c
>> @@ -453,8 +453,7 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
>>   					 msecs_to_jiffies(100)))
>>   		err = -ETIMEDOUT;
>>   
>> -	if (dma_async_is_tx_complete(hdev->dma_lch, cookie,
>> -				     NULL, NULL) != DMA_COMPLETE)
>> +	if (dma_async_is_tx_complete(hdev->dma_lch, cookie) != DMA_COMPLETE)
>>   		err = -ETIMEDOUT;
>>   
>>   	if (err) {
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 2cfa8458b51be..590f238a0671a 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
>>   
>>   	dma_async_issue_pending(chan);
>>   	do {
>> -		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>> +		status = dma_async_is_tx_complete(chan, cookie);
>>   		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
>>   			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
>>   			return DMA_ERROR;
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index f696246f57fdb..0574090a80c8c 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -832,8 +832,7 @@ static int dmatest_func(void *data)
>>   					done->done,
>>   					msecs_to_jiffies(params->timeout));
>>   
>> -			status = dma_async_is_tx_complete(chan, cookie, NULL,
>> -							  NULL);
>> +			status = dma_async_is_tx_complete(chan, cookie);
>>   		}
>>   
>>   		if (!done->done) {
>> diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
>> index 0cfa0169875f0..d762939ffa5de 100644
>> --- a/drivers/media/platform/omap/omap_vout_vrfb.c
>> +++ b/drivers/media/platform/omap/omap_vout_vrfb.c
>> @@ -289,7 +289,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
>>   					 vout->vrfb_dma_tx.tx_status == 1,
>>   					 VRFB_TX_TIMEOUT);
>>   
>> -	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>> +	status = dma_async_is_tx_complete(chan, cookie);
>>   
>>   	if (vout->vrfb_dma_tx.tx_status == 0) {
>>   		pr_err("%s: Timeout while waiting for DMA\n", __func__);
>> diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
>> index 3ba00b0f93200..6d5c36ea6622a 100644
>> --- a/drivers/media/platform/pxa_camera.c
>> +++ b/drivers/media/platform/pxa_camera.c
>> @@ -1049,8 +1049,17 @@ static void pxa_camera_dma_irq(struct pxa_camera_dev *pcdev,
>>   	last_buf = list_entry(pcdev->capture.prev,
>>   			      struct pxa_buffer, queue);
>>   	last_status = dma_async_is_tx_complete(pcdev->dma_chans[chan],
>> -					       last_buf->cookie[chan],
>> -					       NULL, &last_issued);
>> +					       last_buf->cookie[chan]);
>> +	/*
>> +	 * Peek into the channel and read the last cookie that was issued.
>> +	 * This is a layering violation - the dmaengine API does not officially
>> +	 * provide this information. Since this camera driver is tightly coupled
>> +	 * with a specific DMA device we know exactly how this cookie value will
>> +	 * behave. Otherwise, this wouldn't be safe.
>> +	 */
>> +	last_issued = pcdev->dma_chans[chan]->cookie;
>> +	barrier();
>> +
>>   	if (camera_status & overrun &&
>>   	    last_status != DMA_COMPLETE) {
>>   		dev_dbg(pcdev_to_dev(pcdev), "FIFO overrun! CISR: %x\n",
>> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
>> index 7df466e222820..790e0c7a3306c 100644
>> --- a/drivers/rapidio/devices/rio_mport_cdev.c
>> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
>> @@ -597,8 +597,7 @@ static void dma_xfer_callback(void *param)
>>   	struct mport_dma_req *req = (struct mport_dma_req *)param;
>>   	struct mport_cdev_priv *priv = req->priv;
>>   
>> -	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie,
>> -					       NULL, NULL);
>> +	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie);
>>   	complete(&req->req_comp);
>>   	kref_put(&req->refcount, dma_req_free);
>>   }
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 8c4934bc038ec..5f884fffe74cc 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -1436,25 +1436,13 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
>>    * dma_async_is_tx_complete - poll for transaction completion
>>    * @chan: DMA channel
>>    * @cookie: transaction identifier to check status of
>> - * @last: returns last completed cookie, can be NULL
>> - * @used: returns last issued cookie, can be NULL
>> - *
>> - * If @last and @used are passed in, upon return they reflect the most
>> - * recently submitted (used) cookie and the most recently completed
>> - * cookie.
>>    */
>>   static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
>> -	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
>> +	dma_cookie_t cookie)
> 
> With this I think we should take this opprtunity to rename the api to
> dmaengine_async_is_tx_complete()
> 

Ok, I can add a patch in my v2 series to do the rename.

