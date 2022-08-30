Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750EE5A5DE7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiH3IRm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiH3IRk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 04:17:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927BC04E0;
        Tue, 30 Aug 2022 01:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTJpK+6S5AAFqgHAMLaACJ/88yF9qnHl9oLLAmV6gyNYsLt7Z6JfjXjkF8hxLGKFrJNK2/vFWcr6e5RBnp5/L9oV/VHJ0KCO4EWgiK/B4ZhWqklMGzMP6KyMwYZkGv+wTiBf0/fpz+SFMvNnOHhQavIaPERlEfhvIup+SGYyXLf8dXm2UqOLbRzUUeNT/n1ZiLTLm9y9gN7l1sCfPOBtSiGS1Eqcom3siWkGhKKZpK/Rzji1fdJUZJqwFCf2cEEMefEPLPdlCzaB0Jl0A4ess9Hd5Z1YB6OFqZz2abBTJ6qyfoz3jjiWaYMf8NOWhu820sCRxqpUFEFsigNy0KyBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5/mF1q/gaHy3KjXpOkLy83ssrXXpHYJTBBgLzglGYA=;
 b=MADOPjePZZk1jM2iVL0g+3PmCL336AKJCk9w+QW91SQ+AHnFtDxacXW64b9t2h9jh4Oz0TH1QniRPWBw4eJkMFM9QNBlRx5i3oh2S4mT2vNlqfIlRTAeUwptsGVrKqXwbf9KuE3g5X5LHCnWIhSXTqsU+jV7E8RDd/sB007Zuh8LPg9oC5MGyv6FX+8VFA3oApKKn+eohvY1CBdc6iWk4BeF1BmpKiS68Vr81AqOQIeQxSYdS5uhIsNKnb8aONbJ2sXKZqpLSfWHtqImwXp/x4vZeScFauGCqnkxMbVpeDF7Ve/C2hxSV14CnUxDc0V6K6GRO4IRbvRGeIPEIW2/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5/mF1q/gaHy3KjXpOkLy83ssrXXpHYJTBBgLzglGYA=;
 b=EzGYMM78o9NqjgLT557KifR2xWDHq3OxvzIshx55fZV7AlWmPm0VKX/pGMHMX33N2XXap5rH3ehg9x6WRpTNsnLTW3uUeKou3JrYrVW53Ue4SeC5rBVjHUsKzgQDIVTt2PtDPmae7k1S7uF8poOeG0zrnhGJoV7uxePOCCtbUT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com (2603:10a6:803:e1::18)
 by PA4PR04MB7645.eurprd04.prod.outlook.com (2603:10a6:102:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 08:17:31 +0000
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb]) by VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 08:17:31 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     shengjiu.wang@nxp.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Tue, 30 Aug 2022 16:18:39 +0800
Message-Id: <20220830081839.1201720-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To VI1PR04MB5936.eurprd04.prod.outlook.com
 (2603:10a6:803:e1::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db50176f-6436-4c8b-0428-08da8a6015b3
X-MS-TrafficTypeDiagnostic: PA4PR04MB7645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i91GN/UNoKBDbD2rhdf448u/mn+thZzMeDNrqqHaSVli76Tzm0Oz3m+AodCllzGyZgydH3vPOmJWkRKVkrlbzsoU6nBPLj0zb/WWFdeluMGQbFzYemEa4gfwdhLdQ/qQ3vfUxG41Y4te2rRFURxqZh0jcbEwi1TYsHLr4yI+mV1RQtNOi64HQqpXLWcfLw3ow5gwjPnY07sJo8CMMMg5fz341g/YlVD/ZfF5faGAFpW4+wDILljvIQKbCrGp58CsVSxN3o2smj0P6wJLyCEPiIDrGq3s587qspI0i4Vm6xruq0HvUkzcmZ+wR0XxT1+ZAefizyoYTDPY6mtbb44tz4iBqZYx2hwho+N4sRa5s4lzgFfS1PkVCGHhmAG5oWPC/4NZBq09KOMjnt8u4NYH97nMrUtW5E8vWdnNihj0IlUduqsS3qh2/KcEfrVFsUDdPwWWATEAqsojK/BEfIM2C0jfIa9o6WQbs1fwLu7XxOmRkHE1RfgqSYq2ObGoA4ZhDi548Fy9Ht0KLPg+Ru7bUkuk5amdMqFTwIgi+b8YhEIqQWWqCVTskqrQCXK2nSLaQ0jiferv6KpmlVydkTzPI7uDiHm1pEQsPpU0414qi9rQWPSsA7Z8mxL9wV9enlQV6/bFhHhqrxqek32w9woaWAS/MCI84PvwYtGxcDvooaThpii2IEbAugNOoaBsRMBGszIze40rJAl6Nhobh+E1e/PWhkJW8IXp3hEe+pEUOq+bwyM70utoxyG5T2ffgisEuHVMcyiiaTUIO8ujUT8GFnigofCYceouLp7X7hde4F1KjG5yOlheyBlJjS9pqZ2aUWRWp5F8jqKSNj8OAuYvEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5936.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6916009)(38100700002)(26005)(6512007)(38350700002)(316002)(41300700001)(44832011)(7416002)(5660300002)(478600001)(86362001)(8936002)(6506007)(6486002)(2906002)(966005)(8676002)(4326008)(66476007)(52116002)(66946007)(66556008)(2616005)(186003)(83380400001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5XWW2Izh+Lfe5HS5ttTnsEuR/D62xyxbi49OsAu6mO09lWWj+kDYONCBXi3j?=
 =?us-ascii?Q?qUgim4XVOzEK0dTWoT55SnU2c0NhHhx4J342dkVn8K9wCP63EinqLcWsLpnC?=
 =?us-ascii?Q?HPZ+lYDEVsUW+xIO8dVrgAYclQPf3nblgW3iZ4CMmots0OTODYJrPghVr8yv?=
 =?us-ascii?Q?XXoaXsTSxJG8ITokqlVq18MPTh/RpHKfR9y2YruQnRhx+3cW5NuYEILsZZqG?=
 =?us-ascii?Q?8oXc8zEMLGEtvWVt08n2caU0NRFTVYJF14CyjxEdymMBce4ZPPWsCpnQRxpG?=
 =?us-ascii?Q?oHbFpvWOGURCWm78ZCMoD6dkmCVlJIplhB40Mr9Vth5vEUJWtH2Kxr1V5o75?=
 =?us-ascii?Q?uwPu1/oZT0TzAxvzg91Wt7P4tA3eO6JGhj76Fb51IxJVjrySVzmxQEY+mZfD?=
 =?us-ascii?Q?MhVlXmcnrJqJAZuuieg4ZEUYD+kh58HDgGtV90DJakTZ/eq5wxNu0kvplhia?=
 =?us-ascii?Q?MUXlo8KsPxdIxMzZoZjXTKRSTtbfAsM36IzidmuxA8o4r69WoLlMc48wond4?=
 =?us-ascii?Q?b1FYjfO6Em8Gt1d4TARrN1SjrEvI+2Yzn5/1EqMUzkRBptA4rDgxq8iT7o0h?=
 =?us-ascii?Q?mpB2pa+pKFAjjr/G0Y0A4fsrk82SWQ7pRFys6VXvIj8uIfqYvqg21r4pUsV7?=
 =?us-ascii?Q?6d9X7gwe98PQNhFy+OaMpdAHBOz3sKN26W26uiEMliyDXb0N1/7R4uzM9+B2?=
 =?us-ascii?Q?hZhukkx8ZbNlONZVALsADi0qmdPpR9wgDM2CyVsRnhqAxXp3BJxh+8bA0nUP?=
 =?us-ascii?Q?cCWbDkxU9NvJ8DNAXd267SAWUYBwdkqPtQ/EQYwMLm9kLB3VXamghyhpqpdn?=
 =?us-ascii?Q?m067C60OvPzKI4OVhOrasehR69q8K/FB2364bdE13kmktw/xumJb/sa+zdwl?=
 =?us-ascii?Q?dL659V2K7EaXAmYMR4+ckGI1cRHup0NYEu8PyGXO4x4u40+iep7LfSeKi4iD?=
 =?us-ascii?Q?KN8gFm4PTyJddYil776vwyxqkFdpBstHV3jP9SDZyhpBLUcXrExL43AQ7Gr9?=
 =?us-ascii?Q?mD2biNJN6bCqGnkqiMTYAntYPRx2uBGMeJBfC9u8dtkJ7iS1bM50kNO3HRqA?=
 =?us-ascii?Q?7zHVF5qNcfC+ysPBPFlZR1mnhOa++kS/6yd/MxJwmKuZZ85DV9iqYp0UNBkw?=
 =?us-ascii?Q?z6YUJ+dt4lz34jXl2s5egQ/veKq8pIOAbiUFrugcfzdTLOW8KnHTfHQ1O5Bl?=
 =?us-ascii?Q?dbhXpDMmlau+mAdNoiUIPMq3Q7jEURnoOAsDPvL4Mse6iO7D227D8cPlltsz?=
 =?us-ascii?Q?KE27yUfGVORr7rhBw20LO8GWswYZ3GFD24TRpkfpt9ilUR5s8U0TfQM7E2Dz?=
 =?us-ascii?Q?acWZ8gqRaNr1y60oVN7i9tPfaW8xI2RE8L8YZ1FbHgR9GZhOYw00TrAL5e+o?=
 =?us-ascii?Q?wscb8M2zalifIJr/RmRD3ZHH9RhokloNvj2OPWdthBl7PTDP+2oaVSsvB288?=
 =?us-ascii?Q?YyH4I4Z9YEDsHe0pExx2LnhxQFEO4itkLuQk5sAu05E+OAsAXFCRPn9cPB9I?=
 =?us-ascii?Q?dFcvV+IWoxUoBDiJIFARxLxLqe+9N90c0s9yEBXC/ICj7EtgRAX1Q1o3DPzV?=
 =?us-ascii?Q?EvRcCKonrE6AdU4viZbD6U/TG2czdX0hIcdohYmp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db50176f-6436-4c8b-0428-08da8a6015b3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5936.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 08:17:31.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBaPrg1eae3JfeldokAQR6UeKfY6RRN3oY8EQBeJySAO/xdCupmnGHp5wv0wle47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the i.MX SDMA binding to DT schema format using
json-schema. In addition, add new peripheral types HDMI
Audio.

when run dtbs_check will occur nodename not match issue
because the old dts nodename can't match new rule. I have
modified thoes old dts, and will upstream in the near future.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v2:
modify the commit message in patch v3.
modify the filename in patch v3.
modify the maintainer in patch v3.
delete the unnecessary comment in patch v3.
modify the compatible and run dt_binding_check and
dtbs_check in patch v3.
add clocks and clock-names property in patch v3.
delete the reg description and add maxItems in patch v3.
delete the interrupts description and add maxItems in patch v3.
add ref for gpr property.
modify the fsl,sdma-event-remap ref type and add items
in patch v3.
delete consumer example in patch v3.
---
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 142 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 ---------------
 2 files changed, 142 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
new file mode 100644
index 000000000000..54cd99ae127f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -0,0 +1,142 @@
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
+  - $ref: "dma-controller.yaml#"
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
+              - fsl,imx6ul-sdma
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
+          - const: fsl,imx25-sdma
+      - items:
+          - const: fsl,imx31-sdma
+      - items:
+          - const: fsl,imx35-sdma
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
+    maxItems: 2
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

