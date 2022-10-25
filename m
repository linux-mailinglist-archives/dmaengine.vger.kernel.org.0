Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B560D2DA
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 19:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiJYR5s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiJYR5r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 13:57:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C2F682B;
        Tue, 25 Oct 2022 10:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Q63nDBHRZz6/JdWaVQ3slT1yzIxOShKxh8Ca9P6OVmEZ+aXtGDVIAY43JEDMMzPVvY78C/sHWGq4/HtKMLdxsLumhSId4+PEElF8NYe8jJsm2rlDqHM3zFLwIMiLYKZfI0in/D2QJD0HPBwcUslRQ5jK/+lxwkzLmOLInCFggAxNiZ4J6/rIR+nd4J9YoiO3xefSYW4f/W8gKYxL7oucDS/SaCmS/OPmyPXBGJNN/aS2Mte0Ye0MUDe+FpuvCkDBEcYplrTwgZw59mqXjHqZsN7HJzaTsR6YlFTa3oeEPyy6yhFjpNpVyJHSAAKkNSm4EruKDS6CnAQmXVU0YXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApwWTx3nhzVYclFq+7VTHG1+uXahEaBPAGkoiSnFhPA=;
 b=YhH0ECDXaA+R3k2ppBaukQbfvAB2K9A2+2TFqEnvXy1oOVBtWPz62E+922/F8rt9dohVBy5JZckAX96gFWr/zrJcdMq99X+3pqE25geEV1/n45HbIheFbxoxue8w1+FhOTQ8iTkKhPAqLb3TWh/S1JO/URdMls5mjO5aPwsHbVQA8zC2PTviU+4SH04pFDP+BFXsd8g5jRAYQHCdYrB5PMlvPM3+MXCYmQqqOxvwqp4ASGvKiXKQLTQ6eDdeYvsIZd2o7F64TStBVednDBnD2RoaqQSyf1EPgwyS0jLE2U9FPGg8rKP3e8zElacZ3VcJ4qm8fqeWhNHof0YjCP0pTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApwWTx3nhzVYclFq+7VTHG1+uXahEaBPAGkoiSnFhPA=;
 b=saLPN5Cu6RbC+Hs6PDlaqorvvRyHSrWJ6sWkBnqg350hG/FTRKNdIPh9NdKGNf99DqinoqBJcXIk8gOPczAXs1ykfgJRDb09/F1sF/TYO9PitMfZEMQHmCAoBIxW+4ELiYWM+q38DhuiEWteR4ASFwylg48IOHbhrWAAswj080w=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 25 Oct
 2022 17:57:44 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::50) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 17:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 17:57:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:57:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 10:57:43 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 12:57:42 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V9 XDMA 0/2] xilinx XDMA driver
Date:   Tue, 25 Oct 2022 10:57:16 -0700
Message-ID: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 6feb4a5c-6063-4ec9-65f2-08dab6b26adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og0u5Zyf/uj/5lZgJvVwtVtgPRX0GRrHxUvy30cmi9sBs5JhyHw1T6ASxb9iWD1WE9VKlGxqAbwEvawMeTUPZYd0oPvwo/eJNUm6yDabcLAqMwh5Z9tufXKRSNn/se+hT2FpZe9X8OuKMwI9+8XLxcVOKckcVZ6g4dtrmmYEi3jI1jn0A+Tp4uNi/TsFEzBSfTpOr6Ca3YKz+4O30T18dVEQzVQIPTRTjCzvqJ1cnSYXNAzsuFOH0hIw89Z4H2mYxUmEDHtqznUio4fPgWmxEeGgAmy0WJnlQGPVJjr2azIZGdPPvy1o9iIx7XcjSAPfzA3ngoaBWJDCAFHsSYEBj+VHrVSOEF9T5ebhlqzkblegYvmGA/xFhV77LX1bo26X9DR3oGMJu6SABsfKEmAuddBicpHxg0TEfabuVtKnqFhdhiOPd4i9+RM6THsJKZq58IH6DN4zR+LJmFme4K5ZCArDq9fuU07n0FzUIhxd96RNouMRjEhVqXBAHym0qj7E2IANNX0qZn60n78NKJZ2YonWXaAIfQCZCQLWCslpsS6wqvxaGx3GsgaH/8xKx55oaBiDa9V2v8t7V6c2PWW6iEZtneI1v827V8ujZYfUKGWONwq+YnqCBCG6e5/tNRpFH813kXqKOV6nW4UwVzPc7Do+oPBdO+TOH164kg+lpQpvkEg6iImyLv8EpNdIp2ff4UZC9IxW+Jiy4jVQw4zP2DYAFOt7L+5Ic+LuwJR8k0/rL5AHB8e0t1CJv4Qx7B/zJHksX24MzoDnSWsWSgEvCejKkbyOMWpnNWXM/wdQEIKinAT8LJtwb/aPh1uwoZ/z/FQg09zfI8Ldq+Zns1CQ+Gk0e6RRqxz6S6KzK4xOICsVG7HtIRVkCaqZs128662t
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(186003)(47076005)(2906002)(5660300002)(40460700003)(6666004)(44832011)(2616005)(40480700001)(83380400001)(336012)(26005)(70586007)(426003)(966005)(110136005)(478600001)(8936002)(4326008)(316002)(82310400005)(36756003)(36860700001)(70206006)(54906003)(8676002)(41300700001)(86362001)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 17:57:43.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feb4a5c-6063-4ec9-65f2-08dab6b26adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V9 of patch series is to provide the platform driver to support the
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
 drivers/dma/xilinx/xdma-regs.h         |  171 ++++
 drivers/dma/xilinx/xdma.c              | 1041 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1288 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

