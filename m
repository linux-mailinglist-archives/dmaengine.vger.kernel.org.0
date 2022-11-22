Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45B63425E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Nov 2022 18:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiKVRWF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Nov 2022 12:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiKVRV5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Nov 2022 12:21:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3B79915;
        Tue, 22 Nov 2022 09:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX747cmnUXv7mN5VpoRfaTvD4RKu5QmWNV2YniJEyrgBtqNnxi8vjtmKy++/Ij8kCRPFknGMtoq3FIaTQEFBEEl3+5GAGhwtzJG+bM7QhGCHrwZsQ5RrrVv2gXDr4dr0Vmhh1Upx2PgEOCIZPXrUNi197Bvz3xQacpIshBY4UJbxtGCSImb8bG6T6Wq/MMsuDCT1sakSWUkIp/6J/AxM1539VQ6vDe1l0vFL9LAYEnxmjYlwFOflUAOwbF2C//oedUv2PK4mNjzDMtcCs+ZVn2iBzUvEwIuevY3errOCIGS7++/V73ljcxV7m9F6VENQuK9YUfP8d1NyTr9hLgFkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=IEJ2UvEDfUc4jAFsddtQB2XdhLLTnpEcPbHxe+YP1iCCNptzoXy/s4lYFw42SsyMqFc5ICoRniDXveuJQr2ZyM9p9ujorlGI9Jz2hTWI7YbLtZYgtu85H1Tcw4m6U/u5vVAz14i0ZVsEkzPNzvC9mMFV+NY/baA5I/pButwsiw5RoVg6sXpXCIpXFEkkRQtY4bdhucAEJdf1rO0zJmVnoIhu/VqrDdhEUVvm9B2b5S0EWyfI9wmgNHrLTfu2cgnPlzAB7NB/Gw4Fo9twd7vv1johZyaySyU66wcr+yF0ZFS7fNHp2Sx+OziPiivvHnOSwWRxvL8EouY9NQJN1EEfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=VAsSL+P2HUnuxF/4uOel0DxmSFHHOAwo/SeUeybiWOJCl4B9scMTn9hLf5NonoZZZumgXa0WkuL6+Ur6Ad6VwCyeJgj5i4u+2iQX11ce6OFF3oQ26GJaYJRNkXZmvnY7/2HEtHe0TJyEEASSSmx9V5iR5NYTzT1CjQlNl3BRzUY=
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:21:53 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::60) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 17:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 17:21:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 22 Nov
 2022 11:21:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 22 Nov
 2022 11:21:52 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 22 Nov 2022 11:21:51 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V10 XDMA 0/2] xilinx XDMA driver
Date:   Tue, 22 Nov 2022 09:21:47 -0800
Message-ID: <1669137709-22028-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|BL1PR12MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbfd1f1-5a39-4d83-1dc4-08daccae0c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMWI78KuHE6mSyQHHnUMLnOfmfUg6eGxSiTloXlT5Y51l65VQjAjSc7OL2UcyEISb0FE8lLchaxSdCaCZl1uVJNa9D8hUvjxyqPPwcKcabMNwjm5lxd8M4BdZTKnVHy2cSg7SUdOy97CNf6kPrZQFOu9ifoHESo4yRYgP5aX13cymW3FtLNef/55CSIBNqUTNn1I2rKPuc/DyIgioZDEPAMEu4T/2gbbUvVE1Lpre+tqrrU75F3SS2Z39DFDJk/VNZFZUBWOZZtiGs96hTCnpAxOyBI67JPdtw+Q9AeXZIvzzP+ZxMsxytC+06nvivnIn9xeXwlSJ/4IKtxCFPH3phn9aIZVQrUrBXOOmU5io1FTx1Z2w8AU2HgNOZC/9IHuYYOElW2E1et0YWU0R3kcpZHTSwL56JAbYV9ZEJlocme/dW3pgQBJUkVxCLIIQ0lcgnkzaEAUJcQ0RohDjyTtbDUhw3oiunB6LKGH0J/5ZHmLbtEbWvveQ+4v1AmeeKSzrtobMxvcKw+Eehh52ArpD1LA9/Mm3ReuIRqkKYQgUXMZFZbM8T3K0sqPGPtClAaxhFD2Onc7chIqVKwjMaGvs7ky1gslZGmX7xhHVf3swwgbKxtpI97nGu/9yTwiy5qQwYAepKKzY530SCSMWQmz3uh87/k6fzZhsWj88Xbnxcz2fCeVNNLOcgWSp1+IdsSZy8HxCYsxqwslPtt6mN2oZFBRD1LOqWCscmt39ZPVCacZLV6nhrkn5eDMvOwcKMTFtTsthqjpYOeTo7oF9hETb8qnN+PcQdG0xbQq/M39RLRYXldy4DBixHWfx/16wJdA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(5660300002)(336012)(86362001)(40460700003)(36756003)(8936002)(2616005)(186003)(44832011)(316002)(47076005)(2906002)(54906003)(6666004)(70586007)(4326008)(8676002)(70206006)(110136005)(26005)(356005)(41300700001)(478600001)(426003)(82740400003)(81166007)(82310400005)(966005)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:21:53.1663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbfd1f1-5a39-4d83-1dc4-08daccae0c80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
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

This V10 of patch series is to provide the platform driver to support the
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

