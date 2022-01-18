Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF049255A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiARMFg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 07:05:36 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:63393
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235536AbiARMFf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jan 2022 07:05:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKjZ/DPxNtBi4NDm5EmhBA6jP+IuBYa/0hXa3SoslrCHVSDY6phqXD7v6VrsiJwxVeOu+DIWEHdpZNlXQ9GsFakOp+Ox2Dykjfq9oIW5Qdcq4mmPkySU8+Zxto6rSNyJ2e/znj6E3sv5731SBLeuVTlzAwXoZAzLzkYaEUUiwxuDwyQyn7SvAym/43iigNECz2O+BrjCyKlS2VdmNS6As1XA+zII/BjoN66mFezN+5g/b9XSq3jG5fJiDBHTGBR2NsnJ6dAo4JOxIf4VdkqLH7B4RUCTlBiLDyLrwsB0ck8bddAarYwXfN0VBSUC66ikJW+D9xCxILPDCtlpI1n/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl7Fn/29KYKF1jUxcXOeljTMse2jYQDa2ZQjWm/c8cY=;
 b=EwZriqKx6J2f3VvaN2hXMOgzwk43mH6ENq3mCwsaT2P3kGrtrwKgK7vC8J6OWrEFJKHlhDIX/aONAsHX3Tce+obz75nRD1oIX6WZM55RnJ5v3ssRzki+zVBlvl2c3YPrs/z2e9J5teTF2KxKzeV8qSpTCWmOcy/XbqbjPBULCEcQ/3fJJ5BHApnsxYAQkLzmnqX95/gxIFS24FUffBnphWD+Jq4LFCgaoTJNXEIxMfo8tfujmex+nCgp3LrRf9Ag5zsAEXz7se+TGEe5iZq9MqM4FJbayDj90mxndzWXUBPWFvRAZsXyRRCWIWjkJr6t2uWESWc/qOfbdhiyUIBGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl7Fn/29KYKF1jUxcXOeljTMse2jYQDa2ZQjWm/c8cY=;
 b=MRD9Yidc3zoI7zBiuM4osMUviILzN/ewBXTEw6fAHmLppxsDlfiSTYZU30h4Iz2af1MffAAyAVOfip7zlofhFnU/rIpof4TyV6aiV0AR4+U6rB0genunxwQjMOp78UZzhh4Kztm5TkQYwm/pWgmfNyb4jI8HvESofKUy3fWCS6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) by
 MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 12:05:34 +0000
Received: from DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b]) by DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::ced:a3ff:fb2f:165b%10]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 12:05:33 +0000
Subject: Re: [PATCH] dmaengine: ptdma: fix concurrency issue with multiple dma
 transfer
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1639735118-9798-1-git-send-email-Sanju.Mehta@amd.com>
 <YdLfLc8lfOektWmi@matsya> <38ae8876-610a-3c32-5025-1419466167e4@amd.com>
Message-ID: <0ab6a63f-95cd-447f-df10-f73031e71fed@amd.com>
Date:   Tue, 18 Jan 2022 17:35:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <38ae8876-610a-3c32-5025-1419466167e4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To DM5PR12MB1242.namprd12.prod.outlook.com
 (2603:10b6:3:6d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f79d81-722f-4fb3-fd8f-08d9da7ad483
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40466FCB15A6F6C018CF258FE5589@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4Y7xJhEsL3wO3FWcaKqna45nlhPr/QNFc8DN+x62YuElaT75C9ziaCiTzmP7ccceZBAWKkrLfHQ9R2bNWMN/5FMatyHJK668PPcc+Ne4SYSXClVdj9NlZFnYsRVBiEua1ucpKBAyiE8ZdxKWrOjzFELNKjDkOiOGqhXXp55hnrhMsT7+5m+9TlD+mfZ1R5hzuhXpIw7BMc84PhA15IjOgVbYxgpCEKPnpKIklhE7AsflzR3txUMcuOCefVmDEC/XbtQB/gShVsVVNHLT6G+hiIkOUM/53WwXCSBnSdVLNAqcV4zU3bCivA6+1V41O/iwv3ImSdjfzNZYeLTOeP06T2AO8fxudhFu0hRNUTz025iERZWrZmR1+sJhqWbcPXPlFolEU6SdRVGuhP3PBhBBMV0P/Gc8hwqGUbGqBIaX34YKCkmfx2WCeIHG+Qf7D6Uywfe3qCljLjwELeFR1f0qd9TKnDXasCVX6uB0aD+Yicr3BA0g88m0ftW92xUnsU6eH5WRbYBai5PtwRQwVXnfwthw8jUapyQYYjqJtjjOZRuVkXneRR1ONJb86OTFux13Vy4B9cwP4h6fSO4CgnPdGefKIXuQaWUHUcTkzq8cBkMzALwu/o4IUEnrfIl8TNxksq6F2IvYZ9xJI7ZB5xiQteRkUgrKl6B05SQuTp9KAkK6j+xa76W6MLYu44ORy3xl16IsY+rvAIGBXOAlZLgiS8PikwcJatz2lGK+mEmY80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1242.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(6666004)(38100700002)(36756003)(6506007)(8676002)(8936002)(66946007)(53546011)(186003)(5660300002)(31696002)(6512007)(508600001)(26005)(31686004)(6486002)(83380400001)(2906002)(6636002)(4326008)(2616005)(66556008)(110136005)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri9aUVhlOG5YQzZnZ0xqMDJNK1dzY3RMQVJvWTVyZTdFSkdWZU5mS1JCdXdj?=
 =?utf-8?B?azRQblJ2cDkwM2dObi9rNjJkOWRqZ0NpR0NYcXd6VUgwS1k4UUI3ZnNPK3JZ?=
 =?utf-8?B?bnZIWUFPUEs3bi9ORFpBbk44SzdLakNaa0VyQUt5M21HWGxqbTIwNEtxa2ZT?=
 =?utf-8?B?SXNTeXFydVMwSnJXNVd1dzg1Sjd4RnRrNU5jSi9BaFUwUkdQWWJ1cHByOUZt?=
 =?utf-8?B?V1ZGanhXcThtRFR0S1djM2MwL21hTlRmcDZ1OU1LUVBIamRZK1lVUHlpWUZv?=
 =?utf-8?B?VHFGSW95bUxkOEd0TUc2SWFvTTl2UUJNWDJUa29tVUFCbTZWMjlaQVl1NWk0?=
 =?utf-8?B?WU5CWG9iYXgrTGpkVHRSZ0x5S3dJVE1mN2ZzVnhxMWZ4WFJxelg2VDJ0Ym9S?=
 =?utf-8?B?VlphOXJpNEcyZ1NCdEhKbWg5TE9HNVZjMEphSi8vMGttck5nLytWOEwzUEow?=
 =?utf-8?B?TXNjN2FUOUtHLzg2SmZZZTZvOUFsOE9ZRVozbFluNkU4UGgyTDRkc3NGSHRW?=
 =?utf-8?B?bE13dStNOFZhdzg0V2ZWaGdENGRxcHp3N1JweE1nazI3R0RzTE9MM2ozTlJZ?=
 =?utf-8?B?TU1nWUFzTmhQWG1qSVdyTEppOU92NEhOMXFBTG0reFlLTXZmdkMxZ3pTR2VH?=
 =?utf-8?B?M0VsUVh3VWdCTFk3emR5NTE1eHFRc2huVm5NZGI4ODZVMk5Qa29wUVltSlFT?=
 =?utf-8?B?OGYxZ2FWbGQveGgwbEJSYXF1elZVYlI2NHdyeGUxZ3VNeWw2MkdvNDJZWlU5?=
 =?utf-8?B?WUlhenJjdG1rUUZqWWc3OG5zdWF3L01DakZNVDE3ZVg4M29JTlVLTGJXelpk?=
 =?utf-8?B?akZPTHZQMzArVEV6cFZwT2p2T0cxcjRWWDFVY3JVV2FkdThZdmYzWjVLSm5V?=
 =?utf-8?B?ZXF2bXBUS2tkYmpaTm1qcElxNkdKNzZOako3QWJIcUJzUGlBTW1GeHVWMTZz?=
 =?utf-8?B?ZjRMbjZQdzZ6Z3dzV1JRYU1OWlhSUS9wSjkxeEZFYWwyUjRlNFR3UnZySGNT?=
 =?utf-8?B?bExEb0JqdWhROGhHOHNqRWRjR0owM0p3VUR6cVdCR1dDMWhXaXRGcEJJSEw3?=
 =?utf-8?B?ZnFKcGZpcEM4aktCZytRdzRSdUtkSld2NEZraGtXOGlLNEx6clZIcXovcWoz?=
 =?utf-8?B?WEc4RG5KdzMwYkZLSlliRkowcUxzMEFoNXJteE96WXpYN1lOMkRlNTROTHA1?=
 =?utf-8?B?ZHV0L0RMT1RFWDIwV1huQmJBT0UxbnVOaUlUb0gzekdZWHlIc2FoVGhxdkVF?=
 =?utf-8?B?STY2U1BNVTV1VkF2Nm5QOGd3b3hjZFFGMmY4dGYwRjlvTlNlc01Ba3lsYVFt?=
 =?utf-8?B?bHZ2QkhNTSsvRTQ3ZmJrd3FuSFdDQ2crcGxHeVNaeElyVGdtUS9YeEVWdW5L?=
 =?utf-8?B?ekNYb3pYOEFmSlBwNERYVkRGV0hXaUZhRVZTbUw1YnR3Qm5PRURVKzdlcm1l?=
 =?utf-8?B?NjA4NHJscjdsS3prMUl3cHRpeG9uZWFpOERmSnVHdzNwelV2NDNpdmJvdDBL?=
 =?utf-8?B?a1FJcFNLaks4V0ZlTGs2ekdyY2ExSnYwZmgyWXJrYmFGcTdTcXlWcEpTaFJM?=
 =?utf-8?B?L0F2QW92U3hYSm53SWVDMDM3bktFSXdHRTZwVk9iRklmWW1VZ3Z4dHVqeXE4?=
 =?utf-8?B?eDg3cE9qQW1qM3FqdVlBZ1AzSU4xaW55dndncWNBc0h4N1hvQ2ZqeGRLSTcv?=
 =?utf-8?B?ZGEzUXJqY0V5WVQxaWVITk43OE9SUGFyanBSUW4rUzk3YTRaalpsYWVsUjBj?=
 =?utf-8?B?RnRqaHh3dW9XQjZjVGVhLzhzWDZnNzY2VVVIUkZGN2YwazdaZmhIOC9BZXNv?=
 =?utf-8?B?Y3hZL05BU0ltN001S2poMUIvUHQyMXZPMlg3MTZSYUIxUXZvOWRzdXhLcVAw?=
 =?utf-8?B?R3RHK2pYWU9EblJRbUEyUTJ3ZHgrRUc2VzIzRHNFQzVFckY4UkNBWjVsNVBp?=
 =?utf-8?B?Y1J0NmRuQlZ0c2RpdFlvS2c4Y3c3Zm1EYmRCeUlZdWdNMmxaNStBTEltVVJY?=
 =?utf-8?B?QTRrQXhyUFk1VXVLMHFiSDgvOUoyS3RMeVpaUVBuTWoxQTgyZnUzbjg0dlpn?=
 =?utf-8?B?VGhicUR2Z2ZIRkRrUC9pMGR2dTlyYUdZaG1SK1VFTkJhOEtvUlNnTDNDU051?=
 =?utf-8?B?RUw1Q3RCNkY2eDZSVmw1ZUJvQ0UvYTJQU2htL1RLaG9JYzJTdTgxaHhHUXcw?=
 =?utf-8?Q?jSK5ehFrlg+fn6u9w57Ykao=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f79d81-722f-4fb3-fd8f-08d9da7ad483
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1242.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 12:05:33.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBQPgB+AdqqGLdzIgP9EiCbD1EIB7hLMqJ+9H61Jc0uz/cr2G7HU9I2ztN3xGrchjbbcBfsirAh84Hjo2ldGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/10/2022 1:27 PM, Sanjay R Mehta wrote:
> 
> 
> On 1/3/2022 5:04 PM, Vinod Koul wrote:
>> On 17-12-21, 03:58, Sanjay R Mehta wrote:
>>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>>
>>> The command should be submitted only if the engine is idle,
>>> for this, the next available descriptor is checked and set the flag
>>> to false in case the descriptor is non-empty.
>>>
>>> Also need to segregate the cases when DMA is complete or not.
>>> In case if DMA is already complete there is no need to handle it
>>> again and gracefully exit from the function.
>>>
>>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>>> ---
>>>  drivers/dma/ptdma/ptdma-dmaengine.c | 24 +++++++++++++++++-------
>>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
>>> index c9e52f6..91b93e8 100644
>>> --- a/drivers/dma/ptdma/ptdma-dmaengine.c
>>> +++ b/drivers/dma/ptdma/ptdma-dmaengine.c
>>> @@ -100,12 +100,17 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>>  		spin_lock_irqsave(&chan->vc.lock, flags);
>>>  
>>>  		if (desc) {
>>> -			if (desc->status != DMA_ERROR)
>>> -				desc->status = DMA_COMPLETE;
>>> -
>>> -			dma_cookie_complete(tx_desc);
>>> -			dma_descriptor_unmap(tx_desc);
>>> -			list_del(&desc->vd.node);
>>> +			if (desc->status != DMA_COMPLETE) {
>>> +				if (desc->status != DMA_ERROR)
>>> +					desc->status = DMA_COMPLETE;
>>> +
>>> +				dma_cookie_complete(tx_desc);
>>> +				dma_descriptor_unmap(tx_desc);
>>> +				list_del(&desc->vd.node);
>>> +			} else {
>>> +				/* Don't handle it twice */
>>> +				tx_desc = NULL;
>>> +			}
>>>  		}
>>>  
>>>  		desc = pt_next_dma_desc(chan);
>>> @@ -233,9 +238,14 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>>  	struct pt_dma_desc *desc;
>>>  	unsigned long flags;
>>> +	bool engine_is_idle = true;
>>>  
>>>  	spin_lock_irqsave(&chan->vc.lock, flags);
>>>  
>>> +	desc = pt_next_dma_desc(chan);
>>> +	if (desc)
>>> +		engine_is_idle = false;
>>> +
>>>  	vchan_issue_pending(&chan->vc);
>>>  
>>>  	desc = pt_next_dma_desc(chan);
>>> @@ -243,7 +253,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>>>  
>>>  	/* If there was nothing active, start processing */
>>> -	if (desc)
>>> +	if (engine_is_idle)
>>
>> Can you explain why do you need this flag and why desc is not
>> sufficient..
> 
> Here it is required to know if the engine was idle or not before
> submitting new desc to the active list (i.e, before calling
> "vchan_issue_pending()" API). So that if there was nothing active then
> start processing this desc otherwise later.
> 
> Here desc is submitted to the engine after vchan_issue_pending() API
> called which will actually put the desc into the active list and then if
> I get the next desc, the condition will always be true. Therefore used
> this flag here to solve this issue.
> 
>>
>> It also sounds like 2 patches to me...
> 
> Once the desc is submitted to the engine that will be handled by
> pt_handle_active_desc() function. This issue was resolved by making
> these changes together. Hence kept into the single patch.
> 
> Please suggest to me, if this still needs to be split. I'll make the
> changes accordingly.
> 

Hi Vinod,

Any further comments for this patch? Need your help to get this upstreamed.


> - Sanjay
> 
>>
>>>  		pt_cmd_callback(desc, 0);
>>>  }
>>>  
>>> -- 
>>> 2.7.4
>>
