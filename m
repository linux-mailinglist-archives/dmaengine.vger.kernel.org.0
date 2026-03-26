Return-Path: <dmaengine+bounces-9672-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG1EKKYXxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9672-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:25:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0EA3346CF
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A225830C7834
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE333D813E;
	Thu, 26 Mar 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqaIJq95"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4763CF664;
	Thu, 26 Mar 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523507; cv=fail; b=rVwXkGShesrMfk47DMUfUsJd9DRy/qY95gU+vQ+3W6jXlkXOFUhXJo2CMXpkZui2EjU8RujEMKLfyG+I9L5P8+P16Jc5iaIezMlIqpceuPyx21gfDNCEsv6rTU2CO+uqtAZxzpmgVmhIn9SGOSVWbKPxNSyBL++V3EcwFqvUOwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523507; c=relaxed/simple;
	bh=S1s9eEL+e6ZhFAmNEYpv65ZovJCBkkZwzR7yhlLIEow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnFRWagsNORiCpJuHtQjCvJtL3OOKQ3twjoFXi9XzyGulFtBExa0HPhapFQRU9NMxrB1ujfzXUqubUCKfPir9fSVM3yiaKp5INshR9neoaa/hXOE/A+3MygvGF0q22hlT9z45SF5YaumQRtMPB6EPlsYK4f0s+dANP5SLIcQNhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GqaIJq95; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI8s9X/5uVm9l8gMmTW3fn9Eiz+FAA/yYSeYraRcFktSMbosGvXtHnrHslquCg85j8ZfM4wKV99DcDbC5QUIfWkWRYJDsu9oDvIKISy07MEdBjioI86OAUY59RZVJDHHPOVpDOk4SXBy+jAJrNC23G3dXreRioj4wl7j/FNf+V3ZXWbVq++PN3y2NddWm/8m71Gy7HZCub/+ayop2n6aMNBV3gP1wMmX6P232YoGGcBGD+ZOcjmUsXovLPMrtZ4kK/4C1CLmrh4mXN1fDcM7J2u6lHulnMkdtqi/E2Scs87tMEVjI9NIESqKA6/pdP4I3eZe3mM34gRpSqvaGiBvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=Iaz8IQ+A9ZdkSCAGlYy0xFCYBDENWmZ90yz5QZa0pcUTaGfog9WBGkhJUapT0OkgPFZqvw8zpN835zW2oaQ6uQbQZCOf/H3Jx/c9LMWUXhrpndHsp5YWi44nDZmv4MfupEAU/a1uxvjvngoQoHu+9HYWw+tbUNdv9c8F4vRUP8qclvovqBKfW2SZhYKzrf6mmd5plhbuklaawBlmCFh/wD9BSHrL7Pa2fwwCTwGGuY1fbyToyuUlZUyf3xX0dfUUCADTmxuAn8NIOyvpKqDylX36e1YKZwCRX2q/xxs/ehuN0GJ1I8hEZG/QMdrn4yAAFsOe2Zk5wb7Jy2RcM6TboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrBIbZMyVZaLHD0RxJdtH7oKyBdkos2HKFAeioE4AKs=;
 b=GqaIJq95GW7cHTpcJYUN3q2VIfcLjCkA0LDm6uIr8mmH15kGw3I97jXZZs7SxmeEV1Ja3AzBsFMkTMoIRtWDcuTzJge1+GMYk16lAVK5iGaguEjsea/8jPZaSz7l2sQ4dVH4nTgSTbLFXz/CTgvrtn+S15BNBErqd5vKtPzLaqYnQePW7YMUhZrKrWqRl125fz1PjvdFJy8exA2bLVRClfGbTT5Tc3yIy2PBUz+A4Pjs8gWuczpys7jQFbYpI+cuuPdFoc3+TT5AZXs4zSt4G0EWFDYePA+tWepzVX7mkZ4UeViZDIZZojhozcebJpaGnQDtKcLXhN44oY2LHW4mFw==
Received: from PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::26)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:11:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::e) by PH7P221CA0075.outlook.office365.com
 (2603:10b6:510:328::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:11:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:11:34 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:11:31 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 10/10] arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
Date: Thu, 26 Mar 2026 16:39:47 +0530
Message-ID: <20260326110948.68908-11-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b119f2-01b3-4a39-da31-08de8b2875ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3BQmY7MP6G2K1tp3dK9/p7wvTzxz+Wx1Tp7ySqOa13jzL31QQDP6Y2nlUzkcgg9eBLyaLky7CD7UOy9rfGj7bCPOm4KmOYOo2tmuHaUPZqJNrj3TsQXdhe/S9DN0BsxKp5b3Flz2mtjb1fsG7zne4BHYr03pXcOETWVBr9z9JELubh5TzusvpuIJPD7MjCVxAfdJaOwoZXOXnFk2hu42WFK6ws8c3Cs9/ZS4yFGvJGiAJ1WFirG+bpsNfI5WTo2Kk+o80J7dL4TT4hqxttVoZWCXH/biXTz99hAy1txnPGgw3sD2qs4uDLPeOAkzyqNCynQZ6+yxG6DdPLcaUp6et2uf4nuW+hMYg+TVmYDWBKlBKZGm4KrSSNv0uNTvG+30mn4YFKT5eWt1jS+fKLMZz4gANJMvZVQTBiad7+FBwxFGy+bDfNRVu52VyoMZi+d10ttLUsm+S091OG14oX+6Q4Gx6YwKXNiwvYuduqvHJ9dNVKTIBa94S1cGH0lfUi4wroa+1DCcXgj3TTRWpAABb7kMHBQA6vOC16yjNOhKAQGE38Ir3VNhbP1maUNxryjBU3OZPhwVgOG0+nWu7y5cRTEFp4oNR+nAzaWXgNRU+2f3Yhh7vDFrwmaSqE9GoaPPEaS55qOgV+Wx/OT6SKStXR0+HbCP3GvGwrXkoRw6VJmDvYLQANtbGQAJUBIQT8K0EVnd3OZvLu8RIf97u5mRrgXI3YaTYS59UU5f7yYLcLMJh1zxmy+H7MhLUK5+2JBphG8m0B7fV16mOhCSxTv0exlk2L+q9rxBjIhE502456D8D2oRo7tilpDikvAPo3Q4
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5FIqbwuIYt3r4fvC9oEsRJx9/g5LpEsqqqaEUrkD/ztw/Nb/VknNffaUdro6dM++2L40UN5J2ZkZHj9UlUWu7vTMbVFtE4sQKSmrbTH1J8DgxR79Qg8Jlg+gWvby1JGeRIvKFPgVS5cSbIzm8q5U18BljHzzpvNixozQUGTxdLUDz+GbUWOmRSmrPKeKEICOCVFjlS2kP2sLRQag57dSl6aam+XQxNhapwvbaSq2uWVmAYbxXwBj1mTMk5j31aqM6roj3dpRfsgtzey7K3QQuh5gDKghkO1gWTHTcL5rDUBDUEgBrIvkSNoEELHj6re+dpRUk+tOYQLZ8fhiaulu/pXCIdpNIppffmShjbKO9abxbqkjCsth67FW6HOSwWXPHO+U8bM8RNHlZ7/y82hjKtxRUNOzmKVYXeCd9n+nSqnQitpw55z2uXxxl064KDt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:42.3186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b119f2-01b3-4a39-da31-08de8b2875ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9672-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,0.0.0.0:email,c4e0000:email,0.128.44.128:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A0EA3346CF
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


