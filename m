Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9303C6E6D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhGMK2a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:30 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:26754
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235475AbhGMK2a (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk8p+UUGzfNS4pvswg/A08uMzoqSDFvoQWbTzEVpdM+a7S1w2Wz7kHZL/oOJZCIN7Rg8y/pQ96sAa6/W8fpSM3T8lrKevBuEIarjJl5gDV6oIOBrdTjp9xvKogkrPuptdCXiNsoJmLlRh0I9o9nKZx45EPhfAFdSC8K9uFL9Yv5Nd2Z5sdoxFNgEJUdbl9JZSMbGXmPjX9hibKFbXDpJWDs3uDaTcBM+MYQdse4jUt9YB2fibGUnVH0tMYXGGwCAh6K/4DkFX9p0Nle09oTQQkMzMsr7trwb+ws8zjZjhEfT1y/uJFLOwSYBjL7Lx4K9DV9oAF3DJBewDRfczoGHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=aUJNP/JUaASGsvtbujDplHGbATj5pCE7DAMGLG2nEluMhzX5XDk+iZCyz25tYufe2Mlu28RwUh1e0D+Foc83YwYmgInEKFEt2AIh+VILTKXuD3JSzLmOI8/oaavsLQ3A2dj4JbrYhOCFLVCdmnE1DI4CfZLg79tB5JIjJX2G7PJDlceh00ww1wp+o/koGKH+dfCnBlt6gf/gSuL6cNCOCwPWQgnhySZJ3Tjo7oSjKkcC7qtl69X3h/3D0ccWVetY6d6uI/OCAVnc8PvU5jzVkdvxrfJVhyU7ZrEu4GgQOE5H9p20Dhh0OzuNdBuiOqQC9ibyeTG3/et2HtVHzkIYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=X9Zqie/nXr+toYCm5awaB2BFXI0CjHsqeZ7k9fGb+8Om/+nrIVJUCZo1J4+56PJQAk1BX+lszY9I+rygfVlYvoXheNeu8n8zyYAz/mEnNmkVwYaMfdS5jeViGro31Ug0YfN8TVRDgo19pKMeaRhKNXfvwNzWt7x+DK425hYS+ZM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:38 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:38 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Wed, 14 Jul 2021 02:41:39 +0800
Message-Id: <1626201709-19643-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 032fb65a-68f1-472e-e923-08d945e88eac
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288A5CC41F6D811D0FABFFB89149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47r6EzDbqOy9sLfgWzfRkOXY9m+5hH3whHnDqy7EKVp8g4bzLACC59FysmMVEbI314Y6NwUPpvdc37fLlFLk2ZuxsCFgNf0C6ZRPt680SPe5mQoZJ4H5My4Xz58OX38CRyMwb1dLMZxbvsABimnDuDXA7pYKJ7un0O4TrsWQQyT/ilqpvrQkgER99NPKfhf4vA84fH+FcNOEMGvuSJb8NI9xeXiyc3CDsdDVcZxEqHp1M6P5Y+x7a1R85uWJbUV71THG9cHcDAFCqarDQ68jGg+rxjMSJFoNj9Iv0pNq396Gw/49ngJa99XOuGBHQ44XW/RuqIPfAJB+g7JEUyGIulLKAmdO0iqyhZ4jFrkwihgFxU6/nCu82JiPOUZUfVKhndm8ZIvezR0BNaSFUQCKsXstfaj/7aSwjZq8nb6paBo+q8lOxHnMhP56i1QCNgf7W5f9UlwFgRjXXgJBAK46UXXmdTG3FKzKjBh1Pm8o1YOg2hs+2M6EeZ5gJ9//thr61++L4VS22dtyU1BfmAlfyCuEpGhLXJ6n78uRGyFezrHhsMgjitPT7sjsvS3iuNmV9UuMS8IMj2omxBnOxw9SFzolsUVfuc0LxYY9Wefk5E8O4oEDy0a9m6+biobS2agJRZ8xCgXqGO3chigxk6nLkGqAFo3QZZ220AgBLV2IrIz+hD/HtQ4rmHs6IxRevED2yMrF59cFrOjrV/4dI4Wn8faRQ4Ry+JWXIPP52vltURLS6uMR93oVgQRDNWrZvJ2Jy3rh2KjV2twk8uiNtZBtEBLdAu2GSbqW7ZP8npp+kdX5j8UYEgfGJNTSGVsu5YpQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6512007)(316002)(83380400001)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/26cykMMDyh8zlIAh83pYxUucS1KvyRXdAcfms3z6HEyn+vhtTIneJPQTgSp?=
 =?us-ascii?Q?oY2RpSLE6zkd1+OQ/jEcUNnPjzI23aHJHCfXxKgArbqrvp9J4fh9aAl6B8oX?=
 =?us-ascii?Q?J5ICWtB9t4D2YIqM2ooSlSZ3rRyQvsO2oxcf30sJDORSB1HfEoNTqmcBN5Rk?=
 =?us-ascii?Q?yJbk3gzqF8FoyVW1oDczY6qUn+bHrjs1qVcBD3BKCsk34T411gHIwxG3JdYX?=
 =?us-ascii?Q?ifZgylHDx9F15OonhMXcIq3Z02lS9A3LkbIoQdx9BUxtYBht2Mp1ip7kO6n2?=
 =?us-ascii?Q?0oGqKdq4MPslYPNVNOs9TuoYxBhZiWu4/7AZOzDGJE/oMuM9Xyy6bST8Bkp2?=
 =?us-ascii?Q?4uMQfrzDaYPEO/2CQ4dysJdcxce/SekN0JH3QAEZO31o3jLC8jjRM8dqg48y?=
 =?us-ascii?Q?87tj1R0RIfWXvq1M0jJ7j3qGIbmsCeo3Wsd8KLyM0dq+xkNdw5WKZ7vPOyMR?=
 =?us-ascii?Q?8qqNSzb1P89z+0HHI/tSa9dbXTFxG/OFbDxM9HjsvNVkGhNKsLxMptqCU5Um?=
 =?us-ascii?Q?5kjl9i89Em3y83qHS9URnoV9dw4Mat0HdRkX5k0NdAjZkAk9brAtjjXQEMc3?=
 =?us-ascii?Q?sCbArEu3mbGO2ADh1n3lomwyRZppKesjUY08/orC4ppjjUiysJIxnoXYKAaO?=
 =?us-ascii?Q?aGSi7W3mL5rOEJXPsqGNijFBuDrbLr/D1vrLQ9r1/tSz9CuSVKLwA8jCKgsn?=
 =?us-ascii?Q?J73P19az0RzgrdfkWtE1LEBpk0zxpHJJwAn+rKqEnaHRmmC38Z19f/UxGnkl?=
 =?us-ascii?Q?JaGp3uVqDf2eY4GkZvLWHwFm55YQTulzH7u27ASj0F0R/tpTv3I9PyGHAftX?=
 =?us-ascii?Q?uDSjKw4epds3Z55eG+sIaYs7zdbHCEiQYbnSN+yAmStulmtXFnmSHvEaU6EA?=
 =?us-ascii?Q?RpLifUdu2szh/UFTzE6c35V6CzmU81iQRfjSABhm3Su7jcJvQlwtQVWyZck2?=
 =?us-ascii?Q?R4XzYAgkmiOfFLOEQ4C1EJmENvXPaVUtFi3gPrXmG8N9Lxp7kP53Bzhkshn+?=
 =?us-ascii?Q?YnPB1lctfTWWIRmH4Y5FLWJAE/zsAPOMZhBIxWC1q72zW+Uir21Po4P3YcFt?=
 =?us-ascii?Q?sCgqhae6Lz63qj8cRNRifU8q/dcxmw/Ylg8YD14908JPIHdBNIpH4jG0WE6H?=
 =?us-ascii?Q?zCIKPy9AupcEpaT6IhtVsxRwQzJJ8Vw8JYCrVBHbcTvitx89pL3wbSdu/kw9?=
 =?us-ascii?Q?R8rWjjSc6Ncbg/v5Vw+M8/qEDaIOZSr3RfHkXm2ffB4hIB1l/X1LN+Tfxfoj?=
 =?us-ascii?Q?IOA22gDHCVmmGgdjYkrcLXtQ17hwNbYeUMYQmCYM3t5RaM51rTmwvyO09TVn?=
 =?us-ascii?Q?NwHnhSAZPVopcpd3vQ9CdyCj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032fb65a-68f1-472e-e923-08d945e88eac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:37.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dlp3BC7fQRbPO57ww+bknQV+nawIbVFXXG3DZUmiryQlVEqw6tGZ2P8VlnTqB69lNKhqT4z2ekNVSM7OyR0jCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are two ways for SDMA accessing SPBA devices: one is SDMA->AIPS
->SPBA(masterA port), another is SDMA->SPBA(masterC port). Please refer
to the 'Figure 58-1. i.MX 6Dual/6Quad SPBA connectivity' of i.mx6DQ
Reference Manual. SDMA provide the corresponding app_2_mcu/mcu_2_app and
shp_2_mcu/mcu_2_shp script for such two options. So both AIPS and SPBA
scripts should keep the same behaviour, the issue only caught in AIPS
script sounds not solide.
The issue is more likely as the ecspi errata
ERR009165(http://www.nxp.com/docs/en/errata/IMX6DQCE.pdf):
eCSPI: TXFIFO empty flag glitch can cause the current FIFO transfer to
           be sent twice
So revert commit 'dd4b487b32a3' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 82e01ce..89c342f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -334,7 +334,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -348,7 +348,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -362,7 +362,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -376,7 +376,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 8 1>, <&sdma 10 8 2>;
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

