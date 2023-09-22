Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5497AB70E
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjIVRQT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjIVRQR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 13:16:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68E1AD;
        Fri, 22 Sep 2023 10:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0KUhl5OWlQU8YGmJkj9pGE3KdCwVdIBtJi68O0WV387gPOJLVl4AFema7ubsTdkCOkSi4r4m0NrjPWIMI09B5+s0gPnfc92Wz5A/SKFFFvobci26Cm9N8Ps9zEOxb8AMVZPVtC8ST9P4opkzOeq4EOiv8I+l7al8son+kyQ0gLGndkf3VDG38AQc9ASB3gpAYPfHVM4cL+SUSRYgn76dbR9CfjwZkLrQveFgwftTv8+XZdlbSI/PHY8Fc3uy5jvoLdWzX7QKDtDNVuTRXkL4qpYmJHMmpZ0UDPUpY9pouXDNltBjSNBdc4/v2nfPV8ZLBcn+fDrEeeWIDYA1g34rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOdTPUsmiBCcxTOj8NIg/rtLtUis7KIL3NY/t1A3G5I=;
 b=BQBDdpeXfqYEICMtj4NZjYA5lfTKhKCqlbaMdxzb7YFbiCXC1/MLPIH4OYvfPdsi5BHQ/rPOaf8Es3mrIIA4SIX+QM2mdGXPUQeK5IZbL00eHXIjG99D6PnuUf15cAhjTtH6Z5NDI09So2Y3IZ5SxmsMFQjONoYSVemd28Edbs5To5Dbk0nFBdOUkOPa46kjkaQwQJJeBbHsESs50s/tRk1Fi1zeCrq5EHa6B8k4XsfL2Tmu/r/9hW1nDfuykiGadUmXjPDPd8v69lDCN+3k2U/7+vmwWLhcxOGbLxATbaDREPEmd35K28nu9kMfwWC/S0p/TBoIcNm5+LAwUy2YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOdTPUsmiBCcxTOj8NIg/rtLtUis7KIL3NY/t1A3G5I=;
 b=Hw3uAvUgCi9+bzG3JQM7CTp2BMTec02kSDABSoo3JA+IkIUhl5A3XGiPCCSJ0GgQEFrup0yyNlvza8WrO6ih8pbitzasfZr9qDst2wQba7XzT3HM7/Ttby2gCpZl9YqL5weQKIgZZk94tHuZkxhJplqO1QihHU8SiZzjjr+SAM4=
Received: from MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 17:16:07 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::11) by MN2PR04CA0029.outlook.office365.com
 (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 17:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 17:16:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 12:16:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 12:15:41 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 12:15:40 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V5 0/1] AMD QDMA driver
Date:   Fri, 22 Sep 2023 10:15:38 -0700
Message-ID: <1695402939-28924-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe2a410-8957-43c5-c952-08dbbb8f9bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/h7OWHaGPxLcpDkV+EEXMPTHraOHdVKr4Y7zHIsWI5pZMU1t+l6yqaQ0ri98/TyOHBRmJH3JuFzf0gjd3T0jN7dm7bSmKzyt2oiaVaAepOKp3v1j1Fqnt6S3E8xMct7/phtRaTChB38Eq8lJH2lWuD1aXAcj6hdhmJ9psbnN28zNfn5amX3IWDiZzQZdAzgsoNYjJ4il23h11mGIsLNp4+cNYOE3r4wqWEkErlGfr9tdKRHtM3RdBm8RkGDNc95jiH9Az6JeJ3izIezVIeKpMKUrKxGUEg4eDwzFaFEtffDwmX+aQk3CAQ9+A3jUI+LMKxAcBXk5xD7FeawfVFH47yY32AzG9IWlMskjvm9qPOFHUYnqAbSvfQnUCXaXLUqSrJZ+ZbEzUC43N+20FyYKnloZR5YLV43i0FK9VN/luSS0UwXErYBZYBKcO6DujGHvGrTtSB9LfN45rvNvZW4/+3wORyTjN5upgf7PM+FYk4Ha2Se8T0z1w+CY4bl4KpWqKJOm0cQk++pybtFvc6WNZ2Ba+xtPgIldxOba2enNpQtxu9lkuELpF59y/x4QVTIMKU/LFg9QoTaXYUT0Xkus5jlb0qiuGu0OgXIUnBlzvsXVJa+U58IV/Mcl+/J9UBvJ/9/8UQO/p+Xed7ncFoStKcX1EiqVX/uvPQo0ua7o0G8602QDK+CVToMwghzlXRqsLIVtULkiGOIX/O+dibI+RPsrmdt4xFFEMFSpdjVrwUWN5I0KZ90qgizJD5jJIMTRjPN7BcwJEP9pcipxgJUph/hOmlzxyyZWh/NN3hBCl1RpCp8G3l0Nb/N0iUIoS5num+4B5gijiECu1crc3KX2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230921699003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(26005)(2616005)(86362001)(36860700001)(47076005)(82740400003)(356005)(81166007)(36756003)(426003)(336012)(4326008)(110136005)(40480700001)(8936002)(478600001)(966005)(316002)(44832011)(70586007)(54906003)(70206006)(5660300002)(8676002)(83380400001)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:16:07.2400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe2a410-8957-43c5-c952-08dbbb8f9bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Changes since v4:
- Convert to use platform driver callback .remove_new()

Changes since v3:
- Minor changes in Kconfig description.

Changes since v2:
- A minor change from code review comments.

Changes since v1:
- Minor changes from code review comments.
- Fixed kernel robot warning.

Nishad Saraf (1):
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    9 +
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Makefile               |    8 +
 drivers/dma/amd/qdma-comm-regs.c       |   66 ++
 drivers/dma/amd/qdma.c                 | 1187 ++++++++++++++++++++++++
 drivers/dma/amd/qdma.h                 |  269 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 8 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma.c
 create mode 100644 drivers/dma/amd/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1

