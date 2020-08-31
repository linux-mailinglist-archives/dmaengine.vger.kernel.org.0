Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12151257486
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHaHuq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:50:46 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:64790
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHaHuj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiMrqlDrFpwxg9aMuAoDM7IGPBsUdR/ghR0+mI5CM/lxLDYpEcHj9cT7+0HJjfB5X+9x15RvudpPyIadDE+3baA3eynIcSoRW+cKRBmxDfU0cLguVvy+z38PTZ4czsujJm1j39AoomB805GPbNJ/BZ4PIE4xQLJ4PuN22naLJUXK5U3gJOvhrDIv93zRD3xPuXQxg3EMqAnPFDiwZb8ZDG9jPyncvE2oibM+jur++D/Viy+jskR5uf/x4IBIH20J42o2DpIMe2tYxcxi7lX8nQKrajlQ+5i626y4NOgPie8iwmiHDfzECVdoDp3UbmZw5rVDKA30+znnuRctLGTGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=SD2JB0+dTL2awIUI8puGZ52Xiwx2Ybk010IB9f08tfaVuw0yOQcXnjFsCkIwkCqQvtCvFNDs0LgAoVZPop31Uj+EHcPRt6hRHavDeJZH3ofeT/UlcuDunsIx2XKjko9DLBUuSwBrsN/d8fA9zQKhsRM7pPx7km2bFqLwEjGeyhJ2RMhbzZfFZIoYakHYul7c0+l5wyEXWmGj5KZ6meCeokhtzt8kXwUYzIFCFOLMgrV4gdWz1Zl38ICoX64PuilLptoqOxEWlGMIwB3zUoUaQGlHaJGV2JUgvuIx/Yz8KrWa2SD+fx6A49wSYLz+pXPbk5niOc//QU2z+5uelO47yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=CYFaKuJotO+p8b2IOi0+Cadwtj6lbTa9Y+uITeyEwa14pm2fdhlasPsmaEIfl1HAi8ooLZkSzkKAjl27qPK7xeqRtXNqyLO89EZ62kc/wqZkYp1fcv2/v8YeVHHW3D/4G/31y7xp8ACQphoEYhZT4SNlN4ejz9l10QWhBKQFfIs=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:50:35 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:50:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Tue,  1 Sep 2020 00:03:14 +0800
Message-Id: <1598889805-30399-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bce594e-0a2e-4c4b-6bbe-08d84d828aec
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694F7363B2400A99790625189510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MF15f10A1jYEd1UXLDDNafT1cJ6VWudH7QVen97DsS7Qnd9cKop8MTWcqUCgg7OFAtLKUxesQQkoMLITfeAe60anwwPEL0zYx3h9/yVTcNG7wj3uM4GW45nQkZOv4V9Ze1d1IfsAqTBVJXBQjenVAP3NNgorcGvhV8v4RNtBl/9bEPmM6bsbtt1uA5WVF73eDVG9EY/MY/dLl+JO6ArVyY2uu3GRZCPwTXlYmeOh/OFFT/3n7fEx7NhwJHKIoZZJQ+sfb7gzlyHiIgD8HuvB+5xGnKrSzGjPq7qx4T3rViImROoWDZYRtH4ng21/xvnL4QmpeJeTC3GAx3GuYZekVvYT0uowwfbxZlnZ8UoNUpEDlht/bw9W7LQXhLpVjBbgwpgtJzETpEHKO8eqa2s/rDOJt23a+rR2GdHxJC7ji+LVy3EexMRG778csa5RR1VI46yPwz/0oBBVMsBqqo1tkPAwe93QTatTkgObA5NoWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bEYxaLzqfb3tUpwyup1Ze5SsAlC3dEOlUBa7OZZespKvE0UkJ65Z/8CNFVF7JhmsD8qLVig7MIY8NVz1vRoOUjphhNgG8eYBCvJByL68RW9FCu+bKPrPAx6874pd8bsfhTcv4253bRi4toMtUYb8zlJmhDSGXejvOR40Ke+SE5xavQB568MsKtXSr9ibmKvWNRt9bxjW6i1L5r7domSggdx28875qRDVwGbN8QHfzmSo1s0JWF1QgASNsiPFIT06Gd/0gRXHt6fQiUeUv83GfanNUAQ/iM9GTObTEYd/3ZyqZkuCPGfbnGcvAPzKa032zOGwxdXAVq6NY8871fNQ7M7TfwukoYnoWRTjmx/f39tVTwV6Op4nDMSxZn1Methn+2dEWIGuympWG114oUwbqLtHYulXSdnlJFJ3BmrQAUBA137MqxP2O53fYHIWH9wvKXi454t37mCjDG593lDpBbs0HGuazSRVd8+ACpjRPU9ykQj/N/UbkqfamtN3dZDEMCwnWigwSb8ZoZSCi5S91EvoU/HvsCcI10AmdP9vs3qHxVG3cxZlHm+b/kiTyHVP/HG+2VPWm63/vXsKiT4mp75Gziuje/xR9a1uFMA6BDsLL/w/ccxO3RBaXxMRplNZRBiiAXcazYHbIjbjgXisFA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bce594e-0a2e-4c4b-6bbe-08d84d828aec
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:50:34.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N4I9hwS/xb/K1+r5gGeckdYfQN+NnoYh7LPfV0vDHlOhid7ttkZIb+PABnMzvLkFzD3veRIEe9Gcf1g8F8XIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
So revert commit 'df07101e1c4a' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 78a4d64..afdd9eb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -177,7 +177,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
+					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

