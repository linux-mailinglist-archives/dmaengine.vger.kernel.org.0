Return-Path: <dmaengine+bounces-9724-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG0cF/qSymma+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9724-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:12:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C999935D93B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D18230CF3E8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794DE331A76;
	Mon, 30 Mar 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfAsD8Wo"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088E330662;
	Mon, 30 Mar 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882019; cv=fail; b=uCGAZ8gf32z81E+aSwtcaDu/FavUdkdFKFngErsGN73waqoy9+3u0A+/rxMTfPNvVz4EoBtR608Uieh0OaLo8v4Vr/zQOvO1prONphk2svH/z3KoaMKcXsyw9z1k2dP9/N/M4j+ulI3E8YyZFFNatR8Ank/WcCLxzfUCSe9hHSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882019; c=relaxed/simple;
	bh=F7N07dFMLvlemGwIuQlgPeHn+dNn4DEOYOxqNi6avqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqd8kS1rU0KHtLq9XlG7mJNu8RepEfFClKrtroHeXC8pxebkkoIbgPOLcN+MoopDpQL6nqYbzdJgP/zfy/gZN70FB3jw8HMnPXckZZpiOkKpQu0k1WcDmnr3AGZ7viF5LZDtSGEIkPe+lpBZzLf7l8Upp9gAPvz0Y0uh+0nfd1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfAsD8Wo; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMaZCtNA/xi4k/vS1Ua/5z2MCVAa2pgQ8blFaaNiFp0egg75IYxeA8MhPA2peBLGTlTtVd9g0DfOtr0uzAT+Xvnny+lhToxMHOklSb5jHv4x/QElOM3d5Cb7pyebLBZZY0Vy6mQg+jN2EYczXfhW9PGU7NVttUJSVhcBrHXVHXPO0L4nKlDSxar7/2fDQSeA5Q5oD8RP4BJIEJ6vyk/T+EPwu7UK14czL4hiLEez9pgU99Z7KCLoqeXvmrjwkiQgcM9Tj51r2gzQ4dfJ8z+W7UhbDZSXz6d7eqNxfxZDy90Vj7YOU3su2DkQ+E2iuilBPEorTP5DoLBhu4g6roieYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URPqDxmkI/L7xMDFRAwSv9wH+PZi2i3JfG01+7Uel3s=;
 b=Vnsu35t9tYevr98Zi6l3zTFmT3M0CubxnlDEc+73VlwYVSAE1uegH1fEVSK+tAnvomEWj9SFGv9ldIqFoAfI3O4UcYbSoAHV4kq0Z1f955HYgZJO+8tssbq/qXLRR/NEwwVH6vIGSURrOBLItFe3d2+YjkzLEH5L59lmOw0CKtyRiQHsK4Dg5amO++S5IqSJIIuaHjHayb9DKoL/+8Kwe6yHhrMALkXd3iRvki64i5URi9RedCiYypfZpG6nb4S7A5I9r+yO97wJYWxSeNz0koGNoD2YqnlwEdCJIzOHhaeOn4pg889LsWpcwaayPHV0vRNr203GLctICWEMDlynIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URPqDxmkI/L7xMDFRAwSv9wH+PZi2i3JfG01+7Uel3s=;
 b=mfAsD8WorN4IJ8XgnO1joHcP9/skxJt1/o42fbEHY5UW+lCkfRpJ1h3aDXNUNIitx4POIUYaletum64+nU9dS3F4lx/zkvKr6cO0fodsiN6oVizgBkSbNX1QH/7jsRVOTz7dE7YbX6gJZcoQFvI5/AzvVPDxUbV1hbLnLIAg1C2SZ4F0aY8s4HYHP40BfhZYkDLSrADlDGBBebULHL8vSv7YXM5e88sqqSnfQ7qTV47jV7n20D1O2MD0QXXzrsSMTO0rmfj0mHdzBBiZcK5Pvdr5pyuhJhpjtLCEyKdJvc3IkTOoqrZXpOpXIYJMqNcCHeIlxojSpkQOpqVbRfpmDg==
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 14:46:53 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::13) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:46:30 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 09/10] dmaengine: tegra: Add Tegra264 support
Date: Mon, 30 Mar 2026 20:14:55 +0530
Message-ID: <20260330144456.13551-10-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: d25d8ba1-cec3-4a43-6dca-08de8e6b2f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0EH8bF/kYKK9bKpsOeGPxrYC1OBY2D7OPmuvzC+3a7hbbFo+dVwrOKpfU919WXVDfo2Ku4eTPW4xpLmK7dUiFT889EiY0hlZImth6kZi0x2z+dvbTBfosqSO0fcoxez0nK9siho0zqGWAtBcvr/Zes2RICtTjIdG98ft0gKRNiu+Wc8TxvtMkbfU+YTayF9NpOecSrHJFDThjfxuVyPfCH8CwRwRgluP+ESiDMNPQQlRnVLIA0kZAljDEWsj5BAPLTIrIDIC4bYjpP79p6QRjJpnObEDdM+UC84TDRCoGQ+RNZEFXtE2TvYDkps6nvn/Nv2jhUCnp3W6zfDf/yPzrxWJOACp7N2mcdt8LvOiCuqM/d9khB5U/ylDdrKSFHrake9t+cDKIVl7KU4XNwXJ/BS9GAnvqUfl38bDVV7p3jrZqdjNV7VVDu4zYCrGaUCpQU7b3pSXl8alr8//Axc8HwUVCjpER0ABMwN82qTWN6lCfYsFEHprH3FH1vxqOL9HS7mhfXZE28Ym7inHMuC57iafVpE4Q4EMaV94QP2t/DJKp5DmUiASEVqPLQTQNfm7S0dQOUp6Zvbw1T4flpHhOWKAa2YKbIQirSP4kUtog7T5u1TpaXVWZl3xSq/sx547mBqG6FOcbC7gzUa1a6qPqCO7XG1CxtxeGXbyp76HKgxC0SS7LQWOUuPQ0HmNzifgGNSAh7y722PUgTbS2ggfNJpOMDimf5YG4POXS+xfDsfw8fdovtwyaIFf6POZBqQGjIxk5G2mJXkMs5NCF67R2PRsgf14DPGsY2EfW4h83ekI28NHHc1banLwIpTCqkVr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1mCNhS93+qIU3nPF+n3iNN81BhH82Ocru3Dgj/WaI2KsfrSTK5e9fTvgGvFavWaTZP/1wmn3l6dAEzP50M1+B9jFfZ7V04K9kaQQCyCE6Sl+cAsOo9phjCup11iaMbC2NzheZB3jMY1r01/FCRNu6m04E8Yu7RbATgvP+A3ArEmK6/KCsNQwhe1afjxe49LKkRmJFQhUtzK2WU+hBtWr08G1DTVqtWw4XvkJJ2e2ldWra/9rc0jSQHLDNu9k5wC1bFx4FD1+WsIBMx3+UJhuIK2htK19X8vPjzkzRumsSvEYBRmtv/dRJ9VM7MJ2nPWgrhhyhyb43arAAWSsTodJ9l4udIP0wJcdJbcQL5a8PsMv6ENrYhRrREpZsqiZ6m92Z1YNYXz6w6t1d4j9hQFo6cjrvfbLA3GzWBz2JdPw2SQVMrzNaQbDG6pDARgka9f4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:53.3937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25d8ba1-cec3-4a43-6dca-08de8e6b2f0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9724-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C999935D93B
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
index 64743d852dda..0b7faf8bb80b 100644
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


