Return-Path: <dmaengine+bounces-6398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61051B45AD2
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2995C5A71
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BA374280;
	Fri,  5 Sep 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="YnMel/IH"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E69374267;
	Fri,  5 Sep 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083510; cv=fail; b=Pu/gNxT+2AWZPwa7KZWDgy350s3q4fMrNyt63aFk0o09V0vTgtFMiSxGavipSmqwAtAIuH95UpkVB5nmCju4XmdANbqF+3JboXMdL0SqCxrB1L3Wr5rN438Nvnoa/AhXuZj5YuYwXnsKv7yH36s3AQgm02LVZIIC1wibeYMF/uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083510; c=relaxed/simple;
	bh=9tlk3C/WYrlzCEeFS5SUIqUadUoRHFed2hccwh0NYg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D74stg5wtkKmvYbn76jw7O4NujlNNTyh0NdT69oEJAe1Wfps82NPCy6GI9Tr3AUH4AYf6ksFg3/Ql51X1Jk2A3BX8LJ2zuPer/BOL6eJay0i0L6ncwZGcP/wOR66M+2GVd42HUvcEMjM8ALxsHG69MvLGRFamowswBhO1qmJq0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=YnMel/IH; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itaJmJAfuQDg/oMYW5nzKhPv2xWD1PBRRaWd2MR8onNSMCNpIvtJJ51iGG+wVU8YYcwfq0DdFqrK2LtO/AxleiLgCxtFOvR+G/D8VK88ER+4WkV6bOlv98qf4Vj4deSfHK88qfsy3noI7PN2GswY571/I2cpypvC65Rh2VWKlQNC+CZG6m097uhCgibTvC25eTHgF7p8WaLsMacU6qzxP3fD31rbaA5+70qy2mT60FprTGfzDXzxJ0cQz4do2dSUgbQbdWVL6LGrjVgQ2eR9G0EfIUgkaWfuWfjQm33qK1Qtdq28fTQOb2HofGKP2elJ2RLO9vZa3rYG9e46eMzC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F9YZk3fvt1TywJYVX3ZW/FzJX8G5lbTeO4AvAPbAwk=;
 b=Ztl+anHkq7jjLMOcF5CPs0vDWRFqZdn6kEvfrgp8PPAmoOvBs1GM00Q2+aBrNnnYZTd9j/iY7GT3x1XaaYoxDAdRyGWOv1tJLb40mf6s9mkr0OsxYjfPtpQdUh9kGy0IGAawWKlK4Rr2zhj1Y57Raf6m7Pbg1L4oStkEynYa7VkEsdBzCnHyJqwfOvLIgNHtioJvh5bVYoqYnyu506XXwkbmYhnzQuWSiZuxkel2rTluuo5Gc+IRuWxg+cXI3n/mnmOJFObLDZ/tQ3GYOoHC5Jy8dnKq6/yoe1AbzyPbRUmnNzS/SgdXl56FXTYszPOn1z8+CeYHPIfvn5yXb17FNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F9YZk3fvt1TywJYVX3ZW/FzJX8G5lbTeO4AvAPbAwk=;
 b=YnMel/IHabFsroWUFtXt4z7NjVwbsdlLMagrcqRBJHKWYbi0200iHIGutlBqMG2NGlucp2WYpnIoiVGSt5acehEhdylZRBuzQ8wQQqtAAiWcOHYN70ImT1Vb8QZJfvQdJwbZe7ETnnoOJLHAcSr5HwuoRAckKbWcDSM9V5wbw94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB14067.jpnprd01.prod.outlook.com (2603:1096:604:364::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 14:45:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:45:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dmaengine: sh: rz-dmac: Use devm_add_action_or_reset()
Date: Fri,  5 Sep 2025 16:44:18 +0200
Message-ID: <20250905144427.1840684-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB14067:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a693ca-2c5e-44d8-469a-08ddec8acdf2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iw6MpOkvoac55A9/rO4DGIvk7fdsRnDdZPTnpfer8CGj7TxW4UU0A7Y2XyMK?=
 =?us-ascii?Q?ErIrK+OzeinbW9QwJ2yJBlQmzkPcSdtDGAbsGsk49RUBp5XdkA4hSZrse2/5?=
 =?us-ascii?Q?c931DdaHB0uPyN75REeNrCDI+OIuM9FM6po8W8JEGsrthzivReu0okk1Qo0A?=
 =?us-ascii?Q?bZJoZtWhuwLgDAwJh1No3HeLfco4BNA9uuiAyNW8LyjYvJXWIlUTiV7ckAxp?=
 =?us-ascii?Q?JqY0Wwg6YFKm8TNkAQJT/hRlRYai8Oj9Uaqp4FYFfMjvjcZtQRmTE0cj1ajJ?=
 =?us-ascii?Q?ENJ0uHbsay4mwTxjC4UK40MO7PJMWC/nWXSVhNXZsfTQTa0Bd9rCaactUC7b?=
 =?us-ascii?Q?M88n5Ya5i2OJe1MFOA5uSZ+UEJtken6KLTkgYZrav7bcoewhH0nXQosV0MDo?=
 =?us-ascii?Q?ww3MRUcTlELC7urnw1ce6M4CYSKu8L4TInJ2rWboVVWboB2Ol5JrwHkIFlkv?=
 =?us-ascii?Q?Io0paOIYe0FtIFlsleJuw2naEY4N0KsHHW0nYsyJmOd6d+pptdH2uIwgSyNt?=
 =?us-ascii?Q?d9oJru5EMdD/enhiMjHp+sfmD3S6G2/m7Ole2GvgmzztiJ5H8kShr4/GFIS0?=
 =?us-ascii?Q?rEWQzaoyTWAtb/Hmw/oELTZa1udAvTcLL2pfVp2ysV9MfvFo7E/IuserdB5H?=
 =?us-ascii?Q?imx44BnKG6NwBhaSSCfRbSI/cyEUjhsT4ESYAbqVtamzy9+aXGtE/kKI5gWZ?=
 =?us-ascii?Q?tib3H0H74VB3Ak4wVnbH9qbMbjkI4MgitUyQZKQ0JTwQyfszKNUVZS7FqomC?=
 =?us-ascii?Q?neKfsqQIPgcukSM4OafvEAxuRHiCrMK+HByww0Vyvxm+YTmiikCq6V5SvDd0?=
 =?us-ascii?Q?FthoCz0zv6CbN3b1kKC/f8YorlTTxjLGtCClJMtkBTAFN/aRhSBD5dYL82z7?=
 =?us-ascii?Q?5a2hhNcO/Sk2TWrkLdf+PB6IJL8uWVsEFYUZIK1Hp1dhBdoO37Ht86DkIpFz?=
 =?us-ascii?Q?p8s3Rp6gqq1hK349tIkESz+HuVeSKIAyBqdqA/Wi0HEaEYdI/JmFGyiEbnKT?=
 =?us-ascii?Q?WJFQmqAk0v/Td666pbuQxQuRGTyv81ji7Xz1HFZbQ3uIQ000JYqdAGHiNlQg?=
 =?us-ascii?Q?DQo/rIL2raA4qW2//xVfZBmfc76/y5Lg0JOiAnQRz9PyWfbO+nnLtFLE/EUt?=
 =?us-ascii?Q?hIQVZUkI23S1JsVnH27U9w3f0fKASoJZ5a4NFRskLz/qr0Xgl5EVAZ71POOP?=
 =?us-ascii?Q?C8dEmP7Kgb2EDfDRje9Ufk5QcTFjjShCTUAKRyWY2YtLSr0cHP0bT709OqZe?=
 =?us-ascii?Q?Bbv+T+MSZQDU6rcQ1AumFsA7NvsdcIJD97KqQirV14HYpuK4XLMv2PeWVFeO?=
 =?us-ascii?Q?HkkaSBhj/9d2hgQIhVDDHTc2PKt6aDH2OcNbi0TWw6gVebmToVUCn7HNnDxS?=
 =?us-ascii?Q?4wXO/AEmo7ZEGj82rxVb1GcJXpnblX7hqvTC/H/aUac3vNzG+/EySVk4g5FN?=
 =?us-ascii?Q?YJyHJ/BOPFZgjeYcCWXmck8AxurDW8RUqmbbCNNkDLME0bXXwzJYsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjVs0si/1z8xlHcQVkm2MmrkxwPAtCc/kGC2qpoZVdRhS9Ix7x1bz18m+kxi?=
 =?us-ascii?Q?u6yVnYZx//WZ/kpLXp+uhcSGKtNaNwAerdveF4PZh3Gsj+Ahwzup5PkJdA0v?=
 =?us-ascii?Q?DpEVQ54gyQiIAJCJbaAIPWvmkrd2uwfWawnAFWmizUP33MfO1zCJX9zaKfMQ?=
 =?us-ascii?Q?Ffrb0M/n+QlzeQuIBPptQNfurRu4t7/117RcbAqdp7k5+sAeI499j9jCBtJO?=
 =?us-ascii?Q?9iAq5ncOB1t1VKBC4AEt3LxMQG8OEh0qtCX450Cgwle00RJ32QKaQhHu5fdz?=
 =?us-ascii?Q?3eIySAIHRmTF93SQ1jeEY59yMjCplcTw/0Yd+5USqAzHTh8fVTb/WcYFdHw8?=
 =?us-ascii?Q?wtaeqtfaMRsmyv+46IJmjEK16dFiDbc5VbHLuDVf6OkQZksSIa54kiyNP+jr?=
 =?us-ascii?Q?wumAoVzTfwD8FG+pHS7zkr5nJF1ye/YQFefAvtX68IODJHcG389iyqfxapAw?=
 =?us-ascii?Q?o8kYSylkXOgwiaPUOOrZX81uqrAojd83HgDvBWVEZeqhNL8Oqm2QGTNYhy9Z?=
 =?us-ascii?Q?pCU1wPX5x9jFoK+FbRcmP8DOQZxghwAXSQilyVQMcOcH9nDL4Jopgn0pMtbf?=
 =?us-ascii?Q?150q47bxhBy5LWqLPnI3QuFm1M5yemFX9leE0ovgSjmjnyPN+UJtRuNCTaMA?=
 =?us-ascii?Q?hFrR6sje/Dhpsb/i+LdMKSewK5h5tR2xoLJxsN5YVocK2X/LvscqWcOXOEJ9?=
 =?us-ascii?Q?0oTViYUlGHnSlsXCRQTXOLmMNMC65U3ayziNol6A1QDFZaZHppGTc3IVwa9H?=
 =?us-ascii?Q?emylz4t0WhdOpZ8QgbK2xuUhf5VFlO4gsIIFlebjDplihnca7liYn4HbBHUN?=
 =?us-ascii?Q?gPGPI7ENvIaUjvsyW+zuNXrZyzoz5EHJnciXkkPp+IEiX3BUCoSzDZGvriYs?=
 =?us-ascii?Q?fBG6iInTYZLYY1f9I7ACxrYEYe4WHl/YfcJPB206vn9tJFKk1Jaw6s7IhjDt?=
 =?us-ascii?Q?KImbPtkb6W8syizb0FC1bV03vVvT37OMIcZ0JXtFombnDf655S6qnYfwd73Y?=
 =?us-ascii?Q?ViNoSwEQdBrfj1pYfk4AzRwd7IQZbtARN0unbzk3fSTlYyhdlrDVi+mw5Qfx?=
 =?us-ascii?Q?Hl7ofWlTlScwLx9Uw5fW/KM6hS9dku+1xdSumbCvDcvovIkCzrk2H0Fbg3wS?=
 =?us-ascii?Q?SShhM8bJfWKCgaBOqmdxR0P+bzyfiJf1HogMZaHGGZBz45W0B/OGv3kh06AB?=
 =?us-ascii?Q?/hbQ2LuE6KzO/h9goODGF5o3eFGwNjaX4LkVuQNDducygLA+tj4/0TrLf7xj?=
 =?us-ascii?Q?tNxpTzSrhOEiknA2SNZzlOyA6P+f9b/IDzN6SpdNfqQw/u8kLCtPueY8b6ZV?=
 =?us-ascii?Q?Fnky2fnEFVRMp+UWK/CUXftK06A02bFKEJPBhBz2jQk7nhLSm8lLbpWgmVbp?=
 =?us-ascii?Q?0O3SIMSc/nkWe7ZNF3U1OaI9pgsh9zwppGZN/bvUB64lYQq/fYQFYam505ei?=
 =?us-ascii?Q?L7Eqlo+gFYf0TM+sb0pscW7PZ2U9y1T3Jndh4ptXGOfyBHNk+gx8TmGpqGIk?=
 =?us-ascii?Q?sc/M/WZv3BHkikEcuUk745wOIE1PUGDFwIlcTAtHEgqy3Lluvy/3rorP7Xtm?=
 =?us-ascii?Q?N3nyc8Qbmv36UsHuo+1s3o7LP1KuO0Wn+1PPHS8ygG8jDkU9ebbaaJ7qTiXp?=
 =?us-ascii?Q?hSM17RuODxeT/ipWJArrAMc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a693ca-2c5e-44d8-469a-08ddec8acdf2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:45:06.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMVmpk5DefYKdkQdprUKxM/texD5e3yjI6jLotbelFBFTxUDlkTYlkKptI/Ap5o+f55k/GY57/e/Ofbm8XerPXxMCzTUdfmklmzORLusWLNhUsz9mtrX3B1jaz3GYDBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14067

Slightly simplify rz_dmac_probe() by using devm_add_action_or_reset()
for reset cleanup.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0b526cc4d24be..0bc11a6038383 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -905,6 +905,11 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 	return rz_dmac_parse_of_icu(dev, dmac);
 }
 
+static void rz_dmac_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rz_dmac_probe(struct platform_device *pdev)
 {
 	const char *irqname = "error";
@@ -977,6 +982,12 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_put;
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rz_dmac_reset_control_assert,
+				       dmac->rstc);
+	if (ret)
+		goto err_pm_runtime_put;
+
 	for (i = 0; i < dmac->n_channels; i++) {
 		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
 		if (ret < 0)
@@ -1031,7 +1042,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
-	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 
@@ -1053,7 +1063,6 @@ static void rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 
 	platform_device_put(dmac->icu.pdev);
-- 
2.43.0


