Return-Path: <dmaengine+bounces-5256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933EAC2B63
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138201B67CE7
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EE20DD52;
	Fri, 23 May 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4l1+rEu"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7E198A1A;
	Fri, 23 May 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035995; cv=fail; b=BJKIGFT5cZYMkYWQy5cXV/tQ+eNWP0OTuDkC04vut9qsZ/EvgSlDTMOryKZW3nZHOtSklAc22RA1p+IYvcE90MrJC8lLPvKOz1VwN1dw8T/9GX0n/6VK01MB3HW5ZWzO/k8xMkw3Pm/yOmNg8e1zy+1rLamev3MrDKY10LiohMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035995; c=relaxed/simple;
	bh=MNb9vIZHrwcMc6Zb9/itETUkoenC9sINeEMriemAOmA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gD2KNL4XbI3Mk3/fWKg40BUQeozKqOAIIMZmzAU5pdikPB5XRsDm/YY3RKvMflw6bBtNZBNHvZLdRDivild3Nf9i0Hu+wQDQPpIDD0ZbrVElXrY2ytYUcJL77uTgwSe0IwAUPAorkqemvYvGE+Zg/xgviDINFmvum9Yh8IEsKMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B4l1+rEu; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXv9YZBpeWEEOOGUy0bMzQpjShiOBsvUeNBuMgbHOAl/cM/YoSaEl6XVKuq0QnNU3y+r6xzD5jJiEOONL+Njoo+w4C7h+0mqJCvoXWSZfl4LdWsBLUvgez3F/6IhKaqIN/GHnJvBdosluhhg82DghC5beLcc6UtxILzV1BvnAFQ2OKUYfb/LM742qCgdXN6E9PrL+5UvldT5hHudv8EkVeg6wm31zMTEhdlFJv0Tf1kGEgoy4CWaBCUpWhKdRxfmpOcB1vyxT8UqHJosz5tOl2kxxe4f2as04J9+GzHXVS6aeqiUC4ycxo/9OGpcBO2afyeNVIGHc3GmNIEUr/ewUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hiSLDqXF1UzPj82+omXqSrhi3xcDb0z0vvtXkVPskY=;
 b=gHd78kUWcJyYSG/4aVbY8C0mBhUpEfF/us/pafatnrlvDwM2OoGUdZX2CnTV5U8Bo0/VeGcXVk3L3cFW9oxC7/H8ZeBTCRHY+UMTouk9OK+XtUUA3rewtKHuOCNLmHVyMzaW1JJb7tMeX5tPt12yIJfmLkIkej4IABJYYjWn7wTxQ+ohAt6ttmfRI7ZbPS7jEg74m/gzf/9tc2SRVOtu/e0X2P1GntHac98hnWwNiDfJ1pCYN7T0QUJ+0Ip3uQIRCP05E6Bi95pwTVaCyvBuM6apdXv61W+kJ/9yLMo9UJ1StEHVzRjdivA5evRDlQ3HYEEFsPa3mU79MOZAHCAvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hiSLDqXF1UzPj82+omXqSrhi3xcDb0z0vvtXkVPskY=;
 b=B4l1+rEujSf6900clErfp7VXUinVaTXOymex6ZTUbV5GDtl+VO3mAFxusmn5BUMnmvKtZ5E01KlFa+e8NzFZCBCQgAdFMCBOzQ+4fwBHGSaOYWqvjwC+vuJYsYhjzsaM1SL1Agh8l/t0KvFLQG49gA+DZZhZH7NqF4u+jqy0e9aSRN/VF2MjvRSPw9aE/X09tZp+syRXxNsjziQgj5kvFq5gtNgXUCXJrxoTnr4uwEmqBoG6bZlp+mOkPgZmcZ9/fvUfcegYlroYhPNCb7TWOYyecjcXGq5NCtuxoK97jonn+BuFMAmII3mIeJgnSpqvFYE6AZVk23VP1j5ZQw9aOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9684.eurprd04.prod.outlook.com (2603:10a6:20b:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 21:33:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 21:33:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names for fsl,imx23-dma-apbx
Date: Fri, 23 May 2025 17:32:52 -0400
Message-Id: <20250523213252.582366-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: d5140804-9cf8-4751-aae2-08dd9a416a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRKU15IurEjLfHFsjslO3RBYwyXzbgMgoQoy03pF/ecXpiFF9kDoT+IXcJpb?=
 =?us-ascii?Q?0EF7HbjZ5Yqby/8+4Mt299eqS43hQRdKpxrZsZICkROtHCq5/nh55mtW5CRm?=
 =?us-ascii?Q?tHJlgzodOSXn1GNgjJXKx52lDapsj5PRSiJ3IFsxBX/iLR78ARKNFB/gZptm?=
 =?us-ascii?Q?DPHp3O28Ji/0OI2pm52X6WujcPVzaVbcufkvb4fh3JdEuqvTm4jF5NJ1wbMq?=
 =?us-ascii?Q?X4h1h9+RbQ1qXmX1hxWufsTsI1uUyt/qAlfGa8YZzq4AyGEajFThr5pCqau0?=
 =?us-ascii?Q?dIVXNOd9U1ZXHfS2dQDYvQqpzzDuS3WmijakbifR6l4Zes9Ou6nKPKdbR9Up?=
 =?us-ascii?Q?cI6TJlYDG+zOqgLJLMgiqKq4XGfoad2ImPfJKnlNiS7cNfqJCNSs/WVC1S1U?=
 =?us-ascii?Q?/I9cA18zecYz5rgU6p+OsU9REYFhWDubQN/vs4zyNUS8H7+jzd6Ph6jdP1DW?=
 =?us-ascii?Q?evx2wO1uZBOGRtYwp2n3gODNm6q+dcArfnwUWoHj0YHaYHWuH8Mmi+dPBxXL?=
 =?us-ascii?Q?u4N2n6fBz5RGOqTwLTQMdq73xPoig2qiCkiweT3ZzWdwOxhVLAgMabzapcp4?=
 =?us-ascii?Q?lZZA2azd+hNeWXSwZ9yrsL7qvoA8GYR/+xy3F9TuIwJLMudpyL6VEEwug7KM?=
 =?us-ascii?Q?tti5eUNxZwnlI5c7rEYL6eo3WiDy0SJkTjZJ+KUGRDoOQg3euNwhXPVbuE4W?=
 =?us-ascii?Q?ESst9keVADE0bI4VPArF+FpLJDdbfXKQfZhb/TTF1XdIiHekRYNre4TwVLjS?=
 =?us-ascii?Q?0AaL7osunLE9XIdZPXIR998SfkoRQSdyOqOhyLo0vZtvqQgS8Bx/NYr1XEvc?=
 =?us-ascii?Q?EQ74YiwCdCdsCAaNEYwEjC/zcV0V8zZn3qq+9Ky14e3CzXP3jIfPSBxffHry?=
 =?us-ascii?Q?xK8swxSCo4AqratzfK4gFvRWyJ/DVzpPOEKYXmdqDtJgBlmZL9sIQocX4U8i?=
 =?us-ascii?Q?colsw8agbxpD+TZI/3IEY40DpWRiOUtzGzcLggluY4sMkebMNpJDjmyCr/E3?=
 =?us-ascii?Q?NFiwOCRAxZcwaStJq13MDoKEx5+jicJNE65yI/CXVhl/qL/OFR9yp/iOZKxd?=
 =?us-ascii?Q?6iqRJIKr2sWdQNthZ6MPJDHmTH5960N+fgN10l+OmIYdwI8pwTR4nuInQdPP?=
 =?us-ascii?Q?H8ehwlRYVeovwpx9cwrwSgSfWPcIPba5J8ibaz+ybxXeKrWZCswwX6w117mI?=
 =?us-ascii?Q?EG30MJEvoWhAsoODPC4rsosYl5/cpo+oL2uFuKeYj9LOX/DifR1yLvi2B2GB?=
 =?us-ascii?Q?KdG+RNFiDs1NdBSOxd2dsjJyMIa19YM2ubvzqVK3cWX85aeRp7ECXYJq6nQq?=
 =?us-ascii?Q?3UlVJv1oN/2nzA60GZgttC/8RgWkCWeAM5kuLSij1cpMY5bEEmxCOhQDXFh2?=
 =?us-ascii?Q?+5Oi40mgYjAOE2Q/ysl5FSQsuMV0uzh2hk369T2hEe4PQgg3lWcToyZAcx4T?=
 =?us-ascii?Q?VQRV1ssZWqKjrK5pAGNZk2wJ473317zp6q7WxBgApblkSk7EFg7si5S74+jF?=
 =?us-ascii?Q?MHeZB4rmHqs4j9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOTufKHliqZprwPreTtAygmtep59brzUlxB4hswxsNkstO4hcEqqQ0uk8uRW?=
 =?us-ascii?Q?8xGtnAUrNq0rurhvIdrYDFe8du/sUgQjZjxY8KFVJReCZYNixdKPXr5ZeOph?=
 =?us-ascii?Q?RcvS7QRelNC7oSlPf/0bRanrVSBX3eGP+lKZzQBeymIhsk7eXtJv9FXCouop?=
 =?us-ascii?Q?bMnZFwNQPULJ5oRvBOMGzpguvvz8S83nidNE41TKvyfX28PtBwo9kvw/qq8b?=
 =?us-ascii?Q?AHryVNQ7tRSTntS4TAOMi4GGkxQgWgCUtLXbCkuMHiES+clFHbL5bwybp/85?=
 =?us-ascii?Q?BN+80DsjHcmUR3zOeD1tN2K5kvfAUnB2Yjv1xLki36iF6hy7soHUqh5/cD/V?=
 =?us-ascii?Q?7pBfhryfe7yThbZRXb1ogsDCRMN6k8Suy9bBn0jtRSO7SHQ3xNuWWJ4eXa/S?=
 =?us-ascii?Q?Ygg93l6dN8g5BGpFb3VM6VMrawpl07JVhB/AHRbIWMpwW5YtkpHVxzL9P5P1?=
 =?us-ascii?Q?QUr3L6uJrPnLDP9MdEsFS0fZGCMSs8pfWEvB8QE6PHmM39LCkClmgg8Uh4S8?=
 =?us-ascii?Q?uDB//GZM9hKbCfhFzxt71hqr72W/iNm5vE/IXO1xRjeeEBTbtc01m/o8hs5R?=
 =?us-ascii?Q?1Pv0p2eDnzdwgi6n5Fqiu0Z/ZxXyCImzpyG/7xKOvpNZ3dqwXbhIzha096ec?=
 =?us-ascii?Q?pbDhPcqCG5OHYm8rn9SsXqp7aFjdtcW1Q7yPykvkoAGglGEDIA41mH0Izy2D?=
 =?us-ascii?Q?1QvDI4xPEXin6oOxMwRXVbgt0IhYjAdrfdxW58ceUM8Q/6AtH6u4ZrLv1eGG?=
 =?us-ascii?Q?1i8Eu+88pEjjW4WYUCJWO6QbMJwkmNx4yBgMHAVF5JUZImUJdoZON/wypebq?=
 =?us-ascii?Q?VaUMahrrNVmYYiGLvCEVepsRdE8Te7uIzEGuQkdO8pDTyY2iywUyrUcKQ732?=
 =?us-ascii?Q?VJlgX0+NvZ8K3cGjPLF0NanqA+FPyY0OoBK6c5LHIxoaSZnVM03P388uihry?=
 =?us-ascii?Q?7rWo4xMrQRbjabEn0A5pdsHvmN7JsDj5V5MJGbe12pnxDzWeVZcTj7Y+nXaq?=
 =?us-ascii?Q?d21Xi3OKKuUpV3ULOWd+XOPSINFF5VSUnPM2Ja/D8F7ua2Ff80v/U2uZ5uLe?=
 =?us-ascii?Q?cf7KSwgzXqbIcCO0gmeYYrSoTCNkzFIOwlLGxp44TpDB5XeN9W5or6ltJ7FL?=
 =?us-ascii?Q?bTD1XfJ+KLW3jgPXngwndjk+ogiD/b7+mFjn4zLaGrn3Zgj53vmUyUXqVAOH?=
 =?us-ascii?Q?K8451fXJke91LST7g3ZufA9GvO0l6Y5zb2KXUWZGAqgkMzId9Kg2GNTduDc2?=
 =?us-ascii?Q?VGXaIaxNAZw5Wm02CJAcRRTsUDFP5BIquKOuLTfdXP0LGMGfqT3dstgirJ1X?=
 =?us-ascii?Q?Z1Dh4RrsMSM46sRTULbSH29LzAtGMIROdPTe7M7J4Cz5kbqTRWUZOEWQyYLo?=
 =?us-ascii?Q?TMazxx7kYkiDoXranACExBAgLnvb6NxwTliZMPiWW0AZ60uH0ema7prDpzpO?=
 =?us-ascii?Q?Ju2WtO3YH6H3sKU4AF+R1c1gOeaRDSC24R2FEvAPGcQwwa/CB0CV0cZabGom?=
 =?us-ascii?Q?wXyzZzZwKL1U5o5ZltY3sfhbFNdG+1WajfhT/IHqhAd2805eocGA/a7pk1pw?=
 =?us-ascii?Q?0qMnqtIXowZM2x998CA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5140804-9cf8-4751-aae2-08dd9a416a70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:33:10.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym1U5/qNm1OpPrp11vDbPZhozr5OsVF9ilwQWhgRoBmb6mTFuZaVSKyLYUG2rTvIc5xiUdemGaMxwPaBZWffdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9684

Allow interrupt-names for fsl,imx23-dma-apbx and keep the same restriction
for others.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,mxs-dma.yaml  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
index 75a7d9556699c..9102b615dbd61 100644
--- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
@@ -23,6 +23,35 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx23-dma-apbx
+    then:
+      properties:
+        interrupt-names:
+          items:
+            - const: audio-adc
+            - const: audio-dac
+            - const: spdif-tx
+            - const: i2c
+            - const: saif0
+            - const: empty0
+            - const: auart0-rx
+            - const: auart0-tx
+            - const: auart1-rx
+            - const: auart1-tx
+            - const: saif1
+            - const: empty1
+            - const: empty2
+            - const: empty3
+            - const: empty4
+            - const: empty5
+    else:
+      properties:
+        interrupt-names: false
+
 properties:
   compatible:
     oneOf:
@@ -54,6 +83,10 @@ properties:
     minItems: 4
     maxItems: 16
 
+  interrupt-names:
+    minItems: 4
+    maxItems: 16
+
   "#dma-cells":
     const: 1
 
-- 
2.34.1


