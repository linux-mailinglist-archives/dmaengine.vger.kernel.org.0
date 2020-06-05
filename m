Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93D11EF918
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFENci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:32:38 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:16417
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726844AbgFENcg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJXDa+C3M6tkNpndcrR6Md4tzhaN1LjT7OUtN7VFO48tYYI3dhwlHqZkSmHj/plFzgPl+wm5iZ8xm5pTlOT3UbhXvTBowijqyBNx7gxr3Z2cNcHw+t11kVVHnV0RmgXjJYx2hALZeBHsv7Oqtvqzd7PHSkWJC+cfdvBWTGT8tpP3VYfCrBK5YpSjm9DGIqOL/MvZFk+tW/S12K4+4HOxw6+PbkiON0HfgT43Xn8NoJ4IM9EMW/60vH1Jup1ncb6hzTh0QW9RpL0Q3LfpM5JKJoe4b/e6vQJpO/D6P9XDo/mNt4t74mWTZTy+F+iydq3FZ7We/AxRdfpBUWEgf00lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=kJwifkXD2PK/8KJHg/kex0xnGBcsj6rAF1iQUM8sn2O6jsY9YyvEZGDXgHx5q/06JC5/tF6eQY37zKCEmXxCCWJO0pfThzwil8wZDWK2o3o6fWWaju45S8AprT1O5bU2o0AqVXjiOUF0YY2aUOkT3ah1L+0lFfK3ygcEAn5fdquAyxmb1DNl4rQLZodoThG2/L61zmUNRV4+ssbf1GzQ2EjwXlEIvhpQXN/N8ZUoqmD7+0HvlNdEQNLe49pveZg9yO5Vg1o8iohJvnO3AFpY16vYOFsqhByM66X5krqYhYqf6YFVZNC/bdl2QSY4mB7HWp/HMuRhn5ichBEpgCZWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=EvYtOi9f1LvGWWR+R9swn10/AHnpy+ReGKqOptym7Qyt2io0cKxXOeG/dvOKy8FFJtPGT1vxgSvCVOhXvv/gLCyUXUodVr3KMGz/SJaVyC7wQJ3Fzy7dVVmfqYnIAEZRggqy6QfGIzpc/p463rtIG7nJk/uRRZcISjY4Hi+Ixp4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:32:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:32:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 01/14] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Sat,  6 Jun 2020 05:32:22 +0800
Message-Id: <1591392755-19136-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:32:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53c68dce-7ae0-417a-a0f5-08d80954e56d
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67026FE212817760F5D5FBD989860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1y4cn+y1ipE6RQHnGnvE4zsUMd68j6uqE/rqnKmQHHetSDuKN7awNCNNaK5JTPWnx69kNgI7zTc79TfhFqrGsTlx+9XaHuaD5QNrtFHZvK+UmyE3ER1Far5we8F7mejJrJkgQi3sPagLD5Cxfq8SziJRr72GKAhuvhNA/r9O4ak4avqWGx5YOT1nQwcnsPTKrXAqEBKVqUC0uDn+gtRQtpXpcWltzrGV05pclqMWrAhzFg+LCZERkEynpBunF8Qgz78FkhPoH3woDv1avld+UgfTj+bA3l0ITau2ThlR7NOHEhf6ymKFNqaDZx3Wq3LUFpq6beBcDJUfTgEweUqJTKNQ/X/3KvYZMtQeO8G3MI/Mg4iW6fLSxCE3627sZRizkWTRcr+Siz5C3bp0UdRljhAuiaSYg6YfBXRaheI6i2IMpzkfTCerjV9L91QZc6Y73Y4TeUbMIcHEvx+5Kw0vDkDjzaynSjJGn2oZj5n1uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(32563001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hfw2QgbLAPtfMIJuttTdIR/ItmSh+r3FcjHWtqESnepLDemnD5eTf9SevRGv4jsdl4mET1bIZXbdX3W5O0MZhGz6sT8BGxO5EdBxlMjgKZb9XJBWInv7RnW3FnSYQSU/gxrbeuxnhEXyUjXkwVvKPRtVec4qheF45HF/qpU/AoEwZeyM04pXg9CHghvDD4/9Mf96cmEJIgYz0vtJmowwVTXkiPl3sdYCL5UDqtA7Jy+BrE4gbESfOqPG9l+EReC9J37AvSxgBIDvHrkIU24VCjwNDAQ2eObVmkH7o3WKFqly6mQh+eJqLAwhQOdw6wzpKlICYug2hn1Jeebmt76wPmonwBE6hQuzjlDTkR5G/9coX9CMjgHOCwip34BwJKyFiuXqWpcu0Uj5ca9FBEAbUtUwiKK7F3ix9DfkEpiVKXab76AFz5GAFNt6ZrXGzWo/pIZ1n2aRxaCM1fKT83IC7E3/VdIAu5NZ+k3uQk5DG6Y=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c68dce-7ae0-417a-a0f5-08d80954e56d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:32:30.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqq1e7vOavquFrhI45NeEsknbCwJL27zxdKO159qIVMVgjQhk0y7EQuFic4gBfBhvg8eyo7yQ51VVP/p7Dy+DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
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

