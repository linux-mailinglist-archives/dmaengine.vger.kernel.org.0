Return-Path: <dmaengine+bounces-5892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD139B157A6
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 04:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86404E805E
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 02:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885981B0413;
	Wed, 30 Jul 2025 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="W29cjr/k"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324F2260C
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844196; cv=fail; b=Ze4Dwzf/WvA3GByNhq3/LpVLhx3WumpY9I5uNFerCU02BDsqUsqrGaZX2CijJAsQ5lG/mxq6jJN7DqGyyov+fV/tIpWgtL45LTEVGh0wicweNmPRrkUEsEXjLubuDiuu+VsyfQEKaD3HzDHhwO3TfP7F9++loysJ2Zf1Gk0IQYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844196; c=relaxed/simple;
	bh=rb8cCBdRhToAxa9hZ3BAQxJoyZrY2kMAficYuWltHbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daBFYPZ4bOYHbiuk1TVFVot8EvaIITz9hRRVhZRzYMNIJHW2XJR3CofNnxNIrtZH27tJoNq+9oRCQy4EAnjqC0nAbOwitfRE7HS5ICcIk8QUymMlfbYt+pfVsr6J+GhtmM1yUcTi+VuTeTJE/88VcNivCJjUtxaHZp0Ft9H0EE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=W29cjr/k; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8TRYWJWpPhoaXcEEWvZofOG6t6whToRlRFi+9PsJq8NdvG9nLQ4hDIhzeq+4mOgHavdb/r9PdhTh+V4zN75tsYhXw9HJgTEaGRTed22QEg/G7fG4SfsRbqnpm2zCmXQZWyjDZAofwel2AJqX5z/NLs7PRqkV7GYIxkyXv+ffViuC1WbSZ9jLpDL2I2OQsErdzAJYDr6qNcHiD3y5yH//Ijs0Vcg09Q8AQlNmLxVjEbmBR+ShM7YvO/y53ZR7UJxx8qmPjJaScCGu2FcQlSnBgHL9gBEQwwrIKrLlHlkKfubrG8ijY4VwLpHRRDff80y/4cVOpfnuE68xCF76w1kwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBTChWYGeDy86wsfaMz42BsBp9ORYcO+JIJew8ZVoh8=;
 b=w85nca6fUu36HTqHr/GYmbeuFZt4LZ4Pnk7eqIhcJn3ZHgKZbjoqyRDjx1HVjJhd2EGFyfquyoCf2tBYY9VIEklNVI9vYbu15Imt6mLUE1TtZR6y4wx5NWfd5atN+8v3QIqgeSinc0B+T29isFpUdzNTtP+J4kmGZAaGNyDj+mdC3f/Mx75CR84TzR4gpU5IZueaaV5pJInAVxY7LVG+dDlxRKPdvy/cV937a+YMhUXIN2wIGhHmUNfeywY+WXCZLq82WHzX5577KV94j6tmCKhQfhUAsJvtey5nJ3cwjMVyzyEQDXu34kZEV5Wl5QnBAbLSMA0dF/KD8o6avgI+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBTChWYGeDy86wsfaMz42BsBp9ORYcO+JIJew8ZVoh8=;
 b=W29cjr/kI+Bnqa+QDRZYTv93SlmYxs8joCSmHHlIOgZhS1IKYwCA0Ha/aRszpWEPpWhPLoffDsmXIUwcOTwllPs1Q8bbKq51WXIl/EAd61B+/rDb1GCSPI9xrSvnbLRNx5juGgAYW/5MeW3VtaU+cJmXwsW3k3Qc8yoVa8s7HLehmiVJ7UvMvhAOvVqZLi/FD/y348rOaZyXd5BNDE44PvL3LGDHVXEVtmuluOKsJFMRjgLwfe5b+7k4ihjoXDbbHhvv/WyVSokhhQKt8D9VfaHwZjFmVg0rHvrcgz+QQNRmkrCv5ZUnYbg3v6CB6G71eZQyqY4sQ+NARfwnWMbtMg==
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by MN0PR19MB6408.namprd19.prod.outlook.com (2603:10b6:208:3d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 02:56:29 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::19) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Wed,
 30 Jul 2025 02:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 02:56:28 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 29 Jul 2025
 19:56:26 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC: <jchng@maxlinear.com>, <sureshnagaraj@maxlinear.com>, Zhu Yixin
	<yzhu@maxlinear.com>
Subject: [PATCH 5/5] dmaengine: lgm_dma: Added HDMA RX interrupt handle functions.
Date: Wed, 30 Jul 2025 10:45:47 +0800
Message-ID: <20250730024547.3160871-5-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250730024547.3160871-1-yzhu@maxlinear.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MN0PR19MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d395bd7-92a6-4d85-bd87-08ddcf14ae3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLk0WWfgbyzuz1ptQBG5pm/pB8RXU220K6A1swqqtXUkahFDW/hGVCO9FMyy?=
 =?us-ascii?Q?DBkEh/u2H8MH8A+46EczWB5pYFDKuf7HELvSost6b+JY1yGSpB9KNmCFvjL6?=
 =?us-ascii?Q?9tbNXmbHOFlaBsHvc1POmE1qlscCtQovYQd4DUME4TDK35bB+qVxkNzq4f4J?=
 =?us-ascii?Q?ecAAsRSX5N3WcU8dZVFm+j+4j6tqizPqY03/kuvhYIPkmdJl7O2MvBljYcAy?=
 =?us-ascii?Q?h8uFZR4Nwy0ZMPTHu5IKGc9k8ypXXAwSLfuCTmq1VYXH6x/ubLTAiRjkm3Qu?=
 =?us-ascii?Q?1RepAczRukb+cOA08YPvXQO/CMU95llR0yz8wg+4HKXI9KXAU4qLR8JW+wQb?=
 =?us-ascii?Q?baHB7Xshm2VRpQ1R5x5ubQLRBhytvO8QDswR7lfh04IUZgJNuLEm2z31PoiZ?=
 =?us-ascii?Q?GK+U1wVG2h3WIGUC0+GQQ2ZDp6KQrHqvKBZm2wplS15dRzuoATWo/ln7qlez?=
 =?us-ascii?Q?DojmhvQKUQ/Gn9xhT8MHbcR4gWdzVm9BZdBIZarCOul2mniK3SiO+/5wvEc2?=
 =?us-ascii?Q?VyN+7RoF7RGBrg1ggzDGtKOWaHPb41nApqq0oEQNhp1GEqvhMNSyg90oQKON?=
 =?us-ascii?Q?/+kj8sWEKdf3kjyyQ6k0h/oVBReGwp/eBpe8YTZkpt5x/T38vDcLpLAgmj7+?=
 =?us-ascii?Q?JNZUfv43W3kUjkidpdOM7CCRJFClp/kmk1wK8W5PLbQuLzkRfgvItoxsc0UQ?=
 =?us-ascii?Q?fG7QZRvxc/7xrER7mPc4h47VMFP+QRqdbeL6QDDpzQvpEO9fgFSqYBLOmejD?=
 =?us-ascii?Q?+gBVRiT4ok9v8jSEbVviz/6CIs50Ogm/0R+L2Qz2rWFbG6QPMTld0Yi+thUM?=
 =?us-ascii?Q?A4mYGT7galLtHTzVq1AEub1anSt4R0vtQQmRGUqqk7dfTbE+srTeDw+i3F3i?=
 =?us-ascii?Q?ZQGJKp9i8tsFMFQUWZYz2LiudO047MKrHEkYKNKy8Jk6g8RyLxeL/ggs5pIZ?=
 =?us-ascii?Q?Mf+6Gk70whexE0ZmsVNbGM1tDSEVbifHelzoe0WnI7SwJNHPU7FlGjw8mVaq?=
 =?us-ascii?Q?CKZxGg+YR/vIwBK0pFpZGjASBdmiKVa12NX4XlZDFsmkgQIHXWztNeo39g8R?=
 =?us-ascii?Q?ras8XDkv5rzqeJ81sOXte6VPjG/1ubtsAw5JsHDRKwObLz4yWMCsMcEZnGyw?=
 =?us-ascii?Q?UGcSwX7dFfAlHYxUFT2r7HvjP7ORyTYkt84tiDl9OrGLNOzL2YdYpvdBn3T8?=
 =?us-ascii?Q?6ED8DW0nqoX/5lLf73pax0SJNWG4kj39bHZ14U/NTKlERrz+tHy8FZ5MTm00?=
 =?us-ascii?Q?633wfHGTTftimXD7cdsdp8PeJ6W7kiA0vDfITKSD5aQa8IsuxZMHa9x+iJmf?=
 =?us-ascii?Q?JF9QjHhJ6VQTM64FgYTq0xIxr9XACvLps8kkyiQ9Gy4kAkdadrgWRG5pYMQt?=
 =?us-ascii?Q?qtjDLuCajMgpJtUo5etvAUYhDBMRuJvuwQOGugK62a3TVMhwjxF/fzP8s6px?=
 =?us-ascii?Q?wI+XqQAUgqQS6EovPAO3iIyZAz1swX1FZeatCMpLfS0/h6Xx37HH8/6+QNS1?=
 =?us-ascii?Q?68Vg5OwzVO3/0fyDff/uY0A1LfrQi4xZaL+Z?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:56:28.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d395bd7-92a6-4d85-bd87-08ddcf14ae3c
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6408

Enhanced tasklet function to handle HDMA RX interrupt.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 drivers/dma/lgm/lgm-hdma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/lgm/lgm-hdma.c b/drivers/dma/lgm/lgm-hdma.c
index 198005b48d59..531d2b2f51b7 100644
--- a/drivers/dma/lgm/lgm-hdma.c
+++ b/drivers/dma/lgm/lgm-hdma.c
@@ -31,6 +31,12 @@
 #define DESC_C			BIT(30)
 #define DESC_OWN		BIT(31)
 
+/* RX sideband information from DMA */
+struct dma_rx_data {
+	unsigned int	data_len;
+	unsigned int	chno;
+};
+
 struct dw4_desc_hw {
 	u32 dw0;
 	u32 dw1;
@@ -68,7 +74,7 @@ static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
 static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
 static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
 static void hdma_free_chan_resources(struct dma_chan *dma_chan);
-static void dma_tx_chan_complete(struct tasklet_struct *t);
+static void dma_chan_complete(struct tasklet_struct *t);
 
 static inline
 struct dw4_desc_sw *to_lgm_dma_dw4_desc(struct virt_dma_desc *vd)
@@ -140,8 +146,7 @@ static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
 
 	c->priv = chan;
 	chan->c = c;
-	if (is_dma_chan_tx(d))
-		tasklet_setup(&chan->task, dma_tx_chan_complete);
+	tasklet_setup(&chan->task, dma_chan_complete);
 
 	return 0;
 }
@@ -177,7 +182,7 @@ void hdma_chan_int_enable(struct ldma_dev *d, struct ldma_chan *c)
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 }
 
-static void dma_tx_chan_complete(struct tasklet_struct *t)
+static void dma_chan_complete(struct tasklet_struct *t)
 {
 	struct hdma_chan *chan = from_tasklet(chan, t, task);
 	struct ldma_chan *c = chan->c;
@@ -185,6 +190,7 @@ static void dma_tx_chan_complete(struct tasklet_struct *t)
 
 	/* check how many valid descriptor from DMA */
 	while (chan->prep_desc_cnt > 0) {
+		struct dma_rx_data *data;
 		struct dmaengine_desc_callback cb;
 		struct dma_async_tx_descriptor *tx;
 		struct dw4_desc_sw *desc_sw;
@@ -202,6 +208,12 @@ static void dma_tx_chan_complete(struct tasklet_struct *t)
 		tx = &desc_sw->vd.tx;
 		dmaengine_desc_get_callback(tx, &cb);
 
+		if (is_dma_chan_rx(d)) {
+			data = (struct dma_rx_data *)cb.callback_param;
+			data->data_len = FIELD_GET(DESC_DATA_LEN, desc_hw->dw3);
+			data->chno = c->nr;
+		}
+
 		dma_cookie_complete(tx);
 		chan->comp_idx = (chan->comp_idx + 1) % c->desc_cnt;
 		chan->prep_desc_cnt -= 1;
-- 
2.43.5


