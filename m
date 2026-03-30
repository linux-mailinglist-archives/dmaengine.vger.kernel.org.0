Return-Path: <dmaengine+bounces-9721-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDaVJtaOymn09gUAu9opvQ
	(envelope-from <dmaengine+bounces-9721-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:55:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EE35D3F5
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6A531358CE
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339D3264C3;
	Mon, 30 Mar 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2Yi9e5q"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D573242BD;
	Mon, 30 Mar 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881999; cv=fail; b=p6McmrBIajzfo+TT/dCF5/Ks18QoopDlkN49yx+dXi7aMoRO6IPUDqcJtB57voogU0Gho4w+Y76RxFPQ9fNu9Cao4w/WhsNGj2pJckUZceu9Pguzw0xEzAlQWC7iy92EUWb7eL/MRWJ9neATf9TKoWEE73CThHWZZJ0Yio4Kx5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881999; c=relaxed/simple;
	bh=SQJ7VMOdztBN8VEoQ/woCNTKLz4Zb3vzMDtFm/Pnv/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fu1Jr/6v3K03c2UFMtrCVNjV/AqFXDLq6YK2bChi8Su6e9dDkpnAxqvSIollERjj4qzzTZsCHpyj+/ogYcHML8rQf0DmnXwRWqvp9FTRmuNwojRI+x9vh/t/kw7D4JOmWBhlCoDVpfngkrRrQ/Vi0NQ+Vqrs8hxAxSatxmxnHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2Yi9e5q; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2mr+xc4RtLU6gYu+c8bq3kaxRR56AxVqfvgCq+5qMQNq1kKWfm58XCVFB7kK1TRjQKhSUN/e6yikGHJcPrxEfgkpUQe2E6jvn97t9N6+5O9dsEysJHk93NXSVQk9GAEG3ZRtC3p9plaUu5icHo7sYW+3qfKaJKxFtyaO/G8d2GidliWD2z8doMeUlS3XnF+R381Melpuw3g5vcfXNcDrApkhSHM9kUf8+ZArSrE0bxIlL4th2pOYhBEafztvUW4reScq2jgS9fweUkagR7fLab3xOGUg2jNls8Jxqu5J+OKiRCUwUWwEyMjy9BvB+xqBEvGm/P868GrnjjdTDbk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=G394CHLPVhj89XiLPp+spbrInMFzCkjcjM1d+jPBJfE5mf3ZmweV942zm11pHO+IqF2WcINR0TMd9qSTvstuPqVkMST4Bdad2YYjJFNb7pRGs4ybz/Mbp6zbs5XhQPN56zRe0Ff8OPmghAQv2U/lZbTxi7yZB7SHD8Oybui0PCbiiCwDyimWzL037JUkrF2lgzd9EvP4OMlJpWvyU54OOl19XdH28nw7glGPBP/gDA9LtIQdTPL1x+9BfiKP5DY2n+8tSj2bLdSRnYU1IQ1/ifjm+JvegZc1ZOwyIi3V7/4ord8QHKWls8WwD1XnyFXQacTle0wEupRK3HrHV4bTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=E2Yi9e5qC4oDBv/RuktMbiAfGnyE3yjK0Bv5zMHPg2dqHnvflzYrrKM1sbmTtLU+VIKQROIi0Rifs0rl3N3whhkkSYefE+V7xyvE4ssdCBFekUrYt1KKdulC/4R/uAuHYHnLHqpov0XBxVbo/dYGUN4FeoXS3vcpriWDGvMtlzoBDdEz+YiL8fnwfxdJVkchRUG3uwyNwrvGjAZGmklGPMgCFIgtdd05ZsDofkX9HbPKPbG1ePPMfm4IpMvra5YRzHxA1YZ619MPtYbmi8xXtsQaF4Kmv+UlzVhnK8xq7wWbGSSwBri+QkukrBhyLrE4XWhKaASYhGPLODtV7FrTDA==
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:46:31 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::52) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:06 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:46:02 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 06/10] dmaengine: tegra: Support address width > 39 bits
Date: Mon, 30 Mar 2026 20:14:52 +0530
Message-ID: <20260330144456.13551-7-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 17be865f-0f3c-4937-310e-08de8e6b2150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	amZnNZ8p+eTZGIAOMq/O0YsRcgJ/K6k6WYxsNTPIntRhLmDtnl5zrh2zZJQUDxmrK7ngBJ1SlHhy0N9gvJQbVXq803fqEcr5CH+85wQ1zdaokS0U09tDHSF52QpBvK+sYPIkNeJulwFmD961vsvptbC7adO88UE/IFx8JeSURur7OQsfPvgJBuEMIxpko8kr1RRCfMVNDClBs14OpnOa+8hz6euZR5ILtuPZoYBAGlP0fO0l3oBIHB5rdIP32HOYayT9UtFgZ+Gar5I5s+CgACl0W4/qqQs9x/7K2dFUrF1LarNwsKvNKJ8+m4OdZeCnX6dXVIkVHWWlotNV8BT0RUN1QnnczVZogiNZSGOHy2EdeR+8xwGuhBbzwHd8m4Tjz1NIODNuu4ly3pUBHJ4diJcgt8hesqcm+0AH47kAG/89yaU2E0M5Sm11PK3JJuKRIl1jwSud83FozCw6ZI6T3ssrtHI5HwUnb4sA4mZD9r/hX4zypfg0OVdbruzUL93jD/t0Lxqkv8lqya38kgXh0UgTi9q0gTDN4t1OkLFALyAEor7BNV8grTyi8TBs9a9r9dcvTO5Kw/L0RsHNfcAwqyyR0iSFrbaWJyf/BwK9UIa7jlC7tux99SmU5BlphXulAPwnxsxLvbCJeUyOVG0872XTJe4y2C7m1VDY4XhQzt4HaaBp2IKKtmjXXkvukywyaZZPqUmWLOi3YMawPlWMxv3oHSSE8zG2v5I6QqIwM/1CJ0KkwzNuV1aNbBmlgdENTCF1SsP6GLRnc9VEd1X6C9jOWzPSNUC/8dY/UPr2teovCmFYNof+3iZ4mpiU+KDl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+oh4N2ZAr1GkfU118HTUY7f6yiX/LnfI1HEHRjau7NO+rI8NvPnR0tgBx3g41jJsqk793ZpyTSsrue60L3rCgs8NMKoJY3iS+yFAevRSKOa93Skb+Fl7W8tdTz3sNRXhlzVhuzhn1BsLao1MyK7xgWhwGAoxfNs79LEPVwV6hxlGseuaeXpxEHoto1EbLVN1Ik6sJP9K27aKZdnxyC3QnHzMUsMbd44YHyyWnHEl0iuKGYhqLdT1MStn7Lfh/UCU7lnDp8fM3A77vqUCRPp0QGOsRxgTOB5d1LIQzI8QNqUZCsDcGwsd4fobUDbxxqHCOjzUz7rBPP7wxuWtF8KJ5jipF4y+/XdUinlwBR13KCpTQS16E1Cmb4pE77BoewrheAySg+RfgLKangHiPz9xMa7HhnN016CYyqxT8DI1SZ5sOZQn6FW5wfrf8gYt3WWD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:30.3310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17be865f-0f3c-4937-310e-08de8e6b2150
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9721-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 362EE35D3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 supports address width of 41 bits. Unlike older SoCs which use
a common high_addr register for upper address bits, Tegra264 has separate
src_high and dst_high registers to accommodate this wider address space.

Add an addr_bits property to the device data structure to specify the
number of address bits supported on each device and use that to program
the appropriate registers.

Update the sg_req struct to remove the high_addr field and use
dma_addr_t for src and dst to store the complete addresses. Extract
the high address bits only when programming the registers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 83 +++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index b213c4ae07d2..3ac43ad19ed6 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -146,6 +146,7 @@ struct tegra_dma_channel;
  */
 struct tegra_dma_chip_data {
 	bool hw_support_pause;
+	unsigned int addr_bits;
 	unsigned int nr_channels;
 	unsigned int channel_reg_size;
 	unsigned int max_dma_count;
@@ -161,6 +162,8 @@ struct tegra_dma_channel_regs {
 	u32 src;
 	u32 dst;
 	u32 high_addr;
+	u32 src_high;
+	u32 dst_high;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
@@ -179,10 +182,9 @@ struct tegra_dma_channel_regs {
  */
 struct tegra_dma_sg_req {
 	unsigned int len;
+	dma_addr_t src;
+	dma_addr_t dst;
 	u32 csr;
-	u32 src;
-	u32 dst;
-	u32 high_addr;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
@@ -266,6 +268,25 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 	return tdc->vc.chan.device->dev;
 }
 
+static void tegra_dma_program_addr(struct tegra_dma_channel *tdc,
+				   struct tegra_dma_sg_req *sg_req)
+{
+	tdc_write(tdc, tdc->regs->src, lower_32_bits(sg_req->src));
+	tdc_write(tdc, tdc->regs->dst, lower_32_bits(sg_req->dst));
+
+	if (tdc->tdma->chip_data->addr_bits > 39) {
+		tdc_write(tdc, tdc->regs->src_high, upper_32_bits(sg_req->src));
+		tdc_write(tdc, tdc->regs->dst_high, upper_32_bits(sg_req->dst));
+	} else {
+		u32 src_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR,
+					      upper_32_bits(sg_req->src));
+		u32 dst_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR,
+					      upper_32_bits(sg_req->dst));
+
+		tdc_write(tdc, tdc->regs->high_addr, src_high | dst_high);
+	}
+}
+
 static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 {
 	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
@@ -274,10 +295,20 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 		tdc_read(tdc, tdc->regs->csr),
 		tdc_read(tdc, tdc->regs->status),
 		tdc_read(tdc, tdc->regs->csre));
-	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
-		tdc_read(tdc, tdc->regs->src),
-		tdc_read(tdc, tdc->regs->dst),
-		tdc_read(tdc, tdc->regs->high_addr));
+
+	if (tdc->tdma->chip_data->addr_bits > 39) {
+		dev_dbg(tdc2dev(tdc), "SRC %x SRC HI %x DST %x DST HI %x\n",
+			tdc_read(tdc, tdc->regs->src),
+			tdc_read(tdc, tdc->regs->src_high),
+			tdc_read(tdc, tdc->regs->dst),
+			tdc_read(tdc, tdc->regs->dst_high));
+	} else {
+		dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
+			tdc_read(tdc, tdc->regs->src),
+			tdc_read(tdc, tdc->regs->dst),
+			tdc_read(tdc, tdc->regs->high_addr));
+	}
+
 	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
 		tdc_read(tdc, tdc->regs->mc_seq),
 		tdc_read(tdc, tdc->regs->mmio_seq),
@@ -480,9 +511,7 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
 	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
-	tdc_write(tdc, tdc->regs->src, sg_req->src);
-	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
-	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
+	tegra_dma_program_addr(tdc, sg_req);
 
 	/* Start DMA */
 	tdc_write(tdc, tdc->regs->csr,
@@ -510,11 +539,9 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
 
 	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
+	tegra_dma_program_addr(tdc, sg_req);
 	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
 	tdc_write(tdc, tdc->regs->csr, 0);
-	tdc_write(tdc, tdc->regs->src, sg_req->src);
-	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
-	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
 	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
 	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
 	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
@@ -819,7 +846,7 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
 
 static int get_transfer_param(struct tegra_dma_channel *tdc,
 			      enum dma_transfer_direction direction,
-			      u32 *apb_addr,
+			      dma_addr_t *apb_addr,
 			      u32 *mmio_seq,
 			      u32 *csr,
 			      unsigned int *burst_size,
@@ -897,11 +924,9 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	dma_desc->bytes_req = len;
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
-
 	sg_req[0].src = 0;
 	sg_req[0].dst = dest;
-	sg_req[0].high_addr =
-			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+
 	sg_req[0].fixed_pattern = value;
 	/* Word count reg takes value as (N +1) words */
 	sg_req[0].wcount = ((len - 4) >> 2);
@@ -969,10 +994,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 
 	sg_req[0].src = src;
 	sg_req[0].dst = dest;
-	sg_req[0].high_addr =
-		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
-	sg_req[0].high_addr |=
-		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+
 	/* Word count reg takes value as (N +1) words */
 	sg_req[0].wcount = ((len - 4) >> 2);
 	sg_req[0].csr = csr;
@@ -992,7 +1014,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	u32 csr, mc_seq, mmio_seq = 0;
+	dma_addr_t apb_ptr = 0;
 	struct tegra_dma_sg_req *sg_req;
 	struct tegra_dma_desc *dma_desc;
 	struct scatterlist *sg;
@@ -1080,13 +1103,9 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		if (direction == DMA_MEM_TO_DEV) {
 			sg_req[i].src = mem;
 			sg_req[i].dst = apb_ptr;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
 			sg_req[i].src = apb_ptr;
 			sg_req[i].dst = mem;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 
 		/*
@@ -1110,7 +1129,8 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 			  unsigned long flags)
 {
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
+	u32 csr, mc_seq, mmio_seq = 0, burst_size;
+	dma_addr_t apb_ptr = 0;
 	unsigned int max_dma_count, len, period_count, i;
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	struct tegra_dma_desc *dma_desc;
@@ -1201,13 +1221,9 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 		if (direction == DMA_MEM_TO_DEV) {
 			sg_req[i].src = mem;
 			sg_req[i].dst = apb_ptr;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
 			sg_req[i].src = apb_ptr;
 			sg_req[i].dst = mem;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 		/*
 		 * Word count register takes input in words. Writing a value
@@ -1304,6 +1320,7 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
@@ -1313,6 +1330,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1322,6 +1340,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1433,6 +1452,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->stream_id = stream_id;
 	}
 
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
+
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
-- 
2.50.1


