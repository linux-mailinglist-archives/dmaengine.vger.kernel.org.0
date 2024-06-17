Return-Path: <dmaengine+bounces-2383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108EE90AAB5
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137A11C25659
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC0190682;
	Mon, 17 Jun 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z2N1cz/q"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F66188CD0
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618680; cv=fail; b=r+6nM3DxK8m/mPk19nuxXQMC8/eSqX1RQ0ImKfv+j7LxcOBrnZnPHEOYRAPNNwfWnO0KLIIYuBRGkvBJBbKaHQXblwaOE0mY4r/q2yGSAHEL2obPj3NtlmSCaCagoy8Qmh2zRFgDveAfgnY9XA075QK8IlbSFewTZjuYU0kqMRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618680; c=relaxed/simple;
	bh=kgypospOUPbW50ttVwmZzcfpalaZ5eSZuD79PgB07lg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIbcf1XqiKT5tqh/SZTO2YRr9Z+vd+u9MOFXsIoAnNMOQpgiDcksJkU640IJOmBq/tS6vRN0Y6OOf3QgwrLr7PbQhKrRVTd9tpqgcuPDmkUPrMwofgW/AVuh7QessnPNnzGxnp50qKXr1YOGkWlA+sF6xSKM0qaSCSi7a2yv/tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z2N1cz/q; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQd6WQkguHXS5CJsyOv4DXqywRLzZK8jtNaXaZLhTkCq2X0K8RNUdfbLSINeWrNhktcV8jaLxij5yvQ6YYmIKWhMw9WfAcuRS1Ee/Ls5xDRsjKGt+6/8NLLbT9da/EB+eKHFHvynCL4yIfL6CaK9XjBxeKYQA29Om9jyHo6fonDht2QnNBysZ91EH6b4mKOm8wc/PsOLwyW0kYTpOZWqG6xQyaT3k88oCperiduKaz5OUDkrLCBykZY8U2ejvkLIZ8V6eRGS2bU8FS/dtkQfmgPJTAyIOI7gSp4A7KHQ3lCjNlyag9cYhi0fsrxPHJlRg/7Eff0VoH/K0d5g8pJuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANXmaULBZn1Jsq6O4IcaiQw65P51HPV59PZNDT9NVDY=;
 b=VGRREyI+GtXa610XghFR6d+4bCNmtH6lpKDWNmRJZrgvYq5+kl2kY5IlqdrV2aqNVFPU5bjaCD/kh3LcEQvqOUFgCJUq9Pibs0glNj1Criryn5act0/0GGqC34CK+5MM/RoqQnk24VDz+oIwDXWt5MZP27HTjI0zs/FA1EQZbJ+fPXxS+c4QSho6v0ktIqVtF/HUwd0JRPDRGgzCa9jF8RIUh30jtUavQZziRFVBUcTlPx/Rr41SPuxEWHSoKIJd52ctvb3B/XNMOU6d1vvfd41F3ko76KDvdJ06vWmnBRsFpidm0cRaGoKjLz9HrnniYI0eXHqqu7WkN2n/W4Jj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANXmaULBZn1Jsq6O4IcaiQw65P51HPV59PZNDT9NVDY=;
 b=z2N1cz/qljReKi6YuJylKJkpqlW8R7Y+gleahUDuyUuPd943pklv8eH64uL3VLMTkC1Gvw04JozcE2A+GDD1dOk9Ix91mpcHjKRVyegapJIoXkin8t3XpqLv2CZAmz4eu4KdtIqccGSRfEQmpAaSF+52AVRr0cmUNR+fo5PrjSY=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:04:35 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::c2) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:32 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 0/7] Add support of AMD AE4DMA DMA Engine
Date: Mon, 17 Jun 2024 15:33:52 +0530
Message-ID: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1e8924-a4e4-4976-8ba7-08dc8eb4e3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H38wn+oZ/lNOhbQBnmaZV82pkivsXu2+foHwyKB+OdrpcXM1CHcImw6TRvZM?=
 =?us-ascii?Q?1xwDKp2jgwT4tnHLD1dO3guyM1TGw0zEM9kLrqQfAYyp/TYj3N3JZFaDlUnH?=
 =?us-ascii?Q?4MhmbDZibkKwdtmLLl/bNNqW8o6CFXido6RAPvmxOl48WxEdNwoaxLBFBu59?=
 =?us-ascii?Q?VNarCoe0B+Au+jSNo1XGiiFNH95zjuIC6ns8zXhFS6+qflDD2kUyVCk2mttR?=
 =?us-ascii?Q?u4hHQcY6MxBmBE3pMdH0b23oE/DgdHCa0rkoKvk+0G2/4EUOUDIdvP0FVnOo?=
 =?us-ascii?Q?1x9KZ8d59gT7qtQ+0/OMVHX+WWWhW6s717yEVYFAqhWIIz3bWo7b1aCRCsgY?=
 =?us-ascii?Q?aIdsgXu0l5DoUf/39IBBaR8rrVgnCIuxuL0lV8091B2+4EruxFu4GLFuSHA4?=
 =?us-ascii?Q?ruI5WHzKR7jckJXjhREXEWpxs36zev4LmMCjqfIbks3F7Ewhe8N5L6ShgzBM?=
 =?us-ascii?Q?anMxMvQ3GpAdkkKQAlXuFxNqUu92m3mL4gWcPTqtBIXHTaKu95hr+LNLZJjK?=
 =?us-ascii?Q?uyKUQF29jvHOn1tfyMYzwccRaMRWSlM/+g8XjQNTsJMzcMUZgyMaWcKOGHEL?=
 =?us-ascii?Q?uz0p1CGfLTbaR1dAhoZV3KYHuDJZGJRRalibh3NvkYDLfHuIKrHT1qEOByxI?=
 =?us-ascii?Q?C8y8azhPF19cDhu7heOy3dKdjNOwrntVNRGotK/VWfTLpXRgQsomPCUfdq10?=
 =?us-ascii?Q?Kmb1Ya8bz+grGnfgD337OaS7qt8NoDm1SDvaaaw3OeRU1XkUret8zxddfy7e?=
 =?us-ascii?Q?ibg9ODKBNsTWclEdyTFdHZsfAnnZ4dQyYjCWoNBofPB0BNPWr1wtcoY9Eevz?=
 =?us-ascii?Q?wt0RoMACcl3oUCGsoPMkTvD4y/IhKecFzpMzBIL44IseznjzhIZRxmWabGOi?=
 =?us-ascii?Q?K7xvSSLeyFL+ZBe/+uG6KZi+QFFRVAqNFAyY0vitX8x/ICJ5lfPmWZdtbZ51?=
 =?us-ascii?Q?Tig2z/6gpD7meNVreH4sgIg6wA+W7KRXbWpeowA0KVdXJOO5J9a678Dl2fga?=
 =?us-ascii?Q?jHGlPWhpuy8Y+LFZrRGIFJrRZa5ROs1r0GrI3Kh6bFHNZywyTogjgMCZEsJF?=
 =?us-ascii?Q?UPTgjL8ooaSf2eN/VxpMojQxM+4YJLLbdGw0ZzjuUE5TmIZAyUirU0Zk7Be+?=
 =?us-ascii?Q?DvzoEG0Ex3yYzVZTP0CLr5LkOZbDZEbWoxOCrMMZ2E1mKI+GtCyY09EzS9MX?=
 =?us-ascii?Q?jk8xoxPpGfVW0eNrrVz4r24lJFVmjBP6DaEynCcxk3emEcEIvZGQITOI1mwN?=
 =?us-ascii?Q?zTOnO75qo446J4PwLwsj5ymTp0xRl6/2+ymvx9ezJrhyR2l0h9ui3wjKJ2TC?=
 =?us-ascii?Q?2RiMYj3dEMGlEhX+ML4cuAC8WDf/oPyrwVKV+hRnepdymJHMfhIPMCIrHGn/?=
 =?us-ascii?Q?XY2scVpdhGwAVJFdk/cDy1oT7m+K7dA8CI7vkL6PjmUmd/ttTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:34.8633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1e8924-a4e4-4976-8ba7-08dc8eb4e3f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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
 drivers/dma/amd/ae4dma/Kconfig                |  13 +
 drivers/dma/amd/ae4dma/Makefile               |  10 +
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 281 ++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 191 ++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               |  80 +++++
 drivers/dma/amd/common/amd_dma.c              |  23 ++
 drivers/dma/amd/common/amd_dma.h              |  30 ++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   2 +-
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  76 +++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |  14 +-
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 109 +++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   6 +-
 19 files changed, 798 insertions(+), 65 deletions(-)
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
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (79%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (98%)

-- 
2.25.1


