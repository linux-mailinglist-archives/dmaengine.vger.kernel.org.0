Return-Path: <dmaengine+bounces-2003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBA8BE71C
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B11282327
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F307161313;
	Tue,  7 May 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezXgS4Hn"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93771607BA
	for <dmaengine@vger.kernel.org>; Tue,  7 May 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094867; cv=fail; b=ks4/qLu2rUDefBWIvC361CIyaiZgpig3QPzei9x9So9jp7EI9ta9pzMwIYQVyRRqc5/qwIjH5rlh2a4wYUAtdf9sjuMM1hR9P9ArZdRj13slFM/0siLxhUaMWtxPNqmB/Bxv5dIxCSLEpZ+8y4zBz2odTQWUFvTA+Ybu+dntjs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094867; c=relaxed/simple;
	bh=QJHGjdMH6A2O0K8Fe3YwueuXItW7PVpJG6Ky2r1kBF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e0mf/FwNMgSAV4/wa7hw74kuhP8VAe7OeIHXrGtKcKNM4SSOaTnPwr86j2PKpU7vLWXRFV1wBIAygLSbPxZFKsoSJNuSsxP5XU06kKy6aKGJLCPL9gIE8Xb9eNkNNkNZ/sFcIF6vjxR7xb/nYfk2CMBQMm5dKHwHaCTAfsDkp1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezXgS4Hn; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niH8YXm+lnXIPk51xzmgC7v7V490VJ6q0x3vJFPA8EHCN+YMujExdSao8BFJ0LRxc2o1mebJCrZyWkTfRLbttyldX29aL1DnNVTJMbpTdvnJ3GrrHxneXsk5oaiYIsVJh1LFzQ9hx6pc/tgwpK1AB3SkWH00Cn923FuhtvGEYR+0oxPnD19EVYFkT56eIIVuMOANhS6DDiZhRsJOsDmSr+mZCLVxJDmo30+MbGPoWqpfNmDrzya6HL6zeTr871eekDALKCCP7kxkQ3KV9+cevhE5AiLKxTjKHiNUXuFXyQImR+ZGMmSl4Qkim/pqk22c1+fUMferwUXUgc2RcIHBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOPk7OLmVzrtsDveh8QdRhekr+OijQXj+UvSeDnJg7Y=;
 b=f373m2juCDfW5VkrTW9ZrXtLFTUeQlzwrjKx9mUWm+alwjXLrVMzEQF6olbGzZoHs62Dt818aHhj47A8DXYQ/zatrpknNk3eLX2UpWTqAcR0BREkOJQl5tF7WmmfNebXwShGTCcAwsb7VZCrgm75UcE/kfvZuQHKkaREyYcrnAwj9TO0D2p6TkdQahCjGzdbdqbYdckxrrmfKbAtiDaAPeVsnjpxzAzQWMBcUW5ng8AWKLcqCjYLsbpfwL4AXfyn7+yE66uxaZDjvqfd4yEiLN0l0Z83YP0XEZ3vY5b3eRIkeY5BB93etpmXlKqWFdppfQkBGCB3eN2GNeXPURaikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOPk7OLmVzrtsDveh8QdRhekr+OijQXj+UvSeDnJg7Y=;
 b=ezXgS4HnnztkJgOaqPsGGEpxh2MG/7hFbDvc2Z0Iu8QXzxo/ku6ieOZzc458dB8xXLgEdiFOE5wJfQvtvbCtkqZzyVH9MsqHix5+KZoHIzroe3fIr4M86//buW6d2/CO7CYqU4Lt5Nzf4ToxUcdoMiUSXKitbF8PXa5Sb5YuJs4=
Received: from MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:14:21 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::9a) by MN2PR13CA0036.outlook.office365.com
 (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 15:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 15:14:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 10:14:20 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 7 May 2024 10:14:19 -0500
Message-ID: <a624aca2-19c0-e4d6-086a-3bbf94f9fe3f@amd.com>
Date: Tue, 7 May 2024 08:14:19 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] IRQ Pending signal's state leaved true once stopped
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Eric Debief <debief@digigram.com>
CC: <dmaengine@vger.kernel.org>, Brian Xu <brian.xu@amd.com>, "Raj Kumar
 Rampelli" <raj.kumar.rampelli@amd.com>
References: <CALYqZ9mqnT7pP6PsZUFvp5XpmrhHXjo+0pQt7mOX2AD0noUjAQ@mail.gmail.com>
 <ZjYpa9OQDsNL6Xlx@matsya>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ZjYpa9OQDsNL6Xlx@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 269a0a56-c52b-416d-5a10-08dc6ea85f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWNrQTQ4Wi9xdkRxTGJ6cjRJUjA1QTVIbUVGWktINUkxZmpmOW0rMzQ5clpW?=
 =?utf-8?B?WHora3JSZXBtWDFMYzRXQlBKUnlEU0hZMmp3dERISVgrRTNMbWQ2azY0QVVW?=
 =?utf-8?B?TjVwQ01yUG4xTFgySHQwSU83Njcxb3M2OUNBdlZtbDFhM21WclFTdkNIcU43?=
 =?utf-8?B?MXd5YS9TUm0xS2JJcG5UTFZLZmVlRjNIcGF0dkJIU1NLNFJ2Q2lXQ1JJVHp1?=
 =?utf-8?B?ZThob3lkUXRSOUUzYTlJbEw3L0VLeWQ4MlpkcDVlU3Z3YmQwUmRBTTViV2ZN?=
 =?utf-8?B?VktTallYb2ZYOWYxbTZqMGt2VVJJMmhkSEV3aGxEbUU4SzNzRW1SV1QxWm5D?=
 =?utf-8?B?ditkS1pxRDFmSTEvTi9wVjRteFNnSjFnRzBuQ28za2xzclN4THFUK3BvYnpF?=
 =?utf-8?B?dmhSdVZNK1doMjcxbDBBUnNWbitQdEhsb2ViWmZkVHRDSzJlWWZRUXhqZW9O?=
 =?utf-8?B?M0ZyUStIZG1rejJacWJ0bEd1TGpNVlFucmZKdEFqeWpiMUtBaUFWd25jTmhw?=
 =?utf-8?B?bUVuSDk3K2ptcHdxdTVJdWhpOTFTRldMQkh5c0diK2hJc0NiNVpBa1M1M0Nm?=
 =?utf-8?B?ZjlXL0JvVjVvWld2Nmh6dWxyZXk0Y0JoNXlnMzJFb3N0cnZFR0FaVE12NHlD?=
 =?utf-8?B?VW1JSzVId2t1TU9WbHV4L2QxcG1qaXVxV2tlYzdMdEtDdW94QVo1VzZSOS9F?=
 =?utf-8?B?bW8yZ3VhVkFVRE10RFFIU2M5UHFMbnRYbDA1RUhZNS9TMWxPSnJJZStJK2N3?=
 =?utf-8?B?dW5KVjdPSGkzSkZQaFprRjhLaUNMV3RNdjh3ZHBEUEVZdzdndE9vaWN1VU1t?=
 =?utf-8?B?L3ZGSHZTMWY1SkdMUW1jTHcxZDRqRmYyQ05wYTdYVkhrMVpRdDNtZzZ5aEhM?=
 =?utf-8?B?WkZLR2VTMm5PTVd0VDUwVkl4MG5PS3NYMCt1R21YRFhZbU1TZ3RDeDBlVUJz?=
 =?utf-8?B?NjVxSThrL2EzWFNwcjI5MHI0eXFHNjZGWnQ0RjhDZFNucUhYdjZJOUpGeUlM?=
 =?utf-8?B?aU5zWnVLTDJnK0ZkY0YvMmExYUVBKzFJdGJoUVhLdjZwM1l0LzFOenQ3bzQ1?=
 =?utf-8?B?UXJndlB6MWNhU0tIWnNLVmd1RGdWQU8zR1JDM05TVVFxR3dGN3lOaG00alY2?=
 =?utf-8?B?SzZ2TEJxQyswZWgxU2tRNUR2WVcxK1hUbk04bkxnZDZiY0NhTi9vbEVaeXZ0?=
 =?utf-8?B?MlViSzZSeXBCWU0xNXErRkpmN2FoYlBUVm5tV3RSaWQ1MkhieXVFMmVzcVc4?=
 =?utf-8?B?ZGVhNTl1MlUrUEREYzJ3OWJIODR0UXhpNUx6dDRGOWZBUVNxNDRQMG1WbEFr?=
 =?utf-8?B?Ny8vTTM1VUJsNm1vc2Jpd1RaYUNoMkNJVm9rOUc1UHFiSUFoYmZLaC8wdUNn?=
 =?utf-8?B?M1l4bHN5aWJHYjlNQThXdGZvYXVOblAwNkJuYnlBTjlzMjhKc2lNVEw0a0VW?=
 =?utf-8?B?ZjA1ZDJ1bVgyOTBubkpZRmd1N2hxeXBrS3R3U0tBZE1pQUtMVFYzblJaSXlv?=
 =?utf-8?B?MTNWY3hGcHpOZkpLMW4zeEdJTkozRWNrd3VvUkJIS3pQQW5kdmpZU0VXNjlI?=
 =?utf-8?B?bkJrZFppTjdHMjBtWWNSVUlzNlhYL09uQkFiRWM0TXZjUkROdkxMY2ZMNUpC?=
 =?utf-8?B?Qk5obHFhS1o3UHk2dXVtV1RjaFBWTkYwd2xOKzVRamZkREFuaUJXdHFST1l6?=
 =?utf-8?B?QXJhU05CdDBZbjZybmdVRGNYcEZUQ1A5dmFVTGZtb0cvQUxqMmRmQkRrMUZ6?=
 =?utf-8?Q?JDMbnNcjzJzek6u042gHx/aXqI6Ope+XWdbDawd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:14:20.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269a0a56-c52b-416d-5a10-08dc6ea85f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

Thanks for adding me.

Reviewed-by: lizhi.hou@amd.com

On 5/4/24 05:26, Vinod Koul wrote:
> Hello Eric,
>
> On 29-04-24, 16:21, Eric Debief wrote:
>> Hi,
>>
>> We've observed that the IRQ Pending signal's state stays TRUE once the
>> XDMA channel is stopped. This is due to the missg acknowledgement
>> (stats register read) on the last interrupt.
>> We simply move up the status register read.
>>
>> Below my patch.
> Thanks for the patch, you should cc the driver authors as well for the
> comments on the patch.
>
> checkpatch would tell you that these are:
> Lizhi Hou <lizhi.hou@amd.com> (supporter:XILINX XDMA DRIVER)
> Brian Xu <brian.xu@amd.com> (supporter:XILINX XDMA DRIVER)
> Raj Kumar Rampelli <raj.kumar.rampelli@amd.com> (supporter:XILINX XDMA DRIVER)
> Michal Simek <michal.simek@amd.com> (supporter:ARM/ZYNQ ARCHITECTURE)
> Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
>
>
>> Hope this helps.
>> Eric.
>>
>> =============================================
>> >From 1f49f5e2537741949b6af90d09c8c22764333ff6 Mon Sep 17 00:00:00 2001
>> From: Eric DEBIEF <debief@digigram.com>
>> Date: Mon, 29 Apr 2024 16:16:45 +0200
>> Subject: FIX: IRQ Pending TRUE once stopped.
> subject should have tags: dmaengine: xilinx:
>
>> The last interrupt is not acknowledged so the IRQ Pending signal's
>> state is leaved TRUE. Move up the read of the status register to
>> acknowledge the IRQ lowering the IRQ Pending signal's state.
>> ---
>>   drivers/dma/xilinx/xdma.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index 306099c920bb..de23f75bc76f 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -923,16 +923,16 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>>
>>       spin_lock(&xchan->vchan.lock);
>>
>> -    /* get submitted request */
>> -    vd = vchan_next_desc(&xchan->vchan);
>> -    if (!vd)
>> -        goto out;
>> -
>>       /* Clear-on-read the status register */
>>       ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st);
>>       if (ret)
>>           goto out;
>>
>> +    /* get submitted request */
>> +    vd = vchan_next_desc(&xchan->vchan);
>> +    if (!vd)
>> +        goto out;
>> +
>>       desc = to_xdma_desc(vd);
>>
>>       st &= XDMA_CHAN_STATUS_MASK;
>> -- 
>> 2.34.1
>>
>> -- 
>>   
>> <https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

