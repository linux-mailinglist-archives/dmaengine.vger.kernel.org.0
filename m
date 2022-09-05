Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379235ACDBC
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiIEIcG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiIEIb2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 04:31:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECFA28E0F;
        Mon,  5 Sep 2022 01:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpBDyEdl+LRaIeFE0nEK1RfT2wvk9/zmPcW4xRacPJs7NSsaanbxZb/6wf5ElXIZVTROcGt/cpWkID6aGVLFW3t36WLshpjAdWCuUOPrscRfdMI8DPmxno+edMFn3C5O4GXxu+BKCPMn8K/GPcN2zKvIRS09KiXsA7rhZD+eVl2nTUx9z1vFKyfX4FgPkihd0mX0hEFYTc3/35GLgVufZER6KjelgOjnYj5fD4Qm1dpM3Q5uLQaqSEDLfxcAUxKhmj1YYNQsKzZ00xiwJ6D65MMkqUvV+c0R6QeEEACjFt53h7RNNUxUUFked+p0tuNMybw63vqVmPHu9kThlIHw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxW0aCeDRRSA+8HA8BdgcVLhELoxMNu7+roSElwiXuc=;
 b=P5C1LW7cs64i57GJl/hKYt9MBZ8fQRBjN+KCFAPPLTcn19Fw3FYUf2ig15VhhjrivfwGr63O7G9HCH06OFR+SHyqUjubwMb9F86OVKDk+okwVy3h9803c02zg8tglZj+176gyg65CHcSrZLTuPHZrW8MVq69Uh+yqV6qIQ8lcScj3YWj9sO9+/1a+VfvMib72D5/HXNcZfpwz9Y0xebwTtQtlm9s8YEhF34oDMuRnlbokvX4nPtDewuamF5mZ0/dcLcSltx5O1ZF/NWQx7+ImYycsao9q/o7nYl7saMnh8Qg3n/+mSQp8rPn6zmbl2Ud5CSRWtqxd+tGnK7A4z/OnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxW0aCeDRRSA+8HA8BdgcVLhELoxMNu7+roSElwiXuc=;
 b=Pk318fmTSjKPita+m4La9Sdrp/9Zw2b4Ms1zHFwMcrls/loTa/4gtpnclPzuthsLa1ZgtJ1+DYXHPS35YnP0wbwRdVeLeEbP6h1vvyEj5ic83T2C5FW8RWWaS95EfkJl5ujH4tz3buJX+Kf/dcCS2xMryNgnYNdk4MxTk3KYoQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PAXPR04MB8591.eurprd04.prod.outlook.com (2603:10a6:102:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 08:29:54 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 08:29:54 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Mon,  5 Sep 2022 16:31:02 +0800
Message-Id: <20220905083102.89531-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e8afff-542a-48eb-5542-08da8f18cf06
X-MS-TrafficTypeDiagnostic: PAXPR04MB8591:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrbNNJySsibl+uKbbYkl9m9SgNJhGNUoURJjVsIM3iU0v+IIrFC5qE04SU9W7AkHdzAGblC/vjPEnSk1Tt+z4fdmYDF7tF+Lqhkg5YdnFGJ7TwGShKSEYAreflJlbDCYr7DK1k/EZbqngImZdlUJPX1kEjKYJXv2m18VU3XtHzpz8eiX89LnGHo+XBQiS51K12Bs163QQaBF6WrYr+VDNDbAg5QINIlevptgAWG+aLbnmdz02ICsHAOSp/ZXozeF/zzmNNTsFald1N4gAwD7lsZ81Xw8rh29c++TDTnHyIJqkX5kPeH/SjdupgKY0k4bpdXUCDDp1fRdgRjG2iwPQ3jQD0Hwi1kwg86TxfSVVsZw6bhkm1XWuU+9GWmL25P/r6DgdD7oiAC7TX6aaMjltTpowG3ZsHBfGkVk9UxpoCWVqGDUwoGVpIMKq+BKW/wMXln80lof29mIf0gHrL+oWoiLT0K+0SumCrxK6H8Qy40AJBSsUPb4E76M08jh/K9PF+rf3ie3FOJk1olY/QMig1xzxy/b05B2TgIgsylC36964GbnwsG73xj92itJaGvXEEIYfbxvx4Ax0XSRTRcT1/u7foR1yDmNGrY+ga0rugUb9Umwx9nAhlQAtBTpjAYYjgdPOGK7EgsZxIDbukMSBIawO/JhbLeGB7O+//5gx12yYMnPtglmbno3YDFpP+Gex5/bz/mFFP/6d4WJmn38UgZg2R2NbSnwkN0EXeC20352Rwt3lKLVWFiGunqs8D2lp0K/eCMjQWocYuMW5lFbKsysBC8bGSf5Tni9BKsuWPQCsk8TL/S/RjiH2xGi0UHaJGA3MVGTfKVku/jH6J4AyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(6512007)(36756003)(316002)(86362001)(7416002)(38100700002)(44832011)(38350700002)(2906002)(8936002)(5660300002)(66556008)(83380400001)(4326008)(8676002)(66476007)(66946007)(6486002)(6666004)(966005)(41300700001)(2616005)(186003)(1076003)(6506007)(26005)(478600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i++OLY62hpETgxUqnFa2ywNMXNiGvQSEcLbypPnXSGATxc4mXEcs8NhmiXlN?=
 =?us-ascii?Q?0ahjzSLZVLserm0zDUE1QQj6PC5mEac47MncSQl75ndNSoXk9qwpERdBfBU8?=
 =?us-ascii?Q?rekn0ZnoEkt7yNa5ljzuhnoQYJBtTn6wvsapcGyjqFK/Lo7XFOJkhOPd9O3v?=
 =?us-ascii?Q?pYA2/ErYAfzfNSl6cHioxiaGgioWddQar/NvixGmbrFshH8layzei3aejhNw?=
 =?us-ascii?Q?y8yxt72QkFDVSI70w1zqYJPePD0D0IMlX2jG4hlixIQUeyTy13VkkCNJ5q6q?=
 =?us-ascii?Q?d2seKVRL9XFscUrp+vtlpd/fFq5Ioxi+TW7MUIFoJ8X6X0yCIm6wZZ1BJR5P?=
 =?us-ascii?Q?D0CKFZRS0fhThBV3QY6DZLmVBODdVh2xXGHaJpXWdF8ItUe01FucfLdeoQdF?=
 =?us-ascii?Q?8g4McF036AB5Uz64mfRz//Qvyzy6upHKxa00FV3dQBqD+1p3PO5pv3T9raDF?=
 =?us-ascii?Q?OCXp2wexFCbxnI34FTnedJTzXkuxc25styd3g2vE+7jmv15XTzIMAZ8/kVjy?=
 =?us-ascii?Q?gECHekmUfEFwt/AVtVbtw4s14LhaknC6PFV3L2JjTdcj1zmLzsNk64a8+gIi?=
 =?us-ascii?Q?BWNjLi4vJUF16+grg4gfdRFlx2zGkxo/bBo0fyCMvIOpZyRcna1KFYjT1hbc?=
 =?us-ascii?Q?6RFRqbgQE7Y/HDI4zu9frFog5JpPAuPlpkS/L+j/LMLoz8MJI9p6dskLzZgW?=
 =?us-ascii?Q?Jz2sdHH2lti2mlIMn+E4DPuzBHHgzuhvQcaNCt5yjPRw2Wp6kiwCJADFfOod?=
 =?us-ascii?Q?B6MVXjvf7QpkN6j6QAizuyWoL6+plaa9qKiBVKsNbNRCuD4lTgUD55Uxvnuj?=
 =?us-ascii?Q?0dXfN6LDLB55+caByYQcFHdRPcrR3VIukDzhjBKby2pFEQJKLa92xUCD0MZh?=
 =?us-ascii?Q?quJ8g/76BKZATJJuHmSsu33QELYKMXTDgmj677qGNwJatwpVLL53C1BmllQ5?=
 =?us-ascii?Q?0k6Aa4YreH/0tZBiof5x7PNs3MFl1sQVDZAJGP3gr+tA/mm8z3S+7h+Tot5g?=
 =?us-ascii?Q?FMscsx2y1EUtSIR6WktfHTAyKynwPQWXMYPiVgvUGqbp54pFSY5f6TIBJRC/?=
 =?us-ascii?Q?gLrE89kj5yuqYgrit6IknAvuDtTfygfAeGG1y+f0AjJWxpllMz7y6y4Z4JmV?=
 =?us-ascii?Q?91ClG6Xud4qygdxveU+ldpDAA8F30Z8UV3IYHXmpOj2X1uNTQn8lpEjctBhF?=
 =?us-ascii?Q?c2WeV17higFoAzcCkHHcbKLQ8NzGRJremj2j8XSlxdDRwWCPK4UMoQnxBDX1?=
 =?us-ascii?Q?5npJ/0bufEvn7E2kJMxNiNf18xMOmSCY1YEIUehaEMFBkCm6qlw9OUSHrO+b?=
 =?us-ascii?Q?TYH0AmveEYxuGH0lbGUVRIWDQsB+PBTNTnDPdlq8ZPve1t9UKh838IjxOson?=
 =?us-ascii?Q?bBPsYRRLk8pI+BH2RiFNCcNrEdnRTvBGWxeG7rkfBCMjUrv5cUrmyGIDX7Lz?=
 =?us-ascii?Q?sB8IOpIcLDHTbA4khK8B21DA6TP59BMS0ZtjRrgX3j2RrrbqBtyardXTw/w8?=
 =?us-ascii?Q?lPPslULifPvo44zhkEmDatcs7nzNjFaVUfEgZ4CEGUUjJF6WrXMhxbY6S9rN?=
 =?us-ascii?Q?tWJ6Iskk543QWI7OYxlQfCRNunuZvUBBKdu+8RnW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e8afff-542a-48eb-5542-08da8f18cf06
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:29:54.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG8xDmVfInNvGJLtpmGlwyz+I7WoHUYUPvzGT4SwxuwG7lySioOFIbarQNH1BeqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the i.MX SDMA binding to DT schema format using json-schema.

The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The original
binding don't list all compatible used.

In addition, add new peripheral types HDMI Audio.

Acked-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v4:
modify the commit message fromat in patch v5.
add additionalProperties in patch v5, because delete the quotes in patch v4.
delete unevaluatedProperties due to similar to additionalProperties in patch v5.
modification fsl,sdma-event-remap items and description in patch v5.
---
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 2 files changed, 147 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
new file mode 100644
index 000000000000..3da65d3ea4af
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,imx-sdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
+
+maintainers:
+  - Joy Zou <joy.zou@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx50-sdma
+              - fsl,imx51-sdma
+              - fsl,imx53-sdma
+              - fsl,imx6q-sdma
+              - fsl,imx7d-sdma
+          - const: fsl,imx35-sdma
+      - items:
+          - enum:
+              - fsl,imx6sx-sdma
+              - fsl,imx6sl-sdma
+          - const: fsl,imx6q-sdma
+      - items:
+          - const: fsl,imx6ul-sdma
+          - const: fsl,imx6q-sdma
+          - const: fsl,imx35-sdma
+      - items:
+          - const: fsl,imx6sll-sdma
+          - const: fsl,imx6ul-sdma
+      - items:
+          - const: fsl,imx8mq-sdma
+          - const: fsl,imx7d-sdma
+      - items:
+          - enum:
+              - fsl,imx8mp-sdma
+              - fsl,imx8mn-sdma
+              - fsl,imx8mm-sdma
+          - const: fsl,imx8mq-sdma
+      - items:
+          - enum:
+              - fsl,imx25-sdma
+              - fsl,imx31-sdma
+              - fsl,imx35-sdma
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the General Purpose Register (GPR) node
+
+  fsl,sdma-event-remap:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    maxItems: 2
+    items:
+      items:
+        - description: GPR register offset
+        - description: GPR register shift
+        - description: GPR register value
+    description: |
+      Register bits of sdma event remap, the format is <reg shift val>.
+      The order is <RX>, <TX>.
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+
+  iram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the On-chip RAM (OCRAM) node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,sdma-ram-script-name
+  - "#dma-cells"
+
+additionalProperties: false
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
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
deleted file mode 100644
index 12c316ff4834..000000000000
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ /dev/null
@@ -1,118 +0,0 @@
-* Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
-
-Required properties:
-- compatible : Should be one of
-      "fsl,imx25-sdma"
-      "fsl,imx31-sdma", "fsl,imx31-to1-sdma", "fsl,imx31-to2-sdma"
-      "fsl,imx35-sdma", "fsl,imx35-to1-sdma", "fsl,imx35-to2-sdma"
-      "fsl,imx51-sdma"
-      "fsl,imx53-sdma"
-      "fsl,imx6q-sdma"
-      "fsl,imx7d-sdma"
-      "fsl,imx6ul-sdma"
-      "fsl,imx8mq-sdma"
-      "fsl,imx8mm-sdma"
-      "fsl,imx8mn-sdma"
-      "fsl,imx8mp-sdma"
-  The -to variants should be preferred since they allow to determine the
-  correct ROM script addresses needed for the driver to work without additional
-  firmware.
-- reg : Should contain SDMA registers location and length
-- interrupts : Should contain SDMA interrupt
-- #dma-cells : Must be <3>.
-  The first cell specifies the DMA request/event ID.  See details below
-  about the second and third cell.
-- fsl,sdma-ram-script-name : Should contain the full path of SDMA RAM
-  scripts firmware
-
-The second cell of dma phandle specifies the peripheral type of DMA transfer.
-The full ID of peripheral types can be found below.
-
-	ID	transfer type
-	---------------------
-	0	MCU domain SSI
-	1	Shared SSI
-	2	MMC
-	3	SDHC
-	4	MCU domain UART
-	5	Shared UART
-	6	FIRI
-	7	MCU domain CSPI
-	8	Shared CSPI
-	9	SIM
-	10	ATA
-	11	CCM
-	12	External peripheral
-	13	Memory Stick Host Controller
-	14	Shared Memory Stick Host Controller
-	15	DSP
-	16	Memory
-	17	FIFO type Memory
-	18	SPDIF
-	19	IPU Memory
-	20	ASRC
-	21	ESAI
-	22	SSI Dual FIFO	(needs firmware ver >= 2)
-	23	Shared ASRC
-	24	SAI
-
-The third cell specifies the transfer priority as below.
-
-	ID	transfer priority
-	-------------------------
-	0	High
-	1	Medium
-	2	Low
-
-Optional properties:
-
-- gpr : The phandle to the General Purpose Register (GPR) node.
-- fsl,sdma-event-remap : Register bits of sdma event remap, the format is
-  <reg shift val>.
-    reg is the GPR register offset.
-    shift is the bit position inside the GPR register.
-    val is the value of the bit (0 or 1).
-
-Examples:
-
-sdma@83fb0000 {
-	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
-	reg = <0x83fb0000 0x4000>;
-	interrupts = <6>;
-	#dma-cells = <3>;
-	fsl,sdma-ram-script-name = "sdma-imx51.bin";
-};
-
-DMA clients connected to the i.MX SDMA controller must use the format
-described in the dma.txt file.
-
-Examples:
-
-ssi2: ssi@70014000 {
-	compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
-	reg = <0x70014000 0x4000>;
-	interrupts = <30>;
-	clocks = <&clks 49>;
-	dmas = <&sdma 24 1 0>,
-	       <&sdma 25 1 0>;
-	dma-names = "rx", "tx";
-	fsl,fifo-depth = <15>;
-};
-
-Using the fsl,sdma-event-remap property:
-
-If we want to use SDMA on the SAI1 port on a MX6SX:
-
-&sdma {
-	gpr = <&gpr>;
-	/* SDMA events remap for SAI1_RX and SAI1_TX */
-	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
-};
-
-The fsl,sdma-event-remap property in this case has two values:
-- <0 15 1> means that the offset is 0, so GPR0 is the register of the
-SDMA remap. Bit 15 of GPR0 selects between UART4_RX and SAI1_RX.
-Setting bit 15 to 1 selects SAI1_RX.
-- <0 16 1> means that the offset is 0, so GPR0 is the register of the
-SDMA remap. Bit 16 of GPR0 selects between UART4_TX and SAI1_TX.
-Setting bit 16 to 1 selects SAI1_TX.
-- 
2.37.1

