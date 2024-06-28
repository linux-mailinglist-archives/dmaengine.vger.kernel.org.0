Return-Path: <dmaengine+bounces-2594-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C545E91C484
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431B81F21591
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B51CB315;
	Fri, 28 Jun 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YReFJTf+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E62263A;
	Fri, 28 Jun 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594600; cv=fail; b=rN7L1uL0BsHw1/H/3iBRgxDp0bKaUtiTD2nc5ebmZ7QXsaHC2p6za/yKY42FIJvgUjjwRFydrmSBb/KXyM6IOEzxm+0eH66fBx9OewpVV0mzoI+4u7IezKf2ZMfke8sBROwMcaXAbpVPN0o2MUJ4ETF9Jk6HDvfBt8LGoGpkZ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594600; c=relaxed/simple;
	bh=4RtSnB4k4UyAZO4z+xcCFZoHyvYzzNo8OZLBk+JmcnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=li1rSmi4XsDGoWsssa8a5z6vygyLZyMhlvHCRvBsk1aZAqytp2INGdWVGozkW41jSLdGwhGBYh6gwdCPrHUkZKRubaFdvRL1rlozVuHym1AT50+dm70CIVayKVZPSIa+pNoaKe8qm1IPg9jC0+LWb3LMO53YtOqzvqEc5NJ9OBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YReFJTf+; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7v65letl7pUvB/wDAY9BJQgeiyDpEtyhiQ07NsDIi65DwMWwZaeobFUo/GR5jrqBuES1NxhLC2xmwaub6XJyRb9N3oRHDjEd6kJeX5Ac1+C+Kv8ieguOyiPe1cpy9wjZeiKwJb+JZhIqlYVt940Wg2+GNuqP6EWYNIdpP6PKHiRmE3stA9YsBLYygjlj9w8Y+xTZZczq6AsCE0mUI/ONTJQ1hO5VmizAQ6EOuIKUZmQM1g45B18nLeincDr5WdOQI22CxqjGQO371GP7YPsv4wlyVhcFKk5rU7MHo7+zVy+24C/gSIKBKfk2HoWDlsyCMjR/Qu9Yfqpdrp2JE456w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=XOA1liT+zp9MSt2gjdJtwz0gJueyRgUvZKTfsgmuiOTY3NazMPJuaBXJ9ijVvWU+KPvDOa96VvQPDTXQruvLeLZpMVkIX/cZNwEOxfA5IJs6R/88vx8ZdTwdQ16PFxNk9Y06f3o1xoO9eXtRgW7a4xkOlXRZq0t21KNjxk+XoAhGXibfA1FEYNNCb7IHdEzsl7SrOpof6RFDGohaPcGDhk1rE9kYpbCsY+Tl8P2n4QJbVBg0LBhG8tHNHP4jg7RQUPGMgH84lqsvgojAJCkBtCMD93HkDXt/oRnDOeCJQ2kiHNEb/6gLMtGZITO7D5XKyp9bcUBCms0+N5vxIFfaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=YReFJTf+1jL1/6POZhOcziN0SKtQdLW04DlBkk1hCJcIOCcMLACY7GIR25JHZiyK5zPQwAhsybDax3BNCQQXP+fnTZSDLh0LD1zHM+SvC6muoWFUBHYjjw2X7wByH9cBg5jc2xsos7rMKO0ORif7NLWTiTeeGd0VBhdK9idRTsQ=
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 17:09:56 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::32) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 17:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 17:09:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 12:09:54 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Jun 2024 12:09:54 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V12 0/1] AMD QDMA driver
Date: Fri, 28 Jun 2024 10:09:59 -0700
Message-ID: <20240628171000.1155538-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: b44ca84e-5dd7-4729-67c9-08dc97952220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/NyxsmnQngYYa9eBhQHFx4h0KcCSCMir6LhMp+5jh1bfv32DFrh5ioZltCt?=
 =?us-ascii?Q?XEfpD2IFNfpVFRUvKRo5G2y0GOdjHVCtZFHttuKlZILmWuYzmqZ5p0jzZbtk?=
 =?us-ascii?Q?qJBfwq6Z8caOJYCslth8NMw2//R8a1vZWS6T2gT9Fc+O4w/mjzUm1Df4H6Kx?=
 =?us-ascii?Q?8FgPKBVBm5L3lXkflzs04H7KvyqNmYX74nvLg8fjHGziErooytt9qA6CXvqe?=
 =?us-ascii?Q?ikJ2CrLDsqRjFabgjcLg6/PpR+YvOo1k1lqTuCtti8nGITlPxYWBjzGqXuez?=
 =?us-ascii?Q?89g4yxIDJPKobt7HtmT4erBcckIMKB3z8Sb4QCNLvnzlxwYy263qgmTcCKdq?=
 =?us-ascii?Q?/Exd3x+N5A68bGTGQ7Yqb6PvfeHhcfvuRhGPrPN27TkfTWt3m1nQUivQjAtK?=
 =?us-ascii?Q?uAXFECE29kJtToVjd2akWW36x/02Ura3wKvyWM91t5703sJ7+jiL3gdOP4xC?=
 =?us-ascii?Q?Glbjqqhd7ut3ZFF8Obkm6j31OgDpVkrM3LEyCBPwfa6LMdoJBr1H5JArT7Sh?=
 =?us-ascii?Q?CR92TinY2SRiHA2qtCLMDk7qbslpX5/YDjDXcOw6lywVhxo832DT2NP3TEoU?=
 =?us-ascii?Q?2UyAcfLicfXMOj1GG1Jo2uR2AGWgqBMcbi3ycOtuBGO7TtJifjNT4sQOC/7l?=
 =?us-ascii?Q?71qQZ02cGu35iGVZgnUBKut7yQbu+6NkL5SVuJFYX3iTY+xST0NJvd+TxVvq?=
 =?us-ascii?Q?j7Ag82LysbHusilWUNfrQv+Xy5r6Tt5Nru/knoMAZJUNT/MhmTYJuiSZFbsV?=
 =?us-ascii?Q?oMxT9M1tBtRfFoCrNm7ioOb/HlAPuOqYVBcRGnEnD2UsXHaQfmGr9UXLqeo8?=
 =?us-ascii?Q?prxBMupYjIlBuU4OLBUmNBKPLm+CF4tEOc1/mlJ3Tw8KDN+bz4IZb3GquEKd?=
 =?us-ascii?Q?FhWU3lar9ZqmxDNT0/k5g5iMdGpTgSw3fNXlFG4eryXKQpOA5excwV1R7kCE?=
 =?us-ascii?Q?8OvrHr6Rn3PJruB5QboANG900j5fMrxk3X0+l6+egWhKoioDASbYbosxcQqi?=
 =?us-ascii?Q?+Tejxz4nxBJZZckvKwrX63T2uROVeRUZrVhbre0JrqZGF2NZ76ilz4fRQlpl?=
 =?us-ascii?Q?HyO0JKmWPuz5AbjI7+DDYEHhEBpLp4XOOfLS33zOarzi6NEQZ3AHqGYVjKv/?=
 =?us-ascii?Q?fnse69/EgdIBjdFSIkB+my2Bd9Ebu5gzVUwcCWec9vZ2IUVCpXRvL7pna57N?=
 =?us-ascii?Q?CfDDyWXnQBywKURBR9mGf6KL1Qrvb1Dcklk9Bye6yW2JCZh/YvTL+fbcgc1y?=
 =?us-ascii?Q?5I7QLpD9Pr70dpLaq3wiastEOCdbSosGh8ZZourMkOjTekAyjPPa1P4JJiH4?=
 =?us-ascii?Q?X/1B/wdBI2DdHSgcICDcZ6PdQ+eN+CImzaXGP8L7UCgqc+9Uot0vl+c/diGi?=
 =?us-ascii?Q?0fT6i3OMN9hWaha6WJh9TwLV5WBMolSdzKJGGZCKmoUDg9LP9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 17:09:55.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44ca84e-5dd7-4729-67c9-08dc97952220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

Hello,

The QDMA subsystem is used in conjunction with the PCI Express IP block
to provide high performance data transfer between host memory and the
card's DMA subsystem.

            +-------+       +-------+       +-----------+
   PCIe     |       |       |       |       |           |
   Tx/Rx    |       |       |       |  AXI  |           |
 <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
            |       |       |       |       |           |
            +-------+       +-------+       +-----------+

Comparing to AMD/Xilinx XDMA subsystem,
    https://lore.kernel.org/lkml/Y+XeKt5yPr1nGGaq@matsya/
the QDMA subsystem is a queue based, configurable scatter-gather DMA
implementation which provides thousands of queues, support for multiple
physical/virtual functions with single-root I/O virtualization (SR-IOV),
and advanced interrupt support. In this mode the IP provides AXI4-MM and
AXI4-Stream user interfaces which may be configured on a per-queue basis.

The QDMA has been used for Xilinx Alveo PCIe devices.
    https://www.xilinx.com/applications/data-center/v70.html

This patch series is to provide the platform driver for AMD QDMA subsystem
to support AXI4-MM DMA transfers. More functions, such as AXI4-Stream
and SR-IOV, will be supported by future patches.

The device driver for any FPGA based PCIe device which leverages QDMA can
call the standard dmaengine APIs to discover and use the QDMA subsystem
without duplicating the QDMA driver code in its own driver.

Changes since v11:
- Removed metadata callback and added device_config callback

Changes since v10:
- Fixed Copyright

Changes since v9:
- Merge 2 patches into 1 patch

Changes since v8:
- Replaced dma_alloc_coherent() with dmam_alloc_coherent()

Changes since v7:
- Fixed smatch warnings

Changes since v6:
- Added a patch to create amd/ and empty Kconfig/Makefile for AMD drivers
- Moved source code under amd/qdma/
- Minor changes for code review comments

Changes since v5:
- Add more in patch description.

Changes since v4:
- Convert to use platform driver callback .remove_new()

Changes since v3:
- Minor changes in Kconfig description.

Changes since v2:
- A minor change from code review comments.

Changes since v1:
- Minor changes from code review comments.
- Fixed kernel robot warning.

Nishad Saraf (1):
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    3 +
 drivers/dma/amd/qdma/Makefile          |    5 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1143 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  266 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1542 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1


