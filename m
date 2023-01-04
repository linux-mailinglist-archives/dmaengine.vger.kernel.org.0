Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B865DA30
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjADQmU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 11:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjADQlw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 11:41:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0961C131;
        Wed,  4 Jan 2023 08:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1EFUS+drSRcRYgNhzCQoh5jPwLGtaw3xDgZRwPtWxkXx7SdWNCrH7lCkEuN7i/50P/yH89HYKeo7vU7wkIxys5WHVcjgxBw/08U+evYQ5tWpUfEJvIY/KWuozfRTPxusxCnfaLvYnOroQEahsbpP1zalVmT+4/89wsefs1oN3Jmv1giobqSV1vpUfuILFfyuqH1Fkjc/RdsdjHLgLsLzCDrlLcdCq7t4+mwpKzFr5Gw+E4jHNrGEKxF1w4ozB0BoRdkTY5c2YsPKp20uNKA1ooBCwTtRCFABQKDSmQ8N5+d7G2P5Z3omISSRSvaBN/hDzot+H7/S+pkD+CR+rZW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jvyGBuH2fvAOiqFAE6dALUqHxvX0lHh0TXJhDzIQkY=;
 b=LmJYaJCLOm7WZ/h8HfwNTdKCKddFcMBc/Giug8DMtRJ2X0ixDZB98fvxofxEa09pOBWcmXA+Q199AYnvTPKz6hujsUzjYWhs9MCx3BgeRXABcXT/j6Yj79aSb4RcNr51guh/ccX90M4WeystCZli/A+ZjeD6vlHGevD1ncLzq8dO7ogA6td3Zvv0xmg5Z4AM/D8K4HaXnV/IO903wa6a7UBl9Aj8T8UhTMK9cuFuNhnfhx3KihdAqsMfdPrjyaWytGPARWQORZamBS3VoFMNvLh1cgXo+H0fWO01Kn1s/vfjYbNh4cxBOMQhH9swW0FM3qqM4M5VgcDGIbZyeBGkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jvyGBuH2fvAOiqFAE6dALUqHxvX0lHh0TXJhDzIQkY=;
 b=EhJwNp7UuZB+M3Jh1ph+gffVdL92DMhfiOWWvpC/ifpvc/yfpkYKwpA6BWxb4pMFqVKUvfaiwj7+hr6xjtuoK6LQKcWXHn3Zyt2+qpePyJlGrxii6LcUO+KZjnGvoB4wTypLGftH9kzx4AOpBG4/Ft0treChND1g+v0zPA4kWwY=
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:41:47 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::6d) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 16:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 4 Jan 2023 16:41:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 10:41:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 10:41:17 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 4 Jan 2023 10:41:16 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V11 XDMA 0/2] xilinx XDMA driver
Date:   Wed, 4 Jan 2023 08:40:39 -0800
Message-ID: <1672850441-51944-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 547290d7-78f7-4bc1-d0ca-08daee729243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9IMNVsW5eVZbpDi7R8/EIUeCsx2p2D4QW2s249zzNkW0uwjeFx398Ue3BEsmg8OLfIZEjDNjcqlyl7sm5Li6xtvk+kAjSwCKdP3k6DsI0tifNuVahV0m04usGYVXh4y28I1MZOE1O5F07MyKIl2h/LtfT/gPfVxiV+iP9BZ3f52zdUhhEy0NXRniH7kYFSS790Yx0cJesEm3ktc2hmc+ana0Fnp2Sji5SywtZZwH4tya8xFq0BP70G5XXE2o/4ZOidHFxrVydazJBSIxwkG+PDPiHoLxY8vnjcZANTq82cAger3AnWMajKZGP9jx759N+55JuEjJHDDdGOXcXGu3NDTrD2+GQIA3JWeqmpoT7dPzhVLLITXcRU5BowitYzYxzN9XK9ok4hYoeXcC/V2//n2N90zramRfB4axIuzKaq1fBm5fZknkAATES1AYBjPMgzNS+iahXdvz81akSJHy0pTVgYZrggj1fZp1rzVbI1Q8/eZ0u9E0UAU/C+X1cD11xyiO7Eub8CtwXPv+vq9h78AId9lgqSX/xd48iisRCRRFTROOMLh3ZrgSnYqptnX2Uzf0KTLDEMUFa1ROnqPKGlwFDxdE1fDo9OeSDyYr6kxN/xcpoTEr1JcBz0JB556q95DGDDwOGKnSOQj2XOvs+u2ycqpOfajxSZGw4gBB4ELCNJp8rbwWoNZD8BfHKs/Y1WcASgEWeSPoDG/C6UovWslEOM/VHAYbByZwP97gKFa5LOZb3/10WG/JTaDla0uyD/kbtTnzM7Na4BsnQqLpF4x5Vfa1ladXggV8FHI/byzAnBxDnTm+dHlPs0iMOc7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(8676002)(70206006)(70586007)(54906003)(2906002)(44832011)(5660300002)(110136005)(8936002)(4326008)(26005)(478600001)(966005)(186003)(6666004)(2616005)(47076005)(86362001)(40480700001)(336012)(36860700001)(83380400001)(426003)(81166007)(82740400003)(356005)(36756003)(316002)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:41:47.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547290d7-78f7-4bc1-d0ca-08daee729243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

