Return-Path: <dmaengine+bounces-2077-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6745C8C9D1A
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7971C21ED0
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91D54675;
	Mon, 20 May 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mt1wUqTC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FF52F74;
	Mon, 20 May 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207859; cv=fail; b=nQb9MT7zPhNcHzvmJLQZuLgEw28d4QzW6p/RAlJ9nGI9GiiB/X3hqNXc1DR6MFOr1l2KU2bVhJeCxKgfX7qJWSBoeHQUod7BlPOjT33rT+70hRHDg5JpySadcUh6Obed3/+z5DzyP/AUlJr8NTFgKKANo6xWbFJFSvzfZFyUPqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207859; c=relaxed/simple;
	bh=Gx6/pGkmDXD3pFjBoH4/UsVR/YEDMm6Aad7W8Q81/gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwAwK7smh4SWQEm3VbjtuwDNI89FkE+ncV9zdsL9RDAvQYOmhmplcTLMU3Mk15TggF17MOP7Qe6kLf8oF3kx03Ns3Va2Jg05x3rDgG38+SGBI+BejxIBhQLHnDa/QZhWXKZivxDggCjBSf8IvFwjyn68vui4SDNNlChnt30dfj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mt1wUqTC; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knwDw8qk11LDKVXC6kTwoz2H7/LOEidG/L184E/4jQ01tCQXMeTyBFm8JfAyoBxpR3bh0LCrO87E1c1sNJGKvnurTZcqnB3tjYrTBT1zMsDXFKQ6dai3QCh1QUlUeCxMm73GMJ3CyR8GbqdcThPNrDZfK0N7Q16TV2UGe/qpJ72aMIjxXRebHEZQPfcXORjHmQXu8v7QzKFOdUtO/ZfvgRpDGAPZjzl3FT+N9ukXMnV9fBvTzBtSjm5M1TUIX1vQuOrIIeq5j7kengtFw9oT+33GGwg2HK2y6pP6t3q13QnN548IR5WLRchIGE16p2ijFgNHFE+bNtgpE+9odqxxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPIjvUUYWgaMwZcyb3axc6WJo2LY5gxYGHSH8RI+jkQ=;
 b=XdFjH8/5HhXwat0YClNY1C3rFajvPTy44iubgGur0iR6LGpDpXkLdFmOn5Ak5eTguYs/aTz7bDBdRqt/iMQRD/crLRFvbqIfe/npeligp/D11FmykK4YeofFQ0cgZyqLj3i07HIyBoJwoBkkr8930I7WZMIM39SyEDfAFVyrvPIPNlu6p4/7lj1Z+zM5Z6Enww+qwG27fy3+aWp/67VLX/qeMaBJpq7lJgmH5AbJ0/PbfZmyVkX2fY4ySTRJVkeZjKsaTOu/QTK2veFZhMVp6zDdN7mDFgQdVGy6E4ewltSEk/m1JnCQfmHVTGCAGcldkhU/OalvcTbwNea/W1sTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPIjvUUYWgaMwZcyb3axc6WJo2LY5gxYGHSH8RI+jkQ=;
 b=mt1wUqTCha4RPTvJk0gDOijFmUzFg+GGoF1fgmjB0Dk31U5o3qWUWzF7RAscZgKmyIrtnJ/8K2VWLYyAY7331ra9C2uoCXuQIdC4PdpAu6ELztn4ZpJTI4TsVnlNkFYOkuUCUr9HmOFKUKADtmWbEUb6YuPSm1XvI8GMDFdS8ADxCYOVpN+AzpKuVUfd1a5CZAmIBhLPi3miKI1MOmvUdFGnpH4Z4F1rRSHkunVQC1ZmoI/dnfw9dW5SlxPiLce/a6puT//xJqlUfZfkowXLUJpoL3R74IbRw6cybR2wWkzpAzDTcO/FIwj5W7R0RYjzvrYPPb6MsQhFJUiPBGB58g==
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 12:24:15 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::dc) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Mon, 20 May 2024 12:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.0 via Frontend Transport; Mon, 20 May 2024 12:24:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 05:24:01 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Mon, 20 May 2024 05:24:01 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>,
	<dmaengine@vger.kernel.org>
CC: <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mkumard@nvidia.com>, <spujar@nvidia.com>,
	<ldewangan@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: dma: Add reg-names to nvidia,tegra210-adma
Date: Mon, 20 May 2024 12:23:50 +0000
Message-ID: <20240520122351.1691058-2-spujar@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520122351.1691058-1-spujar@nvidia.com>
References: <20240520122351.1691058-1-spujar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ce93a7-91b7-4546-6092-08dc78c7c33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HpGCMZzLzQ7xfY7O7QLps/loH9YKFOo7L3+WiBwrc6VEDX2cdv5ud0khOo3e?=
 =?us-ascii?Q?jqoO+Y2duRH8lAwsUOK12w1CtZKfiW3MImgiHU0IHTmCFk4cWqU7JP8eRrAu?=
 =?us-ascii?Q?dQ+B7h5BgGeWLBrARofEVM/6Rb+D4ksING/bbPKe/8rvPGKXqG+HbmfVaWl3?=
 =?us-ascii?Q?WlyJMETZI/kGmD1Ln5zTdSi6OXxSOgJjpNTpjchwiW1mJ8rFPXZVH/V3vaLu?=
 =?us-ascii?Q?hDU8SFuFB5gzcKG3fZEXu81W9GAEL1lJAd3SKbrFXHYbNmUpYx9nvOnfEkKB?=
 =?us-ascii?Q?R/oLNp/l40MgNyFwKQU0hYk+bnPRb3kedOyNYi3jRAQqpejL4VdAFYaOh52V?=
 =?us-ascii?Q?pzU6E+fSAiyY4O7sh/f4XxbOmOCXMWEOEl2l3YNITCBCbvHqibDo3w9+8AML?=
 =?us-ascii?Q?MHca5pkZ46AkgDfTpLqpfLRfBxQ0gEljgAB74yuTU5n36Sb8sEaFw3l2jaUY?=
 =?us-ascii?Q?KbBOdWFKHiHFYlrMC9j4co2vPbL3IEjywpquUqpyqgD1m0iKO2LzlSDxX5t/?=
 =?us-ascii?Q?rJqod//yrg/AfONFbZvQs09qEkmed3jdufewq8Sa5CR+I0YgImSI0t2SGN5k?=
 =?us-ascii?Q?jwrE2AbLeq8+9/akXdzTzFi9fl4cY0cN68OkCFlgSu20yKCKaqc+35PVBSRi?=
 =?us-ascii?Q?/AOjeMp88m2AcQ3T41vkMiOsh3J+KrEIjyg9llH9ErolCJaFnjgalSljeVlK?=
 =?us-ascii?Q?UgJ6hd67+NepX1y41x7kMg2I6ABxawCzDdXcoTePgXdfuHB9hzMhlcQhHCFK?=
 =?us-ascii?Q?pXk4uLKq7k18+1n/VLZ6+o0CAlG6cQgaDLHwLTUcpQyFePcyOI+StX0nu3iR?=
 =?us-ascii?Q?GEOITt1s9ro62fPZdFE4qylOGPl5WX7ahwrp9iVyFPGph5YlyY2xwGV9GAvL?=
 =?us-ascii?Q?xfQ3tnVgTBWAgxSwm7b95mS3udIAxjWdGh8ajhDqfslOmmq+OUTa8Sjg3rlI?=
 =?us-ascii?Q?RKyHx1z0UsNGErOSiKwK+tI5EuWOfxii3YP7VCa7FsFhYdmwPCx0aBSo++CO?=
 =?us-ascii?Q?SQ76kqz8ocJutJ0v1YVRtECBeGqUBGjmFwxtW6Pl1galfn+sCR/Od2hhgX7r?=
 =?us-ascii?Q?cYC/F5vbHpTGFg3yUwCYvZLUKN4o6Gb0SLIIL/ujD4+S8WSZguNmWsITcr6Y?=
 =?us-ascii?Q?0sjCZA6m/ZvZf1YWJxp+F1nF0VqDSyF5axFyutG01Sgl/CpyPQ0tueNXoeiv?=
 =?us-ascii?Q?WfUDoVi2bmDS5+kp/8EVThvxhUgVfvPJwJfaBs6n6+4CKuqLzRuPF+/wjx8M?=
 =?us-ascii?Q?KcEToaqLHKcnyuVjQBGfSrkrLAm2hyQbcgUc0NMxnL0W692ybZTRcLB54fka?=
 =?us-ascii?Q?vGDQwU9hnMzuBmyJxg8uMOXVt8P6EnzReyOM0G8g9o+R+UyIZpTQKzEZn1aX?=
 =?us-ascii?Q?DFG5H00iak4p0tUzyFQWH27A9/us?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 12:24:14.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ce93a7-91b7-4546-6092-08dc78c7c33d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

From: Mohan Kumar <mkumard@nvidia.com>

For Non-Hypervisor mode, Tegra ADMA driver requires the register
resource range to include both global and channel page in the reg
entry. For Hypervisor more, Tegra ADMA driver requires only the
channel page and global page range is not allowed for access.

Add reg-names DT binding for Hypervisor mode to help driver to
differentiate the config between Hypervisor and Non-Hypervisor
mode of execution.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 877147e95ecc..ede47f4a3eec 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -29,8 +29,18 @@ properties:
           - const: nvidia,tegra186-adma
 
   reg:
+    description: |
+      For hypervisor mode, the address range should include a
+      ADMA channel page address range, for non-hypervisor mode
+      it starts with ADMA base address covering Global and Channel
+      page address range.
     maxItems: 1
 
+  reg-names:
+    description: only required for Hypervisor mode.
+    items:
+      - const: vm
+
   interrupts:
     description: |
       Should contain all of the per-channel DMA interrupts in
-- 
2.45.1


