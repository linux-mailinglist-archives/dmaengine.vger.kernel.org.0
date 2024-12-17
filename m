Return-Path: <dmaengine+bounces-4002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05D9F4569
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 08:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56896169CE6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1511DB94F;
	Tue, 17 Dec 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWNgLG4r"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8E1DB34C;
	Tue, 17 Dec 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421471; cv=fail; b=utUDjJumWnGsGEXZ8XYF2rrBL4mLSwzReLpGIsA7sc5/q0dhh88Fb25PPXdbMKSCL30XftGfNd4zml8VTr5BT7tlOk/cSU+tcPXNnQmHnu2Ymkqi6iANPjnJ1TiA2cnfGNuW4s37RULuJBJ9aMqfXuEb9ImTSxzIaLLw4CX27Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421471; c=relaxed/simple;
	bh=t2O0J+ehR56uejV8Dv1PgD98ZExfvTkfzfaRBJIICbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omWTUjw89if28rBCpM5xfGPE8I4bx6BzCMejxoLLGhFKJwPsOP+KXM6k/P8UpBl4P32WSgqY+991D0Jj5sSQtxd5PNPyhyNCXfSPWA7eecGso/PQxr7al8hBZEapBpJC1BFJ+vRkQ39OYgAUhc6Qv2e+ZvdtZelziFyRktts7us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWNgLG4r; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpDFpyxC6IZ9p/6OmbQ7WJ6hRyjCFaZeeyRQakimwJ5cOv7gz5kNsupFBKKCZGGVDjRbegplTm+e9xB4JSIqHaXGvErGPJ7PRY7pPyCoeZr8+RMuS/HpATMOAA1fGDOTumc8ZeahTMsKNDnlLecJj4wyaWixGHhAK/9dK3Zzum7EDS4zYTEi7LQTfASsvd23nj0bZccZnS0rTARwbIxs5h3ykm6ONGj/KIFHUMWmrYV667QE8bnA6aIVQIAdxZBk857s3XPoYifCOdmhhIeoo7tSeZcZ+R2ftmkZ9GQ2F0UA7z1jDT4OicwjcDcC7ulLSkuoouucZDc0374kvL59Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=DyCup1OJxSrA2si+hidYDpCvClG2sfKHxtLW14XeCm5HZOIK2YjdJgdyR4yq+pCX6ZElA2j2wjDG400M53N6D/YwcJt8A0LbtkY8PEZnbFmC/Po9l8q+we2+HxE/id8bOP7cK+WNMayWHVWZ7UpwUTYRTX0v1jcP4Lh1gkBgo+WzzjuK5WJM5vnuqp52FtVSSmqXdjOQXERSSFJrxMfatLT6Aod4WT/JGxiyILnh/SrzeKu7Hcpg3Qh5SGWNKHNkm0bvQnkXxpp2/p68+JUOhNRtxvgI+bonuzE7hj4VOJ5hDQH2ei7kz2Nk7VhyDGHJiIUBgqKiFmaf99XH+x9upA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIu534TX3lhOryF2fscbWwyfydqGSYwW+sCHVbJG8M=;
 b=GWNgLG4rwsQhNuGeLQ4yYyM8vstm+wMDPJWWhBqldnJf642KgfbcTK2m5Hd48gjPyiEVLiEOA3bB7xr9v+pbX0fT7O7ibO/oa5TmDbvr/YiesHgLiD6wcOe0QZB8ZfWSAUytzKW+4g82vlfOL72xZHtVSzmRBM+qYcz7f9bJgwDfxF/u9xLVYPnfKM+aM/7G9QaASKi9d0teJNZzvLA1BxKRNIV81IzV5i+dFr7bLg0j4eCm2FKzief5QIsy7e8vhQW7AL2Bl7QUT0Gy9anQQmrGVZ2wAb6HK/s/Kk3yhgPFt+xyJUniTUGQsVPPo3NGNaCNNGOQHFJ9UWz+1+bpGg==
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 07:44:25 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::e9) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 07:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 07:44:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 23:44:18 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Dec 2024 23:44:18 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Dec 2024 23:44:15 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>, "Mohan
 Kumar D" <mkumard@nvidia.com>
Subject: [PATCH v2 RESEND 2/2] dmaengine: tegra210-adma: Support channel page
Date: Tue, 17 Dec 2024 13:13:58 +0530
Message-ID: <20241217074358.340180-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217074358.340180-1-mkumard@nvidia.com>
References: <20241217074358.340180-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7c9183-358b-440a-98e7-08dd1e6ea0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HizunEHJdLO3pqGQjsrKNsmkkpIyYdk0KSfUYSkSBmGz6SUuCQROByQFcrzd?=
 =?us-ascii?Q?4sUn3wk8fewdCfZRfTniBYAMYCWNb3wYrlV99Fmc9W9ZDRIW0Icnc5ZtSFgi?=
 =?us-ascii?Q?tLMvzZ4aqgaph5zqEp/3sRW5Q5isi2rtSzBthHAcqi3/0IUOSDhKsHKKNbf1?=
 =?us-ascii?Q?MYWy/uiYcenaXEMIRkPVp7c+i53sKAeIcFjdFr1tmZsc9E9+ewxCC62Kx47m?=
 =?us-ascii?Q?wHxh5+h41zInMcRQEuPhf7SpFafJtUijzUxtNp2IfUzs7sd6/7WqvMKNoPIc?=
 =?us-ascii?Q?5thXIw+Bcv4OK4fYqn+L1JQ4kVOBbT8Wjk1QSfwunYMDOhjkn9gWCC6GAS9Q?=
 =?us-ascii?Q?mVXwxPfQXr/sxgD6qYz59w6ATfPd0G1MEX996JASKp3QKgMhYyHYvGMagElW?=
 =?us-ascii?Q?OxbX1O/okx7XEk7Q6ffJgmHHFMfFyPLHR42IsWxcjwIhRuc3SoPmxy8GofPQ?=
 =?us-ascii?Q?Dvia0zaadAIUs5J7t8Y5+R0MoP6a/1Ll4TWO8K3Fe3it83AHduuFf0D68uCn?=
 =?us-ascii?Q?TOrHEpLX4KivIeZUWczuVps6nFsy5KSMUWOtNUQzrYsgUYfA/hjZ15Iz8kMB?=
 =?us-ascii?Q?Fsn3mNSHY/CGMR8AYDc3iOI2GwObqjcXGznEvFH1Mc/ikFXwX7Mfq3XvnUAK?=
 =?us-ascii?Q?6RNFVUWJgljrg4nLhrIo1XAW07NdkjXfUyk3tO4uxXYrJTkK/ayMgmOOZckL?=
 =?us-ascii?Q?FaBTH37U8ojNSfZVCAHvhbVccOqzNsQDCUBvLFBo7dYN1t10mDKzKn/gfzJR?=
 =?us-ascii?Q?Eo17tcsca7Y5Eewqpe4/04o8B+06idv0iO7gnAbikWGRcPlbTCTKKoruxGoV?=
 =?us-ascii?Q?hkqnRlIkfYtC40OQHN4iUzlga8WpAZVHUukStYFJfNslhU4CT4EgNb+LVAEl?=
 =?us-ascii?Q?AZOtYHMH590D4HhLiTKFlY1qYhjQXHD4k12PvMuxtK+hHqUV55tyaPI08EXp?=
 =?us-ascii?Q?Q5IwPg0jKPF6EWBA/EMbeLAfOkRc/yILKEgjIQyw6Ygc5rJlRuPeDh5GMSjl?=
 =?us-ascii?Q?D0A6WKsk34i9rhfEUvWE6H1MDM27eshdpr6kJbAy7EhVdviPtd+aqtxI/V+j?=
 =?us-ascii?Q?+uAJxADwMM26h4OPTyxlYV0CTyvr6v5Zr1vcRu0wGz3A+Tanugc6SpiQb6cx?=
 =?us-ascii?Q?Jkd6JjBSR1UDdJGe5aSkbjT98X1zV30yT1RME2jWoft52u+RYViQrXr6SQJR?=
 =?us-ascii?Q?ENwuFg8SwhSaeHgFSw5mrAAVtwwaSgcISXGUyjWZUtxHuucbV9YDfJxGlm34?=
 =?us-ascii?Q?FjLUZ90wGNKs1x9no5jorNS9maaBJiiO7/HWnHvrvqxPREHY92cm62QkIu9M?=
 =?us-ascii?Q?4fNdUtKLt9ilUDn1sVY2kgmP3LxZjcEwb0/1xX9oEDiAFW8T99D6LRk01tIV?=
 =?us-ascii?Q?wjZwRN/F6+Xbn5FU9qThzVAujH6+ZzVC6zxdh7Wp8mv8n+IiY+n4Z1eQ3DDL?=
 =?us-ascii?Q?RgqzXIVoRbn6JhLYcbqT32qnuHpcnMtCloNjXNH5EEu+lLLjDi7Wrz48BtlS?=
 =?us-ascii?Q?OXqN27Od+HIg6vc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 07:44:24.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7c9183-358b-440a-98e7-08dd1e6ea0cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

Multiple ADMA Channel page hardware support has been
added from TEGRA186 and onwards.

- Add support in the tegra adma driver to handle selective
  channel page usage
- Make global register programming optional

Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 86 ++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2953008d42ef..6896da8ac7ef 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -43,6 +43,10 @@
 #define ADMA_CH_CONFIG_MAX_BUFS				8
 #define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	(reqs << 4)
 
+#define TEGRA186_ADMA_GLOBAL_PAGE_CHGRP			0x30
+#define TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ		0x70
+#define TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ		0x84
+
 #define ADMA_CH_FIFO_CTRL				0x2c
 #define ADMA_CH_TX_FIFO_SIZE_SHIFT			8
 #define ADMA_CH_RX_FIFO_SIZE_SHIFT			0
@@ -96,6 +100,7 @@ struct tegra_adma_chip_data {
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
 	bool has_outstanding_reqs;
+	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
 
 /*
@@ -151,6 +156,7 @@ struct tegra_adma {
 	struct dma_device		dma_dev;
 	struct device			*dev;
 	void __iomem			*base_addr;
+	void __iomem			*ch_base_addr;
 	struct clk			*ahub_clk;
 	unsigned int			nr_channels;
 	unsigned long			*dma_chan_mask;
@@ -159,6 +165,7 @@ struct tegra_adma {
 
 	/* Used to store global command register state when suspending */
 	unsigned int			global_cmd;
+	unsigned int			ch_page_no;
 
 	const struct tegra_adma_chip_data *cdata;
 
@@ -176,6 +183,11 @@ static inline u32 tdma_read(struct tegra_adma *tdma, u32 reg)
 	return readl(tdma->base_addr + tdma->cdata->global_reg_offset + reg);
 }
 
+static inline void tdma_ch_global_write(struct tegra_adma *tdma, u32 reg, u32 val)
+{
+	writel(val, tdma->ch_base_addr + tdma->cdata->global_reg_offset + reg);
+}
+
 static inline void tdma_ch_write(struct tegra_adma_chan *tdc, u32 reg, u32 val)
 {
 	writel(val, tdc->chan_addr + reg);
@@ -217,13 +229,30 @@ static int tegra_adma_slave_config(struct dma_chan *dc,
 	return 0;
 }
 
+static void tegra186_adma_global_page_config(struct tegra_adma *tdma)
+{
+	/*
+	 * Clear the default page1 channel group configs and program
+	 * the global registers based on the actual page usage
+	 */
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_CHGRP, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ, 0);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_CHGRP + (tdma->ch_page_no * 0x4), 0xff);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_RX_REQ + (tdma->ch_page_no * 0x4), 0x1ffffff);
+	tdma_write(tdma, TEGRA186_ADMA_GLOBAL_PAGE_TX_REQ + (tdma->ch_page_no * 0x4), 0xffffff);
+}
+
 static int tegra_adma_init(struct tegra_adma *tdma)
 {
 	u32 status;
 	int ret;
 
-	/* Clear any interrupts */
-	tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
+	/* Clear any channels group global interrupts */
+	tdma_ch_global_write(tdma, tdma->cdata->global_int_clear, 0x1);
+
+	if (!tdma->base_addr)
+		return 0;
 
 	/* Assert soft reset */
 	tdma_write(tdma, ADMA_GLOBAL_SOFT_RESET, 0x1);
@@ -237,6 +266,9 @@ static int tegra_adma_init(struct tegra_adma *tdma)
 	if (ret)
 		return ret;
 
+	if (tdma->cdata->set_global_pg_config)
+		tdma->cdata->set_global_pg_config(tdma);
+
 	/* Enable global ADMA registers */
 	tdma_write(tdma, ADMA_GLOBAL_CMD, 1);
 
@@ -736,7 +768,9 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 	struct tegra_adma_chan *tdc;
 	int i;
 
-	tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+	if (tdma->base_addr)
+		tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+
 	if (!tdma->global_cmd)
 		goto clk_disable;
 
@@ -777,7 +811,11 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 		dev_err(dev, "ahub clk_enable failed: %d\n", ret);
 		return ret;
 	}
-	tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
+	if (tdma->base_addr) {
+		tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
+		if (tdma->cdata->set_global_pg_config)
+			tdma->cdata->set_global_pg_config(tdma);
+	}
 
 	if (!tdma->global_cmd)
 		return 0;
@@ -817,6 +855,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
 	.has_outstanding_reqs	= false,
+	.set_global_pg_config	= NULL,
 };
 
 static const struct tegra_adma_chip_data tegra186_chip_data = {
@@ -833,6 +872,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
 	.has_outstanding_reqs	= true,
+	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
 
 static const struct of_device_id tegra_adma_of_match[] = {
@@ -846,7 +886,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 {
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
-	int ret, i;
+	struct resource *res_page, *res_base;
+	int ret, i, page_no;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -865,9 +906,35 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->nr_channels = cdata->nr_channels;
 	platform_set_drvdata(pdev, tdma);
 
-	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tdma->base_addr))
-		return PTR_ERR(tdma->base_addr);
+	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
+	if (res_page) {
+		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
+		if (IS_ERR(tdma->ch_base_addr))
+			return PTR_ERR(tdma->ch_base_addr);
+
+		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
+		if (res_base) {
+			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
+			if (page_no <= 0)
+				return -EINVAL;
+			tdma->ch_page_no = page_no - 1;
+			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
+			if (IS_ERR(tdma->base_addr))
+				return PTR_ERR(tdma->base_addr);
+		}
+	} else {
+		/* If no 'page' property found, then reg DT binding would be legacy */
+		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res_base) {
+			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
+			if (IS_ERR(tdma->base_addr))
+				return PTR_ERR(tdma->base_addr);
+		} else {
+			return -ENODEV;
+		}
+
+		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
+	}
 
 	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
 	if (IS_ERR(tdma->ahub_clk)) {
@@ -900,8 +967,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		if (!test_bit(i, tdma->dma_chan_mask))
 			continue;
 
-		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
-				 + (cdata->ch_reg_size * i);
+		tdc->chan_addr = tdma->ch_base_addr + (cdata->ch_reg_size * i);
 
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
-- 
2.25.1


