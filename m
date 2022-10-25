Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854EF60C68F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiJYIfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiJYIfT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 04:35:19 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20046.outbound.protection.outlook.com [40.107.2.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493DFBC78F;
        Tue, 25 Oct 2022 01:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb6G67a3/INFVOAdRtLusRSxpXLdGCXEa/KOgLU7tIAvqG3w+tckPEaE2qAz7kBPlwhV5ePf2w8BagbqABYackBcZMAumtoqLf5RRictGNWBzVYcchR1JqJj3spXJ8QtFr4/yBUU+K9VyNFk7TJnY+yzPG5rG767t74ilnUnMUvo9z8d71wYWyDRg9X4tgZVzf0koeR2JFzUtVntNw/mXnxPwSPoWeXTLKn8pCU5cFfve5001T9oO+WCzh7txD3tX+v+31dQIm/TcnMJFvBzikt9BGIr2ny+ELNMy6WUm4ZxFlRVaqsc+yFuHtN8wrVfSKI2Y901n9DXOEVrB2usUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SylflRXXaFH8xi2NFIAS3qALAQHUaiUaXpNs+xde5Ok=;
 b=iabynQYEKELEqsSAt+lPlZeCr0mK56tIgqKMiNQLLW4Faflvw0k7GGxV2DTQw1yr7kk1lGQSJEK8U+gXfeMZweTiSypj0smbbHQai5KWuGAS0vkv7XA24/03FAhDFr6no2gETWUm93xVcv5nfhFn/gh9waL2pRkaj6vhA5TsANmlQFoA0z0bT90+OwZKFP5ixQ0XSPYUkism5Hre9GXEi0p14tGm59QRNKWidYHpKpp1BXcyc5Yl8Jfbs4AtCdZS7ECpP2zCpanIoOmSCBqZThTwoNQDKB2uBzcENm+PmRfOKUDMnxPdcIUY0hFoUGi/dZ1YciKnAJoCdU12ZEK2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SylflRXXaFH8xi2NFIAS3qALAQHUaiUaXpNs+xde5Ok=;
 b=pMmOpIO3H/MCxIFLTkPzt1eVuaeuwft6iSaM41/18hrP9mBMChEYV2BXLh2Y+u1nGp6rwUNsNmwndNe/H6s1Z3XhLtgWOxsKKh+4BS7++A+1LxRSrgEHRkayixZC5O4fKaHibV8dgwk0RbZ2a//wmCpjY+YM8myvWRMGIrhZXR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 08:35:10 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 08:35:10 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Tue, 25 Oct 2022 16:36:08 +0800
Message-Id: <20221025083609.2129260-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221025083609.2129260-1-joy.zou@nxp.com>
References: <20221025083609.2129260-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddb48e7-930d-4f16-ee65-08dab663d3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+m6EwWnNRtcuL2lEY8zhTmvWyHv8AY7UtjP/9El0t7ceVUkIeoO08aU4nuweR9RnD1O48FZAnIvlRTjepL3TdLCvL2/ISUEqNShEAPkaPmZ2T/2wSY9BoxqM3FKWe8kSjWC4DucFWdDk9NDb/dMZ7cevoRA8hdUY4kqBkJHGObn193xM8VI+6AYOeLWtdvuw6THAZF0kVTLYlmNY7dUERh6Fd0NrcyqHGtM/gSeykpB773s0UPqGYeryW/pmyE2ek+RuCKHOSHdr3zfI5Wxrgc9CoVpbyyi0Uqgweu8hWX7JPv4YtnzWnPgLdWCQJ555E7q+Lvau0AiBR3FH36zMp+NYMeZ4dcZWKsFwMYsy9spPXK/8dwFg99BwMKytpWhi7YLEwGyt/rvdDZe8I5EZCnB1kMZ/pwV3r6vY+IK6uHDTW/f1a+SNblb1/piUM0WXtnkWWrxA1UWOq6XaGSNi8NtxSxWBwJDJlHYV+dDBJYhII/XfYxGk8DIR/6C1DKMekiLW0udbLioRa1q9w72spT7EKtVMJtWdMLVGzs9YlV04yPG7TVuXMN9tYAkT0VUZsIY8jbjGLs+6mOPQ4AqMUkXmQ5NjCPcfrLfVeeoM/eySH6JbnOB2Wj93dkYNGgO2UT+XNsCuRbdmN5Q08PSNOvQzXEKtHvBTiNLOHh/X57XQNJE7c6SO3Hy0wP/B9JI6HGqYALyth2dPzbzeUjFFJpYAghKzykFeiwVFoTX0ysoz+03X8VSUIOSRYqB8l62r24uJt4EEhq30ruoiqcdaQt55hLG9/yusT62HIrBvw+mw7wVeK/X3cBr94X8oG/uHyQjtTmcdlJ6jB7m/ui2Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(6512007)(2616005)(26005)(478600001)(6506007)(52116002)(83380400001)(186003)(1076003)(44832011)(2906002)(316002)(966005)(6486002)(8936002)(5660300002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w2m5Z6X5wSRI0nvEIaub+ZmKjALVZy0wR+3noVtLed+ob1FSta/H1wMHBgmJ?=
 =?us-ascii?Q?RCr/dKjO5uLXx1vfN4XhAlkv5hCtDv5ATgXPpgPsoLGO4cGUklsXMaLoix0X?=
 =?us-ascii?Q?/q4lvOF/ndHfmS4VfQBSMcHUrTqBF9lXMxhuLaG7agDGOMlT3rsk1tdg8HaG?=
 =?us-ascii?Q?r76f5Mpz8TMduTgbhzLADCW1atN5BrcFyrkJ/JbsXjDkYSIlioUMn+TL0Fum?=
 =?us-ascii?Q?HgeVeFXAF56MTP24o1nlntDNDFqxVglIR63mGV3KZJh0KResXo9W3PTBmpem?=
 =?us-ascii?Q?oKMMxST5JZKZ3Tx9ffTJYYIcuWI1IOoMXur7jMTQCpLpWF7pzcMr+AFQvQZD?=
 =?us-ascii?Q?uaRv71P/+e5gl933h3qal+lfVL8HA67tehla0te1SEYwkJ7yFg6GKzvHt9u5?=
 =?us-ascii?Q?gTVh0C5qtNxhBSh28C+M/hLpGaJTmvaifKPBxQCPecqVdsaWIe2dTIsNe3ep?=
 =?us-ascii?Q?s6ndAm4cqeeYaVFy9OYubdf7WRPEB+MrEGfPKyeLyiFeOchZnmw8B+vWv6+g?=
 =?us-ascii?Q?uSjyH05UOSxTNR0/rrWSktJmsLv1UIhmKOLYiqwzrd2RnqgUnIdTf69p3+BH?=
 =?us-ascii?Q?pY6/0Rmfe5NkomkQzhN1LEwOcaWALkSH2PSzr8ccAmTMFST4eje1eKSPd+nw?=
 =?us-ascii?Q?fhL95hfgjtTgp133WHaxBA7ir7JTlwqkqb7QreAodtyZ1/iqK3PpIbEIgVwE?=
 =?us-ascii?Q?cKX30+fbS4pQfzyKFuO9qreWTBaHL1n7k4sI3vtVbeNPsPA5MIb/M71f0oCn?=
 =?us-ascii?Q?nxI4hhXM2phbQTU9o9VFjAnV2bHHGwK56QJrN/HNc90tfSFI0krVjRNXLQzJ?=
 =?us-ascii?Q?C/eef0tOXxAolI3JGobEZOiN9EvmlKzxi/uIblZORD17ZGVLI+DsAHMKVke6?=
 =?us-ascii?Q?G8wfnndE3HhQqukXi1g4V5m3PaBA7vtClO64x8XCVkn0q3Lj27OmI7l1FUEk?=
 =?us-ascii?Q?ZRlWAXOw27IAEk6oyVi2rjQtayG4iEVkYtofwWvaR8ncnZtKmdetW3Ep/E4/?=
 =?us-ascii?Q?7Y4LbIJ2Dn6E/Es214axvFvPKyoiC2NLpaPzTAGBHdvEt9xFStpyjCU0c9bH?=
 =?us-ascii?Q?e30Dbs1ARPkVkC9XrjYpjpNkl9W/PQ09vi6v1WXtOTzGP0KhbDJYsWF3wD90?=
 =?us-ascii?Q?ignzkzbeKwMYrLBgaLL2C4dHI/LNMERwJ6Q+FwBtDCHZHsfgogp3IBMpxZdW?=
 =?us-ascii?Q?E+Kt8zLg6kUcrf0gQMvnkPibsOCZEeHprWjCEFFmUGDSoHGIWvmh2h0k6Vo8?=
 =?us-ascii?Q?zhvJcCayF7ep/5FANfDAEj8TqumXn7/iAQoXXhrqSwsnfc72wDERYerP4OQz?=
 =?us-ascii?Q?lb+k4WNEC+/OuIaA0bgfbzYSKaC+pK7DTrpeh3F3fqRMKLxEqh+//VCkc2H3?=
 =?us-ascii?Q?6NgrJZ8QL5odg4/lsPtvOfBKqQm02dqzeY8h0CgBagbZXuN+TjSAptNPAP/N?=
 =?us-ascii?Q?y1RVs1ZEIiiA56ibucUSFKvBiQzrgzAS67yc7ztTR+tHaWd5/39LohAjJN/F?=
 =?us-ascii?Q?9l0+YSPRxMxiB663M2BiT6iYM32xAoBSX57VarsTr6/bSAo5G92sDEcjGvE3?=
 =?us-ascii?Q?tkR9Ib8SWrKjA/+cv7dCHVNm5G5EQYJ3qs4GmAFH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddb48e7-930d-4f16-ee65-08dab663d3eb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:35:10.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEYm4QRfIfht4Zvh5ulC/VBq7S+Ae1EXJvlCIIjurQDKy3r1S+yiRNIjAcgV9PVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
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
Changes in v8:
add the dma-controller quotes.
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
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 2 files changed, 149 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
new file mode 100644
index 000000000000..fe527d32cdb6
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

