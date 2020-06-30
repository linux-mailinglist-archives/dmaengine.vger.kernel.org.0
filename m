Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84C20ED83
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgF3FZm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:42 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:6022
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729832AbgF3FZk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV+EHo0JENEuABxZ6g7bRCux86lgnX4btI140X3usOZp3g98fnBiOCXodpmAh8rzam1PPj7ziI9/PY3U5ma0rqDukcTaZYZolt8CNSXA2W0hp2CnfrD0+SGXXouBs0LhYJp/65dQtw/S5icZ8wYH+QAPGNu1Bu/Xmtfk8KzAjh/FSi5Rm04WlT3cb7g+4LuxIQi+F4YznoDfBczxMCD5AJE0HBxw8XAARfjHoV8wRzNiRAutF936MMkq77XojaEP3Vmy+ECoGy2q052DeWznglBO/1VwbUAjEOf4DkUMXtPsvCoMmtJofzSQIE8t4TYB6yswcGB4tDMx8GpZdyWzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwRHmQ4mQ9Ssi/XHtHwbkLAPrzpFChC9/nuv3wVGWus=;
 b=f/OwWJrYgydUP2XZSxw6BX3iNNvUlmoyzDBjbUVG4rmmtIb1Os/7OAULOwz7ijljMc5hF2Id7VkimdH13qUpNcb/ETHBb7Z+IT7RhBRBu/LjaI7Lcdpq+Q9LSkUr6QxoLx92nKMssxKf0gvsxtLr4c3dv9Q4+BSmrrk/Kjwi+DmYk38F0kbEACoKDruXGnU5lXReTd6kJsEO77ur3WLqMlsCojm3lF1aODCq/nnsZTZO0M8HD8B/oRVs/m3qSArBHjhY1Xl4S28SwUoZiXNTKosF15oZ5oKsxNc4dDbIG0ssdPASwgwZALQ5BLlg4J2O/fuRd63lwLmMx5F2rU/49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwRHmQ4mQ9Ssi/XHtHwbkLAPrzpFChC9/nuv3wVGWus=;
 b=kOVdD9vsimmwFLWtDn0jmGcgHGqcfwheQjffTMbGCZMiHyJe+7t4T4ljrd4NcMVcYUQqv7Zni5++jNJxTozpVAnofZjk47HwljeGIvKjqD+eb82506UEikje1fvVLL7JCO0ba+mCqlJdyiSx62ZlRqUe7YmjxPP2MJw3bcxthDU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:35 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 12/12] dmaengine: imx-sdma: add uart rom script
Date:   Tue, 30 Jun 2020 21:31:16 +0800
Message-Id: <1593523876-22387-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e553974c-fe53-4c61-a08c-08d81cb60451
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664064452306464CDB731553896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8UQB+H8rZHZnN/OBJN42KlVGhy5NtClfdZ/kta8inaH5HYP5WGJUnnaG8TNkA2Uq7VCEClbI06Y/eqns/42YasoBKrCb6iLpACXeH2PXy8Gpm5Zav+pQvya2LUMPZCp1ZBsGomxsxJBitcYMg9hESd7n4EXiVxXrbiglG0C7pDsgVky/AV/3KMOz69Q9sM6mUN9DCY5QSJ3aa5Fl/xrCcaFYTxmgEUPAW7LEO6R9MObiv/K15mrscw2ynebav157oGQwiWmHMlwPBMUk+QXP6Sx7Zumf8w0MrgnwQfKXaSNOFT+Dq5W4tBvwja0JyIwikDlQk3gQ2HFw7OSwZzpLY/ff4BxNTCCSHqUg9OUJHVJdPbjBUDzmnU12sROeYu/ZsZWx+A2z0Rtfj+ZbpeIG+xPT8DEjLdkZjBKPDkVnb8/GPbVR57LE1Ih1VC0Gfp9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(966005)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nJfpPgNA6DMoeL0GGi82qHQSoF+O3XPTEdnpCE/chW3MLG2u0rC5473FnvTfgG+bgmPx/cDm00uX8w/3FpsaTK0SOMSD7PioOMAd60AmobCwQ5Tj3P/iJi1mrREHWmwxeUqqiO0PDaHhXs9sYwsyhKziXa1CybouXRYsm/z8phbFsNDFBMT7W7NgjfcNu6840RRgxNCdEWQikBkvMBJFpzKZli5vYopEwJFtxBoNy4AfA+U8StfwpDBZXtRWr2iA+Ec63LmrqnYvJotFMZKkBq21WddsVBIKWOtc6julEImhaDx4gEfFYJqCL5amnDdLlR3k9Yo3gz4GL/SSt6IHvUOg1RMEVdf2y5ZUB51aY/i6wsuZam4PK3t4/uoOnNRHiA/fGT3R7VTiHEJtO07fZ02zmBIQokMLvGMN55Gqqa6X42ZOIXy7VYZTHyaPblchnVbKrfdlSEfuB589X18CCbnJhG44qLZAw6NCd7fbwzE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e553974c-fe53-4c61-a08c-08d81cb60451
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:35.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euCy1t98rRqtiF5f/n9UiS32eZmFiciWHJbdz/5hiJuFWRuLlge2VWC6b6X43NSg3twWrZvQ6UtWqeY6IswFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
index 3058c78..e946271 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1729,8 +1729,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
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

