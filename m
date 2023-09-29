Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C67B3891
	for <lists+dmaengine@lfdr.de>; Fri, 29 Sep 2023 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjI2RZN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Sep 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjI2RZM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Sep 2023 13:25:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B831AE;
        Fri, 29 Sep 2023 10:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtRkL51m4kKaBsaecttklG/puj3A4Y7XQ/Jc8S6uzJSsra2PzA8MKv72lDAB/Fgl7hqNeNyWjgnjHoJLHxAC3kj2C6zhsuiv3chiXS3JHm/uRkZLvWE+1rFiUNIuvTEHALRgexPbUpnW2rbLy3mt8VDdigX3eOXwb191cjH+XMUTvCsDj3iP1kaDAs1y1Ao/oYX8DDuULJiUPSlMdt2BpvavlJ929yvw+1O3NXCL7RdJAhIbL8RipNujy7ZDIKm6c18zr74lT2hGWGdg4GLRS6UCXNpSl7I5K1iXA28O6/aAq+UoaUEgtlyi8kIzfBIW8lFGJ9F/RxxGVCUoSGRb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7X8HEcOsyvvKOimzaSf8XlGjNX4bzAWdtZ4/EzPTT0=;
 b=OGqNvctzI3eoYpjBRlR6p+Ef4OPz9XILXqe8534WF0svPgPrAL5vI783Ha7/AWQepF4ISWgqoS2murz7eNA8ltRXtqCuYJw3xnIsfyq/55dCM2ouTJzOq6kXDk+U1y4qcOKmWpSf4bz8tErAjjX4gvxVWg4k8eDdt47AgjVv7KUIb45+gsZS89P4sMDz1thxF6Ifsi9oPpJFRChnz7vOPOwsxUWyBkXSdTrwmV+ZIog5l0p53uWz3qjl31rVWIkoBvmo7aDASHvPNGto5owheVxXv5Td+TZc5P94Lfx2dmrPmz2n27PFIW/n5zr2eJHFa1g02GBfW9KL7Cz5qoiKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7X8HEcOsyvvKOimzaSf8XlGjNX4bzAWdtZ4/EzPTT0=;
 b=bRXarYaQp/Ubxtl9qdC0LgVZfascNqXFae+M8mqzginmgujDgTh+XqUo7FqzBFt+X8bafPzlPHEyr62YKcDQwQvG4TNWutA7ZfXb1m0yp3iLs2D/2fbyGhW9YnwewR2cM3C+7Itsy2zKhQA/BeN55zqyz7EyFfnhk0cfDUs/3zM=
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 29 Sep
 2023 17:25:05 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::3e) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Fri, 29 Sep 2023 17:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 17:25:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 12:25:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 12:25:03 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 12:25:02 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V6 0/1] AMD QDMA driver
Date:   Fri, 29 Sep 2023 10:24:22 -0700
Message-ID: <1696008263-42937-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ced39-9598-4891-e32b-08dbc11104c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVIXcMqoiBTYmwnD5YWz4sGC8UZoYZ8P4mrMEZBkESqOoxkbGtUB1/Vnr9LnboRrfZSyXdRDPdomAEm+4AUFqWlP5xmcwfjdzZugIl5a1HeCpvcdWvGSAbrrYQNrceLL2EuGJzrGMB7OZNj/R44cu/LCcaugm6aCQ/ItFShK3ZEXH1hFFsLrgsCb1HULxR3wercJSdEgrAxxg7DaZrwhKw3SAGSpMut9k6GIsaWPDdCNdqFMqxVz8uGj4mL3oyFxDx6VCJhOvMuS2TFaljFtGPecmV/u+Fz4beeOm15JsQNYTP3ZS0hZjEIjhCwhBF7wihgY8DhNgHKhyIlGcY6MccrKhBVMnw8McXqBTcWGGZ1daOr+mLstN7tpEVnkGy4k/7SW1yWZchxx5vLY57rMJrIgnoFDj2ksVQNXweP1aOl5Jovy3NzRsiYpFZcG2DrhIgwZpM3wBkcjx28I2+nCsqT9fM/Ie92W+V2sMxhpLIH/9U+XCf0RdDHnlFwAmY+AD97yFW/lt9luBjQL4renJKcCHoovqwofu2cQ0cOSCUuyODHQzrkVsW2BvLPkgwYGxWY581jva9o+0Z3g5i0iWcwUqtqWH8//hAIskkOeowWlY+BggfaR4oWzUd7lstULR26wRblolYROORWzoUItduIraO2AqBfLD0QkwwZM4ljmQd2rNVTj2JMBhBTvYJ0Bxyf38HRgTo4mxIMdch0gPAIgC5Xq6lNGU/EAGkh+wCBD5IinnLH6l8qr4Y1R1cw+vscN145hV80+b76nuFpOPyY+3wRlPyYl1xJfc2gAsP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(47076005)(426003)(336012)(44832011)(5660300002)(4326008)(8676002)(8936002)(81166007)(82740400003)(356005)(26005)(36860700001)(83380400001)(478600001)(966005)(70206006)(70586007)(36756003)(316002)(54906003)(40480700001)(86362001)(6666004)(110136005)(2906002)(41300700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:25:04.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ced39-9598-4891-e32b-08dbc11104c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

 MAINTAINERS                            |    9 +
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Makefile               |    8 +
 drivers/dma/amd/qdma-comm-regs.c       |   66 ++
 drivers/dma/amd/qdma.c                 | 1187 ++++++++++++++++++++++++
 drivers/dma/amd/qdma.h                 |  269 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 8 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma.c
 create mode 100644 drivers/dma/amd/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1

