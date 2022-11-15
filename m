Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1962947B
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKOJhW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 04:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiKOJhT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 04:37:19 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B813D66;
        Tue, 15 Nov 2022 01:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXyKGKoFdXCJ6BArh/yBo0Xqnd0L74m3uEYpl1Y+BdBZzrRRKz1F9tAlKAZSnjuMHBjqhalrzqmRWqmJ0LHwDdU0anz4ish3RK/QNU85DXzNV2GyFUHbfKvw0ZwCYypk1gjAMfpNqhCpAhWcOV1f+8qJMnh/mqV3ettsU4sZ1wuLK7ByjKHGWj8TaC5mNpSW+XJx9z29QddRv2INLP52sDSbx+TZxLP24YT7k3mcK5kOpVYuKubobgMpJPlqr5Q76qtshb1icLGWjtyU5AV2GM5lcofgZP9T1mU1GuSBnwh5ARevWlJ6qC/mYeQ3qdRhY6sgjvJeSo78yVbGTX/Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHebfnZTxJDDCL+ZyNibYPD0eTXxe7WPyqFWM6WXrzU=;
 b=Sj+jGNHGVXoDY1/cOq2UbLbesgQEYlREPNgLvZZM1HvK1T3zj4xI5LP6SKoHZ2oVQvYcyGbvNRiGxme4uB0hKVz0fphxkAZNhE8+I+KH330nTvYO7r96E5C4UdzFlpO/gQEHZZOIcfCjzAbWkqvH0DOUhb3/21cePfK9r/dC82azXdhj/PV5BcTjEmjkJOo8G+VeBgsuAg8wGlEpxUdVixD1x8YwnmXuPyXN70TuQmgldmUQfTKjC4pQpzVRdD1B7dekYrQp31yxwaAiQ/cDbCuIsjNLRL18JFQw3Gmwbse1FBo42LjIHW5vjT/ximiwM0nvDiPoiTZL9L+8j36M1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHebfnZTxJDDCL+ZyNibYPD0eTXxe7WPyqFWM6WXrzU=;
 b=NLxrKdw/t+FumREW9/viCgCjiRtzWbTaAJKhrcn+2718O70u0zYPg3ADfhmE1j267S0bralIQ1r4y0jjsgEIkDEE8oX7O5II3iV4gpWQ8BPmPu5s6lJYEe15DUDZcjmAa4hg09uIQg9NetsSZSR3BLgqBtW4UyHWbh/3vBfj7a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PA4PR04MB9462.eurprd04.prod.outlook.com (2603:10a6:102:2aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:37:12 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 09:37:12 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Tue, 15 Nov 2022 17:38:22 +0800
Message-Id: <20221115093823.2879128-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115093823.2879128-1-joy.zou@nxp.com>
References: <20221115093823.2879128-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|PA4PR04MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc474fb-3cbf-410b-cb95-08dac6ecf95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkHBs6gGk5WPGl/wxSDHWOAy1oB0AIKXWrUImPd0sLP5alHAZLQ2jP+e48p6aooVFN2sSGUwkyCMJaLripHrCbtMIv677dviiqgfF78RqY6kpwGiQj3XbBt4pyt7xiKe2BhUbJqEYjOo7HbllH1gIc1rxjNv5cQx7Oj7WMKTlpGeQGMpI5dUEwuqU6Y4Qre2Y0T7WQe0z21g6+3NX7H3S9bYi5vEiklj8paFUQLN+Au5l0b5+Ikul2rtclEBouh+UzyIaCDJF8vIpgWDegfWSB6kpNVc3ZeBe7DsSTz9c7xiWip2k5QIBmvQwc9K0Rom2HXlf+kPUemVcT7Pt6MXNY3V/k8EY3MO82NtJ617qFlVdKXGrGkQHCHB+7mYiuy5JMdxPtFopKIOarcjD5UhN8PsaEQRHtLeH9XakygIYR8hOOO+RuHnCewQ48NPF8w5Las2R4KAOj2TOwSmfQRRvOJRj1hSTBwsewPjYtRkYE5n2iLVm33rpYVhMro4oSt0Cpem3PyahF+33O/Ky5njiWktnULtayTKxk5+5a6zAyIj2mBIJ2p0G2mumofiXv7QcseoCEP19/CThcXqjZuQ1GfXH09h6+dUUpUP8xbUjSQ4ah5cDoFbXWH3hMU1OykJhnc96reya6LdWoiQfh4bkBjVc1P36d/HEId9Iml1LJA1LXh8kV8BTg0UiyXIrhw1drcDKf8WhNK8fE83Cw1lwnk4U/Fne09zHOZ9w2Q0XX1zSptixWSpRZoqQ6OLJfNZeQqrQ3EnIuCjDSZSc3wLa0vUxVI00l32WXIzEIn76+F8M+gVpPdnj7fxYjCLmxuvvtr0HHIQq5XvKPXCdcGJEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(6666004)(478600001)(6486002)(966005)(5660300002)(8936002)(7416002)(66556008)(36756003)(6506007)(41300700001)(2616005)(52116002)(44832011)(2906002)(1076003)(66476007)(316002)(6512007)(26005)(8676002)(4326008)(66946007)(186003)(83380400001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZcP1H04mcYxu5NF6LSE3BZ76yet73eb4yfJuCoXmvRWPphOuaXJqGbSBYgeg?=
 =?us-ascii?Q?CUIN+2oixkNp7MMvUcGLwxC+SvB+X08d07bl9s8UJnHsuhQ3yerZID1gLvJA?=
 =?us-ascii?Q?t0CBJQ9F1fOHVcxhDeJ//0HI3Qj30xt3/h7uQppTJUSL4ftC2IBmcD8sbeYi?=
 =?us-ascii?Q?ycsTZHW/yizMvY9Wb4LtLUMeIXxYtNiP5iYH8cHX9Y8D628csoPjtaa5PmFY?=
 =?us-ascii?Q?9vHsFrYJ24hcaPA0eW4XgZFhH8I1bGte/JiNDr17vuSp3uC5s2XDcRDQhOVD?=
 =?us-ascii?Q?9nv1o2OAOZd126H0I94hbvwACYiWjW7vNnjp6rSuxWK4bwyBc+9Zrj9X3hR8?=
 =?us-ascii?Q?w/sqXoXKZaJ1TrCBWAH1dQR5CXw+4EsqJqjHvbPDWzUvsdkG2Rq6zFwDcQJB?=
 =?us-ascii?Q?UGweGmHCXEzK8QThTSL2NdKq+KsH7bRCpenHExKkQ4LSyST38LIuua33fQgs?=
 =?us-ascii?Q?hXT4HovSQpipF4CR2UmZTzNLD/zinNneBYh5StffGEtM5NVG5rS+j/apB8Fy?=
 =?us-ascii?Q?SzYwDQNjFV6WLB28oWlypjtqgpY1xSa3EIVIrC6KPg4CcdedRt3wtWAcsV42?=
 =?us-ascii?Q?CmzE0U+kAjmmiZwr1h06hmqLJynu5pgLicYohN2rsDaDXQi8X9S9rjTYoZsh?=
 =?us-ascii?Q?SWBfRuEedCGxlh8WcrAqgwN72F/pxcTtS4M6e1wOivw4mR2V9iNZfCCsuqId?=
 =?us-ascii?Q?k2USMm9UW/Gkhp4wCeavF6XR4L9/iSEzHfJN3o3ZVA8xB0eeW89vjnbcJQMO?=
 =?us-ascii?Q?pXF/mkyYnL5WOPuIgWCnskpzvaM+3j9lwcZu4fRLbKdvfxYxP7xrt5mgA6to?=
 =?us-ascii?Q?x5WgCSMt0J2szVrb/3U0gQvrxm4dqY8N2h9DjWxSG+v0B//Ej/VAB3IxgwnX?=
 =?us-ascii?Q?jHH02vgZe9go738QCYDnH0M1E2VJaKolp7jwrt1smksd9oYEqck8JF8nXpab?=
 =?us-ascii?Q?K4ZnKyDVJQlVsKMgkz5NM3rX3mmQnpxengMRRBqS0I0K6+BxTS8mV4S2naeN?=
 =?us-ascii?Q?JiRlM3xVCOs4fCsIle0Wkt+KHm0gjqLqetd+baNNubwxo4ICcTsNVFqkarsJ?=
 =?us-ascii?Q?64N60e0LFDquJTSF+WQlGrvo8BQpQcmqX7+JuBEMUO4x96oqKS1YQaI2fSei?=
 =?us-ascii?Q?CgpmbxrTD833EYlleriWuKX2NEnoNCQy13N/tUvOmCFoh7xg2QQKT8a0CFy9?=
 =?us-ascii?Q?eHHi404Z50x3geE+rG3HweHTX8mQ+LGzQ96p5ZhSisuB+yRDOwMtxyTaezze?=
 =?us-ascii?Q?Irft21Xmho0jPGfmuYVAXnPYxjkrk+A+WWgVbcedKx8gBynNYg46yUe/2ZiU?=
 =?us-ascii?Q?1IeLOy3PJo9fpHj5+LMZygpj4GdvFmxOhdcEN+MFSX15wj63cyZHq8LC+etk?=
 =?us-ascii?Q?d5nrWwneas0SrRUyLk+q08Bw3+4xLg53YZQEqM40HKDch/f66m35DjItLY2z?=
 =?us-ascii?Q?D3zP1vYz7FnnEAnqi3z+fgfvTN4SkG4nEsqWjrI5l2ziEAMjVsuwlLdq6Wj2?=
 =?us-ascii?Q?aRDan1gfpVXnN5QXk25D7PZBl182wov2O7bkugiCSzmPlsT8XbVsK6vFAX4m?=
 =?us-ascii?Q?OuJebU9BupAj3ukeAuC+WuwJ4q//fWTfEwWWIbpD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc474fb-3cbf-410b-cb95-08dac6ecf95b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:37:12.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNA8lW/EVdK4wuGrbgRGXSZ/F6xIxOjai4VlF7onHgdRd5hNjDT1jfmJ9kna3fJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v10:
change refernce the dma-common into dma-controller.

Changes in v9:
add the dma-common refernce.
delete the dma-controller refernce.
delete qoutes.

Changes in v8:
add the dma-controller refernce.
delete #dma-cells in required.

Changes in v6:
delete tag Acked-by from commit message.

Changes in v5:
modify the commit message fromat.
add additionalProperties, because delete the quotes in patch v4.
delete unevaluatedProperties due to similar to additionalProperties.
modification fsl,sdma-event-remap items and description.

Changes in v4:
modify the commit message.
delete the refernce in patch.
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
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 2 files changed, 149 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
new file mode 100644
index 000000000000..b95dd8db5a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -0,0 +1,149 @@
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
+allOf:
+  - $ref: dma-controller.yaml#
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

