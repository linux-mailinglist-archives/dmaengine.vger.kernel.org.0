Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97FB241747
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHKHj6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:39:58 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:41888
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgHKHj5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktjXDfHiKq61L9slI9MoU2ovofMGIxoOPRzJL/QXfc87Jk8UjworAsfDVnGtA7+rrokubchGARgmQSMExCzHPQoKr7SUejGH3cvHgYCsEgmx8FyMST2grTQ7JvTvya2meapjnFqwSZQtR3T2jpsoq3BZfYdFPNJ1HO1xOqx0r8Mu8pQ5VwRdVTYFaoue3siWk2QyyHu72/pHIY0DWQQo4dapJmfxJABZ2+P8Ijdpa2MUcWQd1BbWPlbagl58iQPGjHM4HAon9UDfsWeM7AJck0bNl6JnGkHGqXHdHf8QUzRrjBNpDyu57sFFwhRPyfKVcHd4+1qRpQBi/IFfFkaiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=Rx/mhYkevhtKrNzpvVAK469V1a0YOHnWWeuhNOMmIBfmAc273mFxBaZGiH29R8m+cGfGeNtopNV8yvfjCoZodC4tI9MS+oLrSV9IMnWUY3KEWtPCG5uBwSxY4NWStvbjSJKlTlw+QbV5V6L5mmCfr43PmIn8RGCqamtDyYIx08mO4rPqicRc//7YPY12WX778FKGf0/XBxG15DqpuNoGU0N0YPfkEREnLPYFLWEKKgjJkxIJ4Knl15JKKHVVC0wAgZGinusMJSPc3Q4tvO96WiWL356ovCRynRKAkFiHjrhsTG1eq7rlbqvD3uRYN1N6UVMyBSkCUfjSXDsdGsEdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=mdQFsGwy1wYCqFdEdcS7dE1y2uSLA9neqkOugvjs8FePy+YkAwer+j+BV9uuuoevg1uPxioRebmcB1fbq9lG43RJ8mcQ7M9tTh2jV9pTEtOAYUTi/upHQrr3oEtQ3olcaviYJLKxY1Y/leUB/PzSPll2B5+6d4NGBX/R/1+pGbo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:39:51 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:39:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Tue, 11 Aug 2020 23:53:40 +0800
Message-Id: <1597161231-32303-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:39:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f653e61c-1519-4fe2-2210-08d83dc9bafb
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3464EE13FA8B3A0860572F8E89450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCEny4/mic2ItOoag4CkeXKhrnDLBEYvKqa0wDhdv+347+5whNkwIqPAVlYzCJsbYuCI/h+zD35eNZAMMwcrfT9+/j0WBvKktUc77Mt1wI+SgLnCgHRnJNidd5PUNm35huuc4ySSRAV4vCc0pp3CALDw7YbhffAUB5i2Hre+eXlEGyiYWdP9qTtQD5x2a2TxH34GTsnftsaj/Rrlkma8V2kF35PnhQU5LuKtNbo60Dcm+GxqrPzc5NQufVC0j5QcyFq9jZ26FnPFgIYXOPMg6fc9IVfQsMql4C5d+H/P5h2t4hYaNYTImNRmoBE+2UOHP+0eiX/9Qyw/733neO2unMLcvZNANXqDau4QgIk9rZNlsTwvXPpp7Lfbmvw90s7GN1R3hjwg30NKOTtNktW9t8YfxXgjK7BaT/F/HybdrT87PkSRWTHp6EP7W2yh9hkzakZxOcpZrGyfu5YM/Mg9kq5UEo272/2aBlgAsEUYV+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j48tDAU/VVbvc5l6vioumq4swUdi00kvQt7uZe/QbwcJ1dBwQXMIIEy3bZdgJOXXpBvW4rF2ZtKDcuHCTC8qdrzEv99cmB2FKyyNEiHOPZIpHZvgsh59XxqEDakdouc+wH3rCv/q92ooudgB0EGbzOJsHgS3WNBkDP5X6lXvV2rebzgP9nvdz6OtrLER68A4wduEeSgnDrJmt+Vk8HTL1bdTP8sMjQsBs+cvJVYIPlEiup+LQEH/eEmiYUZYTmV//S5ne/WXXu3JUptxmIePLxcgI71VQwb0l+9cBcVdn4ZAQrS+YJw2AqK20O2LyX+BUwsXSe6pfmDS8Up/W2ch5rSQWavI2prOq1CBtFvCzN9G42URTlkzeY7s9JlFXUlu5m4/36xSTwq1gB7oTycoR8YWEbmtqgVvt4gS/gGkpGO/+XLS0FoNud9JhNJBSQ7u7m8Uv6Q7/X0Dj/dUnAAVnMAfG2WPQMguLNv3gSm8sJ+hWIbZV7Gy0YZsodUxGhJzh8dMPy0+WfkhcenVqDahoXuWbYwdUiDhW8whIPQjPMbAUEYvLZybGlbubDJ48JuGhbx+3ZPbT9VH5yQbQEvTTrWJbAigDPrwSL1Avh8bimNeUEC6uocpib+MX0vvonkzAMrI2MFbsS8QojlH/n6f8w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f653e61c-1519-4fe2-2210-08d83dc9bafb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:39:51.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+jv6SH5PJHTBj+ktOpYGxkhqChzj3SG/0kcYbLNt8HdcdXY42F62BXlEjZ7CZ5mQG05P1hSZDQzNq/mTrvz3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

