Return-Path: <dmaengine+bounces-3116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9749719A5
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5031F230D2
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7F1B5ECA;
	Mon,  9 Sep 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R/6aPEw7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B61B375C
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885610; cv=fail; b=RyxfT9O+0nYIWwkQZDW1utroZmqun6Oi1YXMXCyQPldo99+4pkD6xW7RHs+hdt5pprQ0q4MQgRcfiqnSes+vTD0BwqWZXo9vtXmsO2aOTRY+tXVpEVb/gbOYxsn9KG1+9J1XWt6vaw2alP56UDmQof0hIvOV1IIrVwBPWXeEg28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885610; c=relaxed/simple;
	bh=sV8gyHzms2XHXmkjMSQ2rNtNJe6/lbS/OhPxLd2NF6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tWNS3RpSZAjekAp37Z7NoZ4q3ty58CH1jsO1PF8aXXCPtnmyg76s+ntyqrEKK9M2ZhWn0rLhOzrBC6zbhNL3cplc9zUb5q+tkec4Kh7u35mo7aDT1ONCLLR9qah9nrOTpH0PoO9ueISRYpdExiTfxEorkN3PcbRTkuX9WpWN0a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R/6aPEw7; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5Hrms798G9MKz99VhFF0ZbHpkFtlTdI65S//fWxtNWiulo2pN/f5IqqEtqUm3Oda3ItIIRxg3CG075Ne2UDULodqw6qdIAH78zkp6hTMNKX5Qo7FT1WdZU1Co/XELgPo7e4Q0KNqaDzyk6vQT2Cb0kexeOk3McwRCaS+RP/6SRAyGc+mqWiCQrXwQ+A6Glb+GfWucIm57ymFSu+zdJDkh7T5y+XFPtfMP5w85KsartKe4CC2zWReG1Vo3/9Tu8PGd1p8YfFBHZqGG3MUypombdxHAaULfON5NM+rtzTKLcibbibppKD9qBcnOnCnGgfqHuk9DIuVVRMShoJmFacXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+t6LqSIsor/WBgLAapKckFC/C8DvxWNwR0jw86icyg=;
 b=ECDhOX0Q42FVO0Z5zb92U+YWGCWx5YfuXcubvstNMIGlvUFV6Ry53HCTuNMFLXka36T+VOkBoshhTfvZ6ZkCobVUfFK1pcHN2d9DekK0d8TUSqRkpl8hfwLdXBTCIbdHGb3JO1QHtFYfX/SxhsjrZ9G5xtUn0d+rSku/7TzDYEhSq+5JJsUdr73mEOlwdgRZR2JqruYiuptjpuTu/qiAgLBkgRBU8Z36k7Pd+A+e4o5bD00IzCH9rRgD3AnvABIPo3eCzL4L3mkvXxeuK9lUFsywsTepLcaRQDa3vCcV4nElkyjZtZLHDwX73qR71pjzbdpU0Ra59lGlS8STePe+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+t6LqSIsor/WBgLAapKckFC/C8DvxWNwR0jw86icyg=;
 b=R/6aPEw7kdHcwFiFI30Nl2LDj+29ng5USLul2sziFa0sKLsDB+xBLRZWfJCdvtaTr5e3azykpJByobAKK8krEfsKPQXy3yinjaMlW5NfBATtcUMoX0qkB2+SCgqH3SXDHSE/rSceNMWyOKwR61klR67gaClTeOq7+X1CO6QwGww=
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 12:40:03 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::89) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:02 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:39:59 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 0/6] Add support of AMD AE4DMA DMA Engine
Date: Mon, 9 Sep 2024 18:09:35 +0530
Message-ID: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 06418923-b3be-49bf-df9d-08dcd0cc8697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4Y+ebuD2YS5w0VCZ4PaMPUtCeqV1zTz2zr74Hfro+i3aKzRJ/9RC/c0JD78?=
 =?us-ascii?Q?qFr2QJr8H4Lh7HHCjz6HdwaETTHl2fSr19lmhtcJ/RK7Pqh8BIcvwzDKT28Q?=
 =?us-ascii?Q?bjU0GbTi9QjHMYvxlk7Ihqo504wsBqPNgDarXXgVMnS1WG3X9QnOjCFoECnK?=
 =?us-ascii?Q?WrNzBFppagbr5OGJHstDJPqgnQATAea89s3U7FlE5Dfv4I+jTqjzjewWJ5L8?=
 =?us-ascii?Q?EuNedbFIn2GiqLmr7fHOxFi8hj8MjahovCziBSIjt/l87yXwKh6EQcqgj4qP?=
 =?us-ascii?Q?mOQXBZ9dHB1UzJeZF/OOYBR2etE5Zo9Ib6YPHD29N6JLW6xmVjVBo0dr2Jet?=
 =?us-ascii?Q?iZRk2PpU5cN5rc3Q17iuvSQLuccVUduUz6udmJK4R7tDXcXwQFAbL9ktAFi+?=
 =?us-ascii?Q?ppoN5PzG/3obUCZ0H4qGdmc0ei0/AP2rjskhNfHyuogiSdWB2vK4fJV9uJnk?=
 =?us-ascii?Q?FwVkTmgIImbqqlran40uT9+tL9Mo2ZzchC6CRUCfk88XbJ3WmqFk0LrKf29l?=
 =?us-ascii?Q?IJXO+LhXaTGqVF2y1isoQ8nW4Kxz3Xzq2Y3ekQXXxMvBQ4C0PkfbVz4/2zSR?=
 =?us-ascii?Q?n0Uz2VIJmTde52d1hkgQGqsXcju9u3m6i54uZ522B4vzxw2zckgOzmRPyhye?=
 =?us-ascii?Q?0jqWZyJK2tSDs2bxEGsCfG6RLVXdqy8UVJYp+Vq3ARkHrLZQuTiPR7Vd9LBR?=
 =?us-ascii?Q?5Pr2Jhw9j9TWBCjN5oUDX6JpxyMupCXECwaOGEELuBB3gzgPaQkNPYmSi5Rq?=
 =?us-ascii?Q?WDtPmbD43QNf4UQi4R7OK54jiAk7aNe5/U82UbLLBlaat6UWyoU6BuP13r4I?=
 =?us-ascii?Q?Kfomk9ESscLfyMXQ8CkVNa3MVxsvhMaxu/AqXuReBEtRPrPThWN4kUhyOtwq?=
 =?us-ascii?Q?I1kXocOl/POSwFcS0n3GdCQ1j6pCMpMV0xol5eFnARj6jexvkGg5N4o1mxPp?=
 =?us-ascii?Q?zDgiD3rb3SAyZ5VAY1khuwrDnNbxPVRBnE0F1Q3/kRfKOV8WwLlMUdcM0o7B?=
 =?us-ascii?Q?m76tpRp3w3JjADJxjF3PeWIezorxWYngvVWhRBoJOvjhD+4udTr8TW+ISMCk?=
 =?us-ascii?Q?GSCR6B3GraozcOZ0W0Ao8HDh38ewruSN6iiXh7borsxNpmsKbhffMYT9E7ud?=
 =?us-ascii?Q?sInFNJY5MctxKD4uacpMTZXjaGrhDHkBc8VyfuYppBOnFVotDtLQvebSlqJO?=
 =?us-ascii?Q?sr6aL2kXtI0KvSdoonkUtHDahGQUV64HN+hK+4DWlwtgBhzVOOEKK9yzwvYt?=
 =?us-ascii?Q?QfIRIViS/3owMrq1nIXtjZHGjgE4lHyE0xu7yUMqs9kOW6FMaKQ3lwPPRfRv?=
 =?us-ascii?Q?tRIPjav25FZTlOii7a9oq5MInT+zSbeed8kJbLrorh8IOPXEPcAPgdHJlVcW?=
 =?us-ascii?Q?iimMEeXt1lXcp4dCGodaIVgT2qabWrnDETgYWtmcCZfIL8KL8RRp4W15fkis?=
 =?us-ascii?Q?palIFcADwJqoMHNr4pscVeehqUQbyEfioFNcpApS2MhrPTmvtowmTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:02.8523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06418923-b3be-49bf-df9d-08dcd0cc8697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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
  dmaengine: Move AMD DMA driver to separate directory
  dmaengine: ae4dma: Add AMD ae4dma controller driver
  dmaengine: ptdma: Extend ptdma to support multi-channel and version
  dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
  dmaengine: ptdma: Extend ptdma-debugfs to support multi-queue
  dmaengine: ae4dma: Register debugfs using ptdma_debugfs_setup

 MAINTAINERS                                   |   8 +-
 drivers/dma/Kconfig                           |   4 +-
 drivers/dma/Makefile                          |   2 +-
 drivers/dma/amd/Kconfig                       |   6 +
 drivers/dma/amd/Makefile                      |   7 +
 drivers/dma/amd/ae4dma/Kconfig                |  14 ++
 drivers/dma/amd/ae4dma/Makefile               |  10 +
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 157 ++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 158 +++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               | 100 ++++++++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   0
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  79 +++++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 223 ++++++++++++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   7 +-
 17 files changed, 725 insertions(+), 50 deletions(-)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/Kconfig
 create mode 100644 drivers/dma/amd/ae4dma/Makefile
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
 create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
 rename drivers/dma/{ => amd}/ptdma/Kconfig (100%)
 rename drivers/dma/{ => amd}/ptdma/Makefile (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c (52%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dev.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c (59%)
 rename drivers/dma/{ => amd}/ptdma/ptdma-pci.c (100%)
 rename drivers/dma/{ => amd}/ptdma/ptdma.h (97%)

-- 
2.25.1


