Return-Path: <dmaengine+bounces-1127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424E869C63
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D41C24B87
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439E4DA0B;
	Tue, 27 Feb 2024 16:38:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A54CB30;
	Tue, 27 Feb 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051904; cv=fail; b=VsNYNBRcreJ02gIcbHspfJJg5NnNmA7/x3xGmoSs4DSTvYTasbgFdbt8pad/TcvBiceTu79AcA9wBcZJ0BBTVVjgiz8n+3VjY9eES1eYduwEjNiZ4DQQL1pdcK8xR+HDFR1MWTAOjmHitR7B++Ob8HId6I1xsERZWMuTOCvgxiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051904; c=relaxed/simple;
	bh=NZ/M4xuBeEhFXE0Iq3QzB1Hs47D4Mwww8Y53G+GTsaI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJACAiJjGU45i6hFOe/0JssB+ZyaduARe7hcIsQM6p8LftcZ6Cb1HnFr42kxjk9S6crBm6eSuNQkmCKHjUBMrJR+jxsKYYoa1ffB7gdNU6fdF3csjE61hlCcF6aRP/eGq7VNmB321iUi63gRn+eEN748qNrZzORwSdeSTPCpOho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/fU4+JjN5Zoh7CrEJvPLsQkIIEI30a3wtYLlmTLRb4Rzl5zmh9p6W8DpOfTrCr9imOJZ/fVM/Wt0CGLYDKMjONpXqeE9ayu3v7FvURxxEl1ONPaax/jNnO5yWLK/tjtPYzMVvpfRPDVolOnN0HDzFrjyK/YF7FPT0tvD3B10SP1RygCg/FuNsnvdMPIBdI/MHKL1zE2TFQ5V38g18M5oNaQ8y2byB4Ytn1xj5TYKy3qIsVpmObr708r3gtvu1tjrTbh7YLBMHp9jKpn4dgQp8SOZM87d/YlJ4xxQmQFqbJQ7eGwT18Rmv+dUtpd9/Pgon2nDMthoJo5ZGHSVNqJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/IF5+vxDHjNEIUSsIbLH5WSbf5uqgixkJs2tf/d9dw=;
 b=lbK9MXZvHqaj2/UkOxxHjM5kYr6faRevoR3qGPqw1vlh6Tst6thtE7brx6+Y5ocvMxPuxXKpO8hTmkt1+ZoxHDm75svEoeAvvfl385Q+KoE0I2QJLUUy/Uyd9DvSmUWcsiK3er4ZAhmWlOPP6Je+Bj1i+64w69myA5b1g0F9q3bd/JsCdVZvPDz2HLMLsc2l0dSpgy3d7aAhRNWob5PU+xKPOouxEv72sTl6qm3Oi6B8TcgeQ3LJtgvUu6+o1Ln2Iur5zNEcdKohw9hs3PDSYtLt06BAwCzlIdeBEh8eQOCQOUqhrH+Bxj3Lp87RME+AvW4IiYwjP+QxEhotpOndTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:11 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:11 +0000
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
Subject: [PATCH v3 3/6] crypto: starfive: Use dma for aes requests
Date: Wed, 28 Feb 2024 00:37:55 +0800
Message-Id: <20240227163758.198133-4-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2004ad5-a24a-4dd6-070b-08dc37b27c4a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpyIrzI0Hcts98Nwk644qaNUGzqbFXgl4FocgBL7ZU52ZyiwkovIf809ONHies2BT9T7b2lxTNBiXzC9K9Gb+SsnnLeJgaDjgRX97WbjzU1Q1fXWNd7A3PaycL3WN3myPVAEVSUjji8qurvql04BR0Q4Z7qZ6P8E0olasxsoE0CvHOLQRAlXSSND+qb4RZC5hwpgvskx1IhQ6buzPWPnktG51Y+vOq87320EhkPpOnv8tY7QMCMaF0+DxbB8Yk6FmqqN2/mlGp8YP1ZswDhQCyXFw/V6ha+p2FdTnoxybGmDASsOwDOsiic3y7nh+YLerBsgB8oEfZpTEUnqvpC8XzJ/nCwuquOfDQ/XAF4LL04APTdsj8Dvxl/doW2oPBgj8ykwENaI3eyhec+cp5BT9y7N9YnhFPGJdUBQC103o9noFxC5nJ+9sE1pxS46b7j8AhrLG7hWWHCXc08LFWza5mItF92Vq868PWUg8xXiegltrXbCfqe4fhLhm5QO51Wpm5g4FjCycQNhNTVyJvqD/mYjGyDMJcBA7SKp3UJt36hKWJDHg7BSpXsT4XiuOyF/fIoELFV/PZUu0wME1BmFrvB6yPNk1j+B4ddvZGPWOmwY6Igg2MQpSLWUH4suEUVVx9HzupI71qz4PW3b8cEs7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1ewSa2CXx2BXRYALyZs7qGspFTp53Kf8F8ehOhJfOeTlKPX8UaV+VYIaMjC?=
 =?us-ascii?Q?Iw4yAJW8yOA4Xb6/j9utlVcuuOWMSl406fqduUwf4Fux5jIMaPyPOsdO1kpM?=
 =?us-ascii?Q?VvJ9ro7z2NXSW/HAuDFxd9ZEXH6SnFX0Nwx0V+Xsgg3rBUTBtTZWYFxqqPSR?=
 =?us-ascii?Q?GCTxTG9MZMherTjaPh5Io1xD2y97Rc0n8qDy7fu/SwCit7jY6GCJPA9t67C8?=
 =?us-ascii?Q?03veczfH9QpLgLlJS1wOebPX9UpbxhOAY3CuwFUnfaUp7JXQRJFvIzC3O6O6?=
 =?us-ascii?Q?8Y5gebMzE2Ax5bQ3hxqrm9KB9xt7KHpcFwqLQ7iWqXjwrFh4eXgj1EJmpbhw?=
 =?us-ascii?Q?HnT2r0BCOa2Sv9qTjZJZ4sSPXKhlLUNic0eX+7chq6OebUQKeZ/aPAtwTZ8r?=
 =?us-ascii?Q?z7I7yJ36cfma77PIqsw0zjrRKH8aDJ9noaUxgwG+2pNq6J8NbHPrl82hmve/?=
 =?us-ascii?Q?jadmWQArL3bvn+sCnMwNdyjVrpjP2bI7mJJjSOpRPxnU7J1hc2OKCMhtFIyW?=
 =?us-ascii?Q?rOjvlk7QC6gs5uEKxW7jyO1MJzlxnyMd+ZiO8/a9iB3dwHJwP8s1UkUe4rZj?=
 =?us-ascii?Q?h7SB7JU2HaGA3IWjaGaxPKe+RyT4udWogE8GUzxtmj9UZfZQyYkqW4mcLhP4?=
 =?us-ascii?Q?Zg1CFv33NQo59sXxP2RRRHW1hqDsyz22XgubI7wYQSaxKjZc671OJvJ0oFYH?=
 =?us-ascii?Q?eF6waiVgDo9vpmbf3oV7ds2VnLF7ozZ6CNR3yQa3eQABoytcbZl2CEWF+ybr?=
 =?us-ascii?Q?E25+3DL7TFC7x+RUlIEXVi+4SDpYSSTo9KVUw2rkv14Wcrs3Vh2FZhNACz75?=
 =?us-ascii?Q?q5dqHEelg1RQXJ83gCvPt2gK3uMOiv5mVmc+nrYyyVKqqYV1wLPGmfHuylk6?=
 =?us-ascii?Q?Nn6m4puFCb8jNOfli2JtqVQW68GQ9Pyc/d5qMN+ko2CxsZxe/aYH6YT7/I8w?=
 =?us-ascii?Q?cHibYpP+7hDlpjFkPGnBr65QWw1ewCYYVjmaPOg2NsEMMaTmk+8FHb6/mMDz?=
 =?us-ascii?Q?JTDhLhiak2xv5i4mr8R4jFGpZTRNoLBXzXNNESuWQ+ATU+DwGoqFbX4VUhoA?=
 =?us-ascii?Q?lR2kETp6PmKmWyRq+pMCyz+4kCbxh6aO9gaQK3FHm+GnyDegGJNbkbUIKbzZ?=
 =?us-ascii?Q?H85E16j+wRIIiCIyXEYa3BmgslTjvEsD3PMUxX/4ZbbbsLBrgJTjw09hwxDC?=
 =?us-ascii?Q?77XQTlDWHan1s7NURp8YWWj0Phafn9D3V0i8B8t6EoJAHVqS2/4zBPtymyMe?=
 =?us-ascii?Q?A9EFvgB94kIXyyk5ay7JyKjpVABD4EDv7Wh5q7zFxTADyraBcQi/wd8uincq?=
 =?us-ascii?Q?MmEPLh4HMeiPHM51hDLLHAtptagvvnMKviBp+kPyReArwkV5oNfgclA0IYjd?=
 =?us-ascii?Q?QUnbdJWLkmlM4fsiNjIAkopyU700Uaj3VslVgJWYQtMqWxA7WdWEFQlZ0ivX?=
 =?us-ascii?Q?i55++MoqPxNrsI5/5IlJGxCPBmvY/1iRoBkW9bxHMYTa65UR34MbGLtOkM2B?=
 =?us-ascii?Q?iKj3l67F2AvttLXXxVeKRH3BpQxl6OV+839L4WVPZxiyNVuWqxWAYzbkeKDR?=
 =?us-ascii?Q?TN/YcxGRZUlkWHJPr99soWAdvP1bKiFz1QDklkzlcQlu2OjOf93e/OHvfkfe?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2004ad5-a24a-4dd6-070b-08dc37b27c4a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:11.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI3zZ3fg4oNKyA9d3SrrC7GUupEeD8pPjuKiESwKkq1akqLZLzM+OK8HPpHaq2j0tdMdXIPm66nmPgl5UX3AQbp6RD362Inei5VNNKoo3QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

Convert AES module to use dma for data transfers to reduce cpu load and
compatible with future variants.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |   4 +
 drivers/crypto/starfive/jh7110-aes.c  | 589 +++++++++++++++++---------
 drivers/crypto/starfive/jh7110-cryp.c |  24 --
 drivers/crypto/starfive/jh7110-cryp.h |   6 +-
 4 files changed, 395 insertions(+), 228 deletions(-)

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index cb59357b58b2..0fe389e9f932 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -14,6 +14,10 @@ config CRYPTO_DEV_JH7110
 	select CRYPTO_RSA
 	select CRYPTO_AES
 	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_CTR
 	help
 	  Support for StarFive JH7110 crypto hardware acceleration engine.
 	  This module provides acceleration for public key algo,
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index 1ac15cc4ef3c..72b7d46150d5 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -78,7 +78,7 @@ static inline int is_gcm(struct starfive_cryp_dev *cryp)
 	return (cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_GCM;
 }
 
-static inline int is_encrypt(struct starfive_cryp_dev *cryp)
+static inline bool is_encrypt(struct starfive_cryp_dev *cryp)
 {
 	return cryp->flags & FLG_ENCRYPT;
 }
@@ -103,16 +103,6 @@ static void starfive_aes_aead_hw_start(struct starfive_cryp_ctx *ctx, u32 hw_mod
 	}
 }
 
-static inline void starfive_aes_set_ivlen(struct starfive_cryp_ctx *ctx)
-{
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-
-	if (is_gcm(cryp))
-		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-	else
-		writel(AES_BLOCK_SIZE, cryp->base + STARFIVE_AES_IVLEN);
-}
-
 static inline void starfive_aes_set_alen(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
@@ -261,7 +251,6 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 
 	rctx->csr.aes.mode  = hw_mode;
 	rctx->csr.aes.cmode = !is_encrypt(cryp);
-	rctx->csr.aes.ie = 1;
 	rctx->csr.aes.stmode = STARFIVE_AES_MODE_XFB_1;
 
 	if (cryp->side_chan) {
@@ -279,7 +268,7 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 	case STARFIVE_AES_MODE_GCM:
 		starfive_aes_set_alen(ctx);
 		starfive_aes_set_mlen(ctx);
-		starfive_aes_set_ivlen(ctx);
+		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_AES_IVLEN);
 		starfive_aes_aead_hw_start(ctx, hw_mode);
 		starfive_aes_write_iv(ctx, (void *)cryp->req.areq->iv);
 		break;
@@ -300,28 +289,30 @@ static int starfive_aes_hw_init(struct starfive_cryp_ctx *ctx)
 	return cryp->err;
 }
 
-static int starfive_aes_read_authtag(struct starfive_cryp_dev *cryp)
+static int starfive_aes_read_authtag(struct starfive_cryp_ctx *ctx)
 {
-	int i, start_addr;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	int i;
 
 	if (starfive_aes_wait_busy(cryp))
 		return dev_err_probe(cryp->dev, -ETIMEDOUT,
 				     "Timeout waiting for tag generation.");
 
-	start_addr = STARFIVE_AES_NONCE0;
-
-	if (is_gcm(cryp))
-		for (i = 0; i < AES_BLOCK_32; i++, start_addr += 4)
-			cryp->tag_out[i] = readl(cryp->base + start_addr);
-	else
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_GCM) {
+		cryp->tag_out[0] = readl(cryp->base + STARFIVE_AES_NONCE0);
+		cryp->tag_out[1] = readl(cryp->base + STARFIVE_AES_NONCE1);
+		cryp->tag_out[2] = readl(cryp->base + STARFIVE_AES_NONCE2);
+		cryp->tag_out[3] = readl(cryp->base + STARFIVE_AES_NONCE3);
+	} else {
 		for (i = 0; i < AES_BLOCK_32; i++)
 			cryp->tag_out[i] = readl(cryp->base + STARFIVE_AES_AESDIO0R);
+	}
 
 	if (is_encrypt(cryp)) {
-		scatterwalk_copychunks(cryp->tag_out, &cryp->out_walk, cryp->authsize, 1);
+		scatterwalk_map_and_copy(cryp->tag_out, rctx->out_sg,
+					 cryp->total_in, cryp->authsize, 1);
 	} else {
-		scatterwalk_copychunks(cryp->tag_in, &cryp->in_walk, cryp->authsize, 0);
-
 		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
 			return dev_err_probe(cryp->dev, -EBADMSG, "Failed tag verification\n");
 	}
@@ -329,23 +320,18 @@ static int starfive_aes_read_authtag(struct starfive_cryp_dev *cryp)
 	return 0;
 }
 
-static void starfive_aes_finish_req(struct starfive_cryp_dev *cryp)
+static void starfive_aes_finish_req(struct starfive_cryp_ctx *ctx)
 {
-	union starfive_aes_csr csr;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
 	int err = cryp->err;
 
 	if (!err && cryp->authsize)
-		err = starfive_aes_read_authtag(cryp);
+		err = starfive_aes_read_authtag(ctx);
 
 	if (!err && ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CBC ||
 		     (cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CTR))
 		starfive_aes_get_iv(cryp, (void *)cryp->req.sreq->iv);
 
-	/* reset irq flags*/
-	csr.v = 0;
-	csr.aesrst = 1;
-	writel(csr.v, cryp->base + STARFIVE_AES_CSR);
-
 	if (cryp->authsize)
 		crypto_finalize_aead_request(cryp->engine, cryp->req.areq, err);
 	else
@@ -353,39 +339,6 @@ static void starfive_aes_finish_req(struct starfive_cryp_dev *cryp)
 						 err);
 }
 
-void starfive_aes_done_task(unsigned long param)
-{
-	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int i;
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		block[i] = readl(cryp->base + STARFIVE_AES_AESDIO0R);
-
-	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, AES_BLOCK_SIZE,
-							     cryp->total_out), 1);
-
-	cryp->total_out -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_out);
-
-	if (!cryp->total_out) {
-		starfive_aes_finish_req(cryp);
-		return;
-	}
-
-	memset(block, 0, AES_BLOCK_SIZE);
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
-
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-}
-
 static int starfive_aes_gcm_write_adata(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
@@ -451,60 +404,165 @@ static int starfive_aes_ccm_write_adata(struct starfive_cryp_ctx *ctx)
 	return 0;
 }
 
-static int starfive_aes_prepare_req(struct skcipher_request *req,
-				    struct aead_request *areq)
+static void starfive_aes_dma_done(void *param)
 {
-	struct starfive_cryp_ctx *ctx;
-	struct starfive_cryp_request_ctx *rctx;
-	struct starfive_cryp_dev *cryp;
+	struct starfive_cryp_dev *cryp = param;
 
-	if (!req && !areq)
-		return -EINVAL;
+	complete(&cryp->dma_done);
+}
 
-	ctx = req ? crypto_skcipher_ctx(crypto_skcipher_reqtfm(req)) :
-		    crypto_aead_ctx(crypto_aead_reqtfm(areq));
+static void starfive_aes_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr = cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
 
-	cryp = ctx->cryp;
-	rctx = req ? skcipher_request_ctx(req) : aead_request_ctx(areq);
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
 
-	if (req) {
-		cryp->req.sreq = req;
-		cryp->total_in = req->cryptlen;
-		cryp->total_out = req->cryptlen;
-		cryp->assoclen = 0;
-		cryp->authsize = 0;
-	} else {
-		cryp->req.areq = areq;
-		cryp->assoclen = areq->assoclen;
-		cryp->authsize = crypto_aead_authsize(crypto_aead_reqtfm(areq));
-		if (is_encrypt(cryp)) {
-			cryp->total_in = areq->cryptlen;
-			cryp->total_out = areq->cryptlen;
-		} else {
-			cryp->total_in = areq->cryptlen - cryp->authsize;
-			cryp->total_out = cryp->total_in;
-		}
-	}
+	cryp->cfg_out.direction = DMA_DEV_TO_MEM;
+	cryp->cfg_out.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cryp->cfg_out.dst_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
+	cryp->cfg_out.src_maxburst = 4;
+	cryp->cfg_out.dst_maxburst = 4;
+	cryp->cfg_out.src_addr = cryp->phys_base + STARFIVE_ALG_FIFO_OFFSET;
 
-	rctx->in_sg = req ? req->src : areq->src;
-	scatterwalk_start(&cryp->in_walk, rctx->in_sg);
+	dmaengine_slave_config(cryp->rx, &cryp->cfg_out);
 
-	rctx->out_sg = req ? req->dst : areq->dst;
-	scatterwalk_start(&cryp->out_walk, rctx->out_sg);
+	init_completion(&cryp->dma_done);
+}
 
-	if (cryp->assoclen) {
-		rctx->adata = kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
-		if (!rctx->adata)
-			return dev_err_probe(cryp->dev, -ENOMEM,
-					     "Failed to alloc memory for adata");
+static int starfive_aes_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *src,
+				 struct scatterlist *dst,
+				 int len)
+{
+	struct dma_async_tx_descriptor *in_desc, *out_desc;
+	union starfive_alg_cr alg_cr;
+	int ret = 0, in_save, out_save;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.aes_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
 
-		scatterwalk_copychunks(rctx->adata, &cryp->in_walk, cryp->assoclen, 0);
-		scatterwalk_copychunks(NULL, &cryp->out_walk, cryp->assoclen, 2);
+	in_save = sg_dma_len(src);
+	out_save = sg_dma_len(dst);
+
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
+	writel(ALIGN(len, AES_BLOCK_SIZE), cryp->base + STARFIVE_DMA_OUT_LEN_OFFSET);
+
+	sg_dma_len(src) = ALIGN(len, AES_BLOCK_SIZE);
+	sg_dma_len(dst) = ALIGN(len, AES_BLOCK_SIZE);
+
+	out_desc = dmaengine_prep_slave_sg(cryp->rx, dst, 1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc) {
+		ret = -EINVAL;
+		goto dma_err;
 	}
 
-	ctx->rctx = rctx;
+	out_desc->callback = starfive_aes_dma_done;
+	out_desc->callback_param = cryp;
+
+	reinit_completion(&cryp->dma_done);
+	dmaengine_submit(out_desc);
+	dma_async_issue_pending(cryp->rx);
+
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, src, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto dma_err;
+	}
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret = -ETIMEDOUT;
 
-	return starfive_aes_hw_init(ctx);
+dma_err:
+	sg_dma_len(src) = in_save;
+	sg_dma_len(dst) = out_save;
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_aes_map_sg(struct starfive_cryp_dev *cryp,
+			       struct scatterlist *src,
+			       struct scatterlist *dst)
+{
+	struct scatterlist *stsg, *dtsg;
+	struct scatterlist _src[2], _dst[2];
+	unsigned int remain = cryp->total_in;
+	unsigned int len, src_nents, dst_nents;
+	int ret;
+
+	if (src == dst) {
+		for (stsg = src, dtsg = dst; remain > 0;
+		     stsg = sg_next(stsg), dtsg = sg_next(dtsg)) {
+			src_nents = dma_map_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (src_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg error\n");
+
+			dst_nents = src_nents;
+			len = min(sg_dma_len(stsg), remain);
+
+			ret = starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (ret)
+				return ret;
+
+			remain -= len;
+		}
+	} else {
+		for (stsg = src, dtsg = dst;;) {
+			src_nents = dma_map_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			if (src_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg src error\n");
+
+			dst_nents = dma_map_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (dst_nents == 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg dst error\n");
+
+			len = min(sg_dma_len(stsg), sg_dma_len(dtsg));
+			len = min(len, remain);
+
+			ret = starfive_aes_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (ret)
+				return ret;
+
+			remain -= len;
+			if (remain == 0)
+				break;
+
+			if (sg_dma_len(stsg) - len) {
+				stsg = scatterwalk_ffwd(_src, stsg, len);
+				dtsg = sg_next(dtsg);
+			} else if (sg_dma_len(dtsg) - len) {
+				dtsg = scatterwalk_ffwd(_dst, dtsg, len);
+				stsg = sg_next(stsg);
+			} else {
+				stsg = sg_next(stsg);
+				dtsg = sg_next(dtsg);
+			}
+		}
+	}
+
+	return 0;
 }
 
 static int starfive_aes_do_one_req(struct crypto_engine *engine, void *areq)
@@ -513,35 +571,38 @@ static int starfive_aes_do_one_req(struct crypto_engine *engine, void *areq)
 		container_of(areq, struct skcipher_request, base);
 	struct starfive_cryp_ctx *ctx =
 		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx = skcipher_request_ctx(req);
 	struct starfive_cryp_dev *cryp = ctx->cryp;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	int ret;
 
-	err = starfive_aes_prepare_req(req, NULL);
-	if (err)
-		return err;
+	cryp->req.sreq = req;
+	cryp->total_in = req->cryptlen;
+	cryp->total_out = req->cryptlen;
+	cryp->assoclen = 0;
+	cryp->authsize = 0;
 
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+
+	ctx->rctx = rctx;
+
+	ret = starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
 
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
 
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	ret = starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+	starfive_aes_finish_req(ctx);
 
 	return 0;
 }
 
-static int starfive_aes_init_tfm(struct crypto_skcipher *tfm)
+static int starfive_aes_init_tfm(struct crypto_skcipher *tfm,
+				 const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
 
@@ -549,12 +610,26 @@ static int starfive_aes_init_tfm(struct crypto_skcipher *tfm)
 	if (!ctx->cryp)
 		return -ENODEV;
 
+	ctx->skcipher_fbk = crypto_alloc_skcipher(alg_name, 0,
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->skcipher_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->skcipher_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
-				    sizeof(struct skcipher_request));
+				    crypto_skcipher_reqsize(ctx->skcipher_fbk));
 
 	return 0;
 }
 
+static void starfive_aes_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(ctx->skcipher_fbk);
+}
+
 static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq)
 {
 	struct aead_request *req =
@@ -562,79 +637,99 @@ static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq
 	struct starfive_cryp_ctx *ctx =
 		crypto_aead_ctx(crypto_aead_reqtfm(req));
 	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct starfive_cryp_request_ctx *rctx;
-	u32 block[AES_BLOCK_32];
-	u32 stat;
-	int err;
-	int i;
+	struct starfive_cryp_request_ctx *rctx = aead_request_ctx(req);
+	struct scatterlist _src[2], _dst[2];
+	int ret;
+
+	cryp->req.areq = req;
+	cryp->assoclen = req->assoclen;
+	cryp->authsize = crypto_aead_authsize(crypto_aead_reqtfm(req));
+
+	rctx->in_sg = scatterwalk_ffwd(_src, req->src, cryp->assoclen);
+	if (req->src == req->dst)
+		rctx->out_sg = rctx->in_sg;
+	else
+		rctx->out_sg = scatterwalk_ffwd(_dst, req->dst, cryp->assoclen);
 
-	err = starfive_aes_prepare_req(NULL, req);
-	if (err)
-		return err;
+	if (is_encrypt(cryp)) {
+		cryp->total_in = req->cryptlen;
+		cryp->total_out = req->cryptlen;
+	} else {
+		cryp->total_in = req->cryptlen - cryp->authsize;
+		cryp->total_out = cryp->total_in;
+		scatterwalk_map_and_copy(cryp->tag_in, req->src,
+					 cryp->total_in + cryp->assoclen,
+					 cryp->authsize, 0);
+	}
 
-	rctx = ctx->rctx;
+	if (cryp->assoclen) {
+		rctx->adata = kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
+		if (!rctx->adata)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "Failed to alloc memory for adata");
+
+		if (sg_copy_to_buffer(req->src, sg_nents_for_len(req->src, cryp->assoclen),
+				      rctx->adata, cryp->assoclen) != cryp->assoclen)
+			return -EINVAL;
+	}
+
+	if (cryp->total_in)
+		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
+			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       cryp->total_in);
+
+	ctx->rctx = rctx;
+
+	ret = starfive_aes_hw_init(ctx);
+	if (ret)
+		return ret;
 
 	if (!cryp->assoclen)
 		goto write_text;
 
 	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CCM)
-		cryp->err = starfive_aes_ccm_write_adata(ctx);
+		ret = starfive_aes_ccm_write_adata(ctx);
 	else
-		cryp->err = starfive_aes_gcm_write_adata(ctx);
+		ret = starfive_aes_gcm_write_adata(ctx);
 
 	kfree(rctx->adata);
 
-	if (cryp->err)
-		return cryp->err;
+	if (ret)
+		return ret;
 
 write_text:
 	if (!cryp->total_in)
 		goto finish_req;
 
-	/*
-	 * Write first plain/ciphertext block to start the module
-	 * then let irq tasklet handle the rest of the data blocks.
-	 */
-	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, AES_BLOCK_SIZE,
-							    cryp->total_in), 0);
-	cryp->total_in -= min_t(size_t, AES_BLOCK_SIZE, cryp->total_in);
-
-	for (i = 0; i < AES_BLOCK_32; i++)
-		writel(block[i], cryp->base + STARFIVE_AES_AESDIO0R);
+	starfive_aes_dma_init(cryp);
 
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_AES_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-
-	return 0;
+	ret = starfive_aes_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
 
 finish_req:
-	starfive_aes_finish_req(cryp);
+	starfive_aes_finish_req(ctx);
 	return 0;
 }
 
-static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm)
+static int starfive_aes_aead_init_tfm(struct crypto_aead *tfm,
+				      const char *alg_name)
 {
 	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	struct crypto_tfm *aead = crypto_aead_tfm(tfm);
-	struct crypto_alg *alg = aead->__crt_alg;
 
 	ctx->cryp = starfive_cryp_find_dev(ctx);
 	if (!ctx->cryp)
 		return -ENODEV;
 
-	if (alg->cra_flags & CRYPTO_ALG_NEED_FALLBACK) {
-		ctx->aead_fbk = crypto_alloc_aead(alg->cra_name, 0,
-						  CRYPTO_ALG_NEED_FALLBACK);
-		if (IS_ERR(ctx->aead_fbk))
-			return dev_err_probe(cryp->dev, PTR_ERR(ctx->aead_fbk),
-					     "%s() failed to allocate fallback for %s\n",
-					     __func__, alg->cra_name);
-	}
+	ctx->aead_fbk = crypto_alloc_aead(alg_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->aead_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_ctx) +
-				sizeof(struct aead_request));
+	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
+				crypto_aead_reqsize(ctx->aead_fbk));
 
 	return 0;
 }
@@ -646,6 +741,44 @@ static void starfive_aes_aead_exit_tfm(struct crypto_aead *tfm)
 	crypto_free_aead(ctx->aead_fbk);
 }
 
+static bool starfive_aes_check_unaligned(struct starfive_cryp_dev *cryp,
+					 struct scatterlist *src,
+					 struct scatterlist *dst)
+{
+	struct scatterlist *tsg;
+	int i;
+
+	for_each_sg(src, tsg, sg_nents(src), i)
+		if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+		    !sg_is_last(tsg))
+			return true;
+
+	if (src != dst)
+		for_each_sg(dst, tsg, sg_nents(dst), i)
+			if (!IS_ALIGNED(tsg->length, AES_BLOCK_SIZE) &&
+			    !sg_is_last(tsg))
+				return true;
+
+	return false;
+}
+
+static int starfive_aes_do_fallback(struct skcipher_request *req, bool enc)
+{
+	struct starfive_cryp_ctx *ctx =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct skcipher_request *subreq = skcipher_request_ctx(req);
+
+	skcipher_request_set_tfm(subreq, ctx->skcipher_fbk);
+	skcipher_request_set_callback(subreq, req->base.flags,
+				      req->base.complete,
+				      req->base.data);
+	skcipher_request_set_crypt(subreq, req->src, req->dst,
+				   req->cryptlen, req->iv);
+
+	return enc ? crypto_skcipher_encrypt(subreq) :
+		     crypto_skcipher_decrypt(subreq);
+}
+
 static int starfive_aes_crypt(struct skcipher_request *req, unsigned long flags)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -660,32 +793,54 @@ static int starfive_aes_crypt(struct skcipher_request *req, unsigned long flags)
 		if (req->cryptlen & blocksize_align)
 			return -EINVAL;
 
+	if (starfive_aes_check_unaligned(cryp, req->src, req->dst))
+		return starfive_aes_do_fallback(req, is_encrypt(cryp));
+
 	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
 }
 
+static int starfive_aes_aead_do_fallback(struct aead_request *req, bool enc)
+{
+	struct starfive_cryp_ctx *ctx =
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct aead_request *subreq = aead_request_ctx(req);
+
+	aead_request_set_tfm(subreq, ctx->aead_fbk);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete,
+				  req->base.data);
+	aead_request_set_crypt(subreq, req->src, req->dst,
+			       req->cryptlen, req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	return enc ? crypto_aead_encrypt(subreq) :
+		     crypto_aead_decrypt(subreq);
+}
+
 static int starfive_aes_aead_crypt(struct aead_request *req, unsigned long flags)
 {
 	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
 	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *src, *dst, _src[2], _dst[2];
 
 	cryp->flags = flags;
 
-	/*
-	 * HW engine could not perform CCM tag verification on
-	 * non-blocksize aligned text, use fallback algo instead
+	/* aes-ccm does not support tag verification for non-aligned text,
+	 * use fallback for ccm decryption instead.
 	 */
-	if (ctx->aead_fbk && !is_encrypt(cryp)) {
-		struct aead_request *subreq = aead_request_ctx(req);
+	if (((cryp->flags & FLG_MODE_MASK) == STARFIVE_AES_MODE_CCM) &&
+	    !is_encrypt(cryp))
+		return starfive_aes_aead_do_fallback(req, 0);
 
-		aead_request_set_tfm(subreq, ctx->aead_fbk);
-		aead_request_set_callback(subreq, req->base.flags,
-					  req->base.complete, req->base.data);
-		aead_request_set_crypt(subreq, req->src,
-				       req->dst, req->cryptlen, req->iv);
-		aead_request_set_ad(subreq, req->assoclen);
+	src = scatterwalk_ffwd(_src, req->src, req->assoclen);
 
-		return crypto_aead_decrypt(subreq);
-	}
+	if (req->src == req->dst)
+		dst = src;
+	else
+		dst = scatterwalk_ffwd(_dst, req->dst, req->assoclen);
+
+	if (starfive_aes_check_unaligned(cryp, src, dst))
+		return starfive_aes_aead_do_fallback(req, is_encrypt(cryp));
 
 	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
 }
@@ -706,7 +861,7 @@ static int starfive_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-	return 0;
+	return crypto_skcipher_setkey(ctx->skcipher_fbk, key, keylen);
 }
 
 static int starfive_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
@@ -725,16 +880,20 @@ static int starfive_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-	if (ctx->aead_fbk)
-		return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
-
-	return 0;
+	return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
 }
 
 static int starfive_aes_gcm_setauthsize(struct crypto_aead *tfm,
 					unsigned int authsize)
 {
-	return crypto_gcm_check_authsize(authsize);
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = crypto_gcm_check_authsize(authsize);
+	if (ret)
+		return ret;
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
 }
 
 static int starfive_aes_ccm_setauthsize(struct crypto_aead *tfm,
@@ -820,9 +979,35 @@ static int starfive_aes_ccm_decrypt(struct aead_request *req)
 	return starfive_aes_aead_crypt(req, STARFIVE_AES_MODE_CCM);
 }
 
+static int starfive_aes_ecb_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "ecb(aes-generic)");
+}
+
+static int starfive_aes_cbc_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "cbc(aes-generic)");
+}
+
+static int starfive_aes_ctr_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_aes_init_tfm(tfm, "ctr(aes-generic)");
+}
+
+static int starfive_aes_ccm_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_aes_aead_init_tfm(tfm, "ccm_base(ctr(aes-generic),cbcmac(aes-generic))");
+}
+
+static int starfive_aes_gcm_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_aes_aead_init_tfm(tfm, "gcm_base(ctr(aes-generic),ghash-generic)");
+}
+
 static struct skcipher_engine_alg skcipher_algs[] = {
 {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_ecb_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_ecb_encrypt,
 	.base.decrypt			= starfive_aes_ecb_decrypt,
@@ -832,7 +1017,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "ecb(aes)",
 		.cra_driver_name	= "starfive-ecb-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -842,7 +1028,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.do_one_request = starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_cbc_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_cbc_encrypt,
 	.base.decrypt			= starfive_aes_cbc_decrypt,
@@ -853,7 +1040,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "cbc(aes)",
 		.cra_driver_name	= "starfive-cbc-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -863,7 +1051,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.do_one_request = starfive_aes_do_one_req,
 	},
 }, {
-	.base.init			= starfive_aes_init_tfm,
+	.base.init			= starfive_aes_ctr_init_tfm,
+	.base.exit			= starfive_aes_exit_tfm,
 	.base.setkey			= starfive_aes_setkey,
 	.base.encrypt			= starfive_aes_ctr_encrypt,
 	.base.decrypt			= starfive_aes_ctr_decrypt,
@@ -874,7 +1063,8 @@ static struct skcipher_engine_alg skcipher_algs[] = {
 		.cra_name		= "ctr(aes)",
 		.cra_driver_name	= "starfive-ctr-aes",
 		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask		= 0xf,
@@ -892,7 +1082,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.setauthsize		= starfive_aes_gcm_setauthsize,
 	.base.encrypt			= starfive_aes_gcm_encrypt,
 	.base.decrypt			= starfive_aes_gcm_decrypt,
-	.base.init			= starfive_aes_aead_init_tfm,
+	.base.init			= starfive_aes_gcm_init_tfm,
 	.base.exit			= starfive_aes_aead_exit_tfm,
 	.base.ivsize			= GCM_AES_IV_SIZE,
 	.base.maxauthsize		= AES_BLOCK_SIZE,
@@ -900,7 +1090,8 @@ static struct aead_engine_alg aead_algs[] = {
 		.cra_name               = "gcm(aes)",
 		.cra_driver_name        = "starfive-gcm-aes",
 		.cra_priority           = 200,
-		.cra_flags              = CRYPTO_ALG_ASYNC,
+		.cra_flags              = CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize          = 1,
 		.cra_ctxsize            = sizeof(struct starfive_cryp_ctx),
 		.cra_alignmask          = 0xf,
@@ -914,7 +1105,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.setauthsize		= starfive_aes_ccm_setauthsize,
 	.base.encrypt			= starfive_aes_ccm_encrypt,
 	.base.decrypt			= starfive_aes_ccm_decrypt,
-	.base.init			= starfive_aes_aead_init_tfm,
+	.base.init			= starfive_aes_ccm_init_tfm,
 	.base.exit			= starfive_aes_aead_exit_tfm,
 	.base.ivsize			= AES_BLOCK_SIZE,
 	.base.maxauthsize		= AES_BLOCK_SIZE,
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 2685f5483639..cc4139a88a0c 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -89,28 +89,10 @@ static void starfive_dma_cleanup(struct starfive_cryp_dev *cryp)
 	dma_release_channel(cryp->rx);
 }
 
-static irqreturn_t starfive_cryp_irq(int irq, void *priv)
-{
-	u32 status;
-	u32 mask;
-	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)priv;
-
-	mask = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	status = readl(cryp->base + STARFIVE_IE_FLAG_OFFSET);
-	if (status & STARFIVE_IE_FLAG_AES_DONE) {
-		mask |= STARFIVE_IE_MASK_AES_DONE;
-		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
-		tasklet_schedule(&cryp->aes_done);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int starfive_cryp_probe(struct platform_device *pdev)
 {
 	struct starfive_cryp_dev *cryp;
 	struct resource *res;
-	int irq;
 	int ret;
 
 	cryp = devm_kzalloc(&pdev->dev, sizeof(*cryp), GFP_KERNEL);
@@ -125,8 +107,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->base),
 				     "Error remapping memory for platform device\n");
 
-	tasklet_init(&cryp->aes_done, starfive_aes_done_task, (unsigned long)cryp);
-
 	cryp->phys_base = res->start;
 	cryp->dma_maxburst = 32;
 	cryp->side_chan = side_chan;
@@ -212,8 +192,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cryp->ahb);
 	reset_control_assert(cryp->rst);
 
-	tasklet_kill(&cryp->aes_done);
-
 	return ret;
 }
 
@@ -225,8 +203,6 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	starfive_hash_unregister_algs();
 	starfive_rsa_unregister_algs();
 
-	tasklet_kill(&cryp->aes_done);
-
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 60cc269a0f28..6e523e45cd9f 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -168,6 +168,7 @@ struct starfive_cryp_ctx {
 	struct crypto_akcipher			*akcipher_fbk;
 	struct crypto_ahash			*ahash_fbk;
 	struct crypto_aead			*aead_fbk;
+	struct crypto_skcipher			*skcipher_fbk;
 };
 
 struct starfive_cryp_dev {
@@ -185,10 +186,7 @@ struct starfive_cryp_dev {
 	struct dma_chan				*rx;
 	struct dma_slave_config			cfg_in;
 	struct dma_slave_config			cfg_out;
-	struct scatter_walk			in_walk;
-	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
-	struct tasklet_struct			aes_done;
 	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
@@ -236,6 +234,4 @@ void starfive_rsa_unregister_algs(void);
 
 int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
-
-void starfive_aes_done_task(unsigned long param);
 #endif
-- 
2.34.1


