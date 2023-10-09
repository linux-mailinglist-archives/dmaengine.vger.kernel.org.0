Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE97BE48D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376698AbjJIPVm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbjJIPVl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 11:21:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15FFAC;
        Mon,  9 Oct 2023 08:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpFrn56fkbtnxpzpT+a/L6t7ScG5s/uBKTtXwe0gdLFwjLMMh5PecLbpBsjC5v4yTO1NWFbotdvOovlrHI3xoo5BhWQv4rXBWREEsitcNUy2TbruTHLyQixPSXnbbcoyVRwXXxLc0nl+W9ArVnBQUiZSdsZ2hVDW59Iy3JFe6Yplw7xFtDFVMpwJgI+sBK/gKLfWHh61CQ7VtH9lxCOhWkzcMUovmeBNh7rsTZJfMFg6WMYBKKRVCP8M1/x8wcYQul+RIcHj48rIEc893WQ+7/y2grmPxusLpzMpyyz48rzBpBBvniycPlIy4YeJzPbAjpjII5B7yKujdWlL8S3FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCIth2Las1+uw4+thf2SGEd6Q7ePhxPXETi5zczTJE8=;
 b=g1VXhQt5IUexQez6JQYxj/F9NZAA7YAX5r5R4GIisQl1gTEdxshDFA1Uq9Jweox7xBzLA74aKREmtABuAem6dAgcFWx1tD9/kUag4+zfnB78fecmwz4kXsAqdbdKGWNlYRn1F+NJM3TkkcKw1owOI27a22flqYWywvYjI/PqrhxIunlP3LpM385L/zhS287fmaUqVnqUvvS5PWG52I45QnvHXMVczu4QGqSpbiXW2nFwxu9waYn7wCyZWLV+jCwToS/mV/XxkGLiPQNF8M94AyOcyVN6WeBfFAOM5QGwx3ob0p1EXWV2qXwQjSpgk4YhZ5GZzlP+p1P3n5wHVcwvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCIth2Las1+uw4+thf2SGEd6Q7ePhxPXETi5zczTJE8=;
 b=BXFoLnGD/Sd8sC9X87E5CAQLZ8gkOxFgBJXDZyMvPC/nxYQM7xjcEE2ZUmrqKCJO8vojcE+l58NdeElcKfXIGRZhwRs/9uPZ/HQDnjGLr60KpfHG2I7xlNE26gMTiBYl2yI1s5V2NPJUtr+cuTLLeLI8tnM7fShC4X67Nl4IXa4=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 15:21:37 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c3) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 15:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 15:21:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:21:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:21:36 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 9 Oct 2023 10:21:35 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V6 0/1] AMD QDMA driver
Date:   Mon, 9 Oct 2023 08:21:33 -0700
Message-ID: <1696864894-4860-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d5fcea-1869-4300-e876-08dbc8db6e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKnvvzhY9zSoO0Rze7TaIhH0gJNqS8zmNpnyK+SqkwTKZ7vSA6jtjEBxGoLz4RY3pxU3GoHPdW0LgvjpKStTLK+AlajghOULO9Kp6s50H57mvhRGvPTF/CjCFLItJhoTqow+p3wGe8R+jEM8ixX7y2GyKatS1e0KllNwXHEy2ioCV1AepDgruqk134F6wEJ2ooJ/rxEYp/6vqc4ytTpmEJIGB2RAZUzQTCC/TokUydmGsdtqqBpSsGoIltWtsRpfjPe8A25oXgLUNe83JN132mLZWkyq2XQ2TetUncAGA+cnh+xupmkl0E7FyH2esAJbTOYiRihPrLYFRrRgT69oRoYMIh1UcBRDX+vxowaxYKe4jiEBLHBw+DHoFT1d84wmlzs0ahvnKC8CNzupz7zk7y4TA8WT5ahm2Ex+gzh0Ii+YGW7vbblXAmfb8l7PCwnxKpXI7BRinjN8hcQvQOYIq6C4CM7ueDtT0ZIARcb4rb4+CoCxLXZMUi2DrDE042MjXL8dZHgc8qbVFI73OJwj0E0Iq4zxc1el/reDRbpWjH/hnbkUp/hdaGz7cqX65zrsDYYEpPcgkJ0pPOYZE90wNFqwFLmWluB2SzsVXnbtjIIxFLMo3PbDzXh945HKp4SpZSPgsEzbpxj9PciD1kAzCb2fZWCp4LCMCEC3KggxDjI1nXw83p3EJB2jVY3hTpLZdJepB1KhQ+KvfUELL66CTV9efJQ8f7KTtn3ZpHTCZi1SOXQm5WIuEIGl32lsV7Uiyh4ohZ6sgMyYGcnr0KCqU8jZgORUWG46LU4gjjYjlQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(2616005)(336012)(426003)(26005)(47076005)(36860700001)(5660300002)(316002)(54906003)(70206006)(70586007)(110136005)(44832011)(8936002)(8676002)(4326008)(41300700001)(2906002)(966005)(478600001)(82740400003)(36756003)(356005)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:21:37.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d5fcea-1869-4300-e876-08dbc8db6e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes since v6:
- Minor changes for code review comments

Changes since v5:
- Add more in patch description.

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

