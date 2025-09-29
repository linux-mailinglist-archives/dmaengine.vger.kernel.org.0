Return-Path: <dmaengine+bounces-6727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28131BA8F5F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA145189F303
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528F2FFF88;
	Mon, 29 Sep 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPX++5iL"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE42FF679;
	Mon, 29 Sep 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143788; cv=fail; b=lcBU85Zr7wX6rLa2uAglzwPzsv6IIf//8O4LSNi55duBduKSry+f06+zUe4p5Q/LYCBFR6MfFgN+vcR431aJTSnah2+N6zE9+GHJG5BjSy05qk0i0UVE/syaM+/7ZGTVxAuIe1e+zzqcwBqwc4O+IHeOAG+g4L0733an0mBMxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143788; c=relaxed/simple;
	bh=oWblNlPzvCxMFnILCtKpbRjUwoBckzJ4lVxrmkY4ahU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVNjfeBwNeUyF4Zz+R4B2+YToOvqbe2Bzxbxo1F6REDQhDBcYerJ2tI3GQuXSEYCDQcYg7T0S5ZKbtLaKsDCVkaNCS1WdT3SQ3dtF2AZXRs+QozjxR6v2ouEQFiAXZ//GcXozTAsXcOjrDtJAbNpiUokzz6+RW9LC/5vOrwXkgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IPX++5iL; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcjxb4jL4WTg8bufgF+lJanoBCg96/5Yc0CjAHFgXgAvACDLYy79ODRb4i3PAXpSF4tQn1lJYwFrNlb2ZHEOiuz4vd+in99uejqcjuXFRpJ67oI6mXiHgqRqF6TA0fMMBy+hlV88aU1Ox/tya4nQUdYG6OIwdToG4G2Z0YjpaorpwBHXYSRSr8xtd2mRWWEjIy8CElTeGAfpUeb7eipPhQRy5ld2tKN95IlY4WOHLcoo9ahzF9YJm76G7P/KfyrsTqw6Ui00EWjcoRhUAwIls0ZVud+XE8qWK1+iOLQh5DtHilEtnhyBqEiJXDVsRuHn6eCkfEMV+9ZHDUHCMToZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz88UuEL8h55Cii56f5mK/nG6c3X2KGJPyZuqt6Pok8=;
 b=Et4IXicB2816xJhOHwVPLWYK22CTrASYfsUgbHw8di/nzFE9YFidN+aF/a4DnxcG8x/SEiXbEEJhqMVGCvgOYCuRSf8wNNPyXyuFb6ile+4l+UGFEB6YY/+h6zjH6T35wqgeX74ywzMjZl3LwvEsL7jYb9eyHLOzQQ8oGg85ban3PVAGUsgKdjGDuk9A/NQS/n9VzFMH9DB9TgrxihouA8E69zHGV1in50PbXq/OaVyieOVWIGjpHJdhphTrymwEQO8LflI2R8o2dpfe/KVTDNYmzSDSqa8AFnRCSCKyGJFaMb5JNEmbIUMkweOH/8qZO2PaFlK8eeuJyJBctAgAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz88UuEL8h55Cii56f5mK/nG6c3X2KGJPyZuqt6Pok8=;
 b=IPX++5iLtcc1SONZn/kAaQmrkSmdeIdiPUfiFTSu5fIWjXW8hPO3aow1n1+if8ZrbBawMNAQyr6L/BZnysfINQY3MRMAv+6Zexs//O6Lg8wdNcsccm/WkpwZW2Kr1weWKWBgvh+il6R2YZJ+OtSODIkrJ42fv+WKTCIWjIi77V3qK9etNcLLe9kkkd4/6tdEnFwp5yBlTLVCGDRN7uVrVL0CW6yCCTnrciUHiar5tvDUAv4/ejlDUs86+ttMzk1lkPzJ5/t85FFDTPkV5eEXEDB8H1ntaIUyIwjAWDp1GNvx0mON6uy3KgHa+vfid3bM+pzpqaLe+39YMOh9/Fsetg==
Received: from PH8P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::16)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 11:02:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::6f) by PH8P222CA0025.outlook.office365.com
 (2603:10b6:510:2d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 29 Sep 2025 11:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 11:02:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 04:02:15 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 04:02:14 -0700
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 04:02:10 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>
CC: Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	sheetal <sheetal@nvidia.com>
Subject: [PATCH V2 4/4] arm64: tegra: Add tegra264 audio support
Date: Mon, 29 Sep 2025 16:29:30 +0530
Message-ID: <20250929105930.1767294-5-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: ac91af74-fd94-4861-8ff1-08ddff47b07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKuqDxdfuq6rpJvIuK0cGs0NuW8RHpyWZYMZr8cg/94kvcsm+pS0se9U/Moe?=
 =?us-ascii?Q?f+n9Of3B9a9Rx2Oo1CvLWiOFJ3h7B254Riw9pokqQr+39iMvj5zUtD6Sw2Dz?=
 =?us-ascii?Q?HlAfgs0EgQUtLFT63RpTl8W031t9dxjFq67P+gkJT/KjjVCnl6Vlhg3ZNsJO?=
 =?us-ascii?Q?o1ZZxor6yMwIyAzC7wiJ6wyYeSyK+3dC5HuP7hsYI2fAsKzHt6yDH0hmAWyw?=
 =?us-ascii?Q?o4XBuIV7aYDhqvtvOhiBtovWplP+GtAwawwLgjIb2c/Z1NoEPBsGM4QVjByp?=
 =?us-ascii?Q?nvuFpb+gM54g4Cac/79gtaWQA5CXJnSUfYFZKB+igWPwjZSumZfQSy31+TtM?=
 =?us-ascii?Q?MrWl5sGx4UgFDTXngMN9tJf4eIKQZA1Cq34pfkvNnxQcerNL0hDOUUd1Qnjv?=
 =?us-ascii?Q?KyRy+FoO/XWCkXsEkGbI4svcR1N087SHO4e79uDW8mrIBBj3oTGFhvXkZE7q?=
 =?us-ascii?Q?LJ9SbeRg49R3J9grfSyRMNDaDUoAkx9rs7mmPgmQzgxrp7b7ximggNREuvEh?=
 =?us-ascii?Q?aPDR86INi1uqA40WLHQ10ooLq+4XH6KzFVO9HUW9W5Lzgk4ZZKUzqiLVM6Oi?=
 =?us-ascii?Q?+aeMC90LyGerrn9oiiL8+H7wnjmNh4YnDHdqHOZR41UgyCa+yb6KaV07dCC8?=
 =?us-ascii?Q?OHnVgWy2VodNvj2qJi2ThgduGYEckpIdLW8O1H/p+5EbSxFKZuDSCyLfNeyO?=
 =?us-ascii?Q?T2aJ0St8u2iCQMLrYwIqIuIo+ez2RRFoH6phjwIjraWQpziMxV17TaMT1FiE?=
 =?us-ascii?Q?uW0xebXnqB5BIZy7HYD5jnCv1Lpj8kQ61+8Hy2N9OnWpByMHD8TR5HkjqHAI?=
 =?us-ascii?Q?nfl2EmSK7ZmXAQtDKtGxPNJ5Zbh0VF0orZ15zbWrJMU1a4iCh7VWPsGjl1gH?=
 =?us-ascii?Q?5lrClw3LQgSeLWGOJp8rpdBmXVVWciRo5FkDfz69Lb3jct/vHWXkEc7Ad8hZ?=
 =?us-ascii?Q?dXw7vwiVki08mGakeTZJ/LwhE++LCBITVN8dOL/rvid203x7447jjI/7yT/n?=
 =?us-ascii?Q?Ea6cD9703F2Gr0YO6jH50vIETn7s7CRfAG9rCKzT8PIePOWJxr+V9kBbploI?=
 =?us-ascii?Q?piODW0kIK/0R0xqpkVA3yzlgRQRa+mbOw2Ch6fpiw+qKzCdCIoAmuDivhM25?=
 =?us-ascii?Q?glpMxe5aEZ/0GFBej1uuaFYJQCRCEaKCUKNHG7SNqyQ/qT9mRem1cb8gMfCk?=
 =?us-ascii?Q?iwXUwfxW17LpPyxya9NL+C/tR8ejIZfT8dtE35JW/iF6oaCaiwBL2wYGN95S?=
 =?us-ascii?Q?mhOFHZOSIj/6kIE/wcgqspTDiwTRNtZBHS9juNt6mAKXRgWJH/0kH3yW/4c6?=
 =?us-ascii?Q?UBYLorhbwNx+ecSPmlEU6Q6hbWZvoRdD15lE9cUV4QnxGgkdeUJ1LlWPq3B0?=
 =?us-ascii?Q?3906bMsvKsL7XWeQrbvNnT5bv6ajgV7GDGZCaL2su21soE1Cz9ATonpzo8ms?=
 =?us-ascii?Q?umCzwNbyN7xtW38V8NWi1jLDSiVGOeP7x2nmqPiy0WYcgenkeB6y8+g1Pgem?=
 =?us-ascii?Q?QleWF3RJvlyVBfT081EqSKR3kO7CBIGWFtdiucOyGWiaAv8QvWXTINunFtmv?=
 =?us-ascii?Q?oUkXjvipnb3V77pLq2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:02:32.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac91af74-fd94-4861-8ff1-08ddff47b07c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

From: sheetal <sheetal@nvidia.com>

- Add the audio devices for the tegra264 SoC in the tegra264.dtsi file,
  which includes sound, HDA and APE(Audio Processing Engine) subsystem
  nodes.
  APE subsystem includes,
   - I/O interfaces such as I2S, DMIC and DSPK (all the available
     instances).
   - HW accelerators such as ASRC, OPE, MVC, SFC, AMX, ADX and Mixer (all
     the available instances).
   - ADMA controller and Interrupt controllers.

- Enable the audio nodes in tegra264-p3971.dtsi platform DT file.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
 2 files changed, 3296 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi
index 6b6259b7310f..1fcfac2066ae 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3971.dtsi
@@ -1,4 +1,110 @@
 // SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 
 / {
+	bus@0 {
+		aconnect@9000000 {
+			status = "okay";
+
+			dma-controller@9440000 {
+				status = "okay";
+			};
+
+			ahub@9630000 {
+				status = "okay";
+
+				i2s@9280000 {
+					status = "okay";
+				};
+
+				i2s@9290000 {
+					status = "okay";
+				};
+
+				i2s@92b0000 {
+					status = "okay";
+				};
+			};
+
+			interrupt-controller@9960000 {
+				status = "okay";
+			};
+		};
+
+		hda@88090b0000 {
+			nvidia,model = "NVIDIA Jetson Thor AGX HDA";
+			status = "okay";
+		};
+	};
+
+	sound {
+		status = "okay";
+
+		dais = /* ADMAIF (FE) Ports */
+		       <&admaif0_port>, <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>, <&admaif7_port>,
+		       <&admaif8_port>, <&admaif9_port>, <&admaif10_port>, <&admaif11_port>,
+		       <&admaif12_port>, <&admaif13_port>, <&admaif14_port>, <&admaif15_port>,
+		       <&admaif16_port>, <&admaif17_port>, <&admaif18_port>, <&admaif19_port>,
+		       <&admaif20_port>, <&admaif21_port>, <&admaif22_port>, <&admaif23_port>,
+		       <&admaif24_port>, <&admaif25_port>, <&admaif26_port>, <&admaif27_port>,
+		       <&admaif28_port>, <&admaif29_port>, <&admaif30_port>, <&admaif31_port>,
+		       /* XBAR Ports */
+		       <&xbar_i2s1_port>, <&xbar_i2s2_port>, <&xbar_i2s4_port>,
+		       <&xbar_sfc1_in_port>, <&xbar_sfc2_in_port>,
+		       <&xbar_sfc3_in_port>, <&xbar_sfc4_in_port>,
+		       <&xbar_mvc1_in_port>, <&xbar_mvc2_in_port>,
+		       <&xbar_amx1_in1_port>, <&xbar_amx1_in2_port>,
+		       <&xbar_amx1_in3_port>, <&xbar_amx1_in4_port>,
+		       <&xbar_amx2_in1_port>, <&xbar_amx2_in2_port>,
+		       <&xbar_amx2_in3_port>, <&xbar_amx2_in4_port>,
+		       <&xbar_amx3_in1_port>, <&xbar_amx3_in2_port>,
+		       <&xbar_amx3_in3_port>, <&xbar_amx3_in4_port>,
+		       <&xbar_amx4_in1_port>, <&xbar_amx4_in2_port>,
+		       <&xbar_amx4_in3_port>, <&xbar_amx4_in4_port>,
+		       <&xbar_amx5_in1_port>, <&xbar_amx5_in2_port>,
+		       <&xbar_amx5_in3_port>, <&xbar_amx5_in4_port>,
+		       <&xbar_amx6_in1_port>, <&xbar_amx6_in2_port>,
+		       <&xbar_amx6_in3_port>, <&xbar_amx6_in4_port>,
+		       <&xbar_adx1_in_port>, <&xbar_adx2_in_port>,
+		       <&xbar_adx3_in_port>, <&xbar_adx4_in_port>,
+		       <&xbar_adx5_in_port>, <&xbar_adx6_in_port>,
+		       <&xbar_mix_in1_port>, <&xbar_mix_in2_port>,
+		       <&xbar_mix_in3_port>, <&xbar_mix_in4_port>,
+		       <&xbar_mix_in5_port>, <&xbar_mix_in6_port>,
+		       <&xbar_mix_in7_port>, <&xbar_mix_in8_port>,
+		       <&xbar_mix_in9_port>, <&xbar_mix_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
+		       /* HW accelerators */
+		       <&sfc1_out_port>, <&sfc2_out_port>,
+		       <&sfc3_out_port>, <&sfc4_out_port>,
+		       <&mvc1_out_port>, <&mvc2_out_port>,
+		       <&amx1_out_port>, <&amx2_out_port>,
+		       <&amx3_out_port>, <&amx4_out_port>,
+		       <&amx5_out_port>, <&amx6_out_port>,
+		       <&adx1_out1_port>, <&adx1_out2_port>,
+		       <&adx1_out3_port>, <&adx1_out4_port>,
+		       <&adx2_out1_port>, <&adx2_out2_port>,
+		       <&adx2_out3_port>, <&adx2_out4_port>,
+		       <&adx3_out1_port>, <&adx3_out2_port>,
+		       <&adx3_out3_port>, <&adx3_out4_port>,
+		       <&adx4_out1_port>, <&adx4_out2_port>,
+		       <&adx4_out3_port>, <&adx4_out4_port>,
+		       <&adx5_out1_port>, <&adx5_out2_port>,
+		       <&adx5_out3_port>, <&adx5_out4_port>,
+		       <&adx6_out1_port>, <&adx6_out2_port>,
+		       <&adx6_out3_port>, <&adx6_out4_port>,
+		       <&mix_out1_port>, <&mix_out2_port>, <&mix_out3_port>,
+		       <&mix_out4_port>, <&mix_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
+		       /* BE I/O Ports */
+		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>;
+
+		label = "NVIDIA Jetson Thor AGX APE";
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index e02659efa233..49eed7fc16e7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/memory/nvidia,tegra264.h>
 #include <dt-bindings/reset/nvidia,tegra264.h>
+#include <dt-bindings/power/nvidia,tegra264-powergate.h>
 
 / {
 	compatible = "nvidia,tegra264";
@@ -49,6 +50,3163 @@ timer@8000000 {
 			status = "disabled";
 		};
 
+		aconnect@9000000 {
+			compatible = "nvidia,tegra264-aconnect",
+					"nvidia,tegra210-aconnect";
+			clocks = <&bpmp TEGRA264_CLK_APE>,
+				<&bpmp TEGRA264_CLK_ADSP>;
+			clock-names = "ape", "apb2ape";
+			power-domains = <&bpmp TEGRA264_POWER_DOMAIN_AUD>;
+			status = "disabled";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x9000000 0x0 0x9000000 0x0 0x2000000>;
+
+			adma: dma-controller@9440000 {
+				compatible = "nvidia,tegra264-adma";
+				reg = <0x0 0x9440000 0x0 0xb0000>;
+				interrupt-parent = <&agic_page0>;
+				interrupts = <GIC_SPI 0x90 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x91 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x92 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x93 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x94 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x95 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x96 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x97 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x98 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x99 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9a IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9b IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9c IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9d IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9e IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0x9f IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa0 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa1 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa2 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa3 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa4 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa5 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa7 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa8 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xa9 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xaa IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xab IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xac IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xad IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xae IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xaf IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb0 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb1 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb2 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb3 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb4 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb5 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb7 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb8 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xb9 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xba IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xbb IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xbc IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xbd IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xbe IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xbf IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc0 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc1 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc2 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc3 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc4 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc5 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc7 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc8 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xc9 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xca IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xcb IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xcc IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xcd IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xce IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 0xcf IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				clocks = <&bpmp TEGRA264_CLK_AHUB>;
+				clock-names = "d_audio";
+				status = "disabled";
+			};
+
+			tegra_ahub: ahub@9630000 {
+				compatible = "nvidia,tegra264-ahub";
+				reg = <0x0 0x9630000 0x0 0x10000>;
+				clocks = <&bpmp TEGRA264_CLK_AHUB>;
+				clock-names = "ahub";
+				assigned-clocks = <&bpmp TEGRA264_CLK_AHUB>;
+				assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLAON_APE>;
+				status = "disabled";
+
+				#address-cells = <2>;
+				#size-cells = <2>;
+				/* ADMA is under AHUB range, its excluded in the defined range */
+				ranges = <0x0 0x9280000 0x0 0x9280000 0x0 0x1c0000>,
+					<0x0 0x9510000 0x0 0x9510000 0x0 0x370000>;
+
+				tegra_i2s1: i2s@9280000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x9280000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S1>,
+					       <&bpmp TEGRA264_CLK_I2S1_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S1>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S1";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s1_cif: endpoint {
+								remote-endpoint = <&xbar_i2s1>;
+							};
+						};
+
+						i2s1_port: port@1 {
+							reg = <1>;
+
+							i2s1_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s2: i2s@9290000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x9290000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S2>,
+						 <&bpmp TEGRA264_CLK_I2S2_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S2>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S2";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s2_cif: endpoint {
+								remote-endpoint = <&xbar_i2s2>;
+							};
+						};
+
+						i2s2_port: port@1 {
+							reg = <1>;
+
+							i2s2_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s3: i2s@92a0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92a0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S3>,
+					       <&bpmp TEGRA264_CLK_I2S3_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S3>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S3";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s3_cif: endpoint {
+								remote-endpoint = <&xbar_i2s3>;
+							};
+						};
+
+						i2s3_port: port@1 {
+							reg = <1>;
+
+							i2s3_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s4: i2s@92b0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92b0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S4>,
+					       <&bpmp TEGRA264_CLK_I2S4_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S4>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S4";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s4_cif: endpoint {
+								remote-endpoint = <&xbar_i2s4>;
+							};
+						};
+
+						i2s4_port: port@1 {
+							reg = <1>;
+
+							i2s4_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s5: i2s@92c0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92c0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S5>,
+					       <&bpmp TEGRA264_CLK_I2S5_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S5>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S5";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s5_cif: endpoint {
+								remote-endpoint = <&xbar_i2s5>;
+							};
+						};
+
+						i2s5_port: port@1 {
+							reg = <1>;
+
+							i2s5_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s6: i2s@92d0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92d0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S6>,
+					       <&bpmp TEGRA264_CLK_I2S6_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S6>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S6";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s6_cif: endpoint {
+								remote-endpoint = <&xbar_i2s6>;
+							};
+						};
+
+						i2s6_port: port@1 {
+							reg = <1>;
+
+							i2s6_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s7: i2s@92e0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92e0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S7>,
+					       <&bpmp TEGRA264_CLK_I2S7_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S7>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S7";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s7_cif: endpoint {
+								remote-endpoint = <&xbar_i2s7>;
+							};
+						};
+
+						i2s7_port: port@1 {
+							reg = <1>;
+
+							i2s7_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_i2s8: i2s@92f0000 {
+					compatible = "nvidia,tegra264-i2s";
+					reg = <0x0 0x92f0000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_I2S8>,
+					       <&bpmp TEGRA264_CLK_I2S8_SCLK_IN>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA264_CLK_I2S8>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S8";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s8_cif: endpoint {
+								remote-endpoint = <&xbar_i2s8>;
+							};
+						};
+
+						i2s8_port: port@1 {
+							reg = <1>;
+
+							i2s8_dap: endpoint {
+								dai-format = "i2s";
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_dmic1: dmic@9300000 {
+					compatible = "nvidia,tegra264-dmic",
+							"nvidia,tegra210-dmic";
+					reg = <0x0 0x9300000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_DMIC1>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA264_CLK_DMIC1>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC1";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic1_cif: endpoint {
+								remote-endpoint = <&xbar_dmic1>;
+							};
+						};
+
+						dmic1_port: port@1 {
+							reg = <1>;
+
+							dmic1_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_dmic2: dmic@9310000 {
+					compatible = "nvidia,tegra264-dmic",
+						   "nvidia,tegra210-dmic";
+					reg = <0x0 0x9310000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_DMIC1>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA264_CLK_DMIC1>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC2";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic2_cif: endpoint {
+								remote-endpoint = <&xbar_dmic2>;
+							};
+						};
+
+						dmic2_port: port@1 {
+							reg = <1>;
+
+							dmic2_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_dspk1: dspk@9380000 {
+					compatible = "nvidia,tegra264-dspk",
+							"nvidia,tegra186-dspk";
+					reg = <0x0 0x9380000 0x0 0x10000>;
+					clocks = <&bpmp TEGRA264_CLK_DSPK1>;
+					clock-names = "dspk";
+					assigned-clocks = <&bpmp TEGRA264_CLK_DSPK1>;
+					assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+					assigned-clock-rates = <12288000>;
+					sound-name-prefix = "DSPK1";
+					status = "disabled";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dspk1_cif: endpoint {
+								remote-endpoint = <&xbar_dspk1>;
+							};
+						};
+
+						dspk1_port: port@1 {
+							reg = <1>;
+
+							dspk1_dap: endpoint {
+								/* placeholder for external codec */
+							};
+						};
+					};
+				};
+
+				tegra_amx1: amx@9510000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9510000 0x0 0x10000>;
+					sound-name-prefix = "AMX1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx1_in1: endpoint {
+								remote-endpoint = <&xbar_amx1_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx1_in2: endpoint {
+								remote-endpoint = <&xbar_amx1_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx1_in3: endpoint {
+								remote-endpoint = <&xbar_amx1_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx1_in4: endpoint {
+								remote-endpoint = <&xbar_amx1_in4>;
+							};
+						};
+
+						amx1_out_port: port@4 {
+							reg = <4>;
+
+							amx1_out: endpoint {
+								remote-endpoint = <&xbar_amx1_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amx2: amx@9520000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9520000 0x0 0x10000>;
+					sound-name-prefix = "AMX2";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx2_in1: endpoint {
+								remote-endpoint = <&xbar_amx2_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx2_in2: endpoint {
+								remote-endpoint = <&xbar_amx2_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx2_in3: endpoint {
+								remote-endpoint = <&xbar_amx2_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx2_in4: endpoint {
+								remote-endpoint = <&xbar_amx2_in4>;
+							};
+						};
+
+						amx2_out_port: port@4 {
+							reg = <4>;
+
+							amx2_out: endpoint {
+								remote-endpoint = <&xbar_amx2_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amx3: amx@9530000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9530000 0x0 0x10000>;
+					sound-name-prefix = "AMX3";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx3_in1: endpoint {
+								remote-endpoint = <&xbar_amx3_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx3_in2: endpoint {
+								remote-endpoint = <&xbar_amx3_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx3_in3: endpoint {
+								remote-endpoint = <&xbar_amx3_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx3_in4: endpoint {
+								remote-endpoint = <&xbar_amx3_in4>;
+							};
+						};
+
+						amx3_out_port: port@4 {
+							reg = <4>;
+
+							amx3_out: endpoint {
+								remote-endpoint = <&xbar_amx3_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amx4: amx@9540000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9540000 0x0 0x10000>;
+					sound-name-prefix = "AMX4";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx4_in1: endpoint {
+								remote-endpoint = <&xbar_amx4_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx4_in2: endpoint {
+								remote-endpoint = <&xbar_amx4_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx4_in3: endpoint {
+								remote-endpoint = <&xbar_amx4_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx4_in4: endpoint {
+								remote-endpoint = <&xbar_amx4_in4>;
+							};
+						};
+
+						amx4_out_port: port@4 {
+							reg = <4>;
+
+							amx4_out: endpoint {
+								remote-endpoint = <&xbar_amx4_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amx5: amx@9550000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9550000 0x0 0x10000>;
+					sound-name-prefix = "AMX5";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx5_in1: endpoint {
+								remote-endpoint = <&xbar_amx5_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx5_in2: endpoint {
+								remote-endpoint = <&xbar_amx5_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx5_in3: endpoint {
+								remote-endpoint = <&xbar_amx5_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx5_in4: endpoint {
+								remote-endpoint = <&xbar_amx5_in4>;
+							};
+						};
+
+						amx5_out_port: port@4 {
+							reg = <4>;
+
+							amx5_out: endpoint {
+								remote-endpoint = <&xbar_amx5_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amx6: amx@9560000 {
+					compatible = "nvidia,tegra264-amx";
+					reg = <0x0 0x9560000 0x0 0x10000>;
+					sound-name-prefix = "AMX6";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx6_in1: endpoint {
+								remote-endpoint = <&xbar_amx6_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx6_in2: endpoint {
+								remote-endpoint = <&xbar_amx6_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx6_in3: endpoint {
+								remote-endpoint = <&xbar_amx6_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx6_in4: endpoint {
+								remote-endpoint = <&xbar_amx6_in4>;
+							};
+						};
+
+						amx6_out_port: port@4 {
+							reg = <4>;
+
+							amx6_out: endpoint {
+								remote-endpoint = <&xbar_amx6_out>;
+							};
+						};
+					};
+				};
+
+				tegra_adx1: adx@9590000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x9590000 0x0 0x10000>;
+					sound-name-prefix = "ADX1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx1_in: endpoint {
+								remote-endpoint = <&xbar_adx1_in>;
+							};
+						};
+
+						adx1_out1_port: port@1 {
+							reg = <1>;
+
+							adx1_out1: endpoint {
+								remote-endpoint = <&xbar_adx1_out1>;
+							};
+						};
+
+						adx1_out2_port: port@2 {
+							reg = <2>;
+
+							adx1_out2: endpoint {
+								remote-endpoint = <&xbar_adx1_out2>;
+							};
+						};
+
+						adx1_out3_port: port@3 {
+							reg = <3>;
+
+							adx1_out3: endpoint {
+								remote-endpoint = <&xbar_adx1_out3>;
+							};
+						};
+
+						adx1_out4_port: port@4 {
+							reg = <4>;
+
+							adx1_out4: endpoint {
+								remote-endpoint = <&xbar_adx1_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_adx2: adx@95a0000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x95a0000 0x0 0x10000>;
+					sound-name-prefix = "ADX2";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx2_in: endpoint {
+								remote-endpoint = <&xbar_adx2_in>;
+							};
+						};
+
+						adx2_out1_port: port@1 {
+							reg = <1>;
+
+							adx2_out1: endpoint {
+								remote-endpoint = <&xbar_adx2_out1>;
+							};
+						};
+
+						adx2_out2_port: port@2 {
+							reg = <2>;
+
+							adx2_out2: endpoint {
+								remote-endpoint = <&xbar_adx2_out2>;
+							};
+						};
+
+						adx2_out3_port: port@3 {
+							reg = <3>;
+
+							adx2_out3: endpoint {
+								remote-endpoint = <&xbar_adx2_out3>;
+							};
+						};
+
+						adx2_out4_port: port@4 {
+							reg = <4>;
+
+							adx2_out4: endpoint {
+								remote-endpoint = <&xbar_adx2_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_adx3: adx@95b0000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x95b0000 0x0 0x10000>;
+					sound-name-prefix = "ADX3";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx3_in: endpoint {
+								remote-endpoint = <&xbar_adx3_in>;
+							};
+						};
+
+						adx3_out1_port: port@1 {
+							reg = <1>;
+
+							adx3_out1: endpoint {
+								remote-endpoint = <&xbar_adx3_out1>;
+							};
+						};
+
+						adx3_out2_port: port@2 {
+							reg = <2>;
+
+							adx3_out2: endpoint {
+								remote-endpoint = <&xbar_adx3_out2>;
+							};
+						};
+
+						adx3_out3_port: port@3 {
+							reg = <3>;
+
+							adx3_out3: endpoint {
+								remote-endpoint = <&xbar_adx3_out3>;
+							};
+						};
+
+						adx3_out4_port: port@4 {
+							reg = <4>;
+
+							adx3_out4: endpoint {
+								remote-endpoint = <&xbar_adx3_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_adx4: adx@95c0000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x95c0000 0x0 0x10000>;
+					sound-name-prefix = "ADX4";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx4_in: endpoint {
+								remote-endpoint = <&xbar_adx4_in>;
+							};
+						};
+
+						adx4_out1_port: port@1 {
+							reg = <1>;
+
+							adx4_out1: endpoint {
+								remote-endpoint = <&xbar_adx4_out1>;
+							};
+						};
+
+						adx4_out2_port: port@2 {
+							reg = <2>;
+
+							adx4_out2: endpoint {
+								remote-endpoint = <&xbar_adx4_out2>;
+							};
+						};
+
+						adx4_out3_port: port@3 {
+							reg = <3>;
+
+							adx4_out3: endpoint {
+								remote-endpoint = <&xbar_adx4_out3>;
+							};
+						};
+
+						adx4_out4_port: port@4 {
+							reg = <4>;
+
+							adx4_out4: endpoint {
+								remote-endpoint = <&xbar_adx4_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_adx5: adx@95d0000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x95d0000 0x0 0x10000>;
+					sound-name-prefix = "ADX5";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx5_in: endpoint {
+								remote-endpoint = <&xbar_adx5_in>;
+							};
+						};
+
+						adx5_out1_port: port@1 {
+							reg = <1>;
+
+							adx5_out1: endpoint {
+								remote-endpoint = <&xbar_adx5_out1>;
+							};
+						};
+
+						adx5_out2_port: port@2 {
+							reg = <2>;
+
+							adx5_out2: endpoint {
+								remote-endpoint = <&xbar_adx5_out2>;
+							};
+						};
+
+						adx5_out3_port: port@3 {
+							reg = <3>;
+
+							adx5_out3: endpoint {
+								remote-endpoint = <&xbar_adx5_out3>;
+							};
+						};
+
+						adx5_out4_port: port@4 {
+							reg = <4>;
+
+							adx5_out4: endpoint {
+								remote-endpoint = <&xbar_adx5_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_adx6: adx@95e0000 {
+					compatible = "nvidia,tegra264-adx";
+					reg = <0x0 0x95e0000 0x0 0x10000>;
+					sound-name-prefix = "ADX6";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx6_in: endpoint {
+								remote-endpoint = <&xbar_adx6_in>;
+							};
+						};
+
+						adx6_out1_port: port@1 {
+							reg = <1>;
+
+							adx6_out1: endpoint {
+								remote-endpoint = <&xbar_adx6_out1>;
+							};
+						};
+
+						adx6_out2_port: port@2 {
+							reg = <2>;
+
+							adx6_out2: endpoint {
+								remote-endpoint = <&xbar_adx6_out2>;
+							};
+						};
+
+						adx6_out3_port: port@3 {
+							reg = <3>;
+
+							adx6_out3: endpoint {
+								remote-endpoint = <&xbar_adx6_out3>;
+							};
+						};
+
+						adx6_out4_port: port@4 {
+							reg = <4>;
+
+							adx6_out4: endpoint {
+								remote-endpoint = <&xbar_adx6_out4>;
+							};
+						};
+					};
+				};
+
+				tegra_admaif: admaif@9610000 {
+					compatible = "nvidia,tegra264-admaif";
+					reg = <0x0 0x9610000 0x0 0x10000>;
+					dmas = <&adma 1>, <&adma 1>,
+					     <&adma 2>, <&adma 2>,
+					     <&adma 3>, <&adma 3>,
+					     <&adma 4>, <&adma 4>,
+					     <&adma 5>, <&adma 5>,
+					     <&adma 6>, <&adma 6>,
+					     <&adma 7>, <&adma 7>,
+					     <&adma 8>, <&adma 8>,
+					     <&adma 9>, <&adma 9>,
+					     <&adma 10>, <&adma 10>,
+					     <&adma 11>, <&adma 11>,
+					     <&adma 12>, <&adma 12>,
+					     <&adma 13>, <&adma 13>,
+					     <&adma 14>, <&adma 14>,
+					     <&adma 15>, <&adma 15>,
+					     <&adma 16>, <&adma 16>,
+					     <&adma 17>, <&adma 17>,
+					     <&adma 18>, <&adma 18>,
+					     <&adma 19>, <&adma 19>,
+					     <&adma 20>, <&adma 20>,
+					     <&adma 21>, <&adma 21>,
+					     <&adma 22>, <&adma 22>,
+					     <&adma 23>, <&adma 23>,
+					     <&adma 24>, <&adma 24>,
+					     <&adma 25>, <&adma 25>,
+					     <&adma 26>, <&adma 26>,
+					     <&adma 27>, <&adma 27>,
+					     <&adma 28>, <&adma 28>,
+					     <&adma 29>, <&adma 29>,
+					     <&adma 30>, <&adma 30>,
+					     <&adma 31>, <&adma 31>,
+					     <&adma 32>, <&adma 32>;
+					dma-names = "rx1", "tx1",
+						"rx2", "tx2",
+						"rx3", "tx3",
+						"rx4", "tx4",
+						"rx5", "tx5",
+						"rx6", "tx6",
+						"rx7", "tx7",
+						"rx8", "tx8",
+						"rx9", "tx9",
+						"rx10", "tx10",
+						"rx11", "tx11",
+						"rx12", "tx12",
+						"rx13", "tx13",
+						"rx14", "tx14",
+						"rx15", "tx15",
+						"rx16", "tx16",
+						"rx17", "tx17",
+						"rx18", "tx18",
+						"rx19", "tx19",
+						"rx20", "tx20",
+						"rx21", "tx21",
+						"rx22", "tx22",
+						"rx23", "tx23",
+						"rx24", "tx24",
+						"rx25", "tx25",
+						"rx26", "tx26",
+						"rx27", "tx27",
+						"rx28", "tx28",
+						"rx29", "tx29",
+						"rx30", "tx30",
+						"rx31", "tx31",
+						"rx32", "tx32";
+
+					 interconnects =
+						<&mc TEGRA264_MEMORY_CLIENT_APEDMAR &emc>,
+						<&mc TEGRA264_MEMORY_CLIENT_APEDMAW &emc>;
+						interconnect-names = "dma-mem", "write";
+
+					iommus = <&smmu1 TEGRA264_SID_APE>;
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						admaif0_port: port@0 {
+							reg = <0x0>;
+
+							admaif0: endpoint {
+								remote-endpoint = <&xbar_admaif0>;
+							};
+						};
+
+						admaif1_port: port@1 {
+							reg = <0x1>;
+
+							admaif1: endpoint {
+								remote-endpoint = <&xbar_admaif1>;
+							};
+						};
+
+						admaif2_port: port@2 {
+							reg = <0x2>;
+
+							admaif2: endpoint {
+								remote-endpoint = <&xbar_admaif2>;
+							};
+						};
+
+						admaif3_port: port@3 {
+							reg = <0x3>;
+
+							admaif3: endpoint {
+								remote-endpoint = <&xbar_admaif3>;
+							};
+						};
+
+						admaif4_port: port@4 {
+							reg = <0x4>;
+
+							admaif4: endpoint {
+								remote-endpoint = <&xbar_admaif4>;
+							};
+						};
+
+						admaif5_port: port@5 {
+							reg = <0x5>;
+
+							admaif5: endpoint {
+								remote-endpoint = <&xbar_admaif5>;
+							};
+						};
+
+						admaif6_port: port@6 {
+							reg = <0x6>;
+
+							admaif6: endpoint {
+								remote-endpoint = <&xbar_admaif6>;
+							};
+						};
+
+						admaif7_port: port@7 {
+							reg = <0x7>;
+
+							admaif7: endpoint {
+								remote-endpoint = <&xbar_admaif7>;
+							};
+						};
+
+						admaif8_port: port@8 {
+							reg = <0x8>;
+
+							admaif8: endpoint {
+								remote-endpoint = <&xbar_admaif8>;
+							};
+						};
+
+						admaif9_port: port@9 {
+							reg = <0x9>;
+
+							admaif9: endpoint {
+								remote-endpoint = <&xbar_admaif9>;
+							};
+						};
+
+						admaif10_port: port@a {
+							reg = <0xa>;
+
+							admaif10: endpoint {
+								remote-endpoint = <&xbar_admaif10>;
+							};
+						};
+
+						admaif11_port: port@b {
+							reg = <0xb>;
+
+							admaif11: endpoint {
+								remote-endpoint = <&xbar_admaif11>;
+							};
+						};
+
+						admaif12_port: port@c {
+							reg = <0xc>;
+
+							admaif12: endpoint {
+								remote-endpoint = <&xbar_admaif12>;
+							};
+						};
+
+						admaif13_port: port@d {
+							reg = <0xd>;
+
+							admaif13: endpoint {
+								remote-endpoint = <&xbar_admaif13>;
+							};
+						};
+
+						admaif14_port: port@e {
+							reg = <0xe>;
+
+							admaif14: endpoint {
+								remote-endpoint = <&xbar_admaif14>;
+							};
+						};
+
+						admaif15_port: port@f {
+							reg = <0xf>;
+
+							admaif15: endpoint {
+								remote-endpoint = <&xbar_admaif15>;
+							};
+						};
+
+						admaif16_port: port@10 {
+							reg = <0x10>;
+
+							admaif16: endpoint {
+								remote-endpoint = <&xbar_admaif16>;
+							};
+						};
+
+						admaif17_port: port@11 {
+							reg = <0x11>;
+
+							admaif17: endpoint {
+								remote-endpoint = <&xbar_admaif17>;
+							};
+						};
+
+						admaif18_port: port@12 {
+							reg = <0x12>;
+
+							admaif18: endpoint {
+								remote-endpoint = <&xbar_admaif18>;
+							};
+						};
+
+						admaif19_port: port@13 {
+							reg = <0x13>;
+
+							admaif19: endpoint {
+								remote-endpoint = <&xbar_admaif19>;
+							};
+						};
+
+						admaif20_port: port@14 {
+							reg = <0x14>;
+
+							admaif20: endpoint {
+								remote-endpoint = <&xbar_admaif20>;
+							};
+						};
+
+						admaif21_port: port@15 {
+							reg = <0x15>;
+
+							admaif21: endpoint {
+								remote-endpoint = <&xbar_admaif21>;
+							};
+						};
+
+						admaif22_port: port@16 {
+							reg = <0x16>;
+
+							admaif22: endpoint {
+								remote-endpoint = <&xbar_admaif22>;
+							};
+						};
+
+						admaif23_port: port@17 {
+							reg = <0x17>;
+
+							admaif23: endpoint {
+								remote-endpoint = <&xbar_admaif23>;
+							};
+						};
+
+						admaif24_port: port@18 {
+							reg = <0x18>;
+
+							admaif24: endpoint {
+								remote-endpoint = <&xbar_admaif24>;
+							};
+						};
+
+						admaif25_port: port@19 {
+							reg = <0x19>;
+
+							admaif25: endpoint {
+								remote-endpoint = <&xbar_admaif25>;
+							};
+						};
+
+						admaif26_port: port@1a {
+							reg = <0x1a>;
+
+							admaif26: endpoint {
+								remote-endpoint = <&xbar_admaif26>;
+							};
+						};
+
+						admaif27_port: port@1b {
+							reg = <0x1b>;
+
+							admaif27: endpoint {
+								remote-endpoint = <&xbar_admaif27>;
+							};
+						};
+
+						admaif28_port: port@1c {
+							reg = <0x1c>;
+
+							admaif28: endpoint {
+								remote-endpoint = <&xbar_admaif28>;
+							};
+						};
+
+						admaif29_port: port@1d {
+							reg = <0x1d>;
+
+							admaif29: endpoint {
+								remote-endpoint = <&xbar_admaif29>;
+							};
+						};
+
+						admaif30_port: port@1e {
+							reg = <0x1e>;
+
+							admaif30: endpoint {
+								remote-endpoint = <&xbar_admaif30>;
+							};
+						};
+
+						admaif31_port: port@1f {
+							reg = <0x1f>;
+
+							admaif31: endpoint {
+								remote-endpoint = <&xbar_admaif31>;
+							};
+						};
+					};
+				};
+
+				tegra_sfc1: sfc@9700000 {
+					compatible = "nvidia,tegra264-sfc",
+							"nvidia,tegra210-sfc";
+					reg = <0x0 0x9700000 0x0 0x10000>;
+					sound-name-prefix = "SFC1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc1_in>;
+							};
+						};
+
+						sfc1_out_port: port@1 {
+							reg = <1>;
+
+							sfc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc1_out>;
+							};
+						};
+					};
+				};
+
+				tegra_sfc2: sfc@9710000 {
+					compatible = "nvidia,tegra264-sfc",
+							"nvidia,tegra210-sfc";
+					reg = <0x0 0x9710000 0x0 0x10000>;
+					sound-name-prefix = "SFC2";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc2_in>;
+							};
+						};
+
+						sfc2_out_port: port@1 {
+							reg = <1>;
+
+							sfc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc2_out>;
+							};
+						};
+					};
+				};
+
+				tegra_sfc3: sfc@9720000 {
+					compatible = "nvidia,tegra264-sfc",
+							"nvidia,tegra210-sfc";
+					reg = <0x0 0x9720000 0x0 0x10000>;
+					sound-name-prefix = "SFC3";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc3_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc3_in>;
+							};
+						};
+
+						sfc3_out_port: port@1 {
+							reg = <1>;
+
+							sfc3_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc3_out>;
+							};
+						};
+					};
+				};
+
+				tegra_sfc4: sfc@9730000 {
+					compatible = "nvidia,tegra264-sfc",
+							"nvidia,tegra210-sfc";
+					reg = <0x0 0x9730000 0x0 0x10000>;
+					sound-name-prefix = "SFC4";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc4_cif_in: endpoint {
+								remote-endpoint = <&xbar_sfc4_in>;
+							};
+						};
+
+						sfc4_out_port: port@1 {
+							reg = <1>;
+
+							sfc4_cif_out: endpoint {
+								remote-endpoint = <&xbar_sfc4_out>;
+							};
+						};
+					};
+				};
+
+				tegra_ope1: processing-engine@9780000 {
+					compatible = "nvidia,tegra264-ope",
+							"nvidia,tegra210-ope";
+					reg = <0x0 0x9780000 0x0 0x10000>;
+					#address-cells = <2>;
+					#size-cells = <2>;
+					ranges = <0x0 0x9780000 0x0 0x9780000 0x0 0x30000>;
+					sound-name-prefix = "OPE1";
+
+					equalizer@9790000 {
+						compatible = "nvidia,tegra264-peq",
+								"nvidia,tegra210-peq";
+						reg = <0x0 0x9790000 0x0 0x10000>;
+					};
+
+					dynamic-range-compressor@97a0000 {
+						compatible = "nvidia,tegra264-mbdrc",
+								"nvidia,tegra210-mbdrc";
+						reg = <0x0 0x97a0000 0x0 0x10000>;
+					};
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint =
+									<&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint =
+									<&xbar_ope1_out_ep>;
+							};
+						};
+					};
+				};
+
+				tegra_mvc1: mvc@9800000 {
+					compatible = "nvidia,tegra264-mvc",
+							"nvidia,tegra210-mvc";
+					reg = <0x0 0x9800000 0x0 0x10000>;
+					sound-name-prefix = "MVC1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc1_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc1_in>;
+							};
+						};
+
+						mvc1_out_port: port@1 {
+							reg = <1>;
+
+							mvc1_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc1_out>;
+							};
+						};
+					};
+				};
+
+				tegra_mvc2: mvc@9810000 {
+					compatible = "nvidia,tegra264-mvc",
+							"nvidia,tegra210-mvc";
+					reg = <0x0 0x9810000 0x0 0x10000>;
+					sound-name-prefix = "MVC2";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc2_cif_in: endpoint {
+								remote-endpoint = <&xbar_mvc2_in>;
+							};
+						};
+
+						mvc2_out_port: port@1 {
+							reg = <1>;
+
+							mvc2_cif_out: endpoint {
+								remote-endpoint = <&xbar_mvc2_out>;
+							};
+						};
+					};
+				};
+
+				tegra_amixer: amixer@9820000 {
+					compatible = "nvidia,tegra264-amixer",
+							"nvidia,tegra210-amixer";
+					reg = <0x0 0x9820000 0x0 0x10000>;
+					sound-name-prefix = "MIXER1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							mix_in1: endpoint {
+								remote-endpoint = <&xbar_mix_in1>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							mix_in2: endpoint {
+								remote-endpoint = <&xbar_mix_in2>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							mix_in3: endpoint {
+								remote-endpoint = <&xbar_mix_in3>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							mix_in4: endpoint {
+								remote-endpoint = <&xbar_mix_in4>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							mix_in5: endpoint {
+								remote-endpoint = <&xbar_mix_in5>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							mix_in6: endpoint {
+								remote-endpoint = <&xbar_mix_in6>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							mix_in7: endpoint {
+								remote-endpoint = <&xbar_mix_in7>;
+							};
+						};
+
+						port@7 {
+							reg = <0x7>;
+
+							mix_in8: endpoint {
+								remote-endpoint = <&xbar_mix_in8>;
+							};
+						};
+
+						port@8 {
+							reg = <0x8>;
+
+							mix_in9: endpoint {
+								remote-endpoint = <&xbar_mix_in9>;
+							};
+						};
+
+						port@9 {
+							reg = <0x9>;
+
+							mix_in10: endpoint {
+								remote-endpoint = <&xbar_mix_in10>;
+							};
+						};
+
+						mix_out1_port: port@a {
+							reg = <0xa>;
+
+							mix_out1: endpoint {
+								remote-endpoint = <&xbar_mix_out1>;
+							};
+						};
+
+						mix_out2_port: port@b {
+							reg = <0xb>;
+
+							mix_out2: endpoint {
+								remote-endpoint = <&xbar_mix_out2>;
+							};
+						};
+
+						mix_out3_port: port@c {
+							reg = <0xc>;
+
+							mix_out3: endpoint {
+								remote-endpoint = <&xbar_mix_out3>;
+							};
+						};
+
+						mix_out4_port: port@d {
+							reg = <0xd>;
+
+							mix_out4: endpoint {
+								remote-endpoint = <&xbar_mix_out4>;
+							};
+						};
+
+						mix_out5_port: port@e {
+							reg = <0xe>;
+
+							mix_out5: endpoint {
+								remote-endpoint = <&xbar_mix_out5>;
+							};
+						};
+					};
+				};
+
+				tegra_asrc: asrc@9850000 {
+					compatible = "nvidia,tegra264-asrc";
+					reg = <0x0 0x9850000 0x0 0x10000>;
+					sound-name-prefix = "ASRC1";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint =
+									<&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						xbar_admaif0: endpoint {
+							remote-endpoint = <&admaif0>;
+						};
+					};
+
+					port@1 {
+						reg = <0x1>;
+
+						xbar_admaif1: endpoint {
+							remote-endpoint = <&admaif1>;
+						};
+					};
+
+					port@2 {
+						reg = <0x2>;
+
+						xbar_admaif2: endpoint {
+							remote-endpoint = <&admaif2>;
+						};
+					};
+
+					port@3 {
+						reg = <0x3>;
+
+						xbar_admaif3: endpoint {
+							remote-endpoint = <&admaif3>;
+						};
+					};
+
+					port@4 {
+						reg = <0x4>;
+
+						xbar_admaif4: endpoint {
+							remote-endpoint = <&admaif4>;
+						};
+					};
+
+					port@5 {
+						reg = <0x5>;
+
+						xbar_admaif5: endpoint {
+							remote-endpoint = <&admaif5>;
+						};
+					};
+
+					port@6 {
+						reg = <0x6>;
+
+						xbar_admaif6: endpoint {
+							remote-endpoint = <&admaif6>;
+						};
+					};
+
+					port@7 {
+						reg = <0x7>;
+
+						xbar_admaif7: endpoint {
+							remote-endpoint = <&admaif7>;
+						};
+					};
+
+					port@8 {
+						reg = <0x8>;
+
+						xbar_admaif8: endpoint {
+							remote-endpoint = <&admaif8>;
+						};
+					};
+
+					port@9 {
+						reg = <0x9>;
+
+						xbar_admaif9: endpoint {
+							remote-endpoint = <&admaif9>;
+						};
+					};
+
+					port@a {
+						reg = <0xa>;
+
+						xbar_admaif10: endpoint {
+							remote-endpoint = <&admaif10>;
+						};
+					};
+
+					port@b {
+						reg = <0xb>;
+
+						xbar_admaif11: endpoint {
+							remote-endpoint = <&admaif11>;
+						};
+					};
+
+					port@c {
+						reg = <0xc>;
+
+						xbar_admaif12: endpoint {
+							remote-endpoint = <&admaif12>;
+						};
+					};
+
+					port@d {
+						reg = <0xd>;
+
+						xbar_admaif13: endpoint {
+							remote-endpoint = <&admaif13>;
+						};
+					};
+
+					port@e {
+						reg = <0xe>;
+
+						xbar_admaif14: endpoint {
+							remote-endpoint = <&admaif14>;
+						};
+					};
+
+					port@f {
+						reg = <0xf>;
+
+						xbar_admaif15: endpoint {
+							remote-endpoint = <&admaif15>;
+						};
+					};
+
+					port@10 {
+						reg = <0x10>;
+
+						xbar_admaif16: endpoint {
+							remote-endpoint = <&admaif16>;
+						};
+					};
+
+					port@11 {
+						reg = <0x11>;
+
+						xbar_admaif17: endpoint {
+							remote-endpoint = <&admaif17>;
+						};
+					};
+
+					port@12 {
+						reg = <0x12>;
+
+						xbar_admaif18: endpoint {
+							remote-endpoint = <&admaif18>;
+						};
+					};
+
+					port@13 {
+						reg = <0x13>;
+
+						xbar_admaif19: endpoint {
+							remote-endpoint = <&admaif19>;
+						};
+					};
+
+					port@14 {
+						reg = <0x14>;
+
+						xbar_admaif20: endpoint {
+							remote-endpoint = <&admaif20>;
+						};
+					};
+
+					port@15 {
+						reg = <0x15>;
+
+						xbar_admaif21: endpoint {
+							remote-endpoint = <&admaif21>;
+						};
+					};
+
+					port@16 {
+						reg = <0x16>;
+
+						xbar_admaif22: endpoint {
+							remote-endpoint = <&admaif22>;
+						};
+					};
+
+					port@17 {
+						reg = <0x17>;
+
+						xbar_admaif23: endpoint {
+							remote-endpoint = <&admaif23>;
+						};
+					};
+
+					port@18 {
+						reg = <0x18>;
+
+						xbar_admaif24: endpoint {
+							remote-endpoint = <&admaif24>;
+						};
+					};
+
+					port@19 {
+						reg = <0x19>;
+
+						xbar_admaif25: endpoint {
+							remote-endpoint = <&admaif25>;
+						};
+					};
+
+					port@1a {
+						reg = <0x1a>;
+
+						xbar_admaif26: endpoint {
+							remote-endpoint = <&admaif26>;
+						};
+					};
+
+					port@1b {
+						reg = <0x1b>;
+
+						xbar_admaif27: endpoint {
+							remote-endpoint = <&admaif27>;
+						};
+					};
+
+					port@1c {
+						reg = <0x1c>;
+
+						xbar_admaif28: endpoint {
+							remote-endpoint = <&admaif28>;
+						};
+					};
+
+					port@1d {
+						reg = <0x1d>;
+
+						xbar_admaif29: endpoint {
+							remote-endpoint = <&admaif29>;
+						};
+					};
+
+					port@1e {
+						reg = <0x1e>;
+
+						xbar_admaif30: endpoint {
+							remote-endpoint = <&admaif30>;
+						};
+					};
+
+					port@1f {
+						reg = <0x1f>;
+
+						xbar_admaif31: endpoint {
+							remote-endpoint = <&admaif31>;
+						};
+					};
+
+					xbar_i2s1_port: port@20 {
+						reg = <0x20>;
+
+						xbar_i2s1: endpoint {
+							remote-endpoint = <&i2s1_cif>;
+						};
+					};
+
+					xbar_i2s2_port: port@21 {
+						reg = <0x21>;
+
+						xbar_i2s2: endpoint {
+							remote-endpoint = <&i2s2_cif>;
+						};
+					};
+
+					xbar_i2s3_port: port@22 {
+						reg = <0x22>;
+
+						xbar_i2s3: endpoint {
+							remote-endpoint = <&i2s3_cif>;
+						};
+					};
+
+					xbar_i2s4_port: port@23 {
+						reg = <0x23>;
+
+						xbar_i2s4: endpoint {
+							remote-endpoint = <&i2s4_cif>;
+						};
+					};
+
+					xbar_i2s5_port: port@24 {
+						reg = <0x24>;
+
+						xbar_i2s5: endpoint {
+							remote-endpoint = <&i2s5_cif>;
+						};
+					};
+
+					xbar_i2s6_port: port@25 {
+						reg = <0x25>;
+
+						xbar_i2s6: endpoint {
+							remote-endpoint = <&i2s6_cif>;
+						};
+					};
+
+					xbar_i2s7_port: port@26 {
+						reg = <0x26>;
+
+						xbar_i2s7: endpoint {
+							remote-endpoint = <&i2s7_cif>;
+						};
+					};
+
+					xbar_i2s8_port: port@27 {
+						reg = <0x27>;
+
+						xbar_i2s8: endpoint {
+							remote-endpoint = <&i2s8_cif>;
+						};
+					};
+
+					xbar_dmic1_port: port@28 {
+						reg = <0x28>;
+
+						xbar_dmic1: endpoint {
+							remote-endpoint = <&dmic1_cif>;
+						};
+					};
+
+					xbar_dmic2_port: port@29 {
+						reg = <0x29>;
+
+						xbar_dmic2: endpoint {
+							remote-endpoint = <&dmic2_cif>;
+						};
+					};
+
+					xbar_dspk1_port: port@2a {
+						reg = <0x2a>;
+
+						xbar_dspk1: endpoint {
+							remote-endpoint = <&dspk1_cif>;
+						};
+					};
+
+					xbar_sfc1_in_port: port@2b {
+						reg = <0x2b>;
+
+						xbar_sfc1_in: endpoint {
+							remote-endpoint = <&sfc1_cif_in>;
+						};
+					};
+
+					port@2c {
+						reg = <0x2c>;
+
+						xbar_sfc1_out: endpoint {
+							remote-endpoint = <&sfc1_cif_out>;
+						};
+					};
+
+					xbar_sfc2_in_port: port@2d {
+						reg = <0x2d>;
+
+						xbar_sfc2_in: endpoint {
+							remote-endpoint = <&sfc2_cif_in>;
+						};
+					};
+
+					port@2e {
+						reg = <0x2e>;
+
+						xbar_sfc2_out: endpoint {
+							remote-endpoint = <&sfc2_cif_out>;
+						};
+					};
+
+					xbar_sfc3_in_port: port@2f {
+						reg = <0x2f>;
+
+						xbar_sfc3_in: endpoint {
+							remote-endpoint = <&sfc3_cif_in>;
+						};
+					};
+
+					port@30 {
+						reg = <0x30>;
+
+						xbar_sfc3_out: endpoint {
+							remote-endpoint = <&sfc3_cif_out>;
+						};
+					};
+
+					xbar_sfc4_in_port: port@31 {
+						reg = <0x31>;
+
+						xbar_sfc4_in: endpoint {
+							remote-endpoint = <&sfc4_cif_in>;
+						};
+					};
+
+					port@32 {
+						reg = <0x32>;
+
+						xbar_sfc4_out: endpoint {
+							remote-endpoint = <&sfc4_cif_out>;
+						};
+					};
+
+					xbar_mvc1_in_port: port@33 {
+						reg = <0x33>;
+
+						xbar_mvc1_in: endpoint {
+							remote-endpoint = <&mvc1_cif_in>;
+						};
+					};
+
+					port@34 {
+						reg = <0x34>;
+
+						xbar_mvc1_out: endpoint {
+							remote-endpoint = <&mvc1_cif_out>;
+						};
+					};
+
+					xbar_mvc2_in_port: port@35 {
+						reg = <0x35>;
+
+						xbar_mvc2_in: endpoint {
+							remote-endpoint = <&mvc2_cif_in>;
+						};
+					};
+
+					port@36 {
+						reg = <0x36>;
+
+						xbar_mvc2_out: endpoint {
+							remote-endpoint = <&mvc2_cif_out>;
+						};
+					};
+
+					xbar_amx1_in1_port: port@37 {
+						reg = <0x37>;
+
+						xbar_amx1_in1: endpoint {
+							remote-endpoint = <&amx1_in1>;
+						};
+					};
+
+					xbar_amx1_in2_port: port@38 {
+						reg = <0x38>;
+
+						xbar_amx1_in2: endpoint {
+							remote-endpoint = <&amx1_in2>;
+						};
+					};
+
+					xbar_amx1_in3_port: port@39 {
+						reg = <0x39>;
+
+						xbar_amx1_in3: endpoint {
+							remote-endpoint = <&amx1_in3>;
+						};
+					};
+
+					xbar_amx1_in4_port: port@3a {
+						reg = <0x3a>;
+
+						xbar_amx1_in4: endpoint {
+							remote-endpoint = <&amx1_in4>;
+						};
+					};
+
+					port@3b {
+						reg = <0x3b>;
+
+						xbar_amx1_out: endpoint {
+							remote-endpoint = <&amx1_out>;
+						};
+					};
+
+					xbar_amx2_in1_port: port@3c {
+						reg = <0x3c>;
+
+						xbar_amx2_in1: endpoint {
+							remote-endpoint = <&amx2_in1>;
+						};
+					};
+
+					xbar_amx2_in2_port: port@3d {
+						reg = <0x3d>;
+
+						xbar_amx2_in2: endpoint {
+							remote-endpoint = <&amx2_in2>;
+						};
+					};
+
+					xbar_amx2_in3_port: port@3e {
+						reg = <0x3e>;
+
+						xbar_amx2_in3: endpoint {
+							remote-endpoint = <&amx2_in3>;
+						};
+					};
+
+					xbar_amx2_in4_port: port@3f {
+						reg = <0x3f>;
+
+						xbar_amx2_in4: endpoint {
+							remote-endpoint = <&amx2_in4>;
+						};
+					};
+
+					port@40 {
+						reg = <0x40>;
+
+						xbar_amx2_out: endpoint {
+							remote-endpoint = <&amx2_out>;
+						};
+					};
+
+					xbar_amx3_in1_port: port@41 {
+						reg = <0x41>;
+
+						xbar_amx3_in1: endpoint {
+							remote-endpoint = <&amx3_in1>;
+						};
+					};
+
+					xbar_amx3_in2_port: port@42 {
+						reg = <0x42>;
+
+						xbar_amx3_in2: endpoint {
+							remote-endpoint = <&amx3_in2>;
+						};
+					};
+
+					xbar_amx3_in3_port: port@43 {
+						reg = <0x43>;
+
+						xbar_amx3_in3: endpoint {
+							remote-endpoint = <&amx3_in3>;
+						};
+					};
+
+					xbar_amx3_in4_port: port@44 {
+						reg = <0x44>;
+
+						xbar_amx3_in4: endpoint {
+							remote-endpoint = <&amx3_in4>;
+						};
+					};
+
+					port@45 {
+						reg = <0x45>;
+
+						xbar_amx3_out: endpoint {
+							remote-endpoint = <&amx3_out>;
+						};
+					};
+
+					xbar_amx4_in1_port: port@46 {
+						reg = <0x46>;
+
+						xbar_amx4_in1: endpoint {
+							remote-endpoint = <&amx4_in1>;
+						};
+					};
+
+					xbar_amx4_in2_port: port@47 {
+						reg = <0x47>;
+
+						xbar_amx4_in2: endpoint {
+							remote-endpoint = <&amx4_in2>;
+						};
+					};
+
+					xbar_amx4_in3_port: port@48 {
+						reg = <0x48>;
+
+						xbar_amx4_in3: endpoint {
+							remote-endpoint = <&amx4_in3>;
+						};
+					};
+
+					xbar_amx4_in4_port: port@49 {
+						reg = <0x49>;
+
+						xbar_amx4_in4: endpoint {
+							remote-endpoint = <&amx4_in4>;
+						};
+					};
+
+					port@4a {
+						reg = <0x4a>;
+
+						xbar_amx4_out: endpoint {
+							remote-endpoint = <&amx4_out>;
+						};
+					};
+
+					xbar_amx5_in1_port: port@4b {
+						reg = <0x4b>;
+
+						xbar_amx5_in1: endpoint {
+							remote-endpoint = <&amx5_in1>;
+						};
+					};
+
+					xbar_amx5_in2_port: port@4c {
+						reg = <0x4c>;
+
+						xbar_amx5_in2: endpoint {
+							remote-endpoint = <&amx5_in2>;
+						};
+					};
+
+					xbar_amx5_in3_port: port@4d {
+						reg = <0x4d>;
+
+						xbar_amx5_in3: endpoint {
+							remote-endpoint = <&amx5_in3>;
+						};
+					};
+
+					xbar_amx5_in4_port: port@4e {
+						reg = <0x4e>;
+
+						xbar_amx5_in4: endpoint {
+							remote-endpoint = <&amx5_in4>;
+						};
+					};
+
+					port@4f {
+						reg = <0x4f>;
+
+						xbar_amx5_out: endpoint {
+							remote-endpoint = <&amx5_out>;
+						};
+					};
+
+					xbar_amx6_in1_port: port@50 {
+						reg = <0x50>;
+
+						xbar_amx6_in1: endpoint {
+							remote-endpoint = <&amx6_in1>;
+						};
+					};
+
+					xbar_amx6_in2_port: port@51 {
+						reg = <0x51>;
+
+						xbar_amx6_in2: endpoint {
+							remote-endpoint = <&amx6_in2>;
+						};
+					};
+
+					xbar_amx6_in3_port: port@52 {
+						reg = <0x52>;
+
+						xbar_amx6_in3: endpoint {
+							remote-endpoint = <&amx6_in3>;
+						};
+					};
+
+					xbar_amx6_in4_port: port@53 {
+						reg = <0x53>;
+
+						xbar_amx6_in4: endpoint {
+							remote-endpoint = <&amx6_in4>;
+						};
+					};
+
+					port@54 {
+						reg = <0x54>;
+
+						xbar_amx6_out: endpoint {
+							remote-endpoint = <&amx6_out>;
+						};
+					};
+
+					xbar_adx1_in_port: port@55 {
+						reg = <0x55>;
+
+						xbar_adx1_in: endpoint {
+							remote-endpoint = <&adx1_in>;
+						};
+					};
+
+					port@56 {
+						reg = <0x56>;
+
+						xbar_adx1_out1: endpoint {
+							remote-endpoint = <&adx1_out1>;
+						};
+					};
+
+					port@57 {
+						reg = <0x57>;
+
+						xbar_adx1_out2: endpoint {
+							remote-endpoint = <&adx1_out2>;
+						};
+					};
+
+					port@58 {
+						reg = <0x58>;
+
+						xbar_adx1_out3: endpoint {
+							remote-endpoint = <&adx1_out3>;
+						};
+					};
+
+					port@59 {
+						reg = <0x59>;
+
+						xbar_adx1_out4: endpoint {
+							remote-endpoint = <&adx1_out4>;
+						};
+					};
+
+					xbar_adx2_in_port: port@5a {
+						reg = <0x5a>;
+
+						xbar_adx2_in: endpoint {
+							remote-endpoint = <&adx2_in>;
+						};
+					};
+
+					port@5b {
+						reg = <0x5b>;
+
+						xbar_adx2_out1: endpoint {
+							remote-endpoint = <&adx2_out1>;
+						};
+					};
+
+					port@5c {
+						reg = <0x5c>;
+
+						xbar_adx2_out2: endpoint {
+							remote-endpoint = <&adx2_out2>;
+						};
+					};
+
+					port@5d {
+						reg = <0x5d>;
+
+						xbar_adx2_out3: endpoint {
+							remote-endpoint = <&adx2_out3>;
+						};
+					};
+
+					port@5e {
+						reg = <0x5e>;
+
+						xbar_adx2_out4: endpoint {
+							remote-endpoint = <&adx2_out4>;
+						};
+					};
+
+					xbar_adx3_in_port: port@5f {
+						reg = <0x5f>;
+
+						xbar_adx3_in: endpoint {
+							remote-endpoint = <&adx3_in>;
+						};
+					};
+
+					port@60 {
+						reg = <0x60>;
+
+						xbar_adx3_out1: endpoint {
+							remote-endpoint = <&adx3_out1>;
+						};
+					};
+
+					port@61 {
+						reg = <0x61>;
+
+						xbar_adx3_out2: endpoint {
+							remote-endpoint = <&adx3_out2>;
+						};
+					};
+
+					port@62 {
+						reg = <0x62>;
+
+						xbar_adx3_out3: endpoint {
+							remote-endpoint = <&adx3_out3>;
+						};
+					};
+
+					port@63 {
+						reg = <0x63>;
+
+						xbar_adx3_out4: endpoint {
+							remote-endpoint = <&adx3_out4>;
+						};
+					};
+
+					xbar_adx4_in_port: port@64 {
+						reg = <0x64>;
+
+						xbar_adx4_in: endpoint {
+							remote-endpoint = <&adx4_in>;
+						};
+					};
+
+					port@65 {
+						reg = <0x65>;
+
+						xbar_adx4_out1: endpoint {
+							remote-endpoint = <&adx4_out1>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_adx4_out2: endpoint {
+							remote-endpoint = <&adx4_out2>;
+						};
+					};
+
+					port@67 {
+						reg = <0x67>;
+
+						xbar_adx4_out3: endpoint {
+							remote-endpoint = <&adx4_out3>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_adx4_out4: endpoint {
+							remote-endpoint = <&adx4_out4>;
+						};
+					};
+
+					xbar_adx5_in_port: port@69 {
+						reg = <0x69>;
+
+						xbar_adx5_in: endpoint {
+							remote-endpoint = <&adx5_in>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_adx5_out1: endpoint {
+							remote-endpoint = <&adx5_out1>;
+						};
+					};
+
+					port@6b {
+						reg = <0x6b>;
+
+						xbar_adx5_out2: endpoint {
+							remote-endpoint = <&adx5_out2>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_adx5_out3: endpoint {
+							remote-endpoint = <&adx5_out3>;
+						};
+					};
+
+					port@6d {
+						reg = <0x6d>;
+
+						xbar_adx5_out4: endpoint {
+							remote-endpoint = <&adx5_out4>;
+						};
+					};
+
+					xbar_adx6_in_port: port@6e {
+						reg = <0x6e>;
+
+						xbar_adx6_in: endpoint {
+							remote-endpoint = <&adx6_in>;
+						};
+					};
+
+					port@6f {
+						reg = <0x6f>;
+
+						xbar_adx6_out1: endpoint {
+							remote-endpoint = <&adx6_out1>;
+						};
+					};
+
+					port@70 {
+						reg = <0x70>;
+
+						xbar_adx6_out2: endpoint {
+							remote-endpoint = <&adx6_out2>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_adx6_out3: endpoint {
+							remote-endpoint = <&adx6_out3>;
+						};
+					};
+
+					port@72 {
+						reg = <0x72>;
+
+						xbar_adx6_out4: endpoint {
+							remote-endpoint = <&adx6_out4>;
+						};
+					};
+
+					xbar_mix_in1_port: port@73 {
+						reg = <0x73>;
+
+						xbar_mix_in1: endpoint {
+							remote-endpoint = <&mix_in1>;
+						};
+					};
+
+					xbar_mix_in2_port: port@74 {
+						reg = <0x74>;
+
+						xbar_mix_in2: endpoint {
+							remote-endpoint = <&mix_in2>;
+						};
+					};
+
+					xbar_mix_in3_port: port@75 {
+						reg = <0x75>;
+
+						xbar_mix_in3: endpoint {
+							remote-endpoint = <&mix_in3>;
+						};
+					};
+
+					xbar_mix_in4_port: port@76 {
+						reg = <0x76>;
+
+						xbar_mix_in4: endpoint {
+							remote-endpoint = <&mix_in4>;
+						};
+					};
+
+					xbar_mix_in5_port: port@77 {
+						reg = <0x77>;
+
+						xbar_mix_in5: endpoint {
+							remote-endpoint = <&mix_in5>;
+						};
+					};
+
+					xbar_mix_in6_port: port@78 {
+						reg = <0x78>;
+
+						xbar_mix_in6: endpoint {
+							remote-endpoint = <&mix_in6>;
+						};
+					};
+
+					xbar_mix_in7_port: port@79 {
+						reg = <0x79>;
+
+						xbar_mix_in7: endpoint {
+							remote-endpoint = <&mix_in7>;
+						};
+					};
+
+					xbar_mix_in8_port: port@7a {
+						reg = <0x7a>;
+
+						xbar_mix_in8: endpoint {
+							remote-endpoint = <&mix_in8>;
+						};
+					};
+
+					xbar_mix_in9_port: port@7b {
+						reg = <0x7b>;
+
+						xbar_mix_in9: endpoint {
+							remote-endpoint = <&mix_in9>;
+						};
+					};
+
+					xbar_mix_in10_port: port@7c {
+						reg = <0x7c>;
+
+						xbar_mix_in10: endpoint {
+							remote-endpoint = <&mix_in10>;
+						};
+					};
+
+					port@7d {
+						reg = <0x7d>;
+
+						xbar_mix_out1: endpoint {
+							remote-endpoint = <&mix_out1>;
+						};
+					};
+
+					port@7e {
+						reg = <0x7e>;
+
+						xbar_mix_out2: endpoint {
+							remote-endpoint = <&mix_out2>;
+						};
+					};
+
+					port@7f {
+						reg = <0x7f>;
+
+						xbar_mix_out3: endpoint {
+							remote-endpoint = <&mix_out3>;
+						};
+					};
+
+					port@80 {
+						reg = <0x80>;
+
+						xbar_mix_out4: endpoint {
+							remote-endpoint = <&mix_out4>;
+						};
+					};
+
+					port@81 {
+						reg = <0x81>;
+
+						xbar_mix_out5: endpoint {
+							remote-endpoint = <&mix_out5>;
+						};
+					};
+
+					xbar_asrc_in1_port: port@82 {
+						reg = <0x82>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@83 {
+						reg = <0x83>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@84 {
+						reg = <0x84>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@85 {
+						reg = <0x85>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@86 {
+						reg = <0x86>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@87 {
+						reg = <0x87>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@88 {
+						reg = <0x88>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@89 {
+						reg = <0x89>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@8a {
+						reg = <0x8a>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@8b {
+						reg = <0x8b>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@8c {
+						reg = <0x8c>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@8d {
+						reg = <0x8d>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@8e {
+						reg = <0x8e>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
+
+					xbar_ope1_in_port: port@8f {
+						reg = <0x8f>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@90 {
+						reg = <0x90>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
+				};
+			};
+
+			agic_page0: interrupt-controller@9960000 {
+				compatible = "nvidia,tegra264-agic",
+						"nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x9961000 0x0 0x1000>,
+					<0x0 0x9962000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x230
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+
+			agic_page1: interrupt-controller@9970000 {
+				compatible = "nvidia,tegra264-agic",
+					   "nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x9971000 0x0 0x1000>,
+					<0x0 0x9972000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x231
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+
+			agic_page2: interrupt-controller@9980000 {
+				compatible = "nvidia,tegra264-agic",
+						"nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x9981000 0x0 0x1000>,
+					<0x0 0x9982000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x232
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+
+			agic_page3: interrupt-controller@9990000 {
+				compatible = "nvidia,tegra264-agic",
+						"nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x9991000 0x0 0x1000>,
+					<0x0 0x9992000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x233
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+
+			agic_page4: interrupt-controller@99a0000 {
+				compatible = "nvidia,tegra264-agic",
+						"nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x99a1000 0x0 0x1000>,
+					<0x0 0x99a2000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x234
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+
+			agic_page5: interrupt-controller@99b0000 {
+				compatible = "nvidia,tegra264-agic",
+						"nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x0 0x99b1000 0x0 0x1000>,
+					<0x0 0x99b2000 0x0 0x1000>;
+				interrupts = <GIC_SPI 0x235
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA264_CLK_ADSP>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+		};
+
 		gpcdma: dma-controller@8400000 {
 			compatible = "nvidia,tegra264-gpcdma", "nvidia,tegra186-gpcdma";
 			reg = <0x0 0x08400000 0x0 0x210000>;
@@ -159,6 +3317,22 @@ pmc: pmc@c800000 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
+
+		hda@88090b0000 {
+			compatible = "nvidia,tegra264-hda";
+			reg = <0x88 0x90b0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA264_CLK_AZA_2XBIT>;
+			clock-names = "hda";
+			resets = <&bpmp TEGRA264_RESET_HDA>,
+				 <&bpmp TEGRA264_RESET_HDACODEC>;
+			reset-names = "hda", "hda2codec_2x";
+			interconnects = <&mc TEGRA264_MEMORY_CLIENT_HDAR &emc>,
+					<&mc TEGRA264_MEMORY_CLIENT_HDAW &emc>;
+			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu3 TEGRA264_SID_HDA>;
+			status = "disabled";
+		};
 	};
 
 	/* TOP_MMIO */
@@ -400,6 +3574,22 @@ psci {
 		method = "smc";
 	};
 
+	sound {
+		compatible = "nvidia,tegra264-audio-graph-card";
+
+		clocks = <&bpmp TEGRA264_CLK_PLLA1>,
+				<&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+		clock-names = "pll_a", "plla_out0";
+		assigned-clocks = <&bpmp TEGRA264_CLK_PLLA1>,
+			<&bpmp TEGRA264_CLK_PLLA1_OUT1>,
+			<&bpmp TEGRA264_CLK_AUD_MCLK>;
+		assigned-clock-parents = <0>,
+			<&bpmp TEGRA264_CLK_PLLA1>,
+			<&bpmp TEGRA264_CLK_PLLA1_OUT1>;
+
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.34.1


