Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1809B3C6E6A
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhGMK2Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:25 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:36071
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235571AbhGMK2X (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7a8hxnPgyM9gHI0WUHIyqmRXsw7IiOp80G0o4jKSSqCoufi8QHcS8cW8aDUh7yqNRyU1ebInHE6qyiA+d1Kkem3wPaorU67NLPBdYCZyv04wU/j9y//HbYDKEycluaUoXQwjCqfnF3UN1dtNrCkovf0hTUS54m61FFSeXqpB5CJhjBwzpgYU8P3OQSt8E4nNfyJ/J0Hrw9XSTY4DMdzRpXlINeRg00drb4pppQhE2YQjzswFIgYZskGKGjmVB6tTqa3UFlJzi7GNDfEDejYWNxvl9IYp7JWNExy8kQxAuKDZLMyYNPo1EK6IX8m/G/bwPoWFo0PgAaThRsDlmSAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=LdvLJxqlN+L9+mAxhJDMyoj0ha/+O8gKTP6f7AyOYLgZNrYgU9F/WsP5o1CFG0BvB8b4sIyXS4TrfLgtZpS8CURycc/5jqLgd2Ij0qnbBzL6fZwumtqIOlAAkY1e11oM9NW5dCYXM/m7TOMie5En5BC5vEhxtRcSaj+BDjrLKxo/T54a95TSNsr1OkpTTIE8BqrieMPoH+tZOwatmV9JA/1b+7pTYCz5Vfclz8VwNyWAtOtMJ7IsSd+eSvFT4LgJ6U4eu6U2qQZ5E9cy+yV9Lj/Aa+2PcOfBzDEXeAfdFeqD7LtUrWfHBeEYt3GqJ31Wta8QReEHi5KHWWk+aR07FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=UEYIgDHIFj6kaapJ1xs8zF1YGiJBuCultzIxoC52tVR5qE14fN/+ExtY9gS8JU4FhqNpE8BZsuxYkq9YJyBmKJRkjLaNd9gjZBu2QT24Atpe05dxCDnT7/CqGSSi98/wnHE8OUuT6dR6a1kVh1pf77ZEVCbihrcp63WLmk69yI8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:31 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:31 +0000
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
Subject: [PATCH v15 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Wed, 14 Jul 2021 02:41:38 +0800
Message-Id: <1626201709-19643-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b99b9d6-3140-4a6d-b8ea-08d945e88abc
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288C89BACB8B782B138694689149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KALfZ8SykTSUAymceeL2W/KodJm6Hfvhs0IegKZHBXTpvQGoMdf2L6x3HHuxV96iySJ5xxUJp7yVu/MATB4A2PwgaIr3JI18Ga6ZlOnUkN1BfyeIurUdaLcSLGX0ev/kN02AZutuS1nIfei4l213Hff4SCw7YK0XPDlbqh/XQ/jW7qb9NeKHSzeRBBe6tNTzPQ/AjlsYUMqn0K3be4WWsSk6S5lcDB6qb4BSK8vpRFp3TYFoasUpRznC9EOTQeWtZkhspz1IJOgRiSIMaxBM2hZgSQs+U9Oze6QjT1RkoLKs7tvymr6mERegU6+IGsX5S6yk9BzUAMALL5u6k97IYstdVmVH1eIJxWNDE8TOzyTQn4ct8SJ7urj2mN9EVFrfAlTPzc7CUtbKX9QJHq/UZDE6smIupTQARQdckeb1Ezj7axQUHyt6ZmozndxObKgntkhTBEQW/NBK9lM+FAardg+pkKpH6nTcjB8xBAsG2z621YT0NYy3cXn9H9920Syj+EcVwclfZ1V9YrX51yWllDyNMXCWD3P1TH6bYVdp2/hZarmYfqFPhmzb1/Iz4EfbsN13H8ckcqnPe1BmXSXhvJNSBCstChqhzpDjNCocIriwne09XYkrFPev2/71W2K3VGu4mjcBYKehLq1updKtP6Y4xA4Qzwsi0TLFCxI6ny4N1SixffSvpa3h4D4Gll4EobqcyO9Ut2dSqi9vyMOPocuYfBaig7e0mVagiZX7jBPI8t0i7TJVLozvVci1iVK/wWQxtWGEWVN2osvmQ1EpVH9OMg7DX/5/4hG5bQFWuw854Vy2Ocpjh5pBhfUvsy2fAqFaLN356vK3Fj3YRrswgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXNdLFsSbsW0Ug3i0ODnxYgzpSkujaqlaVGgfd5D8y3Q9mY9FFnl59ddObJ9?=
 =?us-ascii?Q?hjcQy7uDsRCKhulIcoFddHiImhP4QhwUz+7TrbkJ35M9Fa/Wb7p62MmjCqsm?=
 =?us-ascii?Q?oLmb0qMn+iRYQOSIp2Qzeows4XG/DOengxJ9n90AGz5fyqeOPOtqElDVP1ff?=
 =?us-ascii?Q?GAsl+kWotpR4vCYfBziQ9b9wU/bmkQg0E/4TdfkIyKLo44bL2yY6gNOsIUYk?=
 =?us-ascii?Q?wvCrIdIxgn0WB/b3WX7M6+Y+88WCpBy1feCR9QuUftLBcrJShhBgra8keb4Y?=
 =?us-ascii?Q?BqI9Y7m1EicZcQQXnQfK8w/OdtOUxFIeyf4ptdYjmJFeT4PTmvb/9QdD+7X4?=
 =?us-ascii?Q?VDPpKRFFaavLiYBD6E8VxBl4nVzHqugNiFa7PPxEAEuAXW47GuDl7BAj41R0?=
 =?us-ascii?Q?lErSE1OB7R8yH41lKlxZabReCCiD+lsZo1fNBdaymNViZ/2XCXmLQQdZKfDq?=
 =?us-ascii?Q?x2KxBW0W4FSzmC0w90sIj9Ithc0QZj7uL73HxjBRy5PBviVF8puvReZGV26v?=
 =?us-ascii?Q?UNuD2rRrgqaEFPtDapRUKNGSjjFGRUIjbP/ANnvn6IFL+zFSnJ/5osuLyO6C?=
 =?us-ascii?Q?HsDZGQeOTDR3+X3NHbhnJLphMkF3zqBJCJbD226T++aNOavPxQRR9lpvuSN8?=
 =?us-ascii?Q?a/JXuTfW+xSFpN//LOwvx+ExJhIXsLfUqNiwwv3taTDWHXRcyRLBSqvWjwMv?=
 =?us-ascii?Q?N91iNfNteZ/xsuvereWtkttoXXzDMhB7WHLjctPnKjzDm+Z4aHRuBfJic+16?=
 =?us-ascii?Q?Dp7Tz8D/VzimqkbdYEyHTCr5XFFyuuf5y246TRjeUyx0dIV0/75sjL0ywvW6?=
 =?us-ascii?Q?Mhlra0rOQyrTNuRccCI1qW8anMq0UMQyYp06+GtART6lSai/7lB3PYveabd0?=
 =?us-ascii?Q?dWZT6rDvfH8DE3zcFlBTvmzUJi3kHbde8iXLR4H/DySK5QRbrkL2AC+kxYEL?=
 =?us-ascii?Q?/QNRfJCcc9I612X8dgp16Pgs6vlfcAmAw8AjClucX5cPjbNlcxGgyLfC6YM3?=
 =?us-ascii?Q?ubYQvRKrNZ0ZfTdpLzedzEoubKj5Nfy5p9PlUNezzdFKXCGny6ZC/RDzw6P/?=
 =?us-ascii?Q?7yh9j1mI0dhzsHJIDNtlqgYD95q+850TCOerv7u8gcb2vRqRyyXqBJqAXnN5?=
 =?us-ascii?Q?x1a7PvGTf8NPNQIrm/Azqc5rZGEysZaXcSXc8NgDKiA/K+iz2qCW8tY6lClZ?=
 =?us-ascii?Q?/IvMHlmi47DVGaR0TngfgDBpaEYlGK++DxXAGifcqliMdF5zrBIGpiuYe8Pv?=
 =?us-ascii?Q?xpqHXoNctwU0NgK6O2NDFgGd2HJn27vkKsZ/BkotMP5C1HNOAFBedJjmaxJT?=
 =?us-ascii?Q?05BZGxzmRnOnzX676XjyOVMP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b99b9d6-3140-4a6d-b8ea-08d945e88abc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:31.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtFpZwsVfEKvWryRpOzb9qi6a6wEv88//vtDS8zxhRRxOgVzO/5dXHYgrWOcEGuEtMBQ3I3VAA+2gpA1dvSyBQ==
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

