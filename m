Return-Path: <dmaengine+bounces-2927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73984959EE5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7241F21CCC
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08671A7ACA;
	Wed, 21 Aug 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mAeZURDQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D91A4B98;
	Wed, 21 Aug 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247656; cv=fail; b=Sm26O+nN1rwcJlVd/oAw2rBM+MPH3TjVfaaJcCorqv70g6nODFFZTZNiGI5KJEtK9KdLRdcXEqJwCGu2fWNVctvHTBlCmhHquusmMu2yUR2Hype7zboixNq+KiiI5i7weiDTasGXmcvUmjLzbOs8RKRbUHmRwDNExWhUwvfbjsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247656; c=relaxed/simple;
	bh=/ree/yEnVNNDnz82YfhRbvfe7o67yEWnDw3JFDFL+Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y42b5hXnK69ONBYVXmDegU2gs9yC8lsXQJpbp/OWWClyM1Jjd+Yha6XjwxmjjmzQyzn+wjs+/0awFB9kQEr+yqdwsnb2RvJ0V12V3CscI5lU1fvE8rc1VVs1uT8R09Xc+BmWDhHzlLo1NXIw6M9L3+AYeEVH/MEDjwCLmopqONs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mAeZURDQ; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3zhpCiUGBY3lxMbeHMhiynLJyvbQk70CyM6O4bR3iFpzxu0gnfSNIKCHQY9nDy++yW9qAs1ptLmqg032YzV0NBbMfxePzURIxkXatlwLhk5rluuDbt11R5UZuX5wkHMNpH1RWBj5+EUWvroxxdByGpjomioU50y5T74lvwNDpCfcinXhv/wufHUiA2kw0epzx2S1gN+bDqM85rs9GkOl4LaXRMqmGx6rVZHQU+yTTrhQIy9iIHldS/FDNVHIWGOCVjqmv0JHk3NGsR+UEa8U1J8dr2sw0KAWV7uGfVJovFMwa26t9qDUK7JGSivX4v8rKsct9nmwU3C2pmKLP0QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkq60Vswh5YghXxNNO/NyBf/0xieb+q0DRK6whcAT/Y=;
 b=xNYFLr2cBMIUyiCTo3ei+awSfl3B7XK3cEFJvtAgHt1kvT8rVOiomiUsw6yeLzCiAE/VYLB0LnwvB3TQhXrYcy1jPeWB9z25aT22KW4kzw0z5nz15RI6KTSdRXaxB0bs7Jb80rusPxMIlBm2Ns5eKtWJG7kPpnyr6MgbC7BmHtNkbZpGLmTJPmTrkjYGNtJBfE/mfgkmCwGDsgyfULi5gk/kIsyTTxqfQ9K4dqx5ZZTT8Ev8UKiin5StzQSnefzHVBOuSPO+h27xvV4knugIJ4IHevdWDulvEEa03vM9CoXKy4xwx0b1+K8OPDu42QisLErBLGDBKvcsnGh7jxuzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkq60Vswh5YghXxNNO/NyBf/0xieb+q0DRK6whcAT/Y=;
 b=mAeZURDQOtwlC1TeFe3DJPrvc2jWFPyjH9P3vgtok5MHOa2u0xACcEMrkcX9Jnj7UQx66yEKno0pJYeNggMr92FFCDv07MBTEyAc5t3aikXihqrhheHYJ2nvj0yyjMuwZM3X5Lhr05/+QI7Orj9UPsOCksEfY+awWmcWtjQ0WqQ=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 13:40:49 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::88) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 13:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 13:40:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:40:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:40:44 -0500
Received: from xsjssw-mmedia3.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 21 Aug 2024 08:40:44 -0500
From: Vishal Sagar <vishal.sagar@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <tomi.valkeinen@ideasonboard.com>,
	<vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<varunkumar.allagadapa@amd.com>
Subject: [PATCH v3] dmaengine: xilinx: dpdma: Add support for cyclic dma mode
Date: Wed, 21 Aug 2024 06:40:43 -0700
Message-ID: <20240821134043.2885506-1-vishal.sagar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aaf7d0-6fe3-4e7d-849f-08dcc1e6de2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFqOStvKSWU8WOw0mWYRaAzLdNB8k66+CEhbpY+3T/rSSIPjLOjP2fGy/pRP?=
 =?us-ascii?Q?PDg3TAvMV4CI0uGYwOPsJQgdtH8TL2OEL1CYFsLscJXTn25iyxlKPUQ6Y8JQ?=
 =?us-ascii?Q?VRQ7xW5J/14IgE+xxTbF42haamyLFhek5C9LfpG27Iiby68oqZdnoNA8C+Tk?=
 =?us-ascii?Q?CpNxuGKS39nWwaKDunWiUUxdxOpkGaQWUO9BCqmBlYNRUokgATKbYdunTNAE?=
 =?us-ascii?Q?yIw6bLLDCFjBlW/PgyHmgukgf4PTltuLdyPRpqOh6LCvxItN8khXdM1JwS20?=
 =?us-ascii?Q?tDinCUVynptPUivpFZhFPC6x+vt/2IBm9nu9socgBOy4dmVLZwVXsVQcb190?=
 =?us-ascii?Q?c4FMO2aDNk/EANaFiq4paL2gXfdfmwPomG24icFVnJkkQKA1EqxshDYJZiYf?=
 =?us-ascii?Q?HI35ictqMZRHUjxn/NJiTvF9wKXeVj2fy9jyUsEj1CMNf08JcXiTDLz0wcUw?=
 =?us-ascii?Q?jMejP+U4OCfmkxcZ0AsalUPsN1E1pV45mxi/bQtuz1bg0RP+7OLbBHwtA2rM?=
 =?us-ascii?Q?B25WbG4BgSWgWYxSlSOk4w8OXfT7UbnhIJ1I5NOVoIvX+fdXi5gJLBXwtVQa?=
 =?us-ascii?Q?5tnV+m3Jad0zRxgPiqaELnVIEtIuDi/2yx2fcJWIl+m6SPpuyOaXHZKlu9i9?=
 =?us-ascii?Q?epIogfpFap5gzuFsg/wtYvvk6xMky2xQ2l1HQRW/bmqdil1n3D6zp3+IvAWc?=
 =?us-ascii?Q?RaZV9hbXFRub7i5y6Dq+t/JOLvcBBYi/AOxr3YVt5ZIyNs5PHX2ec6xsR9Lu?=
 =?us-ascii?Q?69Ffy8cgSI7teY8dBUOa/iBD833igvM8n/noJAD0u0spgg5R1xNVCtkQMuky?=
 =?us-ascii?Q?afSH+wO0zcY2Bv3/sDyoJMAGix6xPqYJ26WmSUlRJq0UkHHlGuFbdNrn6i+2?=
 =?us-ascii?Q?Ri0pBwqoU9TA/HJCzx4sdx6ruaKP1bp2f713pUA86FCom/TBaTnjVK+LoixD?=
 =?us-ascii?Q?o23NvUqu60f/oWzMOGIYmjk+1ZPTFH8WI5x06wFFSiYi4KkBAXOi2plhivtj?=
 =?us-ascii?Q?nzQuQAflW95Af0sKhM3UR9zEn7Ow2wwLLKOjws38pD6QDZwP1hDa8Zp7tT1u?=
 =?us-ascii?Q?Uq3PYZ5QyfcdvjzWhsbdUY9zQkrBP64S8WtFixaNeQOVfjaZml8JbMVG+xQu?=
 =?us-ascii?Q?bnv4FwpatujdSwkro2+bqmaevN2eAAsreCbcJRzqaqFlyPJaZu1hqxd/j6au?=
 =?us-ascii?Q?UkYy518xRPx/G3BqtrBf5y/ZCkfUImHGTmBPx0HeFNz+feuTkTKY2OpC2S3R?=
 =?us-ascii?Q?Ep6rmy3iOhCi5YlIkIIcMC6aIz/0cwQK6nSW8cGeoUO8JW4S37APbjaTeqSO?=
 =?us-ascii?Q?JQJ98Xv2I3c5SUoa+80H3rNVRfQEXdRnSMxhj7Do5urV6XrszcsCe7j1fRLP?=
 =?us-ascii?Q?dYlj+iM7ATHcqc2ZO79U4OR9PIMLbw4iidIW3nnhR12sCVvG1Y0wv/vghEEA?=
 =?us-ascii?Q?Ews7tfjfNsM9aAJt2ChnizH2aigB8yJq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:40:49.2525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aaf7d0-6fe3-4e7d-849f-08dcc1e6de2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

From: Rohit Visavalia <rohit.visavalia@xilinx.com>

This patch adds support for DPDMA cyclic dma mode,
DMA cyclic transfers are required by audio streaming.

Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

---

Change in [v3]
- Fixed cosmetic changes as suggested by Tomi
- Added Reviewed-by Tomi

Previous version is 2/2
https://lore.kernel.org/linux-kernel/20240228042124.3074044-3-vishal.sagar@amd.com/

 drivers/dma/xilinx/xilinx_dpdma.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 36bd4825d389..77b5f7da7f1d 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -670,6 +670,84 @@ static void xilinx_dpdma_chan_free_tx_desc(struct virt_dma_desc *vdesc)
 	kfree(desc);
 }
 
+/**
+ * xilinx_dpdma_chan_prep_cyclic - Prepare a cyclic dma descriptor
+ * @chan: DPDMA channel
+ * @buf_addr: buffer address
+ * @buf_len: buffer length
+ * @period_len: number of periods
+ * @flags: tx flags argument passed in to prepare function
+ *
+ * Prepare a tx descriptor incudling internal software/hardware descriptors
+ * for the given cyclic transaction.
+ *
+ * Return: A dma async tx descriptor on success, or NULL.
+ */
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_chan_prep_cyclic(struct xilinx_dpdma_chan *chan,
+			      dma_addr_t buf_addr, size_t buf_len,
+			      size_t period_len, unsigned long flags)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc;
+	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
+	unsigned int periods = buf_len / period_len;
+	unsigned int i;
+
+	tx_desc = xilinx_dpdma_chan_alloc_tx_desc(chan);
+	if (!tx_desc)
+		return NULL;
+
+	for (i = 0; i < periods; i++) {
+		struct xilinx_dpdma_hw_desc *hw_desc;
+
+		if (!IS_ALIGNED(buf_addr, XILINX_DPDMA_ALIGN_BYTES)) {
+			dev_err(chan->xdev->dev,
+				"buffer should be aligned at %d B\n",
+				XILINX_DPDMA_ALIGN_BYTES);
+			goto error;
+		}
+
+		sw_desc = xilinx_dpdma_chan_alloc_sw_desc(chan);
+		if (!sw_desc)
+			goto error;
+
+		xilinx_dpdma_sw_desc_set_dma_addrs(chan->xdev, sw_desc, last,
+						   &buf_addr, 1);
+		hw_desc = &sw_desc->hw;
+		hw_desc->xfer_size = period_len;
+		hw_desc->hsize_stride =
+			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK,
+				   period_len) |
+			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_STRIDE_MASK,
+				   period_len);
+		hw_desc->control = XILINX_DPDMA_DESC_CONTROL_PREEMBLE |
+				   XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE |
+				   XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
+
+		list_add_tail(&sw_desc->node, &tx_desc->descriptors);
+
+		buf_addr += period_len;
+		last = sw_desc;
+	}
+
+	sw_desc = list_first_entry(&tx_desc->descriptors,
+				   struct xilinx_dpdma_sw_desc, node);
+	last->hw.next_desc = lower_32_bits(sw_desc->dma_addr);
+	if (chan->xdev->ext_addr)
+		last->hw.addr_ext |=
+			FIELD_PREP(XILINX_DPDMA_DESC_ADDR_EXT_NEXT_ADDR_MASK,
+				   upper_32_bits(sw_desc->dma_addr));
+
+	last->hw.control |= XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME;
+
+	return vchan_tx_prep(&chan->vchan, &tx_desc->vdesc, flags);
+
+error:
+	xilinx_dpdma_chan_free_tx_desc(&tx_desc->vdesc);
+
+	return NULL;
+}
+
 /**
  * xilinx_dpdma_chan_prep_interleaved_dma - Prepare an interleaved dma
  *					    descriptor
@@ -1189,6 +1267,23 @@ static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
 /* -----------------------------------------------------------------------------
  * DMA Engine Operations
  */
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
+			     size_t buf_len, size_t period_len,
+			     enum dma_transfer_direction direction,
+			     unsigned long flags)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+
+	if (direction != DMA_MEM_TO_DEV)
+		return NULL;
+
+	if (buf_len % period_len)
+		return NULL;
+
+	return xilinx_dpdma_chan_prep_cyclic(chan, buf_addr, buf_len,
+					     period_len, flags);
+}
 
 static struct dma_async_tx_descriptor *
 xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
@@ -1672,6 +1767,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
 	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, ddev->cap_mask);
 	dma_cap_set(DMA_REPEAT, ddev->cap_mask);
 	dma_cap_set(DMA_LOAD_EOT, ddev->cap_mask);
@@ -1679,6 +1775,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	ddev->device_alloc_chan_resources = xilinx_dpdma_alloc_chan_resources;
 	ddev->device_free_chan_resources = xilinx_dpdma_free_chan_resources;
+	ddev->device_prep_dma_cyclic = xilinx_dpdma_prep_dma_cyclic;
 	ddev->device_prep_interleaved_dma = xilinx_dpdma_prep_interleaved_dma;
 	/* TODO: Can we achieve better granularity ? */
 	ddev->device_tx_status = dma_cookie_status;
-- 
2.25.1


