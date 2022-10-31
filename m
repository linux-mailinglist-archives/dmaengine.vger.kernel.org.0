Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090ED6133E8
	for <lists+dmaengine@lfdr.de>; Mon, 31 Oct 2022 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJaKtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Oct 2022 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJaKtS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Oct 2022 06:49:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34FE2657;
        Mon, 31 Oct 2022 03:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWRbgQb7/bdxa9jgVWTy4HhuOar3q0VV4uQlDuQuSVTBIFa+M0ehOG2q+IeWFNLrO+Oup5MCAMHUCB4v5CknFndJ/iIvl5vdZhT+tDDofkDO40A1QuZZOYzz9clBUXmIb/aMdoQGPrxF0LGwZhMshEyNO52K3YZBHLw/JGNLZG1L2mBz95WSjI1N7jz8E0WSvEvFu0afVJDpKF9hN9vfUrOsK8TeWmfyzVy9Z41+DM9Lc8NTYgLSE1/TlYHQ8wN/Cs7RBDKSVqWNN/BOCaQBwQO6KE9Lzz6ljgHsLx5ZxY99DfY/RAfD/ptVp/MaZxFsSmdR/82WI7hdbYAV4Xs9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpGjsfV99uvPLZZI5+M4N75Xuwqy7IEbQfiUdBUjEGI=;
 b=KlpPYa3m/H4OfkYC0gGDAx/H4hTUp6AqkWoiD+bpq2Ie9HYe+d+B9qguEPh4JqTIEfxvT/qbrgBldTFRODT99g5hRY/eHqfTJQ8kPXcMVd7lDAD+bcf6epKMCb0xA6DotpkqJg3mHvUmgsLp2GsA1Bbt19f6B5TCFB75Nfr/Z+dpQi1iIE7xNuxxZK7ObHfByvvo+foAvGU+TpWZ9u/phk0mBTpM1V3G4rgZbkhiJFfuvGaUj3YqBojFipnF+q6wifeeJyy1KPxolRMuAjfaS3LUNaih9gJ9istUw9WhkDNpQkI0wzMzMuMds8xp7Dq+3OmYeKOFiuGf5zuWddnmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpGjsfV99uvPLZZI5+M4N75Xuwqy7IEbQfiUdBUjEGI=;
 b=O9V9lG4SZXhPk3oUBFvlrCP69Lp9kUbpT1ZqEuoq5KpdWs6dhX+WOWvhRHo6/d47nlrv9gNKVC/2b3DMThCNElTzZtehjb3MYbsVNHWmpX81aYpgKCxlc6n1M9dVd9DrpeC7hbA66N6U9iiE42YYThssU4W28yNvv9Uxmydc30I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 10:49:13 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:49:13 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
Date:   Mon, 31 Oct 2022 18:50:27 +0800
Message-Id: <20221031105028.598502-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031105028.598502-1-joy.zou@nxp.com>
References: <20221031105028.598502-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM9PR04MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe9c320-b2ef-4a73-6212-08dabb2d8c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcZtKA/fjSgZrVC8mc3w6vJEU/CYUJ786FdQCrUvCoKzn8LfiH2gMh//1tSE5IqfZeM5IMEIPkDuGQ26ZFsmvmzL5a3WU5XqDwnW9EqH1/TmjFWo3CCHrlmMiWwUkS7bMSGxAo2W/nwKqJryOjdlLLFMhzK6PvrX7QCvhuW7eAB/mGQlpvZ89VJ6HhApu3dY0D2yft+RfS73QyNK1+jU6fbSlQzJRQ5Ha+sNHzwtVQldbPa7BegJQ2BpP4z5iRi8p0Bzk2AzvDF06X4eR62HRKOVcIz33XMqDOTK8Xfk7iPiN0w5VQMvk7eXWveYIB+f/fjifnZsCaSdYpjGN+eoA5+G1BKumzqGd/lcpat5oMEYFfshPKYq7yl8V+RQOzGzfMc1dh2WX44yzLCRI+fXWqQUE0qyWCQV98w+VW6PsUgaVImKc5f37vfoxckn+tuVp/4coroXdWbZrkDYuwQUonic/uYfJSGwpVXEbhNIG8fWjP6KVF3Itxe/D5BbqC4OuU25knhO8OV4Au++Uabf8KrGLsBt6K5O1YZkBU6jIAJtgY4DDAZ+NDmtbo4JO3iapKLFbmUeoEuQMp6e3T31ETBxBtH5cEyaciV0sMbubUPqimzKQgLDFH2G3HhZTYx2wsg25miUfk4KoNnd9/iIdBHapVrfcQcP97tIsW6cG3E9rpINCp1IG5Kj1xSmjzPIVEX425hdQbOqBJQKeQwh3xXPU9nStQnS7vjm6Toh+v7/J2/BFRC4wXGXqGXGPb2+C5lGXN6ZspOSksRIqxSpihUeomz/ideE9cPBar90x+//xe4wMCidM+mKKvhqDWg+1vGC4zNXH1EKrAI51ktubg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(38100700002)(44832011)(38350700002)(36756003)(86362001)(2906002)(6486002)(966005)(6666004)(8676002)(478600001)(41300700001)(316002)(4326008)(66946007)(66476007)(8936002)(7416002)(5660300002)(66556008)(186003)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSs0lHA06gkP5wBlIbrV10nSlfFkGajT6ZJXcBePh0moctszpMYyaKimrLGu?=
 =?us-ascii?Q?pKjOh2y1RWdoVLUhhuCqPJJrE1Pa1mP2OHemuL8cZzDlylvk0pPmr0O/B/rw?=
 =?us-ascii?Q?d5kzl3v2Q6em1/IundIPb0Z1Dl/s3FLCk114tW462QkzWfxsZhb7T93pGSTp?=
 =?us-ascii?Q?ZDrjAOrnkybtn5EKi6VWEb+p2hV+arNO+NXc2XqU3c92v98TVYRL6Fm9Wdip?=
 =?us-ascii?Q?qxodkodQLCoKy2v/sLLp8vkgkgZkzzzlpLSvbsbdISuB+9orNiXieh923IrQ?=
 =?us-ascii?Q?5ETRmZmE5i7Du9+at72P4rf+v/qDUovjZON0y44hdbpoiW79vSm1XthCfp5p?=
 =?us-ascii?Q?RuiAVeI65TR8dq+/VgDZR2JKHbQCDIQplz4Wk/5W89eUwFFr/p1aWkBtLF0B?=
 =?us-ascii?Q?TKCvXWtztjmi7AcOftKms8UGO9ZEUIEHqD9nzlGu4FTjxiTt9dJtY5o7+ObQ?=
 =?us-ascii?Q?U4xlKFOlengiVjU6qUsweraEmuZVFWkvxLmVeax/W392UbT2CleY4lBIcGE7?=
 =?us-ascii?Q?8buKTyG5NSPeb8j1YoeBOztlC7+Sem9Lzrtzw4IqVfTumo15W3u9gc0Wd90T?=
 =?us-ascii?Q?nIDBauhv/kliBM8Hwi/EQ7fTmrh8X4dzlHcnued1b2MVK+30BeuSC4iEkT9h?=
 =?us-ascii?Q?H4zNDoUckuTWJ291W+p14fMmX6q8bVmwRXgiq1Dg4FKbR0WJxjqtmGZ6Gg9q?=
 =?us-ascii?Q?r3aOmDRdPIr6/ZWDib5PKZsCk5IODn5zle4UXg1+wp2obRdOh1jy7+k789Sc?=
 =?us-ascii?Q?OkRDtoeccnjHSVSFqcqe4+KZp9rth5VrWxGWXEVEudDj2RKsxc5ZqqaTXmMv?=
 =?us-ascii?Q?CPaxdKBx5kqDd4bX2wXnrNYtDZrELGr7uAE1pslr5CiESOansqiek1z9BwZC?=
 =?us-ascii?Q?DIhdudqE1olmKbDxagghy87dgfmF2DzXrDaqclIi/HZLWxZgQiqBFhA4EYXv?=
 =?us-ascii?Q?Ni7/0Zgxyzsew2xklAislSAp+Ef9KpNyhCtg2AhkqD6bzTmy2mPS9hJcpP0u?=
 =?us-ascii?Q?RqMXUIJHorAEiMQJ4L8oLGzgls3lzNq0vY0zeoWCOP1Z9/lrHoHws7S66/jf?=
 =?us-ascii?Q?5YLk1LOi5XrGvfoaj0yDDbzdmkczj1408uX+JmERQ/q8gc2S4U8x1t7VUn2D?=
 =?us-ascii?Q?ywLwYjQuhwcDVhyflNM5FYONWNkHehSesVLs2DsWz7YX4DClnchpE0tkv9ie?=
 =?us-ascii?Q?dnvxW2n70WowuaxegvXoKrgtR6Vunx1azIVoKGNzMA8Zmx6B969/qa8QSc+y?=
 =?us-ascii?Q?gTGTsWvw9mb85yjE7lLtrgok4qYrZftSBmVUayVK8mGl3+qOjqkmJFsfpBJM?=
 =?us-ascii?Q?IDhRUocwWuooZyVlArUWgiWG+iYQ/4A6cKDAppp7wG/yRqQ0GAC2lzh/8NnE?=
 =?us-ascii?Q?/ffbhKXRpVYq1uXt0SAxnd3Z3jjXDDS4+Ae3pyNsNmBNst6RagWAjwUAWQzj?=
 =?us-ascii?Q?FUdFM6bSrKWKIV4HMo6/XVoMmsvCsiPloWk4X9qpl52ToIQTW0wjWuvS5hZH?=
 =?us-ascii?Q?f7Mjd3CDGWlyRLREeNiHtl/hikAHu8m+y1iW9y6knBu3kBCMpYpjk3Fmd/Kj?=
 =?us-ascii?Q?T+KVbzZwk2MUMwWkRL43NJKHq21HlYocdEgqF2X9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe9c320-b2ef-4a73-6212-08dabb2d8c6f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 10:49:13.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AB0sLbs9vaxLFNEGxxmZ75d1qd4MLoTfAZVd//iCjhliVZR02NU3Ls5WVQI762l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
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
Changes in v9:
add the dma-common quotes.
delete the dma-controller quotes.

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
index 000000000000..95d0391a1f39
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
+  - $ref: dma-common.yaml#
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

