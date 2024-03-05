Return-Path: <dmaengine+bounces-1261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D2871650
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FB28395E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352B7EEE3;
	Tue,  5 Mar 2024 07:10:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270F7E59D;
	Tue,  5 Mar 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622638; cv=fail; b=uRY8CRzxBcJq7IdPunE3s0zHDYyKftb6SUuf14kPW5nI+hquS8tIlBY75WKCKNvQn/3cttkfN1IzsmR+GL6H/8wxjRwNWWvW4OOQizvNLlnXTfxIDvnOmbtnNa9BPFJecTju1yY4Tf3MCnrES8uUnwvx0zys49dtUhAWUjXiu0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622638; c=relaxed/simple;
	bh=cO26IKOAbyQc77U1e+/3YTxNuw7RIXUAiuSwIbH2d1M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSS6+qwsEFU9LkMuXoUTsfovUahqddJiNt/mTJgDn2pSpl6IHAtJw3LQm7Jp9dHkNQjdg3CFXWmEd3wAQq75UmjvsrnBp+TKG4uWJS7dsVzHNrh49E5jArdKA6VNhKcUnDFP0YSA15zZjFn7eE11CrPn90X7KK9/aS6siwRXqDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK6lJ0WJUEIVAQ00BDjonb2MeuzEfeejBy0mxk6O7/OmPYxvmu0537zsBK7P655U/DfMXhuNNQ3RyQge0eMycnPR9kU8x+qZnDiVK+roIaUgISInQAY9TzM5yzZuWO3jYI9VFyEi3Aw8Wn+P4oS2Q5exwVVa5PSAj9zgTFkzjlWyjXPCIMBB5l++kLCbBo2VOK/ADhwnOG4Rk2oo51sLaJMJLX9BnIsrqMye3jOKxVymM2CfVIdPzmiFQfV/4x5bPBTkO1EWUnqpgXxXcRHlxWBtnMTKJlyARfR2vuK2DynRKnzzwlcDJfNqU/HCDALFEA5Ctvyg+4IDDNV4+0hDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+6iJQ1QE70/17cj4lkwfQHYdoRGK2aBsNuuLZGPuwo=;
 b=K3DVDXvd7cUWV/hxztpoXYZE7dTIcFJPxjE0LTHILFGAEje6VY5+W4AirrAmAeahRwIWDp9lxz82Oak78jB1DYTbRqVp63n6VeA4Vx6tRn86S3aDfs+7mPmhmdHhIvm6ELDrYBxwSwmykJgCogzosVOYJiRHTUMenwk6lW02tphpIkcuz20XtPT9234Jzq0c0piIN+t5TWdM36rqZE0FPSYrgTpCZq5bLKkU8Qfq0Vz42QL8Kt0SQoCcitXwSlYC4sBiInd8XdPD5I04nTb7o1PGL4SWLnLo773EqLO0ZdyWEyZLvJZVg76xodBi3oZlJpmOm7rVxTiRhXufuhXQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Tue, 5 Mar
 2024 07:10:24 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:24 +0000
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
Subject: [PATCH v4 2/7] crypto: starfive: Update hash dma usage
Date: Tue,  5 Mar 2024 15:10:01 +0800
Message-Id: <20240305071006.2181158-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1b1722-81e4-439c-d110-08dc3ce353b6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WrutaAvTcNrANabJgeyHIRK8loytaSdHtQHwxvUagsJA7eZMg3LOsIU0QUjfIF2QtKbwgJAp3EGhg/LYTmtHBRhOV4ihh7w9z0on1RCtaWGoj9NVEdxI0MojO6xiBkhO4Sg47tV29c6vroXaS1ImjOKgRAqZQZnLPRgox2epHx26KRuEt7b9mPFoMyr9ZomnvBK6WiD/20JRvhn5pYDdQt55fkgmEt1Tb0u5bAWufEMsn79h49MmjL2DYBbgaVQK1bqs7GjZ6KfCWYHBrmZJVijPiU0cH8OjK9VOWRNa0pE+TmWzVHT6fXjZswPpcc977I/UZ3dKLfHI6F7HTL+KlJOhe/rLy7G+w9TvQ0qq2eH47DbIfYdzXzpOgZ/Orfexvs0LhGIvMoKANDY4NyszGwKlJ3mfiwfHLchDWuBnBu9yuQF9xos68rn9K15D+oniBKIcJ9RxuDuY7p+bTQqmW5qp0C1VJPvxgUoayO2sk1oCzv7jUnjA7SrwstPTRaNWyMWQrp+19KDotvbtu3yZDw1BQAq6HWNkDs+9jpCBTRHDIEqTTOwEztzzgFpVYL4DJjgJDQX6Ne/LvNGT6513Hbnn/i+DJmzhw/DvmDuX4HzGFlGR27ATlf1jODaoyyVOhZz1jOgGtzHqbC7dvnhbSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b67/26X0NU2I4wMGQdURIuXFiy1oK0rHOEqFuP9RQL5+ccfqS4VyLy5n1brb?=
 =?us-ascii?Q?V3BrbGyAleqERFGGoVKEs9MxiwMmzNmc5pkC8QBmhIIxXp8tHf+JRoGxtRYe?=
 =?us-ascii?Q?E3e7b/oQlPiYG5QicSjYIjtPN1Bjz2qDLOEzurG+e4BX/IZXKaePQp1aomOI?=
 =?us-ascii?Q?5ij84xMxB+A00EDB2zaE8ufB9zzQGVIaz9HZR7PcVDyvRAFdTs3c7Eqvlrzq?=
 =?us-ascii?Q?IsfWuhWaXzyVxV0NrCr5fsTjQx8evMU8iQPxLMVHt+TSIq9q0Y2qjF3799Fg?=
 =?us-ascii?Q?9LyILp8D3HorEVAu0yLLpNY6ieAHJ682//ocPDVFUIsNtMn+KMS3hhgWZBs+?=
 =?us-ascii?Q?GR1lSOEv2jjUceVvepsuH5HbsmLYpm61dzFh52PwZ/br240jIxKfkgBLVLv5?=
 =?us-ascii?Q?SsyZaU7Qw8yYmlVVhEkuiNY0UFvODqX2dCnS9qS7RkliQ1SJ7rYh/TBoHRzc?=
 =?us-ascii?Q?E661ulpUMWTIY0+xRX/21sWsISFd8RtJavZzeqwvPzUEOpkSJG+f7lDeOgk6?=
 =?us-ascii?Q?02igBM9vs49/kce2X7ZtROCnxjQfWHrK90AUnqtMmh/pIZrRifhsOwdL4z1h?=
 =?us-ascii?Q?D+Kd44TohjEk+0XEQHwzV2R3jnBxlxAj1yPbR2fXRjdjRGKWYi0LwdR+WsXk?=
 =?us-ascii?Q?RZ1ZUVOkro/jPY+CPzME+FWXapkLrgGfWIIQ2g8tO/EOR0APF9T+zZemgqLj?=
 =?us-ascii?Q?pFODhpDvSTVzzWN0iKFXchACMV03qaTc4j7sny/FuQ+sC+6UA4IAnbNMtI6t?=
 =?us-ascii?Q?/6UBp2QBLIGSygVQyQBibSo7gQcqr0h0YKhHcxQRZOAjrSS/b126JeJu9TNe?=
 =?us-ascii?Q?bKnGambA4RmgXm13gaSLLjZ/f3MPUX0ZsEYq9qcdh6SIucryUGKmgkirGviN?=
 =?us-ascii?Q?yk+a0yUjYICCzosdXa7TU2Tar2KWatwwhLVxAJCdeSktu9oO5/xWtvT554MD?=
 =?us-ascii?Q?5ibfFU3ZeDtyTdZnFhN9M2rRWTKH19miY+3rfP3CqbgRwbBqC7N1AY+0LMok?=
 =?us-ascii?Q?QFqRsjjXi7rYOArP4lGTx92ztxtYWlMiNjPtRB/1mC6MWpK5rc8YjmD2Ia9i?=
 =?us-ascii?Q?wtxRvyNebgLhyRtVxUo3QqrlJ0FYMlpLDwrY7gf1+WNXABzPbFpKmG4hARxx?=
 =?us-ascii?Q?8edudmzUhyiVEWiS2t+OpzSPle1mQa3ul4z/kM8mwe7gQumPNysnIpcSdz0v?=
 =?us-ascii?Q?UlPX3y8ZWopg0ZhwUG/gzYfPDxgecJo24vhwM1VJd53QNvoIeoaGaXhwfPZ7?=
 =?us-ascii?Q?WXSWIYcIuJscLkcrThI/apnuYsf7vbSnYugEpumOYYagja3yhFRqZ59BYavT?=
 =?us-ascii?Q?eTw5053IhuV744MB/7l8iLXoLJJKofX6ZUr3Z+LJOlz8a4SxzQGoHmORkoxY?=
 =?us-ascii?Q?MPdKgxtPayZfTjREzEeqdDJThYQdpjUtWtUPYErEXVsoo+FGwtq4ckSX8Ycz?=
 =?us-ascii?Q?JPJpUHc5Ed89BF+38RDYvZmIxnrn8/TVtaQdfiNw41HDjCSCskw4MIK4HvWd?=
 =?us-ascii?Q?EPOHX+e1+UppnpjRpeoDc/x3jC4l3JeESbqDkpMYVQq2ExGz6Q0Ag1DkL38f?=
 =?us-ascii?Q?pvJ0u/kmJCyQhJE0gPmUaU3EnOJqyWckNo/7UCHN5c15NI0whDNhplZwM8Ut?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1b1722-81e4-439c-d110-08dc3ce353b6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:24.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4AdQcKM9PJsoDAZ1AJTqpvBs2Z/SBiSmUx1HypumT65Bg6/v/HJTbiysickQj4gqniMzSE0JxKMuZRp9wsseSN73iIrL6Tk1IGjYpCOTfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Current hash uses sw fallback for non-word aligned input scatterlists.
Add support for unaligned cases utilizing the data valid mask for dma.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.c |   9 -
 drivers/crypto/starfive/jh7110-cryp.h |   4 +-
 drivers/crypto/starfive/jh7110-hash.c | 275 +++++++++++---------------
 3 files changed, 112 insertions(+), 176 deletions(-)

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
index 6cdf6db5d904..82327e21d340 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -91,6 +91,7 @@ union starfive_hash_csr {
 #define STARFIVE_HASH_KEY_DONE			BIT(13)
 		u32 key_done			:1;
 		u32 key_flag			:1;
+#define STARFIVE_HASH_HMAC_DONE			BIT(15)
 		u32 hmac_done			:1;
 #define STARFIVE_HASH_BUSY			BIT(16)
 		u32 busy			:1;
@@ -189,7 +190,7 @@ struct starfive_cryp_dev {
 	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
 	struct tasklet_struct			aes_done;
-	struct tasklet_struct			hash_done;
+	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
 	size_t					total_out;
@@ -237,6 +238,5 @@ void starfive_rsa_unregister_algs(void);
 int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
 
-void starfive_hash_done_task(unsigned long param);
 void starfive_aes_done_task(unsigned long param);
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index b6d1808012ca..2c60a1047bc3 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -36,15 +36,22 @@
 #define STARFIVE_HASH_BUFLEN		SHA512_BLOCK_SIZE
 #define STARFIVE_HASH_RESET		0x2
 
-static inline int starfive_hash_wait_busy(struct starfive_cryp_ctx *ctx)
+static inline int starfive_hash_wait_busy(struct starfive_cryp_dev *cryp)
 {
-	struct starfive_cryp_dev *cryp = ctx->cryp;
 	u32 status;
 
 	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
 					  !(status & STARFIVE_HASH_BUSY), 10, 100000);
 }
 
+static inline int starfive_hash_wait_hmac_done(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_HASH_SHACSR, status,
+					  (status & STARFIVE_HASH_HMAC_DONE), 10, 100000);
+}
+
 static inline int starfive_hash_wait_key_done(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
@@ -84,64 +91,26 @@ static int starfive_hash_hmac_key(struct starfive_cryp_ctx *ctx)
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
+	struct starfive_cryp_dev *cryp = param;
 
-	writel(rctx->total, cryp->base + STARFIVE_DMA_IN_LEN_OFFSET);
-
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
@@ -149,50 +118,48 @@ static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx)
 
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
@@ -215,58 +182,74 @@ static int starfive_hash_copy_hash(struct ahash_request *req)
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
+	struct ahash_request *req = container_of(areq, struct ahash_request,
+						 base);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
 
-	if (!total)
-		return 0;
+	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
 
-	if (!IS_ALIGNED(total, align))
-		return -EINVAL;
+	if (starfive_hash_wait_busy(cryp))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware\n");
 
-	while (sg) {
-		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
-			return -EINVAL;
+	rctx->csr.hash.v = 0;
+	rctx->csr.hash.mode = ctx->hash_mode;
 
-		if (!IS_ALIGNED(sg->length, align))
-			return -EINVAL;
+	if (ctx->is_hmac) {
+		ret = starfive_hash_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.hash.start = 1;
+		rctx->csr.hash.firstb = 1;
+		writel(rctx->csr.hash.v, cryp->base + STARFIVE_HASH_SHACSR);
+	}
+
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
+
+	starfive_hash_dma_init(cryp);
+
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents = dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents == 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
 
-		len += sg->length;
-		sg = sg_next(sg);
+		ret = starfive_hash_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
 	}
 
-	if (len != total)
-		return -EINVAL;
+hash_start:
+	starfive_hash_start(cryp);
 
-	return 0;
-}
+	if (starfive_hash_wait_busy(cryp))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error generating digest\n");
 
-static int starfive_hash_one_request(struct crypto_engine *engine, void *areq)
-{
-	struct ahash_request *req = container_of(areq, struct ahash_request,
-						 base);
-	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct starfive_cryp_dev *cryp = ctx->cryp;
+	if (ctx->is_hmac)
+		cryp->err = starfive_hash_wait_hmac_done(cryp);
 
-	if (!cryp)
-		return -ENODEV;
+	starfive_hash_done_task(cryp);
 
-	return starfive_hash_xmit(ctx);
+	return 0;
 }
 
 static int starfive_hash_init(struct ahash_request *req)
@@ -337,22 +320,6 @@ static int starfive_hash_finup(struct ahash_request *req)
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
@@ -370,9 +337,6 @@ static int starfive_hash_digest(struct ahash_request *req)
 	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
 	ctx->rctx = rctx;
 
-	if (starfive_hash_check_aligned(rctx->in_sg, rctx->total, rctx->blksize))
-		return starfive_hash_digest_fb(req);
-
 	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
 }
 
@@ -406,7 +370,8 @@ static int starfive_hash_import(struct ahash_request *req, const void *in)
 
 static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 				  const char *alg_name,
-				  unsigned int mode)
+				  unsigned int mode,
+				  bool is_hmac)
 {
 	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
 
@@ -426,7 +391,7 @@ static int starfive_hash_init_tfm(struct crypto_ahash *hash,
 	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
 				 crypto_ahash_reqsize(ctx->ahash_fbk));
 
-	ctx->keylen = 0;
+	ctx->is_hmac = is_hmac;
 	ctx->hash_mode = mode;
 
 	return 0;
@@ -529,81 +494,61 @@ static int starfive_hash_setkey(struct crypto_ahash *hash,
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


