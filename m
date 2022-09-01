Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFD5A8B1E
	for <lists+dmaengine@lfdr.de>; Thu,  1 Sep 2022 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiIAB6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Aug 2022 21:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAB6J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Aug 2022 21:58:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19311BE19;
        Wed, 31 Aug 2022 18:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqy7Y1h4tz0KGpsdafjM4OQvYoNfjI2yMm2e1gZk3PVcTtl2VorR0HfxygiBHNas/S8GPi6SZ2pA8Ml3jh5sTAkTGLKxBO9tULMCJXX+drwbLt5pmRieaYMwpqD1lg0TPMzrO5rqCrTXz0aanCuBxdzTeVGs/nBCGupqj83KqvSe2OC/Wya6Hsc9S/E/QfFKWqa/EAql/MNenaynYFJ7I0ISg8i0R6/zzzk36GqKN3fPLnPVaUKQ7FM8L6EFlsw/OGKtb/b0crOhZMs9CHfmpC484rzvHBL21fID0cT/LWT5EAbUxhgQBDW7AZeNVuloNGcsqJ/GUfUM62XM6wQLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvWlg40vwXJzY6Xfy6woEqPpdEVg+izr318OLEXi8+A=;
 b=D+8af6VGchlsnwpZ4ip3u6jtvvKQH8wUILHNze14Caeeg29dvtpoAuPw0me3fSqHaVQ8jnPOuDofNqgQ8KowIaO1HCWKrMsj/qR+bN4OINawH/fApPXgjpzp7r/Q9g8X5PqPWjVODdJtEpbfM4Egzcmf6465hheO/tigvj72cdqXSd0uRSCYhrVjGHYiv4OPwModcpDoS6qCdjJv8FWo7Rkj1S57Y/wosWup4eBZ55V/Qz1umyRS6pmgxkkzKD7WBnhKHgEN9LTmT9NXuxI7ZkGdrj9y8vsLgNewPjKssL0IgH5kRhacP5kF1eyogtPZhvqEeK6En/5oubwoDrMe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvWlg40vwXJzY6Xfy6woEqPpdEVg+izr318OLEXi8+A=;
 b=CKpyvyEPH9D+C3xj1Eqpsbci5a8WtcQxkOLd7AEfsZf2tnHzQT42gr9Kb5azNvY3VX3AtPIjnEMb+YMP2IJfvsFYql43SXDb3L7/9C5V97hdCE17LTQ/vhhi74Xm1kfR45ymBN2oCU55HUgB+/shVfUyoDu0DBkllRGnh6wIgVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by VI1PR04MB6159.eurprd04.prod.outlook.com (2603:10a6:803:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 01:58:01 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:58:01 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     shengjiu.wang@nxp.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Thu,  1 Sep 2022 09:59:26 +0800
Message-Id: <20220901015926.50082-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92df860-aef9-4e82-7551-08da8bbd666b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+01TKJnOIG4O0yjzaBAn2qfjFVgzOf5+sNnGGQ+RX29dVmWO1Pun9HrmqXDWHlHH0C82Iv9VSITs7LGC3hol8mXtQW8hirT7F9V9Ubm0qfCM9FNDurZF/7ByfQFoAlEny7w6gc04aU0h8AA6lj5TYmYlDom1T0u8gEt1sBknva6ZcJW8FqPLQuqN2d3nhS5iQ+XXuqypzL5HRT7hJF2ZQA5eoUqRzm1kLw3fWx0uuk7TrLxDG5xB0IGFUiYV0VPkZuhyvOOt/1125xbGOHwaEv9QzXQ+SQn2b1sdH1KXyOVVaeDbmtOWYzFcIDM1+s5Kr5VbEipoK9SAPaj3opfF7PIMj9CdHGokkdgiUTiHeINcSv5KRN7xPth3nTVAaX2pHC7WX5s+E56CfX46CyE9JTI34EM8BkhwLZ3svF9bY/c2vNJD37haRZU/nSQfLgAVW+/EYBcQMj4HJsaRpLX7NdsJ/q/X5L4phDQ+c2hXEMeI2pu+8wYC4DAN/juzMaBexg3INA9nhsgAkCZZcEiZFsn4HnDIz6jAt/wP/2B7pX31Xlc8/ujKjQOXru6W22dIkft7OSxIJErniSpQPeUEPEvnPkG6VIihUu2g11Uo0DMT97hBXoxuoP483wG8WzKMfqbBLXGqjHoMYFj0RBGvByNg6DdaXUfLeEtkArbJJYO8ukglRUyJ0f7WmK7iryjRw3UwS8Rr54uz2Pu1PWa13eIJ38Oki2QVhjtI8NS/nlnHE+Ihmnhr4FewQivfc+L4ehSF6ewhgABvi5FqSPNBYhvWTqglJgPTnXd+whdzj6MaC4d8kcL7P9Va4Sy4OG/1z/lU4H5O+7tzyKfWAwxtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(2616005)(1076003)(83380400001)(38100700002)(8676002)(38350700002)(6512007)(6486002)(478600001)(66476007)(966005)(66946007)(66556008)(26005)(4326008)(2906002)(7416002)(5660300002)(6666004)(44832011)(52116002)(86362001)(6916009)(316002)(36756003)(41300700001)(6506007)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M+OyquPZKCciAhmHYayRECnKZ7eysJoKJYsqiZFM97aom2p3R28pTEj5UUzN?=
 =?us-ascii?Q?gD6WyF9txifL0bt/Ka9Hg9okaEiSJ3F5UjeGf7c40FxzPjc8WUpeK1witQYr?=
 =?us-ascii?Q?f3FgSrlv5aDoP4uPQQRSD/mxzVFft/MmXashJsh8LpRvBhRDJck37NWocPGh?=
 =?us-ascii?Q?5tc5Je4O9A7KjVyqPw+eq4osCJCkKjns+AS4RiV3f0jPA20nqlNIgdh0m8ze?=
 =?us-ascii?Q?m/m0bfX+xBfvs3qlyj9jpr6UPtzJXnsBXj+eTUm7qDFHgziGEl2U+qHjzhlU?=
 =?us-ascii?Q?nJfFAkbIKkGwkEdF8lTesa/Pil+hqkcUeSsEf0I7kE8KgUBDYe/IhEH+zguH?=
 =?us-ascii?Q?z8ahfdUrVphwdACEPDO/GsQ0//qwX46ra3/Kk9ZXiBYnR3m6SzjIyIHKzdST?=
 =?us-ascii?Q?GSMw2bg9E3xZCcs8SlqxTcClP8xhlX9CpIHWRL79RoXZdred62bN27oFHmQF?=
 =?us-ascii?Q?zV2GLh0SvwCn5YpkTZgeQcFHYEq0vu+doJGgVMmX/MeZFN9L7u0Z85qKPgvJ?=
 =?us-ascii?Q?1OAWiKidKWmrlSlrrkPyoFRhnH6pisvMTFrm3eIwu9yMC6B7/qRsfUz7ZFab?=
 =?us-ascii?Q?7hijoQRua1vlSgWO0q5Vb0LAPJ4oGv0lC4rATcZeT5ph88Jzpc/sEjNYAOVD?=
 =?us-ascii?Q?SayvGpU03/EPYKdXh4cDDXqHgCO9UecSRlhTE5lP9NQz2C0Hb6o1+kA6qOob?=
 =?us-ascii?Q?sXK4CiYKD69IjbbD25LFLMT4fSO+m79dTQsDxVBMUhSoygOaPQOkf+mm6WwA?=
 =?us-ascii?Q?lpk378tBthwDLllGZn7iAPIJMwZRcH3GrcV7dLAJa9rJRwKTjpaxMiXY83AO?=
 =?us-ascii?Q?Q/HKyIc1dPtmFPWRx4A/+7HjNLyij2wTLxY8YvYRzho8CaK/bAmldWBGk5VV?=
 =?us-ascii?Q?Ol4Pr9xXiwu4mmDwWhdhv8JVhIkavGatRqWj6Ih9eg54FfE1/28WT5c8vD3t?=
 =?us-ascii?Q?d3kPUlzNyKITyk45+nQZZ6IjJ/80LMiXXaRoBUu/yBEUsDne5aj9KiDkOnpm?=
 =?us-ascii?Q?BeoYdBBnSHYntjDpEHrBfSis3WpsWclIKXjGCwfhGhiegxvVmnKHe57X8aG9?=
 =?us-ascii?Q?P4LzVTDQxvTbtNtmgcYdEfjmgfr/54D6EehV8l4HqrI72VhZ/e9ON8cRYCSw?=
 =?us-ascii?Q?i5XWeM6osvsrGZjuYWq/rBLSVO7WqMMLbHRNqYyGbSxM8yKvX7/qW2F6OyOR?=
 =?us-ascii?Q?6GiSBBaUx3lex+ikxrU/yU2K9Knc7OCQ4TjCtURCFWXnOCcnsUGpqIXEX0XD?=
 =?us-ascii?Q?BmQ9wbKzEKG9n5QWRtn3eTt2phYkg1SQbq+ZcVp/798qXDiZiNtBXy5Up17e?=
 =?us-ascii?Q?+f1puQXSL90pcy23OXvvHqcebbjOqmaJqqxn9uraLHOeIdAY3UEo3JV3xnu0?=
 =?us-ascii?Q?y8rJ0ISsGFhSASnw1fePFjo+gi5UfkuTNMgUbec5UwNvPuXBC1L5h8s+tIks?=
 =?us-ascii?Q?jYolRQPGwMc6JRSh/Wt9AeOqiEC3xNGzjeNpjHbSZ3tpKfo8Oj8AOmGDwhD0?=
 =?us-ascii?Q?pqWMGzlt6Az/kcbQ5TrL6tFHKr+bvot+oFRBA6WJD9qmtvHCCezSQOBzUvyp?=
 =?us-ascii?Q?7UAzQHZ+kOg3o2w7o8H9SEfWNMcdmFWCRglsPkmS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92df860-aef9-4e82-7551-08da8bbd666b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 01:58:01.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKYl7A9RAde1Xanqmg+L4h4n1E/o8udRzAwdGbq+PBYhjaDP6pBM1s5edXL9HKR5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the i.MX SDMA binding to DT schema format usingjson-schema.

The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
fsl,imx50-sdma,fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The original
binding don't list all compatible used.

In addition, add new peripheral types HDMI Audio.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v3:
modify the commit message in patch v4.
delete the quotes in patch v4.
modify the compatible in patch v4.
delete maxitems and add items for clock-names property in patch v4.
add iram property in patch v4.
---
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 143 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 ---------------
 2 files changed, 143 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
new file mode 100644
index 000000000000..18b31758cc67
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -0,0 +1,143 @@
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
+    items:
+      - description: The GPR register offset, shift and value for RX
+      - description: The GPR register offset, shift and value for TX
+    description: |
+      Register bits of sdma event remap, the format is <reg shift val>.
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

