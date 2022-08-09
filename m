Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259058DCA3
	for <lists+dmaengine@lfdr.de>; Tue,  9 Aug 2022 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiHIRAy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Aug 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbiHIRA2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Aug 2022 13:00:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FC1125;
        Tue,  9 Aug 2022 10:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkRb+WMVgjj9am/t4Am3XexZKJpJbDLSDeC55k5ItQNuX5RumwZrjGYgdiXRY1qNBcLf99d39zjhGwlP7dsZlnWy7Hom/qUTiMs6svjKs/S/BjSiO6pbC/ozuoOdL8wLB88HnfXrj3TnrNa2lwMLQ/1xXDI1Q0xxAnJAg4uJSwjicofsUU7wqMuxieMRAWazJmnCkazvcLMvG2wLo/WSsAIp0/r+J7q36sRbQU+4JiwZtrfB3mMEfQDUaM4jt3bag5BRHgbkqhyVwt14ev6aKyX8d+ifsPP3Ri1IBVzp/6VmoRUpeqRLp4rO75Ogy8DGNXAK/Rv/EOXlGC4s4b1ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhTzjV0OT2QBKYciT2OwT6DLaWD4orz8uCq+fmwBLOw=;
 b=LUbCepTC9S6SPeEeW2QrX0SwjMW26E4DxXYpYZjwFwSQSnkZnIajaGFiiCUCn8yU8G3Tp0MXJG50WQrzgzqgEWIpGTk+0wdT7WHyIkFmF7O3T6fH7uh35Gig5ijbNbKXY1OU095YLgna6muhkBl7O7O4OGcoGsALGINsOH76XHkUGqAo87hqtSiczrqIVvcnqqANpfeWdrDQjVQQOr6wHFGkC0YrYKcZy5neppJjfxlkkcurAazavyY19Y8MR/zylhYU6WuE9zjEKbUG6HyCIfJxbzS6bpTf0b+xFiux04vol6Mh2PwgJ/pGiFO6INgrZzo2IcGILudvJeDS8IHaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhTzjV0OT2QBKYciT2OwT6DLaWD4orz8uCq+fmwBLOw=;
 b=nmFwG8Vd5Ry9lp9RFn3N/ReVs7tizysMSoz4pkqkoSvidzSzT3emr43YAbYOXAqJ52bRG6XN0Vjq4tK1Gfaz2mXRCBmZWgU0KIh0MwYFydI11YHC5pCuyJ/A/RLfrMvrst/P/7IydvIbODbDxNNrS025WOsNdkklbl3+nRkTFqo=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by BN8PR12MB3265.namprd12.prod.outlook.com (2603:10b6:408:6a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 17:00:01 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::53) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15 via Frontend
 Transport; Tue, 9 Aug 2022 17:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Tue, 9 Aug 2022 17:00:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 12:00:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:00:00 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 9 Aug 2022 11:59:59 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
Subject: [PATCH V1 XDMA 0/1] xilinx XDMA driver
Date:   Tue, 9 Aug 2022 09:59:57 -0700
Message-ID: <1660064398-55898-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ffc9538-2f59-4409-6541-08da7a28992f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUU3NkFkdfT5jjLbMpUVCX1/x9rAWvm31fK5NiQZ+vHdjcEcp1BP6/8P9gaTVi1GL+zSdpOG3I7ioEpm6kuVyqpKTeXRHk0kymIJWZpV6aBVZ91iXvcAcie8kLr0wgnfE5iFs8679CYIAYPS9vKKcyNTCpRYDdLNWD2Ae+z/Ddm5XhlEnF4ktNYHCbx0aCrqikgkXi+AII0EkiTyOu1dmMfmbUERxJTb5047hHcb5jsi5mih+JX9NJ733nnjZ8zR8Rg8QVn41ZvXn7WT2YHF2gSV6jGzFR9ZdhCApzk7KMOIv9UXrHqVZ5OkQoNJpVk3quFdFMIzfusd/MhXvqxfIkAYX6dDZlJKAA8wBTBIQ88P6Tv8jLR8vtTieXrs9//zNPqmACL9onkpS0I405/TEuCrshLs0HwsBrXBfSFRnfZtvumAKFXGfIneDE7coGQ5Vg1hSeDz9WoSOU+EmmD5VnfZ4WD9a4eEKd8oPKnVxVR5emwKlRNVGaF7xzMeUyPuVp19Qh4GDDWnfTqSRTUZdC9xTafjECtE3I6fZgJ/fGchcsmwsQX5x22Ar97VIipvuIErXD72HpfpVGzjr7KAiG7IspOzrSICqgJK40mW1Tpm0+8jKEFKbUQSuXirO+6q16Hfz/Um98cyDvxGHLrcMcrotY8tGD0jpLXk5mt5XEJqOkqGeBD6Flce01wS9N8jGjNzMuE9Vgep51H3e3bNlDi8gxXFh81s7V53JenRVh4PMMgYP4im/hoU0uP7tPnUeaGz+mHUJGIO/Sj2HVfJIr8Mn5BeM9PYkfOCi42ARhjTuUGqKbiFpRlZ6riEj3PFznbQRbW8WI076I53IIW7eUXxwUREH6RjdY6Y8PWRqzBtN3/St7JMZQsKb510JW/tilWDcnuRYlqg+CTfBvI01g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(40480700001)(36860700001)(2616005)(86362001)(966005)(41300700001)(83380400001)(478600001)(44832011)(2906002)(336012)(186003)(40460700003)(47076005)(426003)(26005)(82740400003)(81166007)(82310400005)(356005)(316002)(54906003)(36756003)(4326008)(70586007)(70206006)(8676002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:00:01.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffc9538-2f59-4409-6541-08da7a28992f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V1 of patch series is to provide the platform driver to support the
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

Lizhi Hou (1):
  dmaengine: xilinx: xdma: add xilinx xdma driver

 MAINTAINERS                            |  10 +
 drivers/dma/Kconfig                    |  13 +
 drivers/dma/xilinx/Makefile            |   1 +
 drivers/dma/xilinx/xdma-regs.h         | 179 +++++
 drivers/dma/xilinx/xdma.c              | 952 +++++++++++++++++++++++++
 include/linux/platform_data/amd_xdma.h |  34 +
 6 files changed, 1189 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

