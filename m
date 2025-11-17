Return-Path: <dmaengine+bounces-7199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B450AC62B30
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 08:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37D4A347A1D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A183191D3;
	Mon, 17 Nov 2025 07:18:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023143.outbound.protection.outlook.com [52.101.127.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D242D97AA;
	Mon, 17 Nov 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363905; cv=fail; b=IN4BqDIR09gOkz3alJ+Nc3k9FdrqXPGpNxXc9L5pfRgqBNn1vdKBmxkyKs/+Pm4CiFtMDqla4o7PRugM1kx+3JUeYC0TKZstYguv8nXl2+Q/LAVxTT6nsctUBR5WKzTYFYLcQZHGk9ydNGZWqqUsFlU+JwbL6lIHujOGCFWtkU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363905; c=relaxed/simple;
	bh=B6t61dy9N5Qt44tf9v9biWNtkEABefQ65IletFx9bs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyEiM9pno7no7D+d7lgXz27UXxOUlWMfVZ1CnQHyCl4ETJ0qQe2S7tXEVVUqPEyasj1Nfr4rRs+jizmTEd7RrSdPZrauZkX8BxIZDCL8q3ICQY2LHD8aIbnD8nET6qJwOqgn69CenhrmqD2QvySMb29V4OT/R6XyIuAz2GPQJQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLmIJxDXg5JNVKZcqlq3gQShqmsxcocWys/YXmT+apCLSkwYDv22M6yorjG2O5OnIdPZhWOX5A/rHOClbSg5+W6T+zvwDmARZGIrnUelfmlIXrcswZXF3BbKZWqjt7808CyPLG3LgL98YsaSRYa0VAvdgBsIP5R0XLRcH1NwToLWsQ4cSglCVurcPMJiep7Vby0n1Oy/3skhfuicLYMt4PFGZdEI6BA9kTiOrkZUHsD82UBbIVGQbVl+zBi/iswXPEf00jNyONrrDWC7n6sYljhLOLogj1dWrH1Ji0f2vSPTUpja0HU1AhTpRuDtVpx3ILhSZaBmtzFblVsRnh4p4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0ktfGK7Ciy7iym/Q/8bV5uPBFHvAA9iTyBd5PWTRIQ=;
 b=kuEKsdgM0TNLQ6ZLCpikL4II6Cg1NvQDDc7SaSMK++Ezt/RGre552znnY3NCTXERTbWRdML4OK8eeLyimT7UEhd89+6iBrk/owDJF9ZIytbZ709sq2KkntyV4uWXfRdgi76q1dYyhDebctp0wdqaaFyugm05B8zFz4t3u+H65R7OLJyrMseMhcMWNXSxS4jebE2aAv7G5qYjkoUV79DLRPjoQtwoKH6FFHNH10CFi2qnHtS5TYrpNJav2gYzAakQsC7m8QZrxu0p4Uw2NwACZocaHDKJb2CuJZ+LXaczOVYbbft3cyWQymtrNDNyzF+OQmKYp9LX86DZQcXZPP1+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:196::10)
 by PUZPR06MB5651.apcprd06.prod.outlook.com (2603:1096:301:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 07:18:17 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::95) by SI2PR02CA0051.outlook.office365.com
 (2603:1096:4:196::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:18:15 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B43AB40A5BD5;
	Mon, 17 Nov 2025 15:18:14 +0800 (CST)
Message-ID: <7f1ce6c2-df20-48d6-99c7-411346b526a5@cixtech.com>
Date: Mon, 17 Nov 2025 15:18:14 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma: arm-dma350: add support for shared interrupt
 mode
To: Krzysztof Kozlowski <krzk@kernel.org>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-3-jun.guo@cixtech.com>
 <eb9eae64-f414-4b04-9a10-4dd8a9088e96@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <eb9eae64-f414-4b04-9a10-4dd8a9088e96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|PUZPR06MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f5ff8e-7ff8-4109-f9ac-08de25a979ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXpMK3pLUDhCUWtZRDZYVVQzcnd3WFN5bzVuM2g0anRtc3VyT3JlOWV0MFJN?=
 =?utf-8?B?MU1ZcGx5ODRjZjBmdFJKeUNnZzJ0bks0Q2xMeWRBZVZUcEZVWnp0eWthTXJW?=
 =?utf-8?B?Y2pHeVpIdjFhVWp3Y2NuaVdNaU1CbDgrMEs0dDl3bzVHaGhuZFV4eENNenFr?=
 =?utf-8?B?Y0xPSmNYV29DWllJWjFFS1U0QmtkdmhUV29PejJ6bDdST2V2Nzl4RWNKVFA1?=
 =?utf-8?B?bVdIRVU5L0d2UUFtWEppK0oxdXdWNFRpRjJCZU8yR1ZMaEhKTFNRNzV5QlBH?=
 =?utf-8?B?dlM4dHYwZFNJM2lCUnhGSzVuSTBQekdxK05wZk43SlpxNEpXamRjdVhKNmQr?=
 =?utf-8?B?MGY3ZUdUNUpjVHlDZ3FqR2t5L2I5N20xV0xXZWVpdzJJZTlYUXRIR25adlhE?=
 =?utf-8?B?Z2R3NzM4QWVLdlpkaG9HNjl1MEVSQ2UwTTFPaFo5c2diblFlaXdYOVNzejJ0?=
 =?utf-8?B?RFVGaFh5bXBIU3UyWWVYZG9WT2dBWFZISVBoYmZHczNaV3ovSXNJNlZhbG42?=
 =?utf-8?B?eU1DR0NncThiUm9kejhIU09vLzdmTjZNT3ZSN2ZxczQwa09JRUZIKzF4aFNj?=
 =?utf-8?B?UmNsN3VsYTlyNjAyR0REV25iVnNZT0l5L0tZMmxGMVgzK1lhQmd1UmJyTWlL?=
 =?utf-8?B?ZUtnenJzNWRmajZRMTRlVHIybFhOZU0xbDZnNVpRY1h3d1l2SVJQcmtZMGd2?=
 =?utf-8?B?UHRLaG90L1RCTDBrMXZaVmp6UExtS2hjYXFyaFBjQ2pYNWhDaGNpUWtqaVBR?=
 =?utf-8?B?SnVWSC93ZDkrV0wxNjdDZldBRERXczIwZEJvWE55VFNJbHgwU3Bja2haSDR3?=
 =?utf-8?B?RkQ1amx6Nm0xVlI2R3ZWOGRoWFI2QTM3Q0FGL3owWUJXYkhqNnJ6ZkgrQ2Zt?=
 =?utf-8?B?eTZEQjJKQkdHb2dDa1NiemhhbFdqVGp2Mi9sTHI1aXIyYVZxYWNGN1k0VXI3?=
 =?utf-8?B?UUdFRGZWa0wrdFZqSTNMRFB5b254b2xBUTNqNE1hVHJlMG1WUkZUSHJIekhx?=
 =?utf-8?B?M09rdEltVVZDVkJDWTNWZ250NTlWcUtlU1JoQUJUVXdKcUltU2pjMmFiblE1?=
 =?utf-8?B?KytzckxsUW1FcWlXVlhCNFQyZWhHTTY2Z3hvcTE5TDJmYmNHazFHKzJvKzNR?=
 =?utf-8?B?dGhjbForYjVWZmpMTzJkNnVJT0krS2lJanhuWm5UYnZkSHRHOWhVS3pVd0dF?=
 =?utf-8?B?Y3RDNk5FK1RQMGtTbFNmRHRkdTE4VUlhR3owNng3ZWc4a2NxbzJLVVFyejNK?=
 =?utf-8?B?ZHZHK1NHVitSZnFObzdNajQycWVGWHUwaUxIejg2WDhUb0xNQkFqN0tFbS81?=
 =?utf-8?B?UEhscVJlanVRaCs2SUc5bDVPUHRkWlozQm43cFAyeDdGWm9VYlI5N0t2K2V4?=
 =?utf-8?B?THlKcjNNSG1ZZXh5N2JoY2E4ZCtxdW91QXRjTDNtZkU2aWpsZkk4WU1oaWll?=
 =?utf-8?B?K0drSG4wOUNnNUZjbTNYcWtPVEVqQnpSWlVnWE9aaHJDcTZQM1c1QXBtR25n?=
 =?utf-8?B?QVZOQlRpRGg2aytPek1oUEMwTmNyNlJyZkExdkxTYWFESElPQlljVGJKS1FO?=
 =?utf-8?B?SzQwaS80ek82ZDhNVFJPVUhLQzJDWjRnRXQ0dXlrWUtIM3ZuQ05Sd1lZdFBk?=
 =?utf-8?B?RzhYWHRTWHo1RXdGcHQvVHh5Q0hDWnZRaUpqV1AyUjZYT1ZwMU5pb0FPQ3FD?=
 =?utf-8?B?ZzQ0bDZlWXlLNFVxVXcybDVBanNnSGlxTisydVdPY0QwbGFPeVZsQm9WUE1X?=
 =?utf-8?B?bzBsSThYempoc2lVeE9kQ3F6c2lQNVN5SjRtSkw0bmwzVkN1ZEhVRWI1ZHZr?=
 =?utf-8?B?cFpXc3EzdFlqK3lJbzA4amZTOFZEZWhPeW9ZeWRWQSs5SUQ3RnNSMG0wQWpV?=
 =?utf-8?B?QURLY2RLQ3oxVC94TjBIRWhwT1RLWi8wMlVpT295WHVoQ2E5ZzZBRjROZXZr?=
 =?utf-8?B?cmlmS3Y4UzBBOHp0ZWhKbDF3UUtUODZwYU53RWN2b3VUUG40RXJidHZkTGpp?=
 =?utf-8?B?VFljQ0RVMm5LMC9rRncwV1ZKc0dLVERlTTVMbHpQSUxtRktoUmtJTmZCS2pN?=
 =?utf-8?B?bFMyd24xcThLQ3ZMNHJmblNHTTArVjJ6OEhRZzJoVUUwQlBheHlkaWtKV3RF?=
 =?utf-8?Q?8VA5I0/DSBMy38bHG5bYHAhYR?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:18:15.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5ff8e-7ff8-4109-f9ac-08de25a979ec
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5651


On 11/17/2025 2:13 PM, Krzysztof Kozlowski wrote:
> On 17/11/2025 02:59, Jun Guo wrote:
>> - The arm dma350 controller's hardware implementation varies: some
> That's not a list. Look at git history to learn how to write expected
> commit messages.
> 
Thank you. I will incorporate your feedback in the next version.>> 
designs dedicate a separate interrupt line for each channel, while
>>   others have all channels sharing a single interrupt.This patch adds
>>   support for the hardware design where all DMA channels share a
>>   single interrupt.
>>
>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>> ---
>>   drivers/dma/ar
> 
> 
>> @@ -526,7 +593,7 @@ static void d350_free_chan_resources(struct dma_chan *chan)
>>   static int d350_probe(struct platform_device *pdev)
>>   {
>>        struct device *dev = &pdev->dev;
>> -     struct d350 *dmac;
>> +     struct d350 *dmac = NULL;
>>        void __iomem *base;
>>        u32 reg;
>>        int ret, nchan, dw, aw, r, p;
>> @@ -556,6 +623,7 @@ static int d350_probe(struct platform_device *pdev)
>>                return -ENOMEM;
>>
>>        dmac->nchan = nchan;
>> +     dmac->base = base;
>>
>>        reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>>        dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>> @@ -582,6 +650,26 @@ static int d350_probe(struct platform_device *pdev)
>>        dmac->dma.device_issue_pending = d350_issue_pending;
>>        INIT_LIST_HEAD(&dmac->dma.channels);
>>
>> +     /* Cix Sky1 has a common host IRQ for all its channels. */
>> +     if (of_device_is_compatible(pdev->dev.of_node, "cix,sky1-dma-350")) {
> No, see further
> 
>> +             int host_irq = platform_get_irq(pdev, 0);
>> +
>> +             if (host_irq < 0)
>> +                     return dev_err_probe(dev, host_irq,
>> +                                          "Failed to get IRQ\n");
>> +
>> +             ret = devm_request_irq(&pdev->dev, host_irq, d350_global_irq,
>> +                                    IRQF_SHARED, DRIVER_NAME, dmac);
>> +             if (ret)
>> +                     return dev_err_probe(
>> +                             dev, ret,
>> +                             "Failed to request the combined IRQ %d\n",
>> +                             host_irq);
>> +
>> +             /* Combined Non-Secure Channel Interrupt Enable */
>> +             writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
>> +     }
>> +
>>        /* Would be nice to have per-channel caps for this... */
>>        memset = true;
>>        for (int i = 0; i < nchan; i++) {
>> @@ -595,10 +683,16 @@ static int d350_probe(struct platform_device *pdev)
>>                        dev_warn(dev, "No command link support on channel %d\n", i);
>>                        continue;
>>                }
>> -             dch->irq = platform_get_irq(pdev, i);
>> -             if (dch->irq < 0)
>> -                     return dev_err_probe(dev, dch->irq,
>> -                                          "Failed to get IRQ for channel %d\n", i);
>> +
>> +             if (!of_device_is_compatible(pdev->dev.of_node,
>> +                                          "cix,sky1-dma-350")) {
> No, use driver match data for that. Sprinkling compatibles everywhere
> does not scale.
> 
> Also, this is in contrary with the binding, which did not say your
> device has no interrupts.
Ok, I'll rework the patch based on your feedback.

Best regards,
Jun


