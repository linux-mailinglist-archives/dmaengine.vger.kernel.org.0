Return-Path: <dmaengine+bounces-6725-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1ECBA8F3E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1411C36E6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A62FFDE2;
	Mon, 29 Sep 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZUn5zzjg"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57802FFDD9;
	Mon, 29 Sep 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143746; cv=fail; b=WvfNymrcKpo9OHgczd9Z43elQjU2XDkQRt7QDA6ILKB02Jyylk2nv6acbJPDnkTtgLSSM4WpIFpCgneF8SNrOMQli49CxbeFfs1mITLBGMJes1yrS8Icm8KAY1pwSI+OZXUfVRIVGmxKQpSdiG+ZopTarhRkwGvCPZQgqMu3IqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143746; c=relaxed/simple;
	bh=XhRnS8TvY0R9bbQpECJfWqFUnkKbO1NCVANbn9f5qaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5is7CLGk4sGgcsCHaz/ZcqOBMLKlKS/l66iEWvP1R+BTsZt0x+NBaZN5NMnum3thXxRYqhC6cbpCaWW5Ly9IpDy/E9EqQhd7jO0s+C3riqnNmW6j9D2/glSYyIpsfVs3kVTWVDsjTRm+G1FQEjifM1YESuh6yS0Tcri2wGx5v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZUn5zzjg; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYIV2ay67GVVCNhGW5jvbP+iSpSl2hQ2xh2y+5sueYBDDQNR2DhsJNBe9rKFMwjI/AfzF4H3oNmo2b/z4HOdKcBORxH+pJuGlCZUY3E96TqVXfkRlrSkUy1Y97RqLHM2WWjMsoQgwZX/EmEEgQbtmhQooSuYP3PD9UsW0VYDpKm+FRo9lzcv57PjKywphuVF2qjvWy5xCTYcnq2QfNJoN6yi8OyMt29rv6ph0tayWbiebncNpD5CycwsAeYrLk/r5tA7WD2qdCjpKhv3VPb9BuCN18lvPhAJBMpwyejjQWZrjn1qe33YszdpqsJyJAceUR0ihik986YjUdwmx6vxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr33LbVI8FcmxU+0g9l9hlv4CfdaSKqtyczjMH8zlcM=;
 b=xuYkpwG5KW8V073559kv9bNKdQzaBdlwGAf7WvA24QZPDK3wpCpt48LeXbc3u6IV4Its/MtbEkgpKziV/AJzI6asaEEGxiK4npJWwnwjpFgEiaHddPmrclO3zQBJ/yYTDBIx0VBfuQ0vZmmxYGKzuAVWhecE9J6XsE1s7+aP8hYsLRdD1qAOGPzUI7igIL4OAdbkKzCRONxWH9b4Q4rQD7dZrhw3TbmOClKwBDibW7SRL6e2SmsGUSwlRORgfNSrk/KdahF1k/7DeHNvl8XbbzJm1c3vTDA+5plft4qE9HVKqV4O/ZeoKnfK5DWXG6R7QvSD2uY7M+31D14ou2IKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr33LbVI8FcmxU+0g9l9hlv4CfdaSKqtyczjMH8zlcM=;
 b=ZUn5zzjgT/qARyvaWTd7yZZqJ/Tt0K/MoHbpxV0Tz7RHI76gOjOQA+uiiva//TjVwmRdrZuj5F3cF5qUe6ndfi5Nqtef1c8iCrexXlMSwaWsNETwhlehDwVX4eYqY19kZY3UVnKjzgTZ1ipjwQV9H5CXY0MykhJoSAVWpb3tZU7/VE92dfbuoyWxPdyjZHE2hUGRgC45Ynv7jz5HJ3PuyKbcfh32LHrctOQqx2K9tzQGnA70KLc7P7Tc3N1XUJVjlZHh8IHIyLBor3mpNrbALOWLNUgmjL/IMcFHBcm01Q7sMiaaCDXNsN2NLVRZVQHFli63qxknp+PXw+1rt/0Iig==
Received: from PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::34)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 11:02:16 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::62) by PH7P221CA0080.outlook.office365.com
 (2603:10b6:510:328::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 11:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 11:02:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 04:01:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 04:01:58 -0700
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 04:01:54 -0700
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
Subject: [PATCH V2 1/4] dt-bindings: dma: Update ADMA bindings for tegra264
Date: Mon, 29 Sep 2025 16:29:27 +0530
Message-ID: <20250929105930.1767294-2-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c11c309-0a14-4942-08f1-08ddff47a6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMcLJUPUH4dHidro3U+Iu5W6dKSQQE8WN8pl6RmJgHJHv1rEnGetoJDRJQWU?=
 =?us-ascii?Q?uHeKCMrNiaS18MLVk48/CcA9l7CqntmuymZuzJTt/yD0KSHxateGdYYnvQXa?=
 =?us-ascii?Q?aBNZqvirWuu4+Ge8ejoLB1AdK7ccoK6czAwBQFPCEf/f0EZcBegiTjZWJ14I?=
 =?us-ascii?Q?dkuQR52Zp35/KebvwbJEsOclyFxLE4I9NIWjcJtIX3FcRHGHHErhtQCVlbqe?=
 =?us-ascii?Q?qZyJudxaUi9zA6vYUru6r6s30SjZ+/iuMXbbfeet0Ctu+TbmdQxwJxNRziSY?=
 =?us-ascii?Q?GavWgyc5WckgpwdbSeBfahlBkZ/yCdzgBkyxelulWMfc9JHiyYwSo7PoZcTn?=
 =?us-ascii?Q?pQNCespilJIWElrnt9Rja9Sa87oIKXWwJEBwKLSI4aZj80T5eG6WlN1ovFHa?=
 =?us-ascii?Q?jRiTiikakV04tvQj6qZMEaZZkJhVvt5cF2/BqPdGUSr32Sa7vCrNAcu7MFYF?=
 =?us-ascii?Q?hbQm6eMv6TTB4/QPw6uJXBIqYRItD5nMerHulMh0KZfYT0hWJS7gwq+AIrma?=
 =?us-ascii?Q?+bOKa+qUbIJ8OBZqNzyx5k+KHM6iU40MpQtdD9F3wT0dworaCfy6nn0zRVhi?=
 =?us-ascii?Q?EjTsrHnppOOah8CMuuHmMo+GNiS7ya5RbwL4ZP01hpnV3p/xs+yoFFmhmteJ?=
 =?us-ascii?Q?jkkmuIcqOUs1GZ73zbVy4CD2TIr/+g7CSgV06Mx9oXshkHFFVelhJ7X1wYa0?=
 =?us-ascii?Q?Q6RESz+Zpl32pPyPXEdzLrQE6CVsZh5sI6ZIz6wDgZRS8VcRAlTi5sTplpBZ?=
 =?us-ascii?Q?1cQ2AyIh/mJmK4sj22pwx+KPJ/P7tNfju6g/6GGh6gCJKLp2M6CmRb4oR0Ig?=
 =?us-ascii?Q?sQZq2+rTGiHQ8J3AHQZemjvANaCPPXNfhmaUOetUi6tw6I80NPXEp13gm5gV?=
 =?us-ascii?Q?d0T5QroHZjTsjcdnoMq39piiFCmOaSMubce4LbKGM3SyWsnRCE8A8pnMVXY+?=
 =?us-ascii?Q?xrO5GSwtwjgDCtAmdQJsWKf2XVoGPkFqD50fBJSBSjGbCTT8Cwv+jHnbxISk?=
 =?us-ascii?Q?4p9Ogs3im/q3Iq9EL9XGQ+hCh4qUOzUeaRfn/SP9872HFaIRwGlA+xEefAps?=
 =?us-ascii?Q?YbhFBAXggFrrw1eEgyhnYSc7SFQWRyHVh/+zuHVPb4SCHSdeaK+TeOupMiCQ?=
 =?us-ascii?Q?BkWfGTuyUxdf/FqNX05yjNiOhI+exKUpZogFrPpWdYAJvHNRFWi+oFyesOsw?=
 =?us-ascii?Q?eyn9cz019atf7ViX8/3174RC0AVETPY54dY5A4RMiuGZkERGYD6GEplEn7Tl?=
 =?us-ascii?Q?TwhUEn02wSH9d8R2fH76eA+yShMArGerhkiZTp3Wv3AoUAOuvY8+E2Fewemr?=
 =?us-ascii?Q?6EWm7h0ZXcww3ZmcMJGGl+Hr2VZfbww020W+4FfeMgv4xegpISgwnjlqQtcJ?=
 =?us-ascii?Q?hIwi4TAHWvr2I/mOHhUT7yLgiVV7v6IItn+CdKRsJ2mSzpDIiTg6OBQGIUtQ?=
 =?us-ascii?Q?3yGywcxGEVT+m+fMsg1EZ1fV6YaIBA22j+D2J0WdoWe/c0YrRqNHB9PXttQ9?=
 =?us-ascii?Q?3TYsrft7WKr/VwyFRvKm+b+EEDAT/q0F2KRFzkWBAVXeNTYbili5wR0C3O6Q?=
 =?us-ascii?Q?5zTkuoC9l+d7jFC70Gw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:02:15.9071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c11c309-0a14-4942-08f1-08ddff47a6a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

From: sheetal <sheetal@nvidia.com>

- Update ADMA device tree bindings for tegra264 to support up to 64
  interrupt channels by setting 'interrupts' property maxItems to 64.
- Also, update the 'allOf' conditional schema to ensure correct maxItems
  for 'interrupts' based on compatible string, including tegra210 (22)
  and tegra186 (32) ADMA controllers.

Signed-off-by: sheetal <sheetal@nvidia.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra210-adma.yaml        | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index da0235e451d6..269a1f7ebdbb 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -46,7 +46,7 @@ properties:
       Should contain all of the per-channel DMA interrupts in
       ascending order with respect to the DMA channel index.
     minItems: 1
-    maxItems: 32
+    maxItems: 64
 
   clocks:
     description: Must contain one entry for the ADMA module clock
@@ -86,6 +86,19 @@ allOf:
         reg:
           items:
             - description: Full address space range of DMA registers.
+        interrupts:
+          maxItems: 22
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-adma
+    then:
+      properties:
+        interrupts:
+          maxItems: 32
 
   - if:
       properties:
-- 
2.34.1


