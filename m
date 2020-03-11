Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20418133E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgCKIgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:36:13 -0400
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:6169
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbgCKIgN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzde6hBRNryBBdYxvuabtv1xfU+6zHvfUGdrqEBQmVuB/ynfTGAhMwgzgBfzkJpUJLdmxjsGPllLJX5RZo7Db07Ipzkr7EORG+H30XVH8mOTXSUKolBKVMPwdGhl7Wkknc1uCfei8fnCaMJZUynuhX2j1DUZ42pPAht8tk58XGCoH9JIiHZoVwxsRXOFl+GmO5KRvS9+N6yGY/5CyJPN18RzE2UPDlv0x8KFNwjbTt5UyTTzSMDp8Z+yo/mJVWcKvDGaf5QEhp44BeSCrTPq8BXceWD9OVq8yHu3RkRiR6P2wa2rssTmwl8A8BJXVP3ObscNBumiaV0mHa+WLTAgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPH6fqwENpMZpDGmX3HfiPkXiAHYaZSKePf7Hki9OEA=;
 b=LV8kiZaRj9jvTRY4CvLgsXcbgKVqKjxNqiTMex+2l5LvABpljNB6X4WanoXM8tbpGCDMtwyhOxZPWouASsL/kItAOjbJ/6ZKKikBIQWwHUPC27AugDP0vQt+jHIQwg5L1ufxAvXlcCSypj4PeysS89PH1Vq/RtM4UCSq6C/SHl21yTsZki1XPlgUh2NN9kOhJXxh3OOREhcafstqDT53p9XceTq3+65i3qUGpfbNF/9f4WT47jxc79lQ40fMwBMgRtbEx2FexIb+JYh+LokZTESUH5OB4Qct3LEfYgiwjjhXeGueFjOmlMamI0q3Y1VPJ0f/aGxFpbWthh/IwLMIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPH6fqwENpMZpDGmX3HfiPkXiAHYaZSKePf7Hki9OEA=;
 b=ira9LIB9aFZITcgeUToXQmMXbr+snP2wnYSIeEjZ0nWMJR7bfMc/eOxHgCL2CgPuKOIqS8Nc/ih9SAfpQt9LfbkFNZkFUki/92u0o+4pG7/oewi2dQkxyBp2sL2zIkbzwN5eAb4gRDHEB5JCQCFeVMR2OLTcEux4UsnqKwJoIa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6702.eurprd04.prod.outlook.com (20.179.234.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 08:35:55 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:35:55 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 07/13] spi: imx: fix ERR009165
Date:   Thu, 12 Mar 2020 00:36:30 +0800
Message-Id: <1583944596-23410-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:35:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61a30c02-053b-4b58-d9c6-08d7c597370a
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:|VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6702B36021B27650292B1F6589FC0@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(966005)(956004)(6486002)(2616005)(2906002)(6666004)(7416002)(66476007)(66946007)(8676002)(66556008)(316002)(86362001)(52116002)(478600001)(81166006)(6512007)(26005)(81156014)(6506007)(8936002)(36756003)(5660300002)(16526019)(4326008)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6702;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLOpfAqTmKEOxmjA+Eii9tPmuZmQ/buFZgtdCD2ThWJFpZ1tO/pUlEnwxDwco17a9w/OyLjskL0l/MbCNVSz14ueimhcf2FL58OFnKGSXYSC6WH0tKiELAVO55xNTUZBQg+GFHRrNOMPwAHrbHYl4pAMZg1E43Hg4PtYc8YlT6Qj8o3/6FfmY1RP29hyX9F9u25+ZEVtQI/nT1hS2IKG/S6UWWvKGTUmRrzOC4fKxwOz2IWk8rdpAkZuB26hOYnhocSIgyVUE8dhqubRhhJWLQsEtzDru1crLyNXVqcvcKA9kgHL674si2ok9xLmcpEMOjnGzZBOsvgdu8Nx657RuuA2OOHz2OGd21kXqTvI4HZhK3KpYarGnWNzwsF1D5VdSaXWNBY2rC/pgUEYxoXe1wMfk9WzJgeiw5FfNPEuBHzURmhr3jJBi44rlmipXClFpgPvGsApwO1a+k69pJiJ3Se7t5wh9aXLwkxfrWEZ1yFhFY0qwiqlrir7Ft8PMYxCz1yHHgnTgnMTggIFMT3sYQbzzrpoliSH2FArUJv6663S6uT0maEy35WwUORQtWrIwkeFQVtCXEePnejnBhWpUQ==
X-MS-Exchange-AntiSpam-MessageData: SqUEIYYiiUT2aObU0pym0nzdTTZ+MaY9pxbqngICWlLuOhZCftOsh3os1+fysPlhhAVgffwfzS29eRFGAvFzd/nw0X4QRUZBxksbqde5AtpMmmkUmWJvTaxbiQADpEnrmbuuIxjpKD0JiNIJotIvyw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a30c02-053b-4b58-d9c6-08d7c597370a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:35:55.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5cVnJrEybXoboHzTOfk8YdRQrP0zEFZhHzVIiJtYtAhpWwIxXMmW92HxK+vhBsVWrIR311lKLp2OiO151KXQQ==
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
 drivers/spi/spi-imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4f28a4..70df8e6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -585,8 +585,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -617,7 +617,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1171,7 +1171,11 @@ static int spi_imx_dma_configure(struct spi_master *master)
 	tx.direction = DMA_MEM_TO_DEV;
 	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
 	tx.dst_addr_width = buswidth;
-	tx.dst_maxburst = spi_imx->wml;
+	/*
+	 * For ERR009165 with tx_wml = 0 could enlarge burst size to fifo size
+	 * to speed up fifo filling as possible.
+	 */
+	tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
 	ret = dmaengine_slave_config(master->dma_tx, &tx);
 	if (ret) {
 		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
@@ -1265,10 +1269,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
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

