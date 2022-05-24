Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5E5324CA
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiEXIDE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 04:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiEXICz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 04:02:55 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765C9CC8E;
        Tue, 24 May 2022 01:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MryyVEMhAC7SCVAKx0M6KUuMLd6XbIwoc1RioYRnJVMk4UXfLaGwL1uwGree7BYAG3SxvI/IFNqvLzxMbJX4NShiLJdyjf3sTmOo4bJKAwHFGGb56hrixWY2qtETflgZln9UPxsNdwdonCvaI+flQ5xQAMrCrSV9FH+Gw5M1s04pUxnedwH62yGtfF5xwHPCCJmjBxSxbRk4fsCyanvG47RithREqXQYujz/vMjc2FkCGgUOO4x7IWRXemPb7fbPvhbRrRDAfpNR8mvxd9gurSwuK2GajtpiW2HfwOrgqYT32s3CydGAQ7+XtZ/opZVB2FZ7tzy+z3KzwsUBOsxsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClneRox/PTiy7ggxNpWpXxtbrpL7gck+vBCzjWrTUWo=;
 b=XJZqmg6/IstZ0tS/mGVhaudM0z6qu9yD84vy4jSD8NQ6RprJT4Rvaz1ZLTnOrs7YWz9MsYkzXxWclvBqw8S+jSoccA+nRQpwpbskoSwQVe4uL4SNMSoW77+dJfmTHuDMRa35pJxlng/W6pwDRhY2MtBSq4ELvG0yWjOFifFDaEIow3sEpTlEfdJb43nhCGCS1GHBYs/luPk8JXBDbmsw6JCrCQsqYIjm7jbxs4Fo+VGd84BWcAiR1VqDNz+q4X8cDPh5q7WV8EGf5rfr3b4LQK53kLD8okBg8x2dzCh2juKjKsKsTbLa5r/QLyZpmG1DhZSrEujpDutu1mB5fHFvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClneRox/PTiy7ggxNpWpXxtbrpL7gck+vBCzjWrTUWo=;
 b=IXLxhGlldJ5CcqYVWif5n2DmDaimcxDlfa5whD72GiixDiCjT6bHME+RO9iPh/flknabJaaYcU92QDVTohUlvgQwvkVxanaQAV9uJ5vjCMvwqNUh1YFxPi1UdWeeALzuMeAE/cOZczPtttj5r+80ZhKwiI8IjvhbjFKKMvn6dCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by VI1PR04MB5279.eurprd04.prod.outlook.com (2603:10a6:803:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 08:02:26 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c%3]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 08:02:26 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio' transfer
Date:   Tue, 24 May 2022 16:03:37 +0800
Message-Id: <20220524080337.1322240-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67dd724b-be02-4ca5-95d5-08da3d5bbd87
X-MS-TrafficTypeDiagnostic: VI1PR04MB5279:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB52798E8317958F8F7D816EDCE1D79@VI1PR04MB5279.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih/nSXJ7bMj4Xm2SJmI+khHEukGUI0DbOlxFgQhxjSMbrUS4G0JD3hfxcnNbBlMCi/GYTfkoMASkwDdATijqNzZjFhTvGW2aDU6iU5KuKhPBOfErUAlrrx6BbSWEi2p+7ILEezjSJehozkDcbeHue6pxC+ehppsCrhWadizSQm3htpjWADjbFzAY3S0yIgXK7MiC1zBezXl/W5RFZgzHUDTN9NR93mQrp2jVUuwD+EHgs0M/o3uK/tr7vfRE3k5iXYNC342QukTN4ogEQ5nE9OzdWy8BsgwEf2FFAHM0ObYijphVDV/l6qDRJ0fbfUu2aAGSA1hvCGdALrCB61z1xEalvi2zfS/ZtDPfofoXAIxNqvazuR0oC6xsg3Cp0XJUYZmBcQM3mbtB8rHC0NPlCywMRlVIPyv8VMVvPLhl8nSrMazf2aAcJurMFV9/w7rSmjKt0ogBNLxyDgIH5KyVELBfwND0RdszBO+irb3dBWixUMNAEMFFGkLeaKPXpFQD/I3MBzwMt/lyJJruF2Mvrwe+IWlx4gLWtwRfEgbIbcRvg81or2iMcoQyRXk8dMwE4X9/Gs7SDE8ZFXXXxDzzu8/cy375xseM5k1mSKEDypqAz/tSrZOztpEbRyYSPaIAxSlTMSpU7APs7/dArJ35B79ZxJyqxQo+pKUeAW+TTDu3GlOhbTgO3Th8EzUtXKOYa7kAEYGzjaUMOM+ZlBp44oD31vWMNI79pcNpq1nlaHSqu6AuwsdwCv5sT2puLfLklzG9uiAIo7RQakohaP/zhRZ7v8m0SMleaxJsig0iVAEn51V0LTSTszLeVllYbpF167UTo24TjWvV4CZmmHrQDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(7416002)(1076003)(52116002)(186003)(86362001)(83380400001)(508600001)(316002)(36756003)(6916009)(6486002)(966005)(5660300002)(6512007)(26005)(4326008)(8676002)(6666004)(6506007)(38100700002)(38350700002)(66946007)(66476007)(66556008)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31MxfXFila+yeTpcLypV+d6PaNNUjJfJNXkgiU0rv7Tvak3vFPjD8baSPHJR?=
 =?us-ascii?Q?KaRNgWXsoKOHp6NV1DrELAxA8kvLqpX3js7S8f8dQIekPTRrlfV9OLmvcVcW?=
 =?us-ascii?Q?KRpSH83BXBFiyUok/eh+JtNLzESCPr4tjE6/iNvblN5rxazv2p9EHa8Rnk/T?=
 =?us-ascii?Q?Cw+A9hMcqsfRleY95eWz6o2qsDo/BxpROjN2QJquSSUUSGIGZLfemqu+Clgi?=
 =?us-ascii?Q?QEFW+K359ZF8UU9DhLS8mP+ChUXP+Pf/KhMI9ucny1lesLSPLCAvej+xviS4?=
 =?us-ascii?Q?Yd71Rq9UOXDimvfjhI1Wzh9rA1fzWjOh0qAwZiW+BACMyd9Q06sQuwMOpTAj?=
 =?us-ascii?Q?OlEZNlVq4VEpc5Na6BQ8VF86XxqQd5OgwDZP7k/zko63r0xQNHouuhqusmt7?=
 =?us-ascii?Q?u/Qk7THlYxGwPaoCbNkySyDPxYJl6wrFu4qogI7NlnwLs96eEwGOWmsCla4I?=
 =?us-ascii?Q?9jZcJBerMpJgIEDcekVTfWKBPxzK7WfTE+miWga0yJYGDscKhSQt3X4nD3ty?=
 =?us-ascii?Q?IZCcC47qKof/o0g/HqzU+wTpSSaxOHYzWXiMvGQcOlvHrUAx+hs7U6khFYS4?=
 =?us-ascii?Q?IttlsH7c3IEJnYC8+rHtnjB0DF75URmC0SnckDm3ELIUbS2eza5s4Tku2/5t?=
 =?us-ascii?Q?iPGINlQytPeY02xc3vsG7T/P1gzrms3SwOJk16IgBgJGq6DEYe9ZQ13KATe5?=
 =?us-ascii?Q?qYvZiUA9O4cPimeLzkW5ARUvrgTNCfpgDQDzBCS7u+TjUSFGzdZHSbC3/YMF?=
 =?us-ascii?Q?PkO0B3E+ACoTPscYFIbuzFpy6UJXWVN3K4qJn3QkJG9WImcMLJHVp5aixqmG?=
 =?us-ascii?Q?2Kk+UHO9P89QNt/ooR7rsbOeTDLmT+a67QnXlQ3IrBwLJl+Et3iQkE2ij+1I?=
 =?us-ascii?Q?KHhymuUraLKe9bL0M5PuFfEgZjWApR5hTc+ZJUZNABEdYi9gNHMqkNq1pduH?=
 =?us-ascii?Q?Pp8k7m1tgA3hNbttnEQEuSy3K1mqmxZmlp5ixEAvjNjDTYiHp0Lmkw+J6P+M?=
 =?us-ascii?Q?q0wdLuoyM3r/wz1igOp/3dFFfncpg3m5d55m8cEwfuBZTcHdOdGlTGKyNb8e?=
 =?us-ascii?Q?XNcwL0ar4s9oA6CcrczIuAazyEuhuHIffhXEYn/c0hq23M5IJWN6En9H7tvN?=
 =?us-ascii?Q?LP2p6xqxivwjj55jj3ORHJlq7qst3FklGdD2mLHDryzMpI0lhfn1+w98xyQ0?=
 =?us-ascii?Q?179q5FMw/H815ND7jjtDAFBYcWog9quBMdZPg07slcmlQGalF1yUAQ6fBjbR?=
 =?us-ascii?Q?lUOQ4a1VSwn3XlClO2Qh+oh88EAtGfJqDTCWZTBckybaQV9zatRwXfHlH2rH?=
 =?us-ascii?Q?Y8GWRM1ZWRDYzuTZauXai7+vC7w/Cq4DBzqySECZS3xKuFXEMQR7heRH5tGF?=
 =?us-ascii?Q?h2DXPQggb3wfCeihr5HIcF7XD7Zj0qTU9L8hUiQOVI1ChnhldVIYpL6ns0ia?=
 =?us-ascii?Q?PsZ1mt19bUj6ur7QwPjwdAmLhDv4G/HMNgkHT+6PgSupzliesD+J+FaotBe6?=
 =?us-ascii?Q?19o+5M95dQo6fjMW1gFFC/R/diqAsfKwK/VuQHtKhA3nSKFHgZeJSwyGMBOP?=
 =?us-ascii?Q?V+hrXjxy05akaXAO+DvCTJDWC64hBfnjWMi3hk4PsaYZjz413A3IHnVJNi93?=
 =?us-ascii?Q?3z7NHAEHs1GPwlDdEK9VirfFYBJHA1EHPnXfHxs753Zw8KTsCsZuna6G+bS8?=
 =?us-ascii?Q?qcAriDkrEKhFsakFwGG1EXJBWCwvatSmmHTJIWLAZ5o871pNwUInEttx0il4?=
 =?us-ascii?Q?tPajtlUMIw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dd724b-be02-4ca5-95d5-08da3d5bbd87
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 08:02:25.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqJj9HlID1xvp7koF8quSLzj+Vd5KQr6bES1ioCi6eRiVdeqhSyAM9DjBGeTK+My
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add HDMI Audio transfer type.

convert the sdma bindings txt into yaml in v2.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since v1:
convert the sdma bindings txt into yaml in v2.
---
 .../devicetree/bindings/dma/fsl-imx-sdma.yaml | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml
new file mode 100644
index 000000000000..5b4f7a09a395
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl-imx-sdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+# Everything else is described in the common file
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx25-sdma
+          - fsl,imx31-sdma
+          - fsl,imx31-to1-sdma
+          - fsl,imx31-to2-sdma
+          - fsl,imx35-to1-sdma
+          - fsl,imx35-to2-sdma
+          - fsl,imx51-sdma
+          - fsl,imx53-sdma
+          - fsl,imx6q-sdma
+          - fsl,imx7d-sdma
+          - fsl,imx6sx-sdma
+          - fsl,imx6ul-sdma
+          - fsl,imx8mm-sdma
+          - fsl,imx8mn-sdma
+          - fsl,imx8mp-sdma
+      - enum:
+          - fsl,imx35-sdma
+          - fsl,imx8mq-sdma
+
+  reg:
+    description: Should contain SDMA registers location and length
+
+  interrupts:
+    description: Should contain SDMA interrupt
+
+  fsl,sdma-ram-script-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Should contain the full path of SDMA RAM scripts firmware.
+
+  "#dma-cells":
+    const: 3
+    description: |
+      The first cell: request/event ID
+
+      The second cell: peripheral types ID
+        enum:
+          - MCU domain SSI: 0
+          - Shared SSI: 1
+          - MMC: 2
+          - SDHC: 3
+          - MCU domain UART: 4
+          - Shared UART: 5
+          - FIRI: 6
+          - MCU domain CSPI: 7
+          - Shared CSPI: 8
+          - SIM: 9
+          - ATA: 10
+          - CCM: 11
+          - External peripheral: 12
+          - Memory Stick Host Controller: 13
+          - Shared Memory Stick Host Controller: 14
+          - DSP: 15
+          - Memory: 16
+          - FIFO type Memory: 17
+          - SPDIF: 18
+          - IPU Memory: 19
+          - ASRC: 20
+          - ESAI: 21
+          - SSI Dual FIFO: 22
+              description: needs firmware more than ver 2
+          - Shared ASRC: 23
+          - SAI: 24
+          - HDMI Audio: 25
+
+       The third cell: transfer priority ID
+         enum:
+           - High: 0
+           - Medium: 1
+           - Low: 2
+
+  gpr:
+    description: The phandle to the General Purpose Register (GPR) node
+
+  fsl,sdma-event-remap:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Register bits of sdma event remap, the format is <reg shift val>.
+      - reg: the GPR register offset
+      - shift: the bit position inside the GPR register
+      - val: the value of the bit (0 or 1)
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,sdma-ram-script-name
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sdma: dma-controller@83fb0000 {
+      compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
+      reg = <0x83fb0000 0x4000>;
+      interrupts = <6>;
+      #dma-cells = <3>;
+      fsl,sdma-ram-script-name = "sdma-imx51.bin";
+    };
+
+#DMA clients connected to the i.MX SDMA controller must use the format
+#described in the dma-controller.yaml file.
+  - |
+    ssi2: ssi@70014000 {
+      compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+      reg = <0x70014000 0x4000>;
+      interrupts = <30>;
+      clocks = <&clks 49>;
+      dmas = <&sdma 24 1 0>,
+             <&sdma 25 1 0>;
+      dma-names = "rx", "tx";
+      fsl,fifo-depth = <15>;
+    };
+
+...
-- 
2.25.1

