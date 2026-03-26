Return-Path: <dmaengine+bounces-9664-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHMfG4gUxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9664-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:12:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBCA334284
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9333D305ABA0
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21F3C0601;
	Thu, 26 Mar 2026 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qs8BaBR+"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098F3A7839;
	Thu, 26 Mar 2026 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523440; cv=fail; b=OI5XshlSeCbsQV+ZOGUNkjwhkdw/m8vj0PmcsFdqeEVvdIDdnOgE7pdNKNKdZiVwhszgaT4xTF3IkQ5UX0pkKznR1kwLmDuCXPHw82AOCifrySBRgg5WP93D5fCABF0tNP1D+sV/me+C6evtMV+Y1Zw4BIb6tfptQF3tZrFL85M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523440; c=relaxed/simple;
	bh=I9Jf6991WxDcrrVxLgNrTEuMMpB2mQJt80ACs+rMu2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWxupi1n2t7JFjo2x835ab5Lml85CDkAHtMVXFXUHoUSdxo5m4RB2sg8XbQrTdo8S302ri+SlRaeJbf3hZsDcmy3+2HVjRZ78ow7OdGMohhTvXVA3yLMhvehlGuXjLQBnCgsHh4xSIR9SW4ABaxCMC7vLTzG8yiKbx9RsTc38XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qs8BaBR+; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx5Aor+BxjPyDXaIU/nicK0VQDeXbEq55lq6cOA6qSid4D8Om/7mvyM0lEmbtrWYbFrCYzZn+l0TdFBKkqtLN+qQfFK6YoOEmRl1b2AseLRq+idt8kGOWltHooDd88uI89slVWsdlLUolMUv3TnNDXJPhF2S0hzZdg6f5Am7+T9vYjpWpMnBOBuORYjtxMjBvZ7eatU+uMCSoDMP0V7FlziOrdY397yLUhOGslL2KOSE7hn3mwwshLciFf/LVo5zAHHUgY/g6/nYHWqWNfeu4RqR4EPE/uVxUdHPFB5IhR/CVPAa68PZiBv4jxz6l+LYyGNE9fO9uefo7skVqpGCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=UNl1sLFIhuaq6UfSedFDlKdRiV3PxZKnm4Yrg0OMnU2b1nM5HTERxO8EcMFeQuV3QylaMphwE2vHCFuKOxJLsiSvp/nKqc3xkp3mBlCdm6qN+hkJCcZROvIFUiGPMdROcLFt9b6qGfdpBfpN51yWqVKNkZkIgaSxWZj236WWCTWDrysIoLwHwofTJ5LLqL9oMUZrE05enVb39xIfLYRvg6khY9XG+hkZ/I/HKjpRySeTn8MF1Gy+8GaU60r+AloXZBZIDn8GAyXfxgTiMX7EPaVKot3tvLkYl1S0+NXa6USDP1aNOnop7EK0E68b10pEsnX7alkbWlQLZ3culNLQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=Qs8BaBR+NwOxM0uMLDSbhfnNbcRjNwe3fk7No5EfG9H8um0WadOcZ7SpcRZXq+mD74P/Wx1Xq4dZpEQW6oahBJ54l+HQjhC2R3qEHMGXgy6Yj3kOO5xO/eP+UBgJ20ftRrIPmU1ibtzrKYYFpG5XsNWxrFjhKoMb4b+l36WbkEIjM31jz+QNI8zuHOlIEDSCZjhJSCAQ9GRDFr3hcsxA8gp2VxZbl5B3y2OKFHGe5FKl1GFQ47MmGlwC1Yy/VXZLFuui0izDf/Dsn2kVWilrUypK3fsPWZAud4/lPMfFvXaHCj7qObTuf+JGU8m6ilgjmtzbq7Wdlct+4Jsn6dxh1A==
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:10:34 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::b4) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:10:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:10:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:10:25 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:10:20 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 02/10] arm64: tegra: Remove fallback compatible for GPCDMA
Date: Thu, 26 Mar 2026 16:39:39 +0530
Message-ID: <20260326110948.68908-3-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 003367e8-b757-48b6-f2e4-08de8b284d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	8Vt5m5LZb5XuDeQUwqDmMe8yvjjnHhX+2Q41GH36vBiTdWK/gCjVVjJ9UJYjM1LbxylWzE9LcHgnznd8+D/4VkAD9NSZ5IX+9OpgpFPv/Y9pZzj8nNl/FFVY+ya+UMKhNE4mWtlkMHzrBfRXRD6jEWyoWflQv98hL2GFl7PrY359CNTW/fERy2S5kMcsaNi/eAWdV9FYypfydWPt3KNBP6IHURfAQaoZWLi1yFlVAoLvGrmCErmONvjpSya9DIPPEnqsGky386ejbdG64Z3J3RsbwuY3XbvZJNWCQI8mGEV8+nXj8jbHIuPFpqGMBBrZrE/ijlWVL+xaaVKO0KasNCFIHmwX3ibCoeF4YCG/dkw0GOz7dkvPpvppwPDJChCp0ohTIdQ6znk9B2C07HL27e7z0pkTxd95NH3G9KFe47SqcitRmBy6CAq/qHIYsafvs6fbqOLCI2wAln+2Ftcdnd0SL8whmsp4/VjHGYC9YNhwEM8UsR0KNT57QLV3pD9OGB64hEApMjVDzuPPgoyOJjNzDxSNCz8NTS+KcfTkYtOrukdM44nTBldzHKkMvQ7DNUXx+J7mWYFI7v5r+ttjF2Bn8GmcYLxzfaz0PS0Tnz63sPf9PLVbW++iEGCahnBWkJP61ZWSZAF6wwRCejsWGVsiwkfkDNRgRtwWEiI3jAc7LfU+BLy4uiPd3jdbzmyQE1nCRAni6Pn92h3lBAmzW/RnnNC8o1c05rozmtXhoHk9T4VQpvMxhMKu2dKUqUBi+bn8lLM4gatD6cn6G3MuaLRqThe+7uUFqpIdvHwNQmz3YV+gcgBhA7DbdrXUmyws
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VpSUjHj0irWv1I213ombkaoYi5QjXDFJ8+E3vM87DvJFgDpCF/khcQrbHGDlHTIP93hodw7EnEoTpKH6EYh4Ox647XfK6NppjmEZxGIkMM0zdOznmt99GWogYivf6cNXsa+p4gjlC2RRlpWtoDVTirgA3Da1HGk5AzI8ThbRqKFommGY8DCGGhcYWZUTg+ad38e+e6jKBYD+9A0+4LjGvGZ1B+C+TDEH8jg+LjjGpNSfnYRuu98d/lhjeGpn/fD6jL38SEiUgNO5qUhrw4NTkwltk3tTXCmI3tkKKyjINeTZ45t8U7KLVc7oXLYBb75wcBVe59ORVwVkW78/ailgNWw4TzpUUC0ilwbST3e0FG07Z5wzlbnyT8l7G93ezAXYtOT2uaSZNvmDC+b8QZJH0C2XimaxoW1f2ynNsdSAplPjmiiQdVUYh2mfqtw8f95I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:10:34.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003367e8-b757-48b6-f2e4-08de8b284d88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9664-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,99b0000:email,0.128.44.128:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0FBCA334284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GPCDMA
in Tegra264. Tegra186 compatible cannot work on Tegra264 because of the
register offset changes and absence of the reset property.

Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 24cc2c51a272..af077420d7d9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3208,7 +3208,7 @@ agic_page5: interrupt-controller@99b0000 {
 		};
 
 		gpcdma: dma-controller@8400000 {
-			compatible = "nvidia,tegra264-gpcdma", "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra264-gpcdma";
 			reg = <0x0 0x08400000 0x0 0x210000>;
 			interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.50.1


