Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8265AE4B2
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIFJtB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiIFJsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 05:48:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06378224;
        Tue,  6 Sep 2022 02:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvP33Y+AbPSxSvWjoMEZxn2uZYgCuquYntMball1sdK+GTxi+scOfCzOX7wMhSepZTpM1kInzs4v+RKZjJVk42lY4h3uH0MwkrHhUNxA6YrgLVNEnzbBHWordvqlnXcn3DMtJaF/wwKRfGM36mOVjVxYOYJ4nhUm9i+oSnJQo3TeETOVEQwvVlVECZtVvbBmrDPcLkA80Rm397wmJMvVkjki34zpHzdJ6aGi7Z1iCLhPG1zAaRhSg3ZTLMeLSLdNLv19yft/vgKvBr4DKJmNAHOev0It3iA5wgd0VkeZHHG+0m9GJSRc44g03Awr5TEpH7optnwqwJRyi3Lrt9bWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdSKn+zJ1W9xl3vGEDw7eN9hvzZQ5k0a2hV5kaj4deY=;
 b=nMu10tvzcPuOtc/Z5Nwj4nIPSAVaRmD/7hZ/NoA36TPJd6x3vD4/m1M9Q0qcE216JyzQR522VrgoMhZ3O2uSv9GDgzKB1b2f3i977Pb1CpeVW1D/9AxLvLrK1cOj+urnC9FZW9DQJWwntt73ObVgdYaiWWrbYzULQq7qcjYI6Ao704gB76YP9qc8Z/R3GgxCJ5xbfcflnlyT7iEpC0r0LYejkPSa3OZ7XHZRTElMny0IaQPUDnz3fYbGLNwqejVfki+iLP/JZtGfCdo6n62WlSSCRF3b24jWAfp0CXO5nU2gN/q62VYmg9fznaxjxQjbj5sNTSkNR6caesGhVbzqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdSKn+zJ1W9xl3vGEDw7eN9hvzZQ5k0a2hV5kaj4deY=;
 b=p26YzYczT0l0zcmaj7NQ9aQLjxHfev+jmq/lbdi+KJoeQp8fLPan1xyecdifidQpz2sDaX/0wtyXsLT1t48sbcWSjQQUkkpEDQwUV7j1yoaKO7guzrN1fjy/4xKQtb8rrCub5JTQ5bO/BvyBrQLVRZyIFKkYws+Osmn/XKoZZ5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:48:25 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:48:25 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] ARM: dts: imx: update sdma node name format
Date:   Tue,  6 Sep 2022 17:42:55 +0800
Message-Id: <20220906094256.3787384-4-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e553886a-5eef-45bf-c19c-08da8fecf12b
X-MS-TrafficTypeDiagnostic: PR3PR04MB7305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaRobycWyOCnxZtrcKmGJ9dlsQOAmiXpK47I6rqZq2I9HJ5G3otkSsCHUOxoEod15za0jZc4KX6JbXZpNvjk1Rh+zGGEGyNbZvr6/H15So2ZulF82/2byad+vGPSWHIl2RFrFqpBz3X0pN2KL6NYfo+YrOr+STJODnkXKkMa/PB5rGMdURdTBIgH1qZTQDev02azhoGtZaP+esV9QEbbwzJqoPdUJ8RNhK3t8VrFO+cAFw/4U4pXkcI9IXzYN03yaJxJkw6pf8hUhn7bq4wAjyDIpVQNxnvEpk7rh0m1h93nAMxYXyAV6fsetUWen0ZJ/09x+iJ6PQnqo6T2hooVQB8Xj2fQnrip1L2Hm9zFzm4XfXiO6MkuN76nk/BoAZfglBohSRmCM1UvPBIvTRkaBeQVfz8z2WNsqC/BEeCbrNYASIVR6nzGaOru/Y7zwMlL/KnY4kqfb4PF9OYrbpnGbCT0pWc75meze1ezuRJvRbtzx+TjvZW0lU1UD1cKwzOu+dxcE1QnH6+Y4qi30853TRKvnPlu56K/r2RAx2Rp+ZMjxml5urYxZ/dGmLzak3YDNUiEyfTymY30holU/0q6K560n/jroLDDf9h8iqGhj3Miu1yLY883QAIvP2mE85eVZQGY99TByqgtanbGf3Fap3GZ5ZCDXfs+tKjctuEsh5gfLEiPamkUWlQwd23mV6jRIeN5zPNXjkSzaOYHef4wxd0hzPb03CPDaiGRLQtfKzRbiVp5bncBpXKwjU6H4mZa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7416002)(8936002)(5660300002)(44832011)(15650500001)(2906002)(83380400001)(38350700002)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6666004)(86362001)(2616005)(6506007)(26005)(1076003)(186003)(41300700001)(6486002)(52116002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jqt06sfX7thCrQplFpbXZvIc3lJW6Hgfiqq9PnUMViS7n4fFeUplsGTXbjM+?=
 =?us-ascii?Q?dzUagBjFMSNg+YOCGE5MFBjdSrmZAsQp5Fo4QJVG/Po2fYxBCqSMMwSdr/yi?=
 =?us-ascii?Q?0syda5e1PRgl0dzkmmXSxoWYGASZDt7EAU1a7lEMidjkT/cDITOXU7PyBU86?=
 =?us-ascii?Q?2P/97yxx8q5iXrvwRVpyyZcmCSpGubBOAUP+lgAv+sWMBgw4zlKCi26+QLEs?=
 =?us-ascii?Q?Z1jdS2CyATK0/2Hfo09+s4xvdTlhhsRwy+DqmPA2RAm9Xv/ROYVR5j4+Kgr5?=
 =?us-ascii?Q?T2ux9afMentnNC/0ixZRcSe5EQXOp/B4CLcEqMVfy59QoyF2SKtFAkuekKEE?=
 =?us-ascii?Q?s9xKQ/LO0F/RWgu6jHj3MiT7NX3vaJhADkQP5vA8xOte2sdG3bIhFuboWkyl?=
 =?us-ascii?Q?Dl59vY25hIN2Z5bDN/xcWI2rlZ61TX4RxEqjxIulR8R4i9KbGbGp5WJXMxSF?=
 =?us-ascii?Q?Odua/tSF/ERAsK2vss1XX4+YHnaZP5sGtY6th5Kzn/sxSXPV85976ERyyyYK?=
 =?us-ascii?Q?vamaRwYJ6/lrb7XLN99L80pD57iGEgMD500BGO4VGyRCCSmaPx9NLlMKlUze?=
 =?us-ascii?Q?DSIwMo5JCg4rxCEFEbeTwu/eADouyb6MctvuLbNsQz+yNHafUhEhZveeBB8j?=
 =?us-ascii?Q?mOO4+TWRl0hfuH7LqkPv0ze5NLc0QX4cygZ2W9MOUO+UbacXG7ykFFh9dSo+?=
 =?us-ascii?Q?yR02D75rzge+GrCJa5of9/HX87tp62STVIeE3rwzthPMooEHodboFf0B5dg/?=
 =?us-ascii?Q?K+UbnTiQh3mt1JmFVHrwc4Ze+8T1kzp/wFfGUVse4RMgpSBhwKyfQJ8OGrmh?=
 =?us-ascii?Q?hrsCFkW3pVRx8JWh2E1QModcR4i1b6zZVzHuuV1bP/eeoOzaWmvNlEvWnTRU?=
 =?us-ascii?Q?MRyziJ0E3zr4AladN5/a/Y+CHCb1a1zTeM4jqq930obX4Za3B8CC+HnM2HFe?=
 =?us-ascii?Q?2ghC0NNUaAhvvTa4IxRY/L8XE8u5y0OLr1oI+To+4IGbm+xXGm+RBqmkS/G2?=
 =?us-ascii?Q?46NksR/lS8+PJ+xXHFfpetrGttrWIc1uOf56K0414v7HMzSSqlSb6ksvZ7FK?=
 =?us-ascii?Q?BJK3CRKhcFP2LCp4GdsRBhWL9LZobWZJIbC50KvzMNJ+sbw/0gmIpA1j8199?=
 =?us-ascii?Q?L6018CNHIcAdDM+pg9Tp0z7jNUmyM481WrZtTQk4WvcJisSnhP+lAM5xiPg9?=
 =?us-ascii?Q?vSJwMmnmE+CuuRTqVw+p5WNlYPmhwH2m9cbqaBYczEZLPlM8jfXE9yuUjH0+?=
 =?us-ascii?Q?CzDe1AtVer6w/xaidVzoXqsfZJUh9jghKf/+AiBIx1j3wXq1TcNgLpJqFF/c?=
 =?us-ascii?Q?p2rrzPKVHYC2R28A1/+IVI63gS9BxjXSfsnH0w/38m2HSeLYEAni6e0E94sY?=
 =?us-ascii?Q?OK0IF86G3qzLk8crOeuK9Cfb4fOpEemUKbzYE+aLLJoxpfdJ1BMx1LwpaSA8?=
 =?us-ascii?Q?yYNjWVsA7dc+29tHvOtSDwxWdC4rjjIPLlOiS1rVmOQAqyhNgCYodBJwJzBZ?=
 =?us-ascii?Q?zE9QRRh8pSCRU4ZbKtU5GQ4mDOLph+0rDuuUw4nW/t3w4iST/1Dvb874bglU?=
 =?us-ascii?Q?qlxxcHwTGASmTraaP3EDAmfmiOsAoDYbw7XAfEoT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e553886a-5eef-45bf-c19c-08da8fecf12b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:48:24.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgU5KxRFabFgLxroybMYF5K7hCtGhKD4oTnwzzLhAngfVKQOinKNhyEd962o22Sw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Node names should be generic, so change the sdma node name format 'sdma'
into 'dma-controller'.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v6:
delete tag Acked-by from commit message.

Changes in v5:
modify the commit message.
---
 arch/arm/boot/dts/imx25.dtsi   | 2 +-
 arch/arm/boot/dts/imx31.dtsi   | 2 +-
 arch/arm/boot/dts/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/imx50.dtsi   | 2 +-
 arch/arm/boot/dts/imx51.dtsi   | 2 +-
 arch/arm/boot/dts/imx53.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bc4de0c05511..5f90d72b840b 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -515,7 +515,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx25-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 5c4938b0d5a1..95c05f17a6d5 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -297,7 +297,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx31-sdma";
 				reg = <0x53fd4000 0x4000>;
 				interrupts = <34>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 8e41c8b7bd70..d650f54c3fc6 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -284,7 +284,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx35-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 9>, <&clks 65>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index c0c7575fbecf..3d9a9f37f672 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -421,7 +421,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx50-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 592d9c23a447..853707574d2e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -504,7 +504,7 @@ ecspi2: spi@83fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@83fb0000 {
+			sdma: dma-controller@83fb0000 {
 				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b7a6469d3472..56b3c13f4eb7 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -710,7 +710,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4f7fefc14d0a..ff1e0173b39b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -929,7 +929,7 @@ dcic2: dcic@20e8000 {
 				interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 06a515121dfc..61dd78467aea 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -747,7 +747,7 @@ spdc: spdc@20e8000 {
 				interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 4d075e2bf749..514ed4dbd6fd 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -842,7 +842,7 @@ gpr: iomuxc-gpr@20e4000 {
 				reg = <0x020e4000 0x4000>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sx-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c95efd1d8c2d..2b5996395701 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -744,7 +744,7 @@ gpt2: timer@20e8000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 29148285f9fc..0fc9e6b8b05d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1224,7 +1224,7 @@ qspi: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@30bd0000 {
+			sdma: dma-controller@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

