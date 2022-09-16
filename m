Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F45BB027
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIPP0o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIPP0n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:26:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2AA3D34;
        Fri, 16 Sep 2022 08:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9M6VGno3M169QRh2TIy9vPkRgal/qxnAaNfOP1S9h0ZZPdvPlFZIBca3fVG7gPTSgyh1KMe0w/0RyasvbmLFQTMb16yjECJ7iZS80BmhIy1SV4muXQjz85xDhtYBnvf2NLzAK2qNb9WgNUcXIP2z1/Pj2qxNEvIMhZavTOZ7RlfYutHX0vuSLrkSUJrtdXp2qeQylEm0sVqeMHe3MGyfRTTkT32jQpzMDH6OaGd3a3j3jGZYx7Dqw2+VMdEyadVbzOPOtD1RvnlS8Earr53IsLntmGITgydBR7UVsn+eLs2nts2GyMIdZVcbVyO3CaruD6jKa7hvuAt95PWht+waQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msA63dbNzCLTJO7ktrXfms5T9dZYusVVQ8ejd3PF2vg=;
 b=DYzqgXfvF1b2z5HtqT5kubR/mbH6WAsTN0ZsUkNNzbLynHp2JPIGdFJOry2XrDVe0REshsQ9EqtcpRe0ghvoqmKLMMFn0+gHQ0GNeTlknF26X+h3G5Yys4N5QiCtDVB2m51cXbaWu352xEjGi2UfifW/omLjEGtyl7QosQaXjmiyP5KoqjDKDCsVaNczE50A48rdrj0CfVq0sPTSXXbopxmZidR/ODICfXjFOgXdQ4borYoi2hP9nLJZXxaE6Z86H/iV7u8DBEX0fAIc/XH7X/tArR8fLiIkH8kzMTulW3ZzxlhKLXpzpxhNpDGZq2WrReCSCGgSi8tQjp/dsToIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msA63dbNzCLTJO7ktrXfms5T9dZYusVVQ8ejd3PF2vg=;
 b=Vre7V2hlmKdm4EcslZ5OrNc4MvBUNW+DgtS6CBI73z0LQMcom9QrbHaa4diPkgYEfM07kuaO4WI1xnAl1Xi5UEjRQevysPOdB7Gu4K4fbDRVAr0g82k9ML6/NzOZIf61tRVD/4AVlRiqXNH727SwjplY/jcM/4Jh1gDJrjVrvKU=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 15:26:39 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::e7) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 15:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:26:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:26:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:26:38 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 16 Sep 2022 10:26:37 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
Subject: [PATCH V2 XDMA 0/1] xilinx XDMA driver
Date:   Fri, 16 Sep 2022 08:26:24 -0700
Message-ID: <1663341985-65589-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec62b1f-371f-4025-3fb0-08da97f7d9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHuZzMnPBnEhwQUBbkL87mSPf5/SS+l1CvmE97uGKmTA5IMl21yDqs4lT6Ds2fRSfzt8d0rEgnvJIQpQw/qBjXo3nMEOjKcWDZDoX+x/hqIS7gGbCcgDtJHiTis9+tTx6dUuv7eKILZjVc/dmR5jYj7twwfco4JMs1aMlZYTWVYgclx5Wo23QV5ovGoKOLJyC6i8D3HhCq2ToN8nfqK8fu9pbNdqXXWQd2MeJ5Po6dm+5HQOvgZN6tAluIbGL5Z1XfLhxxrJT2xzb2KWSc0RAb67mZdcLdvXTFrcBv8e3JhK+SRKDPmZ+WkpHyScU1SH59acLy4IdBvGwpOKoNqAq/LpCDZRrULGEWum4epvcn9Yl1HeI7ULDrOW5cUncvC/szFUAv2GV6ErghxaC9vQsp3g2FR0EzQ2kNq/kBdH4c092wg8/h0cmFX04yi6VIqOPJvOdFujDn6CjOPh3WhsFOZipSWuY8lUqHFyBYsY2776QQDepwriff8APoRkW3YSktZStfxcbWJuFS3ijou6dQjhn7F3gJm7EkHIfP7ejNO4SLNY1HPVfCutJVQmSp3UbQvjoxIxV2j9Qtp9aUJ5EuvR1e50qbxPfdxWOjKifW4XNM3xfaZZPEWt8oi7WAmrXafxivklODdKbgOjGMlmRyaOoItacxjwagzQlBaSY8rcezHOxdZfdAdsqsY48cf4vhYltt8AsEFxfH1PFVmLwmVHac7AylVTfpI8UC2DnFoa3JjjCcPyul5Pht/AGO16WIpu5oLTVrhJ/vjDfVafqrwOkFJkgGQ7TFcPQomjcRrZIYyCiHJIN7QDja/XOa6TBQ7sMv/RaZatiml0wvS8kuPSubz2aaQmFNM3XOc8lSft3/An6Ps2dAyWUZ7MIuDW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(6666004)(82740400003)(81166007)(2906002)(44832011)(26005)(478600001)(86362001)(966005)(356005)(82310400005)(186003)(2616005)(316002)(70586007)(70206006)(54906003)(83380400001)(336012)(40480700001)(5660300002)(47076005)(426003)(8676002)(4326008)(36860700001)(8936002)(110136005)(41300700001)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:26:39.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec62b1f-371f-4025-3fb0-08da97f7d9bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

This V2 of patch series is to provide the platform driver to support the
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

Changes since v1:
- Moved filling hardware descriptor to xdma_prep_device_sg().
- Changed hardware descriptor enum to "struct xdma_hw_desc".
- Minor changes from code review comments.

Lizhi Hou (1):
  dmaengine: xilinx: xdma: add xilinx xdma driver

 MAINTAINERS                            |  10 +
 drivers/dma/Kconfig                    |  13 +
 drivers/dma/xilinx/Makefile            |   1 +
 drivers/dma/xilinx/xdma-regs.h         | 171 +++++
 drivers/dma/xilinx/xdma.c              | 982 +++++++++++++++++++++++++
 include/linux/platform_data/amd_xdma.h |  34 +
 6 files changed, 1211 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

