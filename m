Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24221ECD7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGNJ17 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:59 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:34030
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727034AbgGNJ16 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf9q0FSJLgvEybv09Tl0MptE7KFMXeGhzHATb9ZfQo4AHD9ipgSpNkta3894R2wYRmyAKvdFFSTLqN+X94axDegzJvJu/BJBf6s+rW5dAQlwZm670+R7KrDcNAb21oE7CjhC2LY+YTbLxzuIIhxZo1qd+I+A2akeDFqXKQ77gAXM+24zVEmBfzfP6EweHd9myNeIWq2PynAJUja9B31iBE7MEId7mRSnpVzdZ7BKmcHOnBKGeVgOB3DW5KVyIC6WMgVDaxUdqdhkUqoztzQwvyR2vO93BRVQ0KTJpOYUDLPtpsIRVnyHRTmVjZimErCKWzC7cdIDePqfe0V/3e1THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofN97a3mDisiE0ZvD0xBvk5pLhZNGrCxQ+kYMd6BnfU=;
 b=BwslpmCKVnLQByfY34lElkPcz6SOnkHcRB11XyQubD/Ndv0ThrMw3eZcvECyGQB8NoMvFgGKgbmys12oGgMPHwDB3oIrp7qqTDrj9xXdgbw2GNM4nqzuJJH2gCrNsPt5a88Af2/+zXXjgFyP3W2rU4+/RV5qHuYKKHCRhNN3QDX6EMRZLe8g6JNLdptSGv0HArfSOjFstCQK6paKEsLXg0e2/RSohgW3aLYTfetC97NFTz6kmPV2/qFloW6OkCaQ4vKXwAhxse1Inl6/UyBhz8LSe+m+BDNMMyq80Ik9ufcHb55aW7qAwdfgYC79HGAdURSJbveho4/JY+9PGm2M8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofN97a3mDisiE0ZvD0xBvk5pLhZNGrCxQ+kYMd6BnfU=;
 b=cw8BMMlLMYCJtaFQlihgy94ib7DHaDhvziZvdQdXREzdis3N4kh0EtVEHaazHjQe59gE/pVRfKzv23PLmT6EngDXAxUPlXxIpoSkbM76WVso8+C8YhT1FzWMSubq+UpfGReDlRw+lhI5nxGKznetkQOVnq6TmQzSdqzvpHv+RDk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:45 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/9] dt-bindings: dma: add fsl-edma3 yaml
Date:   Wed, 15 Jul 2020 01:41:45 +0800
Message-Id: <1594748508-22179-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fc8d088-fbf8-4793-5a8f-08d827d82a2d
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6270306D64C55A91007EB57489610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1qlbYCNWTv1/itaP9TuLEWG8Hlgvfm/zQ7AX1lFgaBm9tf6hy2crvr3lgIrYY0G3gVkYc7DA91NSgTEpNcKZqskyMpGhAYIeXczPZa0TQipx/qZiRaGwGRJmMkyTzNo2BnDihfxrFJFFgFDLB4WsGJVH8kW3JKP3iN+pDShf9qhANR0o+m9I7ld2vufUYEUvDGHN1TkMRvXzo55q0eOTSs3p1ui8zzhy8iL3lS04QfhDk+dxyWLA0YmwPju1DAwrkPTrsKBMyih4D+wctffJiEDM+8iAM5fQirZKhGtC43IJGhtDKXIwO9ukUPIuRkb+fqsJHyZ4HH9WV7yElIgKZsvtwKxzWdNf5GJ+UVsdGjqUAd1aKcFeW4rqOhsUVAqswJMGVbvwSZ1Il9IEpyAWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(966005)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(26005)(5660300002)(8676002)(52116002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: doSfS9r6F2djQCPSNeeffu/GFIB838wq8Ij4iOk1VisMg7WyAhbPwbzIB4WSnJ6741dONIC0UCd7VOoxKd0N6LXL69GHCY+l1Xi5yZoElh6oA9xHfoSWZfuD5C+fPADZ6mvU16fbl3lMLZhfEKO2fBB3FFbeY1dXvIWxUSPIjuPr0cxYsjMG5/L6bWuU1UAXF1ARkJfvHrPKwXgL3SrgPftO+f481qJDaU8BuwfOJXtabVeb8pBi+sG2D9x4vxucVFERiPHS5xyi2xTgNT5gs2bi9zWDPsCs6oFEx02wFt3vhP9VUvJ3diPI9YA43jdqwTpztVYokPZXLy17huFW0Um2MbUv7OIw7d6PlY/MuqnShQ3Sm1X2KxG7+KQrNRAAewSyNCzyBhzlaTjGDhOqxYFxFY6rIdCmW+xj+Mdo+RCX7IfgrD2n2WPSwmRVZTVJzKgJjhnNiKg29YQymJbGJtp6zLeSJPE0OxJgJP5a974=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc8d088-fbf8-4793-5a8f-08d827d82a2d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:45.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opAgyVhKZBK2Rj4gnuFnF6XVCNezKBd73g58xlWFBTP4P7Zilb7ohk2ixSxFfpO0Z7T2gAEK7rZEuszWuUkPjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device binding doc for fsl-edma3 driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml

diff --git a/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
new file mode 100644
index 00000000..ebdad90
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nxp,fsl-edma3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP eDMA3 Controller
+
+maintainers:
+  - Robin Gong <yibin.gong@nxp.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-edma  # i.mx8qm/qxp
+
+  reg:
+    minItems: 2
+    maxItems: 32
+
+  interrupts:
+    minItems: 2
+    maxItems: 32
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 32
+    items:
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
+
+  '#dma-cells':
+    const: 3
+    description: |
+      The 1st cell specifies the channel ID.
+
+      The 2nd cell specifies the channel priority.
+
+      The 3rd cell specifies the channel attributes:
+        bit0 transmit or receive.
+          0 = transmit
+          1 = receive
+        bit1 local or remote access.
+          0 = local
+          1 = remote
+        bit2 dualfifo case or not(only in Audio cyclic now).
+          0 = not dual fifo case
+          1 =  dualfifo case.
+
+  dma-channels:
+    minimum: 2
+    maximum: 32
+
+  power-domains:
+    minItems: 2
+    maxItems: 32
+
+  power-domain-names:
+    minItems: 2
+    maxItems: 32
+    items:
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - '#dma-cells'
+  - dma-channels
+  - power-domains
+  - power-domain-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    edma2: dma-controller@5a1f0000 {
+        compatible = "fsl,imx8qm-edma";
+        reg = <0x5a280000 0x10000>, /* channel8 UART0 rx */
+              <0x5a290000 0x10000>, /* channel9 UART0 tx */
+              <0x5a2a0000 0x10000>, /* channel10 UART1 rx */
+              <0x5a2b0000 0x10000>, /* channel11 UART1 tx */
+              <0x5a2c0000 0x10000>, /* channel12 UART2 rx */
+              <0x5a2d0000 0x10000>, /* channel13 UART2 tx */
+              <0x5a2e0000 0x10000>, /* channel14 UART3 rx */
+              <0x5a2f0000 0x10000>; /* channel15 UART3 tx */
+        #dma-cells = <3>;
+        dma-channels = <8>;
+        interrupts = <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
+       interrupt-names = "edma2-chan8-rx", "edma2-chan9-tx",
+                         "edma2-chan10-rx", "edma2-chan11-tx",
+                         "edma2-chan12-rx", "edma2-chan13-tx",
+                         "edma2-chan14-rx", "edma2-chan15-tx";
+       power-domains = <&pd IMX_SC_R_DMA_2_CH8>,
+                       <&pd IMX_SC_R_DMA_2_CH9>,
+                       <&pd IMX_SC_R_DMA_2_CH10>,
+                       <&pd IMX_SC_R_DMA_2_CH11>,
+                       <&pd IMX_SC_R_DMA_2_CH12>,
+                       <&pd IMX_SC_R_DMA_2_CH13>,
+                       <&pd IMX_SC_R_DMA_2_CH14>,
+                       <&pd IMX_SC_R_DMA_2_CH15>;
+       power-domain-names = "edma2-chan8", "edma2-chan9",
+                            "edma2-chan10", "edma2-chan11",
+                            "edma2-chan12", "edma2-chan13",
+                            "edma2-chan14", "edma2-chan15";
+    };
-- 
2.7.4

