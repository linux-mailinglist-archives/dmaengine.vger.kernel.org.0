Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6061EF932
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFENdJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:33:09 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:9557
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727788AbgFENdG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:33:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9lZWfZxJ2/XVLwyfyTomm6E7PRmaGaNADsPHRrAU48T/Y1c9X/fSb8wREbluRnf3FqdML/cKEBSMu6upQZaJaFPJVH/Q2D9gcD/9la2m85RYhSypEsQI6cCBXzbou1Ufdd5PCXuEHKhOWI0trLhpzSj7nzsMEdgqXDClRc8oF4bEQP1NiqQq75Jo+D+Ra/374X+YmDcmhvmZncr7yLeB20uQCwuvcb6tWMaQ3be+ySrwQvzGWZA8MGB0PKgHE7e9mvSN7G3OSTIzXPXQiW4ilu5as3EI+CS2ZGC7p+DIeWbhJs/MrLuzHaYaOeDSlk3BLr6J2MbHlGb4xwj8PiEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ck4AeCjwv1t+XcVanhhgxvuofHKawX2tqytLZ7Mxg=;
 b=Iv0snFVJREnr1gk02Exxno2DFiVdHkdz3ds94PPnN4gv4v4qBCcUDULHqdBlIcnMXid9eKSvYlqq54mG8RJgt0lVZVPSUcTVtxq7FB2JtUSRJFJrIwk124rWPIVVPpyKvvaN4kXlsOhKH3+8dHC9pFn8znAPDSr7+QsudK58lX/rrUGeXRfTu/bDq7UK/Sbfvf1B3FA/7u2Kl4BM59oykzv7Sl6uE7YSqyX6/l5JA761hhZXEzFvRZVwicHpM4n2cfvpkBZ6C9EqGj3GeMdt0mRKnfXafW8Y5jIbnBhId9J087bujRX3dl25H73l4cu268/PgbxD76M6SPIgnKpd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ck4AeCjwv1t+XcVanhhgxvuofHKawX2tqytLZ7Mxg=;
 b=eYLh1GfHovD4TSmmQiutschCRfXGqCWYqvv42YTQVzX609pbDRDvWMxVZBx7qWAkxXNHKVoWW7XDcjLNy6kiEqbQrQg+p8aMA54ZoSCg0lzSXLvc15OcWcbkrHdKFWNT+FwXjjYygoVpDFeY7ku5cyvXo73oQz2Dlk2MXi/jwWw=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:33:00 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:33:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 06/14] spi: imx: add dma_sync_sg_for_device after fallback from dma
Date:   Sat,  6 Jun 2020 05:32:27 +0800
Message-Id: <1591392755-19136-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:32:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef92f22b-cb60-418a-ec2a-08d80954f71f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67026E0815F502FE1EBD54A589860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/7KydArBbKRDJmPebLnAqWRm0aKCED73I/8TUjY9Cv8zhcjNkeTSs5iruOV4zDJSdps2FJO1TRgRazrxVHZo5V4Nuwgw1kZdHiTA4JcLO1SB0seyZZxLwJuc/kE6+wW4QYpNtZP59ROKYyWwqLAAFT7SJjYOY49gARJw0O5MjupPkrB1Z7TCq818cWF5l/9lEaBEWd4rmUaSXDfaCHmddf0ZW+Zy58QwjSrDNBnK0rxuHvbEBKQD+t8bc5V1yekaazMJ8PLs9hSLkOlKdbuSAaoHs/7cyYgKzOTdi/4gky9bY7x7dxZ405v5UAguLTyiSXyySmpo+Y0nOvQgmq9WLMZRV4g8jx/NRE3Ykj2zAOmpEmyYb3oyMO3qpYp2hl7jl4Q02iYTOUCTDSdpJw5+MjsNtoA1as70hQbEs2p0PC0M4p+MjxOw/rEr4JPk4B5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(966005)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hh6PGbtUz2rL+Ln3aj2ndN+rzl8fBl9pPtiCkH70bOfoDxXAvdL0MxW2oX/6wUHL9QY34xRlumSf1a1ucjS/SRS+lWeOZRCSSorQMNRPB/r6nZ4DuVJXWFMLqCPcgHA9vavXM/XQpE5FwT2KczHlxXTUWqDl/uqeDtpObdhM3oPX5zpLGr6cbrKoe31Hf8d3yXcFP87aIMhhUpKVseGTV+Ov89zRXa2/7W7GnWgJhb0GAoIcMxcl5TQcHJwa18wRcVndidhUFt3waMkKYyd0LrrnIlYRUUv2Tmda4jvH9I0Y5c6StUQGouG3i0g+UzbWg9S/O7p0rhcMm/YRocqIfQ+BALrAglu1bSYAgSFi0MWO2LNQt3sLD/s/z+XnvR6+31jsCA8GyNtX1l3bkS4HiYpWny7eO2S71flcnqPltcNgIlXsiQ+XYzGCKPYeyQ43RT3cJ0ZmE+UpQSaT3zznSWt6Nb13bf/hUr5HXFk5zZQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92f22b-cb60-418a-ec2a-08d80954f71f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:33:00.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJNnO7AWZxSbkmOoPB8LtIWpdssbbHnD6IJ9kl0Ay4k6HdvSZ0dPr3EzeYnHvT4ZRSSFq6xIdWy6+NZYGuNeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case dma transfer failed and fallback to pio, tx_buf/rx_buf need to be
taken care cache since they have already been maintained by spi.c

Fixes: bcd8e7761ec9("spi: imx: fallback to PIO if dma setup failure")
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Link: https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com/

---
 drivers/spi/spi-imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b7a85e3..c51cd3a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1456,6 +1456,13 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
+	if (transfer->rx_sg.sgl) {
+		struct device *rx_dev = spi->controller->dma_rx->device->dev;
+
+		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
+				       transfer->rx_sg.nents, DMA_TO_DEVICE);
+	}
+
 	return transfer->len;
 }
 
@@ -1521,10 +1528,15 @@ static int spi_imx_transfer(struct spi_device *spi,
 	 * firmware may not be updated as ERR009165 required.
 	 */
 	if (spi_imx->usedma) {
+		struct device *tx_dev = spi->controller->dma_tx->device->dev;
+
 		ret = spi_imx_dma_transfer(spi_imx, transfer);
 		if (ret != -EINVAL)
 			return ret;
 
+		dma_sync_sg_for_cpu(tx_dev, transfer->tx_sg.sgl,
+				    transfer->tx_sg.nents, DMA_FROM_DEVICE);
+
 		spi_imx->devtype_data->disable_dma(spi_imx);
 
 		spi_imx->usedma = false;
-- 
2.7.4

