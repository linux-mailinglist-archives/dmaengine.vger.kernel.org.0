Return-Path: <dmaengine+bounces-1131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF0869D33
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406AAB2B261
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C22481BD;
	Tue, 27 Feb 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QDepQeNF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB51EB40;
	Tue, 27 Feb 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053729; cv=fail; b=UwtBLEKx/75PaT6Pobt2GJLNPPotqq3jsSMo/59paIuDc85KbR6t0OrFVpHaENoust1gFC/4Dx1CwiC91sW6MXMpzGH0Q/WYSsa+CThqjCYGruyFgz1MJ7sNww72gVmTV1Xq0Cgz612CUc3mcPH+sJTHi81wIS5dblJfWLiwIMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053729; c=relaxed/simple;
	bh=/5pyNx3GN9mTyGJvJVwuj6hpiNsHfAvm+cqVb3MwIDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFUGsBkZQXm7KoYaWrDawM69T/kUznb+zHXrArMPACH6ki4fCe5toTVPhFOrp6ZBiyCSEWE+yD+memAfG7HsL2krVQVV9Vw/Ymo2tA5av+Qt5nXpaxlItG+xVyNYDyqGVi0TSbOLdfhvXN6LA6sChI2FpVPIL0nJG7lEsAFXGO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QDepQeNF; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3RMd1DRP5IO+XCcVBzE20/EGsT51tq86Pv1VsOdPBbvJ82i6UtGPZheQ50F0aElPU+uniSuowakEmfI5ircmzFmpxkEHnq/wtoyyOfQi8snw3bgjetxKbDTvPlxMsiYBdRJg0C0zSQOr4QDa5W0N+fc4/4BMZkRYWwJga1q31zaqKfkLwd+pzeeBHJIACG0FJXefJITXjAtrZM4KQtDgNUbI1+ZueqLx36O+LvX49zFm0BNDowcP5DKLol2RYpc2bMuC8cPt6emmKSHEJvOPUfl3I9FB1sf4ifmd4qU3BUcoA3vCI6n52fajkwuU+1WuZRT75IPdWMOGTK1Uv0otA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9lTy8Eh99mrMkUF+FkPuPWHRmJIkmluTdBGkCEyUiw=;
 b=ahl+YiBPBCH9GShIKejajolDPbBG00KV1ugv9CH/OypsjB+6mA7rhj8aR1A1UJWxcqcy4gKE7N3fer1GJRVOEd/twnseatiJA9Nwl7MOCHjaZpLmyl5cgjsNWyCdGWNhgkjPsVO0Caac/VQhXEmnjoKcj5uJC8eiU8RU14AcCtDqwW0cWesDOfxcfb55hM9mriQfnWYQtQfEGgA0cy58NaSxvtIdsuAAifwrHxsLX8vug7/VSezCI2Tc7Yk4v/bYnfb+6B+KIZAPKo+eqTk6uhcf9UCS3Yby/bbHOsIBzpV6oslR8UntisHBoWJ+8qqhLz+9sqR0htE9Uz5QXrJnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9lTy8Eh99mrMkUF+FkPuPWHRmJIkmluTdBGkCEyUiw=;
 b=QDepQeNFCke8wa7wdbVcLtiCVtnXZL3IXCQ29GXokypc18rjP6koXLb5zwgF88I/m96np2VY7k7S4SUpR6B6zDfi1XypGDd/vC+VOUpkwjYOtigMi6i2mCuxzVq4ljwbrOxMbyK7rvKixDpOVHbiSCtC1r8cUtmXqHV66YUTnkk=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 17:08:44 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::b0) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 17:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 17:08:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 11:08:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 11:08:43 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 11:08:42 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishads@amd.com>, <sonal.santan@amd.com>,
	<max.zhen@amd.com>
Subject: [PATCH V9 0/2] AMD QDMA driver
Date: Tue, 27 Feb 2024 09:08:27 -0800
Message-ID: <1709053709-33742-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaec3d0-bd68-4eb8-4091-08dc37b6c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PAciJrppV1X+Tsc1QEYbdxxr7CvBmC1J9EWQlQjP/sFr9pBIpK9/ul7XbteqWgx7gzHTMOtPDhHPD5hllMHcBV1B3LYkAnXZVt0IIad5jMyKLymWdxrZEYq5W9soKAuN1bzh65g1/KhLy68GFjObT6hTFqjWqF/8YqHp2XHsAKBLLJRvMnRax5/qpp2UD3g4rZU9VpjCBTBo3dMauZmr7sl+P9NdXrPsNGR984Cb0vlSwLX9dSb9PM+yNzBB7drVCDFOEZG07SpTTo61lS235pZ1YOaISlp7eDHdOU8PUG1SsksQTbcz/GPuLdHYxKhA3frWx+ForDPej6/Rb/7rsOKrv3PF+gTTsC+LyFHHvfultLKJdmGUF1vOaewiOIdymwIa9VmhyinVEaj/ELU0HAIb1zx8Vr3jheEMW4e3StvrqhzG5ccG3e9s6WhEXtPAIaoehwc4igkwQ/6BnNMz8QsDtsEJ5MN52MGwp9G2eQPJj35ikZpbbQjiK7h3KtBfTQ10VwOF4Y20Ek6NKyYbbLXsCdvWEhUrkD5BdHIIfJ+vIwZSctDHLn4fn+9olk60JTTStrk7XhIkNFvc0qc4mYZKe5HM8egXEPBXa+IVIXKa+hZkVENApKUk5wqR7XgH6WMrVmEBCa3dI4r+AYGE+oVeVijEyoRSta9HS2snjhvbFh4bD3PFisEEHM4ZWnDeVTZljTvnhjYJP42on30wt3SUcfC4kYwfKpRhb3ePedQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:08:44.0435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaec3d0-bd68-4eb8-4091-08dc37b6c0f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861

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

Lizhi Hou (1):
  dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers

Nishad Saraf (1):
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    6 +
 drivers/dma/amd/qdma/Makefile          |    8 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1162 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  265 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1566 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1


