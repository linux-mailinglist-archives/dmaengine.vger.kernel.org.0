Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6B1EF93A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFENdU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:33:20 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:11399
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727863AbgFENdR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfmQoxbMIYDDi92wz0+mgBijt53VbtqTsIgwWJjGo/Q/ncqwrO6Ht6YkLNAp1fbz7phWdgbnoKlmI+AhFEo+ODhuU/wDEbhce+Y0ZB7WQslsc+M9UW6w4pg9xMzxEtONMDSj3qucVKn1f3jrbRJrQ3V5lnM2MsX6AYNoBnI4Gq03bC5l2fPnVAHfGI19wLAGeBikazSWcM/uVHc/bZK8Bqxt9Zpevq1w3pRDVGT5mNAjffQZc+XEEL/DMABhla1sadH/FQjqpQ7Jfo4RezZaMCtS0iQ5mLHUztxD+cO8TAzBlUME/xSLl1vuw6hXcLtFeR/cecbQomN1vnJnHuw3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rnbTyZ4GfgYxDAYqxYP9JOp40/s1BbVRUa1y4Xo54=;
 b=O1UZTj1V1crnjbFIBg0g7bZ6ymrLae4DITsp+GXXh22OwMuayYYhMd+LytcJZ8uePEzIBMdSjo+vAoDMzgByJip+fr4Q17aDKx0AuWn497qEYvPz/OBk8+cQesjral/Y51v+XEnHF8RZW+tHNtyztGzgKNtWdYws5G4VdWPH7KBaSy6+4XiMsKWMXhMK8+yDg2451g8dzu4JUqiSAFJhNboeCU5VM9gWoJTKOdpLs8KdPWVbZgF7XE8S3wi622pu/faENF1sxJe/0AFBfAu5+kHn/5EW6P+DPca3YPXQDR4MtDdCIjUqS3hauoXhlqoj1HaKi/qzmWlz6InAaFnuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rnbTyZ4GfgYxDAYqxYP9JOp40/s1BbVRUa1y4Xo54=;
 b=I4OO5xQDp3WAgO5sCGeY7hysmQFoQc0pZPynVWq/WG+ZmLd8CeI+ppr7Y1dojuta1LrTmIzDQrR3OUNfcQvAkqIG/ygOoEpTY1aD8oGe1ZJggpPWlqZ4PIQ81Z4TI6718Lnv9nP+VEVZMIv4dNqpb1P4u3eUS645AkfrdbPI72c=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:33:12 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:33:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 08/14] spi: imx: fix ERR009165
Date:   Sat,  6 Jun 2020 05:32:29 +0800
Message-Id: <1591392755-19136-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:33:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5111e0d8-6d77-4578-bb00-08d80954fe37
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67021A5691179DFCC4AC01E389860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIAPVXe/t4X29WRpY3zWYlfxtwvi9vVjgTrOdLsPXrKVBWMz5p7gj4Uqsy7zJZ8Ze8e5Ttz35K8vcWwkrB+pgvNqmsaIFFpJMiFg5Qu+eVUAIXWUTqloKMqYtDDhX56LzZi/zQzeeVMR+iv/Eax4MVsQw+pv+rie3hY0WF7wO0Khyi/qwDt7TrxOdDlMIeQrOEgmKUTduZq2DR/BwSlukkoyFkxTbXcA2zOKhqbJ7y9bJmHcrPAxZxYDeQoI3gElq2jgHab24n/FVy1lRwuikbf/59lUXgyWnQeumasubQvN6Yk1X/vCbZA9VF5Hkc/kXRXIsOKezI0HJ2C6Oos0plTQHvgXBmNvj5z9TJh1k19WTEZQe77/uoU711pUChxH1z2pXGUVb4Ik9GQdf75BVv5qAMH1w4fO/lhEHMmRZS5Zc0MdnpnvZXIa0PFsEn8wUxBOsJL+Jx8SfpcMzZ9gJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(966005)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qGAtHUF7emCDF/M1ljG2lqjrdMYjhOiG4GeDU00d0m2oceMaqsbmtY88soC0SoDbKWW9E/NNAkiNQhRXFwV9NXvGJ1IodFaadBjprNdTkhpVpv10dxDneZMgsKoLWNOvkwdSjgHRBdnPIBigbk6iPcUClbe9bZWqeoF2HA7JQTZ1ERpi48cu5LnxKzWvUiMidj6yAEfQ8Txal96vHzNDRoRKiypIaIZiQSPB1fqjQ8jmTWSoWmjMMYGjQtQyDKNRGqogu//ueveMyQZjJkymoIg4oD2q2FG809KZjPx/Lxkqpdhwfh6gDuT2ocYXoPl4++6TpzafwpE0KvdWBWi0IC5WIyiHu/52m088L1edbk5kQOSgj1WEAqw17ZO0hTwvPVHYOFsXr35DWGG+NKyVpVZN9f7pjCjDOOJbyoaokH1VhdJdnTD5EutTpqUoShgsTzHAsmsiQxIHbH57JzYEZMXQsT0J1orkytGeJsp2gqQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5111e0d8-6d77-4578-bb00-08d80954fe37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:33:12.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSZyzLGrpTMSUlpn7kjvHr1JDBGHfqfjljB1tDTzbtlCj0qM3OC61xG+I/Dfu5VlZeVMEZ7ygsROqC5lrytGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change to XCH  mode even in dma mode, please refer to the below
errata:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c51cd3a..f82d63f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -591,8 +591,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -623,7 +623,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1273,10 +1273,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	int ret;
 
-	/* use pio mode for i.mx6dl chip TKT238285 */
-	if (of_machine_is_compatible("fsl,imx6dl"))
-		return 0;
-
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-- 
2.7.4

