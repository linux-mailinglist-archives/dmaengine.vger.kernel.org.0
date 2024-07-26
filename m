Return-Path: <dmaengine+bounces-2740-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A3E93CE1F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E595928172C
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4B176231;
	Fri, 26 Jul 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BqIYpKfb"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114217556E;
	Fri, 26 Jul 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975217; cv=fail; b=igsgbPUpvLkMSuMXF/7NWu7AxDe/GRumdiP79nUzchKi2mctQvDiOpEDx10CdsnsCiftJGV43RyvLMRGomjdp7ElNhuMVcQ80hXnvgWWcT7nkD8uvOdf0nojN4fJegGvu6PRIoBNcRX4YII7J0WSHH72ulQqAy0phTkOI2N2iaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975217; c=relaxed/simple;
	bh=LUm1/HxW/IdcfvkP9Byp+oPtMzjIt+po76kcO8Evps0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQvuH1z2T+9yU4oy+DgOrkKlGRuA9LH0mEt/ecks/oKBLs+uJKCbC1BW8BHqxNnaDX2hgqUP20a/J6Lh3xnCN94FoOffzCX1vb0wNwcUfDQxZb6hrbN9y0VK7G9GB3Q9yOxDFMKbaGEeLXGaGAMEKJhPDj7RUkzSYLOTaibEAq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BqIYpKfb; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdIKo+eGUO2+BxpnfmawI25WzIJiehPL8p4X6mD1Mvvl3IU2oxNH4O1kpEWbPYixIlqfyWJC0ZTASwQz/xPROr2PcHwyAYb0E14P7wd8eZkpDnrUa+1tg8ogjay5KDMsYK9rAEmKJYwGU0bvt0rWlsLc3XnMgihbmrAVPAlACD8DMnbVSmneVbw5eKsD+W4gWfPfR0V7BBIfzZHqfemS3+aaLxAa5hpo+gD8d2a4clmBAXWcky/813Wm5S5VJUU8VAEhYV357V+txqZb/EA89iSssCMGrk86JjV9DGejUs6EQ75hM5nJMqKWFswTkrH7AEHKPU2w1qz6df85WDWVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQQs2D5QEhvfB9NPCvT5CVn9f09oD8CZeoXEwyJ5asY=;
 b=F1FuedcxCDNa77H5Yd06XiUnbfgK/jtuIl9IgiBl18HiD7HC/l470Sd2ddkWdFSGm5+JTX2qaLBXvpZdEhZBXSWtBNLmdSlWoTS2BfitBnldzJ6o8h5ZNcGZdSTMyUAjvWCRR5wqLS1oRsMipb/8Rx9dcWXv+gde3FBfaBtbBJ4CYnI/gVbRyZhZN+YrVu2ha0q1RuXNOjD8FxH9axUn5oDVHiRQNwv0g8sV2wfdwdD2BXcQtdCj+ikWl15vcA4pobJuUje+M8clrRsEVHUAdpOCA1RuFxxYwEQ8qvl4qM2k2VcC1Ko+BdyjnlHseFtr+QsTV4Qs2I/xvM4hgvEWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQQs2D5QEhvfB9NPCvT5CVn9f09oD8CZeoXEwyJ5asY=;
 b=BqIYpKfbYCxD9C1f/spMNZnjQStJwKox9YPM5A/p/Cn92YIxJuZHB4WMbrwQuHEVTAoX35fHZtCbeZd0wDN1aluK4yn6qVFjnfxCeqevbuCv2LycprfXFDJFTtZtMe0rk5GTIgrPVb4YBvyWVCPkUk0X8RrWhguSM2hEFhqKQp8=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 06:26:52 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::31) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 06:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:26:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:26:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:26:50 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 26 Jul 2024 01:26:46 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
Date: Fri, 26 Jul 2024 11:56:38 +0530
Message-ID: <20240726062639.2609974-2-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726062639.2609974-1-abin.joseph@amd.com>
References: <20240726062639.2609974-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1595868e-ef9d-4097-ce8d-08dcad3befee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYzDivfo4uudG0q7r3m+FXWa3SHiTIn1WaKboVjpwVPagZavNvfh0nPBbh9P?=
 =?us-ascii?Q?kjCuFlw9n5/d4yAmX/3Mjs1Al21lLMGHw1OM97o3lM4LYTU1aQeHaeSAwfxE?=
 =?us-ascii?Q?g0kuWRC7X6upAEytgG47YG18ocPNZZlytePP4KRGsqPdBHJi7ic5VtH/QWXp?=
 =?us-ascii?Q?F0mpA+fap0oFmrze24VvUeiRcdb61YdG4fpbFi2zRiM0Odbio5DdNjl1LEJm?=
 =?us-ascii?Q?jsfmw3G5noy0u+QSsi9G0usJob3aOthLtumrLP/L6Ca3XGf962kaDEd8nWT3?=
 =?us-ascii?Q?wOG1phfUAl2sjdz9uHVtCXr3yDX4XYjLgILXtyKfL+qHIGHMbTrNiZSmI6za?=
 =?us-ascii?Q?K2w+IVjUDcV2WHoww+wTD2rp2BdS6ioM4m4IGqkBvuKeGxcGQT00F9hRt0xk?=
 =?us-ascii?Q?VMDEP3k/nZpRT7UJh4NGPDWtksFW/7tTdjSfrZvz29thuEAcpa2KqGZvS8Qw?=
 =?us-ascii?Q?LMMBF95YMj4EZLk/GKf1kEwphULFxL46/9jVWYB3HhyE4Ksrltjen8xw5VfY?=
 =?us-ascii?Q?14A5SX2ccGfhv+uzwqMO0Kai3RL7C6FG3Byzkfrph+jNRtXJW5p2nv7nOf0T?=
 =?us-ascii?Q?9G9zLCWm6GTKjSaFB5AjnF7wKvmuUbj1pSKknZuNFiNpiqbsHDc5yEaQiHjA?=
 =?us-ascii?Q?IJ7/G4AgZZG8Nn4cGsKq7jP1HmOgLByGOr8/CgmVSG46lExyrEX9MMc4/GPS?=
 =?us-ascii?Q?Kv4ewlkB7ugbCr9ycV5hp+9PxO8RpUqBxwXLMqH6Zau2VcW3rMxiU2QlVIXm?=
 =?us-ascii?Q?OKF6j5Ypva10Tg+SoUV4S2aD/gluUoNsuUAZS9QeiqyOg13MokRVnoQnmibs?=
 =?us-ascii?Q?mvhPvOvCMT18rwLhqp2qYKf+yg+16qGvz7qfSpaokgjMObFVjds/nF1wz2TB?=
 =?us-ascii?Q?/CzGksovz3/KcvJg6nfVW5Q5x4GxqJdg5KMZxHrGODh7l5Cd5Vcf31kVrVjk?=
 =?us-ascii?Q?DV8CJOKbWQLco3jHoAvU0kWaazLGwrZFqR7bDRAirQLr7vr5k6ghZnbkt+UI?=
 =?us-ascii?Q?zCWYLBw+deU7t5QVJLGeYH/klY0obB236ToeYObNJ82RPzFFl9vSW0U5ezNu?=
 =?us-ascii?Q?uO0oZH4QjUtundEQwei8LdtBcaiJQj94SNVzhyvg3stnD8DRlXbe7PMnXq8W?=
 =?us-ascii?Q?tBh0AWZHiY1c9o+7bDhLsnzPCbm+ALzGmd5twbviALkaKorrC3OeFYvzE8Kf?=
 =?us-ascii?Q?+/3e6vsQASdMoEiNyCcsAjAk77N5KCb4WU3AGNmN+Aup29bzis0CH8nsJ99T?=
 =?us-ascii?Q?ioW6riyYUUpXqJ4qxd+pzM1Vw3BDcJXBl7ijdJ/DWB8p5BrA+b+cQrfNFkSq?=
 =?us-ascii?Q?6ZykSGwuQ+9b/U4LpqELdXCuTLY7iJW6xnVedrCnBHFjGWx5YHqhxEQN/e+9?=
 =?us-ascii?Q?AHeVKNJyOLUauLlC/DKO/bxwY+UpnClyKJtfynXorc+2KO5HNodaGhnAGPrJ?=
 =?us-ascii?Q?adwxpwO+0Sfe9uQ/u6KBoqvTEJpeAzE7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:26:51.6567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1595868e-ef9d-4097-ce8d-08dcad3befee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235

Add compatible string "amd,versal2-dma-1.0" to support AMD Versal Gen 2
platform.

AMD Versal Gen 2 has 8 LPD DMA IPs in PS that can be used as general
purpose DMAs which is designed to support memory to memory and memory to
IO buffer transfer. Versal Gen 2 DMA IP has different interrupt register
offset. Add example binding documentation for the newly added compatible
string.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---
 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index 769ce23aaac2..17f16ae7e42b 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -24,7 +24,9 @@ properties:
     const: 1
 
   compatible:
-    const: xlnx,zynqmp-dma-1.0
+    enum:
+      - xlnx,zynqmp-dma-1.0
+      - amd,versal2-dma-1.0
 
   reg:
     description: memory map for gdma/adma module access
@@ -74,6 +76,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     fpd_dma_chan1: dma-controller@fd500000 {
       compatible = "xlnx,zynqmp-dma-1.0";
@@ -86,3 +89,15 @@ examples:
       xlnx,bus-width = <128>;
       dma-coherent;
     };
+
+    fpd_dma_chan2: dma-controller@ebd00000 {
+      compatible = "amd,versal2-dma-1.0";
+      reg = <0xebd00000 0x1000>;
+      interrupt-parent = <&gic>;
+      interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+      #dma-cells = <1>;
+      clock-names = "clk_main", "clk_apb";
+      clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
+      xlnx,bus-width = <128>;
+      dma-coherent;
+    };
-- 
2.25.1


