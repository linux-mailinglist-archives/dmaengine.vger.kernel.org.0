Return-Path: <dmaengine+bounces-1628-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009A89075F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921011C2493A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4812F391;
	Thu, 28 Mar 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiyWkzh/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE126AF6;
	Thu, 28 Mar 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647910; cv=none; b=hDryC+ETvbauWotiTDhmac3a3eUiIDXJenIR2oBjUerg2gScHSZvJ6yX6phD3R6n3wZDFoJnXZ4KZQoRCHgRYpn+ddbBDAHCphdRZeleFLeOCGmnNKlePwPKZ18YaJ2toAQoH5oHoizjIqzOtde/v9kAc0Ie4i04lNMLTgQd3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647910; c=relaxed/simple;
	bh=ac1Kn8LmwZ5RI2FPdjV2fO+QzvvOlEM30zcJmht4tQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDYhvx0bu9godBMsx0WzlEZrK/CO54ycBljX++VwPcu5at1r2mvjVsV8eboj63WTXuXG1L8BaBZEQPFafWK0KV2XYDvc2+PAp4rONqpADhbCqkJzZsEnXThIy36Ky9qW06DVfdSIbhS8vv0QoYLp/W/jceLkOIRwud/xQn6rrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiyWkzh/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711647909; x=1743183909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ac1Kn8LmwZ5RI2FPdjV2fO+QzvvOlEM30zcJmht4tQk=;
  b=GiyWkzh/MDS4DHyJuw/Eqx+yy69c76bEd+lYOQ4ZirA6y5Fea7DwTkr1
   Dn6gxC7ophkHcLF+3UF7Cf70h47bHka+IQUTMCjnwKNn3pfyK7jS31eWE
   dswPqaQLBPgtTaffs5FDpRvnqsYYn8yZRCbjIHK3ABQg3DXkpf+pC28MF
   PXD+twFpDXVvJjhO1k5g4XCZU3YhEv95e2cV/OlQlr1ODHC0pfPQiN9fR
   TzIHrVqYkSc+Gb2+UITbgpDMhxmDBXsvubtO6IYgV2hNhVeb08DdsE0jl
   ia76kkWNtPVni9oQO9Pk6aQ2ohc6t04u82FXxUy94Qh9fU+bM0pwNgIxQ
   w==;
X-CSE-ConnectionGUID: xrhB358CTmWOhlxFQuECIA==
X-CSE-MsgGUID: AVSnW7dTRRSwxP1VlXKSfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10631357"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10631357"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16675627"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:45:00 -0700
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
Subject: [PATCH 3/4] crypto: iaa - Add deflate-iaa-dynamic compression algorithm
Date: Thu, 28 Mar 2024 10:44:44 -0700
Message-Id: <d7e080791f8dab932b5584c583cf17b37af3046e.1710969449.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710969449.git.andre.glover@linux.intel.com>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some versions of Intel IAA support dynamic compression where the hardware
dynamically computes the Huffman tables and generates a Deflate header
if the input size is no larger than 4KB. This patch will use IAA for
dynamic compression if an appropriate IAA is present and the input size is
not too big. If an IAA is not present, the algorithm will not
be available. Otherwise, if the size of the input is too big, zlib is used
to do the compression. If the algorithm is selected, IAA will be used for
decompression. If the compressed stream contains a reference whose
distance is greater than 4KB, hardware decompression will fail, and the
decompression will be done with zlib.

Intel IAA dynamic compression results in a compression ratio that is
better than or equal to the currently supported "canned" and/or "fixed"
compression modes on the same data set. Compressing a data set of 4300 4KB
pages sampled from SPEC CPU17 workloads produces a compression ratio of
3.14 for IAA dynamic compression, 2.88 for IAA canned compression and 2.69
for IAA fixed compression.

If an appropriate IAA exists, ‘dynamic’ mode can be chosen as the mode
to be used by crypto facilities by selecting the corresponding algorithm.
For example, to use IAA dynamic mode in zswap:

      echo deflate-iaa-dynamic > /sys/module/zswap/parameters/compressor

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 21 +++++
 crypto/testmgr.c                              | 10 +++
 crypto/testmgr.h                              | 74 ++++++++++++++++
 drivers/crypto/intel/iaa/Makefile             |  2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h         |  6 +-
 .../intel/iaa/iaa_crypto_comp_dynamic.c       | 22 +++++
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 88 +++++++++++++++++--
 7 files changed, 215 insertions(+), 8 deletions(-)
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index b64bd780ad87..a7136c804ca4 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -33,6 +33,8 @@ compresses and decompresses.
 Currently, two compression modes are available to all IAA hardware,
 'canned' and 'fixed' modes.
 
+'dynamic' mode is available on certain generations of IAA hardware.
+
 The 'fixed' compression mode implements the compression scheme
 specified by RFC 1951 and is given the crypto algorithm name
 'deflate-iaa'.  (Because the IAA hardware has a 4k history-window
@@ -54,6 +56,25 @@ selecting the 'deflate-iaa-canned' crypto compression algorithm::
 
   # echo deflate-iaa-canned > /sys/module/zswap/parameters/compressor
 
+The 'dynamic' compression mode implements a compression scheme where
+the IAA hardware will internally do one pass through the data, compute the
+Huffman tables and generate a Deflate header, then automatically do a
+second pass through the data, generating the final compressed output. IAA
+dynamic compression can be used if an appropriate IAA is present and the
+input size is not too big.  If an appropriate IAA is not present, the
+algorithm will not be available. Otherwise, if the size of the input is too
+big, zlib is used to do the compression. If the algorithm is selected,
+IAA will be used for decompression. If the compressed stream contains a
+reference whose distance is greater than 4KB, hardware decompression will
+fail, and the decompression will be done with zlib. If an appropriate IAA
+exists, 'dynamic' compression, it is implemented by the
+'deflate-iaa-dynamic' crypto algorithm.
+
+A zswap device can select the IAA 'dynamic' mode represented by
+selecting the 'deflate-iaa-dynamic' crypto compression algorithm::
+
+  # echo deflate-iaa-dynamic> /sys/module/zswap/parameters/compressor
+
 Config options and other setup
 ==============================
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 8981e8fb220b..f48b00c9eac8 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4816,6 +4816,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(deflate_iaa_canned_decomp_tv_template)
 			}
 		}
+	}, {
+		.alg = "deflate-iaa-dynamic",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(deflate_iaa_dynamic_comp_tv_template),
+				.decomp = __VECS(deflate_iaa_dynamic_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "deflate-scomp-canned",
 		.test = alg_test_comp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index c79ba30c2194..88736fc6509e 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34598,6 +34598,80 @@ static const struct comp_testvec deflate_iaa_canned_decomp_tv_template[] = {
 	},
 };
 
+static const struct comp_testvec deflate_iaa_dynamic_comp_tv_template[] = {
+	{
+		.inlen	= 70,
+		.outlen	= 46,
+		.input	= "Join us now and share the software "
+			"Join us now and share the software ",
+		.output = "\x85\xca\xc1\x09\x00\x20\x08\x05"
+			  "\xd0\x55\xfe\x3c\x6e\x21\x64\xd8"
+			  "\x45\x21\x0d\xd7\xb7\x26\xe8\xf8"
+			  "\xe0\x91\x2f\xc3\x09\x98\x17\xd8"
+			  "\x06\x42\x79\x0b\x52\x05\xe1\x33"
+			  "\xeb\x81\x3e\xe5\xa2\x01",
+	}, {
+		.inlen	= 191,
+		.outlen	= 121,
+		.input	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+		.output = "\x5d\x8d\xc1\x0d\xc2\x30\x10\x04"
+			  "\x5b\xd9\x0a\xd2\x03\x82\x20\x21"
+			  "\xf1\xf0\x23\x0d\x5c\xec\x0b\xb6"
+			  "\x64\xfb\x2c\xdf\xf1\xa0\x7b\x12"
+			  "\x3e\x58\x79\xae\x76\x67\x76\x89"
+			  "\x49\x11\xc4\xbf\x0b\x57\x43\x60"
+			  "\xf5\x3d\xad\xac\x20\x78\x29\xad"
+			  "\xb3\x6a\x92\x8a\xc2\x16\x25\x60"
+			  "\x25\xe5\x80\x3d\x5b\x64\xdc\xe6"
+			  "\xfb\xf3\xb2\xcc\xe3\x8c\xf2\x4b"
+			  "\x7a\xb2\x58\x26\xe0\x2c\xde\x52"
+			  "\xdd\xb5\x07\x48\xad\xe5\xe4\xc9"
+			  "\x0e\x42\xb6\xd1\xf5\x17\xc0\xe4"
+			  "\x57\x3c\x1c\x1c\x7d\xb2\x50\xc0"
+			  "\x75\x38\x72\x5d\x4c\xbc\xe4\xe9"
+			  "\x0b",
+	},
+};
+
+static const struct comp_testvec deflate_iaa_dynamic_decomp_tv_template[] = {
+	{
+		.inlen	= 121,
+		.outlen	= 191,
+		.input	= "\x5d\x8d\xc1\x0d\xc2\x30\x10\x04"
+			  "\x5b\xd9\x0a\xd2\x03\x82\x20\x21"
+			  "\xf1\xf0\x23\x0d\x5c\xec\x0b\xb6"
+			  "\x64\xfb\x2c\xdf\xf1\xa0\x7b\x12"
+			  "\x3e\x58\x79\xae\x76\x67\x76\x89"
+			  "\x49\x11\xc4\xbf\x0b\x57\x43\x60"
+			  "\xf5\x3d\xad\xac\x20\x78\x29\xad"
+			  "\xb3\x6a\x92\x8a\xc2\x16\x25\x60"
+			  "\x25\xe5\x80\x3d\x5b\x64\xdc\xe6"
+			  "\xfb\xf3\xb2\xcc\xe3\x8c\xf2\x4b"
+			  "\x7a\xb2\x58\x26\xe0\x2c\xde\x52"
+			  "\xdd\xb5\x07\x48\xad\xe5\xe4\xc9"
+			  "\x0e\x42\xb6\xd1\xf5\x17\xc0\xe4"
+			  "\x57\x3c\x1c\x1c\x7d\xb2\x50\xc0"
+			  "\x75\x38\x72\x5d\x4c\xbc\xe4\xe9"
+			  "\x0b",
+		.output	= "This document describes a compression method based on the DEFLATE"
+			"compression algorithm.  This document defines the application of "
+			"the DEFLATE algorithm to the IP Payload Compression Protocol.",
+	}, {
+		.inlen	= 46,
+		.outlen	= 70,
+		.input	= "\x85\xca\xc1\x09\x00\x20\x08\x05"
+			  "\xd0\x55\xfe\x3c\x6e\x21\x64\xd8"
+			  "\x45\x21\x0d\xd7\xb7\x26\xe8\xf8"
+			  "\xe0\x91\x2f\xc3\x09\x98\x17\xd8"
+			  "\x06\x42\x79\x0b\x52\x05\xe1\x33"
+			  "\xeb\x81\x3e\xe5\xa2\x01",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 static const struct comp_testvec deflate_scomp_canned_comp_tv_template[] = {
 	{
 		.inlen	= 70,
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
index 9667e89bd88a..1c70456ad9b8 100644
--- a/drivers/crypto/intel/iaa/Makefile
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -7,6 +7,6 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
-iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o iaa_crypto_comp_canned.o
+iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o iaa_crypto_comp_canned.o iaa_crypto_comp_dynamic.o
 
 iaa_crypto-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS) += iaa_crypto_stats.o
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 33ff0f95c543..a7f4baa137e0 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -18,6 +18,7 @@
 
 #define IAA_COMP_FLUSH_OUTPUT		BIT(1)
 #define IAA_COMP_APPEND_EOB		BIT(2)
+#define IAA_COMP_GEN_HDR_1_PASS		(BIT(12) | BIT(13))
 
 #define IAA_COMPLETION_TIMEOUT		1000000
 
@@ -26,7 +27,7 @@
 #define IAA_ERROR_COMP_BUF_OVERFLOW	0x19
 #define IAA_ERROR_WATCHDOG_EXPIRED	0x24
 
-#define IAA_COMP_MODES_MAX		2
+#define IAA_COMP_MODES_MAX		3
 
 #define FIXED_HDR			0x2
 #define FIXED_HDR_SIZE			3
@@ -138,6 +139,8 @@ int iaa_aecs_init_fixed(void);
 void iaa_aecs_cleanup_fixed(void);
 int iaa_aecs_init_canned(void);
 void iaa_aecs_cleanup_canned(void);
+int iaa_aecs_init_dynamic(void);
+void iaa_aecs_cleanup_dynamic(void);
 
 typedef int (*iaa_dev_comp_init_fn_t) (struct iaa_device_compression_mode *mode);
 typedef int (*iaa_dev_comp_free_fn_t) (struct iaa_device_compression_mode *mode);
@@ -171,6 +174,7 @@ void remove_iaa_compression_mode(const char *name);
 enum iaa_mode {
 	IAA_MODE_FIXED,
 	IAA_MODE_CANNED,
+	IAA_MODE_DYNAMIC,
 };
 
 struct iaa_compression_ctx {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c
new file mode 100644
index 000000000000..baca238cd136
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
+
+#include "idxd.h"
+#include "iaa_crypto.h"
+
+int iaa_aecs_init_dynamic(void)
+{
+	int ret;
+
+	ret = add_iaa_compression_mode("dynamic", NULL, 0, NULL, 0, NULL, 0, 0, NULL, NULL);
+
+	if (!ret)
+		pr_debug("IAA dynamic compression mode initialized\n");
+
+	return ret;
+}
+
+void iaa_aecs_cleanup_dynamic(void)
+{
+	remove_iaa_compression_mode("dynamic");
+}
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index f141a389f5ca..4d34096b80ca 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -94,6 +94,7 @@ DEFINE_MUTEX(iaa_devices_lock);
 static bool iaa_crypto_enabled;
 static bool iaa_crypto_fixed_registered;
 static bool iaa_crypto_canned_registered;
+static bool iaa_crypto_dynamic_registered;
 
 /* Verify results of IAA compress or not */
 static bool iaa_verify_compress = true;
@@ -1137,6 +1138,23 @@ static int deflate_canned_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int deflate_generic_compress(struct acomp_req *req)
+{
+	void *src, *dst;
+	int ret;
+
+	src = kmap_local_page(sg_page(req->src)) + req->src->offset;
+	dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
+
+	ret = crypto_comp_compress(deflate_generic_tfm,
+				   src, req->slen, dst, &req->dlen);
+
+	kunmap_local(src);
+	kunmap_local(dst);
+
+	return ret;
+}
+
 static int iaa_remap_for_verify(struct device *dev, struct iaa_wq *iaa_wq,
 				struct acomp_req *req,
 				dma_addr_t *src_addr, dma_addr_t *dst_addr);
@@ -1292,8 +1310,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	}
 	desc = idxd_desc->iax_hw;
 
-	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR |
-		IDXD_OP_FLAG_RD_SRC2_AECS | IDXD_OP_FLAG_CC;
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
 	desc->opcode = IAX_OPCODE_COMPRESS;
 	desc->compr_flags = IAA_COMP_FLAGS;
 	desc->priv = 0;
@@ -1302,8 +1319,13 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src1_size = slen;
 	desc->dst_addr = (u64)dst_addr;
 	desc->max_dst_size = *dlen;
-	desc->src2_addr = active_compression_mode->aecs_comp_table_dma_addr;
-	desc->src2_size = sizeof(struct aecs_comp_table_record);
+	if (ctx->mode == IAA_MODE_DYNAMIC) {
+		desc->compr_flags |= IAA_COMP_GEN_HDR_1_PASS;
+	} else {
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+		desc->src2_addr = active_compression_mode->aecs_comp_table_dma_addr;
+		desc->src2_size = sizeof(struct aecs_comp_table_record);
+	}
 	desc->completion_addr = idxd_desc->compl_dma;
 
 	if (ctx->use_irq && !disable_async) {
@@ -1669,6 +1691,9 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		return -EINVAL;
 	}
 
+	if (compression_ctx->mode == IAA_MODE_DYNAMIC && req->slen > PAGE_SIZE)
+		return deflate_generic_compress(req);
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -2009,7 +2034,34 @@ static struct acomp_alg iaa_acomp_canned_deflate = {
 	}
 };
 
-static int iaa_register_compression_device(void)
+static int iaa_comp_init_dynamic(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	compression_ctx_init(ctx);
+
+	ctx->mode = IAA_MODE_DYNAMIC;
+
+	return 0;
+}
+
+static struct acomp_alg iaa_acomp_dynamic_deflate = {
+	.init			= iaa_comp_init_dynamic,
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.dst_free               = dst_free,
+	.base			= {
+		.cra_name		= "deflate",
+		.cra_driver_name	= "deflate-iaa-dynamic",
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_module		= THIS_MODULE,
+		.cra_priority		= IAA_ALG_PRIORITY + 1,
+	}
+};
+
+static int iaa_register_compression_device(struct idxd_device *idxd)
 {
 	int ret;
 
@@ -2027,8 +2079,21 @@ static int iaa_register_compression_device(void)
 	}
 	iaa_crypto_canned_registered = true;
 
+	/* Header Generation Capability is required for the dynamic algorithm. */
+	if (idxd->hw.iaa_cap.header_gen) {
+		ret = crypto_register_acomp(&iaa_acomp_dynamic_deflate);
+		if (ret) {
+			pr_err("deflate algorithm acomp dynamic registration failed (%d)\n", ret);
+			goto err_dynamic;
+		}
+		iaa_crypto_dynamic_registered = true;
+	}
+
 	goto out;
 
+err_dynamic:
+	crypto_unregister_acomp(&iaa_acomp_canned_deflate);
+	iaa_crypto_canned_registered = false;
 err_canned:
 	crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
 	iaa_crypto_fixed_registered = false;
@@ -2042,6 +2107,8 @@ static int iaa_unregister_compression_device(void)
 		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
 	if (iaa_crypto_canned_registered)
 		crypto_unregister_acomp(&iaa_acomp_canned_deflate);
+	if (iaa_crypto_dynamic_registered)
+		crypto_unregister_acomp(&iaa_acomp_dynamic_deflate);
 
 	return 0;
 }
@@ -2103,7 +2170,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	if (first_wq) {
 		iaa_crypto_enabled = true;
-		ret = iaa_register_compression_device();
+		ret = iaa_register_compression_device(idxd);
 		if (ret != 0) {
 			iaa_crypto_enabled = false;
 			dev_dbg(dev, "IAA compression device registration failed\n");
@@ -2244,6 +2311,12 @@ static int __init iaa_crypto_init_module(void)
 		goto err_canned;
 	}
 
+	ret = iaa_aecs_init_dynamic();
+	if (ret < 0) {
+		pr_debug("IAA dynamic compression mode init failed\n");
+		goto err_dynamic;
+	}
+
 	ret = idxd_driver_register(&iaa_crypto_driver);
 	if (ret) {
 		pr_debug("IAA wq sub-driver registration failed\n");
@@ -2277,6 +2350,8 @@ static int __init iaa_crypto_init_module(void)
 err_verify_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
+	iaa_aecs_cleanup_dynamic();
+err_dynamic:
 	iaa_aecs_cleanup_canned();
 err_canned:
 	iaa_aecs_cleanup_fixed();
@@ -2299,6 +2374,7 @@ static void __exit iaa_crypto_cleanup_module(void)
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	iaa_aecs_cleanup_dynamic();
 	iaa_aecs_cleanup_canned();
 	iaa_aecs_cleanup_fixed();
 	crypto_free_comp(deflate_generic_tfm);
-- 
2.27.0


