Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3236122C33B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGXKh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:27 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:32999
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKh1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9UxHnw44h3c9OFzpxccBz3cX62TDEl+dkEk7ujQLBB47i9FEciJKM6SdXnwiz36Se8I5vz3tMmo+lIWtkW6TeBCniSoI95twopK8hJOQS3rM3qt+TDweZYlJH2YBBauSHiDku+x6HzrcQRy0gepuYIZc8ImnsOxMUmhfFe7cZylT0sOkNOkDmxCS4Afrj+jmhWTXP3KU6niSNAPl5oap0bkXHBxSojIPIie0WCmEKuTVFvF0aZAhn6vQQ47h2wK/p90CQtRTy95Q6ZcixE8qGlsOLXyQS1bqDbQkhHW29byYLyHHf9xT9QYngnFKXvXEiRqJMlasm94Hu9FKf98Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=SU2fr/xOzWRXd24Doy8d5QHs5SG1x34MEu4zNQ0vnt0QqE/RKepXo1u93xzh8qpW8YfWrXdZwUCCjDJxotH2sg83ItmYBUHosgbE24Gh06A+32+laeKwEYXeyjYDT8XeI4A5s/KpFRWzSllZgwcbQQVBBllBBACzID/e94i86ccU8zfnWi2xj7TtoZ5I2l/oaUTpEOZOZ5MKRAk8xltecWVIGNMrLMYXnZBNVFla8gJnsK/cOnZRgugDQmhCAt4X5ITQK6JZxWd4LVPLvB15OSo/5ucrM+2rg7kQD8jr+VtLCaw6mpbKzT8xbMW7ueeKVJ76Zs1ulIHaB0vfPGqwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=HF1zcm/C3BQex8EN9UNDgiJh2pr+Y3f3uFuSx+YMYaGT1Hzxq/EuGc50Kywrv2zy6Bvu2ikvkqSC9EZ1GnmlZf0fEiUHFkkYMBoXu5A8i1XlW5jUaUmQ19r+HFsc6crco6BpFT7z/r43+OklM7eIWsDkxoysCibN9uokWXUxiSQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 10:37:21 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Sat, 25 Jul 2020 02:51:15 +0800
Message-Id: <1595616685-9987-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96fe318e-43a6-4ff2-2e42-08d82fbd8b65
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB612597CC2EF464C5AA70ED4A89770@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzbXsT7+zf+ZHjU6zQfKrwho2q7Ed2/yuluu7k51QGi/inXyMa5xHQ6aOT7TOCzUdp0j3cRez/1gVwHR4AreJmBYFO1/6cYbE+vQ63dIl/TdA98I/wVPqzzho3Y+F4uGUGJTi2HCZt9bz0COlAQjBbq92Llw3If9vVggqlOtzvh7eM0TjnDURM07b7g14ftY7PixpS1k+GeVB0bXTwjPdt5m0ExELF1q9T+RU2hOqQQtKZRwYKVFFmJzTSDwDafF2dI86xmIhWijbAimXel1bQvm8ZsbtWOAAZrOo+kdNpLL37jxJSkvhW8G2AWo9OrWkIPX/U0EkVyLpvwA/fpQJGACUHMB3T32hAl6rV6OVjhgGrlUPBJD3ZWfV65GinSOMuMyweOQmtl639dVNjsOG27sbmbFALc2YLJtEUrWMQk/hVhjEzFGk6V0ggT4J3lN7aAAw5BjTRcqftnxykMU5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6486002)(478600001)(8676002)(2906002)(8936002)(6506007)(86362001)(2616005)(26005)(956004)(6512007)(83380400001)(316002)(186003)(16526019)(36756003)(4326008)(52116002)(5660300002)(66556008)(66946007)(66476007)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SN60KlTb6l5n9hDKZMDP1JS84gVHoC0Q4Mq2w4G1n3kKHOMo2LQadr4yiuQfgPdAQbVnq+i3LVQwFnesO9Ys9M9Meu9vePJMlrpxcqJMv+16PsO5q622KpVPcS2g81yDUkPwqwqMc4D2FDt7s9LyDIsyUD3hb8x4Zt34eAbDC+NoJD/fXDKsVanq41g5fFTw5iF/VI84Po6+954c5LbiH2uJPLKmQwR7auic1jBcqB5JhsFVXbvLihQiNs0REdSptZz0KxQLMAYEOdSvnFO5rrUkqKl1ph4PJepP49qbMa9m0ary3Lve17jwcoQS4BlZW8WXY0Fg1dfMbrdGe9ZYRW0NpvOeWZzISRoJUUa67H6uakQsF7kQjUMOGl0osN4YvCi0sPhFYf2AegoU/txPHw9emESJ8k9bsKPFKUTpaOcUBeI7ci2/AkruI+8mZ1ZcnRU26CFIA67U4mizv0AA+2HKByUWckpOeh0WG9Nem8U=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fe318e-43a6-4ff2-2e42-08d82fbd8b65
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:20.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23nonrbiH2KVh8Ba7i6O3Wc4br+b9UaGcy7gokZpBV8M0tIb164EfCcWorjXOylvAtY9iLG26PxfNVkHIWjPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125
Sender: dmaengine-owner@vger.kernel.org
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
index 346a52f..a8dedeb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -327,7 +327,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -341,7 +341,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -355,7 +355,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -369,7 +369,7 @@
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

