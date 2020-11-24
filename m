Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF42C30CE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 20:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKXTmv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 14:42:51 -0500
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24961
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbgKXTmt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 14:42:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8wvPaJJLwh0rDoPnz5E7nlwI1ENl7d4l1sM8USDG2cj4scNP4Y5RwUYmOe0US9bNuF4qFdnJ0/gZxU6muqZ8zLHp3GRcrLY1gNuLkPLx07Jc8NuIPR9uR4vHW4H6R8/fHP3b3aWBwDZQfKXOOLGF8o9x/lHl+YeKYDWKdvekMUPPhmVrpaLy/y1oC7+thgMDVq/kM0zYcNzE4g1Z6G63RLyfezs5nplQLNyo+bwueJ+H+C6S6CJd1AeWdy4uhALmNVypiuka8c8AAi1z25SoVPifd+BZsBXKkxBmUrNy9emX+pSacRaustBR+OVOwwDCgbR94x1K4xLXHisFeowJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D/oQp1sOAnYxw+2jgiNwTSfzJcIut6aq2DjOqPIplA=;
 b=XkwXCVfA65frLDbAL4qSpr8qhCBETmJfrFTdGBptSffAKsAWzZIoR4/WoP00Cn7iR2f+zo4jC+0tzyTwYx2S95gedEgdJ4EmBUNjZxciU9KG5XYEs833hvRXmBzobf1I+gKGDrVSKJ7lK1jlkAcFTK7RTLjdhH7naJ3EonaNopD3+13zQ34tWObNqd2b8uxVn6xWt2icTBAynMJ+auKKcTFUK2s/vTfH26zfK7u3qZjSZEX2XYuWtiU250IaJ0aTlJOJzXdcZfOOHxgyeRx08skK5lgz3TR6EpNWeml5h+Ocr5X8Osc0TgCSNx6ykcy37a5txV4843OxRcgkyeyfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D/oQp1sOAnYxw+2jgiNwTSfzJcIut6aq2DjOqPIplA=;
 b=J8d6ZKt0d87vo2/5niEJJ+65jwjaRyIr+kA8v37PD1qsH4OQrc59Rr7vTcW8uOkNvw8R6LiBOBAmaYEVIQBSeEeqldP81CauLM89wvuEjn6csTmMWoT1WNSTV12eWymbBB1QQEcTEzDLBHDhH1/Yxs2LCmu488fgbUDMyrM666A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 by BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 19:42:46 +0000
Received: from BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::e552:71a1:999d:e411]) by BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::e552:71a1:999d:e411%7]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 19:42:46 +0000
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>,
        Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
 <20201118121623.GR50232@vkoul-mobl>
 <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
 <20201124171813.GS8403@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <4025c706-f33b-4a29-b9c5-81c023d6bf8c@amd.com>
Date:   Wed, 25 Nov 2020 01:12:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
In-Reply-To: <20201124171813.GS8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::25) To BY5PR12MB3956.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.71.123] (165.204.80.7) by KL1PR01CA0037.apcprd01.prod.exchangelabs.com (2603:1096:820:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 19:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6227b8-2b8c-4091-8943-08d890b11dcc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3222BB2F67BA14855964824EE5FB0@BYAPR12MB3222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpIdQ+0hpdmYWi9PAEsnHVNAC4jgLYkg+Tw5cg7pq9vxtnetNYhZEGmtyl+RAWLfXMaLPgfnY5zS/VSEoJQzADJDFdlFDXB+xZ14Aul1wTlfhmL/hrhlP1wlEIzdTcmp2MaxpIwC6+aW63gvmUwYo655EF4UvM1jKh1F8bMhOSe+9sC+Ku9H5YDwt7LokPcBhJH5+VOeNu0torFa+ZUL1lM0Dk1wAlwF6sTkSqcldu15cEK+a6KyV4RJ0Pm6a63qpmtsCAIb1e6bZS3J4IVyLVGPYULpqBoeQ98QBFHdw1NnSN9UG3AoCBJ3biEqjHS9GNfKVGsGGB5rLKrGpfMjVnmoKFWMjRp85I1E6ToTAH9oJOKoqVqiAoI/O5zj4JUh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(36756003)(316002)(4326008)(478600001)(5660300002)(8936002)(2616005)(186003)(16526019)(956004)(6666004)(53546011)(110136005)(52116002)(6486002)(16576012)(8676002)(2906002)(26005)(66476007)(66556008)(31696002)(66946007)(31686004)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjJXNmlXTldTL3F4R2lhdjFqTzhybHlzQTlxaHo4TFRMdG9idnZwamtqRnVr?=
 =?utf-8?B?aFJReUxhTFpXazRwUXo4bG5ib2JjaHBrME4vaSt1UG5CbVliKy94TERyRlBX?=
 =?utf-8?B?aFdaaFV6ekpJRjE2UHpkeEFlUDQzNnRaM2d0TGhqRWt3M3VIZWQ2THQ4ZndU?=
 =?utf-8?B?NnppL3Zoa05YT1o5ejBrdmQxeVhLdWRZejAvTDdoWFl2N0RkOUQ4ZHJXdk5I?=
 =?utf-8?B?aXJtMUJ2S2w5L1NmZFRKUkxRNDNvZnhWZWhTb2l6V2dEajRhU1JKZ0QxMUlU?=
 =?utf-8?B?dlo2N3JvTjlUMEUvRUpGbjc2eU8rRVA0Y3FsMmJFN2JJVlpBYlNhNXp1bmdZ?=
 =?utf-8?B?VFd1NXZJb3ZJdE0xb1JHeE1VQkMxWldWaXVmbkVtN0Y0VTJPeTExQW12Zng1?=
 =?utf-8?B?Ui9wa09zeitucGprV0gvbFBwc0l3ZHBMaXcyNGMwRjdpMDk5QlRVako5Ukh0?=
 =?utf-8?B?NU80N25pU2pxZ0xraUtEQy9WZ0ZudXdBZ3IzY1d4SkRxNG1ocGs3TDRNZFVB?=
 =?utf-8?B?emEyZ2hUTlhLekNzd3FBUmhQeit5KzZELzRRZFpEaE5tZTZJMm5hSVJoNHNs?=
 =?utf-8?B?NTFPSHRIQ2dmYWRpNzlHdXJ3Zi9Ka2xwc0k4M2ozRHU1QWIxSjduSm5vdHV1?=
 =?utf-8?B?dnl5YVMvQXdzNjk0Y21Ob1RUZlhPK2VjUG5TVEtXQTIyclM5UkhMMlFxbXBV?=
 =?utf-8?B?MHJZNHBFZmpmRVBnZzBMY2c5OGc2dEUrVGlmK2IzMUUvdzFIYTdVcDc4TU5P?=
 =?utf-8?B?eE9QUXdlQ2NlQ0pJRll1QnlsVzBSNFYxNTVacXFBaG1BM2xuZHB0a280TUFE?=
 =?utf-8?B?cm9MU3ROMGlYR1VyYUI3TWFVOEFULzJLendRSXVaaCt1RW0vNGtZOU5ua1Er?=
 =?utf-8?B?S1MzTzl2UVdhVk96cVhPazJFM1BsbHBkRWJVVzVud1NRS3IxQjZWbW16dWFQ?=
 =?utf-8?B?aE00dm1iaUhXUVpZWlF4NlAyVlFhaUFNMWIrOE9acU1YSWNPd3lwSDNmYjBL?=
 =?utf-8?B?TVZvRTFMTGMzemZRbkxYejFNNkFlY3YrZXMzWGl0S1F6S05yampOeThZUUdh?=
 =?utf-8?B?RE8xNGNCT1FrbGU4c1V5U0pmTzlPSEdlN0htQk1GS0RXcklab1grV1VRVFI0?=
 =?utf-8?B?bCtGMUhkUVRDeW5ZNzlIemFmNWVVR2J6Um1ZUVVwd05MWEY2VU5oN3pmaWdj?=
 =?utf-8?B?aFlDMWd1SllaK0pNckJWcWltZzZRMFFPOGQyVTIxaEJlUkM5aGlwR0ZIRjFR?=
 =?utf-8?B?UFpwRWFSY2pEdjJrY3REUDdZSHY4VExxeFpJbFl6Wi8zSjluVHZJSXZhSzVM?=
 =?utf-8?Q?z9C0ZgYGBxhSPWaFBQB6OlQElmnibjIJyJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6227b8-2b8c-4091-8943-08d890b11dcc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 19:42:46.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu9lH6QyJJREuQbIIcomMNpv5CC1OP6OW6yiCLHqKho0fUkquoDpNfrqesOw/oy0JlvirX+miHTCPYtooEBuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/24/2020 10:48 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> Hello Vitaly,
> 
> On 24-11-20, 09:23, Vitaly Mayatskih wrote:
>> On Wed, Nov 18, 2020 at 7:20 AM Vinod Koul <vkoul@kernel.org> wrote:
>>
>>> this should be single line
>>
>> Vinod, do you see any obvious functional defects still present in the
>> driver, or can it be finally merged for us to start testing, while
>> Sanjay is working on improvements and style fixes? I'm sure the driver
>> has hidden bugs, as any other piece of code on the planet, and Sanjay
>> will appreciate bug reports from the actual PTDMA users.
> 
> IIRC there were few issues that I would like to get fixed before we can
> apply.. I hope authors can reply to the comments received and we can
> discuss on this.
> 

Thanks Vinod. Am working on your suggestions.

> --
> ~Vinod
> 
