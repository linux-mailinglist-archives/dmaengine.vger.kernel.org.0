Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E76910E8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Feb 2023 20:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBITFX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 14:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBITFW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 14:05:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5E5ACE2;
        Thu,  9 Feb 2023 11:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INFLSDa43xPEPA+l+dwD6wE6d7jpYfOxsm88LxYUl69gtGcOy7Wmb8uHvzmi3W/THNhxyYijXgzHb1BC1rU9m/QAbktWZFfmcoiclAXvVsKuJ3C3SjOrRN0yQcX8BJ9LBh743X5YrLmxqyoaK2y6Uo668kUH5Ow3dhUU3rzHJzbISXDmaL3zwOH934Dge6N3k6hRhYSWffnCVbERR6MNTjmtQ9Q0OUk6ps03qjiRC73pYpvBq5Whf3+GnNt7p2etSm1/sDpO8YYGkTCEE4/D0s6CkZjV+FR3yVZ4W2pNk/Vkp3WZovYwfWsiNUXznSjOf6EsNApKPuwQ7XYIzBaofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=LOkn1InMiHBwRFa2gg/rG2J3Um/wkJhEaePvX+XeXEnf2MunD+PPvxTyouDB0/F/i5Gl2NHvXuPrduVvsHzj55gxosXvK1wRcALwlOYARGau0+68Iq+DqQoFazoKEo8Ymt7EZUw9dWcjLlc76aBdGkP1pxfLqYTZjN1DS3tSvXaU+6GacF6jXOEOmPE0ctLKRfPEcU0od+doKV5d29Us49d6/ZS6l7CcNLwAjDc9SQsDytZ2DLV5f7YD1NTkrtaqZ6ZJiSpliO0o6ycR+IPqfCbjsWFxOZJgS7lbA3rYDh7fuw2vlsHzOG9TEniowAZ6biBNDB0Mtmk+TQ5JFb8RPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=1YQaph6g5jWCEuE2TB25CmsB7i+TuHTWyJA70nXVtTmpKpdxG076C03UvS2JhsPST+/O9iyQiHa0ECGZoyIth0p3/Ua3tnDnfQq4WYqNBw72kAvpOUZS1smNT6G1ZGAmL5sXPlYcuUieYPRane1cJE05+uxQU6KPr/5Vc5KHcc4=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 19:05:19 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::e3) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 19:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 19:05:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 13:05:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 11:05:17 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 9 Feb 2023 13:05:16 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V12 XDMA 0/2] xilinx XDMA driver
Date:   Thu, 9 Feb 2023 11:05:12 -0800
Message-ID: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5955eac0-82ac-4529-6e01-08db0ad0961a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU9ijCivJ35kflJqlJaIS111+y4gXSYAOSnVXgXqms+Ahp2Q7xAJjKQvhyWD7X92JicguZOjamgnkodg8aYFVb7z4IdeSbbrTSbctdLjXbNeOEQPq/pbaPucVaLmWpHp7cCv+uryRf747rJuMeQ/P5GB1K8fVPhyewtLGQlBUwza9floIBggGn8UjJnEPmjo9idhDzV3cPKlOqlx6XyUGIU+TwRG3rFgvtz7d4f1DgF17xvN0CdfsrmBOtpPg2b5JNoStes8CT5il7J5OwVuHlQGSj/EUbsr0KYQajdHWBoz8W4VWS47p19OfQ9+4NqWYgkpi0ZrprRgi7FxaD5WZLTvmxa8FXR8BWSifwV+wQ5FCdjjL3ihNHhV4sD+KdbWT2u5wT2zHaNpx4HwbeZiOe57pxE0p9GlzK3hC6BrEmEn9sjr5JCqPZdCEoZHRLvIflIb0RHWeG9p/VzpEZG25sCthm6y7xI9uk0OCs/azibPRwdD12f2cF1GSiOhWGHT3JZHGHmDGB/Y0JT4KZgN2vhyQpNVyer9qLxQC3gZgYdHPB3gGVYZLYERI7pjz5K5PXls531/MtMC/MS6Nm3w9Mmjp0PSHEN9ea9cpRR5rg5nAM3ndSCDC6wuRVp2cQ4e2SCz/Sap9X72jRiM0lQrPi97csr27yoLunNMlzDBI9ffiFfYorj/mEyhr7sXqjZJAh+aoFa5OVLvaQkPhCmcyya8aKTGblwrT00oiGdixPZapqIowfPO1knzIwIYcHBRahzjzKsNJSH7Z6nL1fdw4ATtwQ3mgT8qb56SMKc0l4Xr/Jr7FemevoTIXZTOvhGL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(478600001)(966005)(40480700001)(36756003)(82310400005)(82740400003)(316002)(356005)(81166007)(86362001)(5660300002)(8936002)(110136005)(54906003)(26005)(186003)(83380400001)(36860700001)(8676002)(2616005)(336012)(44832011)(4326008)(426003)(47076005)(70206006)(6666004)(70586007)(40460700003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:05:18.9440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5955eac0-82ac-4529-6e01-08db0ad0961a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

