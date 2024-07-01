Return-Path: <dmaengine+bounces-2606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157991E596
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFB1C204FC
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBB16DC2B;
	Mon,  1 Jul 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2GC1VFi"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537B16DEDF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852179; cv=fail; b=tlPXIwRBnzJWBW5X1IWWgavzPINg0zNVtuQpKR3+h+7fGBNFq1caTX2IrMmBP7JQVF8e1AEKc7MZPiChaHB0fi+Y0pByOLK8EXZ02OI/6wqauzuVkONpLHsgitsv3/c1LjpsQgA2mLBM1PMpSt4VKv3Aobeq6ZngC4Vo4ffoslY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852179; c=relaxed/simple;
	bh=mX+sX9hrZM6qKGRVntUpXEpf6KHqV1uELjuVzezbiN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOUQeXQm1WY7iRde7j5/ap/srrSbQJcaPbrkdSV2x8aMwvIHYgGiPAPnlvdwR6BWpBw08UMAPMpvkLVU/UAVnB9oG+wGNFm7hFbQuZQvHPoadpshra4umv8tV4t6CsQzaAIT7zoyK4aN9vamENBAb7ttUsWkDvuA4XawsIVn0Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2GC1VFi; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4nej6e8Wgi17r/0UCjClU6NjgfBoBG2JEU52rqINyvQWn6vzfj2fefRc05cqkkV0lyBq2ExBnmUKObL+146S9+mBsZ/dS8IVXGMinQuXwpflFB34RAl56XEtC20YOrlFmer1mUvd7vttfNniVcOO3bRYjThxx70jZWZ/OYvncEMbVBebd7ObPkBABGqSOgab4m51zGoi4hRXjnYKKCAlNNAn3nbhLj74MDVu0Rtfm7PBC/0aNNsbahOIH+TFXxGib1ZruSHBS+l9b0PZhEfYZcvVhI7NJcC0HOWVh4hbGWAiUHv5zGE0q8LQcWg4WDwdsd/iNBPbGkqYWdcOq/i1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1b7wQZODBRRs4KbEGVyQlRUhBfZwdSA6VVTlFUsxk4=;
 b=FW2i3a6oWg4caIWrN1qlq7mkUnwLilON6AzCV5zpNI3NVKLE+KGyg1YAzJGdCLvr/HwsNaBXhF8N8dwXPgKqjQD7sYVgYuUEZh47KyudbOrvxGI8ZL/ZxEeADDjx3WsGS972wiNs/w1R+9pfLjibzghi+R3hKgEqj5XjR46nQ/Aayf47e+ToQNoYgSWN+rQHpPz5N0RLbf4cAWuSB7CcXBc42AYP9+EFl6gF8mEDQn3ZQP6cGSRXzQyy8kBeo95+gvmx30LEePx6yHK35SYtDVQFSQ8JVEBkDmtPvDR67C3EiN7GYnbBUzgpZgc7OMZTtDiaPnVW63zbe+UP4eDwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1b7wQZODBRRs4KbEGVyQlRUhBfZwdSA6VVTlFUsxk4=;
 b=h2GC1VFiuRCiNdHjL31wWjqZo2+CqtMxaAh04ifnxljI/TtK5MnoBqQ5W1mO/45PnnZl57jo72Hik3NJ213CklbQSriUw3LdMA4pkPun7ZSOa9y56LbJBGnkp3Qcx/L+XQLsNaeUvqA2r/wofLuE8jdU0RMampYEIiItSSFrik4=
Received: from SJ0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:33b::16)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 16:42:55 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::bb) by SJ0PR05CA0011.outlook.office365.com
 (2603:10b6:a03:33b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21 via Frontend
 Transport; Mon, 1 Jul 2024 16:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:42:55 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:42:52 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 0/7] Add support of AMD AE4DMA DMA Engine
Date: Mon, 1 Jul 2024 22:12:26 +0530
Message-ID: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bd272c-aba5-4085-df32-08dc99ecdb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxvijV972NhaRq7lSy3iy4S0f0RtcNZc8+15LRJ9eD/w56dVENCSIt+l1B3j?=
 =?us-ascii?Q?FX75d/2FLjUEkpEJN/7d7DPtigz26DDgSQ5/9BtYWB6tzKAH1i4W31jwuQyy?=
 =?us-ascii?Q?1xYtD1lftO+2zFlD9lTRQIw/UWNqJO1Fa2L/jnoBFu7CUzIdkEBUyQCc8iS+?=
 =?us-ascii?Q?WxIzJCHJw1ZmDaXr0XPH4ogoop3zvt7ZKYz1ih7pkTLlfUWxM9ipVh4O8bK+?=
 =?us-ascii?Q?8GQXxjT5vUV02Ld06sOUb5e7avBKVzfixzQGNm2Iidr37eHI6KOHqsDoky0J?=
 =?us-ascii?Q?/igqtxXLvjd+FRWTl+HsfBunv5AweAHgnZap5g5mFyqHqgRl3uQmZJDHCJGn?=
 =?us-ascii?Q?W9RJZOfLJcLK3NWX5rBY7Z9O9BExO6Zlv8XcRVeBpzySL6bCgJ9jT7LV99FR?=
 =?us-ascii?Q?Gn2811dfyQ45s7zbXQ4m+/V+8RxvFYzDmzLoiuBykY/dzOG/SBD6oHjbT31x?=
 =?us-ascii?Q?ehwr8jDA4Ym9ZIC+b36FWhHWth8f6K9xRrNWBXrJoFvZ/hYI0VeOHHhEwZ2f?=
 =?us-ascii?Q?ATtfTpy5JmkrCVhBmgH9kYj2Up4we7YVVKBKR+dlUDNGKKqQ2vIdZTqIRaV5?=
 =?us-ascii?Q?gdGji6Egb5sBEq5Dp+kGcNi18DXEaodKkW+JGXSnLE3bghXR2mYELuGSLhxl?=
 =?us-ascii?Q?q7Z43PxrB798aG11+wl7FroODhb9rw82MbNDKCLdJplTMSHlY+N5CFc3kSPm?=
 =?us-ascii?Q?sxDJDef1g+lHNclXQmVF1y5PMOtKoTK71JGS27qgLW0gNr5QA1WvoPEdm7Ss?=
 =?us-ascii?Q?geBqQ3o8TjvYJsOd2uIP3U5aZcjGYhL82+ASGSWO6nwkX/E04DHsUPAzMisU?=
 =?us-ascii?Q?BrozzwLZbCZOtQ6Udw15+JMRhKCaiz0YUk11Rqr3U6bqgjv1IrAiEOTjOIjD?=
 =?us-ascii?Q?HFwaJtoEC2CXe2XocAUNI35jA5CkZ4v1wrUneAISY7/htEg9yCBP3xcWVTLD?=
 =?us-ascii?Q?W4atkanOeZsvXc73nRMhH42bpFrh1gZJ+HZoYcuM/JU3+KFLxg9TDMm2O6BB?=
 =?us-ascii?Q?fic19YJ/o4E06/MepFLO39Zp1scMkFs20u5p/TjlQpxV0Wp1D7UQQ41qu4Ar?=
 =?us-ascii?Q?YKfWSqEa6Z+0uk954sPLvcX5U8iW5VNy20m5wUSQi+n4/aa4YXAExsuEsd8E?=
 =?us-ascii?Q?ZMraKX38auiULF+makALlIAdrehE9NSfVklBqhNvL5wLJbUvCbIWC8B/ktpk?=
 =?us-ascii?Q?QphG+eRT8q1gNhE6//zJwMD/tlMus4e86eswCA4xkNHICY3Jrujb60UeUq80?=
 =?us-ascii?Q?7ncnNnKO9Pc433x4GanWkf5YDokUYFxIDsXZauGwxfYW2SsU7mdWUajH6XRY?=
 =?us-ascii?Q?/BNlGCjeO9mSfSxqDZGD1jOWllFacFHe0aGgUk0U41r/gGK6mwhohb3mHy6H?=
 =?us-ascii?Q?LthkhdVgyPan1Uj8DUX7tWCAdZK1e9bCfWMi72D250KDthEbIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:42:55.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bd272c-aba5-4085-df32-08dc99ecdb6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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

Basavaraj Natikar (7):
  dmaengine: Move AMD DMA driver to separate directory
  dmaengine: ae4dma: Add AMD ae4dma controller driver
  dmaengine: ptdma: Move common functions to common code
  dmaengine: ptdma: Extend ptdma to support multi-channel and version
  dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
  dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
  dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup

 MAINTAINERS                                   |   9 +-
 drivers/dma/Kconfig                           |   4 +-
 drivers/dma/Makefile                          |   2 +-
 drivers/dma/amd/Kconfig                       |   6 +
 drivers/dma/amd/Makefile                      |   7 +
 drivers/dma/amd/ae4dma/Kconfig                |  14 +
 drivers/dma/amd/ae4dma/Makefile               |  10 +
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 260 ++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 158 +++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               |  89 ++++++
 drivers/dma/amd/common/amd_dma.c              |  23 ++
 drivers/dma/amd/common/amd_dma.h              |  30 ++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   2 +-
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  77 ++++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |  14 +-
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 110 ++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   6 +-
 19 files changed, 756 insertions(+), 65 deletions(-)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 create mode 100644 drivers/dma/amd/common/amd_dma.c
 create mode 100644 drivers/dma/amd/common/amd_dma.h
 rename drivers/dma/{ => amd}/ptdma/Kconfig (100%)
 rename drivers/dma/{ => amd}/ptdma/Makefile (64%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (53%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (96%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (78%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (98%)

-- 
2.25.1


