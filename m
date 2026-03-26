Return-Path: <dmaengine+bounces-9667-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC+sJHAWxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9667-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:20:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A32334571
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DFA3082A65
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F63BF695;
	Thu, 26 Mar 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clilHE5B"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5D3358AD;
	Thu, 26 Mar 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523486; cv=fail; b=oYU7Xn4v9toXmL4i9Xy+cOujv4mQwD1Wcm7VUCU5Zz13wsJuyklkgxOmOZpSo40UXHPl6nRR1cK8X6u2Txp0Utz2OO/xZsUaC6lbhZx+EXdah5GCrfiDhW1/u15XkSAaGEinfWEn0t59k2lYGFSgJV77VqbszLzHBfqE/6enlRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523486; c=relaxed/simple;
	bh=SQJ7VMOdztBN8VEoQ/woCNTKLz4Zb3vzMDtFm/Pnv/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMea1IvO5M/fpTFX7Li8zoEol1S1+4VhS5SXuAJAlcnINoClBpyuJcUyLpPetW4F6NFqcrZ88tignUvCVWo4jh3U//fdvq7C0G6P4T6PPnve84abZf9ByQL7t6Q0Lh0fNWMH0mq46Eqme0P/oyLRrhkGexURMXjLfLieLlZt+V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clilHE5B; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3WdayPfGrf00L7KgIQ4G/5ENnpOexbrmVlLoMooWcG4Os2cj0TEOL7GObTOTegXL/CMScEv/x24RN0smorQPgNgXkYeIT9iR4jPXXAL4XCl+MIQFh+XUoq3lhquSD0usCspecB3pMFyGQGrel2yKwbowBDI9ifHN2EIwB91KiCnpGio9ogDn8PEzYMyOpPgFrky+dxGjoor6ZylWXoCueD5+Wwv/IyCLWLG+rxdsN45Fbi2FwYHMCemqCqRHeYtJTqUAbkwIVXCoRSokx2lWLmWcU6r95SJ8P5nTI5F9iN20QhIgWN9eu5C3+aHmA6ED265AWpzjay7utFFAJu4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=IeEyNFvjKjSsr5P7fjyDAhq3viPMXxS6a55YYDf6kQoqHQOF5ddBfwSwFFD/pz8F1LwNQWXiIRaOwZkSI1LkyHtiIB1HYb0qZFltMsZzvfdM5TbGYij1JOPg0yl0xeiHF76cAl/NyAr5rWXTHQiXQhKx7yinfVwrqcPRge+r6Z7T7N37Jtoz9NqO48UNT76YzDsv/Pn7FF8UtQhh9297JimRslOjWvW2pVLQBIJe1+aynWedovkzCDcvJjtxTVbqVk+7hx/3NQOBATkyVeKvTViO/S429MiasYnQiXMLs7oE1PJ2Dy7yvDHifqHi4ehUc++MBGIrJPg8b37Ich0ibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=clilHE5BQeCrZ3sHF+rqGpv9FiDXPdX8fYXAXA93dvO57taYTUrjM9hJly8FKFoz+USWNY+Ok7vXHFpvofDqaeL+fT1xUE8FGU8UbA4sQnF6U0xPWoKJIdefQ4fPTrg4IDmIXjTk6ODbJ/gUFlpONvF8HcILajlluyyW8oLhBhEfVIYvYSCmJVNKfqZ4w0TmH+A0prV6ddqF7q9+DV/93f+UURnzplFs1s0fpfFM0nScWaBa0VIxo4lNWE0K2vam5TOoWw/+FU/2Kg73EEuSCpVLyyvVW1wXVmRyOxJAvFUfdCAZjWKDgdNkFoj+sC3actjUOrjvSQ4Y1r2kB9tQgQ==
Received: from PH8P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::35)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:11:17 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::10) by PH8P223CA0016.outlook.office365.com
 (2603:10b6:510:2db::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:11:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:11:07 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:11:03 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 06/10] dmaengine: tegra: Support address width > 39 bits
Date: Thu, 26 Mar 2026 16:39:43 +0530
Message-ID: <20260326110948.68908-7-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ed7cef-e4bc-40fa-8e51-08de8b2866d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zI8j1QZoceGWo1FjWKqpMiUFm0fTQQhaI3BUjmBAuNSVnmw12UR7hajQV33QUyxQ7thvQWNdIwerKy+RR4sgBpiAcYnnbVTMh5QCkc16Ntx4lu0DPVuCuCxOkHFDh/Lf5fW9gxyxUu7UO0ykFhptzGW8+wW7cXrfOuG8MdmZNe4j+WHEELJnjRgFMVwSPKu4b6lxn+e5e6RhNVI/Ci0TEZKS9ZTreoLj4HG+vt3aVC0pmSlUZRoTFgL+qREP3z6WkqckoLdJfFiXzz1xtaS9MQQNzhQBWl/4eP48UinR3bILAXBIxRBkBA8B9Nte9fjrUkyZ3L4rKCnZCRa1NmC9EFk0Ta32gihqEOw/aFDEr7rott9jVwWS4yMZgH8N/4qiC/EsMqG+QDRjk5V4inUIlQWboiUDgxotve6/ilrzG+4uhCHgC1dP90a67hgN2QPsuFGafvfLuTZ3d68ONDCSoObogJbk6oZDoqi7Gp59FjKne5d9653ziSZVFPNZJHTcoXepoZfbHo7/zkPdRqtsAMcXEHAwknyMQpqqtGPVmo+TjNj+JYN7vPnNqn0ppRDzM0DRM2Rx6a1xJqOGYGOWh8AoRsjT2j3f0tQTl0uId+n6FKS2GA3znCDn/h/KK2SDR8kAw1QtPWdn89fad6hfFAwPwAsUSEtGL242G10uRzyEQ53qclsjLiONUpsNl9T9hyKtZzvuNHOwBaoIa06TPnBXUL5SBqaHiwMfzqXbEizg3HD+q+8AnnS0IziWuuwHo3Ku72n1Jlwl0hPAhLOePC5tGXoCvH5fxwmsB5rgxzCHSjLPlFL67/Lcovh757YU
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wRLKPuP63zv7MIqzSeKbXF0jspFPaX+5KSZ2PPZZfHngac2+mTCoEwDmcws9JTO58kMdO5dtHTieyNty+Y2srjjOt4NKLhy4v9gTKvxgkBOxVnmXHKL3w+N+/pvVz7JSohv5rarjxjgbP1XGeeHveeTZcjZHSgIfgi+HeCBzoInQRMSi8sdY1tq2vNHAu/zUdFJk26jEXA5mGS1GhczhgTyJH4HDj657q63qBijZ2O95LOdpWgRrnr4/k40WLruhDyLWX29amXgE5gXohQVbqAuMM05UD3ew4VDYDOTjS4y/GkY7WWrLIiio63i+fJJ5Hc1ssyLAE2FWPKfORfClyp+dPR/W0MaLdw5e7pvdagXMkbccJ9coLhL9mnDs+s6Vvtbc+WcNSx89SYrE9W8ws2TIAoRpKekNscMpbvAAVDyaIXeAs+107yqLr7fJywUn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:17.1898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ed7cef-e4bc-40fa-8e51-08de8b2866d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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
	TAGGED_FROM(0.00)[bounces-9667-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,nxp.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F1A32334571
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


