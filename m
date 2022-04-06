Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBF4F6E05
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDFWuc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiDFWu0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 18:50:26 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660097.outbound.protection.outlook.com [40.107.66.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D501EDA3A;
        Wed,  6 Apr 2022 15:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxkJ9EDD5Ub01J1es8/9aYcPzkcCWBSfNVA+Grj2DGtm2wDzB5usvWO8IhFonzXjtVuFF/KJ1p4H6I/S5Jn+ZW0EVgS6bzIoFZPnQgPBg7YLS3A9Aa1xvvac8wxEAL7RHiFjDO2kUx8Zm2vgdU/pihryZq/wksGmgtGV4We74E2O70ZPtO3TgcdYJNTlou4u4JFAgIaaz/uvvICb0Ga7rAHhDmA7IlxWKyJ1p9IP7SFP8+4LpMv+vyi2lVRIujHw0z3IhyVf99w3dEjx2nd/eCWDAQlWyjZGDEMAso6Z0yDYLOs/3EQQpE2MRLe/LteZrXEhlybQQQS24uWkv1g1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9x3J1knr9MhujooGCdXbhMWtFj2bVNtt/kosteOgMc=;
 b=cAwXN5ba5YlWky/BMHJhRx/tAt5jqkQ0MJ2+mWzPRLqaciZKmw9aEfy1+VNxlUpZdjUtZKdc37/8sDH5VWRVwZX8JpAmqFQvEKqOwKzZCf6nhmQc1WSPLy/NeToQOOGEIv+xqNkscrkQgMK1B+F7xnmZGTbDK5HY/+uNPHS2WoqXemaBMX32mTGA4VE2V4xHzKBQxnDu2wOLeg7mp96upZPEYdpNg9QSTRQ/GPFCXCtuOQ5iifltYq7nPg5L/E5TN4lvwxOeETUpwt9l64/57WMF+TokVwhnfyv2k6NNCkeB8Oh1nasvNuNuTzm0ZPhma1A2DY8737BMCFz8NwyLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9x3J1knr9MhujooGCdXbhMWtFj2bVNtt/kosteOgMc=;
 b=FsbFZz8oIipglP0MHPU2qyCGBaDGPwKTFffMHkFG5nbH2AvdtEaMsW2dHk6en/SG40FHEknikulOO6w9FblQ2KHk8biJcjzvX3oDfilAvcDM2U1aL94E2M0t7Z4MJumBeRl/clhLeidj77wkzHuqPGVMA2wCc5fdbv2ytkkvtWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by QB1PR01MB3474.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:3d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 22:48:25 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::291e:a689:84cc:ce0d]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::291e:a689:84cc:ce0d%9]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 22:48:25 +0000
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
Date:   Wed,  6 Apr 2022 18:48:08 -0400
Message-Id: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159f027a-347e-4c69-5d58-08da181f8f68
X-MS-TrafficTypeDiagnostic: QB1PR01MB3474:EE_
X-Microsoft-Antispam-PRVS: <QB1PR01MB34749A4C84CB858F32C9C45CCDE79@QB1PR01MB3474.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n0dHrEk5vscdvAgpZ5T5siKhx7MuVRRgVDjzOJiWIxV1Noo514YiYHnBX0nmlbeoDdi+xfRG/HdJdxU/2HO3jE39GQH4xaEvII4xIU6zzrx+F55kIN2iemVuYl2awP0u33eO1/bHAc1LNxTJknHDoz5osmbnnlTV2s+WbDkwUrwL8IxhdLpzAqfIEX4CGlY0eaDMwfD0Z5A431UjbsYvWgU9GHsEFLHyNUaawCL4Hl7LsR8DRFOJ6YzJJ4m2iA1oO7yRkN6qjSwzSu/Qa3ATLOr0I5ZLoOXGExMp0JB7FWxdBYaVRpRAC6SFISPPuufjWDZxG0KdSQyF2dpeM8E8dFVADhZXHeCwEeJ+fskns8xLg6Y5UghEWtYK02O1DMNpqgSsQTEwWRlhP7n1kokc1rAgEP7exr7VMwttaxUsq6cXpt5XySwYqfimD+sCV5TtBh5p3hvd2/q3JK5PWyXZJwYRsozBUBapLQqGEdZSUJzkfWQnBcTCjRqqlYWL2srAgt7I4Si1pb3fYE5aOaB2P9R8apbnQN3nvdNrG9xJmBnnyiPjAqWiWWSR5A6OhCoYYby16ThxQ17yHXuViKElkvOmJmWYR5YzIx5DC46I+yN6NwF027ALAYklMMtS7I2pEzfzUfgVwiKpvqrDcG1tYdYZoNEVhuqBrMbyIByvcUZWCyWKkLeGIvck8ddyUAT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(186003)(8936002)(4326008)(8676002)(26005)(5660300002)(2616005)(107886003)(1076003)(36756003)(7416002)(6666004)(316002)(2906002)(508600001)(86362001)(921005)(6486002)(6506007)(38100700002)(110136005)(83380400001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSBijB6QLq1mgEdZ5IC57U9PjGDjv/BidrvNM3AbnbP9Tk0OdbFwKCBbYoC5?=
 =?us-ascii?Q?K1EehEdOTX+zEcCfZlRD/z+BhCK2xYMrZGYQemVsXnoGFfdyKdJdNX99Tggk?=
 =?us-ascii?Q?21b/kp2OmhJBT6sGQqSNiFIVNXq+l4lzAFVV/VzVQHIQ69RuayJgoE4NcVBG?=
 =?us-ascii?Q?qYBhTVIUcBaLxeYNjxozLupN5dq/nAw8Xh5cmrhiPqJ5QdoGMnBNfeMioKzL?=
 =?us-ascii?Q?1p87FnA49hU1yscWDBp5MdoEMklJQ5uKcbFRqu+kTZULM8upo06WCatCIz8b?=
 =?us-ascii?Q?2qVPnmXG9lnqfFWzl4JwkpN+BnSpoOk8BzCAYGwjzh5YWBv7T1yYXDiwjCjD?=
 =?us-ascii?Q?BJRReJr4pBgJH63qtQEFbYuBuBI9F6s+82U1TFqGbnGxXsmJweXZHcdxGOOx?=
 =?us-ascii?Q?r6lWz1dUwX7dpBWzqpDMVlJ9sYqvU7jwwizi1M7TBa5QfRiQ03tE5FC2mBm/?=
 =?us-ascii?Q?NZyWhEmGrAo8dHQsaQCH3/Tg+Ry6Ertn9pEkqeW2o452FXZ2eCXksk/Cmo9S?=
 =?us-ascii?Q?nH9Wyy/qFn2qgsERobUFIt2tK5VntBulczz5Y7SWmJtgWVTlieST5yc24QLt?=
 =?us-ascii?Q?bLOyOV3OGgJc4FSK5/xNw9OziDlWInHSKN2g+P3XWE92/imCS471H8ffXAbp?=
 =?us-ascii?Q?2snhPtMBEViA1qGUjVaglZbyKSX0RuMv54aw34MshR0te6gpBj8YCXfuN+hh?=
 =?us-ascii?Q?5LVXrcjkmWQ4tdl3fI6ZEf8cMuDgYtYr9fXLLFblvtmn9ligQkDsLUJTO2K5?=
 =?us-ascii?Q?beVBC7YG1M5NONtRasddk1oMMvSiarU8krHCz1HRTaCVzFqTm8VRULIeT2BW?=
 =?us-ascii?Q?uFD8j/B+eeyISnKjUPFAPaQtINAi/qsNoYJ8kUbhZ8muULuNPQrtHh4GdVtd?=
 =?us-ascii?Q?pwZtrplF4cuzK7qCc6c98mOgmdQ79W6y3qwvj2LoHfOz42096UykPmgDuEpY?=
 =?us-ascii?Q?nTrStV0q9aXla9v6tHjWrH9dY3+nfQoXkWr5gxtFg0Cr4N8nmy0+WuOqsgEw?=
 =?us-ascii?Q?QXEz9jg73i1862tiB4UM/s9m0CNSUrM+K1Glu3GU0opvhA2WeFseHaRdUytM?=
 =?us-ascii?Q?ki5DHgFGL0m5FnKfAkvewdlNLPb7DeERWE5rtadBuEW43wk4DEkpvj9+glDx?=
 =?us-ascii?Q?83mtn9DEixyMqPqaPIIHJWAjdGb2zBgrvNcbb8H3eP06LMo4d77wPuPHQoDe?=
 =?us-ascii?Q?sho6eN9/BiVh0ChW8wysvHc9oKot8Z7Fg+DRY6FaQpBUSSC1pYMsDKrRYYmb?=
 =?us-ascii?Q?rO3cC0PxZo77Gbi6wV19yvLk2nHPLutNIW3zpLo3B2OT+Sku8HMTv6ddiiXQ?=
 =?us-ascii?Q?QLv8vTIzyvXQ24REsFRnWGilsgvUo5oHgeI+zchj21hNeNpBWR+esXHtNL04?=
 =?us-ascii?Q?26D1dv9yvhN4Txf5BWIFs4b4mZtA5OSpQk5nwF2WWsoR/tilddMCDUitPSrg?=
 =?us-ascii?Q?75LXvG9dnqw+AmsDLYBNBTlF9IOuyD8+h/uJuItYhv05yhr/q8SgBTbyC8F7?=
 =?us-ascii?Q?ZxJRBcc9qqKUAFVBYn4t6BjRUXXh84YUYt9tvHBYmGv4n5tu/k6qX9qGUV+t?=
 =?us-ascii?Q?/YemBeCqJB/G8dxljSjx44ccDmQhf3PYD5NEaE50SmOVNqw1VXh9SaKupyaN?=
 =?us-ascii?Q?jHMlqV+WQljp58KQ0Jvr1GY6DXB7gmMS1l9hBXQQea3I8wkuDRm1j7jxrFzi?=
 =?us-ascii?Q?p00cNLnU3cfeHQlux7tICICGlijrBfjNp1YMkYCJFV9k02XVHBR6rsSpPila?=
 =?us-ascii?Q?Yp8trdyhKYo9o2AJ//k+XxwQSh5gelY=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159f027a-347e-4c69-5d58-08da181f8f68
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 22:48:25.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsbW52bAV13FrmUcP+PxqrI89tVuWAPAmW1FALpvRTiy+V2nOGHRY8B3jKYdkh5CtBNbeCq8y2E68s5nMTnAS1vd56xAv5I0bTicg97SgEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script") broke
uart rx on imx5 when using sdma firmware from older Freescale 2.6.35
kernel. In this case reading addr->uartXX_2_mcu_addr was going out of
bounds of the firmware memory and corrupting the uart script addresses.

Simply adding a bounds check before accessing addr->uartXX_2_mcu_addr
does not work as the uartXX_2_mcu_addr members are now beyond the size
of the older firmware and the uart addresses would never be populated
in that case. There are other ways to fix this but overall the logic
seems clearer to me to revert the uartXX_2_mcu_ram_addr structure
entries back to uartXX_2_mcu_addr, change the newer entries to
uartXX_2_mcu_rom_addr and update the logic accordingly.

Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/dma/imx-sdma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 70c0aa931ddf..b708d029b6e9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -198,12 +198,12 @@ struct sdma_script_start_addrs {
 	s32 per_2_firi_addr;
 	s32 mcu_2_firi_addr;
 	s32 uart_2_per_addr;
-	s32 uart_2_mcu_ram_addr;
+	s32 uart_2_mcu_addr;
 	s32 per_2_app_addr;
 	s32 mcu_2_app_addr;
 	s32 per_2_per_addr;
 	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_ram_addr;
+	s32 uartsh_2_mcu_addr;
 	s32 per_2_shp_addr;
 	s32 mcu_2_shp_addr;
 	s32 ata_2_mcu_addr;
@@ -232,8 +232,8 @@ struct sdma_script_start_addrs {
 	s32 mcu_2_ecspi_addr;
 	s32 mcu_2_sai_addr;
 	s32 sai_2_mcu_addr;
-	s32 uart_2_mcu_addr;
-	s32 uartsh_2_mcu_addr;
+	s32 uart_2_mcu_rom_addr;
+	s32 uartsh_2_mcu_rom_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
@@ -1796,17 +1796,17 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 			saddr_arr[i] = addr_arr[i];
 
 	/*
-	 * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
-	 * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
-	 * to be compatible with legacy freescale/nxp sdma firmware, and they
-	 * are located in the bottom part of sdma_script_start_addrs which are
-	 * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
+	 * For compatibility with NXP internal legacy kernel before 4.19 which
+	 * is based on uart ram script and mainline kernel based on uart rom
+	 * script, both uart ram/rom scripts are present in newer sdma
+	 * firmware. Use the rom versions if they are present (V3 or newer).
 	 */
-	if (addr->uart_2_mcu_addr)
-		sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
-	if (addr->uartsh_2_mcu_addr)
-		sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
-
+	if (sdma->script_number >= SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3) {
+		if (addr->uart_2_mcu_rom_addr)
+			sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_rom_addr;
+		if (addr->uartsh_2_mcu_rom_addr)
+			sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_rom_addr;
+	}
 }
 
 static void sdma_load_firmware(const struct firmware *fw, void *context)
-- 
2.17.1

