Return-Path: <dmaengine+bounces-5602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173FDAE3591
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970FA16B5DB
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3A77111;
	Mon, 23 Jun 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gItqbjmp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955C3C30;
	Mon, 23 Jun 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659463; cv=fail; b=kCSgvbJVe47D2m2CY5K1hXUX+mvP48Oc0ZobCxHLm3Y9yIV7Cnv+pO6YNvICoKa1XXJcOywaaYQF4MNPVcV++V6euYeu8v3+BaTizz28F4s5yUYjzhI7/EzI/iguNt/cv92xeLjiObmBmLgmX9DRdwMWh9WXnurW8CltG8FQ8X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659463; c=relaxed/simple;
	bh=0EVw5iEaORvrShqCWJi9bKWYiL7z4yBzXjHFFVnmrLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arK2XT789V8pZ4J0tT8f5a1h//hUfbGXaPUc+Q/TQFyUZ+Ix8sW2xXGfjGMx7CsKdP7sR1FKP8A33J8y+xpT+GJ8qHV/+xn4DVRnJX/8oOPYeOJRsVkisInxvUkWXf2ZhrzjbSsVAIlaq3+ghuumMcFcOgVhAAiRPXZ1jlTT6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gItqbjmp; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaCj3rLqs7Br9LqfEqMyND5wyyQgS2tD8tpeyoZFgUm3qw+x6QssdENvAaMZyV9n7dADY+Gxl+l7beKLQx/W8ZNxip+17j7tI/X7KoLKZEwNoLi9egzMN1UHH83tUJgtz9iYOm9ZLkOvKaGRFo1uGo6gqZVm5suGTKcBPTaEbHTcIAThJXmn/PW3uoLlyfbvM6ZPHfBtJYAkq/3BpwykNxuHgBLYxY2mzpIIPZEowo/F80Gn0DN5GNfu1v/3eAKL3L5eY691vxRF3uaCsUgMhfTWpTvvdAY2b31hqFYcmaMJ61aFHyfL2QPZD+0MGJpx9qj1ZMdIhC9rK1AXtWmWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gOgozVtpOCSn2Pi7L9sAfxZS/xQb4q/SbhlxKF3dnU=;
 b=Ls7lahnIf4EYJ0+hIo9pw0pJiyLt78OWwJo6nZYEVdY7bagAUjLN44dkH/f4bgJGemeilSMdUY6ob57m0wF2W5q++w3Qr9CHBxP5ZqFXSwUJkYvOoNHjA64qMvzxPmImlrcdW1Xi+E/j7cFRdr/Jtbd/NrOn/aKIuapq0vhByy+QHJVl9Z+AayQPzAq5kiP7lkwtQJ4gia05pDWeX1/xl9iyafwxaYsAJW3XyKPmh+St9oaADQG0LkVWPYnfW052/iQPCFGPL2gFBaKCfEMTHxIYKVBplSAdyHDRv7kQmACeD4U+PL0uSmgrTX8gdVGh1voBYWYXJmvEZCMZwJFGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gOgozVtpOCSn2Pi7L9sAfxZS/xQb4q/SbhlxKF3dnU=;
 b=gItqbjmptuOtDqmOMloRsSKeyXhTyEI/0XLD4T+XkNTAaXK9QBx5CmSZ8gHNRq9VcHEY353ETOTnre9zxXBOy0dHYfh09ZzpecnXo72DmH9OpIQnlIza0DMMk0/+Jf4ub88ErlQEIbQ1r6DNkKZmxd0mR1NYlpLhM/4qXGeySv4=
Received: from SA9PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:6e::11)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 06:17:39 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::f9) by SA9PR11CA0006.outlook.office365.com
 (2603:10b6:806:6e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 06:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 06:17:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 01:17:37 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Jun 2025 01:17:35 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mani@kernel.org>, <vkoul@kernel.org>
Subject: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Date: Mon, 23 Jun 2025 11:47:33 +0530
Message-ID: <20250623061733.1864392-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a559591-d18e-46ae-24d6-08ddb21da6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ivw+0naQXhn7tGTqabp9JEZkD7YM8LoI9XkwE8wAFWw6qwp2bSGdHbUiNcch?=
 =?us-ascii?Q?l/s7PTtL8D8ox0N6fq5N20ja4FJKSVQwqQenhvVDyNm+bZP84F8DOzNldVFe?=
 =?us-ascii?Q?Frm/Vrb1i124FfxWVvgTO4M9xVaMm42XPVx6PtCHR+KxoHy6Z1Zk/vA8XoYm?=
 =?us-ascii?Q?Al5hFm2q8kHa1rGxu1uIUvvrWegO+DhyfsMPD9DKfZkga+y1Ua/Uu8QESp0m?=
 =?us-ascii?Q?KYQHhpEm/ZY3MTsEyr5zr2KgD8J+nl5qODo74XNR2UGIzZ/N1W0Fw2BvfVT1?=
 =?us-ascii?Q?OO3VJBCGYVmm0HJcWkXllUOPD0CmEwpdFWMLRbgWxJfMIXjjZBsWiqlgMT8S?=
 =?us-ascii?Q?SHEsI9p0KiZUrunl/wah9CY6XO8FhKuJyDb24aPzK9z3IAZkd24iYo8W5166?=
 =?us-ascii?Q?7q3iddMKImGeJSp1ZTz0OCx098fa2nFR9O6TISA0rk5GRNFDyIGLKO0YjKp9?=
 =?us-ascii?Q?ER/4zMsgRo7fRETLV1HuC5xBqnw+Yisrre8nYMd1uD6JvI7B3P4G8JahkrzA?=
 =?us-ascii?Q?wggMMFY2DLyRuX45uO8cKFraBjz9NXpFBjiVCBW/0lYq3r8eopRRK/QPBfmr?=
 =?us-ascii?Q?I5vbU6u8a7iMvdykLdOcQQB1FT+0AetUUjanW0mmgsRcQwHMTF3OdyhCNXDX?=
 =?us-ascii?Q?nk5G0W9ur99JcvqbmhQfO8aD20ZfQtpoFZLG9db044LIJWHThMEH07Zgh+iR?=
 =?us-ascii?Q?PXDWJedGW8i/DmfJlOJgkBYr9fdqI1EbB1I4COVeFAM7yFEhesqjTVdfaly8?=
 =?us-ascii?Q?KaFRfOFZ5FvX0oDG16/kInD0S/6Fc1XMsq4hJz7ZPMFaaQ30T59hhRKDY7de?=
 =?us-ascii?Q?CqzgUMJ+g5+BXw8fKP7m1bRupgTS9dNlEFwgiyUJSmZsRQnO9kkcQ2E0X40c?=
 =?us-ascii?Q?HoS6urHTPPpi0YAY7mMXaOEdeAq5mW59MnXR/5kF1lRAaUTAhh2YgNMHEvch?=
 =?us-ascii?Q?k2YsLNv1dGJ+BUk1bc6tK9PvURLBkXH528mxuls9f41EZ+MESosetDm9Obp+?=
 =?us-ascii?Q?xr3kb7Zf/nJKIEUPxU+Rw7sJD1Kvz42vHcgOBijShP7M80jcXCqXCusBp6zY?=
 =?us-ascii?Q?a9cdqVFZEo4AVabBzKt0wfx9fhKQVXu/M4akbIKWsqrqGqLHnZIzHnuSNEc4?=
 =?us-ascii?Q?BKdoL1ioV/WXk5WW/5zhOU/HW37IowA9rPhA1Bct3WU4uqdzGomATqtKPsIJ?=
 =?us-ascii?Q?MRvlMSvonmBX3ATuAcTt/j3y8LSCVx4xffVUhf1vmk1KfHIzOvQlHMf7hEOx?=
 =?us-ascii?Q?DKBz7nPq5tm6dRkw3L8zCGnat0xTyTS2RWBPfh6AFR9NFDDma0LW20Cp0rPI?=
 =?us-ascii?Q?K57QI474RJSsO6imbamU7hCwdNY1OmU5nfZux6+9xLzdCVJVtiGnundoYwK9?=
 =?us-ascii?Q?SHvBOIOTxh9AWdFWvfzZQ+b+VMsnuylJG/yuhM6nss9pzlieo49hZDSc3G+r?=
 =?us-ascii?Q?9p0J2DdmxTCY6LTwFiKibpZBaSqLPk3PX418/Re0a7YRFV1cZWPpvDlCioHZ?=
 =?us-ascii?Q?m95Qn8Uuved4tL0mbezRgAnkNt9q1NWqu3+T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 06:17:38.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a559591-d18e-46ae-24d6-08ddb21da6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

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


