Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7C3A9677
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFPJsW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 05:48:22 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:36577
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231468AbhFPJsV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 05:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXm0IlNHP0FKtTHzAcUvzxjYC8FZc4mYkzfjgMHzrmCm1czCf2PHZNRVg3H+Saf/2uy2TDHjsYBVs5WURyXzbbTTNyD7ieVLLYhEjpmsB9XtSA/8awvj/MWVuw7sMeQ7Rwxpkd81ONmb45Ny7XVHOj+2L+ixeEcK7s7P/3+9njJAFxdPDNFNxk/gS/47xk/jQfULyoxGTtKeMnDpwivevzckIDzINFQWJB8xvLi66i6N0lJh+WPclhwBZ4WQ7j9oNbuKC71gdiLCuQAKSAaoz00EHFhwaOUjlBrzyS5v6JSrEDN2mDjHWz6olcNue0hJSFDTVL0zxp9TTOS3G/QO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c68nZpflBCfcfuLN/FGMuczdGmOJEnDTwCtkNm8is/8=;
 b=oC3rSShLZX0fT7etd11GGo1jW9NGujhvkvzpHu3W9SnRTz6iipyeBoThSBC7hdd05Kbp5dWJS1r2Arv+c5feNOPRuF6hd02IG1gNrGzTgT8wN8vB+ou8VuOyvYSJjRgS1Jtt7GUev3zgWFcaN0U2EUrkALZPCLYoFTERZqLLg7pITJx2pcFOnJamlZPMafwtwomdr04hLR5ten1Xun1u3toEzMjBJAFItn8WiQT7eFUwDkNElXF/OwEv781HXKD7wEeC1wcJ+u510fxoIaArJ15RIuq0YygH6wdMcYC1qqNWNTBoabRMFuk3Hl5+p/po+yF+Fbm8W4Z2VSec+FxnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c68nZpflBCfcfuLN/FGMuczdGmOJEnDTwCtkNm8is/8=;
 b=xzTOgDpdkbTxqRgSbO33qX5Zv4o1mvm4ISVtG7mp/L20h74KZR47uUxLrLSYjuKvXBzIIity+WbAbr9XVXmWULL8P4IS+3xqtxk3tBQHjv9N/EBmXxOTar2OZj/nM5zMOm50Z6ak9TMfowKR/Hsq+YbMzU500Gz/HjfiW82Js+M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 09:46:14 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 09:46:14 +0000
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl> <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl> <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com> <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl> <YMmvZBP9QNc5jf5L@kroah.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <de2443c1-4739-6172-9ac7-76b002ad1244@amd.com>
Date:   Wed, 16 Jun 2021 15:16:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMmvZBP9QNc5jf5L@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MA1PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::26) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by MA1PR01CA0132.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 09:46:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9dc5123-4edb-4f4f-0c78-08d930ab9499
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50390EBF95B8421F3467F776E50F9@DM4PR12MB5039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLDh0tX8zRUloDJoYiwdaJtSyHNJi1xPP7VfDQi36aGYWoZT1jnAhCO+wAFeBXX+yPpTPvIC0kFpPGqtfSH8DRuZA8msm9QHx3zlfCY9nT6NLATu6VPzK3DmWJrsKCKdfgnIRWkkH6lk5skdfhOyFtccDuPw14/p+/7haVuOIkZ3WoLCs+ouhfwwx/Kkvlq2CKMCyMM9rD56Z/fMDceRyqtKynkkQxRY8Qvtvq00ppXGYdnXJ4LONAo80Ee3OL/EMmJF74etjX0Y0WQT1B5CZnhBVUIogHejPjLpUKhjXKKt/uOMjITtqCGL9x7YzoodqZK0taLrLO6su5B22q2/V26eXfU4OnvJAT9Xcs1TotNaRr5Xszw4PhAE/MN6teTbW0/nQlUuPV1t7E+fWmNT9VEzhR1Tj4nQTGtZv6z/UkIUQkgvDcfNXjWLeEt3UFFxYY3Fmx3AroYZRduh/u+L4TO/PLMsw9/yZAfEXUx2CZweDlM39Cd3g6n3TB/j/xE3YwRwvUo7mXGKg5U1zyXd9xInws8DQbeX108Hsi5LKAMrDT6dKDuLmGZbhRmAWrwUnic9Uc9oVkEBOqvdNB1/a+9LOdMYb7dar7/SeKTAxfLjfskD+UcXVxhF/P46blrN1/02XCMk3pBdVkRQR8q0AtEXIx9VjxTvScLpDoIwxHHk4ioyoQR6UBl6ggYPtIEB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(4326008)(8936002)(316002)(83380400001)(31686004)(956004)(6486002)(2906002)(53546011)(5660300002)(38100700002)(2616005)(36756003)(8676002)(110136005)(31696002)(186003)(26005)(16576012)(6666004)(16526019)(66946007)(66556008)(478600001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZHbHJZRVRFUnhRWmJsMEVmSE5CY1dIanBscnBLMDdtL3htR2QyY2dGb1Bk?=
 =?utf-8?B?NFRCMXFQTGxlVnQxRlVhOWtGcXNMZCtRV3EwYmdaR092L2lmYmd1QTM5enoy?=
 =?utf-8?B?cDJFWnRPZHU5RFRnSnlRUWtaR1dySWM1c1pWQldIdFZFQnNjakI2VWxMRkJP?=
 =?utf-8?B?S1FOSnFCQk03enUvQm5KN00xbXVyVVVnR1k2ZDgvRHYvMXZUL2Z6eFB0ZzAw?=
 =?utf-8?B?OWFvK1FuNno5TmhiQ2xlQXE1WG5DcFZmeldzUkpXYjRNa2daREVBOU8yK1ZX?=
 =?utf-8?B?OVhJTkRlRkkwZDlPTi9NWkNZaUZ3a3NUMllOa2FobGpMMlB0amVQSno5cjBH?=
 =?utf-8?B?ZnpFVGJZQmlYRHFkUk52QmdtdXBVUG9ZVUUwNEZlT0FsdDF2Z2hNckNrRTVD?=
 =?utf-8?B?S01BYXhCdGdzc0pOME54TjNJcFZ5bHE0b3FvYm9kODcyakpuR0xKVU1LTGdz?=
 =?utf-8?B?dHhLK3pmdHp4NjJna1JaV3BpdVIvRzlNc1dOUElXdTNyNDBNckVuMUNySlpT?=
 =?utf-8?B?WTc0ZVdURkxWMjFCdVRPSitYdmVrSnRvSE5QZ1BUQkk2dnNGSFlMdGlIcjVa?=
 =?utf-8?B?S21RYkROTEp6QVplQWk5SEMvR0ZFT0MxTmVwSndGTm42b0F2V0hucVMvb1dq?=
 =?utf-8?B?Ny9IR3FYTGVTajR4enJqa2ZqYjVkSmNMREJ4WC8rRHlKbW9ieFZobHB1V2V5?=
 =?utf-8?B?TElIR3hSSmlYMTAwTjZDblowQmJDRkxEVTF3MHVlaXlKWXN4dExFZTJsOTAx?=
 =?utf-8?B?TzBydWZWK0JnZGYrOW1qTTdqYkhwQnV0WGpPdUROQ0g2ZFRqbnl2QTJRZDB4?=
 =?utf-8?B?VmxXSkh5a0VadS9JTW9FcUpGZEdwV3hKS1J3Z0ZIbHpsVVZQZ2hDa2JyVEll?=
 =?utf-8?B?VWNNYjJSUlJubS80bnRyMDdKSWlKYUJ5eHpOQTRXK3IrdFF6dHBXN0p2OGRq?=
 =?utf-8?B?V1d6NzM3VTZ6cTNTc0xMVUs1TTdTNVplZXJ1U3FoYXFWM0xSL0FzYTBDTjJa?=
 =?utf-8?B?WHg4MXpaT3d6aytGWHZZSGV5eHZaRFVYcFNNdlFnYXltM0p4VXFGeGZIZGdY?=
 =?utf-8?B?M05VWEtXMzZnKzVYR0hvZk1ONW8rWVJoNmRzTUFEWG1DN0FQaGZ3MGJ1cmMy?=
 =?utf-8?B?THdxWWVUYnBXd0xtTG5sRlgvN3B4NTdmWm5jMjFGRXg5K0JzZ2tqK3ZDZWZy?=
 =?utf-8?B?TVhhRC9vTkZ4STRKRnRLTDhZdHFzc1JYZlFFdExRcUpMZVV1a3M4ZHZkbDhs?=
 =?utf-8?B?V3g3UTcxcy9tR3ZGaFNkQjhvUTYxS1RCZmxxZG5yTm9aT0xRdVJmR0pUdmE4?=
 =?utf-8?B?eDlvYUNDZzk5cldoa1N6QXJHTnYvT243TTJoMlliL3M1QksremtlK3BaU3Aw?=
 =?utf-8?B?c29BWXJiY2VIczBPZ282WnE3bFZySW9sM3VxdWo5S2RKL0orNmx0aTFhYjVw?=
 =?utf-8?B?T1E3THYvUklJSkNxZHdtOHNZVWo4dStXMHAyR1E5WmdRQWJ3RDkzSmxIWTA5?=
 =?utf-8?B?ZDQzVGtMalJBVElRMlJhcVNTaVBaZkdNVmViNWFTblFVWGZJZzc1TC9KanNH?=
 =?utf-8?B?dGs5SERRc1FBRzV5VnFQc0YyWXdNQUN0RFZKTHRxSkprUG5CcmorYlV6Zmha?=
 =?utf-8?B?R2d6R29CcUpVY3c1SU9sNk9jQkladTk5Nmw5TWh5UDliZTVFaVJSNlp0SXRt?=
 =?utf-8?B?bG9PUFJGQW9rYk1QZDFaRmVDWDBHYWZmaTVBUmliTUlkeVNyN1lDRXVYYzM4?=
 =?utf-8?B?bi9YOE5ieEpNVXFqZnpPeitBclI0RkpRWjd1SmJ2MzgzK0tkWHhub08rVW9I?=
 =?utf-8?B?OEJ2L2YrTnd3TU11aUZZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dc5123-4edb-4f4f-0c78-08d930ab9499
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 09:46:14.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnl7DCxReyEHaDBHA68bgUTIX5+/8ZPa/D3izWpiTAdU+cH8qdJr3mGZwKojrUEULULNDJtYLCB2CBMF88qvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 1:29 PM, Greg KH wrote:
> [CAUTION: External Email]
> 
> On Wed, Jun 16, 2021 at 01:22:54PM +0530, Vinod Koul wrote:
>> On 16-06-21, 12:27, Sanjay R Mehta wrote:
>>>
>>>
>>> On 6/16/2021 11:46 AM, Greg KH wrote:
>>>> [CAUTION: External Email]
>>>>
>>>> On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
>>>>>
>>>>>
>>>>> On 6/16/2021 9:45 AM, Vinod Koul wrote:
>>>>>> [CAUTION: External Email]
>>>>>>
>>>>>> On 15-06-21, 16:50, Sanjay R Mehta wrote:
>>>>>>
>>>>>>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
> 
> In looking at this, why are you dealing with a "raw" struct device?
> Shouldn't this be a parent pointer?  Why not pass in the real type that
> this can be made a child of?
> 
> 
>>>>>>>>> +{
>>>>>>>>> +     struct pt_device *pt;
>>>>>>>>> +
>>>>>>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>>>>>>>>> +
>>>>>>>>> +     if (!pt)
>>>>>>>>> +             return NULL;
>>>>>>>>> +     pt->dev = dev;
>>>>>>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
>>>>>>>>
>>>>>>>> What is the use of this number?
>>>>>>>>
>>>>>>>
>>>>>>> There are eight similar instances of this DMA engine on AMD SOC.
>>>>>>> It is to differentiate each of these instances.
>>>>>>
>>>>>> Are they individual device objects?
>>>>>>
>>>>>
>>>>> Yes, they are individual device objects.
>>>>
>>>> Then what is "ord" for?  Why are you using an atomic variable for this?
>>>> What does this field do?  Why doesn't the normal way of naming a device
>>>> come into play here instead?
>>>>
>>>
>>> Hi Greg,
>>>
>>> The value of "ord" is incremented for each device instance and then it
>>> is used to store different name for each device as shown in below snippet.
>>>
>>>     pt->ord = atomic_inc_return(&pt_ordinal);
>>>     snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);
>>
>> Okay why not use device->name ?
> 
> Ah, I missed this.  Yes, do not have 2 names for the same structure,
> that is wasteful and confusing.
> 

Thanks, Greg & Vinod. I just verified with "dev_name(dev)" and this is
serving the purpose :).

I will send this change in the next version.

- Sanjay
