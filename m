Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC83C6E92
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhGMK3b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:31 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:65299
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235767AbhGMK3a (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8+WIkW9dzr7np9Agfmv2CIAWthL1xBXWP1Petut7DbY2EAWTXywxSwSzh+CUEHlbPOvDHnI/g+bQl4dWknbTzYvoZROErT4M6x3OAIohCfa2fcrwKswmiCleGi3h1v69bOxYTSEX/ItDQA4PCIjF2jUBQfCj8nRBfBhaiHo0JRoW5ZnckFwiTmG50OyvTb25o03hdMUGXoe1U86k2WXmYEwOjucz6zZING4oTpiFDycVn6zLzJjPQB2Fw6Dnu/hSGJlrSNLrQ+tPHAYaI04ShtkuO12M9s2BriJKMuPJejGTzvyrGik+30L0P664bzsQELbyfF6jgfQ0P3UFeOchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy7wYF5hmeBicDao0726iP4rATOZGsJRcrBYBDsOo/g=;
 b=H9+yrwausTwr/s7/QD7qyquBxGMIb/24kupMVGeR3159E+QG/ICYIzTrlmpLLMV+MzYuMB/heZaD+kPQxBjTeFf5cEw5v1DmilmJa3NbHL85/ooRisVYOMJZZPi54BcYhEXMM53hc9yVRCt4DGLUYhYPYW2GttKc2gh66RUWMAGqopE4sGfUO826ulpFX8xvpOxsLV4Z0ehZSQksAleAHC6YtjH2gmwaad6CoIi5wXNZvJhxjzcmUA+//p5KLkCVkKCsFcm4a53U1uo/C9nCm9dRBzvkcpgnHjfT70uAJd3mG9OFnFIPJJ3CQdrDlClFHwzn2VyjumcYkAiD3G/DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy7wYF5hmeBicDao0726iP4rATOZGsJRcrBYBDsOo/g=;
 b=oWDj7LO00CN6EjBhbcwCscLFx47p87pG/qxL4TS9wRKxy3emlSQ7SQwD1BfcRETyhuViISKXdqO4x+DrVO538AR4CHV5UHhbXPky+UftwrSqle69VJ8PkB0gicEajiLjvfdmqNdB0Ok8kyRcl3YqbertqpkBpFiZy52HC1D6sSY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3344.eurprd04.prod.outlook.com (2603:10a6:803:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 13 Jul
 2021 10:26:38 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:38 +0000
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
Subject: [PATCH v15 11/12] dmaengine: imx-sdma: add uart rom script
Date:   Wed, 14 Jul 2021 02:41:48 +0800
Message-Id: <1626201709-19643-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc20d32d-c6ad-408f-4864-08d945e8b2a3
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3344C23EC71E824CEF163E1689149@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Bj2K5bShk/Simo8Sg5VUl2nea0xaiFDECBuYqHPKU/utcK8f4wxVGXtwi8PbZP3cRkfA46QDnTARyJYo2uIlSI6AJwMFugre0wRUa+nORuUs2KgHhUntB1HYL0XL+gqF8n2dtVT8QWHbr2K6VUubjWEjcINkyYtzyNSdW3ngYOCQt7uhU0GXoY8a/NLcS/A7MucJ5Sq7bM1qMmpOiealq6YZWFmChRYNApyrlUeeaud1TMo9LH6OTCSEvcifwyS7h9ON1MQ8cAmAOXAeLGcFVTE8/Pc4r/ezGhS6Gky8VyiNW2Fh5Ldz4nsOnDYfg32zACaV1+rgTQc/SuxbUUZhqXGMe9hQytNyBurbLq/pBnoN1nxUoN9h8geq78PjM67BnXJhSj4DE/e0/FkNFzkVqwudJXeflTIj2eQs3UBCe1WKA5l8L5KWWwKTTHR+eFeDeymsuuyFyFvHAsPUFbSGiKfV2Hub9BvoFvAe55WtODRMCC/AdG6/5xkn1P4ryqi35qKbb3shodJbhRzVk2nUlBFNUYeKdH6ABRRzcRwGs8ig2MGELP+IedtjbaRSQMcZQ8NW45oZ95sion5bRnEKmBRZXkieDLUGnVQgZ6gMLV4ed6DlNtyoQYrY1zWkCRspjKfvddCvXlXmSDqcGAHQqamFkcxPf8A0y7YpcRT1DXHcPBVoY2K0e7SaZdYX7CzZxKBfEuV4iTkVS0C4337a0jtOLfBiIG4bkrsJZbRb/jr06MGbWm2haQ/jJZzFmNqdGb/uLt3HAhHY6WeVJSZRNmF3E5zqaOKU90YVrJDrWckpvjEeox2kaUIvzvrmghR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(4326008)(26005)(66476007)(956004)(36756003)(8936002)(6486002)(478600001)(5660300002)(6512007)(86362001)(83380400001)(7416002)(2616005)(6666004)(966005)(66946007)(8676002)(66556008)(316002)(38100700002)(38350700002)(6636002)(2906002)(921005)(6506007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6D+3dQDAwLFneHH9qZ2vjg6fCajYfH9dphB1Mz4F5C6qf1Xd/p4oZmF7Cilw?=
 =?us-ascii?Q?eDYWk+bYf5FnWBDfFcIvwfoLqPrPwFu7r+RWhocYe5mhRY06XxLzGXvM7z+Q?=
 =?us-ascii?Q?9TNsUxQNmLoVO3+Bg2QwGMnoveAoraiEwSww9gW2jcS2x4Uyo9CewmvdlG7/?=
 =?us-ascii?Q?DlzIAkWg+HThxxBuFeshS3YqTkvrmgZFJOEQ0WHFH/RZ/Y8zr8oxgyPRG4MO?=
 =?us-ascii?Q?NzTUhPGQ+fRAmvDqngua1iXVFefvS6CY1xOlVJ7kCd0hAP8oiFNN+hyOORty?=
 =?us-ascii?Q?IXBPgr5GT6oxBJ5Al+GLSTK+iYkokUcQPYfo08K6oZBA/Qq/2uQAWHIeZsYl?=
 =?us-ascii?Q?RE51MOGtDTSBA54fPDbf/VjRNyjoYb4ZrHZcIkGMxpMIIjXA7QRMLP8oYoYc?=
 =?us-ascii?Q?qlE3p0ih6TiVqKby1rzxmdoI5DloMbTZO7TvptIvKKIf5pGYTTUq3hw6TwCj?=
 =?us-ascii?Q?HFeeWCvX5eaFBQ+mCqRg2boy2OszbgR16ytZPdV4OyhdjB+JrIoWVfHdBRx7?=
 =?us-ascii?Q?piRRpZLr8WOEoMRq7y0JSscNr3oPQsfntm79HsuOsb8bezBGaXFDF0pX3gXV?=
 =?us-ascii?Q?kcsgeaDmProDLbErtgZ7lcoUIwEF6XbnLvFovFH0z4Q4EJYisxx8rnzxv03b?=
 =?us-ascii?Q?HYcrBYmLZOtz+hsKl26ejeabY8N4x1fHByP6bRDm7qeHdKNbZ+9F+CYZCZIA?=
 =?us-ascii?Q?79Nhw8bh2ZUmENovGIHIv4EoZair2QfRPihjY7fMLTt5zdf46h7b6evTt4++?=
 =?us-ascii?Q?zcv+kCv1xohB4qc6uO96P3+WA8bb0zTfhlo2RmVUsR54NW5EAhxK12xAeb1a?=
 =?us-ascii?Q?kIC8O0L9WAtqwFyjbA+1E8OR0O70Bnp7lPUFjuNOctLfZlouhvAanFWN17zq?=
 =?us-ascii?Q?qFA8XksjQgNV+iYvq1gD89wmbiNrBUtnlnGueMItyqihYpcJrG2TqvTjRtbO?=
 =?us-ascii?Q?PCDuJ0RjYgUtLYIbX1oF5Ii9g8FsV+zIEXK7J08PfbAzzvlyh6ID4HBHHFQ4?=
 =?us-ascii?Q?AnpJREIp6je0bIXP2dgDDIosIThES55jokA1QM8diEL24u65857KQmpWxJvn?=
 =?us-ascii?Q?7enQgpTQTRGYkAbbOoTD7E0wZFJYrfl44wLuFNRLVLjiN5kInNZ8CNZ3mFE8?=
 =?us-ascii?Q?G3G9xRFpSes2fa/R8EmgHfu4Q/f3KwvJG0ZzOGO4uT4bNe40yxWE4eQUlSXD?=
 =?us-ascii?Q?zIRdL2vbP7hWzAg8NHQLNADe7WIBWBjTsPqTsHHFPk+TgVm4PghhA1nkyjva?=
 =?us-ascii?Q?s4eMd6cbwHG2PoeQwIiruHIFlXl4l/7+g36QP5Mss6HuZZavUn2gO3SfuazR?=
 =?us-ascii?Q?oViwIGDdPDXAeC6UoZIb84/U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc20d32d-c6ad-408f-4864-08d945e8b2a3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:38.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6hu6zdioHi3O56pXaf4n1sI4Uzeh86beI4YPkQu9JZ6EnGZ2+8zFxEv2MRrfzL8TjnVLHdJr1gYkrG2HYjPDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 211299f..c449755 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -198,12 +198,12 @@ struct sdma_script_start_addrs {
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
@@ -230,6 +230,10 @@ struct sdma_script_start_addrs {
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
@@ -1749,8 +1753,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
@@ -1774,6 +1778,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
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
-- 
2.7.4

