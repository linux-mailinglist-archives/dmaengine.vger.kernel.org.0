Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52C4BC23D
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiBRViY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 16:38:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiBRViY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 16:38:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF8190C8C
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220286; x=1676756286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VDqrQ0c2XcwuF1K8IuD8gC+BLgaWEGq4HmqbQ/O0m6o=;
  b=VDVGOHU8amvJEu6N1QdVpgd3Qh3kkmT3l+AkSih0hQHHdtrYTIrYUMJW
   qGKVYCyMzWnrXMhpnpbBXrHWwMkjXR2lVZo2aoNy8x1zmHPUOSwNJve//
   UQRv+PJJCfDKCPTkuV0uUN5acLXr6B+ksml4Heh0P65q5QOSWP3jjplhr
   GqJOwQMNiyn3w/fQsRADs8sC/6Rhs+JBN4QCPFbeusUqvFvdemJMKLpQD
   DrXVOGHbq8jO51/P5fNs+DBQR8HRGW2hFYG4e+UqEi9xkZLSavYam8G1e
   t60xJ2A7ApXRinTBq6b5NrxorX7gcFmoHJ58yP+OXy3TLCY2pq+l2Rd4h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="234770177"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="234770177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:38:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="705541965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Feb 2022 13:38:06 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:38:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 13:38:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 13:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvXXV1mVAzQkNmvS3ehzDn3HJMSXhHkn6pKe7GcTpIjDP4KIckHMu4rfrT1LJh9MjE9jzF2HAg3MjYrHF01mTXn/OnA3CqULmimU0AOjxIDs0gRT2iMHIYmQdZozLrjNBBXt2XfHLKAasR2l1EQkX24mYvlv29rvjwQvb0Wqyr5aSNiV9/7D2+CL9XX8NVnDPdBi0XVja4o+TjpsM67kCMC3GFTxGfCwTS3RMReLzVSb/q44Bl1FOHNbeEqgK76UIMn6zJs2wD6KvZu5etEmE+JY8qygZ3jY2AK30qy6BeTuyT+He9YwlMzgWsASIr5zfz6nVhTx6eFz45bpT+jg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcJ0EZILwDaNCpZDAN6IEKniXmn5lLFuNIUT+dsXCy0=;
 b=R2aKhLLjXWa3ZV+Gag/7JlqilsHmCZcYwAje/bLP7WrcpcWT0mZBerYL7UgXdawK8f9DBnjN49kglJINxCIInZzZzviDUF/WsHSkVaDa8nkiBoAFjGw5KsFyovQuq/39Pnk2FWOR027EFc+oV5MV3KgcthytaDLoIdW44GZHqeDtvBRH1xgsaSHL81hRfahvdgRD2aIagSycnWsbiUMViSkVS+aduiUCemc8CkUaB/c6QRArHsB00XUEfptJMq9OhiyTWrwFni/e6t7W840VDQFMmXpyjCwY5uEhrriKHQW1be5bswV8mmwQvNNe01S+YI79UH/Q3mj/coQL2zF5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by DM6PR11MB4171.namprd11.prod.outlook.com (2603:10b6:5:191::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 21:37:58 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888%2]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 21:37:58 +0000
Message-ID: <8f063778-19b7-1b48-7429-9cca98ea456b@intel.com>
Date:   Fri, 18 Feb 2022 14:37:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 1/4] dmaengine: Document dmaengine_prep_dma_memset
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <okaya@kernel.org>, <dave.jiang@intel.com>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
 <20220128183948.3924558-2-benjamin.walker@intel.com>
 <YguSODvaNBKp/2O+@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <YguSODvaNBKp/2O+@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:301:14::15) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4c640f-e945-4275-af9d-08d9f326ee40
X-MS-TrafficTypeDiagnostic: DM6PR11MB4171:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4171445611F22BBF4E8FBC03EF379@DM6PR11MB4171.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2CHNjcHSEKoU8DQCxRJ5AjPHI/1aw4HutkoF7OI2bA5kTFAoj8a3+oRlH6UylwRbfT6it+/6PJ4P5tdejK+mLMGPvD9C8ICShsfFkTOGLD4YXROYwBbXWUB0B85BWG5vK/wF26cD7rH/zGotiZRCNiQxcE57yyj/g4aVPO2ewwyJiw+P+SQpTCPLVQ+UUoDZNcSaOGOdwKP54ds5wXCio8vvIpKULbeiOLfjslfNqM2O/OsN/Zc45ouRyAsc+YQMY9EB4pZcpyGoIwK2CdJAjnS0Lv+B0gAKWRNaQkUxJfKB/a+CktXKDXOgA6chgsVu56aucEcbTEvEQugHaCVSxivcGZyVwTvPLPlbv7rRoS0oHuqzX2q7uRkX8PccG22peD7i7f6lN/XeavyfjGUOMIdr0KBOhwXKX6r+H3LhwzdSNTI9fKQkV2TbutGiRYoYOvbBfOVjiCpIITn51xE1eXivQQsOxEpcIi9Qtdi+PV/0p7KxVlGnLHPEceDKfgO9PP5qUzVzVH2h6Hez9e9Oik58DILvUKyhNPAzbtAnWlTndz04cC1jhg8uUqUt/KvwX49MyGNedvBarDvZHfogbzD5+C96gns9skNql5AWHeJiSJWTs8PRbuZLIBGcgTgBsJWA/Efr6urOXctOawGE0nIg6/Ay0vqyIXQdJCkmSS7+osw0ePn0egLfOSOlG/gMG9s5f8Xn2kYciSMBMX4wcbTW2r3AuBVPYfedJHzaD6s6Isvy7KUOF7LG9Q1otsoXuI7ch+ch/EMNvj4J3u/qqVy3OtnNfjeTzsnIzCh5b9ExX8W58LkrwSCvPsZlGc9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6486002)(6512007)(8936002)(5660300002)(6666004)(53546011)(6506007)(66556008)(66946007)(66476007)(8676002)(4326008)(107886003)(186003)(26005)(2906002)(86362001)(2616005)(508600001)(31696002)(38100700002)(82960400001)(6916009)(83380400001)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXh4Z1RwenVYL1dLejVGWkVyRld0NTBUcnlMMkl0OE1yMEg4dk41ckU4UU9x?=
 =?utf-8?B?a1pFUnQxYklHQ3kvQXdCRWl0VE8wT3lGWmxqaUhVb3AwT1hGSDhoOU1QTkFL?=
 =?utf-8?B?UDZnbThGUlh2UnQxNEdQWXJXeXIwMFFiK1V6SSt6M2tCWVFvaEFmTzNzWFh0?=
 =?utf-8?B?U2FoME9wdXRQeWJOalhXUjV0NmFNQ3BFZHQ2a3dIWDlVQ014OUpkdVJ1SFlX?=
 =?utf-8?B?dHkwN0xpS3p2TXlzWmo3OFNlZVMvangvUEJEdTZCOE5RS3NiQjV5L2FYU2lQ?=
 =?utf-8?B?STFJWHpTS2hQS2lwTmgzUEFkRWpvZWRzd3A4MXdOOElSZXgzb2cxSGZ5cGJv?=
 =?utf-8?B?VnMyb1VDNFE4TnRjd3VkM3ZIdkZWajZ0MUxwSldiMGROSkFjUFBVV3FhRjcz?=
 =?utf-8?B?ZzNwZUtUeTJSTENUTWlVV1kwQ0ZiMzRqeGRzQytIRDdjS3lpZjdwY3VjZTMw?=
 =?utf-8?B?aGdNSTBLelZUZllKN0t6ZGxHV1I3WVdSWVBMOFFkVXFCeklwUjIwdFVkL3dv?=
 =?utf-8?B?ejRWUWJQQVVPYm5haWgxOG5EM254SGRKMnlIUVVwWktHZ2h5MWxPSlQrcEFF?=
 =?utf-8?B?aC9JQ2g1OG1reW5DbnkzYzRZbGVmM0tjT2lDMXd2QUNQSDM0eTE2ODFxdGUy?=
 =?utf-8?B?MFQxUWMrTDE5L2ZySm45VEc1czNsand5Q0ZZU3ZhY0xkcnlqUENqMFpuNzM1?=
 =?utf-8?B?aGQ5UGd5c0ZERnpSbVlDVDYyazlDYWFlR1MzSmhyVXlReHFXUlhBak9Pclk2?=
 =?utf-8?B?MDJoNEhqaXJQUDlxTGpCcGJ5bWZWZElUOHBSc29vaTNoZEs2aE9KOTNSdFpV?=
 =?utf-8?B?aDEySnBWY29QSEwwOWRlM296MUxmYUVQSmRqSzVXOE84ZjFYa3o2Wkl0L1BO?=
 =?utf-8?B?dUJUNTBzbzVuRU1meFJPNUVUYWYvNSs2K2VyZVdvOWZqMk9XZFdBdDVPbnJz?=
 =?utf-8?B?Sis0QWgvUyszVzdlUzgvVm1xdCtjMXB0UnR4K0t6Rm9BdGRBTmpmMDZNbXhQ?=
 =?utf-8?B?QWZKZ0MvTEJzWGpHdWh6WW5DS1htK2I2OHhOYThSL250WEZtMVVzbU5jWldI?=
 =?utf-8?B?L3FlZXlCYkVpbElOSks2Q3ptRkJ5WUNWOW5sQXBPd2UxOW1UUnNYcEZLQlc2?=
 =?utf-8?B?NDZneFhsRVNuRUovSk5aYlZwaFhYYzZhdTJnRFUyNFJ1UXBOTXIvR1RadG1v?=
 =?utf-8?B?VjQrMW9JVDEvaW5UQlJFbkE0OFczaSs1SDRvQm81T3ZJOXlGMDRYRDNwMFV0?=
 =?utf-8?B?N0RuUlZ2dTloMjI4VS9pSVBWdGVyNTF3RjZxVWh1MFMxd2NwVG9qRWVEMzB4?=
 =?utf-8?B?UWhEa29LVmc4eDJwMTNTQnVjVjhLek5MY014QlB3U2JhK0tqKytkZjJXdlR0?=
 =?utf-8?B?Y28vcUpCQy82VWIyMW5DcnhjZFJPN1o1MktIdWpKcGJuQlFLRUN6ZG1LbkQ3?=
 =?utf-8?B?RmtDcWxnQTQxVXpQOFJDcE9qWDF4cWlJVXFOcEpLSTBZS1o4WXdZbmllVC9L?=
 =?utf-8?B?SkN4dHRBczg5VzRHbWdjVS9UdjdFYnJWbjB0TTRnMDNZc2ZWdXNUa1dmQk9N?=
 =?utf-8?B?eDU2eHA0enduT3h0VktxU2VhUHpEekhZUDRuR1QwQUZENFpzMGwzRTZDNE9O?=
 =?utf-8?B?MjkzMXB4WlRFUjJpdkJMZ1lXL3hPS1VGc3pldDZ2MDNCZXR1Z0g1UUtUek1i?=
 =?utf-8?B?bGNNR1pFeWdkOW9aT2Myd3J3bUN6Q2pIcFFoc0VjR1pjZXBsZXVZODVPY3dD?=
 =?utf-8?B?TmtQK3F6dERZQkJJSWtIQUJhOHRUeUVHY2E5cTk0YU02TmF3ckFNQzN5Ykp4?=
 =?utf-8?B?ZDNsM0JLUk4zd1czMXZhekxZUW9oOS9HK1VjQXk3VlBxZVZ2ditwazN3YWF6?=
 =?utf-8?B?ZTZDWnF4WkhhcExrci9UVlk2MnB1Y3JuZ0RYNFl4OW5RaXZpaHNHaDVWTitO?=
 =?utf-8?B?UFN2NmUyZWVIV2ZqR2M0QVdiaXJXUW9ZZGoraU5vVk50NENGc0FyVEpRTDgx?=
 =?utf-8?B?S09EVUlvTWpteCtPSnVaYitwU0pUTnVLWXRabldJbTlCREhiM2VoZmM3UHNY?=
 =?utf-8?B?YzZ0bXlrNDhtQjEyK21KZkpnckZPSmhRTkJTaFJRc1VYMDV6V0RCQTgyVEtF?=
 =?utf-8?B?YTF6dzJ4dlNHRWtWWERhRVNxYjk1Z0RWSmpEcHNhNjN0YTdPdHZmZDByZi9k?=
 =?utf-8?B?bjdiZXBmQWlEY1YwczI5TmpsVGl6cDNUVDVtVG4vZ1hkV0FRbXl3SGVKQ2Vp?=
 =?utf-8?B?L3B4WFZoSGVzelhtRjZ6U2ZQWkVBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c640f-e945-4275-af9d-08d9f326ee40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:37:58.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRLIacTs237yXecLAbR+6xTbXI4vs8vX+xQ3XN2U3twJ0neWh4W/Y7KfdkXKYApe+VCH41QcQIHyNrISIkaA19KinwuaINq56FTLLQPOR2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/15/2022 4:44 AM, Vinod Koul wrote:
> On 28-01-22, 11:39, Ben Walker wrote:
>> Document this function to make clear the expected behavior of the
>> 'value' parameter. It was intended to match the behavior of POSIX memset
>> as laid out here:
>>
>> https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/
> 
> Can we add this to Documentation too? Documentation/driver-api/dmaengine/

Ack. Updated in my v2.

> 
>>
>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>> ---
>>   include/linux/dmaengine.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 842d4f7ca752d..3d3e663e17ac7 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -1031,6 +1031,14 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
>>   	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
>>   }
>>   
>> +/**
>> + * dmaengine_prep_dma_memset() - Prepare a DMA memset descriptor.
>> + * @chan: The channel to be used for this descriptor
>> + * @dest: Address of buffer to be set
>> + * @value: Treated as a single byte value that fills the destination buffer
>> + * @len: The total size of dest
>> + * @flags: DMA engine flags
>> + */
>>   static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
>>   		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
>>   		unsigned long flags)
>> -- 
>> 2.33.1
> 
