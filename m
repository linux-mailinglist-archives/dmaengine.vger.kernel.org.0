Return-Path: <dmaengine+bounces-1145-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF486A78D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 05:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F681C236D2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15D20DCC;
	Wed, 28 Feb 2024 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YEC7gbHq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EA208D7;
	Wed, 28 Feb 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094120; cv=fail; b=XCYcLp93MGYwd2/AdZ+ZTxjmNcQlaZ2R1AhF21lgHQCGeeGtu2vxzqsUqMjDvZD3JUcIHjejyADX7jWgSNttLp0/OSuZwpEjzq7PQiV4be+yknZXNY7iAFe8iCuPn4Wt3iHEVc7+EYip5pyk9bM72ffhSavUaRUfMLD9E6EvVJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094120; c=relaxed/simple;
	bh=/GSVGrIDKEWes1yX7MpAJKA6qyubeHLvnNVrLHGkSQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2gtIszuq+ApsjBBbzBmPGdPUIMK4O/Fu1UtI8Zh2J38GJ6mMKE7PItm9jzr/2qe4OSEQ+jUnPbhN37JFvo4V+kGdF2EaxPiBykLDCR4sXFbj2Nw/gR/bvtwZcFjJb7JF7ztvAh2kIF1YLbGux6J0JjEFECa5T3/2qcIlAjKn8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YEC7gbHq; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8brVTMDOdPuMw4CLM8AvMiJl08K/GPwTZytlvPVsXTx5mc16EkXGKsBW8GyMsTxUtCspsQ+uCDQt1bc9jbk6/xZ0U2as60rTJitFzPSee0DMqbYkMOEkrW8rStHpFfRlpMRUHp3hWgCsmemp4UWqjdKd43yXa066UzUcKoSLReRFeBugc4jxkQlFdMJGtK1i1EzbSqePoBYCekkFElUb1wI7gd9v4zAdlzGbX4g8BsHAtgsXMjWwjXoxoTK3K7olV8ieQseyML+7DucMtEUPVd9Wp29e7E8zpe0RttfJTu5V51x+TbEKl1tZGQ0I999PGxJdP1crWzfW6dQ/iWpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryCmsoarc/HZTT/sh8IaJM0ufnDWQrPGVAniZL5jjMY=;
 b=GVo+57H5PI4i8SIGcvwuI1Z3DhFXLNnJ4vK1+mIfG1QH5L+6Frw5iSBYe9WsErzny9XT4gjhhc9rt+bBbuZfpnv7Rjcacj5KmMvn4kLmzGGz6cr6y7h/wnrrk2MDaXn7fWHJ+etwxbDO3tY9AIzuTZwIZDLi4lvsWR0t2X7iCCJHsw2x/VDew3BsrxmHRFYlBjFHJgpd9iQpRohVY2p8jt+qpNmTxqRd44lmrmMwJVxWPF5SAYz2l7zVhDGIhx3R1SCcoPD9wOfWlGOKPTxpuKpwLncCDSOG2VQ5ewnS6urcfExVtnds7lEjlJebitNL9OaE9+uSrkoNbMiJUs+b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryCmsoarc/HZTT/sh8IaJM0ufnDWQrPGVAniZL5jjMY=;
 b=YEC7gbHqk8T5DDC3e0p6gvVP0bCVOSwGp3ETPJV0iC4LbW8QvUD++O6Nh6cl5ERqrGuskab2q1KKm0OTGjN/LqZ9S8KS2ijU+y9ZeJwFxfFG+NdgR2/Ys7EdkZShSldcqUZR6T/EW1im+gL4sBjftxYbdURxP1qzVDqsxhrfa14=
Received: from BL1PR13CA0337.namprd13.prod.outlook.com (2603:10b6:208:2c6::12)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 04:21:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::28) by BL1PR13CA0337.outlook.office365.com
 (2603:10b6:208:2c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26 via Frontend
 Transport; Wed, 28 Feb 2024 04:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 04:21:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 22:21:51 -0600
Received: from xsjssw-mmedia3.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 27 Feb 2024 22:21:51 -0600
From: Vishal Sagar <vishal.sagar@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<varunkumar.allagadapa@amd.com>
Subject: [PATCH v2 2/2] dmaengine: xilinx: dpdma: Add support for cyclic dma mode
Date: Tue, 27 Feb 2024 20:21:24 -0800
Message-ID: <20240228042124.3074044-3-vishal.sagar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228042124.3074044-1-vishal.sagar@amd.com>
References: <20240228042124.3074044-1-vishal.sagar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vishal.sagar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd54d75-d375-408e-dc05-08dc3814caf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3bfLdO9y5fh05il883dEhA4dKLPM+5yVvlDA3Kt1zc2JvcXb6Yb/T5ojrbsUpFhn/dz1iJYJZ1OOJV064Gn0KcMWPWApPppE49y8TrDO7QUyoDYygcGdDMUsGT+qtszpAGua5UenwtrxTJVSo7HAOHpqivxwAy5oKWohUR2boxiKNmLDx5Wj1r3zVCnc05PjhL+lif7RShRjMxul2C5AJGT+NauETylwY2TxgTEcZlVwGwQeB4usdH405IpAn/JLE+HhrhsEdCJWEdAYqmPyqCzyh3OGVo9cwglXbWgoO/dfZQUzppB+J7teVLI9Zy51b4p8yRFZ8npDvi8WeShId7UwDedLOuUpphbFyG0dy0dzLZtyPGYBRx91DCTstwn1HrGKB3x7kiMtJoAqF5NDhDONQOFOACPTT0J+Mvmrtn8YvD7WmxU4Fxy0/RNW+jO/Zjv4m7TSVegNXbqkCv4pXbme1u/jf9N0H+NT6Yu+8qqkbZAmpdn+RvqcpiEcRf1eEvMYB1c1ShvTOG6ht8Kyl6fuPFL/KzS5K1tFm9o6Y0bBI605zZzfi9hYZCOu4npHQ65chIXZy9j//5B83adICGN40R8LbJR3qMupPk4rGpc2/BpqMf55qekeI/k/Om4rkWRW9vnlVHSrhvS+qSz7TOxaITIdXr/57uO3oXUZ682eZAOV5KnjV6k1A2PPQ1FkrE4V+Of2gBVcdcqM+fwtVZd3/e6Smtr164QSkQj1HoKVRpHUskOji8/9BpNjwh1y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:21:53.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd54d75-d375-408e-dc05-08dc3814caf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

From: Rohit Visavalia <rohit.visavalia@xilinx.com>

This patch adds support for DPDMA cyclic dma mode,
DMA cyclic transfers are required by audio streaming.

Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>

---
 drivers/dma/xilinx/xilinx_dpdma.c | 97 +++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 28d9af8f00f0..88ad2f35538a 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -669,6 +669,84 @@ static void xilinx_dpdma_chan_free_tx_desc(struct virt_dma_desc *vdesc)
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
+		return (void *)tx_desc;
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
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_PREEMBLE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
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
@@ -1190,6 +1268,23 @@ static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
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
+						 period_len, flags);
+}
 
 static struct dma_async_tx_descriptor *
 xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
@@ -1673,6 +1768,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
 	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, ddev->cap_mask);
 	dma_cap_set(DMA_REPEAT, ddev->cap_mask);
 	dma_cap_set(DMA_LOAD_EOT, ddev->cap_mask);
@@ -1680,6 +1776,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	ddev->device_alloc_chan_resources = xilinx_dpdma_alloc_chan_resources;
 	ddev->device_free_chan_resources = xilinx_dpdma_free_chan_resources;
+	ddev->device_prep_dma_cyclic = xilinx_dpdma_prep_dma_cyclic;
 	ddev->device_prep_interleaved_dma = xilinx_dpdma_prep_interleaved_dma;
 	/* TODO: Can we achieve better granularity ? */
 	ddev->device_tx_status = dma_cookie_status;
-- 
2.25.1


