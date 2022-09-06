Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DFA5AE4B0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiIFJsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiIFJsR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 05:48:17 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81077562;
        Tue,  6 Sep 2022 02:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhh1G6Ql34z3gdRd2YMxvtvu41HdwHoeK7NnldY4yB0sBuqiI+7nVphGCR4rwLqAylhdY9LiT1DJ3LZrgwCtn3XuOBTV11cwP0DTRErOTtpbbXTw/vL+z3YWUuMzO4sWs2ZzsjIfoQM5uAtqVjRrKzDTn8jRfPQ1H7PMNOQ8MIhzczbF8Gg0BkAZzzWgC3V2OA0Ynjz8oaFX4DiBxcGRWLh7jrtGzP7QaEKZxqHvK3VIK+LwJJuN8stXKFy6SyCSxoDduXtLU03RATyfU+Zc93SxP7UQPcsrIqPzFNX++FSSzaUHN/QqEtBk3iAl5UkSfU5yq44cx+ytgWftW3iKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt6fDI5F3i8dI1X8YcnvQdhddD64JWfTToiqrA14f5Q=;
 b=GmSG1HWsdMQsLtxgwp7J5V3cxpzxrvhI0WV5ebdgv1Rn5uIrEsVmHcY5DjabDxdlcNtKUJNN9QLMHzLKSfStsfnblx+J8EKXhI0fLBBCAjsH4CAucTdb/5RYeZ2BN7atgJMcLeYMvOHzk5OdndOgzqQB0Tla4DbsD+RFkaPhiWKXd17RnYWWgwBIvbDjmFSEslgB/vSiFF7VYuFdt3F6RhygyDsdS1OhLuzvtpaul6+9RPKVUAGHwZNShBCRxFld+eUWS6as4RllxHAvs0j3nQJNzUTAshArCWWAYYpN8ZFG4aw52KMbtkhq7RCbbANjcvZo/4VWlqhtyzfC2b8whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt6fDI5F3i8dI1X8YcnvQdhddD64JWfTToiqrA14f5Q=;
 b=mfwOgJIpvTd+EwNcSGruQ9Q/OKlhKbQkU6Ju/H/efwc4c+WoEv8/qhiX6brYSesEBxmeF2RacEAbHa/Pqjsd4/5RSFVnT1wa/zifEEW40uY0+IKh0r5iahjQ9Pf0d8JIAgOU12VH4eAtxtQ0HVu83GENq3mzuHCA0LSJXuBpLec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:48:10 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:48:10 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Tue,  6 Sep 2022 17:42:53 +0800
Message-Id: <20220906094256.3787384-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906094256.3787384-1-joy.zou@nxp.com>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58dbb4ce-1d37-4b9b-d692-08da8fece89c
X-MS-TrafficTypeDiagnostic: PR3PR04MB7305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okwYHyOj40wbqLSwWynApPgWZiZpImPVgrfNh4A6iq8sYljixWuBfwGxLT3Qr2TXHyI015aLn377Flj0PmB8E5IY09MMSc57Rz48hLE5bLw9Qz5s5EL08fqndIveJ9knODXfsiXkJCNmNoreGkoF7YADOrt+o+/TUsBBS59jjRmFKE+D4ko+3gz1SO8XW58VbE4d0CUdxtTrgEgXGCNW9LIOP/qcsENAyRWn0njJI1eXwqxNrSJBXtaoes70FDMUKvlMm1A4kCUImvbj7g0hMer33XgAriUl8pHQtLYN6h8iScpq56Jdrl1lUXUVJyuBvb830ikkvHTYEbtEMsPreNEEZ7tFtmCT08oK2yXmA3xS/+7DcU3qerDI1YMhg+u8KQofBueCJgWIS5vYB31BucUCHS0S/AC0TIqnQ0uxt0iIl+pl/ZY+fuxDhzaP5UFX1+CSgOIGZo6DGdUcYsHj/mDxJ1YbY7zZ6DzI6ODB0zgf8GYQf6iddg2lAc78lIpZf2g1RAK9EkVZp9H1Rudtft/u/JgXKZDdkP+Pmzb37mrM06MSDyWae4yaIGGZ6vELGgpm8MPWuv5nDUCAa3yqssmgMqx9nsJFn5F2h+egcAtPXdex41BrJQluzSc54Sa+u12ZluxzV5Y+abV4Ph7pv9xgplDyufbFb5DZu//LbtJnOw5EQZ01NMjs3uwtDJeOU10Hx726so9WX34shCUgU4VAnLQoKqFOXdKSpJGSSr2ONPzLpl01cysUZHdDB5aIU4zZf0xmIQubEJaKO2Mtsk+1jw3otB4G1Lhujjh4FcycyoZETa20UXiSYzqPjDaj5jEiipLj3LHqUFpfiO6+Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7416002)(8936002)(5660300002)(44832011)(2906002)(83380400001)(38350700002)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6666004)(86362001)(2616005)(6506007)(26005)(1076003)(186003)(41300700001)(6486002)(52116002)(478600001)(966005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M32XJIXQv0m9DoLXWikSt/+ul3FHA6O7PD5tphvnvC5lbHMLIc1CqBScXzcq?=
 =?us-ascii?Q?1ZER2mnEuXiAW5Zq5cUCulmmLpY7UrXe8Vde0KZ/YjL8koXZCaBHOG00vlkZ?=
 =?us-ascii?Q?5c21hJ2hGiqMrYSyWIbRswPYQSREKsBVhh1+eQ2LtS+E0uV91+GGr2KJYCTy?=
 =?us-ascii?Q?SM7yDgEogZZneKpUKd3ydEUA79CiubBTBWtL33Q2eH0xhc5+zbuhlF4EAzxJ?=
 =?us-ascii?Q?gCO00aC2+lVdpxFbBfLZ9k4LzhvL9qBDWwlTT718DR+kG6eh51iULE6UuXVE?=
 =?us-ascii?Q?BTVi7F9p6bdik7HR9ZklmTtWy+Kg6KgzWHfhEOX2pvVFHmpK0fkH9wOM7cra?=
 =?us-ascii?Q?5cHdVYiTWqrT4H0EqAf0oLZckC3G2z0cWcoxMOn8s+JHlS/M3m9est+ezp9E?=
 =?us-ascii?Q?j8L0dtgJ7fBFGwrl4oVejRKCsURhJgXhkMtx42rn4omsmDoo1jtdnPRCcXa+?=
 =?us-ascii?Q?KSwVMvuOpKzHRpbkAptGnqpAdofzc6HH8S+NppzWHEAy0nbYx0RKYGu5lI8F?=
 =?us-ascii?Q?dR+O+p9TIV/1sBXppfpuSgbT6Ifueoivq0vRLJtNAJjMPAtZSZ9kNjsqqo2p?=
 =?us-ascii?Q?XFn+ZRYjakcj1TTUjgr8PsRdZZ8PSsE4L0SmHQ02CS9g9KPOPmBMU8c05ubd?=
 =?us-ascii?Q?L2Lhqy8Pz2reD65LvA/ee86c40IEe4nRPQXCurx93Y6bo177vg6sSjTS7joL?=
 =?us-ascii?Q?54A8WJ0GTl3s/Vp2m+hiQgmeIFgnZkTAu1ncHRNhpFk8Yget5iq60I8uXgpg?=
 =?us-ascii?Q?onkEkz7C9Djnm1IumQT9lISDhUImNsbYTmqdHKAJj3dvkicbnDHivyxRsVRu?=
 =?us-ascii?Q?shkzGWKfGUuqn7msegmexykqJc9N+h9hCrqWSdOLyZmus1jbWsCx45gtq28D?=
 =?us-ascii?Q?m1Og8NOuR5lSI3lQOEd64l2QabzSsompUrcjoG4v55FVFTdiEo0bNn0cfQBg?=
 =?us-ascii?Q?60qheARUGywI2Ca8cJceA/kJHgBn8Lnh0IIoWJrrnqbrOom3jIMr+FNI6GQx?=
 =?us-ascii?Q?NLCS/d7dK1S4kfn6OYPQRyYtVEW57kUoPPcv59MKQNaQ9sXWaVgipXusVhSy?=
 =?us-ascii?Q?dJH61YWYh/f3vkEySbq0aQ/ilvuY48hsKyu2wKldt3skzSORmaoRfdJO8Vss?=
 =?us-ascii?Q?SbHh2ai500pT9Y1CCrwQ4+tMtmF4rBw2QBvttK+b29Q0ueFeHdo5+qAfQZWk?=
 =?us-ascii?Q?INkeN1kjg2/0c2c9S3u2eQabQmlHstGWgVgym/i/4kWdOru6k+KcqbqKaAyh?=
 =?us-ascii?Q?ktdXSyXYni28NDJUneemsHtDzLoWqAdZVB5/o4wmglGG/S4QdE9w8OApZ4AU?=
 =?us-ascii?Q?upM6pp0z0MgVP3S/KbSFSzp16+qqOZONYsj+VP4ODGmHbUQt/qhiK+4G9AK8?=
 =?us-ascii?Q?mBjGEqJ09L7xaRGAZQkL9CTJgBMoslj86HaZ4jk1y2zaCJdXh2urxVTQraOx?=
 =?us-ascii?Q?5rwgE+c/xffZiYxHPNbRJokYajueBBx/YKf7DeVUT/W0OpTEIiZ1WK5tsDfx?=
 =?us-ascii?Q?e4skxFfJmrc8uWNCc25bSLW6x8DJG/JKHAWSLvxXH52N6W4pzZwwkSFkZqqS?=
 =?us-ascii?Q?OBZZpTs/KyKzil2E8fg0F7uXAKOCLv1b4Pn6+yfa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dbb4ce-1d37-4b9b-d692-08da8fece89c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:48:10.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGV3VaLm01ekZWqt89UfkE8G5GhG/yFIrEQupyv/Iojj8Y6b8MOjbI8XJxbB80oC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the i.MX SDMA binding to DT schema format using json-schema.

The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
original binding don't list all compatible used.

In addition, add new peripheral types HDMI Audio.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v6:
delete tag Acked-by from commit message.

Changes in v5:
modify the commit message fromat.
add additionalProperties, because delete the quotes in patch v4.
delete unevaluatedProperties due to similar to additionalProperties.
modification fsl,sdma-event-remap items and description.

Changes in v4:
modify the commit message.
delete the quotes in patch.
modify the compatible in patch.
delete maxitems and add items for clock-names property.
add iram property.

Changes in v3:
modify the commit message.
modify the filename.
modify the maintainer.
delete the unnecessary comment.
modify the compatible and run dt_binding_check and dtbs_check.
add clocks and clock-names property.
delete the reg description and add maxItems.
delete the interrupts description and add maxItems.
add ref for gpr property.
modify the fsl,sdma-event-remap ref type and add items.
delete consumer example.

Changes in v2:
convert imx sdma bindings to DT schema.
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

