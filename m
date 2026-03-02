Return-Path: <dmaengine+bounces-9171-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIIIFM6EpWkCDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9171-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:38:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D01D8C4B
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D43EC301DBA1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262736F427;
	Mon,  2 Mar 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dj4mJMi/"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634F36E496;
	Mon,  2 Mar 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454999; cv=fail; b=BG7ZIXkp6YMH9uvS1CNly7FQQ7s24S9VMin8Adcpb2MFYwJLnBrMcuXEMv8IQZZR/pYrkprD2WjT1Q3Mn01N3Q85tKlL0o2gBrfEaOAk2dXBvljXQbAWLVdoJ6gv2d8sNKOWuaEMM12YB54AkmOVuLT+hHpK3Opiqamca35OiDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454999; c=relaxed/simple;
	bh=zbqEmD30p2s2recFsVWTNJd8Vt3/XDWnHO11LAMzcgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FizGsE9cRX3ErQucxpqR9AFSusJboq3sqz/dB3oR1CUmdhnpv9lluMBWLr7ydBG7PUax8E0aIG/Ikr9l6dA0c1d/GhK5i55KWfavugrAhNYa8lRnVenDrypLPsu46unTAiXBZj/v5J9PRcVLQbKjzActmqYskbp0HsQcSOp8UaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dj4mJMi/; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ3Pr6mWVUdI0GVaSRPTCF50xNMMxqkX+1GQ2tStXWMAod00SCzyysPIXjcbxnOprin/1+D0TS1pjh0sizfwM/jSx0iLUUlhlYI6PLPCcFzDyM3UibWweZhTlAXIvbgGD2CJ/7jMGUPfKyK14cmrrIsXx7b9jHDMW7RVvE3uc+oYSAVLmVSfZTY59M34/GESgzk0t2Z1Jj/w77KrhYicc2TuWzQ5rrf6jPGa5IZl4OGbT+WJJwukA/1SH2cXpDTQkHmnrvBC68Dij/KnGJYooPgzKgIM9P75hw59AXewELvl6s+3ScAx1Y3zvpH1TUWCKOcVQZ/6gaf+M3vY4i7mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnVVdWftpH8glkTgO07JaOnVnQ65PMADwUb8T649etc=;
 b=i9SgCbunq8VD8fUF6BB2ndj1PsEL9EEAUyPyLZmbNhGVm6i/o+yccxK/JbAoLBcg4BeRN6duwUKkZGwkJeMJ3dN+hpcKrwTB4MFWrfRfJYpDFUyON3JGzRBp2TQdn9L663Aghx093QGAEZlZJ8ExUnETHGncNFxZ+dJRAoofbHZgJypdJi9RVV1aJ63F6LQx2C9s88q7Tu+w7YI8nm+T4DxPIC/5iKcUiKpqQomFYzrGOXF6nrbRwPhVZMMP3RdpOXiFdcQ8wDX+M1vky7emf6+rM4kQMeOZGT6oDuOrpYQau9m+NuEi7OFJnov7mL1fA3QiA2G2Yz/0SSjcqYSBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnVVdWftpH8glkTgO07JaOnVnQ65PMADwUb8T649etc=;
 b=Dj4mJMi/+UMAThX7fQN+Kw2aYAb608CM3lOIBK/c0x5FyAgqCQYW8WMu/1YA8DeMLdVWXglh4QN59bf3njDOuifNEHZnNB2IYfZBrP4sZ7UgFv6jKUyR+1ZyqTbIH/jz2rCGOzQrBYjPfHEYBYISOhZb8IoWTVvH0oOCNkfghasqT6DSD9fB5acepozpxRc+cukP0t83k0Q4Qv6xb2DmVGgwjJEz2jZUtiUBJcjG1+cFgRHBGUzyod+zJrVddewXnesA1uaIiVD13lOLssl5HobPZ2LTN9CjDpeG5HFq2Iyc9aQkU+8V9hjTDpq6eLrgMc5Og2KLtD2ZbvNjXlwp8Q==
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:35:19 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::ec) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 12:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:35:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:35:06 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:35:06 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:35:02 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 5/9] dmaengine: tegra: Support address width > 39 bits
Date: Mon, 2 Mar 2026 18:02:35 +0530
Message-ID: <20260302123239.68441-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: c61d1267-b320-497f-ed1b-08de785829fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	7Hq32bzCI5e3eQBF3Uxdl0+GXw6Cc4Pd9rDob/k43QnP5FS3VwyJQVIeNXlitn3fcUXjqJ12gK02DgJAx2EAEcdZqyXrxTJbtJtCNAmGaE7p84hgOv7QNYXZ34fAK/hnnPw9vB2HPAJyPqEgrlTXpoiTEjZcrS43nWs7bLO8xXNiZSf9ajF1rknCmpijCYmcQ9CU1/jScuMKh7ZkTJhJ5tGH8/DULi1W4iXubjOaPRKAk7Bwrh7WRQ7/hAlbHjdlfxhC4tgqeGIESFf7+vg4XT+R682ajMj0LNv5nsDjDbaOVNr3XgeyyWVdsygdNGBPAYaU0xevzPLAtuq2tlP4CPB+p2OCo4P7RGMDYJgjO6ZW9rSVujM86tu/3u06LUKRGxWEuQEt6uJgXV3OnwEH9GWV5wy3E88+30hh7c8hnL5APYB1Afm64wQyWyu2oOLQqeJzY1n5J/y8z/P6I4qm/KanQfrelhk24JVbFuGcBDbFVX8aRtSohZ+mQc58wG2cvf3m5Wtgc1GcvzZELqPBqawt36fD8klmAUyXqc9fMF3ut+9gX0iUUXLZHLSWg1vdgl2Ml93Qx4w6Kt4eIbrS7Pc6n9OHlf5tfyBXvUdGAnHZ9mec6wH9FV+vIXsB3T1k7cp3ePBNuI0tUsNrP3x3alBpzFdCi2s/TMx8nhGUH3dG1M9sBEkJf/XgbAJTA6KuSQF8hlOOkXcE92IEcvaDRjFb8ZXBafgF4mAVJ5crAXaohZgV5jsNiiOHeDryExGJcsil7/WEVdGRbLCKOVyQMB6mTh9QO7jkXvZlAXQVFeCZ+rwuXvriYZRW5B34aKVzcR1c/uM+GiUPr0CT4tfdCuwud/5JPluUj+1rNHpl4EM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eHkdXWRQaaAxpqqTlvv1+56q1vEG/cPNjukz7kJa/cqtSdtJtrZ3UGHHT0WYKiiIXGQloWVNlu3ERDe3EBwKDH0owkY+CANh1UPR+eFFJ6yPySIktOZASNKIy0u5xaWLlsyzXx9bF3UAPcYqPJFS4DHMScZ2RY/as6srWIahcxi1gED/AddQO59B8nrVvKl37vNaHQW72kX5xtwMnYWh7e98YknGc5vDj/NKVYrgGs5S9Kl6rfFsRzxZdyvdnwKS2UBRp5u0QR6Q68clgUZN3QtEbdvJyKrPPwgbKSIlCpFCW8YxGhpa69WkDDA7CxYBeodlZOc2OjGIzQZwN6ELZByx0mUvaDSfuDTZr9tzre04w9XQfTMjSWdRDjEm9WaP8MUnpwQdxBis+Noc6d29ibusPSpOcmZpIN+cPt5vpXUi3ZoJjhwyJoBk7I8jp5BV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:35:18.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61d1267-b320-497f-ed1b-08de785829fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9171-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E69D01D8C4B
X-Rspamd-Action: no action

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
---
 drivers/dma/tegra186-gpc-dma.c | 87 ++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 09ba2755c06d..753e86d05a02 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -151,6 +151,7 @@ struct tegra_dma_channel;
  */
 struct tegra_dma_chip_data {
 	bool hw_support_pause;
+	unsigned int addr_bits;
 	unsigned int nr_channels;
 	unsigned int channel_reg_size;
 	unsigned int max_dma_count;
@@ -166,6 +167,8 @@ struct tegra_dma_channel_regs {
 	u32 src;
 	u32 dst;
 	u32 high_addr;
+	u32 src_high;
+	u32 dst_high;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
@@ -186,10 +189,9 @@ struct tegra_dma_channel_regs {
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
@@ -273,6 +275,25 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
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
@@ -281,10 +302,20 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
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
@@ -487,9 +518,7 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
 	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
-	tdc_write(tdc, tdc->regs->src, sg_req->src);
-	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
-	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
+	tegra_dma_program_addr(tdc, sg_req);
 
 	/* Start DMA */
 	tdc_write(tdc, tdc->regs->csr,
@@ -517,11 +546,9 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
 
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
@@ -826,7 +853,7 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
 
 static int get_transfer_param(struct tegra_dma_channel *tdc,
 			      enum dma_transfer_direction direction,
-			      u32 *apb_addr,
+			      dma_addr_t *apb_addr,
 			      u32 *mmio_seq,
 			      u32 *csr,
 			      unsigned int *burst_size,
@@ -904,11 +931,9 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
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
@@ -976,10 +1001,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 
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
@@ -999,7 +1021,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	u32 csr, mc_seq, mmio_seq = 0;
+	dma_addr_t apb_ptr = 0;
 	struct tegra_dma_sg_req *sg_req;
 	struct tegra_dma_desc *dma_desc;
 	struct scatterlist *sg;
@@ -1087,13 +1110,9 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
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
@@ -1117,7 +1136,8 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 			  unsigned long flags)
 {
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
+	u32 csr, mc_seq, mmio_seq = 0, burst_size;
+	dma_addr_t apb_ptr = 0;
 	unsigned int max_dma_count, len, period_count, i;
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	struct tegra_dma_desc *dma_desc;
@@ -1209,13 +1229,9 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
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
@@ -1314,6 +1330,7 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
@@ -1323,6 +1340,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1332,6 +1350,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 39,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1443,6 +1462,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->stream_id = stream_id;
 	}
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set DMA mask: %d\n", ret);
+		return ret;
+	}
+
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
-- 
2.50.1


