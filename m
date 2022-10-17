Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60DB601325
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJQQD4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiJQQDj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 12:03:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2172D6EF07;
        Mon, 17 Oct 2022 09:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8ngSbhNrM6odcYcj0bEwXr/1X6u0d/Az7lQ91AobEfxKAc2BAEexLq9VKYG2cYWRTosewICFFePb1L8NZaGYKbRMqyyQ19CV+fJE8Oh0CwxKxjv9gV1afsov52ie9QUONXF+w+khdVzoB1+nK8DezjrW/6+slsej8ZKcNgmmYeuwfHTUZNkTB2la2Yl0NBVbjgMibHAmt0w9il0nJ+bnNBybfGLs9FUejCKAwgOAG1b2OTD2/vNbLx4VyV0z9FigEmaVSwivGUH0RqirpgrdpcNWcL0riOfC66/g4enSKw5yZ+sjom9yDXmDdhw5lWJab+xbLbRpFuOqlTzYjvlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzEKF5HGBp7JYgjD4qHYz9VwrN1h315S03mR66Zzi9M=;
 b=jkWIs0k214K3ugneofObAdkIGqV2rBtpg+ToHJZ9kM9kVYLJF7yPj+TpWyUZw6oGkpUN4mXhFsv/TitRG1rgfaEtyvxMLlBy4HScEQ1RLPDcd3Lh9dpMZGC0GwoieqnZCRoHxYzbDapEA6wc0vUg0S990aSB+sefqpUXWcCWN4gyorMYqIdRaSHi64Oh6xeNLpyhCaUxA6eN3oVKQhOw6NLOoQ2WCNgS/n5cX0kh2zJfCPSwGs776m74S+1HJCGHR+T083Z/ABUosU8bJLimh/n2JoNO/iStq7IVvxJoIhJdj9l6e+fEGf2mIx5KBWEkzpW2QqEq3ShlwXYYBE9AzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzEKF5HGBp7JYgjD4qHYz9VwrN1h315S03mR66Zzi9M=;
 b=TE3IpX/3Khx0Uiuwt5hcXS1N+Y2AV/6TM4+4G3g8EqU5Ga6ThIPECAWLQ989aADupDotf6Qiq4B8pxvyA8o/9gs+2GfbtJrUIKI68XMy2yHL1RiLZbkOUxcAEE9eOIIAf+4xY7+xhuVjiKG+AWewbsD9I+uCkB4nk8jEsMu+gZg=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by MW4PR02MB7137.namprd02.prod.outlook.com (2603:10b6:303:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 16:03:14 +0000
Received: from BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d9) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 16:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT035.mail.protection.outlook.com (10.13.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 16:03:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 17 Oct 2022 09:03:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Mon, 17 Oct 2022 09:03:03 -0700
Envelope-to: brian.xu@amd.com,
 larry.liu@amd.com,
 lizhi.hou@amd.com,
 max.zhen@amd.com,
 sonal.santan@amd.com,
 tumic@gpxsee.org,
 vkoul@kernel.org,
 trix@redhat.com,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.74.144] (port=32848 helo=xsjlizhih40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rootmail@Xilinx.com>)
        id 1okSZz-000FTy-FR; Mon, 17 Oct 2022 09:03:03 -0700
Received: by xsjlizhih40.xilinx.com (Postfix, from userid 0)
        id 4911BA93; Mon, 17 Oct 2022 09:03:03 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V8 XDMA 0/2] xilinx XDMA driver
Date:   Mon, 17 Oct 2022 09:02:59 -0700
Message-ID: <1666022581-27279-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT035:EE_|MW4PR02MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea02149-43fe-4d28-b44d-08dab05918a8
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsFQVaHH1BUgb6fTrhJakwc1zwoJf+HHP2wZklYP+rq5gcbnqnf8FH5L09B0zPewmKRAquyTemlrrWBOwVt7diQbVaiXQWld4+0sR/rVQIeOXgvT6sNT2ICmd/6UgUWDCzlsa64hj/aEJhxB0VzZakV7exMzo/BmXp61GSf5/5I1hMLHCoTrrFSNkycbh7WdYrUjmSTLWPxgx+CKLPn7cS2Vg+1Bvs3mEEoDkYvrn/sRh/LG+hTvjg0kGa6MO75047Zz2bwfXmMp8nqbt2tqh1wC8kNgnhTnLu26LDI/W35xdEZGebd0u7wNEbuUve5LSrjLG9SjoOCUT7yckpLnYFsUlbmokZUdMW+TqkZ143OWer6vPdm8HUxdZg7AdyBPAe6IbTZFoIIIdrTlbDeIONan3Wyvf5JJCNTrJwFv2jrg3q5ngrp3Ma3m61xk9xTYCb1T/v5IpCU7vMMYhsHBawd9FHf29OEJD4HMYnhfr1LKooKQtOW+qtM6WJHYGKsevSd4xzk73DLXfVDyRRJm+cnd8kBI/11cfo5iNYP2ZPmdBlTRhIG71SG0CODLErq1nFr8BWYQDT0+C71ppPom/pQo2tWplBhQwgBKTGq6c+ZVMI2tx9UWVXsXn9ykcqVHuzHIQoh86ZAcr5awSqh7sa6KOtuULqX9oJYxcuohpFLRhyEOox827RAUvdk0ZJUWgwbJkbBMZSgYolAa0U7fu3gS6ChExTi5S5otuaItPeduQFfGtWfNm4HFUN1DIM6cjfmrheXN3/lNU9DhENJC4Unl3gRG+c8G7ZfdNKn69Pp5lKSQfYIeTmsbkO9nK3zifFWOebQLaihUEbalDDXEbbKpTfUij6hH/JSz6oTpp21K7CIeVKn+pR9CGL2tOyrB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(70586007)(8676002)(70206006)(4326008)(110136005)(54906003)(82740400003)(40480700001)(36756003)(83170400001)(36860700001)(40460700003)(356005)(7636003)(478600001)(83380400001)(186003)(316002)(2906002)(6266002)(6666004)(966005)(82310400005)(336012)(26005)(44832011)(42186006)(47076005)(2616005)(5660300002)(41300700001)(42882007)(8936002)(7416002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:03:13.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea02149-43fe-4d28-b44d-08dab05918a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7137
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V8 of patch series is to provide the platform driver to support the
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

Changes since v7
- Use pci device pointer for dma_pool_create().

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
 drivers/dma/xilinx/xdma.c              | 1041 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1287 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

