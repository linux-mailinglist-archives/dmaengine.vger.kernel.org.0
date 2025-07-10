Return-Path: <dmaengine+bounces-5758-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8AB0007B
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 13:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24041C8599D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA72D0C93;
	Thu, 10 Jul 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0TorY2YG"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AC29ACEE;
	Thu, 10 Jul 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146623; cv=fail; b=S393XgdfrXFXEojzfyjqj3KJ6dG39tpn/k+2I9AeOXs0rIvKe51mLszH1ksE72hILMR5pLAK6590dtD5wrygIz+Mab6qv5Ooca+8j742XRLp83Y2QiudmN3/O7DV3nnnDZSxre599Gx3LgixD3YZVYJEaGII7L0uS66nL4WeEaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146623; c=relaxed/simple;
	bh=dgs+NWc1O/ikvHenen3TTpNTiZxs7BCORdlHcRhdXsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXHO11mi+oB59HZ4tRS7vRtDri7Vn+ytFiEpZo/lV6ITYmTUUQSHTN+yai/OGQE2zP3bmn+HfjTP9QKww8atk+NxqtyelomAugaMxycCSQXfe6eODRRgHMkhYgMEZn/69t253bIP7zslsZ0FBYHfNTVqM2V855qz7qxCn49vMEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0TorY2YG; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd79Rj+wo47I/dbHXQnsenAm1OJHtbOH7vAyehp7iQW82lVg1LAThprknJjDV3pBUpAWUEaOmEjpLSwD+XhTv2achd2544KK2QGZyb9/4O5hqvT5lCKtMa7LbDZS+gEv7NWGlUhjAp2PWStSsirYLZo7j4DSP0RfNlXnDXsO34ghTqt/6bmEECD8AkUKeB5hbkv4PzqWsnPOOKVbqL7Zh2hieOzB9PSAuTXidC6IJY+vDFB45Bp8EGqJLQwZQReYDTXvow3ZDC1RxdfSqrG8Q9nF8kOXhgSasxFEbgVRjqAxN0DlXJIgfx12PfYkj/2qDQWJJhsNNHCOc3Co/zktyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GofPfNT1BvqHRzfiu59YiXnjVlDfX8pcKJGdKxX2Cg=;
 b=ZOa/r7CFY0T8whuHAGZ+6+HC1BjQp81Ar5EmQJoU2y4vxvmzVHZFl8K7u/vRrzfZ69rOR9n2XZ5STcU99V2kydWM/Z9IjQnhkkIXr3Oto6jwso2Y2pqvH3IIC3QuRoCBmSPSHNJKpNAqTDqqhAQ9ZEK20jNL9t7Ak+R07JcjxwvDbG4aL9Eyfa3kRtZZwCbMl3ZHgB/0YwJ3P0MlPJbdOOCE4UrqgRS36Ex1sQXQOz2qVi/5M4zM945YB5cLADYNOhApILxUE6ZBoU2X67lLVx0E1PsCnKGURbpWxx2S/SXNg8ZIeUh7NX+GYOb3ad/HEyzR4KTqU/pHHfMljxmWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GofPfNT1BvqHRzfiu59YiXnjVlDfX8pcKJGdKxX2Cg=;
 b=0TorY2YGkWqq5SM4IMcpoQIO+vnNlVwu2Svx1+xWvUC8GkuEi0gKu1jvAgoyGjMZNq+1U71jxmBDIeVkSc1BkrGGwFjkoOnv2a/kz3zZbNH91T3PYrHvUglum/ff15Vj3MeaxO4xgJnf/g+0+ad9a1n8eRt4w/bHkjdtxl/e0cw=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 11:23:38 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::72) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 11:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 11:23:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 06:23:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 06:23:36 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 06:23:35 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mani@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH] dmaengine: dw-edma: Set status for callback_result
Date: Thu, 10 Jul 2025 16:53:00 +0530
Message-ID: <20250710112300.439575-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: devverma@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e45ba6-af93-460a-cd50-08ddbfa43746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhPxZjYbcxFdXjKesZl5/kXwnCD0i5J37cKUVsxypygyITOtK6LHBYXsBZKV?=
 =?us-ascii?Q?Ec8sxfu1ojGSl1i67Dx4WHIPSHMvKNSmO4fqdzQFijUGi+482MDOYgtyXkvx?=
 =?us-ascii?Q?I25YDqQ4qblRYVknf8Z8Op/R5k973XP09iJtPnIyPMmiV49dwzetdOKO7kH2?=
 =?us-ascii?Q?riK0qiGdeC8wMcmiv41Hv4TaOOQC/CFFt5RQG60IybbqQN0jwNHHET8iBYHY?=
 =?us-ascii?Q?QmQSQF3ra+mkzkQaM9T8ilFujP2c09eztZDFV12p7V2Qz0SKEopILUqzERd2?=
 =?us-ascii?Q?110JxZx0QMmXiV5jbQzcU/ArKJZ3pxqvdGthj6K988NFTNts9wWV3JwGwVSb?=
 =?us-ascii?Q?snn1OfoOMYGORFQ3sdGcL1/Om+E5yqtbJUGTvSrD+ycdauTYyx6G2U3xvKuv?=
 =?us-ascii?Q?87VN41QqlsPocU8+NJXnOCRxuQmFUoMn+VVBGentqVAhYpHehmWpiQ7Q9hQU?=
 =?us-ascii?Q?OCoDkUOcPt7rSVDmH5tGXpNIUopP/jieyPeHLjEaRVrK6WS1wvmuvW5PxlAx?=
 =?us-ascii?Q?hWL75/+FMYTY5peybnMKARIhevExL3/NyrJNNeqvu/ngXZg9cWep7bMsksUV?=
 =?us-ascii?Q?FBpCfGynG8xHPzoq3a/ItiBje3LOL1+lTX/0Z23GXgVslHm/N1T5VthXNszu?=
 =?us-ascii?Q?lK8sMuUqA99VCa8b0r+QKzFipj+cmc+AeNoM+N+MBpHy1oyt3m1YlcRl010t?=
 =?us-ascii?Q?HCSRaKXMztvLlmj6VughRuUIuDTrV5A46i/InABg+Pa9bwawBWsCEcTQK/It?=
 =?us-ascii?Q?s/xNtxtgHDnZW7vqHyp+7hM3pvSY1Za/v6n07ufFL0XiTqjCvDSjSomj6l46?=
 =?us-ascii?Q?0luad1BjMdTlea/MJtF2fO4b0AN8WlfuKr7LTF1fYUWEQR8/X52G9NstQdqw?=
 =?us-ascii?Q?ji88ZFU4L1He1ASuag4vwSbQIK3F04zvdV+Dtqy5/B4XY502hqn4vG0+3Sb4?=
 =?us-ascii?Q?KK3XzcFCwDQnaz348wgjPIRkMualkS8LoC1Ts2W9gdD4C71L1vHcRAEPLgbK?=
 =?us-ascii?Q?QhXGWPJDgtqllQDuhuV+6DSumJagPl77gpS1bJiWP44T46ZHzasPXywx/t/4?=
 =?us-ascii?Q?6bi8vCM5xvPCL0+cbbHC6SX8v2zGUKKxvOdNU4ZPdzL1ty8b7cjYSPvrpFkf?=
 =?us-ascii?Q?aoCzczJearaIeiJhOKoTPun0/Z9XOGdWvUD2Y7eJTYAGc2nUrMUkJ+u639XE?=
 =?us-ascii?Q?xEuKD5yI0QTf42y+MQFwfiLFtkEVLwgHnV16rn7Xn6I38AQGZhTmGRNeMFAQ?=
 =?us-ascii?Q?uBwQuaV0A2HfYHBpnuvxjkQqBYavus9ZNGw08BTd1CDwm4J0WsSi4FFGSM3w?=
 =?us-ascii?Q?Zv8jm5aO32fNV3VUrJ2jqusP5rRe73DmrGNrrqjPKXx1fd6H9QZiQvs14y2x?=
 =?us-ascii?Q?FEiocVc3wK0MXDoiB+nJLAatQknmxp1iReFEXTtZ34pDi28gctkyd3+55Fyw?=
 =?us-ascii?Q?jMiGAEXknojQRInBmho1IvG8adZVSlUmhjOjf44YYiTE9z7iNzl0ahG00sVQ?=
 =?us-ascii?Q?xrHlHIsne1Y0OiaFdSCDW2BNYGNU8O7vPpQ/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:23:37.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e45ba6-af93-460a-cd50-08ddbfa43746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

DMA Engine has support for the callback_result which provides
the status of the request and the residue. This helps in
determining the correct status of the request and in
efficient resource management of the request.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2b88cc99e5d..9f37dc6c92c6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -596,6 +596,25 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
+static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
+					enum dmaengine_tx_result result)
+{
+	u32 residue = 0;
+	struct dw_edma_desc *desc;
+	struct dmaengine_result *res;
+
+	if (!vd->tx.callback_result)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc)
+		residue = desc->alloc_sz - desc->xfer_sz;
+
+	res = &vd->tx_result;
+	res->result = result;
+	res->residue = residue;
+}
+
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -609,6 +628,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
 			if (!desc->chunks_alloc) {
+				dw_hdma_set_callback_result(vd,
+							DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
 			}
@@ -645,6 +666,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
+		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
 	}
-- 
2.43.0


