Return-Path: <dmaengine+bounces-3434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1029ACA1A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C32EB20B21
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34231A76CC;
	Wed, 23 Oct 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXUH9d8w"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163401AAE31
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687005; cv=fail; b=akAqfbnA62D0QF9TCMdxs1OKleoEcoQqlGMwJEHmk2aM5St7/geqGmqVlKmsaGmfTswjxwEfvDJwrbQ32YO1pHLJNk9yrBWppp94sF3gdUId2DSTl+9W+BJNIwN7X5jzd3jJ/Cmkl0PKjl6F+VFc8+tQ61nBTV7cdMA9DhwEpsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687005; c=relaxed/simple;
	bh=ygmAOx4cq4bM6rrXk/qdv0QdWM7/D4Ewva7t4V63S70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYm8lfPFWgOBwrqTs4rS0CnpifmwdmytF6bPenjOLaHoBFgR0h0q//QxatszzLss2INNUv7Zc76PUspirNI/sozMdnyQelGFGxpwulWD9M3HQF7YM5CWHveahtrS6hk4Nunw09SdBDErgKenVzvLNZuMe6vZSlQkIBQx2A/+V0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXUH9d8w; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgxUvhCWzDfaY3eG0xyKkj3kuFVBh3rtwbqggkkpIYVjipAMasEJsTkdz7YhPfzC34LFFomFhsXTDea2HfAt1iHapbyGv8Omq/N8Mlu3eo+iDNqeDSMlNKGlBrQMjorBux/eOXHE3pz5iqrrK/KOkhOXLJIgihyz9osPWpAxpj4k4DJPlNSiHGPXHiZJuTA1f1LIxT4/T3dRCPmGAIME9O2OWg8YFZ+rJ3nlwmq6HFesR7EhfCRBaam24iHQT1kEPF8nW7sYh35qEBADIN/FWdkVMZ+2/YxPKdcScgZKXSChvBHibIyuqkW76uj3WHqHTVNE8cp/2sQku1x5Oin+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXe/ERreli/SgvH8WB/YeogdRemDqmqA3IQkO6y4PCA=;
 b=yUug9v4vuC62qmlaX2yBxmooUbgcyAkWRIVcNX8aRitVeK8UsL2VEYyypQJ7KN560wn5qQ49KUPDAgOSK/y8QCYwYs+eXGeZxYphY36xWSsfj41cBrNUo0TwGVQbOLROF7I2Ly78rAiFLrlWwrvoCb6ajNt2/AYSD63BKscCSEdyx5O95pdY1m25Chu9sPvnZtky3mqjYnxIgyrXUQmzUgjodVulX34hPHxRdlC8ICyD55bTk4xyP/XKRrcseKrBlQBfk5Sgvk42oMD7OeoSMdPHx36O2csv15n79J6c29CB5n0b0HKOfHxQQClX35gx95R3CZirxrZaRAHKogQWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXe/ERreli/SgvH8WB/YeogdRemDqmqA3IQkO6y4PCA=;
 b=DXUH9d8wieq9n4KWdADDC8tlzmFZYIPdm9JTXS8eiVQ9mSVarDA/xDuID0vThc7Huvy0vwfwDIGuutRIW6Ve3y7kydjyuuZduEijgBc7ovf7Baijwfp9BzrwXEPW/5JDFhBTGGLzxKmVB+vNOcLrZfE5i57DkKNO6bjgytel/UE=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 12:36:40 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::ca) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:39 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:37 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 0/6] Add support of AMD AE4DMA DMA Engine
Date: Wed, 23 Oct 2024 18:06:07 +0530
Message-ID: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c91935f-55dc-4b7c-be23-08dcf35f577f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lZ/BH2AIjVhYlQycx39WO4JmOmAgm6R/PZ9HaipS2O8iQvv888dGhkf0cbof?=
 =?us-ascii?Q?ONpAP53tYxgeh0VEyUSxZ4ZOqYoWK9N0lPObLSiR4B3p48dJLoiOco6fzhAx?=
 =?us-ascii?Q?HJ9B4h/qPaLDpvXyQalgSerXs1YxVjIw8gNNSVtBg5M04tbTf2nJ4JGsTk83?=
 =?us-ascii?Q?BIIH2lW/XmVqlBRZC+fEwveizl+041NBdip6bw5x+YX5AWcbfpSR7wfGiVuq?=
 =?us-ascii?Q?VPFqX88C+FHDNg3DLMI6MERNyq4BHuFBxR0Hk7zDvRHcvDDXN6KTQQ5sKKaL?=
 =?us-ascii?Q?RegX40qcZVU3sg6T+Gbue7ifXbrZwkqasWzoON811msPUUCm5vesrC1Rs30h?=
 =?us-ascii?Q?HhOzekWO4aDVPzkfZ90ppuSTuwAob1wZvSYIsMGU+efUr4r1TwbtFnTPW2Zl?=
 =?us-ascii?Q?hjddn4LTI6uo4pYrRi3Een/WgUVFGSuiI1NKfi59EH+uAzAa8Q19aoyGbQi2?=
 =?us-ascii?Q?+JW89PDalQD99MG8laedgyO59Cb7JDXCp9p8qm9BRrY2d2bAzR+zb3PZsj5c?=
 =?us-ascii?Q?Ge66TJ1i1WLjUrSIFM2XOM3phk8911J2TyQCXW9tyn6Z3UBc4Dv7Z3Qw7sEZ?=
 =?us-ascii?Q?lHKgLFG9GoXd8dfwgHNDGYkMc7Rr+XyT4R5vms1+gXrJ0/1utoriqSNsOpQh?=
 =?us-ascii?Q?HHsxHsdWfQ2TTTEf1p1cgdzgKVF9DkGc/wV/fKzsvZ0QByakbmgVKT3qvvMu?=
 =?us-ascii?Q?bK2PdphrQi4TWHgTBPl3gJwbMlzHeZ7g5bSP+Dw2uuHkwHUsN2RonQ+7v7xF?=
 =?us-ascii?Q?jnR7ygZ3K6BZICddl9jLjxoDwszSqzbWxaWkSPf5YzTGcuM/Ja5CWhHmT14G?=
 =?us-ascii?Q?SEzcNgYGAMDMPIwij2dxusB/yeob+qmmwXKtkl/hcnAhfVLqxSeM0ne+Rta3?=
 =?us-ascii?Q?kgEW5tiueufpfbcSVVjncsVwjXcZY/J06fbejtYlW1NfXmyxIpdSL9YKHG8x?=
 =?us-ascii?Q?jBxxRHhg4H15R3p4l3tbjqWUpQ/uq/MPdgLvqVsupKdLPXmwW+Uaxtn7iWgc?=
 =?us-ascii?Q?LtFtniTcfrA1u474phOb6mKNqWArSSBqJeu+x3F/+SzDEVlkiqwVehLE/f03?=
 =?us-ascii?Q?dBt71oywI0C1fsnbh+VLqpHOXGeAGzobc6pnIsAmbBQyl1QXNu0A/wS09JcO?=
 =?us-ascii?Q?0d4eisSxeIhZH4/iTk5TjhWS+8pegz5WBVU7mR2gsNQ+GNY0344A4jC3RXtI?=
 =?us-ascii?Q?dIn6CRnhAbqiJlPBHlLu8QaDmenssveqcInZPrlt/okSUac5Qtqb6os05LRV?=
 =?us-ascii?Q?GWmWwcvROWKwNbJDIg31ZSU/916aZQKkj2yzmBw46Mt+XXw4WG4XXvR40TCO?=
 =?us-ascii?Q?5t89zpGleOwo+/r7q32V9hS5248BYid0+UWnVihJES4Dv/A9bsOxjkTdv/k9?=
 =?us-ascii?Q?S0w8OcIFVSgeWFvzMVVgziY/PsXDFGSGzyx+v7jpn2ti/9NgTRabmFf26UOV?=
 =?us-ascii?Q?Pcwve8cS3As=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:39.4418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c91935f-55dc-4b7c-be23-08dcf35f577f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

Changes in v7:
	- Changed the subject line to reflect the driver name.
	- Moved the code to reflect the changes in the first place.

Changes in v6:
	- Moved the wake_up call just before the return statement.
	- Changed hex values to lowercase.
	- Removed the common directory and added header files directly 
	  into the C files.

Changes in v5:
	- Initialized the buffer to zero before using snprintf.
	- Changed the function name to avoid a duplicate symbol error,
	  as pointed out in the link below.
Link: https://lore.kernel.org/all/202407040547.MfCINdp6-lkp@intel.com/

Changes in v4:
	- Removed blank lines and grouped the mutexes into a single block. 
	- Replaced all magic numbers with #define macros.
	- Added short comment for error codes.
	- Replaced the while loop with a for loop.

Changes in v3:
	- Added COMPILE_TEST to the Kconfig.
	- Considered using pci_alloc_irq_vectors and pci_free_irq_vectors.
	- Removed mb() and atomic variables where applicable. 
Link: https://lore.kernel.org/oe-kbuild-all/202406240021.ytiS3jV6-lkp@intel.com/

Changes in v2:
	- Changed all variants of "mb" to "dma_mb.
	- Changed cancel_delayed_work to cancel_delayed_work_sync.
	- Removed 32bit dma_set_mask_and_coherent.
	- Rearrange the order of the #include directives alphabetically.

Basavaraj Natikar (6):
  dmaengine: Move AMD PTDMA driver to amd directory
  dmaengine: ae4dma: Add AMD ae4dma controller driver
  dmaengine: ptdma: Extend ptdma to support multi-channel and version
  dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
  dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
  dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup

 MAINTAINERS                                   |  10 +-
 drivers/dma/Kconfig                           |   2 -
 drivers/dma/Makefile                          |   1 -
 drivers/dma/amd/Kconfig                       |  28 +++
 drivers/dma/amd/Makefile                      |   2 +
 drivers/dma/amd/ae4dma/Makefile               |  10 +
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 157 ++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 158 ++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               | 100 ++++++++
 drivers/dma/{ => amd}/ptdma/Makefile          |   0
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  79 ++++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 225 ++++++++++++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   4 +-
 drivers/dma/ptdma/Kconfig                     |  13 -
 16 files changed, 725 insertions(+), 64 deletions(-)
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 rename drivers/dma/{ => amd}/ptdma/Makefile (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (52%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (59%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (99%)
 delete mode 100644 drivers/dma/ptdma/Kconfig

-- 
2.25.1


