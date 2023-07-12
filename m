Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01604750E7B
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjGLQ0K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjGLQZz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 12:25:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4762136;
        Wed, 12 Jul 2023 09:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfVZ/Dpg9mu71Fa8xWCHIHO9ih/FSktVPvldb0gt5myGGcVJrdMFzzZNczrQZhWLgK8vcMCE2E/BzKHyF3BOp25MnT2Q5Jc08w6sAysGRKlFrCk4IZFiKv93MLKzXz3DdOFtxiN7wAwk8vvj8iLAGY7EghbAQvoJ0TQR6YHjCprJ35y8LGxAx0+ZKn9XHZ6vXWx+x/bLCTJUwuqJsHdGuK2RSW4+2Aj+SugcS1mLlAG4TwwswTI+VjFKEWz9THidB+4NUBi9d9aGRHuu5T4XY7Hyvee4cMF1rAyJP23AeTMzE8Ds1UKDl9b7M/hhqaHPHOwOHBdzAzrWoBISXzPmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8i9PPCWv5yKHSFwxnbb7Tr9Bz7VGPMZSrn7ncQRsXo=;
 b=meJrG3R1RpT6dlenZmo0ZkAswaWaprxHe1fDUvgemLgmnOoiSXmxP8+GaSYGdIa4ds6pSWtPrZtdXdufXjvBzXVUFggIKGBlNpD/FW9eyCZcquexaf2B5atP3aOWDd8s3vbp/HRamdVpdXGThxwXs3nxg1CglnA3rMNKCE4tlfLNFweQvAjzkT0YXp4W6BTfSA76ko0F+Xcc8v8fWyoq8RHKK5xrBbOwmq05Nf6zVYG8UtDPvT05gvQa2GFUqRfL4JFLlRDGxClOwA1xT3l2+KdKVRT1bfsElA87Vn6oq6bCd6a6h+H/x5EG0tlcEFgBqTqihFEGmzMX6bR54faFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8i9PPCWv5yKHSFwxnbb7Tr9Bz7VGPMZSrn7ncQRsXo=;
 b=JkA1qsBfp9TqkQIpT2qQGIzTlzuwiMKmoRm0THDc8snpq8RYHAAdBPUcKnjmW/XU0MFdZg5q/MY69p90tYogD57DmnOyJBAVnznKafcusw0EW0/bdSwj4/RCZlSZMWXBAzEEbslrUuJ6Naz++enKflgrnp2oQfKdO/Lm5VE2p68=
Received: from BN9PR03CA0714.namprd03.prod.outlook.com (2603:10b6:408:ef::29)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 16:25:45 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::65) by BN9PR03CA0714.outlook.office365.com
 (2603:10b6:408:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 16:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 16:25:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 11:25:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 11:25:17 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 11:25:16 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishads@amd.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [RESEND PATCH V2 QDMA 0/1] AMD QDMA driver 
Date:   Wed, 12 Jul 2023 09:25:03 -0700
Message-ID: <1689179104-58089-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ba4fad-0b47-4cba-0db3-08db82f4a521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4bEWUWwtqxr2SymlXLqP2nlNd9XTtqZ7oBnWt3I6C1pPdy5gsdV+V/QAr3PDYs+WQ/1BSxAcd3fYlvPyaXQlQ9GZYLahLTbyv9GfrSa9ITKmuzeHVbGT7ig78QfFItk5xNZ7xv51ug4fTm665y7PZwXLyHCrKQUKKuhS4XgyFOL+eWNWnRoV8KumAI0eCLKeJcIAPib9oMQ/5C5k2USyhgLIM79xARSIh5Z0uEMojn+if03jPItssHTV6vcwUXY6yYpYEEd56OQGph93U8avYe8uxuYHmAz94NzGZq0ET3Xw/uYMHZJcARjMJQJOy5GgcHrgMO2yNbUYznmUYN5Ji/TecfE6R7UAH3Y0RALv2eUCnpTE3raOvhui+/fd4mAqnYTEnawGLg0kBhi3HMvkNjVXiPWyrOvTvfIvKCsF+EzepYeftWX+VjLYeXM1WqLPgBLfKCTX2q9TCSbhV/zPonAKbQY7g4OGDJJAQV78hublSB35vNf5+bwtTYVV5xH0DaC3/QcqnAlAa85cNs5YdsjYv3i205dot9SPBbURugr9EcMFSA+ztKc11eqoQtAlR44p9Tt/jnqxm+o4e2rJt2OSvvA+hsGByhYEz2urFRcQlI5BEF7GvQATXTm6fy+CFjEFBwlB5SF/WC2z8kK/YkEqSXSKlZkBaQAsR90+xGrbj/I/RLTVfkEU5Y0zVF312yflPanY8HXsxq3h/hkd5fPnTVPUadmTKFFdTMqmhx5Uvb1m0KVinUVS30Rqq4jjfXcqMBtqJOl/O4y+2QKA9RWmkUYBTPQsRY5ji4H7cd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(36756003)(82310400005)(86362001)(40480700001)(40460700003)(81166007)(356005)(82740400003)(478600001)(8936002)(54906003)(966005)(8676002)(110136005)(44832011)(5660300002)(316002)(2906002)(4326008)(70586007)(70206006)(41300700001)(2616005)(6666004)(336012)(426003)(47076005)(26005)(83380400001)(186003)(4743002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:25:45.6626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ba4fad-0b47-4cba-0db3-08db82f4a521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/dma/amd/qdma.c                 | 1189 ++++++++++++++++++++++++
 drivers/dma/amd/qdma.h                 |  269 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 8 files changed, 1591 insertions(+)
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma.c
 create mode 100644 drivers/dma/amd/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1

