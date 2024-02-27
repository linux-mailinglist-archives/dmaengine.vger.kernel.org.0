Return-Path: <dmaengine+bounces-1126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F051869CC4
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE0B3302E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1138DD5;
	Tue, 27 Feb 2024 16:38:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BE3DBBF;
	Tue, 27 Feb 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051901; cv=fail; b=VTb+A57intoMqKgZvJ0SPbQS051aw55p0fYMcthopMnxArkKGiUWDU1Q6egkCeg6zPaugwrZYqTOiobbrwla3CkMY27zPZSkvgiXesGfe93UxJLLdyRSUUWFzinS8xNtyjRZlw8E5SdjJJO7lVBhWDoDUlAoDl3pIrXlsK5gFis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051901; c=relaxed/simple;
	bh=6hT83FI8bg3dQjXMYMWjqjoqEUxZQNdF55CddK4wlcU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuvHk4fJjSiyMnyUSbptIWTz6CsPbSpZQzED1xzCJy/3TqRx2lGSskYopMEBt97yhVLp59tbwEld3cFzOe+Xbj0GSm3Fwsa1+OJVxoe+CjcWcMl1WtCwb6ytJbd5c9csWTu9TBYwhACCW1jxFf+sydoI1pgyUY3D4/Gn4qBNCO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8itswayPE3XxC8oETaDEnX/LnseJWdUfW/y68CjpaQIm12ShPnmbrkUKAy3vI2G67MtHqq0H5xCzfB//9JXlXcLoyOAhKHf3S2yV2uFaI3Q9rM3V1/IP7Ux2qXQqFskajqlwGmfOQ99kDRcKr0kOb2x7Fy9RSX1vwzg8EYkRIZTAfa8OEOzuPTVnhApV16dlxKpJYb2OSwpsKjF0K3bYKBCthZX5CPDa7zL6npCRSdnBN/F7hU2C4GhJJLY3h1oluse/8zBlYLPhgz6mAsLLf82/Er4tEJYu07FX7wKIC0RLL0j7ZXylN6wwb6ArvqMBH6eHZeyq0MPFlaRgNnK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwYfsEg3kNZoU5bRI4c1mE813JcYK1zxTkaGutPHKJQ=;
 b=Tdn0CLncSg/Qsfka8X4nQGcUlWpQ2boWrdjlJTSd1FmoKYZLHqxXz7mH0rFp5YP18gGo8m8+kNio36FgZbCAecSMZGY3eGK9ezULz2/YKf/3LB/VSHOrPMR4R1rFJlT7ZgEE+LKgaalv+pH0URVDNud/uOnEIQlWC4ShCA+RSzEnv7Oz5MKa3qvpHno7l+agcyPzanH1mBAUAiBkb9hRwLqfDtvWDrSD5ofvcIdLEWVYLlAXI9qhzXk9+TI0AsMjYIXWXdjYf5sxvKfUqmlLQYiZ63L3vHT9V+pZXIpjFmd+VKFh4qqJFzgupOkfHHlbF2UVpqholwt69UtKc6Sd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:09 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:09 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 2/6] crypto: starfive: Update hash dma usage
Date: Wed, 28 Feb 2024 00:37:54 +0800
Message-Id: <20240227163758.198133-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::16) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c808243-0bc6-4f40-b2a6-08dc37b27b6e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GF0FX7qPVi+iY2Fg/qqhZwUDfhUYLOZprYWd9YLEX0bChxq829w1kBBWM5EMRUDCVJH4SkOcPkjK8XnGQWxFS6ey5D5zZgygE2GBt0wGEQn9VDH1rCHipXK2i9zSN/AL6c+wr3EryDxuGNaDxXGrSCt/88GweXm96ihDM/DBn7HNJRYiqloxqfMabjmlxesgAjM9Fd6y18mcfXBFbUyANlWm1YA/GWUxt2clKz05fGyMVC4A2y8f1K5zQjZXt5Yf/yyxUBAWjcfMa3ZPNyLT14p4zb6wMgcIVe6rSaPRSL7d9x110MhIyehq0JnmXualtSXnI2gyacyattsGDXJPcfMDN2NCAv7og6C6oX13r15I+M8G6SXYDmj1a9/2nN4gpA7qqw8PbRYIrRIWLheb3EC+B99DEub8NT/Og71kA020arlwNXUUM2l7JqjdRfTOGbtzVsbBNSLlq8GAYYKx1jJvi2J6cjqdV6caLlLtrQhB+KEPGri4HljRXHVMTIigbf8N8Z9WR6auBpry9tshyOB39RMo2vLdQNISmWZ5u9+RgNBTg5J06GqjDpA9qOotA4eIb+2aHivFjb6oh1JNHyZYWS4jc2W6bR0/Ms8gBwLEPpvbbvxyM+rDhRy5wBco0xlN/+D50OEimgoEpY1qfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyIX9DoqH2ixQHOwrw0kyfzl6ZOGJ3bmSE+X5fGIX4hHQMLF8GedbradoiEV?=
 =?us-ascii?Q?LVwjwkF+JfeovSkFdd/UI6cR0/KV12ENzxIeyU0ZeJl4rvrY9xRZuFjcHrbZ?=
 =?us-ascii?Q?tW6jgy4k6o6uQbUcB9NeUy5E6vcTRlx04mNjcFMzi+JcfxiLvAlVm67PcY7y?=
 =?us-ascii?Q?ml076/QD97LITpWqQNACxu/YjnwTRt9FAwIswaO+axaB8LovuqBUGfdPnJVB?=
 =?us-ascii?Q?JTYFOmvw8PQ9cT7B2CjQeKKG2XOOrAsQpzawvewZtXTVGm49h9e/gcOuNSZP?=
 =?us-ascii?Q?4W+vkU6R+uxXd1tSDI6+8trxPMzSj93lu5cSR+G6L7XSdZ5/Gav/KjrmZwDj?=
 =?us-ascii?Q?9HZx4zqZrt1PPCibb0d9Kng6IEIfKon3VJUTVTL4AgR1XdaJeRZ/jblvmfwC?=
 =?us-ascii?Q?rCadbeiu0Ox9/vtuMEMj2eQh5rrENX5kDbJ08q2qZg2akfSax2l8QUuBafu5?=
 =?us-ascii?Q?8IKMN8nSjNOZjoHYchZTRHTPDJAz2SGy9WQIiA6AizGGLpkMv2I1JyeLKuQT?=
 =?us-ascii?Q?N8ZFryfL/L85hHABS227D873a23VaZqrB/fllqiiLDqYSzjN5UF1u+MLpz5o?=
 =?us-ascii?Q?eh+Go+++OKwoaSAkforppTtHdFsDV0WTdMp3Nje1CWizsMOmDrWCiBBBkg9z?=
 =?us-ascii?Q?ltpckM56mrJOK3Ff9bI4lWJegHuoASOzpYr4Win/APkPMX0x96FMDCHNVISv?=
 =?us-ascii?Q?BSHbLqusBYl3mHiKLCyF4OiFlLiPAgIHU2HY7z83e3njsCdaEXOLoW8LT83v?=
 =?us-ascii?Q?ysDmdVz2bIUGAAcHVTZYgD1gmqrRAj3sz0ZBNAEJ4pS+ZsNQwv6broHzkdln?=
 =?us-ascii?Q?yvzyNUp/ypVtb92LXzqM5IRoCfmg7hIEsAxSvFmwLhdqVa7RI8fGl2iP2Hqy?=
 =?us-ascii?Q?+PvVOBd/EvgSk8lBpK0WTUeycO6VhHxRET2PWoxhCEGsS1Foy3oIvc+XkG1s?=
 =?us-ascii?Q?M2etK2uEMUB5tnYx1SZkdNiUSEIpVzxE/vp7rS/mg5rKvueRMDG9SuzsxFAg?=
 =?us-ascii?Q?NyjRWLDlaf8FSMFEPNbTNWVH5QBmcF1+1OXggmgaUbppx/hiUFWPp0Mly+6v?=
 =?us-ascii?Q?ZZf2S1CC/0L6PE2OCZXEquhHYpvjMYPMDs9y3ThlGRGNSAWigd96Vj9ZdKZB?=
 =?us-ascii?Q?5fT+ZFX239oGis7HHId1G4S5cbXSVz9iKVGNShOb0WOxtbsj7lx2ey3wPnVC?=
 =?us-ascii?Q?xupcYm24OWu/RmRDg9MUS2WHqzRuYcROEi5MW0wES9M7anDXZjbm96VmaY/6?=
 =?us-ascii?Q?dDtziPDBF9yTTASnCLalnwwZrPwXvF/SUv7qJz9kikv/LMuabzIsQ5ZuzZvg?=
 =?us-ascii?Q?uEbUYaPzHOCYdUvHQ1alMaEfwjzXnDGv9+QI9+O2y1LycW/Gmd2KmoyPbKwq?=
 =?us-ascii?Q?oU/eVaa9fCG2SIRm7UkqznBfpC2tG3HYUB6BSGLtJ0574SvA7z3KdB7DrCh9?=
 =?us-ascii?Q?iYFblZU2MawmkuCSdgrfgAjNCQ4ZNTfQ2+yI4BciWZfEzNhN8UZ/jYcRUJ7I?=
 =?us-ascii?Q?hPPmIsGXJRTmuhfHBrbaRWGA2sibjr8+16Ef14gf+A4kz6rZ5XmowyzWfBpk?=
 =?us-ascii?Q?3MF5PG/ocT/WCLhA3yzW0uzg8OhMy4zHdxKgVsOtC6pofGXopGaXgfSVAZ2F?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c808243-0bc6-4f40-b2a6-08dc37b27b6e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:09.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5BC4I9YZ8Ll6uN7fPqNw11U1FSMOqC/Xu/M01XRI4NOmWGNsP8txtsOW/vYve9okbqdPennBmcOgGQc0iuqLuTn98IAAxCQdEafY7q+IfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

Current hash uses sw fallback for non-word aligned input scatterlists.
Add support for unaligned cases utilizing the data valid mask for dma.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.c |   9 -
 drivers/crypto/starfive/jh7110-cryp.h |   3 +-
 drivers/crypto/starfive/jh7110-hash.c | 263 ++++++++++----------------
 3 files changed, 100 insertions(+), 175 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 425fddf3a8ab..2685f5483639 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -103,12 +103,6 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
 		tasklet_schedule(&cryp->aes_done);
 	}
 
-	if (status & STARFIVE_IE_FLAG_HASH_DONE) {
-		mask |= STARFIVE_IE_MASK_HASH_DONE;
-		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
-		tasklet_schedule(&cryp->hash_done);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -132,7 +126,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 				     "Error remapping memory for platform device\n");
 
 	tasklet_init(&cryp->aes_done, starfive_aes_done_task, (unsigned long)cryp);
-	tasklet_init(&cryp->hash_done, starfive_hash_done_task, (unsigned long)cryp);
 
 	cryp->phys_base = res->start;
 	cryp->dma_maxburst = 32;
@@ -220,7 +213,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	reset_control_assert(cryp->rst);
 
 	tasklet_kill(&cryp->aes_done);
-	tasklet_kill(&cryp->hash_done);
 
 	return ret;
 }
@@ -234,7 +226,6 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	starfive_rsa_unregister_algs();
 
 	tasklet_kill(&cryp->aes_done);
-	tasklet_kill(&cryp->hash_done);
 
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 6cdf6db5d904..60cc269a0f28 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -189,7 +189,7 @@ struct starfive_cryp_dev {
 	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
 	struct tasklet_struct			aes_done;
-	struct tasklet_struct			hash_done;
+	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
 	size_t					total_out;
@@ -237,6 +237,5 @@ void starfive_rsa_unregister_algs(void);
 int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
 
-void starfive_hash_done_task(unsigned long param);
 void starfive_aes_done_task(unsigned long param);
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index b6d1808012ca..4e82f05a7df7 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -84,64 +84,26 @@ static int starfive_hash_hmac_key(struct starfive_cryp_ctx *ctx)
 	return 0;
 }
 
-static void starfive_hash_start(void *param)
+static void starfive_hash_start(struct starfive_cryp_dev *cryp)
 {
-	struct starfive_cryp_ctx *ctx = param;
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	union starfive_alg_cr alg_cr;
 	union starfive_hash_csr csr;
-	u32 stat;
-
-	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
-
-	alg_cr.v = 0;
-	alg_cr.clear = 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
 
 	csr.v = readl(cryp->base + STARFIVE_HASH_SHACSR);
 	csr.firstb = 0;
 	csr.final = 1;
-
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_HASH_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
 	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
 }
 
-static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
+static void starfive_hash_dma_callback(void *param)
 {
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct dma_async_tx_descriptor	*in_desc;
-	union  starfive_alg_cr alg_cr;
-	int total_len;
-	int ret;
-
-	if (!rctx->total) {
-		starfive_hash_start(ctx);
-		return 0;
-	}
-
-	writel(rctx->total, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	struct starfive_cryp_dev *cryp = param;
 
-	total_len = rctx->total;
-	total_len = (total_len & 0x3) ? (((total_len >> 2) + 1) << 2) : total_len;
-	sg_dma_len(rctx->in_sg) = total_len;
-
-	alg_cr.v = 0;
-	alg_cr.start = 1;
-	alg_cr.hash_dma_en = 1;
-
-	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
-
-	ret = dma_map_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
-	if (!ret)
-		return dev_err_probe(cryp->dev, -EINVAL, "dma_map_sg() error\n");
+	complete(&cryp->dma_done);
+}
 
-	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
-	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+static void starfive_hash_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
 	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
@@ -149,50 +111,48 @@ static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
 
 	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
 
-	in_desc = dmaengine_prep_slave_sg(cryp->tx, rctx->in_sg,
-					  ret, DMA_MEM_TO_DEV,
-					  DMA_PREP_INTERRUPT  |  DMA_CTRL_ACK);
-
-	if (!in_desc)
-		return -EINVAL;
-
-	in_desc->callback = starfive_hash_start;
-	in_desc->callback_param = ctx;
-
-	dmaengine_submit(in_desc);
-	dma_async_issue_pending(cryp->tx);
-
-	return 0;
+	init_completion(&cryp->dma_done);
 }
 
-static int starfive_hash_xmit(struct starfive_cryp_ctx *ctx)
+static int starfive_hash_dma_xfer(struct starfive_cryp_dev *cryp,
+				  struct scatterlist *sg)
 {
-	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
-	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct dma_async_tx_descriptor *in_desc;
+	union starfive_alg_cr alg_cr;
 	int ret = 0;
 
-	rctx->csr.hash.v = 0;
-	rctx->csr.hash.reset = 1;
-	writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
-
-	if (starfive_hash_wait_busy(ctx))
-		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting engine.\n");
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.hash_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
 
-	rctx->csr.hash.v = 0;
-	rctx->csr.hash.mode = ctx->hash_mode;
-	rctx->csr.hash.ie = 1;
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) = ALIGN(sg_dma_len(sg), sizeof(u32));
 
-	if (ctx->is_hmac) {
-		ret = starfive_hash_hmac_key(ctx);
-		if (ret)
-			return ret;
-	} else {
-		rctx->csr.hash.start = 1;
-		rctx->csr.hash.firstb = 1;
-		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto end;
 	}
 
-	return starfive_hash_xmit_dma(ctx);
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback = starfive_hash_dma_callback;
+	in_desc->callback_param = cryp;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret = -ETIMEDOUT;
+
+end:
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return ret;
 }
 
 static int starfive_hash_copy_hash(struct ahash_request *req)
@@ -215,58 +175,71 @@ static int starfive_hash_copy_hash(struct ahash_request *req)
 	return 0;
 }
 
-void starfive_hash_done_task(unsigned long param)
+static void starfive_hash_done_task(struct starfive_cryp_dev *cryp)
 {
-	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
 	int err = cryp->err;
 
 	if (!err)
 		err = starfive_hash_copy_hash(cryp->req.hreq);
 
-	/* Reset to clear hash_done in irq register*/
-	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
-
 	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
 }
 
-static int starfive_hash_check_aligned(struct scatterlist *sg, size_t total, size_t align)
+static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
 {
-	int len = 0;
-
-	if (!total)
-		return 0;
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
 
-	if (!IS_ALIGNED(total, align))
-		return -EINVAL;
+	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
 
-	while (sg) {
-		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
-			return -EINVAL;
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware.\n");
 
-		if (!IS_ALIGNED(sg->length, align))
-			return -EINVAL;
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.mode = ctx->hash_mode;
 
-		len += sg->length;
-		sg = sg_next(sg);
+	if (ctx->is_hmac) {
+		ret = starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start = 1;
+		rctx->csr.hash.firstb = 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
 	}
 
-	if (len != total)
-		return -EINVAL;
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
 
-	return 0;
-}
+	starfive_hash_dma_init(cryp);
 
-static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
-{
-	struct ahash_request *req = container_of(areq, struct ahash_request,
-						 base);
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct starfive_cryp_dev *cryp = ctx->cryp;
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents = dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents == 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
 
-	if (!cryp)
-		return -ENODEV;
+		ret = starfive_hash_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_hash_start(cryp);
 
-	return starfive_hash_xmit(ctx);
+	if (starfive_hash_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware.\n");
+
+	starfive_hash_done_task(cryp);
+
+	return 0;
 }
 
 static int starfive_hash_init(struct ahash_request *req)
@@ -337,22 +310,6 @@ static int starfive_hash_finup(struct ahash_request *req)
 	return crypto_ahash_finup(&rctx->ahash_fbk_req);
 }
 
-static int starfive_hash_digest_fb(struct ahash_request *req)
-{
-	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
-
-	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
-	ahash_request_set_callback(&rctx->ahash_fbk_req, req->base.flags,
-				   req->base.complete, req->base.data);
-
-	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
-				req->result, req->nbytes);
-
-	return crypto_ahash_digest(&rctx->ahash_fbk_req);
-}
-
 static int starfive_hash_digest(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -370,9 +327,6 @@ static int starfive_hash_digest(struct ahash_request *req)
 	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
 	ctx->rctx = rctx;
 
-	if (starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize))
-		return starfive_hash_digest_fb(req);
-
 	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
 }
 
@@ -406,7 +360,8 @@ static int starfive_hash_import(struct ahash_request *req, const void *in)
 
 static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 				  const char *alg_name,
-				  unsigned int mode)
+				  unsigned int mode,
+				  bool is_hmac)
 {
 	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
 
@@ -426,7 +381,7 @@ static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
 				 crypto_ahash_reqsize(ctx->ahash_fbk));
 
-	ctx->keylen = 0;
+	ctx->is_hmac = is_hmac;
 	ctx->hash_mode = mode;
 
 	return 0;
@@ -529,81 +484,61 @@ static int starfive_hash_setkey(struct crypto_ahash *hash,
 static int starfive_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha224-generic",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 0);
 }
 
 static int starfive_sha256_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha256-generic",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 0);
 }
 
 static int starfive_sha384_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha384-generic",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 0);
 }
 
 static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sha512-generic",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 0);
 }
 
 static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 0);
 }
 
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
-				      STARFIVE_HASH_SHA224);
+				      STARFIVE_HASH_SHA224, 1);
 }
 
 static int starfive_hmac_sha256_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha256-generic)",
-				      STARFIVE_HASH_SHA256);
+				      STARFIVE_HASH_SHA256, 1);
 }
 
 static int starfive_hmac_sha384_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha384-generic)",
-				      STARFIVE_HASH_SHA384);
+				      STARFIVE_HASH_SHA384, 1);
 }
 
 static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sha512-generic)",
-				      STARFIVE_HASH_SHA512);
+				      STARFIVE_HASH_SHA512, 1);
 }
 
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
-
-	ctx->is_hmac = true;
-
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
-				      STARFIVE_HASH_SM3);
+				      STARFIVE_HASH_SM3, 1);
 }
 
 static struct ahash_engine_alg algs_sha2_sm3[] = {
-- 
2.34.1


