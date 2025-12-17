Return-Path: <dmaengine+bounces-7739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E0CC5C13
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 03:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C511B3020DDE
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B016238C0A;
	Wed, 17 Dec 2025 02:13:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023074.outbound.protection.outlook.com [40.107.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FE3B1B3;
	Wed, 17 Dec 2025 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765937581; cv=fail; b=kmJVQU5XqdbdVcRRAsnHdLlIOKsiAhSgwshDxpJChsapXLkzRSDaRcqLIEbRpTVAqCAR6Dru4X+JSUojLhYMCSrMbtbGmg3E1pb3TWNARZwC1fqCGtJYmo9irIe7+7oAChQtvaBRpQp5ePS6Wm5vULJ7wRMp+j4Q/NzYMyKRqGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765937581; c=relaxed/simple;
	bh=uTWCu0RDBDAC3bXM4Km42vv/2mo/34yyMhFFmgjqR6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPRq7aG0ZuQpxxuNLuaGBeASFc5uD7KOXBSzj/OTD5u9jqyk9fsIPVCL+DKeqBBpi6RTE3CPXgF4BSakCAyNiVvh+iagR/WHqd4307XG0Fhynk/t+N5m7B07h6Db7JazCAZFyDiNzRhxCRxlKB2EhZRt9vuWtbfG8s12ejhQiJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWZGsdKbsOdAB0U031uvyt2G8gFkU3MMp86Uy1BQjiLTK3cY91kO1lJ7xDpW4UtIiLLSHXIumpWn1BvhvA8lxPl8nvJCxcTe2YEVFnYiFHTYvu7QFeCIzSFary1ekjL7vRtA7lP75e6i22UNFKaVoCJ6pjSDrJ3b9qIIRn+o13MYwO9vI71ZrosrqmRjKge0Kdt9we7PYoToQHVL90kkHuA81uNWljaYA7uiriaIU1Wt9k3pzmKPPXiILNBhgYLwcEIJArpL4GtQ4T3pL/cxOg05vWQ6VeENBqykG88jYvuAn2HMDmJUTaPZ/BXv+sbGQj+yP9k6dF748tirI+Dx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR/W7tXQAtcldECyv3GNKnr5ePuL0RouJeBTmNE24KY=;
 b=XKczcbWnYTbHkiua1rQId3oXHhfbHVZL7v927GSEYrI/qXDYiD+bznWDwJTn+RmbYFwC2DQVtQDsuP2tgJ31B8b8sk8kE+PhxtAkfJZ6aVvrDj8XKZTjSC/C3sy5YNmHYtBdE0fEJWh33dXnttG8wLImGzXO215qiPyJJqhpY7I3EJQMk8Ef1erZ4rhmmQxUl2fgsvoCP438QzXryyAYDmcdR6vDyR77YhrcwPwP/AUbPwxGu2uzAac/XncaqD3K5itvF4l0D/4xYaJM3qKTM0DuN5q1ebqXwjgCjrktklGXJL7JkECEzeDkABk9Je8BgVq7E4V06KFeucyimE871Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:300:59::27)
 by TYZPR06MB5396.apcprd06.prod.outlook.com (2603:1096:400:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 02:12:54 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:59:cafe::da) by PS2PR02CA0039.outlook.office365.com
 (2603:1096:300:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 02:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 02:12:52 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9C97840A5A13;
	Wed, 17 Dec 2025 10:12:50 +0800 (CST)
Message-ID: <87ad76b4-0141-46d9-81df-1e2948f46803@cixtech.com>
Date: Wed, 17 Dec 2025 10:12:50 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dma: arm-dma350: add support for shared interrupt
 mode
To: Robin Murphy <robin.murphy@arm.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org, jelly.jia@cixtech.com
References: <20251216123026.3519923-1-jun.guo@cixtech.com>
 <20251216123026.3519923-3-jun.guo@cixtech.com>
 <910e3db2-c4ef-4c21-9336-49469234b8e6@arm.com>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <910e3db2-c4ef-4c21-9336-49469234b8e6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|TYZPR06MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: c4be0da1-19bc-4fd6-1f87-08de3d11c8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCs1SHU0blRzVHF2TTdCcDFXamVNaE5lTWM3UWdtM0JyUHQrTVZxK2VHYjkz?=
 =?utf-8?B?dk05ZjFnL3Z1U25UdkwzSGRUdFpRZVRscXYwNU5vV2NIWUhYOWVDWEwwakNy?=
 =?utf-8?B?a3RRRmhBRnFQVnY0azFmT2tOcEw4OENtNTlXYXp3M2tFVTV0MEVDaDM1NUNV?=
 =?utf-8?B?cUJ6Q0MwSmVXdW1maHA4RnkxQWVyRHY2aWhZeTgxSTlxd3JHMHpKMUFrUXYz?=
 =?utf-8?B?bDRqdVQ1ckdEdTVhTmhWc1dSQ1p5Y2RTQ1F2VmJJcTcvOWhWTFRQQzFPQW1T?=
 =?utf-8?B?SURlOC95V1dBclVEWFM5YlNQODFOOURrSDB0N0VnZWNLSE1lNTRlc3M4dHI1?=
 =?utf-8?B?SVNOSlhEZVJ2YzEvV1NHZkNzRmlaRmNjVFVaakMycUhCOTFOTDFoWllFWTNM?=
 =?utf-8?B?aWgxTFNGQjc1dHdWRFpOUDlTcVZZcWU3My8zVVJyek9JRGFJa3MxL21OazhW?=
 =?utf-8?B?Smx5MjJwN0VLc29sL2dWa3V3ZkxwWVExSHMvU0tEQmxzVlRVa25IdTlIcUFP?=
 =?utf-8?B?b3dmSk9Ldnp2SXRTdTZwSTZxcUhkcEZkOU1pSlJTUHVGQW5oc0h1OU9Ya0VL?=
 =?utf-8?B?NGtmL2xpY3c1UWF2ZGFsQjZOaE50bHVCc3huaG9LRXk3QjRzSFFZQVlyRFVr?=
 =?utf-8?B?ZmU2M1pFc1dzVXovZjU2U0tuVzF4VXZaSEJ4WTl3T1E0Yk1yWXhkMEVwb0Uw?=
 =?utf-8?B?di81REd4aVEwRmdxZGZTLzFTNVc4S0p0Ry9IVjJlOFlnUWxCMyt6YUFWN2p2?=
 =?utf-8?B?dmZjWFR4a2s5OEg5M21DclluZnM5SVUzckREcGlZS3FQVytScEF2bGdsdS9r?=
 =?utf-8?B?VTBDckJSUnI3TFlwV1hlVkp6Y2U1TS9OSytSaFEzTURGTWxxdzdKcUU0WUFv?=
 =?utf-8?B?YUtHYVBud2tuQ0hVZDB4amJodTRIcDJNdkNzbERMZzdmeU1hb1BMbVZ1R3pS?=
 =?utf-8?B?MEFwb1RVS1V2b1pCNUJwWUNnZHJQNzNCRlcyNXpiVXY1Nmd2a2dzNXYwT0RC?=
 =?utf-8?B?NnFtbjIzQ0tvSzdqeEpWajRTOU45eHF6R2hTMTQwdWxyRytvN3hmNmE2NFJl?=
 =?utf-8?B?OVExU1dacDFZdjRwWlRyOG1DWExsM2RsTjB0SUlVLzlPSzFDa2xFbTA0TEYx?=
 =?utf-8?B?eTlIanI2YU5MaTlncEdMV0xwSFZXREhCcndnZXYvNW9kYlFjdGZ1akx4WVJI?=
 =?utf-8?B?dTQ5QVdqR3VZSUJEMnR0b1RxSTVXbllQY3g3TExUMms0K2ZleWFYUkl5eElN?=
 =?utf-8?B?cFJsTTJmUk5WaytqM0paMEhhSlNZN3U3NFJFb2JHcXhiY3p5L2ZadDdIWmtX?=
 =?utf-8?B?WVFHYW0xdTFXeDYwT0g4SkM3ZmJDa21EVWd0Q3ZjQU9wT2RlUnBYbjFPN2VU?=
 =?utf-8?B?MFo1c2JvOVBSeHlIbnpmL0ltRTFMaDlQblN5alZESVJ1WE10VndCb3dZUFRJ?=
 =?utf-8?B?Z2sxUjIxMlN6Vk1jNi8wbXE1dS94MGlUZTZ3anpxMnNia01NbXFKc0pqZ0NW?=
 =?utf-8?B?c2FpY0UrMGd5SGFJbzRmakEwUzFDbW0yck0xY1JVVkp3RGNhQ3dXSHhycGxP?=
 =?utf-8?B?N3M0WDIyUlpVVW5KOXZRNitmakVXeGdwenR2bnBPOEJMUWFKeHBPcVZjVGox?=
 =?utf-8?B?RE5Qa2cvWTY5QkVkSE5yczNhUTBpc1VvZHpCa1hUdGlzemxKMFlFRy90RCtu?=
 =?utf-8?B?QU9ZTzRHRVRsYXhldTF4L0RkUlFYd2o5ekNadkpmRlRKN25OWSs5bUo4RFM0?=
 =?utf-8?B?WDluSXZQRHU3eGZuMkFjOVRkSjRKSWRMWGlVYjBWeHBXbWU4S1psRGdXb1hZ?=
 =?utf-8?B?Q0RCT2JZbUdQV1N3SE1rajdWSnUzZjRLZEpQdlRFUUdxZXZEN1R5WDZCMEZK?=
 =?utf-8?B?TXFYVlBPQ1FJL1ZFTDEySDJtMWk2S1lBQVRXT2JoY2haUEV5aTVFcjJQdDFv?=
 =?utf-8?B?c2FCbnZUWEhYblBrK3NjZDhsTktjV1NES0crU3RkMDZCQWxLTCt0czNka3Z0?=
 =?utf-8?B?YXdKSHViZ0dzc3hUQ3R1YnlvY0VISTFmVXdqcG5TVlVJcEI0VG9XKzcvQjRo?=
 =?utf-8?B?VGFvM3V1bnhQeklKR3l0d3NybjhMM0lZMjZ3SzhqbVBHejdXeEtvR0lSd1lJ?=
 =?utf-8?Q?EKjU=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 02:12:52.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4be0da1-19bc-4fd6-1f87-08de3d11c8a0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5396


On 12/16/2025 8:51 PM, Robin Murphy wrote:
> On 2025-12-16 12:30 pm, Jun Guo wrote:
>> The arm dma350 controller's hardware implementation varies: some
>> designs dedicate a separate interrupt line for each channel, while
>> others have all channels sharing a single interrupt.This patch adds
>> support for the hardware design where all DMA channels share a
>> single interrupt.
>>
>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>> ---
>>   drivers/dma/arm-dma350.c | 124 +++++++++++++++++++++++++++++++++++----
>>   1 file changed, 114 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
>> index 9efe2ca7d5ec..6bea18521edd 100644
>> --- a/drivers/dma/arm-dma350.c
>> +++ b/drivers/dma/arm-dma350.c
>> @@ -14,6 +14,7 @@
>>   #include "virt-dma.h"
>>
>>   #define DMAINFO                     0x0f00
>> +#define DRIVER_NAME          "arm-dma350"
>>
>>   #define DMA_BUILDCFG0               0xb0
>>   #define DMA_CFG_DATA_WIDTH  GENMASK(18, 16)
>> @@ -142,6 +143,9 @@
>>   #define LINK_LINKADDR               BIT(30)
>>   #define LINK_LINKADDRHI             BIT(31)
>>
>> +/* DMA NONSECURE CONTROL REGISTER */
>> +#define DMANSECCTRL          0x20c
>> +#define INTREN_ANYCHINTR_EN  BIT(0)
>>
>>   enum ch_ctrl_donetype {
>>       CH_CTRL_DONETYPE_NONE = 0,
>> @@ -192,11 +196,16 @@ struct d350_chan {
>>
>>   struct d350 {
>>       struct dma_device dma;
>> +     void __iomem *base;
>>       int nchan;
>>       int nreq;
>>       struct d350_chan channels[] __counted_by(nchan);
>>   };
>>
>> +struct d350_driver_data {
>> +     bool combined_irq;
>> +};
>> +
>>   static inline struct d350_chan *to_d350_chan(struct dma_chan *chan)
>>   {
>>       return container_of(chan, struct d350_chan, vc.chan);
>> @@ -461,7 +470,61 @@ static void d350_issue_pending(struct dma_chan 
>> *chan)
>>       spin_unlock_irqrestore(&dch->vc.lock, flags);
>>   }
>>
>> -static irqreturn_t d350_irq(int irq, void *data)
>> +static irqreturn_t d350_global_irq(int irq, void *data)
>> +{
>> +     struct d350 *dmac = (struct d350 *)data;
>> +     struct device *dev = dmac->dma.dev;
>> +     irqreturn_t ret = IRQ_NONE;
>> +     int i;
>> +
>> +     for (i = 0; i < dmac->nchan; i++) {
>> +             struct d350_chan *dch = &dmac->channels[i];
>> +             u32 ch_status;
>> +
>> +             ch_status = readl(dch->base + CH_STATUS);
>> +             if (!ch_status)
>> +                     continue;
>> +
>> +             ret = IRQ_HANDLED;
>> +
>> +             if (ch_status & CH_STAT_INTR_ERR) {
>> +                     struct virt_dma_desc *vd = &dch->desc->vd;
>> +                     u32 errinfo = readl_relaxed(dch->base + 
>> CH_ERRINFO);
>> +
>> +                     if (errinfo &
>> +                         (CH_ERRINFO_AXIRDPOISERR | 
>> CH_ERRINFO_AXIRDRESPERR))
>> +                             vd->tx_result.result = 
>> DMA_TRANS_READ_FAILED;
>> +                     else if (errinfo & CH_ERRINFO_AXIWRRESPERR)
>> +                             vd->tx_result.result = 
>> DMA_TRANS_WRITE_FAILED;
>> +                     else
>> +                             vd->tx_result.result = DMA_TRANS_ABORTED;
>> +
>> +                     vd->tx_result.residue = d350_get_residue(dch);
>> +             } else if (!(ch_status & CH_STAT_INTR_DONE)) {
>> +                     dev_warn(dev, "Channel %d unexpected IRQ: 
>> 0x%08x\n", i,
>> +                              ch_status);
>> +             }
>> +
>> +             writel_relaxed(ch_status, dch->base + CH_STATUS);
>> +
>> +             spin_lock(&dch->vc.lock);
>> +             if (ch_status & CH_STAT_INTR_DONE) {
>> +                     vchan_cookie_complete(&dch->desc->vd);
>> +                     dch->status = DMA_COMPLETE;
>> +                     dch->residue = 0;
>> +                     d350_start_next(dch);
>> +             } else if (ch_status & CH_STAT_INTR_ERR) {
>> +                     vchan_cookie_complete(&dch->desc->vd);
>> +                     dch->status = DMA_ERROR;
>> +                     dch->residue = dch->desc->vd.tx_result.residue;
>> +             }
>> +             spin_unlock(&dch->vc.lock);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static irqreturn_t d350_channel_irq(int irq, void *data)
>>   {
>>       struct d350_chan *dch = data;
>>       struct device *dev = dch->vc.chan.device->dev;
>> @@ -506,10 +569,18 @@ static irqreturn_t d350_irq(int irq, void *data)
>>   static int d350_alloc_chan_resources(struct dma_chan *chan)
>>   {
>>       struct d350_chan *dch = to_d350_chan(chan);
>> -     int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
>> -                           dev_name(&dch->vc.chan.dev->device), dch);
>> -     if (!ret)
>> -             writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base 
>> + CH_INTREN);
>> +     int ret = 0;
>> +
>> +     if (dch->irq) {
>> +             ret = request_irq(dch->irq, d350_channel_irq, IRQF_SHARED,
>> +                               dev_name(&dch->vc.chan.dev->device), 
>> dch);
>> +             if (ret) {
>> +                     dev_err(chan->device->dev, "Failed to request 
>> IRQ %d\n", dch->irq);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + 
>> CH_INTREN);
>>
>>       return ret;
>>   }
>> @@ -526,7 +597,8 @@ static void d350_free_chan_resources(struct 
>> dma_chan *chan)
>>   static int d350_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>> -     struct d350 *dmac;
>> +     struct d350 *dmac = NULL;
>> +     const struct d350_driver_data *data;
>>       void __iomem *base;
>>       u32 reg;
>>       int ret, nchan, dw, aw, r, p;
>> @@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
>>               return -ENOMEM;
>>
>>       dmac->nchan = nchan;
>> +     dmac->base = base;
>>
>>       reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>>       dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>> @@ -582,6 +655,27 @@ static int d350_probe(struct platform_device *pdev)
>>       dmac->dma.device_issue_pending = d350_issue_pending;
>>       INIT_LIST_HEAD(&dmac->dma.channels);
>>
>> +     data = device_get_match_data(dev);
>> +     /* Cix Sky1 has a common host IRQ for all its channels. */
>> +     if (data && data->combined_irq) {
>> +             int host_irq = platform_get_irq(pdev, 0);
>> +
>> +             if (host_irq < 0)
>> +                     return dev_err_probe(dev, host_irq,
>> +                                          "Failed to get IRQ\n");
>> +
>> +             ret = devm_request_irq(&pdev->dev, host_irq, 
>> d350_global_irq,
>> +                                    IRQF_SHARED, DRIVER_NAME, dmac);
>> +             if (ret)
>> +                     return dev_err_probe(
>> +                             dev, ret,
>> +                             "Failed to request the combined IRQ %d\n",
>> +                             host_irq);
>> +     }
>> +
>> +     /* Combined Non-Secure Channel Interrupt Enable */
>> +     writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
> 
> This one line is all that should be needed - all the rest is pointless
> overcomplication and churn. And either way, copy-pasting the entire IRQ
> handler is not OK.
> 
> Thanks,
> Robin.

If the design uses a single interrupt line for all channels, then I only 
need to request one interrupt. When the interrupt occurs, I have to poll 
within the interrupt handler to determine which channel triggered it. 
Are you saying that just this one line is enough to achieve that? I 
don't quite understand.

Best wishes,
Jun Guo

