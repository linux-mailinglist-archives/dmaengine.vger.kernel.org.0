Return-Path: <dmaengine+bounces-1430-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16087F182
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FD71F24764
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBB5A0E9;
	Mon, 18 Mar 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxFF3ojU"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58825A783;
	Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794736; cv=fail; b=LCI4vsd0kN4UVCuVT3mFquoS9SgLAhKpVgQyIZzGEP5xgnouMGr8brGyoc9HEMRIZSnWqKyfKa/W3RjtMk8gDDTW+mbC1e7f0RLbtIjoM5hLn0wiONgHnC1qD2ywA/V8FM5lPaxFiECNqi3YHSAdXqtpFqoEhRTwzvtLwRE0SGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794736; c=relaxed/simple;
	bh=ljnlvogNa9wjnjqYA+qrmJGp+L08YvFN1+NqfGiLnuk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DBNGiOdJauTFe7+VpeXAdpb0UcboYPFsMLB5vH29r6h63H476Ax7nz87gZBOJlKWHuKudnRHH/xJB05prerGRiC8xHaOytX/Ws7TxlI6KX4QGOCDB5oSoKE4CGzMR7pcE+5o8HKnoihAhVR3iOwb8M05ggalrofO/z75L7X11BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxFF3ojU; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQlsOfpAzB7jn3RUU7FYa2lbY8eD4z/ePU2BUtBCC39ONC3yFalY0WRWDL5+moQUWPZuyCY34UXwhZB9D5PtowYMsM3Dmk9cwokALcy1BMDP4Qlii+/nLv5VsrYRA/DQ/rxmGY5EhbDayM6HnAGHw1WyH8trmaWZJhhIPcd0wXJyE2JAyPhD21VGHiOphh/fkOUwSt2LyY7luqaqyJD9g6hE7ouVZwpK38BQleXlYtC07RhQXPeD3RP0MbUIkxk3y2igSWk7cFWWJB+bDuyf6ZWh84+NTqTGT0tMjRcDi2yZBJPEga6/Z03+wvVR9ww5caR8QjTGYW8gIeDrWOQ+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waST1WDc7IwCRjnOr9xnT/UgX5vct1eYeHIekxCI1Ps=;
 b=DYe/H29FYk9vqrf4Oh8+mcH7J0LJR7d+64zzG7CSWkpC+cBT44h7FGjD2FCTVIiCu2ztLylTv+Tjd6eCqi0y7q0YlK++R+qEAYKJlDt3TDaHSmFPbkPBKkrE9E1PM+7cgChyJUI04mHNVwSEQAAM6VEtgaeQaQWvIRvKKF3enjvGSvJp13kZOFE++nCLc+Yih7UtGwmbF13MgxPgNPgLTxNoAWU8N4y5k34sxYnKiBmEY3GgFnAZ4daOShoDskltjUGJ9N1KbXnijomflRrGvoCxMYrYPGCW0RaOttZlZKD4csHfmgQqO2WW2IIooBUp9PMrgXabpy3A78Rid7DvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waST1WDc7IwCRjnOr9xnT/UgX5vct1eYeHIekxCI1Ps=;
 b=FxFF3ojUCbe3aENunLGDeOd9dX0GxUyuH1aMeme2h5a3iDvTI2zRo/QBP8KYIUtpXF0csq/jCEm96fbibLl7zQR/nm6gWo3+Pvsen/A6V5xLP3hPp/f37T8O+b1J6krDmgIr3LICaNOpN2WuvvUsu6HfP8TOCaDADxDqCFBjC4Y=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 16:44:38 -0400
Subject: [PATCH v3 5/5] dmaengine: imx-sdma: Add i2c dma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sdma_upstream-v3-5-da37ddd44d49@nxp.com>
References: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
In-Reply-To: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=1789;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WnRMemTOoEpPrh74qdvslzZv7uH3a8I9p3b25CXOt2w=;
 b=r5sGLNOZz29yoq/nSBHpN/0L5T6UoRlY+t4u8x2vZGWexln3Kcg6PA8aaJJygTWqnRgqbDGK8
 B8KCE6i2FGWAIAnjlfTAXtxt1rHuiTOKxPbAY2mrb35DSmzHBgvqEAY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcvl6hlV3g8SXpGha8JrdjJ1pKXiKiIzS9WDLb1LcZv9PqJ2jBO6A3xJ8x9AiNl8cXyBPm5vnN9ofxh6nHmUvyyPaoWKNL64cFudNeItK4pBT4uQV6Z+O5NAujYLevZhsQ0SXn4kPM9p2QjPrfDg8p1KorjG7XdceXKOSTHJM3nurGaK8pwtDUKn0JyFSNqfKP5Qul8D0HAr1+765d4aVjVZzkSCj1l+JkS/qTRIHN1SkIJpHPxG0lzTlVxfcDwoNpBRGisdcOcu9zzWwArrGJ/lgluqRK5S1espUsHdzBN1zh06pMVFDWwrkgvj6dRes2GL/cnl7I2mgD8h9vaCm5axR4XcIRGTyPI3VLgfFKl0Cj3l5+j2mHWspOQ5DcKom77EN2hotiP2ay6pGLLIZ/XkJ4LT9A/XY7eheW0gyl4736zeY9FCkD0TiE+Yff9pDtmP2iesi1MuPVTlpsIimp7JVCri+LTUSfitHbFzjK9k2EtL/xmxo8HaFmajrpuVWL3pvIuBHIEmvYdYRd93W4rtO7EHAQ6jwu8Iz0zwQrMBlfKraaFgjoVxJZMJh7AMngXzIA/ya63eqzKBFMZE55GycvyJdHBzAH0biHKtCI6luMlxmLUsqZUPRjg5Vd+zhLtb7kJHSKrjLmcMwSIJScxu6nI+pAFpCbQVPmET3ZmtDOvmyY3kY7J8GaHy0Wu5qK5zJj7+z5+QMia3bXrlhIkrIeWdNEUT+JI+tdZoiWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlNIUjkxamRVczc3cjVGdEhxMHVGNmFTVFY5Vk16aUUxK1FzSWFSbFppaDYw?=
 =?utf-8?B?aFV1OEFZekdUUHk4bkx2SlIwWTZkcVdUNW5JUEx4bWtWV2dEYk5ZT1U2aUZa?=
 =?utf-8?B?WFpkSFA4UGpvWVVJak1qREozUjEwUi9xdVpLcFVRREo4YWVHUnl4dkgxZVNy?=
 =?utf-8?B?ZC9uMVF4MTdOeU16R0QrT0lHdzd0UkgzY0lCWHpXTS9JcTN6WVVpbnZUcjJU?=
 =?utf-8?B?WUNXWkVUb1BBV1ZUclFLNjc2dlZicTJsZ3YvTHdMZ0hVY3BVK2VKRXgyWS9r?=
 =?utf-8?B?SFZTR2lLbHRrMStwTnhYVkRDQzJ4UnVJRGUzRTVNNS9KWk9xaXhMMjlpZWtV?=
 =?utf-8?B?YTZPK2dpRmYxSi9HRWEyRUtqY0ZjTzBJejhpeEg0UGhtK01zaXV3Nm5RSzZM?=
 =?utf-8?B?ckdPUUhXL2grMTBOb2tOM05tcUlycTJsWHY4VWVyckh2bmQ3MDloK0hjTWpY?=
 =?utf-8?B?TnlJU0xYRG9TK2R2S0Z4RHZJVTdPTmRRVFltNzFGOUdZMWQyTmVoaTFlbVBP?=
 =?utf-8?B?NzFtQWMvL2s5aFVMNDdRaDNZRjdrcmxHNHlBVzY5RVdkNG1yVlRoZnZnSHc3?=
 =?utf-8?B?VjZRTGhLVnZOL25RR0R6YjgvU1V0cnZ2dnpjQnFNRWlXb2tKQlAwa2lNcTFH?=
 =?utf-8?B?Yzh2dnBWN0hPQlVjd1ZJTS9Lb25tWVZ3Y29oeG1SdFBQZGFvalZ5c3Z4cTVa?=
 =?utf-8?B?OTRLa3Y5cTcyUEM5VXdDWFRYaEdlUm1qSFE3czVGSGVlTkpxcUhaeFF1NWNP?=
 =?utf-8?B?M0hJVkNXKzBFSVR1MzFtWm15Mkx6clA2ZWsvKzdsb1ErbW12aU1BMUVmeFU4?=
 =?utf-8?B?cU1hcXdKWlBlUDJIU2x2TXoybmloRytsNDF3bEN5WlN2YndGQmg1TjI4ai9Q?=
 =?utf-8?B?SG5sL3BISC9KdGtuUHBDYnJDckNuMFZIalRqNGZYMVoyRU0vYWxCRERySTBB?=
 =?utf-8?B?K25jZE5rR1dFS0dJMjkrN1pBWjh4ZjlGanFLNG91YWxLUkdxWEdBN0xOazhE?=
 =?utf-8?B?KzB3MDVOZm1RUzN5MEF3NFdnU3pBNWFmMjAxRC9kY3NmY3E4Zk4rU3Yvblly?=
 =?utf-8?B?aTFFVzlJZW93ZyszS2RuaFpDSlFWOThkRHY0VWkwUkNGTjNyWVVEVlZUdTBV?=
 =?utf-8?B?YXZLTnl6RFlGZ0VMbnBhMzhRQ2FURDRweWdtSlN2WXlUYVd2OUU0ck5ISHpB?=
 =?utf-8?B?M3c2K3RwcHVVQXJJekdMVCtsUGNKNXpsaG41OUNLTEFDakxidFZ5ZE1VTXRj?=
 =?utf-8?B?VjJyclBJWE8xZW4xaEVKMHJTZXIzSEJrNURIbnl4VnFJMTVwcjAzYVJMM08x?=
 =?utf-8?B?Y0J3VUlZdWs1TnlGSGxObmdQNlc1S080c0o5TlJValhBdzF6dmpwQ2xqVlNa?=
 =?utf-8?B?K0NaM2NjN2d6NmZnSDFsWktiNDFRYWQwS2VxdkRwZ3ZOMjJIZGs0bkRCQ1I5?=
 =?utf-8?B?ZHc2MUoxTGg5RzVwcTBQZmgrbUtzWXc0NlJheWV6Tng0RklsNzNtRFhhZDNY?=
 =?utf-8?B?NTFxRU1icGZvM2NycEtmb2RTV0tHVC9mMklVM2NONnFvUGRjZTNuRHpXNk1O?=
 =?utf-8?B?UjVWZTJtSWxqWmtLTlI3bGJ0WG1ZK2JuaTJudkJKclhRWERxOW43MEovbzNW?=
 =?utf-8?B?UElFUGh2WTN2ZEViWXh1VXZEZUJHM1p1ZzRvYlB2ZkFSZzdZUDZqYTZVcHo3?=
 =?utf-8?B?NEY3cmpWTnpodXFIeGlWc1BGNUhmZTdjOXFaQzR4bXh3Yyt6bTRGM1pva2FF?=
 =?utf-8?B?V1ZIcEJqajFUQnVkMnVodndmN3JTR2pyRjYzaUJmR1Q4QTExSnRiOHNJNFE5?=
 =?utf-8?B?VlhjMENaVVZ3d05qbG13aHd4aThlQUFiWFNIUlB1UytUc0w3dy9xak0yTUgy?=
 =?utf-8?B?Qy9XbjMxelhKNEJIb1F2enF2NzhPVWRwTDE5MXNSM3c1RmtZTmZZVC9ULy9p?=
 =?utf-8?B?c1JFeXNwMHdWdThTUklBMy9mdlJtNG9GSUVFbmxvcjV1VFp4M0VhbXB1RXNL?=
 =?utf-8?B?WUdLeDJQWkNvNVNVYkUrQVRIbmYvOUEwUFpoRVpabzZYelF2Y3UxaUFMRmFO?=
 =?utf-8?B?djlnV0tHT0xRZmtXVnQ1dFdvZmlXenoxWlkxdVpiUWdTcU5BRUlqeGxhZXd4?=
 =?utf-8?Q?QqoTwuuqcoNP4Jvq3IB3vvsJL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98e84c2-82ab-4e34-1767-08dc478c5a3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:31.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHgtE1822wiiv9kPU2XiNOTBBcrMbcZQ6WM99JHBq6zCdliBOhBJRF6mV7AHJXM3F5msjq/t7VoC/2Yd0s4I2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

From: Robin Gong <yibin.gong@nxp.com>

New sdma script (sdma-6q: v3.6, sdma-7d: v4.6) support i2c at imx8mp and
imx6ull. So add I2C dma support.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c      | 7 +++++++
 include/linux/dma/imx-dma.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 35fb69a84a8da..5bc4419fd45f3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -247,6 +247,8 @@ struct sdma_script_start_addrs {
 	s32 sai_2_mcu_addr;
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
+	s32 i2c_2_mcu_addr;
+	s32 mcu_2_i2c_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
@@ -1077,6 +1079,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
 		break;
+	case IMX_DMATYPE_I2C:
+		per_2_emi = sdma->script_addrs->i2c_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_i2c_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_HDMI:
 		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
 		sdmac->is_ram_script = true;
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index cfec5f946e237..76a8de9ae1517 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -41,6 +41,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SAI,	/* SAI */
 	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
 	IMX_DMATYPE_HDMI,       /* HDMI Audio */
+	IMX_DMATYPE_I2C,	/* I2C */
 };
 
 enum imx_dma_prio {

-- 
2.34.1


