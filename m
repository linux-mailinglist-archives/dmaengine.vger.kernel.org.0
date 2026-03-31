Return-Path: <dmaengine+bounces-9764-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPunJomhy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9764-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:27:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA7367EC5
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3790E303010A
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697E3EDAD4;
	Tue, 31 Mar 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGGBYbRm"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46653ED5A2;
	Tue, 31 Mar 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952674; cv=fail; b=WNmTt/37bHZdEcDMWex7miLeCaaP2Z1oVaWZt83vm8mm/GSmsGK15M5PxvyI+2dVMSu2aaazjMOGMDZGozBUia9rRDyfvEuMR63eGTf8f/0I4RItUkAA7ej8EWKD6WfBNEE/KtsiKLlFI5eHsXk0Wi0HCgFoTG8uv6Xl5jJMDEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952674; c=relaxed/simple;
	bh=B7XblN7s9HPvksPjnk+M4nT3M3Kif8DJwQoywMQ3JBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmsGbmbSbss/E9jJcBm65c+A3SwD3yAxuA5PZH+DlG5pYpAZJheJeivzYSUh+m4ykBmxgjPvVWj4phNabWLXzbjzAoL9F1lTBBR4UxOYpmyWTBJuq+u+yPcT5wZ982qQjKEGadpZ/jo/iC7IrRz8lI4nd8OF12pTwo7sN/0GW1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rGGBYbRm; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc0W+pvop6uz1h4TQjOhgEiuO60DJetMlGpSO6HOgWoauGD2JAUFRzhPExpBwvrAQsN7V9I69M1LKJNlhwEu3I0ft2xUTxsGK8Y7NPovmInr8NvA1aOPTRrrwxaPYPsOzbAlBJ5jZIZcS0A5y26cfrN4yGUdZRrKLY2sRkyBT03RowEr5pG1r9XKd3yind8vRY3pTsbFVifIeNCHfoPyn9zErF9sPHQgTBOCuCZumE+ae1CSbFDVJFP462B8u33mSlwp9s9tXt1fB1vxhBEi69blnRWrVp1pDYutgcJKiX7utsJJu4BQuvtiuOCFd4CEte6M+JxF17ov+/7jTlJzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcgqoLz13KFmKN3mR2UjKBEjCv+/Rw+s2cWv2ER+IHo=;
 b=PgSHxTpCsn082C2dmGD+WAAxHRY/N8eGOTQeGJjQhzOvvg8JACyEkIAV2P6PhCpRGFWoVhiw5Y3raySh6vQWL0RDLzCIlm5ZI0Xg0p6SCTIVV0fjrHgYhTINMTh33HLAbZK4EzPvvtHKoqlAbWZVrfae7IdkplVKFNw1j2EPCh5qdD0wR3zzTSHDTH2E1YaDldgXjrrbBIHU+o6NLg5Omafd9Tp7hnYKd1rTVX4f3nYA2AkSf4l2qf4QM75cbzkVdJB8DoC+5FYCyA2bhGk1+duArnxUC6ZHStIuzxGB3wb+h9bPT0XbFhs0SmOHFcjZ2njOfil/657RyZA/W7+v3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcgqoLz13KFmKN3mR2UjKBEjCv+/Rw+s2cWv2ER+IHo=;
 b=rGGBYbRm8TIgF+NHc1IMcFt2bWy9nqpOGcRjymIlNy/93xuJZjd92HHwqZoSzvP6v0BtakFfRta8RVYT4wsa3HZc72ytETvfpvAuo2GLJWLY+7Nf+qzarswC1c3d/QmMesFKidtje3S9xA13CsuIWzL0lNLUnDO2sQEtTIPCb7YQIldyQPCFioPr8lPGjcFaA3Q9WkGcyIPgzrdeeeI1K5UEtHPrOS/wlTlB3gAi+K0T7RpiNVteg7Y6DBTp+VKusA4WWjLjjWXJr/zYetgfs82B+v40KOhtqR3Ux6CEZfInbsZtuX5bSvW5KHI2BZsn/ytTSyZnYg9xJYXAUIhEvg==
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:24:23 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::14) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:24:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:24:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:24:13 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:24:10 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 05/10] dmaengine: tegra: Use struct for register offsets
Date: Tue, 31 Mar 2026 15:52:58 +0530
Message-ID: <20260331102303.33181-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260331102303.33181-1-akhilrajeev@nvidia.com>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5217f4-7a7b-4bf3-db7f-08de8f0fadb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	azFx7m4Wff2074RH6i+xHS+z2RqITyenk9y316eflXx63MFbeFVOwn+z+dlA3sbBStZfTPRYhI54M3i37ET2y0rCM7Aee5Ma+tQ+NOV8vRCo7hDO/qS6UQDul5XoM6XmY+k6D2DUhDMrZhgBnoELZlWXpMDaPm70A5C+ku5Y6Z6LrYpUMCfEGdH5hkg8n3/r2ulrejH54D+SvpuACn9zIraRzUw959QLl2ptXQU6oVe9iTX6/Ti6M7GWz+fLrcNdAq0R9tPDNIyEnGRgMZtmrRR8jU9AqGyqDbokaT7t7n4LcVQwq7ld2CZouavdvdhClcqIy+5LQT5REGbqDjoCBL2Ct/ZDKvWx1ZpO85SsE4K4SfonBiXPTt3nqzNwIwQj9rcZ63L6VOYkKVKwJIz9ZustcQW4f7V5fTjRFaLi0EwIsXZR/y8ODb79M/aSl9OV1lM/UZ8Va9YLlMXTm9OXh36jLle0uL8D5or8L3INrdWe3c6cOeTY2DJVAqYAH1JYLtBs6J+7FQow6joHNL2AL5ixhrpWKkSvaFPCvrKQ/uVY5d7baYZcwHf9FWUmo6A4VhGT1hgLQWstErzGnDuWXj85kc9mGkYJSS2/eS55QYhkm1O8mmfvhjGGNW1QoAKozBwjbqbsrgw9uRHCjIcihTU/PxugCxLMW+qhWz3n7oro8WvAC6+U3yl5wBRaWjupPmunorYoLDCWHCX4DxL6FEnJW76hXUZLAL/VHk2N6qECZj6OmQLhkCQaHb41Q/h+8v4m8cjKHRIWJ74HgW/amVoHz0XlZaBi8Mout6QNjTJAo39qh8aJvliSkea23fYA
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f7mMzWI8nD2jIo0CizCX5m4x7skiajfd3lHX5UnOpb3FyU7CL/ZcM/PZ3zbe1c5N/abiVbM5YF1sb5TgLa5rqN0rKH9mLwrwukLSPfrl75j0O/8rQn7Po5Nw+gtVoSYlZTtqIVQPw92qCQGrNSDVFaYaju8E0bZYSb7LpsYvK8ZkvY3FfHqLqtLBPqQXynN7VVWKv6PZMMJXtLDCgX9YRjWcHh0sQNtMF5H7r15G8zEvzpBn7mtdWXpx3EIoLqFAmR1n0J6Jp8JR+jEC1UZZCxcs7on82u9SaVKK/izuxGaV53bnUY+HPJAGM3xcs6sCODBhW+o3NDNSWF3Dq1UYswiv64wAxR01bWcOB5Tfp1SqD6Eh9j8/U/nreBtzFynp1c9a9mCtnwY5xIy6yXWxfraLcKvwKoisJEucOnZXuXt/cIuVr1cAAaNR1a9KscuC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:24:23.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5217f4-7a7b-4bf3-db7f-08de8f0fadb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9764-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7BBA7367EC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/dma/tegra186-gpc-dma.c | 282 +++++++++++++++++----------------
 1 file changed, 142 insertions(+), 140 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index a0522a992ebc..b213c4ae07d2 100644
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
@@ -143,16 +121,6 @@
 #define TEGRA_DMA_MC_SLAVE_ERR			0xB
 #define TEGRA_DMA_MMIO_SLAVE_ERR		0xA
 
-/* Fixed Pattern */
-#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
-
-#define TEGRA_GPCDMA_CHAN_TZ			0x38
-#define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
-#define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
-
-#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
-#define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
-
 /*
  * If any burst is in flight and DMA paused then this is the time to complete
  * on-flight burst and update DMA status register.
@@ -181,18 +149,24 @@ struct tegra_dma_chip_data {
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
 };
 
@@ -205,7 +179,14 @@ struct tegra_dma_channel_regs {
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
@@ -228,19 +209,20 @@ struct tegra_dma_desc {
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
@@ -288,22 +270,22 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
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
@@ -377,13 +359,13 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
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
@@ -419,9 +401,9 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
 {
 	u32 val;
 
-	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val = tdc_read(tdc, tdc->regs->csre);
 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+	tdc_write(tdc, tdc->regs->csre, val);
 
 	tdc->status = DMA_IN_PROGRESS;
 }
@@ -456,27 +438,27 @@ static void tegra_dma_disable(struct tegra_dma_channel *tdc)
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
 
@@ -488,29 +470,29 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 
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
@@ -526,21 +508,21 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
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
@@ -601,19 +583,19 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
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
@@ -673,10 +655,10 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
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
@@ -687,7 +669,7 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
 
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
 				tdc->chan_base_offset +
-				TEGRA_GPCDMA_CHAN_STATUS,
+				tdc->regs->status,
 				status,
 				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
 				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
@@ -739,14 +721,14 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
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
 
@@ -893,7 +875,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -916,16 +898,16 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
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
@@ -961,7 +943,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
 		  (TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -985,17 +967,17 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
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
@@ -1049,7 +1031,7 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	if (flags & DMA_PREP_INTERRUPT)
 		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1096,14 +1078,14 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
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
 
@@ -1111,10 +1093,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
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
 
@@ -1186,7 +1168,7 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 
 	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1217,24 +1199,24 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
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
@@ -1304,11 +1286,28 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
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
 
@@ -1317,6 +1316,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause,
 };
 
@@ -1325,6 +1325,7 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause_noerr,
 };
 
@@ -1345,7 +1346,7 @@ MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
 
 static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 {
-	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	unsigned int reg_val =  tdc_read(tdc, tdc->regs->mc_seq);
 
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -1353,7 +1354,7 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
+	tdc_write(tdc, tdc->regs->mc_seq, reg_val);
 	return 0;
 }
 
@@ -1419,6 +1420,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
 					i * cdata->channel_reg_size;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
+		tdc->regs = cdata->channel_regs;
 		tdc->tdma = tdma;
 		tdc->id = i;
 		tdc->slave_id = -1;
-- 
2.50.1


