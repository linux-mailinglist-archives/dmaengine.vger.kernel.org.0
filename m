Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE0769F1A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjGaRPi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGaRPN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 13:15:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF3E26AF;
        Mon, 31 Jul 2023 10:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goNXhmbGZktbQ8GBm48dFWHeBq74/kjezZlPA9lRM6LOcc8OBbN6sLb8pyyBdOt9BpZ//FFaNl8+vsctJM6U4FaV9xAptUKXLdlVeoDTxHIYUuYAn06WQZ1JeBgj0Jhgvi5qbT+aeUDZeRsRYmdKsgdDpJkIhUx6o1vTMV4rC+NA9REO55WgW2g+kVdDMGoC/pRNu1HO16HBdaLFXgkPnhDuPLjPbUV5TkjmQXh80iTQjqNryjRvo8tHBZUPM28SGLFJCD/APr2WMHF89xJ5SuVw7vjOCnVnL5Oo11tpJI373yLFNBLaH4QblaI9oJgdAMSHb0KXIPpgQGtB5Xos6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uihR7IHTmVr9HVpC1qTOmZZ7H29W/QHkQ59FIYrpWY0=;
 b=G2PVdSL3gnsWHgb6Xf0DKPmVQhRCyKRyw3A2xm7PvLRgbzdSl2D7QkcuFsB0ZYAt+sdRMjnpgCqXMWXDcos8mvVU4EkHtzuVPKA3uVymH9+QEFudT6aHTzMS0qd6/WbxAarZg65mscMS0lQvsqBvh6oEdj2InQy7Qo8SuFZUr7lX1ISfa+niM99WivjGM8a9EJxhDwIkf2Sg1cnCQywxjVIqxS8S5IOdeXske2v/2Gg6R4u542f3wCXX046YOotsIf8nA9YdqiQPLp1YdghFEjwCHfPwkkZMdnFu4mwiLbZVHX+il9MK6/XDicGq1nPOL4ZbhXixh2Vv7E9wxbVioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uihR7IHTmVr9HVpC1qTOmZZ7H29W/QHkQ59FIYrpWY0=;
 b=cCOn0zSGSzs7tJMJd2g18jChUxOAFIsQeHAD67bVQ/av+wVQT281ynqZ1g9FgqhClK7TMhidabPm+qJDbQNb2l9SLyUtVvvtKFLVcAd5D/CqfGMKxwH5P7S9ekOJOxfRmriI8PK888j79eIoulYbtHrK6XZMWWZeMipcWLzXtls=
Received: from CY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:930:10::26)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:12:42 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::9) by CY5PR16CA0016.outlook.office365.com
 (2603:10b6:930:10::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 17:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 17:12:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 12:12:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 12:12:41 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 12:12:41 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V3 0/1] AMD QDMA driver
Date:   Mon, 31 Jul 2023 10:12:14 -0700
Message-ID: <1690823535-22524-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a278c6-8ef0-4991-2d59-08db91e959ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL9WhEj/7Oka5I5uy+bGWcyhg/4CDWUB2UdzIEkvJLG5OBNcFnTGo0qYL1wekrKFN4jKMZgsiJYrWNfYXzTQMu4ARfrnBBTKHWm2PzB/FdH3gizM3LbsAul65t3dFgz43db+falAeBDSvF3CvNzK6Fh9bq8oj6jW3L+iqo8OiI8D2qPFB9KxhiCeq5YGnS8yzSF4IfvlJalYyYFXhJ4axZ6uvfFeKY7pvAyO4ZZ26MqORhvmsrOLGpeESDql4gU3uTLOzpVrCBYj0WlISonuO3witUDWeu9XvUh8/wy6kFlhv9/FPmdIStsu2uTuw9bXp4XKpl+1CPPhWlVzzdNnXuBQaT8JkGbc3D0lVUdvNfzKH+iU4FAaaBVRqKHi2i58CVn80kk2XvsGliwVZXV7AhEV/5Wdv6N4cEPZrDzyLy/SIAlG/8B0V5L/OcLMufFCxGY8UMh8SAlAo7UQ3t8DorSI2gNf/fl5AIn/ifLhr5K5xzskMk+NqYyclBIeTXGGT3Ho0oB3RZv9IN5jUmqFn6jbMZcdwIzIIspOwKt1+WWSrb+SraSLGtN4FCi4Y0bVvJ/Ec1MueJiqA+GsJuYp0wnNKw6oupN5nfgiRUNKPUky1RYUZZzGD2hF1Ar0U1+uYF4Wne7N3tzKY5i/tnyUAqR+iP7nYcW+naP0gHRQKPEsCBKEp6ZI4996u6CY6WTq+OvNdayd95B5QOFnpdMQ53kxVnw8SaFJJ8EbS16YMThuB39nS/eFhH7nrU+663wm7Z3tTi2OjNG4xPFubYWI1FdjRlHA0rRoivX1FvHtsZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(54906003)(356005)(41300700001)(81166007)(70206006)(70586007)(82740400003)(110136005)(478600001)(2906002)(6666004)(36756003)(47076005)(36860700001)(44832011)(966005)(26005)(83380400001)(426003)(336012)(186003)(40460700003)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:12:42.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a278c6-8ef0-4991-2d59-08db91e959ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/dma/amd/qdma.c                 | 1189 ++++++++++++++++++++++++
 drivers/dma/amd/qdma.h                 |  269 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 8 files changed, 1591 insertions(+)
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma.c
 create mode 100644 drivers/dma/amd/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1

