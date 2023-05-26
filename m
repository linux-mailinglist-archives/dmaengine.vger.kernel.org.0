Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988FB712B0B
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjEZQue (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbjEZQue (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 12:50:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D6D9;
        Fri, 26 May 2023 09:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4E06ivjp8aRJ6QgJREj6eTEBwhX6mQcUuokqK2rtEnghY82I8S7kDF1lPC8GXow+Xnum119K7bXJRZU6RoO1ETv5lJh4Az3DFaa25Rxp6W84fw+UEe/eZeOk75O7C0EsfflB0phdsc3NvMxCVFmeZTswXolW0dDMafIoHKjFvAmmh8+ol3lRwHyTMV0iQM8BhLlQxdR3ME2tSju8So2kuGhMj6dDvsM0wB1r/Y84LiYmsLLq0hglK3CFfUDBqGj0VXXszjq2Q7DN/MbxDfGT1KVRVMBBzlilosVMTShQhMugT0pFFhUatLy+TWyAaBLoZAbUkS6iULBRJ9RpMqjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjOwHsKOUQ8bGtGURjup/0qyynYze9MkKorU07rie28=;
 b=J9HvbLqJJJfrOzT1pte8anctp/x4EZ99AKzw9Fe3Ah5WRL8rSwm4htYaIRrf/g/JMUyxD/k4tBSmrsqZ2HupwmhltYuyHoaYnNizyjSckQMBFjX3z9H+5mDjawJvTfQBJQh/ZvhfF9Bccvxuyt6XLz2FOzaiZ8sXlZwLpS62DExMEfO/t3PJkbjNpyUc/Xsan042lR3Mawjc6eokGf5Khh9ot5aPm+evgfmOmm8ugUc9t9ZpCH85/PP6FPM60IWUkkg2wa6HLoTZCzJ2GLjo4dTrTzUJtfdpWNSr9D/4wVXbQCXvwbzhdZXma++XVYYUhJDK6mMnB7WiAhfu/UCFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjOwHsKOUQ8bGtGURjup/0qyynYze9MkKorU07rie28=;
 b=OtJQqLQHIwVboETuWA2EzSwiXOZCqb8xCW3NNqlze/FBtPPTWHeDF+aRkpUQkHQuQa9nwNYzWiX+hNhUvZvV6TiGoGFgXlH5QPl/Uv5eJDEFZkMvPJ7rxen068myLFWCZineK64D2cpmSr6MpImrFFsffTD3aNbgIfGTWgWvhtA=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 16:50:27 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a4) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Fri, 26 May 2023 16:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.19 via Frontend Transport; Fri, 26 May 2023 16:50:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 26 May
 2023 11:50:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 26 May
 2023 09:50:24 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 26 May 2023 11:50:23 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <nishad.saraf@amd.com>
Subject: [PATCH V1 QDMA 0/1] AMD QDMA driver
Date:   Fri, 26 May 2023 09:49:54 -0700
Message-ID: <1685119795-11729-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e32269a-e4ae-4477-beea-08db5e094e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHxENcFeUESlHK35g4+WlXk+49UrU7nHzPrSj3VygCWwuUyYe7fZKNfbUECV1TtH0SS4O/tR9gytTYS3bqA2itycRESLouFah72/ERW3AUiZiMRvazwdt520fy5zSQfDyF/Ee59uf+FUBplQ/Fv8mGsyI/LVkcWeUdzurNreyZF5IipNNTcVUw6m7M8iGSwejqwt/tpIY7CSmr9OAo64FGetkItuauGqnI7cMSxvb+c1nm9BiOkUTjI41FSJl8BEoa1Sx+jcDygZrq2/ATnfIhwTbIW0JjrQiolQ/SZKo4JVJwEW4C4nx1Jqzp0aQQJtcd4OC/Afe6EPoUsmvlEVuDGPzLSOaQrmUCM/q5U5IGIyf7XtNYUCbBQgK0dD8yZ82q+IRBB2n8mffCllD5fs2xWP9qdwDqfl0xlPrVAT52qZu7xagymlZTQc9heY5+PcMGTeu8ARpEMzlE1Jn5BBSAls253GU4jhuYTZmte1spUkmr25RhMXTGS4YSjpt9GHN0nxCghRcIdn/BLyjlHC5QML3JMGNO3UEYK1dRVdBhM4THP0nrjLTnKlbuflybTkNkZPfGLPrj6u7a0Wlq3lhJ0ll8jn5igxy8pnK63mCGq7k5LAoNCETUS4TVn0orjPhwEEGJYHsGY6cvGW3jfm1Fycvk+fi/Bwk5rczH1+jZ2wlh2HniZKqN/1mqa+DgBYVVHQPfX9j6bL6NJMCZ7B+b++99C3TKzyDbT5m/fwQuxbUUzrDd40ertvASywru3nUxXibojlRZvJDF5WoHpHhV+tx4hglduc3ccVQwNXZqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(44832011)(81166007)(186003)(2616005)(82310400005)(26005)(426003)(82740400003)(336012)(356005)(83380400001)(47076005)(36860700001)(478600001)(2906002)(86362001)(966005)(40480700001)(110136005)(54906003)(36756003)(316002)(4326008)(41300700001)(70206006)(8936002)(70586007)(8676002)(6666004)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 16:50:26.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e32269a-e4ae-4477-beea-08db5e094e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

