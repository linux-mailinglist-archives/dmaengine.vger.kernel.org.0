Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C05723101
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jun 2023 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjFEUR6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Jun 2023 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjFEURA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Jun 2023 16:17:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E56E75;
        Mon,  5 Jun 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996187; x=1717532187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4jdov+lWEPj68tMKfM1TkOPum0Ie/5M1oFN5iU5axg=;
  b=NINe2dvlLUKxlFYN3ihV+4q5//3A3BjrnameSzMKRBQlVBFPT95hXFgL
   A+nYpiTNRx08Hf9IEJJD3wkdCAMHW2MwiFupBeefMC0ahM21YFxC93dpn
   S6hDx5Rg6uMnzowL9t6FNEsihP8qV+jhCg4QE4mmUZLkN1hfD+fCqmy6Y
   QhkXtC66aGqWE9bHKFIAIb+eMFqI4KvmoYz2lXLtHXt2CmpvlFBnslst1
   F47gsLnohadXEC0nmnZ24biQtBb/NU/UdC9YRST7vUmmsc9zKjtHXAZ6h
   Lq8B+vt/wsB2NozCrZ4ozfGpPyoE+Icq2QF+4llKR4zHIndiksFTklpMo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356480464"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356480464"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711934578"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711934578"
Received: from rkbrewer-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.33.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:16:05 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v6 13/15] crypto: iaa - Add support for deflate-iaa-canned compression algorithm
Date:   Mon,  5 Jun 2023 15:15:34 -0500
Message-Id: <20230605201536.738396-14-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
References: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for a 'canned' compression mode using the IAA compression
mode in-kernel API.

The IAA 'canned' compression mode is added alongside the existing
'fixed' compression mode and a crypto algorithm named
'deflate-iaa-canned' is registered using it.

It implements a good general-purpose compression scheme whose tables
were generated from statistics derived from a wide variety of SPEC17
workloads.

It provides much better overall characteristics than the existing
deflate-1951 tables implemented by deflate-iaa.

Either 'fixed' or 'canned' modes can be chosen as the mode to be used
by crypto facilities by selecting the corresponding algorithm.  For
example, to use IAA fixed mode in zswap:

  echo deflate-iaa > /sys/module/zswap/parameters/compressor

To choose 'canned' mode:

  echo deflate-iaa-canned > /sys/module/zswap/parameters/compressor

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 crypto/testmgr.c                              |  10 ++
 crypto/testmgr.h                              |  72 ++++++++++++
 drivers/crypto/intel/iaa/Makefile             |   2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h         |   3 +
 .../crypto/intel/iaa/iaa_crypto_comp_canned.c | 110 ++++++++++++++++++
 drivers/crypto/intel/iaa/iaa_crypto_main.c    |  64 +++++++++-
 6 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index b6d924e0ff59..692a721568a3 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4829,6 +4829,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(deflate_decomp_tv_template)
 			}
 		}
+	}, {
+		.alg = "deflate-iaa-canned",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(deflate_iaa_canned_comp_tv_template),
+				.decomp = __VECS(deflate_iaa_canned_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5ca7a412508f..1898151e629a 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -35829,6 +35829,78 @@ static const struct comp_testvec zlib_deflate_decomp_tv_template[] = {
 	},
 };
 
+static const struct comp_testvec deflate_iaa_canned_comp_tv_template[] = {
+	{
+		.inlen	= 70,
+		.outlen	= 37,
+		.input	= "Join us now and share the software "
+			"Join us now and share the software ",
+		.output	= "\x6d\x23\x43\x23\xa4\x71\x31\xd2"
+			  "\x88\xc8\x61\x52\x75\x84\x56\x1a"
+			  "\x13\xa2\x8e\xd6\x49\x63\x43\x74"
+			  "\xd2\x98\xc8\xe0\xd8\x61\x58\x69"
+			  "\xcb\x71\x01\xe5\x7f",
+	}, {
+		.inlen	= 191,
+		.outlen	= 128,
+		.input	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+		.output	= "\xdd\x42\x42\x63\xa4\xda\x48\x4d"
+			  "\x5c\xb8\x2e\x22\x56\xaa\xd5\xc5"
+			  "\x68\xa2\x43\x83\x74\x31\x52\xb5"
+			  "\x54\x13\x19\x1e\x15\xad\x8b\x89"
+			  "\x09\x8d\x8c\x90\x86\xeb\x62\x43"
+			  "\x22\xb5\xd2\x20\x75\x8c\x4e\x2b"
+			  "\x05\x3d\x36\x44\x27\xf5\x69\xe5"
+			  "\xdb\xde\xbb\x5b\x2b\x7d\x37\x75"
+			  "\xd8\xc0\xc8\xe8\xd0\xd8\x90\x70"
+			  "\x7b\xa9\x54\x1c\x38\x38\x34\x02"
+			  "\xc2\xe2\x8e\xea\xa8\xa8\xb0\x50"
+			  "\x8d\x3a\x16\xf7\x88\x0c\xd6\x8f"
+			  "\x95\x1f\x40\x1a\x1b\x29\x34\xb4"
+			  "\xf1\x97\xfa\xab\x87\x87\x45\xaa"
+			  "\xb5\xd2\x96\x7a\x03\xf9\x47\x47"
+			  "\xc6\x46\x6a\x22\xc3\xec\xff\x07",
+	},
+};
+
+static const struct comp_testvec deflate_iaa_canned_decomp_tv_template[] = {
+	{
+		.inlen	= 128,
+		.outlen	= 191,
+		.input	= "\xdd\x42\x42\x63\xa4\xda\x48\x4d"
+			  "\x5c\xb8\x2e\x22\x56\xaa\xd5\xc5"
+			  "\x68\xa2\x43\x83\x74\x31\x52\xb5"
+			  "\x54\x13\x19\x1e\x15\xad\x8b\x89"
+			  "\x09\x8d\x8c\x90\x86\xeb\x62\x43"
+			  "\x22\xb5\xd2\x20\x75\x8c\x4e\x2b"
+			  "\x05\x3d\x36\x44\x27\xf5\x69\xe5"
+			  "\xdb\xde\xbb\x5b\x2b\x7d\x37\x75"
+			  "\xd8\xc0\xc8\xe8\xd0\xd8\x90\x70"
+			  "\x7b\xa9\x54\x1c\x38\x38\x34\x02"
+			  "\xc2\xe2\x8e\xea\xa8\xa8\xb0\x50"
+			  "\x8d\x3a\x16\xf7\x88\x0c\xd6\x8f"
+			  "\x95\x1f\x40\x1a\x1b\x29\x34\xb4"
+			  "\xf1\x97\xfa\xab\x87\x87\x45\xaa"
+			  "\xb5\xd2\x96\x7a\x03\xf9\x47\x47"
+			  "\xc6\x46\x6a\x22\xc3\xec\xff\x07",
+		.output	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+	}, {
+		.inlen	= 37,
+		.outlen	= 70,
+		.input	= "\x6d\x23\x43\x23\xa4\x71\x31\xd2"
+			  "\x88\xc8\x61\x52\x75\x84\x56\x1a"
+			  "\x13\xa2\x8e\xd6\x49\x63\x43\x74"
+			  "\xd2\x98\xc8\xe0\xd8\x61\x58\x69"
+			  "\xcb\x71\x01\xe5\x7f",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 /*
  * LZO test vectors (null-terminated strings).
  */
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
index cc87feffd059..ff6ab1d0bc13 100644
--- a/drivers/crypto/intel/iaa/Makefile
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -7,4 +7,4 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
-iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o
+iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_canned.o iaa_crypto_comp_fixed.o
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 4c6b0f5a6b50..1144ea06a1b0 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -114,6 +114,8 @@ struct aecs_decomp_table_record {
 	u32 decomp_state[1220];
 } __packed;
 
+int iaa_aecs_init_canned(void);
+void iaa_aecs_cleanup_canned(void);
 int iaa_aecs_init_fixed(void);
 void iaa_aecs_cleanup_fixed(void);
 
@@ -148,6 +150,7 @@ void remove_iaa_compression_mode(const char *name);
 
 enum iaa_mode {
 	IAA_MODE_FIXED,
+	IAA_MODE_CANNED,
 };
 
 struct iaa_compression_ctx {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c
new file mode 100644
index 000000000000..aff0899ffb9e
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#include "idxd.h"
+#include "iaa_crypto.h"
+
+#define IAA_AECS_ALIGN			32
+
+/*
+ * These tables were generated from statistics derived from a wide
+ * variety of SPEC17 workloads and implement a good general-purpose
+ * compression scheme called simply 'canned'.
+ */
+
+static const u32 canned_ll_iaa[286] = {
+0x28002,  0x38024,  0x40066,  0x40067,  0x40068,  0x48144,  0x40069,  0x48145,
+0x4006a,  0x48146,  0x4006b,  0x48147,  0x48148,  0x48149,  0x4814a,  0x4814b,
+0x4006c,  0x4814c,  0x4814d,  0x4814e,  0x4814f,  0x48150,  0x48151,  0x48152,
+0x4006d,  0x48153,  0x48154,  0x48155,  0x48156,  0x48157,  0x48158,  0x48159,
+0x38025,  0x4815a,  0x4815b,  0x4815c,  0x4815d,  0x4815e,  0x4815f,  0x48160,
+0x4006e,  0x48161,  0x48162,  0x48163,  0x48164,  0x48165,  0x4006f,  0x48166,
+0x38026,  0x38027,  0x40070,  0x40071,  0x40072,  0x40073,  0x40074,  0x40075,
+0x38028,  0x40076,  0x40077,  0x48167,  0x40078,  0x40079,  0x4007a,  0x38029,
+0x3802a,  0x4007b,  0x48168,  0x48169,  0x4007c,  0x4816a,  0x4007d,  0x4816b,
+0x4007e,  0x4816c,  0x4816d,  0x4816e,  0x4816f,  0x48170,  0x48171,  0x48172,
+0x4007f,  0x48173,  0x48174,  0x48175,  0x48176,  0x48177,  0x48178,  0x48179,
+0x40080,  0x4817a,  0x4817b,  0x4817c,  0x4817d,  0x4817e,  0x4817f,  0x48180,
+0x40081,  0x3802b,  0x40082,  0x3802c,  0x3802d,  0x3802e,  0x40083,  0x48181,
+0x40084,  0x40085,  0x48182,  0x48183,  0x40086,  0x40087,  0x40088,  0x40089,
+0x4008a,  0x48184,  0x4008b,  0x4008c,  0x4008d,  0x4008e,  0x48185,  0x48186,
+0x4008f,  0x48187,  0x48188,  0x48189,  0x4818a,  0x4818b,  0x4818c,  0x4818d,
+0x40090,  0x4818e,  0x4818f,  0x48190,  0x48191,  0x48192,  0x48193,  0x48194,
+0x40091,  0x48195,  0x48196,  0x48197,  0x48198,  0x48199,  0x4819a,  0x4819b,
+0x40092,  0x4819c,  0x4819d,  0x4819e,  0x4819f,  0x481a0,  0x481a1,  0x481a2,
+0x40093,  0x481a3,  0x481a4,  0x481a5,  0x481a6,  0x481a7,  0x481a8,  0x481a9,
+0x40094,  0x481aa,  0x481ab,  0x481ac,  0x481ad,  0x481ae,  0x481af,  0x481b0,
+0x481b1,  0x481b2,  0x481b3,  0x481b4,  0x481b5,  0x481b6,  0x481b7,  0x481b8,
+0x40095,  0x481b9,  0x481ba,  0x481bb,  0x481bc,  0x481bd,  0x481be,  0x481bf,
+0x40096,  0x481c0,  0x481c1,  0x481c2,  0x481c3,  0x481c4,  0x481c5,  0x40097,
+0x40098,  0x481c6,  0x481c7,  0x481c8,  0x481c9,  0x481ca,  0x481cb,  0x481cc,
+0x40099,  0x481cd,  0x481ce,  0x481cf,  0x481d0,  0x481d1,  0x481d2,  0x481d3,
+0x4009a,  0x481d4,  0x481d5,  0x481d6,  0x481d7,  0x481d8,  0x481d9,  0x481da,
+0x481db,  0x481dc,  0x481dd,  0x481de,  0x481df,  0x481e0,  0x481e1,  0x481e2,
+0x4009b,  0x481e3,  0x481e4,  0x481e5,  0x481e6,  0x481e7,  0x481e8,  0x481e9,
+0x481ea,  0x481eb,  0x481ec,  0x481ed,  0x481ee,  0x481ef,  0x481f0,  0x481f1,
+0x4009c,  0x481f2,  0x481f3,  0x481f4,  0x481f5,  0x481f6,  0x481f7,  0x481f8,
+0x481f9,  0x481fa,  0x481fb,  0x503fe,  0x481fc,  0x481fd,  0x481fe,  0x4009d,
+0x503ff,  0x20000,  0x28003,  0x30010,  0x28004,  0x28005,  0x28006,  0x4009e,
+0x4009f,  0x3802f,  0x38030,  0x30011,  0x400a0,  0x38031,  0x38032,  0x400a1,
+0x28007,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,
+0x0,  0x0,  0x0,  0x0,  0x0,  0x0,
+};
+
+static const u32 canned_d_iaa[30] = {
+0x3807e,  0x20004,  0x481fe,  0x18000,  0x400fe,  0x18001,  0x3003c,  0x20005,
+0x20006,  0x28016,  0x20007,  0x28017,  0x20008,  0x28018,  0x28019,  0x20009,
+0x2000a,  0x2801a,  0x2801b,  0x2801c,  0x2801d,  0x3003d,  0x3003e,  0x481ff,
+0x0,  0x0,  0x0,  0x0,  0x0,  0x0,
+};
+
+#define CANNED_HEADER_SIZE (71)
+
+static const u8 canned_header[] = {
+0x85, 0xd7, 0x05, 0x40, 0x54, 0x4d, 0x10, 0x06,
+0x80, 0x3d, 0x40, 0x44, 0x2c, 0x6c, 0xec, 0xb3,
+0xb1, 0xf0, 0x8e, 0x3c, 0x10, 0xb8, 0x43, 0x11,
+0xb1, 0xb1, 0xb1, 0x39, 0xee, 0x0e, 0x41, 0x29,
+0x09, 0xc5, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0x6e,
+0xc5, 0xc6, 0x04, 0x1b, 0x1b, 0xbb, 0x15, 0xbb,
+0x15, 0x3b, 0x7e, 0x95, 0x7f, 0xf6, 0xed, 0x2e,
+0xdc, 0x3d, 0xee, 0xd8, 0x1b, 0x3f, 0xbe, 0x37,
+0xb3, 0xb3, 0xb3, 0x3b, 0xb3, 0xf1, 0x9e,
+};
+
+#define HEADER_SIZE_IN_BITS 568
+
+#define CEIL(a, b)     (((a) + ((b) - 1)) / (b))
+
+int iaa_aecs_init_canned(void)
+{
+	u16 gen_decomp_table_flags;
+	unsigned int slen;
+	int ret;
+
+	slen = CEIL(HEADER_SIZE_IN_BITS, 8);
+
+	gen_decomp_table_flags = 0x1;
+	gen_decomp_table_flags |= 1 << 9; // suppress output
+	gen_decomp_table_flags |= (((slen * 8) - HEADER_SIZE_IN_BITS) << 6);
+
+	ret = add_iaa_compression_mode("canned",
+				       canned_ll_iaa,
+				       sizeof(canned_ll_iaa),
+				       canned_d_iaa,
+				       sizeof(canned_d_iaa),
+				       canned_header,
+				       sizeof(canned_header),
+				       gen_decomp_table_flags,
+				       NULL, NULL);
+
+	if (!ret)
+		pr_debug("IAA canned compression mode initialized\n");
+
+	return ret;
+}
+
+void iaa_aecs_cleanup_canned(void)
+{
+	remove_iaa_compression_mode("canned");
+}
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 6562cb7c59fd..60ba967e1158 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1079,6 +1079,7 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	enum idxd_op_type optype;
 	struct iaa_wq *iaa_wq;
 	struct pci_dev *pdev;
+	dma_addr_t src2_addr;
 	struct device *dev;
 	int ret = 0;
 
@@ -1114,6 +1115,13 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->max_dst_size = slen;
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (ctx->mode == IAA_MODE_CANNED) {
+		src2_addr = active_compression_mode->aecs_decomp_table_dma_addr;
+		desc->src2_addr = (u64)src2_addr;
+		desc->src2_size = 1088;
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+	}
+
 	dev_dbg(dev, "(verify) compression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1169,6 +1177,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	enum idxd_op_type optype;
 	struct iaa_wq *iaa_wq;
 	struct pci_dev *pdev;
+	dma_addr_t src2_addr;
 	struct device *dev;
 	int ret = 0;
 
@@ -1203,6 +1212,13 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->src1_size = slen;
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (ctx->mode == IAA_MODE_CANNED) {
+		src2_addr = active_compression_mode->aecs_decomp_table_dma_addr;
+		desc->src2_addr = (u64)src2_addr;
+		desc->src2_size = 1088;
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+	}
+
 	dev_dbg(dev, "%s: decompression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1536,6 +1552,31 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	}
 };
 
+static int iaa_comp_init_canned(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	compression_ctx_init(ctx);
+
+	ctx->mode = IAA_MODE_CANNED;
+
+	return 0;
+}
+
+static struct acomp_alg iaa_acomp_canned_deflate = {
+	.init			= iaa_comp_init_canned,
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.dst_free		= sgl_free,
+	.base			= {
+		.cra_name		= "deflate-iaa-canned",
+		.cra_driver_name	= "deflate_iaa_canned",
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_module		= THIS_MODULE,
+	}
+};
+
 static int iaa_register_compression_device(void)
 {
 	int ret;
@@ -1546,15 +1587,27 @@ static int iaa_register_compression_device(void)
 		goto out;
 	}
 
+	ret = crypto_register_acomp(&iaa_acomp_canned_deflate);
+	if (ret) {
+		pr_err("deflate algorithm acomp canned registration failed (%d)\n", ret);
+		goto err_canned;
+	}
+
 	iaa_crypto_registered = true;
 out:
 	return ret;
+err_canned:
+	crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+
+	goto out;
 }
 
 static int iaa_unregister_compression_device(void)
 {
-	if (iaa_crypto_registered)
+	if (iaa_crypto_registered) {
 		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+		crypto_unregister_acomp(&iaa_acomp_canned_deflate);
+	}
 
 	return 0;
 }
@@ -1723,6 +1776,12 @@ static int __init iaa_crypto_init_module(void)
 		goto out;
 	}
 
+	ret = iaa_aecs_init_canned();
+	if (ret < 0) {
+		pr_debug("IAA canned compression mode init failed\n");
+		goto err_canned;
+	}
+
 	ret = idxd_driver_register(&iaa_crypto_driver);
 	if (ret) {
 		pr_debug("IAA wq sub-driver registration failed\n");
@@ -1743,6 +1802,8 @@ static int __init iaa_crypto_init_module(void)
 err_verify_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
+	iaa_aecs_cleanup_canned();
+err_canned:
 	iaa_aecs_cleanup_fixed();
 
 	goto out;
@@ -1756,6 +1817,7 @@ static void __exit iaa_crypto_cleanup_module(void)
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	iaa_aecs_cleanup_canned();
 	iaa_aecs_cleanup_fixed();
 
 	pr_debug("cleaned up\n");
-- 
2.34.1

