Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A35E6B17
	for <lists+dmaengine@lfdr.de>; Thu, 22 Sep 2022 20:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIVSiu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiIVSis (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 14:38:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43031B6003;
        Thu, 22 Sep 2022 11:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz2xMnmkqU6+2xCvhOgxttszS6BIv6ibU2uPpZzOxZlany++pzy0zbZcMtpNPTZ4VigO7ygZ2At/ZH/uCa+dPo7yEoJXjSRnLd7Jh5S234OBD8PR9jHIUsEb9suUPaWpTSvJI3VCZ7JZ1DgpWknOyrq4bTREsBDJsA5hQiB4sPYLqprL587yOA4Yeb+Pe9QtHV5+3276Yr6PUNTBZyg8wZ60nJkf6JGkQgAAo5lBbe7WO6vBTku2PXj246Q418m7ABLnMCT3Icewb87QVfkBmr/fjseBjv5BA6tdc4yBWQGBipQbPxkbU01Gxt19sxT/1cNRaK94pRPWXOY2XdTslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4ea0rLu7aqyjaZk4iuLQO2W09IG+tek20GTSkWCqz0=;
 b=j/ehWfBvzTufOKu4KVPLwTPmZ1+qZG7AiLow1KPdL3gxtOt7zGuGco217GBLzloacib/HCmg1ogOnsPbr6w3dFBSe4joqmoh1/+kCrDo3wK6bXmlJ0SwDTDoVB3EmCU85/xHealwk7VMY1AqtIpltdW5aakD0dSzk5jiQoyW1MPw9LWacJVqp3kYTYZ7Fj1ydMjBjN5iZjqC/ban4yq7y4SZa+kKLkUrfHbUPYxBkweq88w0YXJvwxLq55HpvwuIMfZytYIBuWLCUTJmoUYLOls4IDKk9byrHvqcdryoJKdisXUP6qByI3/I5h0fUAPKrmhCMG6GaQgVDMZCYOcs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4ea0rLu7aqyjaZk4iuLQO2W09IG+tek20GTSkWCqz0=;
 b=zp7KTcrlKSlayCDflvH2v2ngQC6vPwcSVb+XmGxACiBcpVE8s9KSCBM/6zLvE7KI5OpWofhIjELbAHY9nTw3kYn3MtrQqM1oTs8r9Nef94Vkf4FG/NoJ3fwLfOBg/q44W0aw8VgdR+sx9EBVeNYXhSNkwSDlpFvlqceGLMjZnLc=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 18:38:39 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::85) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 18:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 18:38:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 13:38:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 13:38:38 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 22 Sep 2022 13:38:37 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V4 XDMA 0/2] xilinx XDMA driver
Date:   Thu, 22 Sep 2022 11:38:23 -0700
Message-ID: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 95158391-d19a-437b-1c84-08da9cc9aa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ7uTKu/AIFBPEQDxvhsuXgXXLV/LlYR+PrwCEaNHRMXJCAIkIOhJ+fygpCtjBOWglwJtDQCB1Iir06u+vZhXJ3Db/ow+KwRH5x41SNW1jkI8C/Ljujhu281/heSQwr5bGexdR0KqIwir7bhY8aWdogatACFVg2pH4gnV4uCTyECMnA8hlazPxfSCS9S2K+jmv1XzxVHp2By27/SNMlRl+rmUem2iVyaK4SFVpAHPC64X7ucnzRG0iR7KVALSAWY+UMjykS7FkRExde7qaXOKhyVEU4vn6azpH/CEceObZs/HhESLtI1Z5hsIVgG+l4cikin1FHE4MF8dLy7H8IwQOAyruBgNLHoXDchT2Yw1BDwkEe4DPvMh6HiTgm6UPJ2HGWoZleoaBAiGke0UMOgPL9i8asJynpTKrBAHNC4pcaFpYzsL7WgXD0gR+krCsxuIbZDBgSLFzh/RzYUFCQ0pHseG/+cuAI1Ae3vz3R5ixW7G4MY804Onx7w1BZj8cdnzyC7MN9NTHeiM007y137qBoaMBLjkZY5SClqv5y+Md7VDBkorvGF7kkLpm4gg5Iw4VkS4dmrE+Ptm9m5w8xWoSKMn9kKJQsu1KXwwHni1kDYqdkUoYGj/iDuHwtgfQ4GR0g8Tvc2tiuYjqbUq1Vc2AQE7Ahi76ugUDhWigtYx8G0DyZl5rnF1QLVyB5Vnm5PUL22uaFonUJgtfHsLZ11XZCOrWAQk90YNCdIPU0GYKDxiWmLJWz/U9chLpIYYXgsASx7njHAhD3y3q1mpc+78tvAGfB4NAjcMuQY0fWhyfsoGjihsaSo+lo8AMUaUSIsnPMRrVarETkrWVktaR6VBnmOBt22+kEowHGi/ZF6db1FC5K3Ff8Hc7V446NJZ2bd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2616005)(8676002)(186003)(6666004)(36756003)(82310400005)(86362001)(2906002)(40460700003)(356005)(81166007)(478600001)(44832011)(966005)(5660300002)(82740400003)(41300700001)(316002)(336012)(4326008)(83380400001)(70586007)(26005)(426003)(110136005)(54906003)(40480700001)(36860700001)(8936002)(70206006)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:38:39.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95158391-d19a-437b-1c84-08da9cc9aa9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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

This V4 of patch series is to provide the platform driver to support the
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

Changes since v3:
- Add one patch to support user logic interrupt.

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
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  171 ++++
 drivers/dma/xilinx/xdma.c              | 1035 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   17 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1282 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

