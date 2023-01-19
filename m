Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF460673EE6
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 17:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjASQcj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Jan 2023 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjASQca (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Jan 2023 11:32:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA114DE3C;
        Thu, 19 Jan 2023 08:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDQL74nA0SFhr6vFq5Z7ubZXBN2Y1jMgO8aDoitMQzxIQg10EEURkBb9wTAG3ldbcxxeAzzgG4ggaonmLtmX4riy80HDKGXLCNSwrJ0XlQ49S78QLq/L5qNELKNLhdn8LD93oLRUAh0giLnVQN8ZTUvjejjyADS4nbZ9VPvmrTyCMgkTWk2q+Iw6pxlExaST0BFLOWPeHYC6GrmLONmL6Lz3VVKsJ7mIGVy/wZq0ItZ2qWy9WwgywxSEMP7AMSdEJZQdm8bJoWIpbqHteTd3hcMPVV9XW1/N25I6FgBw4IR5GB4R4iY7ctJmLKLptMUsphKV+FPddORT8t2WRnOf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=IbxdFZNDm5UBFQ9QePhaeutBIOBmr/3lb0pxVEDOTccAyuDJ+0YdKzTLpurAeSw0r4PX/cukF2e/FwXzXgy4GdrtNCXYjd6KoA3TM2sklJ6FLTgH9bHZA5wLYPyoYM8wrrzPYClMpQJYpKyGCAn5T65akNui+TOTAAbylsTv8xq0jR9aEzaSZhali2EnEhQ04ebh9rV8mSf92ZyQ2zH90+XKNx5O8/rX8pIuk7gJLWBPYvgKhmRlJyKzDVW5CqA132F76BQSDcP0M3xAEbZYdkJZSoCGRPWrToFOurMmTz3T/Ifua0zJ66OClRsX1JzqY2iN2bQ0VqcnUNR6jBfWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=jqPQU0p6xatDbkFG4uXHJiTFHX4s2gKgFuZQhauPiFy4THRt1bVgRkcyKcCLtrqs5qsx+xyPaAWrswIWpJJrPJT+G9D0o0unaWxTsKo3ETGPwICgu/a2AiDLLJ3zFKWPtOjToTaBIah0Y+N791rc6Hr1ApkFF6+bUFvJPf3xx/s=
Received: from BN9PR03CA0951.namprd03.prod.outlook.com (2603:10b6:408:108::26)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 16:32:21 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::e5) by BN9PR03CA0951.outlook.office365.com
 (2603:10b6:408:108::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 16:32:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 10:32:20 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Jan 2023 10:32:19 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V12 XDMA 0/2] xilinx XDMA driver
Date:   Thu, 19 Jan 2023 08:32:04 -0800
Message-ID: <1674145926-29449-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 34699e29-e7f0-48cb-1976-08dafa3abcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McietNT95xfiKpOKXC6l/4HL7W4ZZ4b4wd2Zndwq7A7bSnNXJ6xnHvpiWlIjmettWCrfbSOLwSKpxrU+NrX49+r4oGLoha/uj77svZ4+q+U8me+ANqSd98ClCorP+YTi6ceD4C743jwx8qPUlmap4FPX5yqwrhQihfHPAjOhN6k2iQA/0jL3wYycbeIiau+Zn4rFADWdFFHsKcVbWvVZbA4DVHjWiY2gekqBeyzDqG6oi6mHCt4NZIIbAw+YMv8yvHZ2WlxgFbBw782ktk5p722hhXsDYqCzhazWmwa83Bhp3ipUcJWfVrH753tCY3JOd2yWvte2BqUQqobgUX/NBGkySBBp/edfz9lOORP/57RXuemx3GF5M04DW5nDeRmerMDmFEgoIwOfgMhVR7H49N9+mdq5rPGTU91DZtT1I2EAEViqXtdqgT8/TIVKZtLsv2OR7/HMgIreOmKVQrKYyq7nibDWq2EM4kDt7n6NBZUVrobeowSCc5oNZk5AmyWqV/JHeorJ+9kJVsGbcjt2tKaZCElsfc5VvRMdd5ZYuE4MuysbzDyk3qIWAp+n2oNXT1xrHYq8qaaodDIVyA+aaTjEMdmadJURYZ86MGfcLBWJ+5zMIr4h0q3zbBkVzseiJ4TSyrYcUjxa0qNRMZmi0tUxxhRxczAPZ0tWWnqhIP45zZvSX8bAUsiCoWuTk5UD/9ZYwyXxHGr8Ak9fbWHMbgVvQjTNEoaMl2oQPrJRdu6UDT/B2nmJm0H8Gn5e9TG2zMz0WSShCyNMz0ILsUh9bt6SP1v0HFjgDTh4aAg58lEJQ9Qfy5WfXPnxaVR8W5Ox
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(83380400001)(81166007)(5660300002)(356005)(2906002)(86362001)(8676002)(8936002)(4326008)(70206006)(70586007)(44832011)(82310400005)(40480700001)(426003)(478600001)(2616005)(47076005)(26005)(186003)(336012)(316002)(54906003)(110136005)(40460700003)(41300700001)(966005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:32:20.8679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34699e29-e7f0-48cb-1976-08dafa3abcd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

This V12 of patch series is to provide the platform driver to support the
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

Changes since v11:
- minor fixes based on review comments.

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

 MAINTAINERS                            |  11 +
 drivers/dma/Kconfig                    |  14 +
 drivers/dma/xilinx/Makefile            |   1 +
 drivers/dma/xilinx/xdma-regs.h         | 166 +++++
 drivers/dma/xilinx/xdma.c              | 974 +++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |  16 +
 include/linux/platform_data/amd_xdma.h |  34 +
 7 files changed, 1216 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

