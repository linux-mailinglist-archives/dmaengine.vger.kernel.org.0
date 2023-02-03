Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538FC68A15D
	for <lists+dmaengine@lfdr.de>; Fri,  3 Feb 2023 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBCSOE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Feb 2023 13:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBCSOD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Feb 2023 13:14:03 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05632411D;
        Fri,  3 Feb 2023 10:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr1BsNgR1+fFLBO8rn6ow/6SNDtq/40RW18y7jx9QH2azbwf4xy+P4mtdYHlHNb6Pyn0n4DoK337kJ4gfHDZLQN9iz5XjO4Qr7mD8+QXPm9t3ySOn+zkkDhoXXCDbm5iLwoWIVFIwXE0bHKhrMJ0BhAGtVswb0W8bcVXKPxWw3jTslhjOOb8XBYGOybwkrnK3xNyucnoi/bQn9nJAXg2/ouzqPRxU5UE6IAuEzKzdKoUMyC8tKGT+KPmhZQCSsq3mZfSV7800S9/Z5RbtFudnob0oFWfaGArsMZYDljr/QUx62fQ+fzXHv4SlnmOaeU4Fba5nSR1PcEI1v0bDgkfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=C/tV8xHGskPmSW8u0Q4geP22dHglVS3w/sV6fDtYpRgUTHNAegT7nYBTobFWG/1H653VmKaOHJbJLP2on+LtxdlnC3HWDFOJPOG6Wm+MD5GHcUtUffiq4TlFi/OEof/YM/6YBkDqAtlLUzDW+Hb3CStCHtXQerocqLoohkAyt3ZlEMjtsgG+t667N9z6ShQ3gjc6wBquijsBe7/RTBVHuRT7faliPjIxKjB6UQuiRjiP+x5h819QaQPeznL9vHr+Ab2tv7pcLdm1aIvfcMmOVaFWpGedxkTOf9LyHqAlrNtIOvJgqDE+2+I5iImQ/ey80AmPL+2H+O/KvTD2UJUIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcS8yOsl9+79HlK0tItjBXALELYGd1Ebsn4u/JP7uI=;
 b=Qu6JHywDVqnP1+pTKcBnq5/1SktTS3Tb8McUMaL0aUGIV3aUoMBYE7xb999zc7Mie1zT0r6ILXgR/8sF03egO/S1UIuovGslgMT/iHasKnoa0obhB83Kwq7jhf7S7QoG5NjXgeQq58DL9ix2SHuFNkiSgvaPTnqAqHsCrLz8t8M=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 18:13:59 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::14) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 18:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 18:13:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 12:13:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 12:13:58 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 3 Feb 2023 12:13:57 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V12 XDMA 0/2] xilinx XDMA driver
Date:   Fri, 3 Feb 2023 10:13:53 -0800
Message-ID: <1675448035-72930-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: f181c38f-c1d3-451c-8200-08db06126c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51TmKBMJnqTnVYhZQDWHhUrwAgFF+qw++kjBYtd7K+TtCbe9b8lZ73vBDr1y2RnGrzVRTYdRc4/W2a2Fqu3nAHKL2TD5UCZ0VkLzDRKTBxgp6oZWN2ydqRNfB4KI1yTCD0UbDvZTXCUae1t7NddxhThb/uVzGwV9R4oqiZq7U/NGB5o73pJXty/IKUoPw9qsnWiV/zcHbtSG42y/HofBVAvBvJyF95SX77Vbi3sOYqX8TopzkAnnVhxonQXZXzAPFuBjL4BuNxeNMlUwaI3WfxhnwePoUWIG/q1XPvVlAmjMFfvpIdIlAvv55/HVbWHr0tvVSkFM5KLEsAmOKhP1nRLesZVdUQTlFe2Ae7VbXt7VKKFP58hRiSdwRpnQGNgskiyYyJI7fen44YyTYDnKSamrAvAx2acyg4ZnVmyY5f4cU63L+hERqVqq280hHKqnDg00opTVcY67WGZcgICJu1MPZG7PrEaI9GJYJ1SkMjWcOBQFenF1kXP5X8/dW9LoAqiDuc67lphV2dC8UAXpGB9MNRLtmjEJrRHStDCQMxq3tkIasrqbeC+benh1Bd9lvSBg32v09zlL1TtProahFHw8D3fL9djYeer1vnaZZi/XyArknLqVr9gUc7UdVNEP7o4O3K3NOoBSv5Ek6YeoYCfDPRbrMuS+jIBqdPlOeqzp8X7r3LQG0dU6sRK2JgmLEhGXX4b4uCJy0Cyl9T2B7jlHCK9d/NSGO3cpl2a56ZSciuZvVjuDQqzOBX6CYfBNgO7mftDpccIUv6Q0kANWDLcUMfRGURKwYBgR87Sag8KGjPpbHS0ZjfD6ootj1UJd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(70586007)(36860700001)(40460700003)(8676002)(966005)(478600001)(26005)(110136005)(36756003)(82310400005)(54906003)(6666004)(186003)(316002)(86362001)(5660300002)(2906002)(44832011)(70206006)(41300700001)(8936002)(4326008)(40480700001)(336012)(2616005)(83380400001)(426003)(47076005)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:13:59.4066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f181c38f-c1d3-451c-8200-08db06126c05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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

