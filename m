Return-Path: <dmaengine+bounces-9670-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFziNEgVxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9670-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:15:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08933439B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 363B130958D1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A273DCD98;
	Thu, 26 Mar 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+MsYTac"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5B3DC4DC;
	Thu, 26 Mar 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523499; cv=fail; b=G5HBGT2v8EyxP3Cb/FOuwoqX5XQ7DHH2t1ZDA/0L8zjW1/JXtp+X28UB28WtJU12U+h55mm4t2od9wViB29GrLm7fIGPonlZmFt8sf79EhaMdLxn/34SS3Fv+QTDX33aXfO4um7///a67wuxVWD34ESzrTzcIwvqwiJfVDZV8XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523499; c=relaxed/simple;
	bh=JYTlyNhUv4vTBGck67zbdcRECNh1OxgvWj9elxg2QHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgFs2ol4DHluCmhXz8XNRcR8IbJqSG0dIFMKVbM404LkmC3UMg1lUG8QtBdszd9Pb7BeQ+3300Khj0HGHav/RCECDeOC886EwA22/bqL31EIy1oGks40iXkltSJWGSEf6IuMZrDDVEzPtMT+E7FmL+v6mcKjDVeitZ7Yg2qesHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+MsYTac; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEJGVPQuduwX11VGwTGY2NI7DAZR7/7pKZPNvi3+077sC7NDmbRdcRYP1znJgExdOCWpRuAvKIh1mz3eMaw/aD/RKEeoN+AIEphIFZ3K/puF/kvft8LACZWooFYNrOeVFCBB64QpCtpfuwPgfps7FTmjQrMjIB8qbzd28yBuJH2/34ufjkAkTe3/ncAHdhpSkrJSji3X8yd+/ldClLAEkqdK0PVw8fLAtAYKLkwdEjEfOJmBCRHbP15n/VsxWenaWoHtI7RsudE2Z6PT4sUIakB20l/0fz1Vvo1Lz9vDze/Omt75YwxTOlqRkffRrQJS8O5WH77IrdE6/tCm6vJRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSfzwSDdJu+HGJQknoI/vRE0SzfoPnO8Gbka8zaRvEk=;
 b=ri8/wfPy4zJM6178dbEmMP5XIaVlDXwhx1qlLrGtM5FsjgJYAKJ4nb4f67XAAhvpaDXnNIF0jvl1cj5WubTsGdN348ZTCcWO/zZprXPtJ/xtZ7ZSnXfgIp7YkDoBiNVRKMHmdnGIf5R3OFJDTVoNnZIsLcOmE1AgEorLs48/kFeQTcWTmVfatDFPkJ+XrbRMpoYI0uGtsq4pLXYXkP4mBmNEsfCVxBcT/v8B+YgTTY1DxtiWfzG1KHwe1CHtFETk3+GZknPr+YKCJDBi3obmVvzqbM7injk0BxDBFZ85eaOUWFRUGBysFNUJY7OCqecq6GriLf79oAjpj3HMsYcJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSfzwSDdJu+HGJQknoI/vRE0SzfoPnO8Gbka8zaRvEk=;
 b=k+MsYTacKgGfhEYDumsmoAkt34zSEMrD31RBHXXVAiyG6V6E71ifnehkYunDOy2Pyd4Mp/BBcmT5smA7Vx4nFsVkWCej3H8GphPmFdmtf2Kt9ZT76CmH1Dd4evOvLTuHGKpuyoRVh2LsMzry6TLjUQcDK0cwatLZuAc8yfVoDZIEtnpskK4IFCMeGJLItd5dbd3YeraBC07xa78zUT6IZCB5A5kx9HTQADo4gjkQdWB64o58n8HODZvlteCbZ2k1PEthIx4dApVUjf3qPFQ4jCJ6+CwyDmI59Tlulgvgl6c+QtsjX/llJuHqG0RBmnqmXwnT6zCXkvx8s9wJc+s1SQ==
Received: from DM6PR05CA0040.namprd05.prod.outlook.com (2603:10b6:5:335::9) by
 SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:11:33 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::cc) by DM6PR05CA0040.outlook.office365.com
 (2603:10b6:5:335::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Thu,
 26 Mar 2026 11:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:11:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:11:29 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:11:25 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 09/10] dmaengine: tegra: Add Tegra264 support
Date: Thu, 26 Mar 2026 16:39:46 +0530
Message-ID: <20260326110948.68908-10-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: e916922c-8def-4572-eab1-08de8b287004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kgDSRsZ4wU78gBj9gWXyqT1nD4ahf2PdMqQhkP8acVsgpI02yl1/BP9EzysavgFDBeDxZxDT5fkZqfEaJaP5F1haC7JcHrWeRJxFzyxd4EtD0Ej6RBMQLD9wb9z05yvVbBDJnmwCuKDG/N+ghfes0jjyATYqV2pxR0RhSj+8g2ApHdRPT6/A2yJ/CrqFJE32vywKfT90dgJ03x5PtVqOl7jVa3e5eWE4egyTTGMa+dE5XtRRR7Mz/9vyQVBh2mGrpa+PA1WhbvCCYIpfB6b004POLHUNGVb1oVp3gSlpfh/vPxHJC2T1xbiGQAJXmsGSUCdnGr3Wav7s/Zg0OOUixD/yB3kPvh0GFvWAe6QuOlOEhMI1o9+MeOY4zvtzwDusc2SLMpxRXhFkofeyR1StFuT6S2IC+NzMvMtcy2e7GipRK3tpa/9izsgPkVxc20MhRRSRKk/UHZv2cIVIQWUTZI6P0zQwYeplzpLLqSCinSPBxrFMu2tapCJ5r1NGnVlAQir0JXd/Oi7QEQ/TEQOGpgiBbY7/CTiwOdKBgQYHRbw0k/zqlUOUJKevNWCTYNOpMT0ZfRguqFH+yTMMXcj44GUUnIYVx+EHm1fBEahNze0jTGY4CEbg8scmX3U9eo+tsKh+FKg+SKbHr9lzyS2U5QSd0hUF0GVf+HZDEgPD585AbWDSiBkiqhkqHXFzxHTibFtnLD+OGITGZPNDtXnlSzqrlTDoKSTT3gijxDQawt9E0HLONGqYmCiqr98v2cfTUpiEnIi5P3M6H7Gn97tMVmP3KgxwOniBqYu1lHSKdVmz+jSOmFteVeeymRUyYnQh
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S5ITpCWUcmGjVfF+DiFFBf9VnRIhsdn9iuKIHD0T3V17v4LLMWmbO3s6m5p/GpD8N3Nku1hohScN92V6ug6b0wjossF4iyN7IyHaBkP6hCatY22N20uw6QZr4Q38nQ/GhzZ/ArzetBioWH60no0J0gvLJlfBByHS86mP/zOFwVeTbPOF2z4n64VWg2nUN449V7bM32zXBIB4goC2F6cpWJeUfE6EmAcKpBXpezHgbCuGVNGRQv+c8iJCRE6vgtJxc1QYJK3yV/danQgC9K2I+ycMXs+FL69st6jX6r7Uvwd4HE+YauCuskJiHhsKtEAU1P8IqPq4hSVyhAYnqeUmlDpvaE+aI+6tEakDUl3Ey0/dkbosOfhUN+Oyl5nqhfGdilTPkJLcfnSSCfHXWthIW32dbfmaOhfa8KB2JeSsgVU/PTw/kDOtgmLiFen27PmC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:32.6685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e916922c-8def-4572-eab1-08de8b287004
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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
	TAGGED_FROM(0.00)[bounces-9670-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BE08933439B
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
index 3b377f34be58..c2f32604e7fb 100644
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


