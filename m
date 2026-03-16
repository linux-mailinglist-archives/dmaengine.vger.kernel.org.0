Return-Path: <dmaengine+bounces-9449-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFopCeE8uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9449-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:24:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D308929E1C5
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6D59305732F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63353D5228;
	Mon, 16 Mar 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EM+T5KV7"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5E3CF68A;
	Mon, 16 Mar 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681652; cv=fail; b=gU1gW2ZYJabRLU065FDX+0M8OEJDG8IM9yAdEo37Bpnyg04zBWCAUq2u6edLQvUJBzUFVI0pdYF3s9rry2y4soCDRHgrvJAnUQJmIsfQXyysyBX7JSODxaRf6cT8MYIkEYWdm3dX0SNzaOfsp4m5sao6UcZSX1QU0ZJNnPy7iF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681652; c=relaxed/simple;
	bh=JYTlyNhUv4vTBGck67zbdcRECNh1OxgvWj9elxg2QHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBIueon652rD+u6Iy3JFxBwBFgIf3TUsVuPvzx5b+l0Wm3g6CruYw9UO17J1EWUJBgEAN1mLBf0dP9Crni6+P1OCgt9w3A8j3bI0dUEdDONZrWkcRwBRbsjqJ33DfqSeuMy46eF+3Nn0fVtDc+XK39ml0FBYzjtOKM9tLTxjiQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EM+T5KV7; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2Ds10GVd8ZPjAxwFNvsj1UPk2tRN//n9K8cdyU8e+bc92FdVgEnPtJNfYwC2ssk5d/uaMNZ7x5lW4Jkc4yJh9bJjfselxyD4ztnp4qrrkBP7SMNk6Y8EbOw8KxbA7eUGPKCmf3s5Q/Ygb+ZR8gtEbDaPwuygCvlR4hdHD8UCy8fCV8XefrHPtDwgaUZeYku3IZMT4J4Y6jPD136r1a5bSzzYSSZa4Q3tq8qgTVrFkZz2d9KViKl7FKP//GObQ0Q7Z6GGHPuUKqy0atJlrf5iGuE8sQnfKN8Yo5F+86yS0PydGGvPNSbpXZQheVRu/TxCGyUcxXIJDLU6jrlKfsktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSfzwSDdJu+HGJQknoI/vRE0SzfoPnO8Gbka8zaRvEk=;
 b=Yr6mlUYSx3puYIMiW193TYzEUR8aB6JlxDaeFeUX4honYjacHwkJvgbvwskaU9Yq956ZEJ4LKBs1SFinJkpXtqn808k1IctyfxCa/N9B1ukqdvIAoGS2EM12xqebY8Z9JU9IgJmrVM1G5I8Ut/aWWW5bIl7h29kdY7UB9iR1MtchnUaeSLds25PEYNwvG18FpRzxoObR9ltot+EWvYIjnN/+EOFe0AjPzNJe810YWqEY+ZZwM1Abz7cLq9nxQ/LYIQdWr2seWYSOaW4qmQD/nXNnhshuR5ZQ9VoXbEMRNhk/2uw8bWY3NLS/USPpGkJp50GAMWsZq1gXoMqF8okbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSfzwSDdJu+HGJQknoI/vRE0SzfoPnO8Gbka8zaRvEk=;
 b=EM+T5KV759BvIoarwFKExYaIu9tI0bM0IecuY0GllZ7rTEAK0zI3GvlIpTHZwUQZ50opOOyDdayruAM4gbP0mnyuha+Gg9qFr9bkvk9q/FYobO8CWDBA6Zoe0HdDCQUiXf+Ka6zTIY4GepmPeHMPzoJe4TCPlaOETLRyOo6P/WHq3eBwlWWOVdX1Si3PeCIew4M9QZoHM5W/wSWuRtpejUbQ1XNQn5v8vb2UjgjR9If/p96DJjQBEr96kxBMIc50eUL9Hbt+6sXzkwc0WDejVTfBKDhBoZW2fzpwoU9ghQhk1de7nLVOudSQ9SEILIah9DwqZ4DqKHo4gLmaOLBs5g==
Received: from SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::9)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 17:20:45 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::fe) by SA1P222CA0058.outlook.office365.com
 (2603:10b6:806:2c1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:20:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:20:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:20:24 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:20:20 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 8/9] dmaengine: tegra: Add Tegra264 support
Date: Mon, 16 Mar 2026 22:48:22 +0530
Message-ID: <20260316171823.61800-9-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316171823.61800-1-akhilrajeev@nvidia.com>
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 220cf287-5747-4588-0ed9-08de83805b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DIutqVebr1vIjDsh8lFpEDHABhAa9OBcCi3mKWjkMFANmipUurjy5MV88RrpBwwVDjj8FfFnKmopW9UevmYANChWCaxPLwYFbbt2fIzrB91GnUTe6drbWSBOEh5Z9QKhEElckheRLdfKO33uQKU78ozyQd/iwqnzT4JmAAMm1EwoQhiJyA0p2oTUbvQzVfGUOe+cDIDb6Dug7kYL7bLRDX8sfXuyb/kqwR78rrMy3GYkhWIMP8w4Q8FLXsae0G5P81dkSMnomN75RnlvG3TQuR5KADIWoxjd5wOuWrj9hDEMwUTNzHDdnzar7RFBn7JxZYAgrr9RxirjqEJ1PsIqgO0ypNz4Xy4Z/5ml/RT4zZISJk1aWh61Wt0l5QvWq81O/gKnr4O4IRe7oiMkWlbf15ZU5wGyeOL55aUVsv61pN3k7mr9A1kRmodlwTtVADZeJu9ddfTbZCjBuSDML+V4z1HTHxwHVLr4xotnE2KrvTr7aOOwx+PVuohDz7HJtp7H6tWor/9zvyrM8gD0Z00ZMmG4SUCPBWF7W7TTGiIVZ2TZoyB2eGfTrA/e4+j6HQlzt837w/r889K5u7gZ5gt6jTlNkO2AwH6bdaWJ4SbXk56ONojxh3qLARcveelA9ZOeOfUF20URu/DG2OSF+0Ckot9vOP+fPRsobu6Z+Tir1f9Bc4rJ7kPyMaz3/YOUgwQef0wd5aZeuPKzik0YaNc+tEtlZ6EldsUCzSF69npESgmmanDXN9nU7MuPsyi/tLQ2xNx9KE3WiLfyQW0bfJ8GyIxKUnVeNALggp6Ccimje6nByxmyOvPSBpTptZnhJ6Yv
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	biCYnfkqJyHrOWcpuJSHFjId8A1b/8QLWirqnadZ0u8LR2rMNm/9HJbS1CYGfn+2ZPea1jQd+y8HRtIRkJafdWHietvoYY46nYS2NDDPjWRm7WPmUool0iyIs926nEEgn56Vr8Y5JQnVUqGJTFWWuVXg1gC+b7X0cqF94RL9Asa+thsD6yOsQE+13ygsTq7tm5Fn2xHD8EMUndjX8yCNNoG6g/7/QJHT2hfCsxy0/jQNznKRvjGVRJk6TDKcllWkD7R7+MmmdIBofnvTJGUPLbrvK7IlQIusdd87/hC2zXyhD9qF1TE9v/BY+0M/icWMJ/LWezkaUcvSB/k8nhCFfm5PufhExvvIXszgn1ldJOs9OM5sPmWP5lnuzg2mbxsOjAog+AkRF4DfUFJ0AwAx6OPHvIp1L/XnqFk7zNtvlVt059tb0rHOFrkvMDN25Pbz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:20:44.5109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220cf287-5747-4588-0ed9-08de83805b71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9449-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D308929E1C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add compatible and chip data to support GPCDMA in Tegra264, which has
differences in register layout and address bits compared to previous
versions.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 3b377f34be58..c2f32604e7fb 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1319,6 +1319,23 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 	.fixed_pattern = 0x34,
 };
 
+static const struct tegra_dma_channel_regs tegra264_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.src_high = 0x14,
+	.dst_high = 0x18,
+	.mc_seq = 0x1c,
+	.mmio_seq = 0x20,
+	.wcount = 0x24,
+	.wxfer = 0x28,
+	.wstatus = 0x2c,
+	.err_status = 0x34,
+	.fixed_pattern = 0x38,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.addr_bits = 39,
@@ -1349,6 +1366,16 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.terminate = tegra_dma_pause_noerr,
 };
 
+static const struct tegra_dma_chip_data tegra264_dma_chip_data = {
+	.nr_channels = 32,
+	.addr_bits = 41,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.channel_regs = &tegra264_reg_offsets,
+	.terminate = tegra_dma_pause_noerr,
+};
+
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpcdma",
@@ -1359,6 +1386,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra234-gpcdma",
 		.data = &tegra234_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra264-gpcdma",
+		.data = &tegra264_dma_chip_data,
 	}, {
 	},
 };
-- 
2.50.1


