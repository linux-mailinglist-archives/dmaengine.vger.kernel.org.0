Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E622C369
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGXKiY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:38:24 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:26390
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728121AbgGXKiX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfQ0aN9hEDk1gCZDCbCrDisjP+Kdx5OTioxy8+4dTNhdl/U0RQ2a34XNY2Q7kLE07krg90fojP7ZsTwZ09QZgyWF83iWnxbESp8GOsq/id/1P2828V+z05TZ+nZSbc8f58vYvnn6Dq1K0Oox2Q8pAVSLenXEwokdyKRPddNGl6TQxs5ATwuZ5tsTaOeXf7PVqi51dK5V6zmuUmX87ra3RCn9WvlNJxFzOaBfbsu0TQm4mtZTcH6HQpWYo8V2GPjuFynhQNmehpIzwQ7sxBn+AHdogGJivjNucZWYPWlgQwFnfD9s41rmUOUcfoPBaGVVyusnSnchaGal1Q+I8hBWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBIPq6OiaZoFybaiM/oj4EKt1yY0a1UUP3wLjjdf/lk=;
 b=LyV18mbLo6nRy1JoGc11IP0jD2q3vmmrwoNUmNQn3m4jNKl3KIz0b3f7KlnmjtqTWbAkTOUbuc2pImZL7mID+GmHysXnCF7Y9Spjt93pZ3Y4OpaoM3km6OqB+5he9kRJ3DcqBfltmqN4zdCZ0TKx6nb17XNVDmN0m3PfBt0t8QGTjzkGppUow3FuIEFwmKjfXCCa2vZg8+oEMHGhczFncQMI6XSMzFwM3z7CLl0Oi7FWa40YZ6NDUHXbDLNdJGW2NJQ01Z0eu92D9g/thJ1YO2C4zVtimJnqm/OehmqkomFvfQ9vO+XTfhEjbUCo2r+9W1tcHSIXkWr5SikPDUy1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBIPq6OiaZoFybaiM/oj4EKt1yY0a1UUP3wLjjdf/lk=;
 b=bzXYWz+Uf9QGbt6x9VMqEhsz7/LYrTCpZ5IWYNpqYlRPL/kR+6t+QDi0M4fH7uMCPUen0KiliravpCKLDqN74v1mDyFBVfETzIzXEbldLEjwVbQpddwwz9Z31lKuUeGfMGR0SApBzZGIxg4MiRC8L+Hj2kLtF2pJE8CRquSbdrk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:38:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:38:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
Date:   Sat, 25 Jul 2020 02:51:25 +0800
Message-Id: <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:38:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8184ba9-3b6b-4e67-a54e-08d82fbdae5b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3710D37C68784447F9FF54E989770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40iTtDX0VfalWJkdiF/LCDsuh1HIUPosZBagUAMPnc5dAZMKT7mFOZ7ddTzuxRmalAmeLFX0qz2ZLBDupvLdFCh+TSYkiTKLOY1Q3HUT7OvOOeZzW/shKY4+TvspO9X0YM7is/8bAwbLABlp0UPE9TvUii5SKpSxfPcXXTA79KVqT4vJllNQ90We4BWsDMqZkPTqsC4U9z67NmID7PJsG/vx33WMSZPHnY2DWJShKEIM3RnVQ87pIPLfujIoBGwNLAPbkiCNWVGr7tqVb/69y3p2a6Mxn4vcL4vt9OJ3uTIXkV7wk7jELwlMQYv3gkNyOrZ3uoiNh5eKLqPZcPY/ioL1D/23bxQi7nmLniU3pPtPv+c9NdvjEd0baYMp/rdI77HqKSj42/LfAO979/tbV0TZRL3wUUNoewHMdkeNBG0JGsGHqYhBrGoLD6ujK0T9ux3HT7W2u+IpfbflSp9aDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4mlP6SQzB9Y/Ds7L0Wwf0IsKxoXAZfEFflkkEojcbYjoOYpsGfIwLSo3w9VVg8cz8E/yUrVg2XWbJvzwNyP/aglcO5MHvBohRSMiK4DZgwv9SUgBjqpAEmGU5nSCuAXQNzqu5Fp06K0WhV7yOz5Cv6try42vqwIVAlLm1bgYK3vvs1eI/nf8G+UKUU2oVbnVxEHAmiCVqIOa92e3Y38Vt/EjRomL4n1HApBWq8tZOD4doMQUe29Nfejlob8nzvmTncE2SvKQZKpvGnjjt/bTmHsf86M5TdaXN9l5DjoOxWSf3zeTEacfDsaqOYDaXGWBRwS+8xwK+kWQa9Hi4ma2zyFcMQTMtMCb5yTlY4SK4P8BhR5t/I1bz4m06i7+f+VWPVYyDCMg1lmxY0UNpY/QxFf39rmFuQNhffuNMHnx+JS5An6sHrXqlkXGvTYj/aWRpjbjmNj+4B3JXe02eDiftDTBRYjoEnKi2eMZaBiI4gg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8184ba9-3b6b-4e67-a54e-08d82fbdae5b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:38:19.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKZtvEhK4VcFNbtYMiZyPmYaWiAMTatR2+5V6FwMYyCheahmsY6FQ4ZHF01Se1F1s7HPQr0bRohAeUHgOk4fMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
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
index 8735606..5900e32 100644
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

