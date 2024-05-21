Return-Path: <dmaengine+bounces-2120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297628CAD17
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A345B2277B
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0A6CDAC;
	Tue, 21 May 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZjEsqrvF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50E1F947;
	Tue, 21 May 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289753; cv=fail; b=XqNz2WSTrThAkORANF+iPnxtElUqYz3p90bjw19s1e9dUkthTJxz0Eds3ErKQdWYlqVCCanSZJuXS8G/x2MWDF0AGGEFZeaV3t0uWJSCGfTTCE4jSjE9qhPa2tE6ARdIVrVbmiggMlynA3K8Mgxn2poE4pxgb8YkU/N34roSh88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289753; c=relaxed/simple;
	bh=DXSHAprIkvTTYP1XMzpuOhlr+WjMgfij4mkww+kJB20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtYNj2oPJQbkcqIWGSerlhOlEwDPLrD5UHAGJ94o1Q8hasPl51FY16xwQt31OJ9ONOMNfFWNwNMIURXWjFPioU8cVlGLCpo0ye2GWA7KR6U5srr2yFx7AuxYkzW7UFTHxdcrgNUJCRxAQoJ8Ywz8Toh8gicvvjIZPfdyjk7HrVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZjEsqrvF; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2vUbr9744wNPJoIwIPKYmkCUwgUMq20elEq7gAdWlLAPD9R1OHOv7XgQ7LwF351nFTt5zlT3LJnsXCBAyXHKyBXTR5FxKjWDvw8DPKy2OzoqvdgdD61Oi1hLRqiCjEASHQ6U5edun0JCprM95cN6276A01iDM69Udsr6/pBTgQEBbXgysV4IJo2cpMi/1O3cclKTT6L9P0azBNwZOUD57qyTwx9pB62KEgwozHE73S1Cr7ofAaCIIw3pzs5Tmh65bexdrUjpZIkhH/ML9ia/aX9ygEttB1K2jzN/FXeWSEw5wuPv8hZfWBBJn5S7Ay+h1NUt8/dExLRYPcnMiDMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fND1Syo6V4ww/4E2FwaEUX8j/ReVi/ULbMfzBm62Tb4=;
 b=cDf2S8T3/yTGNIiVzo792ksNY66kj5lPVt9sCuSVp8SEPO4i09AZQlLO9mAtf62mmAiesVRPslp2ys6ExfRmbhgQil7liM5UIn15uT4lLH40LbvHBupLPHyb/Oe+MZFlxT41/lZtGtzBSNAdkI3lkWSv9SLme/D+2VIezjt+UdhTdT0fqsBFq7tLZy8V24wrBU0E8sy80haVEOj9TZiGS3bBiX/+2SSGEk6L/wkijmzeKYQo1cHznGyx5yg0/p0ln6WovoJrZt2t8kgVa6U3/rSkPOH7w1bEZzX7aEsA/UQJD2qFRz6UySXU35jiSZzhtkIxdq0zcw81mvj8Tcn83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fND1Syo6V4ww/4E2FwaEUX8j/ReVi/ULbMfzBm62Tb4=;
 b=ZjEsqrvF+bkA5Ijjosp4WPQcgtzYjCI2wwLmYLAMOf37OK1UyxjEEyCcSZNdUsbwdk58POgbRsbPS5eYHVW1A5XQTmqkiVX2aH/9Li9LS1Gls6m0uLhT7fQZHHUKtp4E1sDsBWb9ESGs+pSVCFbDgT8hR5ACyuVAOeYqHPTsynb9OZs13Bmi6IdxcTZwtG4YpO74dNAVYDpNT/60chxSesKK7s2VqiGu8Qu0cGsPXnNK6ouXd8zwm9lZSNGUdZ+M1m5vCiUaY2ufWcAynk8XPZ2D+c3XFdJJa+HRNuSjTZ+3+c/57JlIhu5pqAf8PfGU1ole6dxdDqKJM1XDdaEJ5A==
Received: from PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::6) by
 SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:09:08 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::9d) by PH0P220CA0001.outlook.office365.com
 (2603:10b6:510:d3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 11:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 11:09:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:53 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 21 May 2024 04:08:53 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ldewangan@nvidia.com>, <mkumard@nvidia.com>, <spujar@nvidia.com>
Subject: [RESEND PATCH 2/2] dmaengine: tegra210-adma: Add support for ADMA virtualization
Date: Tue, 21 May 2024 11:08:01 +0000
Message-ID: <20240521110801.1692582-3-spujar@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521110801.1692582-1-spujar@nvidia.com>
References: <20240521110801.1692582-1-spujar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3730ad5a-f450-494e-1a25-08dc79866f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vG9RtAQdHqaoZSzlgR2gH/kdxezuUUipNC6TVpGPrA1MeatmCNJchn++zdLP?=
 =?us-ascii?Q?rfrjw9wSJwv8BlryiAmWDPz5E7mCadYwZPCtVANItsNCo7cTNeK8Nic6ZgHh?=
 =?us-ascii?Q?zTpsd5Nq7Ji/EcZrheLh99Drm5RPdAIXuB6AjSsQoGoNl5ljLSpHSAtBKOtK?=
 =?us-ascii?Q?E6vXLD6cdq/Ruv+bzVMBVsG+oig6FQptev2eL/MFKYu4BHkFq1JLm1NxYzzx?=
 =?us-ascii?Q?0Y795lugcwaKcfYbYbMYf63X7G7JAFeKtj4XuuCaALsVWo8MO9D4r8Rvqapt?=
 =?us-ascii?Q?IvjSTooKu1oyt5hBf4t/jr4L/LmiBnV/XtvCel6DDvLr2sW2xSCglBIeBdmz?=
 =?us-ascii?Q?2Zia5fGVeZ6pl3fsNQ2iTgTTOnNVNKrzz9g0KlyHdOywjlb5ZQnR6M7uscLU?=
 =?us-ascii?Q?DvHfhH48nQP+u5xaoQ+dIJIkLeusw0WuvDIs1tA6wh5fHuohcEJsIOTkru+k?=
 =?us-ascii?Q?pvXgImAtw68cBIULannnd3ShHzlmr99I0gKopgks4WhZ0eSNT8ON0HG+wjjU?=
 =?us-ascii?Q?MaHzZm4cIZ/IJw9rDWRNqxNJxRCOPWHEXhXd5DZK/IoAKXfFDTU+TFfkMBsB?=
 =?us-ascii?Q?A2Mtgx+3bRRTp8nCOHYGN35f8dMMHRVnQYQXEZqEGhKYt05yasDlccXm00ay?=
 =?us-ascii?Q?GylizWBnFY+mAJjIWNTY8EaEsW8f66wA8VJ8YF1VqQsS53Oqb5q8tyz/i/5q?=
 =?us-ascii?Q?SuSvxXKLMEsf5tjwKnoI4T4SLGRXvjbKheLRRGELDEdyYkteaIFjWbgfrR/C?=
 =?us-ascii?Q?FbteLXcazN4ioDsMvVncr0N3OXNQwJogS4M5VBga9ieVfWsvbz+uC1Iu+Ive?=
 =?us-ascii?Q?350QouyUPdAoKayavN78E6HcoDnj/TVC3hjdXAyF+cPmyatVMD9y4kqahW1o?=
 =?us-ascii?Q?CHMIbA6HEGOxGsnPazDNYs0PnS+tmP3fqR1uQXKlGS6Rcxz6TeAyJV3nXjyA?=
 =?us-ascii?Q?KFWkqjgLLSKEQCexKRJuDmuBbYPnWbaZQXaM3Tvs4w/5yh88MfXeeRQ+7YlS?=
 =?us-ascii?Q?yZ4rn0G3u/wD1qJiR9tNPA6ftSacWPi+JfZRmVeitymlakHZOrIZpXDFAjVN?=
 =?us-ascii?Q?0LBW1EzL03VZxAy94fsEKyUmHlFj6rZF9xmJ/eVD60haJYCXH1ifx9Lfe/ec?=
 =?us-ascii?Q?qSsz1xjeVnkoJqFXo825fkIXU0BYQ53AnilgyicjJw0wAQ1Ef7mnvsrpm1lT?=
 =?us-ascii?Q?HXU8KQgRpMh6jrvSmnM21bV62KJE2YABVfjp/uLUmqVis6x3A2tT2HQ6hhkJ?=
 =?us-ascii?Q?W24zoJl2A+6TzGSMBeK7IKYeF4nYYk2ZOebOSxMUugfbxz6Tuq/qnVY4g8in?=
 =?us-ascii?Q?Qj474wb7s0IoGRBZqyxuIhIUzfQIdl5r3LjQJ/8BnohGeTOQfSlgGrZmQWoO?=
 =?us-ascii?Q?TC8NVWo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:09:08.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3730ad5a-f450-494e-1a25-08dc79866f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

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


