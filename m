Return-Path: <dmaengine+bounces-8229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82957D163DF
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 02:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6796C30038DA
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6928CF50;
	Tue, 13 Jan 2026 01:56:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023079.outbound.protection.outlook.com [52.101.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE1285061;
	Tue, 13 Jan 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269415; cv=fail; b=re8uUUtK3nYQyA1sQlk+a6NLy7fiodiQduvYPIUIYQ45sJ/4HxibRV7HupA3RBk6uZXxFAT3S7Hjfwpt1p8wPOjySTp/SJrYKXUleyCGJ6/1rxcg4WAOrrtBvmLz9RIr925R0xX6FHwYJwRijGeRfHhbYtM5K73l9dI4FZsP7nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269415; c=relaxed/simple;
	bh=T3nKb8vRYQQP/N0jz58g5U6bLejT813uvCXUYKBeGnY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HamtliOa/URLxPZRtfS+F4pkme+tVfco85aoqzSxG63DfIzGUv0I7/ljYXvAW9E3e8F/nxsGdC2/GZBRD6hsT6QGfILkwETPhsg0+FGcQLpP736HypuiQP5reLFzAvpI0nUfOKst36i2rLP2LOusNMzCPnA6+SvVg96b2YpdcAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQHB0SJyetNaupwEKDqELqBIgui8cSfsb2KXpPJcL1zPCQ/BhzMclMEzaSBlIi1SIcMvxMYlkJhdlfOQMxeVq8F3QQy2iKvpJOc7pV6hSH+i/loE9Tag2hS5snYgD4L20CSz8GSYQzLzin9uK0UuSm4J7JmQ3QgfA0a5iaxwyDzsNyTmBSR4HjeUQsKN8OSIT3pct9wH8N/PixGMi/rLppO2m8APOOjW51TVF5yb4gerzVWqWZka17gr+7bUagl3Bt92Bn+1c0Aue6YUef614E951deMVyrobQ53jsgcigjb1RI97NSQ4A8ZBZI16CX/rOqXge2zO3JiP3N/pM64WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPFbcmPNbOnyYqEHcx+yLkKpb1NQykppMCqhGfBfe5w=;
 b=dIUnhF0l4BRLDYhtigPNIxSMLsDbwrTW2I+BQe8X1ProRqWt9nuobP7ueeonP5nsW7KtFgyuI+zQ6jnXBTnkHO/YwoGdzwls/q0mlQ9o6DLhEXx/j2J2wGMdq+owYCLz+aRdaq9wunD3juo3NKsJetWpGmVjqO7TV3xUI51+LakYPnwLOqWHM61o5aU1RjLwgvSzmDqNEmGxey9/e3UVC25wbTVihdp0vBHonY6+PCCDK81vrVjWFRyB3OqO7V2VgcU7P7sU6cEUBKJoIcjg0fJ8228RrkEuQISZ0tYlOeZV7NXrTzLyzsKrFM1K3/2uIK/lPd7XRFEXn7JB6WgJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0210.KORP216.PROD.OUTLOOK.COM (2603:1096:101:19::14)
 by SEYPR06MB5961.apcprd06.prod.outlook.com (2603:1096:101:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:56:45 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:101:19:cafe::6a) by SL2P216CA0210.outlook.office365.com
 (2603:1096:101:19::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 01:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 01:56:44 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 64E8340A5A13;
	Tue, 13 Jan 2026 09:56:43 +0800 (CST)
Message-ID: <81579735-562c-4818-818e-029ef368b718@cixtech.com>
Date: Tue, 13 Jan 2026 09:56:43 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dma: arm-dma350: add support for shared interrupt
 mode
From: Jun Guo <jun.guo@cixtech.com>
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
 <87ad76b4-0141-46d9-81df-1e2948f46803@cixtech.com>
Content-Language: en-US
In-Reply-To: <87ad76b4-0141-46d9-81df-1e2948f46803@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEYPR06MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7f91e9-0484-4c06-f832-08de52470115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVdYZlVyQmdDd2JGRnBXanBibVdpNjI4TC91V2p1YnpwZkI1MFQvaitVSllw?=
 =?utf-8?B?d3dZL0paVGdwVzhKMFFkNy9ENTA3QktNM2FEYTBwL2lvSGtBNC9kM2ZQTTRR?=
 =?utf-8?B?UjRaR2tPYnQ0M05Bb09jaUFEVjNuN1ZOS1hCaUE3VC9uRkQ4UlZuamRjb0Qy?=
 =?utf-8?B?NDdVTUxkYVRxZnVLNkEvZXpteDBmMTkvRFd1RzFSYmxMdExBMm1wYU1xeFc2?=
 =?utf-8?B?RUtkRzk3ZktXbVM0Y1d3dlpLMVlkN2wzY1l1bWVxN3FWK2p5QXd2SUlnK0Ru?=
 =?utf-8?B?UHZ3TURkN3Z2RXpHb1dpUUpLVmhjb1VmNFFmYnFrSmdBUGNiZldVb04rbENK?=
 =?utf-8?B?bTFzSHMrT1RCNmljZmgycGRZYStkM1BZMHJuRlc1dVhmUXZjd210Z1RQM1ZL?=
 =?utf-8?B?VmpLTzE3dDdqVmJMZ0VmanVRWCtEM0E0a0wrcXNpVWdrWlFoZUZmbU5RVGtn?=
 =?utf-8?B?R2VlQ0pqcGFoOVpCeEdoVVkvMHJPL3luNEpuTnFYMzlHazN1NlZ5WU9CTkRi?=
 =?utf-8?B?alJkSDhZd3NxSEowWDA2ZkVpRWxhN3dEL1BpQ2txRWR0WXFrQTNLcW1UbDY2?=
 =?utf-8?B?eFNuclZTa3VaNGdtWVpITFNGblRJbVBET2RtV0c4UzdTTVNRV1E1OG45eHZn?=
 =?utf-8?B?dnhmZDAwck9kMlBQdVlZRW50VlRXMlg2R01sZWJycjdQWXFnam9ZS2xxVE9l?=
 =?utf-8?B?SDV3M1grTlU4Zm5wWVBKMzIrRlpnbUxOUHlOeDdQdDZGVWQwdHV0VzIrRlBn?=
 =?utf-8?B?aEZ1M1I4SUxKck9kL0JndjF6NW9zbFErc2xLT3NCVitOb2loVnNWWkR0SC9I?=
 =?utf-8?B?THRxZWxCNnpBZ3NaMzM0OVN4QnJ5NWFqNlVqVHVJT1ZZaUdvTlJkRWRoWFVt?=
 =?utf-8?B?NEVwVXdFTmY0NWpSY1hjNjhRd2NsWmtpVGZKT0IvNktsbVNrMHJrSWJNYWJC?=
 =?utf-8?B?dU93RWVKU3Z2eWs2L2JPdUdZelF6TGJyNStMM0VNS3QxZnRMZnFYbFJrVVk3?=
 =?utf-8?B?OW5lSGxiSjdaUmJpazFBY0pNdm5UNmo0SEhFQW9nd2VmVDhuQ2dRd3U2M2RH?=
 =?utf-8?B?aXNhelV4ZHlERDhNVTFYZjkxL2lZL3FWMjJaMzA3WXJRajhOTCtsRmtkVTdy?=
 =?utf-8?B?UU1BRFFlUDh6YkNoemErUDlJODNnUjVLUldnNDFEMnhRK3p0QmIyWGtqQjJp?=
 =?utf-8?B?RG81Vm9BZ2FwNlZIM2ZqVVRYQ20zaXFsZVc0Z0x2VzJvbWtEVC9IUzhmUWNo?=
 =?utf-8?B?YU1iODM1M0t4QWlEU25HZ204MnNrRlJsc3loVEYrSDgvNHhrUWJtKzdieWFh?=
 =?utf-8?B?NzAyVHBCQmNyZmwwTkVBSUh2blFwWTJQZlFPa2FZRERscUNGT1JVSEtLSlg0?=
 =?utf-8?B?VmQ0cDhNUU9JRkhuWlJkd3g2N3pMQmpWYUtONGpJYTVYbUk5L0ozLzlTeHNC?=
 =?utf-8?B?MFc2Zi9Hd2h3ekZpcEQ0NXY1Zy9mOVVRWlEwakNWMUN5L1VlQjJzdDZGUC8z?=
 =?utf-8?B?NkdXNWIyMHN4SHVoV0I0TkV2VGw5dGdSTE1iZVlGY0ZOSWE5UjNjZzVlNXRj?=
 =?utf-8?B?REJCWVcxVExHMXpBUHh6dG5SRGhZRjE4Q0FHeUNqcGV6a2pSVkVwM3dGa1Z3?=
 =?utf-8?B?VklqVG1UbjkvNXdHYk9uZlo0ME1FVWxZTW0yR3NyNVpRU29NejJnTjYwdDBH?=
 =?utf-8?B?eUI1OEdnYksvVEJIYkZUM3B3SEUvZ2l6UlAxVkhWM1JCVkN3RUhMZmlyZ0Ny?=
 =?utf-8?B?T2MvUmZlSWc0MkhlYXdTK015aTNDdy8vZTF4UE03cXJmaVUvbHZTV21BdlhZ?=
 =?utf-8?B?YnBGTmVvTW1DQ05GUkpCYjUxRHVxUElZcEpreVpLSkJvWEk2R1A3K3Nrbndn?=
 =?utf-8?B?b3lpWUlyWlNjUHArNENrbUllUHZCNlRDTTIvN1R5T090aUdqMTViRjRoMXhw?=
 =?utf-8?B?dXFhM2c0SjdnM0dvcGg3S2ZXRlVqeGZDWHIrU0RCSGFFMzFFZlY3UFhROTRV?=
 =?utf-8?B?dWVzZnZ0SjkxdHplT3RXQXgzNWcrZUt5d3h4QnY4UTlBN25USUVwRWhtVTZM?=
 =?utf-8?B?T0xybmVUb0ZYemkvUDFYM041bEFENTVZUHJ6eU9iWHhwbXF4UUVMVEhNWHEy?=
 =?utf-8?Q?Svy4=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:56:44.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7f91e9-0484-4c06-f832-08de52470115
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5961

Hi Robin,

   Regarding your previous comments on this patch, I wrote some 
questions in my last email and would like to continue the discussion.

On 12/17/2025 10:12 AM, Jun Guo wrote:
> 
> On 12/16/2025 8:51 PM, Robin Murphy wrote:
>> On 2025-12-16 12:30 pm, Jun Guo wrote:
>>> The arm dma350 controller's hardware implementation varies: some
>>> designs dedicate a separate interrupt line for each channel, while
>>> others have all channels sharing a single interrupt.This patch adds
>>> support for the hardware design where all DMA channels share a
>>> single interrupt.
>>>
>>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>>> ---
>>>   drivers/dma/arm-dma350.c | 124 +++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 114 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
>>> index 9efe2ca7d5ec..6bea18521edd 100644
>>> --- a/drivers/dma/arm-dma350.c
>>> +++ b/drivers/dma/arm-dma350.c
>>> @@ -14,6 +14,7 @@
>>>   #include "virt-dma.h"
>>>
>>>   #define DMAINFO                     0x0f00
>>> +#define DRIVER_NAME          "arm-dma350"
>>>
>>>   #define DMA_BUILDCFG0               0xb0
>>>   #define DMA_CFG_DATA_WIDTH  GENMASK(18, 16)
>>> @@ -142,6 +143,9 @@
>>>   #define LINK_LINKADDR               BIT(30)
>>>   #define LINK_LINKADDRHI             BIT(31)
>>>
>>> +/* DMA NONSECURE CONTROL REGISTER */
>>> +#define DMANSECCTRL          0x20c
>>> +#define INTREN_ANYCHINTR_EN  BIT(0)
>>>
>>>   enum ch_ctrl_donetype {
>>>       CH_CTRL_DONETYPE_NONE = 0,
>>> @@ -192,11 +196,16 @@ struct d350_chan {
>>>
>>>   struct d350 {
>>>       struct dma_device dma;
>>> +     void __iomem *base;
>>>       int nchan;
>>>       int nreq;
>>>       struct d350_chan channels[] __counted_by(nchan);
>>>   };
>>>
>>> +struct d350_driver_data {
>>> +     bool combined_irq;
>>> +};
>>> +
>>>   static inline struct d350_chan *to_d350_chan(struct dma_chan *chan)
>>>   {
>>>       return container_of(chan, struct d350_chan, vc.chan);
>>> @@ -461,7 +470,61 @@ static void d350_issue_pending(struct dma_chan 
>>> *chan)
>>>       spin_unlock_irqrestore(&dch->vc.lock, flags);
>>>   }
>>>
>>> -static irqreturn_t d350_irq(int irq, void *data)
>>> +static irqreturn_t d350_global_irq(int irq, void *data)
>>> +{
>>> +     struct d350 *dmac = (struct d350 *)data;
>>> +     struct device *dev = dmac->dma.dev;
>>> +     irqreturn_t ret = IRQ_NONE;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < dmac->nchan; i++) {
>>> +             struct d350_chan *dch = &dmac->channels[i];
>>> +             u32 ch_status;
>>> +
>>> +             ch_status = readl(dch->base + CH_STATUS);
>>> +             if (!ch_status)
>>> +                     continue;
>>> +
>>> +             ret = IRQ_HANDLED;
>>> +
>>> +             if (ch_status & CH_STAT_INTR_ERR) {
>>> +                     struct virt_dma_desc *vd = &dch->desc->vd;
>>> +                     u32 errinfo = readl_relaxed(dch->base + 
>>> CH_ERRINFO);
>>> +
>>> +                     if (errinfo &
>>> +                         (CH_ERRINFO_AXIRDPOISERR | 
>>> CH_ERRINFO_AXIRDRESPERR))
>>> +                             vd->tx_result.result = 
>>> DMA_TRANS_READ_FAILED;
>>> +                     else if (errinfo & CH_ERRINFO_AXIWRRESPERR)
>>> +                             vd->tx_result.result = 
>>> DMA_TRANS_WRITE_FAILED;
>>> +                     else
>>> +                             vd->tx_result.result = DMA_TRANS_ABORTED;
>>> +
>>> +                     vd->tx_result.residue = d350_get_residue(dch);
>>> +             } else if (!(ch_status & CH_STAT_INTR_DONE)) {
>>> +                     dev_warn(dev, "Channel %d unexpected IRQ: 
>>> 0x%08x\n", i,
>>> +                              ch_status);
>>> +             }
>>> +
>>> +             writel_relaxed(ch_status, dch->base + CH_STATUS);
>>> +
>>> +             spin_lock(&dch->vc.lock);
>>> +             if (ch_status & CH_STAT_INTR_DONE) {
>>> +                     vchan_cookie_complete(&dch->desc->vd);
>>> +                     dch->status = DMA_COMPLETE;
>>> +                     dch->residue = 0;
>>> +                     d350_start_next(dch);
>>> +             } else if (ch_status & CH_STAT_INTR_ERR) {
>>> +                     vchan_cookie_complete(&dch->desc->vd);
>>> +                     dch->status = DMA_ERROR;
>>> +                     dch->residue = dch->desc->vd.tx_result.residue;
>>> +             }
>>> +             spin_unlock(&dch->vc.lock);
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static irqreturn_t d350_channel_irq(int irq, void *data)
>>>   {
>>>       struct d350_chan *dch = data;
>>>       struct device *dev = dch->vc.chan.device->dev;
>>> @@ -506,10 +569,18 @@ static irqreturn_t d350_irq(int irq, void *data)
>>>   static int d350_alloc_chan_resources(struct dma_chan *chan)
>>>   {
>>>       struct d350_chan *dch = to_d350_chan(chan);
>>> -     int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
>>> -                           dev_name(&dch->vc.chan.dev->device), dch);
>>> -     if (!ret)
>>> -             writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch- 
>>> >base + CH_INTREN);
>>> +     int ret = 0;
>>> +
>>> +     if (dch->irq) {
>>> +             ret = request_irq(dch->irq, d350_channel_irq, IRQF_SHARED,
>>> +                               dev_name(&dch->vc.chan.dev->device), 
>>> dch);
>>> +             if (ret) {
>>> +                     dev_err(chan->device->dev, "Failed to request 
>>> IRQ %d\n", dch->irq);
>>> +                     return ret;
>>> +             }
>>> +     }
>>> +
>>> +     writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + 
>>> CH_INTREN);
>>>
>>>       return ret;
>>>   }
>>> @@ -526,7 +597,8 @@ static void d350_free_chan_resources(struct 
>>> dma_chan *chan)
>>>   static int d350_probe(struct platform_device *pdev)
>>>   {
>>>       struct device *dev = &pdev->dev;
>>> -     struct d350 *dmac;
>>> +     struct d350 *dmac = NULL;
>>> +     const struct d350_driver_data *data;
>>>       void __iomem *base;
>>>       u32 reg;
>>>       int ret, nchan, dw, aw, r, p;
>>> @@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
>>>               return -ENOMEM;
>>>
>>>       dmac->nchan = nchan;
>>> +     dmac->base = base;
>>>
>>>       reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>>>       dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>>> @@ -582,6 +655,27 @@ static int d350_probe(struct platform_device *pdev)
>>>       dmac->dma.device_issue_pending = d350_issue_pending;
>>>       INIT_LIST_HEAD(&dmac->dma.channels);
>>>
>>> +     data = device_get_match_data(dev);
>>> +     /* Cix Sky1 has a common host IRQ for all its channels. */
>>> +     if (data && data->combined_irq) {
>>> +             int host_irq = platform_get_irq(pdev, 0);
>>> +
>>> +             if (host_irq < 0)
>>> +                     return dev_err_probe(dev, host_irq,
>>> +                                          "Failed to get IRQ\n");
>>> +
>>> +             ret = devm_request_irq(&pdev->dev, host_irq, 
>>> d350_global_irq,
>>> +                                    IRQF_SHARED, DRIVER_NAME, dmac);
>>> +             if (ret)
>>> +                     return dev_err_probe(
>>> +                             dev, ret,
>>> +                             "Failed to request the combined IRQ %d\n",
>>> +                             host_irq);
>>> +     }
>>> +
>>> +     /* Combined Non-Secure Channel Interrupt Enable */
>>> +     writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
>>
>> This one line is all that should be needed - all the rest is pointless
>> overcomplication and churn. And either way, copy-pasting the entire IRQ
>> handler is not OK.
>>
>> Thanks,
>> Robin.
> 
> If the design uses a single interrupt line for all channels, then I only 
> need to request one interrupt. When the interrupt occurs, I have to poll 
> within the interrupt handler to determine which channel triggered it. 
> Are you saying that just this one line is enough to achieve that? I 
> don't quite understand.
> 


Best wishes,
Jun Guo

