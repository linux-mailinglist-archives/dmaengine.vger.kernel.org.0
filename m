Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA36F5277
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjECIAy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjECIAx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 04:00:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17630D3;
        Wed,  3 May 2023 01:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl5N4Hwy2qfydtcxlRaMqg9e8/NQlEHS+raMtyxNhv9XYQ+G3AYSgTmnnCGFgt1pZw/Cspfs1ySyDcvXfEcWHTOFRMg7WswYG/EyX4IPvA0wO4scZ3WObpV5oNkzL80CJ0qhtBBO6fY3ykezoroSzMQHerVFVFi8OLaXpvIeJwPgm2kICKaFejWLvKW4NlhS5p3DySr2EKm5dILFNhXr7cQ8l14URgqrIPm+5tWKbBh2E50f26UE1d/+j8NNNJ7/ow9JfsIW0MYftKJK4QxlrAszwa2YgXwHV9QNojsjgf60jdErOU2/zxUTQowpSSWggR++bnVvwAjGvECy6QeTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMOZnczM3+Ft5RaSKV+NrKhiXdyII0BJmT7FqQMimu0=;
 b=D1olpg8CgE9txvhtxTtwYd1bbdNHXGMT5TlNEYqO9S1g/l80583Jc9xno10Q+vua95ikt7kiLpbcupVLn8nRf5QS9eqQMSOxlwWBwGX+IsL8Zpu1X88QgrngOnHMnTaOIRJQjxGUj0hSTYqWvSTJkMabXF9K7f34v9aOdzk1EPqilkv+ImB53cLqo8bclERpMbeTEeFq7cP3qa2RQULg6oncEN3wLxF7HxWAQN2NR5s6WRFAAzKmh4sE6ABe4ZCkFTLQexMI9oSHLLtX+suydympjwLHB5oAFKxW4EzVeDypIWML3g1v7dGtOcvLwRxnEMcz0rrDwTwGKc9Biv4VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMOZnczM3+Ft5RaSKV+NrKhiXdyII0BJmT7FqQMimu0=;
 b=3z1AGgEZa9g04kibDBjGYi82lAKRFa1b82JAmaxwnqhpne2dN9Iid5QinY3kFqp9v8teaO4YuGpnFaj425ve4A37sjF4FHCsdhFUq6tTLdVE7oAX+7VJdU49pMtk64ccsQgISS/5UEhmS7dpJZl9IhieBHO6Ngx/1q5RnJkDuKQ=
Received: from CYZPR05CA0009.namprd05.prod.outlook.com (2603:10b6:930:89::26)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 08:00:44 +0000
Received: from CY4PEPF0000C97B.namprd02.prod.outlook.com
 (2603:10b6:930:89:cafe::eb) by CYZPR05CA0009.outlook.office365.com
 (2603:10b6:930:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 08:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97B.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 08:00:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 03:00:33 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: dma: xilinx: Add power-domains to xlnx,zynqmp-dpdma
Date:   Wed, 3 May 2023 10:00:20 +0200
Message-ID: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97B:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cd5e57-1ef7-4872-99d1-08db4bac7f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/0twEIJNNCxxOBGmUdK4569iNecTrIB9v9fZFUbaNFY7hD0yd3lW1veW/KzXW6aovN0kR7D6ERa8Of3chtT3uBpHsiTCBGnfEiLFWnCBrj0wkF2M3Y3dw6qoIfE/5FCGv4un4CbTj/c2fqs/ADuSgMYPCaQVlrJnP2pKwn7GhM8QBA1vatNYiadx2FnGn/oTy1FDe7svL3SMOJWYGU9KKHTU5MzchycePLeT6SYUiGW64wp9WvyDSkGoI0YVs0vzYMPZrvEKx4yAMcwqpFBY1xtJLqxd7sNvMAyehgjyu6xD1ntRKA2trR1HsSpJZdBwTm/I4fwCrGA5PRHHywE5hENFtUAH850Gj8BhdUFUdz4scSQzY648PGx4vzge7sabosIM1UEG9pamqtyweJA00PSglSbL2fX5IaTxniyYiFWSTEMMoMpziSbpsKnFNgYAMjpyALebB6yFG2VwcbXHWU8xNPmli2w+2tyt0RSubbnZIwv2jXGSuu9HniEhIEUBAJoVnOBXK1jwEvtOYhqhfU0rPLOpL2xFhob1M72l1lRRQ+Z/6KvJzVKihqVPIrkYikhzViDpZrGqM6lnqj3sBQvHGYqjoetqPIU1GgyIOnhN6iWLa7tqM/7qEk2cbYaFHExJ3SThddy8nu+c1WRIQMhejHPzY8g993YTz3CDnC4Sv7XXEw77HX4ttTOfBGD404F82MjBG5bzWQN2TD9QEl+iJbh0xURW3j/RbdtCk0AauJ+Ildrrnavlq3IyJHT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(26005)(478600001)(36860700001)(47076005)(426003)(186003)(336012)(2616005)(83380400001)(16526019)(86362001)(40460700003)(4744005)(6666004)(40480700001)(8936002)(82310400005)(7416002)(316002)(110136005)(44832011)(54906003)(70586007)(8676002)(36756003)(356005)(82740400003)(70206006)(81166007)(41300700001)(5660300002)(4326008)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:00:43.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cd5e57-1ef7-4872-99d1-08db4bac7f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DP DMA has own power domain that's why describe optional power-domain
property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- rewrite commit message - requested by Krzysztof

The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
DisplayPort DMA controller") added this property already in Linux that's
why the patch is also fixing dts_check warnings.

---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
index 825294e3f0e8..f066f6983899 100644
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
-- 
2.36.1

