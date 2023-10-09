Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C67BE952
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbjJISbP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377554AbjJISbO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 14:31:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FD9C;
        Mon,  9 Oct 2023 11:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHnBZVFFyePsDadjtwhWRPUcSy1cEGC2zViHqBs/uHMSRqRfV00m9BNSt8aXoL4rfdAWKwSk4A9LcCKAXFzawIX6nkL2XeSz02H2BeYpIZL32LkQDFX3TQVohLL4tUUdpKtBDyTh7TWPtJ5qiHocKJ9eZhfCLd0UysFuxNJxjBj6W2UMaqYPeXGGB5Zn+WKxzufqTBJ8Bt7rBDTl5FthNdEl5PbBkoRF0Y+ukl/0EEkOgUed2FSWL3m2gCWzhuhey4yTBwkoKqCq3LLhvEzunIRcH/4sxgMsznzoGW0nX10WI5g6tYmaIofVSuguIsHmBNQpRHKNDxK4RCIcXdKJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZnN9SNB4n7/VcY1jqeLLDYrEV1CGi1GOwI5nZNECkA=;
 b=DD983tQkGF3Jf0Dm1/hVFH2skGnUutavuj2QWTqCh+W19MfwLPVjljGY5Micf1gAYcaSiGCWj2gE/9/U7+YZA1dM9MjSlVw78weuqucCCgPueN0j5OmovD6DL5Sy3CXrkIjwKwHgEe1idl8e+drZQDEsaTQMPxflj8OO7/qIMza0K0ugl4lVpYv7igQ4rJEC6hjBQ+5kbHPJ2PzHxLVLzvHMXJLE4SI7s3DlYnjUIwwOK+YuZeOU4TRzJv7BBeLxck/TCJz+mac4BmDcZFb3X7IP48WqbHTCHljZa+bEuvrYqV5lrpK7utusLQvnSQGVTapRaaJdV+tuA4j9pbCY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZnN9SNB4n7/VcY1jqeLLDYrEV1CGi1GOwI5nZNECkA=;
 b=Ta09wnojQA41D9smJgeh36Y9ErVXna914w0dURvRgElyZbtYWtAmHAU8v7Dqsi/gplBoTjNqnAQcKe3ijQATjtnaKaEfVrXu+lTYMBtmofewlOIi0aX0hwpRo/mAckNWK+/FE9dFmhOXeIjJ9lrmmyf2TqH7cR56Vvyei3mtdIQ=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 18:31:09 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b::4) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 18:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:31:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:30:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 11:30:28 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 9 Oct 2023 13:30:27 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V7 0/2] AMD QDMA driver
Date:   Mon, 9 Oct 2023 11:21:32 -0700
Message-ID: <1696875694-18245-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 16740c17-dbc2-4596-53ed-08dbc8f5e7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jJKxS9EigDP9hjTdrUz4eVPZ8w1VuwshBFFvzRE4ONi5VaHPZ08zOe3BGkHDTI+blFYp5sPG2nelVeUn1EfiGVICwmEX4b13LaU63Z+uTbs6gC96/hFWXBamK8hWD3IdhvhgnCnMwqtX35rEFFm1N059nGjLkd+jGitFo38D1t14nzyjQULm5nd3dZyCmxbHOKQ4qkKQGqdqNpqwEQje5dP7EyfgXgqrlRKzmSmlqYBs6JBqufBmZAoSFaV949sUk5QqwZDNoztA6D5TccharrQqohuwMDpyGxgqRnQgkPB/QHJ3rwyTRF7JFT0Vy8BG/aoEv9E8QT/DBEpRRkkNiqwhUs9DJknrTuRdgm4RcfJfr8P9iPCcagtPDoXav+tPApjTwhoyd720uaOcpJcRxUItLwGXPWt8hcr7/Ezrjg0GMxGwZLOc6wxxGYphC6q19W2lN8lE9BIvYjyu8hnJwGF3gyOY7CgrONt9zjVZ1st9Lbmz9liLn38zk7GuiF1hhvjEKeoz8Tsr3wDXjexmNzafEiqBeLXjN9EFBzs3XcHMB0y5FeZd74IqjGlWYTioSc5RYbAy71yMeoZJGQUhHMkP76QnyhH+gxg+Gkkh3WrPvgBkK4mZKCZwduTSsJPQiTqhtkLcR48Ka3x/DQDxrNezr/sl9OKgSLAowat5e0GCZQ1XLJIuScZUWzZAvAO1dnvroZfVZjUFljmjqPbHDqoSKLxvvdlsGYerklIhW55ILfSNVu+TUqpy2aVf5sp2XAc5mkpKZZtsPyf5B1dt0Pel24GgOLW57Nr+EQRQOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(47076005)(8676002)(40460700003)(2616005)(426003)(8936002)(26005)(36860700001)(316002)(54906003)(70206006)(70586007)(110136005)(2906002)(336012)(83380400001)(5660300002)(41300700001)(44832011)(6666004)(82740400003)(966005)(478600001)(4326008)(36756003)(356005)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:31:08.6549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16740c17-dbc2-4596-53ed-08dbc8f5e7f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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

Lizhi Hou (2):
  dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    6 +
 drivers/dma/amd/qdma/Makefile          |    8 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1185 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  265 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1

