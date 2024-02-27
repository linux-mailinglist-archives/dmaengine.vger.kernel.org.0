Return-Path: <dmaengine+bounces-1129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CA869C68
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946C82826C3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6A4EB5C;
	Tue, 27 Feb 2024 16:38:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEC4EB3B;
	Tue, 27 Feb 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051909; cv=fail; b=NlKGLXRkh0Kxn9Q9IHdknsVWQKALcSNGZ8dMNcEYiEXpldX9v/y5b5v8oL+TJLtm6q89zgtBglEU/rtmyrzzwnuk7V4GtuTkgRVURZEP5BvYvcpoJTEpGLPTAGJpWgK8Ny8M+RY9Ds0NxKK7WVs8FY7gt8aRnJDnUwe5vC5eODg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051909; c=relaxed/simple;
	bh=a2kSj/N41fu3wtttz6tKElnDO/7+BZI876DcZw6HYNg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3lkx2+cGmPSKiPX+GpNuc6aFUxKovzSj2sQ3W0xtfkVGTrA7w06AM4eh+gpSKtiCLXfvkFQtrqTAalc8Tu7bsiPj1pmrs2qK6lNEj5VF0VmjTp448zp52EFHFl7urfdmrWUgnUPfvZ01jIBDK/ceVJV+1CIuhlgY/e3i/kfOOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3he/M31EFG5rbnDg1DtvpVFq+tQxkIm24hYNYFdsVBbdtbww4ArCF0O5hqhRLYmqEaNSYEV0quwRWvdWb1sMgUqNPUJHkqUZ4ce4nqA/LbGGQUzY1XGK0YoZJmgA5B4/3HY7aFGiAG3cU92i+TrA17bREeT3fsgAkILGlNqJMdrfC2pGTDCdDQ5ngLnDgq7C4FRYztuqZ02Tpy9+3rcf7zj1uH4RstVN3rwbOZ0ocXMF+jNw6Chwc7JlpRpnTPBQFnxMsCD1u3utRaK9X873rgGzpDXEOL9c57QFaGuAt/skROW6Fvu0Z+A7GaVSn2u6Yvz6Yd25Dk7+hsqdZHkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDo+XQFzr6zgQmUdXaMtdgTpGc8h6PBylFQde99iOXQ=;
 b=KhRMPLR/E0Sj/Y4KtpFUbdRwRlFpc9hrqnU1OESIiM7czi9db0D4OJnaodJZ2i3axfvJsQEHXojE7ia/WasZaat/8DMeNVMsOdonxxnfXAaKxhRM9SKoygYon4wCftIzR7WoVePoB2rY1arFda3hTiR7eRD3pLalw8K8At0AMsPKhR+YKNL22bLD+XUIqyumi/hEszGRw0FFy9Xp+HzBW8K+qKDn9nmgRbMLHjdZiMjyeuaK1khzh6SPK4HTrb0x1dnWdj+za90ff+2lzzaLhauRhV3NZW36qtWxoZ9YOzhVn7R18qZhjMOE2jfzSHnJ2PS0tsm62C5dwPQxSPBBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:13 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:13 +0000
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
Subject: [PATCH v3 5/6] crypto: starfive: Add sm3 support for JH8100
Date: Wed, 28 Feb 2024 00:37:57 +0800
Message-Id: <20240227163758.198133-6-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a423db7-fe19-4e41-9b82-08dc37b27e0c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e8xiqWmS8Qs9yJSqgvEOA5BInNLCFTVA6wviGKV+7dsSEH0UaDoHQpNw1bBA10Xg/1XWqbvsH0I17w4epe1HYFhv5qMmUfQoKKHP67jvI+CYKgPuljecxZ9/oDWGy4OH9uCD3Ers5tB7x463kkgs30GOHmoFrmUmcQB/CdujevZfOFieNnChAVHl0NnrN1/b+Fae2GxbHSskkQwa1UEtKO3+fjXbAxxgLBKkgtBUOwQkFH8mOqSutYpuBWfAy2DSWoC++8cxPLFGjsm/Ao3h8ADFY/eL4bu6Up2U20+Azb0aKXkuugMlrIlmxLOe30xZqRxdUgzYSuh/jkMcRMiNJ6d07T3wq4H9IF/lUNG2+/0av+pxwcDL2FDKmviKzg5axeuaehjxce1xQgOhnST0Xqc76saKqp7ZnIrmml4NEMCKInqe+xJRgoN3X62a4R5p846kIAAsn86gJOzDjHxhj26Hnvi9xxOr9RexB6LtqkS/Sy4bK8PEQIcc6hN+5yPEcsE7r+PoHsU04FOYd2IXZLYjQtL5nKpP9iiC7T7gCxfVv1un1sB2GWKDLs1lc4RaSyesYhwOUJbgyfnQzMk2r9X3oeTeYJQJWu3JMfF39EcS7PFQrs+haUFMKJ/zZkRXXtr4MyFOShhvR7IR43vitA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZliB5Q0nVBM/qlFktDDAzJHCiEAva72CqjZ/PRuw9Mvb4JavcusDfQ2Qnvw?=
 =?us-ascii?Q?6vjJCLZu6GStzdR6kCyJBsecxBFs+S+XLDk2a4IBI/TqwioY4AjivxMRW5Ts?=
 =?us-ascii?Q?VXZgTYAL79ZrXNXxlX3dtGN/toRasVpYmBeZCk7j8AhXg9ntsxuAfsOlw23i?=
 =?us-ascii?Q?0zcPBhz0CumMmRW46GkwO13e0qlkSK1ua8lJ6feooGKyjqYxj4/BtYQKkkVv?=
 =?us-ascii?Q?G1AfvVJ5MEruxuXi3zRZbiZ5fouJlF9yOFfCVSejTL4JsDgU1yC+F+A6yoDm?=
 =?us-ascii?Q?/9iNjsMVF1ZH3Uov4n84SigHBVN50ZwSFYRjbsnUmEUtvEdJsZSeebuV2XMf?=
 =?us-ascii?Q?EeM3iV4vZtuT6pmRRYJ9UjLOOk0sJMxeUVvg1j/Ke2zlrtVHCu3JXF+L3lzS?=
 =?us-ascii?Q?KijNon5f9A9ltcBGFQOh8B7BxV6l4yAmsY4ytdg2Ey3RrYFChWApIQqvrsIM?=
 =?us-ascii?Q?lEy8Watmw59YNjkJ77s6pVYJd/+Y974abZAh+Rs4ua7j2zSiXTMAJx/kheY9?=
 =?us-ascii?Q?iFGBrzKgLoMxGwzwrSI6RjP7sihtW/ThgpSyJCkkK3yx2yzABkWufUL0pcne?=
 =?us-ascii?Q?Sxg4MYgGid/DfUhWe4UWfcFLkU9ZgQ5zaun9URqgaPyuAxrWzige5QrhB2nY?=
 =?us-ascii?Q?gMOnCf50YJ0H6yW4SSunWdzYUKycFHMnWIx68ytl0wEusjyIBx8A6wPxARos?=
 =?us-ascii?Q?HJw9EWSFX7bkdPgDYAejVKBXw2yPkmp78fAUEVmvGlZlEIgoNDEwewcwH0fi?=
 =?us-ascii?Q?Ivm7CvPJDx1qEgFF/HpkVeDWhBQ8y0LPRH7J4ogNsbIm7dSc6xzrCmmQDtte?=
 =?us-ascii?Q?hLyPBs853ezRZGmVAhSbcd5yCt5TO7weS9D5c/niGoblaDsX3PseMdVRY3ar?=
 =?us-ascii?Q?CH59YvopIDX3x5wrfbeyaZmaEzmHWr8sWYx/RYZKdOEs01koR4FdWjUBBxJF?=
 =?us-ascii?Q?sR17iryxJPljOsqgSriFAzvXmlIFa72RpblueTEsq2xElBqiV2eGPKHt8pnP?=
 =?us-ascii?Q?ehmUAIPUHgY6Sia8KpRLscqF4PfaZPCXl31Oq9deZoBnIVp3Ga3XcdHvIbHi?=
 =?us-ascii?Q?spdwu3uHdVK0xgtfrk8kwJfUqDjtAeTuATHtuk0Pfkwds015v89lIuQ+qG3w?=
 =?us-ascii?Q?UkG58mkRf4/OO+kJ0Hp61cUkZIWcM+QRk9t26umXAH0dbI7jkJx+WfHkbbuh?=
 =?us-ascii?Q?SyAV+GXvCjZRvEaCSiB1rEsTPV77tBYc21C66UXNeFy2nztq4cvEBiPT2hdr?=
 =?us-ascii?Q?qm8W/0i7iAFwgeLrbOnRfIJQIwlFF70KYqGqaL44I3aleteXhXYEDJlv5S/t?=
 =?us-ascii?Q?ePEnOU9YlHo38MCUuPRsN5Q+PW5MxqgYnxBkjkb0+OtHFU9wtNXJ0YR9q1b3?=
 =?us-ascii?Q?GnNZZpl3mpYYrQlkiVtHrwE1ObIgcSZrV5zGypHRLUy0NpTNZXlGskGqr/i+?=
 =?us-ascii?Q?MPP7kmqPZ8WqhbhlR25RCEy6IlEH01m9XKzcyieiK3axc0ZWq3oCdMpWV9N5?=
 =?us-ascii?Q?0xD/zGWPTbT9DuVKiyo6ukFmUDF7Xii85Z1jHMxmtH0dSDYntYBvRr9VBkFq?=
 =?us-ascii?Q?OZlusKKFAEOQ0C8wDoNLGu3ZunrgMsTGMW1mbTKPAylAwEWIWhxLQIhxV9nG?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a423db7-fe19-4e41-9b82-08dc37b27e0c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:13.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4khyjPI4fWIB0nzqk1KBHzrvmVeCdzJD3x89y6wukywuZhnubaH+fkQT/x5tmiUKMm+agwXJe1Tv7uUmAyS5RpeqQmS0/Q10nH8dSssxm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

Add driver support for SM3 hash/HMAC for JH8100 SoC. JH8100 contains a
separate SM algo engine and new dedicated dma that supports 64-bit
address access.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |  25 +-
 drivers/crypto/starfive/Makefile      |   5 +-
 drivers/crypto/starfive/jh7110-aes.c  |   3 +
 drivers/crypto/starfive/jh7110-cryp.c |  38 +-
 drivers/crypto/starfive/jh7110-cryp.h |  66 +++-
 drivers/crypto/starfive/jh7110-hash.c |  45 ++-
 drivers/crypto/starfive/jh8100-sm3.c  | 535 ++++++++++++++++++++++++++
 7 files changed, 686 insertions(+), 31 deletions(-)
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
index cc4139a88a0c..19bbcaaec18d 100644
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
 
@@ -126,16 +129,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
 				     "Error getting hardware reset line\n");
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq, 0, pdev->name,
-			       (void *)cryp);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to register interrupt handler\n");
-
 	clk_prepare_enable(cryp->hclk);
 	clk_prepare_enable(cryp->ahb);
 	reset_control_deassert(cryp->rst);
@@ -163,7 +156,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_aes;
 
-	ret = starfive_hash_register_algs();
+	ret = starfive_hash_register_algs(cryp);
 	if (ret)
 		goto err_algs_hash;
 
@@ -171,10 +164,18 @@ static int starfive_cryp_probe(struct platform_device *pdev)
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
@@ -200,9 +201,12 @@ static void starfive_cryp_remove(struct platform_device *pdev)
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
 
@@ -218,7 +222,13 @@ static void starfive_cryp_remove(struct platform_device *pdev)
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
index 6e523e45cd9f..0e2bd03cc3bc 100644
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
@@ -132,6 +162,32 @@ union starfive_pka_casr {
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
@@ -177,7 +233,7 @@ struct starfive_cryp_dev {
 	struct clk				*hclk;
 	struct clk				*ahb;
 	struct reset_control			*rst;
-
+	enum starfive_crypto_type		type;
 	void __iomem				*base;
 	phys_addr_t				phys_base;
 
@@ -210,6 +266,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_hash_csr		hash;
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
+		union starfive_sm3_csr		sm3;
 	} csr;
 
 	struct scatterlist			*in_sg;
@@ -226,12 +283,15 @@ struct starfive_cryp_request_ctx {
 
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
index 4e82f05a7df7..bd01d3ad520b 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -103,6 +103,8 @@ static void starfive_hash_dma_callback(void *param)
 
 static void starfive_hash_dma_init(struct starfive_cryp_dev *cryp)
 {
+	memset(&cryp->cfg_in, 0, sizeof(struct dma_slave_config));
+
 	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES;
 	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
@@ -505,12 +507,6 @@ static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
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
@@ -535,13 +531,19 @@ static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
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
@@ -770,7 +772,11 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
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
@@ -830,12 +836,27 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
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
index 000000000000..3ffc8882c241
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm3.c
@@ -0,0 +1,535 @@
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
+static inline int starfive_sm3_wait_busy(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  !(status & STARFIVE_SM3_BUSY), 10, 100000);
+}
+
+static inline int starfive_sm3_wait_key_done(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
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
+	if (starfive_sm3_wait_key_done(ctx))
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
+	int err;
+
+	err = starfive_sm3_copy_hash(cryp->req.hreq);
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
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	if (starfive_sm3_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "Error resetting engine.\n");
+
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
+	if (starfive_sm3_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT, "Error generating digest.\n");
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


