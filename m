Return-Path: <dmaengine+bounces-1266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660FF871665
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390671F24FC8
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707787FBB4;
	Tue,  5 Mar 2024 07:10:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0F7F7D3;
	Tue,  5 Mar 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622649; cv=fail; b=qOR4kvyggLBPtInN+blcoXMb1VtzVe73/Kx564839+li0Cfjb37ayVnPKRJY+/Vi+qQQfQdDHjvVSXiL2Fjpjd8lMoHXwlss5pQh1tO9FBQbk1Bh8i5P9VbofWEgu+hRShMEeYxX4Zr7/tkYWCkCMQdqkbD1B9Uc2HGDA3YQpx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622649; c=relaxed/simple;
	bh=BFbarC120k30AKrwWZxknxKq5UcPOFywZfSSXEV47S4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILOjY1PseWMYs+6cx3UABnho2v9XvxTTa1SPttezk9V1uBix74cAdyk1e76KvH2+MJ3WdTf7XZ/9U4rsgYtaSz0Z+095Bigc5PXdmU+L2VNTNonx2EuayxyLgVTiyMZtA5X3gcbXumQcHw9gnhq/+zYIDDuzTFyNTARFbEpRXsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of+qLZ495XnHDFBk56uZ8Yled5d7dw6ZZSl04IfAYTsqXLf+Y8CSCYya2Yx5Lo2bCyzDz6PZRsdI6KJVEszU+DyfQDBqWq9xxSdbDvq0ADmIPhXkojtC/Lc3GneACTND8pnuR4K1n+9JjNOH9ThT9ux/L3wBXZKO3JiCRlG7HwWQ7Dom2jISz7f7C5fxl9r+y6skn9RW3smvMwhsHM3ntm+/bzhbm4KBfG4BwicnxN3Hp3OQHToBRvZcytcM7UFiJNC217xK4YgHun9JikOFtZLtlCM5GV1ByilTkdEkBygLJkxUhgW8NDibc4ZD27F/BRc14hglz/1xJN9oTc3tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDyEGVU06i0spTgV6lMyp61aKxaGahobdmwHT0Nv6EA=;
 b=LmBGF1FI4dsEL0ATc0f67oBOPv2n0tcFfgzPlx4ZbZwZ5z8td2+gEyTxzv7eSIfbz8fVRGkdOwnt3jor75ruzL+dM1gn0F4WZqKBdYQ8paUhfzNFov5LAtHYGfPqM03pqnjifLUUa+zI1j56L7o3/cJgNSYjnLALLP98Sd7mx2T9hxVsJ+jXcdEQBlEHHHLdzBSWNyVsf+KgJMAxjRnNe+WmyQvHRMXRODTUKO2KpzFJAENbcGm6K5ZhHFC7KS8WmTHMm9xZZDA8eyexcCFe1wPZ6QZH9dv+PPXNV4GXfT9ZT9QHpgMSQeQV1mShnwn94iyGtx5YutTkFbTSRoItLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0686.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 5 Mar
 2024 07:10:37 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:37 +0000
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
Subject: [PATCH v4 7/7] crypto: starfive: Add sm4 support for JH8100
Date: Tue,  5 Mar 2024 15:10:06 +0800
Message-Id: <20240305071006.2181158-8-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 095b85ad-81e6-4b1a-41cb-08dc3ce35b44
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D0kBJBrwt0Ayl3VTgEYDjdeDIgJvHsbowbHAGu1vhcICwNo8NOBv//IeN3xHrFSASsWJfj6pPI4YRcDWvZVDeX4JVmRCclR5wcyOmsq7hCU8f0JANbGVBGT/2f2dFX490ZORRjPArhF5GRZ5bCoAcppL7NUfW0OWF+Jm4ieYTeDLGEAuTsaTOSTyWOObxyG9Z6kYoqqJK/no8i3EtRKDnXsb6dNkSu/SrY/mVieD7B+wSSWe/Et2TdWaeReDEXhKXi53mE0isxCbIVWmDqhHs3Eandak1eUuDKXtT7aUZO3bs+vq3Pq/wXcmT9uawV0Yah2a0EpgTSxTDhUbOxkbexjeq35OkJxI0Izn8UHKI3Oqw7Je5SL1DxVK10WhmHPvWKwC+hQ+zPUhaFzajJC+tDXFiE6yS0VHDQ1+7o9+KQl/v5cU3hFFKBbqoUqkSyRxOSE0WvpRbqw+SnK/JyqKPq9FylRQ/lBR2RaS4WDBRDbcbslfMznyiBmys7UfefXfgOgkqRlNnGjBKBYoWfn+auspUEYnondHupqjs4vDaLAnAt6iePxlvka6fQoicKz58nqVpRRcgJohl7wu9LdtRud2/O8NvgLJZZ8gpw6ZEKLr+HdpDohuo6wVQ3St+Oo2D/tWvP5E+674KnKI+lTwfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1PbZ3jhav5iKrQR5Po39UgtCxnJcOw+zdoDF98OJ+lQg1VuUNbvNJvdeAZd?=
 =?us-ascii?Q?pgEOov9d5QCs5gkRdgYgBUJ9YiR4ZNsdqVtI3A5D+pDFogoR3MAAueHMtn63?=
 =?us-ascii?Q?IrluJqBmUt+RC811iI99w76a3bJSIoMbYmCGqfxRl6E7ie6aq7Lll58fAYeq?=
 =?us-ascii?Q?9+SGNhQN3GsHuBidRK6CT9wA83/9peLNMaigpU3Ni1Fxb1tAG5j1n4O9e/+o?=
 =?us-ascii?Q?UFsE1ah5NMOmo9R48NjC2lkshphVxhMscDfZYmSmh3GpRFPUmRoOUi76mtnw?=
 =?us-ascii?Q?jxojzPB6K2lDvDgHDCQ+/Rf82ouwPEIPgJ5koJrQvS+i2kkTTm/dvFlnF8/1?=
 =?us-ascii?Q?GnUMv7qstWVSmvlvd7NzXpGk4IRpfb3iQuAyEwMnNZ178vFPamSYTu4YODPF?=
 =?us-ascii?Q?9tKTFhNdWHitERDgJr2U3XZH2zmmuVpWzQ4ZDkCDHTUep32xmnQLNfAHj3Xc?=
 =?us-ascii?Q?4gPAnt1MSdHoo0l6n+RhnQRGZzheBV6+GhuwCVEgI5Dklg3lwm4NaNeWMuVf?=
 =?us-ascii?Q?7c2LC489RtDtXesCq0w93sfaY0Xej+4X5A/4kYwc+8bZIDW4eOLkXlgZyGm9?=
 =?us-ascii?Q?0jZRr/BVu8NblYZF7xzaGdQ42surkNRYT56uwc9btOEUci+p196WYYuyr/6v?=
 =?us-ascii?Q?ZL0BdVpRppUcU0Wqkhg3sgtITm79mWWSqv7H48gux5IIOCgF/H+CzEhL69Ji?=
 =?us-ascii?Q?7p0rRiZY12qOT3laA6//mVAqbG3r0CKUjj07pCMr5U/HeyAlbSwNKswKbSo7?=
 =?us-ascii?Q?03NXlPKPX3CDMMSe1PvEzH7myaJpfXP+9CmnX41h9hDV2f4bQOVkleFupYXd?=
 =?us-ascii?Q?lEy/iTPn6uKZYpIiKuk+OPBn+5Hsbi3AkPp42z9vz5pWNk68EOhCYL4u6CBD?=
 =?us-ascii?Q?Txt0ZwS/cUvWm9GtVP/+1rmxuDunW+ygLKdn1aEsEHmQUPhuyX90iXFVkyFj?=
 =?us-ascii?Q?YaYHd0iazPlYYmVJ+XczZHG1jKppqUR3D5umA8SDc5pudSfv27ULst3AKiHK?=
 =?us-ascii?Q?oTjpoavpV40iuO+WhDu1M8NrMckSTs/nm2Mq1SGCZ/h/PkPhYa1uolNjH6B0?=
 =?us-ascii?Q?YBbm9L03EvmRe9ddtKNnovencFN0hfLKztMEgeJoGewDRQjd5D8JtpEh4uuz?=
 =?us-ascii?Q?0yR3AjgbLPa3umcWNnL0Y/eEt4ODjQB6HaCdBgb180jEci63XqgayUo3so1+?=
 =?us-ascii?Q?2D7wbVl8/A90wknlIzJlptZ+N11Dv+QGeKgHVuLLHz1CewrFXidOc2fGH4jO?=
 =?us-ascii?Q?+WRk3m6FJQLiziL7sJbmAampRK5/XsDuMpPxpYYpIuWV7OTnqM+F2P8YFL42?=
 =?us-ascii?Q?Q4MMs9Mw7nziMA3rqmWwXKCkKvl86wj4/PkHCnq/4KrUFlad1CFVGDBLgk4A?=
 =?us-ascii?Q?1I56/o2DUWfRr+Y9wxwFjtBfzsVIIaUwhWc7F8zaeRlAo/D6qfBRTMgNvxO2?=
 =?us-ascii?Q?QmwAR51xlrJcpU4IFdAkmdfxD+cyUhzeVPquFu/QjeqbSGrGNjm1KslLRTRW?=
 =?us-ascii?Q?NjVvd2fmHf/NKsHV6E0mVhFW4Qy3MIEeyOXgNfmsZcTkbdOMUEM4KMh87yMr?=
 =?us-ascii?Q?CgwxWos2CTTZGL5c4z430k4pLiStRBOwIbz423bMjJTdrq5+h8R/g1t+nRAm?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095b85ad-81e6-4b1a-41cb-08dc3ce35b44
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:37.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NN/hiXh7+DirULOEqtTKKgnbk1EmrSLsygsdsyAF8UpDTvCl7ReIApUk5qnT27fUtFHEuDAjIetll0LFPjZnro7zQlJsnt7uvYp23xc3cr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0686

Add driver support for sm4 skcipher and aead for StarFive JH8100 SoC.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |    1 +
 drivers/crypto/starfive/Makefile      |    4 +-
 drivers/crypto/starfive/jh7110-cryp.c |   10 +-
 drivers/crypto/starfive/jh7110-cryp.h |   39 +
 drivers/crypto/starfive/jh8100-sm4.c  | 1119 +++++++++++++++++++++++++
 5 files changed, 1170 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index e6bf02d0ed1f..740bb70c5607 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -34,6 +34,7 @@ config CRYPTO_DEV_JH8100
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_SM3_GENERIC
+	select CRYPTO_SM4_GENERIC
 	select CRYPTO_RSA
 	select CRYPTO_AES
 	select CRYPTO_CCM
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 867ce035af19..0a4476085716 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
-jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
+jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o jh8100-sm4.o
 
 obj-$(CONFIG_CRYPTO_DEV_JH8100) += jh8100-crypto.o
-jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
+jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o jh8100-sm4.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 19bbcaaec18d..cdc34b6e1e81 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -168,10 +168,16 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		ret = starfive_sm3_register_algs();
 		if (ret)
 			goto err_algs_sm3;
+
+		ret = starfive_sm4_register_algs();
+		if (ret)
+			goto err_algs_sm4;
 	}
 
 	return 0;
 
+err_algs_sm4:
+	starfive_sm3_unregister_algs();
 err_algs_sm3:
 	starfive_rsa_unregister_algs();
 err_algs_rsa:
@@ -204,8 +210,10 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	starfive_hash_unregister_algs(cryp);
 	starfive_rsa_unregister_algs();
 
-	if (cryp->type == STARFIVE_CRYPTO_JH8100)
+	if (cryp->type == STARFIVE_CRYPTO_JH8100) {
 		starfive_sm3_unregister_algs();
+		starfive_sm4_unregister_algs();
+	}
 
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index ae523ec48591..1df938713bc9 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -7,6 +7,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/sha2.h>
 #include <crypto/sm3.h>
+#include <crypto/sm4.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -190,6 +191,40 @@ union starfive_sm3_csr {
 	};
 };
 
+union starfive_sm4_csr {
+	u32 v;
+	struct {
+		u32 cmode			:1;
+		u32 rsvd_0			:1;
+		u32 ie				:1;
+		u32 sm4rst			:1;
+		u32 rsvd_1			:1;
+#define STARFIVE_SM4_DONE			BIT(5)
+		u32 sm4done			:1;
+#define STARFIVE_SM4_KEY_DONE			BIT(6)
+		u32 krdy			:1;
+		u32 busy			:1;
+		u32 vsm4_start			:1;
+		u32 delay_sm4			:1;
+#define STARFIVE_SM4_CCM_START			BIT(10)
+		u32 ccm_start			:1;
+#define STARFIVE_SM4_GCM_START			BIT(11)
+		u32 gcm_start			:1;
+		u32 rsvd_2			:4;
+#define STARFIVE_SM4_MODE_XFB_1			0x0
+#define STARFIVE_SM4_MODE_XFB_128		0x5
+		u32 stmode			:3;
+		u32 rsvd_3			:2;
+#define STARFIVE_SM4_MODE_ECB			0x0
+#define STARFIVE_SM4_MODE_CBC			0x1
+#define STARFIVE_SM4_MODE_CTR			0x4
+#define STARFIVE_SM4_MODE_CCM			0x5
+#define STARFIVE_SM4_MODE_GCM			0x6
+		u32 mode			:3;
+		u32 rsvd_4			:8;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -269,6 +304,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
 		union starfive_sm3_csr		sm3;
+		union starfive_sm4_csr		sm4;
 	} csr;
 
 	struct scatterlist			*in_sg;
@@ -296,4 +332,7 @@ void starfive_aes_unregister_algs(void);
 
 int starfive_sm3_register_algs(void);
 void starfive_sm3_unregister_algs(void);
+
+int starfive_sm4_register_algs(void);
+void starfive_sm4_unregister_algs(void);
 #endif
diff --git a/drivers/crypto/starfive/jh8100-sm4.c b/drivers/crypto/starfive/jh8100-sm4.c
new file mode 100644
index 000000000000..5c91d4f3a79d
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm4.c
@@ -0,0 +1,1119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive SM4 acceleration driver
+ *
+ * Copyright (c) 2022 - 2023 StarFive Technology
+ */
+
+#include <crypto/engine.h>
+#include <crypto/gcm.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+#include "jh7110-cryp.h"
+#include <linux/dma/dw_axi.h>
+#include <linux/iopoll.h>
+
+#define STARFIVE_SM4_REGS_OFFSET	0x4100
+#define STARFIVE_SM4_SM4DIO0R		(STARFIVE_SM4_REGS_OFFSET + 0x0)
+#define STARFIVE_SM4_KEY0		(STARFIVE_SM4_REGS_OFFSET + 0x4)
+#define STARFIVE_SM4_KEY1		(STARFIVE_SM4_REGS_OFFSET + 0x8)
+#define STARFIVE_SM4_KEY2		(STARFIVE_SM4_REGS_OFFSET + 0xC)
+#define STARFIVE_SM4_KEY3		(STARFIVE_SM4_REGS_OFFSET + 0x10)
+#define STARFIVE_SM4_IV0		(STARFIVE_SM4_REGS_OFFSET + 0x14)
+#define STARFIVE_SM4_IV1		(STARFIVE_SM4_REGS_OFFSET + 0x18)
+#define STARFIVE_SM4_IV2		(STARFIVE_SM4_REGS_OFFSET + 0x1c)
+#define STARFIVE_SM4_IV3		(STARFIVE_SM4_REGS_OFFSET + 0x20)
+#define STARFIVE_SM4_CSR		(STARFIVE_SM4_REGS_OFFSET + 0x24)
+#define STARFIVE_SM4_NONCE0		(STARFIVE_SM4_REGS_OFFSET + 0x30)
+#define STARFIVE_SM4_NONCE1		(STARFIVE_SM4_REGS_OFFSET + 0x34)
+#define STARFIVE_SM4_NONCE2		(STARFIVE_SM4_REGS_OFFSET + 0x38)
+#define STARFIVE_SM4_NONCE3		(STARFIVE_SM4_REGS_OFFSET + 0x3c)
+#define STARFIVE_SM4_ALEN0		(STARFIVE_SM4_REGS_OFFSET + 0x40)
+#define STARFIVE_SM4_ALEN1		(STARFIVE_SM4_REGS_OFFSET + 0x44)
+#define STARFIVE_SM4_MLEN0		(STARFIVE_SM4_REGS_OFFSET + 0x48)
+#define STARFIVE_SM4_MLEN1		(STARFIVE_SM4_REGS_OFFSET + 0x4c)
+#define STARFIVE_SM4_IVLEN		(STARFIVE_SM4_REGS_OFFSET + 0x50)
+
+#define FLG_MODE_MASK			GENMASK(2, 0)
+#define FLG_ENCRYPT			BIT(4)
+
+/* Misc */
+#define CCM_B0_ADATA			0x40
+#define SM4_BLOCK_32			(SM4_BLOCK_SIZE / sizeof(u32))
+
+static inline int starfive_sm4_wait_done(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM4_CSR, status,
+					  status & STARFIVE_SM4_DONE, 10, 100000);
+}
+
+static inline int starfive_sm4_wait_keydone(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM4_CSR, status,
+					  status & STARFIVE_SM4_KEY_DONE, 10, 100000);
+}
+
+static inline int is_encrypt(struct starfive_cryp_dev *cryp)
+{
+	return cryp->flags & FLG_ENCRYPT;
+}
+
+static int starfive_sm4_aead_write_key(struct starfive_cryp_ctx *ctx, u32 hw_mode)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	unsigned int value;
+	u32 *key = (u32 *)ctx->key;
+
+	writel(key[0], cryp->base + STARFIVE_SM4_KEY0);
+	writel(key[1], cryp->base + STARFIVE_SM4_KEY1);
+	writel(key[2], cryp->base + STARFIVE_SM4_KEY2);
+	writel(key[3], cryp->base + STARFIVE_SM4_KEY3);
+
+	value = readl(ctx->cryp->base + STARFIVE_SM4_CSR);
+
+	if (hw_mode == STARFIVE_SM4_MODE_GCM)
+		value |= STARFIVE_SM4_GCM_START;
+	else
+		value |= STARFIVE_SM4_CCM_START;
+
+	writel(value, cryp->base + STARFIVE_SM4_CSR);
+
+	if (starfive_sm4_wait_keydone(cryp))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static inline void starfive_sm4_set_alen(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	writel(upper_32_bits(cryp->assoclen), cryp->base + STARFIVE_SM4_ALEN0);
+	writel(lower_32_bits(cryp->assoclen), cryp->base + STARFIVE_SM4_ALEN1);
+}
+
+static inline void starfive_sm4_set_mlen(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	writel(upper_32_bits(cryp->total_in), cryp->base + STARFIVE_SM4_MLEN0);
+	writel(lower_32_bits(cryp->total_in), cryp->base + STARFIVE_SM4_MLEN1);
+}
+
+static inline int starfive_sm4_ccm_check_iv(const u8 *iv)
+{
+	/* 2 <= L <= 8, so 1 <= L' <= 7. */
+	if (iv[0] < 1 || iv[0] > 7)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void starfive_sm4_write_iv(struct starfive_cryp_ctx *ctx, u32 *iv)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	writel(iv[0], cryp->base + STARFIVE_SM4_IV0);
+	writel(iv[1], cryp->base + STARFIVE_SM4_IV1);
+	writel(iv[2], cryp->base + STARFIVE_SM4_IV2);
+	writel(iv[3], cryp->base + STARFIVE_SM4_IV3);
+}
+
+static inline void starfive_sm4_get_iv(struct starfive_cryp_dev *cryp, u32 *iv)
+{
+	iv[0] = readl(cryp->base + STARFIVE_SM4_IV0);
+	iv[1] = readl(cryp->base + STARFIVE_SM4_IV1);
+	iv[2] = readl(cryp->base + STARFIVE_SM4_IV2);
+	iv[3] = readl(cryp->base + STARFIVE_SM4_IV3);
+}
+
+static inline void starfive_sm4_write_nonce(struct starfive_cryp_ctx *ctx, u32 *nonce)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	writel(nonce[0], cryp->base + STARFIVE_SM4_NONCE0);
+	writel(nonce[1], cryp->base + STARFIVE_SM4_NONCE1);
+	writel(nonce[2], cryp->base + STARFIVE_SM4_NONCE2);
+	writel(nonce[3], cryp->base + STARFIVE_SM4_NONCE3);
+}
+
+static int starfive_sm4_write_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 *key = (u32 *)ctx->key;
+
+	writel(key[0], cryp->base + STARFIVE_SM4_KEY0);
+	writel(key[1], cryp->base + STARFIVE_SM4_KEY1);
+	writel(key[2], cryp->base + STARFIVE_SM4_KEY2);
+	writel(key[3], cryp->base + STARFIVE_SM4_KEY3);
+
+	if (starfive_sm4_wait_keydone(cryp))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int starfive_sm4_ccm_init(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u8 iv[SM4_BLOCK_SIZE], b0[SM4_BLOCK_SIZE];
+	unsigned int textlen;
+
+	memcpy(iv, cryp->req.areq->iv, SM4_BLOCK_SIZE);
+	memset(iv + SM4_BLOCK_SIZE - 1 - iv[0], 0, iv[0] + 1);
+
+	/* Build B0 */
+	memcpy(b0, iv, SM4_BLOCK_SIZE);
+
+	b0[0] |= (8 * ((cryp->authsize - 2) / 2));
+
+	if (cryp->assoclen)
+		b0[0] |= CCM_B0_ADATA;
+
+	textlen = cryp->total_in;
+
+	b0[SM4_BLOCK_SIZE - 2] = textlen >> 8;
+	b0[SM4_BLOCK_SIZE - 1] = textlen & 0xFF;
+
+	starfive_sm4_write_nonce(ctx, (u32 *)b0);
+
+	return 0;
+}
+
+static int starfive_sm4_hw_init(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 hw_mode;
+	int ret = 0;
+
+	/* reset */
+	rctx->csr.sm4.v = 0;
+	rctx->csr.sm4.sm4rst = 1;
+	writel(rctx->csr.sm4.v, cryp->base + STARFIVE_SM4_CSR);
+
+	/* csr setup */
+	hw_mode = cryp->flags & FLG_MODE_MASK;
+
+	rctx->csr.sm4.v = 0;
+	rctx->csr.sm4.mode  = hw_mode;
+	rctx->csr.sm4.cmode = !is_encrypt(cryp);
+	rctx->csr.sm4.stmode = STARFIVE_SM4_MODE_XFB_1;
+
+	if (cryp->side_chan) {
+		rctx->csr.sm4.delay_sm4 = 1;
+		rctx->csr.sm4.vsm4_start = 1;
+	}
+
+	writel(rctx->csr.sm4.v, cryp->base + STARFIVE_SM4_CSR);
+
+	switch (hw_mode) {
+	case STARFIVE_SM4_MODE_GCM:
+		starfive_sm4_set_alen(ctx);
+		starfive_sm4_set_mlen(ctx);
+		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_SM4_IVLEN);
+		ret = starfive_sm4_aead_write_key(ctx, hw_mode);
+		if (ret)
+			return ret;
+
+		starfive_sm4_write_iv(ctx, (void *)cryp->req.areq->iv);
+		break;
+	case STARFIVE_SM4_MODE_CCM:
+		starfive_sm4_set_alen(ctx);
+		starfive_sm4_set_mlen(ctx);
+		starfive_sm4_ccm_init(ctx);
+		ret = starfive_sm4_aead_write_key(ctx, hw_mode);
+		if (ret)
+			return ret;
+		break;
+	case STARFIVE_SM4_MODE_CBC:
+	case STARFIVE_SM4_MODE_CTR:
+		starfive_sm4_write_iv(ctx, (void *)cryp->req.sreq->iv);
+		ret = starfive_sm4_write_key(ctx);
+		if (ret)
+			return ret;
+		break;
+	case STARFIVE_SM4_MODE_ECB:
+		ret = starfive_sm4_write_key(ctx);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int starfive_sm4_read_authtag(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	int i;
+
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_GCM) {
+		cryp->tag_out[0] = readl(cryp->base + STARFIVE_SM4_NONCE0);
+		cryp->tag_out[1] = readl(cryp->base + STARFIVE_SM4_NONCE1);
+		cryp->tag_out[2] = readl(cryp->base + STARFIVE_SM4_NONCE2);
+		cryp->tag_out[3] = readl(cryp->base + STARFIVE_SM4_NONCE3);
+	} else {
+		for (i = 0; i < SM4_BLOCK_32; i++)
+			cryp->tag_out[i] = readl(cryp->base + STARFIVE_SM4_SM4DIO0R);
+	}
+
+	if (is_encrypt(cryp)) {
+		scatterwalk_map_and_copy(cryp->tag_out, rctx->out_sg,
+					 cryp->total_in, cryp->authsize, 1);
+	} else {
+		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
+			return dev_err_probe(cryp->dev, -EBADMSG,
+					     "Failed tag verification\n");
+	}
+
+	return 0;
+}
+
+static void starfive_sm4_finish_req(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int err = 0;
+
+	if (cryp->authsize)
+		err = starfive_sm4_read_authtag(ctx);
+
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CBC ||
+	    (cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CTR)
+		starfive_sm4_get_iv(cryp, (void *)cryp->req.sreq->iv);
+
+	if (cryp->authsize)
+		crypto_finalize_aead_request(cryp->engine, cryp->req.areq, err);
+	else
+		crypto_finalize_skcipher_request(cryp->engine, cryp->req.sreq,
+						 err);
+}
+
+static int starfive_sm4_gcm_write_adata(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	u32 *buffer;
+	int total_len, loop;
+
+	total_len = ALIGN(cryp->assoclen, SM4_BLOCK_SIZE) / sizeof(unsigned int);
+	buffer = (u32 *)rctx->adata;
+
+	for (loop = 0; loop < total_len; loop += 4) {
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE0);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE1);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE2);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE3);
+		buffer++;
+
+		if (starfive_sm4_wait_done(cryp))
+			return dev_err_probe(cryp->dev, -ETIMEDOUT,
+					     "Timeout processing gcm aad block");
+	}
+
+	return 0;
+}
+
+static int starfive_sm4_ccm_write_adata(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	u32 *buffer;
+	int total_len, loop;
+
+	buffer = (u32 *)rctx->adata;
+	total_len = ALIGN(cryp->assoclen + 2, SM4_BLOCK_SIZE) / sizeof(unsigned int);
+
+	for (loop = 0; loop < total_len; loop += 4) {
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+
+		if (starfive_sm4_wait_done(cryp))
+			return dev_err_probe(cryp->dev, -ETIMEDOUT,
+					     "Timeout processing ccm aad block");
+	}
+
+	return 0;
+}
+
+static void starfive_sm4_dma_done(void *param)
+{
+	struct starfive_cryp_dev *cryp = param;
+
+	complete(&cryp->dma_done);
+}
+
+static void starfive_sm4_dma_init(struct starfive_cryp_dev *cryp)
+{
+	struct dw_axi_peripheral_config periph_conf = {};
+
+	memset(&cryp->cfg_in, 0, sizeof(struct dma_slave_config));
+	memset(&cryp->cfg_out, 0, sizeof(struct dma_slave_config));
+
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
+	cryp->cfg_out.direction = DMA_DEV_TO_MEM;
+	cryp->cfg_out.src_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_out.dst_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_out.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_out.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_out.src_addr = cryp->phys_base + STARFIVE_SM_ALG_FIFO_OUT_OFFSET;
+	cryp->cfg_out.peripheral_config = &periph_conf;
+	cryp->cfg_out.peripheral_size = sizeof(struct dw_axi_peripheral_config);
+
+	dmaengine_slave_config(cryp->rx, &cryp->cfg_out);
+
+	init_completion(&cryp->dma_done);
+}
+
+static int starfive_sm4_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *src,
+				 struct scatterlist *dst,
+				 int len)
+{
+	struct dma_async_tx_descriptor *in_desc, *out_desc;
+	union  starfive_sm_alg_cr alg_cr;
+	int ret = 0, in_save, out_save;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.sm4_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	in_save = sg_dma_len(src);
+	out_save = sg_dma_len(dst);
+
+	writel(ALIGN(len, SM4_BLOCK_SIZE), cryp->base + STARFIVE_SM_DMA_IN_LEN_OFFSET);
+	writel(ALIGN(len, SM4_BLOCK_SIZE), cryp->base + STARFIVE_SM_DMA_OUT_LEN_OFFSET);
+
+	sg_dma_len(src) = ALIGN(len, SM4_BLOCK_SIZE);
+	sg_dma_len(dst) = ALIGN(len, SM4_BLOCK_SIZE);
+
+	out_desc = dmaengine_prep_slave_sg(cryp->rx, dst, 1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc) {
+		ret = -EINVAL;
+		goto dma_err;
+	}
+
+	out_desc->callback = starfive_sm4_dma_done;
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
+
+dma_err:
+	sg_dma_len(src) = in_save;
+	sg_dma_len(dst) = out_save;
+
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_sm4_map_sg(struct starfive_cryp_dev *cryp,
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
+
+			len = min(sg_dma_len(stsg), remain);
+
+			ret = starfive_sm4_dma_xfer(cryp, stsg, dtsg, len);
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
+			ret = starfive_sm4_dma_xfer(cryp, stsg, dtsg, len);
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
+}
+
+static int starfive_sm4_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req =
+		container_of(areq, struct skcipher_request, base);
+	struct starfive_cryp_ctx *ctx =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = skcipher_request_ctx(req);
+	int ret;
+
+	cryp->req.sreq = req;
+	cryp->total_in = req->cryptlen;
+	cryp->total_out = req->cryptlen;
+	cryp->assoclen = 0;
+	cryp->authsize = 0;
+
+	rctx->in_sg = req->src;
+	rctx->out_sg = req->dst;
+
+	ctx->rctx = rctx;
+
+	ret = starfive_sm4_hw_init(ctx);
+	if (ret)
+		return ret;
+
+	starfive_sm4_dma_init(cryp);
+
+	ret = starfive_sm4_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+	starfive_sm4_finish_req(ctx);
+
+	return 0;
+}
+
+static int starfive_sm4_init_tfm(struct crypto_skcipher *tfm,
+				 const char *alg_name)
+{
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->skcipher_fbk = crypto_alloc_skcipher(alg_name, 0,
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->skcipher_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->skcipher_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
+				    crypto_skcipher_reqsize(ctx->skcipher_fbk));
+
+	return 0;
+}
+
+static void starfive_sm4_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(ctx->skcipher_fbk);
+}
+
+static int starfive_sm4_aead_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct aead_request *req =
+		container_of(areq, struct aead_request, base);
+	struct starfive_cryp_ctx *ctx =
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = aead_request_ctx(req);
+	struct scatterlist _dst[2], _src[2];
+	int ret;
+
+	cryp->req.areq = req;
+	cryp->assoclen = req->assoclen;
+	cryp->authsize = crypto_aead_authsize(crypto_aead_reqtfm(req));
+
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
+
+	if (cryp->assoclen) {
+		if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CCM) {
+			rctx->adata = kzalloc(cryp->assoclen + 2 + SM4_BLOCK_SIZE, GFP_KERNEL);
+			if (!rctx->adata)
+				return -ENOMEM;
+
+			/* Append 2 bytes zeroes at the start of ccm aad */
+			rctx->adata[0] = 0;
+			rctx->adata[1] = 0;
+
+			sg_copy_to_buffer(req->src,
+					  sg_nents_for_len(req->src, cryp->assoclen),
+					  &rctx->adata[2], cryp->assoclen);
+		} else {
+			rctx->adata = kzalloc(cryp->assoclen + SM4_BLOCK_SIZE, GFP_KERNEL);
+			if (!rctx->adata)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "Failed to alloc memory for adata");
+
+			sg_copy_to_buffer(req->src,
+					  sg_nents_for_len(req->src, cryp->assoclen),
+					  rctx->adata, cryp->assoclen);
+		}
+	}
+
+	rctx->in_sg = scatterwalk_ffwd(_src, req->src, cryp->assoclen);
+	if (req->src == req->dst)
+		rctx->out_sg = rctx->in_sg;
+	else
+		rctx->out_sg = scatterwalk_ffwd(_dst, req->dst, cryp->assoclen);
+
+	if (cryp->total_in)
+		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
+			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       cryp->total_in);
+
+	ctx->rctx = rctx;
+
+	ret = starfive_sm4_hw_init(ctx);
+	if (ret)
+		return ret;
+
+	if (!cryp->assoclen)
+		goto write_text;
+
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CCM)
+		ret = starfive_sm4_ccm_write_adata(ctx);
+	else
+		ret = starfive_sm4_gcm_write_adata(ctx);
+
+	kfree(rctx->adata);
+
+	if (ret)
+		return ret;
+
+write_text:
+	if (!cryp->total_in)
+		goto finish_req;
+
+	starfive_sm4_dma_init(cryp);
+
+	ret = starfive_sm4_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+finish_req:
+	starfive_sm4_finish_req(ctx);
+	return 0;
+}
+
+static int starfive_sm4_aead_init_tfm(struct crypto_aead *tfm,
+				      const char *alg_name)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->aead_fbk = crypto_alloc_aead(alg_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->aead_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ctx) +
+				crypto_aead_reqsize(ctx->aead_fbk));
+
+	return 0;
+}
+
+static void starfive_sm4_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+
+	crypto_free_aead(ctx->aead_fbk);
+}
+
+static bool starfive_sm4_check_unaligned(struct starfive_cryp_dev *cryp,
+					 struct scatterlist *src,
+					 struct scatterlist *dst)
+{
+	struct scatterlist *tsg;
+	int i;
+
+	for_each_sg(src, tsg, sg_nents(src), i)
+		if (!IS_ALIGNED(tsg->length, SM4_BLOCK_SIZE) &&
+		    !sg_is_last(tsg))
+			return true;
+
+	if (src != dst)
+		for_each_sg(dst, tsg, sg_nents(dst), i)
+			if (!IS_ALIGNED(tsg->length, SM4_BLOCK_SIZE) &&
+			    !sg_is_last(tsg))
+				return true;
+
+	return false;
+}
+
+static int starfive_sm4_do_fallback(struct skcipher_request *req, bool enc)
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
+static int starfive_sm4_crypt(struct skcipher_request *req, unsigned long flags)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	unsigned int blocksize_align = crypto_skcipher_blocksize(tfm) - 1;
+
+	cryp->flags = flags;
+
+	if ((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_ECB ||
+	    (cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CBC)
+		if (req->cryptlen & blocksize_align)
+			return -EINVAL;
+
+	if (starfive_sm4_check_unaligned(cryp, req->src, req->dst))
+		return starfive_sm4_do_fallback(req, is_encrypt(cryp));
+
+	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm4_aead_do_fallback(struct aead_request *req, bool enc)
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
+static int starfive_sm4_aead_crypt(struct aead_request *req, unsigned long flags)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct scatterlist *src, *dst, _src[2], _dst[2];
+
+	cryp->flags = flags;
+
+	/* sm4-ccm does not support tag verification for non-aligned text,
+	 * use fallback for ccm decryption instead.
+	 */
+	if (((cryp->flags & FLG_MODE_MASK) == STARFIVE_SM4_MODE_CCM) &&
+	    !is_encrypt(cryp))
+		return starfive_sm4_aead_do_fallback(req, 0);
+
+	src = scatterwalk_ffwd(_src, req->src, req->assoclen);
+
+	if (req->src == req->dst)
+		dst = src;
+	else
+		dst = scatterwalk_ffwd(_dst, req->dst, req->assoclen);
+
+	if (starfive_sm4_check_unaligned(cryp, src, dst))
+		return starfive_sm4_aead_do_fallback(req, is_encrypt(cryp));
+
+	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen = keylen;
+
+	return crypto_skcipher_setkey(ctx->skcipher_fbk, key, keylen);
+}
+
+static int starfive_sm4_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+				    unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen = keylen;
+
+	return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
+}
+
+static int starfive_sm4_gcm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = crypto_gcm_check_authsize(authsize);
+	if (ret)
+		return ret;
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
+}
+
+static int starfive_sm4_ccm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	struct starfive_cryp_ctx *ctx = crypto_aead_ctx(tfm);
+
+	switch (authsize) {
+	case 4:
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 14:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
+}
+
+static int starfive_sm4_ecb_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_ECB | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_ecb_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_ECB);
+}
+
+static int starfive_sm4_cbc_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CBC | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_cbc_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CBC);
+}
+
+static int starfive_sm4_ctr_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CTR | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_ctr_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CTR);
+}
+
+static int starfive_sm4_gcm_encrypt(struct aead_request *req)
+{
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_GCM | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_gcm_decrypt(struct aead_request *req)
+{
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_GCM);
+}
+
+static int starfive_sm4_ccm_encrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret = starfive_sm4_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_CCM | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_ccm_decrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret = starfive_sm4_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_CCM);
+}
+
+static int starfive_sm4_ecb_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "ecb(sm4-generic)");
+}
+
+static int starfive_sm4_cbc_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "cbc(sm4-generic)");
+}
+
+static int starfive_sm4_ctr_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "ctr(sm4-generic)");
+}
+
+static int starfive_sm4_ccm_aead_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_sm4_aead_init_tfm(tfm, "ccm_base(ctr(sm4-generic),cbcmac(sm4-generic))");
+}
+
+static int starfive_sm4_gcm_aead_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_sm4_aead_init_tfm(tfm, "gcm_base(ctr(sm4-generic),ghash-generic)");
+}
+
+static struct skcipher_engine_alg skcipher_sm4[] = {
+{
+	.base.init			= starfive_sm4_ecb_init_tfm,
+	.base.exit			= starfive_sm4_exit_tfm,
+	.base.setkey			= starfive_sm4_setkey,
+	.base.encrypt			= starfive_sm4_ecb_encrypt,
+	.base.decrypt			= starfive_sm4_ecb_decrypt,
+	.base.min_keysize		= SM4_KEY_SIZE,
+	.base.max_keysize		= SM4_KEY_SIZE,
+	.base.base = {
+		.cra_name		= "ecb(sm4)",
+		.cra_driver_name	= "starfive-ecb-sm4",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= SM4_BLOCK_SIZE,
+		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+	.op = {
+		.do_one_request = starfive_sm4_do_one_req,
+	},
+}, {
+	.base.init			= starfive_sm4_ctr_init_tfm,
+	.base.exit			= starfive_sm4_exit_tfm,
+	.base.setkey			= starfive_sm4_setkey,
+	.base.encrypt			= starfive_sm4_ctr_encrypt,
+	.base.decrypt			= starfive_sm4_ctr_decrypt,
+	.base.min_keysize		= SM4_KEY_SIZE,
+	.base.max_keysize		= SM4_KEY_SIZE,
+	.base.ivsize			= SM4_BLOCK_SIZE,
+	.base.base = {
+		.cra_name		= "ctr(sm4)",
+		.cra_driver_name	= "starfive-ctr-sm4",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+	.op = {
+		.do_one_request = starfive_sm4_do_one_req,
+	},
+}, {
+	.base.init			= starfive_sm4_cbc_init_tfm,
+	.base.exit			= starfive_sm4_exit_tfm,
+	.base.setkey			= starfive_sm4_setkey,
+	.base.encrypt			= starfive_sm4_cbc_encrypt,
+	.base.decrypt			= starfive_sm4_cbc_decrypt,
+	.base.min_keysize		= SM4_KEY_SIZE,
+	.base.max_keysize		= SM4_KEY_SIZE,
+	.base.ivsize			= SM4_BLOCK_SIZE,
+	.base.base = {
+		.cra_name		= "cbc(sm4)",
+		.cra_driver_name	= "starfive-cbc-sm4",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= SM4_BLOCK_SIZE,
+		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+	.op = {
+		.do_one_request = starfive_sm4_do_one_req,
+	},
+},
+};
+
+static struct aead_engine_alg aead_sm4[] = {
+{
+	.base.setkey			= starfive_sm4_aead_setkey,
+	.base.setauthsize		= starfive_sm4_gcm_setauthsize,
+	.base.encrypt			= starfive_sm4_gcm_encrypt,
+	.base.decrypt			= starfive_sm4_gcm_decrypt,
+	.base.init			= starfive_sm4_gcm_aead_init_tfm,
+	.base.exit			= starfive_sm4_aead_exit_tfm,
+	.base.ivsize			= GCM_AES_IV_SIZE,
+	.base.maxauthsize		= SM4_BLOCK_SIZE,
+	.base.base = {
+		.cra_name		= "gcm(sm4)",
+		.cra_driver_name	= "starfive-gcm-sm4",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+	.op = {
+		.do_one_request = starfive_sm4_aead_do_one_req,
+	},
+}, {
+	.base.setkey			= starfive_sm4_aead_setkey,
+	.base.setauthsize		= starfive_sm4_ccm_setauthsize,
+	.base.encrypt			= starfive_sm4_ccm_encrypt,
+	.base.decrypt			= starfive_sm4_ccm_decrypt,
+	.base.init			= starfive_sm4_ccm_aead_init_tfm,
+	.base.exit			= starfive_sm4_aead_exit_tfm,
+	.base.ivsize			= SM4_BLOCK_SIZE,
+	.base.maxauthsize		= SM4_BLOCK_SIZE,
+	.base.base = {
+		.cra_name		= "ccm(sm4)",
+		.cra_driver_name	= "starfive-ccm-sm4",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		= 0xf,
+		.cra_module		= THIS_MODULE,
+	},
+	.op = {
+		.do_one_request = starfive_sm4_aead_do_one_req,
+	},
+},
+};
+
+int starfive_sm4_register_algs(void)
+{
+	int ret;
+
+	ret = crypto_engine_register_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm4));
+	if (ret)
+		return ret;
+
+	ret = crypto_engine_register_aeads(aead_sm4, ARRAY_SIZE(aead_sm4));
+	if (ret)
+		crypto_engine_unregister_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm4));
+
+	return ret;
+}
+
+void starfive_sm4_unregister_algs(void)
+{
+	crypto_engine_unregister_aeads(aead_sm4, ARRAY_SIZE(aead_sm4));
+	crypto_engine_unregister_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm4));
+}
-- 
2.34.1


