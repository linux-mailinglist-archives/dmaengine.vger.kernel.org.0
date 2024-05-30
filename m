Return-Path: <dmaengine+bounces-2213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598298D476C
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5C1C21413
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF006F2EE;
	Thu, 30 May 2024 08:46:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2110.outbound.protection.partner.outlook.cn [139.219.146.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D11761BF;
	Thu, 30 May 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058805; cv=fail; b=pnpM/WOjZKmAxPKie52gPFE+7celwH5H3lh0BiULsNXbqqmt2wYkz9Jp3XdNo1xNgKTuwzo83yQ1rNW8C/CpfCQJAZmiIBB9FDLAs3YBTfDB/vuY9Riqn6xhRw//m3wOyN4S+L/KncNbjndMInjK+jM/QQo/neRKAvGcWU70t8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058805; c=relaxed/simple;
	bh=dapI3b5PaHMoIjGWC0IErBk4j8KmA8iAQem7w5RHM8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYtd5YfT9kEtWjYtx6HIJyQuwhgk8MyJWna1L7376oJjwkNVVSuG9fTF8AKAIOasd7mvpOO5PDFjCUUlKhr+mCOCJIGbi31lyJ89w/InUJGpE45MlWnW4LIpro5eZgKlEGUvLK+is2/ZVz5emccZV4fdlo+b6mvw9ODRnEF5+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJmCeUDtk9s4aOKwKwQZyM7tPanyzoq9iMO2m5cKmxgO7+aeKYYwXLSuhW9im2FnT1EqDcU8hHygWHXOugunB6MOh0gRK/ZAQuEmbMoB2DtqFa7Xi7gVssBOSdVyNsZXaqs3q63SmlKZnLbrkRoi1Vf1OZBnb4cgHt0zrTOAgk84N7HT76uB8pPA4aIodzHJU0iZ4xyO9j+X3Cm0gLDlHRZUXiGfAsROMoeVMhgQjmE2fOM+/MudzVz9phf2wFix7LU7VCOoapkCD6hBr6ivMd0IVSDhp2HJRS+1NqWQ5NxK8yfdAaV1a/4nqxcdAXKlF9xZcyX0PJYuoa8VG+sWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17vlXwX0vAm2ykk21rIX6088jcmuyw1PiyRbe6nJUMk=;
 b=YMKpyH7cNkfDd2wWnNltFjbp9MCNfSOKMVn58GDgpa/fcIHPOvAk1ug077dBqusXtWyxh4R7H7My7MJMr3R+gjt8GdYsoPsf6EumZ7G2Ha8w2bj2JAjx2BsLdT3dYyUv0yxrnYnrdXu3B9w6obCYX9s/S2qdoJ6fAyazV8l906zxzF6ma8Ld1Cj2OxdAOKxb6DQt27O+ZjWmKdb7nB1xWaqp/dORlCQxGsAzRpGywX+RIlR6ms3dRHceqex/VieVzSz7r+iwW78enf7bZ2i74uEDofGnc13o+na8Q+jgkM3bVt9FVHm+WMvvAz3nzXVeKppW5NBfSUkmFxOeY7yDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 03:11:28 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce]) by NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce%7]) with mapi id 15.20.7587.037; Thu, 30 May 2024
 03:11:28 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 2/3] crypto: starfive: Add sm3 support for JH8100
Date: Thu, 30 May 2024 11:11:11 +0800
Message-ID: <20240530031112.4952-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
References: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::17) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1054:EE_
X-MS-Office365-Filtering-Correlation-Id: f01d970c-d301-40ff-6adb-08dc80563244
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|41320700004|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	vt03g4cISiYEhf43EzolKGEX3nZvIsZr2ANytpdWane35g50BMzoxfOTpn3OWPs1pb+LQJCTdxfPsc5hx4AJyzRQcewJxfC4TwP/bxIrFEmBcKGKozIOhWRflAebYnzlzoqQoTgypOZUWe27NnYMzLYTX8l6AzXVlvt6UzDYG6wk7fSxkTrbqXnv4dj/ShWVIXsj527XIUnVBcR6iuPoxdRiHu27nAmCzu/YWNdHStWqFdU6BP+44K1Kzw9mXiQQS1NXaP7nSBTjULibJMFgNPNDnpIZ8o7embCqYikRA82Mu86rlTn54UPkepEJ6j6Tb2s+L+waSRf+ALqyGsOESt0ybZWWO21Qa6aWRpCQRW8S+vDXXInkR3CdufnVypgy9Dvg53JyzXxkwrTLFuiN9Ur7QyGjvf2xpupIznD47UksszRv8WoLrTRja2jce6pG5iOEKU0ZYyO3f2ZcsUrH/RlZLg20DB2BF+4q4uUmC5Tf5A6p8TRHBfSbI6UoJ/Tdc6WA0Pq0VNu2fL4bK2m13B0pWASQWpZW/kzJ/27geZxGAy2w5XdieVNJisnhHZEanGOj3Zb+QsSnFtlCvKtI0te5NsOmlIriUjOoeaDdgzjZZoHG1XZau7SU8BD/PxR+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qjLVRx2CXlJq/FV+Nzivlr2OPyNGRR5xCktfHYdlb7UUsd5N1l3LuGzvr/7o?=
 =?us-ascii?Q?NH6NDNyX/sOo9Obg68RbFV2nySYWAojy9UQZWngQbKf3HIfznrzoCgl0vvVL?=
 =?us-ascii?Q?QYFj+P9IQP/eLdeSIZ1UIBfdqTQuJ4rC+y0QVzfPU96yFTD24dh3P4m7zS/n?=
 =?us-ascii?Q?/br46luGlQN8i6Jk3RXEsafhFQyDq0IleomKRx/jqcBhHPSL/x6mBOz3MSvM?=
 =?us-ascii?Q?sKzkVcWBhNDdp9VN2E06MZ+q3rGp0+TRVQ87Hbg4H6tIjYlgr6Hb043TRund?=
 =?us-ascii?Q?qKGJmwPnDSRRa2SA0yGMENf8ErSzMrUxKJBbimPFzh2HfVpRw18lpROlRRhl?=
 =?us-ascii?Q?GYrqbvvBFU6n33g/itCJcC+fNFnjDRKnZ2Kif4a9JRd0850bdnGxhHVrdGaY?=
 =?us-ascii?Q?TDqqJDX+fc8onpluLd5ITe5dnXwLBvX/sJbgOoaqvpiI/rf9m09VeSadUI4u?=
 =?us-ascii?Q?rz2Ne5yhg1vGmXpn2LZR/7dOVF5qPyqcxqoCBeH4dq8hkWeWKVVaVNQ1akU2?=
 =?us-ascii?Q?ewCOM+FzA8flljkKVMEGXuenc4Z5Ypu06+Ra5ysKxzFhXg+PWLaw3VdoXs08?=
 =?us-ascii?Q?vP01PPyLMTv+VnL4Gk5CDzkA5KDh2qSfVG+liw2+QXWKAtitMg4PW084hrzZ?=
 =?us-ascii?Q?6Gu0dH7yFWM01yjSb1vRNd4yqhq9/r1YwUhY4bxJia5EEzxf+K0+Vwkx8HOZ?=
 =?us-ascii?Q?SAjvYdyVYkAOriFgDT/XihTk4S3BXsfdy2vFoWSoHWuervA0f45926DqMUDo?=
 =?us-ascii?Q?lVAZpNF9alunXXOigrik9qWXqEciGjGKk9kVsFJfuf835ecaetP1AL2kFYUA?=
 =?us-ascii?Q?9f6yaneWtPL3gySqmJ1MeevufFJ5A6Dq4SkZ/2VZJzvxwcgomgdQX8sigETE?=
 =?us-ascii?Q?T9XUHZz+7izE4x9pxcMw0GGUPXgJMYi4yvZSworMaS7v0QDTrskW6dSdFF2P?=
 =?us-ascii?Q?w6Oe4ceeet9Z/Kaq7pV+J2MqhUQCh0+ZFgI/CekrkLUiPogJGi0fckmJX2S/?=
 =?us-ascii?Q?DiO5VrHb1xhTZKApoRy1AacaHkfVlyHqRCn3qi1e9Pd8xLtEejEI1Gd8LOMZ?=
 =?us-ascii?Q?JHDubFM6phPUMIFhvOcoHfPCIc2dW0w5NM6lBQ61XDiF0eP+sfUsZ7ID2xb+?=
 =?us-ascii?Q?j+aUgpvo4wyxLOlujMDfEyeoa8UjWZU/QTsJmqufpbOwUQcfj7mS2qqooIvy?=
 =?us-ascii?Q?4zyWlZ/LKOAUp4paxXeLjv5ONYhZ8WjBFqbyyxMAhCcNOokpi6R7NkMBuH70?=
 =?us-ascii?Q?TiWAEhVB1ulnDPrJS1eZ93jx5PMgE+RcrAXQqNLV3Ge8XxGQX3w7LbY6c0+t?=
 =?us-ascii?Q?5Ec672bHWKwv0JnB/eqB3XJXmPSl7UtqcRwMNl8swPLFfDyg6ql+bPwlGjKP?=
 =?us-ascii?Q?yB2ulCJwgqa6+ZpbTuqqm/8rt+NJaWJJ409BmrVMiM0Fzt7NgsN3RDewSgtO?=
 =?us-ascii?Q?bF7whVdaxi1g99ksrmZsJTm0sO1I0+BacVj0tLkY/bokoD685ivSpWPx+gxl?=
 =?us-ascii?Q?RX8egqh5LY3q9zQ12dk4Xe/WeFaByNXUcL2Q6k9jKyTWbr4W/L3VfA9ASl/Q?=
 =?us-ascii?Q?AW9KdOe2tGbRAfUEJcUxeCU2FJLyyzfGdR5tZwY0NOWFdVqBP4fnL4c6ZEk8?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01d970c-d301-40ff-6adb-08dc80563244
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:11:28.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFkluPg5LEbSTtyqzf0rmsS/q2yLPxktI5CJNUHOjW1XejHShjH8KkPtdrMrxFRV2tB32c2CFDS6QGlCaJYc9pi5Skydq8Jc+9Nd0fmVaMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1054

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
index 86a1a1fa9f8f..45440a6a29d4 100644
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
index eeb4e2b9655f..60ac752352c8 100644
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
@@ -226,12 +284,15 @@ struct starfive_cryp_request_ctx {
 
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
2.43.0


