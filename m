Return-Path: <dmaengine+bounces-1896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9018AA161
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 19:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F942849AD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA417556C;
	Thu, 18 Apr 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NzcFfWac"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C71442F4;
	Thu, 18 Apr 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462657; cv=fail; b=ictEBJnr0P4gkAmd/uLpeD/VCwz/g6TPjfW1N7n5/FmPDjheRS0paN8n6Tjf4qTIkvYCk6GmxcVWiLc3oQ4/wo8c5q5NeTBL+weumUe0kBJeF1s3fIbZtrvuFtzlcCt5vh5GoM9ddtG0xhOIOIUAjQdtwqaDZilpYa5airIRHEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462657; c=relaxed/simple;
	bh=4RtSnB4k4UyAZO4z+xcCFZoHyvYzzNo8OZLBk+JmcnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4/1ANji6V8nSUwUjlks7VdqouPb5qhksVXwfAmsgPJ1Re1fqeRH9kg0FiI8MTlSuQN9qKM6B1d6vIYUwaPpM9IdT26ha1x4ZMJhP0VLKmhAd7FJTHKHtRelWBJ+eePmnoxbjai5tjkOcWYY1EUeiiHlJBD2NjewPxOcO2rIQDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NzcFfWac; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX+NTupk//WxW9gVjJKCguOTFiklges8f3CT5Cgli6x3FQVFplZi6+unCHvDtdngS8LrXb0HDtKmKeLMQArJRclQh4fHGlRL0KhYh8XgeTQ+dF4JtC8PVSex0kqEr9XwDCNU+M8nHVB+K90IC/3zCkHFx9MidT8c8wzazPvhGwmoL+SyN6zkMJ4rKkgWSiIXfTHHSsSwuloOwWotqtOxG4PLYeDNDQEatEwX7w0cdsL/VebbeTRC7tdddueTExrGiimErmDmyDhs+8TyJ0yl7v2MjRHQM0PDel0uH6xh+4qlafbMGlG/qkyPlkUgszXBtljKgxuUlr2wUjTMRO2vAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=oS6n8hMRufCPHJLRnHXSPJIZ3Ojguc8aZD1zqQS/n81sofNuw+840b64BNY/+FL0nrKGiv9MUNJLKW/0/wzSFM0wEz6bYOviSNSe5XnGmowOIlf8dPOndlQpUav3G8OL38ZuhaHPpzE6NBFVxY+VKKkCKgPJoAWbPyHiby4pvhkfeHmPy8aEogwyL3AXqKzRYPY3tTzIaSrDMTxtaH3qLR3jU89RKPrTPLYYEsAc1mB8cUFJvwUndQ8kbskqYpff9GflVhEhYRZ25ehHHqOOl5zjPeV2EiwjifvTb3wjOQwdlZyeWXYmi4NTO1LZMUEGSzJzWQ+kc6n+4xQOjiAO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y82wlPYsBKuKZP7Z4V77tukVWKnZHErs4EDVcuPaNAE=;
 b=NzcFfWacd+7PXwmOJwQ45PEoSZddA6zsUzX3PcAogpRtvbHxfDRhrq2U4fwtjvg/y5rsTVjZQOPgz2CVIT2eebog7xYoQ6MA/ezgJ/Ze5i1nilOPeacG/Wp9j2awqVFOKPbSHbUwJrk6kXZ7L2e/VFLZBzxW3i05dgahgSL1NP4=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 17:50:49 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::96) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.27 via Frontend
 Transport; Thu, 18 Apr 2024 17:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 17:50:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 12:50:48 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 12:50:47 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V12 0/1] AMD QDMA driver
Date: Thu, 18 Apr 2024 10:50:42 -0700
Message-ID: <1713462643-11781-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 99abe3d8-8713-4f37-64ac-08dc5fd0153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fDi3Hiu2Uv75KBcPsEMFkS0L3T8nSdyYuEki15JQTgOu7m/KCJJ4OltXeywK4q3ugBKSqalHDz9K3RAZzgA+nSkEdwBGLw/NEHaAHT3pOnQ9QPSazveV+sTAN1MkLS0oz0wPOgh+AIoORexYY+KUpZB2PXkIlPhcs5P9U8jL4bqf0bnZN2AefmzPXo8KyEAFcq3/puFB2tefEvmxCU6LYmQRiwGueugXv8MApq2AHlnTPvTq3dnFcG3/aiXQFLjNlqjsa6xxQt8Gq30m2L7sNznq2s4eZK0GGEwwrITxm5a8dPgq8HpZU5cYBSPrcAljYxJD7lh9Wey+tHZWsJp0uPtTwqR8D42XQBuHHN6qaRHXiB9Z17Un0YSQXCTwlxlR+1erPWMApfJAdDjBaINkpbCCF/kKLyFAEHVUE3RYdg0PQsaPI6k+Nykq82g98aYpwwzb3IRuBPrgG85P69U5rw4n4NWoVKZ4swXut3CDpscSFUAHb2ANjcuyDHza/A73Uj0sCtj67O+q1eXiryMfSxZbpzcLsFX+by5p7zBF8rLwvV52fP25FG0enkukt9kR5pVYhc538NHBSDi8B8xX/K3pEt19jy5IBHNRfjbodiI0wg2q90sxqWZ+l0gf/q0IHX8uPAI2xS8/iT4XwfoyZKAEY3Fc+uBT/i0RVA1hKLDfkKgN+h07ZZf6tL9apNFhLNmsen1cr8B5wG0DwJvSGsNyOoQcPFuczXf+TiRf6jLF4ljsqdYqPww3M+38IOxxt1CU42kNB/JjI6zk9tAZ5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:50:49.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99abe3d8-8713-4f37-64ac-08dc5fd0153c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

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


