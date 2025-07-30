Return-Path: <dmaengine+bounces-5908-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7BB15E2E
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B834C7A3BF2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CB27A46E;
	Wed, 30 Jul 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0sM8WI0F"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8665239E81;
	Wed, 30 Jul 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871417; cv=fail; b=WF/0aVq+hYwISoCy2TYiNWri7lLX7zZELy2ENUEKf2WPTV1GiGLWQcneTkhqdmYo+Rd3J3Xe4euZFXxK8fM2qguDBtaMzsTzrp053gyj3as1Z63nPTZgyvWxYx/HDsa8y3EAx8B25k/rxtZN/9sF5JWCH7PmYVAisCS6Yf9EsOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871417; c=relaxed/simple;
	bh=oR0DBEz9ATfyKW3c9xHBYU6DLF+Z2TmJCfUnn0zK4hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gi8naaoBjPJNLuMtQNJV63x6mqbkYVCQLN3xpoWagApfPPNrT5JuvxOkGZSayAZw3kDSI1p+jO1BqCeu//08aoxHP7TsCZ9DEomCa45QdMq5JmmaRghelVULNlCoqYDyuCAwxp88DSlY5nclIfmknuqUDkDuCDR44ITctNMYGTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0sM8WI0F; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meGqUdjJxuUBWzWTxMnhbnckOg5Lu2/YejOWGGz2mJvAD9700S1ew+nPhnTHlwZQS98UqjeyPFusEtxenMhJq610zLgGxcCnxzjuZc4Trx8kKaZb6hvfAbizXpDT6/ktEuF3H1l8wQ4ZZzSjGDG1F/j/W/rfcyyPWwrzgt4IxvronnbX8riXNAbfW+t6fz5CISyVavQ9CKMUZ/xV5Jtj5AqBQk+MOdj5kb0EtjtKesZIxuRF/IYjbT0wQybtiOtDHK1qBt/f0zrFBicfZwS1c+7vTuO37/8ISyi7iyfGMLqPbAo3SUJqYUSdMOXnKEkLJjq2F+z0XFpYgBjzzZ6vqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FiMtBeE7XQ2cWZ2CaPS+Ip8BDHFPPKgVM1s0BzdyXM=;
 b=PHr+fT9KcXRDpucivci8AUZuUzv9PkeqVYCXPx0+LKt9B1VhsOMK6iNtTdeNkdI5dAmDI2Lby6etGG+gPMBJDE+K/CZHXucmUkxCGeUMmajR3teBrFk2C/hPyIaGjEqiYXnCXt4RHgvvgvwAZuAggtNKr0Z1ciItTXiATL7sz3r0niqwZTIJ0uHvY7aUd/lCy83sML1I9t3I7Dy6lCtJhY3LZwooV2gXaVp576vkZGIcTpkUo/KZNCEC0CVkzFD/fEUEcTeovnkdccieIfY+53P+/L484YDEJWAw0ZVRFbi70/Y532ItmlEG1hoCo3WSr81a3K+9yMuo53IuEtTo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FiMtBeE7XQ2cWZ2CaPS+Ip8BDHFPPKgVM1s0BzdyXM=;
 b=0sM8WI0FFhi6xOn+70o/+Lo1bB+sbOENffYKCRG6bM+d3u9RIXas8669eVc+++At3iyeX2BD64a8/NMJIZRJuv6939dfOZ6HrU4Hy4RwQ3VKfdrzVSfFbYgbJWIxKDn/EHLfv6ZpjRtTrRSqIl91y7YA7/fubFMBZt0QKb9xYqg=
Received: from SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 10:30:09 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a3) by SA0PR11CA0168.outlook.office365.com
 (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 10:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 10:30:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 05:30:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 05:30:04 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 05:30:02 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] dmaengine: dw-edma: Set status for callback_result
Date: Wed, 30 Jul 2025 16:00:01 +0530
Message-ID: <20250730103001.1646225-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0ecca1-9fd4-49ed-24f0-08ddcf540eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzdoshpq/P+vkH0PZ4khCNWJuE4rPYieQaW0RiJLFFDoarzLLfnHM4pZHyS/?=
 =?us-ascii?Q?yFfFUsN1bOOzhf7XeRm5+nRW5W2iZ84xIKb0QN6t93c/5OLsa/pD9PObafkI?=
 =?us-ascii?Q?Hz3x1nw8TV/uWbgpnFpN/pxkTGkPYXnuYDfxJiNh66kkp9rP0ZULw95MFwX8?=
 =?us-ascii?Q?OSiPU1QSrJc75BNXALOkfVpBLhwuQbhi4gt0z8RisT1qSlkWAWCs3DPLx+PI?=
 =?us-ascii?Q?7vG6CKS6mRxdLt8EZ7hMriGSKo1ol8uUR4jQaHtgv3yJMZwS3uPcASHZIYxJ?=
 =?us-ascii?Q?lw1ndAJASRnbdaSZRyX29NU+c5t8JQ8sWIM+xGzgTmAkA585MfhdNNd1Ye6C?=
 =?us-ascii?Q?MqZ4ZdnxFRuiuZ15AOvshKXWRNdgPJA0MGnR6ok8nqwCTnu6QRyHei8sLJ8R?=
 =?us-ascii?Q?Rh0ua9eDHP4fs/u70e/KP21LprkELlU7FD7Tm2jgJFI6swi07FHtuxr/l3uw?=
 =?us-ascii?Q?tDeWLYm/bjWeZ7410dDcgB1WPeyACv+/f98Qgb6pEuD7PsxYfb/kDY0Ibx09?=
 =?us-ascii?Q?UqTjut7AjnqE2XM2vtmlV6djytsCL0V1Od5PcZZEuWOscEtKo+5SRsBFpPSm?=
 =?us-ascii?Q?iuSm10UAfm/DlUU95CYUkZYpoB3E3/XmxJTwL4FGhsKsZVGhb0J3dIoF9OtG?=
 =?us-ascii?Q?aGtjp3HWs9DyT82Mx47XHdG2DZjw1xQILTiX3vzjisO1wuexxLxrvBW//9Qj?=
 =?us-ascii?Q?AEAu8Qcbl89e9hJBzu0gFdIsqbRFyUbIWNbd7VtIarmJ+daNsChQdxQune8E?=
 =?us-ascii?Q?EhQUPMvHRhE2tuuma65ZpKhbsE2kyJ2+i57MZX/EKSoPiUBIgii77w1UAedN?=
 =?us-ascii?Q?jImDMFTIuwpL2T/YPpOBfjUFLMrxHDYliz51ue4uthrWatwy18lwKK7doiql?=
 =?us-ascii?Q?HJ5QPkOIQWKNXOMM0tNEzi8+c8Y7x+IwBhlYWV+SdcZ77n5uTXFekJv2NmyA?=
 =?us-ascii?Q?8nqSAx6/Z1K+M1O06t6J5rfiuNJrdJWTO7Rhp2YFVs99ZWG6wffwkJnxGBle?=
 =?us-ascii?Q?U/4/GcdGxqZAlNWwA1KD5O2Xw95B0g3n7OfebH4px4c7EhViFm/1GVqLwOtT?=
 =?us-ascii?Q?kK2bV9+QcW83e4zrHOvoiR/lQBk3lu4DvMQSTrO16+2iY/SIP1+1PwxAowkI?=
 =?us-ascii?Q?YymCSdCeNtA3un0Kn++tPePh0hJlKy4PSC7ZGRdBUJW2rtVj/ShVqjLG2Mzd?=
 =?us-ascii?Q?Kwz9OSs8mD8Y7kA78cWMTKxBbuiqc4L2hJjkMd5TaGChiQJaTTpklHTBZHDj?=
 =?us-ascii?Q?c6lgRBeNreS4E2BUNQReAJXpgzng9gCYNe6wMbAwvy5N7/5BSFCAGG6UA8kF?=
 =?us-ascii?Q?83+vaCRItqvgjdP1VUDbytP3NCnRGuXXthPW3NhWfmc7uIxhXyS+f62L8ft9?=
 =?us-ascii?Q?dy059LtM0GmBlnSpF293GsVPQO/O4CbfqMQBZ140glTFNxrKPmw+Nq9qyPWE?=
 =?us-ascii?Q?PUsoCUnQBcn/c7qERwY6zwjkO1PM34VeVkFcVs05Dt6cpKvz2aXP0oEbDTy4?=
 =?us-ascii?Q?tpk3df61sL53Sr3Gzgf8xkICBfzHrnyvxv7v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 10:30:08.6371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ecca1-9fd4-49ed-24f0-08ddcf540eaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

DMA Engine has support for the callback_result which provides
the status of the request and the residue. This helps in
determining the correct status of the request and in
efficient resource management of the request.
The 'callback_result' method is preferred over the deprecated
'callback' method.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2b88cc99e5d..0db618806c1c 100644
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
+							    DMA_TRANS_NOERROR);
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


