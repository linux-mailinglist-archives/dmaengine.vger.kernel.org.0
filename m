Return-Path: <dmaengine+bounces-1662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2B891FF4
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB53289AB9
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1B149C51;
	Fri, 29 Mar 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PcedNrqd"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2139.outbound.protection.outlook.com [40.107.15.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084A1494D7;
	Fri, 29 Mar 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722935; cv=fail; b=WW1kIXOcDrvl2QYrtNE04JZJWElAI5nvFlxNE3/Fi7AzzQdMHv+3nVVpnRlzWG5FBS3e+i5mtrNvxct1TeI/y3aabYxeX0HLjn7ydfivMq+5dBJlA9cF7NapbZ2HVH22G5lVp62RwhlCDFS5cA32tR0D5o36OKhkMh9SJYRtI1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722935; c=relaxed/simple;
	bh=GUg1Wj4dT0857ArZKskce7IdNNMU6FU4HDK9KygVLKM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SuARp9vlowFTPPQnUS21tAW7qJlk17mS71D5htoGooa+RW7FraLZJiEqZ/Pe/UpEBb3UKJDEGsPeTd8tOYsnpwBCbF/OpYmCv6E9OEHPfyUUYSEhWVsCiVTEXFXmJOsdcGsPEXebNBRPk5w3B3dPgsa73LrILDyc2+B84CL+nSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PcedNrqd; arc=fail smtp.client-ip=40.107.15.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C85q0VCmnMmra2C3qWNfJ2/hBIbFINP2l0h3ZSUT7ro53VtjETqAOA8q6OYDpjvqGbkvXv/dZ0vJmZyvqKyE+n7UnaP0jYa0X4l4T/cP/xq+HbBOhYiuE+PlrSCv26mPsyD5OykLIoFOGOmy7XKu6w+mjd09m6dG7RrtjaR4Qgl6QCia6oZM8ompPgdaZZeUyQvEg+qaRPJXV/n4DHUetVgTsBumNoZoc3Ql7iq43Qt5UNh2ZFiPIuw9tiViPX0cFlfwk7rIm9o7RGF5F04PZSrFVuhSKC284KGSYT+slrBfrAqnbOV2wk+cb7+p5JshYi5e+JhnhrtUhRvM8zwVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzM7oGmNAXKt9ZcnTiFTPEbnaZJfG8FJkAmk1UGopoA=;
 b=f3KdOoj3PTEQcGBN9TZ3r6vOc2ZMPCvK6U0xwTeu+kdM6oYEj5xm7rdQ9U6EW+1K39wUX012DjHh/HZxmGYdUeU5k0RoBcuQDyTm3S6Aify3u9/y7dZccoo4mlBZ+dRCaC3s0HDfS4zrfPuYX7Y1ocTdVYzEjWFXR4PO9uYHq+7Pbb3GliVVhSxmwpFCnu1/TIVdg8xncsn0YwJA7En9+tIWmU5OM26vy4n6bp0rIBfhIMJ0t6otYSnSy6qBNGAib0fFfMwLzM8lyBgSe1T0OdgeyZFlh8DgxKA1IyAForhhCKHxS0SNHvY+pwo3vOoCDkMJTN09cQdPZVv4NRzaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzM7oGmNAXKt9ZcnTiFTPEbnaZJfG8FJkAmk1UGopoA=;
 b=PcedNrqdy0Wpij1dnWrHqUiz8FzsOAgCff6Zh22MpluF7EGbh0HiDAQFkVGHn7QuT40EEixxBAqv1+cr4QC1Yo+h1Ov9LzDje7lhTjztOgdqTIorohGCcD4feQG75ho0LB/UzCreDXYS9kShCEJwqUD4L294msVystXPCI66ayU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 10:34:45 -0400
Subject: [PATCH v4 5/5] dmaengine: imx-sdma: Add i2c dma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sdma_upstream-v4-5-daeb3067dea7@nxp.com>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
In-Reply-To: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=1789;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2tg8wOjhxhqBB6OjCDOf5puoLCfcQRBtu71Xv9Qv30I=;
 b=LXSSGgqH8US8n5b67XUXJBfdoReehi8kxIDWjaQDidy7IHKOY66hgL1wKYghw66OzIHIRYT8g
 S9p+5c2/021CeVJ+kJkGGpUlTDFHV4mqtoP8r978c+QKGuYeyXg6Zxd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yIHc1bOzm/OZft0yFWfDCkrqKWNkvO5Cec0G8CdgmYtDMPEF5F+bpwK6nD12nwwwsol6YTlP/doacsXaHiyh4KnpHjr7xP33DM63nf+11rZVySF4OrIR+UjlbJ20XTUxFF17F93ottVtpubn1BFkXFaO9SezTwxOaPXDdH5fQAwg9BUYomIiddidy6nkN9RGZbOUXN63u+qkkOvGwZ6Eutk+2Vzzxp5brcS+gFpkXArCY90wpu8c8DmUhqTmj6cr4eZsiYxFBFIxuS14TeQey5egNk8n2amQCG33oDnoqP31S/ePfbi+aUlzw/BqSUfOzDfDeyntzdJwQ2jIRGgZXuPf6WreS4kMXCaGxCLRjFt5DyGmsxa7/GigVpSQGd+mj7OtiNFRsl830llW3Eb9zfStMg4RG21Jva69lAjn6GOBIKAQjyzCJVeHoNLJx4CTDUNTR3+dWopzdUZvtWizlTmOl0VtxmA24PZxzO8YDey3BvPObQqpbsfiGl4mp2oIdCFzbDZFELPuDZ9q5vkpI6P2e2nZKiK/1ZYSH6xpfzHWhP1hPL8lMX6RcO7m/mLGTLHfvkfKvy4Q3LI3odpgjvgP0gAQs0QnmyXgntB/OwXsNhY0eln+0xEL+c+AqIKca0Kvsp/VoGliJnxuaNAf6xRZUEZTWCiIBkp3SCo0pn2djgTBEQwuzcRqGJb8xpm0f2tX3S4I8f3wEo2bQknFWvLFp/sLUPou3uV6A1g/NiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU4xVlBiandJQkU2TzhNVEFUdGtUOEREZXN0ei9zS2FaK045eFV0WE1sQzdx?=
 =?utf-8?B?L01WS2drQyswUWtSWSticzRpWllJa0RKcjhrRDRwdXFRdTg3VzlqM1pWUmpa?=
 =?utf-8?B?TVVGZFMyekxic2NCbm1BMC9pYVFqWG1kUGdhNTBTSlRHbHZJUkZMQ3VNZFc0?=
 =?utf-8?B?dGlUVnI0OXNoWStYMGhocWZRN1VMbWpBaWJRUHhwVDNxU1dpcllvNzFFeWZ3?=
 =?utf-8?B?elRqRVRkN0RsQ1lnQmxiL1pGNVpwMU1LcHNKcWNnM01jYm9HbzZBbUw5Nk41?=
 =?utf-8?B?MFRraXVLNXhKekRVWkswallnc1l1WG9kYWdlUWE0eFZrQ1FHNENPYmZ4RmhF?=
 =?utf-8?B?UkQ0WWRCQ2kyZENDRVlIYTc2c2ZNbmFMbWN3aGcwa0tFaTZuZmlYNW03bHFI?=
 =?utf-8?B?d21OYVJBL1JzdUJadHdFbGpBdnZZb1EwaDBUTFFrNjZBVTkwb2VaMVM5SDgz?=
 =?utf-8?B?cSt0NmxvWVMxZlFhR1RVWEY2SE9oVkNEUGV2bW1BKzB4Q09IUC91TWhWRlU3?=
 =?utf-8?B?YXNpOEtSSWY1amxLdUtuVVlEVFErV0pZcWVWOVlFRkNqQ3pvSkVEVTN0UTIy?=
 =?utf-8?B?aThSSWE3c3dpR0YyT3krU1AvWmJtUUpaNFUwK2hVa3l0QTJIMUxOT3N0bytE?=
 =?utf-8?B?VzVZbHdzUlk0ZkU5TjdyQmtmTDZhUi9zN0dVZFYySkw0NGxjVko4YU1rbnEy?=
 =?utf-8?B?dkt2SEl3dHlvQVVGUmJTV0g2TURWLzZyT1l6OXMxdGpKNk83SkVuUzZCdktV?=
 =?utf-8?B?VkJNU1FPaENiTE5KekdYM0x4aWNmQmkwQitsQXlVczRqUWRvcUc0ZWNnSENL?=
 =?utf-8?B?UGRNT1l5L1A2L0s0SXpCUXNhcUh2b09YMk5xNm5paENQcE9Ld0JxZ3Y4VkRR?=
 =?utf-8?B?MDZBTWJLVXV2dXpROGQvWDZWVjVlZFhlRHllR1BMVUhnSWsrYzUzLzhKa25S?=
 =?utf-8?B?d3pFcHZBNHJ5dlBoZlVDYW1GQzlvV0RReEJMRWtsZWpqSENVeWdjM0ZrdEk4?=
 =?utf-8?B?dDhpVjY4SUkrOHZGbmRVNTBPRlBIT1JBY0VDMU1wVUxQYTMwZ0t3b2taak11?=
 =?utf-8?B?RWxlWHJMWnE2OUtXQW95RUUvL2FZYjlBVExCUWkxRkNDeWwySjNvUG50Zno3?=
 =?utf-8?B?c1plUXBmcm1nZ2hCNU1CSkN4WDljcE44M0twTWlrRlMwVFlVTWhlRkhQbjJC?=
 =?utf-8?B?TmtReW5ZTXJhZUo3RFlCRDR4UUN4aVZLSEx5YTk5OG9LY2JXWlJlbVdLemhB?=
 =?utf-8?B?SW9wM09BcG02SVU2Y2lVYkJRWTJDbEtKVk53K1R2WVpGb0QvSzVsWW9aM3N0?=
 =?utf-8?B?V3RBOExhYWNHUkJ2NmUzMTh1cGl0N01yZlRJUjBtN1Bwa1pvTXNxTW8wYzhk?=
 =?utf-8?B?UjFZUVJsMEMvL3IyVUYya0dtZzZhN3orN0k0NGJqbXQ0TlFONkZMSFh6aWZx?=
 =?utf-8?B?UllrWEFiOXE1THhwdVFCc0FUSmwzNlNsd0RwaDlIUzdkQllVZzFsTkZJK25p?=
 =?utf-8?B?QzcwbXhrc0h1c3ZHSGcrdlV6Wlloc0xZOW81YTNKMWpaZUVEenVZcUE2YXFS?=
 =?utf-8?B?WlNKWjdSSzlzNUJMSEc2MTBxSDlBbW5OazR1QnlmcURjaVdiR1NNVmVGUTBy?=
 =?utf-8?B?ZmFiSHhDMkJlRlBDSlNOVEZFMXhSVG9SREFIYkZOMnVzWlhpOGh5bkUwbEwr?=
 =?utf-8?B?dTQ4SXc5K2pRQ0ZOL0tlSGhyRWNwT2I3RnR4WFoyeVRyMG11dVlubUhZNnNj?=
 =?utf-8?B?WU1FNHlhLzArUDU4T2x4Q3VuYktISVBIZTNBcWVwU1d4YWlMOU1IRHBja3pZ?=
 =?utf-8?B?TnhpY0Eza3JCd09tVWZ6ZG9aU2ZINFRMY1liTGkyRzhJOENZcEZoR2xRWXp5?=
 =?utf-8?B?b0JQV2xBT3RtNGJqaFRxMm5IZ1NJb0V4UG1uYnlzQmhUaHozWmw0ZHZmem4v?=
 =?utf-8?B?c2luSWtFeGtDMllTbk9uNmkwenRDaVJjNm82VG0xSlNEMlhmZGZSeWYxWUNS?=
 =?utf-8?B?dXI4aU1TU0V5R3hZbTJCZ0M4WFJFalVWWXM4RjVLbXRNRmpwYUkwSnNHcWpV?=
 =?utf-8?B?dTRJWGJoTVhpa2tvTzc5aG5JWm5Kb2RObVpELzkrNGx6UGpJVWhFQVBLZEYx?=
 =?utf-8?Q?pc84=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c60f02-77da-4273-f04d-08dc4ffd7c73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:31.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpMJouv7/D34jnV49po4ghvJNRXsAK/6DQCr7/FjPLz1RLlaaljiwPPMT9ujTd8Ab1U3oxaTjEltK0SAI9G/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

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
index f68ab34a3c880..1ab8a7d3a50dc 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -251,6 +251,8 @@ struct sdma_script_start_addrs {
 	s32 sai_2_mcu_addr;
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
+	s32 i2c_2_mcu_addr;
+	s32 mcu_2_i2c_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
@@ -1081,6 +1083,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
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


