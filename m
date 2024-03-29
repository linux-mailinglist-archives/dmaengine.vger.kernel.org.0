Return-Path: <dmaengine+bounces-1660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A0891FEC
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7657287BC1
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16513BAF7;
	Fri, 29 Mar 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K1pOOc0p"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2139.outbound.protection.outlook.com [40.107.15.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120013BAD4;
	Fri, 29 Mar 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722927; cv=fail; b=k9//CLCHPMETYl2Qzpj98hskaUmTUOQxaCUcaBVGtb4KrtYazV9F+HvGxP2XSg1ZQn7pYoZD7Zv1oDOtlrEbZBpnThuv6b/Ia833pczTxEB+jXJ+ApyUYxAYvuralWf+PgzEAwUABrhApfvBs6ZXPfXmUvt1vWVFz5h6++VySzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722927; c=relaxed/simple;
	bh=WDtLyRQI+V5vTiC7LmgN0/WTeCcbXau+vPvX1ltm1Eg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bFYPo8UJVDSWTzD67q3y0mCYBrj+gyy3RIPbpJrvQrZ1V21KUkhBf12YRZ6yV1vSLHMPX5PUHI42WEk5h3vdAKSLDn4YV82ElU8oLO3/tSZS4M6c0130qLa/p3bIwKf017Qy4yHDDNyKK4ybv6pUGYJQzvMmH/bo0g3hUW+ZzF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K1pOOc0p; arc=fail smtp.client-ip=40.107.15.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAcr3kMxi8KcMQ8yh3Hc0EDmj+wqlvqrPhyQtI95T7tX407+ip2yc9ukTfSYNb4Oi8i2y2n+3QXkqYCP9HnHbiIBx5GOIvyeypcyLFGRU6sWSgtNqYMQ54BtnohMJBKBSoOK9LSoq+ehvJt60AVmfdHaXpRAPLURvtkTQ8S25i7uBim/3cqUqF4jGwcMwV/J2qXaw/JYbG6oB+poUs7o6ESfXiNzj6fEj2VDUPdPMexM92/41ZQdE2v+L074u1/oqBgkjy5jOTO5suVlChrL4BmKd/YT9mYkWST4CJrxLZZx95pZrrtrpaZsia8PLQTtD3xUMo3Popju9/1Bjn2o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6smyow8kf6oBw5BBoj7lAbZzkwWsN9AQy5l1oH7+KpI=;
 b=i7poIuEuz3mRnucU18GQmkoMvWoslmu2TUNq0oaYB7pNrldG593S+z+seDN50lN6VyM1wA7RGv/9KJovZzua78YdSKkDzup1bJR3DP5cQVQRY7NfFPmg6uxqV6JGQpwCVVFle8xkkA9Qq0pGJD5E1E1RgJhUMBfCY8U1friVqsbvRpZtL/9A6Wj8NpdmfWfC7KxyvClZPQPz3Gsim53tXdMnIYTJbaF7UxSGT42GPKHyFykr47gsjDium/CAFqsacPm6l9+PKbuxMLPuiKb6y6Vfm27ruwu2u7Tbmut7ZE42PaehRLEUEOFJolwEC9A9BgrHoi9PYeQx6b8HErkvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6smyow8kf6oBw5BBoj7lAbZzkwWsN9AQy5l1oH7+KpI=;
 b=K1pOOc0p0OiRfE5vzu4cK+7AfjiMOAUMF7tvEl757Y8r0jt5kPD8xZuF4jANlAnZIcliemRizczdGDrjQ5ZQCgSYPsZimo9wJRpM2tW8bDB/3CvK2oz4xLjYnHRbrg/AQEwdt4Ed8m1lnZ9tSeAHiGtlkQBOTBMpy0ymRAipja4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 10:34:43 -0400
Subject: [PATCH v4 3/5] dmaengine: imx-sdma: support dual fifo for
 DEV_TO_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sdma_upstream-v4-3-daeb3067dea7@nxp.com>
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
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=2211;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=f/3k48+9FaySkCBcvGuMB4syTNvpqPDE/E6mQZq2QGQ=;
 b=UJ+qrh8+F4HLdPlVyBD/nfhfBula+Xu8HW7enHougqJY0Q3530GMrKdkcu5kBu0U3chz9uJQS
 p7fGcjoiGzjA8EwVIbtgZVUgUPK0f/l6QeShJ1/EhUwCNVJThrTJJHj
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
	dFi84h7XCbk7kt774IXUOufVUoWNpyrpmP8hPWHFvJPiKjkNGx8QYgRuSI1jQCxk8EoKYe4+crMXObmxVzK4GwkiBq5BUqj4bKNSE3ptj2NBq/c6BlI+jLnYgzcTkpFCySwdnwLj4p6uvXpx2jarqzYAxSD9E8rL9gLNhHeCMXm0DNGtx03IAvmeqOIa1xxWh0dSIKRtXZuSiEsUvHVbO9T6zOlqcXUG+u554Y+3WC7yB8vpK0FbiCq1iB3nXCYG++Cd/qR33kjBlkr9Jo+HLmdTtNtiulxd+2gg98xQEzlhW/IHqOmnpr8sTEhqD9gG+mupFiSc/TtdXNwzm5eiL4AZkkIfqQ4SzW78xlqnFYWy+Z4imDh4tclDysOXyOYTE+AOblkcgMne8MlbS0Vl7XVC/vXi4jIAltmhE1z2jjDcX4rR01FYYmvaQF7XWVhbsk8QOrpsIC+dSRRUrQ5ggPV74cO+k3ULfQ6A0JPaxgZkEJm93IzOqum3zINkJgI3D8r5iPLQATAj/OVyTeJovNC+9151reBf86ybMuT58v1EKCsma8iCfkdweKS5z85Je2bxYdVUuSAfyT8BsyslWZTrYqqpBcrz4EWNYba96777btDifR4zbsLSBdgsO23dVQM1De/tbe1RKuTnoPLFNZudItE2EqwQmrC/suRyT9WDlaGyNWfzZCEIFiRiTcMiyIL6uh8FMtTrKWdon/Uk3iaROoy3pIaMe6jCFQJl+sE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUtxWUpsR294ak9oeVdaS3RGbFY2RnJSOVNTK3ZNVXQ0eEJsYnNoYkRkaFEz?=
 =?utf-8?B?bGFlc1FuQlBQUFJlY2FMUGhMcE9WM3BXbzkvNGxDK1ZzWGdVeDRpMXVXd09O?=
 =?utf-8?B?NEFidWhNSXRlSEhpaTJwMzN3Wm5QOTBWbWkxOERyVkJSM2dQV2lzMmozV2Mr?=
 =?utf-8?B?b1VyK3BFNW1mK3krOENHek1PNjlXVkdJeXk0KytPck9jOFFTQjJYbmxOQnhu?=
 =?utf-8?B?OVdGcnVqakxEZmIreU5kSGhNb2p2ZUtaYko3VUJrVWJiZm04TFQ5Zy9LRTkx?=
 =?utf-8?B?Y2tCYm1oZ2dHNDNpVTVjUDg5aFgwdEc3dTJRV3k0MFUrSkl1ZDhtVUY2ZlBp?=
 =?utf-8?B?NVdHNVF4VCt2NlhCamZvQUJLQnUvZ3pKN1FGVndHMzRxYUxNRDY0ZjRHQ25U?=
 =?utf-8?B?bU5iR2FhU0lGN3BHMVNEVHhMK2dPY1VCbU9jY28zM3IrV0FVaDdkNmM2Zkxx?=
 =?utf-8?B?OGd1UjhBT3dhT1FGdSs4UDJwRWV0NjA5ZnBUZHhrZ1FiQVFET3F6NktVcnpI?=
 =?utf-8?B?d1VPUUxtWTkyS0hNL1pmSjk4MDMxWStHYTRwclliSGJjTHZUT2xac0xLaUZN?=
 =?utf-8?B?cmJZU3duWlV5elpYL2JPcUptdHZ0bllVWE0zc1g5SjZjL2JrSFgvZEJFOXcw?=
 =?utf-8?B?Q0hvZ2lZRmg3QXBhS3NNTlY2T3I5aWN1STNXZFFhVWhwakxCcGFpODY2TVhO?=
 =?utf-8?B?MmNTVjhtYWNKTEZSKy9aMWxFdVdWMzZFOG5hNG1rK0ZsVGJmdm5rSlo0SHkv?=
 =?utf-8?B?WU12cGcvZnQvNkRQaHQ3eHN4SmNQbkV2eE9sVnFkMDhCMldDYnZuNWw1SkE2?=
 =?utf-8?B?ZS83K29vMkFORlVaR1lRUm0rYmN1S1h1dGpXa3F1YUlZcEhIZStmT01MQ2hn?=
 =?utf-8?B?SVg4d3RtOWh6Q3EvbHRRQ3hobEQ0QnBXSUI0RlZOMHl3M3cvMUFKVTZHemdO?=
 =?utf-8?B?T0lZcStOZnU1V09nZ1VjNU4vaVhjT1ZGcFlhMUExTUh6QzhsaUtBdWlwMjhC?=
 =?utf-8?B?OEdTN0U3MjVTZEZvQUxaSTI5di9tY3ZGMHU1bWs2eWhlR0NzREQ3RmVpUWVt?=
 =?utf-8?B?cTdmQXFoRmI3aklSK08zaFQwMFZDOVVReWFGbGxab2tzOGVHeSswMlZVdVIv?=
 =?utf-8?B?a1pyNSsvZURDaTgzTUVqQzlEMnVQK21vQmNZTThQbk9SalNnY3F5WE8zMTJ3?=
 =?utf-8?B?dVUwZyt6WnMrZkx0K3ExcHZrSGFLeEErOTNHamJKM2k1eU40eS9iWmpvUm5Q?=
 =?utf-8?B?WXZiQTlBVkU3T01mSmoxb2lHSmQzSlBVK01PejFVdVg3OVhFZnZ5MHNUK2tB?=
 =?utf-8?B?bW1LVDRlMm5ad3BLdWE3N2luMkhWUjNTclBHVkRzeTFZd0F5dnVENThIekNo?=
 =?utf-8?B?VlhmMml3Z0FFdG9FOHBRUitKdGFmb1IreXlVaGlOTjQ5alBuZ0dGZXdKeG5t?=
 =?utf-8?B?a0ZnT21jaXRwVVlVMDhQdzJVMU96REwvWnBUekx3aEo1UGMrUThNUVhncTln?=
 =?utf-8?B?TmFRaUdteENuRjN3Y2kvRHNmYTNzb1FpRmlObWhvTDZwSjBHTytlNnNnVWNl?=
 =?utf-8?B?UE5qZW1TM2d5RnNRQ2xkRjJRWU9rZ1dUaE5zNHMzSy84VjZoVklMamNRWkJU?=
 =?utf-8?B?eDZCa3pFclgrc0VFTGNLbjRkbHhGd2NteVVKNTJMeGlTRGU2RldUdUNXQVFP?=
 =?utf-8?B?N2g0d3c1L1F0VEVwVWlxZ0pFZEJaVGVIVGU4SkpYVVB3RUQwalZ0ZFlrYy9p?=
 =?utf-8?B?VnliUGJUanBOV0h0MTJCL3JiWXhwOTdIVlRRYkRaY1hMN3gvT1BXT1llUldp?=
 =?utf-8?B?UlpGVjQzekFlOFRSdmZzSUN2bkdOb2d6R1BHK29sdm1qa2JVcGFIR3YzN1Rt?=
 =?utf-8?B?V3hiVzBHbkpIU21uakRRR1VCM0RqZVZFUldQR0loREcvcVFWclA4bno3WlNa?=
 =?utf-8?B?MEx5aVVPQXFJYzZEKytpSXEvc3pnc3pJRlYxQXBIZ1hLeWtuQmhsOTgxY0FT?=
 =?utf-8?B?RGM5dzVDNUVFbUQ3bUlYTEVYR1RSNmxBeHo5VmdoV1VUOWlRQnFsTjBoUkpl?=
 =?utf-8?B?VDZVSi81ZXNTUDVtN3FvZVB4MFEydHIxVXd0cWovdEQvK1pNZzVRSFVkNCtZ?=
 =?utf-8?Q?rX3oMmZhtydOmGP4DbzR96RT0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93270e98-d73e-4195-d698-08dc4ffd7788
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:23.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7P/5v9n1NA/aedrJM3ZR8661xxSgjzUB3uQliy8GrIHXMeDuFWHBm4YGH3PImhrjRA3r1LTS8xTVuAfzo0MYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

From: Shengjiu Wang <shengjiu.wang@nxp.com>

SSI and SPDIF are dual fifo interface, when support ASRC P2P
with SSI and SPDIF, the src fifo or dst fifo number can be
two.

The p2p watermark level bit 13 and 14 are designed for
these use case. This patch is to complete this function
in driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6be4c1e441266..f68ab34a3c880 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -138,7 +138,11 @@
  *						0: Source on AIPS
  *	12		Destination Bit(DP)	1: Destination on SPBA
  *						0: Destination on AIPS
- *	13-15		---------		MUST BE 0
+ *	13		Source FIFO		1: Source is dual FIFO
+ *						0: Source is single FIFO
+ *	14		Destination FIFO	1: Destination is dual FIFO
+ *						0: Destination is single FIFO
+ *	15		---------		MUST BE 0
  *	16-23		Higher WML		HWML
  *	24-27		N			Total number of samples after
  *						which Pad adding/Swallowing
@@ -169,6 +173,8 @@
 #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
 #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
 #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
+#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
+#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
 #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
 #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
 #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
@@ -1258,6 +1264,16 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
 
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
+
+	/*
+	 * Limitation: The p2p script support dual fifos in maximum,
+	 * So when fifo number is larger than 1, force enable dual
+	 * fifos.
+	 */
+	if (sdmac->n_fifos_src > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
+	if (sdmac->n_fifos_dst > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
 }
 
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)

-- 
2.34.1


