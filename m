Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E19605BEF
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJTKPa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTKP2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 06:15:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7113B52A;
        Thu, 20 Oct 2022 03:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec/VxzKcNDuObfJahK171UlZ6Pt1q/hL9GhOOlLYi8bjRJ/OCxYgPh/hoBJ32m89PT6ph9mcIDRPz+UNe8q9xDF9Ps08pM72TIojf0hk0oPkf08UcJCEFKjRQBqqb0ioxdR35RgkjzCOQo6eNINDYA0dJ+b0x0BOTOR3SaaTTc75Aw78F+kEvtOCD1ivh0VIXk2EdWoS0PsVUVhC9gW/EhVnEuXVHzO82UA5tV2t7Z0absrZTcUEENUFd6IRXy5oo6KYAOivYRn0uY18wcrHtl67NZ8HagpLAbBF+IGQ/QsJ4mCdeyEnR/nU2dBi/IherqbGRZ4B7J4Y66kHKn5r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt6fDI5F3i8dI1X8YcnvQdhddD64JWfTToiqrA14f5Q=;
 b=AKlP0fQs1LjaAvKIa2MIGVRMcirtTIZ/ZzO7lsYgU8E9CjihDIBAtYPVsaM8dAREWMnd7dRkN9hreQhI8gSYwDLayltndQK1ZbKYCRasyKXwCUrke0bWCod+T49ct5CL1Lzeam2oQt1MlJPu6evE6jRBE94eDOgWaYVNInLUtfR7kIypHxUoTSpAf6euk82HQTYwdocWb03HDMdYA5o95EuAffaSCQyvPCb/ECOGPdzZmp2yWu8NI40hSkFzjoNkg74AobT1YQiEeku+TwGHpsRO91jiq+6QP/R7gbwPnCNVHS1ZVwMkEWA3/XCXglcwcCZgoPI7BkcrjB+L86bHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt6fDI5F3i8dI1X8YcnvQdhddD64JWfTToiqrA14f5Q=;
 b=k+ZnRADAGIHMqUWBqGdL+NZss8mKZ7Kq5ivD7yY2tiaO6jj1axQHlRVvH43yqc40akx3mjG7msOITUDW/I8kWkauFL2y+zQRKh67zpbMJFqbbDE7Ah26LkfRFj/MsqMx5RMgIRTS1purWShpqrIbq7Ebc4Ji+9wUv+7McJKB0bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:15:21 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:15:21 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Thu, 20 Oct 2022 18:14:01 +0800
Message-Id: <20221020101402.1856818-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101402.1856818-1-joy.zou@nxp.com>
References: <20221020101402.1856818-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|PA4PR04MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: d02cee41-5ebc-4ebf-4d00-08dab283fe7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APJlSp/AATqEYrhZIjCNG/9iKCZMP+VWwjgE49apWyEaUaozBMdyFL83R0anjC5XbwphY0i/+dt4r5t7ag1qh5KZPxXLdlkEPUC5mpCqzA5JSxz4e0b0sIhNUYOEkZsfR6VROzL4DNI74omX+NpeXa5ay094qgKmM6yvohj9SHaIthY+yad5oLfOdqKzrant7XkKAp31TIm1hGI8PCFX0dawN1EYgVf09Efl75xJqiZaL2bqBmtWNa3E28+Xhb+GpdDgvFmDGxnfghfrbNt+mvb+4EL3xGB1Sul6Fwd9wB5yvXmODzaszxiJjrPxf6SQA62PrzkyujHyS9ahdDMKuxFNAqiTusixE4F0bddMHjffKvaHEaHRXSBBoT9VYJpMzXsHguhsMbV3ybERhMAGdZG1OphSxjzUm+/Xfqp3B+tj9sRU9feJlgrMQIGJSE506D8AfvCU2h2johc/ktVjc5fstQAuSb8pK6c6jwOIIE7iKlfpFQVTwTC/+cuD0eQmnzQDLqaBim44dcWYSTzGj19mRpHuNbJls934QGcZRepazuwhx3cAsMYAR86NC/+32UYiGem+5tz51kdIUs/9VOddCXU90Sr1odkif/uAHEQ8PVbWriyh3DN8ol94GduccpnxZO5bUUDS+QfIuWTxiAMKwHBhg9+i6fo/egDb/VI3yVmZdCrGni3oYLgtRgxp1I9HFtqmFr2bnwMHBiKg8OyBYsG5PpxUMWBj5dMR2Wm6Ifg4MUcP50oeXOgU0VO1yyHSmNk9UBRRQHFjtwawoya27aNe+Hav4PX8Hz8i+jd44zelMafGBY0OfikHU+k8x+EsXUYM0gRuEpPABQXSew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(66946007)(2906002)(5660300002)(4326008)(66476007)(6512007)(44832011)(8936002)(7416002)(316002)(83380400001)(38350700002)(38100700002)(8676002)(66556008)(6666004)(478600001)(6506007)(52116002)(86362001)(966005)(6486002)(186003)(1076003)(2616005)(26005)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ctV6FTIbSazuJYx9uSN3FlhHNp0NNJuEoqwyKbBxOJmdCNixBSWVb/GkrfRS?=
 =?us-ascii?Q?z4TNZP+AalkCKS9o/hFfkjtAr/B2q+jXyKw6tZffv4xlbjNDxLcCBkCmfBZM?=
 =?us-ascii?Q?J1CFZC5pUptN76NppaHY1HICXNY2FLRPY7rtM2ioruvPN/QK7GmHBD0YVJCy?=
 =?us-ascii?Q?1MSI41mgl8mzGItODYF3LvSxW/+bv97qmFvhz5yL+BuDTG+ZUgBLWMAIB8Lo?=
 =?us-ascii?Q?gk1PeDu3Q0XRxptpqRoMvDNrjGopKzkQGiihPNf7I5ca38JwAb1W6eKklgJC?=
 =?us-ascii?Q?egen31QuV5/YSK6CpkIWbsMajS4AZq4OBpOg9aOzHI1J2c1X2XMLqR2PjCZ3?=
 =?us-ascii?Q?Mwbtehi8fW0s03K2Um08VNunFVVjVy1XgHiVaSFYR2RZltrnQoF0WG53wGBC?=
 =?us-ascii?Q?J0w+MRcbj5Rk1CQVleYLvFbGKF4VKk4Xhk6mlPxxh7VvX3K6c/9QsL+YqNd4?=
 =?us-ascii?Q?3jV+CaJNCrTWKYbIf+fzHQ40Y8T8MmvL6WWyQMRRG7/Yv3t9POkBK2r9XYbl?=
 =?us-ascii?Q?+9MLvUY+fqDvJszqjSJnaPW3DLA6cXjQq3s0t6xmjBKSL3GfB+c43kq7WMKs?=
 =?us-ascii?Q?9CJ24X+oaLfbd0zFSS+1x/N+53+9fPn8rDxIflCAOMYqxY3PyOinWGwx5bVN?=
 =?us-ascii?Q?Ez909lc4G1oPlaFtq+1lgez2phw+Hp3lJNl3v3CB+nAA9Y/yI/48oc83RBO7?=
 =?us-ascii?Q?YYuKki117b5X2lh22CTRhNe1iyKRnE4NT8klKjYBCqrUbdUHdpBfFzb6Zghk?=
 =?us-ascii?Q?LQ+wWlaOn2Yb9DKLXSHCPt3uI+gya6rvWNCIkT0Is/eZK0x4jIO3P8OgIGFB?=
 =?us-ascii?Q?4KJk7wPgRETMaS39Ru4/6WxtiW1HUpiJcu8zkUoFRhBpt3Yvi6eqRb5zsA7t?=
 =?us-ascii?Q?9FCfqjqLLrKysYOMXNH29umLlKSwpm+ZSsmmoOq5q+C0+lNWSbsgcLHv4En8?=
 =?us-ascii?Q?MQ1s+U5fkIsrxhvqGi/WLhwLIA81N2VcjjN387a7A/S9X0SqXsMFTrEth1oh?=
 =?us-ascii?Q?Kb/Vbe6y/Z0REANRFrkYbUqXNkdD1lK781npN5L75QX1GIowoC5G1W8t33fV?=
 =?us-ascii?Q?xAez+Pn7X1Kv/dBRo2YMUG4/6z6zE87xmGBCdJtye2BxniKusFkGFncvxmfD?=
 =?us-ascii?Q?wQT0ftTbUH4F6IIXDjZgEOjtQ390HjImhRWv3Pls/gUH0YSwsgcBEnqLXJY2?=
 =?us-ascii?Q?5CU9jVLcId9e9qt/zaYeYbZP/0Qb8QcZhc1wyuRg37BA4D4n6UyC0MXt3+9Y?=
 =?us-ascii?Q?DYzJL1qJ4X0jpfaPLojsJ6PVWTor97A0uMW7SMNGKyv9xShPqYF0kEeJiloX?=
 =?us-ascii?Q?wC1MkGIGMGcURQbQ5fUmDKeVnrOi8nousMM/mbJin/WK+qnQDX6B+UnT6TXk?=
 =?us-ascii?Q?nHqvQkzXxefmMTe7d2jNu6PigdyXBbk90L5RRe0Qz9ueOMBjl7jZtREK3SjH?=
 =?us-ascii?Q?l+mTXhzQG9JaHr8dpFYK1PaQmMAKsm+KMYPUWscx5/Vid7fxFHJb7eWigusz?=
 =?us-ascii?Q?UaKmhW9NCn1K0F+eCnhvl+p6WYzHQ4igAa4AfntAa0jp/GmwUxxcIgvXnMS4?=
 =?us-ascii?Q?KmQhk9slAJKsXC/4aqRqmEqueqXafocTvoDLkPL1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02cee41-5ebc-4ebf-4d00-08dab283fe7c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:21.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufHDbA7QtXj9IqjYj7pJDa4NSnag+XqvJ3EbUXPH0FuPdSS3yKmxt8Ay6bl37vBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

