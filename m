Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D685F4B1A
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiJDVqU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiJDVpr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 17:45:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA7B4F;
        Tue,  4 Oct 2022 14:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJJsMaWdu8SRdNQKvasb+WD5MjUTiC8yMRnOZPjbtfqdQG2Mq4acO65GmjNQZHGIzMXN0kSCsDNn8R2TvfmQzFkD7VSFdr7KDAgijBRh7d5vASNAFimb4eApuhpMOrycjp8qcTsSJ0Q+RT2MKLKxzZsFujgOFfjoJviZoPT/KY2L+t4D/ZSybtzQlUIp4DD4esS6fXHhzwH82nUx/ghQ8GIWT8KRqZo6rkyUl69a8Ktk0istwGktLWsoQDqjogvrTPbJMSrMmkkDlGewPPlmUaflN8eMDZe+Dh/+u+ocfN0usdjGKbDTYbw+3OXkSK6+iAtHi2Nb5GcZzHLqi3A9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rYB59bGiVJgihVus7gEmBv+oOjfeeZymTwMZOBGm1I=;
 b=MYvmKRxdxwRqt/+6EltXIZu4AwXWKETZzSwaPJe1QHi5/Numd0RTJcBdiAHMdOVekkTIUkD2L0F6ffbOgDTbVVoPBcgNenYWf65qHHB6VQwCNNpTtvJiMpj0/6OjHF3pW58nF4hEk9gnhooZizeVKiazy6hIj8pmY87WpHPnQfeip+cGanyKFUtmRPCcg2IxhPe5IAyyYUFMzbzVHREVN9wVFrg3dn4EA8SGYZJqgiOsNkjpUbqKGnAfjGfi5zRYrZL1NArJYc3iAKOjB2UJEZJUst8abpQICVLzko6fYn0secbSjwqjGKv9CBTK7YSThf0fxhauJwSO6ImgkRHyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rYB59bGiVJgihVus7gEmBv+oOjfeeZymTwMZOBGm1I=;
 b=Ta4IqflvUW3ygSWQqQYrdRXtKpx7SAe4DOs6PumsaaXnmfXjXEpRlHTdKC03dZ37U+Ypz/n8yAvuypY8tPGjEqoz/Dnd0BvF+G5FTwaTycYxp0gp2nuTxKNmnMb8AFZLUTIcecJUBegpQUA1PoReyeu73cw0foGVCw8pqTK8nHY=
Received: from BN9PR03CA0972.namprd03.prod.outlook.com (2603:10b6:408:109::17)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 21:44:04 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b0) by BN9PR03CA0972.outlook.office365.com
 (2603:10b6:408:109::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Tue, 4 Oct 2022 21:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 21:44:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 16:44:02 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 4 Oct 2022 16:44:01 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V6 XDMA 0/2] xilinx XDMA driver
Date:   Tue, 4 Oct 2022 14:43:57 -0700
Message-ID: <1664919839-27149-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: cd238ac5-4ac9-435a-2dad-08daa6518eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7jcc1QVHs3HYnKkvSogUvpUbXbeRg3jgj1MhuIa1nMBNZHDMpUKm0rOI7P0Topx+pB8t/XDsnlw+cHYagOTDVBLclzFvvG0ohvS+ZrMpiLoSx4SSe6C7d8VOivvh4UEcgQ8bkha4UXoIVBef3sAznuyoIsVDUD9pj12Pw1dKxY5VP+kSSloY6bneic/CleoCOjgnpRgAQHcTqMtM/MHXoSOweWa9LMsfinLNkYuYtipXUbN6eQoMtolWe8Zv/SlmuHC/rzkjx/vYgG6oM/jrTWps4lA/wV/av+VlSo9k2nXW46M51myF9d5Y1bMX9mzkFd60/OYIm4YqXWJyuOGTIe4U/pKvI1e/QrbQh4ItfJs+DzRURVrG412eGUZEOx8jio7jnL3zEWtJ03BPHzrbSxd2XCDfviu4c7ly27c18THKrNfh1tJuTAKxHKOw/oICZ2+8sJoVmYXyvne6ClB3atu2oCeCI0w1cslUjpeJOrxEvtPEkZorxeF2KYeBcDs2bMdhZM31waCi29UEjxYPGqNpkhdyElZWzlOIake0MMz+zaqAnz9RUrvCVMsmE+ylJQITdk7T11jltRnIpRVPEu/Xgq6YQsd/9/lYYqx0d1/7VzY5IuEPQfJJMF+9+wRHbhdCBFptjPxLKYMH6uOWoW5AP/1bIvzcHZLUR/qTw2tbx9vLov+0UYYi/qiny8g/0k08at83FA5X8FBrHR1cRWo7zGOcGn8qFr9I3eJ1V5JS5tcxuFeT5JSDQZEvDrbyQ+93GSRWHqIgWodzppsYaKpToq3+tezkRyAxFyMmdyDpucohDuFFyjc6zaiD0E75JB41y/F6gLxVdaugSFG/fFjUFgQxVzyHMmUnlaDL4BPqoea+TjbbuA3g4RHdoo1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(82740400003)(356005)(36860700001)(81166007)(54906003)(110136005)(316002)(336012)(40460700003)(5660300002)(86362001)(70586007)(83380400001)(8676002)(70206006)(8936002)(4326008)(40480700001)(478600001)(36756003)(6666004)(26005)(2906002)(44832011)(186003)(47076005)(426003)(966005)(2616005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 21:44:04.2431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd238ac5-4ac9-435a-2dad-08daa6518eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

This V6 of patch series is to provide the platform driver to support the
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

