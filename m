Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEB1F0748
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFFPVR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:17 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:60166
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbgFFPVP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T18Aw1BqttMAgqGmKUjpXTgrbkuQv8XgrEGWupTEn2/R3w/lLwToEU5wuoJ07nEXQeVzWelvVZNKlXNK5/fL/WJnkPpMOnJW0SPpOFc3yIRRagjty7w0o/8KbQl+C+k5G8Ym165iXOZcmtgXNXx0KWKFxOyp+5N9nqKyqsWAlydB2RIlUcyspaiNidd5dbNpwg7inPgQpvzat/BTQHM7D+oQSmzIOG/6jbuPVfzEecXoisUTik1aBvUmAaF0wcWT4bnVcxnz1tGu0+opEwP2Asdchvc6ubWfMQu3WpsMEvpDmjAMdU1hWMqD9528Rh+e4KKjdYV1porrztVnHvym7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3+enMAcD3oYybpWdU+Y68kpJ0Y5OZKM/qJZR3jOjME=;
 b=DJiu8g8CHmHYvXmhm4F+osYyRVG4mVWPWCGQNeuGzS0RwSommGXYb3dEhTUZGPwQBMcoFEL5ijfhHnImtK/HOLkzO7ggpPKhSv/4qIk5svaI0/YIForvNkE+Ht6ixClsezGT5U0vdSXDAXTK4jtFLeoztQDF/rIrFUCoxK0BPkNOvm5qKmoKvx1HG/YczkSJiVDkzVTwG4IO/fUUuv7HKhwjkJwJdN5Y273VNq/Ju84JS/8H6IbjxLLIDe93Z/jc0F4zN/J4IG+cpxI/dGreJDPGCVKLsnDO8yMUqtkaBAFrFHF1iE/N2ysnUUnEUQh+Fkvnpqpn3h5i6saxEflubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3+enMAcD3oYybpWdU+Y68kpJ0Y5OZKM/qJZR3jOjME=;
 b=jIxrhj3rXFYhhSn6VwmZKtqzxsPn0+dvhmbPI+9q6ZJMvIlBQQEX5kImuO9qXS35+zY/t0yk1JOM5xNz82YRHcRVkY0jfq3J8HuY9CC8NNbTGD5TmwRMbpHMZzSGfurs/u6pFOYDzlh0/Bxp2ydQRSwqIlz3KQGB/0DxkPx/g3k=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:11 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:11 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device after fallback from dma
Date:   Sun,  7 Jun 2020 07:21:05 +0800
Message-Id: <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1b855c8-39a4-4648-a260-08d80a2d3e69
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB651121FDAAD6B8EFD0A5CE6F89870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8Om1ZIktW6R/6iYRfSIDjxou4YBMvAoshwG1cXh+oAEmU+c+IeQA1ppdmnSZx0IY0N7WeToY7SqotPZsjv83qS9DQVMG6IA2xfRm1EfEuPVO1xmPj3tIZ1fhz5NzNGmHFqqNxYrlP5xsR6zxpIoRscoUpz4QOPIy/5ylvETITIEpoRqJM8MYIWti+hsPP11C6FH+b6BLk7SHOlMZ+d8AUvAzywNXnVtiTXKCN5/3bPuuM1Dr3gsK0xjjs1cz8oHSinYVl7XkZjXlhaX5GkdFG0iwo5KWCY6jQ3I37q8NlqgWV4EApT6XOu8exsuBBWrpCtbf9vNaDY1isXTpSjbmXXTAdJD9K58A3Itct+y8L5UwkiyuTvNJT9/KVL82T6Kg21fjuP5di6oiPq4/gDXCqbDhsRo7R0ZCSGGMR7jJIihTc152fQz0PIrPyylBQMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(66476007)(16526019)(6506007)(66946007)(956004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(966005)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1wk5HrVJJrzzbF40yYq1ZSDQVhWu73u7NDXeKZOxFMDyjIQ3srb6qmA0RMPXVGADejRGUmYlAMbeJpfk1l4dJSihf75nwAqUc+eXuN5NPjD10I+NzLVnjRJ8S3N6hN57LHtX8NXvKGEUUfpcq9xAUIzvtSIA+B6ZlkqUmgX+o2us3HNUNvVw1lbcb9SgYq7uzaTFnWhPMJV/URwoBl9+CJK0EEOCc1vB4bQAsYTPY7eiMeZbv0cNp6x3oh+plrqKRHVU8xw/jsbhOi3TkQthlEuj33eRpnJgMVN+f6z6COFV9G1N5/YBV5+3ySDwMS4u5dcC2PLbMmvYRUOMeKvbRxOUuFHieX1A/PZLxdKSe0W/RHxFRGzuv4Fg8Kx7maJY0l0gwfOaa4ioUmKeVyf048jGAti1WjjmhJ9H1jB1ZQwczsFW4qX+i/oiMD59TlLA8FogCMIFss1S9BxV26WbuDKdjPqc7QvayCfxLyVVaok=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b855c8-39a4-4648-a260-08d80a2d3e69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:11.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiXvdPahvzhE1tAXv0C43ym7IaJeJCstAPodWgWiBVnmAI2Qu7zNh3F+1+td5RDX/mmswXLtwYe96wvzFwWoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
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
index b7a85e3..84aebee 100644
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

