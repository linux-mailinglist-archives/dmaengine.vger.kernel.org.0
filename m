Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA56D7719C2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHGFzt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHGFzr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:55:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919761738;
        Sun,  6 Aug 2023 22:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF1YtN/31VOUPEWFv188X6FxB/OsRNne+L4qYDl99eIsCho04lOfzd+euqdvwbrUHrmyOm6fTI0kdmYz2hqWqqSF8PGMp6WVhi69snptXN0iBRMTGuEbE6zMh78EoDwKH7j8mUkglRlYsA/05yBFPQn5FjpIeYWv9IMBJpyoiacpI77DtMArUoJBg0m82s59UUnp9TsYnNwK8Il1ellBOdgWe37WTydojm3z/zi7flj6XEwOeCVTtP+CRYiAKGfBQYCxBeNIQDUWWyoWM0b84fNr2myzfJswdA/pr1YUV64VzbIh/U/sUHtZVRyeT/asa31QkHK8EKplVAaEm59vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH5HNF3SYI/mo7vTYwjLBKWqRKJFhjR9igkOvw3DC7w=;
 b=UzdRCZRNAy5i+E8AAnNDsF/ZbLEYrT0a/pmoqZ1tXlTpf/WUa03rKWCJI5Xgy42ewshceoCDTQafr6R6m0/ToaHvfVJ4s7cQBZyijpgpJKl6K8jjtBmbyjX/9yBZO/SId+0a9KePu3ZUMfm35NSR7PpZxON4bq0gN6sDab9Aw2MtawYnsZ5ooNVtTFmjg6yFKWWl+Y9aGAaN9SElQA/HhwPr9dOvEXvwkElq9ZPhvINQ1sC3lJGTwr+FToDccX/P4laeMqqje5QLlLLaYJzqMNEbaICVU0qN+RP4HDmK0RdZzU6E2D7n6N3qhM7FNu1HPsR7hL5KFTMY6wZOyxtUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH5HNF3SYI/mo7vTYwjLBKWqRKJFhjR9igkOvw3DC7w=;
 b=hZy0Pgxprpiveow40xiDdRTX688/aBinjuCPweYfs9rSbUUzq609agf2o5wlKeQjn06AkK+aoJF+7qX0ALpOlg3/zcAxMyKhOL1o/Y+RDCUlia+rr8RoK0uc2Ho+h4ztm77or3SEdGRcVklo85JZ86ZA3YOIfmDf5C2DFC+w7QQ=
Received: from SA1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:806:2d3::29)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Mon, 7 Aug
 2023 05:54:06 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::48) by SA1PR03CA0018.outlook.office365.com
 (2603:10b6:806:2d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 05:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:54:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:53:05 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:53:01 -0500
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
Subject: [PATCH net-next v5 08/10] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Mon, 7 Aug 2023 11:21:47 +0530
Message-ID: <1691387509-2113129-9-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b521e2-6287-4683-71cb-08db970ab5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpQ6tFx0hgmQvmbwyNjxYG+I8lJT4Sw22l7a6ULPVphM3VN6Rqjm0fUrO3PuRRCVNymYGKOFbDli3V5hEqg6qoA0MJtvf/YF1/Qz15rAkTpJe2QNwXj2xjBlNv+5MRYn0Nxyz3/1ozmfOYhFSf7fA6P4MtoKmzAQ4Anfjs6lDiLVqLtQQX8GfTySLRyCw+8Mz6mHiyhn3VGeZB8HR6DcPtcIrPa4h0luDdodyANvLQRVYDtEPctlRbQXIAEPc3HjHhMGptjEo5hHw1r43nRrv238eWPpeMJITzS43AjHYInS7JLlo1Je0tZbV8l/Tf9t6eOMWmTXJd4e587gDae09VjGW43aDfO9NESduvrEvjMFnq/dyd7tkDVWS36lqYIcup+KhgE45V2JyIlg9MfQLbs3pmsDEuv8400DnHK5uR8rJd1rmRpbkdYWHHYxlNDx2kNK3fOLZJULo+caoBl7IoZnNigZ9/JLg6wFkp+IpT9Gd8CnnDQUJ0Tz/Jwh39LYx2o+XfXwLx1rI0B273HVMWNeENrh9XpW7Xi6Khg1joEQ768gF3yrTTsos1+pwNG1uA8d3/zsHSeO48jDPKheij61Bdzpqw2p8bXsw5uNRUvBu3ECLBvego7QtaeuXopnCGzF6gC1zv3P3is5OOSRJmt7LsDZkpY5/FJRRHLI3CcqXAT/RjRDz8z0O2m4LxDOQugzIZ+KFfsjHZy6Blzloh1QutwqtTOvZKS013NX7p/95L2h1fcel63by0JY5u0PX+okfv3DQyLOLkUVtRoTnNS5yARygZSWtEmVjfexo2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186006)(1800799003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(70586007)(70206006)(2616005)(426003)(316002)(4326008)(5660300002)(40480700001)(40460700003)(336012)(41300700001)(7416002)(26005)(8676002)(8936002)(81166007)(86362001)(921005)(6666004)(110136005)(478600001)(82740400003)(2906002)(36756003)(47076005)(54906003)(36860700001)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:54:05.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b521e2-6287-4683-71cb-08db970ab5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Xilinx 1G/2.5G Ethernet Subsystem provides 32-bit AXI4-Stream buses to
move transmit and receive Ethernet data to and from the subsystem.

These buses are designed to be used with an AXI Direct Memory Access(DMA)
IP or AXI Multichannel Direct Memory Access (MCDMA) IP core, AXI4-Stream
Data FIFO, or any other custom logic in any supported device.

Primary high-speed DMA data movement between system memory and stream
target is through the AXI4 Read Master to AXI4 memory-mapped to stream
(MM2S) Master, and AXI stream to memory-mapped (S2MM) Slave to AXI4
Write Master. AXI DMA/MCDMA enables channel of data movement on both
MM2S and S2MM paths in scatter/gather mode.

AXI DMA has two channels where as MCDMA has 16 Tx and 16 Rx channels.
To uniquely identify each channel use 'chan' suffix. Depending on the
usecase AXI ethernet driver can request any combination of multichannel
DMA channels using generic dmas, dma-names properties.

Example:
dma-names = tx_chan0, rx_chan0, tx_chan1, rx_chan1;

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- Modified commit description to remove dmaengine framework references
  and instead describe how axiethernet IP uses DMA channels.
- Fix "^[tr]x_chan[0-9]|1[0-5]$" -> "^[tr]x_chan([0-9]|1[0-5])$"
- Drop generic dmas description.
- Use amd.com email address.

Changes for v4:
- Updated commit description about tx/rx channels name.
- Removed "dt-bindings" and "dmaengine" strings in subject.
- Extended dmas and dma-names to support MCDMA channel names.
- Remove "driver" from commit message.
- Use pattern/regex for dma-names property.

Changes for v3:
- Reverted reg and interrupts property to support backward compatibility.
- Moved dmas and dma-names properties from Required properties.

Changes for v2:
- None.
---
 .../bindings/net/xlnx,axi-ethernet.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index 1d33d80af11c..bbe89ea9590c 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -122,6 +122,20 @@ properties:
       and "phy-handle" should point to an external PHY if exists.
     maxItems: 1
 
+  dmas:
+    minItems: 2
+    maxItems: 32
+    description: TX and RX DMA channel phandle
+
+  dma-names:
+    items:
+      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
+    description:
+      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel
+      Should be "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel
+    minItems: 2
+    maxItems: 32
+
 required:
   - compatible
   - interrupts
@@ -143,6 +157,8 @@ examples:
         clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
         phy-mode = "mii";
         reg = <0x40c00000 0x40000>,<0x50c00000 0x40000>;
+        dmas = <&xilinx_dma 0>, <&xilinx_dma 1>;
+        dma-names = "tx_chan0", "rx_chan0";
         xlnx,rxcsum = <0x2>;
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;
-- 
2.34.1

