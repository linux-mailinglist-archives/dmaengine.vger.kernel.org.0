Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664283C7B74
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhGNCIh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:37 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:40519
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237317AbhGNCIg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbMNSAcNuZ89WCQEHLFONRDFPipf0ciwLzetiAjjUjZd3kgwWHKFk3KND9CXIh3G8LLweRR5gMC0ET9/NiVN2uk/meZ7OSZZKqfTIinb+MHQILlfU3BlbBx4bc3AkYSSFbEeH4fSi90fEUti+/YRwLl9gcrITMpW+qEAH7MubVOH9CwKfa+ngO6fuwi5DvhHvkrHarK1ccQc2iAuh1jy4xn2/PRSyNSjicLgV4uNesEzFzfBtWNSy4UlW1c01l7d8ufF7GSDP5bmiO5NRVJlyY0BQsYWSTvz475K8xLNIAHF44JcXqz0sF5ClT6dITwHOdEDLWqeKrUgAksugIYxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eivtqmCh/6qtoM7vlA+AvrjcmQeA2UWkk6iZBtAnm+8=;
 b=InQO5icx+/gl9tGfSeKEHD4Z1L3/bJoqSkxpQ/T6yK9BUjLC12dFGTbw46rzU/do++/yIjw/RfQuj2rtghzhg8QfMuJerz3zpjZuk8SlbJwo5qwZkp33nbFzq7udcwLzdXhlxyKH5NB4qBAk0cxDNVe5+Q2Qv2fTAggCA/E4Dkf3txjSGAoV9BIXnbJ89rBgaq3J9a5CSWiSM0TvyINzeyb5wp0R4RVwkPmKYiqnXsxiny4VxnT0gcjo/XEpHAyDB6GqtEmkxzPcfAn5kqJN+8h4P73anfYn1qLcfulb7QtJeg6g+n5H7P6Nx+ga0Qi4nkqbnTI56j54N54BTsNUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eivtqmCh/6qtoM7vlA+AvrjcmQeA2UWkk6iZBtAnm+8=;
 b=DX+8QaXMwc4gf9AVvEPBQ74cxVzaMjE+T1nZcw91bli8XX69H9qzGiJqxANLZ2dWU1LLsiahNivcsMJT59FfLh57SQpN7MfNYEgYQZlki1h7SndtIQbDcKGfny+f6P9cyyvFKTSxl9ImpRKHyN21pqwwn7bM9wZfv6sKwxR1DgM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5773.eurprd04.prod.outlook.com (2603:10a6:803:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:42 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:42 +0000
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
Subject: [PATCH v16 11/12] dmaengine: imx-sdma: add uart rom script
Date:   Wed, 14 Jul 2021 18:20:51 +0800
Message-Id: <1626258052-22198-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78775705-c336-4c08-7c56-08d9466be239
X-MS-TrafficTypeDiagnostic: VI1PR04MB5773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB577341DC2E0C7DEB43C2812189139@VI1PR04MB5773.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+8+YJfnNq9Hh1m/QxjgnkIgtKhyVeek1pzBNT4wU9L1VW/k7rh4EFuGTbZzQ/+1uU5jTr+9ke26neLQXA/+C/gTJa19c6VbYHEhhABjz2xvxKAirO5CYvzBHVxUNoGlWVSB2QbQxS+iUdQu01cCzOu/7zuPCmHtLPAvpyr154nlOlPCW1ciMEeQPb4kYiv0slixrqNQojvQuUIE1nhj5hKjxIA4679REcI0P87sARcpLDfttaTILC5pQSsKbqXIj+xUXqtaPYubk5kesz+kGFKtatB1RNIGZP41fnBDuc5se86pTRJBHGoxY5bOxRi4Q5pw7UZFTxuCCTz5dzewjyGAk2KPHXIT0ET+aoRvbBlMv6VbXjMKAaDAdBPccJGtaJy3+dEgIkXnRhIG7FeVoLc+DURQxoT1BmeOCUbuQGy002njym0j5VTf6syaAoLjNLDJOfk/kZ+b92rR42tIx3pqQR/AbDZuVoelDbs25KHG/izoQ/VN1M84Eirl1L4RJcWmgxKJeAI6KVq4OCZmxwTf1btQd54UeS6lNK4shlkmoMbX+QRumfnitC4tfulkiJXXvTitO1Sx5RWdQrfT7gjjieJ/NIteiECzJ6khPz4J3epj2ZMY4eO57C3d9voRn2Heqp5qRff7RoKxqM4QJpF5EZAichHat7zmYV8GMOe00Kl32JiiyxWkzbDEsIDLfUVKxMIpYQ4ezg/fvqCuNlpPuGAxB7kSdshqdOChAsbHlfEv15yUaTqeWfw0fDVRd03mF7O3QIpiBpX7vOnUmixuCMbBi7Eqib4uL8U1+T55i3VxSNwPgTQ6764wXHBx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(7416002)(2906002)(316002)(6636002)(921005)(6666004)(83380400001)(38100700002)(186003)(6506007)(52116002)(26005)(4326008)(8676002)(478600001)(66556008)(2616005)(956004)(66476007)(36756003)(86362001)(66946007)(8936002)(5660300002)(38350700002)(966005)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uATJW4JLqLrCVqgi+7+bdwJme5YS8SUlFr+F+NFwoxlgLAbePtsBwUEtikC+?=
 =?us-ascii?Q?CAcksZw9WJ2bJQ363y3NGW1x/Qi1ZQ05Bk2QRJAIAIMtFQS2LqKk5OPV+CVK?=
 =?us-ascii?Q?jDFLoE42vHHp8LD5bVIZfKgn53ivJEq3rbaWw1K+ZmmymagZT6SJti3h27FM?=
 =?us-ascii?Q?YsdVBWMv3oAK8DrMgmiiE+B0i/VntX9tbvmKR9OoRoYxNRKlqbKLCYSmGOh4?=
 =?us-ascii?Q?M9ae0FMgjI+TlcYPEoxYUtdwETrJSaPsZtV5KFBbZ3tHxfmxcATzCOWD11WB?=
 =?us-ascii?Q?pt4N3UWsXuA5i+JoknMvJD5arzxLxvXmh7Bd6pPLBaj7c1oDR/djo4cUMvLh?=
 =?us-ascii?Q?NBvoutDOsp+iVRBAUaAFfsVBtAdYzAEijbKp8XKYY2Ch7A0/xLSeulPhG1T3?=
 =?us-ascii?Q?T9wRF9tn6jijWBmZZkpMVcfuxLYkmsrM4z9u7uYovR6jgerg0Utq1as4voIU?=
 =?us-ascii?Q?VnnQ81sESPY2qe/1xTtYHjg8QnG/8BolQApLlpYB1aWne3ldIzYFMfQqPANB?=
 =?us-ascii?Q?AXyjTMBv+PSK7aAI7gWuLecLO0g3NO9LyiYbMwGN76hq/WnwGexjSXsK1OzF?=
 =?us-ascii?Q?T/2aIr7DsnoFbuyk/IFuhjCFKhH1/LUxOPJfJVtZ1dPiktlP5zjeT8aD7z13?=
 =?us-ascii?Q?64UhHwyPxpY3IqLQiamksmC3nAcjEP4JrllFzDOAU9Ej7lyuoSHLliBqHFE7?=
 =?us-ascii?Q?q/Z5kAWUIJu/L5HBwfYVPW1C8CS3p/QM5tL4hqm2THRPoFpakE8qagtOi7tA?=
 =?us-ascii?Q?reMdgUj41WQ4YR5XMwaQfQRwYxvUxkcu+Dzarx0HlkTGWxnOOuFlVbIyz/z3?=
 =?us-ascii?Q?0nQMJcdV9iYuCW/AOSx+LDzs2Ub1oE8efunAklQW1ze3WzhpnEeJPOGPHxzO?=
 =?us-ascii?Q?zr/aOTfWlDTqQJ2o45ewJUGvcVqfiOYRGua2AT9MfyIAjC+d4/k6epMp9PmW?=
 =?us-ascii?Q?MhZgaEVwG/Nwd08GiGyvxx3xZHbh7qL5SEN9sjt4DXNF2XSPrrHNJ9TyfH96?=
 =?us-ascii?Q?VumPDkpwLi+sqoEbMzh5LePQst+1VHQK0UcCrATD8zu1l5df9ty4rePnE2gv?=
 =?us-ascii?Q?wsV46Pq6cHRwJrD6WgJAoKWyPXuL6znVfJjmOzrodT575ulCwQOOWFSYcq1F?=
 =?us-ascii?Q?OmeeZENNTA+3DgWsIOxWkeIwLilSEPsRB1S0QRC7SzwfME4FAsttHhJJiqxp?=
 =?us-ascii?Q?7TVpz9WWQI8JeWYvZ3SECLiOLw315X3EinxF2MdNP1Oxg1DfLLDf3uTj5DMu?=
 =?us-ascii?Q?9MKGYLjq1gpRzhGeMIxyuvH5Rpi3AIOzmGiAxfV55TvPLZHMGX4RzfxkHmz3?=
 =?us-ascii?Q?mhMFa/IpdeyuI2tx81KonSnM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78775705-c336-4c08-7c56-08d9466be239
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:42.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9n/RfTeNXxJV/2vC5d1qxq4XPhQPaDhRkcVc4nWdarNb+zuWhTW7fBvuE68Wa6HJIuSSPPBOh2XE52GDDiFBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5773
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
index cfcd413..9ec1edf 100644
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
@@ -1747,8 +1751,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
-#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
 		const struct sdma_script_start_addrs *addr)
@@ -1772,6 +1776,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
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

