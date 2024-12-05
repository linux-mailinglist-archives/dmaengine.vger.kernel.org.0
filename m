Return-Path: <dmaengine+bounces-3906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B39E5908
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63A0280FC1
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8543D21C9ED;
	Thu,  5 Dec 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8auwdSY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE600219A7E;
	Thu,  5 Dec 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410771; cv=fail; b=nbAXxVNuruWObmm8S5H3BqwnmUND7kh+Eii3/sleGcQCvW7tlZFO0Sn9/jgyxCo73O3b9VuxW5vkqvcqBDl1X/KXR34QspjNLUwOqA3I/t6PozMSsSYX6v1Frcaw5N/ZdIotKOcH5ia7VmhsYf0ND0Jy8/gElLiZh1cMfPyewSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410771; c=relaxed/simple;
	bh=25EpQtslEoZXZxqhKcgPVKgpBriz4CPz/erODDybkMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1C0jz/Z3H0HVzMR7VgpK/XmPvKPFNvjYR+iTkBhIA60DkfsExSJEMGC2hgEQz/n94a+FBlzd5wEUqP0yVtdSwfYhYWATxrjFErDSRJa8X42L9pTrsfVE1SC7tvcL5tqEVcWyf4sOTWWGFTQ+hnx1+8bd2uyGqpdR4yI7BqWeF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8auwdSY; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV1d4SLelABM8vv7nSGNLH+OnOF0JSTiZwDqG9avabSufKNEXgXwaMoWSUw828t+YPJsRjtp6NUBMPoy3Lw6J02mnxJuYQhIm32l1oYbzbNsYRK5YA1Cve0WEGoVnLDE9o1IffR8JEGmeuQHXpmXuJBF4gQXuWIOAu7IHKBlH3vHvZaYi5R3v7HiToAGT8OPG61lsNSUJfsi6LCtjJrco5+cAdZFY3e+15Q3Z2o5ipG1O/qW5zf1B2qPhjdQYCrrcrw2CtGUMylxWkE0yhN5FstxCNjPawQlRrGfLOmK7qk1MD7XTVyQa5lCsEj+suMrLD6WWAItyagTF8Lv5ohwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqSfowizJ+KZyeyK1/yi4DfP/YFjwCJk9OFpN1Pjd0c=;
 b=SRiUjNrMWuiaUrAagAbvWprhnaRUsmkF1xVQ5FPEK/xAXvWMho7lxvETFoKjxkB4DjFI0BpZzBPktSTVobajGweT3a5r9U0MyLKpJT3SsrpcqSTmLVeW0be44LKAX7uMRBpIz6WJfsFNCw1TRIt/GZAGf8R9b8aVob7mb+iqosULyikCJleZlLo6lSJWeLDajN2Jrx/npJb1e+K1jMWd8kWyJ5RWgHKDnQZ3NpIVZjkGP8qVaanyMBjd7cXsKVVQXjcAuHTBgmUVAlS/Hp1IiUUcGiHZeCP57fFmiTmSAdvuDroXDxsLPX9oRF+ORX2SazNF76VWWJhM393Ei2iOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqSfowizJ+KZyeyK1/yi4DfP/YFjwCJk9OFpN1Pjd0c=;
 b=V8auwdSY9leK03Cabh7O4IeZB3xE0Yie3dxwuRcuPhlbWtjsyD28ZkDPJCsa7uNE0BZ0TCs1HYZGAxpav8BAEFZczH/T4Nb4Gfz+6gO/juf23V/F7biZxst5DBKQOcozN8hVPzF09zsA6IU2JH6eqQZtx7Z7UlzHeWOsIcQMMrRUebIdQynhmhGw5GUDskACl31a9O+i1HauTepCRaVdq8d3ks1enzIGyejisl2ZhRB3ZJSWd5GrQcJqxFBlmKASjct+t3TK+4BFWCnflnWagPKPyNcAg9UztCfUk0jruYIYNY4ss8HPDxCGFCf+7P1a1smzsFB+tNSxePToFJRu9w==
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 14:59:25 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::9) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 14:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Thu, 5 Dec 2024 14:59:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 06:59:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Dec 2024 06:59:11 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Dec 2024 06:59:08 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
Date: Thu, 5 Dec 2024 20:28:58 +0530
Message-ID: <20241205145859.2331691-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205145859.2331691-1-mkumard@nvidia.com>
References: <20241205145859.2331691-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ff4009-503f-4f85-173a-08dd153d6860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRgflKqmCGvzBa9xhOYFRlTOetr118Y5/Y655HtCgnjCrwpnh4CqOz2YZqAh?=
 =?us-ascii?Q?t48dGQP3z8rTWbCVzpahHT9EMd8SeNfcebR6Fiqm8i/r4Ob+Igir7hLAkQaO?=
 =?us-ascii?Q?57iVnGj1WL1Gu9NeXjv0rMqSOi9Ejh4hKwZ22UhnKuri/4pXaNWlPtoPHdSs?=
 =?us-ascii?Q?aiB0arUmENUInmOCYZhfS4BuuXmzfjBsg4KIrYujyNYbQoqD7n/tL6PEddxP?=
 =?us-ascii?Q?nEViC9ykqRkZfJng6T4CBNdTgzv/SqO5jsx1EIc37KiFiePNm0cAKTe5dj3S?=
 =?us-ascii?Q?U3HCHk0Y5znHmwpGRxPlxYAjw50SuvUkkEnSsLarwbjzcB7a0ApCC/81wVJy?=
 =?us-ascii?Q?ApxD9c8YkXk2sr9fVQXpPpSGaCmDYSvwDRUFtgleQUCihNAXhH7PuR57fHZ5?=
 =?us-ascii?Q?euPi051LdnsJaB7ATBOjs5dTjm4qR95Mxre9JHcQpHveNwiGtnXcNpkWYSoo?=
 =?us-ascii?Q?JKq2A8OpU2fjwVZjUGcNsiL/PfORQKvXycSv8dQK0EEA7FPGm3rPX3wVC8ah?=
 =?us-ascii?Q?vvmOUJS6+c5d1zyCD2WjhLHwZ4GiRPEWz3NZ/HDtOhuNhfEUyM+gsXXNGn/o?=
 =?us-ascii?Q?7RT3+LIWSQaImBlguAW9S6eyNT5yRjy9lZo5zEl1xyY4jRzK0PbnHYzdUOBk?=
 =?us-ascii?Q?tUCZyVWCFtQDlZjOdDT3vaxHbN2ggbakwaIrURvq1YrTgylP+YAA7iKc2xcd?=
 =?us-ascii?Q?jfJqJkeT1sp+YWdvK7f6I0IpilSelAbbOFYpBbTokTdgBaR5VzHhThAA6qV5?=
 =?us-ascii?Q?pdXWMHrY+6T9CMJs1xqS9BM8c4nuwUp5ue3AYCIYAZnFIJvXOUBiMLvzrbmZ?=
 =?us-ascii?Q?zCs5dlmXPXPpPI4lw3hC0UrfA5WBRpBUApIGh1qsTm+SNQvyfgKcZrSiPQYs?=
 =?us-ascii?Q?GqaVKyGiv/TAxLYEt9oEyTGoMd0LLKub3vv0a/7P5YCoEa5JEARn9p4YknXP?=
 =?us-ascii?Q?KkvtPgXUmtAuOiH5RHm6IVPlZgf+/YBfjtmoIgboNpeIND6Adxxal2c0ZfT3?=
 =?us-ascii?Q?hxmlGedEAsi1c+yEqWjiakYAFnWiSVH6hdAIiVajQkq9T07xlM9Su5Z145GK?=
 =?us-ascii?Q?iJ/0VcYbE/hkT6GajHzg4sujuBngAplR3cWAg+Tkwb+D6UpJGxGV5wUqoKFa?=
 =?us-ascii?Q?USBymvOiNa7Yc4zZSItNApDIDVVTNYbIgFpol5K/zSJkIxroo+dGJ9UbneV3?=
 =?us-ascii?Q?AK6fLq/iSt7aXVDW5fwmvXSWyF+D53XEjNz/phLXIMzPyYI21dQmuE6iRkr3?=
 =?us-ascii?Q?qK4rnQUC5O66W9b5YRSIzRLKENzCaCDLmrPxnJq09LGhC8CjeHATAztyjOHD?=
 =?us-ascii?Q?RaLicMeRFlD4PBWpQzW4FmBrBf1Yj1t3+ULwlIDUoAzC297J1qJRJIaSXuaF?=
 =?us-ascii?Q?j6/TBXdIcBdEmT3O0mgfVj/aSp73UrP+fbnFuIeeiWgVJhVj0UVv2W7fKE0N?=
 =?us-ascii?Q?q4k2USvJ8P8Lx6qx+B0/am28qoeQqLFC?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:59:24.4482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff4009-503f-4f85-173a-08dd153d6860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Multiple ADMA Channel page hardware support has been added from
TEGRA186 and onwards. Update the DT binding to use any of the
ADMA channel page address space region.

Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 .../bindings/dma/nvidia,tegra210-adma.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 877147e95ecc..8c76c98560c5 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -29,7 +29,24 @@ properties:
           - const: nvidia,tegra186-adma
 
   reg:
-    maxItems: 1
+    description: |
+     The 'page' region describes the address space of the page
+     used for accessing the DMA channel registers. The 'global'
+     region describes the address space of the global DMA registers.
+     In the absence of the 'reg-names' property, there must be a
+     single entry that covers the address space of the global DMA
+     registers and the DMA channel registers.
+     minItems: 1
+     maxItems: 2
+
+  reg-names:
+    oneOf:
+      - enum:
+          - page
+          - global
+      - items:
+          - const: page
+          - const: global
 
   interrupts:
     description: |
-- 
2.25.1


