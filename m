Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD95EEA5C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiI1X6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1X6g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 19:58:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7A10D0EC;
        Wed, 28 Sep 2022 16:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OykExBMTi4aNDPDkYn1SKJaxFf7l/5O1kfC0bVQiqLiNZ1LdtlDGS3CEzKwgReTT8Cqn7qzsQbjpqsRV1b2jZdhSi4lfSLHZXlVM4vHiRWVPVNPAVYruOz9DhtOXjYY2PJrEcE2rgy2lL0Wm+xL3DN/HLOt02zxJv/JqNePjWXT3WyAGlNst1nwoe2BhOBN9Kje8pK3c0JEz2JMOIcqHIOSZQ0mNl9zQM0BR76EFEvt6P0Qv7Bnjpw+eV6aaHdtzKQ4tdyJyOj3r3eRRoVVal28Brhz2xbbYmB/oYi7p0d7gueMtkiPJ/Foh0/8dwVeLwAKvtB9CIuHsr8qxBMSThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6WYV9ksgaHixzbPCbVVslGmwrO/Ly261cWpD6YONLE=;
 b=DWZwHj4tPZxQ+k59iXTM/+YGmaAGd5boI+5ZG2tQPOa2KSt3SBlt/XMcm/DGyxQm/Nn+6Uky566hq2ral+ceiN5bbc8MtaXRo/lGGN+VpbaaFxnZCjUuq9Hc7JlkoabZkGuB4CdjpkNY1uWSCjbdbDVWyOnZRVv0jlB31K8O7pacGw8mP7bRG6CV4Kj4OeapPjSmUDeHMX+qdktPj6ft63JUbLrsg1MU8f8lyx1YktbcGJA0vZnsAyBeFWZhstse4QFrLleqhYQrC2LQ1883mW0LxdO+23brraWaQzNtG3DKJlIutzD8L67QjxNW8zobYeoRdhQcTXz2RmcyKH953Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WYV9ksgaHixzbPCbVVslGmwrO/Ly261cWpD6YONLE=;
 b=ZIBQLXmJr/bi32ngyaINKidNly37WoSGDqZXjxtMxwO6hC9GtLDKcbNjJ4OKEYc387ARPGnS6gkYiMM+B68/WZ1HotFAfIywyA5r8L5YS4NfddogBnTOH6CTnsBaF32HpzHYovXB/IuIy68DWa8C0O/mDtMuFWVG+eIkbOsyMBs=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by SJ0PR12MB5471.namprd12.prod.outlook.com (2603:10b6:a03:300::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 23:58:31 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::e2) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 23:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 23:58:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 18:58:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 18:58:30 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 28 Sep 2022 18:58:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V5 XDMA 0/2] xilinx XDMA driver
Date:   Wed, 28 Sep 2022 16:58:25 -0700
Message-ID: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SJ0PR12MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 879b101d-17f4-447a-9f3e-08daa1ad584c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6CmNDTAmR/9+KaHXqRinl0O8vWkEX0dt1fCGADd44t/dxoC9tk4m2YkAQxIf72bEWCo20x0sx07QjN9ZUk6MOPFHGbN5RBciHkt16tGMk/mPf1rsTHqbb5ftvkrYp2XCnUa+f5o7a4DvLZDMB4qUpsMJN9wAfpx7CUd+r4yMTUiye9xBk4Ej4U/uSwZYylioVAVguy/wAivAHGokaW8AEMa6C02OcXjkGdT91HwDDyNsTrVKm5eLSGdYMMbzL9eeMmWegUKLK4XRpSRd/x7+M9rjok7W5UqEuC+0E5iMWVUELskYP8UMWRC5w+dq6DVTW/YGtQEO/x1vfrFH7I90/sJeI0fDMBd3B0xYPkOIipb7IR4lePbeQiUbWSf5v5dLTznhJzeODZ9vNaXj4RHeo/eDBzfJ/qjxmmGTIc6NKKMeQaKeZ3eKRr36ZAYDLHqSYkY3D4eRy5jt3K7UfaZt4ieS2f0YvzYD99bW72ts/1mF7dyTiSPu2AXqjM0edcerIVf0/dnjpPXP17FKEKZcEsEf1zqDKO9FCrqBVigOGrAjbdnrL1TljoOFlWKxrHRLR53z0ap7GyXfQJrQeNJt/WSqQxDTlq7WB3yCTRuIQsRXNZuu4CQofrPho+C1EYQbHxF3tsLhIOLYg1fvx4YSRr3mvtWUJcI3Etf52KeoIoE2IuL4aSWn4e44511EeuO432GLc+AgX6pF0NP8oJbyuoEPaYaVi/drKZTUpUiTZUQUvWVjpzPgnH0irkONmd52qRnW8QoilhdBKUuj6nuv35KoIp65/AbpwGdmZxgM3cmEUS6UiCON8Kh6tFg0SXr3LKnr5RC9E4P0yqOQUTeIPCXbUETkMUr9sZfzdinqhSEp5NebRlFFOH9lCm8sewm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(54906003)(316002)(70206006)(8676002)(110136005)(478600001)(6666004)(44832011)(8936002)(41300700001)(5660300002)(70586007)(966005)(26005)(40460700003)(2616005)(81166007)(83380400001)(47076005)(82310400005)(186003)(426003)(336012)(356005)(2906002)(36860700001)(36756003)(40480700001)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:58:30.8552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879b101d-17f4-447a-9f3e-08daa1ad584c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V5 of patch series is to provide the platform driver to support the
Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with the
PCI Express IP block to provide high performance data transfer between host
memory and the card's DMA subsystem. It also provides up to 16 user
interrupt wires to user logic that generate interrupts to the host.

            +-------+       +-------+       +-----------+
   PCIe     |       |       |       |       |           |
   Tx/Rx    |       |       |       |  AXI  |           |
 <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
            |       |       |       |       |           |
            +-------+       +-------+       +-----------+

The XDMA has been used for Xilinx Alveo PCIe devices.
And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
    https://www.xilinx.com/products/boards-and-kits/alveo.html
    https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems

The device driver for any FPGA based PCIe device which leverages XDMA can
call the standard dmaengine APIs to discover and use the XDMA subsystem
without duplicating the XDMA driver code in its own driver.

Changes since v4:
- Modified user logic interrupt APIs.

Changes since v3:
- Added one patch to support user logic interrupt.

Changes since v2:
- Removed tasklet.
- Fixed regression bug introduced to V2.
- Test Robot warning.

Changes since v1:
- Moved filling hardware descriptor to xdma_prep_device_sg().
- Changed hardware descriptor enum to "struct xdma_hw_desc".
- Minor changes from code review comments.

Lizhi Hou (2):
  dmaengine: xilinx: xdma: Add xilinx xdma driver
  dmaengine: xilinx: xdma: Add user logic interrupt support

 MAINTAINERS                            |   11 +
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  171 ++++
 drivers/dma/xilinx/xdma.c              | 1020 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1266 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

