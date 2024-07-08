Return-Path: <dmaengine+bounces-2650-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F692A4FA
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0C281892
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE44137937;
	Mon,  8 Jul 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X2P3ymy/"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B915A5
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449926; cv=fail; b=LlepHU5RGaUMsB0N1obRXiiWIrtMcEuLVB939cX2GdR33iZ/AxHT0hLub97+aoyQn677QdI94+3R8znOci7gDcDo/aapO9KUFQltM0saUPUeYsz/wgX/tSBiuYAuQoYzqTq9kC3hEab01oukuIvz69vWNzREWsp7UKtibeUegBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449926; c=relaxed/simple;
	bh=1xjGhUIBL7+Yx2cOO1Xzcau6gaYhrwssMJjWcX6Mgdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WiiPj+CWaiIQr4mCuXjQQj2qzp3mamZu3GF50Ca3NwfLX/XapgM4MGEkkW+WYbI0VyXQo62AAUa9+6bywG5bbmvJMjlDVf9JifjpSmGsyU9FKUgFeSjBTmUN5kpsulevrGmnmzGiOpY5AnmnCXS+RPtXUpo357JuQNxCQDJXoN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X2P3ymy/; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxLXV9G1Oxofzq55yeW89Avi+1On+3h1fF0lBJbTryJoqNr2Ywx9T/w1Ldgvqkfej1j4+GPzNzAyRBu45kLRpR301PtVX0gn6VFw99U5FCb8lv3d4s3vF8rKCjLDHIL+Ut2gE32wQP3zeyStXC7YzoSPEibR1rMxkKXAjad9j5fD+mZ906tFffDcusApCYdWBvzmx44y8cv6iTRWFx+Gqtfaf/PPI7Bm9EAmawsZ1Ru1tMQs2MELgzWhFJptSx0x+Pn44DtmMj3n17HNov8i3lKU8eKNJZJL4INK9ogkacTAxWq9RGILX8BOQqBRmRUucCqni1ilZQjphrsM6VmEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPvyu3ZQEHKLkM95xsXMlLCevEVIv8WmRdIgfXfgN/8=;
 b=HsJnbvfeZz9ss2qBqGDiLhftcZDF0YuyzURm1PcJWSv6nULxwo9FzhsYqBtYEYqfe/9KKb3RKj/+KQFiOoH5Oo2/2Ctx8LV876m82XNu1fotk7zhmbDUMxvs7EwWQ0b3htrh/w8l/DCo/a8vk0v0KvUl0l1PXdKv6uFTD/SuxpKsfGXVwLkhsyl4DOxp9wwRooTcH5KnIE7UlHmjTIyIH4KxgVi1GngR8eLkPfMIGeN4ktk0TMg+2tPRvXjaALJ9GcDRH24xm/umGqv0T39rPDKMXXMKQMI26llZTEtoW/6VrrubGH36OFrF98VZmFg0jPdjnEr36L+GnRzUK2g5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPvyu3ZQEHKLkM95xsXMlLCevEVIv8WmRdIgfXfgN/8=;
 b=X2P3ymy/zIMELGBxfn0HqvbABYrGP3qBQ6HtKPj+EITVOcUf+BQ4a6GC/urVWfeL9HSX6VQzJtKIoUSHJnQzbgBCYSd69woAxBr0tATJj6tUr+VvZ1JBtA2ZZRcBy0SrJvkHrbpff2UFKHaDkMeOO6h+TGZJYwp4L5fbQBj41No=
Received: from BN8PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:94::23)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:45:20 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::d) by BN8PR03CA0010.outlook.office365.com
 (2603:10b6:408:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:19 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:16 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 0/7] Add support of AMD AE4DMA DMA Engine
Date: Mon, 8 Jul 2024 20:14:53 +0530
Message-ID: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: c3faf528-9303-4093-f89b-08dc9f5c96a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wk3VH1ZwNpL42xaoz1+bT7yHEWECl/rZWcwwn0Lr8IjpGQTHX+PgSCj7lg5?=
 =?us-ascii?Q?1os3VqkvuO0ttHDADBWpoY5KZ2rVZx9VUHkdgFUmmWPKmU/Sfwj1mJ73xcYT?=
 =?us-ascii?Q?eIG6oaTs8Z3aTWaBj9GE7nfBQTXvU1Zix5+9mmFW9tH3iT117E27u0A257/d?=
 =?us-ascii?Q?7ACNhjrUubkvRAcOQJD6MAC27VUr3YZkg8n2PVY/dNg7yGVRbRpuw6jhWR0E?=
 =?us-ascii?Q?2lJtzoDVhpwqbRrHrIXBqKAiB16in+w3r/aDcdNRMxre72MJGb4s8lk+jAPy?=
 =?us-ascii?Q?cJHS8I1flKTaOxPCXm2XqNam0E8dDISOjBwwKhXmtEFaYHP5/M82LNp3H/H0?=
 =?us-ascii?Q?ocGhN6KLIND5Ja8J+ZElMWLiTmqv1HjXPskVFa4InVFxaupQSpOpfGsr0oNl?=
 =?us-ascii?Q?AwfXxsXcSeoiGt0LUOpwrQDA5hWdocTuIUaRioPFvW65mOc+AsL3nwlx6e4N?=
 =?us-ascii?Q?5OYPYAEdplHI+MFhXWbiQ0muWztiteojFIss4QJVA1TSyWUfyXiKSJM3iEFv?=
 =?us-ascii?Q?rmxTW8/+nIBF5F+C84EhvL05njSwFSESyEEMb0/UL/yyX7KQmBg1qWo9KrHe?=
 =?us-ascii?Q?lkq2ON1x9X4Bz27aqRWGrQlpuJ/lkherb5mIVjFzN+PhcWEJNus0xPU6N+W3?=
 =?us-ascii?Q?OdWWgiWYQVHLNMW6ijYZhb3sryaJo0HIbbDyM/Hr/sw0NjO8Of+d6iIecpvx?=
 =?us-ascii?Q?+fWSZTP9BCq6t0grV/zV6nVBCFH0PoJ12IbIDsr6qZGDMktxJ97PXnq2BmDk?=
 =?us-ascii?Q?8NYiOhXI71FAXU9BSDunCIGjekeY5uyNeAJMQk04VDwwliVuPJV4Qqy1nVbh?=
 =?us-ascii?Q?Ike6s8aGjYLK4oMuL8EevoM9XNF2gmGgWd5ls10xHwEtPyO8rozuXjm/tufk?=
 =?us-ascii?Q?HZXwiETr7+HhIxxBvoV06mBjtZhgdxL801AzTmwq/l2WwT5MM7KxP6YdpVM3?=
 =?us-ascii?Q?NsibPQUGJ+amW1O7/ru5zNwPn+DRPf0822GDVfqeEJhmuBfmzBUDRAnlWyyN?=
 =?us-ascii?Q?S3LoeGVQdBt04J+KcY7tCCEjIfnpsHxWLouKZjuJrIE99DQzSP/zmNINf2Jn?=
 =?us-ascii?Q?EnJ1nPO9jRGXpES8CLdyT5B4v4/eIiMpXpiV1BR1ss9W5g+WpBA7QSTyVp3i?=
 =?us-ascii?Q?qkbVmy07UedQx61TWDp5c5seVo62hyDN70qhRQkucPN4pu0Ra7Bz38ck9fjD?=
 =?us-ascii?Q?JHBaTM1tXX5gv7Uf1Kxh1Yubat/E737np7TywV8dSLz/20Q9sB6maxYmzVhx?=
 =?us-ascii?Q?PfO5l3McWjyM8DHUfikiPmhiIVARv1P2wI6X7ZZOQx2kqsgObu2tAXTeBTUW?=
 =?us-ascii?Q?aRw+96YpDAk0aXtPpJb4LLmITJ2Bl6SV2R/NYY74vvn4JvZSRAeWClaKtO19?=
 =?us-ascii?Q?lL4R8g+/UE0sUa5eer5e08Zqwb/rIOKXPMAu5m1lDMnND5tVvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:19.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3faf528-9303-4093-f89b-08dc9f5c96a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 261 ++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 158 +++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               |  89 ++++++
 drivers/dma/amd/common/amd_dma.h              |  30 ++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   0
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  80 ++++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |   2 +-
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 120 ++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   4 +-
 18 files changed, 743 insertions(+), 53 deletions(-)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 create mode 100644 drivers/dma/amd/common/amd_dma.h
 rename drivers/dma/{ => amd}/ptdma/Kconfig (100%)
 rename drivers/dma/{ => amd}/ptdma/Makefile (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (52%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (99%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (76%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (99%)

-- 
2.25.1


