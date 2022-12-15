Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A164DFB0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLORcw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Dec 2022 12:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLORcu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Dec 2022 12:32:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7876BDF27;
        Thu, 15 Dec 2022 09:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA0UACVk02UHbXgm8kvvCFx0Yr9lf0Antt1DCXB4xYQU7jS8mQYbixReIBMOKW9c5WEmEA6xs4AEzbTT/SAt+P+BVnoCP41jiCBRo9MEHEEieNnSgxUrlxx6a+candnvI5WHB4XZAefw1l1n78b8texrDPzKx9ZhvQhbio0Uq/Gx1KcXerVpyQXKiG1X+sNWZivlip4Ng1Dp9VhxzaCSqabihXXQOHr3rSKsr5g6vWnAUiEsRahBZPcHYNuCI++czUQNOOhlwJRciCm77pSauahd7/7VYrQmI8w7XQGmyiXRo281KHL2NM4G4ukAf1I11UEu/ROmteUx1pGj7IfMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOfYKO5Mptaap7zkC6m1fti+nZESZ8nqYJcEWicd+ME=;
 b=ViUWeWUrpW5YKHdjw3o8+StBop6yZgHW5zoTOylg2I41jD/PoKc+RHwRiX87QktC2Ggb7mpIMwLCd9IR7m46CzVHW3yQcuyz3StwsqZmaKBsz84eHSm7B4gyERnZAAxBmPgOfAX0QvxqAyJDXVNEw3oAa+MoWGeItDRTLtGGiCgVl1lAzEtrpta/6LP5p0+51sHAKdA72DDmFEuzDonDaxz54hRMOnGGBmxnZ6C9oKamtEDl4GjvLNL0+FB7qu4hQRG4IdsTJ0z17/Y01+qMj0l8V6lwFbJ2FdcI46azquwrmCo3Shu1xU8LNOJS/YASg3UsBE1gQaL9XtLoezNZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOfYKO5Mptaap7zkC6m1fti+nZESZ8nqYJcEWicd+ME=;
 b=Ts8isMLohIlXhaA4uwYq7ONCDJU7oWRU2sNdW9o1R/fUlpgJjMRTOs1SQalTcC1Eo66UvUz2cs+VmfVlJo9alGNuA5QBE/uxEif5TfRonJ+v5AvHW1AiyJUBFJY2z3ASIXdxDKafRGCRe3fEN6YsPr02r0LzL2qXoTnMN8Ojrwo=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:32:46 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::88) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 17:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 17:32:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:32:45 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 15 Dec 2022 11:32:45 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V11 XDMA 0/2] xilinx XDMA driver
Date:   Thu, 15 Dec 2022 09:32:31 -0800
Message-ID: <1671125553-57707-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c179ec-bac9-470e-3c6f-08dadec26159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npXM47ZHp2lFr/d3IIlFg2Xf0lv05Sv5uAVaVbK/fpakRX7FS3ptwK8xANMF7NdF8s6Frc2cfP+X3PXRjRy2wywpiq92WHrHD+Ahu7XJeccJ/pCCJ3Z0er3ygPrVge3yhIGgwVEOkNN3HZLNQS+9NG1LiWRWG5/U4jJAGek5VPGOnq+P+CPAORkBkm5dFJNxOL290t05rrMB9lZjRSCPVVwL72AL+EGQwzdEZwhMYYNyfMjxhvUN49NZI+LI0/nWkLsyQZtCh+kgSeR6HrOzv62joz0bO2B3fZSemvDhaZYVdJ2GHoBSODG4EFiOwZnt+L5FctcVKOdl84YvpzdRgkfKH2Y7mbyIScE2qEtcb+reuot93jtt/esVRA+vN2zn74D4xuNsSOsEF7xOJ4tKEB/vvUtt/jPKaxKQd/llDSNFApz1KqxIodS03jjYLoSswSi2CN4m3SSpNiA7KKzStViToQUyjjhxsrvMiYs7wDD0WgOxwnlEUYpyHm0qrfDs0jRWy9kD3mjPvRIuS3NOewrSd4o8OtyrQRbZ//IWMypQrGiWgqH8Or8qJykR0cz9uyAhq1kca8DP4bducTqmvHwdE50/42nGixqFMrMt5XMCTpl+EJG2Pa0ygHBzWSF9U4s90RHkCsGA6dVMOWf/rk02X566H+mAIjMjAj7ZuULOF0kv4/inditPyss5/dOI+Rpn2fYagRFQlgYqJXlRsriQ0QhvVGVOJSltpBm9LsKHda34TczociUK2IgWBJcC+a7CoC5aoV+gXf/ViEe2qzX1aV7gN1O02ubeTgp8uYAjbY76Sa8PPmO5vZmUyjRt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(36756003)(4326008)(8676002)(70206006)(70586007)(316002)(336012)(54906003)(2616005)(81166007)(82740400003)(47076005)(426003)(2906002)(83380400001)(36860700001)(40460700003)(82310400005)(26005)(110136005)(186003)(966005)(478600001)(40480700001)(356005)(6666004)(41300700001)(5660300002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:32:46.4137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c179ec-bac9-470e-3c6f-08dadec26159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

