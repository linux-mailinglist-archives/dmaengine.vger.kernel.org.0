Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046F7719A2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHGFwx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHGFww (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0881708;
        Sun,  6 Aug 2023 22:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTVDUkyDaREjVhi9oFfH7QrbRink8zNan7M0KldD1pC5RfsSITWGEL0sMdywc44KrOysmBm8E40BKJhSMchulovzOLknVY6UgLq34AV3JdmHhl2xycWvb9p59HGJ+p6ZtNFMp8eLe02PuTjn9r15gAhFqe6e1LEzu0Apb/1C8IDA/V0wFSkHZlaGwl2MxZId3VRXbDTARsBbZZLhDtdcsdLqaPKl7VGehmw8ezDtsVAHY2/gq8vt4BqMbEPSFFMsoR6vgW7g1u7n4zjtzfHT+Mkm8ZHtqHITap/D7RmY6i2E7x9ZO0uaOcXi9ujqNXd0W9csrf8Z0Ll55brlyNATag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1BcLQIjOQ8tbltc5V5QqZ847OyGNE07UJWyIqHHuCM=;
 b=VhFK9N7mxo5EuGqHk5msWqzYEmSGsU+e2Ra7D9ceeOglD9f8QfJXCMieHKIweGD6yIp1PHjGe4c1zS2fauycnnPuWYXdK0CnZgX4Yu6c57ByWrcDs8skfbeeyjTzYK+4Ex1g/DOTB7mnI3PeYFUqQwIVDkSRrwdWQB+TEZjTeradked8PvEMpzkro007ViZTIBMCzRm18VQoxxcZwbm9i/xZLHkeQ0KbHtBcLRJK31UBodJYaqYsU0rh8EcLzecSrhkymKWuHmuJkgMKkrxVT2y6lOD1ouGA3q0LmD5tCuSaXO2ygqFamLIbCU9ATJSsbCHQnBQMba5gao0M+Tq4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1BcLQIjOQ8tbltc5V5QqZ847OyGNE07UJWyIqHHuCM=;
 b=wwiGLFTRA/BacLyjrsGHx1pdddG2e3+HDouazpBeeQFL9aBa2D7GYbqgsAQPDuBjxCtC8r709uNYm8fLpz36z+gHbLtjYgW43b89aBv3iefoXmXr4ZUotRa8gPaAjkXnPR8Q9vo9pgUSytcS5sVThq3/gYnGjUoHYKjBdrK58JA=
Received: from CYZPR05CA0009.namprd05.prod.outlook.com (2603:10b6:930:89::26)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:52:40 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::2c) by CYZPR05CA0009.outlook.office365.com
 (2603:10b6:930:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.15 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:09 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:00 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 00/10] net: axienet: Introduce dmaengine
Date:   Mon, 7 Aug 2023 11:21:39 +0530
Message-ID: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b7bac7-7e3e-4aeb-a7e4-08db970a8433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1st/JGOFzcmFhtsUICIW7rm0ZC99JXZzHOda3WbsvBOWJ16rsd0B2Cz4Twr4hYhmK8ocIHtHku11HTEsz7soG8VOS+VJoOoK+oRTnz9/KNSDCXuky6NXwuWG7mYfs5WpDpm/bugjWQXcpDTuTFABdANfVPJhdhLew1tIz3GXXDEaemosVE7Z66W5lcPZQYC/8EEbpsr8OlDHrhudpMrURoE0tZ9251bPqJll0SbdkIQU3S1fXWflQNvzaSjg+H4NGvyZbzPJswXiuoZ72YNt7WkIpOaAtumGr69rLQSPAsFKHwaT2YNRrCriXAGsfckkR5UjqqaEbfZHHDW5xYux7VsMpHbY48qLNbcK0xnAS0mnAueyrK3a8JvVO9sBBODejVBBYt5/Gd8Ez9hb5hfHS9iAgk1OdkoEeHZaGNqtz6otlrMVmFDMGB+Gqpa/qljRk/zvRAMB4kdorE64RzmVAxdrWbFOcFZColaeJ7UIJZcCpR5h+g5pmZdLtiDNsmpYW62fYDO3ls3gQVxTkffl6tvYfbT7hmdHlJDHW1+ickg7aEKysKWOBbVfq3a5b9nvdnNwGi/XqcXslTjXVDh5LDgNqStfwo4ysuX/ciJ5sKbbKCXltuCROAQzFZZH97GFBSVXh10GDnMRKFOcQ6LqCRkExJqB3EK9uA8/O2jMNWQoqieItcwKdPBCPhkuEYwRY88CZUVqAbBDiVOrLCFbjIDgK90t+kEnswg0pmjqCUBiFNTRChH9PyCpWuBk2VF5rDWAxN8Icun0qrGLgG5zxMA9vOUUMldxkJ8FxuWCRbqm+KMckUAf5RbyUy334nOM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(1800799003)(186006)(451199021)(40470700004)(46966006)(36840700001)(426003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(7416002)(66899021)(36860700001)(47076005)(8936002)(8676002)(2616005)(40460700003)(40480700001)(336012)(478600001)(81166007)(86362001)(921005)(316002)(82740400003)(356005)(110136005)(54906003)(70206006)(70586007)(6666004)(966005)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:42.5408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b7bac7-7e3e-4aeb-a7e4-08db970a8433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=3.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The axiethernet driver can use the dmaengine framework to communicate
with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
this dmaengine adoption is to reuse the in-kernel xilinx dma engine
driver[1] and remove redundant dma programming sequence[2] from the
ethernet driver. This simplifies the ethernet driver and also makes
it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
without any modification.

The dmaengine framework was extended for metadata API support during
the axidma RFC[3] discussion. However, it still needs further
enhancements to make it well suited for ethernet usecases.

Comments, suggestions, thoughts to implement remaining functional
features are very welcome!

[1]: https://github.com/torvalds/linux/blob/master/drivers/dma/xilinx/xilinx_dma.c
[2]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L238
[3]: http://lkml.iu.edu/hypermail/linux/kernel/1804.0/00367.html
[4]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com


Changes in v5:
- Fix git am failure on net-next
- Addressed DT binding review comments i.e Modified commit description to
  remove dmaengine framework references and instead describe how
  axiethernet IP uses DMA channels.
- Fix "^[tr]x_chan[0-9]|1[0-5]$" -> "^[tr]x_chan([0-9]|1[0-5])$"
- Drop generic dmas description.
- Fix kmem_cache resource leak.
- Merge Xilinx DMA enhancements and optimization[4] into this series.

Changes in V4:
- Updated commit description about tx/rx channels name(1/3).
- Removed "dt-bindings" and "dmaengine" strings in subject(1/3).
- Extended dmas and dma-names to support MCDMA channel names(1/3).
- Rename has_dmas to use_dmaegine(2/3).
- Remove the AXIENET_USE_DMA(2/3).
- Remove the AXIENET_USE_DMA(3/3).
- Add dev_err_probe for dma_request_chan error handling(3/3).
- Add kmem_cache_destroy for create in axienet_setup_dma_chan(3/3).

Changes in V3:
- Moved RFC to PATCH.
- Removed ethtool get/set coalesce, will be added later.
- Added backward comapatible support.
- Split the dmaengine support patch of V2 into two patches(2/3 and 3/3).
https://lore.kernel.org/all/20220920055703.13246-4-sarath.babu.naidu.gaddam@amd.com/

Changes in V2:
- Add ethtool get/set coalesce and DMA reset using DMAengine framework.
- Add performance numbers.
- Remove .txt and change the name of file to xlnx,axiethernet.yaml.
- Fix DT check warning(Fix DT check warning('device_type' does not match
   any of the regexes:'pinctrl-[0-9]+' From schema: Documentation/
   devicetree/bindings/net/xilinx_axienet.yaml).

Radhey Shyam Pandey (9):
  dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected
    property
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Freeup active list based on descriptor
    completion bit
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase
  dmaengine: xilinx_dma: Program interrupt delay timeout
  dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
  net: axienet: Introduce dmaengine support

Sarath Babu Naidu Gaddam (1):
  net: axienet: Preparatory changes for dmaengine support

 .../bindings/dma/xilinx/xilinx_dma.txt        |   6 +
 .../bindings/net/xlnx,axi-ethernet.yaml       |  16 +
 drivers/dma/xilinx/xilinx_dma.c               |  70 +-
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  10 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 622 ++++++++++++++----
 6 files changed, 591 insertions(+), 134 deletions(-)

-- 
2.34.1

