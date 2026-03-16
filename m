Return-Path: <dmaengine+bounces-9450-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAg4Ess9uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9450-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:28:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D529E37E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4064A308F809
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAF3D564C;
	Mon, 16 Mar 2026 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nWmarSos"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489073CF68A;
	Mon, 16 Mar 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681660; cv=fail; b=DooSyDn4P5wx48O3qnBytiNfVWh4tJTg9nYOq0pJHgs8Z9e2zT4Z+osoromCSl9c+Kyv+CbnTJ3dnqB9oPRP4wNiZAkNeynRf1KJmbLeDeU3LIkiONOZjUY3na1Q9Zgp8KmcP8o7/G0RwWCJhKYrEA1Pc10TrtjMkURI/ZlyI1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681660; c=relaxed/simple;
	bh=CD9YUleqGP5Xa5aSILRQ6O//cLsVfxk0zh8vxA0wVoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXtrSCMFV5OnsMcK9ULIIoK8ksoKQY2g0WahJry6f2h78P6ifCbIyp+SBTzyc2mb3W3g6ihk5BEq2f4sOL6Lg5ElXHEs20X8iEfc9rXYUFDkMKUw2l3uIwTDGJgKu7j+JSEsTc3JzFCFNeiwvo3xUlM7Ww9vyKe8UdYoH4o0P/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nWmarSos; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnwnNJ0VPUL0asvps5s+Iv28KLPfpAY98XArc7JOx851HmsyloT5+DYJiOUbmMxHqCnvyoLDo7L9Dy2f2EbP8QcC2uBKsWglWgRcfATReeD0SJFpGA+7x7lR6C0uqwnh4t8/ZTWZHu5YiuHAY50eLsB/Qn+vxNcuWsB13T9A75N7f4JcuCPjznCUmnLXDrpjQJHsI6JuC39avFBIoGKFaL467iLWObbgT2HoapwX+9PQma879B54OtlACptQBIO4t3KMg9oRTjg0UMYWSVIlsX4OnFia5ZfssqGT4b0AJwYkc7XaSFrXGUVUrLRch8L8PhJrHUYJutBGMFd8qzK0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehPpuUxceOYMCKeZmzm65SF+MbMIapiAG0cblRO6uxw=;
 b=WS38MwFid7gPhtNMRLPk+UUi9v3A2aw8zX/YfvFEPgV7v2T2rkWlRY4yrP19ZVP8hY2fIbPEPRfXO+UjsLYviuR372gD/IlWGalaUuLL3xb5VLCXzcvnafPBEqGbjCTAuh/UhFigkRF5YMEeYdg6awOWZ7AY8g+QILw29XN3brGML9DNBw/GOF0C3o9tcjJunVQu9bLYbfidyv506hr3XQ5JXfckkb8dbgJ1z5ehF2+fa3PTBwsW7h0PlmicJKf1OmtUcfFRTPU+6JgJ3jthMkqBJ0iYO2Dnkql+W+pBgGS2P6q0wAdFyenytaBbF5JOh31mh3BQIbtQxXRHaKiy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehPpuUxceOYMCKeZmzm65SF+MbMIapiAG0cblRO6uxw=;
 b=nWmarSosOd80KfgMDM95TTu6wZEj6Kj8Cs/EortIJrYb57vqkUVKoaECPoSIL+Vdn7/Vhb906iDcITKzZL1gXVwYAdQNWeXBL1hQjYDz/3WIu5tUlepX1pqQ8eq5p1eNPXthISC0543hYcMtjMQe9Tc7F3wji24/e5adkVZhcc6Ju6Og4flBOj4kr/6/NwOFYnI9Loda3bui7tDAFMDYmoL495NzEoYWcpn7M3WTuAN0Qv8t2BcCZFf9Z8yOjECBMdb1FzmpPfjE4uieWWGGsiWIF9WxJlOpOl8n2IQagbWI8e1iz6iJNaa1kybxFWuUvCBHZaZdsYXrItrF8u8kXw==
Received: from SA0PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:d3::16)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:20:53 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::6) by SA0PR11CA0011.outlook.office365.com
 (2603:10b6:806:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:20:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:20:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:20:30 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:20:27 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 9/9] arm64: tegra: Enable GPCDMA and add iommu-map in Tegra264
Date: Mon, 16 Mar 2026 22:48:23 +0530
Message-ID: <20260316171823.61800-10-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 266fd995-b682-49e5-b133-08de83805fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	WF9V+Bq/LrdQEDeuWQZ9292wHA/e3v3rXFMQCC+sZ2xc2pgkhN/U6tlurLQ9rfrLDvq1b82xNKdhvxo2qV4qlPHIyBylznJOjzinJ+w/PDzEI+qNd+KVgokPs4t69gAHwF3tv4tft55UotW1scco5+VoN1cCSPbF1orjTnLvtu+jLqKG4yfPpp/FBPZUnJ77LX6471kPsNJEUtduXkQxP+7EzClbcTQVGy9k8aGbxyLlyUk3lY1ev1KMe+8ggW6lWKxTnYhVDvxvtZO6o3qPwb9d8zwZeii0otM5O0yPR33vb1uB6zcENMefT3HtBx7XDMgFIW2cyE1TRkgjYdQ1SkAC2AB+3p4aQdF2OCpDOz2maBw6WdKMWRbd/K/OjU91iOCd8byZjYl/bNqO+Td+oxFz8lIdT5Lm22roQtTnerdGaPAJKsIQiqVTbBYF9INJFGjvhhPEFjhKrM3mVSPxEO8CSdfap1GGglbAVFyBxSDzV5Sw1m3IrpRsk/daRvT78Y/Ic5gOJkfpYFNNQ33v9oJlBG/hxtGeTaGO7iVlPBF4y8Z+4F29Fa6+l/o/tmFuo9mxVKwAjG46jkcCO/FO3urGfOnqHO3yU/kNQ5N9Y9V58a8hjr86ENCIplygq07Xe8wLjC37765DIfl326PuuAm4MtdAtO3P8DGCYES2hSm8pzRoF1C0pI0Qk9l6v+QcyKWm54/2O6j4FcgSIrpDNeVQJfdOKXPBtieflHQmQfjkK9z8TTZGB0/5XCcIEE33V8s1K56FIMhARZIMXfYQamZd/s6JtdJ3WMIrv0ybe0vyEwubi37rUxlDEgVf8IFN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rGIXRNkjl2sR3noxpbd2XS8+vJ1qtgswFXHpgK6XCqLZNq0s6Ok2NVtaPUJOsr8H0BumHmlksCdq6uqDx+3wZV/ZZuZLXxqLFOI/sVY8ivr8f4sMkXrGVxQ8LjvG7H1m035x9etbKoG3VcW93yFMykNPHIIyDMQj+KFtrEqQ8jUWwvhWiw+5K26U9BQ5ik/a4wqzLYgiCuGbc8j19GL+SiQIJUd82swF7+dvuZRuJg2oPrQ7Cd1H0pHWMQUmn9hgiR9HJny3+KqM2XEAXDXrnmolWVvpDARy2emIKyqvekYeH6sp1xDMSfpRJyEL/JEMMXzH1zL++b5bGgnngjo86T/Ka9Q3u7QC6NJ9ee1ow/tmtQK5NV3KobK9gAsJnX3bmap0Tc+4GCf7+drVCGNXqNakDGQatQ2hwefg1tmkIe4VnDTW5wBCK20H8FeQD37+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:20:51.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266fd995-b682-49e5-b133-08de83805fab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9450-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A13D529E37E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the fallback compatible string "nvidia,tegra186-gpcdma" and
enable GPCDMA in Tegra264. Tegra186 compatible cannot work on
Tegra264 because of the register offset changes and absence of
the reset property.

Also add the iommu-map property so that each channel uses a separate
stream ID and gets its own IOMMU domain for memory.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi | 4 ++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 7e2c3e66c2ab..c8beb616964a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -16,6 +16,10 @@ serial@c4e0000 {
 		serial@c5a0000 {
 			status = "okay";
 		};
+
+		dma-controller@8400000 {
+			status = "okay";
+		};
 	};
 
 	bus@8100000000 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 24cc2c51a272..b2f20d4b567a 100644
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


