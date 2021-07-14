Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B937C3C7B4C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhGNCH0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:26 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:46992
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237379AbhGNCHZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLIPhJuBF+4SSEZXRVXTpR4sJZkbNXiDAjIBdyojPwX0SQDK2gLcJbZRrLOwvoRBF8+8+wA1xhAkiMmh4nIj5th1qHEFUjrZSoM+RxN/HXKyqdqNfxjqfZDUu8h9IEwT+tmoNBs2KKtpkFLgsyOvQEH1Cc/gJ/oVFPAsiz/AbysvI7OIvOUGQfIeYrer0gfZ9GSvSTwlZgeJGs3cZhb3CiRszeYWEecT4/Dr5lir3iOkciAe4Rti1I7TnBmva2crp7nU9En7sdiaMWjAAUpMOJLGrNUWQ0PZg6NRqpzktMdYT/FcfxFgREhzwffnEEQgUuC1IA0rEpYHsYCJgcPNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=JI5eMoe5pwpWMhwXt2rY/yyoDX6kr3X9tQGM05GskFUDXchHCnc7W0BwAYWJ4KwzlCf0NBORS8k6tBsJ7qIuHvysh8LmG2t899v4J4Kz4dvbNBC2Bg4T1c21m4UJXdDuG+kE15MmaaDVhWktoH3Q9x2WERCS6fa8/zdTwB0MKeN4JIBMLIP+yirqghjbvH/va7V5ahfpLJkxG9Wbacn1vqoeDz9oLrr3EC5hbN2LAR5nR1OhpRg65nKzvkAk0QqYGIyCzt/MGQYctTUW2Yd9jz9QtvHwwG3ftR5GjniMxYmV37KglBtKwbOOoE9wBQYi+M8GhTn2EkccJ8d7rJkbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ72kGobutbcDxLx+bWS8PzUgxHjzbso6I9Vt7rhhAY=;
 b=E67z2GYD5ITcuV7WCAtN7a3PnMIae8We2cuZvZb5jwMqQqWoXoCbsmMzf6+zur7oRfLNy0LifpDSDLFocVsI6bY0OBKSgUZrkJDlfXjWankvwQ7Eqq1IsrTZMau3ZUPcZ5NioyY1s3rR4Rd5MUPRm0WvtchsUtZzAsm1DZyxhpE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:04:33 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:04:33 +0000
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
Subject: [PATCH v16 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Wed, 14 Jul 2021 18:20:41 +0800
Message-Id: <1626258052-22198-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37fdf83c-a0b9-42e5-cf7c-08d9466bb8c0
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175B0762107432F124B573689139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnkJ5qOHuQraGkO+kP3zjYkfgv3zY3Z/T0IOI4sfShcHAmAOfTbowFi0qKvaAN2MW+KJ7lO1kirSmV83bHDgy2Vz+N39g04ZGHxyN/dR/xM/YpKcX5NmtJmIpgV6duyvSGk8zXJ48T0QxL+3TvW9nrgbD20gnno5nT2jmslUNQGQSvIozShlLAbFu9B9rcr3VztFJEBWI92BGJdRfJibL38JH5uYS1vGT06NqFDLYJA2AJSvhZHXQpjdEPASi74pMI2lOkLe0icOX7h0Oyhbyk8cow/Q2Qwfu2UfE0zSxtI0kOFykmna039RUTAvIlzpcdxektYeKFznOuk8+XjjqT0oRIYgwWMP92zJzwT9pUiRAUkSoS76NIEDsP1PUBHUiJwneO//xx/OnYGzI86nqks3b+RNimIOlC+Y1RIcIzxxzi6EMSPsDRqBZPtA70czsnZbuRp9dNl+9TgNW5X99no/NncRsFuZsgFg5F8qObZzvwz2yymUJ9YbPUnwGrTGknc9ERpuYNc/6U9Qrl3YGdmsi+S6DW0UgUmagaDn8wQLWSvWG7WOwI1793ABGuppjmb/WvdeoXHfw/dMram0aZkcYFuB6WQ/taSxauNbSYRO6US9Ck6JEGQeBxW68f3/SEuIaTbgvKJPa0xi8dnNhz8rQI9g+2STB2wNKEWTA+YVuc4peWSxTGQn5f+ZJeplTRy8w/DhWPDVYN2GBKUWMW6ISzeFrgu467fve2HhL+uAAK1UTKUiWwyXlgbwFaQXr02c3ZV+qNeyPzzs5QXXBRL7qE5C8C8LgMLUQQjwCieC3fThVeiTSMJiWIYOReOrcaAK3J/r0KbSdFeRUjSYlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jT5eXizo75RlpKQu9OjBhKxVGcZ6yQYMNymDtdL5XvDugASnv+pc/bO3DCKC?=
 =?us-ascii?Q?vCmzd60SrF1udLjRzmJIbyN3s9U5fYMyGAlFFwjFLn70BN0HYJ7YbGGbkrRD?=
 =?us-ascii?Q?lNOMCSyvXcGxSzCQMrgwozoCitJ88jAKdWwRzK6D3lBM/BrdPeFyx770d9YT?=
 =?us-ascii?Q?WypW2a3CybH6JEh3e2kWSu28D7kR1ll5C7Ym17bo8f70IChF4edVBWSiZwOn?=
 =?us-ascii?Q?8615Jl2P10OxEi67YrhnfuLLczOCdJyfxETsJY3SCbzSqz30YToioiWY1R1e?=
 =?us-ascii?Q?tr+zzdeVIQX0bArGdNSs2sWgz0BVw2GGelHlOhMQGsI5eevAE0vnE3ERYDnT?=
 =?us-ascii?Q?ntnqZuv5Cjh3xh6uiSUgaYuO/hI8qrEsqPCk+syNok540guLYsWE2MkB2oJk?=
 =?us-ascii?Q?MKxoiUJbGmkbA2Y0gVSpjKMLibNkAo0gkq6s3oqICFcXke3d6VsL5bQ4AwtP?=
 =?us-ascii?Q?VIklODVbHz82BtaXfyBg0+lT1OLJ2MSahdNi9jVoKXDQcMHSfxA1x/6zIJjQ?=
 =?us-ascii?Q?X6BctD1+Sl8u++ouj8aK7OCKRB1CV+JqwQYzorvZDtMQItrx3dkgMNP5j0PI?=
 =?us-ascii?Q?3ZLmgQf2TEq0i4y1wYhg0ZLcf3qLTBn93OzarUU/vhhkcYW/3taI8mGlqwUu?=
 =?us-ascii?Q?LMfIUlHNd18Cu79k+RBW3YR2m1sC67c/Ie6Q9HaLckH9iHZLdOB1381F7rT5?=
 =?us-ascii?Q?2ZilCS7K3IanvkC0RovMSICvRFFDKAnL/r9h/p0jkMAUqCeDRZzzvgG1wttY?=
 =?us-ascii?Q?EqGgCSqQlewjx46/6OthyTnRLC6MNugiMfGTyU701aeXPsBQLjPIrpexpogr?=
 =?us-ascii?Q?yfsmdPq+F89h3KDxfkfF4E4PJ4Gce4gJSkBoLBD7dRKGaDr99hUBeTn5wiGK?=
 =?us-ascii?Q?M7py2y17QIUI4110469uwPajqawQAcgrQgd8HJRVIINxGRBUoTo2HNQmu+wH?=
 =?us-ascii?Q?DeeqcVqnylvbtoOa3DGhUmbUd/uaSEbaC0379uPPlvJ4k41Mbtoh62Qh2fLo?=
 =?us-ascii?Q?YGUUtVG2+0ZSDeMT6y3URqF2ONi6/gReGIUhRhp0ljFO9/01EHqPhiI5JlAC?=
 =?us-ascii?Q?no67XL0uJ7hnrvFrhlZKSIm5yw6aE/+lYxOQgHHQiOAPS18AQn98iZ5xNe0b?=
 =?us-ascii?Q?zHTzxkMQvBUuL0Evi4Hudw/AGCWsckJN+GIA6l6t6gRhpNpkkZBh16gesr4f?=
 =?us-ascii?Q?+iCaRVMbpWof1OMwr7XHXhyH1zlliDluBknpp+V/F7A3KZ/2MKyazM6CvNXj?=
 =?us-ascii?Q?LBIUab1cldLpgR51ZyyJmznfWeBP//BTpi4W8ZgpLPRpv4CU+xlbPJmMYibW?=
 =?us-ascii?Q?LicUf98PrWuKNlPT/rheLAio?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fdf83c-a0b9-42e5-cf7c-08d9466bb8c0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:04:32.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY/aYvTHSPOAwQejCR4g000nMlL6AziIwP/oc64A8RVFwToagHoSGh0FIiQAp/Ua9JySVYxTpMeLpfMz73m3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
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

