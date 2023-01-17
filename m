Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4761670CD2
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 00:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjAQXLV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Jan 2023 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAQXK7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Jan 2023 18:10:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7E683EE;
        Tue, 17 Jan 2023 12:54:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOTtZrd2IeIs3RCz86xXXSXPtT66uIk+i2rsyJ5PufHgOrIRjV05E6Ogulz6An3tfheEoYjbqTqxodWT5SIlq8dp/T62iK7nEhaiyo9sv2N6HBZP7Fvg+w2MLnkyqdDTdvm4jDRjqqvU7uNE+5wct/ASMniByW/tyemTpMiGIik83cCTPJq8SouJlqKZHY1UzvNhO2fKEQMDJCkbcrtjpvpmvlcPv0/YRBeM/mV6heJXvojATYb+7z2s5JJPCTscYaJhmCxMsayuicJhjRyP5Ik/l0YL8WOYwJwTKCoJQpAy0Qc+UwhU1dnyzABRR0Bb9ygVabDFTZ02hTa2YJA8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jvyGBuH2fvAOiqFAE6dALUqHxvX0lHh0TXJhDzIQkY=;
 b=oC9x4DAKFUDQNAcKlnecl1xQrZLbopOr0D9oes0MpbefezEJI2eeRF+qUieIE7tyT7gkk4Fi5dSftuF/6LhtpOmizUKJz0PryJt4CEVumtA6mV5g37yrKDFUC9CskGLSD6761obFutwVmz25wxMMCtdmqftfoHcsz7PEqqTz41NTGQKojmlM3f9W/43P190B0299lEidAXGx5Ypv5DdX2aSRm6deY5yJDTV0REqNaKUq7lz47tghrfiUpYqItfrXFE7ZfK3SZJ4jwV+RLUN5ebwMPCQDR/NUB8tA32frQYRd1I1JP7HGVWwGJIGXe36THf+aQMatv4E/a/CAEQBTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jvyGBuH2fvAOiqFAE6dALUqHxvX0lHh0TXJhDzIQkY=;
 b=W+CJwLCWJ4YMLhX0dxe1EjVGfI0UUCYC3ymp45bgXUAvzlQPZ4Z+0ZSBNKDVgscjcAKGbAgP4Y45yUjgioQyOa+FTAPkhkLPb9Z5T8eArC5MH6BmlY3PBU6rcAfeXetPO78Tu9NdL+tEriCCIk70dfFupz/2JdOXBjOg4AAAc3M=
Received: from DM5PR07CA0060.namprd07.prod.outlook.com (2603:10b6:4:ad::25) by
 CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 20:54:18 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::64) by DM5PR07CA0060.outlook.office365.com
 (2603:10b6:4:ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:54:17 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:54:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 12:54:16 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 14:54:16 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V11 XDMA 0/2] xilinx XDMA driver
Date:   Tue, 17 Jan 2023 12:54:00 -0800
Message-ID: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b271c94-966a-4031-a601-08daf8ccfffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygafrXQjZHmnkh1t+a+y8rAnW3ThI213OPSyx0CsKVPNQ3m304G56pqzpaja1X129+ASzshlLdT0y3PziJdvtWPN5surV46xRuKyrwVy/Qj6m588H3l44NFWfdBUAtVMV+9YXuiiU1Pp0lYizo4ebSE03RxcABTxhW+qFDYTtWXmxf5qBBi9aBYbuO2FDLeGnARzygcc/QKZW18MoXpTvRNA69yA0tpoExTksaSUsSy35p3okWJC0pqp0EyKXLDKNkFFVktBsRuc5ekmkiHQXIkdaw48QPaT3tzENj4HXnsUmeREY8kZg28axV/6soTDHcqpDgoIGhAygxiGaqGZLzsV5WoKXsJRppaOjedq22sInePtEP2NLfkPF/wtPKzJM5/hrSGRmMnDs30HN/G5HvVHEeB3YlHV2bwhPwa9Ycw7Hm78OA9BpabWzuW1Bdg9w42qNlPFRBv8ROlGbndoU5fO76jFF42JNmylas2JisWEr8/zope1kiK/2yz/76e+YiGygdac9do3XoTBJCqceD35RQKXsosnLRDCktiqgM2x31s9MoTLdiQiWXZbQ1iAc5hyYoQanx58Jhih3r3XN4RxGN9b2H1FYmoWBxRsrOibxf9I2GJPflAJGqq/05+E31uxQoMr0HhzTyDWCtIyz5zGYkHqE/alLE3uOloyz2VNEPlfmsT0hrFiC/GSJaFpC1r+Rg/3sgsBS75EBeBzpeYpDH2bPWTlik08ssLI2o4Ffxoh9mOjTiaBZYjRxgYMI60PQ5a5dVkF0jRVq4ekWcO7JtZiDOAvK12a1vnOmUbhIPmYQuQgwPXddu2ItL8b
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(36860700001)(83380400001)(356005)(86362001)(2906002)(5660300002)(44832011)(8676002)(8936002)(70206006)(70586007)(4326008)(41300700001)(2616005)(40480700001)(82310400005)(186003)(26005)(47076005)(336012)(110136005)(40460700003)(426003)(966005)(316002)(6666004)(478600001)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:54:17.7329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b271c94-966a-4031-a601-08daf8ccfffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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

This V11 of patch series is to provide the platform driver to support the
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

Changes since v10:
- Added Tested-by Martin Tuma tumic@gpxsee.org

Changes since v9:
- Cleanup code based on review comments.

Changes since v8:
- Fixed test robot failure on s390.

Changes since v7:
- Used pci device pointer for dma_pool_create().

Changes since v6:
- Fixed descriptor filling bug.

Changes since v5:
- Modified user logic interrupt APIs to handle user logic IP which does not
  have its own register to enable/disable interrupt.
- Clean up code based on review comments.

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
 drivers/dma/Kconfig                    |   14 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  173 ++++
 drivers/dma/xilinx/xdma.c              | 1004 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1253 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

