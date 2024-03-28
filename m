Return-Path: <dmaengine+bounces-1629-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD5890764
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4919A1C2B685
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7426AF6;
	Thu, 28 Mar 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKjnHymg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE570128370;
	Thu, 28 Mar 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647910; cv=none; b=JVesYLOpavsh3xSKHAgE/ZJrFkispCI0faSuBU6qTfIw7lZKjpt8NQWXL5AJBUnyMrLqWPy++pdWaXGXdA5/q7e54jQyy0X4vV1DRiECM2JMhI8GsKi+adepqp9YAsaZDEqvGrgV3RfnTXRj5PCrjNqdAUMdt4Z3cuKYVj86ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647910; c=relaxed/simple;
	bh=mwRtl4Gj3eQKhBy8l2CMkKhpHHKi5w8URb2yHTrh+zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMDcSIQgWo33TPwBEBck/YVS5YojiINactY5jEP3+0cAALH6M8HeQLfQzm/vRHEWiaCtdw1/mmXO1rR8wpFb/UpFXLr0qGoTD6XwbjKhUeBlWyn0QRN8CbmDu70qy6BNV9b0XDekIDzV4O6qbN5jOH3a+OcvZQAiXjiTgxV1gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKjnHymg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711647908; x=1743183908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwRtl4Gj3eQKhBy8l2CMkKhpHHKi5w8URb2yHTrh+zM=;
  b=PKjnHymg/Pd0tjeVENTFTdHZshQbVlXOVPqmKwUSTo/2QT8aI4QVkYR1
   Bmrf/J/0RT9bnD+yQA/Hx8oNz6PFfX/Ww0DJW6wncaGUzt+rBHOa4jqk4
   QcpoyRpsWGEwRsN+Fa+O1C4lr9cY3GkbP86f3m+H2Xs11EmCdp6WmDyHa
   //AXQDsPW4LCiB+WEVR1YEsa6zd+fCTHt6gZHMW2e08JMzaOeVF6DsD1U
   qm8urAq13ORPCauY3jjgsI2MTw4e5E2fu5IxJ7ch1H3SabiVvSUIG9aFS
   G4VOGuDG3mzkyxsJDNSSIMAl8z+bOwI0Whdz6S0xIUYajFlMIUo4U0sBb
   A==;
X-CSE-ConnectionGUID: Zq8ukXv7TdmVH3+1eRR/Rg==
X-CSE-MsgGUID: c6qpZ5IJQIKqzCGFmnz6cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10631352"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10631352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16675604"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:59 -0700
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
Subject: [PATCH 2/4] crypto: iaa - Add deflate-canned compression algorithm
Date: Thu, 28 Mar 2024 10:44:43 -0700
Message-Id: <f59789265e79701d021ecc45bc50252d8d2a5981.1710969449.git.andre.glover@linux.intel.com>
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

The 'canned' compression mode implements a compression scheme that uses
statically-defined customized Huffman tables. Since the Deflate block
header is a constant, it is not stored with the compressed data. The
Huffman tables used were generated from statistics derived from swapped
4KB pages of SPEC CPU17 workloads. Canned mode provides better compression
than using the Deflate standard's (RFC-1951) "fixed" tables and better
latencies than dynamic compression.

Compressing a data set of 4300 4KB pages sampled from SPEC CPU17 workloads
produces a compression ratio of 2.88 for IAA canned compression and 2.69
for IAA fixed compression, which is a 7% improvement.

Either 'fixed' or 'canned' modes can be chosen as the mode to be used
by crypto facilities by selecting the corresponding algorithm.  For
example, to use IAA fixed mode in zswap:

  echo deflate-iaa > /sys/module/zswap/parameters/compressor

To choose 'canned' mode:

  echo deflate-iaa-canned > /sys/module/zswap/parameters/compressor

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      |  15 +-
 crypto/testmgr.c                              |  10 +
 crypto/testmgr.h                              |  72 +++++
 drivers/crypto/intel/iaa/Kconfig              |   1 +
 drivers/crypto/intel/iaa/Makefile             |   2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h         |  38 +++
 .../crypto/intel/iaa/iaa_crypto_comp_canned.c | 116 ++++++++
 .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 271 ++++++++++++++++--
 9 files changed, 500 insertions(+), 26 deletions(-)
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index 7b28aef39ba0..b64bd780ad87 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -30,8 +30,8 @@ algorithm::
 This will tell zswap to use the IAA 'fixed' compression mode for all
 compresses and decompresses.
 
-Currently, there is only one compression modes available, 'fixed'
-mode.
+Currently, two compression modes are available to all IAA hardware,
+'canned' and 'fixed' modes.
 
 The 'fixed' compression mode implements the compression scheme
 specified by RFC 1951 and is given the crypto algorithm name
@@ -42,6 +42,17 @@ which allows for a window of up to 32k.  Because of this limitation,
 the IAA fixed mode deflate algorithm is given its own algorithm name
 rather than simply 'deflate').
 
+The 'canned' compression mode implements a good general-purpose
+compression scheme whose tables were generated from statistics derived
+from a wide variety of SPEC17 workloads.  It provides much better
+overall characteristics than the existing deflate-1951 tables
+implemented by 'fixed'. 'Canned' mode is implemented by the
+'deflate-iaa-canned' crypto algorithm.::
+
+A zswap device can select the IAA 'canned' mode represented by
+selecting the 'deflate-iaa-canned' crypto compression algorithm::
+
+  # echo deflate-iaa-canned > /sys/module/zswap/parameters/compressor
 
 Config options and other setup
 ==============================
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 94fd9ceef207..8981e8fb220b 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4806,6 +4806,16 @@ static const struct alg_test_desc alg_test_descs[] = {
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
 		.alg = "deflate-scomp-canned",
 		.test = alg_test_comp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 38c4c96e11e2..c79ba30c2194 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34526,6 +34526,78 @@ static const struct comp_testvec deflate_decomp_tv_template[] = {
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
+			  "\xcb\x71\x01\xe5\x3f",
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
+			  "\xc6\x46\x6a\x22\xc3\xec\xff\x03",
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
+			  "\xc6\x46\x6a\x22\xc3\xec\xff\x03",
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
+			  "\xcb\x71\x01\xe5\x3f",
+		.output	= "Join us now and share the software "
+			"Join us now and share the software ",
+	},
+};
+
 static const struct comp_testvec deflate_scomp_canned_comp_tv_template[] = {
 	{
 		.inlen	= 70,
diff --git a/drivers/crypto/intel/iaa/Kconfig b/drivers/crypto/intel/iaa/Kconfig
index d53f4b1d494f..a78fb0db814f 100644
--- a/drivers/crypto/intel/iaa/Kconfig
+++ b/drivers/crypto/intel/iaa/Kconfig
@@ -2,6 +2,7 @@ config CRYPTO_DEV_IAA_CRYPTO
 	tristate "Support for Intel(R) IAA Compression Accelerator"
 	depends on CRYPTO_DEFLATE
 	depends on INTEL_IDXD
+	select ZLIB_CANNED
 	default n
 	help
 	  This driver supports acceleration for compression and
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
index b64b208d2344..9667e89bd88a 100644
--- a/drivers/crypto/intel/iaa/Makefile
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -7,6 +7,6 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
-iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o
+iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o iaa_crypto_comp_canned.o
 
 iaa_crypto-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS) += iaa_crypto_stats.o
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 56985e395263..33ff0f95c543 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -39,6 +39,15 @@
 					 IAA_DECOMP_CHECK_FOR_EOB | \
 					 IAA_DECOMP_STOP_ON_EOB)
 
+/*
+ * iaa_cap.dec_aecs_format_ver == 1 means the decompress internal state in
+ * the AECS is Format 2, which requires a different length from Format 1.
+ * See Intel® In-Memory Analytics Accelerator Architecture Specification
+ * Sections 6.4.1.1 and 7.2.2 for details.
+ */
+#define DECOMP_INT_STATE_FMT1_LEN	1088
+#define DECOMP_INT_STATE_FMT2_LEN	1248
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
@@ -59,8 +68,10 @@ struct iaa_device_compression_mode {
 	const char			*name;
 
 	struct aecs_comp_table_record	*aecs_comp_table;
+	struct aecs_decomp_table_record	*aecs_decomp_table;
 
 	dma_addr_t			aecs_comp_table_dma_addr;
+	dma_addr_t			aecs_decomp_table_dma_addr;
 };
 
 /* Representation of IAA device with wqs, populated by probe */
@@ -77,6 +88,7 @@ struct iaa_device {
 	atomic64_t			comp_bytes;
 	atomic64_t			decomp_calls;
 	atomic64_t			decomp_bytes;
+	u32				src2_size;
 };
 
 struct wq_table_entry {
@@ -105,8 +117,27 @@ struct aecs_comp_table_record {
 	u32 reserved_padding[2];
 } __packed;
 
+/* AECS for decompress */
+struct aecs_decomp_table_record {
+	u32 crc;
+	u32 xor_checksum;
+	u32 low_filter_param;
+	u32 high_filter_param;
+	u32 output_mod_idx;
+	u32 drop_init_decomp_out_bytes;
+	u32 reserved[36];
+	u32 output_accum_data[2];
+	u32 out_bits_valid;
+	u32 bit_off_indexing;
+	u32 input_accum_data[64];
+	u8  size_qw[32];
+	u32 decomp_state[1220];
+} __packed;
+
 int iaa_aecs_init_fixed(void);
 void iaa_aecs_cleanup_fixed(void);
+int iaa_aecs_init_canned(void);
+void iaa_aecs_cleanup_canned(void);
 
 typedef int (*iaa_dev_comp_init_fn_t) (struct iaa_device_compression_mode *mode);
 typedef int (*iaa_dev_comp_free_fn_t) (struct iaa_device_compression_mode *mode);
@@ -117,6 +148,9 @@ struct iaa_compression_mode {
 	int			ll_table_size;
 	u32			*d_table;
 	int			d_table_size;
+	u8			*header_table;
+	int			header_table_size;
+	u16			gen_decomp_table_flags;
 	iaa_dev_comp_init_fn_t	init;
 	iaa_dev_comp_free_fn_t	free;
 };
@@ -126,6 +160,9 @@ int add_iaa_compression_mode(const char *name,
 			     int ll_table_size,
 			     const u32 *d_table,
 			     int d_table_size,
+			     const u8 *header_table,
+			     int header_table_size,
+			     u16 gen_decomp_table_flags,
 			     iaa_dev_comp_init_fn_t init,
 			     iaa_dev_comp_free_fn_t free);
 
@@ -133,6 +170,7 @@ void remove_iaa_compression_mode(const char *name);
 
 enum iaa_mode {
 	IAA_MODE_FIXED,
+	IAA_MODE_CANNED,
 };
 
 struct iaa_compression_ctx {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c
new file mode 100644
index 000000000000..26ea887978e6
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#include "iaa_crypto.h"
+#include "idxd.h"
+
+#define IAA_AECS_ALIGN	32
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
+0x481f9,  0x481fa,  0x481fb,  0x587fe,  0x481fc,  0x481fd,  0x481fe,  0x4009d,
+0x503fe,  0x20000,  0x28003,  0x30010,  0x28004,  0x28005,  0x28006,  0x4009e,
+0x4009f,  0x3802f,  0x38030,  0x30011,  0x400a0,  0x38031,  0x38032,  0x400a1,
+0x28007,  0x73ff8,  0x73ff9,  0x7fff6,  0x7fff7,  0x7fff8,  0x7fff9,  0x7fffa,
+0x7fffb,  0x7fffc,  0x7fffd,  0x7fffe,  0x7ffff,  0x73ffa,
+};
+
+static const u32 canned_d_iaa[30] = {
+0x3807e,  0x20004,  0x481fe,  0x18000,  0x400fe,  0x18001,  0x3003c,  0x20005,
+0x20006,  0x28016,  0x20007,  0x28017,  0x20008,  0x28018,  0x28019,  0x20009,
+0x2000a,  0x2801a,  0x2801b,  0x2801c,  0x2801d,  0x3003d,  0x3003e,  0x481ff,
+0x0,  0x0,  0x0,  0x0,  0x0,  0x0,
+};
+
+#define HEADER_SIZE_IN_BITS 656
+static const u8 canned_header[] = {
+0xed, 0xfd, 0x05, 0x5c, 0x54, 0xcf, 0x17, 0x06,
+0x8c, 0xcf, 0x02, 0x22, 0x62, 0x61, 0x63, 0xaf,
+0x8d, 0x85, 0xbb, 0xe4, 0x82, 0xc0, 0x2e, 0x8a,
+0x88, 0x8d, 0x8d, 0xcd, 0xb2, 0xbb, 0x08, 0x4a,
+0x49, 0x28, 0x36, 0x36, 0x36, 0x36, 0x36, 0x76,
+0x2b, 0x36, 0x26, 0xd8, 0xd8, 0xd8, 0xad, 0xd8,
+0xad, 0xd8, 0xf1, 0x53, 0xf9, 0x9e, 0xb9, 0x33,
+0x03, 0xbb, 0x97, 0x5d, 0xe6, 0x7d, 0xff, 0x1d,
+0xef, 0x1e, 0x1f, 0x9e, 0x7b, 0xce, 0x9c, 0x39,
+0x33, 0xe7, 0x4c, 0xdc, 0xeb, 0xe7, 0xf3, 0xf9,
+0x7c, 0x3e,
+};
+
+#define CEIL(a, b)	(((a) + ((b) - 1)) / (b))
+
+int iaa_aecs_init_canned(void)
+{
+	u16 gen_decomp_table_flags;
+	unsigned int slen;
+	int ret;
+
+	slen = CEIL(HEADER_SIZE_IN_BITS, 8);
+
+	gen_decomp_table_flags = 0x1; /* enable decompression */
+	gen_decomp_table_flags |= 1 << 9; /* suppress output */
+
+	/*
+	 * Bits 8:6 specify the number of bits to ignore at the end of the
+	 * compressed input stream.
+	 * See Intel® In-Memory Analytics Accelerator Architecture Specification
+	 * Sections 6.3.3.1 for details.
+	 */
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
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c b/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
index 19d9a333ac49..45cf5d74f0fb 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
@@ -78,6 +78,7 @@ int iaa_aecs_init_fixed(void)
 				       sizeof(fixed_ll_sym),
 				       fixed_d_sym,
 				       sizeof(fixed_d_sym),
+				       NULL, 0, 0,
 				       init_fixed_mode, NULL);
 	if (!ret)
 		pr_debug("IAA fixed compression mode initialized\n");
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 1ff6b7c77d89..f141a389f5ca 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -34,6 +34,7 @@ static unsigned int nr_cpus_per_node;
 static unsigned int cpus_per_iaa;
 
 static struct crypto_comp *deflate_generic_tfm;
+static struct crypto_acomp *deflate_canned_tfm;
 
 /* Per-cpu lookup table for balanced wqs */
 static struct wq_table_entry __percpu *wq_table;
@@ -91,7 +92,8 @@ DEFINE_MUTEX(iaa_devices_lock);
 
 /* If enabled, IAA hw crypto algos are registered, unavailable otherwise */
 static bool iaa_crypto_enabled;
-static bool iaa_crypto_registered;
+static bool iaa_crypto_fixed_registered;
+static bool iaa_crypto_canned_registered;
 
 /* Verify results of IAA compress or not */
 static bool iaa_verify_compress = true;
@@ -258,14 +260,16 @@ static void free_iaa_compression_mode(struct iaa_compression_mode *mode)
 	kfree(mode->name);
 	kfree(mode->ll_table);
 	kfree(mode->d_table);
+	kfree(mode->header_table);
 
 	kfree(mode);
 }
 
 /*
- * IAA Compression modes are defined by an ll_table and a d_table.
- * These tables are typically generated and captured using statistics
- * collected from running actual compress/decompress workloads.
+ * IAA Compression modes are defined by an ll_table, a d_table, and an
+ * optional header_table. These tables are typically generated and
+ * captured using statistics collected from running actual
+ * compress/decompress workloads.
  *
  * A module or other kernel code can add and remove compression modes
  * with a given name using the exported @add_iaa_compression_mode()
@@ -313,6 +317,9 @@ EXPORT_SYMBOL_GPL(remove_iaa_compression_mode);
  * @ll_table_size: The ll table size in bytes
  * @d_table: The d table
  * @d_table_size: The d table size in bytes
+ * @header_table: Optional header table
+ * @header_table_size: Optional header table size in bytes
+ * @gen_decomp_table_flags: Otional flags used to generate the decomp table
  * @init: Optional callback function to init the compression mode data
  * @free: Optional callback function to free the compression mode data
  *
@@ -325,6 +332,9 @@ int add_iaa_compression_mode(const char *name,
 			     int ll_table_size,
 			     const u32 *d_table,
 			     int d_table_size,
+			     const u8 *header_table,
+			     int header_table_size,
+			     u16 gen_decomp_table_flags,
 			     iaa_dev_comp_init_fn_t init,
 			     iaa_dev_comp_free_fn_t free)
 {
@@ -362,6 +372,16 @@ int add_iaa_compression_mode(const char *name,
 		mode->d_table_size = d_table_size;
 	}
 
+	if (header_table) {
+		mode->header_table = kzalloc(header_table_size, GFP_KERNEL);
+		if (!mode->header_table)
+			goto free;
+		memcpy(mode->header_table, header_table, header_table_size);
+		mode->header_table_size = header_table_size;
+	}
+
+	mode->gen_decomp_table_flags = gen_decomp_table_flags;
+
 	mode->init = init;
 	mode->free = free;
 
@@ -394,14 +414,19 @@ get_iaa_device_compression_mode(struct iaa_device *iaa_device, int idx)
 static void free_device_compression_mode(struct iaa_device *iaa_device,
 					 struct iaa_device_compression_mode *device_mode)
 {
-	size_t size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	size_t c_size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	size_t d_size = sizeof(struct aecs_decomp_table_record) + IAA_AECS_ALIGN;
 	struct device *dev = &iaa_device->idxd->pdev->dev;
 
 	kfree(device_mode->name);
 
 	if (device_mode->aecs_comp_table)
-		dma_free_coherent(dev, size, device_mode->aecs_comp_table,
+		dma_free_coherent(dev, c_size, device_mode->aecs_comp_table,
 				  device_mode->aecs_comp_table_dma_addr);
+	if (device_mode->aecs_decomp_table)
+		dma_free_coherent(dev, d_size, device_mode->aecs_decomp_table,
+				  device_mode->aecs_decomp_table_dma_addr);
+
 	kfree(device_mode);
 }
 
@@ -418,11 +443,79 @@ static int check_completion(struct device *dev,
 			    bool compress,
 			    bool only_once);
 
+static int decompress_header(struct iaa_device_compression_mode *device_mode,
+			     struct iaa_compression_mode *mode,
+			     struct idxd_wq *wq)
+{
+	dma_addr_t src_addr, src2_addr;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct device *dev;
+	struct iaa_wq *iaa_wq;
+	struct iaa_device *iaa_device;
+	int ret = 0;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc))
+		return PTR_ERR(idxd_desc);
+
+	desc = idxd_desc->iax_hw;
+
+	iaa_wq = idxd_wq_get_private(wq);
+	iaa_device = iaa_wq->iaa_device;
+	dev = &wq->idxd->pdev->dev;
+
+	src_addr = dma_map_single(dev, (void *)mode->header_table,
+				  mode->header_table_size, DMA_TO_DEVICE);
+	dev_dbg(dev, "%s: mode->name %s, src_addr %llx, dev %p, src %p, slen %d\n",
+		__func__, mode->name, src_addr,	dev,
+		mode->header_table, mode->header_table_size);
+	if (unlikely(dma_mapping_error(dev, src_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+	src2_addr = device_mode->aecs_decomp_table_dma_addr;
+
+	desc->flags = IAX_AECS_GEN_FLAG;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+	desc->decompr_flags = mode->gen_decomp_table_flags;
+	desc->priv = 0;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->src1_size = mode->header_table_size;
+	desc->src2_addr = (u64)src2_addr;
+	desc->src2_size = iaa_device->src2_size;
+	dev_dbg(dev, "%s: mode->name %s, src2_addr %llx, dev %p, src2_size %d\n",
+		__func__, mode->name, desc->src2_addr, dev, desc->src2_size);
+	desc->max_dst_size = 0; // suppressed output
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		pr_err("%s: submit_desc failed ret=0x%x\n", __func__, ret);
+		goto out;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret)
+		dev_dbg(dev, "%s: mode->name %s check_completion failed ret=%d\n",
+			__func__, mode->name, ret);
+	else
+		dev_dbg(dev, "%s: mode->name %s succeeded\n", __func__,
+			mode->name);
+out:
+	dma_unmap_single(dev, src_addr, desc->src2_size, DMA_TO_DEVICE);
+
+	return ret;
+}
+
 static int init_device_compression_mode(struct iaa_device *iaa_device,
 					struct iaa_compression_mode *mode,
 					int idx, struct idxd_wq *wq)
 {
-	size_t size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	size_t c_size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	size_t d_size = sizeof(struct aecs_decomp_table_record) + IAA_AECS_ALIGN;
 	struct device *dev = &iaa_device->idxd->pdev->dev;
 	struct iaa_device_compression_mode *device_mode;
 	int ret = -ENOMEM;
@@ -435,16 +528,29 @@ static int init_device_compression_mode(struct iaa_device *iaa_device,
 	if (!device_mode->name)
 		goto free;
 
-	device_mode->aecs_comp_table = dma_alloc_coherent(dev, size,
+	device_mode->aecs_comp_table = dma_alloc_coherent(dev, c_size,
 							  &device_mode->aecs_comp_table_dma_addr, GFP_KERNEL);
 	if (!device_mode->aecs_comp_table)
 		goto free;
 
+	device_mode->aecs_decomp_table = dma_alloc_coherent(dev, d_size,
+							    &device_mode->aecs_decomp_table_dma_addr, GFP_KERNEL);
+	if (!device_mode->aecs_decomp_table)
+		goto free;
+
 	/* Add Huffman table to aecs */
 	memset(device_mode->aecs_comp_table, 0, sizeof(*device_mode->aecs_comp_table));
 	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_table_size);
 	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_size);
 
+	if (mode->header_table) {
+		ret = decompress_header(device_mode, mode, wq);
+		if (ret) {
+			pr_debug("iaa header decompression failed: ret=%d\n", ret);
+			goto free;
+		}
+	}
+
 	if (mode->init) {
 		ret = mode->init(device_mode);
 		if (ret)
@@ -786,6 +892,13 @@ static int save_iaa_wq(struct idxd_wq *wq)
 			goto out;
 		}
 
+		idxd = new_device->idxd;
+		/* Set IAA device src2 size based on AECS Format Version */
+		if (idxd->hw.iaa_cap.dec_aecs_format_ver)
+			new_device->src2_size = DECOMP_INT_STATE_FMT2_LEN;
+		else
+			new_device->src2_size = DECOMP_INT_STATE_FMT1_LEN;
+
 		ret = add_iaa_wq(new_device, wq, &new_wq);
 		if (ret) {
 			del_iaa_device(new_device);
@@ -1006,6 +1119,24 @@ static int deflate_generic_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int deflate_canned_decompress(struct acomp_req *req)
+{
+	int ret;
+	struct acomp_req *sw_req;
+
+	sw_req = acomp_request_alloc(deflate_canned_tfm);
+	acomp_request_set_params(sw_req, req->src, req->dst, req->slen, req->dlen);
+
+	ret = crypto_acomp_decompress(sw_req);
+
+	req->dlen = sw_req->dlen;
+
+	acomp_request_free(sw_req);
+	update_total_sw_decomp_calls();
+
+	return ret;
+}
+
 static int iaa_remap_for_verify(struct device *dev, struct iaa_wq *iaa_wq,
 				struct acomp_req *req,
 				dma_addr_t *src_addr, dma_addr_t *dst_addr);
@@ -1052,13 +1183,20 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
 		if (!ctx->compress &&
 		    idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
-			pr_warn("%s: falling back to deflate-generic decompress, "
+			char *deflate_str =  (compression_ctx->mode == IAA_MODE_CANNED) ?
+					      "deflate-canned" : "deflate-generic";
+
+			pr_warn("%s: falling back to %s decompress, "
 				"analytics error code %x\n", __func__,
-				idxd_desc->iax_completion->error_code);
-			ret = deflate_generic_decompress(ctx->req);
+				deflate_str, idxd_desc->iax_completion->error_code);
+
+			if (compression_ctx->mode == IAA_MODE_CANNED)
+				ret = deflate_canned_decompress(ctx->req);
+			else
+				ret = deflate_generic_decompress(ctx->req);
+
 			if (ret) {
-				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
-					__func__, ret);
+				dev_dbg(dev, "%s: %s failed ret=%d\n", __func__, deflate_str, ret);
 				err = -EIO;
 				goto err;
 			}
@@ -1288,6 +1426,7 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_wq *iaa_wq;
 	struct pci_dev *pdev;
 	struct device *dev;
+	dma_addr_t src2_addr;
 	int ret = 0;
 
 	iaa_wq = idxd_wq_get_private(wq);
@@ -1328,6 +1467,13 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 		desc->src1_addr, desc->src1_size, desc->dst_addr,
 		desc->max_dst_size, desc->src2_addr, desc->src2_size);
 
+	if (ctx->mode == IAA_MODE_CANNED) {
+		src2_addr = active_compression_mode->aecs_decomp_table_dma_addr;
+		desc->src2_addr = (u64)src2_addr;
+		desc->src2_size = iaa_device->src2_size;
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+	}
+
 	ret = idxd_submit_desc(wq, idxd_desc);
 	if (ret) {
 		dev_dbg(dev, "submit_desc (verify) failed ret=%d\n", ret);
@@ -1375,6 +1521,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_wq *iaa_wq;
 	struct pci_dev *pdev;
 	struct device *dev;
+	dma_addr_t src2_addr;
 	int ret = 0;
 
 	iaa_wq = idxd_wq_get_private(wq);
@@ -1406,6 +1553,13 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->src1_size = slen;
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (ctx->mode == IAA_MODE_CANNED) {
+		src2_addr = active_compression_mode->aecs_decomp_table_dma_addr;
+		desc->src2_addr = (u64)src2_addr;
+		desc->src2_size = iaa_device->src2_size;
+		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
+	}
+
 	if (ctx->use_irq && !disable_async) {
 		desc->flags |= IDXD_OP_FLAG_RCI;
 
@@ -1450,13 +1604,20 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	if (ret) {
 		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
 		if (idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
-			pr_warn("%s: falling back to deflate-generic decompress, "
+			char *deflate_str =  (ctx->mode == IAA_MODE_CANNED) ?
+					      "deflate-canned" : "deflate-generic";
+
+			pr_warn("%s: falling back to %s decompress, "
 				"analytics error code %x\n", __func__,
-				idxd_desc->iax_completion->error_code);
-			ret = deflate_generic_decompress(req);
+				deflate_str, idxd_desc->iax_completion->error_code);
+
+			if (ctx->mode == IAA_MODE_CANNED)
+				ret = deflate_canned_decompress(req);
+			else
+				ret = deflate_generic_decompress(req);
+
 			if (ret) {
-				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
-					__func__, ret);
+				dev_dbg(dev, "%s: %s failed ret=%d\n", __func__, deflate_str, ret);
 				goto err;
 			}
 		} else {
@@ -1821,6 +1982,33 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
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
+	.dst_free               = dst_free,
+	.base			= {
+		.cra_name		= "deflate-canned",
+		.cra_driver_name	= "deflate-iaa-canned",
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_module		= THIS_MODULE,
+		.cra_priority		= IAA_ALG_PRIORITY,
+	}
+};
+
 static int iaa_register_compression_device(void)
 {
 	int ret;
@@ -1830,16 +2018,30 @@ static int iaa_register_compression_device(void)
 		pr_err("deflate algorithm acomp fixed registration failed (%d)\n", ret);
 		goto out;
 	}
+	iaa_crypto_fixed_registered = true;
 
-	iaa_crypto_registered = true;
+	ret = crypto_register_acomp(&iaa_acomp_canned_deflate);
+	if (ret) {
+		pr_err("deflate algorithm acomp canned registration failed (%d)\n", ret);
+		goto err_canned;
+	}
+	iaa_crypto_canned_registered = true;
+
+	goto out;
+
+err_canned:
+	crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+	iaa_crypto_fixed_registered = false;
 out:
 	return ret;
 }
 
 static int iaa_unregister_compression_device(void)
 {
-	if (iaa_crypto_registered)
+	if (iaa_crypto_fixed_registered)
 		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+	if (iaa_crypto_canned_registered)
+		crypto_unregister_acomp(&iaa_acomp_canned_deflate);
 
 	return 0;
 }
@@ -2014,9 +2216,20 @@ static int __init iaa_crypto_init_module(void)
 		deflate_generic_tfm = crypto_alloc_comp("deflate-generic", 0, 0);
 
 	if (IS_ERR_OR_NULL(deflate_generic_tfm)) {
-		pr_err("IAA could not alloc %s tfm: errcode = %ld\n",
-		       "deflate-generic", PTR_ERR(deflate_generic_tfm));
-		return -ENOMEM;
+		ret = PTR_ERR(deflate_generic_tfm);
+		pr_err("IAA could not alloc %s tfm: errcode = %d\n",
+		       "deflate-generic", ret);
+		goto out;
+	}
+
+	if (crypto_has_acomp("deflate-canned", 0, 0))
+		deflate_canned_tfm = crypto_alloc_acomp("deflate-canned", 0, 0);
+
+	if (IS_ERR_OR_NULL(deflate_canned_tfm)) {
+		ret = PTR_ERR(deflate_canned_tfm);
+		pr_err("IAA could not alloc %s tfm: errcode = %d\n",
+		       "deflate-canned", ret);
+		goto err_deflate_canned_tfm;
 	}
 
 	ret = iaa_aecs_init_fixed();
@@ -2025,6 +2238,12 @@ static int __init iaa_crypto_init_module(void)
 		goto err_aecs_init;
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
@@ -2058,8 +2277,12 @@ static int __init iaa_crypto_init_module(void)
 err_verify_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
+	iaa_aecs_cleanup_canned();
+err_canned:
 	iaa_aecs_cleanup_fixed();
 err_aecs_init:
+	crypto_free_acomp(deflate_canned_tfm);
+err_deflate_canned_tfm:
 	crypto_free_comp(deflate_generic_tfm);
 
 	goto out;
@@ -2076,8 +2299,10 @@ static void __exit iaa_crypto_cleanup_module(void)
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	iaa_aecs_cleanup_canned();
 	iaa_aecs_cleanup_fixed();
 	crypto_free_comp(deflate_generic_tfm);
+	crypto_free_acomp(deflate_canned_tfm);
 
 	pr_debug("cleaned up\n");
 }
-- 
2.27.0


