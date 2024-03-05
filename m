Return-Path: <dmaengine+bounces-1264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A187165E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CF5B248C1
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E66F7F7C9;
	Tue,  5 Mar 2024 07:10:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB97F47D;
	Tue,  5 Mar 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622646; cv=fail; b=TgprKE65RN3CTLSMk8JBCAB7l+0peOfqphkp6mQqPip9pDf565L3HVMtOOxk7FJ92sTICR38DE2JDeaLQHcPfnvG0J+n7rnjJWoorh8kMu/0wqpIFXDt6UB1GAC2Kodd+axsHry6wAZ1nt1gAcjsxkPkmqLGnfh2qd2Mc1tC/Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622646; c=relaxed/simple;
	bh=SP9s4IWAmCa9uIWewEOsvI4WNBugJEAmZCb9swNHfgE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qRPP+z3elEWsZ+wJmzxTmj3K/11ItvnKJv7z02w8pHT9PrM3xDRVm8A4NGVa+8fCkwK1yVIe+Nb2Ifh4edIhEZRV0kPwShxJGyh2jnmH64JSZgXFbwWE6DvWRIfthFsbJI2oYCTOij9d+hj4tQps0H2JQ9W4iCwJ0EcWThEflGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPVcp1uPFZMe/sFTmtNuDBwuA6hvBVA3VUBgRYoLyGNSfwmbgV5cXB3NvbUmJ0yt9J19BkS4Id7L9K+Y+On/uBRSz5KyLK5GxnCI1cdHFJqV9co0ddrNyg1NDMCBdDsPFNiCkM3k2+k2FXXzncRbwj23hjZc2z0XAZcJHqbz0vxd7DMsHZ7MNc0urWouiKIlHQpu4gRVSu/qvQnO4UgfIx7qrKUMrdL/IbUlgivwRh1S03ialv9QaHjtkfKMOiPxN3UiyK/OTDj5SBs9W1cnyP5BSMXop6HYBpueUoYqT94/1VnIk35vCJ5thFR3hnKKuuwdTYBLAtmEkHV3oIR5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vJT8MbQuu9y2fikh8Ow622nlbI+lsXumaG0qj/UYN4=;
 b=HzGnbeM+CM7BRQ7ZgUR481kC4YIhiWsnW5VfUXza7FBB+b/kxnbj/EMSGXnKZXsa2ywu6gHr/okFUrZAmzDoMKShYp4t0PLiqxqnowFjbjArYy4iYqtuFhYVasV5GZcIsW3KPl35+WiIl8nnl5nJVVnUIGs8JX1XidN5gak2mUBPubXqgXRzpqwMFJ4N0XQbSvsFiHgWT8Fd64xzJFoi8KH+cW3Sc2LeLD7feRZYiIvIZpY3OJen7nghvb67RlbgJxC/or9qq5vmeo2YhmIlM/JFco1J+mjKU9QZj0x2gA9vaonAzIurOlKzGTLTC8eNxrSBlfwI6PAaBTIO7/9iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0686.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 5 Mar
 2024 07:10:34 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:34 +0000
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
Subject: [PATCH v4 6/7] crypto: starfive: Add sm3 support for JH8100
Date: Tue,  5 Mar 2024 15:10:05 +0800
Message-Id: <20240305071006.2181158-7-jiajie.ho@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0686:EE_
X-MS-Office365-Filtering-Correlation-Id: 866f8ca4-7287-44d3-94f7-08dc3ce359cb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RxUdeIqpw0lUwIM09tipKX14rpwFhNkbJwwIRMJa5a/kydZAoBYswV8c3i0juNOjDpt0Yfv8hWjEABgcIRmHRFd3jPK3MV88rudCEKGa8MeKCKOzP1/eLp+IrVWVpBfdmKyI0HoQYUFXTUw4dc7PrTcvhb7BjDFLYJEEAyNNafeY9sDEv+bYpt3DX6xp6VJgmStkWBYgjBa4uAO1c2rYzm4VgOktglO40dtG8O3OhxCgFxzRssLRmJLYF7caXsD8gCg7V4XdyFplhJ/9ce1l1vwaIpRP87wJDF7rbI85SlzxMUi/qeWzUjfYQ3fPRYexGBLTp1Sb6eEWPc97pX04TC9hp2YRY0muHCYOO/8qtJ5wtjbcWa9b29P8TGSWnJf6p9GxgwI/JWCD0ot9D9gzZg/C3LnN/G5jE4hZnVXdqIesd3EVQ7pCy6alao9S8w5Uou5SR3waBrGdGod1zjfqPA0cPo9ggTR+0/UhKfI4IYWy5dSCnNoRgFtFRWVnOtks/kn1dRPXgtHNjqMLMI/IBdSnng/eHn9ccX+x78DQQEkrI26TsfnOYq4URz/3qHri9sqLdlteS3XOpnMXw4JGLAWCs7kxOk8m6lOTJWEqDxwyEem8VqpV8LOVK6cJmYv/1bJRlBJC4AGV2TEqJ9nbeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EgTuEahkxngN0qnRfruo1xE/sZmZkiwweOr3g+b7BU1ayVxwbEQVB0j49zqj?=
 =?us-ascii?Q?wJi4s2iLSY879HlBGQu7mhz5vnxu6ZA2NaBz/ZtDWgvD6Nn6QXxDxUHl+27g?=
 =?us-ascii?Q?SfVa/JlixW8F6fy0j1iym+c3lkz36DCFoF2oWYPWn2ittqDlVAvDh3syL/Od?=
 =?us-ascii?Q?1A2sTukWTddb8NN948yfThKnmoGH1o8F/FvHGT7sFy8X32b8uAIMbNjzNWG9?=
 =?us-ascii?Q?Lae5ae3H6o3TzXHZqX9D0vNGtL+nsfSYKCcYKGeyKcKDGjr0Qf0ZQZc6jlAz?=
 =?us-ascii?Q?Nls7A0ra2vaHG88bMlt4vgJMza2j1YwKEZpsdJEFMZu3DXXn5npteA+OqgSv?=
 =?us-ascii?Q?1lsnUtp7OBlNG5Ij9i7XjrqpXepBzQ5mSgwlkDXxXZRB1oar/bxbhmF6H90S?=
 =?us-ascii?Q?S3ptyksf6WcpK7fIiPMz6akckZnsRxv1Tz7pcn/j1XbsSATAc3/veRE32434?=
 =?us-ascii?Q?o83OUuT7nBMBn+oa7HVR6JFXzy1tItVKdOfrZIlcyBLf74lgW48WbOrMQa5m?=
 =?us-ascii?Q?3lOFYI7ycgeVWRZiKKYQlXudc3N4SEdAk2eSf6EIjhB5lyj2r7CFeeNo0ca5?=
 =?us-ascii?Q?FTOvH7N8+9wr5x7ltM/HrZLJDKU8vaiQU3mCIH4far2s59O/gbDC5b6gZNQd?=
 =?us-ascii?Q?COj6upqBS/mIblEIjhEXkagmu508HVV0jwzqDludJkcwGIqlxI7h4Zy5Fdxj?=
 =?us-ascii?Q?9XrmR+eSKhKCOCjwezLFnarC1EZgN7DZ2VCq53ioH3BKjp2dbsa1AL9rB3hm?=
 =?us-ascii?Q?7l8NGohVFZ/2yi1KrMfXmgmUrsiHABoI374ycpmmvWCy4eOiKC5hj4X1jp+L?=
 =?us-ascii?Q?/+lPGiec2nnMSeupZyiuEnSBNL4H51Fg99OjPiAqZIUcPi96hEQxRmJOchtZ?=
 =?us-ascii?Q?1Lx4NC4HNlvxE1ollVWfYpD+XP1pQTo6ZEz2gxA7PVL5wQUz7RrHjhfB5d2O?=
 =?us-ascii?Q?MRAaieGOaPfaphXic98aGOr81edVYegUEW50s+OVPa6u6eram65fzqeXvJpM?=
 =?us-ascii?Q?ZMhhT2ZrI6zAq9QqivwXcYzltYa3jEK23Gnsb4pWzxH8mGBVjnzn37EVILdV?=
 =?us-ascii?Q?IPZ569GnS124R8Q+eAUkPbkjdJZVisGTGED4DTU/b3C9VHz8Oy/llklzJuHm?=
 =?us-ascii?Q?WEKIkVQE+GSyMKMnB5YgJf/iCN4Mk9AT5nqEcYBnTJGtW4elJlZVih06HdMK?=
 =?us-ascii?Q?HsLWgBcS3blUTwacOC3ePbXa5wH2PuU+fbe8/6gi+OGWbGxq4an+Ye/Dksyh?=
 =?us-ascii?Q?guSz6DgwH5AHjcVrblROG+ggsKF7XT4uvgfBIeeKrrULwblWIQOuAREbHS0i?=
 =?us-ascii?Q?c32jeQjRIGOEAG4L0MXrqqDZulJr2aPNOwc+FQzbsqM25xY5HIQE5NsolzwL?=
 =?us-ascii?Q?VJVK2MTUWGDiK///uPhPi3on9/WTVC/Ac6uOHSIlDyho7F5O2Faw4s40xPpT?=
 =?us-ascii?Q?QVQpR1BCHWB3MIhQftaQK8nsaZSrBikKeKlx4Azvdh4gaDyMWqiUdkt6SCHA?=
 =?us-ascii?Q?jXJWLB/c1TgYsF9nwUBqHltJ54e5mcaGcX3FDfMIz22kTumLoCGYKNf6VwMG?=
 =?us-ascii?Q?VJxVqNPmAQNr3AMHByngpoCenumXgQPxRIEyWPGZXq9HgMv8bl1TeBfBDMdK?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f8ca4-7287-44d3-94f7-08dc3ce359cb
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:34.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7V9HhNxhdP5DNmbFuf3nDF0wWZxifCVzHV2BTt1FdA3lmbfsxM/h4xdAWwNIiWL/McyDObp3AUhbAWRkDHm88OZ3qmP9WxEgVtk/XGVGL18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0686

Add driver support for SM3 hash/HMAC for JH8100 SoC. JH8100 contains a
separate SM algo engine and new dedicated dma that supports 64-bit
address access.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |  25 +-
 drivers/crypto/starfive/Makefile      |   5 +-
 drivers/crypto/starfive/jh7110-aes.c  |   3 +
 drivers/crypto/starfive/jh7110-cryp.c |  28 +-
 drivers/crypto/starfive/jh7110-cryp.h |  67 +++-
 drivers/crypto/starfive/jh7110-hash.c |  45 ++-
 drivers/crypto/starfive/jh8100-sm3.c  | 544 ++++++++++++++++++++++++++
 7 files changed, 696 insertions(+), 21 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index 0fe389e9f932..e6bf02d0ed1f 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -5,7 +5,7 @@
 config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
 	depends on (SOC_STARFIVE && AMBA_PL08X) || COMPILE_TEST
-	depends on HAS_DMA
+	depends on HAS_DMA && !CRYPTO_DEV_JH8100
 	select CRYPTO_ENGINE
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
@@ -24,3 +24,26 @@ config CRYPTO_DEV_JH7110
 	  skciphers, AEAD and hash functions.
 
 	  If you choose 'M' here, this module will be called jh7110-crypto.
+
+config CRYPTO_DEV_JH8100
+	tristate "StarFive JH8100 cryptographic engine drivers"
+	depends on (SOC_STARFIVE && DW_AXI_DMAC) || COMPILE_TEST
+	depends on HAS_DMA
+	select CRYPTO_ENGINE
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SM3_GENERIC
+	select CRYPTO_RSA
+	select CRYPTO_AES
+	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_CTR
+	help
+	  Support for StarFive JH8100 crypto hardware acceleration engine.
+	  This module provides additional support for SM2 signature verification,
+	  SM3 hash/hmac functions and SM4 skcipher.
+
+	  If you choose 'M' here, this module will be called jh8100-crypto.
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 8c137afe58ad..867ce035af19 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
-jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o
+jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
+
+obj-$(CONFIG_CRYPTO_DEV_JH8100) += jh8100-crypto.o
+jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index 72b7d46150d5..3ee782b6c028 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -413,6 +413,9 @@ static void starfive_aes_dma_done(void *param)
 
 static void starfive_aes_dma_init(struct starfive_cryp_dev *cryp)
 {
+	memset(&cryp->cfg_in, 0, sizeof(struct dma_slave_config));
+	memset(&cryp->cfg_out, 0, sizeof(struct dma_slave_config));
+
 	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
 	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index e4dfed7ee0b0..19bbcaaec18d 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -99,6 +100,8 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (!cryp)
 		return -ENOMEM;
 
+	cryp->type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+
 	platform_set_drvdata(pdev, cryp);
 	cryp->dev = &pdev->dev;
 
@@ -153,7 +156,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_aes;
 
-	ret = starfive_hash_register_algs();
+	ret = starfive_hash_register_algs(cryp);
 	if (ret)
 		goto err_algs_hash;
 
@@ -161,10 +164,18 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_rsa;
 
+	if (cryp->type == STARFIVE_CRYPTO_JH8100) {
+		ret = starfive_sm3_register_algs();
+		if (ret)
+			goto err_algs_sm3;
+	}
+
 	return 0;
 
+err_algs_sm3:
+	starfive_rsa_unregister_algs();
 err_algs_rsa:
-	starfive_hash_unregister_algs();
+	starfive_hash_unregister_algs(cryp);
 err_algs_hash:
 	starfive_aes_unregister_algs();
 err_algs_aes:
@@ -190,9 +201,12 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	struct starfive_cryp_dev *cryp = platform_get_drvdata(pdev);
 
 	starfive_aes_unregister_algs();
-	starfive_hash_unregister_algs();
+	starfive_hash_unregister_algs(cryp);
 	starfive_rsa_unregister_algs();
 
+	if (cryp->type == STARFIVE_CRYPTO_JH8100)
+		starfive_sm3_unregister_algs();
+
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
@@ -208,7 +222,13 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id starfive_dt_ids[] __maybe_unused = {
-	{ .compatible = "starfive,jh7110-crypto", .data = NULL},
+	{
+		.compatible = "starfive,jh7110-crypto",
+		.data = (const void *)STARFIVE_CRYPTO_JH7110,
+	}, {
+		.compatible = "starfive,jh8100-crypto",
+		.data = (const void *)STARFIVE_CRYPTO_JH8100,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, starfive_dt_ids);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index 494a74f52706..ae523ec48591 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -19,18 +19,34 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
+#define STARFIVE_SM_ALG_CR_OFFSET		0x4000
+#define STARFIVE_SM_IE_MASK_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x4)
+#define STARFIVE_SM_IE_FLAG_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x8)
+#define STARFIVE_SM_DMA_IN_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0xc)
+#define STARFIVE_SM_DMA_OUT_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x10)
+#define STARFIVE_SM_ALG_FIFO_IN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x20)
+#define STARFIVE_SM_ALG_FIFO_OUT_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x28)
+
 #define STARFIVE_IE_MASK_AES_DONE		0x1
 #define STARFIVE_IE_MASK_HASH_DONE		0x4
 #define STARFIVE_IE_MASK_PKA_DONE		0x8
 #define STARFIVE_IE_FLAG_AES_DONE		0x1
 #define STARFIVE_IE_FLAG_HASH_DONE		0x4
 #define STARFIVE_IE_FLAG_PKA_DONE		0x8
+#define STARFIVE_SM_IE_MASK_SM3_DONE		0x2
+#define STARFIVE_SM_IE_FLAG_SM3_DONE		0x2
 
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
 #define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
 #define STARFIVE_AES_IV_LEN			AES_BLOCK_SIZE
 #define STARFIVE_AES_CTR_LEN			AES_BLOCK_SIZE
 
+enum starfive_crypto_type {
+	STARFIVE_CRYPTO_UNKNOWN		= 0,
+	STARFIVE_CRYPTO_JH7110,
+	STARFIVE_CRYPTO_JH8100,
+};
+
 union starfive_aes_csr {
 	u32 v;
 	struct {
@@ -68,6 +84,20 @@ union starfive_aes_csr {
 	};
 };
 
+union starfive_sm_alg_cr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 sm4_dma_en			:1;
+		u32 sm3_dma_en			:1;
+		u32 rsvd_0			:1;
+		u32 alg_done			:1;
+		u32 rsvd_1			:3;
+		u32 clear			:1;
+		u32 rsvd_2			:23;
+	};
+};
+
 union starfive_hash_csr {
 	u32 v;
 	struct {
@@ -133,6 +163,33 @@ union starfive_pka_casr {
 	};
 };
 
+union starfive_sm3_csr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 ie				:1;
+		u32 firstb			:1;
+#define STARFIVE_SM3_MODE			0x0
+		u32 mode			:3;
+		u32 rsvd_0			:1;
+		u32 final			:1;
+		u32 rsvd_1			:2;
+#define STARFIVE_SM3_HMAC_FLAGS			0x800
+		u32 hmac			:1;
+		u32 rsvd_2			:1;
+#define STARFIVE_SM3_KEY_DONE			BIT(13)
+		u32 key_done			:1;
+		u32 key_flag			:1;
+#define STARFIVE_SM3_HMAC_DONE			BIT(15)
+		u32 hmac_done			:1;
+#define STARFIVE_SM3_BUSY			BIT(16)
+		u32 busy			:1;
+		u32 hashdone			:1;
+		u32 rsvd_3			:14;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -178,7 +235,7 @@ struct starfive_cryp_dev {
 	struct clk				*hclk;
 	struct clk				*ahb;
 	struct reset_control			*rst;
-
+	enum starfive_crypto_type		type;
 	void __iomem				*base;
 	phys_addr_t				phys_base;
 
@@ -211,6 +268,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_hash_csr		hash;
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
+		union starfive_sm3_csr		sm3;
 	} csr;
 
 	struct scatterlist			*in_sg;
@@ -227,12 +285,15 @@ struct starfive_cryp_request_ctx {
 
 struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
 
-int starfive_hash_register_algs(void);
-void starfive_hash_unregister_algs(void);
+int starfive_hash_register_algs(struct starfive_cryp_dev *cryp);
+void starfive_hash_unregister_algs(struct starfive_cryp_dev *cryp);
 
 int starfive_rsa_register_algs(void);
 void starfive_rsa_unregister_algs(void);
 
 int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
+
+int starfive_sm3_register_algs(void);
+void starfive_sm3_unregister_algs(void);
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index 2c60a1047bc3..9673cdbfb554 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -110,6 +110,8 @@ static void starfive_hash_dma_callback(void *param)
 
 static void starfive_hash_dma_init(struct starfive_cryp_dev *cryp)
 {
+	memset(&cryp->cfg_in, 0, sizeof(struct dma_slave_config));
+
 	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
@@ -515,12 +517,6 @@ static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
 				      STARFIVE_HASH_SHA512, 0);
 }
 
-static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
-{
-	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3, 0);
-}
-
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
@@ -545,13 +541,19 @@ static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
 				      STARFIVE_HASH_SHA512, 1);
 }
 
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sm3-generic",
+				      STARFIVE_HASH_SM3, 0);
+}
+
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
 				      STARFIVE_HASH_SM3, 1);
 }
 
-static struct ahash_engine_alg algs_sha2_sm3[] = {
+static struct ahash_engine_alg algs_sha2[] = {
 {
 	.base.init     = starfive_hash_init,
 	.base.update   = starfive_hash_update,
@@ -780,7 +782,11 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 	.op = {
 		.do_one_request = starfive_hash_one_request,
 	},
-}, {
+},
+};
+
+static struct ahash_engine_alg algs_sm3[] = {
+{
 	.base.init     = starfive_hash_init,
 	.base.update   = starfive_hash_update,
 	.base.final    = starfive_hash_final,
@@ -840,12 +846,27 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 },
 };
 
-int starfive_hash_register_algs(void)
+int starfive_hash_register_algs(struct starfive_cryp_dev *cryp)
 {
-	return crypto_engine_register_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
+	int ret;
+
+	ret = crypto_engine_register_ahashes(algs_sha2, ARRAY_SIZE(algs_sha2));
+	if (ret)
+		return ret;
+
+	if (cryp->type == STARFIVE_CRYPTO_JH7110) {
+		ret = crypto_engine_register_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+		if (ret)
+			crypto_engine_unregister_ahashes(algs_sha2, ARRAY_SIZE(algs_sha2));
+	}
+
+	return ret;
 }
 
-void starfive_hash_unregister_algs(void)
+void starfive_hash_unregister_algs(struct starfive_cryp_dev *cryp)
 {
-	crypto_engine_unregister_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
+	crypto_engine_unregister_ahashes(algs_sha2, ARRAY_SIZE(algs_sha2));
+
+	if (cryp->type == STARFIVE_CRYPTO_JH7110)
+		crypto_engine_unregister_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
 }
diff --git a/drivers/crypto/starfive/jh8100-sm3.c b/drivers/crypto/starfive/jh8100-sm3.c
new file mode 100644
index 000000000000..4c7685d25851
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm3.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SM3 Hash function and HMAC support for StarFive driver
+ *
+ * Copyright (c) 2022 - 2023 StarFive Technology
+ *
+ */
+
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+#include "jh7110-cryp.h"
+#include <linux/crypto.h>
+#include <linux/dma/dw_axi.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#define STARFIVE_SM3_REGS_OFFSET	0x4200
+#define STARFIVE_SM3_CSR		(STARFIVE_SM3_REGS_OFFSET + 0x0)
+#define STARFIVE_SM3_WDR		(STARFIVE_SM3_REGS_OFFSET + 0x4)
+#define STARFIVE_SM3_RDR		(STARFIVE_SM3_REGS_OFFSET + 0x8)
+#define STARFIVE_SM3_WSR		(STARFIVE_SM3_REGS_OFFSET + 0xC)
+#define STARFIVE_SM3_WLEN3		(STARFIVE_SM3_REGS_OFFSET + 0x10)
+#define STARFIVE_SM3_WLEN2		(STARFIVE_SM3_REGS_OFFSET + 0x14)
+#define STARFIVE_SM3_WLEN1		(STARFIVE_SM3_REGS_OFFSET + 0x18)
+#define STARFIVE_SM3_WLEN0		(STARFIVE_SM3_REGS_OFFSET + 0x1C)
+#define STARFIVE_SM3_WKR		(STARFIVE_SM3_REGS_OFFSET + 0x20)
+#define STARFIVE_SM3_WKLEN		(STARFIVE_SM3_REGS_OFFSET + 0x24)
+
+#define STARFIVE_SM3_BUFLEN		SHA512_BLOCK_SIZE
+#define STARFIVE_SM3_RESET		0x2
+
+static inline int starfive_sm3_wait_busy(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  !(status & STARFIVE_SM3_BUSY), 10, 100000);
+}
+
+static inline int starfive_sm3_wait_hmac_done(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  (status & STARFIVE_SM3_HMAC_DONE), 10, 100000);
+}
+
+static inline int starfive_sm3_wait_key_done(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  (status & STARFIVE_SM3_KEY_DONE), 10, 100000);
+}
+
+static int starfive_sm3_hmac_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int klen = ctx->keylen, loop;
+	unsigned int *key = (unsigned int *)ctx->key;
+	unsigned char *cl;
+
+	writel(ctx->keylen, cryp->base + STARFIVE_SM3_WKLEN);
+
+	rctx->csr.sm3.hmac = 1;
+	rctx->csr.sm3.key_flag = 1;
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	for (loop = 0; loop < klen / sizeof(unsigned int); loop++, key++)
+		writel(*key, cryp->base + STARFIVE_SM3_WKR);
+
+	if (klen & 0x3) {
+		cl = (unsigned char *)key;
+		for (loop = 0; loop < (klen & 0x3); loop++, cl++)
+			writeb(*cl, cryp->base + STARFIVE_SM3_WKR);
+	}
+
+	if (starfive_sm3_wait_key_done(cryp))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "starfive_sm3_wait_key_done error\n");
+
+	return 0;
+}
+
+static void starfive_sm3_start(struct starfive_cryp_dev *cryp)
+{
+	union starfive_sm3_csr csr;
+
+	csr.v = readl(cryp->base + STARFIVE_SM3_CSR);
+	csr.firstb = 0;
+	csr.final = 1;
+	writel(csr.v, cryp->base + STARFIVE_SM3_CSR);
+}
+
+static void starfive_sm3_dma_callback(void *param)
+{
+	struct starfive_cryp_dev *cryp = param;
+
+	complete(&cryp->dma_done);
+}
+
+static void starfive_sm3_dma_init(struct starfive_cryp_dev *cryp)
+{
+	struct dw_axi_peripheral_config periph_conf = {};
+
+	memset(&cryp->cfg_in, 0, sizeof(struct dma_slave_config));
+	periph_conf.quirks = DWAXIDMAC_STARFIVE_SM_ALGO;
+
+	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr = cryp->phys_base + STARFIVE_SM_ALG_FIFO_IN_OFFSET;
+	cryp->cfg_in.peripheral_config = &periph_conf;
+	cryp->cfg_in.peripheral_size = sizeof(struct dw_axi_peripheral_config);
+
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
+
+	init_completion(&cryp->dma_done);
+}
+
+static int starfive_sm3_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *sg)
+{
+	struct dma_async_tx_descriptor *in_desc;
+	union  starfive_sm_alg_cr alg_cr;
+	int ret = 0;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.sm3_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_SM_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) = ALIGN(sg_dma_len(sg), sizeof(u32));
+
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback = starfive_sm3_dma_callback;
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
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_sm3_copy_hash(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	int count, *data;
+	int mlen;
+
+	if (!req->result)
+		return 0;
+
+	mlen = rctx->digsize / sizeof(u32);
+	data = (u32 *)req->result;
+
+	for (count = 0; count < mlen; count++)
+		data[count] = readl(ctx->cryp->base + STARFIVE_SM3_RDR);
+
+	return 0;
+}
+
+static void starfive_sm3_done_task(struct starfive_cryp_dev *cryp)
+{
+	int err = cryp->err;
+
+	if (!err)
+		err = starfive_sm3_copy_hash(cryp->req.hreq);
+
+	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
+}
+
+static int starfive_sm3_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req =
+		container_of(areq, struct ahash_request, base);
+	struct starfive_cryp_ctx *ctx =
+		crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
+
+	rctx->csr.sm3.v = 0;
+	rctx->csr.sm3.reset = 1;
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	if (starfive_sm3_wait_busy(cryp))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error resetting hardware.\n");
+
+	cryp->err = 0;
+	rctx->csr.sm3.v = 0;
+	rctx->csr.sm3.mode = ctx->hash_mode;
+
+	if (ctx->is_hmac) {
+		ret = starfive_sm3_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.sm3.start = 1;
+		rctx->csr.sm3.firstb = 1;
+		writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+	}
+
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
+
+	starfive_sm3_dma_init(cryp);
+
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents = dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents == 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
+
+		ret = starfive_sm3_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_sm3_start(cryp);
+
+	if (starfive_sm3_wait_busy(cryp))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error generating digest.\n");
+
+	if (ctx->is_hmac)
+		cryp->err = starfive_sm3_wait_hmac_done(cryp);
+
+	starfive_sm3_done_task(cryp);
+
+	return 0;
+}
+
+static void starfive_sm3_set_ahash(struct ahash_request *req,
+				   struct starfive_cryp_ctx *ctx,
+				   struct starfive_cryp_request_ctx *rctx)
+{
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
+}
+
+static int starfive_sm3_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_init(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_update(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_update(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_final(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_final(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_finup(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_finup(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_digest(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
+
+	cryp->req.hreq = req;
+	rctx->total = req->nbytes;
+	rctx->in_sg = req->src;
+	rctx->blksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	rctx->digsize = crypto_ahash_digestsize(tfm);
+	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	ctx->rctx = rctx;
+
+	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm3_export(struct ahash_request *req, void *out)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_export(&rctx->ahash_fbk_req, out);
+}
+
+static int starfive_sm3_import(struct ahash_request *req, const void *in)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_import(&rctx->ahash_fbk_req, in);
+}
+
+static int starfive_sm3_init_algo(struct crypto_ahash *hash,
+				  const char *alg_name,
+				  bool is_hmac)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->ahash_fbk = crypto_alloc_ahash(alg_name, 0,
+					    CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->ahash_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->ahash_fbk),
+				     "starfive-sm3: Could not load fallback driver.\n");
+
+	crypto_ahash_set_statesize(hash, crypto_ahash_statesize(ctx->ahash_fbk));
+	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
+				 crypto_ahash_reqsize(ctx->ahash_fbk));
+
+	ctx->keylen = 0;
+	ctx->hash_mode = STARFIVE_SM3_MODE;
+	ctx->is_hmac = is_hmac;
+
+	return 0;
+}
+
+static void starfive_sm3_exit_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	crypto_free_ahash(ctx->ahash_fbk);
+}
+
+static int starfive_sm3_long_setkey(struct starfive_cryp_ctx *ctx,
+				    const u8 *key, unsigned int keylen)
+{
+	struct crypto_wait wait;
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct crypto_ahash *ahash_tfm;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u8 *buf;
+	int ret;
+
+	ahash_tfm = crypto_alloc_ahash("sm3-starfive", 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req = ahash_request_alloc(ahash_tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_free_ahash;
+	}
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	crypto_ahash_clear_flags(ahash_tfm, ~0);
+
+	buf = devm_kzalloc(cryp->dev, keylen + STARFIVE_SM3_BUFLEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_free_req;
+	}
+
+	memcpy(buf, key, keylen);
+	sg_init_one(&sg, buf, keylen);
+	ahash_request_set_crypt(req, &sg, ctx->key, keylen);
+
+	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
+
+err_free_req:
+	ahash_request_free(req);
+err_free_ahash:
+	crypto_free_ahash(ahash_tfm);
+	return ret;
+}
+
+static int starfive_sm3_setkey(struct crypto_ahash *hash,
+			       const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+	unsigned int digestsize = crypto_ahash_digestsize(hash);
+	unsigned int blocksize = crypto_ahash_blocksize(hash);
+
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+		return 0;
+	}
+
+	ctx->keylen = digestsize;
+
+	return starfive_sm3_long_setkey(ctx, key, keylen);
+}
+
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "sm3-generic", 0);
+}
+
+static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "hmac(sm3-generic)", 1);
+}
+
+static struct ahash_engine_alg algs_sm3[] = {
+{
+	.base.init	= starfive_sm3_init,
+	.base.update	= starfive_sm3_update,
+	.base.final	= starfive_sm3_final,
+	.base.finup	= starfive_sm3_finup,
+	.base.digest	= starfive_sm3_digest,
+	.base.export	= starfive_sm3_export,
+	.base.import	= starfive_sm3_import,
+	.base.init_tfm	= starfive_sm3_init_tfm,
+	.base.exit_tfm	= starfive_sm3_exit_tfm,
+	.base.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "sm3-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_module		= THIS_MODULE,
+		}
+	},
+	.op = {
+		.do_one_request = starfive_sm3_one_request,
+	},
+}, {
+	.base.init	= starfive_sm3_init,
+	.base.update	= starfive_sm3_update,
+	.base.final	= starfive_sm3_final,
+	.base.finup	= starfive_sm3_finup,
+	.base.digest	= starfive_sm3_digest,
+	.base.export	= starfive_sm3_export,
+	.base.import	= starfive_sm3_import,
+	.base.init_tfm	= starfive_hmac_sm3_init_tfm,
+	.base.exit_tfm	= starfive_sm3_exit_tfm,
+	.base.setkey	= starfive_sm3_setkey,
+	.base.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "sm3-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_module		= THIS_MODULE,
+		}
+	},
+	.op = {
+		.do_one_request = starfive_sm3_one_request,
+	},
+},
+};
+
+int starfive_sm3_register_algs(void)
+{
+	return crypto_engine_register_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
+
+void starfive_sm3_unregister_algs(void)
+{
+	crypto_engine_unregister_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
-- 
2.34.1


