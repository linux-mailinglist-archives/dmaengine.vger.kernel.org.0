Return-Path: <dmaengine+bounces-5755-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03420AFFED7
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718AB17F886
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B282D9484;
	Thu, 10 Jul 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4UuUJ0Y/"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8082D8779;
	Thu, 10 Jul 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142368; cv=fail; b=aDHLW4HIa9rerSufgYtkahn8Pl+6skwgW7VAsQZnGkt7qVDJQ8+rQC2vU7WfaggyP54453yaIcuapQ9GRHGLnVfYXKrD9JugR8g/W2g1z9o3AeBUkgX2RG74wMC/uL+UnuY5+lthMaSsDTdosgLZjsI7ttwFmphxR2TI95laKgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142368; c=relaxed/simple;
	bh=KbW3nJ/nB8GXsTHjkxKeOig/WZ/xyyx4biEAF49FA4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bpd/dd+1LbajYHErsbHz+1pvwEHHxyAYdi9WvlcT+Tphocd8mUGxMWU+5TAbvSKBNK8ZlX/vGp7u+cDu6DgBc7YOX2XfnAcPKkmzYc2Z//CkpG0nsCo972nLqsEZL7ovlAnnmHYbTqIEN2Low2G3uIUyhjQEyWRLRUJVwg9bppc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4UuUJ0Y/; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy5jDFcxjH/ha16+QZbAmsA2SfMwwHV+5IWAAmPojbKPKou7eV1ol8CLikMkao9aMkMdmiocYVPwKE/gRPiFVngwycGvFeUNsHqOqx6/X1VV+Mg0XTaurqmXccf9GJYTRzar6T7OkRD9bk49lmAzPJ6Sg4+PVUV6mZ4zYa3be8IpMdNI5OXGR2uYG4z7gOdF1knNN/ubb1B5YqpBxYRKG8GfkTfNoOf55IgoI7qaI1pbEIukiPcmGliKtE+UXiXNmTfNCnSCBUlruonka7d1SKpykNHOVpTVhveqG8bvE5jqgn+5iYNt2omrDwa5brMv7JoBJ7+R03r0aMg9yz1zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLsqIcc1NY4Z3pPdlgog/tSwIjIetvzg5+2aMCuUJyg=;
 b=Hta13w9MQkWRMvVO2VnjAMygCpDA754ueY+7h2TW6W+Cc8jm53b45BohmbY6WCusOn2AVudtvPRmMYyzQmzzyYx9lHzc1Ta34pxdZ5lUu9NeMRvEIs7eAog08lqDuWhZg89ogxIILIgJjMcazDOm+FjFcbyQMsOAur5x2frHpXTpYXJjjWZr3xn+ce2PCqeclDpSwn06hc/Eo0tGqMIvrGJa5VZQukUBE7JYTqpZzVeHxNR53mG3uUxVGsxx6rnmsJLyD4E13lB7TDMwiQ82SWluUa3RicKNy61aQp9UalPHO/BTsKN8OFT6DvgQMbSYaFhDBT94oge7YH9OVgQuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLsqIcc1NY4Z3pPdlgog/tSwIjIetvzg5+2aMCuUJyg=;
 b=4UuUJ0Y/TCtbPc7a+KscorsCTvWRlolBXSglEZ11Z1szYcrsn8FEluT5Eec5kWDvmvzAQ2YGjB4F1LvXTjsHhVDsa21cvKgRXoCBbd9kQXQJ2JuTWLGwXsVaAZalJXZIVUVoqPDE2+U13TNdGtKFGp4qVYZIOqB0wf3zN2aO3so=
Received: from CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::16)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 10:12:41 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::91) by CH0P221CA0012.outlook.office365.com
 (2603:10b6:610:11c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 10:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 10:12:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:39 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 05:12:37 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
	<radhey.shyam.pandey@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH V2 2/4] dmaengine: xilinx_dma: Fix irq handler and start transfer path for AXI DMA
Date: Thu, 10 Jul 2025 15:42:27 +0530
Message-ID: <20250710101229.804183-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710101229.804183-1-suraj.gupta2@amd.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bef3777-1c70-46af-810e-08ddbf9a4dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cumfs2WR7eXTAe8vByMF/pl302EyCekP0MtLZTJrV8yXExvcunqQlNeblldZ?=
 =?us-ascii?Q?CqVMiI6xtfvqqkkR1ih9uidOw+xbf/4u0WUlBOSkkRJTHI9mX2fHTyFGLxef?=
 =?us-ascii?Q?4DZ6YbR9iJE55MxSJr8r4q6106E+LX2i645OBo90V44IeFkjMrH4Fky2wdkM?=
 =?us-ascii?Q?sCm4oiWomb3lJSIDNRAZHEU3z2GKyLDhJ7edY9Iiy0V/18egUm+DoNLL94xM?=
 =?us-ascii?Q?u4MMLNMd1zK+Lv2cU4Hvh+sH15GFZ0TqrrdIjhg3HkjsWpRbBQ0561EHC0Ae?=
 =?us-ascii?Q?y/gSw+H/6exFcy39adTa07nPhgIPWw00Dq6aoSl1Xs4tBtdIfN1hvWQeYQ9M?=
 =?us-ascii?Q?uzMwlc8vu5cH/kCrGRM/xCKYkzioUQUJlusvQbRUO6kUFpeBNgJo3i26j8ZG?=
 =?us-ascii?Q?2J43bqF7i+Tnt+XSa+c6pio+BMMlr5cqZFBG55ByMIli2bSlkKSTGQO9QAZc?=
 =?us-ascii?Q?yGimzr5Gd8w6epMPnlDhAdx9kUHnzBY1flTG9vwwYr7bNkh9MQITOcXK/rQP?=
 =?us-ascii?Q?nwy/ATpL0ZOB1PaihgTc/jgvPlhpSx4JRLvtVSomY7iASVMrIPCwAYPPYnWF?=
 =?us-ascii?Q?ZvK2sMULYmiJj0Z5c2ZLxxPqDlNaPcZx2bqpkuuJ8EShXpYZtJmApwuvvgSU?=
 =?us-ascii?Q?fmeRTIKMaotsCLiXMzHWVQ1P3064SgZTD2kebyLLNu9rTXAdQUMYbWBBSbml?=
 =?us-ascii?Q?M96w7fCoBF7uX+8dGt24SEe2gfId1DZgyP7EdJWb7/Qm1afiK36W2bppT3lo?=
 =?us-ascii?Q?/io7If3IkcWMvznHkSvxrlFkVz+23YoJbPLiji9ctqx+G/1VrCvhLEW04BS9?=
 =?us-ascii?Q?46+NtFdqukf9J8CcGDhtBuHHFC1wweZ197mo2as8rUd4gTIqNZLWBZD1dcvU?=
 =?us-ascii?Q?2c98iIpjAPj0UmTyaqenGHvstxle5IQGtY3S57rbWNAKdawjL1cxOLLRC3sM?=
 =?us-ascii?Q?5Wo5YptKHA5TwHE7AR1ZO4+lYFMWfeT1ZdwVQqttns0hCRdJShOxDxpetR8R?=
 =?us-ascii?Q?GlqQgqedmpdghKKTJTX2A9iEhIMrgBsa/tQAiL1bgDEuIzdKKlCYflYslzjE?=
 =?us-ascii?Q?OmB9P6FAl4syKZuM8JGSKOmLdGBrbnKumezJ9feAm/WCslf2T2rCz3jpFMkr?=
 =?us-ascii?Q?daOymQc8AoofyEBBwiUDP98q6nBQi6MPwafvs89exsgRjsBPlazwd3xBhHf8?=
 =?us-ascii?Q?g6SXcJRLGV8KKxP+tdGug8o2QauAqdiTfvvwnxWLpGQEBPEE+9FDaL8Fsp9A?=
 =?us-ascii?Q?KSQsxNJWfY6PRhtXtsoH04tpUR+jew24uG7aYfS69zDp34is2XT8eL1Cq3A/?=
 =?us-ascii?Q?1BgmT97VtUc04IapqjhmFBNY374q3JkTIs4TQE6WUqNecugebvbSz8iVosOA?=
 =?us-ascii?Q?aHhYCevqFcQl/uoHiZcH+YKHHue68L7ykPkjmL99Wdpkh3vYLBDeHLWc7ZZh?=
 =?us-ascii?Q?w3ukoD66X3cjsySU3N2R3JRFDC5JJHR3mA/xL/aqEaI5vlsUuuTzwTiittdz?=
 =?us-ascii?Q?IDTQhz5NFD7G3ogkgPCMqXEjszXr+cIEGPa+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:12:40.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bef3777-1c70-46af-810e-08ddbf9a4dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

AXI DMA driver incorrectly assumes complete transfer completion upon
IRQ reception, particularly problematic when IRQ coalescing is active.
Updating the tail pointer dynamically fixes it.
Remove existing idle state validation in the beginning of
xilinx_dma_start_transfer() as it blocks valid transfer initiation on
busy channels with queued descriptors.
Additionally, refactor xilinx_dma_start_transfer() to consolidate coalesce
and delay configurations while conditionally starting channels
only when idle.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Fixes: Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
---
 drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a34d8f0ceed8..187749b7b8a6 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (list_empty(&chan->pending_list))
 		return;
 
-	if (!chan->idle)
-		return;
-
 	head_desc = list_first_entry(&chan->pending_list,
 				     struct xilinx_dma_tx_descriptor, node);
 	tail_desc = list_last_entry(&chan->pending_list,
@@ -1558,23 +1555,24 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_axidma_tx_segment, node);
 
+	if (chan->has_sg && list_empty(&chan->active_list))
+		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
+			     head_desc->async_tx.phys);
+
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
 	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
 		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg)
-		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
-			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
 	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
-	xilinx_dma_start(chan);
+	if (chan->idle)
+		xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
@@ -1914,8 +1912,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
-- 
2.25.1


