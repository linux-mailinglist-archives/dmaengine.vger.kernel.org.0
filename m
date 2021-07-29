Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9349A3DA0E2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 12:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhG2KNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 06:13:04 -0400
Received: from mail-bn1nam07on2058.outbound.protection.outlook.com ([40.107.212.58]:32901
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231488AbhG2KND (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 06:13:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJnbky6JtX4663ppdG0dmWXLB266rV3RGfoMi6v4Csa1rh/WqGHtuYzJVXRR5ARLgZdjKvZGkc/y/CzS27BOsJ+KKMkzUW8xMY4hL159HyQyZLdTgLZ57Cy3ryuHfUc+CncIEcxoH5UqEWlWlHROXxhQ3dVIiO98r7Mi7kGs5VzvyCawbGIDVs954ccca5pLqJbdBou38wZAs7b45JckySYD/KToWPRNO/fIl8Wwdm09rzUZ+b5Bnn2N0yPQhP8ldlNIWklevY4u/xoD8MSl2T+T9FfcleMpXXiIf8S7qQg8l4P8h12xtgg1Wn7LyUDqtLiZbiVWVNrYJQIOgRIjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VzxSlYk5Cqro5ij9API7cbIkton1xzILQo21X1aO/U=;
 b=lxQ0qqZtyG+WySklgLe2i2UYwEpsCaNegaABCALJJkH3iPImnvbUxwfiVMbVK/4JiKRDm3XeEaD5BKfB4/YvE4toAQqIG0Fc7opPn0uvDuvWs/5DMy6cihoSAqqFWy9LD1j41O0GI9rORHg1LDgUxpb5PZRABdW0IYiI/mcv/Kw74b7ypTACBfhi0euyo69REdMCpGhON+d5cJ/padaAQ0v8od7PJUVMNunL8YPSbtB+1VNlCF7FZKiV5M9inyz3fyAv4rCbhMezqeUkwngn7rcCkkqzQO6Pf7RMFWSa9R5ml4seBI9bUt0pnuDQg/jBFV85GsS2Uf+mJsA+w3VjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VzxSlYk5Cqro5ij9API7cbIkton1xzILQo21X1aO/U=;
 b=gw+iiaHmGYvLkUM1L3S/sPG2WI+1Tbg/98q8suwKVuwD424NU0xiWtlOJ/LxKpFl92IT2fexDRiaSxqjcG2KKyBDr7njM/d2sv+wvBy7s0XeaC0u5xJoXis7D90QPt+fK6Vnj0pfL7HepSz/zaz/c0yD4zQ/KlePWXYVOfYKp/4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 10:12:59 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 10:12:59 +0000
Subject: Re: [PATCH v10 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <1624207298-115928-3-git-send-email-Sanju.Mehta@amd.com>
 <YQD19B4A/l/ZyySZ@matsya>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <368f7d3e-bdb1-ea9f-de70-285280420706@amd.com>
Date:   Thu, 29 Jul 2021 15:42:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQD19B4A/l/ZyySZ@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:820:c::17) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.71.123] (165.204.80.7) by KL1PR02CA0012.apcprd02.prod.outlook.com (2603:1096:820:c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 10:12:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c420410d-b22b-4ca6-5be0-08d952797116
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB505509F827B5FA18AC2A06B7E5EB9@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DknASLUZUgPDkwzxkw50NsGTDZ76/IBQOs5gMy/VsPjqJ0dq62ej9WhNYp9UlRhflPkG9ATWSxAwbkAiqanbaDTKmjdr6trj8uzVRSm3sWdXloOfmzXYmYs7cW9WJd4nWYMaC8uVYDLFxzowgz/It3qxTStDnPtX3MXsbgiv26vojqv6BsmcNARMsXffRft9vjnLUVFphOej3dRmTPLUzmkWu2GJemBEtRWspw7iqKJPb2Zx21Ikqfq01NdSY7mJpXrEt+7Axo/jq2Mdwv6yLDR6nMU3AovvzpGMcvrEDep03cA3zO+TpNca8ZzKxsGcvjIMrEwvoU/1OhpZOii1jYprgIEOHBGl+RNNH1yZhjniYi+0dilQBhuJnzDrMnmRN9BBYvOjqFDu4eZnmUV/1cWNmfjEm9isXGD1SSYsceeUhwZEjXaHmWL7n1slklQC1E8QvNaE93GFKiGosZqPZD6T37mbFc31UuDbiBexrkjs4VWEzYWgSQ13rHT8BLeWso+qbhO1L6FQMSR7KdnYoVHILLuKTmF8zDyesCMO2U56Ds0cpDC0Gqa9LhOQatCW2FTjILVjzaLeeVlpuAQkFtbQvYN2gquYaNVc1+Znkjt+QtRb/NfDt9nWaJwHNa1nmVYLc40c1/yHNv6YRsiwl4d7mLK4lkQgni2lPp7kGXoEriEiRczziztjtGorj/3J4OTYmg8+iKweA8o2zFs7hIQYo4N/KVXGryDJlUNnReA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(4326008)(16576012)(478600001)(110136005)(83380400001)(36756003)(6636002)(31696002)(5660300002)(316002)(8936002)(6666004)(66946007)(38100700002)(956004)(53546011)(31686004)(2906002)(8676002)(6486002)(4744005)(2616005)(26005)(66556008)(186003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STQ4NGFnazB4NUFJZkErT0lRbllUQzJTWTBmWVA0Q1ZoNmpzQURmUEhwZWpV?=
 =?utf-8?B?Y3UwU2treUVGYjVEeU1yTmxmNnROeDVwUmZKOUxvVnhWcnJlUk1ya052TGRh?=
 =?utf-8?B?Mi9XV2tMcGtlQjM4c3p1eENPV0ZGb1ZVYjkrOVRtT2kraFN3SHVHOWZNUlN5?=
 =?utf-8?B?bjFEZVFvSnpIQTJKdHlSQjZxUnF5cWU3VWw3ZCtHa0txVXJtNVl1WTJCd2NP?=
 =?utf-8?B?OFZiaHlQMkJkajdPZ0hZTEkvazlsejlkb3VSYXJtT1lGdTdtYm1lWGRyMVdl?=
 =?utf-8?B?K1hnUEJ0c1lGcHhBbmp6VnRTb3Y4OW5OK0dRYjMxdHVYNWhLQTM4TnhJU1pz?=
 =?utf-8?B?U0YzZGsrZmpSTFZlRm9FWnp4N1pMVFA0M0JxQlNyQ2JRYWxsei9VL3NUZWc2?=
 =?utf-8?B?WFptTTA5eE0wQWY3WDdEa2RHNDdTU0J1R2JZSVZLUjNWYTZRMXE5RmgvVG9h?=
 =?utf-8?B?V3RlMEQ0eUlmZDE3MGIvNXhVc2F6eTBtRzNTVUtNMEVSZkFRRVBwZGpOL1RN?=
 =?utf-8?B?NUJydEZuc05jem53L1ViMHdYTUJ0ZXA2SlRsRzRFT2FEVlpYcU9KQU9lNnky?=
 =?utf-8?B?TUNuMFBERWI0dk5HK0U3UmV3VEJZS3BqL2VqMlV1RWVIeTZ5VVBlNzR6a2tt?=
 =?utf-8?B?Wi8vaW02b0pPZ0xIcHdNV3oxQmhwSFVxZ1MxTWVHTmR2VURmeTV3WTFDZ2Zz?=
 =?utf-8?B?MGROdDdNNE5FYW9MNEVaTFJYQUE5UmRHUVVwZW9Gb1VLdldXbVkybTJ3Wm5K?=
 =?utf-8?B?Wmp0TGVOdWpMcThVaENBTG1xcmt5TkM1ak9sMmpKc1ZnaDAyYXp4MGdlQjJn?=
 =?utf-8?B?QkFsUzhHR3Q1WUxiNWtXc2M1Q3RWNWJwRlVGVk01a2hQa1hmNmtITzl1TzRx?=
 =?utf-8?B?L1NhTlNrMlRGN1hzNS9RMGI5WFMxamdCeXpXR1IvQ3NKVVhGMlhBS1JWNVBl?=
 =?utf-8?B?dnZJVVhiTzgwL2s1cmhNeUQ3c2d0bUZIVnQ3Unk1V1JuVmc4ZElta1Y0WTRl?=
 =?utf-8?B?dVVmZlhMWkhVNHdQSTdHbkFLandHd3pHQnA1dENrRkE0Mmd3UXo5THR3aFJk?=
 =?utf-8?B?Nm1GcnAwZzZkVVFxTjNxMmxoeXRZbkRmeUJ4WEpwYmdLcWhLZnk1UUVoS3V6?=
 =?utf-8?B?MlMyMzZPRE43UnVZN1U2T2ZYdTFWQXRBRURUREx5S3R0NXE3Z0VtZHlGc1ZO?=
 =?utf-8?B?ZlZBNWlDaWhndFZWWG5mUlA5d3RNS1oxOVpSdG96WktjcU5oK3Y0V1I3MDNs?=
 =?utf-8?B?d3V2QzB1RTF6TkFxZGpTK2RlQ0hxUzVhS3U5YUs1ZFFoRVVCUXhxMmYyYzh4?=
 =?utf-8?B?b25sL21IMGRua28weCtsTzNBMVRnbVZXNGhYZGZEcGc0TGk2ZUlOSk9nbk0z?=
 =?utf-8?B?OG1vOHh4cUV2YitnUHlVc3NNYzZocnBZdE9OZklPQW0wclZ5VHZYaUQ0OFFM?=
 =?utf-8?B?UThMVTZvZTVnaE51cEhiaHAvYkljTnBhMnJlUEc2cTZGY0ZhZ3pzc1MxN3FI?=
 =?utf-8?B?V2lXbnlWYnBSS1lzUXZLNHhKTE1ERXdEYTZlbXlKZDhMYWtPa3p4OFJCL3JW?=
 =?utf-8?B?NWlSSlpaMWFyVVE4VjBqeEcxTUN4cU9WbkhqVXZqTmNRQmZ6TTh4WVc3OFdk?=
 =?utf-8?B?a2NVczg3K0JldTVTQ29PUGQxWFhBdll1YWorb0pYZGpONHJlUXI3RkRWb0pj?=
 =?utf-8?B?eDZub0RvbnBSNzRzTHFOSEVYWm1CcEsybEFUamN3TlpobE9Weno5YlY2dnlj?=
 =?utf-8?Q?cwDSsCbpQlrLJEM+JIGpMyS6FlTfjZ0YLkqOBM/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c420410d-b22b-4ca6-5be0-08d952797116
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 10:12:59.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bD93Jc6XVNymJzzifVm58GJ8JHYZDNj0TpF7L2vQnqq6pOgRD01FbgIXwTcUd5clpKhbM+aPCtaOO/WRSEPOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/28/2021 11:45 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 20-06-21, 11:41, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Register ptdma queue to Linux dmaengine framework as general-purpose
>> DMA channels.
> 
> Mostly looks good, one question below:
> 
>> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>> +                                          unsigned long flags)
>> +{
>> +     struct pt_dma_desc *desc;
>> +
>> +     desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
>> +     if (!desc)
>> +             return NULL;
>> +
>> +     vchan_tx_prep(&chan->vc, &desc->vd, flags);
>> +
>> +     desc->pt = chan->pt;
>> +     desc->issued_to_hw = 0;
>> +     desc->status = DMA_IN_PROGRESS;
> 
> where is this descriptor freed?
> 
This descriptor is freed in the pt_do_cleanup() function.
pt_do_cleanup() is set as a callback routine for "chan->vc.desc_free" in
the init code.

- Sanjay.

> --
> ~Vinod
> 
