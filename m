Return-Path: <dmaengine+bounces-1426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89E87F167
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52189281E7A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078C5813B;
	Mon, 18 Mar 2024 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WxKQ1cB/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB458101;
	Mon, 18 Mar 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794718; cv=fail; b=P6URA7f2GPc6EOmQHM5hwWyJM/WV5n7Doa4Wu0IYCwoblRE0DHNE8/+WDSOp3JT7P3lHWsLA9sh1eV+G5JDVclC4jBBmLmW6cOQ1b3y7NKCvvtiMsYs7mOSme5WkNi3AtrH1ZLi4WQey1jS1JbVtKq8FUe21Cuj5dyjZMc/p5mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794718; c=relaxed/simple;
	bh=pkEVvWOsGPC8GRmMAKNJcok9PfGzxBg+simpRDnERxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VhiomeZqCgk1RikemEUQbjYA0NdlUsuduKCqAK7N/KWLaQuRsQuNx0ylgaSrf4GEzTodHwrfHpGzFrFjXBdXTdaOryoMWBUhorQwtIMbnVbKgIQB9SkmlTHKKWS5Jcw6kaVTFcDqmYL7emci345Ig/gEfvQ+4pYsNsLWTxPKCfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WxKQ1cB/; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6fJV2pk91+js9nSZcT0wVsTxJEawcg/ggyxt3ozT1WEIemgLbJZ6FQu425YP694kFAWZBXE0cwYWc20hnLjGVpR9uiGGKC7FNXTjZ+fw64WAQY7EMT9S68eJQ2q45WmkmNe3qHJr9a2znWcrEUu+5/5DsTpVnj44mGPt9NaRxm8e316EA1f0GJmYLBzKGLqidW/i3/mUThiAQrjlhM8TeRshwzJldRKESi0U7+FpyhPqHMVKhEjePJIzpub/hQ3vsrRGjUTmgxq20fBvfzsZtoylUJFFKeVWaJrXMppArrdgSejxRdE4/slvSNiMVrhN413zWOYULoPxEqNKX1T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=lcTipwbPORX+GjqiNbgPnF6js9Adc8Z77I5kHBttCqwfLgTCEN67QGfIEMyG5Wp7xpzrhMRwJEupSxrwAYpLBJ1HsyfrQz/QggpTfW45Eg17eQ7ryfoq51jE+Vq3/4esqxH09adkuneFFSbiioqGJA2WfwTHubzh/K1WCa6XTbg5LnGnfktkCAUT6b/Kk8SQrG/WdEy47BAMJKZbQj5GsMN8DZf62O4gv0lmEyQg6tlsX5GXclsrQsJsFgW1NJiOwiH4AO9hJh2sd93yEzR2tqdEoBRadlaVzkx50IxZHxceIgXeaP+Bd3TflTcghR1sSTSdppGOoKx5jk2VSj/ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=WxKQ1cB/n9KCJi955lwiqlvdooNc952OJGRkJyZ3zCeDG5foTZpgwle+yQgwWyUIIbeWvgUrEYrr9+nIDEtyxzv2qrtqRuB8A9crWkFlVecr53ETupuzYDVkyVUZRGMgIFjmKSqAEzUHUoyL+BjN+ztNh84tfkEHR683DUSs1RA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 16:44:34 -0400
Subject: [PATCH v3 1/5] dmaengine: imx-sdma: Support allocate memory from
 internal SRAM (iram)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sdma_upstream-v3-1-da37ddd44d49@nxp.com>
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
 Nicolin Chen <b42378@freescale.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=4382;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=35WKrihwsy+0gjRgHH1219vF/6YHpbFAEnJbyCUA0F4=;
 b=JPP6OeI3EwXu/KPXP3csyUsmZs4FQNTnM7V9K7FaD+IU3Lfuww2lLtULPg+OXFkfw0Ro6bR/C
 TSAWxXMLPoIDsRxCwiua35DsxcjdZ1tdUAyKyvAR5obWjNEi4sne/8H
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
	57knjcN3Hvv+wGq/xBDl158HRc/8JQawi0NvdK5Yr2DtDHWs3GtefVZI+VaX4GCmfB5nCIoki5UUy+Zb8uED4JFB/8QT66aGGIUjDacLa8m256VFy0IkWnTal/piLQUpyutVbWis9P01EIx3ABfb1lNLW2aNV0ftd6StFhGC8vJWWFgBvFnNew09vNMOjGQcm3EsnM2YdHd6HHbuxEwQo7FzDaPF/lvb0YNY7JzeIQY9f6agThRrXWkeZ6Jc8e3/B869HEDw6GKIFXbsJpYqsts714Tk2OjRBJDbbSAHaehIWWVrZSzvl5H6HHkuHC6WIuARATNRuAF1rewpU0DS43No2gohAwPFdLXEMkV5qjMc84Gw4u3zOBGnW7OXQ7fxioWfpaiP+JiEJiOnAm63Iisviq78uYgkT+LZ0SPJSNBsDk431T615hyl1jhmBMkazlDWUIYnM6LbkYwZXqr4cFFmK3MoRU7vwKexuJB5GpwCHMPJ2DhYUY1sj0vV8pNG81DI4+PtIPJEKS4zBjqZ/Lycus2uCne5EkPkVS0VCCLSlwuEivfduaiRKrOCklK6QGT8BMomlzMud3IFiaB5MIgUaaA1dBk76tl/EZ3RG5m7rurkefZGX7aqSsMUrNFFpa0crshVmJxvU1SUW8s4npgjwZkBwGqw9jkvkQEG73BxUoK3Zuj1BaNHmilGPJ7yz+imfWksv5DYgC3YmkVgeFkzUFL+tQ/jZRAvwY6FXvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZyT0JJNUxaY0ZtNVBvWVF2bk9pU1pwN3ZvUmJNbW5UaVdTc2JicEJLSFN2?=
 =?utf-8?B?MjRROTJxbmtpZC9RUGQrQ2phR1A2VTYwdHc4Zlg0N2E1RFFzYmxoTE5DWkJC?=
 =?utf-8?B?blo2QVY0d1BIeG82MGpKTkNuVGJPa1cwY0o2RkhjNEdmSkJQblVCQ2J5Qm83?=
 =?utf-8?B?U0xmMHlOVDlJWHM0bFRNbmdleWdiaXFNMlZ2WWJvTVNoNE9TaFo5ZGxmRXhC?=
 =?utf-8?B?czhPaHZ3VElsUlJPMXEzWWY3OU4yVkpxcjFaUFV6U0pjaktWRUxpQWZPN25B?=
 =?utf-8?B?TmRJbWw5QWltcUsyN1M5TFlPalBKcDlhNjRpY3RPY3JOSTlKZW9pdnRsdC9h?=
 =?utf-8?B?ajcrYjBKbU8wSHhxV3ZkeHZzWWd3eU1Zemk0dnhPeTlnd1lWNjRRQmJkeXBl?=
 =?utf-8?B?ZFFtcGYwODRpU1N0UnlmVHVYR3dFRGVmR2gwNVE4VUxlYktnNllxdFE0RFlt?=
 =?utf-8?B?VGZJam5DZWlGbXBjckhOT1d3L251MlNURmxvN2RtTnZOc29YZnJncFI3NmlF?=
 =?utf-8?B?TE45UkZvaVpHMGpUbGY0c2h4RC8xMWk0MnhVWnBzZW9iemJYa1dWa2JlV0Vm?=
 =?utf-8?B?ZW5mMGc1SHVieGJkYlVDNUFuTnJ4ejd6RkpPbmV3V1pXWE1jV0c3M2EvVU96?=
 =?utf-8?B?Y3BnNGgvVEo3d2JZWlR2VTE4V0pCODN2c1Yzc1h1UlI1ZHI5OXI0V09uM2pT?=
 =?utf-8?B?NUpyMjRDVmNSZXNjZEtEemVtK2NUbmUvR2YySUhIek8zMllNWTVxc1drcC9T?=
 =?utf-8?B?WUJzMXRVYncwZnAyb05PakFPUy9jMWRudlI5SCsxKzkwZXRiekx5czRxY1BX?=
 =?utf-8?B?ZkkzQmc0dzFrcndUMlhuUW85SkVSbHNUcXZTYXpMa0lDY2RiMnJvZVFlQUhy?=
 =?utf-8?B?YkRzdUhjamVOOEViMzc4eUpmbDV0RGZ5NXZwOGZTZng4Tlk1dkdxL01KcGx2?=
 =?utf-8?B?QVlBMnFVUkt5OW80TkhqcWJmU3BOVmg0a2lESjBaWmdzSkZXcWJIL3pBV3RY?=
 =?utf-8?B?OTFQZHk4bDFyUHMzSEx1WTdrSHN4SDc2elIzWkdML3A1UVE2c1J2UDFwYmRn?=
 =?utf-8?B?YXVQSDJTZmloTW5vNXhYbThrY2U2bm5BTk1PalBCQWM5VTZHRFhnMWZDbDdM?=
 =?utf-8?B?c2lobjhLWFRWNkdHVUlBemVzUDMzTXhSR2J3OS9uT2Q5YkVuRHhSZ3Z3YWhZ?=
 =?utf-8?B?bE9xYU05K3pJbWpOTVAyNHVvd1hzMnIxalFjc1ZTS1J1QkpRT1k1OTRQb1Fv?=
 =?utf-8?B?Y3NSdHBra1V5Uzh1U2pSWHZiSW85Uzl2a3ZiSTd4SUppMUNYUUMrQ3lOYXQz?=
 =?utf-8?B?bHdJMXFFUXE2RHU3VTBEdXVha0RpUEF4MG14RWJpSFFYakE5aXh6b1dkVmNu?=
 =?utf-8?B?Nm9XWWFRbzk3NHlBWStRZU1Xdm1wVDk4RFdRUzhDd0YrWE9TMHB2YTI2YVN0?=
 =?utf-8?B?cTA0YW8wcitSYU8yTVpKVHlUVXZjcHM4eU9LTDM2ZHEvVEE4S3h2OEs1aGE1?=
 =?utf-8?B?TVZlc3VQdEdpeWZvUmxvL3A5T0JoOFBkamsrbHllZ1Z1RkhxeUxPV0ltYzhs?=
 =?utf-8?B?QjcvMDk2RVI2Zmp1eXR2RzlkdnpvSDM2RDA4Q2pVRlF5TFRlbmUrangwUHlG?=
 =?utf-8?B?OEQ2UnorS3RkOWx4aFlKd1MzNjFmeklqTTgzNkpLYW91YVpORkVkeHZXSlg1?=
 =?utf-8?B?dERXVmV3d3hUMElDdHFUZFBjL3VFQ2ttNitUQlhhTUNHS2p6SEluUEhXMnZU?=
 =?utf-8?B?Z1hLVyt2SkFvdkRCc2RkZEdsbkhqSUpOUUFYUlFFQUQ1Rk44WlZPUmZ6Sk1R?=
 =?utf-8?B?TkJ3SU5vdUt3ZkJPTEtkckJVdkhNRVI1cTdEWHB6TE9pdTN5aEhYMlFLVHhn?=
 =?utf-8?B?WjV3UVRWK0VMTlZZQ1hnMnJ2OWQrWCtLTDZDems1QjVIRGhZZEw5alllY01j?=
 =?utf-8?B?U3A3N1lJajVyVGJjSS9jMElMcTI3dHNJOHg0WlF6SWZPbzY1YXBpUUozMm4y?=
 =?utf-8?B?YThVTkxibEFGZTF1NWRNRkFoS2RDekhwU2tTOG1OTnpIU25jOGQ1QVZCWUta?=
 =?utf-8?B?ekhBNFF3SndDUEs0bEkxNmNXY0NKSXExVDloVmNMSHBuTkordzhTTEMyWkla?=
 =?utf-8?Q?DOWzXfym3MkyZbRPT+kesy5f+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11e3bbe-358f-4d00-1acc-08dc478c4f48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:13.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwPNfbHV0EHJH2cEbPHQNiRpg6NK8yHCg96rnZ/pg+4jLsJyh27HB0UHbxk0BH1So+3C0kBAE0D/NP/rc/A6xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

From: Nicolin Chen <b42378@freescale.com>

Allocate memory from SoC internal SRAM to reduce DDR access and keep DDR in
lower power state (such as self-referesh) longer.

Check iram_pool before sdma_init() so that ccb/context could be allocated
from iram because DDR maybe in self-referesh in lower power audio case
while sdma still running.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9b42f5e96b1e0..4f1a9d1b152d6 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,6 +24,7 @@
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/genalloc.h>
 #include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
@@ -531,6 +532,7 @@ struct sdma_engine {
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
 	bool                            fw_loaded;
+	struct gen_pool			*iram_pool;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -1358,8 +1360,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 {
 	int ret = -EBUSY;
 
-	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
-				       GFP_NOWAIT);
+	if (sdma->iram_pool)
+		sdma->bd0 = gen_pool_dma_alloc(sdma->iram_pool,
+					sizeof(struct sdma_buffer_descriptor),
+					&sdma->bd0_phys);
+	else
+		sdma->bd0 = dma_alloc_coherent(sdma->dev,
+					sizeof(struct sdma_buffer_descriptor),
+					&sdma->bd0_phys, GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1379,10 +1387,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 static int sdma_alloc_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	struct sdma_engine *sdma = desc->sdmac->sdma;
 	int ret = 0;
 
-	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
-				      &desc->bd_phys, GFP_NOWAIT);
+	if (sdma->iram_pool)
+		desc->bd = gen_pool_dma_alloc(sdma->iram_pool, bd_size, &desc->bd_phys);
+	else
+		desc->bd = dma_alloc_coherent(sdma->dev, bd_size, &desc->bd_phys, GFP_NOWAIT);
+
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1394,9 +1406,12 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 static void sdma_free_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	struct sdma_engine *sdma = desc->sdmac->sdma;
 
-	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
-			  desc->bd_phys);
+	if (sdma->iram_pool)
+		gen_pool_free(sdma->iram_pool, (unsigned long)desc->bd, bd_size);
+	else
+		dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd, desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -2068,6 +2083,7 @@ static int sdma_init(struct sdma_engine *sdma)
 {
 	int i, ret;
 	dma_addr_t ccb_phys;
+	int ccbsize;
 
 	ret = clk_enable(sdma->clk_ipg);
 	if (ret)
@@ -2083,10 +2099,14 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
-	sdma->channel_control = dma_alloc_coherent(sdma->dev,
-			MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control) +
-			sizeof(struct sdma_context_data),
-			&ccb_phys, GFP_KERNEL);
+	ccbsize = MAX_DMA_CHANNELS * (sizeof(struct sdma_channel_control)
+		  + sizeof(struct sdma_context_data));
+
+	if (sdma->iram_pool)
+		sdma->channel_control = gen_pool_dma_alloc(sdma->iram_pool, ccbsize, &ccb_phys);
+	else
+		sdma->channel_control = dma_alloc_coherent(sdma->dev, ccbsize, &ccb_phys,
+							   GFP_KERNEL);
 
 	if (!sdma->channel_control) {
 		ret = -ENOMEM;
@@ -2272,6 +2292,12 @@ static int sdma_probe(struct platform_device *pdev)
 			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
+	if (np) {
+		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
+		if (sdma->iram_pool)
+			dev_info(&pdev->dev, "alloc bd from iram.\n");
+	}
+
 	ret = sdma_init(sdma);
 	if (ret)
 		goto err_init;

-- 
2.34.1


