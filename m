Return-Path: <dmaengine+bounces-3570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA969AFF5A
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6991C212A3
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A51D4359;
	Fri, 25 Oct 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TyYoJFdw"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088E1D5ADD
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850443; cv=fail; b=uAfRd6vKXJGTR6GsZMWHn1TTb6QiX67hYNH+FJ5f9Nz10aQWKjhXBzlmiDQp1MzefTBJZ2+fuSuIKNvAHfS2peao9MAo6DSicuFiBaFnuN3fmBLyIdX9g1c+c95eCMzgE+cDNhTSf3VR1TZXdT0bKLRfAhAbTvteDz4cWxFl50s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850443; c=relaxed/simple;
	bh=NPTaYp31yiBlsdnKjKGAUHcxzh+DxEAe1RmFYH1Q8lM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFICyo5BFCQUbEavRi0sIElDl8mLUT/CygiRdsqJQ6Zzi4Mn9n0GAkLxxZgROW9R4CQKUsVjacYvxH4t15HKvOyAXZhCakzane+QzH1jOAWRHfjtDudw4JRK62Wok1AiWXPlgvM1sqJy8y/hK+LU7nAG211PDVsTXXnHj3oG45c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TyYoJFdw; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI70td1dQ6TzcJBYtKao/enlk1y5jbLETgo1gfXhZ+30/8ureNF1TenhhIFA+XYHBueb5/aDZ27vAaDxMzQsim4GkeMv3Itdz9htg29V1jAn3/OUDSqlfrWZpIftV3d8gLYIh5ZaRUujN4k4k5cA+rRYBB8NMlHc5tDmZLH6vrUQVKRgWjfe84WnvvdyWQ/oqrB5w3gglD/JvOwQcrtpKqDCOzecTuOCTiA/q6yCH2gvIX55Wl9K7xPZY0hkkODjD45mYq0zqBQ8v74AtXwyijmgWvErRoeLtpj0LTJBIdYLgNybUZWCKdHOKFoYZBLuX4H1nipLm0CiIRiJUIOasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmylXibVB01tVDeFqU/SkkgOz7j9DqDP6pX/RROEez4=;
 b=CldwtDEeT3sd7iQRq3Hl6lesqpdSMJDmZQwumacdGagnKdLKkQFdolXvMQkk54ifZ8A3Sy/Be7IAINCXp5pfmbOVWV3SjvpWwAAvq/W2lI1dSnXkpgduPqkHcODCBTpfAnv+KEq+gzsgpXJ4VZbEKFlGzPgh2uQDD19G8cEj6L2yO1cmuntJH/u/sbsWDRBkiFNZing53j2DxT+Q5EENWkt3MDoj71xOZm/FSYfyozx1abSQm7cYToO3my852bKVX+q2I6mqsOsx1CQpg7JGzRNVX/U7287HiEbSbueQN4K1Fz6m6BdsZajz08zb6rqpfl949bEeHauUjwnbwBewSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmylXibVB01tVDeFqU/SkkgOz7j9DqDP6pX/RROEez4=;
 b=TyYoJFdwzJL2d+v+LoAipVN4TStUM1pKg1oA4TLPZiv335hRPS+iyxsJ3mRJIg3NjFGEDsUoLWAMcotk0BKR0ujS13PSGxfQVe9u0OEChNwR3/lLRg5QmZKjvnY/fVfm5Ed3HbWwW8s96kAwkLv8gJLpcM3qElbF7qnzukiAnMk=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:00:35 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::77) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:35 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:32 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 0/6] Add support of AMD AE4DMA DMA Engine
Date: Fri, 25 Oct 2024 15:29:25 +0530
Message-ID: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f68ed3-1feb-436e-9244-08dcf4dbdef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXbYwLvlOKUhE5nlbbHkbXCAM8JyFI1kPiNOX8CvCWsOgfBsHdbmdU3aSvSv?=
 =?us-ascii?Q?lPKB+Ium9ii5jeTEWCZ3SGm8Uv9YlxMsoGnQPr7GRXK5l6v/+/bh/FAIRdF7?=
 =?us-ascii?Q?ZTA/kwXXdLTzDbUfq2gV0ZU1lPys627BJZL5CvriPjzo3Kzimz4NwlqSr/HI?=
 =?us-ascii?Q?oBfj5+DKGG51E84IwBN+wna3UyR1LWGZlz6hWRiHEWA4XrNPUSH55lupN4Ja?=
 =?us-ascii?Q?Ves15vTh6xHdVGY2i9tUz+aJJCccqXw/Rz8d4ph1zwPixf3OZ8z74aEBcegR?=
 =?us-ascii?Q?N0An2i1WgEAtt48Sgh9AvllQudQrQ6ddlMS1V0ntWJSVi0UBk+WqA82lE8Qs?=
 =?us-ascii?Q?gYegjJyWUpkH/N9J86XKw0Wf6ftzbZyG8+ekBBr5Y6SphQ07ThJIKevut4mL?=
 =?us-ascii?Q?/n8e1ZfnPVblhFLw2m6MQVejgiNsUDZF2d9voWdg9+1RXrmxuQCzBovG8m6U?=
 =?us-ascii?Q?MBw+cDvyXSIg2R/s7Os6o2vLQSB2O1ls6Mv7aTIVDMxqgaor365JQcmMB1j6?=
 =?us-ascii?Q?lDNu6NWaNBa/R16rT6zO0RCB9VtfWRqsO6zZYyJV/O8hVJ37Zp8sEHrHrDbl?=
 =?us-ascii?Q?or/Yrcwh2M5aJSGpIvIvXuS6wY8ndWt9QelWKhK8R70jHU2vf/RtvYbiIGIE?=
 =?us-ascii?Q?yIWD/9uNsPTZpE3aD8nFLBq9gXwMTGsjg+9WoC1MViJ7KetFUyBvRLrcI9p0?=
 =?us-ascii?Q?LGnw+8p5fuOFUTXLdyzW6LZNBhl28O6OLJbVhmThlczKWgD+Wrdw8ND+9FFE?=
 =?us-ascii?Q?8wRH/Ps3/F9ZXwkH87zWPpBrbyukINsWbOmjJa0LSICzrmFeQ52naArL8You?=
 =?us-ascii?Q?9x+sAJGdgNDUjjdL2HsNQisLOufdu9eGOFaFO/LnXUS6hP28YLVvP0VHRFQh?=
 =?us-ascii?Q?Uxb5/2tCLtZISNj5sB/4wqGCsF+pOoQ3szCAPELzOSTQmllhVERn5U0kilxg?=
 =?us-ascii?Q?kZiAb9GK4vLqyJIjOs/7x0olISmv67EmWa2ddSYekxj61UdlT2nQSFh+VrhI?=
 =?us-ascii?Q?VCsor6qaAMNMorSI5Mv++XMsak0oWgvYH/s+hu9QL0qNgA8Kf4HWvlrX6TdW?=
 =?us-ascii?Q?0Lka8W9WTE+xbyqkBrSWEj/lbZYwFbs6bE708MAe3ahxN4HOi2K87EJH4Sml?=
 =?us-ascii?Q?THf/u3JoDX3vRm8LJeMvmFYYaJgdqqtgOJNCHolBh0HN8nZ2D5tlDD+PM4Bi?=
 =?us-ascii?Q?Z2sxhX9BxoAr4DoyjDbG9KY76q7z8chmzhy15Tyj9OT4p++ns6EEiy0IJ1Xn?=
 =?us-ascii?Q?X2+3Y9dQDypkVumBGfEjiZzcIBkMg21eWuB8TrlmUWXgn0Cv1YOKglDK1yZN?=
 =?us-ascii?Q?eGK0fiKr9gwm7to0CP04VWNURSHxpRztxbphBOSSGCLFbjnJ5nMK/MRz8JHB?=
 =?us-ascii?Q?H7fI5RTJDTALHYzeQ4jdCAQMYuNXHViwbkD/FuXwMQB3Lf+ssx8OrcFqM1VD?=
 =?us-ascii?Q?So4kh72uBIc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:35.3881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f68ed3-1feb-436e-9244-08dcf4dbdef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

Changes in v8:
	-Addressed warnings reported by the kernel test robot.
Link: https://lore.kernel.org/all/202410250904.txsoe5RZ-lkp@intel.com/

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
        - Rearrange the order of the #include directives alphabetically

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
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 226 ++++++++++++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   4 +-
 drivers/dma/ptdma/Kconfig                     |  13 -
 16 files changed, 726 insertions(+), 64 deletions(-)
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


