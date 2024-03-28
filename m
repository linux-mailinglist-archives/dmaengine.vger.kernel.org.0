Return-Path: <dmaengine+bounces-1627-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3DA890760
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9B71F25E5E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955912F360;
	Thu, 28 Mar 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwbyfY7u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC43BBDC;
	Thu, 28 Mar 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647910; cv=none; b=rc/CPwb6S+WpDLeDcIjin8kvFY+tih6NA6ZOvHnB1lWh3+WJEx2msLcdh70ObAGRWKaSUPCdrELYar4cp2EGHNI06ZYgnnF+aZ4jFbbfngm5csT6EgY6bseGforsanfITkApsCiyNlREOGMfA/v9s1mraEfWKZSZs/x30diNCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647910; c=relaxed/simple;
	bh=qUxcy08WSCXTRqv6KjjM/Da3kQd1/M5/JyKNmDp5AQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsRtv1wtxVpkpjA+LMJvw0jZGgQj1/yKS8j9kFiPkLWSascM7IYRCWct5E4ZdqrkpVglLNYvY+zSwRtxxdSznkrPd5TEVEDTxFC6FXuoGI7koyGz7ck3anUsRlli43tqJ+ymWPgvKR139uJhtI6DnK2KGdDnW5R4HrN5tJJqUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwbyfY7u; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711647908; x=1743183908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUxcy08WSCXTRqv6KjjM/Da3kQd1/M5/JyKNmDp5AQU=;
  b=jwbyfY7uAnak1JJWtqwaRz89vkYBq5Zw8aFrH/DZBY4mc+6xm2tLzJOv
   zu8eDp2VmuJWUinKiqmX5odND/3I7+T75cExyGD0fKL+OM7tZNLi//tvk
   K5hXj0k2Gwxb6Qk7NlvqwM+6W9Rftu6uVl3BaiInUsomCB/QZLCxL/SFY
   kAfD4nNy499v9U1xoaWI/DJNWtMJcvAnue0iBpQATs9YknCCnGs2y/mSM
   FLJ96n56C7BwT/S8Ug9NrU01GP7gPLTsYfwrdPNhVhM6NEJI1wnFmM5o9
   gD5cObniF0lmsWj7R6o/UQZCIZm/16mESKpQnxyUTZikP04F0r3NSjVvz
   g==;
X-CSE-ConnectionGUID: 7pIVIbaaSQKQu2CQCHT38A==
X-CSE-MsgGUID: x68Ch6Y8Sn+4+wZwvQH41w==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10631347"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10631347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16675583"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:58 -0700
From: Andre Glover <andre.glover@linux.intel.com>
To: tom.zanussi@linux.intel.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	vinodh.gopal@intel.com,
	tony.luck@intel.com,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	andre.glover@linux.intel.com
Subject: [PATCH 1/4] crypto: Add 'canned' compression mode for zlib
Date: Thu, 28 Mar 2024 10:44:42 -0700
Message-Id: <da61521930e080d940f724b67dcaaeecd512e723.1710969449.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710969449.git.andre.glover@linux.intel.com>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'canned' compression mode implements a compression scheme that uses
statically defined Huffman tables. Since the Deflate block header is a
constant, it is not stored with the compressed data. The Huffman tables
used were generated from statistics derived from swapped 4KB pages of
SPEC CPU17 workloads. We believe that these tables should be generally
applicable to page compression.

Canned mode provides lower compression and decompression latencies than
dynamic compression with slightly lower compression ratio.

Below is a table showing the latency improvements of zlib, between dynamic
and canned modes, and the compression ratio for each mode while using a
set of 4300 4KB pages sampled from SPEC CPU17 workloads:

_________________________________________________________
| Zlib Level |  Canned Latency Gain  |    Comp Ratio    |
|------------|-----------------------|------------------|
|            | compress | decompress | dynamic | canned |
|____________|__________|____________|_________|________|
|     1      |    49%   |    29%     |  3.16   |  2.92  |
|------------|----------|------------|---------|--------|
|     6	     |    27%   |    28%     |  3.35   |  3.09  |
|------------|----------|------------|---------|--------|
|     9      |    12%   |    29%     |  3.36   |  3.11  |
|____________|__________|____________|_________|________|

Canned mode is exposed by the 'deflate-canned' crypto algorithm in the
zlib crypto driver. The set of static canned-mode deflate and inflate
tables were generated and are used in the same manner as the pre-existing
zlib fixed tables. We have insured that the 'canned' mode additions do not
impact existing zlib performance or functionality.

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 crypto/deflate.c             |  72 +++++++++++--
 crypto/testmgr.c             |  10 ++
 crypto/testmgr.h             |  74 ++++++++++++++
 include/linux/zlib.h         |  10 ++
 lib/Kconfig                  |   9 ++
 lib/zlib_deflate/defcanned.h | 118 ++++++++++++++++++++++
 lib/zlib_deflate/deflate.c   |   8 +-
 lib/zlib_deflate/deftree.c   |  15 ++-
 lib/zlib_inflate/infcanned.h | 191 +++++++++++++++++++++++++++++++++++
 lib/zlib_inflate/inflate.c   |  15 ++-
 lib/zlib_inflate/inflate.h   |   5 +-
 lib/zlib_inflate/infutil.h   |  16 +++
 12 files changed, 529 insertions(+), 14 deletions(-)
 create mode 100644 lib/zlib_deflate/defcanned.h
 create mode 100644 lib/zlib_inflate/infcanned.h

diff --git a/crypto/deflate.c b/crypto/deflate.c
index 6e31e0db0e86..cda9dc5cab36 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -37,6 +37,7 @@
 struct deflate_ctx {
 	struct z_stream_s comp_stream;
 	struct z_stream_s decomp_stream;
+	bool canned;
 };
 
 static int deflate_comp_init(struct deflate_ctx *ctx)
@@ -50,9 +51,16 @@ static int deflate_comp_init(struct deflate_ctx *ctx)
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
-				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
-				Z_DEFAULT_STRATEGY);
+
+	if (IS_ENABLED(CONFIG_ZLIB_CANNED) && ctx->canned)
+		ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
+					DEFLATE_DEF_CANNED_WINBITS,
+					DEFLATE_DEF_MEMLEVEL,
+					Z_CANNED);
+	else
+		ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
+					-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
+					Z_DEFAULT_STRATEGY);
 	if (ret != Z_OK) {
 		ret = -EINVAL;
 		goto out_free;
@@ -74,7 +82,16 @@ static int deflate_decomp_init(struct deflate_ctx *ctx)
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
+
+	/*
+	 * The wrap is embedded in bits 31:4 of the windowBits argument and is incremented
+	 * by 1 during extraction.
+	 */
+	if (IS_ENABLED(CONFIG_ZLIB_CANNED) && ctx->canned)
+		ret = zlib_inflateInit2(stream, (((ZLIB_CANNED_WRAP - 1) << 4) |
+						  (DEFLATE_DEF_CANNED_WINBITS)));
+	else
+		ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
 	if (ret != Z_OK) {
 		ret = -EINVAL;
 		goto out_free;
@@ -130,6 +147,25 @@ static void *deflate_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
+static __maybe_unused void *deflate_canned_alloc_ctx(struct crypto_scomp *tfm)
+{
+	struct deflate_ctx *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->canned = true;
+	ret = __deflate_init(ctx);
+	if (ret) {
+		kfree(ctx);
+		return ERR_PTR(ret);
+	}
+
+	return ctx;
+}
+
 static int deflate_init(struct crypto_tfm *tfm)
 {
 	struct deflate_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -219,6 +255,11 @@ static int __deflate_decompress(const u8 *src, unsigned int slen,
 	stream->next_out = (u8 *)dst;
 	stream->avail_out = *dlen;
 
+	if (IS_ENABLED(CONFIG_ZLIB_CANNED) && dctx->canned) {
+		ret = zlib_inflate(stream, Z_FINISH);
+		goto inflate_done;
+	}
+
 	ret = zlib_inflate(stream, Z_SYNC_FLUSH);
 	/*
 	 * Work around a bug in zlib, which sometimes wants to taste an extra
@@ -231,6 +272,8 @@ static int __deflate_decompress(const u8 *src, unsigned int slen,
 		stream->avail_in = 1;
 		ret = zlib_inflate(stream, Z_FINISH);
 	}
+
+inflate_done:
 	if (ret != Z_STREAM_END) {
 		ret = -EINVAL;
 		goto out;
@@ -269,7 +312,8 @@ static struct crypto_alg alg = {
 	.coa_decompress  	= deflate_decompress } }
 };
 
-static struct scomp_alg scomp = {
+static struct scomp_alg scomp[] = {
+{
 	.alloc_ctx		= deflate_alloc_ctx,
 	.free_ctx		= deflate_free_ctx,
 	.compress		= deflate_scompress,
@@ -279,7 +323,19 @@ static struct scomp_alg scomp = {
 		.cra_driver_name = "deflate-scomp",
 		.cra_module	 = THIS_MODULE,
 	}
-};
+#ifdef CONFIG_ZLIB_CANNED
+}, {
+	.alloc_ctx		= deflate_canned_alloc_ctx,
+	.free_ctx		= deflate_free_ctx,
+	.compress		= deflate_scompress,
+	.decompress		= deflate_sdecompress,
+	.base			= {
+		.cra_name	= "deflate-canned",
+		.cra_driver_name = "deflate-scomp-canned",
+		.cra_module	 = THIS_MODULE,
+	}
+#endif
+} };
 
 static int __init deflate_mod_init(void)
 {
@@ -289,7 +345,7 @@ static int __init deflate_mod_init(void)
 	if (ret)
 		return ret;
 
-	ret = crypto_register_scomp(&scomp);
+	ret = crypto_register_scomps(scomp, ARRAY_SIZE(scomp));
 	if (ret) {
 		crypto_unregister_alg(&alg);
 		return ret;
@@ -301,7 +357,7 @@ static int __init deflate_mod_init(void)
 static void __exit deflate_mod_fini(void)
 {
 	crypto_unregister_alg(&alg);
-	crypto_unregister_scomp(&scomp);
+	crypto_unregister_scomps(scomp, ARRAY_SIZE(scomp));
 }
 
 subsys_initcall(deflate_mod_init);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 3dddd288ca02..94fd9ceef207 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4806,6 +4806,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(deflate_decomp_tv_template)
 			}
 		}
+	}, {
+		.alg = "deflate-scomp-canned",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(deflate_scomp_canned_comp_tv_template),
+				.decomp = __VECS(deflate_scomp_canned_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 986f331a5fc2..38c4c96e11e2 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34526,6 +34526,80 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
 	},
 };
 
+static const struct comp_testvec deflate_scomp_canned_comp_tv_template[] = {
+	{
+		.inlen	= 70,
+		.outlen	= 36,
+		.input	= "Join us now and share the software "
+			"Join us now and share the software ",
+		.output	= "\x6d\x23\x43\x23\xa4\x71\x31\xd2"
+			  "\x88\xc8\x61\x52\x75\x84\x56\x1a"
+			  "\x13\xa2\x8e\xd6\x49\x63\x43\x74"
+			  "\xd2\x98\xc8\xe0\xd8\x61\x58\x69"
+			  "\xcb\x77\xf9\x0f",
+	}, {
+		.inlen	= 191,
+		.outlen	= 129,
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
+			  "\x7b\xa9\xb4\x9b\x28\x70\x70\x68"
+			  "\x04\x84\xc5\x1d\xd5\x51\x51\x61"
+			  "\xa1\x1a\x75\x2c\xee\x11\x19\xac"
+			  "\x1f\x2b\x3f\x80\x34\x36\x52\x68"
+			  "\x68\xe3\x2f\xf5\x57\x0f\x0f\x8b"
+			  "\x54\x6b\xa5\x2d\xf5\x06\xf2\x8f"
+			  "\x8e\x8c\x8d\xd4\x44\x86\xd9\xff"
+			  "\x07",
+	},
+};
+
+static const struct comp_testvec deflate_scomp_canned_decomp_tv_template[] = {
+	{
+		.inlen	= 129,
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
+			  "\x7b\xa9\xb4\x9b\x28\x70\x70\x68"
+			  "\x04\x84\xc5\x1d\xd5\x51\x51\x61"
+			  "\xa1\x1a\x75\x2c\xee\x11\x19\xac"
+			  "\x1f\x2b\x3f\x80\x34\x36\x52\x68"
+			  "\x68\xe3\x2f\xf5\x57\x0f\x0f\x8b"
+			  "\x54\x6b\xa5\x2d\xf5\x06\xf2\x8f"
+			  "\x8e\x8c\x8d\xd4\x44\x86\xd9\xff"
+			  "\x07",
+		.output	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+	}, {
+		.inlen	= 36,
+		.outlen	= 70,
+		.input	= "\x6d\x23\x43\x23\xa4\x71\x31\xd2"
+			  "\x88\xc8\x61\x52\x75\x84\x56\x1a"
+			  "\x13\xa2\x8e\xd6\x49\x63\x43\x74"
+			  "\xd2\x98\xc8\xe0\xd8\x61\x58\x69"
+			  "\xcb\x77\xf9\x0f",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 /*
  * LZO test vectors (null-terminated strings).
  */
diff --git a/include/linux/zlib.h b/include/linux/zlib.h
index 78ede944c082..05290b3c273f 100644
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -166,7 +166,14 @@ typedef z_stream *z_streamp;
 
 #define Z_FILTERED            1
 #define Z_HUFFMAN_ONLY        2
+#define Z_CANNED              3
 #define Z_DEFAULT_STRATEGY    0
+
+#ifdef CONFIG_ZLIB_CANNED
+#define Z_STRATEGY_MAX Z_CANNED
+#else
+#define Z_STRATEGY_MAX Z_HUFFMAN_ONLY
+#endif
 /* compression strategy; see deflateInit2() below for details */
 
 #define Z_BINARY   0
@@ -177,6 +184,9 @@ typedef z_stream *z_streamp;
 #define Z_DEFLATED   8
 /* The deflate compression method (the only one supported in this version) */
 
+#define DEFLATE_DEF_CANNED_WINBITS	12
+#define ZLIB_CANNED_WRAP   4
+
                         /* basic functions */
 
 extern int zlib_deflate_workspacesize (int windowBits, int memLevel);
diff --git a/lib/Kconfig b/lib/Kconfig
index 5ddda7c2ed9b..2cf46e863c30 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -320,6 +320,15 @@ config ZLIB_DEFLATE
 	tristate
 	select BITREVERSE
 
+config ZLIB_CANNED
+	bool
+	depends on ZLIB_INFLATE && ZLIB_DEFLATE
+	prompt "Enable canned compression mode support for kernel zlib"
+	help
+	 Enable canned compression mode support for zlib in the kernel.
+	 The 'canned' compression mode implements a compression scheme that
+	 uses statically defined Huffman tables.
+
 config ZLIB_DFLTCC
 	def_bool y
 	depends on S390
diff --git a/lib/zlib_deflate/defcanned.h b/lib/zlib_deflate/defcanned.h
new file mode 100644
index 000000000000..5db1fc749d74
--- /dev/null
+++ b/lib/zlib_deflate/defcanned.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * These tables were generated from statistics derived from a wide
+ * variety of SPEC17 workloads and implement a good general-purpose
+ * compression scheme called simply 'canned'.
+ */
+
+static ct_data canned_ltree[286] = {
+	{.Len = 0x5, .Code = 0x8}, {.Len = 0x7, .Code = 0x12}, {.Len = 0x8, .Code = 0x66},
+	{.Len = 0x8, .Code = 0xe6}, {.Len = 0x8, .Code = 0x16}, {.Len = 0x9, .Code = 0x45},
+	{.Len = 0x8, .Code = 0x96}, {.Len = 0x9, .Code = 0x145}, {.Len = 0x8, .Code = 0x56},
+	{.Len = 0x9, .Code = 0xc5}, {.Len = 0x8, .Code = 0xd6}, {.Len = 0x9, .Code = 0x1c5},
+	{.Len = 0x9, .Code = 0x25}, {.Len = 0x9, .Code = 0x125}, {.Len = 0x9, .Code = 0xa5},
+	{.Len = 0x9, .Code = 0x1a5}, {.Len = 0x8, .Code = 0x36}, {.Len = 0x9, .Code = 0x65},
+	{.Len = 0x9, .Code = 0x165}, {.Len = 0x9, .Code = 0xe5}, {.Len = 0x9, .Code = 0x1e5},
+	{.Len = 0x9, .Code = 0x15}, {.Len = 0x9, .Code = 0x115}, {.Len = 0x9, .Code = 0x95},
+	{.Len = 0x8, .Code = 0xb6}, {.Len = 0x9, .Code = 0x195}, {.Len = 0x9, .Code = 0x55},
+	{.Len = 0x9, .Code = 0x155}, {.Len = 0x9, .Code = 0xd5}, {.Len = 0x9, .Code = 0x1d5},
+	{.Len = 0x9, .Code = 0x35}, {.Len = 0x9, .Code = 0x135}, {.Len = 0x7, .Code = 0x52},
+	{.Len = 0x9, .Code = 0xb5}, {.Len = 0x9, .Code = 0x1b5}, {.Len = 0x9, .Code = 0x75},
+	{.Len = 0x9, .Code = 0x175}, {.Len = 0x9, .Code = 0xf5}, {.Len = 0x9, .Code = 0x1f5},
+	{.Len = 0x9, .Code = 0xd}, {.Len = 0x8, .Code = 0x76}, {.Len = 0x9, .Code = 0x10d},
+	{.Len = 0x9, .Code = 0x8d}, {.Len = 0x9, .Code = 0x18d}, {.Len = 0x9, .Code = 0x4d},
+	{.Len = 0x9, .Code = 0x14d}, {.Len = 0x8, .Code = 0xf6}, {.Len = 0x9, .Code = 0xcd},
+	{.Len = 0x7, .Code = 0x32}, {.Len = 0x7, .Code = 0x72}, {.Len = 0x8, .Code = 0xe},
+	{.Len = 0x8, .Code = 0x8e}, {.Len = 0x8, .Code = 0x4e}, {.Len = 0x8, .Code = 0xce},
+	{.Len = 0x8, .Code = 0x2e}, {.Len = 0x8, .Code = 0xae}, {.Len = 0x7, .Code = 0xa},
+	{.Len = 0x8, .Code = 0x6e}, {.Len = 0x8, .Code = 0xee}, {.Len = 0x9, .Code = 0x1cd},
+	{.Len = 0x8, .Code = 0x1e}, {.Len = 0x8, .Code = 0x9e}, {.Len = 0x8, .Code = 0x5e},
+	{.Len = 0x7, .Code = 0x4a}, {.Len = 0x7, .Code = 0x2a}, {.Len = 0x8, .Code = 0xde},
+	{.Len = 0x9, .Code = 0x2d}, {.Len = 0x9, .Code = 0x12d}, {.Len = 0x8, .Code = 0x3e},
+	{.Len = 0x9, .Code = 0xad}, {.Len = 0x8, .Code = 0xbe}, {.Len = 0x9, .Code = 0x1ad},
+	{.Len = 0x8, .Code = 0x7e}, {.Len = 0x9, .Code = 0x6d}, {.Len = 0x9, .Code = 0x16d},
+	{.Len = 0x9, .Code = 0xed}, {.Len = 0x9, .Code = 0x1ed}, {.Len = 0x9, .Code = 0x1d},
+	{.Len = 0x9, .Code = 0x11d}, {.Len = 0x9, .Code = 0x9d}, {.Len = 0x8, .Code = 0xfe},
+	{.Len = 0x9, .Code = 0x19d}, {.Len = 0x9, .Code = 0x5d}, {.Len = 0x9, .Code = 0x15d},
+	{.Len = 0x9, .Code = 0xdd}, {.Len = 0x9, .Code = 0x1dd}, {.Len = 0x9, .Code = 0x3d},
+	{.Len = 0x9, .Code = 0x13d}, {.Len = 0x8, .Code = 0x1}, {.Len = 0x9, .Code = 0xbd},
+	{.Len = 0x9, .Code = 0x1bd}, {.Len = 0x9, .Code = 0x7d}, {.Len = 0x9, .Code = 0x17d},
+	{.Len = 0x9, .Code = 0xfd}, {.Len = 0x9, .Code = 0x1fd}, {.Len = 0x9, .Code = 0x3},
+	{.Len = 0x8, .Code = 0x81}, {.Len = 0x7, .Code = 0x6a}, {.Len = 0x8, .Code = 0x41},
+	{.Len = 0x7, .Code = 0x1a}, {.Len = 0x7, .Code = 0x5a}, {.Len = 0x7, .Code = 0x3a},
+	{.Len = 0x8, .Code = 0xc1}, {.Len = 0x9, .Code = 0x103}, {.Len = 0x8, .Code = 0x21},
+	{.Len = 0x8, .Code = 0xa1}, {.Len = 0x9, .Code = 0x83}, {.Len = 0x9, .Code = 0x183},
+	{.Len = 0x8, .Code = 0x61}, {.Len = 0x8, .Code = 0xe1}, {.Len = 0x8, .Code = 0x11},
+	{.Len = 0x8, .Code = 0x91}, {.Len = 0x8, .Code = 0x51}, {.Len = 0x9, .Code = 0x43},
+	{.Len = 0x8, .Code = 0xd1}, {.Len = 0x8, .Code = 0x31}, {.Len = 0x8, .Code = 0xb1},
+	{.Len = 0x8, .Code = 0x71}, {.Len = 0x9, .Code = 0x143}, {.Len = 0x9, .Code = 0xc3},
+	{.Len = 0x8, .Code = 0xf1}, {.Len = 0x9, .Code = 0x1c3}, {.Len = 0x9, .Code = 0x23},
+	{.Len = 0x9, .Code = 0x123}, {.Len = 0x9, .Code = 0xa3}, {.Len = 0x9, .Code = 0x1a3},
+	{.Len = 0x9, .Code = 0x63}, {.Len = 0x9, .Code = 0x163}, {.Len = 0x8, .Code = 0x9},
+	{.Len = 0x9, .Code = 0xe3}, {.Len = 0x9, .Code = 0x1e3}, {.Len = 0x9, .Code = 0x13},
+	{.Len = 0x9, .Code = 0x113}, {.Len = 0x9, .Code = 0x93}, {.Len = 0x9, .Code = 0x193},
+	{.Len = 0x9, .Code = 0x53}, {.Len = 0x8, .Code = 0x89}, {.Len = 0x9, .Code = 0x153},
+	{.Len = 0x9, .Code = 0xd3}, {.Len = 0x9, .Code = 0x1d3}, {.Len = 0x9, .Code = 0x33},
+	{.Len = 0x9, .Code = 0x133}, {.Len = 0x9, .Code = 0xb3}, {.Len = 0x9, .Code = 0x1b3},
+	{.Len = 0x8, .Code = 0x49}, {.Len = 0x9, .Code = 0x73}, {.Len = 0x9, .Code = 0x173},
+	{.Len = 0x9, .Code = 0xf3}, {.Len = 0x9, .Code = 0x1f3}, {.Len = 0x9, .Code = 0xb},
+	{.Len = 0x9, .Code = 0x10b}, {.Len = 0x9, .Code = 0x8b}, {.Len = 0x8, .Code = 0xc9},
+	{.Len = 0x9, .Code = 0x18b}, {.Len = 0x9, .Code = 0x4b}, {.Len = 0x9, .Code = 0x14b},
+	{.Len = 0x9, .Code = 0xcb}, {.Len = 0x9, .Code = 0x1cb}, {.Len = 0x9, .Code = 0x2b},
+	{.Len = 0x9, .Code = 0x12b}, {.Len = 0x8, .Code = 0x29}, {.Len = 0x9, .Code = 0xab},
+	{.Len = 0x9, .Code = 0x1ab}, {.Len = 0x9, .Code = 0x6b}, {.Len = 0x9, .Code = 0x16b},
+	{.Len = 0x9, .Code = 0xeb}, {.Len = 0x9, .Code = 0x1eb}, {.Len = 0x9, .Code = 0x1b},
+	{.Len = 0x9, .Code = 0x11b}, {.Len = 0x9, .Code = 0x9b}, {.Len = 0x9, .Code = 0x19b},
+	{.Len = 0x9, .Code = 0x5b}, {.Len = 0x9, .Code = 0x15b}, {.Len = 0x9, .Code = 0xdb},
+	{.Len = 0x9, .Code = 0x1db}, {.Len = 0x9, .Code = 0x3b}, {.Len = 0x8, .Code = 0xa9},
+	{.Len = 0x9, .Code = 0x13b}, {.Len = 0x9, .Code = 0xbb}, {.Len = 0x9, .Code = 0x1bb},
+	{.Len = 0x9, .Code = 0x7b}, {.Len = 0x9, .Code = 0x17b}, {.Len = 0x9, .Code = 0xfb},
+	{.Len = 0x9, .Code = 0x1fb}, {.Len = 0x8, .Code = 0x69}, {.Len = 0x9, .Code = 0x7},
+	{.Len = 0x9, .Code = 0x107}, {.Len = 0x9, .Code = 0x87}, {.Len = 0x9, .Code = 0x187},
+	{.Len = 0x9, .Code = 0x47}, {.Len = 0x9, .Code = 0x147}, {.Len = 0x8, .Code = 0xe9},
+	{.Len = 0x8, .Code = 0x19}, {.Len = 0x9, .Code = 0xc7}, {.Len = 0x9, .Code = 0x1c7},
+	{.Len = 0x9, .Code = 0x27}, {.Len = 0x9, .Code = 0x127}, {.Len = 0x9, .Code = 0xa7},
+	{.Len = 0x9, .Code = 0x1a7}, {.Len = 0x9, .Code = 0x67}, {.Len = 0x8, .Code = 0x99},
+	{.Len = 0x9, .Code = 0x167}, {.Len = 0x9, .Code = 0xe7}, {.Len = 0x9, .Code = 0x1e7},
+	{.Len = 0x9, .Code = 0x17}, {.Len = 0x9, .Code = 0x117}, {.Len = 0x9, .Code = 0x97},
+	{.Len = 0x9, .Code = 0x197}, {.Len = 0x8, .Code = 0x59}, {.Len = 0x9, .Code = 0x57},
+	{.Len = 0x9, .Code = 0x157}, {.Len = 0x9, .Code = 0xd7}, {.Len = 0x9, .Code = 0x1d7},
+	{.Len = 0x9, .Code = 0x37}, {.Len = 0x9, .Code = 0x137}, {.Len = 0x9, .Code = 0xb7},
+	{.Len = 0x9, .Code = 0x1b7}, {.Len = 0x9, .Code = 0x77}, {.Len = 0x9, .Code = 0x177},
+	{.Len = 0x9, .Code = 0xf7}, {.Len = 0x9, .Code = 0x1f7}, {.Len = 0x9, .Code = 0xf},
+	{.Len = 0x9, .Code = 0x10f}, {.Len = 0x9, .Code = 0x8f}, {.Len = 0x8, .Code = 0xd9},
+	{.Len = 0x9, .Code = 0x18f}, {.Len = 0x9, .Code = 0x4f}, {.Len = 0x9, .Code = 0x14f},
+	{.Len = 0x9, .Code = 0xcf}, {.Len = 0x9, .Code = 0x1cf}, {.Len = 0x9, .Code = 0x2f},
+	{.Len = 0x9, .Code = 0x12f}, {.Len = 0x9, .Code = 0xaf}, {.Len = 0x9, .Code = 0x1af},
+	{.Len = 0x9, .Code = 0x6f}, {.Len = 0x9, .Code = 0x16f}, {.Len = 0x9, .Code = 0xef},
+	{.Len = 0x9, .Code = 0x1ef}, {.Len = 0x9, .Code = 0x1f}, {.Len = 0x9, .Code = 0x11f},
+	{.Len = 0x8, .Code = 0x39}, {.Len = 0x9, .Code = 0x9f}, {.Len = 0x9, .Code = 0x19f},
+	{.Len = 0x9, .Code = 0x5f}, {.Len = 0x9, .Code = 0x15f}, {.Len = 0x9, .Code = 0xdf},
+	{.Len = 0x9, .Code = 0x1df}, {.Len = 0x9, .Code = 0x3f}, {.Len = 0x9, .Code = 0x13f},
+	{.Len = 0x9, .Code = 0xbf}, {.Len = 0x9, .Code = 0x1bf}, {.Len = 0xb, .Code = 0x3ff},
+	{.Len = 0x9, .Code = 0x7f}, {.Len = 0x9, .Code = 0x17f}, {.Len = 0x9, .Code = 0xff},
+	{.Len = 0x8, .Code = 0xb9}, {.Len = 0xa, .Code = 0x1ff}, {.Len = 0x4, .Code = 0x0},
+	{.Len = 0x5, .Code = 0x18}, {.Len = 0x6, .Code = 0x2}, {.Len = 0x5, .Code = 0x4},
+	{.Len = 0x5, .Code = 0x14}, {.Len = 0x5, .Code = 0xc}, {.Len = 0x8, .Code = 0x79},
+	{.Len = 0x8, .Code = 0xf9}, {.Len = 0x7, .Code = 0x7a}, {.Len = 0x7, .Code = 0x6},
+	{.Len = 0x6, .Code = 0x22}, {.Len = 0x8, .Code = 0x5}, {.Len = 0x7, .Code = 0x46},
+	{.Len = 0x7, .Code = 0x26}, {.Len = 0x8, .Code = 0x85}, {.Len = 0x5, .Code = 0x1c},
+	{.Len = 0xe, .Code = 0x7ff}, {.Len = 0xe, .Code = 0x27ff}, {.Len = 0xf, .Code = 0x37ff},
+	{.Len = 0xf, .Code = 0x77ff}, {.Len = 0xf, .Code = 0xfff}, {.Len = 0xf, .Code = 0x4fff},
+	{.Len = 0xf, .Code = 0x2fff}, {.Len = 0xf, .Code = 0x6fff}, {.Len = 0xf, .Code = 0x1fff},
+	{.Len = 0xf, .Code = 0x5fff}, {.Len = 0xf, .Code = 0x3fff}, {.Len = 0xf, .Code = 0x7fff},
+	{.Len = 0xe, .Code = 0x17ff},
+};
+
+static ct_data canned_dtree[30] = {
+	{.Len = 0x7, .Code = 0x3f}, {.Len = 0x4, .Code = 0x2}, {.Len = 0x9, .Code = 0xff},
+	{.Len = 0x3, .Code = 0x0}, {.Len = 0x8, .Code = 0x7f}, {.Len = 0x3, .Code = 0x4},
+	{.Len = 0x6, .Code = 0xf}, {.Len = 0x4, .Code = 0xa}, {.Len = 0x4, .Code = 0x6},
+	{.Len = 0x5, .Code = 0xd}, {.Len = 0x4, .Code = 0xe}, {.Len = 0x5, .Code = 0x1d},
+	{.Len = 0x4, .Code = 0x1}, {.Len = 0x5, .Code = 0x3}, {.Len = 0x5, .Code = 0x13},
+	{.Len = 0x4, .Code = 0x9}, {.Len = 0x4, .Code = 0x5}, {.Len = 0x5, .Code = 0xb},
+	{.Len = 0x5, .Code = 0x1b}, {.Len = 0x5, .Code = 0x7}, {.Len = 0x5, .Code = 0x17},
+	{.Len = 0x6, .Code = 0x2f}, {.Len = 0x6, .Code = 0x1f}, {.Len = 0x9, .Code = 0x1ff},
+	{.Len = 0x0, .Code = 0x0}, {.Len = 0x0, .Code = 0x0}, {.Len = 0x0, .Code = 0x0},
+	{.Len = 0x0, .Code = 0x0}, {.Len = 0x0, .Code = 0x0}, {.Len = 0x0, .Code = 0x0},
+};
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 3a1d8d34182e..5debefd8c799 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -218,10 +218,16 @@ int zlib_deflateInit2(
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
         windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
-	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
+	strategy < 0 || strategy > Z_STRATEGY_MAX) {
         return Z_STREAM_ERROR;
     }
 
+    if (IS_ENABLED(CONFIG_ZLIB_CANNED) && strategy == Z_CANNED) {
+        if (windowBits > DEFLATE_DEF_CANNED_WINBITS)
+            return Z_STREAM_ERROR;
+        noheader = 1; /* suppress zlib header for canned compression */
+    }
+
     /*
      * Direct the workspace's pointers to the chunks that were allocated
      * along with the deflate_workspace struct.
diff --git a/lib/zlib_deflate/deftree.c b/lib/zlib_deflate/deftree.c
index a4a34da512fe..919a14a593e5 100644
--- a/lib/zlib_deflate/deftree.c
+++ b/lib/zlib_deflate/deftree.c
@@ -124,6 +124,13 @@ static static_tree_desc  static_d_desc =
 static static_tree_desc  static_bl_desc =
 {(const ct_data *)0, extra_blbits, 0,   BL_CODES, MAX_BL_BITS};
 
+#ifdef CONFIG_ZLIB_CANNED
+#include "defcanned.h"
+#else
+#define canned_ltree NULL
+#define canned_dtree NULL
+#endif
+
 /* ===========================================================================
  * Local (static) routines in this file.
  */
@@ -810,7 +817,7 @@ ulg zlib_tr_flush_block(
     int max_blindex = 0;  /* index of last bit length code of non zero freq */
 
     /* Build the Huffman trees unless a stored block is forced */
-    if (s->level > 0) {
+    if (s->level > 0 && !(IS_ENABLED(CONFIG_ZLIB_CANNED) && s->strategy == Z_CANNED)) {
 
 	 /* Check if the file is ascii or binary */
 	if (s->data_type == Z_UNKNOWN) set_data_type(s);
@@ -866,10 +873,12 @@ ulg zlib_tr_flush_block(
     } else
 #endif /* STORED_FILE_OK */
 
+    if (IS_ENABLED(CONFIG_ZLIB_CANNED) && s->strategy == Z_CANNED) {
+        compress_block(s, (ct_data *)canned_ltree, (ct_data *)canned_dtree);
 #ifdef FORCE_STORED
-    if (buf != (char*)0) { /* force stored block */
+    } else if (buf != (char *)0) { /* force stored block */
 #else
-    if (stored_len+4 <= opt_lenb && buf != (char*)0) {
+    } else if (stored_len + 4 <= opt_lenb && buf != (char *)0) {
                        /* 4: two words for the lengths */
 #endif
         /* The test buf != NULL is only necessary if LIT_BUFSIZE > WSIZE.
diff --git a/lib/zlib_inflate/infcanned.h b/lib/zlib_inflate/infcanned.h
new file mode 100644
index 000000000000..86ca4aedba51
--- /dev/null
+++ b/lib/zlib_inflate/infcanned.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* infcanned.h -- table for decoding canned codes
+ * Generated automatically by makecanned().
+ */
+
+/* WARNING: this file should *not* be used by applications.
+ * It is part of the implementation of this library and is
+ * subject to change. Applications should only use zlib.h.
+ */
+
+/*
+ * These tables were generated from statistics derived from a wide
+ * variety of SPEC17 workloads and implement a good general-purpose
+ * compression scheme called simply 'canned'.
+ */
+
+static const code lencan[576] = {
+	{16, 4, 3}, {0, 8, 88}, {16, 6, 5}, {0, 9, 95}, {16, 5, 6}, {17, 8, 17}, {17, 7, 13},
+	{0, 9, 185}, {0, 5, 0}, {0, 8, 128}, {0, 7, 56}, {0, 9, 149}, {16, 5, 8}, {0, 9, 39},
+	{0, 8, 50}, {0, 9, 221}, {16, 4, 3}, {0, 8, 110}, {0, 7, 1}, {0, 9, 131}, {16, 5, 7},
+	{0, 9, 21}, {0, 8, 4}, {0, 9, 204}, {16, 5, 4}, {0, 8, 192}, {0, 7, 99}, {0, 9, 167},
+	{18, 5, 31}, {0, 9, 77}, {0, 8, 60}, {0, 9, 238}, {16, 4, 3}, {0, 8, 104}, {17, 6, 15},
+	{0, 9, 122}, {16, 5, 6}, {0, 9, 12}, {18, 7, 23}, {0, 9, 195}, {0, 5, 0}, {0, 8, 160},
+	{0, 7, 64}, {0, 9, 158}, {16, 5, 8}, {0, 9, 66}, {0, 8, 54}, {0, 9, 230}, {16, 4, 3},
+	{0, 8, 115}, {0, 7, 48}, {0, 9, 140}, {16, 5, 7}, {0, 9, 30}, {0, 8, 16}, {0, 9, 213},
+	{16, 5, 4}, {0, 8, 240}, {0, 7, 101}, {0, 9, 175}, {18, 5, 31}, {0, 9, 86}, {0, 8, 68},
+	{0, 9, 247}, {16, 4, 3}, {0, 8, 98}, {16, 6, 5}, {0, 9, 113}, {16, 5, 6}, {0, 9, 5},
+	{18, 7, 19}, {0, 9, 189}, {0, 5, 0}, {0, 8, 144}, {0, 7, 63}, {0, 9, 154}, {16, 5, 8},
+	{0, 9, 44}, {0, 8, 52}, {0, 9, 226}, {16, 4, 3}, {0, 8, 112}, {0, 7, 32}, {0, 9, 135},
+	{16, 5, 7}, {0, 9, 26}, {0, 8, 8}, {0, 9, 209}, {16, 5, 4}, {0, 8, 208}, {0, 7, 100},
+	{0, 9, 171}, {18, 5, 31}, {0, 9, 82}, {0, 8, 62}, {0, 9, 243}, {16, 4, 3}, {0, 8, 108},
+	{17, 6, 15}, {0, 9, 126}, {16, 5, 6}, {0, 9, 17}, {0, 8, 2}, {0, 9, 199}, {0, 5, 0},
+	{0, 8, 184}, {0, 7, 97}, {0, 9, 163}, {16, 5, 8}, {0, 9, 73}, {0, 8, 57}, {0, 9, 234},
+	{16, 4, 3}, {0, 8, 117}, {0, 7, 49}, {0, 9, 145}, {16, 5, 7}, {0, 9, 35}, {0, 8, 40},
+	{0, 9, 217}, {16, 5, 4}, {16, 8, 9}, {17, 7, 11}, {0, 9, 180}, {18, 5, 31}, {0, 9, 91},
+	{0, 8, 72}, {0, 9, 252}, {16, 4, 3}, {0, 8, 96}, {16, 6, 5}, {0, 9, 106}, {16, 5, 6},
+	{18, 8, 27}, {17, 7, 13}, {0, 9, 187}, {0, 5, 0}, {0, 8, 136}, {0, 7, 56}, {0, 9, 151},
+	{16, 5, 8}, {0, 9, 42}, {0, 8, 51}, {0, 9, 223}, {16, 4, 3}, {0, 8, 111}, {0, 7, 1},
+	{0, 9, 133}, {16, 5, 7}, {0, 9, 23}, {0, 8, 6}, {0, 9, 206}, {16, 5, 4}, {0, 8, 200},
+	{0, 7, 99}, {0, 9, 169}, {18, 5, 31}, {0, 9, 79}, {0, 8, 61}, {0, 9, 241}, {16, 4, 3},
+	{0, 8, 105}, {17, 6, 15}, {0, 9, 124}, {16, 5, 6}, {0, 9, 14}, {18, 7, 23}, {0, 9, 197},
+	{0, 5, 0}, {0, 8, 176}, {0, 7, 64}, {0, 9, 161}, {16, 5, 8}, {0, 9, 69}, {0, 8, 55},
+	{0, 9, 232}, {16, 4, 3}, {0, 8, 116}, {0, 7, 48}, {0, 9, 142}, {16, 5, 7}, {0, 9, 33},
+	{0, 8, 24}, {0, 9, 215}, {16, 5, 4}, {0, 8, 255}, {0, 7, 101}, {0, 9, 178}, {18, 5, 31},
+	{0, 9, 89}, {0, 8, 70}, {0, 9, 249}, {16, 4, 3}, {0, 8, 102}, {16, 6, 5}, {0, 9, 119},
+	{16, 5, 6}, {0, 9, 9}, {18, 7, 19}, {0, 9, 193}, {0, 5, 0}, {0, 8, 152}, {0, 7, 63},
+	{0, 9, 156}, {16, 5, 8}, {0, 9, 47}, {0, 8, 53}, {0, 9, 228}, {16, 4, 3}, {0, 8, 114},
+	{0, 7, 32}, {0, 9, 138}, {16, 5, 7}, {0, 9, 28}, {0, 8, 10}, {0, 9, 211}, {16, 5, 4},
+	{0, 8, 224}, {0, 7, 100}, {0, 9, 173}, {18, 5, 31}, {0, 9, 84}, {0, 8, 65}, {0, 9, 245},
+	{16, 4, 3}, {0, 8, 109}, {17, 6, 15}, {0, 9, 129}, {16, 5, 6}, {0, 9, 19}, {0, 8, 3},
+	{0, 9, 202}, {0, 5, 0}, {0, 8, 191}, {0, 7, 97}, {0, 9, 165}, {16, 5, 8}, {0, 9, 75},
+	{0, 8, 58}, {0, 9, 236}, {16, 4, 3}, {0, 8, 120}, {0, 7, 49}, {0, 9, 147}, {16, 5, 7},
+	{0, 9, 37}, {0, 8, 46}, {0, 9, 219}, {16, 5, 4}, {16, 8, 10}, {17, 7, 11}, {0, 9, 182},
+	{18, 5, 31}, {0, 9, 93}, {0, 8, 80}, {0, 9, 254}, {16, 4, 3}, {0, 8, 88}, {16, 6, 5},
+	{0, 9, 103}, {16, 5, 6}, {17, 8, 17}, {17, 7, 13}, {0, 9, 186}, {0, 5, 0}, {0, 8, 128},
+	{0, 7, 56}, {0, 9, 150}, {16, 5, 8}, {0, 9, 41}, {0, 8, 50}, {0, 9, 222}, {16, 4, 3},
+	{0, 8, 110}, {0, 7, 1}, {0, 9, 132}, {16, 5, 7}, {0, 9, 22}, {0, 8, 4}, {0, 9, 205},
+	{16, 5, 4}, {0, 8, 192}, {0, 7, 99}, {0, 9, 168}, {18, 5, 31}, {0, 9, 78}, {0, 8, 60},
+	{0, 9, 239}, {16, 4, 3}, {0, 8, 104}, {17, 6, 15}, {0, 9, 123}, {16, 5, 6}, {0, 9, 13},
+	{18, 7, 23}, {0, 9, 196}, {0, 5, 0}, {0, 8, 160}, {0, 7, 64}, {0, 9, 159}, {16, 5, 8},
+	{0, 9, 67}, {0, 8, 54}, {0, 9, 231}, {16, 4, 3}, {0, 8, 115}, {0, 7, 48}, {0, 9, 141},
+	{16, 5, 7}, {0, 9, 31}, {0, 8, 16}, {0, 9, 214}, {16, 5, 4}, {0, 8, 240}, {0, 7, 101},
+	{0, 9, 177}, {18, 5, 31}, {0, 9, 87}, {0, 8, 68}, {0, 9, 248}, {16, 4, 3}, {0, 8, 98},
+	{16, 6, 5}, {0, 9, 118}, {16, 5, 6}, {0, 9, 7}, {18, 7, 19}, {0, 9, 190}, {0, 5, 0},
+	{0, 8, 144}, {0, 7, 63}, {0, 9, 155}, {16, 5, 8}, {0, 9, 45}, {0, 8, 52}, {0, 9, 227},
+	{16, 4, 3}, {0, 8, 112}, {0, 7, 32}, {0, 9, 137}, {16, 5, 7}, {0, 9, 27}, {0, 8, 8},
+	{0, 9, 210}, {16, 5, 4}, {0, 8, 208}, {0, 7, 100}, {0, 9, 172}, {18, 5, 31}, {0, 9, 83},
+	{0, 8, 62}, {0, 9, 244}, {16, 4, 3}, {0, 8, 108}, {17, 6, 15}, {0, 9, 127}, {16, 5, 6},
+	{0, 9, 18}, {0, 8, 2}, {0, 9, 201}, {0, 5, 0}, {0, 8, 184}, {0, 7, 97}, {0, 9, 164},
+	{16, 5, 8}, {0, 9, 74}, {0, 8, 57}, {0, 9, 235}, {16, 4, 3}, {0, 8, 117}, {0, 7, 49},
+	{0, 9, 146}, {16, 5, 7}, {0, 9, 36}, {0, 8, 40}, {0, 9, 218}, {16, 5, 4}, {16, 8, 9},
+	{17, 7, 11}, {0, 9, 181}, {18, 5, 31}, {0, 9, 92}, {0, 8, 72}, {0, 9, 253}, {16, 4, 3},
+	{0, 8, 96}, {16, 6, 5}, {0, 9, 107}, {16, 5, 6}, {18, 8, 27}, {17, 7, 13}, {0, 9, 188},
+	{0, 5, 0}, {0, 8, 136}, {0, 7, 56}, {0, 9, 153}, {16, 5, 8}, {0, 9, 43}, {0, 8, 51},
+	{0, 9, 225}, {16, 4, 3}, {0, 8, 111}, {0, 7, 1}, {0, 9, 134}, {16, 5, 7}, {0, 9, 25},
+	{0, 8, 6}, {0, 9, 207}, {16, 5, 4}, {0, 8, 200}, {0, 7, 99}, {0, 9, 170}, {18, 5, 31},
+	{0, 9, 81}, {0, 8, 61}, {0, 9, 242}, {16, 4, 3}, {0, 8, 105}, {17, 6, 15}, {0, 9, 125},
+	{16, 5, 6}, {0, 9, 15}, {18, 7, 23}, {0, 9, 198}, {0, 5, 0}, {0, 8, 176}, {0, 7, 64},
+	{0, 9, 162}, {16, 5, 8}, {0, 9, 71}, {0, 8, 55}, {0, 9, 233}, {16, 4, 3}, {0, 8, 116},
+	{0, 7, 48}, {0, 9, 143}, {16, 5, 7}, {0, 9, 34}, {0, 8, 24}, {0, 9, 216}, {16, 5, 4},
+	{0, 8, 255}, {0, 7, 101}, {0, 9, 179}, {18, 5, 31}, {0, 9, 90}, {0, 8, 70}, {0, 9, 250},
+	{16, 4, 3}, {0, 8, 102}, {16, 6, 5}, {0, 9, 121}, {16, 5, 6}, {0, 9, 11}, {18, 7, 19},
+	{0, 9, 194}, {0, 5, 0}, {0, 8, 152}, {0, 7, 63}, {0, 9, 157}, {16, 5, 8}, {0, 9, 59},
+	{0, 8, 53}, {0, 9, 229}, {16, 4, 3}, {0, 8, 114}, {0, 7, 32}, {0, 9, 139}, {16, 5, 7},
+	{0, 9, 29}, {0, 8, 10}, {0, 9, 212}, {16, 5, 4}, {0, 8, 224}, {0, 7, 100}, {0, 9, 174},
+	{18, 5, 31}, {0, 9, 85}, {0, 8, 65}, {0, 9, 246}, {16, 4, 3}, {0, 8, 109}, {17, 6, 15},
+	{0, 9, 130}, {16, 5, 6}, {0, 9, 20}, {0, 8, 3}, {0, 9, 203}, {0, 5, 0}, {0, 8, 191},
+	{0, 7, 97}, {0, 9, 166}, {16, 5, 8}, {0, 9, 76}, {0, 8, 58}, {0, 9, 237}, {16, 4, 3},
+	{0, 8, 120}, {0, 7, 49}, {0, 9, 148}, {16, 5, 7}, {0, 9, 38}, {0, 8, 46}, {0, 9, 220},
+	{16, 5, 4}, {16, 8, 10}, {17, 7, 11}, {0, 9, 183}, {18, 5, 31}, {0, 9, 94}, {0, 8, 80},
+	{6, 9, 512}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {19, 5, 35}, {96, 1, 0}, {0, 2, 251},
+	{96, 1, 0}, {20, 6, 67}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {16, 5, 258}, {96, 1, 0},
+	{0, 2, 251}, {96, 1, 0}, {21, 6, 131}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {19, 5, 43},
+	{96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {20, 6, 99}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0},
+	{19, 6, 51}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {21, 6, 195}, {96, 1, 0}, {0, 2, 251},
+	{96, 1, 0}, {19, 5, 35}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {20, 6, 83}, {96, 1, 0},
+	{0, 2, 251}, {96, 1, 0}, {16, 5, 258}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {21, 6, 163},
+	{96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {19, 5, 43}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0},
+	{20, 6, 115}, {96, 1, 0}, {0, 2, 251}, {96, 1, 0}, {19, 6, 59}, {96, 1, 0}, {0, 2, 251},
+	{96, 1, 0}, {21, 6, 227},
+};
+
+static const code distcan[512] = {
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {26, 6, 2049}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513},
+	{17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {16, 7, 1}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25},
+	{20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {26, 6, 2049},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {17, 8, 5}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {18, 6, 9},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513},
+	{17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {26, 6, 2049}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25},
+	{20, 4, 33}, {25, 6, 1537}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {16, 7, 1},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {26, 6, 2049}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513},
+	{17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {16, 9, 3}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25},
+	{20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {26, 6, 2049},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {16, 7, 1}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {18, 6, 9},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513},
+	{17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {26, 6, 2049}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25},
+	{20, 4, 33}, {25, 6, 1537}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {17, 8, 5},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {26, 6, 2049}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513},
+	{17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {16, 7, 1}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {24, 5, 769},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385}, {17, 3, 7}, {19, 5, 25},
+	{20, 4, 33}, {18, 6, 9}, {16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {22, 5, 129},
+	{17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025}, {16, 3, 4}, {22, 4, 193},
+	{18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49}, {20, 4, 33}, {26, 6, 2049},
+	{16, 3, 4}, {21, 4, 65}, {16, 4, 2}, {21, 5, 97}, {17, 3, 7}, {23, 4, 257},
+	{19, 4, 17}, {24, 5, 769}, {16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {23, 5, 385},
+	{17, 3, 7}, {19, 5, 25}, {20, 4, 33}, {25, 6, 1537}, {16, 3, 4}, {21, 4, 65},
+	{16, 4, 2}, {22, 5, 129}, {17, 3, 7}, {23, 4, 257}, {19, 4, 17}, {25, 5, 1025},
+	{16, 3, 4}, {22, 4, 193}, {18, 4, 13}, {24, 5, 513}, {17, 3, 7}, {20, 5, 49},
+	{20, 4, 33}, {26, 9, 3073},
+};
diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index d1efad69f02b..a0b331733da7 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -72,6 +72,11 @@ int zlib_inflateInit2(z_streamp strm, int windowBits)
     }
     else {
         state->wrap = (windowBits >> 4) + 1;
+        if (IS_ENABLED(CONFIG_ZLIB_CANNED) && state->wrap == ZLIB_CANNED_WRAP) {
+            windowBits &= 15;
+            if (windowBits > DEFLATE_DEF_CANNED_WINBITS)
+                return Z_STREAM_ERROR;
+        }
     }
     if (windowBits < 8 || windowBits > 15) {
         return Z_STREAM_ERROR;
@@ -363,6 +368,13 @@ int zlib_inflate(z_streamp strm, int flush)
     for (;;)
         switch (state->mode) {
         case HEAD:
+            if (IS_ENABLED(CONFIG_ZLIB_CANNED) && state->wrap == ZLIB_CANNED_WRAP) {
+                zlib_cannedtables(state);
+                state->mode = LEN;
+                state->last = 1;
+                PULLBYTE();
+                break;
+            }
             if (state->wrap == 0) {
                 state->mode = TYPEDO;
                 break;
@@ -702,7 +714,8 @@ int zlib_inflate(z_streamp strm, int flush)
             state->mode = LEN;
             break;
         case CHECK:
-            if (state->wrap) {
+            if (state->wrap && !(IS_ENABLED(CONFIG_ZLIB_CANNED) &&
+                                 state->wrap == ZLIB_CANNED_WRAP)) {
                 NEEDBITS(32);
                 out -= left;
                 strm->total_out += out;
diff --git a/lib/zlib_inflate/inflate.h b/lib/zlib_inflate/inflate.h
index f79337ddf98c..08d75d00285a 100644
--- a/lib/zlib_inflate/inflate.h
+++ b/lib/zlib_inflate/inflate.h
@@ -74,7 +74,10 @@ typedef enum {
 struct inflate_state {
     inflate_mode mode;          /* current inflate mode */
     int last;                   /* true if processing last block */
-    int wrap;                   /* bit 0 true for zlib, bit 1 true for gzip */
+    int wrap;                   /*
+                                 * bit 0 true for zlib, bit 1 true for gzip,
+                                 * bit 2 true for canned mode
+                                 */
     int havedict;               /* true if dictionary provided */
     int flags;                  /* gzip header method and flags (0 if zlib) */
     unsigned dmax;              /* zlib header max distance (INFLATE_STRICT) */
diff --git a/lib/zlib_inflate/infutil.h b/lib/zlib_inflate/infutil.h
index 784ab33b7842..f72ee6ca399f 100644
--- a/lib/zlib_inflate/infutil.h
+++ b/lib/zlib_inflate/infutil.h
@@ -36,4 +36,20 @@ static_assert(offsetof(struct inflate_workspace, dfltcc_state) % 8 == 0);
 
 #define WS(strm) ((struct inflate_workspace *)(strm->workspace))
 
+/*
+ * Return state with length and distance decoding tables and index sizes set to
+ * canned code decoding.  This returns canned tables from infcanned.h if
+ * CONFIG_ZLIB_CANNED is set, otherwise it will get removed during
+ * compliation.
+ */
+static inline void zlib_cannedtables(struct inflate_state *state)
+{
+#ifdef CONFIG_ZLIB_CANNED
+#include "infcanned.h"
+	state->lencode = lencan;
+	state->lenbits = 9;
+	state->distcode = distcan;
+	state->distbits = 9;
+#endif
+}
 #endif
-- 
2.27.0


