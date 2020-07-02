Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139CB211C3A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgGBGyR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:17 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbgGBGyQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRqmT/8wfU3jLR7WAXP3j4oyPkZ4EqOG24/zIrmCywl4u6SiYY68e1FT7H1z05wXUZncAQb1hdHsAhH+7pTqqtcU5lfxUkOuBxXZ8woBCE4aBr7c+KYzZwvfUKLL9QapI1AtF23r7UmuxCEbv88tZcaj3dJj8JNTGvlX7Bpzk9nTvATWzso2z9DRUQ8PTAdHZD19Yq0lcc6jLThojvdqVcvKaPaKj0Bs/VqLjyHjyEnP2JYqpf3R8otfRfUOTRkTZmrTl+x0INZysitnCrnr4vP/jFWgSaLfYcSkIV9g9EswBc4hbhfW0L+reeG1oNpV/8RDGtdw8t5GPwyhPwbDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2e5NcwrTTSg6jKCPg6PnlO3CjYS3J277pi6JJiawao=;
 b=c5dURlY6z6NS8R5I5F6iv5AVGLKbewyjez5BKekt3lvPweVF8Gne5l5yNY6MplKkuz1hGYUgIT/pz6+zKvgmzep7zB7Qdfc/y60jKsHB+bnNoWtSDt83ae7FeVAQ6lYHKKiY52MMjfX0rd+26rWrrb9/4da7bgngIqIShsu9xlU8HwJd2A5HUKV7+DoyhQPuE91qGFc/kEKleXU++Xg0LotLFfBwmC1eT/qy17djWln9xCzsAZQnxbFV46R99v6urDLaWM/YM3ylJ4LKbas8Fbr7vxWEct0t6PV7Ft8609ky4CLdyMDtWjSeRnEx4Rf0nKz9R760sOz+bC4eLexpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2e5NcwrTTSg6jKCPg6PnlO3CjYS3J277pi6JJiawao=;
 b=IkAkIq7unDzdPH8p9X+PEHC+TXSMYbDNXHhFsLGxXwj3YkXAoRZNch0WBQAFkYKvSn0gyubNjVffenflBo0FgBzmac8cCr4GcEucbwuW7UM6G5sNLnMNBP0eh20LRb7yQzYhso6U8VALbFpZ1kLoHtYk+VPgpjfFKxA/+lrob4o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:54:06 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:54:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 6/9] dt-bindings: dma: add fsl-edma3 yaml
Date:   Thu,  2 Jul 2020 23:08:06 +0800
Message-Id: <1593702489-21648-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:54:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02c86b8a-d3f8-401b-3973-08d81e54b689
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB69431F405E4FBF27A6ED2321896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgLN9uKChleqMJAuCdhFN23NANqt38zb4IoZGF3XW6SFuiriQO7WgTXBbsM0ZQpqNZuB6jZLD1c4JtUyZC1FxViPjbmd4CRN6SDRg7zxPHF8+lPL1hN4c2PsZlVeXvY5R4TKL1J+RvnY1UJ3xMEEIF5TGb9TpY7ID6xw9qEfYg4tiA9CVrJNBUsd4bg/GMnutg9TIEvDGQwhhjtWsO3Y14pozDhRO60WdThkZkuZ9d6ZeZGe+UsFEv5gzw0S1yxQxfplNva9ob4SF9OR2447gxv0qx0zbV57mPTD9uUEfXhMRmbDG0oy+WTlS+PCimR1i5FZTiAQmhMtdLblPkbiSrabDr1tu9OT13qLJExTLY2Zha8mzbPwfNFihPHYlOQnlPsPjukyYHdtth7x04RDQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(966005)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wQ/RkjRdivjz0aWYpp7q9+YPH1tVbILeCGpalOyQMb0FwJ6d4Jac7RO9+/kQDvY+v5P0Mfc/nBghQbPf0DPb77vAP8B7eAxuuJawQ7luaMP0f2j4urRPuIm3GPHbkQWlW+v7bItnOVNYb7ajx1UZt67Lbh3Mf59SbhL9BxrucVYqOh0hVIEO5kNT9rYjyBs4GLkZkTticCHmM67IpctkwWqTWoQtZyTXByyLxqDTPskOtCMfmRckHTFVBOXtx3hbd6KhK25EEfVbDcglswIAtK9paOsO+OmNj5BILFKH7JUR5o+8gEeovTmNjqM3hpM8ef9WoxyONZ7Zn6XF2nOaH5trxOIo+ubpCto8l2Is/ifESQLj8i1aK4ZwWhmJrHPpGO8lzo0Rj/que52RVWLuawekwkJbzUVv7IOwA3P4JvmL80I9gJ2Pz95rTFjYfAQyO7+DgNPNkqk42KgAhbUb4c7SOZTP5JLFVOc8KRjgWrI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c86b8a-d3f8-401b-3973-08d81e54b689
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:54:06.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIqqedBCuwRF2Z18DBF1+6ADqIDeQwodzEnhnZyZV1thi1fb2S7pHgIGFME/8L413K+4RV0bAXPh8HInyO4jVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device binding doc for fsl-edma3 driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml

diff --git a/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
new file mode 100644
index 00000000..d1b47a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
@@ -0,0 +1,129 @@
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
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 32
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 32
+    items:
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
+      - pattern: "^edma[0-2]-chan[0-31]-tx|rx+$"
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
+    items:
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
+      - pattern: "^edma[0-2]-chan[0-31]$"
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

