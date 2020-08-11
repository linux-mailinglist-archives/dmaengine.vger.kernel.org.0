Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C0241776
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgHKHlK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:41:10 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:28418
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbgHKHlK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfHxrQhcGIXF/CA2tFgMGPCciNXp3BL6KWQjgZGf1FpJZFeyqPses8acylzM+Sgbggu9rO1tIy7OmQ6+hEnr5Kh8zHlz45Pz7UjihRulaH4tpWCbBIMjbc9aKDg3lvr8GqQ+5GqHTLZ+z4E6xDYs6zimn7Pv4qDWQOITI0reX+P+3LIcBkAIWu9daQ0Kq95O3NY8wsRC1FIOX78EDU1w4pOoxB219y4zqKj18wyGNE1F2OjG2JG/KuPJtFpxc4COUem8bj3GHGIWgHXVasHbJJ3UgdoV7emE4ghEe+15S713EddPbUzwzTHHmjTeuC+Dq43kw8PuTBNciJaNzP2Ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRY+2DrI/tzbBi6A4V4crHRv5r0Tmfc824mu7Vll8wo=;
 b=UuRrH0zyo6LaYLnsBNXBWl2U1Qb3GrN/B1AApIC+kW3CwpJZ5NdObTG2xCk4RXk3Ms+wEErU1XQGW8a8/9c4sB5NzfcZ410Dl4BL6NBInExrWH193Zf3izxEGq1rf0NL+S6TSk3cIASzbYCuE2AtGWOzP3C5ponAEFAhwHQ1tZNcMCdqGkDy5qZR5ym6u9Dw3vL5+/iq3BIHTksLWMezEKDfUCMpQnM1pD1kOq9SsiCKeowQ48YDHqPTnQXiL4Lssd1mIbScAaQo34I2LHzfa3FX9e60Q18wUr4lXixEkY2qF+qcsezPmKoNkBablkY0el1BxqLy+aS+q3WPjGJxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRY+2DrI/tzbBi6A4V4crHRv5r0Tmfc824mu7Vll8wo=;
 b=RK8pwuisupwWC8EXTP81DrHLsXt/16X4PLsraEAZ46IaRRNTOa/jBL1gCAvqhz4qsA8eIAJdjjILLchU2ibkslbR9OhHBephX2e97reA/YtlNVbpjfwNgPf11/603keRXPP0wM7fLrlwoPcn72qX5f/kDiBoV8704VXXQbvXOWk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:41:03 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:41:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 12/12] dmaengine: imx-sdma: add uart rom script
Date:   Tue, 11 Aug 2020 23:53:51 +0800
Message-Id: <1597161231-32303-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71c4b123-6115-4916-823e-08d83dc9e646
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3464AFD9725F3AD071EA328689450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f96QC6hFyQEEOm0cTt+LfQ21uPDUACSBC8cdJDQFxhouO91pAALDMYYWzwIRFbIiFoTyJaRor0nxLI18A5RYa7MlosVP9kcauWmqKU8ngTY3kHIrFUgTt37iJkSDVAPPDhs2ptTYKa6QkzVDdgeNjMCIucw4jMtwaxMPOzVDxErz0tkdAJ+zslg0gcY8ccKOpAV5GWVpTWMaU6DeU7PCb+PQFuESVw1ulNkyNw6EcFWvJsyqyGNrnC1HgBU+cohKdet3te8E1JG3ziY6vgUZzAUjr4mXwjpbY5unUaWzld88sXIEKYcbsTxSTv/JDBRhG7Fyr8FJ+38ja9mEY5qa0bC9CEww1REHfkfGC5lEWvn6UHYciSJZWM8loMQdfIYZWciLIxdysQcZx0DF6nO9PQnmzRNRpirRjWWfVvdPC8ppVNmpCGCoyxPOj8zU7ABj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(966005)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DkLSOvOxVl1QXYV6NuINdtJG50x1tK/ajFEwZ5P5JbGWXJ9/bA99+M57hsYFUzWG1BbcLSDI89I+aNd0Sc375Je1JXXcSBsnnPSETUhx4QipJohhO2GsAaKsIYfJkLq8rV6MjW1wfkz9O3Q/r0oIh8N+rI+z67w//cNsoHlgusVzCviqeYpezn5uXi6miICHlEwsmd2BllAPJ44h/xuLowa0cQmDuBLaPj4BJVm6MjqactJS1WdlXBjm5+4FwQBDl+fuHtKajud+LkcQv4nOU4NeS8u+hxPBW0Fe+XslD5jJV4pw8uAXbLKUswOSE+JGEmQWlgMHB2C/1JXXmlHjbGrL4sHyrJy1VeeMX44dHX86xVCGI7HIYwnF+AuymT8Mc1fufP/O91TRGkcUIaY1e3Sr036m54XHsGuPeXgWXy71cDnTj4pqBYkbXt9s+TLWnTzlw/7Ycx+VvJtn8luUYmbAPzFJxrJaNdAcuXXwJqYYqORLdlkLEpTNFJoiTQ/ZBtWfHvTEx2rLTRZo/jJ46OGN/fncD8Wt5bu5gHv2rt1d8Bn1NzYyuVeszk0W3axftrT9DjzZHurqT5hOjNhlyh+NRqcvK95+GqSMNnefMWwppBPXXSL3ot8INUvx1dKeGxaRAnzgSmbBANZRnL/CRA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c4b123-6115-4916-823e-08d83dc9e646
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:41:03.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXqVOUq9zIEaAdqsC8n37JnLvpMRalQF1NN63o8zhAjUasyrmFzVIGBP8f0xThUzppvkIduKju1Arjz0P0/zcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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
 drivers/dma/imx-sdma.c                     | 17 +++++++++++++++--
 include/linux/platform_data/dma-imx-sdma.h |  8 ++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8735606..1631242 100644
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
@@ -1754,6 +1754,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 	for (i = 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] = addr_arr[i];
+
+	/*
+	 * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
+	 * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
+	 * to be compatible with legacy freescale/nxp sdma firmware, and they
+	 * are located in the bottom part of sdma_script_start_addrs which are
+	 * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
+	 */
+	if (addr->uart_2_mcu_addr)
+		sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
+	if (addr->uartsh_2_mcu_addr)
+		sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
+
 }
 
 static void sdma_load_firmware(const struct firmware *fw, void *context)
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

