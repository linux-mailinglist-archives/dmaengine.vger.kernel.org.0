Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0D3564E1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbhDGHPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:15:53 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:7137
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346256AbhDGHPt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vlla1UVU/KWsRrs+NYhfsEZtF3HJYyvdbDOMvU8zTGRR741RpYzB/x+vbNDGPxLgA2XVihbOJq2uY67TYv0efOs3YZ9Lw1X+tP+wuWlG25mMOY8OAMlSW7B5qPjmxwTehQ1KwSrQCI36ftLg/nM/ZyaL258wfKmVDG2LE2mkepMRkZfWhLA2ndiap5zeLjbCVnD8L3AXW0uiTDpLdW/X9X1Qm0h5BXuYoXfLi7M3yZ0xPzQnCOE/TaVXL5DKqM8Ynl5nSRY7Ved6zLYUsrkseOtDY+dV4KUVkOnpv6kmu77r+FJzpUNGyBufOOk3aGajzLRrCMmcC/A3HiNLYLht1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=CQK/ly5GwqQE9RQpb7Wg3kaWcERse51wm/WNHzWm4BQVse6Fikckiso7684I9ZjtAcfSGRIee+myD93KOko1ubLwOh9ZecjI37PIzv1R/jXa3cCzA8twgSOX46eK9PpIbgnWmKaQQ37ZCkkuJkn+P7faTN/p18gJourVuhZVpHakWq6WX2Xcy6VUu/CuwQ8tztygt/smzBOzBxUMvRlXDi0Esdm01bGlQFMwLeVS7yHG1i8y6Jm5l6UaGCG5qGL1LXV0pBHqdOGyvhBt3itEYDDHc6npahFW552KU2BOgBY7m61kV+8rjBsymyKd9r3x3UgFgUVUgv1uesljvyiYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=Vtth+cVAJR760nBCaDxq36+u6+JR1BY4APwerskyMZYn7dKP+tYW6E6jxFXkzavD1a78BDXR9On68cxmrbqLGG5rkQEju1CwVLE0EYiyOA1x6tyBiV1fCZJ5nohtdp1ZPeP2SMa1aBrsMuYTK6O7zN3IUWDmP7YjX852vz0QVK0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 7 Apr
 2021 07:15:37 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:15:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Wed,  7 Apr 2021 23:30:45 +0800
Message-Id: <1617809456-17693-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb11d9f3-3951-44c1-1b3c-08d8f994f17d
X-MS-TrafficTypeDiagnostic: VE1PR04MB7326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB732649A66ED3132EC35A385589759@VE1PR04MB7326.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rFBc14QgaGFyKBFCHydRNsK208oiCsabjKwl6QeA1hYUovohWjqMRUZtUh5dPDJdonZ9wGxTPcOHIhaJiLTCEU+hPo7DE8Bzs9rIdQqPbniQAtvdRAyolu13Mmj52IbMFs5bnRW22VLMFq6GI4jOweJ99qhtmfWWNpl8uFQxBNj9jvqEJqIsQB1NSo9clxrw69X9gvWHlgOPol9I/BicMLYDWWxiLq4I9rEZDj5yJ0Qyf02BRmaqMPA4oWK5W3wUASWIbozZKV/r6gLVyLX5UepKlrRfT0MrfBcnNvBY20sMNAjbCkO+71zUiC7jsEwEuP2UAb2J/yUl/S0WXFSoUhi5YYrNgnzF/XcWKm0pKB5Y0+u49de1bCjRaB9/5PMRFPqgPYULfldwQgURwAwjcSL2dq+a0uwZKVNyZqJ0uO6Kx0DWCWvDiEKZIfFV/37jNkkgcsqN6o/fzOXu4sGVZ8PHjt0YNTxiODQFTtNLbk6Gd29qCvCXOmgNyloUUoLhEm2yOSiQd2WVRDCfO0NBJiL4eDf+N6GtXtcFVcuD/SDiJwq9Xq3gbaQ4Rp1iZl7//SI+gCqRbmIusP3TXgCogRemtc+yipGXn93OsFVn1E0IPBKW8tvgxrpzA43HFxo/SMIrmUYqeO4FjH83cNhq15RR0BVkxnKimUAoJUFnsml//kydKstRPi3smaWErLSEKodQQsZdCfN2KhA/zq/I+1bF+D1xWCMfjsYnV1v5X3bu4hYvFFrLbv2G3OTVMAgMZBJqr/MokyvcC7pQa8vI1EZmWDRntE1dyO5OqOykbBatVlGxVI4wqKHDme5oWbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(7416002)(83380400001)(2906002)(66476007)(5660300002)(66946007)(66556008)(6666004)(38350700001)(36756003)(6512007)(16526019)(186003)(2616005)(26005)(6486002)(6636002)(86362001)(921005)(478600001)(8676002)(38100700001)(316002)(4326008)(956004)(8936002)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vT/cUA+Fk+Z+j/ytk+pjbSk7xzO2LyhQOstaZDTP6Tnsdzwyk2tfNRaHzaf7?=
 =?us-ascii?Q?mPB4/PNzvV0mMFP3mL7fccPRmhTrK5IxBCr5mL6do8+Yqpu+eqgz6bv9+YhR?=
 =?us-ascii?Q?K/cs6YH0t7ZebHjW/o3qiqzABEipMZVL4Q4uQd0hQOYqWbuIPPEclxr/zUQe?=
 =?us-ascii?Q?+3rh8Mdg+DkXoL5BjwZ2XpW38q7XpGvq0TF0WDkZ3XVBBLzCBAuu91ySQED4?=
 =?us-ascii?Q?EUuGIgIFz0HOOahstwDRipjp6h3tEFHlvsbFev44KuGE0Pz8r0OMn1YLj/a8?=
 =?us-ascii?Q?aloTqUDidE45NGafO2vCWVWnrsyZbLcZ4rGMIYkCg+X/6hT4yL6iPrC+RQgi?=
 =?us-ascii?Q?9O611bU+M0q/SPd/twedzbKRb2NywzNsVVK8rMzM53MndsPdCQH9KXub6MjE?=
 =?us-ascii?Q?qrVEaYE1qt4BHQPHznQYIciGOqIGSozh6+glm+iMghhdnS5lQwKoHIqsrN4w?=
 =?us-ascii?Q?qyOOrM4qyGbn0na2JAGbDMKI6eI/Ob4jw7aWQsJVW3jI5KX4QZfcOQR+KUS+?=
 =?us-ascii?Q?4MO1tc93N4z3Un6AAHYx3wCMSX4Nx2PHAI3nvwllSFEH6QGST1XcioBQnEE0?=
 =?us-ascii?Q?d0HkrF7QgSRV3aO67En5zOEimzmuE03uQWuLLbH3GfPMreDdhuqJIyGd0ymv?=
 =?us-ascii?Q?gJabqG3e6uwL/CkgtEWX5lc1PmnZ0cgSzzvakVl+g9vcmU+GT/pVtj0hZU14?=
 =?us-ascii?Q?Pdy+AFITlTGQbT+aLKCO2kxRW4C2s/NvEEmB3rKn3rWGRsEJirr3OmhHdKhz?=
 =?us-ascii?Q?g1Z7WVrxyBtKpGVMvYCBBeWXwhg5rMM3qvfyc6TBm6GYPlcV6wyreu9Wkzvp?=
 =?us-ascii?Q?drfxvbhwB7OxeGWyIAW4ZTs099iZK58nOExREmGGYY+FMXWb0D3jj12D6sGV?=
 =?us-ascii?Q?xPA24sUSmKGR1melygZWe4rJXvJ13DwVMYzbHUDpePns7lkpwLEY8dZBljiI?=
 =?us-ascii?Q?tQ3J4LZBlbufnpX5OkFsb8r4t8yTGWqUbWbX4pt1BETNy4XpRNgOh82W1iuJ?=
 =?us-ascii?Q?kcM1ljm19XCEtj8nOArnyFg/KCbBmtaiqjHChfomrMQDOouSUH70ABMwdC8b?=
 =?us-ascii?Q?is6m07EQlMUmpNihGPWSzRcUiVr1W6dUMi+gF9CDV5oFn4hqMKo8nRK8OkYJ?=
 =?us-ascii?Q?ut117A9WhNrQI8z99tqUcDs50YU5NhhbJZ+6lmWDs2Guw0PvLylaZGVfxww+?=
 =?us-ascii?Q?0rvH1pFCdKIQPsKcKHxzrHLIJqXRotipC8kx3/AwVtAuo1SeeCIiZaY1RwMX?=
 =?us-ascii?Q?Po2q6tvgfAy3Ecy2w4wXU+kIhnGMfbgb8CZW9+Axe/PXUa6xRLqet6RmTgyw?=
 =?us-ascii?Q?A7NQfTSgV3U+DMh5LVXRB2E7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11d9f3-3951-44c1-1b3c-08d8f994f17d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:15:37.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cId/K2OZOoZik/mITYwpj1rAs9UubUove9GKV4+Mn29A9U4NLvRLjrv0aS7T1lLiBMSaF24GxWqgUq8VeoKSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
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
index 8d209c1..9caba45 100644
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

