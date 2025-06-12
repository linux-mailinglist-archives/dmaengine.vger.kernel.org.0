Return-Path: <dmaengine+bounces-5388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963EAD67E9
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060CC18984D7
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741821EFF9F;
	Thu, 12 Jun 2025 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RA11Q7b"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A114A8B;
	Thu, 12 Jun 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709293; cv=fail; b=fv73xDE//RCTHcCa1YZR/yDAvfJa4xpYsto22XbXNo5HTIG1B0q2rjDgD/pWVqOMPoQCOpnEAhP49cp7aL2PJiytGrrxZr/c4jiLl7xwBXJv9M/iJAEoMr6lTBf1BBMI20rjuCxhN7jht2JsJz5XqYNdWahmaUoaXFvgkrVOodU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709293; c=relaxed/simple;
	bh=0EVw5iEaORvrShqCWJi9bKWYiL7z4yBzXjHFFVnmrLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DgYvoK9SCxPwjaSCpYAv6MJTM1QUD3OGcPBqiPhze6/iDa3ZTDryfrbCH0S/uHq1FwG55L3LTK6fjW1r770+PRmkMkzNxnnTmklwohyI/ZMw2s4+m50YwbS8X54q2WeXS4qjgGxl6eHB1BFBc+EYBUMxXIrBSidaQq3OR5JDk3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RA11Q7b; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/QpRJq3qQq5La8NiUfp6YHfmNDktscM9wUao6Sq9PGPur+Rd+9zY7TxYUA0/+1IhsiT95d7RXR0BaDMhgrmA0FpLDPJF2RyLaVMy6dxpaElmPIrBWuugwa+72ZEj8cOxom+zIImyOjb4JPZ8RqdTXm8+iGNCB2mZaVG5/X5mfSLVOnSbPA1kcObbrYUP9TE5/DetDH2aRqf5QhvGIVadtZMmOGrn8CWyDgsy4i3WHs2AMeUlEMNI8S6mcOdZjEMUM5JIuozEKhBuMqRbUmh4g/Gjypn/gogQFc7sLsMuPdlXBfoKtVXOTjykDQxuaga5HHww0fPlcv1QqocrW9W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gOgozVtpOCSn2Pi7L9sAfxZS/xQb4q/SbhlxKF3dnU=;
 b=dFh/JOF4/4/OAdsKWmzwc/nvtgA8BEamDTrd+fvdQbHRgQEg9kZwSIYs/DTdSdwr/iCTMyFp7P9Ye9gmsYDD+LOlI/VVnhVY+Mx6c3E8fjo0V3OmTPEMymx9jx6/vM7aEUfpY+aMxMCHUvUXCK4ImXAsoWgParl8QylWnBfCf9w0nY6F5TDhmCET/pJz7OMA5gC3AK0UEOc1+cVMiRPh6/e/ljguDpCyBh89HYv2Y1EBYGNJM922XAwN/3pccW3kkNCWZMTnHOvi6wPAixn8nrQt9OKey1C4V28cczmzmaG7Dhel6YraNRCe7L5v+JOasv+hpsfilp2V3wMXDnMGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gOgozVtpOCSn2Pi7L9sAfxZS/xQb4q/SbhlxKF3dnU=;
 b=1RA11Q7bbzyUAX/gtFf3dREDAr2rm1WQC1upwRPLS9yijjYIVDf6QOnIYHUZ9wa/LVwUUME+msD3NcZl2Em+tx1q9XfsZImoWK9CoPzepzFI9mqOqPvx4aK77nWvLxUXmQkarBqaRrBGKuCk3cG6POvre9NlMsV3ZcAuPyDiTXg=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 06:21:25 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::fb) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 06:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 06:21:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 01:21:23 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 12 Jun 2025 01:21:22 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>
Subject: [PATCH] dmaengine: dw-edma: Add Simple Mode Support
Date: Thu, 12 Jun 2025 11:50:26 +0530
Message-ID: <20250612062026.1261724-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devverma@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ed16a9-c306-463a-719e-08dda9795b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PjU/K5jiKh5NXWg2T8Nh6m3rD25HymzVSIHExzyZK+CGK9FRfAta36S/H5NU?=
 =?us-ascii?Q?JaqvUOIPq9Ozk81/vRLa1QUAZKiCijElKpyWX/oSiJ1/KfCXcNRwFBczD9yP?=
 =?us-ascii?Q?cyJCFiDLjLGaHbGF73/qn5YMxC9qAmeKzW/wlibQmyVYgD9KD6OeUqt1cHeB?=
 =?us-ascii?Q?BwjHSZwO22v0HD/15n6XFdZ/VnH8YhLazzWG+nsY3bzd+skqysJtTJ+YKbq0?=
 =?us-ascii?Q?igKEFEtc1Eh+DTxS7tTrvzc9hby5M/wKzlwKWETP/sHStYre3SmjHqgSrosd?=
 =?us-ascii?Q?z1KNYvfmYZoQQmfJBG17DC8efqepPBAUVqANiEkIecXvr1WFtqgUwBbM9wse?=
 =?us-ascii?Q?66WzOeWu3D+ppEpotgX84wJP8b80s/qhbwMmi5m4fegM1abZ7Lpwc1Pa+F78?=
 =?us-ascii?Q?Fh991OgRFHBz/FMs2VnKLx5AQiHAvntsP1aRWQenC4eDdvGVzIdKJRX8ASZH?=
 =?us-ascii?Q?lxoY/uJ99edeQp2i25mD+4nM0t+BOZ/+GkBfchj5WcAwx9oB5nhdVj6/p8tY?=
 =?us-ascii?Q?N8JZPWqlZqCcMf3nT1d+yPiBkqsvz3HkYg70ERzPMHClf1E84SdQ0HUp5tN6?=
 =?us-ascii?Q?hWB3ukFjWVHbMgKUgTjFskSl1vfwy9iQ0itzOUE1nLrvZiRnuiIf5askyrnh?=
 =?us-ascii?Q?0uV7uwOs0GQOvhJRIW3GXZur9zDElZ7N+Os96Ff33lovKF7O815cGv1pMY4D?=
 =?us-ascii?Q?idXPJEl6N2owaTRSzKAQjdFrnDPGG4DjqtZAewcxrSonzZN/Bb8kiPBrzAKe?=
 =?us-ascii?Q?rYthlY8RJqdo/ItEx0o0FXUsDNllaDoGgeKVmd4R8L/vHHtS0Sjur5TxID0k?=
 =?us-ascii?Q?Sdcu7OyKUSXTURHoI/YcHhYhQv5KjWUXuJ9Swf2y1+7wFzFWgMOYPIgGYylk?=
 =?us-ascii?Q?X0hauyisBrdBowY717nuMokDorVNZ5jHt8GK3vYR++aAIJsiddNeLXhL2BS9?=
 =?us-ascii?Q?nc6J46ngz2bJOkPZRb7RAJujs+XfR7rLv6qF9aRPWYiB3lP7ynNNWVoS5Ak2?=
 =?us-ascii?Q?ZEbqOAiiwuD+2eKnsDpkyDAAZZRjG/G9w8yGiiPkVShX408YewhrdFL2DjEq?=
 =?us-ascii?Q?3hfhMDkNzZZ55m2At+ieRmDapukLTgu2sM21DaSaPswkvbmLY2cj6Bpd2Jl2?=
 =?us-ascii?Q?DSnnEHvPcl3HqonQmqACd1sS8muBHNzjEg3o7I0k9bSUpZATVLEMe8h8fgnq?=
 =?us-ascii?Q?yJvm1OjXb96Hd7hUQ8XMhQHUyZDPBbxUDoms9oL/B15B5KFE7zdatbDiGDxe?=
 =?us-ascii?Q?MG13ztdr8u/jj2eSYz+gOFZzJQE5Ne00cyS5vhA7P9z3gGroAAOh73FnKQIC?=
 =?us-ascii?Q?yMsSftT6Ydt/gTg6uYahVIYXiLrKg+9Pm3YyaYl/klclOzN8ml/jIZpHSElz?=
 =?us-ascii?Q?eZg35P6iOQZmviAVXyfQDw8/eonVZAenZfyVFwbYKT5bkmLKPtypXxx6AhmK?=
 =?us-ascii?Q?IqzMTFEgy+ZGcdbMps764+3ArsSduouAtb6SaQ4VT6/PeW8gok0RYAt/kEl6?=
 =?us-ascii?Q?MQRsJ3aS+VcCNNrkJ7vWi6gFHgDIRtjjENlK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 06:21:24.7025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ed16a9-c306-463a-719e-08dda9795b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

The HDMA IP supports the simple mode (non-linked list).
In this mode the channel registers are configured to initiate
a single DMA data transfer. The channel can be configured in
simple mode via peripheral param of dma_slave_config param.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 53 ++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  8 ++++
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2b88cc99e5d..4dafd6554277 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -235,9 +235,19 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma_peripheral_config *pconfig = config->peripheral_config;
+	unsigned long flags;
+
+	if (WARN_ON(config->peripheral_config &&
+		    config->peripheral_size != sizeof(*pconfig)))
+		return -EINVAL;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	memcpy(&chan->config, config, sizeof(*config));
+
+	chan->non_ll_en = pconfig ? pconfig->non_ll_en : false;
 	chan->configured = true;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..c0266976aa22 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,8 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+
+	bool				non_ll_en;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..3237c807a18e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +263,57 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+
+		/* Source address */
+		SET_CH_32(dw, chan->dir, chan->id, sar.lsb, lower_32_bits(child->sar));
+		SET_CH_32(dw, chan->dir, chan->id, sar.msb, upper_32_bits(child->sar));
+
+		/* Destination address */
+		SET_CH_32(dw, chan->dir, chan->id, dar.lsb, lower_32_bits(child->dar));
+		SET_CH_32(dw, chan->dir, chan->id, dar.msb, upper_32_bits(child->dar));
+
+		/* Transfer size */
+		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+		/* Interrupt setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+				HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
+				HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			val |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+
+		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+		/* Channel control setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, control1);
+		val &= ~HDMA_V0_LINKLIST_EN;
+		SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+		/* Ring the doorbell */
+		SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+	}
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (!chan->non_ll_en)
+		dw_hdma_v0_ll_start(chunk, first);
+	else
+		dw_hdma_v0_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..82d808013a66 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -101,6 +101,14 @@ struct dw_edma_chip {
 	struct dw_edma		*dw;
 };
 
+/**
+ * struct dw_edma_peripheral_config - peripheral spicific configurations
+ * @non_ll_en:		 enable non-linked list mode of operations
+ */
+struct dw_edma_peripheral_config {
+	bool			non_ll_en;
+};
+
 /* Export to the platform drivers */
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
-- 
2.43.0


