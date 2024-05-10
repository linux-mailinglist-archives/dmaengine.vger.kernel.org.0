Return-Path: <dmaengine+bounces-2013-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C708C1F99
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FD1282F20
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281015FA66;
	Fri, 10 May 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Sz7q9HF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51EC136
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329294; cv=fail; b=IVKaoNrnrEUkTIdDWultlgC3EWcktpSvRHtoqJPlqQfAYsUYMbJUx6D6Aw+4SyYodKInf1RoBa5zPwgpsULpZDSXz8PgpTHHjaM7tdb+mjSDjX3ujdd8V6bC1smIyahvECPFwEztNzwaS3OlSRgdnn7JCfJrqZtL58u6PynigOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329294; c=relaxed/simple;
	bh=C9fWUO5ayTudSyKCvSM92GMBYeaqXpcbTa8Uymbp66M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pmTOLHFZU9Xn1Aq7vkiS1BmVBso6ZPqfhqIvzJG8aVi5ZqnHX7GOH8rTCp4kV6mFP+Z21aTZ9eVOmYS3bPd0B8TxBwj26lo2HAq5YDPApZlrRHkgQflnYsrJpUMZ0hqDv6ewSrRhcAe4W+Z5Ux36rDMOdRMM7u/ApyxWcTxqjtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Sz7q9HF; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5HwJ0sBSUsO78aO6/j+aLU0Qi97HfopqYZtbK9tWBEIdGecQEep5uDu/wuDNQndyfdG1ICTVWVOVZS3l96tRTGcSGLR7n34N6gtP+xpuuNPe9izkZ7QKsfk0ZcA+KRhtqcQN9JlPQimpzsAy+YAzEXFMFd8MjyF2FtPmtZCO05XCbGV9D32/OWn1Fl17WqLKpknlhg+Z/LnvBXncyTYilogCcMuRQqEvJnxGjs23YA4ST7nXnoDjCZmzVbkhY+6qcamhV4FDLfN3MpUPDLbahS4F/ypNZXwRmEB87lQJ6WbdrTEd45mV2AY63pv5TNIF4rY+Tz89Ly8y+AG09XIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CVc5Q9DZEboAG+8+QxXloeKWZJQt32sHYLl2JZpxCY=;
 b=mj00+2kaF41Z66ApzAENCDqBn1OeSehzH8N+aqUREwMjZJZK/LDrF/XKvsfed/bYfYwnX/JsdIj9aDJ0LMRFb9pUWBW+niWy7w0ZGlnhibC9VNUUvT36W9FyO8iaW0Yj5+K0JS+iIx1wriErUXT4A3fcdudPBp8FWgsJ2bT2K4oiQynT/djHR1K8KxMYojoO8pXYs7dd0g3//wpouqlJWFTyICIfFb3hvuEFcaM1zO3o91hNXgdLANUxpWUgPmNTdNMc3K2WUiHN0BgGLxMWmkTlbTFsELZSVgG7rDgpBrz4FSnKgAfNCWe5OsesHL/mNOtWVVzOUhz/IS0H5Xq0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CVc5Q9DZEboAG+8+QxXloeKWZJQt32sHYLl2JZpxCY=;
 b=4Sz7q9HFFxQTjAr9n6MoQbF9WTeaZURnCPlAJ847v9pSUWSTS0XL/3tpXKRrG//51j2ek0SMOs27nrJQ+UQYB9aWkRA2XtdKPRkMiF/uVmgCFfbbD5AQOU0iuEVg+895B6rCBwL9MNTKUjdoRE9iI+1oNEVe1wVlTybs2M94N1Q=
Received: from CH2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610::20) by
 SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Fri, 10 May 2024 08:21:29 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::6b) by CH2PR05CA0007.outlook.office365.com
 (2603:10b6:610::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.13 via Frontend
 Transport; Fri, 10 May 2024 08:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:28 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:25 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/7] Add support of AMD AE4DMA DMA Engine 
Date: Fri, 10 May 2024 13:50:46 +0530
Message-ID: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc41f88-8274-4afe-2249-08dc70ca30f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rk0KlZmzpvvV//JWGFPBuFtm2HS76VWkG49eYl5w8WlK3gRoYKSYMkvWML7m?=
 =?us-ascii?Q?M4/N4T3qyOScA/n/5lnEE9rLoFjAzQmV/eQhN8LPFVil+gNeBYeoV7bmjjon?=
 =?us-ascii?Q?hKo3Ax0Ft/1rcoPiHkHPCGS13inve2aAxjOV6/xq9jOnHXgOeV7L+I2LOd2c?=
 =?us-ascii?Q?Ted+E7UfU0i3K5SeHT+h9BN7h7pyVdji1YrPemtImNQOvUN1olPP+AMSuXoW?=
 =?us-ascii?Q?mW2YtMzm7QTct7cyqJU3p441M4alUl/kK2gQwBN2FTzZ8q+DYBe0hieeDNDM?=
 =?us-ascii?Q?MeLF4OfKmdMIr24y0KlT4BnVAng8dHEJRABPA82EU6rFC4RMX9QEMJ7C6xMU?=
 =?us-ascii?Q?a4BFJgdLAoWDbiRtuSWfgg4dNE9UgiCfDms2z0GespTV8VUOmfJSfhVTimja?=
 =?us-ascii?Q?tIp2FqnJNhBI8s0M0olppmPmc3WHHsMmCnCzXbhLhyRpIHpxHXjebi7fso92?=
 =?us-ascii?Q?fofszYQ6+jlaRiGjFlWvBw5AUCGW5Y2LzNIFetR2CZkGli+MXXUiGJhLwnJ0?=
 =?us-ascii?Q?n35SZErWCMD+DehWDP9Cno2gB39epaFO6BBk1YDXSA4qCPh08xoWCCV+OtC6?=
 =?us-ascii?Q?BSnGz6RQ7crhOZaUJ82B/Du30JDUphtLGCYjoDlCy8tHVcShayiq4NsBSgZw?=
 =?us-ascii?Q?5bfm+KaiIUZFv1tpzPZqd9sUA2BUKgLgZsJm9RGkUnMfqqQhu2Qai0xzniN3?=
 =?us-ascii?Q?/Vi0+zyY8WrfKrfWKlBctnksYT9Wq/9pNVN1+O6r68lu5SQMEl12qV/Iprwz?=
 =?us-ascii?Q?X6Ju+Y720WihcKA8W0FyMnQWy3THZyJqcVP1571eISRXEPcKmDetLR2qjm1+?=
 =?us-ascii?Q?oKPm7oXdoAjz2R2HtNPvqXPwtF4posz/HtpaNcaz2mCi6tq4M6qt9vsZw1YM?=
 =?us-ascii?Q?QEeN+d7/XPTOOSrFc93Pv5uYU6pZi2wPXgLLao+3rWI4Jjl/2g4gFUa8CcMw?=
 =?us-ascii?Q?1eSs+tGB7P455djcUKQ4K93XFL4vrVLIKJDXI4okZZXkPtVWtHTnt/uZzk5/?=
 =?us-ascii?Q?Bsa98izKvHPasDMW4Vf6lcP1ArMhr4VENKJ1LT0be9bb9JmiUzz+wmNO/2jM?=
 =?us-ascii?Q?MCYglfs34mECICo8zp74V86qxfYitee2UrZk1h5i85ZgFEOBWtoMos4dLUYU?=
 =?us-ascii?Q?7xLQ8eWFfqIadJPITAiO2VIAVQKSU4XqwQfAEs7SUDNM9RZtMPDpAG3LJunK?=
 =?us-ascii?Q?x2Bq7RTXek4lRwP7I8pNc2R376nmR/HhWJnCSK27Ac9k2s4vA/XFAqFxa5br?=
 =?us-ascii?Q?Sm0x6zrfpfXJhPMyJjHitCyQKpbU4rnHvnzBk9x45ruW47i7UpuH6myRUhwF?=
 =?us-ascii?Q?0I7lpsMZzg26XCEKUqbb7mBM/13XmtWmVoDzbC1Odtgqx2QpSg9NNcJhv2XC?=
 =?us-ascii?Q?0OUP/+bdtuQMiz4WX3XL+W9VLWsE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:28.5578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc41f88-8274-4afe-2249-08dc70ca30f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

AMD AE4DMA Controller is a multi-queue DMA controller. Its design differs
significantly from PTDMA controller, although some functionalities
overlap. All functionalities similar to PTDMA are extended and merged
within PTDMA code to support both PTDMA and AE4DMA for code reuse. A new
AE4DMA driver directory is created to house unique AE4DMA code, ensuring
efficient handling of AE4DMA functionalities.

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
 drivers/dma/amd/ae4dma/ae4dma-pci.c           | 196 ++++++++++++
 drivers/dma/amd/ae4dma/ae4dma.h               |  80 +++++
 drivers/dma/amd/common/amd_dma.c              |  23 ++
 drivers/dma/amd/common/amd_dma.h              |  30 ++
 drivers/dma/{ => amd}/ptdma/Kconfig           |   0
 drivers/dma/{ => amd}/ptdma/Makefile          |   2 +-
 drivers/dma/{ => amd}/ptdma/ptdma-debugfs.c   |  76 +++--
 drivers/dma/{ => amd}/ptdma/ptdma-dev.c       |  14 +-
 drivers/dma/{ => amd}/ptdma/ptdma-dmaengine.c | 111 +++++--
 drivers/dma/{ => amd}/ptdma/ptdma-pci.c       |   0
 drivers/dma/{ => amd}/ptdma/ptdma.h           |   6 +-
 19 files changed, 805 insertions(+), 65 deletions(-)
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


