Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFD7794B7
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHKQe4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKQe4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 12:34:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14C18F;
        Fri, 11 Aug 2023 09:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVtnAoWMqXOVlwYTa7qLpDzuOBvBMtcMbT6J8zMZNqnwyl+VC9AIbbJLoJpUvEyQn1B4zZSJVh39OqK7vcbYIJZXfqW9n7KGWZRxaCbkArK6w6cP7GbnMgkrKrwcbXmGH5jaC/UTnL5+nKcFGxbFMblz3p2xSjWas35EMkc8APbEtdtN7NJaJxqzxOzogA9rHdqK7ZwDqVMySDG3HjumNY+Cu7wK88DWue+4P8R0K8l/2gbQffBb2V9FxkNBC4RpCutcuY2okwoY6gmFQPkeF5noloNRujGzpI79k98LgVAXRhwZJTtPfPcS/t1kSA/9i4Dh04ehynZuUnSlCybmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h757if1kzOYIs8FuMOSkaCaata6dQrtlQwOI1anQTms=;
 b=gAHoZyGcrYYT7ZXDKuNjbNa45S6JVM/5xcJTpeSejd1UBtFiwbGfo0yR+hOgP3buLvN+9egYuDjUlkLlbDUlxTd96qc+z7qDW5c/HFfKv9Btw6MiE96gogIfLy5Ucwb7Hut6ira7sVNHh5K3N+fLlvf4/cDdzo8g0mq3uRVkF0gu5SvdyAiBc9PFsmGod/X3Dew7r1g7YUxtV6hT6WAi9f+e5mHZHeN2pmaDWEL9KOYSMOy4jNztSuKo9/VXEQts85uO8PcqmdMUGohdkvIaqcbIMFUhXfhTzVPuiOQ4c3ezPHH83lNCkxAKZ3otftJqfPSzMsDSzg0GiP0ggGraKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h757if1kzOYIs8FuMOSkaCaata6dQrtlQwOI1anQTms=;
 b=MuQMXmO1OqK3QghdgAsSQCIxmGKeOCyJRjobeAMBNyXwc5LZnF8fLaIV3y8Um8zs53G87DS2wB3m9vpg5joW5gtikSt2df3h+H4RUIiOR42kp5Z3fPcSU998cmdXgwO0udtO89pbu33X5CAMtQiD1aKQoNAsC9Wwnb97wdxy6LQ=
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:34:50 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::38) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 16:34:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:34:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 09:34:49 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 11 Aug 2023 11:34:48 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V4 0/1] AMD QDMA driver
Date:   Fri, 11 Aug 2023 09:34:44 -0700
Message-ID: <1691771685-57219-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 695b9b03-e86b-43ba-2506-08db9a88e211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sN9cbexStI6p/BEBg9pu6ufPfYHqVSHf68+ilckGssSTEX0ockP/0OzHJtVHQXp6bc1Re2W0iIsg+QzGohDl5/PndCErdx6F3Q6eqFEvWm/hsiLr86MrZGp7EzR0PRDqCXUsmKm3dhKgQ9+LsJrYKQHmR+1A3AhpLiG744cRuep81JwJ6/4xSGdnHtYYySFu97sC/IttphlMBBL2rkfcrYtQUCcYDK7pW80XPOqiTEj9Uc2wERvowFz/o6hMSJm1hvfz2DOqRNqRBt01582IDmQcEoQ+LL/HtVQ4K2TRuV7jiTVy1Svz6sA/aR7jvIerqkfvnfFiUaUqPqtWYaQMkmdk2wqHUFFDYsHIZ8Q0/xfSPD/M1O3J0uY1tYj1gkoKrHHadUztaS7EalpkacoXUHD/cXICM9Pp3jUbc3X9zbttxyDMNAVCN9Bi5HOVYeAl3Q7J8U+maPwZZ1gradIYILukUX77HZle54j1OilXOKZog67YtkYRu21wH5qSdTZyUrOYvlWivOuC3HZHJCq1/Tjbw/saqAiw1ulD42UxuUBEUhl8tVkY+R5iIwgQANTzm5fLS6Z6v75hrJ7h2UJFjEM7f+sUYTHnRd8CMHoNxcgvMTdOWrIGS+yP/6Zy11nFgYPf1811Cm6IFO4+M4ittz2+0yqFDjMecjNQhvgMJPTE2rdKwyzp5xdFyZsrgdXwSKh0ZCIwpoZWfOrpl4taguhb7oBOOF16mDv6cZSpwhiToijIaBFpiAngQ14Zpfr702ELAYrgUCyIp0QWvVSn3gNbYGtSm/uq/B1mfYykQ5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(6666004)(966005)(110136005)(478600001)(54906003)(426003)(44832011)(2906002)(2616005)(26005)(8676002)(4326008)(316002)(336012)(8936002)(70586007)(70206006)(41300700001)(5660300002)(86362001)(83380400001)(36756003)(40460700003)(47076005)(82740400003)(36860700001)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:34:50.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695b9b03-e86b-43ba-2506-08db9a88e211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

