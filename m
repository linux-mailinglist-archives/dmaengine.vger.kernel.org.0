Return-Path: <dmaengine+bounces-9725-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFT9DQ6TymnF+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9725-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:13:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDD35D94A
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAAC305C8E3
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C725329391;
	Mon, 30 Mar 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMTSL5+K"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64731F984;
	Mon, 30 Mar 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882035; cv=fail; b=V11/7jbDu03HhLKpTPPhADc6ft7neHau/yKeWGcnrgN2b6bVFy11j3O7qQbWf2e5MZkIBi0dSpfsDrIfRKfSQIM48Mfe2Z0/h/82l21Z1hvh1a4IIrVI+T09qTZAAp496Ofx6t4FZjolNwcUyacUNqY71LaRqdEk7/B78JzA7Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882035; c=relaxed/simple;
	bh=S1s9eEL+e6ZhFAmNEYpv65ZovJCBkkZwzR7yhlLIEow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8r4Q4IRNVYLCZV6HtrDfFRjFMAudGpKOPh2GM8I4VdlNw68Ao8ZLehEw5QiaD8JN7baWZn6lwXjqxg6fsNnd9JGKKtQfiBQvPt1M+IVMBqVEu0oarKM/TScgu0p4PAMXG4i+1UkwmugNPBPP19rzGVSr/1lyqFutbQOLLzQ8nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gMTSL5+K; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKSAOKVPOpyUGY9d5NXCU3hqJjb6JNLkHArfq/BXOdQ28CGwNtD6HlMCgVZApX0YGP+LYsOuzjQo3lTIKMb5Wy36Zcy9c6Wd5Rt7ZZW8gc/b3X2BlY0UIx1cHzAKz/LP60bVchfnnR2SCXEgSGkALhkwcG9CashppHbrebA8/ZOjkNXPHTCHXzZ6qPHuZyxQEp00fB48xofRwd564JSni/9MNUjNbJYIzv810fj7ZsdPHvatXdwCn4jXzM2PixM/Me0FKk998bIazTg0t8qyq22alCeV38NuzeAr7xVM6CUynd0ltREPTt438GxcYBCsUMqCNjeNTRv62pM/iQPkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=yCOl93LCv6nnLhWD+KCwcIDTrTPd6mxVM8Uud0Xa0T6P0jwJK/riNx+uXuTH4fG2rQEvQat+i/+wZP1WfuqPDdS6IzSRGTOw4tzO+9ThUHAI2zip0pych4Bf7sWU99jawpBzMw6B83tzGy6pe5mcH/VRHVzEzARNCDxJAwwz6xHmV0SKMqF9TPQURHjy9LZ5Wmij1ICuUGKZQ3TsvzUh3LN8PyUhN/E4Mp3rBQXOh/NU48V0sldiknQK+OTckKkA7jHsUz4YKw8ek6qZTqc+4XZ6jNggIdspLmGunAqujXQuUzz9JzUffyxX7XUQjScBwD5D3peiXMs5v9P2x3OH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=gMTSL5+K9v9KSWz+wdAaq7lIu2L0R/gYFgkxPRCFBSvkcJUylXgRSUTI/5NTb866CAVOF9KQQGIJeVlmYWdww8zOOjcN7ftIPRNpa1PF6hNAy3MFZnnVyfYiHyTBQI+dDBPW1vbDqMeSvSrCfYPEuKOxn/0SR4AVoDadmZ9Z72MouN60VjRtKU02LJHxh9eb8LWgUxAc6URPe7dKXtGB7TAvmmQdQA3WOorHpHYewQZchMkhvavBq/fqy53awzt2Pb1QeHXJyQxdiMRoEpRQjCK/IZxVmltNHyQbgQ1h+ig7L509oJax2gXzFk2sbAO+PwjQuTohzKRy4QrYyqt0Yg==
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:47:08 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7d) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:47:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:42 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:46:38 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 10/10] arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
Date: Mon, 30 Mar 2026 20:14:56 +0530
Message-ID: <20260330144456.13551-11-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: da29a80c-1673-4eb6-b477-08de8e6b36c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	JrdLciRgfjTMAlAGftqlZSpVVk1CSjkrc/qnfXa8WQFjjhP6plmaeLcf3l64x5BJkgWPRveiVxBA/ZYychkCmI/Eid9gLJAUzdFgFwTbdidVSNMcqLtCntc5lc5TeQa6pvtcKq9gpdBvWsqylueBCKqUsIbLS3tseueCvwiqjbPHJ2gQj7rNyDclUDq7b8gGACFjkzK1wsLNxx4YdYwViaZsuvCEDyE8Rwpt5FnSyFLo/zLcBTWdLevqqwIgOU82pT1lE0X7j1JgrhnTgX8Q2fZhSLY1eTXFAPgwKhPQCDwMJ3oNmlnOnKF0ijwLkloVqiqUFlajt5bw/2ZDtueDAkMoSa9IGYoY57AECutEKfFt3di0bo35EbxiTgXaImjLNZZNmsTzvbZxPB17DUOwvnYdHHvtg+ccOtQbxnUmbzrhbvnvr6i0ZbqgKmcYfJlmW+JkQk6KGdDShOWZU02ds0KWaCq6uk9UFspGTh2NgRG+2lrrRD940bH+BfFinkepwB5gAcW6SFSVBm11h9VPkMeqTIMT1UH0EKReeXrFPTxdFpcvBiwOMydVZI5IJrPIiXe3ACYq3CodrXTCM3qE4r8bziCBXrmAXEAnwg8xW2GQbDFf5kfUpU0+HCHNziuJMjf/UMuPG96JYVYnmpVw+uDUQ5lXG4AH6ICDywfHKkTtz9CGeFjHdBVc+wclmORA7O814kwSyzV0r0/y8RlsmpIODNFbulCjfCKGzMPHb7vXThFYGr395DdyRBKSJ3pEcKW4/bzoC8dPBp4Ll063bI399cN4qW2LUD4ngNovE52f48fmBWawKsdy/sQld89H
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9cd69k7S2nu7DrE4ts6bAChZBwlGfWkhzJEUstdgVbz5Yi0t021PgzFRV9MfztimGu92OkeZMwEM6+hpwKU0hp3j7GAGAlza+r9bvIN+XrE+HzP8uAGaGILgQpjZLOQhe+4l+Cp6YwOczygZ9DvSCUW8xO/VGCMaK1kTuJsFtpqWeB+8LHvtd56ptK0LMtjSS0Xcabgjuc9GkVO9lntyC1Wi3i99lS7cIx9LhctcVYQnqLrtx7R+UW+WxS32FFy7lyx7NA5PNdBZd2DN9r0JR0gczSgUWtXf7GW43cz2yT04Yi383X4RDm7EkzMBWX7hYzYxMw0FGqfjPNPg52ygHt88uf97wgiO40bSOQTeQl2cLQ8HEOwedU+zjC7t7vDAAx2AQx2sQc/meCAj2YR8oUYCNQ4qS7n2sN04EUBbauvA/ETcbplCtjiebXFnR476
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:47:06.3512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da29a80c-1673-4eb6-b477-08de8e6b36c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9725-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.128.44.128:email,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7EFDD35D94A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable GPCDMA in Tegra264 and add the iommu-map property so that each
channel uses a separate stream ID and gets its own IOMMU domain for
memory.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi | 4 ++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 7e2c3e66c2ab..58cd81bc33d7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -9,6 +9,10 @@ aliases {
 	};
 
 	bus@0 {
+		dma-controller@8400000 {
+			status = "okay";
+		};
+
 		serial@c4e0000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index af077420d7d9..b2f20d4b567a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3244,6 +3244,7 @@ gpcdma: dma-controller@8400000 {
 				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu1 0x00000800>;
+			iommu-map = <1 &smmu1 0x801 31>;
 			dma-coherent;
 			dma-channel-mask = <0xfffffffe>;
 			status = "disabled";
-- 
2.50.1


