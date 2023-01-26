Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828D67D526
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 20:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAZTNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Jan 2023 14:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZTND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Jan 2023 14:13:03 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7B6185;
        Thu, 26 Jan 2023 11:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjGywRzj8FiVm9wei3Izzjy7rANJA3hN4YZE+P48/RgtnTDZlaRwuzv0gDKRtLlku7DtrFIgxQhQbUB6weF9EjWuPj3e6UNsx2Nv6yOY+C8iJRH0G023hkeUmsAK3l9aY/h/9XSSi2+RxzvGc6kDVCurYBCdqDTmueTLYpRyG8WxQah/Tb5fBUt8+NLRWfW1c0RmRiVW8lUMWYRAwZIQ7wog7ztHM2ADNBbi25Mq1GxmLOczqTltf6LBIEy2Po4Z+j8KbMSj5W3r537NyDNoVtbrdMIts066INkwb469+EoXc/yZSzIX9cFtrI9O0k4CboykROR33BWtuEPXye5DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=bcCUwIpizZLfGhc33BlbijqceRvmz43Sk2fU4fqsZ4qJMqdMmHJrdoY40iuD9m+1uP4mzPuBwFC2mGnUf5KF3RHOFi6YQ/eTGmSCN+4fPbK0JDiKxnl89Il6wwn52hIGmweli0qpk+EWkxOUdeobhtXcZFkfmMDQtAvvFigAK0KvVKw5vj0giEVX0XyMY6xUOUQbVA6pw5+nVq3E5p9hB4K+/eZ0rbo1l0loqc/u93fKXaciCQlTg9pejFoFjdOGPRg1kcJIqyrMKWCntcQT1UQnB89FoWXjsVdMTBssXKS35tgL2fgti/htnhHwLCaSFsj3a1aVSM+GUtjn7jQBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=U+hLuPaP6SJZDaHOMLyFgQ/x7wGCUO6RTPRE0FKh8pCh6Hhg5zowVJXv9+3ubfwT4SLibja0szgR0mBR7q7EhCsgroKE4LrkQqS9SgIqLBoXO0SuOeALOi9h0AoGWK/RWDGRK3KZFKF4UFzOAszin5afrVt7LC9o8N5nV7aqL38=
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 19:12:58 +0000
Received: from DS1PEPF0000E642.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::61) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Thu, 26 Jan 2023 19:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E642.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Thu, 26 Jan 2023 19:12:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 13:12:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 11:12:57 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 13:12:56 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V12 XDMA 0/2] xilinx XDMA driver
Date:   Thu, 26 Jan 2023 11:12:53 -0800
Message-ID: <1674760375-72911-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E642:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ef6080-7739-4b28-18d0-08daffd1560c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB0hibKWxO9bupJsLhC8uxT0eylYcbXmdrUOBK77rQPMhMD4Yurd19H/MRJtF2rv9vxzbIBBlU5/dDPutHvZDB4h1ZrUgktLHhuQlUFv6vdl9ICXsIVIDHwiZjIbMNVr/zc8fwXyCCFshyIU3fovIAIuUeRa+BhX+YxJRR696bCw8ZonrUy6V3SRexbJdW3agDcfo4oR8s3+VlBNqiIrmbXnXV5afBQfXTaEncflNSUQq5HROiCLmebUxfRYZ34IMgupIzU9HoPaaVLUc4j5bvTlx3bOMx1NhKGc+BsGCYeYLsgMskfbo3O6+u8MkeuMZkHz9VVyXKBYUI0+G5W/WyO2ojn5RI59Zq6h/D0HDskD8olGSyIRnsvQBVDUSiPBD3Uxn7scghW6ODPprtkpci4Uzho18sRCwuJbpaj42fT4qLW/FXk9x0DyrRDnBO54Axts5nwv3m80zW6N2+DbmQSZ+dIyhl6tVVAUhOfqbdbs2s/BlIHOPtLKaDOjwMAiO+uuz0qPWi/nHos9Z0/X/zi7ArV9ScMAAX8B+es365RJrGaLCxJMQw6lzSGUUzHd/o1muGXNia02DdNBqDDxLFsVfAZF675bSEIt8vJ0fEw4w8dWxTp2+tUIzerWEPUeskI5obja4PdF2nfddqh7m+dTugeZxl+S0yw/HqeT7xw/eBK9sCKGTepBAc427vQdVjP/T4NPhL+HUJl/qGVoB+CAG3oSLPFsPZo5bGClOKukDcjcOYgHZXOaBxFOYy70qk34/5ROAHvySS9i0KncTCCcTZPhR1F3Mgv9epFOyIyy1Au0NftYL9ougUBdGO6X
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(6666004)(54906003)(110136005)(41300700001)(81166007)(356005)(70206006)(8676002)(40480700001)(4326008)(70586007)(40460700003)(5660300002)(86362001)(44832011)(8936002)(36756003)(2906002)(36860700001)(82740400003)(316002)(186003)(26005)(966005)(478600001)(426003)(83380400001)(47076005)(82310400005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:12:58.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ef6080-7739-4b28-18d0-08daffd1560c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E642.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

