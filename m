Return-Path: <dmaengine+bounces-3966-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C439F09C6
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD3E188CA53
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67C1BBBD4;
	Fri, 13 Dec 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRmnNs/o"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6E1B415F;
	Fri, 13 Dec 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086416; cv=fail; b=JVfpEsVBwHlhZ2OWzjNN9+a2CKk3qAcFCz20Y8vqpUEgOoCwlhtTg+9l8k/PhZfqwToCHf6BsRictwWIXFZi/opqO0Ynd5a/VCAoRQYMyjlXZh6Ix+mVYtDGhssLvNBp06CDR8UIs0ofN+KMDXK3FVPzbsQudtyG6YDmBxu++vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086416; c=relaxed/simple;
	bh=RqKXWU20Hn87zq836ji/BUkRXHC8+HPatpeJT1RIW3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuIbGBAKSXBQCYQe2izkOospEAe0aT93XpEqjZcV6LyEy9p/MK6AHDDNT3YmgMt3TGsGp95cvtYI1BzXfUFECg/kDv99xj68nJVR59VAmpH3fOkYSEgbqi+teRcLzGsOmPj7sAh5zfhgPQEd6ygwUV/TOB7DEoyHn6QeilueC4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRmnNs/o; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7GcJcN9CK6kC1j52mA68Vuzs/EioslhAVkvXiWfH+2q1QgaNfDGjeNOaiLfP7c9prcNNx9KEfXbemquGqgH8usOkyqefbVbCErPEzx5gzkFv5t1nrvAEWD5o0plcaJP/PV6z2xmqhiMOqNjZ5JgbdM9aH6A3j5fp48C4uHg7aN91GT+YKojG7ezgmLpxLd5kfV1DHRJ3XLL26RcdYSu7SDgRQV+YT9na1+nANHSHp9MoZUGNuafRk3N9ZasWQRcdr0jNPX60tKCWtAkN1vpH3AC7Fq5vafodJ758vRRdXO/MMQDe6XcSAlAmFPD1lpGH3VBBK1qJJdewI1Dk+oA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoCrYcbvwGybbgE24xOKs0EIylThFWF54UQdKYLSiHk=;
 b=wSR74SzdYBOBtH4FUFqiLvnQAJ5nkUxEOco15QpN03soY4NRfyzwIwraTUxJLJkUhUXyb/BUZvDVHwy+FfjW7kv6sF6AsNZK/9Sfyq9EsydezAKDu7d9nBy6AtlTncI5azyVWuKI5QKKyW+mwPqruCqs4K9N4Pta6zpHQrwHube0aQbcgbe5ZIjKB1py+KPKCpsnzmEE9lC9o651lJYdNQrmIJLLZSd3auKY5PXY18abfq1aWZ8q0r95NltrydS9GZpwX+eETP01jLYufpTReH1aW/9Eya1oCHnrsZ4R1R5565wXIgVnRpYjwHyzSpqinBBZqBaiM6J6obsOon2UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoCrYcbvwGybbgE24xOKs0EIylThFWF54UQdKYLSiHk=;
 b=BRmnNs/oOG9e4CnhvmSfOFKl6+8kGgY/VAYc4s4t8eOOuPuUH7nwyK6wA6bnGReOu1JxQf49EKmOKFWa8zJWXaf4aTJbVT3RdVFoII6rDuIe7DybNTPTPbl6Ek9LCUw07zTJlwmyDVnqIhEbnxM/iV3XsY1yuL9vbt9SVreSlbl2JrMplS2JqR2DRscNNY4cO03Q1wnbNpzdk3GQN74PHZipvALRVvXmnsyL39sqWra1t6yttdmUJ5/oVXV8Q76wUmp8/0cEBCiSbgM+GBcDQrmvQKu0svBaF8H6J647J6Q1ocg20jIiCyTBXJ/NpkiDBk+zt4MhgBvNO90NT8IzEw==
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 10:40:09 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::ec) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 10:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 10:40:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:55 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:55 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 02:39:51 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	Mohan Kumar D <mkumard@nvidia.com>
Subject: [PATCH v2 1/2] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
Date: Fri, 13 Dec 2024 16:09:38 +0530
Message-ID: <20241213103939.3851827-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213103939.3851827-1-mkumard@nvidia.com>
References: <20241213103939.3851827-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: e7892e99-2e8b-4766-ca42-08dd1b628395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbzjfaUt6dLukBcdQXE3uFRIq0uHYchFXNduq+ztan+NtMRYFDijU8OLUoVM?=
 =?us-ascii?Q?B4LtH2It/0la4ypHks4/Ic8BLNiJb4yiQpbuFePRF+gxEVY0H8qaE+2cKLky?=
 =?us-ascii?Q?N9o4sIvC8nHszfCchk4Kahk9wmgUfMnGzmNjUO2dgh60FV89SUVxOMfNgDtC?=
 =?us-ascii?Q?rqyPxdY3snrn9fA3+SxfOSEVTrwRu8f0IEvsID4zDRSGq6Te3n6eGBvwCLcf?=
 =?us-ascii?Q?Rk7ANimRcSbXmmNu/5qyivkEa7Nnvn7UyNQV6AjSR1ApnMtM3sBByps/g7Oa?=
 =?us-ascii?Q?HC0WaXfeXpn5cYWcJqz1OJG6TMqAOmOOlzwQAl3jCdsJZ5NhZX/qQRrnv4Gp?=
 =?us-ascii?Q?bhS5mrcIrRVEQ+iDSjO5DzxWlhHUSLXXnlWEOnm5qzPIRb8kTAXeRJCeDcpQ?=
 =?us-ascii?Q?ZnAZomjfR3kaGtTFOQJtNYbNl5YYJv7WnpKAYqKPopq+ec33ZTggUuwcZKfX?=
 =?us-ascii?Q?pspbaZn10m5bXQE7fQjwOspQ0I2YYT6mRpsebRIDA7dEMVe6PVyVYBXwcFxq?=
 =?us-ascii?Q?YYrr6/zn6T39Cv5do6MfLOv6xpXqbew0cSH1jLdfChoOse+koCprKl8cJmYl?=
 =?us-ascii?Q?QdQ/7tkNgSr51eFeFqRuo16UcOyG2EtHHvZumKRRy6MGYVtrzeiXzDwdF6VG?=
 =?us-ascii?Q?lNPyEADISuUqhqNBMJKyCJMdvVwOkjy84DgemWdYtetk2PdQnj2vvCHclOCc?=
 =?us-ascii?Q?ReW/aV9awVe26WG3NR+b7pWxWsbahSrtsLs/GK+q2MbJo+ntYMpkAcvmPUuB?=
 =?us-ascii?Q?Q9Kkooz1DeNvccQwDHqzIdOUdTXn/0YyrVpjDYPE5kml+mHd2HrRNEi3qbxC?=
 =?us-ascii?Q?BXXhh3L0hQSTdiUAPCcSPq7Ek8oGQjlPwJ+B0lKIopHzT2ZwNqYI87/PYXlM?=
 =?us-ascii?Q?DUwTn0/IvsRo8ODLTRTWDEu8qmZa9hPljENGcS3rdmNj4V+Ff7o2vxjzw+Ie?=
 =?us-ascii?Q?QWPho/KshYnNsk8bJx3bACSArZlOAhEg7jLNVfY66Vux6tmqeUmQrbRUIORv?=
 =?us-ascii?Q?7joYyS/xcjYnKLikUI1lF7E72KENl9wqSdS20vSSnvUgBWTrM8Kz2DemHZkj?=
 =?us-ascii?Q?bW7mm4KN/P3goWgJPtP0GCol02eRrhvtN6XoTDag2DdSuCornTkHPnpxxi9/?=
 =?us-ascii?Q?Xxq9hA70H0slbHWZolZyCIR71tEQ/fluqTTAd30kVrHZQiJxl5CfM1LTUMqF?=
 =?us-ascii?Q?X7Vsf6WauYOdMkb70JvvxGmJTFwkvvJSjf1dg/o9mBEK563BGMpXHofmoAj+?=
 =?us-ascii?Q?pBOPsTVrTMFcPo/T9PznIJ9QSWyKVgLawXGTSbtmDfAJA3VNPSBNi5T4ruHt?=
 =?us-ascii?Q?f8pZpy135xYmdrH2x1mZuorCdWrGEW+h9h7RySuT2ssYDkL68hL3WGE4x6pM?=
 =?us-ascii?Q?KJPpwRA+8dMA0YslsRyoermqUXXzM2L5YFfmwWmqekFvUqN0t3N/gskdNBij?=
 =?us-ascii?Q?VsFkWoMnEYd74GLI9GRgNbOQHXHEddGd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:40:08.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7892e99-2e8b-4766-ca42-08dd1b628395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

Multiple ADMA Channel page hardware support has been added from
TEGRA186 and onwards. Update the DT binding to use any of the
ADMA channel page address space region.

Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 .../bindings/dma/nvidia,tegra210-adma.yaml    | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 877147e95ecc..d3f8c269916c 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -13,9 +13,6 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -29,7 +26,19 @@ properties:
           - const: nvidia,tegra186-adma
 
   reg:
-    maxItems: 1
+    description:
+      The 'page' region describes the address space of the page
+      used for accessing the DMA channel registers. The 'global'
+      region describes the address space of the global DMA registers.
+      In the absence of the 'reg-names' property, there must be a
+      single entry that covers the address space of the global DMA
+      registers and the DMA channel registers.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     description: |
@@ -63,6 +72,49 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-adma
+    then:
+      properties:
+        reg:
+          items:
+            - description: Full address space range of DMA registers.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-adma
+    then:
+      anyOf:
+        - properties:
+            reg:
+              items:
+                - description: Full address space range of DMA registers.
+        - properties:
+            reg:
+              items:
+                - description: Channel Page address space range of DMA registers.
+            reg-names:
+              items:
+                - const: page
+        - properties:
+            reg:
+              items:
+                - description: Channel Page address space range of DMA registers.
+                - description: Global Page address space range of DMA registers.
+            reg-names:
+              items:
+                - const: page
+                - const: global
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


