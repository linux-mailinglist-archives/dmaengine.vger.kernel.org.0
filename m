Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C141F0781
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgFFPW2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:22:28 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:8933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729007AbgFFPWY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtli+0Xt97T1JLX3Kk6gwEsIQdCqW4YcUu4HXDK/xWaXz1SgScOOG9Kw/UXv7F0ElvfMkiK7mR134Vd3814rGucCdFcX9drfl1I5ts7vESkOaTADwKUjsqB68/kc81jZxWsq87hnR+OckJ852lf3kQPiOU8o7eL2+WwSk5LSRjk6/2bmEm+Qw1DiiDO6bMKC1PZUKY1i2lgo6F8b9EkYmABl1YxYL9/YypcLkRNWAQmaADlhAjJAWKsX4R862hdhAkqf2+xgdvsAxlIVzxxzW+ia/+h0WAJpya7tfTfQuC1Uc0KwJ9b/S3dNLS2jFYyWkJfFYT9Cbd8ZUXJHBhkbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVa9IWELyHni7gn3nuBup0HmNm+xItFbTKwgykt4ySE=;
 b=j9rw4HHmqZ0U4QonDLdZBS24N0yjPhdyEZeOEQGMpFaBh5WiUeGOWfKGJQkpmLnODWHWYGk7j1BvfdhqU/CWAFfPmqgOUNxnvWF5CJ/Czn5Lr92JSQUfeJOC7UjxNlxhagED2bhEzLrDp6AK5kBj83n2FL/vTozOHJS04PkMdKdf34bUTF2Gi2HLmewH8Mff/sWXmxY5HCRzv34hV4ml6gLjsPlaH5/Cz+cWKxrksNkMYTTRy1KG5E/CBk25z5CIU99K1HJL1GVyi8XgvB+LDmlt6naNZ5Z+EjaYyQqLOIhKDtjamLbodGGtQxBi35VMy5BiQ3E5wdmto3lxx3PH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVa9IWELyHni7gn3nuBup0HmNm+xItFbTKwgykt4ySE=;
 b=AH8RZghEIhcCzDxp8GH4KfCn3fk5ViNKg9EYTUWNpoIDNB9q7rw2OCtK0A8F8M/hIPEc20nMSMD6f7Ft5s6iYkbqrViuhD/qV86ggDrPosZnS/TGlZEG6K+cjQ0fW/sS4TninYvWmGIZiLVo2lvPTTzJ1HYLCcaLXYzhPrCtIyU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:22:20 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:22:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 13/13] dmaengine: imx-sdma: add uart rom script
Date:   Sun,  7 Jun 2020 07:21:17 +0800
Message-Id: <1591485677-20533-14-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:22:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c5e0346-b83c-4588-9ec1-08d80a2d6772
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB642951AC0A1126449283DD5289870@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qu3csd2S1d/s4c+B4JST8keiLIuPSS2WgDpYCQuIv4hsIXgWAw7Mbg/I57M+9+/RAeDh0R4Y07CZgjGr8/eGr9BL6SMG2JOq6yBBNRJqo6Qbakw+llPqMeZP8c5foNdpxHQOV7MJcYs1nP5W9905NWwhxV1uyxE8usct9AanfcSWFdjmM1AK2+FydojAZWORpp3rNgCOl104P4Fer2dwwYslDtNZAzr9O2g3sidEIjLmZghYaMVA3dQ31KYP+y0PUBazJHT/Use9axkVXRdfOb7WnNoTs8R+cS7hAMhUZv2IPLMeNbUn8zSTDACghaEMdNw53ziW7byRg+lyNnVvSqHwNAp4dfbyeDA4dM85yRaorEGrpnBuxyEod8qX4EM/BP5LmpGjb9na902t/eqWZyPQu2B55d8HoatK1gLuZmJztlpwl98Kfqm0wsrEG8SBGZDXDz0cwjbOy1hJFZmTrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(52116002)(6512007)(66476007)(66556008)(6506007)(186003)(7416002)(16526019)(26005)(83380400001)(2906002)(86362001)(8936002)(956004)(8676002)(2616005)(6486002)(316002)(4326008)(36756003)(478600001)(5660300002)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3b/dHkPZILWC/a73j/kRnGSM296dk9PHXTILaEV4nJ3qcnZLroEEimwBN/TerZSq4tz0UNccPN+v3ULra3nFPymHCAO8F7DqqEKixm2S2b5Kla36Ej5Nhr+7HoqiM5HEZCK/t0Hw1sdQ7HguitJiWYFTXtNf/VHwqly6eO7gJXqMfD57yr3kQ3wnrzy8qrvfqBsjPEBZAgDPl4i+/+tRMuRuWWC3ZGgaJJF8SyCvp2mXmyKSzrVX1/eyql3gF8HD0lRj4fPrhEuORgywEMp8tM/V77VD2HCJOEhqfCxQui5J/PnzGzSzuNsB6qGbhGodljxBAjzg0yU3YfwfFBu55yOeBBIHluTYF4gbUxKhPxQf0KFxzkiL1NpY1ZA4V6PU4971E1fmhADwjGp2cCb915c8TOST8C9J4ldk9G5pU+zpyi96/PQnVi8IumAsprzGPt5HgwYBJJ5g7Ubgfg/JCqr8IHcLgMgLni95v/LaFRY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e0346-b83c-4588-9ec1-08d80a2d6772
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:22:20.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A31wA5M38+j0B8aFU3/1FsKlfaikSuB2pd7qgQtgp7cIRJc7BkB7DVbuyRe15ltzupjg4xzFWNvhMaC0EYPIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the compatibility of NXP internal legacy kernel before 4.19 which
is based on uart ram script and upstreaming kernel based on uart rom
script, add both uart ram/rom script in latest sdma firmware. By default
uart rom script used.
Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).

rom script:
        uart_2_mcu_addr
	uartsh_2_mcu_addr /* through spba bus */
am script:
	uart_2_mcu_ram_addr
	uartsh_2_mcu_ram_addr /* through spba bus */

Please get latest sdma firmware from the below and put them into the path
(/lib/firmware/imx/sdma/):
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c                     | 4 ++--
 include/linux/platform_data/dma-imx-sdma.h | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 320104f..2ca7935 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1718,8 +1718,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 30e676b..e12d2e8 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
 	s32 per_2_firi_addr;
 	s32 mcu_2_firi_addr;
 	s32 uart_2_per_addr;
-	s32 uart_2_mcu_addr;
+	s32 uart_2_mcu_ram_addr;
 	s32 per_2_app_addr;
 	s32 mcu_2_app_addr;
 	s32 per_2_per_addr;
 	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_addr;
+	s32 uartsh_2_mcu_ram_addr;
 	s32 per_2_shp_addr;
 	s32 mcu_2_shp_addr;
 	s32 ata_2_mcu_addr;
@@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
 	s32 mcu_2_ecspi_addr;
+	s32 mcu_2_sai_addr;
+	s32 sai_2_mcu_addr;
+	s32 uart_2_mcu_addr;
+	s32 uartsh_2_mcu_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
-- 
2.7.4

