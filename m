Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6E7308AE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjFNTpc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbjFNTo6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:44:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52926AF;
        Wed, 14 Jun 2023 12:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDymoNgJYksHa/xXL3IwKvy8ZTVvaPpRbDvvfhEX3MBrzKYpOwzGYJJ2KM2Tf6PL0DUNPHwLTgSsXLqHCXVZCdxOyT36feuSnitmODRkKC3d8UyxALcnJd23Msd7PrEfcHeKQJaGBBDkPVxGkMubd1Qqr/zVO8V2ts2jR81Q1wIXNAipRUdTY6Mz0U/nCw4Y/QM3ityF4x18+DF7dc2ACzkJHfKtK8C8RS9Jgzq53cXYSWsfSYO3w+zq+srmE+VoSoAu60J/6gaSk1qV6msBcl0O6DOXyecEU0MFUDim3p2syjsPX1mjxDb2+m5rEdeDWxV5dimbo1mT1ouLQj+99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8i9PPCWv5yKHSFwxnbb7Tr9Bz7VGPMZSrn7ncQRsXo=;
 b=hG9/OAgoUSHTf6id4B/OSbMxC2ZiGIpdaqhLvSUw3ofFylePBkQ5CbzdUsk9kPM1kXJJF5yHq5G8EkzUjw+kmBNCp9kS0vVgoMUBs6Xi/A3iwVAiycIOjS3OuQPwoFNzJg8cylt2+0xPIk+9hB4j2x2YExxNaNB7Owqe5YOfKzIP06ZDgQresvi5O17OqRrtkLwBJ/ST4VF9ybGPyIYEG7v1EGdfdCadlSwoexuC+BSPmrl/lc0u4fwjvjkEq5xqKEZeU1iIXKOtwM63eKnjdUksiM+F7zMw8UXFpikYwnq3ZVwEMIrDuB3e520NxjyFXuqMvlshHhOdJhV27pISwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8i9PPCWv5yKHSFwxnbb7Tr9Bz7VGPMZSrn7ncQRsXo=;
 b=miyw0IolX7nlIFKqQH6ELWuEqiek6NQMBEr9Sj7AMAHk+kZt81Zsi02U4+ICeHFRqqMikNgggLtnlIP2f2hIPEjovZpuQBlgScGp/IQ33OxV44ZP/IDBGc8eaSoWh6SYVEeOWzRl1gs3Hmnyr55JejB4FrX6uUvjwyFsHxuuGRc=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 19:44:37 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39b:cafe::ab) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Wed, 14 Jun 2023 19:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 19:44:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 14:44:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:44:29 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 14:44:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishads@amd.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2 QDMA 0/1] 
Date:   Wed, 14 Jun 2023 12:44:24 -0700
Message-ID: <1686771865-15469-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: a2aa14db-ddc6-4246-1b8f-08db6d0fc943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jKDu1EODi9C7U7OSJ3VNPTsQbypbF4Uj2yiJBOcm14k5rVJ5ZbUv8HvqecEYyQkJFlDGJGfQlMHLGs30ztYveUOJsKg0n4GhJrrN1v8iwX0996VhFXkW05LcdY4PnIC3ha6J3KYKrWnswHt0ee+YbLkZAERuBh3pu2f5L4N6LUdZsgpM/kUh0JC6dwY9ANjg7/fSQMqEJ1oJ0Wpm4mpQ527zEch3jgMStYQopEBDjAeomhdk+GRqJrmw/W4DKR1ktgH+oVLBdJ/91MmodSfX8f5X3vInvXP9JgOpKNvogooQMaBKb3fZu4r6Eiln9j7381U2qolXk9sLLkmCzwf0r5EQk3YFzUXkvwFKtOXqP1Yq6sZgYoM+2sIrTAelEGcS269RGA8AeMIIfBPI1qKxt/Wck7cY3gnFGDmwAa3K8bzlwc3Q2BFrHQ7yZm9yiUXoZwbukZ8DDhqA2uAtP+unJQiDaUWWsiScvKh5ePtnn7QEg7JIf8QsSdUMgCkQupT/3kjoEzAvoD8LACUqJ865N89Ql1G6V+DsEKFOVzCFtAJiCKCGdUt/0ZZF/xPJs6aq+9qAECh/vQatTg4f2P1sEcZUVt8QKNJPlAUbpZp5xn1wsmo3JHIs16B5y6Uw9+DCWm2bXIkj4W4DRldCHQMqL0l+MbunxQd/7ymww6RDE/6DyHLF9EVarcI/YRlSFV7cDkOCA6yrqxkYLS0oW0U5BsWI/fO/9LlZi78w488uCz5ErTstAIQTJ7oE5QDDCujr3rOL/+2mq8ISwSIA+2kAdWDoO8oaK0V9A7Ip4/otqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(26005)(186003)(6666004)(40480700001)(4743002)(478600001)(44832011)(86362001)(40460700003)(966005)(81166007)(4326008)(70206006)(70586007)(356005)(316002)(2906002)(8936002)(8676002)(5660300002)(82310400005)(41300700001)(82740400003)(2616005)(426003)(336012)(54906003)(110136005)(36756003)(36860700001)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:44:37.0831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2aa14db-ddc6-4246-1b8f-08db6d0fc943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

