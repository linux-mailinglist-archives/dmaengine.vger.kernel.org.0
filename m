Return-Path: <dmaengine+bounces-2515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F109143F8
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6846A1F21A6D
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49B481D3;
	Mon, 24 Jun 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXDWqEdU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D847F5F
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215796; cv=fail; b=khq0Fbkyh3h7zUT5TszexXw6skp99pU+mcEC15KFzDEzzAgU4biD7093aEpaMY2hRrG8C6LQva347eK+nbAnxsg4319J6yhhc2fhnh2NgOAvlBQPdydTGvmntdRQNUe6k5sG2XVmJS5YdLmfe2r+C4Z4ZrqwItEsMxaHlJ+8wto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215796; c=relaxed/simple;
	bh=z54yQEtROpwzjOIRGUqWbVkeOz4+l2AEHGR+/IZnodE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exRYA/7Oj9gvD+KcH1RwKiJRwPyFX9wjE/a/6kmMZ1iQ9BhEW+iam/yrD/4MPQmauuZvfZcR0Z4mGlfgZJmFMhpHLNrnNh9QlYqfqOYZXRU5Vw/goKZwa4/w8dmLJbWVxwpnbg+LTj+SKotd1QoKPE/5VpOyaeLyhXibMBvtvEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXDWqEdU; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9w5qbfwOdAoBx/+nWorfaS5XpKmhXHisZETH9MVujvMISUrFgLHL/3MjyZlUCiAJyreD0Mm7dDe6iBvO6dCO5MCbyLwckqH04jmWLbwrOjTQpZZFH3BnVWgnYx9gqHVCy1eTqnTMcTcoQfeafDdtZrXlLDev99kcWavY+X4Zgm5antOt8vZH+c+P68fNdT66kWgrenJGVYZsOrKjArrmxUoZwU8/OUybybUWHouO1L3MfVkXaolbkeeFxU2Uu8U+4Y6Ro9Fc0tQhViKD1ZfNyiNR86mSc25F8XQ0eHtWQDO/46Fkp1fdnWyDkl9SwTBHs8fo1zcuJCr/j+DKn8FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGoBMyYKJuM2/xyMUQbvPiS2OiprEsKBdVsiBKwMnH0=;
 b=Vm0C7yTs9KF46cJXx0fI0vN052j2Vqde6oZmsmK+b/le/69/PMK0ynx3VSHY4sTIIeQhSOjNeVVx/AVAlbG85/u0yeTz/1/zbzFGWs7wIobkPlexBWX1TRF20ylmN4kHWIB3yaMcf2Q/Yo8BeY09RK+OY4H0F8nJ6i0czhw+WZO9feBeS0DK6MzDVtsOiR9H8Uwn9DZyyFmLrCWYflL7J3la0/P5AYKAPucd0iGLnwm4XWb37UmjgD4NvmZyzDjYhIEk/I11muRjR0EgcMI7RBjFV7UwGAdSZcilYGNVWFXeI3N76dJ+7tVl5sIZBDZzR4TczgP5oHSxbfHoY2TXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGoBMyYKJuM2/xyMUQbvPiS2OiprEsKBdVsiBKwMnH0=;
 b=SXDWqEdUE6fsJJwXMWIyO/8XMnTAIZ8fBYpRef0p8RbvLPrl+4L6dBdIJm7HWc9R8CU6wZjnlKAEMtEZF2At3NfaQkx7h9dLsdf4HUlwH1NYbVYQO8lcEM9qZzKAeWZQQJzsGBmBl8y+5o8wlBg8i8zW1JPb+o/yR+pYi1pXtHg=
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 07:56:30 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::16) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:30 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:27 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 0/7] Add support of AMD AE4DMA DMA Engine
Date: Mon, 24 Jun 2024 13:26:03 +0530
Message-ID: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aac6404-61ad-49a8-d80a-08dc94232899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jOc1dOpeVtKqVJPRkddu7PWSkqer8dOnLaVK80rvcvPEwrlLvDVhYWt4uXRU?=
 =?us-ascii?Q?mHyjdac3GLjdZL2BUNEuQDEIJno4IIz7+/KRuYig79z134JSMBB3FIpl9AmK?=
 =?us-ascii?Q?ytR4unhoVmLrCOr4WCTDfvojCMCYyb5U0PFO7eGVtJynxZG7KM7bHOXnuydt?=
 =?us-ascii?Q?uy09U7KvvM+gRXwq0XAj3iY2Iqitc1uJuUUUSfEuheFP/IT7UG4TECKfA5hu?=
 =?us-ascii?Q?RMqMKxKxuDGJkZTUjd5qOAgCyQQrGb8hMPOlvFmyhryk9CxVq0wMj6pzRnKs?=
 =?us-ascii?Q?is1DSVk+uuLEt7etGdAzc2Zqp99CYqSURf/P6Olyjsw/ESOlHVB5Ls78qxyN?=
 =?us-ascii?Q?m3034v84GIzz5L1YlPssbOtGcUUQkf9NvuIy63coIBSeHd2u8eN3ZQrrvULR?=
 =?us-ascii?Q?pPf52OXFZr4vWXfQ2cja199VRm5Hm0uNVDKtQDMy77ZnrMBOpoE14mqylPys?=
 =?us-ascii?Q?xWvP3qMUcG+0y6Pxwj55LhUe6AdkZTornzKkrt5qY3gFz7RIeCoaid/DadEg?=
 =?us-ascii?Q?uNBABOKLRmLn0Ve2lojMkK0DSg7zWlWVwYhaGhRvTKzFFuHQwlRhoU03fxE8?=
 =?us-ascii?Q?++K3EeJ8Smj6svThKJRpyiXfMZmnjcN+bPPC3gZRBdC/doHG579T9em3KHZb?=
 =?us-ascii?Q?DM99ACF08A2sAIHVtPYyDZQ33OxJxhn6OkW7CqHXsWYEk1F/lqRYpXHKGxQc?=
 =?us-ascii?Q?uPDgD+GwqL3Vq+Mnn+Kn/qzA0aC1EF64GHQzB7y3w6QmA88EC7Cs7/h4GCrX?=
 =?us-ascii?Q?KXcRK7EIMXdmOORhr/gdEeKK2oygET93hAUUKkXtHvpucyw41LNm1YuJCpIr?=
 =?us-ascii?Q?DVv/w4XTqdil+bYBJFs19PUg66AM2BsUz/qnV0Si6nTFcEOJo5AE53lGPuSj?=
 =?us-ascii?Q?YBlaM7vVLNe/IGDriJ2xZG+X8Gqcjl7XTo8T13iH6GBcuY2hKY03ApGf13QQ?=
 =?us-ascii?Q?13jDBiL2cpEE6IOnZADQ9UoOLrdFEL/hhPT+YAQ7+NQ5H+cMfMw1K99WeyeN?=
 =?us-ascii?Q?ULVi5RxomBB/dsQyGQWDt5oKm5iigp4OId0HfM09oyFgI2EZlEklx9HgH+OX?=
 =?us-ascii?Q?d0mpyvx6xM62CAStrWUgSSHE6GIe8RHaSNXrPLTaR+/f9nnrwrxzj5zP4j9U?=
 =?us-ascii?Q?/UPj2NVPMC2PmKzl0V1mOgVhSpTtHi3UT9Jf1dS8UI7Hcl8rLUbsIHLcs3Sy?=
 =?us-ascii?Q?NK5WtwKzaR4t87qOTTh0+y/ocy28d7HVuqWaPAmP9APfGO+1pzgazKDyw4gk?=
 =?us-ascii?Q?EVNa9Wc9MJHxEHLQfSAlbO8qyANyowlLed/mnuHfoZg267TEFgGfOswCdfCu?=
 =?us-ascii?Q?1ek5BHeuGVUvpReGYA3pfhMb82c90dt8AmLcS07L2gupqLa9VfTLusE1n2I3?=
 =?us-ascii?Q?snUWiow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:30.4767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aac6404-61ad-49a8-d80a-08dc94232899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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
 drivers/dma/amd/ae4dma/ae4dma-dev.c           | 267 ++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 158 +++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               |  80 ++++++
 drivers/dma/amd/common/amd_dma.c              |  23 ++
 drivers/dma/amd/common/amd_dma.h              |  30 ++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   2 +-
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  77 +++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |  14 +-
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 110 ++++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   6 +-
 19 files changed, 754 insertions(+), 65 deletions(-)
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


