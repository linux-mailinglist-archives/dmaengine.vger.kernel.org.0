Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B75AE4AC
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiIFJtC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiIFJsf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 05:48:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF8A77578;
        Tue,  6 Sep 2022 02:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCdDvR8eor0EImvEEh+j7XuilDkipBiqHuQUZ+KTENDeiW0eW+G31AANGfHrqp1PvZ9A8h5nmQMc3DPc7LfmgiPqma8ilPPfiiP+F7jzqZibgqQffZfdAsVUkJ5TRceuSfA8rvfUrL8B9elMOZbNaI9FvdJUBZKanNQWKGipMqc2S2iYhhBXp6AX0DnhKYEy4vky/tVnTtAMue+rb94SANuTERQ4+fw1NrDUtdjN3o9ISrtJ1sVVA5I3gACNwNXUBdjflh7zQUmgvql99WPh092ui0Zs6PEFOCwoirppQ4Kqs+qnyrBSIZgv2XnMnR9qiDHzPfkjmFzF+vNzLPiIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0FmPn9bKy+WC5vi1B5s348FJ6sWh/6fPot6HI30w/c=;
 b=RFwF5NqkoBlcgKKzwDjGWNtoYV/YMVVMV5htUwBAy4yHBwqc7f5CKRpFmshjC+gLYRskHsKuJTbBbeek9ZGP/Nj2sym3I8TLzmlzJaq548kvslmKEG9ie8Fwfd0sZeUx1iG+mq2Cf/bU/hpiifJcl9pBlmszRYNfu4HhXd9EV5fxWwkr40Moj3FC459sB2Nzqe3wi2CnBcP/OOcE7oYswd0S/UX60U02Sx9WVaeW05MSFM5/5tFF7GjuRQZUBMaf98+NDFMeyNea4VGTkRjqBEdpxTVpV8LHCOCz6dGhq3DCqZ31x+cz/tCTFHpzaDZiTsrVr1pYrA6MKy/GHrP/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0FmPn9bKy+WC5vi1B5s348FJ6sWh/6fPot6HI30w/c=;
 b=LtHEbcSYx1k0VnFfK6FqB+JmGem568wNUEbF0sWF31HH+/zmesVC+EQ3OUF2EO/B/VPGuJGW3weHhy/4PICZ3qc02ucCBFb6XRdx6RtqFAahhf7BV5xRSF+cOT8s3E7M58LjGbW5ay6/pGRSrcRHGPjOvGeK6oKPxewhG52dF8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:48:32 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:48:32 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] arm64: dts: imx8mq: update sdma node name format
Date:   Tue,  6 Sep 2022 17:42:56 +0800
Message-Id: <20220906094256.3787384-5-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25fc980b-07c1-44c4-665d-08da8fecf593
X-MS-TrafficTypeDiagnostic: PR3PR04MB7305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I/L2Bz+Sume6KRFMJhW6xdzgqvompCgjdESf9/kacrmxIoWOoMwOzKgCm4do0ChYzEbUAtR3KTDr5pFVABldsFGvzaOql1hIdRW7NS6cq4gLeyv8PvHdNgTSAPbMVSuvePQkR1JwhLWkyHbP764bQ+bErydAfl9OCvWczeKoSy4J5ureVgxyAdNa8oNdKQXLvIadH0ZyDI8AO1tNRSucqTNcCLCdYmTrVIfXl9ftx7iDSHD6SlHAsbEfU1CaAjqtkEc/EAS12SczApdbWBQD80SnBwMIq6wmHAcmg/thV0qiesv9QtCeAn89lN9PzOgg1w9VHFwsVhQ7xvYYtxBeLsAv5ld59aMnGwoOEIZ2CrrVMm00sTPCbhOzhk7RUzu5kMo/FeXMlCg4RGwKePrD1mHLI6Gu8fo2UcixGhw6aEEilf6yeUeQIbKTP7S9nPaaoOtQ2bFGQ1636azIi8kUWQbvkviAl/W5sKtw7DTyX4JVne6sDOEg9qJcqgLoT24Wv4vYtutWys/IPnQkSQe+SlA6s2efR3y5Y/BQESYxbjduK0mDHWfQARdOD1MifHAyspxCf4I7fnSP7PpEhxcfo/DbCHSS8B4WAmBa0fVg2J0GCfewnHDYhFJ96MTH9UeHW4EThe54tedWPTFj0sAQTQb1/7tL5Q5tCVLFwEwrWQXNphOfJgWYedYKB0SxFztcSTSWXVoxoeOVsUZrLfV8cdE3Y9rkajWydk5uyum7cL3lyFn80/4lCACs9f55wyZF1wtohUKAG+/6NBrqXJw2KlCo3cfcbm7yxdJNirUjzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7416002)(8936002)(5660300002)(44832011)(15650500001)(2906002)(83380400001)(38350700002)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6666004)(86362001)(2616005)(6506007)(26005)(1076003)(186003)(41300700001)(6486002)(52116002)(478600001)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNmrjsCiZBxTYu45O0Q4pA2MAxSv56ZwyeoVUQVQS3xZKn0D4rwZp9P5EzRj?=
 =?us-ascii?Q?hp0FpjgLDreVbXS7bIe7VvWq14BtviKRa12I6bDa9uhUq99P6MnQSFWd3Rs6?=
 =?us-ascii?Q?o1H74H2cD9zF501uQl1T3DHKQoBdCvUuk3k/q1ks17I0N6b3tKqxJrz836y6?=
 =?us-ascii?Q?lpPEjcZKFdURjELTJdnZDEXnA/Ro0+NVP9do03QSAUjP2mgwTY2VCE8rhUei?=
 =?us-ascii?Q?NKNIJj7F2mZlnnU4EWCyjyUVJNuVEzM3i1emNXJv/xdjRSo3tdZS6Jh/zfNg?=
 =?us-ascii?Q?lcnnimhV/lvcKZQU5z9qruxNk1RuaPlBPL/VhAQWYYolTeUgktEFSxA41dsG?=
 =?us-ascii?Q?hsdnEMaxV45hEHir8qhSfhAf8tCA8UbqvOQF50mm0iFn6Hf+Lwe4Dx0RWMEb?=
 =?us-ascii?Q?b/yJ2heUWO5DRVgsxRBUuL0XA+hH7DKv5C9zt+N6mRgl5siBB/lKNUQs9vGG?=
 =?us-ascii?Q?UYiqcBmw7J2Z0VXs/eioVl953yvezf1NVlSgPjR/s4WIpMa4HyifqXFnxIMH?=
 =?us-ascii?Q?KMAiPmcDPAIszggWGwpZX4AfilmxTORkbsh5zNkMrhV3Cn7mtCHQX0q6DkxW?=
 =?us-ascii?Q?VE51aBH+CnsnfR5Ba9pPR5GmfUSSXvij1DIG/FsabK8lhlVovapkVeNt2/4J?=
 =?us-ascii?Q?krRAnyVLqZPotmsc1g1XLlYdTtSno09zCRFYZPd2a1Bn9KQtuvWAaSTNvUMD?=
 =?us-ascii?Q?RgQjKNj1d4h7aPtmIACV7wCR0zwNkzkilp5tSSYy1uZN0Mtdt20eKtXPnABl?=
 =?us-ascii?Q?+/AMygnZvfPH4er7jimh0A6DWiRogtcbty4zC0UKoO8JM8TkoaG9m+wjJtYx?=
 =?us-ascii?Q?xHJ05ZrBOKND7KRQ0A0QG2TXq9ltRRNt3vcYAQL1EB/CTyi9PphNWHtGffAx?=
 =?us-ascii?Q?P7dbkY0+gKUzHhVmzzjzRhB3jEmWW2dveeWuSHXjeEgsQpTI/w0g7cxN31Dd?=
 =?us-ascii?Q?VZLS9gzuo4wN2hWvQPL6nugObt8Ly+WthMhLCDmpmyN7zHuFy9V4xcueLiTr?=
 =?us-ascii?Q?yeKnC1c5z002lCjoB8VQZAxFu2eqLXKzZFHkeEetsBaij3xMzQxX3KUyahM6?=
 =?us-ascii?Q?hdjEYmdeQ31mFeD+mHFsGTENHjwunkSqq77xXCUukPxzBbn3/JFisyasjqX7?=
 =?us-ascii?Q?hGD45Qk9ocd9QbdYBzgyOXKiVXOF9Tv3OdSgqd6veETZlIAOBNX2N6A7Q080?=
 =?us-ascii?Q?YkOYuCEk9EnQRlvMWUaNvHbuQhpmAROdytgVSKiEndG2ZKzl48UPdiqsMHxT?=
 =?us-ascii?Q?u5uUnjxs21ZRDxf0mWhjlsWfegl5A2q1wE5twDJ5+yHOQEPkw5e9bTlA3MIb?=
 =?us-ascii?Q?u1avX4Xdl1XnwyjyrmzYpAZWA6QDqsDWEj35Cn8dQy4AogwKw/Nr+zjqN6P9?=
 =?us-ascii?Q?7hWwncejYyDyKHCPAUz54jCLtYj5bXPNK16otT0eUGee5eIfJ0zljE6OJeqE?=
 =?us-ascii?Q?T3e+3m6Xx87xvKUTZY50EWMy6cmsAYjalsUck2tckNu/6aFvLxRAXqaPa1Yj?=
 =?us-ascii?Q?QkRrwU4hu16a5GVolQHtRYq+O4546uvbDoN4/BkBfkhIcIPhAs/OT2hQUNPd?=
 =?us-ascii?Q?Fppsf/0ACsV332BvFYYzzvOrBh1oele4EXcx2umn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc980b-07c1-44c4-665d-08da8fecf593
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:48:32.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFWyilPi9CJfdMZASUmh2zT5Okl+281GQdFzH8tjWAFzRO/Ouogq2iB839hK5vAk
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

Node names should be generic, so change the sdma node name format 'sdma'
into 'dma-controller'.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v5:
modify the commit message.
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e9f0cdd10ab6..19eaa523564d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -534,7 +534,7 @@ wdog3: watchdog@302a0000 {
 				status = "disabled";
 			};
 
-			sdma2: sdma@302c0000 {
+			sdma2: dma-controller@302c0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x302c0000 0x10000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -1302,7 +1302,7 @@ qspi0: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma1: sdma@30bd0000 {
+			sdma1: dma-controller@30bd0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

