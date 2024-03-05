Return-Path: <dmaengine+bounces-1273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E218729B5
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 22:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF90BB2A481
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526612C544;
	Tue,  5 Mar 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oRd98f+z"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E512BEA3;
	Tue,  5 Mar 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675374; cv=fail; b=YPfikIB/pF+dRUzsxpAPz5ooVwDLUcKK1MxVTlrm9vAFUAHeJO8GU+4L8jgZIOrNh6fhJ5B3qUrwVZ5a8daqGq1JRsbGtQve3x96+wp3yZ4S7cPqwhd4pKep6p+jFoyg0H5xZqqV97QyRp4t0bl+VfatueRZiKVq5GEaBQxu0no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675374; c=relaxed/simple;
	bh=vRDawoO9+Eq4bnQeL8HHy62r/yrGHJbsx5KrhzYRmKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELISZqfOXr8XQRtKTfxDgzmZ0awi3V5XlperRVaLlO0ctIHToCDlHqlzTEoKBywO2c1zUSuh8NWwAhUO2vRJn0LGXXz+ZsMPzMUr5yvitxW1IlutCQuVFxT5txVWhzaafOdrhaTYjIUPkHvTTdJZbx9kovwuT5A2Fm3wbGCYL4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oRd98f+z; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmwan0GCLZVG+/nmonrqWAiCk3A4EQyaJ5BnlQVSV4dUygSP8lktA2YSBSW1q47b++Hgbd5p+HFsA4hJUThGGYYCj2fjMwBHTXZMrDBmXcIxjjtPOUiGUpnVO1RPj0TDg7TKGTHEAzr4+0cbvTnutQxKtw9lanNvEuWQ43tf0C5JAU5/TXDXV+64zTrhXoYSDWLtN5PUzrr6YlWz+GvuIK6DiP4NnddfCH9YR+n66CgJ3E4VgueobCY4AhVIkMiosDvDIDyujk0QnGjt+THpwoQez00WEoRZTL0mFJ3AmCATmWVfIRGIU495tgixug8n4RQeDXJIdVHOd+jXXVtHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCandz2nv/87pe8Q22MVE+zAFAumP18UEMridbNZ7o0=;
 b=BvMHNG3AUbxhj2TG+XUeJilFkTPyWIT6UAz89wG6cj3Jwt+sE7d/xARYbj9jN0Jda0h82LBSwXJhdyo9lqZlXaXILIs6BcVUfggLoGIVU8m/dWdBzMSJnd+TeHIjMYr3XBvSnxRVz4vdxphZzuyPyCHCsJiVZ/ISvajgIdjE3D2AEFN7hlqbt7JG4x72lTgPF7mBxdx2NK46BJXZYjbBUbJGFeBbxk1r6Lub9VboxMrAeRjIpFKUwOlMnL8hkhon6Cbj9GcslNULR0lICnkB45R0gdaxSeRqSdNRZRwty2gDzCSI8qO2XoNe+hru9lpwS1dawXKbk56nBPUhZu51TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCandz2nv/87pe8Q22MVE+zAFAumP18UEMridbNZ7o0=;
 b=oRd98f+zgVVWKpF6+HIS7qZSbnpqB8XDq1+qXjWxpcNWUe7NhL7DGsgKQ9lpGAllCTIK0W8qNSd7RQazCekRw6gTN8oNGvH8g7OQ3+bEPVTaD7rNygoUs+O5YD/EvzHx9K5ytyC9eJ+Jtc8+MsxT7UlByANDt09AqbJX7LstSvc=
Received: from MN2PR19CA0053.namprd19.prod.outlook.com (2603:10b6:208:19b::30)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 21:49:28 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::19) by MN2PR19CA0053.outlook.office365.com
 (2603:10b6:208:19b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 21:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 21:49:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 15:49:27 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 15:49:26 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V10 0/1] AMD QDMA driver
Date: Tue, 5 Mar 2024 13:49:11 -0800
Message-ID: <1709675352-19564-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: d09229ec-37f9-4eb8-69f2-08dc3d5e219b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mSuh2o8jIXGaRxKYmS6pEtFiHlBgUWPzEF/A19+HZb837Mrr0idpW+Omw5WB0MbyTo8XjYa/qXTvFM1U1zcWr9A8crUmoxEsp/ilagwspyfezD3FXA2wEw8RzOAdMpW5jYVHjCrQNsvsa9ety7Z9qNie+JhBcXu8PdYQuglkQkXvMAXsYYeCk5OlZLrBuvFX/KL1LnOQVT7dxaHtEDBpweljuVkZBrkizLsLTl/6s8imLPRtzzCxN/HFotHpU0/D8itfuV98wqq+YTFV31G5p7RAqesmsOmwUH5bUbReT9jRtjJjVqpEOQqknz5ZlFMMr7hm5r4Y7Fa0XldCT/dfkObImWVit44+un7ynAb6XGLEHgc6OIgW/O1qRNd3WSZ5j5FFnYp6uY31S/kDuGIgCez7fhXBKdVKMo7em5Wa1iDsPfMQIXpP1qlfUQeh53Atv06lzg5R1dktbwoNmkODK6cBxbxGP5fwEmLVNiI2sZQOTDSXdBbjVjovs6ibFl12u1GmtO98BGkmNudqrF7B//LbQe7qmwCreOifz86QJHxhGUru5W/Kzb++IaySfRMkGnX6c9Iu1g+xcTJBbuljfbQ6vSFCl2SKsfyg5HYcWv7eqxjDz3iHUHFrzklKMpDuqjnmKKg5BjDqsvxiUtYGM9PfE5qhg7rSZrRzb9IhHa2lco2kqmedfcVbFZ4HoAdqiNahuWItKqnUBlFpIGJhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 21:49:27.9352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09229ec-37f9-4eb8-69f2-08dc3d5e219b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

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


