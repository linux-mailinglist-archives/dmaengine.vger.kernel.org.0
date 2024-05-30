Return-Path: <dmaengine+bounces-2208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B38D4449
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 05:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAAA1F23E14
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E621EEF9;
	Thu, 30 May 2024 03:48:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAB1B947;
	Thu, 30 May 2024 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040884; cv=fail; b=ankEZDDM8o1+vlgFaWDHxCmW8GhtP8SwATiM4v5TlGIytj0xsXnw3HTpuXfdV9g9Stzq5h4QGIHNpx1lRebqvQcoopL7Wek1DkbF/TkIIWPkRrPBnE4DjaChOJvNahIkImKHS2dWPDuVJZmA3sf9VyygI+vAvRZFHvGzI3aXWcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040884; c=relaxed/simple;
	bh=IO4SKfHlUBzexslaueOylAeVmeNLO+uDLwWMn/4q9aQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQpnVCZqbtR5FrcLPmGLltCGg/KbokwTE/xatLuKOiKJOLNgt8mf8d2myK5NlDTCC+quqMjsO2X91iHrTrhOHz+zggABPrP1imIBnryo7TMebYtOC0rWVR95sOktY+9SWIjz6Nged2LlYWL1gpmDWnbzxwCJj/T47T+segu3EZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOibluYpef2A69KwYJ7uZUrCUnLsvCJ8xyIuvPr8BPPAgwqaGpBO94FLZ49hfXPaQFIYOSDHirZNMtPU73dqP5WLpG4cUiG6J4gU+lpJ0Kfa7SLbJnnTN1H7sj4SdC5XX1xl5NWRITCTaQemnbeFEqPwSNXG2NfBltbfUuRihQBzK0cqk8PE62Jf3DfjL3vsIax0TV+N7UpMujiG2xrIpYNSNvWxHicMwzx/VHUllD2IvpLE/0HDhe83zIkmr8/r0gp2Fc1xIq40zjcGrDh/3D95U9k4SGRwi81Nn3fbdWkStQZDmTZZjMjGpMmcoq6GofJ5jSLrTjxaeddm01K5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P946W6R22krBX5mPxyVBE3TMcDHsrgQ37/EJcG/W9FE=;
 b=n7/v55CwrMAsCMyptrb4xpvcx3/IZddfvj6GblCIjF2+OSlTn82gcEOPqInB4CzQgxjuL0cFW+W23vlbCG11p2DXDGpcomwCHCIAnNlcc4asLnN0EzkqNhIumDldpMqOXx7igP6dRShLfFkXftPld6/vZEUnwO3ZgVgmn/rYXzKhE28a7vt5WVXZhyDNdfgHAi3kwNLCFsLvfHd/0P4RGYOp19obofcv5SurpQueQBtmlPbCgkwdMcmndrTGIpYOHb2M721arRzpuo5NUfel0s4tQ/Z9sH+jlU6ElahSxIKsp5l1Yjd2KV0jqYrHoMDBgYHhM9H35gHP6ri3nHXW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 03:11:30 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce]) by NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce%7]) with mapi id 15.20.7587.037; Thu, 30 May 2024
 03:11:29 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 3/3] crypto: starfive: Add sm4 support for JH8100
Date: Thu, 30 May 2024 11:11:12 +0800
Message-ID: <20240530031112.4952-4-jiajie.ho@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6310733-4004-49fe-e36a-08dc80563357
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|41320700004|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	aaXqndxMqf/M0YVLCSoEqQomhgQsrbDL1ZCs8jkCF/j13enfutZVzwlgur5N6Q0pGvdpMyE+dIWQqMTb+9E2MUzPRraISoSNG4RE/ySBQdH9OMwoUUUWLS5U1TklBJQ30X/rAsvFFTZ0g8Y4e3O/QRD/mWG5kF2qcmOyx+LvGNwFbp+UP08x5rMW0jtUxmiiwfZSPuExtizXKfN2+T4bWVSB0DdjKa/EsJBcaYu9x2QYwbmtHqb9EJY4R+0twhL2iKua657x9zJAnH/Fuji7xxasSDuArhkx45pJ9dMojBncgZQ8qlfJrQjWwQE7IIikJtbfzGIP0G4C6YBlqAlllarXPQ44qNp7Hrj9HtFYXC9sBuQavmyQYfo9kX36kOpsKJfXp0UjkgPkAJTV9AaABBLQjlGQ+2R279+F15yaVEJTllMjEpHZwc/xu7h6J5Q7XCm9pa382CVoZ/nfs2IpI5sGvdsGbymF8hw3f40SMfdz10cHndUpHdwXYjs4LcHco02bjRPXFq2Td+m3h5ZQXtI4+B7V3qU3YcEgStFjlSNjiX3mLB+fPEDBN/hI+2dF5Bmbi2ZWsXzXA8/D34tbQS1vZjaRsJ4hVmyO9mcSXWCgeo1cxHOGkNq7pXEXT2mH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGjGr5zvl0Gls4RT8GpDD4ULFkC2q1A3abXnZIBJw/zvn+8ut0zq2u8Dkh3o?=
 =?us-ascii?Q?DCqSp0LfXiWakqMN98LKjwk61hdxrEpUXtsBwxmFZadd9/4oZ1LtK17DbJPO?=
 =?us-ascii?Q?rt0RsDz0OcV+jDRRYBEMvChU2a/s7EOixOutW+DnzTx0e4Tzt4hYR20Sc/xI?=
 =?us-ascii?Q?dAUrofJ8M8jXG3rysddBwS8NtAm37ly6duTs5Tmsuh4uI+gFa6fptc3PfQlx?=
 =?us-ascii?Q?4kjxklX1VKftdLb1P+bFX9MuDDAbZRfB2s4Kj+ghRRIFkUCLDzDn+29U7UPi?=
 =?us-ascii?Q?WcgYqhzpb3cVycZ9egr32tcW7dReTU9qOvTGnmVPmKGOC/O3Abc7fOGqiX6Q?=
 =?us-ascii?Q?HrrsybJ88n1p0aPF6UcqKy/+Jmgf6vrrz/Q4sZ6ULLMz6/qr6DFE5tLVFoj+?=
 =?us-ascii?Q?rmhsTZvBIJ2MkqG6wB8twWMGJwx/kcD18WlxSLG8+nzgIcHjCT0GnDiTvNwM?=
 =?us-ascii?Q?3wjOLLVz4VQfJoikPDWhxi5SIL3R1PchWXnYoQSbQ0s+Ed/dzC/rMzAvmW9r?=
 =?us-ascii?Q?Ju3EF96oXtr1qhkAgT25e/6IryPjij0Z5+VpJ8YvxlTdenzHf67zB+gFIc/0?=
 =?us-ascii?Q?HVV8k43Y+v2TKGqVlyOsqPAPOuN7NhNEfDZhx55c/nLjXPysQPTOdUgt18/P?=
 =?us-ascii?Q?5RzMOroOngPgx3VysAD2P9cP1VqXLgIRO5W/0fRNIrqKlP2i+PeeuqUaPbAa?=
 =?us-ascii?Q?tB8BypzMSts+rlMX+Wk7L0ytGtCpWXEtMgVu6+aOJlsyE32IqeohggE5pIGj?=
 =?us-ascii?Q?0opamhOheLjAsoOqr2IN1JJfrcMJIUB0oC/abv8N/bAyFYcIkZBvPQxnZtKZ?=
 =?us-ascii?Q?qU5hY19PAUg3stf6uNKXU//i8wBs9afnZP/Y2LqqDHOQJVBldbpjdC9Ye3Qn?=
 =?us-ascii?Q?MSFnecQ6gBtbO8KOUt8Yxcda09ZNoJO5nmd+eZ9E42Vga8QA7d686Z0RnXHW?=
 =?us-ascii?Q?l4TEVCbNo8slMWRYnJV2Rn+d701tAXhjdEQvM9jZOI3Tsjj+3ogixSrW5ZCm?=
 =?us-ascii?Q?tKtSs2YvAo6EsCpVydHpxu3agcsAmAAIdErPCLk0f62rwW+8fON7KgMz1efq?=
 =?us-ascii?Q?YsTlQwxZHEqKPg3Kg8TjVHvbLfprngDMDyII4nJwzjHU7+gjA8Dn0275hUMm?=
 =?us-ascii?Q?7F8RJUQnyaGnlNtVm335W2Lk4Mwvz1k1STBuAQFQqqTZJAUZ/KnKz3pKGQF/?=
 =?us-ascii?Q?fotUMLrD7N93feg+1n7mDp6vC2LkSaI1asylCCv3IaiOG98VkkMYpLmF3X8/?=
 =?us-ascii?Q?oNs4LozEa0vKzK2f/rqYlaL5Q4M1i2unz8yQrx0ULeiONl3aDAJOFnQGXIDl?=
 =?us-ascii?Q?OHIFsaMRTDxHT9EQBAnv1DyP7dyTwZ2FuK31/C93BPmRCGw7XfvN1IvQsVJx?=
 =?us-ascii?Q?58yK/hilV8bsUehhgHOwGrpgwIzz7Pcp9IQX0UrAelX7E/h1+SHE14SVG1Ll?=
 =?us-ascii?Q?4ZsKSfjaRpQc8xP1gRGTwta7cKVF6sh2FTPKTa235mK9xvllmZkPQTUqkTyI?=
 =?us-ascii?Q?zfEgFRsRW52YhOKDI9X2bbDHkOPNzdI7e3oyiLb5OTUKnMMCdq1S3M3M4noR?=
 =?us-ascii?Q?VE2yWTCBw37h31NvyFbtW83kB2hbmApQQmLEhOlMfVCg6+TXkiif/URctsly?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6310733-4004-49fe-e36a-08dc80563357
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:11:29.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Sw7Elwi9jaxiD5Xgj/z79bUebOZ6H6FyB6kV/2Yzr5taNi9HozX7XIJxlLwaqRaozZCU3Xa96qwnENbDd3mphRbhITmbScbBntTfGQwCYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1054

Add driver support for sm4 skcipher and aead for StarFive JH8100 SoC.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |    1 +
 drivers/crypto/starfive/Makefile      |    4 +-
 drivers/crypto/starfive/jh7110-cryp.c |   10 +-
 drivers/crypto/starfive/jh7110-cryp.h |   39 +
 drivers/crypto/starfive/jh8100-sm4.c  | 1123 +++++++++++++++++++++++++
 5 files changed, 1174 insertions(+), 3 deletions(-)
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
index 60ac752352c8..ca35062fff60 100644
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
@@ -295,4 +331,7 @@ void starfive_aes_unregister_algs(void);
 
 int starfive_sm3_register_algs(void);
 void starfive_sm3_unregister_algs(void);
+
+int starfive_sm4_register_algs(void);
+void starfive_sm4_unregister_algs(void);
 #endif
diff --git a/drivers/crypto/starfive/jh8100-sm4.c b/drivers/crypto/starfive/jh8100-sm4.c
new file mode 100644
index 000000000000..195ba95fab7e
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm4.c
@@ -0,0 +1,1123 @@
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
2.43.0


