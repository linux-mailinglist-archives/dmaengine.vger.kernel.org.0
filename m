Return-Path: <dmaengine+bounces-4001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30DB9F4563
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A913188888B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E531D90A7;
	Tue, 17 Dec 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZjTfd354"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA51CCEF8;
	Tue, 17 Dec 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421467; cv=fail; b=cpHKILhJzyvk08w9LcYMndfjvuuM1jr0ZYyYql3xEie5Sb8hkQ0rE+oordzE7qs9/Ff9U6BXdzD3z/NT2T0CTVCbFSBw1B1yAQ3zD5//ltTkTDGou8TVKN/M9mPFjI4UDPRhOcGH/WG7BrC7zQd86YrlFbxnEYs3PZnF9/ow7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421467; c=relaxed/simple;
	bh=RqKXWU20Hn87zq836ji/BUkRXHC8+HPatpeJT1RIW3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYZqdhKw4gea2SA6U94TD/M6qHETTGD/I+ru0Nj3MD+ycYDSegb5+5NC53LeL3ftxJ2COkuFo79xPwVWdDUJRCNtxpzuiesCuB0LOS2jLhR/XTvdS3/yYB0FiClDR8w1b9zHAPkDPnivi63/avMc4UwWocUHpLT4Y9Ei3qBeRPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZjTfd354; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o091nLtu8HOMPAcUED+brBuWiQQE8vzWDINbkUN/lioODBG5cQft7QMRSRDn13FVV03Jpv9nn6DZRDc02edSO+LkgxPryIpvZBocULYfPWHRi9GziK0oYDQvZY44hDd3WW6VEIubTTeCBdt7I71wiMUUwSEAxmmfyWm50eb496r3MTKEzEfCDFukpgAORjI+PdcNng+KPHnucxwv9FWWtCjQoV74KZ5wb1Gs2LAW6Nh0Yr6c2je55pP8S3yLyCfnlEkw6rD4NtYsap1ek1Rz0Wp8vLYrGqi3bFwCslrz5D1bGveRo52YK4hGyawBCuFJdGFWpw9HbbJrRlyDJaUDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoCrYcbvwGybbgE24xOKs0EIylThFWF54UQdKYLSiHk=;
 b=lsd8PUlOhmsmvKCIKTo6fZBk2+MhdzaE7Pdz+utB4m+FLftZ/7QPnB6mp62p+O0eafQWUWt1lKl9Ft08RjEM6gY/OFtalyjCi0Vhf9fbZEUHVI2l1jorLYYGwjz83/rSM44UrZNEcRbvIoAyrPNVbghb577ZdWPPuHTkl1iGXR62iB0H94UJhwo8vb1XarIKfmsHHp1Ec9nnbH82VN+x82JK/HQH0AtuyQ6WWergEqNxDeaMnslr8Tzxh/BySE+TDFIDJw92vWe0ZE8orA4XEA1LLSB9gD3M0wOsZA79o1eq3ld5kHtq2Fmnifq+mZMKFh0zjJYW7iOX+WmZGgiFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoCrYcbvwGybbgE24xOKs0EIylThFWF54UQdKYLSiHk=;
 b=ZjTfd354DmHQyH4kZUxFORPIN9alMb8vjCFtrvjE2KMxpkAJGj+RbVi79PbHEEM0vKVpv7kYIEoiSYyobk3ZNwzvpoWTbfq0LlRtaBrkhCo1QJJ34dRQqUFayOSMpRH3Yjw8LGb/qtnlI6T3OZNFtWsuPZb5rPcavnf7c99VwBRb/9HT+goOSR5uZ1F/fuMb7uMmRPRpa4+oQcvHKfr9SU+HfTk9zX9KMi9jPyZNETz6GP2e+aq0q3Mg1f9DqUk5qL//BfbrhrMOvBA2JCj1MHCzJ+o3xfFLuv8tvDbe5RpKNsxObzcu+HFOeAY4F3P1jb4IB9WPIaaY61Ay8rYPRA==
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 07:44:21 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::d5) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Tue,
 17 Dec 2024 07:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 07:44:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 23:44:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Dec 2024 23:44:14 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Dec 2024 23:44:11 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>, "Mohan
 Kumar D" <mkumard@nvidia.com>
Subject: [PATCH v2 RESEND 1/2] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
Date: Tue, 17 Dec 2024 13:13:57 +0530
Message-ID: <20241217074358.340180-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217074358.340180-1-mkumard@nvidia.com>
References: <20241217074358.340180-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 745f9210-6303-48f5-ff94-08dd1e6e9e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDYo3zgcJwKAAM4m8uhshhsy71TwKrAmMQl1JW2lALIBV3XqNbYPe/mCaToS?=
 =?us-ascii?Q?PzJL683qAstAmTUcaO7xKLIw7X/+jQWoUOEpYmWCWbMhlDHYlF7qr/S2m08v?=
 =?us-ascii?Q?YvsaJXw1KfAtIL8f4HevmuF5SJGzke5xVQIW0r731qyLncdPeYiwQ8TbTKaK?=
 =?us-ascii?Q?t0xPJIeRH7PuslYmEikqe8TrPmhcs4NT7X8E0B3DGj3sV0Spx4REmrcFmfZy?=
 =?us-ascii?Q?kpgomZNEPL3lqKbwg1+yrCCShzGuStqfQCM1iO/jP8231mcm47bis3fCM7Wo?=
 =?us-ascii?Q?BNqGjtQTgCenOwzqqLmGaLzrkD63wV0HHCeVSgkkbgM3wEOVBkFrGYkfM7g5?=
 =?us-ascii?Q?8TVWBq3832GLTjChXGIYTRNIlyluZ0eOKyHE3ZCtHUHCKb622wW4JLmkpkCg?=
 =?us-ascii?Q?L4aEX/bFQuOGU6rHYyB69pc9Fy5HOZlze/cgbqKnL87YydRQSLBgfQs7Rii1?=
 =?us-ascii?Q?+en0VelCWR2dThsOR8QGWkv9q5TwF6OZ7t6L0tahmL38YMT4KsXkq3OXwac7?=
 =?us-ascii?Q?Trpd3Ctmt6ZyJnz2bXIUDVF5d2pj1u6SviaTkr87JMO4QSNKAcrpevDj9jFz?=
 =?us-ascii?Q?LCJH8PYHPnchuqirfTsbFwDTIwA/RQNbOEwfuXZvMT6Hi9ORGaZ8+G023q2r?=
 =?us-ascii?Q?qjxvbpMd5yI5MWzOQIUWffhJWOeDiI5ZPwbSkEcqiMgxHA2zHhOSpRE3dNaw?=
 =?us-ascii?Q?KvRfpZbtJi/i2r7ff183XDbZBQFSB5m6iG7bE8D/DwPIgbDzyBXnTltx+EIW?=
 =?us-ascii?Q?FXXooWWKygSCR5J5GKw6HnWtSoUIbHP8OJxV+TbdSW2ttsiFrRCsDRkTaU6y?=
 =?us-ascii?Q?zc5o0e6kXuxI19bagDMZRQWB0QLiU1tNQkffWXy9+E5s6RZZ1Yt18d9a7JH1?=
 =?us-ascii?Q?ry/zS4CX3xH9srvn6E5QobQAVfS03bpSY1Mo0huR1UmR3U/+o9QsEtEYeUkX?=
 =?us-ascii?Q?A3HdqQw+1e8HpS8o5h0Ru6t8ySS6VSpTf2mdZI8hTcMUd99ISZbjtQzQ6T2G?=
 =?us-ascii?Q?hHSQQ5fGNbz72jeS55mAhmBQ6fMOPqt9OcEdkc+l5Bnb6Ybv0KexUdH0Xl9v?=
 =?us-ascii?Q?HAvqYJ6/ibLhaD5Z4uExKVnCydw5Ol7LAxne0cRE3St8A9r0jk5B6Ie8M6pF?=
 =?us-ascii?Q?7vj5ixfzw52EMB4mdzKxA1BZU3+wQRxpwqcIpZcG8GzqK8TB1BRG8mM3l87q?=
 =?us-ascii?Q?A44x6+bbkp4o3M4qr9izxAWIWYpqogEw7Wh3MIsDwWhWXNOX5qO9EJwleHpp?=
 =?us-ascii?Q?Pv79LXT6eQJUX+ICm2yOpnO1kGYG7qxyTGCPAd5oz12+Y21FIINWCoorreBY?=
 =?us-ascii?Q?kRDCMO0zFE0bWHlEyuT3yWhdrns2E/OZbrYLEQrdAM3q5iMSxiRZp1phrxbp?=
 =?us-ascii?Q?eb2K8EupIi0sBQL25dt9kpLu/9eG4DWTnOWTNSFCD9LDQVSJORrJ9BrK3XWe?=
 =?us-ascii?Q?Atvf/KILEfkTPBPR+K6G/LGrOwam7RlqkeXSBLYiv8jNAVpcN3dtZF2gPSSG?=
 =?us-ascii?Q?Ejg/iZxXuNZQ/UE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 07:44:20.7797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745f9210-6303-48f5-ff94-08dd1e6e9e52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

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


