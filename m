Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB58C3439BE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCVGlr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 02:41:47 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:24806
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230228AbhCVGlU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 02:41:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/Z69NFBh7HaGdkWgSdqHOfkk1GkxGd4k78RivI1xctAj5ug7mxtLK79GCdbzW2XqDQ3N/gf9F6W3lxDEQnNRd+ham98hKRxity8OAmyMX36aygKikZj4ZTklY8CDzgEqYJMXMrMjaw9I9vMFkCAjF8kOgDYsd1XKrMZZ7mqwoTQVpZVz4cRDpQHiucNR3jTHgWWTIg1uFGMKL7vC4zXqf295hYW4B0DpEB8lXN+C9b77eUHOoQANenO3cnZVkyE51sOOaH7KEc8+NwqI9hMjDZJ4cOfXeHkZyHSCBmCeTuFQc1DDcLiw+Toqf1AkIVmriqURGFVo/AnvClSL8+Xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ihVTUEsfydKWW7453X0txS9H3ABoU8eNY5tRLrmOo=;
 b=QiVC3QiTxx5e5AVKOOgslHqdS8YNIPiU8cAOFjI8jvhhdkyo5WNr/ANsvdqydW9npC+ivLsbFIeIX5PFCBCofEsEDv3AhsdFAYK8qeUw5qs94GxUFXFoxl78fYkOIK5+XEc85RGW2y7e7BalkARjWjbvUS10XZF8WPs8Wh3XyMDLyPsz9lV5JPdp9+zE6WDe6tP/u82qtipL5DCy0Vnhxd0MZIIVkEg21E1zZrOKXx2oUgmEG+kVaHhf2i3CN8F13sPYQD5Inw1VLPU1Q27z79GIkf7FkHhq/Lt5svU22QRtB1/mqFScfNvklisseE85b5SATDGsx1f/PTBXwqxsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ihVTUEsfydKWW7453X0txS9H3ABoU8eNY5tRLrmOo=;
 b=5OZpjRSmgH6XxXhQRlEgzGrP8Gfn3a30HHylrDZySXPVxQnbeur0VDdhhlYn1yHKimZA4Aej4uHy0pzMC8etr1ogshTyvYfFAUxSNMyAnakrGYFOZ9UzFg35w7I+AghVZm4tkJQiIOuCN2bnV5sJzp7tyA85V1QfsCOxQ8rt4EU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) by CY4PR1201MB2503.namprd12.prod.outlook.com
 (2603:10b6:903:d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 06:41:17 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 06:41:17 +0000
Subject: Re: [PATCH v7 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-2-git-send-email-Sanju.Mehta@amd.com>
 <20201118115545.GQ50232@vkoul-mobl>
 <5605dae6-3dde-17f9-35c8-7973106b9bea@amd.com>
 <YFgzgRK3ZuL/GRkr@vkoul-mobl.Dlink>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <a4108a6d-9122-eb22-46a5-cba98dcfd032@amd.com>
Date:   Mon, 22 Mar 2021 12:10:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YFgzgRK3ZuL/GRkr@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.157.251]
X-ClientProxiedBy: MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::27) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.36.172] (165.204.157.251) by MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 06:41:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6c1bc0d-3623-4c31-24bc-08d8ecfd7e7c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2503448A609C119672480C69E5659@CY4PR1201MB2503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPUMhVdcPeHTDu9pyFGLPmAZRtKbZR+lteBtKPiXtWsm43Yzyd9h8EfN70ZS2F3v3q6VloJ/kfErRMzDUQD7TsHgreXDFy7f5fMZt+1QfiXot4TsiUgibz44NHScTCPwyNmQN2Lwx2kgRSrtp9PFLypq/sbSAO1/Vve2tX76V3b4+FyJHpFAmTXE664o0JRnYa9e45bj8YVNtWPxWBfrseC9r16+8dzEbEf5Qj2JR0IBFBC0HMJfeFRFNz3mm8mSlf85Hwm6/2+PEU3LrQPLDg4ppZvgae2flBPMjlDqIWGB3FAH0/OG1Lz0Sme6RyIy/BPDZgX+jpc7fStYI8Nowqbe8Ix2S9afD3BwZR5Hjd9f98FmCL6QST9Fct08LsLkmDwU/F/fsv3u/v1HmPRqPGHag8bn199BsvtzsG4+LybwD4trd5Ovf0GHxpTViIupEGRqnTNSYwH2uBlO+Y7xYSGpsWQ1GOaJTmo4cVUPqsFD4VGdHq5EaFJLnyEESxPlviRcZD2GX/8qLZ89wrXdavK2nlXGzC9XFGZzN/8nPARq7vSh3k7X7XCuCfq7s0yQAOTPFPcq9YpSx6bELYKycArgpPgJzCv3mMiJZcr9SmdGjU+ED88l3yNybOPHrT8Ehf/FFpOis8effkJgKOZTfFq+0OGNOzCXx/Ik2kRC1KKjdYYxp/+zSqkoTwNE1W+gW3s0oFJ6MgKyZ/iIVixhI4Y4OK3kbekgSXGpU0+qb5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(31686004)(8936002)(6916009)(38100700001)(8676002)(26005)(316002)(16526019)(31696002)(478600001)(5660300002)(186003)(2906002)(36756003)(956004)(6666004)(16576012)(66946007)(4326008)(53546011)(83380400001)(66556008)(2616005)(52116002)(6486002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2ZmbDI0d1RXV0FDKzEzV2RoMmxTcUVlSzhDcmpMYURSL1FOUjJta29QT1Ny?=
 =?utf-8?B?ZUllUGFVZHY5M09CclptRzRUNFRhckxPZmRlTDV6RGQ2ZE9ObjBLZDNtWEpa?=
 =?utf-8?B?NVNkVER1ZWsrMkN1WVhGcmdmU1BZV0g5cDhNdHMrVTRJQ0RIVnJKSFRNVEFI?=
 =?utf-8?B?VFZ1MFJSQ1hsbXJQMzdHUSt1UWlTcHFScy8rdCtkWitNekdnK2xObHpNS0hZ?=
 =?utf-8?B?eVM4ajRoWFIzOVBMZXBPanZVOG1vL3Q2cnZkMGRlUGNPWFRQdGRaNjAyemMv?=
 =?utf-8?B?STlSOGdHVUNublJxdkY1RmZKcExWQXE3emhZOGY2MFIrR3Rscm5va1pWQ3A4?=
 =?utf-8?B?Z0djcGNWTVNXV2pzUTBUWmxDZXJaY21MZHhyelJUWlFNL1o4VE0wZGZKK2kv?=
 =?utf-8?B?UmpGZkJmMHd0dVk1Sk45YlVtV2UxZit4SHY5em55bnh6VVFwTFd3UXJYL2c5?=
 =?utf-8?B?aWhHdFRtTitoOWNtUWN3Zm5LR0tHTm0wd1ZTNUtpVlNucnpEZjM0V1RNQTBS?=
 =?utf-8?B?TmlKOUJlRW9TWkswSythUTVxQXVQbDFWaDZtVURLa3UrcFJQZUc2eXk1T2ZR?=
 =?utf-8?B?bnN4K1ExRktON0htcGhIbU5Kck5FVDFjbXhBa1lUQjk3R3BSVFlaUkx0ckNz?=
 =?utf-8?B?RDZiUEFCR0NqQXc3SS8vMUR2eGJiNGp2SVBmdXBEb3RoQnFWYnZTS2ZDNGJE?=
 =?utf-8?B?WCtDOC9naWtFMGtJY2t1enlZdXBIaXRmeW8vZUlCZTVBdUlaMjlyTmhWM2pP?=
 =?utf-8?B?dGRPSEp3MGlxazYrR3pweHI2cmVtNnA4TEFqTGFmMG9aN3RDQWRRT2cyclZC?=
 =?utf-8?B?WVF0QklkRk1uUnluVHBJV3JWUWNwdDNCeG4xcUlESXFnMWM5aERaVWVEczVO?=
 =?utf-8?B?WHJTUWxNVFhRTm9uc3VmTXI4Q3hCMGNFT2lpU3Rzc2xzd210UjVUeW5PMlp4?=
 =?utf-8?B?WjEyWXZ1cnM4L05oTFhEZzFmL3pGUWRVSDhrSVcxYjB6V2tVZGpRb3NlaXJ2?=
 =?utf-8?B?bEswZzhBWkU4YThKM29pbmlWcGhCUWRRVFVmMDFOUVJBeHoxZDJRUkloUm9o?=
 =?utf-8?B?NThWVmpBdU5PSmdsWEdPaWlHdlhYKzZWY2sya01nTUVPNTR3T25HRTJDbER5?=
 =?utf-8?B?WnllOU5EbnZEMzFYVE9lejhzWnJnZ1NZN2RKSC8vdTI3VE9vM21Kd21oVlRr?=
 =?utf-8?B?U3dlV2thZGRweTR5OW1kK3JBTmFtSkQxQ01Sc0ZDQmY4U01YYVlFYWFtSkRr?=
 =?utf-8?B?M0tPUEdWakVWY1FJZVprejkrWng2dE5ISll3b3J2QVl4RXhaS0puQmE2S3RI?=
 =?utf-8?B?VGQ2bWh1K3BwNWVtczlHOTlIdlNEdmpmdHUzNXRaSlUwNnhxL2YwMS9EdnFx?=
 =?utf-8?B?bXFhQnRoWWpsdTVDNzhtRTI1Q296MUEwUGZ0ZU04eGg4N1N5ZzRDcWt1dFRM?=
 =?utf-8?B?aTVUSHhKdE1uSGpCb1p1RHcxRW5ZUmxJL28yUU1zS0tJUXZMVWUwUExoUERS?=
 =?utf-8?B?bitsK2hYemZtT2tSMUY4WVhIZXRwaU9UbG0wbFJjVDZrVGs2dW5LSVd2cXFl?=
 =?utf-8?B?QUloT1BXT1o5eEhvVks2dUNETWdnVjgwQUE4L0RSN0o0U0d1Qyt3K1BEQmcv?=
 =?utf-8?B?bUNhU1ZZWWQxdC94ZlVlRCtUR0E5dlYzem5yeWZ2SVcwT0ZLcUdRcmFvNDVJ?=
 =?utf-8?B?L1phRTl6REJMK3h2OGRlT0d2OTE1YVlBYitLdFhIZExjeGpsWVRLQWdSczlE?=
 =?utf-8?Q?P0kkxRW/KXsZRAcvtkSjAZgyIdtqi0vC61vKAbc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c1bc0d-3623-4c31-24bc-08d8ecfd7e7c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 06:41:16.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swRQJz6kaFe+1mM1K7m1Oup1+nLHvXfamoJ0+Ed1vvr/dYPOdkKR+98llhndGtKg03n23mIXCnEsuoaK0zr6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/22/2021 11:34 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 18-03-21, 16:16, Sanjay R Mehta wrote:
>>>> +#include <linux/delay.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/kthread.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/pci_ids.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/sched.h>
>>>
>>> why do you need sched.h here?
>>>
>>>> +
>>>> +#include "ptdma.h"
>>>> +
>>>> +/* Ever-increasing value to produce unique unit numbers */
>>>> +static atomic_t pt_ordinal;
>>>
>>> What is the need of that?
>>>
>>
> 
> [please wrap your emails within 80 chars]
> 
Sure Vinod.

>> The "pt_ordinal" is incremented for each DMA instances and its number
>> is used only to assign device name for each instances.  This same
>> device name is passed as a string parameter in many places in code
>> like while using request_irq(), dma_pool_create() and in debugfs.
> 
> Why do you need that, why not use device name which is unique..?
> 
Can we take this as part of bug fixes series in future?

>> Also, I have implemented all of the comments for this patch except
>> this. if this is fine, will send the next version for review.
> 
> Am not sure I remember all the comments I gave, it has been _quite_ a
> while since the feedback was provided. In order to have effective review
> it would be great to revert back on a reasonable timeline and discuss...
> 
Apologies from my side. I understand that I have taken more time. But I assure it doesn't happen again.
I have already sent out v8, can you please have a look at and provide your valuable feedback.


> Thanks
> --
> ~Vinod
> 
