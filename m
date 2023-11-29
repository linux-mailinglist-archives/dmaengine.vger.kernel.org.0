Return-Path: <dmaengine+bounces-314-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28787FDE0B
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ACF1C20905
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4714AB9;
	Wed, 29 Nov 2023 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LXnuKl86"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF0BE;
	Wed, 29 Nov 2023 09:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBR7WY7MyaCJ8wGiLUr9EXOmne+7uSGfpg50V7I87IR5zwsa2Hd+fv8EwK1/MU9xyVTAPjetBOGHvq0BorblIx+cHS9t3C14EOGXCNwKdrFIJEnDIHR2yCg4D3yOeU9s/c0K1vbXIshziot10RDz65T26klzV6NUKfI9PwKvBAzkI3Ei3KcBuzmBzh0XIFlXO8h5yRl/+iTvwwVKbtV+6IFaTIO5jAaqZ5WrOhSK+ynXBKNNVZDK/QqyuRP7GP+/7gJ4zZIhpBe2deGUMBJaaVveqAE+tEdBtSU3GJbLmYEXM0tftQE0lVvm7oLt6XIvigh4w+e8lRQPSrdvRD24HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZnN9SNB4n7/VcY1jqeLLDYrEV1CGi1GOwI5nZNECkA=;
 b=SUxCsHxedZ8rjzb0CImggPFf9o8Bu6qbLEO6LOaAOzyCYupWEAg1A5vzgxEwpGW+/ZaqV+Z5jQMrfuURKOpdxOGDISpXZMZaxFiOp99dF0Ae39aCFst5Lo/RNDLMxvyjIgZxdiRg8rh7c3Xbf2MHb3Eo3o4jeP1bd764ChxcpCK8W9QjQIDO+htEJ6JT7HHdkUoeqrptYiTBoSSf6HQGmlqOu8Pmjiglp7fN8PMtie9d4C8CHe0ggf0Co/hGEkxk1TuJ+qK9BFyHNeiJ05KUeJVbA/KbEiu/+G3xLKB6aPWF3Xe5jPGhWYH9ge/YgAB5Vh/90RwpoGVqJ2FaJIBwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZnN9SNB4n7/VcY1jqeLLDYrEV1CGi1GOwI5nZNECkA=;
 b=LXnuKl866btKOkE0su+BTEeoAnE2N0U4fPeImPFLbylGcvnQrfUAX/Yh3pAkhPySzybgS93Qt1piAG6ye7g7ziPunUpN9NYOWaiWKKxfKNyiViatdm86ZogQkWBFbDxnLU40U6w2hDeOna/EsSK/nQUAHaNXZzLnKlMF5ZTbI+0=
Received: from CYZPR14CA0046.namprd14.prod.outlook.com (2603:10b6:930:a0::14)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 17:12:57 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::3c) by CYZPR14CA0046.outlook.office365.com
 (2603:10b6:930:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Wed, 29 Nov 2023 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 17:12:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 11:12:54 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 11:12:54 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V7 0/2] AMD QDMA driver
Date: Wed, 29 Nov 2023 09:12:18 -0800
Message-ID: <1701277940-25645-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: f89f03b4-30b2-4ecb-a65e-08dbf0fe6e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	crdvj0VSZqG+NAYjufi2xxV14Pghl73DCnIucYyqLBggFL0p4PblEB1GDqH8qPX6Vxe9ISANVY2pfmfYyhZIu+KmOXweOkMkY6zfxTEbUGnaMr4Xuml1Vt0dlmfpyyqwQrScf2zC9H0NGpIeZecMY0XRg3s5lSrud96DKNSY4K9gAYkJpSPSS/yGplyUX/pgoXlpEybqshbe/oo10oYne6sbp+WhBql4MzNt5RUlADqi8w7jbuMHQ1KC5fn01HUOHBkiaj8HqVLG7TrLavDUTiWuHpJqjvkkTRf7QxmQMuCabucP/azeViXlN+817hub9T657F0fQi3Seq+WIT7idDctJ2jD+VjWE99e2DFgVYm9wBi9/KqTZevN2Fs9JJMe0LNYClwiiGEkHt1S3Ge6U98sCe50A3PQYqgh2tSyRaaECuHn1t3HB297JXCSWW43MNqn9iyfdyhLLlVvRil0/xpK+soBIBcsTu8PgTA6Y4Qyc2B/vxs+lppPjL/O3uPy7yKcYIlUYKpr3ziGgDPKNX2CCNoYT8mm7QZAR4ODD1lzDmBsIjqD5K+TbxFcJMYi0DLs0A8MH86aL91n/TN94+CP6seAQYwsQsKS8rhlytDiETkFS4FRBFa+uStkGsbPz1yBAIIj4RcW/jrOa9LRw363gg0jNwFro5AqbLIJhOdSMKu589Zkhofa6Ku1CMQSkK1FX2IISJty4SmJ7jpYnfIA05WW+mNL9o9CDBRe7ty+kWIt8dctMAd9xfkuuLoi86rlsdYHh09QyH+bjI1Ocvwz0o60+SPQ5FWUl1IDiQIJQ3V7N2F/x0ECdzvpwiXn9vIXl3Po4qU1bPtkOA2A0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(82740400003)(336012)(426003)(36860700001)(40480700001)(81166007)(40460700003)(83380400001)(47076005)(356005)(2906002)(110136005)(86362001)(44832011)(5660300002)(8936002)(8676002)(4326008)(316002)(70586007)(54906003)(70206006)(966005)(478600001)(6666004)(41300700001)(36756003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:12:56.6871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89f03b4-30b2-4ecb-a65e-08dbf0fe6e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238

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
- Added a patch to create amd/ and empty Kconfig/Makefile for AMD drivers
- Moved source code under amd/qdma/
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

Lizhi Hou (2):
  dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    6 +
 drivers/dma/amd/qdma/Makefile          |    8 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1185 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  265 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1


