Return-Path: <dmaengine+bounces-2079-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437848C9D20
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1F5282858
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2756B72;
	Mon, 20 May 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZhx5LfO"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2D56450;
	Mon, 20 May 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207864; cv=fail; b=fJLmuWeXFLomIOcCtIt0J7WFlT0sPPDyXr2//o123UWt5HMq6R+neT7/R+Y0wKevOwMsu7hkAecT0/vy+Jp4BQL2qm4e/ocy9X0zUwGE6p5hFP63TJTQsEM7n9vnGqAFG9niuEY82yjxNeHCkzLpsDLzJ/Lb41bRqpNnYXSsdTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207864; c=relaxed/simple;
	bh=DXSHAprIkvTTYP1XMzpuOhlr+WjMgfij4mkww+kJB20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4gyUciZ4sO2H0YkASXd+IVbpygK3xfTPvCeLy9rt4FJNI5POkIQ+K3puQ2s9rYeRCnU6FvEAEBzE1jTMIwja7BvBTnAXJ8fvaQlm5zodvqzpRfhUWdM9+UQdw6xUigbfjUJRS6Pi5sY/soiNGjdSZYg26U7Hx9+CYshqK8SMwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZhx5LfO; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg2qBDmilrZmWRGgaqbo7yXrEhBR10uNsJ2fH9SK115miH+H58ab7DmfYC9Vi7+5EfsXC1UzaPQFizN2yQqGsCtlQ9Ckkd2u1TH9SIijroVRDDV/NSznAtqn7mRcNpnwhmLiL9XNnoQ0dvBPkWOtKdfLQ4LfOs/pJINGPVMtjX1oET5my1lfMPW4F5xJWx4xPQ/4mtov8wka7xzjuP/kvJIjWjLvD/FnWcmZCravtraprQQVYyOG8n1skHnR7Od0hDF6NavaHYMkzEMHfJJ9bsQUqGrsabvN110fiAD9bQCuvad5V50dPwUu3X62dmJvS9JQKQNTiTMQfJM2bVxeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fND1Syo6V4ww/4E2FwaEUX8j/ReVi/ULbMfzBm62Tb4=;
 b=FM1UtbPcNw8EkO80N0/x6sL3xZjRwLQiajqVVgwY1kcb4KVQJwpt2pPlFjY6o0+Dgrh8NcUQNYIUlecYuwcPXQvLI6BUm8H3LzJZqk4NPpxCF+3n13B45PgDGXUIWBF22AjJvYAlPXUaWzRUcaC1xaJ56k+IJO1fTJaEAAh/Tu+0SPpTPDDP2ookBurfTm2MNPyH11dvG5A3m+QAA3op+Cu++y8+RVURy0am8cMSkEuNctDmGNl5/stBLg5S4uCnjN3DBXD7Frg2NitAHoZmO24M8EYZtveGyRuBmT40EmSfw/URfIq+BuZGEukBrD3l9Kl9wyHyMRs4zZi5iJqczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fND1Syo6V4ww/4E2FwaEUX8j/ReVi/ULbMfzBm62Tb4=;
 b=fZhx5LfO1HoefqrkrC1J9SX1PodY9oNUC0A4BhUk2a5+trFKxVYDK0J8q76mY3go5eS3jwwegGq8OG2466vJRMicYcdhkWDC+XL9qfpD7Pte9hd3E00LspYaQBWY3offjYmrr2qDPurKXeCjVUOfsCu2eYjUZSNhHsZkaq67TBFRwi0yydvtOxz4osdaN6YDuygvUU+/S2vxGI2kN5xOIp+IBCtLx6DPbZngahDf20ai3WGdiHfi+4AswqvrHbZMttCBK19HUHH6YCB0yZd+5K3f3e8aWlSVwEeMiBHBzRcZzoakOKt9uvyfZk7uvp03RP/eO97szKX/atKm39qtYA==
Received: from PH8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:510:2d2::20)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 12:24:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::86) by PH8PR15CA0020.outlook.office365.com
 (2603:10b6:510:2d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Mon, 20 May 2024 12:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 12:24:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:02 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Mon, 20 May 2024 05:24:01 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>,
	<dmaengine@vger.kernel.org>
CC: <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mkumard@nvidia.com>, <spujar@nvidia.com>,
	<ldewangan@nvidia.com>
Subject: [PATCH 2/2] dmaengine: tegra210-adma: Add support for ADMA virtualization
Date: Mon, 20 May 2024 12:23:51 +0000
Message-ID: <20240520122351.1691058-3-spujar@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520122351.1691058-1-spujar@nvidia.com>
References: <20240520122351.1691058-1-spujar@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 88672170-7a75-44ae-f4a2-08dc78c7c55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7LGPa0a+lSc87BFV/wTNcfU44c990iS4dsM4TurJ1EbUY/eLpwhiLOiktiH?=
 =?us-ascii?Q?/0gVvpgdfcSset0Y3I4/mceq0awK1UC0jKuAty4FtaZb+BbHhGPC6eFMksaq?=
 =?us-ascii?Q?TQUu9Ei0Gy7vBbEqCzssHkpuniGecyx5MDFb/eOnW6KIxpY0R4rTaDEAAxS2?=
 =?us-ascii?Q?eNBsZCDnbU9WT+Bx6iavBseWSRtB+59FaEjdTHE8tC6DOTm+V1qRCqcHv5wr?=
 =?us-ascii?Q?53QiRyC1LmjCs0qe0c6rU71FMcVncIphwMziUgi3l/u0hcKnAoV8ZYtU2Cn4?=
 =?us-ascii?Q?4dbJ/Db3Y6QGLIf2s393yQnrtmbG4f5A9KQCoXA+Dq1GGVlKI8KD1o/vdKx1?=
 =?us-ascii?Q?PXMPPeuKxNmcsZe8JKiNrYlWULS3kZ9tsvyLnhSjCcCW8IaJPTfny0dS2RHb?=
 =?us-ascii?Q?VRbGNh6xqFUSxIHAJNNlGgLbvBalJKQqUkLzE2yMpREJMIx+qi8pMy6Whl41?=
 =?us-ascii?Q?aW3EZq2wB3yvZ2dyz4xnj5wFWr9r4rzbyMRHn78gK5CYdhk4YaWON0+p5ded?=
 =?us-ascii?Q?EDXMOGCvDFquaeoBN02mfWTZwvl6i6awV+N+YzEaTCtoIl+KVR6QY/n0ZRrl?=
 =?us-ascii?Q?PtqFpFOgeEqiQZ+BEVnxTQDmVc6I3W8aWNUjBq3+uVjxuRGqg/P5co4MFEUc?=
 =?us-ascii?Q?Wo99mTWW4KzewEttvlq3e+fWOqgrQCAeq+xxjHgfAKgSz4RRQIUHzz1NYcxa?=
 =?us-ascii?Q?tyr2rs0s5CmsRNyoiTh9vCh1z2WtDWoIhuoFZzLZ3VZveyMKuqxFx+Ozq+2H?=
 =?us-ascii?Q?hMHTLeFu+DcGyp5EDHkvkIWYm/KaGvor4MuIPQcxVxrHKbg7SLs9ZBJVXded?=
 =?us-ascii?Q?/X3ORmamnqi7jXjlVEci5f1xsKhwWlIzFEZIh35uVZntoH89aO+nFj3kIY1p?=
 =?us-ascii?Q?uMVtrxXzJ7Pldsuj5j1yXSqyul2oBm319/pwdxy8TDAGkrDdviZoEl3WljvE?=
 =?us-ascii?Q?x/N2OQrBGOlfor2TPP1NdpPUAIx/lW5/fbXiycL+/CqYGueyNrDjeLpd5Dsm?=
 =?us-ascii?Q?onHdHH7Bxm+vZ+RyT1Ol1Peo8rJ6333Y9QD7AHbT+YTNd4b568XpbzP8OHq8?=
 =?us-ascii?Q?lofHYxAwQhNfrr0mNYi0FTBJmyco4OafU3oBmD5rqSEW/QBh1d1baD+X0A/h?=
 =?us-ascii?Q?ekkOaw/pDQJYA43Q7kCi7BFmrpdqxngNhm/Jdu6s7ef4ZnLXWNdBU87N6YTF?=
 =?us-ascii?Q?BMBhd8Gj07dup+COiOtIzDGwFPtjoRKhXnzRFrTYxb+V/yRycIvMmC5nL1bo?=
 =?us-ascii?Q?Yf7BQ2ccrelve7Aiqi5+MNHLb+mNmynIm1j3bzhtMqMs38JQCUyS0LmOB+Vb?=
 =?us-ascii?Q?UHMaAhDQEWwUb2B/m4BjxeEoMnEZM+N1hYBHETTQ/VVNcD0HzgNvaYl3MREC?=
 =?us-ascii?Q?jV117lY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 12:24:18.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88672170-7a75-44ae-f4a2-08dc78c7c55b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

From: Mohan Kumar <mkumard@nvidia.com>

Tegra ADMA HW supports multiple PAGES for virtualization, to
support virtualization support reg-names property has been added
to DT binding to know the hypervisor mode. Also in hypervisor
mode the ADMA global registers are not accessed by guest OS.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 44 ++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 24ad7077c53b..92f1c0c949dd 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -160,6 +160,8 @@ struct tegra_adma {
 	/* Used to store global command register state when suspending */
 	unsigned int			global_cmd;
 
+	bool is_virtualized;
+
 	const struct tegra_adma_chip_data *cdata;
 
 	/* Last member of the structure */
@@ -222,8 +224,15 @@ static int tegra_adma_init(struct tegra_adma *tdma)
 	u32 status;
 	int ret;
 
-	/* Clear any interrupts */
-	tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
+	if (!tdma->is_virtualized) {
+		/* Clear any interrupts */
+		tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
+	} else {
+		/* For virtualized mode, ADMA global registers are not accessed */
+		tdma_write(tdma, tdma->cdata->global_int_clear, 0x1);
+		tdma->global_cmd = 1;
+		return 0;
+	}
 
 	/* Assert soft reset */
 	tdma_write(tdma, ADMA_GLOBAL_SOFT_RESET, 0x1);
@@ -736,7 +745,9 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 	struct tegra_adma_chan *tdc;
 	int i;
 
-	tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+	if (!tdma->is_virtualized)
+		tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+
 	if (!tdma->global_cmd)
 		goto clk_disable;
 
@@ -777,7 +788,9 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 		dev_err(dev, "ahub clk_enable failed: %d\n", ret);
 		return ret;
 	}
-	tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
+
+	if (!tdma->is_virtualized)
+		tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
 
 	if (!tdma->global_cmd)
 		return 0;
@@ -846,6 +859,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 {
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
+	unsigned int ch_base_offset;
+	struct resource *res;
 	int ret, i;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -865,9 +880,22 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->nr_channels = cdata->nr_channels;
 	platform_set_drvdata(pdev, tdma);
 
-	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tdma->base_addr))
-		return PTR_ERR(tdma->base_addr);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vm");
+	if (res) {
+		tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tdma->base_addr))
+			return PTR_ERR(tdma->base_addr);
+
+		tdma->is_virtualized = true;
+		ch_base_offset = 0;
+	} else {
+		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(tdma->base_addr))
+			return PTR_ERR(tdma->base_addr);
+
+		tdma->is_virtualized = false;
+		ch_base_offset = cdata->ch_base_offset;
+	}
 
 	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(tdma->ahub_clk)) {
@@ -900,7 +928,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		if (!test_bit(i, tdma->dma_chan_mask))
 			continue;
 
-		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
+		tdc->chan_addr = tdma->base_addr + ch_base_offset
 				 + (cdata->ch_reg_size * i);
 
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
-- 
2.45.1


