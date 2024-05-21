Return-Path: <dmaengine+bounces-2122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945488CAD1E
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 13:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C71C2819B5
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1A7602B;
	Tue, 21 May 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+/rTt2L"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25D75803;
	Tue, 21 May 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289757; cv=fail; b=tXzSILDM0sUTHUyYwlBNjt+gQtldbaZlMt36yugbpOC3vI+mNz6lpYt4fUVyIKNCfIbFL4Rs9OsIMUWMADVZIyxUMM5OWmhp8Uj5p4vbvixAQo0PY3sQHgFEP1+lH6pCAe53ArsE0tfMIjgXzROSI7xRc0XD4cspCOd6jI46lx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289757; c=relaxed/simple;
	bh=Gx6/pGkmDXD3pFjBoH4/UsVR/YEDMm6Aad7W8Q81/gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEagRe0126xz4NKGiz4oayCQLcoyFkpofqlNd5NYOynrlVt1sZ6b38bSWPIduiRs1SasjnkxJDZY3DvvbZ/kYMTcfmqu4scBY7ZNd9dsDjIOkuBV9WERaJTKtOy/7y74F49RBei+KuLHywFt7cwrL5zZc9FTNb/+m4wPFaYBhbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+/rTt2L; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh6jS5DM1rI3PlQbKn7V6szYvDgcrtHDG5QbQcCyLNFwNREZqoHbRXE31cb8v4si1GRd/UHvMMKujaNRwnkj4O7sqiu3wVzQQv9xNh/ErDG0xPfcjKU+M2qriVnt82raaXlR1kgU9djTEsWIEMovLOmOOPrsU9d4siQ3kpjozMw/SQvTHoHEOU/tQmbxnReD9AQCfTDad4Z5WBDE4Mi7LCdECy+rH4mfVmiFxlLLicppkiBVBLeAqlciFbmAwnqjBfCkHeNDU0rwhhkHtQU+Zz0wf276JEE+jGTRDMSFCaEEwGT7ydArRlyCBb2O10ZDGgNfad7kWXkYwQRlrCBvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPIjvUUYWgaMwZcyb3axc6WJo2LY5gxYGHSH8RI+jkQ=;
 b=laJP2ib/lyhw88unVSA0i0pO1I6MS+Eptv9SMVhmQz9eCvVYhVbUKYdO4P0zh9X9YtOTG/tZZ6/hdlAhX3SFQCkVJqfVoLobKhDI4mKIEnphtt7El4tKru/2F95E5+4EPwfmZVwvkVy92RLXfJPQCPQ/F1Pdi2SFjWburyL3kkXE2bit+6vCDR23EjLuXYiih6MIzJx9ExsivgS2lmKh1HQOlP1pqcNWdKzKn10FMKGl7DQLUGMU7xwIQTh1NFL0MrMvJVDZmPIZyMH2HwNgDTa/YxfEyifPdchiSq5VxPl64qbuAYAMqsSlhz2oTWo/ael+rxumERcgYaituqlKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPIjvUUYWgaMwZcyb3axc6WJo2LY5gxYGHSH8RI+jkQ=;
 b=Y+/rTt2LBrfJX5MPVr4qmY1xPbFAxi/C61fyr17XNqR7ZRp2MS0AoNVM0gFkesE8VEEvFSv307ynUU1JqtucWy2YVRgQRwacNnZk71MC3TzNmYRdtI1jtuXwjCy7C0fDA+/vF0tSwAHJRWH3bm8yuuHy8iReH5r6Fq4/msTbW7Okcau8NmkQrNhKR3exhT4Khb1T6bCizkkuNP/0Cm/1lj69IWS3rtkMZfqGiT4TqxM0yyXhbdADsEd5Y79LkuMYHbg7CLsbs0Y3e7V3vLOCcFS0lP00ianEnUBaf7wsWcdyIN5OXQZRFptmwDXDlAFpkOtgRn/Px6kj7h62TjrmRw==
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 11:09:10 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::71) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 11:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 11:09:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:08:52 -0700
Received: from build-spujar-20240506T080629452.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 21 May 2024 04:08:52 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ldewangan@nvidia.com>, <mkumard@nvidia.com>, <spujar@nvidia.com>
Subject: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to nvidia,tegra210-adma
Date: Tue, 21 May 2024 11:08:00 +0000
Message-ID: <20240521110801.1692582-2-spujar@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521110801.1692582-1-spujar@nvidia.com>
References: <20240521110801.1692582-1-spujar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 88624823-684d-4928-3c55-08dc798670a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7OaVWjtGNsQpu+XFUFEsIwG9ONxulHibZgcl73k0JeH7VbVaVhKlapQFoIzB?=
 =?us-ascii?Q?k3NJ8z5+Q5PdDPzbYAvw1LXsP3rfVAIh4OZCWwuqHEIq6Fk9oKEfC2qHBOCt?=
 =?us-ascii?Q?SLBpMenMuOJZ0nikEK9gdcFschySlRq3e1BH9MmMU27UYrwXMH1mF9cw4bzn?=
 =?us-ascii?Q?J/HNTS4oFYzUElkZNhlI1xy57IBBGITqWTh1713LR+UAIe0/hngN5lrCa5AQ?=
 =?us-ascii?Q?cBT1l6Fulkx/mncXoO+VQKGFRvhADzN+f0pbT8H0ODYGR29+PFdL+GD4FJdG?=
 =?us-ascii?Q?JivlPuCU4IPxnD9vEm/1WufBCzMR8ztyahSlApbBn1/6TfxX93ewkkys8kAM?=
 =?us-ascii?Q?BnWCQWXui11RCjpsBblW77cNM5bvBB+yzfVeFnjbyqoSKRU9Pisqpo/ekb32?=
 =?us-ascii?Q?45Kp05X7qI9vCekdveomqlZgNmPVmD9RVAnshNgGpm2fEd6Ujx9CPf4pdStG?=
 =?us-ascii?Q?g/+domH80Tf1l16gyNWYBAoWfH3L8bCBidqOc95cTWP8vw46FlfeBX/vXspo?=
 =?us-ascii?Q?f5ts0KIsO/e/H12MYFY9sY1SSmmvNNfh1fB94YueQErHbNjNnhmpi5gql9ti?=
 =?us-ascii?Q?RVEejEOuL9AIXUibW0ZFnTdqhrOpuidLhEMbEtj7l2otp0P0IBEwroLuMHWG?=
 =?us-ascii?Q?p889omcHI3lKmMOQqSlsFOrzxQSJECJTYHn3vr2hkXCpckvCZEWJhzJr+Qtc?=
 =?us-ascii?Q?u+xFyhlc0s3D+qs0RW7iWb4dpezfWMX5rkgF4yduzd/pjIAS/YzYrYGfz9uZ?=
 =?us-ascii?Q?AXJbdCjClJ15rWaVMnpGQlPdH4S3ilurMi8FvU482Hr5BX3iCJ1ov3cJ18fP?=
 =?us-ascii?Q?fS7fHnNelIxsGLmogPqq4bt/iQpBjbKScOIsfDbZa0KX4YIglGst9TvGSqQF?=
 =?us-ascii?Q?C7iVq88kGgmfitnqJMwJVyoWz+3ll2BlDHi+BC/D/KxtmIDHLXEHFznYJuXp?=
 =?us-ascii?Q?XJc5zv48AAeJ2DV23Tvd68d3auI72SNAWMuu/BcOu6GWcD8EjEkmQ4y9fEVx?=
 =?us-ascii?Q?BJTY35In5kqoykg9d+IxzfCP7kvGg9oK6w9X+t981KoO7aGqnbaZw0gSJJlH?=
 =?us-ascii?Q?N875ZeQIIkGychRJqDydzG9AcjsgwR9nQHewhRnCDrs8k9r3nYNtQJqdEuXi?=
 =?us-ascii?Q?xzqVsfvCWFUDgOTe7GBWaVDe0JakmQFi9AqjxS2w1IIN81arTtaqo+tBdwwD?=
 =?us-ascii?Q?cLQ/InXuKvsIlhFstXG6vv3caB9uxM912pFAm/jyoz4OjsnQTuB0GLAc5zGW?=
 =?us-ascii?Q?H1LeLJgFzzhXFd41FnXTOKf9InrkFBR+YPyneWYBFar5eEBCKUdEXAfVfiCg?=
 =?us-ascii?Q?CKZ/TLSaEuv0nOFFwvOyeZabPtte1GONLSEOWQwhw+kL1Esi05QkTaf1l0ZH?=
 =?us-ascii?Q?VOQchx/8pl6hncPmgch9/DYbF2VD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:09:10.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88624823-684d-4928-3c55-08dc798670a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

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


