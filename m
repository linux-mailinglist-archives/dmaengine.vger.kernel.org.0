Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A962863C
	for <lists+dmaengine@lfdr.de>; Mon, 14 Nov 2022 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiKNQ4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Nov 2022 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiKNQ4b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Nov 2022 11:56:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034A31DF1;
        Mon, 14 Nov 2022 08:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kynOvHzkFUDb9KbS06dYq73bycu1kkVHSPkRAT0S5f5kD9yKfXa3Vs5iKhFjRiLe05KTI6QjEim3lDT8E3ytFCZyjH968Fe2jUpFAhhjmTBUeVs9dHSuv1DsGPbyIrSvdV/tTqLYwSv5MtWG7vboIRAJWp7CLXCKG64GA4nWWyTJ3rtUnNmTjjZanGGDK+kxKLxrD6HLhV+QcVFNVQNq9Q7eL0SgcvoGo+vuIPtXnuEAGphvpP45gNnw7JzGxKSwFJ4Ahilldql+z5a85vWRCbEJV0qBIE4O8QNjSVHzcMWydLOC6ylY7coLVzPJplIOWb+fHMjsm77ZG8WIUtWWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=cpGFpQrR7LJtgfQqxBvnjU8JfoA31vx9lNhDpVILI+6deqVxt1Ow5qscuOwbICcvc1FDx3C+6L+u4SeHMCW+jGZNVZxtMiIjMj9Hy2MV48+M5n2DWeMQy9zizO92g22eGb6vTOUoKeuPM3C2gpd/NppA3jWVUhHMmC9w7/JkEIOixn/Fy7fka8kfIEUmBUefL7RraVLzLay9aDx4ilZeDvBCSHMa6GqHYIcdmGllTRfu/msX3dfjQbauv7Dl9GRSD+9jPfR1Nr/WpN/9W1qmTmfvj/fYvosVh9BLQXuw/9LqecbZKGHWPmX8ow9wXWss/eVldTobESyUWQL6Bbp4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=NJQ8+f7hY0AAlJDsTIKGEkFnAJS682Es84g92cnEHt+ywBHHGjiOlD144NQ/jCclfL7oQBhxXim161258hMS+Au0IGLx+jnTK2y2jdlP7/4IOuM5OjTlKZNpKdSHPGY+ZDhQBoBrx87kGKlZ+y02ywVk5Yz4FBDEKlOBc5jU/9A=
Received: from DS7PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:3bb::7) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:56:07 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::96) by DS7PR03CA0062.outlook.office365.com
 (2603:10b6:5:3bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 16:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 16:56:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 10:56:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 10:56:05 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 10:56:05 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [PATCH V10 XDMA 0/2] xilinx XDMA driver
Date:   Mon, 14 Nov 2022 08:55:50 -0800
Message-ID: <1668444952-20947-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0a637b-d09d-487e-75ca-08dac6611fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDz9fBWJtPUncH6+I7Ew9R2ABVzQvlQavmZpj48Otl6/4poh8dSmvkwGY/VwtQuQaMl2SgHE2aUm5Tv9fXPAGjhTe4E+X2+eg8niD7DEu3y/3Yqea2kqkWiktrwXqslaLYpLUPGMWllUiDPPlHRAMpCFK2rWsFwgvlJLBseRNcpCT69T0CUNTtlmc4mjqiy4iAazhfYENtrJI++rWuiRqUimCkwikPM2ouBPwIHzTdGG68iZ56HAuqWaLJJSa4TPenl0UcI9PR99N4oBSqQVfwh0zLBsL9XuWnJ/BtVxX1RLwM1F9MSkfFnIsGbAn9RU9+B2BFgSuSQjbkZ8MWJHT8NM1kcgeR266Dw6XPI5i1LUKTgxHY780DFnhFHLDbjxdvk2L8bRxt0LV4FNQFDxyaNR55d035n0fb4vjwSDjXDhPTQsB/E1Z8KFFxNIzAojAEEO+CS0TGfTrNn703pR2MWG+eD/AkUCifpEBc1EYnWnNaeaGpv77Mg9uqh/vrhQzvYoLB9Vr4/miLOGeIXCJeT3myMepdMogTafpWVf2oFgxSeKwB97yb6eUyVHqPjXKNeP6WuvVu+LhracJR83MYuleUrBJ43OU6PHXTf5goG5aYImHTP4sb1L6g7+EBJyvnl7h4O7BiUK0+wG80rcnoF2W+EU+zScl7/t4RLe9rPPQLfM/As125MshQVMrDY5PyxoGUzdsY2HJiX1rGpyClIfkKOSjy90F86wK0IUoomCOfpa/jMUENOi2mXeRzHgERru+GrQu11o4QqwDJpdanmhdNlKDQuY/RIeBzcpLfWix7HJtVBq4KGHvSevcKbsvDrPIJxrSJpK5o8F62fcQoYHm3swdmhS9bTzm3N5xifFmvSZUv/Lm3uDAlKkzwZt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(86362001)(82310400005)(6666004)(478600001)(36756003)(26005)(44832011)(41300700001)(8936002)(82740400003)(36860700001)(54906003)(316002)(110136005)(4326008)(81166007)(966005)(47076005)(426003)(186003)(336012)(2616005)(40480700001)(356005)(83380400001)(70586007)(70206006)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:56:07.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0a637b-d09d-487e-75ca-08dac6611fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

This V10 of patch series is to provide the platform driver to support the
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

Changes since v9:
- Cleanup code based on review comments.

Changes since v8:
- Fixed test robot failure on s390.

Changes since v7:
- Used pci device pointer for dma_pool_create().

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
 drivers/dma/Kconfig                    |   14 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  173 ++++
 drivers/dma/xilinx/xdma.c              | 1004 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1253 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

