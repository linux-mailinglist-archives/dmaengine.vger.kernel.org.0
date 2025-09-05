Return-Path: <dmaengine+bounces-6390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6FB44E35
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD41E7BAA00
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13623370F;
	Fri,  5 Sep 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmQBOCr7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D01D9663;
	Fri,  5 Sep 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054905; cv=fail; b=Qc+vWtVBAsZ4vhmrvCRdxnDxE40wSbbgUZqM/V22+KcDDYZI6huLeCIG45TnTIyDsRN6fs50NZTPPlWWFRt/XeslCPpl9qXHKdNw8Cl5+9i0+iP52MW+L0i2HsX/tobAZ0Fs8cwEkgnUs0hy6eZiujL503WV8yTq+Gsq+K6CN0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054905; c=relaxed/simple;
	bh=EO8vrS7OgSHFYg70AT3w4ai5/ROu2lVfw0Jpnz9TFSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hW4DK3L43Bjf1BK4OI4kDshX+XN9MQ2I/pbPvnKeBB0pFhw3Fqz/bjQO9WYDwmstsJIKz/l5Je0yBtr77r8k6CscfICWK46ewxF6z3ROd1cXkkakTytUxWJGcVhfFrGvcd/RLC88tQkF64zerOjrqGURqy6q/5ciWh6T0msbZx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmQBOCr7; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JocoO0sXJYutPF5A4jVF4U3jmG/03bBvkBSKs0ZrsaC17L6XwybQdXL1+iHrmcsbWqRxpvW2HXGOpTbob9Al+fZPsuHNH9wKPhyRjqpHiyKeDU7DfxpvC2JThumiI7vpwAI5pEY51iB8k4LIJc4Q7RbcPLkBpQ9J1VB0aehkZmfXBKWWEj2u6Lta4rkpc4N6GFSKDDKClJELbvyD1NHqjRktuCzdg1MpjdzUa4t5cwfbHyXYI3B0mZkHp/KlTJa19nTt3Pvce0Sj+gDlzCokH1dLtb5Lyv9kVeQtkSCgTrGG/TQ6x0CHVRxLIwzDCJruwTqvWEeoq6AHomHqZgdw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu8LEDd4282aI9U+xlecBFS+qHm5DmTS98OsmeKTmDk=;
 b=Q2rODrgFeXS0R7Z34N1GrxYs4ZniTy4bptWLoR47oaFNodZ4VzfC2cQfMkzAS1J72HSZo/lOz/2d7dytVfe8gQMC9IEpVJIUsE8dJxbk/Oj9RTHKvg0oZugm/1ONjt/w9lWAtdcl5wBIFsk1aLBJ6rEMwzyUBkdZqyypb2wdG9u80YtcdnQjlSB5RMQl2WXqhT4EM5yOjql226pwSETVTmrFwsEIFMrYcf8330MkdKygPo8C48FKYEhFSiCNK8tRyr/ZTM1FAQtaffWrrqLCV/OyZoYZqYgMbBXwa3SO6jELVm98gGqjxnPIy6669N2MQGhjxdjh6lJK9xgCUD8nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu8LEDd4282aI9U+xlecBFS+qHm5DmTS98OsmeKTmDk=;
 b=OmQBOCr7TyAwmyPpySR9H3gsIypzqGqywPBVXVGKL3dHmQOuTmJ1Ix2yWfUeh+ILETA1hbGdedJ/e+YSiZxWqSYVdElTtdSi/OOxiYb8NVMF9cA1wUARi6bPGVy0JWzZIaL0gUlYKfx1h/1RB9AnNYZEef0RlvN80bu9ndWSIUs=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:48:19 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::b) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 06:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 06:48:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 01:48:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 23:48:18 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 01:48:16 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing
Date: Fri, 5 Sep 2025 12:18:11 +0530
Message-ID: <20250905064811.1887086-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: b799faf8-de3e-48bd-d1b8-08ddec4832f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3GzTEzWYbjjjKt50WsopcSVonytYtOdPlg/LGy3ev7BU/w5UUejWuWnD87I?=
 =?us-ascii?Q?nRBQ8s77T7nTiisnqB4IvOTfsWxZn/4eLXGXa9LybhDUUCjQ0ABqMM/+WvcB?=
 =?us-ascii?Q?IeZmHP+6YKlmZvIwauhxOl74Zgz9n1bNPF2nvW9E6uLvPP7eoLku6ly+ZutY?=
 =?us-ascii?Q?IEluvV/jGS52utNJ6aljtGb2eVcfXxXT4KoBetgiosgfPEPzghw6U0NzaKPq?=
 =?us-ascii?Q?GWllyv2RLvMgQO8nBLLjtDQBQFIpOn0veg9DQTpw6PlPIhj2ypNDDfVYJFWk?=
 =?us-ascii?Q?vaZEbnWc9005EXzTmoBh/xXYY6avia2VmcCIqiNk9wsoDFeeTJC4wzDpgWo9?=
 =?us-ascii?Q?+danpLldjaoCvAYxxptubiYbwFANLXxm+n+p0Yr8Gd/L4FAmWsi8wGDTQ//r?=
 =?us-ascii?Q?elOnsECUP5pFfj4MJHe1dAPNJ8Q7gIcFPJ5/ti1imce2LFJ/9hYZYBdePn3/?=
 =?us-ascii?Q?aJON8jrH0CAK5KGEpjDRzwD+dYBmfRoHq5HOzYTQE7inE+feEop1wSBQQFo0?=
 =?us-ascii?Q?OTZO3gcZ6/fq90pFGRCVh7OTM2INCsdO4ag2Bt6w6/TFki46VgLTlUfy6Gpb?=
 =?us-ascii?Q?XZsAL6kDhV/QED8f7lxVruspYq42Rvps5ZqbSLYN5lBRWGk11ZZ74ia91Gnf?=
 =?us-ascii?Q?Qp5qzuKzZGZdWokNFza8nYZRLALIHfQw0yRMIbYd7Gg+2UZrkKIOgTaSA5Wl?=
 =?us-ascii?Q?J9c92ntL6N2yXoY4z4+e/rUZrvx4sTNiSFztp/YtMIpnWJJY1DHP8cfCAw7N?=
 =?us-ascii?Q?6UhWFQF0tTDU9/XzBr3FvPBQZYFk4WoVMb0UxIWwvyoYgKG1Dv/GQ48vlQOz?=
 =?us-ascii?Q?yjsePjEVUpAUSTweIS+cAlSGSTqEGCdXW/XLR6QGjxGZV7p1Uln7h2/TFK57?=
 =?us-ascii?Q?nIc4YE2U73435DzGu2sGNJHfbd1QZFnzzF1/WSiNmvxJbamHSVyYTJ2Js/Gq?=
 =?us-ascii?Q?crcGoeCEYUN0qOF5gxgXoOJgsHyh5zqMzU38yf67ljwgMA77Hsy3RvhIMYAZ?=
 =?us-ascii?Q?QpO72DazXDcPwyGc/H/9tPCVU2pjfeRu44bHq3ZexPvJvEdfUC34FGFT+4qu?=
 =?us-ascii?Q?yLwAm6xlcGp6ui96ea7YKzWf/qU5rKyaolAl8IzAweS+cpufF+REMNURL+U1?=
 =?us-ascii?Q?UdZ02QlUFZlVuuNEwdQlQTnC88jv2/OZHQWLw3wa1fkL4o6zvrY0j8weC+fO?=
 =?us-ascii?Q?kscEHJUOId8W/Hy33jtA1YeQVtiHZUtm5Is2LewQfdaRPbJWrRaOjlkf8RoP?=
 =?us-ascii?Q?BylWWKN+C1FUvyWPAxQjFQe1R3xwxJSTPOXwmlrcFmwmgUCP9B202+/GhDJb?=
 =?us-ascii?Q?hbIJvgNyc3gNm1G6h9dYnylBkvACTkYL4rqUhIf5UTcu7ViF7h8wo+SUEkdV?=
 =?us-ascii?Q?HDf7yba7rsHq8xfKnyXG5RchAHvabXr2cNfeeTBR4euH0ePfgclzYQXy7C8s?=
 =?us-ascii?Q?uPpsceE9YFiXCvdKQLD2+RxBpR7YBNBjtnUbu0Av3nwz2u1uCCltJcXSRkoT?=
 =?us-ascii?Q?9mK+0zoL4ZGrkVvJiaAPVMcnWATkpBTn8oDP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:48:19.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b799faf8-de3e-48bd-d1b8-08ddec4832f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

When device tree lacks optional "xlnx,addrwidth" property, the addr_width
variable remained uninitialized with garbage values, causing incorrect
DMA mask configuration and subsequent probe failure. The fix ensures a
fallback to the default 32-bit address width when this property is missing.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Fixes: b72db4005fe4 ("dmaengine: vdma: Add 64 bit addressing support to the driver")
---
 drivers/dma/xilinx/xilinx_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index fabff602065f..89a8254d9cdc 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -131,6 +131,7 @@
 #define XILINX_MCDMA_MAX_CHANS_PER_DEVICE	0x20
 #define XILINX_DMA_MAX_CHANS_PER_DEVICE		0x2
 #define XILINX_CDMA_MAX_CHANS_PER_DEVICE	0x1
+#define XILINX_DMA_DFAULT_ADDRWIDTH		0x20
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -3159,7 +3160,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
-	u32 num_frames, addr_width, len_width;
+	u32 num_frames, addr_width = XILINX_DMA_DFAULT_ADDRWIDTH, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -3235,7 +3236,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
 	if (err < 0)
-		dev_warn(xdev->dev, "missing xlnx,addrwidth property\n");
+		dev_warn(xdev->dev,
+			 "missing xlnx,addrwidth property, using default value %d\n",
+			 XILINX_DMA_DFAULT_ADDRWIDTH);
 
 	if (addr_width > 32)
 		xdev->ext_addr = true;
-- 
2.25.1


