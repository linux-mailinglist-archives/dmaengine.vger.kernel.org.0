Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5227B5BD85F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISXoI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiISXoH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 19:44:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2944BD20;
        Mon, 19 Sep 2022 16:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEb+6RZqm3gaKlDlfWKEjX8Tv/aDqHkUYr2U5AeqOtjCVcYnK8o04qyph9TfTBWZy0Kv5fWVg5xfXzHsBqQMbc47hVwIZRJ8B5KqFwd55ld2sanBmfpdZ+Px2ewYfAA9qT2u4OnpTNZo9tJiH1x+1HsqLyGln9AQAnkebbEmD8s0Hq8UPAtFyp84Iz0Uh66V49vop69kElWPv0AFdsa2iyUsWqrdpf/GpU7K1PR/BAK389B6HUmJmszX4p93Xm6gEDMJU419qKCT48vPfDLiHArIVmC21ex7kKuCwbBIqdk9tciSID7VwHhZYOMy0hYDNGASGdWdE0D6ac7Z4jB9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofc9wLdGth2YV8bEqXIn6oEMn6gekFrm5ZfQiIzrTUM=;
 b=mghB/GozO4vINzksguDPBZ4TiHmqBH/IInMxq51U5txC5XLlBSrVOHDQBnM6U2MfSbpwjhztDZa+Qafk8QTQGB0W3lpPdWXV1i4zNRFCRVaQrKxOzifEkF81SWPjGxEoEl5mWSQ6dDJ/xtxoYSDwbkLEbBFqxiYC3Mp+Ux7MbN551P/oC/kzBZ9jTA3MxhuEZwLBhAZv+mIgfjtLVIP9tv3Tagm0Lwa2A2w8dHYEwSpA4fZeG7VkTwaatinhJzUyxnQYdoI3IxLoj/MDRjEP0g9hY6WOfXZapYb905GZ+fRM+5C3nMzRG3VIXUuvySS04QBPij/NtI+eYiDenHyWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofc9wLdGth2YV8bEqXIn6oEMn6gekFrm5ZfQiIzrTUM=;
 b=2+zUiM4VKzBt6cHpR5+09NnuDNtJ8/Id7ZZKQKJw/DdllUjNbXNDs+4mLLZ81+7V0s50YCFJdozaSUzvtEpZ9jdDq+XcZzAg0Kio8S2vD8h/AOf2W3mgEqRh5Cl6LIR6Mp7DKoG1BTFOM4t+MDsPdKzQWFVgBUyWPGhdj595OMw=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 23:44:04 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::93) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Mon, 19 Sep 2022 23:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 23:44:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 18:44:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 18:44:03 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 19 Sep 2022 18:44:02 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
Subject: [PATCH V3 XDMA 0/1] xilinx XDMA driver
Date:   Mon, 19 Sep 2022 16:43:58 -0700
Message-ID: <1663631039-49732-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DM4PR12MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: af7b95c2-4fba-4525-7e5f-08da9a98d5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bj0gNWjMEVuymI1tDjO5VzHgs3vdSU+ArI2VeQfXDjuIWBnS8qyZ7D5lZCZ9BW/LRceD2+qVTR3ELL9Uz04DkXehFC+DRPcXr7Ey/SAxzKWx2xh3dXaVT52ldSIANPpgoDXL0jHG9FhsmDa1PsV3SY8V6utPrMWwLbZT6TLV5UtZIoma279NKOadqricaPsH/TzML4lQbsxerA+FEN5PWZaT7frUQBC0pcJh1PFe2uQkKMmZShQElIcvh8Xb0+1y4xsXE4kqAwlzO/Qe2ZbFte8kjzZSZ4arsxEpWn998L7KesoHB03XvawierkJ/5OKeaplkL5L65fjNpCdCCxYLfZY2KTzu9KaJ3TzMOvjfUF+7Y72DJn07psTLmB5PW3scdSgoWFGodQQVwwL4nuXb0bWjQ1wFOnWkHFMVUfyY8JTPJYeJlOpxWFf1RM4/tG1M6elH19sgvVRiZZVici6XHfACHJJd8y/zmMTqjSR4jng/OP62fSrORJMg1ww/PZpNAz/Tnv+ztKfM+kSd2Y9zn1EftMaqtmyqlEjYwj6i1kqNcNg4XFP8oCe1f9LJA22GFjARt+CneJbCeZu2/1bpj5hc4WWJc2KGDSNPdJCBkgh1nU3MfpAtj2H9q3rAs7g0MufGMgsQjkUb8nZdY4Fe8xIAU0ywK4iq/3FXec38yPGCoS/VZD5imY8XNyOFXtoYRfxP/8VnLQREfc96A/EUGxIFHeB8WrRLAkPEO7iuZ2B0wUqMQBGlj9RG+7wa1Z+yWfIY0Oj4HYv6EpM9fgxK2wBXNd83PbNYhjZzK/zEYiW7SM90jGqgq5sJ3yTwwt3nil71ejecIqhcL6CrLJnyUsTWyPPTw/m7OiT8Gb1KEtx7gDFjR7dcnw248PjhU9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(70586007)(70206006)(4326008)(54906003)(110136005)(86362001)(8936002)(316002)(8676002)(47076005)(426003)(82740400003)(36860700001)(83380400001)(6666004)(41300700001)(40460700003)(966005)(478600001)(2616005)(81166007)(336012)(186003)(356005)(26005)(40480700001)(2906002)(36756003)(82310400005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 23:44:04.0469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b95c2-4fba-4525-7e5f-08da9a98d5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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

This V3 of patch series is to provide the platform driver to support the
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

Changes since v2:
- Removed tasklet.
- Fixed regression bug introduced to V2.
- Test Robot warning.

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
 drivers/dma/xilinx/xdma.c              | 965 +++++++++++++++++++++++++
 include/linux/platform_data/amd_xdma.h |  34 +
 6 files changed, 1194 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

