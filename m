Return-Path: <dmaengine+bounces-2942-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B095CA58
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F5D1C24657
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5018754F;
	Fri, 23 Aug 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fZatAWIq"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E518733B;
	Fri, 23 Aug 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408405; cv=fail; b=LqjX4ruXDseO8jBbppQmgHUk6sidWiHIzCBvMVbUY+FLZGhAWnci63vcjgkMqgDiGSwvrl7hO7z4/19MoMSLGwJ8DmRp5IMGqLYSsmaJp1HNJNajRPqe15oLbKC2gNIgCk4spnAScoiq8av96X5/7azigL+a+4nCrtKViLrUoc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408405; c=relaxed/simple;
	bh=we5xSqic5G7n2Fxst0d5xu0pVOm0xzDz5IoO93tpz1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aX10f5DXNDsMl+Xbe8mgg/uf2aGbdZ4iU2cU8qLYY4LGhVgdA9uMnyfUflV2j4cEiQDKzWx+4vGluqesclKm5btRTZOyAg1rUuvlhn1Xsjo4VVsNn2I6GFOyWv7CpeL0MTOSKvAybZxBQyildHsQ9+qlfDeYaIfC5mWMtx/0Fyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fZatAWIq; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3PGVcbrHARtR7HniaR+T+fot47Q5qA1Spbutqdq503HXTphLbSAs9FDK1iFVs3R1+W+T1vwSpkv/HBrkFgDdvP4BJYfCXYZRRm0uJlHAmnCh2mCPOEEvexi9p5PGZFejTNTy31k2WBYR8uhWPJ3c6tyG0Fpwf9g+KdNZz+h1FBUdrm+1tfMisW3Ori2b1ycdFulrymuMWVoZ8Ixu8RW4pfi5r7JreYHIaq4RYkc/VIwvU+v9GN4/J74/NdAjpkwerLmyG12hWzVH5bfHti3RrY/5ipmkDT4z/9oxW9UIbz2QSNcaUTGXTKF7aOks7a3hB+Xso01sk/6VMbxzgFFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CBKzRZVhAfE1GGxYtmoT4zKcdXQrw+66XZhjdFdUlc=;
 b=DU4CnnlnszKEo3VRoejb8NsisXBltw1JrPewl0rw0GgAYS9Rxnj/GjSgItPt5zK5b69LJPQfixcXLyLZioDZByjnUAJiC+FPZmX7QlydzkI1uTCnaKIyOeY4m+nkxMVDid29R8eDPZdpWJec8yEsKhOZji3HQOTYC4CMIUkgwF+fB+kXgFOOEaTYOaW/736N5srrouPnSYDhqnWKr+yyMkk/lGkeXeRCzLhquswG1JsZM/pIHnJ3VxyhIsWC7T+0UZuoc2tBCS7HTi6lN92tMpFkfWRWltm/gEADYOJsOTpIg+mAVMY+YWKVNqXQo/xoSXQ41m8SJTiELF2qhwXAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CBKzRZVhAfE1GGxYtmoT4zKcdXQrw+66XZhjdFdUlc=;
 b=fZatAWIqgzWUtUFS2ujLUuxKhB6n6XSHsoZoYRVZkw4GECxVwiwExhNlQlv0k/8RiXBLvcCbvCJ/q5aYTgD6FGY7403mXK4D30Q+40dmpA9t3Blv2RQAyaiU6zuY2nXlIotXHQwIk/lQVGeH9xlnovPSeqvkcQkuatYq8xdd6f9dD8fRq51sXarLp6AQGj8F7mtvTWOyOXMUUXlNF0QPXNh0C6Ab9zuOf51JxToocv1t6t7VYoVPb2MDSvVPvU+MpbecG3j8xFys/RjX0oLEa6Ci3jW1PUabV0QDaNK9COz7zq1B2JRdNuXA/fqHNXotdyRPE6ZVgXUBSkOrQWGtmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:20:00 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:20:00 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 4/6] dma:imx-sdma:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:31 +0800
Message-Id: <20240823101933.9517-5-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-1-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYUPR06MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8c3c1a-15f9-4031-bc9f-08dcc35d254c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TythpMkZUEvTaCK4kaDCEFE890PV5LPibumqqzlvdJpgCD/uPCw8XGb45FRx?=
 =?us-ascii?Q?5GEn2HOeaaKZyXrStHQLE5xUZo0WE1XW2jzdoM4xBh7cfUn5CSW3nQzuasUs?=
 =?us-ascii?Q?/lmDhB4WgepCmS2K7jRCSiYki+KRpj0akEGVxUux2QDKO5AFRWydMCJYsP6F?=
 =?us-ascii?Q?xMOtvOlIGfBWLcZhwEYJ/JvfShOYSTcX7A9tt4/tXJRoizTddp5Wd5qMYfoY?=
 =?us-ascii?Q?WF4n8dYTWadACEGfC7B+cOz/KMafx+k3ZpCOyVCcKohhUNMn7Ro5/fwTjCrE?=
 =?us-ascii?Q?KX7SoKBYou8/s2D3huW48CnYM9byjAZkMbrTS+8lERY2VUKdlX/p8+XB14tI?=
 =?us-ascii?Q?NlZI3Ol6gr7glzyzTV1bBel6ay1PZ9pR3G1rFPwlYW9XvRFQnglu9KYv9Mto?=
 =?us-ascii?Q?6tgvRL8GGXtXOI+LG+QV3A2nBUkKQzj+3S1OMFeftJ2QbZS0c5ZhFUh9qjCV?=
 =?us-ascii?Q?D6V9Suyhwh35lhBrMsqJIxZHhZtJfKqWmGQNDYBFpmGLezo741jPP+KXfF42?=
 =?us-ascii?Q?ePnFrDGjCClnnTRjXDC/MxknLQZBseJkrltAxSIBx9B2KGycnbMUkExIvw7N?=
 =?us-ascii?Q?83U5cggN0i3ZY8sRNDep5t0AO/lqod2y5hDBidtNX29+d9ZesfXHbRQ55A7B?=
 =?us-ascii?Q?LmPSg2Z9byI4szzjl4m+EFdCSea0pOClSpzxiWylqkvehV/qKVoPNVuMNDaV?=
 =?us-ascii?Q?pG38nc2qxVMryzs9uey78qoFbvr3MoujNSodmdnPQK5PrAuMYyDgwNIAMIAF?=
 =?us-ascii?Q?e0jI+N1stgfcY5ICNAR3Ky5QQYRM5CDvUB+ojhiVWWexgRpOjOZ5KU9oJy59?=
 =?us-ascii?Q?/BadcW+Jk/mGhMfykrn6O+wC3moh1dlyUGIxAPUKL0dEz0dAMkKnRfkG1zJ1?=
 =?us-ascii?Q?C49mBtv0nOMXZMSTmm+/JqeNe6k5JSyY6uJ9+SIpiRo6gyBXsBESlkkfjX0a?=
 =?us-ascii?Q?ZJsRi0FhwMaLkEEBU1SP3MSYDSBHCa6sZK2VV6v8DNfAGODoSjji/UpTsIKP?=
 =?us-ascii?Q?GO1q5qbRkF0LNympCrJsXmzD3Iko1tleKcV1et27EXDrcpy/E05F0K5hyiXu?=
 =?us-ascii?Q?vTzRvX32SteUYLa83jGkDsSGoLQz4PsAK/x/x2u3unz8I643NGcyhNCIW50l?=
 =?us-ascii?Q?PD4uyLUdj3h5+8FaWhFC34l8a/4I0cpP9VzwGB+NeM0ndHlmiCcasH5fs5VZ?=
 =?us-ascii?Q?0EuFkeH1zsp9KJ4L5jDfU6rh0Kpp/93owHKbBonDwzjZPCIJQGvpwskVuxQF?=
 =?us-ascii?Q?Mvt3/+nvezhrzgFjCwS0S8BoPlIUfPNVIsz1i1poNR2E2TFwQ4K0+lOEeL9H?=
 =?us-ascii?Q?SnqbaeWG7NMfacj2tggusJLDpdcgLFb2sxXGgWwurc1E4v029FliHY5ewMi7?=
 =?us-ascii?Q?fFX0F72LqA6dzdhSb8CVtB00SX6QmKlvW4rDxBOp6DE7l5aHFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tq9QgQ88NMgWv2nvbh2V2Kxz6o4Er18bTAMGVHdm8eUyJQ9d0jPR9YJeYulK?=
 =?us-ascii?Q?iyX/BDXS69IghbimFgoKA2k+/FTJG3mkUDhJKcEgZ4+WDE9OGUOWFI/EQUWI?=
 =?us-ascii?Q?PkKHdtyoLEmUf+7WG5bQWtNuxVyRz+qqSmIO4wB0oduNZlnBy50v2u5pLwSh?=
 =?us-ascii?Q?9ng5fvG3MAAmfi+uJFEZSC0SUZPuFWX0yFGKbnYMSpNy310ul2vFlqCIqMeF?=
 =?us-ascii?Q?bBUdWYZpX9ycjZ3VmP0VetDwn9NSRcy9HLzNIa6CybeqptZEZFxtNBDkVIyJ?=
 =?us-ascii?Q?RXF9yPxFUV9d8cp9sjjWk6wuWNvVqyuTFa8e/W2Fbamhi3BZUEkk7cOCucyx?=
 =?us-ascii?Q?KeRyks/Htrcq/JMOe/ghbUAqbhDVhPbxEzhavtdQvlXk4j948VvqSD4+c5tm?=
 =?us-ascii?Q?sHynqhdRHJRSKQYodYeA86IPaEFZPje/iQA5d/KXQaklC0xKYY9AlWV7xmRJ?=
 =?us-ascii?Q?6mOenXftbdb0o5WlnWWNGwObAKRg4rBHLQ89+yudM4KHCjN2ujdrsE0gsu/S?=
 =?us-ascii?Q?WaflCpS+/4j1BUTG6zusrehcecWdMRF5avovpRmK8YXEfbJgGoD9XaORkd0r?=
 =?us-ascii?Q?Y6/OYE3Q3yJqS4lapu4DTtXCtxLLRNlu7vNNPQNpeW5AuAa5Oo95ui9sKNIB?=
 =?us-ascii?Q?A+ybz5Qv161mQ+/GSEVw9QChtR/n2ccKY0OdtajC5mf1V8U3GYQJgpBvQzRO?=
 =?us-ascii?Q?8WMRMM6QefnPwqLsXOW7dKzROENEnJQF9m2PZix5/yfODUXJMh4Q0GQHKepC?=
 =?us-ascii?Q?+QkdQxBHRXaBh0Q//bR8ofEWW4jvd27x3cW/6dFWcG9Nm8sCmuyVh0LbyUXz?=
 =?us-ascii?Q?eN9Atf7qjxdB0Pue6wcTP4L1rhYe/ATa42MoBYZqFPaLvvqU724dg1KasTrJ?=
 =?us-ascii?Q?6c1U4Qa4gsMAuMyDde6eIKsGT7EcQDEa/DspEwy8+mi7V+BnBzLTb1+y4B9V?=
 =?us-ascii?Q?Sk6lR7FhPnS7RTvPiSaSiIOk/zO3WzGop8ZgZMaIHeVbS/Z87iC9rUIu5A/b?=
 =?us-ascii?Q?qZ29pB2ft7LDxzR5Jbe/IFL7ZoA9ZhGMtak94M35V329cmR7H+o7nZSg9M2y?=
 =?us-ascii?Q?HKzMdF3xabW1Y04l1TDFFZuRWjP+Sao4x+XMb6djKghtxyZ3kl1As55yj9e3?=
 =?us-ascii?Q?JZSQ7tu4AGSPl10GeGyxYZlFfKFn4bvVGpq9iY6qXq9D2aLWVMTRD7Gng/bH?=
 =?us-ascii?Q?qovz31WREk48ngtS0T9NY6+igP3xfPX+nGNwJARIDyRUVX3+woMjtbTjCq+I?=
 =?us-ascii?Q?s7VGmi6M6C64d4exWGYUycNSFrqpOsRROl39Q3ggFMIRQB2dtPPScdC44p+F?=
 =?us-ascii?Q?DEMHRPfbRyhHDyFAvCnhJOAjE4VNVoGSLd7pZASG7FVadE0HMQUcIqwrVGLT?=
 =?us-ascii?Q?fX4v0ZR/eSQ4FzYm4uEP6M96yGMIuIZiD9EexXqth7RNTFdnzeJUrXonstdc?=
 =?us-ascii?Q?efoLRGbVMFiDX2o0BWJx2Xznx9Z9Jdx73xVE9G+AljCBqQ7S1D+MX19v5FQL?=
 =?us-ascii?Q?b989B6U6Z/PT+Kn59ZmBx7+mfzH6YUz6ce/HLw68p15xYjdRodXTbqvwc6cH?=
 =?us-ascii?Q?aLlvILTvvBvmfCAMjW4ykxTeAHyzm/0blxakmdie?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8c3c1a-15f9-4031-bc9f-08dcc35d254c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:20:00.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHtlHI6735Hbs/AiJJRTYjsJRRoxl6BU8OKTLFrE4oDA4CQqCSR8XfYZ6RIGo/0KDL7KeKdChl4NZZlKd6Wh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

Use devm_clk_get_enabled() instead of clk functions in imx-sdma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/imx-sdma.c | 57 ++++--------------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 72299a08af44..af972a4b6ce1 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1493,24 +1493,11 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	sdmac->event_id0 = data->dma_request;
 	sdmac->event_id1 = data->dma_request2;
 
-	ret = clk_enable(sdmac->sdma->clk_ipg);
-	if (ret)
-		return ret;
-	ret = clk_enable(sdmac->sdma->clk_ahb);
-	if (ret)
-		goto disable_clk_ipg;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
-		goto disable_clk_ahb;
+		return ret;
 
 	return 0;
-
-disable_clk_ahb:
-	clk_disable(sdmac->sdma->clk_ahb);
-disable_clk_ipg:
-	clk_disable(sdmac->sdma->clk_ipg);
-	return ret;
 }
 
 static void sdma_free_chan_resources(struct dma_chan *chan)
@@ -1530,9 +1517,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	sdmac->event_id1 = 0;
 
 	sdma_set_channel_priority(sdmac, 0);
-
-	clk_disable(sdma->clk_ipg);
-	clk_disable(sdma->clk_ahb);
 }
 
 static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
@@ -2015,14 +1999,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	addr = (void *)header + header->script_addrs_start;
 	ram_code = (void *)header + header->ram_code_start;
 
-	clk_enable(sdma->clk_ipg);
-	clk_enable(sdma->clk_ahb);
 	/* download the RAM image for SDMA */
 	sdma_load_script(sdma, ram_code,
 			 header->ram_code_size,
 			 addr->ram_code_start_addr);
-	clk_disable(sdma->clk_ipg);
-	clk_disable(sdma->clk_ahb);
 
 	sdma_add_scripts(sdma, addr);
 
@@ -2119,13 +2099,6 @@ static int sdma_init(struct sdma_engine *sdma)
 	dma_addr_t ccb_phys;
 	int ccbsize;
 
-	ret = clk_enable(sdma->clk_ipg);
-	if (ret)
-		return ret;
-	ret = clk_enable(sdma->clk_ahb);
-	if (ret)
-		goto disable_clk_ipg;
-
 	if (sdma->drvdata->check_ratio &&
 	    (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg)))
 		sdma->clk_ratio = 1;
@@ -2180,15 +2153,9 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Initializes channel's priorities */
 	sdma_set_channel_priority(&sdma->channel[0], 7);
 
-	clk_disable(sdma->clk_ipg);
-	clk_disable(sdma->clk_ahb);
-
 	return 0;
 
 err_dma_alloc:
-	clk_disable(sdma->clk_ahb);
-disable_clk_ipg:
-	clk_disable(sdma->clk_ipg);
 	dev_err(sdma->dev, "initialisation failed with %d\n", ret);
 	return ret;
 }
@@ -2266,33 +2233,25 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	ret = clk_prepare(sdma->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare(sdma->clk_ahb);
-	if (ret)
-		goto err_clk;
-
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
 				dev_name(&pdev->dev), sdma);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
 	if (!sdma->script_addrs) {
 		ret = -ENOMEM;
-		goto err_irq;
+		return ret;
 	}
 
 	/* initially no scripts available */
@@ -2407,10 +2366,6 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
-err_irq:
-	clk_unprepare(sdma->clk_ahb);
-err_clk:
-	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -2422,8 +2377,6 @@ static void sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
-	clk_unprepare(sdma->clk_ahb);
-	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
-- 
2.25.1


