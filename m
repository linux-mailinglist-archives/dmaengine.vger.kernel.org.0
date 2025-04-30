Return-Path: <dmaengine+bounces-5040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F27AA46F5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 11:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECB24E140F
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71C231833;
	Wed, 30 Apr 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3PE1A6ls"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB023182C;
	Wed, 30 Apr 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005152; cv=fail; b=o9PcvJnHhoRCvHhocnalzd58Flj1e7JhTsWRJXexqbAC+BddkfEkRI7l2regdVHUdDwj9NVmp7c5dDJznfZOUBx6WnwOphvWfBCYPjkV0ut3W3kOco7XbWCwg6X/Mnb9XvQfwCOvkPYRdrauUW+EfkYcLHVIy0FLNITwdNyL9Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005152; c=relaxed/simple;
	bh=sAPaGNbmcNaZ2FjSmVeLeKEeXH5DChwSRCnidHOGLMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOA/bxsbh/0JadbqAp8nHhFNzfW2cAGf24FogzScq7CUQawYy48091z1AdIdYXdc4Ep9+900k6AJNZ5o74pWevaVsDfDx1BU8mRBHORrw0RrxxmrEmNx7VXjcQGCRrFq6XjE+SxyIsxQ4bADIE+AMRURR6NS2gmFVpPJwq+LDEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3PE1A6ls; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRLfiz84J2WUp3/xb/+nWD8KBZSGciJwXs2yCKgsS6hAY+TnWzHtpaQ2rmYqB3O1HvZqV8Hovton7TUSCtcV7u864du/M/Cf899DFaXez8Wez1pmzGp7K3zUBsdgcON3RGb369dO8SwLGdJUtmDuUhD7bzjQfKbN31OxD9uirtHqRCIdplauDW3EmaOlm/jmR7+/6CjgR+e1Ix+fv6FqS7MeP4z3wX0yvm1JTZXcWJrU3TJO41LuNKeiUjIcdldQXGzQphHKbq5Tp+vUvkMDNOBA06dqQE4Y0hFZspxySn+lbz8H/RKdIverxVfV21PSrD4eQfl8xzskyhwXn2HPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYKH/YcYMcy1gobqFYWWEFylyKrDse4rTF+9j0iuxYU=;
 b=cAg2R0exPkCx4tG6gMY7F+NvWipTZJ/hkC0pj4ENUe4nS8qJOZjbrNpBkeuS2pNYEpKNyixKAEzNPMa3p9h1AuTyOndus71kBob2/VVi5vlF16baBYDJcbuh3lpRmctt9Ljt+R3XmCXpcsikt2/e3w6ToRoxGbcypZAOi2h8CwXnt3gq7qcDbsGzLRIH12XOAzH/73F4woCrUsr5JExyKwNmv99TB6hOJhzzF4mIuymSKFjzdsoJAGPQLCMFClsUMsliO8DC1rm4U5ohzP2G3knisU9IXX8LXKnQ5dfOgTRU9mE8QEkrXDVZ3VfHKn9C/yMzurXQt2+kWbLuFc2jDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYKH/YcYMcy1gobqFYWWEFylyKrDse4rTF+9j0iuxYU=;
 b=3PE1A6lsOrtFRyD2V1P0ll2/I12aPzkcHoyYf+q4lSbIeA4BYZ5dmdIwcb0ASgHVObyGp8gPbR1/A/eENygmD4QlnxfX9wY1JHKSaFMfsOSudfLQPPNeA7PRhdnZ1n3wYfjD15LHHskG4/os0Pb+nlIcHGosZ+QZLRY6mOUYSaU=
Received: from CH0PR03CA0398.namprd03.prod.outlook.com (2603:10b6:610:11b::29)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 09:25:46 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::3e) by CH0PR03CA0398.outlook.office365.com
 (2603:10b6:610:11b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 09:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 09:25:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 04:25:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 04:25:45 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 04:25:43 -0500
From: Devendra K Verma <devverma@amd.com>
To: <devverma@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <michal.simek@amd.com>,
	<vkoul@kernel.org>
Subject: [PATCH v2] dmaengine: dw-edma: Add HDMA NATIVE map check
Date: Wed, 30 Apr 2025 14:55:40 +0530
Message-ID: <20250430092540.207522-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 916d8079-44b2-4a38-f8d0-08dd87c8fd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ThBRJjLfS4iA4KRoGvi713NJQewZ/CM5Qncj+pr/NqBnjB0SDp4x24orStm?=
 =?us-ascii?Q?cUhFsdfUALr4irey25ETL7KGkYXWt/XdVbwVccOInJeBBKOoWMXFQivkofHI?=
 =?us-ascii?Q?47TMlxck+dadhrMc9RmHbfYFS7Ypyi/ZKwNT8Q30yIuH/pk8FuMQ2/MFFSVf?=
 =?us-ascii?Q?aPFvnRE8+KVaS74z4CNvncCN5ciN2cQ9EcDeKU8blPDEOabn7ggYnW+tS5lV?=
 =?us-ascii?Q?dSzqphQRB5lxJdivVxFeq4j8nZe3mKkfIap4wjd8RwaR8ajBtZLxQlDI5vbu?=
 =?us-ascii?Q?DkJP/CukvMCMgCj2pA19FikYjFoiVpFFS2QxsIgk4Gum+3oKw8k8H6tBMGA8?=
 =?us-ascii?Q?xoMIg9hCoj8im52POAXBSv3GEj1BiDOFbJI9vu7ofhQDJvrIQ+iWLI6V9a/L?=
 =?us-ascii?Q?1VmZACqEgu/jp2uolOT4DaZLmzkwN13Tmp1Ta/+3HWsNIEtER1Gn+Hzr2k/S?=
 =?us-ascii?Q?e4ZEddG+OlefT6rWdiM2ezC0P/I4aSitKWGeRz6fy5kdeAhGYpbGn9oZcS/d?=
 =?us-ascii?Q?MaCK/sKYgi8nnRnY085bspzAWwkrZBqUdyEGY0Exdm85YVslMIR3lfuM14kN?=
 =?us-ascii?Q?ZP6zk04wtMQQ6z1P20xt3q63ufOVQ+p5fzNNxf/+yUC9iV248Ck4MdLbmWqI?=
 =?us-ascii?Q?pIphrM+CcrBiIO+kWExgxqTNLvFVE7Jzo0sTa7/XDqky3n7xiiHTarfqw0cZ?=
 =?us-ascii?Q?hDdopOy0SoDk3RC1ee4u/zbUlRVPBsINP55hkTZrdT5O7Uh6YuCVZ1xb6m4u?=
 =?us-ascii?Q?ISm7hYDTKezeK8qJyzAIguZ9d0lHvJvbRwDigDMV7QzKCzdr4ilJpZE3890B?=
 =?us-ascii?Q?SsBa/a24ch3cWsmmygPkqOaqF1+g3WmUKgxQ1k8nmap1CrnfvYNAnRUyJaFm?=
 =?us-ascii?Q?x71Qy6QE9OEzJbeZIkWBHFO3+Ot2tLX78Y/Ak4AceG0L6d+M3tNi9D90VS1Q?=
 =?us-ascii?Q?DH+Rx/yyn5joTgaCH+SChf6MjRFD5SpVu/kLaX8v06kr9R4xEAwW8xlgO2Nf?=
 =?us-ascii?Q?6VznFqMbfpkZKs1r+YjVeeqx8Yc7VrFzKylemIubD/PYNbrEth4QFx1GGvV0?=
 =?us-ascii?Q?o2JvwB/I9apPtFk0yWhD2RBayjyC3wN2AmUNGidX5L0RbjrS0QsEMFrZ/GGB?=
 =?us-ascii?Q?Mk/sYbKDCRkTDQENd8JFy6ngqRFyTyRnc+UpAdzO4rl5d1MXjpJSSQkb8RY1?=
 =?us-ascii?Q?Bnd59CUKhShHPshAvRtthkQbZESheINNil93zgmGU2wTBXAJ67BfqD07odKN?=
 =?us-ascii?Q?5XmQjVFl5xrtK6XC0lQClirACrqxN26HUczc5RlLDMAfm75d65b1SSlhk8CG?=
 =?us-ascii?Q?1K4gikH4NAO1cf9cyOEaSI+jv9B/rO5+P/W15NlAeGintB9UALKewHP/RA5/?=
 =?us-ascii?Q?xxph2HHYfUbVt9rvco+Vs34WaRLS3WU747XtGYAW+hGZSyU0feGv6RGTKaf8?=
 =?us-ascii?Q?3U3uDA7x5e4fPSwz4yEqYdrl1BhT3dH/oOLK1UhkuzRP6x4nG2KV7DoqycDm?=
 =?us-ascii?Q?4MMXHI2HW/EfJZSiBu4GjRvnuHhoYelTJLay?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 09:25:46.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916d8079-44b2-4a38-f8d0-08dd87c8fd0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567

The HDMA IP supports the HDMA_NATIVE map format as part of Vendor-Specific
Extended Capability. Added the check for HDMA_NATIVE map format.
The check for map format enables the IP specific function invocation
during the DMA ops.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v2
Addressed the review comments and added the 'Debug info' for
HDMA_NATIVE in dw_edma_pcie_probe().
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1c6043751dc9..49f09998e5c0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -136,7 +136,8 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_EDMA_LEGACY &&
 	    map != EDMA_MF_EDMA_UNROLL &&
-	    map != EDMA_MF_HDMA_COMPAT)
+	    map != EDMA_MF_HDMA_COMPAT &&
+	    map != EDMA_MF_HDMA_NATIVE)
 		return;
 
 	pdata->mf = map;
@@ -291,6 +292,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
 	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
 		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_NATIVE)
+		pci_dbg(pdev, "Version:\tHDMA Native (0x%x)\n", chip->mf);
 	else
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-- 
2.43.0


