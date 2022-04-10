Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51F14FB0AD
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiDJWdi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Apr 2022 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiDJWdi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Apr 2022 18:33:38 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660101.outbound.protection.outlook.com [40.107.66.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A3C639C;
        Sun, 10 Apr 2022 15:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+wwtbRMncYvcgyE6Ow5K7TGByFjsmSmvtO7UZmFGuajAVBfDa1mjT8oCbH0b6whQr/Ijz5kPsAlNuUT/6VF4UdvTw3nOwsvPSNyVxghtlW5ouQZtsdJBQcOobBVF33ZtaTlc7RYUNixyEZgOp1F7btnKjUFj3HMdX0vTXs2diKTWWtewldhETQrGFhFdn8WG9XjfLW2djoXi+DlxWGbxag0/Sgjfs/8tWvYWVEW9/MUlKl1QgiR/vijVk4VfPSHsHJlwhNw041n486TP2tW/+PXz7wuatTtblTUDx10P6wTgUx5XjKpzXSSCtdO6BO8a0B63AhjjD1gvL2wsE73/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSn8Pk1FSMNbvGYgf3Igw9ONExpQ0F6JEfpneQ15ODc=;
 b=oLPy4OhdSwmxUE2ncdki7SiZUOQJI26Ya2X24CD+H9Y+iO/MHKjbphxaLRw48eXVu/NG8I+cAcLvjIcpT/ig6rAO04MOROEVbyUigvNBqypqNUyzkTyDEWf90w/cnRL/L8Gugzu4qca04yl6oEI/FtEN2PaDeTG1yTHyjJ5fXIeVr1yduwfgkxa0zGECMzfYJLVeXGFdU6Kq6PF2/NWg3A6G97kpfdq1QQ63P4tZGaq963vSX0GpE85ACoo/WiMxmuS4AYVoDvkUOau4HxhX4+h+qXTXXEJH160Omhj9tZvAg7lL9EESZ3w/zTRNW8Zkxh2f9JRs950ZFKGq0zDuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSn8Pk1FSMNbvGYgf3Igw9ONExpQ0F6JEfpneQ15ODc=;
 b=lobkHWQe7cDyckzPl94dgcuz50YoRjvXI6LF47eH0XvBbWZlDXwQUomSG8bPiWwjMQ91WeY8+QczXImmCsnOSUeVyDe66IiGVxVp63ILL1QP4F9kgBaqExI8cdVgGBxVX5p9tPeG5Yo2vUWsd94DwECCPRoUVFAB45qUP9mA4DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YQBPR0101MB8160.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sun, 10 Apr
 2022 22:31:24 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4d4d:1d22:58bd:2f76]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4d4d:1d22:58bd:2f76%5]) with mapi id 15.20.5144.029; Sun, 10 Apr 2022
 22:31:24 +0000
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH v2] dmaengine: imx-sdma: fix init of uart scripts
Date:   Sun, 10 Apr 2022 18:31:18 -0400
Message-Id: <20220410223118.15086-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246a73bd-b41e-4c11-9d68-08da1b41d863
X-MS-TrafficTypeDiagnostic: YQBPR0101MB8160:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB81600DE8071ABADEB72A8973CDEB9@YQBPR0101MB8160.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX9mVEkZHD5NJ8b+rUnU2W+qhxCUuLcEZYB6C2/QywPvdoUIo8V21FlpkBJiVIZaADF81KpBD3hgGe7AEiCyBGY/Y/ZkUqGVMty6epDWpsjEAWPdwY+0MvxVaojXwqD1bqXFGDb3qJo6da8JC4PaAo9pfTsxg55UI0Eavvc8OUiwzoXObaSoWGD6vBPwGPCTTtzTP5UEreydBVN+xmLK5ops0yvAJDuIvoCtatc1wXixcouPlYfQB9KehmSS5m89myHbzJYm7uOd5PEeXwSXWe8/SPUdQdK1S8nFkthJmsYCLKODlHEHsS4M2jn4MdTUFYqdXByHdcVbslWarHQBeCjMV9S4G5LDIOiPXCka1DQ3ylXAVa8JA3FaWiCXfte8oEyaMuyTCZlZ9qM2gS8ob85tkdoW2yV/r1DUByUVgBJN2G6LWN5V/3Oc14kCazPy6vaC01V/WHb3lN+BuhdcVd8C9n/54vXmQmenqPj1Y/GF503r0n2tohVA8i0mEzE9vQysWRkri/tBdk/Iva4cFq+SS5HQRLG+faLPCf42rTbl2y9agtdfmUgUKIlRKzp8U0KXDsgBo6hgn7dNCOle5CUtSQFkHvC+zhK1em5nwk8gL+DVV5rEPQhkpn7+zOruv8iQMaVmIq4tytu8Qo+65ItXeVZuL5gjc3mRErtssnHfjTNvN4+RuIMX9FWT+skonwCE6k81WVVwSnGvof4v3IdPh8zmo8AOKxHlKDDBmSIZEClBXvnWIECbozbzZCpThrtsnwnXQInlH4x5F6HMbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(6666004)(2906002)(36756003)(5660300002)(6512007)(83380400001)(26005)(186003)(7416002)(107886003)(86362001)(66946007)(8676002)(38100700002)(966005)(2616005)(508600001)(1076003)(4326008)(6486002)(921005)(66476007)(110136005)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qiyxl0Hwz2k/2jW9gCZMh+nvrFQbM9V0yOPJI6yqnupEMLgHlptD/ZRoa5Cq?=
 =?us-ascii?Q?aG+Gp4Yd6MNC//s514c7qq0+HP0UNcZ7Wno0v2hNryKVHbrSVZ9yzLsCvoKq?=
 =?us-ascii?Q?zvy0k3PpY3tbuLhu6IrRHHCmCuoUAr4y1yvg6KAyevnEkjGMXTwEyXfoSDbX?=
 =?us-ascii?Q?sjOlKIPSakyNp7UGlK7/EgOnturgdA6YJ4BQaCpNwSN3RsYKLU96J5bAy6LK?=
 =?us-ascii?Q?TJOY5WMvbvj48maCyt9HuktBXISHvZ7oZe+Ndee/gilZDyNT68coTprse5bQ?=
 =?us-ascii?Q?iBsFMbtdAoWVpm1ELgHZRHVOE+kOggI3pb/7lrRsVvxdX4kjcpn4tpg7rnsz?=
 =?us-ascii?Q?e29gWQuo8m4nNvoAagUad3feDvOjfolndzPWA/G14slojaCSSnVNBR3lXyxb?=
 =?us-ascii?Q?5GOka4chjevw2Sl6+9JZCwrRR69+2Kk+ffv7n9uwOoh9Tz+PVHQ+MwZ2SejW?=
 =?us-ascii?Q?LG5RbsFDQKFtuen6Qfm0HltcOPjGax3/BNDxATCNASUMxhHlyRmhHw8Gvzxo?=
 =?us-ascii?Q?iDB3WnJBlmcGbuFEvJu5MnxJwDs25Rqp/C+Y7l+lagNizP6tD7dMEPXHZ+xI?=
 =?us-ascii?Q?yF9OYzqHS2AwXrb/AA518ORLwRtdHbEB6fHogumYvY/GBI498lu+LpLpji8z?=
 =?us-ascii?Q?O5hCyQGUPeXQx3CblaLB30Zp9XUx3A0xvlncNumcKS6uwue1y3K+eLkeST7w?=
 =?us-ascii?Q?RC5pduno89V1/wYqorOzGvi7MqG1SuuYV4BG9sa2vbn8Qh0hJCvIkyPujQfD?=
 =?us-ascii?Q?YIGRialh27gCrfZW2kNm+9HJKOs9F75sdjq5H2zQiDiOyFU8M2vZUUWOo19K?=
 =?us-ascii?Q?SIwkpFdsBMQx+awwVyuQijCuIzXUaEi92xa3xmzEay0gVkDkU1SbnO6C47MB?=
 =?us-ascii?Q?WQkdGIoJIneVgm817Lm+f4JGj3PwiRfUDhDD7C1iWOp3nxtZwdNh39dGa5Q4?=
 =?us-ascii?Q?kSyA5pyHasePinltubbBbRIFBX1tyUzeJZgihazzO5sLAten0hqqjgmTe4l/?=
 =?us-ascii?Q?UaDkq+VoyrbB2Ojedktgw5Ud7ReOv+a/f9vcTn+ECBdIfYZq5QwwWl5n+rv2?=
 =?us-ascii?Q?2kPDZts3dPmM18AB2ihdFF+9YeV5Nx7bOCPOk86PORzFrhaIwIdGa3o7/q66?=
 =?us-ascii?Q?HN9QVdpU4rntdoIsq9UTCwrb4vRLzJqeRBBLG3ML6mE9+x+QjCFP9TeqxMAJ?=
 =?us-ascii?Q?e22pi/LCciRIgU0qjr8bGGYvFIU86nF9n9SXPb4ucsFiCN2IJKpsw9hqMOcL?=
 =?us-ascii?Q?GkVel1+4FSIWiscmqRmRo0vp0+orz3JHnpBMnpp4dxhl1TaJWByBXlRHp+mE?=
 =?us-ascii?Q?hRCigB2IGcBsjuNVVgV7cyZlLv8svy99GM7hU7VpOCe7LTkOWqFTv4ke8cQr?=
 =?us-ascii?Q?aAMRm7UVsGdrUWt6Y5cZsUC6ygDqi2Da+XqJHeWl1YF0wmlmhDlGR5dONPy4?=
 =?us-ascii?Q?J3Qdt3gsHjGq5GIyXHLtLX31ioG3ALO01Ss+nEqtVstyba2KeDzJ5GzEgfxZ?=
 =?us-ascii?Q?qx21RWZjp36XNh26N/yGQmkthAMwV9iLy2vplCypSeh37fScKmfnzI8IbRZC?=
 =?us-ascii?Q?U7Ciz7f8EeqYaPNkyJgq6vLSM4ZDZt4sN6z6n3WGJ+L2x7XZUqK8gEI/K9qJ?=
 =?us-ascii?Q?V01Wkreob6zwCE+Cu3Th8lgHHwugAl/tldv/BSjhEMDk/FJ0JafoQXB1jFPV?=
 =?us-ascii?Q?71vvUbXLcqv4UBLYUgIuvlP3ZZe+1HVtgjQp1wEHe6Q0NuU2F2g4Ik4kYtsM?=
 =?us-ascii?Q?1r9+ns9Gp3G6Z/hRfh7MBzhOsQZ6ibo=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a73bd-b41e-4c11-9d68-08da1b41d863
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 22:31:24.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFKhRu5qlQ6lJGOHEe4klZ/U1KBIUeSl0RjjTMGJ8wcprTpqyjWODGZm7akhJdZbPN2UEYEEAwvInVvftjD2Px3bwanVBuxJ8wnUz8N6uRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I have tested this patch on:
1. An i.MX53 system with sdma firmware from Freescale 2.6.35 kernel.
   Without this patch uart rx is broken in this scenario, with the
   patch uart rx is restored.
2. An i.MX6D system with no external sdma firmware. uart is okay with
   or without this patch.
3. An i.MX8MM system using current sdma-imx7d.bin firmware from
   linux-firmware. uart is okay with or without this patch and I
   confirmed the rom version of the uart script is being used which was
   the intention and reason for commit b98ce2f4e32b ("dmaengine:
   imx-sdma: add uart rom script") in the first place.

Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V1 -> V2:
* no code changes
* update patch title to be more descriptive of change
* add Reviewed-by tags

Link to V1:
https://lore.kernel.org/all/20220406224809.29197-1-kgroeneveld@lenbrook.com/
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

