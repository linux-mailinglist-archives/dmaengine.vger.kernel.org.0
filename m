Return-Path: <dmaengine+bounces-2918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF72957669
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AD31C21326
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939A1591F3;
	Mon, 19 Aug 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BoLUAZLy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BE156875;
	Mon, 19 Aug 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102396; cv=fail; b=QO+FP7Conx7Z943Bium1PniDvp8xEii/2tuMvt6gPQ5cSgWyiNUV94u3j/SsxinhAwnOj4a+qyF74KuL2ZKgLXfT+Cmr6mepaJhW212aA8s1M+4Duwbk+6ywqOq1rDbY4bRUy1v7gtARv65R50gHXY+EN89IiuEZNkHLYsLJqn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102396; c=relaxed/simple;
	bh=4RtSnB4k4UyAZO4z+xcCFZoHyvYzzNo8OZLBk+JmcnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyMcXa3HC7RsDTurBvmQDbBi05Qxj2xhkcslNkOUHak2x/eRnW5YGfFNOvIYTVAP/kxkRnTbxAEuwoZbvDlyO45CKhhtAdib58WJaYBIyYa69/YSca63+CHZ7Wz8NdmdGo1epLp7yH56ylOrQWAksraR6eCLO+cVDchkdpqzBPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BoLUAZLy; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqgDsc4eW/MW+rRhiH+tpEUCzTxdYZUG1o+wXwCXZeboJSobkmFuELDX+RjVIz3PxxHsbAx2h5KfbNF8VeP42/BFLu7EaZAzmjaRrKofi1A99GpuPQeMd3YKaoVp1en5p9jyAmDIft46xh2iaDjJbFk8DUTh52sxGl2jdmFNWAUSQFHBeDK5KXSbk65Gp9e9NClJ6pb8WPbN1fFIaV+TisXUea/C4reBiTVrPyiER6PK2oeZ6cQNt1HPD5fAbty6sVgWbGtCTYO3vPnjl1QbcXWSrrBjIuWUuH70/hwo7PXwVLwSN+xc9ikf3pSv3AjDIJIlv5qxPBPAc96fl/QCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=WZWRIWIv84TkAnHa/YbZ5dJL5rdUGVpCZHOqggy2N9BLC1NxWCKnJXT81xWl7f+F4g3c5hPJIMgs3AW0BQAdX6iC2OSUD4KaceZKkYllZ/jaXQpvtHP98z89xX0qOqMc2VErAx7jVz7LdjZ7MkwpACTcngl3PrVtCLlOX6+Np0oUX8mDZuwZNAuSsAQF3S19+6H89uPVExgwtPFLgSVoBhBtoqdvspfCtLJitM4SSslPMGC2S+F+C0DbRBefpTbBYyJGH38Ulkipa9Wnd5cL7y6aH2yrKnkZzHJn6VtH45rh47GG/uALRykbhS/c678nkhBblwMfWnMexTwdClLYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=BoLUAZLyCdpVUlJkVWBZmuGxJKUzBFiEagLdf82zJcV6Ql/SauoaKFbb1fW1NYy6BFKGqTwNnm02UtVWFXVKgPKcshqqqfxeiQADAytywsia1qEiByKij6qSXYXjrFcTyU+/gTUvkyboF/U5Ffg647yGvPo/9qt5nTrZgepf1SA=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 21:19:52 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::7a) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 21:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 21:19:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 16:19:51 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 Aug 2024 16:19:50 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V12 0/1] AMD QDMA driver
Date: Mon, 19 Aug 2024 14:19:47 -0700
Message-ID: <20240819211948.688786-1-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: b6267ad6-54db-4cd8-9e17-08dcc094aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pH0zqDuBWp7ohvmk60yhfMnOgwAzxqYJCe9JUZQpXim6WFNVbX4j4iN19w4n?=
 =?us-ascii?Q?EzzxfuCcPA3R+XXtRPbkVtWCC176pcB/cSaYw4wX7/B5/z7hw0DjaaIovd9W?=
 =?us-ascii?Q?W3XWorJQCRcg1h5KD2g2vYuXRTQCxAdm462+8uOi1fXR/fdOZAq/UikXz+cy?=
 =?us-ascii?Q?49P62Uk4p7kyvttYJO7huDQTatpeVcar2aJifHjbFWPa5SD0WWIvxQKJFQ8t?=
 =?us-ascii?Q?fmZXc6Ax61tSMDxHTZNvZFx5YLi5QZSa7zzB5JqmCyrO/hhI1+CvsaEoSE3O?=
 =?us-ascii?Q?N2F8iC56XYVCtrViO0ZXSKvhUN4n5Ls+MuFq6BRlmrP/jmsCVoDJ8pGP1Lkw?=
 =?us-ascii?Q?BpfCQj5B530uH1/BgYjaL+lwmeQHjASOlYJB8tY8KulYFqTYtk96I0HX1dvj?=
 =?us-ascii?Q?j3amMRZwA24PFmTv+Wl2P/GFn3kWFGgkKHcDbja9Q4qXH+H62np2gtsSBSkq?=
 =?us-ascii?Q?w14sYoJOgzlFMzt3xxiHUBvmr+7hukp5uGAvQqIiIb3oKwDr/n4APrBC33W5?=
 =?us-ascii?Q?DRzgPn67BGJLYYkRcCQmDngJRqn++39JFs0QAK3Br45N4Lf8pX9YhH2qJtrM?=
 =?us-ascii?Q?Cy1/JsLeOUhWWTxFw41p4Z6ExcI0XKEKca+paJR6P02GWBHl0DAkmkI43olW?=
 =?us-ascii?Q?ODLpS1o+t7smMa5OsCaTdPVZsY/UQVOqhLO4i/KtIKUbSjO7GOcXCqTOw0cy?=
 =?us-ascii?Q?jglDqucvOsBKNT+Jl/eLhxKYox63AgXeSj+Fp/fi6UB1AL7myHCkSdhB1cB7?=
 =?us-ascii?Q?gvWY23mR/z1fsXjahA3hCg1+uFJKBn/KfDMVMBbGHuoMpxzYeBH2YgELJlFu?=
 =?us-ascii?Q?YtpMETIvwfsycRbxyM4PtOgosm7bOYjKiIbspg4lpfk7/z9hm/Q5Afscn5zd?=
 =?us-ascii?Q?ONo9rlfYZFBVnFm457e3j87W9Y3Y3CAoWueRDjWwgsZ2pU0JeWbYFmk6jESJ?=
 =?us-ascii?Q?E6JMZXsrjjayuYaHwCRRIb2Q94zxQ6tXH8ecdW8KZFWz3tmktxnIzB5jRLsC?=
 =?us-ascii?Q?bump9ZdW4gsG6v4aBP7hWOBK28vVmOmnjw6bPuPmKCFWz//fvWdyPaOldmrM?=
 =?us-ascii?Q?846fvY30VuCzp3xcwJ4XnfnPSYJQg/Rwq52EdZwoZWndFKQPFQk6WPPZ1jJm?=
 =?us-ascii?Q?TW4HBcgXLRfov2jFdxQfLTGs7tSt962Z4Y6hV+MvVzij+2Ed4jS9XnVazo9t?=
 =?us-ascii?Q?O00+BBMh/wVoZ/zqT7jQ3/3ztkPb0b1twk9eFPTS9KiMHE4Zq4/s2oyXIky9?=
 =?us-ascii?Q?5GGpSAy8P2c6jmgR5QK99YcqH7fnDZ9cm83CMkrT95UibVYPLIOXxaYjkEFw?=
 =?us-ascii?Q?NvRy7vZjqk/5aMaktI5nXu7pBDVZHnHW9N/BqDk7RHzFysAC76y5YI22tEki?=
 =?us-ascii?Q?vbqo0rA1oH2q4l3EgHVzyJ4Lgme5ddrFKoWyKfc1pHwOCcLow3Gh6iQYlmtP?=
 =?us-ascii?Q?pD2qic/XIP/qy0PcA+5w/iG7vlu+or97?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 21:19:51.9764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6267ad6-54db-4cd8-9e17-08dcc094aa0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

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


