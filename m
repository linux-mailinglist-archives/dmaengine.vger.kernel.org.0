Return-Path: <dmaengine+bounces-5131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57DAB2E99
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 07:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804241732EB
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 05:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD12550B0;
	Mon, 12 May 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Afg+30tH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092162550A9;
	Mon, 12 May 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747026052; cv=fail; b=Lwc2euGl3vJU8Wc7arHLUDE3dKvSFEsGnupw03zXijoAcBXzTbMStsyX+JlpRyAwwudLGPTIG75p+Na8tvdxRtgH4fmmwYQ5BF6m+1fPl2yL731eJI288X2oS5yQNZK8nH4t3o9g+VS6Z4GRekrQndG/Y+UGr74IyKTeouuIEDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747026052; c=relaxed/simple;
	bh=mxXALEZ4+/MYqR1sydR1gq6ZMHMHYEbyO9cOlKdzVVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIXfsq7E+2zPFgmxcfOJU+MpYt2QNwFM+tfJIZU2TRjMn079abDu0wXxr8J4Zv0ltZ7qbw29XblK95SGK7HmkoD7FrF4WVSWB0yCR7OCUJMca2IsDSrt8aDBmf2NPJtYWgI0ikV9UWjXay9cBxVwRrRTIemZJOFdjWnTtL0Nj+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Afg+30tH; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUsWS1EGHM1ldVybhZPQrFtI/EWcN4BaK+tjNTgq3lcccGLX/QrSgE9p3AhRVF26vrHe4q0ghH+8lYkfHceBq2qzUrNcFjqywmAS/PkDGwteHwEMahlWoUiihzT8zR6MZDPXNQxQfULpJbUi/N6DGX3e3IrY5qLZAawbMhw1HT/ey9CdSSE6l0LJtBNH4inZOYAoDH4TBb8H6xdiDWdses5BCOlLmaWEKviI7L9BSA04Q7MNnJdvZocWp1fN1aCpyH9FIknMMXgUFwCKgFYphTWJNzNM0gUwc87jafT4z2oulCIe+5/rz2zaiiqPoogHop2o3KanNDi7roJzAP8Paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pssiKOE39xbFoYLosMGFY04CDdJ4xIVrmQaFzLg5+mY=;
 b=MixcsKoEudhTcbBAvsp7DWbRSQmTKSnHkhKAHEL1ZFo79stCPE9j3mTzEKJLpve2MnDAkr9q71l54L1UVRJVYi+Km64xAPexsi1gqhhA0t33R1GwVv8AR89k3f/qhGk3w2Pi/7iF4anJlCodWQit9LbY0dCIFjPaPqu0Bto8jfImP+obfM094QPvwU/k7EvRNSXUA+EYgcxW7Mtg00yW5kkU30x3dl59KjM/6QpmGHMAOien+nGmGiDN8yQ+wfId8/blGKyz7L0JsOkczJlJY/P5v1gfigRcbLRnhvYiBlX9+8LWTDyG0AlNK5Y2AhuKfkgOoNVL3hs8N6BF9YF6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pssiKOE39xbFoYLosMGFY04CDdJ4xIVrmQaFzLg5+mY=;
 b=Afg+30tHjsqfGmLMhYmLsrr75hcEj8H5KBPznujkEuDnhO4MmcuUo9IciYN5DCl77LDmiRo1jkKPhRp/nRLeZU+acXvSWFs2Exh5+NFTaHkS53EAuQn2hIp0DRldE6djX71PH11nqm6MlZMjriGy3A6Pg3xhDdRwMaPiWiF9ESqWgPiJ9knHHtogQD8ZWdNMCWtUh3Af1q3WjvPm1J2Hxtb+qwgQpOGkoN0egOldKl2Dw4tMfYyGjNi5HdYp16GmS0w5jNPYNYYRHJalBRy4wUbBZrvBSuIXDN4z8SBhIES7TIRnfvafJeuLQQc9pf9i1wMpZHpMd+ePUY5e9ODb4Q==
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Mon, 12 May 2025 05:00:46 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::26) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 12 May 2025 05:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 05:00:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 22:00:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 22:00:32 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Sun, 11 May 2025 22:00:32 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH v2 1/2] dt-bindings: Document Tegra264 ADMA support
Date: Mon, 12 May 2025 05:00:09 +0000
Message-ID: <20250512050010.1025259-2-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250512050010.1025259-1-sheetal@nvidia.com>
References: <20250512050010.1025259-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fddbbda-6b38-4c56-77d4-08dd9111f4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EssZnsHzjFoq6wc6CSi2gKmxidMlojTFnrSliTndg4bQcN6qkzsnV5DlyrK?=
 =?us-ascii?Q?8C4BQsT97wzOeWys9Ta27wCamOXHCIWpFYEILBLhxmde9o5ciN7TxMiEqJmk?=
 =?us-ascii?Q?HlFB68NSscL0hCfv+/BhdhNIWbBxi+g9SGkBLtokrylmWJvuuSKF8p8fRILq?=
 =?us-ascii?Q?o7ZvHRW7QmYNulVmklPPbKkU7EYneewCA9SOv+M7XSUEruiOI0AxCyxtKt2m?=
 =?us-ascii?Q?O+UtWYSVkVWPLe4maGv3+EMYkpx6L26dHWFdNREq/7YBnYJZAu7LSM2k2M8T?=
 =?us-ascii?Q?ptLT1SHrtL7vXeKVtr32zM1KwguLKaXjc/8J8vhsSGfmS1Alwe6kpitlFGm4?=
 =?us-ascii?Q?JpqCfzyOPgydY3GHfLGxMPtEcdhtC7ycHWtLTOPBcp+RK3lGZVD68S9bbUno?=
 =?us-ascii?Q?FYUO0daCi954ZfzsKrtiGKuYywP94Frqt/UPu6ZvViSqpiQzT13nMhhvfthg?=
 =?us-ascii?Q?Nhn58in+dPDznxONARs14u3+mHCksfsWmPaSRQmpyVyHDvEidSFYOslJcq01?=
 =?us-ascii?Q?ZOCuzKcpJ1vmgOoj+3CRCZe0D3Vt6T1cTXtCxNckQ0dk5cYSPYt95m1s2+eG?=
 =?us-ascii?Q?nwhikg9vJV3jtBhx5lWdSc4sHmhwukyyYA1vLeTUffbFLBkJfArrfXXqd9Tp?=
 =?us-ascii?Q?Kwt+LOs2aFB1JtN7mxPsHmBiuhUOR8p3uZOO6ujFEWNXL5KVWmRqLXLZlUaU?=
 =?us-ascii?Q?J5ojs0TD8RBHkr3trTTsSTeA/2Np1AO9Ow9jOcbp3ruh12mroMolfRhM2BnE?=
 =?us-ascii?Q?SV6saehbfk0HNG+sAWS4OMJpJonFqQiy2JwLbWRSyQTqHOIRdNwgTG6V1N91?=
 =?us-ascii?Q?ezwOLF2bngXrchqKNb34sD8yF+MQaTc76Ht0YGHadsvFtyYE3OtC9bjNbYCz?=
 =?us-ascii?Q?a0y1FPg6kh7valH3JkMTM++2bQFIQCjCWKQtjBM021LwGO6oi7PgxJpy2o0Z?=
 =?us-ascii?Q?zBZUdnI9H6Cbu/v54PtgzDN+yzJQmvSRtRzbrHRlamRCkj4XHaovdnqFgqvx?=
 =?us-ascii?Q?iokBcwSu8lWCyZ2jSZg+zW/sDSNxu0powJ0zYJqAndkGafuoBvTE4xpRyb4t?=
 =?us-ascii?Q?hkIAGYQ6XddzpQ/lYaCrD8A4p8iojfL7FdWF7s8b7fljjuFuq6Q9/OLRxWhX?=
 =?us-ascii?Q?EanB4qx3WGFEqz2049aU6qiKAGrVx9Hwap9GMukBKSUxZNI69mQt4/Kf1X8F?=
 =?us-ascii?Q?Qd83lwDT13G0EBCFcTx720sExm2vnAxRB+Trqj/fKY0KYQI3mz+NNGEScVon?=
 =?us-ascii?Q?eN8MLf2buZSJry/z/ZxWeH4z847QPXoN9Z1WihIQZL0ahTl1p2bGHX4j8Gaz?=
 =?us-ascii?Q?xDEjl6It0kKRp27xT1czxKvzwH2Z1F98YazErEKxSjwg9ctrsnxh+uPN+1a4?=
 =?us-ascii?Q?Wmel+HVfh9cU25fEw0HmUJVWdKqYh3HZv0GUt5gWfjfamuKDJ+3tyTG4pqNX?=
 =?us-ascii?Q?E9sqznxSP5og94TEVaDMonQIaWxUAkMJrvfKIshllRwWiFVhcHRTMISuAHV4?=
 =?us-ascii?Q?rs9YPS+/NInIrt9CNu+J7tYUL1G6WmeoxeC7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:00:45.9959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fddbbda-6b38-4c56-77d4-08dd9111f4a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

From: Sheetal <sheetal@nvidia.com>

Add Tegra264 ADMA support to the device tree bindings documentation.
The Tegra264 ADMA hardware supports 64 DMA channels and requires
specific register configurations.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index d3f8c269916c..da0235e451d6 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - nvidia,tegra210-adma
           - nvidia,tegra186-adma
+          - nvidia,tegra264-adma
       - items:
           - enum:
               - nvidia,tegra234-adma
@@ -92,6 +93,7 @@ allOf:
           contains:
             enum:
               - nvidia,tegra186-adma
+              - nvidia,tegra264-adma
     then:
       anyOf:
         - properties:
-- 
2.17.1


