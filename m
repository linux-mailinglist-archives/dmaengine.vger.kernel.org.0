Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055C0700700
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbjELLko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbjELLkn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 07:40:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08431718;
        Fri, 12 May 2023 04:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfCoOzWMoDiBubJVH0iAOPbVu0zU35vJxd7YvLpiiyR0iKgV2Lqn4rEmj9qreBgRNwIETrgICEBBZacARk1c0fdt7LdptU/NTPZ+fGVnsPBwj38hSUYVTEharRPg0gMJdgHIMrc2tMD7DZybmIbAMJYIChOmpk4azVX6drgRXtu+lQdIK23BHJMCkNG4t+JtpcXLv9Kp5wGHh02m5kPM+RWsjacS9n3wTs0aCtY5WTHwlWqTlAbdoOUzBhG3O38OV/E0WiMIlKY/xEZIZRADb9cZ3PJdTdEBDjo5gXKqMXODA0Xfvx2He4Dy7PN9cjAaVGdlnzKGIZduDazIUyL7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RO1e1MNOQiwDLgRRKBRobTnqUinqglMRRvmWsmndGQ=;
 b=OliYRuXC0t1URLc6avuJ9LREv/LFWcAYtk2/bZMKfK+aGB2+aSdaI8ae/zbcQmy1MVPHTf9Ud0KjYqp+USTD19lUQzxQt1ujpMQ+ncs8nJvG9CTVPh4uDFzEILwdYU6QMv2NUDIKrBT9g8qQbM2erdLvn73e9pVSnp7SMa662UP5Ybxo21Ag/LTuNKdM3i2MnszJAHpV5B1JcfNZyFhcg7LcWUnxsRkcNtdeIgcHDYe+qlkha02ob6OIqjXr/yApjzHkCDFeFd3YKAnv9t2ESknU7BdxXk4wgSfWQPkNrDVn37vf97I0M6ulCGdE7HKWYeYUinntkxuNBeeCq4Im/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RO1e1MNOQiwDLgRRKBRobTnqUinqglMRRvmWsmndGQ=;
 b=4GaxmPqKTpbRD9I4OSrb9XZixRogzo1V7WUAnHijmWR1+SMXFHyeWzLe8UaPHP8q9SFaZcxN0aNe9SYmG5mnF3xo0eBEqCJ/4bOdjE7PWF5uu6uVP0oaZzyDJyupbpJZotQnKXJtIfjvrnNHfY5NHfI5dVyeuFzX5moelPV5UMo=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 11:40:39 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::1c) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 11:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 11:40:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 06:40:36 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] dt-bindings: dma: xilinx: Add power-domains to xlnx,zynqmp-dpdma
Date:   Fri, 12 May 2023 13:40:33 +0200
Message-ID: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=michal.simek@amd.com; h=from:subject:message-id; bh=CIzqKqEHuEC95EL4d11sbyDsplKRyRHucX4oxoB26zI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQ41Vlf7iwMffAt28yIf968sOmZx3Si2TTTjQxN3h6X7 fj3pEG5I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwk6zXDPLO8nf7N5z6VL9/y QXMiR1OywYPz1gzzDM0PC5YUe0+5uj8m6Kt4RZy106dlAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|BN9PR12MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 097abc62-935f-4cbf-e5a2-08db52ddb577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6p9LjLOKUqyVt5UKq6BBheBA4u3aUoW/TRx7c0nJ+FVpNjBTDJAfN2ljiJ9s2gJGuLzvfTA1N4GzUQWB4r223FJnJrkJzYGO8ydZZ1emASA13M2+fqZJp4elvpxqmao0vF3eVKsi+0uaYz0JiX6pqLmrSy50PFPd1cxOIVkwbcr4v/BEpkLBJWRu8bF+LCzoGk54rK8mJkQ/1UVHNhuXAaNJaB+ylWa7RqGJOgz99klFIsORdAWOpLKzJl8Vx10gnmFEKj+ohbsLuq5FyUaVyFzzuhCKIOWu2Us2g3sfzd7sdQzbzwpoCPcPOZ4OinH54iu4sMY/jcId2QcwgbIJwMNiy3wb6cYHIyEu9FFu8cEbSlRHTKv4fp3OMKJA0K9ttB994cX4RwZeJuT4BwnceW3tJGNC2Y/KJ2TLbrJs4FQyPCVqQx2vTr2rYjoFKV8JzIXw73e84FEs2jD4v9ObBE/YuK6V5M2VJ2pgtyj5LfWuKdUE8xtbjbnqjBZZ5zJ6xHJxKgXKWH3I4oAFn5YPnwQSNE093KaBniILZ/9eGPJZAMHuwX7Pjio0los6FEVaOAg/JURWY05N0cc4uVWDdzANiXQZsPgy3nyGLVhBekbN3m+vuIqJbr/6IN0Bggsyy0bcWMQKwg1M3fbAK13wk1p4yjU3Qe7anuejHvaPCBkERK0ig/RHGVnc/W1vIRpNOn+Q+v+8+0L9jtikBXGCTQKGOTrBaWYOgVcA12eH6vZXd3xUdKYqU7UCZt5X12qibyvRa8/9d+5FUvwX+eh9Sy/61ZOQH8TONDB93rP2rE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(4326008)(81166007)(356005)(426003)(336012)(82740400003)(26005)(40480700001)(2616005)(966005)(186003)(16526019)(83380400001)(36860700001)(47076005)(2906002)(8676002)(5660300002)(7416002)(8936002)(44832011)(36756003)(478600001)(54906003)(110136005)(40460700003)(6666004)(316002)(41300700001)(70206006)(70586007)(86362001)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:40:38.7122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097abc62-935f-4cbf-e5a2-08db52ddb577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DP DMA has own power domain that's why describe required power-domain
property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- make power-domains as required property
- also update commit message

Changes in v2:
- rewrite commit message - requested by Krzysztof

The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
DisplayPort DMA controller") added this property already in Linux that's
why the patch is also fixing dts_check warnings.

In v2 I got ack from Krzysztof but not adding it because of additional
discussion about required property in v3.
https://lore.kernel.org/r/029ba923-d13e-ea7c-018d-95e179dda2e5@linaro.org

---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
index d6cbd95ec26d..2128f4645c98 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -41,6 +41,9 @@ properties:
   clock-names:
     const: axi_clk
 
+  power-domains:
+    maxItems: 1
+
 required:
   - "#dma-cells"
   - compatible
@@ -48,12 +51,14 @@ required:
   - interrupts
   - clocks
   - clock-names
+  - power-domains
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
 
     dma: dma-controller@fd4c0000 {
       compatible = "xlnx,zynqmp-dpdma";
@@ -63,6 +68,7 @@ examples:
       clocks = <&dpdma_clk>;
       clock-names = "axi_clk";
       #dma-cells = <1>;
+      power-domains = <&zynqmp_firmware PD_DP>;
     };
 
 ...
-- 
2.36.1

