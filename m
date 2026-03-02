Return-Path: <dmaengine+bounces-9167-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKa2MouEpWkCDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9167-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:37:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5A1D8B6A
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8243F301DD21
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72336E48B;
	Mon,  2 Mar 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmZYJIiQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30936C9D6;
	Mon,  2 Mar 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454915; cv=fail; b=Uw0YcllWtM8UTUxbYWPzeJZI1iO1YmB0tJ9+dDmhI66hKDJOBJPRX1VC2A82JozcQ+FOixhCvc7afsdfLi6V4I/KQ9dErUQIEEJ3yKmZsqiXaB6X58ynCkDXRuwzp2MaNjB6WUznuozkoZDc72pG/SRwIgiUUC7ZKlTxeIJHlEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454915; c=relaxed/simple;
	bh=q8PYb6rASiSwJZK2VGrerGkP04GJt5Y09gDHvgclZBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7rSzIKgZ9e6VscpVvPeCqR71PRyCCiXHCphZDGV4XHASdmb41nQOb7+Hu1m+HSZpyqYktHTAVDwCy9IBhDfomTcICQNQPktwEZ+8LqpW2LNl3vRsD94XxlM//yb5OKiAk5Pg4wmvPEZCO32h7wX3bf1xwk64ZeEX17+6ZSJYp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmZYJIiQ; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAe4WfES0Ka0QBiI5NYs7kN8pV02qbNJjYTXQNUE4mh7M3zAmBualQND/1jyJO+nMfgwbPZNs9j8SFE6iOAFobuoxgsV3k4znphZMTszBbu48tPDxBUHoJcAWGeHr7wJyPhvMCMGWsih/JaUZJAG5+VuLAoP/Gb+4ObJZpi15fmHFmseo0DnfZoDBjyaX5eTBQ6+oi7sjciQWu3m5CdXf8tlVGkDmYXrwfsLho1MH+2nNcwHYfiZQE2SIVgy2wjWBMKNp1TaxB50oXuefAJGFwYoPcL6Ty4v0NC5PW614kIChFqQkkkWvr+Ho7bdEKOog5QfMWPYcEWX7/omIM6PcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08a9r84abdPcnaYDSOD10Y/161r2VocJaQq85iW63sQ=;
 b=HOylNXKCaJmvUTyV2LmLrKalJuL4ghQsjgIP//19y9detzlwHmuaoevb0loULQfNjT0ZWStXnqhDFpMD0ZmmsemRbNXSCz8I4fWTrU7btrQrNQn1srknD4EDbS1g3MG+nKrqwwsUpPjvbFkfIDCcWBs5Zb9l093/sOxB7DKlnos1ixjMvmJoimpz4vTTxD6z1Gf6u2tV9p87KoCDgCTtp6j3cMBMZYmuFvx7Yrhc5RrWYl9IMCY+BCo5elcgaXIME+sA3O3brl1MIXvZOP+dMGyjxv4XQdFRcZaD69+X6G/PMpDS9M79KkhvUujDt8xdoQP/2k+CYK8I6+cm0Y/pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08a9r84abdPcnaYDSOD10Y/161r2VocJaQq85iW63sQ=;
 b=DmZYJIiQZXvQyZflhygtook0MJgXECSSq5q+lLQkEI6Pbp7gBbhYy0bI/Z8HxKFJpkV7QSWTAje0jIcsMfVVB7MNs32yLjgtuF9CNsAo6QNC8GYkceNEeW0KjMfKc//w7/1DSSLMy694bDVk+l0Py9+LgLTWg6tR0EVVaqTjQg4qYTSw4ZsnplGXQ0dEqonmxsJb76D93xXfV6XyEAjKf1XmGlZm4c6D4OYApizrLOxz/eXW43J8rBTzrDWxhQ1N4a4foPZwtfaPnJHCChfaA8GI/PRHe7b7VW0mDlMUKawo1m3Vd43BNwZMJRLWnLhdzjPjf8SqAIfa5mNBSMYOzw==
Received: from CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:35:06 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::9e) by CH0PR03CA0258.outlook.office365.com
 (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 12:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:35:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:52 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:34:47 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 4/9] dmaengine: tegra: Use struct for register offsets
Date: Mon, 2 Mar 2026 18:02:34 +0530
Message-ID: <20260302123239.68441-5-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a9dc0a-cca4-49a0-2f69-08de78582225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	/0l3oRjwq2tUWcACGFrXyDvgFqEZ1R52aHDv9YZQ0VawHq2uukJni7UfccRYEv7C1ABRkmAcnTOx+DOg+bX77vyrIJ35I/GJ/BrknSte3DQKg2Zv2mOyK2qimCH0fXxjkPRpjk+pZQEFT4uTKSqWbDwVY4faFBYhMl5aVp5LEWtr6h9+NeOWNsHt2kLVcS2DvYLi9e6Z87l4ImiA/4RboL9FA8SHuR4tYGgoIIW29u5Siwx9D4wSEyhEZTd1InxXd5gcub2o7fWHEhKv886SXGPpf8heuqMSOzGu2E8HB3ynbVXq5Swz4ENlmq8B1jEj275W004JzLchVsosw0/bo/+BhzowqMwHUeAepHMJKIrEgZltZYDDKsnnLDcaRobyRsndFauGBLnZ1EmPOIlp/0YBYeNpQyJ6IrBMRD9JoQ65Tf1Y9Q27p/A7zPA+VsEFMwG4T3aVWxp1pToCdfEBFI1ctj4+lt/0vngi9TS0g/6SbL+jDGZPglcQxbpu2W29z+L43uWqVijC8zZ83y2eBuwHunYclTxScjnmf+mHoX1melx/o2hDb6/iaEn6aQNkyvguBBSSfAhYP92DRon4RC8W7TuOsLi+hP9TZwnyf+w7FvovvVlSIJpuzr1byu9urUbfx7dsMzhVznMgHHDdPnP/Y7aj5PEkHcEhY81ptx0CZKLUOHQmFLh5fWM0k6iz1bEa4EuCG3jcF3HX84ackOBypVa/DFpLaY1Nsw+imS1alT6uoTWPz5K9RIcm4wTF7OhaNN07CYm6pVjHsJFx8WhlEWRLDz1Ey+EYioDcEPZT/JeLAtcbhg2mY/nfYAJ3xIYXPKWP+G2F7GjXL3SERmoFgIqR5076DXfymIFB4UY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6fR5LOXVvMp2k4ZtjFDU/FPv+BaZl0X5LB0N7y+cLr9BNJlYdjUle5pIRfHZTuhg4TY3+/vrvXX065GnjpRCREL2vP+ap/xWXFfYnnxYHb3G9ZnURrxzzqAmzmR7xjHDcRDihFI2nwLLe0Ipnkugpof/I5ecrYxqeGwzbIEqh46T/XaqrFTeJhL/tHlgHcYmX8bpY1aFut2i4LJ32NX/lIzLuAFjOBmNITdXyI2hnqu5XEe5Q+L4B+Gpm7tJru+1SlzPSq53HZu9I2d0Q82BD4k+icRrjfROKh3SA67clRjmr4DUP8QiMQ0rCGwoWxJ3ZdRDZ4iL0Ih8HgWqctY4UkzGZhlUgVgJqNJpbfNSuQLUS2n0/SWUnlTVzxqTCCgd9RFY6aJz2AslvKZ/9JPrirO3dp6GIYikIrXLbT71VFzz7OfqMaqEoh/Zu4MVWF5m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:35:05.6999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a9dc0a-cca4-49a0-2f69-08de78582225
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9167-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 04A5A1D8B6A
X-Rspamd-Action: no action

Repurpose the struct tegra_dma_channel_regs to define offsets for all the
channel registers. Previously, the struct only held the register values
for each transfer and was wrapped within tegra_dma_sg_req. Move the
values directly into tegra_dma_sg_req and use channel_regs for
storing the register offsets. Update all register reads/writes to use
the struct channel_regs. This prepares for the register offset change
in Tegra264.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 281 +++++++++++++++++----------------
 1 file changed, 146 insertions(+), 135 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 09a1717aa808..09ba2755c06d 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -22,7 +22,6 @@
 #include "virt-dma.h"
 
 /* CSR register */
-#define TEGRA_GPCDMA_CHAN_CSR			0x00
 #define TEGRA_GPCDMA_CSR_ENB			BIT(31)
 #define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
 #define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
@@ -58,7 +57,6 @@
 #define TEGRA_GPCDMA_CSR_WEIGHT			GENMASK(13, 10)
 
 /* STATUS register */
-#define TEGRA_GPCDMA_CHAN_STATUS		0x004
 #define TEGRA_GPCDMA_STATUS_BUSY		BIT(31)
 #define TEGRA_GPCDMA_STATUS_ISE_EOC		BIT(30)
 #define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
@@ -70,22 +68,13 @@
 #define TEGRA_GPCDMA_STATUS_IRQ_STA		BIT(21)
 #define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
 
-#define TEGRA_GPCDMA_CHAN_CSRE			0x008
 #define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
 
-/* Source address */
-#define TEGRA_GPCDMA_CHAN_SRC_PTR		0x00C
-
-/* Destination address */
-#define TEGRA_GPCDMA_CHAN_DST_PTR		0x010
-
 /* High address pointer */
-#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
 #define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
 #define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
 
 /* MC sequence register */
-#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
 #define TEGRA_GPCDMA_MCSEQ_DATA_SWAP		BIT(31)
 #define TEGRA_GPCDMA_MCSEQ_REQ_COUNT		GENMASK(30, 25)
 #define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
@@ -101,7 +90,6 @@
 #define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK	GENMASK(6, 0)
 
 /* MMIO sequence register */
-#define TEGRA_GPCDMA_CHAN_MMIOSEQ			0x01c
 #define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
 #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH		GENMASK(30, 28)
 #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	\
@@ -120,17 +108,7 @@
 #define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD		GENMASK(18, 16)
 #define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT		GENMASK(8, 7)
 
-/* Channel WCOUNT */
-#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
-
-/* Transfer count */
-#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
-
-/* DMA byte count status */
-#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
-
 /* Error Status Register */
-#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	8
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	0xF
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
@@ -143,14 +121,9 @@
 #define TEGRA_DMA_MC_SLAVE_ERR			0xB
 #define TEGRA_DMA_MMIO_SLAVE_ERR		0xA
 
-/* Fixed Pattern */
-#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
-
-#define TEGRA_GPCDMA_CHAN_TZ			0x38
 #define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
 #define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
 
-#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
 #define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
 
 /*
@@ -181,19 +154,27 @@ struct tegra_dma_chip_data {
 	unsigned int nr_channels;
 	unsigned int channel_reg_size;
 	unsigned int max_dma_count;
+	const struct tegra_dma_channel_regs *channel_regs;
 	int (*terminate)(struct tegra_dma_channel *tdc);
 };
 
 /* DMA channel registers */
 struct tegra_dma_channel_regs {
 	u32 csr;
-	u32 src_ptr;
-	u32 dst_ptr;
-	u32 high_addr_ptr;
+	u32 status;
+	u32 csre;
+	u32 src;
+	u32 dst;
+	u32 high_addr;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
+	u32 wxfer;
+	u32 wstatus;
+	u32 err_status;
 	u32 fixed_pattern;
+	u32 tz;
+	u32 spare;
 };
 
 /*
@@ -205,7 +186,14 @@ struct tegra_dma_channel_regs {
  */
 struct tegra_dma_sg_req {
 	unsigned int len;
-	struct tegra_dma_channel_regs ch_regs;
+	u32 csr;
+	u32 src;
+	u32 dst;
+	u32 high_addr;
+	u32 mc_seq;
+	u32 mmio_seq;
+	u32 wcount;
+	u32 fixed_pattern;
 };
 
 /*
@@ -228,19 +216,20 @@ struct tegra_dma_desc {
  * tegra_dma_channel: Channel specific information
  */
 struct tegra_dma_channel {
-	bool config_init;
-	char name[30];
-	enum dma_transfer_direction sid_dir;
-	enum dma_status status;
-	int id;
-	int irq;
-	int slave_id;
+	const struct tegra_dma_channel_regs *regs;
 	struct tegra_dma *tdma;
 	struct virt_dma_chan vc;
 	struct tegra_dma_desc *dma_desc;
 	struct dma_slave_config dma_sconfig;
+	enum dma_transfer_direction sid_dir;
+	enum dma_status status;
 	unsigned int stream_id;
 	unsigned long chan_base_offset;
+	bool config_init;
+	char name[30];
+	int id;
+	int irq;
+	int slave_id;
 };
 
 /*
@@ -288,22 +277,22 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 {
 	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
 		tdc->id, tdc->name);
-	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x SRC %x DST %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
-	);
-	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
-	);
+	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x\n",
+		tdc_read(tdc, tdc->regs->csr),
+		tdc_read(tdc, tdc->regs->status),
+		tdc_read(tdc, tdc->regs->csre));
+	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
+		tdc_read(tdc, tdc->regs->src),
+		tdc_read(tdc, tdc->regs->dst),
+		tdc_read(tdc, tdc->regs->high_addr));
+	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
+		tdc_read(tdc, tdc->regs->mc_seq),
+		tdc_read(tdc, tdc->regs->mmio_seq),
+		tdc_read(tdc, tdc->regs->wcount),
+		tdc_read(tdc, tdc->regs->wxfer),
+		tdc_read(tdc, tdc->regs->wstatus));
 	dev_dbg(tdc2dev(tdc), "DMA ERR_STA %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
+		tdc_read(tdc, tdc->regs->err_status));
 }
 
 static int tegra_dma_sid_reserve(struct tegra_dma_channel *tdc,
@@ -377,13 +366,13 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
 	int ret;
 	u32 val;
 
-	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val = tdc_read(tdc, tdc->regs->csre);
 	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+	tdc_write(tdc, tdc->regs->csre, val);
 
 	/* Wait until busy bit is de-asserted */
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
-			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			tdc->chan_base_offset + tdc->regs->status,
 			val,
 			!(val & TEGRA_GPCDMA_STATUS_BUSY),
 			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
@@ -419,9 +408,9 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
 {
 	u32 val;
 
-	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val = tdc_read(tdc, tdc->regs->csre);
 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+	tdc_write(tdc, tdc->regs->csre, val);
 
 	tdc->status = DMA_IN_PROGRESS;
 }
@@ -456,27 +445,27 @@ static void tegra_dma_disable(struct tegra_dma_channel *tdc)
 {
 	u32 csr, status;
 
-	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+	csr = tdc_read(tdc, tdc->regs->csr);
 
 	/* Disable interrupts */
 	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
 
 	/* Disable DMA */
 	csr &= ~TEGRA_GPCDMA_CSR_ENB;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+	tdc_write(tdc, tdc->regs->csr, csr);
 
 	/* Clear interrupt status if it is there */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
 		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
-		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
+		tdc_write(tdc, tdc->regs->status, status);
 	}
 }
 
 static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
-	struct tegra_dma_channel_regs *ch_regs;
+	struct tegra_dma_sg_req *sg_req;
 	int ret;
 	u32 val;
 
@@ -488,29 +477,29 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 
 	/* Configure next transfer immediately after DMA is busy */
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
-			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			tdc->chan_base_offset + tdc->regs->status,
 			val,
 			(val & TEGRA_GPCDMA_STATUS_BUSY), 0,
 			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
 	if (ret)
 		return;
 
-	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
+	tdc_write(tdc, tdc->regs->src, sg_req->src);
+	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
+	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
 
 	/* Start DMA */
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
-		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+	tdc_write(tdc, tdc->regs->csr,
+		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
 }
 
 static void tegra_dma_start(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
-	struct tegra_dma_channel_regs *ch_regs;
+	struct tegra_dma_sg_req *sg_req;
 	struct virt_dma_desc *vdesc;
 
 	if (!dma_desc) {
@@ -526,21 +515,21 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
 		tegra_dma_resume(tdc);
 	}
 
-	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
+	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
+	tdc_write(tdc, tdc->regs->csr, 0);
+	tdc_write(tdc, tdc->regs->src, sg_req->src);
+	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
+	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
+	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
+	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
+	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
+	tdc_write(tdc, tdc->regs->csr, sg_req->csr);
 
 	/* Start DMA */
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
-		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+	tdc_write(tdc, tdc->regs->csr,
+		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
 }
 
 static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
@@ -601,19 +590,19 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
 	u32 status;
 
 	/* Check channel error status register */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
+	status = tdc_read(tdc, tdc->regs->err_status);
 	if (status) {
 		tegra_dma_chan_decode_error(tdc, status);
 		tegra_dma_dump_chan_regs(tdc);
-		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
+		tdc_write(tdc, tdc->regs->err_status, 0xFFFFFFFF);
 	}
 
 	spin_lock(&tdc->vc.lock);
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
 		goto irq_done;
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
+	tdc_write(tdc, tdc->regs->status,
 		  TEGRA_GPCDMA_STATUS_ISE_EOC);
 
 	if (!dma_desc)
@@ -673,10 +662,10 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
 	 * to stop DMA engine from starting any more bursts for
 	 * the given client and wait for in flight bursts to complete
 	 */
-	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+	csr = tdc_read(tdc, tdc->regs->csr);
 	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
 	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+	tdc_write(tdc, tdc->regs->csr, csr);
 
 	/* Wait for in flight data transfer to finish */
 	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
@@ -687,7 +676,7 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
 
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
 				tdc->chan_base_offset +
-				TEGRA_GPCDMA_CHAN_STATUS,
+				tdc->regs->status,
 				status,
 				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
 				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
@@ -739,14 +728,14 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
 	unsigned int bytes_xfer, residual;
 	u32 wcount = 0, status;
 
-	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	wcount = tdc_read(tdc, tdc->regs->wxfer);
 
 	/*
 	 * Set wcount = 0 if EOC bit is set. The transfer would have
 	 * already completed and the CHAN_XFER_COUNT could have updated
 	 * for the next transfer, specifically in case of cyclic transfers.
 	 */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC)
 		wcount = 0;
 
@@ -893,7 +882,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -916,16 +905,16 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].ch_regs.src_ptr = 0;
-	sg_req[0].ch_regs.dst_ptr = dest;
-	sg_req[0].ch_regs.high_addr_ptr =
+	sg_req[0].src = 0;
+	sg_req[0].dst = dest;
+	sg_req[0].high_addr =
 			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
-	sg_req[0].ch_regs.fixed_pattern = value;
+	sg_req[0].fixed_pattern = value;
 	/* Word count reg takes value as (N +1) words */
-	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
-	sg_req[0].ch_regs.csr = csr;
-	sg_req[0].ch_regs.mmio_seq = 0;
-	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].wcount = ((len - 4) >> 2);
+	sg_req[0].csr = csr;
+	sg_req[0].mmio_seq = 0;
+	sg_req[0].mc_seq = mc_seq;
 	sg_req[0].len = len;
 
 	dma_desc->cyclic = false;
@@ -961,7 +950,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
 		  (TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -985,17 +974,17 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].ch_regs.src_ptr = src;
-	sg_req[0].ch_regs.dst_ptr = dest;
-	sg_req[0].ch_regs.high_addr_ptr =
+	sg_req[0].src = src;
+	sg_req[0].dst = dest;
+	sg_req[0].high_addr =
 		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
-	sg_req[0].ch_regs.high_addr_ptr |=
+	sg_req[0].high_addr |=
 		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
 	/* Word count reg takes value as (N +1) words */
-	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
-	sg_req[0].ch_regs.csr = csr;
-	sg_req[0].ch_regs.mmio_seq = 0;
-	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].wcount = ((len - 4) >> 2);
+	sg_req[0].csr = csr;
+	sg_req[0].mmio_seq = 0;
+	sg_req[0].mc_seq = mc_seq;
 	sg_req[0].len = len;
 
 	dma_desc->cyclic = false;
@@ -1049,7 +1038,7 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	if (flags & DMA_PREP_INTERRUPT)
 		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1096,14 +1085,14 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		dma_desc->bytes_req += len;
 
 		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].ch_regs.src_ptr = mem;
-			sg_req[i].ch_regs.dst_ptr = apb_ptr;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = mem;
+			sg_req[i].dst = apb_ptr;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].ch_regs.src_ptr = apb_ptr;
-			sg_req[i].ch_regs.dst_ptr = mem;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = apb_ptr;
+			sg_req[i].dst = mem;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 
@@ -1111,10 +1100,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		 * Word count register takes input in words. Writing a value
 		 * of N into word count register means a req of (N+1) words.
 		 */
-		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
-		sg_req[i].ch_regs.csr = csr;
-		sg_req[i].ch_regs.mmio_seq = mmio_seq;
-		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].wcount = ((len - 4) >> 2);
+		sg_req[i].csr = csr;
+		sg_req[i].mmio_seq = mmio_seq;
+		sg_req[i].mc_seq = mc_seq;
 		sg_req[i].len = len;
 	}
 
@@ -1186,7 +1175,7 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 
 	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1218,24 +1207,24 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 	for (i = 0; i < period_count; i++) {
 		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
 		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].ch_regs.src_ptr = mem;
-			sg_req[i].ch_regs.dst_ptr = apb_ptr;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = mem;
+			sg_req[i].dst = apb_ptr;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].ch_regs.src_ptr = apb_ptr;
-			sg_req[i].ch_regs.dst_ptr = mem;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = apb_ptr;
+			sg_req[i].dst = mem;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 		/*
 		 * Word count register takes input in words. Writing a value
 		 * of N into word count register means a req of (N+1) words.
 		 */
-		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
-		sg_req[i].ch_regs.csr = csr;
-		sg_req[i].ch_regs.mmio_seq = mmio_seq;
-		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].wcount = ((len - 4) >> 2);
+		sg_req[i].csr = csr;
+		sg_req[i].mmio_seq = mmio_seq;
+		sg_req[i].mc_seq = mc_seq;
 		sg_req[i].len = len;
 
 		mem += len;
@@ -1305,11 +1294,30 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.high_addr = 0x14,
+	.mc_seq = 0x18,
+	.mmio_seq = 0x1c,
+	.wcount = 0x20,
+	.wxfer = 0x24,
+	.wstatus = 0x28,
+	.err_status = 0x30,
+	.fixed_pattern = 0x34,
+	.tz = 0x38,
+	.spare = 0x40,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_stop_client,
 };
 
@@ -1318,6 +1326,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause,
 };
 
@@ -1326,6 +1335,7 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause_noerr,
 };
 
@@ -1346,7 +1356,7 @@ MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
 
 static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 {
-	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	unsigned int reg_val =  tdc_read(tdc, tdc->regs->mc_seq);
 
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -1354,7 +1364,7 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
+	tdc_write(tdc, tdc->regs->mc_seq, reg_val);
 	return 0;
 }
 
@@ -1420,6 +1430,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
 					i * cdata->channel_reg_size;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
+		tdc->regs = cdata->channel_regs;
 		tdc->tdma = tdma;
 		tdc->id = i;
 		tdc->slave_id = -1;
-- 
2.50.1


