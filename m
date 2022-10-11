Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE665FB77C
	for <lists+dmaengine@lfdr.de>; Tue, 11 Oct 2022 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJKPlr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Oct 2022 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJKPlb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Oct 2022 11:41:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6197D78;
        Tue, 11 Oct 2022 08:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxcnPywTJVKW+E7gQGcQiisNI7ayRaL3m/7j3MFBlaOgBgMilO4+mCx7s6WXJGbazReR6ipcD3tGTqGCoAxKNLeJrVtk/b4+FY8ZwVEIQmTaOjn6LZBUmtnw3lZ0AHAS3G0K4D6QW+G9LPxlpuftNx16DBTRfKhSNWGd986BSndUcQsYf4LzHnMUL+11trLMMKxPBCjDVw+0kNP5OCthECxoLz0HdDtItblpRGg31GahSoANKvqFalvJc+lNHQib6AdBoD55snZZFyJkEpvv+mjKxeeA88bd4afMGuRaVAE2TA5e6HO3iSb7hHkE8ouNRuSDV3OoEgUvhgaTtyniGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq8Xx2wMZ/UOR46yLJ7gf6CUgmwpsYoT+hhZ0+P5BEU=;
 b=lGq7Qd47Y1mt/JtEkw4JWcSbwZ5E6lzLcdxepcAiP7TxWO+q4pgjD3+vwAXcjTNpfzINwacAQaAy0c9s8frN6SZsnvUGiLI2Bv9Pu6l1Tu9c4z1+VOmfnLn6U10ccPwZHJkJfezl7frKUdWI3DhoeKhOydpx0dmhCgfg4ir/oh7mkkvCkgJ7PBeUV8xSkXU5vtla1k69I0VSS0hFcjtlCGJF3WS2xYpeuLXDO6X1d6lF90AQtRzWQIeONqi4xpmhEKOpiz1VF3QeN9E8QCnOV7UrLqfBLceUGArXXFox3qACmYaTkZgUqFph4jacVZRghrJwhwuDGxMOjb9Pg3pJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq8Xx2wMZ/UOR46yLJ7gf6CUgmwpsYoT+hhZ0+P5BEU=;
 b=weBSrLMwyJoBljN3pms4LeFOQyYG7gJmMJk2okEaHPNpjijegh9vQYraF1toB8FLw43jYiMzctLTM84L7CMyvGUL07FHIGzZdVJfNKjQMHL8bc74iAK0LEQuX9g3vkWXlLLfUgMRj5GI88NFVwNQkDwaQPe6arPP2Stp8M7u97c=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 15:31:06 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::25) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 15:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 15:31:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 10:31:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 10:31:06 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 10:31:05 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V7 XDMA 0/2] xilinx XDMA driver
Date:   Tue, 11 Oct 2022 08:31:00 -0700
Message-ID: <1665502262-4246-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1cd16d-22c0-491f-c389-08daab9d9d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9pKeV62WjoUvmCDhLjPyxYjhzA1S69EZXaemS+r5h3dT80zQY15nCyYmdDyBv6i7ct8xZrWp2rKPOH1rXgxqLSM3ss/NaWsqdozCMvuyqxeqQzll7Pfwgz/CsiP9gYdxj4aiKhsEqtAso/fW2upP5xmQ5jtt2d8ZjMLFM9Gv3Rk3PFTv7G6YquCSxSSwrEaG8qaF8XQO47UpYKSUXZVNgQkRNoFcuZ9qUJOUNmrzFcBFMqrse/hm8TKIDQYxTl9w++PO9o/Oc941yYUcR5iDRtxSxv3VljhYuS3Il89/nw3XKZHyhAEXW8sdrRaJoPja60UCggFyZRbx6z+MmfvGdh93yBiP8kvwy5ZKKnr3jLZcoeyoqdsF/L+Xi+7qKQ9m7oJaXvbQoLIAA90BKklblutbzK9kLHStDbKce88pPda6+Iwh6Kh35dEWX6VF/czd7Q6k0eZZ9+j8QsVmxalALgCWeCMDfkF1PwCEie8kFtRPMjlvs+usem/fM6PsBmXbA0j/42RE3n4g5A5RSM4hkWsXgqP3ldmeS1B0pvuYNkf0xssRemck7iLl1PIymiTJVLkhClH6ORPtqLqVot0fHb3uFAZdv4xeOjPcAcw/mxEVH10yaFWQRddhcXEam9++iyI3S3XqiBeThWMO2Z8gknWa4PT0iJr55etPZNfqNuuOtEJMr4abU6gfxlQ6MfuP84Li/tihpNiKwtgGKyi0/6Jkuv5Z1dHa4RW8h+iWpCMayaCRyf27AyNps2yvUArM+7rtSc0kzmA5VnQ+fSrtySKvACT8u9Bwa9w6qrOL07U85F7qpmY22ARZtCWlNrZR0DM/ClvWztP2r5k7iD/OWKDEfKoXpa458pVHoGF4EAb+bCGva/weFUTwSxfotgy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(82310400005)(6666004)(44832011)(426003)(47076005)(2616005)(186003)(336012)(36860700001)(41300700001)(40460700003)(5660300002)(86362001)(8936002)(2906002)(478600001)(966005)(82740400003)(110136005)(83380400001)(4326008)(8676002)(70206006)(70586007)(316002)(54906003)(26005)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:31:06.7734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1cd16d-22c0-491f-c389-08daab9d9d92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V7 of patch series is to provide the platform driver to support the
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
 drivers/dma/Kconfig                    |   13 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  171 ++++
 drivers/dma/xilinx/xdma.c              | 1034 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1280 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

