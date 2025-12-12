Return-Path: <dmaengine+bounces-7584-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD1DCB8C7E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5AE13011335
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545042E6CB3;
	Fri, 12 Dec 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpQi56tn"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E639225779;
	Fri, 12 Dec 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542069; cv=fail; b=ijbahOUI+7wYYj92cydqJxhwYYiX/Lo6dKHiFu6Z768L1RDkdmfxQCRoMo2i4kcgPqd5wS0uRPQZ7dC51yIU+QMa5oC7B4xKsOrUIWc3N/YDdo2pcWoaAfuY6K8j545nu+KYGAymgYQPjYH79KrsfX1pZGzUaswv+ODOW7gJtuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542069; c=relaxed/simple;
	bh=i0ZEPsS8VXsP8RkukPNnAgOLasfJ8PClIFaNCynKQ1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjZjUiJZkUui8saO+CxRAXKgBlBjNrJSMEmnKEzla0dyuq0Qo7qUwZu7wH2KvY/ksEaez6e3PhnRagR/8DD/51RBHlkh3RlIdUY1uTBXyDObsqdfTd6fbu1od1I61r4Pu7WqQq997zoFaNykcOn5f3CffUIAb5smJNKqzxPLjYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpQi56tn; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN4dl+0YlydCrXsiGhH4pubWg2hORMTZexMuJUJpwnHYyjtRHBrQ3NisFk01KUrfKCR2gQy/Po4fQBjdw66ypVc830FZLPMXoC76Abq0DwD1umlGLiM4eHjCnH2ZK6rLz0U/XtFYYzlyOtgJQ/Ud5TSNrcfglSmHT4H5YqH6kK0DVxhrcJc15Rk5rxL8lIYl+PMfjYDRVcB311yCMVhkgbVsASSeNX7CdeP1dT5QXq2YteZDDkt2QSzHKybydPSEP36gFEm000fvjNMyqRS/3rv3kVmt7tO7JdZza1UY0iL4KaecpEcnvZQybgPr5jj1q8CvdjENvyT9Jm0++o6cKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e68ntv0R0vGpmVGacB8qkILnE68VhyRuEGCPK8fMBCs=;
 b=nzxk3NPKm3h4R/x8WZmupnOu0wbEUohOwd1imAm/fnBBACBmISSRxmwX44FVZKOIJRYTdVznoO+VUR4OqWjKgHfnwVnyuG5/snwflWx+0Flbf5yWeFDUx3HQWXceL70laJnfziS/SaZd6+gkp4XD/A51b1x+ZrKrZTFLjwCUhkx1sAOwYZXe/1GaU1EP5QxxCF81p/LN4Tt+TX51BpxF8H73Y3BdswDiFxhxHOv4H+ZPEJbSRogM86Bq5X30IO7MDrPRh7oYxvio558EHnDcRELG2FMpZwEcEtES6GUv/ZeDZIT3PCnMVtK1R252w/R0rhrSZXOkabP1KuK2j0Hf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e68ntv0R0vGpmVGacB8qkILnE68VhyRuEGCPK8fMBCs=;
 b=rpQi56tnl69BSpijup2GvtT7QKCz7vdnkY/8bnRUVAhdPmdk3FzoN3PuXVtVrRZ8QlslQKQoAM44qYR2lR/LgI5fGjIGCHQFDg2IqHCZPH1G3EiAmw1KgpsNKo2TFvcL1ONGBugyORr2FfIxDXG6G+iQO2Ry3suYLGVy06x5p/I=
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by CY1PR12MB9584.namprd12.prod.outlook.com (2603:10b6:930:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 12:21:00 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::7b) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.16 via Frontend Transport; Fri,
 12 Dec 2025 12:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 12:21:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 06:21:00 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 04:20:57 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v7 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Fri, 12 Dec 2025 17:50:54 +0530
Message-ID: <20251212122056.8153-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY1PR12MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 63487337-14d8-40e0-e983-08de3978e93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aOk+nGcA6I61/IZs3NvwKDR+nwy2pSewH1WiPIkpwlhG5rcj+ym7JvuzRfbT?=
 =?us-ascii?Q?4rzE4BpATs99cQQbRB5AZpPo1KivMp7FkbYb5APC+zd2BOJLk2FGbFOA1pd8?=
 =?us-ascii?Q?EKZtOTLxBU8CBqArjyu1sBbtN0q/xc0RPM8ViZxVzuUjHdI8jXYoTkKP8VrP?=
 =?us-ascii?Q?doqEoWejzitRwH5jxhOM3j16bX1hlrRgnTJxPMdxSd9CCTw18Ipn2MJQB8oO?=
 =?us-ascii?Q?8wSsa77QeABXIfWKeo22TD1VFkTMoY9qUkhwu4j4aVRIEtzo+6lE+sqD8q9V?=
 =?us-ascii?Q?q/tGnBg5hsOx6ZgdW5eipQejnPOYCk2aB0ywfJ2zJIiuC72dqWlGtVrze+y0?=
 =?us-ascii?Q?V6J7ZDnGSXNk58qUAZwKhy09I3k8QM5ypUU1RBoFgUC9pnLgJOnhL78kBdcQ?=
 =?us-ascii?Q?OAZ1w2bV2FMHLlua6jtZXWXf7mmuPhx6MSJMi9TsdAisnrcO+ZgyeLDhCOPO?=
 =?us-ascii?Q?dBaHmU72V5nhgFqqeLtzX/SoAp5aQPOAJNOvXYQ7arpwpELObuw2Txr+Mvg1?=
 =?us-ascii?Q?7ykEur24Kxk6yglCBhrZyzeEU7M1N1pTg06KrxP8cUb4+3dDX6TCn4X8pqBN?=
 =?us-ascii?Q?vaGcqj2XUmmKiPBAc1Z952qoH5Px+9xyfZMN36D8B9dYYxgeec3CfP4prncS?=
 =?us-ascii?Q?C2+w9W9IhFOtk2lgk0XHUTVAb/xRVcS588mOpo1IpeUrUtLpbpyV89+np9KG?=
 =?us-ascii?Q?B96pgVSTQRE+N6NgClyijiCMYtayuYTOOIoc7rvtxuAAG5f4/wqRkPRDkDnT?=
 =?us-ascii?Q?FVpUrstB3C+Gv1cOKgizIoqQvgJ8hsfd/m/v0ujbcGFD4Ob1LacATbpG8++h?=
 =?us-ascii?Q?8b9XVOnbgQD3jxYTWghHFJcXCwVeX4x4Z8lU4yiq+uLshT0lPajfcwdhjVvb?=
 =?us-ascii?Q?rXE/qyuA5HvGfZE8iovFKJ+T/msnzrqtcFbLAlm+Zho3rDEEOCVenFic3ukM?=
 =?us-ascii?Q?IoDdYH6K6+8Qj1HIJ6Y26T2qDLZh+unvHrUGRiY/V8KR0+e/luQuII6j7hDw?=
 =?us-ascii?Q?dMuawUmFZVMZyQLirPrqOvB/Aq/g9tL7c6ZqSo6FcitwTB9Ir9A0UCehiP/S?=
 =?us-ascii?Q?FJ2whQpv15lAoZSBG3JgLJmPogjwekDnvtoxDMn1cm7aL+zO0tPKzRSz64Ra?=
 =?us-ascii?Q?wFUU1eG33pDXEi4RXqbBWfMawQtzLw6DEDGUIQ0zqbLs4UfdE84VCxTVBUjI?=
 =?us-ascii?Q?oozsUVZmNx0iAzme7h/0K0cI1KCe8TGRl2DT2jLD1V79TF6sllkFevL896z6?=
 =?us-ascii?Q?saKmr7EVtvjMnJyCeFo6bLgsRLtVKwDlawmZ33yeVzvwKgiMpyFisKiuq9wQ?=
 =?us-ascii?Q?N/P6KxbHBgllz+tJbp+7veE9OiR2qDZz106U7sv9XaAUqCiIg4OM313gF7j3?=
 =?us-ascii?Q?xbBn8CbSPV4Sq3ddKy9BtTuOkRIsARE97HmP5IwZsBa1thu/CVF66WlQiDAn?=
 =?us-ascii?Q?paPjA3IKET8sPZXEbfT9wpc0eVO7xs8HtcW7RRVHk3pd8q2/sG9xniXHINIY?=
 =?us-ascii?Q?AgPywv+6wo6c9jSGE5cAp5to3EKdxbfwlrYRTIoLcK15wUhbSK4AXTpw1k6M?=
 =?us-ascii?Q?tdELHaqoA4bU4S9Pcis=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 12:21:00.4561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63487337-14d8-40e0-e983-08de3978e93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9584

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR
   o Logic to assign the offsets to LL and data blocks if
     more number of channels are enabled than configured
     in the given pci_data struct.

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client for all the vendors
     using HDMA IP.
   o Allow IP utilization if LL mode is not available

Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  41 ++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 199 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  61 ++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 289 insertions(+), 15 deletions(-)

-- 
1.8.3.1


