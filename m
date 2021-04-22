Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73877367E11
	for <lists+dmaengine@lfdr.de>; Thu, 22 Apr 2021 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhDVJpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 05:45:43 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:23008
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235713AbhDVJpn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Apr 2021 05:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ9Gy8GonQYVP42rDVRQvj0IubfP+A3DCzmSoYvc4MnA4E4wFC6tINE/PVNyqnP9dvUIbH88JPR2HLmiIcKjM9fM2x5mY9K6ZY5VQLitWY8J+0CrqUYdUIDAis1KYNuW7ln7v5n07f+evY6x01Bk1wIDBFyunODSrHT6W0lUtEm8T5Cinz8Ls3ASH3SDyeKPufkGmRrIkJ5atXSNpdGUhcrsIUXIUPimYhlwwOuGSEj9PZBNAOyRTHsJuu+pyeqrZt88lH96imFH5YNG6qkVBRYD+b/zAAz9c7TwSALCRPuLTy4rq+0aIo60plGAEEcytk4mjkFL1Kc+VO/KHZ900w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFxBtR5SZ/rrlhTNwzSDWLDNjuPYCrQkl7BrIG2sJ54=;
 b=QJlLBoV9TJ+LT0gaZ5D23nYE8CsHJba+gcJAS59Aw1Mtd/CozrLRGARolByQEW52bZGfuQ2kl4hWlKPyNB4a07SxgOFA417fMK/1WT7Mer3V+G+ErtcmdNAJ2QRk2bgjalP1E0/VTvZOax0/2wbgRrDk6qIDDyKaI/Trhk/BCfwv0ZW0JmOvXMFRmkmFpvTUBCOHO/QsZtqnjBNE8uAC11bieAxSdtYZ47mrcfHMA1dOO8XpJ0VZZtjDWCM0nC4VyFQnkPUZMJ+Rm4SgfGk1rHqno3RbedHT5jiBJFwPrnfcmqiShP3vJIQeNCtnEHEjPS/xOCkf3K2Qv61H30FwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFxBtR5SZ/rrlhTNwzSDWLDNjuPYCrQkl7BrIG2sJ54=;
 b=q6oRZKatUIF/r6YUBdlfgrOVZHMXg8KP4mvYfuuUUTM4W9LU8U6yihCy/wNnuNOMPGU4C8d2KNF9wUvK2OZlFxG/aQpFukLpJ41QldsYy2uDb8hc26n87+j6EJsoL6dnIPPX8WpRlaMhKB28OgxMLr0pEWQiqYnC+RMofWWAvz8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4159.eurprd04.prod.outlook.com (2603:10a6:803:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 09:45:06 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 09:45:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: fsl-qdma: check dma_set_mask return value
Date:   Fri, 23 Apr 2021 02:01:49 +0800
Message-Id: <1619114509-23057-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK2PR02CA0199.apcprd02.prod.outlook.com (2603:1096:201:20::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 09:45:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c546355b-e5e4-40a7-436e-08d905734f1c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4159:
X-Microsoft-Antispam-PRVS: <VI1PR04MB41591E6BFBEEB54697AB83D889469@VI1PR04MB4159.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRVRgXsjYTnNPntoEyGEePbC+cwKp5sEIPD0EvpDwO8EskzKtWCNQyuRWhXjZlbrgSPS7pTEbcH4KDexQz4+ZKXng9Vxyo7mIdrByKBuhTHkm7RpTIE1btdwGMtp9FAxmnkHa8ZMLwjqvBxdTb/97wYsp92wcxIY/zMjoCBvmz9qVmaBh93mfnHRaKBC3vZRkvptkkGut7VOcp3Cs8D03hm7lVy7WkD7npWDWikkA4HqwZMXXFYDmyGn+0SAbkECGM2UUzK0JdAeXSQ29Xjvm4iS9ecdW7W8zNTTuju6AmmynI5iXJG0BulIwJTm/10u6o4h+RSX42C59v229+Qa0BUT0FickEKq48n9YzuESw6ikaACVImuATOVYWjE2hnaaGz1YLQDi7MYTPAHAwH1fvhMRoUGR5LoK2JHoGgQSFdczRXvFyT0XusKt/XuMRNYfTU7goXykCeN0TiLHN5lN/Q+kBO6rrqrlJ9bfCI09BofoArNBO31227/hwmjGM35Eta6OquaFzJqtY0DvGNWOGmlYmubY6+k442YJ8epD8Ed75RPn+7NJHnxjD6x4TAOswnSW8iR39P8ZD9iquK6BErQ3ZcvfzhwFqHn9hcQYw7bCtnOExFvQHFPLhVFwK4dUgCJc09JkCUHLLMGusdf7WPlNLEI0YV2HhHgLBWVAS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(186003)(6506007)(956004)(4744005)(6512007)(66556008)(6916009)(6666004)(2906002)(478600001)(38100700002)(38350700002)(316002)(83380400001)(66476007)(16526019)(5660300002)(36756003)(52116002)(4326008)(86362001)(8936002)(6486002)(8676002)(26005)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dYebgBwrF+mJWyL3rrlWbJE3liogXKgy5R+672LyUB7kxATMyuAJp3Xkv1wK?=
 =?us-ascii?Q?hghCv2tfEOMec5pnS2vNW0cKZbWwlrLLHp7mtZ08AnSiI7a48KUGY8oPIIpw?=
 =?us-ascii?Q?cMFMjlgrv1uCS2M1Qy5rUg9Cu51IBvMw3ApmbTa/8atL2J5pfGvhncTzzQQE?=
 =?us-ascii?Q?mbph4SHhdjtPh7ImxiRZr/P2wiLqWJGMQ7vgEPY4ekAU3M0XPcd8VwV+ARQa?=
 =?us-ascii?Q?ogu0v6AJ+BUO7vpOOcQF4GfpSEw1+GgjreKFwnecClGgQhks/qNyM3JWv3Oh?=
 =?us-ascii?Q?z21xNr1cDwI3DTrTnSEuvHv61p5tI7fTKxR+EE7ttVtkr/9GKemjnoOmS+uu?=
 =?us-ascii?Q?Z8oNo8D86ZBsJLujKOnX4om9UnPk4ftq52EETM6XLZY79lX4gJ6Ftyp7gFqS?=
 =?us-ascii?Q?w5D4JRJ/OrcV4nzsGP4SwhMh8stHXkjezwW4IORWx+WG5PV5EQrRtstPFEw6?=
 =?us-ascii?Q?ZBbka7N1ZKOACp/YYK28hcFafCxOXC0kxU1R/ln0Tz3biIEjnHTvoTpSTPS3?=
 =?us-ascii?Q?s2ttJGpS4Mh68PrMer9vAFR8Q46eS7zlpJaoz9ErU9a0R58YkKrmlLxsa+ox?=
 =?us-ascii?Q?7bLTGbnn0FZ1MUaS5SnHyKknhwwChXe9yaUCi+IiZLOxLCGasXQLZKBEQycY?=
 =?us-ascii?Q?hR0k5kuDjXHXJwvA2RebRPfxleLhgh/Xuz7ImdtxGFUxiWkEh2ieBzwkv2N/?=
 =?us-ascii?Q?Zfm6ilo2Wulp3tsdMwvgfTewVN8qaId7yxrKJwfshC6dszQ/gRCHvnUcWKHg?=
 =?us-ascii?Q?4wW6nqnGscsDoviaEO09RA6zjxfcBkI9gUlxPyoJhnclr18efREcnFl52bU1?=
 =?us-ascii?Q?a3L1bFsuWekhgbXkxoHDk/cRdUTMQd2SPdVPOXeJTMgBIl/ZR6uBy1xe8eny?=
 =?us-ascii?Q?xJt9SRa2Eh4Xg3eNZ0soRXyDZqjdVB78SIu4dftOzi/1onZlLCgO3odWAnQJ?=
 =?us-ascii?Q?jbYyH+pAeMZojxdbrliV8mBygmwMCeGUZ5bQoa+HPF1bTmlY+YGmOL8KVTmc?=
 =?us-ascii?Q?vhTYQtHD5kqbz6fs6tQ2kL1NcAKzCzVinx0okmR/EZvvf/rH+ksb8TYARRLs?=
 =?us-ascii?Q?elJV5OB0VHGYqSNBLQ1Uhreben/J4aJZhFOHL1vAHdG5yx+qWge3lId6zf3n?=
 =?us-ascii?Q?yGKGexLiOd+59w6/KRSZExEkuBqLihx9P0Y2yoQSQSZD/QGhWrv0zc/Pb6tK?=
 =?us-ascii?Q?NB3zHWTTgxzBvNHjc6a5VzrM4gsn5AKMuIdX9JsiwpO23WWPsjNvANLvHHD/?=
 =?us-ascii?Q?Ysh7lXDcfJpn2J8ZVqKA1eynWGwJg7WwTqHEOFIX3fi9MVyWGrLu5JJ2y1Pd?=
 =?us-ascii?Q?fEWJqkAf02ndeQGSupHBMNDq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c546355b-e5e4-40a7-436e-08d905734f1c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 09:45:06.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEuid3gUDseMonebzd2at3+9NSC68JvIzwUc7XYFSsjOQ4WjOSEb1dD7/AGwTTFlGR1meSlD2N5VXXCn2bpELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4159
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For fix warning reported by static code analysis tool like Coverity from
Synopsys.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-qdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index ed2ab46..86c02b6 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1235,7 +1235,11 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_synchronize = fsl_qdma_synchronize;
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40))
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask failure.\n");
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-- 
2.7.4

