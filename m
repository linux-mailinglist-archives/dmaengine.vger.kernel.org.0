Return-Path: <dmaengine+bounces-9445-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG4RGpQ9uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9445-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:27:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F829E303
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03518302D5CA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C183D16FF;
	Mon, 16 Mar 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdJ/emT3"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1E3CF693;
	Mon, 16 Mar 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681621; cv=fail; b=L5jG+h2QRswe+2EHb+zgwuVuDvxjj4umVhMmtoydVcpXrUHck+WIevISCPG+s1V1u/wIPVEdo1W+Tti9fnn0kOQAQGiH+b2tq9Hza3o9ihLEM0g6pFfaG7eaFHDDzz1BKHaacAMEG/1V1t3x7yp45DBaue6uookhVtvUg71LWzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681621; c=relaxed/simple;
	bh=SQJ7VMOdztBN8VEoQ/woCNTKLz4Zb3vzMDtFm/Pnv/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxWuMJa6xS6ZeXyxdEUoXTRVcRTFilR1nBM3H0Q7viEzyPsn4d+D25u+akGDJevt1podyVjjZAge8fwbIgkGVVt21h/7g0uriQB6AONsqV3wQoJacmeOKZsEInkCBZtM84fgQUHSWZbi+90kZ3Hluy7eKjC6hpO2NRB2CJu20UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdJ/emT3; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suEGEcRsc/yjwKIkG1tIlBWcbDzWG+MPbOHh2iPesMH5TXsRh+Uzc/AyWF6LQV5WBs6ud28rBfK/fOVdQ5w1rdzD0nmg6pOcnyHGzjC7oH+KtCz91Ju0Pt6qFGYNJq5Q/NAknN+9cdCgMer06GUFF/GqNSws9JBVVQkD7iwDmfSUl+7YDnI4QDs8WBdsohhEirFgnW7W0mRXDGWnE82C75fn6peTAqobmdF3FrWmWVDCVz2TVCw8hx9Xfsm1uqwCI1hJgo7RL18YqZtm39vARw/o1DZvv/sZQAPMcfEi2s4oRdfWLbr0bO06MZK9v2ak9YqYyaf5nMN7t1pATijIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=HYjtm+UOdZ3P3F50kMt72vjRWVAP6vCVIHOYRlgb31tIT8a7K8WUgTOwtjHTwgyggRy5BAkhpq8m9fTnNULBIUF7PV8Nqll64aRT10gmPru4u/0wnXvjUcsJnypxELEmYIQJCc1TDKL2jhBKtv2ceOIlzYcv06geiG6u8mQvdHiWI5NOMUndbXoHZX8bcbxb+oAqnNNJziyoYY2GkqG7wOZ/VE/D8tCbVb/QEpVSZAlOhNNW6KRbdN8EOP3cK24T50kWSE1nK7pMZw+tyu21m0evt7u5vrGFBi5cqz5CrLGh5DmPRzjG1+lp9lcXAAlRzBGKeMJltfYNH4R+lBGwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnz7TKYYKTyGo33p2hmPXlgiheHRvP1btHDWx1JjFc=;
 b=FdJ/emT3rtwo0emhp4g0e2JLawV9qeQJT2vZtfPoH29GXQMEy6WVPh99GeffeqnGPxfcOX84AFs5Cpsfaxr9+4mSeh8qKHuEo+iUajp+Lc1WOdsJwsmPyCc4VRdiNT1wz/SUFWo9KUh1h2D1HaONv78vElkHsh1cnFVIrr/7ECXjrLWf5NbGca8SvvADZt9JLsv1KRBrvvU9w78ap3vIXakYLeu5i7njCB8X+/4TM3meKX4elRaWJiaQ8k+4KpsVTSUIMfrkQqQ0RN0Mz91Nouj525cxK942mW9iDfEgUyhr61SXOAkpdZrmfGuMNtOvAG2uafIjiw5911bfrT8Iyw==
Received: from SA9PR13CA0141.namprd13.prod.outlook.com (2603:10b6:806:27::26)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Mon, 16 Mar
 2026 17:20:10 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::b) by SA9PR13CA0141.outlook.office365.com
 (2603:10b6:806:27::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.19 via Frontend Transport; Mon,
 16 Mar 2026 17:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:20:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:19:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:19:51 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:19:47 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 5/9] dmaengine: tegra: Support address width > 39 bits
Date: Mon, 16 Mar 2026 22:48:19 +0530
Message-ID: <20260316171823.61800-6-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: a740c282-f373-446f-538c-08de8380473c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OcwvNrp8F9lFeSoGMSH4gCePcIZxWRN2tH4DdGY2uA5cbr1zP5mKQio5eiQwS0V1e7MDPsFirhkUfXdxjc1tbRoMnXlpkHBmwULH9+vif0Dq7rn2WV6BkKbWPtgbIx6yT39nIzVp+xIbNfnv8VSLO5erPzF0lfno6qHTa8HLtIq/nD1SCKXYDgO8r8CbcoS74PUob1HbxBa5wjY5nOvPJ5oHxsgxGSsVU3WAxVRp4Vg1BrvuKl1naZFLrA2P2g0FS9rKqaZwRwCADJoawI45Ot3gRTC+ejH6UIyl5eNwpiDrnCj2g72JyJ780atIq9r1m+fTYUMcVCAQWPLbBi6/RQf6kYt1JqYpDmybua5aHo1HNPHLnZ323e0HVaTpSmee6nxT/X2vwl4IVsHYcK4YTFakpmRvc/qBzWM6b4LzdStVfbLPE0B6tEnDuYHp5Jv7/MSM0/YRm1XtLV72NtOW7hcvVpOF1b2r5fcIa/mKA+Whi2iPp68aclV7tFamgc7nLHbV9IUlFlGDwFRHlWA3HJ4Dsvm8aOr9bSAWql0aOe/XwfwI0I/fQ366nZAr19Udg9b9E60z490gY7Se/UQt7nl8aDZrx9YI5cRsekJ/5XafqSi4wx78+BoZR8/bo5Yr+SLX5iDVPQ+ulopwyD1gBMWYZz967CF8SkYPVMF4/XMDhX6lnbzd2JVVbllcyGoJlIhPxWklW47mH3/ZZwBZSCXZxRmxNYEMEEGEVMwb86um/0sb46CJno9Ei9BRtnfkSJUZ54vFFy+6Rk1XcJLCHFOqp/qZp+fD812N82LUwbgJlWpbTSELbd1ImSxqXPpy
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	52hc+R3aOIKqCJ9iWSa4ib575RWNjIQckxHkLbzMl3Ay4oX9X7Wrs3LO8i96qkRTW/x0oGZyND4jODFcRW/qLp92MukcF4uo8BEHIc0CNv3aotW7b4eQEwTDErbt7PSUyuHsU7Y1TgbT/UQ2t0d0Fcqmk3bzY0oFYeoN+XupPxkr2/iRw61JoBBpFXU1eQIHKbS6hUE1khGcqQpMIxPRpdhN3/zViZeA/1x/hcmw8eew15A42idvlCRnyIJjj0DqTtPk9YXFEYs6RJB7CYyWaCRA0lV+G8LOGtkTAuKwGZv7EbpS7Jmgjr3Xlx+sSXEAFrkvNLnGdq/IUOGMjMNel8hiHWhrMw6REu8IWf8TkZr8s2L+JLe7OSwa/tegmJxbkC5AqTEO5xjMshOMVkanwsWaba8w3l6atKvJC5qS0VsEqMBFKBsYTp23LRQoDHP7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:20:10.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a740c282-f373-446f-538c-08de8380473c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9445-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E19F829E303
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


