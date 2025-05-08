Return-Path: <dmaengine+bounces-5112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65EAAFA1E
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB73AA142
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA8225A47;
	Thu,  8 May 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wsiz24dp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51F22332B;
	Thu,  8 May 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707769; cv=fail; b=lijGvV+OaPER8MZ8tfSDa4+mOoQNN1wOssdxR6w/xYUbOWMFvsKSntnMAvZtmtTmrYMzS+h+FvOabVvsiHu5TI8Pj8BsZLO06Yi6ycvQw7vggGn4OHs8f7heSwZxdGHq+eugySdNqxYO08i1503VuGKJPJpkEyIC/RqFrdVun5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707769; c=relaxed/simple;
	bh=8TqK+ltJbFlUHnSKzbxWDvO4phe/u66jYzvMsEHY7Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZEXxIh6cdRm4eIzehuDd5AgkgB9DarIRWiptPNVr2HX3AwVcTlOJ9p20wWfEIifewyEWMhvl3+ZPzXWHw6vZJricvtSXwp+K5JkIsvRn56AkKnkJgN+tKBAsih8xy9AszddJjsaNkCJl/Ad8naNq+jT46wOj/uDxcEZPRM67vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wsiz24dp; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3bj1bzGTcIsg5d9G5T0kQjC9gEdsw0bigupptmve2LIcRUPYnuePNXe9PRidLhjPqvmClwgJZb9hx1VuFqP3xz9GDywREXIjK+belww5+fzzalZeEmfdq1Gh0k2NfZpWv88tyCoxT/Tg5UqPtTL4QOOvKGOMxj/fLTiW7/KBj8XnLAmy9/PEh8P+61x4Y/ihaOoEYHQtyryJ0h/M+7dimEb3O7UILuTl3o6aRkEMYlPInIT/1H0vSX/5h0FVtxLniGWJloKw4wkkGHFepCgYWrHP6IjpOL8os9RabU/trJgZ4Cr2HLinMFo9TekOEuGamK0kBV+dlxEGGwFi1EpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiO8dI4xsR7oP/qtzVAFZOaUV1c7Dc0wqRoEn86bP9E=;
 b=lQAcX5XovSAARyH6TONQaMADGcQXFguKqvD6vsAyj/h3xCkPjH5SzFobeXqY4IIUUPjauJZHdHFrkVPAWYDpP06eIxdTRMOvCTLF5FfvoylEn6hdsYp6On2gkmRYr4bHxwPrjATDH5RpPUdbyO31EHvXXmrjC2qYtE8QBJLQxK5+ZdkyFtyd7vOux8UWRuLHXkmzJ7N9XngIR/MuxfYWwjBt5hxPklV6XoCLfmpGYlFODnCLC6AheayplhWb9l5XNmJGFLeqWD7nCemzDBA/RJI3V9jAueKdDKXjC1lSZeN/mib5ClnvnAdRxb+7de3ePdM3rJ/dzUj4TAXuZFjR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiO8dI4xsR7oP/qtzVAFZOaUV1c7Dc0wqRoEn86bP9E=;
 b=Wsiz24dp7osyN7prhK6RjCV39av4HLxxr9Yq5ds8zwqE0JspfTffP5qa6HWJU205OCIRWCjqVMlWnKW/SD95x+vR2ua6eBSnMSdS7XbiFkOk25CYn/7jHxZAxuyvxuTJ8GwZsClpj+ZrcBFqKSGCnIKOQRSZG2HxQpiTjunyPTtpJIWVYq77XqA+CL4KTYP5VMOZA+T1BdEk6rYlQGsAUcOzpwH9qvyzssjFYUFDzfUcKcJnnRvA/c8y35kDCeNHtWIEOF+KHWMaOaw/RG9LgCAGCyyhbWnPItoqSLx2aNjvaSBiPNfJ/dmPt3Jp3FipfuFgB/K2m1yhihgvspsZ1A==
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Thu, 8 May 2025 12:35:58 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::69) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 8 May 2025 12:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 12:35:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 05:35:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 05:35:42 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Thu, 8 May 2025 05:35:42 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: Document Tegra264 ADMA support
Date: Thu, 8 May 2025 12:35:19 +0000
Message-ID: <20250508123520.973675-2-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250508123520.973675-1-sheetal@nvidia.com>
References: <20250508123520.973675-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: f236e4f5-011e-4c48-e0d8-08dd8e2ce1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMncJzhJPYK4Zhi7/YkZKv+6HQJZOhg2IW70VXNw4k9Ho9HYzpHJNqcJNIWm?=
 =?us-ascii?Q?E5gsxqH9ulthknM+Q34abZMaTmTh7rfTPRmSxzdHZRXeAVW/56/a+MWxceUW?=
 =?us-ascii?Q?a8lzw+8LZ2Hq1NTzSz8cVKit5L6IT2RmitrJlPUHt12ExluocReY2cvIPOkQ?=
 =?us-ascii?Q?940hN/dAy/T8eF4TWY4IJIC9lqbG29PD8/Wuy3dv1sc/gEvTjJ2jA0+qOl1f?=
 =?us-ascii?Q?eBALBgkgtbcZ8zDxtTFo7D3bhYlFA+j82puyBRMRVggbC5Cjv1gZC1+ac+w2?=
 =?us-ascii?Q?Ub2HDN38X4wHr68coLQ45eZ116jVY0djazVFo+316QBZqyTVSMlN6lrYlss9?=
 =?us-ascii?Q?2Hc4F7fdWmOYgpmH7Jt6twoAztnN2KhHnPavLjITRjUpsUl466gcSQNxJyeh?=
 =?us-ascii?Q?eF3lEEECALhOlhHA9U1HmLAJL0PucOX+Tc2mpfSYHoBg5+xqeo2JXXPeJ2kY?=
 =?us-ascii?Q?wmq/HV+tY1dxxHksWct0HzlUxGn9fAdiVD21lu6FMiWDITSD/jVQ768sPvd4?=
 =?us-ascii?Q?tcpA5hqT3FB/dwYb6RKnYazGdVIzHhkCx7FFRNPWS9mNNVoEuU6pfNsmSB9O?=
 =?us-ascii?Q?edb84t3GUHhTU+XPn1eHfLSuV6+16cq6QELdF08ufas6CUcuit57V/45bmmL?=
 =?us-ascii?Q?L32Lio/8KRfAMkYgA0VhUkKabUkLHfnFWVknr+17nn7vn2CiDmzSE2Utm//S?=
 =?us-ascii?Q?NeLjX71cPQNHOsJBN6NExER/etFel8HevZMVgtvifyCaQG7TDBowaliBmn07?=
 =?us-ascii?Q?l4geCAPeOXfp00cT55wxIV0Lkz9qlYeHFARDl4sm/+FGHyGX+aU/nXLUbHu7?=
 =?us-ascii?Q?SjamfLl3SRRkeYk7TwbjHdPLbY/Ms6uuGUMFOPLt+iBb+Xyjqlx8UO0Z8rtl?=
 =?us-ascii?Q?oLng3LGtzczgM2p4USPGyqIZNLGVDZF3BAiCfHTecvwZmnb0BGK3GXTnLx2T?=
 =?us-ascii?Q?yv138aLwReduK1uCbXJfX/yLaRtOFpgz+AJ1m0IcgyfxI2gg6VeKWdeqKsbQ?=
 =?us-ascii?Q?zdTV6p2OEq6jtONLf/UazXNkUlp1r/+3wRFLETdYp8pUjWEt+42pXsxuFctq?=
 =?us-ascii?Q?eK9PyGMbcMdcsNRgZCW4Cvcy8jECWjfiELtpUFEKxrF4v4Tdn3jwDiVcPV4w?=
 =?us-ascii?Q?fvrOA/u8PnQUQlilqw+fL/sQugFcEZDGT5QDLsc6IoaVxkaq6ajnnCKN66YV?=
 =?us-ascii?Q?jn9LHWVlJP6/PEwwJH3zBp5iPFT4E8aeNIRpoPRnfMh7lBKA3eVxxC0qX/xP?=
 =?us-ascii?Q?zpZP94p6JAJThTwajOkkn/GLMhv/vIsYaJ8gg3shumqk3gTvG7un3RYyMYNm?=
 =?us-ascii?Q?8/q9V8LREY3SrEMjk0cbWAD1oHcSYmSW5ZMdJnxeS94cgWWMrbBFKt8ZUedb?=
 =?us-ascii?Q?ETLocGHDSmwOivQrQcAKeN5q25EbQdq/JtesEuttvH2hCxNwHXqUS1U1FXXl?=
 =?us-ascii?Q?SFbU65iIFg7/AQgnV6t0EpGSWAWecB49aLpR/QLgv7oEaKCGJwEcaO8N0Ukf?=
 =?us-ascii?Q?cmbGE8DYqL0oQKlLOwxfc75SOduaaKAhoz7A?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:35:57.5654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f236e4f5-011e-4c48-e0d8-08dd8e2ce1f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

From: Sheetal <sheetal@nvidia.com>

Add Tegra264 ADMA support to the device tree bindings documentation.
The Tegra264 ADMA hardware supports 64 DMA channels and requires
specific register configurations.

The binding maintains compatibility with existing Tegra platforms
while adding support for Tegra264-specific features.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index d3f8c269916c..d204be46b90e 100644
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
-- 
2.17.1


