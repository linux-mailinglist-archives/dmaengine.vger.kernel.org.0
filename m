Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B896ACD33
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCFSyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCFSxi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:53:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4A3B67C;
        Mon,  6 Mar 2023 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128781; x=1709664781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHpQD+NzS3N+3eoiRG6yDBYPjwV/mVMktF7PXvykG94=;
  b=K2liiGlMcA6oXpoUECkmLdzeeIskoEeibJSXiSF1vyaIgnZg4NVt4hXX
   VHscR2Zdz6KjflBZc91Ar85dCNpN8hF/FnCpGa/LIVwEz54PZTf5T3S+6
   DQQHMvKJkTm197khuTBPthASYUHfSKeaUb7DKNLpHQkuY+syOGWJQE2eQ
   JFfZyT+40GXQN3+Ru47aNY0I93sDnRXNQw9lN7Irs6PLaHIsBQ6Dsv2As
   Fhu3X3Ipq18oCNQXY/+hH2ZIR0q+Lt/H9ZBc2F68lbvPoBGGZYDUHx0bi
   z5H2E0mnHXC24QuV27Tser6BOWxFDXHBZk+uICTfNQql5UHUd668wTeww
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227773"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227773"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255883"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255883"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:57 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 11/16] crypto: iaa - Add compression mode management along with fixed mode
Date:   Mon,  6 Mar 2023 12:52:21 -0600
Message-Id: <20230306185226.26483-12-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Additionally, it defines an in-kernel API for adding, removing, and
setting compression schemes, which can be used by kernel modules or
other kernel code that implements IAA compression schemes.

It also adds a separate file, iaa_crypto_comp_fixed.c, containing
huffman tables generated for a compression scheme named 'fixed'.
Future compression schemes can be added in a similar fashion.

The compression mode in effect can be selected by the user via the new
iaa_crypto 'compression_mode' driver attribute.  Currently, there is
only one compression mode available, 'fixed' mode:

  echo "fixed" >  /sys/bus/dsa/drivers/crypto/compression_mode

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/iaa/Makefile                |   2 +-
 drivers/crypto/iaa/iaa_crypto.h            |  87 +++++
 drivers/crypto/iaa/iaa_crypto_comp_fixed.c |  92 +++++
 drivers/crypto/iaa/iaa_crypto_main.c       | 421 +++++++++++++++++++++
 4 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/iaa/iaa_crypto_comp_fixed.c

diff --git a/drivers/crypto/iaa/Makefile b/drivers/crypto/iaa/Makefile
index 03859431c897..cc87feffd059 100644
--- a/drivers/crypto/iaa/Makefile
+++ b/drivers/crypto/iaa/Makefile
@@ -7,4 +7,4 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
-iaa_crypto-y := iaa_crypto_main.o
+iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_fixed.o
diff --git a/drivers/crypto/iaa/iaa_crypto.h b/drivers/crypto/iaa/iaa_crypto.h
index c25546fa87f7..2daa3522e073 100644
--- a/drivers/crypto/iaa/iaa_crypto.h
+++ b/drivers/crypto/iaa/iaa_crypto.h
@@ -10,6 +10,11 @@
 
 #define IDXD_SUBDRIVER_NAME		"crypto"
 
+#define IAA_COMP_MODES_MAX		2
+
+#define FIXED_HDR			0x2
+#define FIXED_HDR_SIZE			3
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
@@ -18,11 +23,24 @@ struct iaa_wq {
 	struct iaa_device	*iaa_device;
 };
 
+struct iaa_device_compression_mode {
+	const char			*name;
+
+	struct aecs_comp_table_record	*aecs_comp_table;
+	struct aecs_decomp_table_record	*aecs_decomp_table;
+
+	dma_addr_t			aecs_comp_table_dma_addr;
+	dma_addr_t			aecs_decomp_table_dma_addr;
+};
+
 /* Representation of IAA device with wqs, populated by probe */
 struct iaa_device {
 	struct list_head		list;
 	struct idxd_device		*idxd;
 
+	struct iaa_device_compression_mode	*compression_modes[IAA_COMP_MODES_MAX];
+	struct iaa_device_compression_mode	*active_compression_mode;
+
 	int				n_wq;
 	struct list_head		wqs;
 };
@@ -34,4 +52,73 @@ struct wq_table_entry {
 	int	cur_wq;
 };
 
+#define IAA_AECS_ALIGN			32
+
+/*
+ * Analytics Engine Configuration and State (AECS) contains parameters and
+ * internal state of the analytics engine.
+ */
+struct aecs_comp_table_record {
+	u32 crc;
+	u32 xor_checksum;
+	u32 reserved0[5];
+	u32 num_output_accum_bits;
+	u8 output_accum[256];
+	u32 ll_sym[286];
+	u32 reserved1;
+	u32 reserved2;
+	u32 d_sym[30];
+	u32 reserved_padding[2];
+} __packed;
+
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
+int iaa_aecs_init_fixed(void);
+void iaa_aecs_cleanup_fixed(void);
+
+typedef int (*iaa_dev_comp_init_fn_t) (struct iaa_device_compression_mode *mode);
+typedef int (*iaa_dev_comp_free_fn_t) (struct iaa_device_compression_mode *mode);
+
+struct iaa_compression_mode {
+	const char		*name;
+	u32			*ll_table;
+	int			ll_table_size;
+	u32			*d_table;
+	int			d_table_size;
+	u32			*header_table;
+	int			header_table_size;
+	u16			gen_decomp_table_flags;
+	iaa_dev_comp_init_fn_t	init;
+	iaa_dev_comp_free_fn_t	free;
+};
+
+int add_iaa_compression_mode(const char *name,
+			     const u32 *ll_table,
+			     int ll_table_size,
+			     const u32 *d_table,
+			     int d_table_size,
+			     const u8 *header_table,
+			     int header_table_size,
+			     u16 gen_decomp_table_flags,
+			     iaa_dev_comp_init_fn_t init,
+			     iaa_dev_comp_free_fn_t free);
+
+void remove_iaa_compression_mode(const char *name);
+int set_iaa_compression_mode(const char *name);
+
 #endif
diff --git a/drivers/crypto/iaa/iaa_crypto_comp_fixed.c b/drivers/crypto/iaa/iaa_crypto_comp_fixed.c
new file mode 100644
index 000000000000..e965da11b4d9
--- /dev/null
+++ b/drivers/crypto/iaa/iaa_crypto_comp_fixed.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#include "idxd.h"
+#include "iaa_crypto.h"
+
+/*
+ * Fixed Huffman tables the IAA hardware requires to implement RFC-1951.
+ */
+const u32 fixed_ll_sym[286] = {
+	0x40030, 0x40031, 0x40032, 0x40033, 0x40034, 0x40035, 0x40036, 0x40037,
+	0x40038, 0x40039, 0x4003A, 0x4003B, 0x4003C, 0x4003D, 0x4003E, 0x4003F,
+	0x40040, 0x40041, 0x40042, 0x40043, 0x40044, 0x40045, 0x40046, 0x40047,
+	0x40048, 0x40049, 0x4004A, 0x4004B, 0x4004C, 0x4004D, 0x4004E, 0x4004F,
+	0x40050, 0x40051, 0x40052, 0x40053, 0x40054, 0x40055, 0x40056, 0x40057,
+	0x40058, 0x40059, 0x4005A, 0x4005B, 0x4005C, 0x4005D, 0x4005E, 0x4005F,
+	0x40060, 0x40061, 0x40062, 0x40063, 0x40064, 0x40065, 0x40066, 0x40067,
+	0x40068, 0x40069, 0x4006A, 0x4006B, 0x4006C, 0x4006D, 0x4006E, 0x4006F,
+	0x40070, 0x40071, 0x40072, 0x40073, 0x40074, 0x40075, 0x40076, 0x40077,
+	0x40078, 0x40079, 0x4007A, 0x4007B, 0x4007C, 0x4007D, 0x4007E, 0x4007F,
+	0x40080, 0x40081, 0x40082, 0x40083, 0x40084, 0x40085, 0x40086, 0x40087,
+	0x40088, 0x40089, 0x4008A, 0x4008B, 0x4008C, 0x4008D, 0x4008E, 0x4008F,
+	0x40090, 0x40091, 0x40092, 0x40093, 0x40094, 0x40095, 0x40096, 0x40097,
+	0x40098, 0x40099, 0x4009A, 0x4009B, 0x4009C, 0x4009D, 0x4009E, 0x4009F,
+	0x400A0, 0x400A1, 0x400A2, 0x400A3, 0x400A4, 0x400A5, 0x400A6, 0x400A7,
+	0x400A8, 0x400A9, 0x400AA, 0x400AB, 0x400AC, 0x400AD, 0x400AE, 0x400AF,
+	0x400B0, 0x400B1, 0x400B2, 0x400B3, 0x400B4, 0x400B5, 0x400B6, 0x400B7,
+	0x400B8, 0x400B9, 0x400BA, 0x400BB, 0x400BC, 0x400BD, 0x400BE, 0x400BF,
+	0x48190, 0x48191, 0x48192, 0x48193, 0x48194, 0x48195, 0x48196, 0x48197,
+	0x48198, 0x48199, 0x4819A, 0x4819B, 0x4819C, 0x4819D, 0x4819E, 0x4819F,
+	0x481A0, 0x481A1, 0x481A2, 0x481A3, 0x481A4, 0x481A5, 0x481A6, 0x481A7,
+	0x481A8, 0x481A9, 0x481AA, 0x481AB, 0x481AC, 0x481AD, 0x481AE, 0x481AF,
+	0x481B0, 0x481B1, 0x481B2, 0x481B3, 0x481B4, 0x481B5, 0x481B6, 0x481B7,
+	0x481B8, 0x481B9, 0x481BA, 0x481BB, 0x481BC, 0x481BD, 0x481BE, 0x481BF,
+	0x481C0, 0x481C1, 0x481C2, 0x481C3, 0x481C4, 0x481C5, 0x481C6, 0x481C7,
+	0x481C8, 0x481C9, 0x481CA, 0x481CB, 0x481CC, 0x481CD, 0x481CE, 0x481CF,
+	0x481D0, 0x481D1, 0x481D2, 0x481D3, 0x481D4, 0x481D5, 0x481D6, 0x481D7,
+	0x481D8, 0x481D9, 0x481DA, 0x481DB, 0x481DC, 0x481DD, 0x481DE, 0x481DF,
+	0x481E0, 0x481E1, 0x481E2, 0x481E3, 0x481E4, 0x481E5, 0x481E6, 0x481E7,
+	0x481E8, 0x481E9, 0x481EA, 0x481EB, 0x481EC, 0x481ED, 0x481EE, 0x481EF,
+	0x481F0, 0x481F1, 0x481F2, 0x481F3, 0x481F4, 0x481F5, 0x481F6, 0x481F7,
+	0x481F8, 0x481F9, 0x481FA, 0x481FB, 0x481FC, 0x481FD, 0x481FE, 0x481FF,
+	0x38000, 0x38001, 0x38002, 0x38003, 0x38004, 0x38005, 0x38006, 0x38007,
+	0x38008, 0x38009, 0x3800A, 0x3800B, 0x3800C, 0x3800D, 0x3800E, 0x3800F,
+	0x38010, 0x38011, 0x38012, 0x38013, 0x38014, 0x38015, 0x38016, 0x38017,
+	0x400C0, 0x400C1, 0x400C2, 0x400C3, 0x400C4, 0x400C5
+};
+
+const u32 fixed_d_sym[30] = {
+	0x28000, 0x28001, 0x28002, 0x28003, 0x28004, 0x28005, 0x28006, 0x28007,
+	0x28008, 0x28009, 0x2800A, 0x2800B, 0x2800C, 0x2800D, 0x2800E, 0x2800F,
+	0x28010, 0x28011, 0x28012, 0x28013, 0x28014, 0x28015, 0x28016, 0x28017,
+	0x28018, 0x28019, 0x2801A, 0x2801B, 0x2801C, 0x2801D
+};
+
+static int init_fixed_mode(struct iaa_device_compression_mode *mode)
+{
+	struct aecs_comp_table_record *comp_table = mode->aecs_comp_table;
+	u32 bfinal = 1;
+	u32 offset;
+
+	/* Configure aecs table using fixed Huffman table */
+	comp_table->crc = 0;
+	comp_table->xor_checksum = 0;
+	offset = comp_table->num_output_accum_bits / 8;
+	comp_table->output_accum[offset] = FIXED_HDR | bfinal;
+	comp_table->num_output_accum_bits = FIXED_HDR_SIZE;
+
+	return 0;
+}
+
+int iaa_aecs_init_fixed(void)
+{
+	int ret;
+
+	ret = add_iaa_compression_mode("fixed",
+				       fixed_ll_sym,
+				       sizeof(fixed_ll_sym),
+				       fixed_d_sym,
+				       sizeof(fixed_d_sym),
+				       NULL, 0, 0,
+				       init_fixed_mode, NULL);
+	if (!ret)
+		pr_debug("IAA fixed compression mode initialized\n");
+
+	return ret;
+}
+
+void iaa_aecs_cleanup_fixed(void)
+{
+	remove_iaa_compression_mode("fixed");
+}
diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
index 016e23aeb147..9bd42cfa949e 100644
--- a/drivers/crypto/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
@@ -66,6 +66,381 @@ static void wq_table_clear_entry(int cpu)
 static LIST_HEAD(iaa_devices);
 static DEFINE_MUTEX(iaa_devices_lock);
 
+static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
+static int active_compression_mode;
+
+static ssize_t compression_mode_show(struct device_driver *driver, char *buf)
+{
+	int ret = 0;
+
+	ret = sprintf(buf, "%s\n", "fixed");
+
+	return ret;
+}
+
+static ssize_t compression_mode_store(struct device_driver *driver,
+				      const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+	char *mode_name;
+
+	mutex_lock(&iaa_devices_lock);
+
+	mode_name = kstrndup(buf, count, GFP_KERNEL);
+	if (!mode_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = set_iaa_compression_mode(strim(mode_name));
+	if (ret == 0)
+		ret = count;
+
+	kfree(mode_name);
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(compression_mode);
+
+static int find_empty_iaa_compression_mode(void)
+{
+	int i = -EINVAL;
+
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
+		if (iaa_compression_modes[i])
+			continue;
+		break;
+	}
+
+	return i;
+}
+
+static struct iaa_compression_mode *find_iaa_compression_mode(const char *name, int *idx)
+{
+	struct iaa_compression_mode *mode;
+	int i;
+
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
+		mode = iaa_compression_modes[i];
+		if (!mode)
+			continue;
+
+		if (!strcmp(mode->name, name)) {
+			*idx = i;
+			return iaa_compression_modes[i];
+		}
+	}
+
+	return NULL;
+}
+
+static void free_iaa_compression_mode(struct iaa_compression_mode *mode)
+{
+	kfree(mode->name);
+	kfree(mode->ll_table);
+	kfree(mode->d_table);
+	kfree(mode->header_table);
+
+	kfree(mode);
+}
+
+/*
+ * IAA Compression modes are defined by an ll_table, a d_table, and an
+ * optional header_table.  These tables are typically generated and
+ * captured using statistics collected from running actual
+ * compress/decompress workloads.
+ *
+ * A module or other kernel code can add and remove compression modes
+ * with a given name using the exported @add_iaa_compression_mode()
+ * and @remove_iaa_compression_mode functions.
+ *
+ * Successfully added compression modes can be selected using the
+ * function @set_iaa_compression_mode(), passing in the name of the
+ * compression mode.  Henceforth, all compressions and decompressions
+ * will use the given compression mode.  Any in-flight decompressions
+ * using the old mode will subsequently fail.
+ *
+ * When a new compression mode is added, the tables are saved in a
+ * global compression mode list.  When IAA devices are added, a
+ * per-IAA device dma mapping is created for each IAA device, for each
+ * compression mode.  These are the tables used to do the actual
+ * compression/deccompression and are unmapped if/when the devices are
+ * removed.  Currently, compression modes must be added before any
+ * device is added, and removed after all devices have been removed.
+ */
+
+/**
+ * remove_iaa_compression_mode - Remove an IAA compression mode
+ * @name: The name the compression mode will be known as
+ *
+ * Remove the IAA compression mode named @name.
+ */
+void remove_iaa_compression_mode(const char *name)
+{
+	struct iaa_compression_mode *mode;
+	int idx;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (!list_empty(&iaa_devices))
+		goto out;
+
+	mode = find_iaa_compression_mode(name, &idx);
+	if (mode) {
+		free_iaa_compression_mode(mode);
+		iaa_compression_modes[idx] = NULL;
+	}
+out:
+	mutex_unlock(&iaa_devices_lock);
+}
+EXPORT_SYMBOL_GPL(remove_iaa_compression_mode);
+
+/**
+ * add_iaa_compression_mode - Add an IAA compression mode
+ * @name: The name the compression mode will be known as
+ * @ll_table: The ll table
+ * @ll_table_size: The ll table size in bytes
+ * @d_table: The d table
+ * @d_table_size: The d table size in bytes
+ * @header_table: Optional header table
+ * @header_table_size: Optional header table size in bytes
+ * @gen_decomp_table_flags: Otional flags used to generate the decomp table
+ * @init: Optional callback function to init the compression mode data
+ * @free: Optional callback function to free the compression mode data
+ *
+ * Add a new IAA compression mode named @name.  If successful, @name
+ * can subsequently be given to @set_iaa_compression_mode() to make
+ * that mode the current mode for iaa compression/decompression.
+ *
+ * Returns 0 if successful, errcode otherwise.
+ */
+int add_iaa_compression_mode(const char *name,
+			     const u32 *ll_table,
+			     int ll_table_size,
+			     const u32 *d_table,
+			     int d_table_size,
+			     const u8 *header_table,
+			     int header_table_size,
+			     u16 gen_decomp_table_flags,
+			     iaa_dev_comp_init_fn_t init,
+			     iaa_dev_comp_free_fn_t free)
+{
+	struct iaa_compression_mode *mode;
+	int idx, ret = -ENOMEM;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (!list_empty(&iaa_devices)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	mode = kzalloc(sizeof(*mode), GFP_KERNEL);
+	if (!mode)
+		goto out;
+
+	mode->name = kstrdup(name, GFP_KERNEL);
+	if (!mode->name)
+		goto free;
+
+	if (ll_table) {
+		mode->ll_table = kzalloc(ll_table_size, GFP_KERNEL);
+		if (!mode->ll_table)
+			goto free;
+		memcpy(mode->ll_table, ll_table, ll_table_size);
+		mode->ll_table_size = ll_table_size;
+	}
+
+	if (d_table) {
+		mode->d_table = kzalloc(d_table_size, GFP_KERNEL);
+		if (!mode->d_table)
+			goto free;
+		memcpy(mode->d_table, d_table, d_table_size);
+		mode->d_table_size = d_table_size;
+	}
+
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
+	mode->init = init;
+	mode->free = free;
+
+	idx = find_empty_iaa_compression_mode();
+	if (idx < 0)
+		goto free;
+
+	pr_debug("IAA compression mode %s added at idx %d\n",
+		 mode->name, idx);
+
+	iaa_compression_modes[idx] = mode;
+
+	ret = 0;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+free:
+	free_iaa_compression_mode(mode);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(add_iaa_compression_mode);
+
+static void set_iaa_device_compression_mode(struct iaa_device *iaa_device, int idx)
+{
+	iaa_device->active_compression_mode = iaa_device->compression_modes[idx];
+}
+
+static void update_iaa_devices_compression_mode(void)
+{
+	struct iaa_device *iaa_device;
+
+	list_for_each_entry(iaa_device, &iaa_devices, list)
+		set_iaa_device_compression_mode(iaa_device, active_compression_mode);
+}
+
+/**
+ * set_iaa_compression_mode - Set an IAA compression mode
+ * @name: The name of the compression mode
+ *
+ * Make the IAA compression mode named @name the current compression
+ * mode used by compression/decompression.
+ */
+
+int set_iaa_compression_mode(const char *name)
+{
+	struct iaa_compression_mode *mode;
+	int ret = -EINVAL;
+	int idx;
+
+	mode = find_iaa_compression_mode(name, &idx);
+	if (mode) {
+		active_compression_mode = idx;
+		update_iaa_devices_compression_mode();
+		pr_debug("compression mode set to: %s\n", name);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static void free_device_compression_mode(struct iaa_device *iaa_device,
+					 struct iaa_device_compression_mode *device_mode)
+{
+	size_t size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	struct device *dev = &iaa_device->idxd->pdev->dev;
+
+	kfree(device_mode->name);
+
+	if (device_mode->aecs_comp_table)
+		dma_free_coherent(dev, size, device_mode->aecs_comp_table,
+				  device_mode->aecs_comp_table_dma_addr);
+	if (device_mode->aecs_decomp_table)
+		dma_free_coherent(dev, size, device_mode->aecs_decomp_table,
+				  device_mode->aecs_decomp_table_dma_addr);
+
+	kfree(device_mode);
+}
+
+static int init_device_compression_mode(struct iaa_device *iaa_device,
+					struct iaa_compression_mode *mode,
+					int idx, struct idxd_wq *wq)
+{
+	size_t size = sizeof(struct aecs_comp_table_record) + IAA_AECS_ALIGN;
+	struct device *dev = &iaa_device->idxd->pdev->dev;
+	struct iaa_device_compression_mode *device_mode;
+	int ret = -ENOMEM;
+
+	device_mode = kzalloc(sizeof(*device_mode), GFP_KERNEL);
+	if (!device_mode)
+		return -ENOMEM;
+
+	device_mode->name = kstrdup(mode->name, GFP_KERNEL);
+	if (!device_mode->name)
+		goto free;
+
+	device_mode->aecs_comp_table = dma_alloc_coherent(dev, size,
+							  &device_mode->aecs_comp_table_dma_addr, GFP_KERNEL);
+	if (!device_mode->aecs_comp_table)
+		goto free;
+
+	device_mode->aecs_decomp_table = dma_alloc_coherent(dev, size,
+							    &device_mode->aecs_decomp_table_dma_addr, GFP_KERNEL);
+	if (!device_mode->aecs_decomp_table)
+		goto free;
+
+	/* Add Huffman table to aecs */
+	memset(device_mode->aecs_comp_table, 0, sizeof(*device_mode->aecs_comp_table));
+	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_table_size);
+	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_size);
+
+	if (mode->init) {
+		ret = mode->init(device_mode);
+		if (ret)
+			goto free;
+	}
+
+	/* mode index should match iaa_compression_modes idx */
+	iaa_device->compression_modes[idx] = device_mode;
+
+	pr_debug("IAA %s compression mode initialized for iaa device %d\n",
+		 mode->name, iaa_device->idxd->id);
+
+	ret = 0;
+out:
+	return ret;
+free:
+	pr_debug("IAA %s compression mode initialization failed for iaa device %d\n",
+		 mode->name, iaa_device->idxd->id);
+
+	free_device_compression_mode(iaa_device, device_mode);
+	goto out;
+}
+
+static int init_device_compression_modes(struct iaa_device *iaa_device,
+					 struct idxd_wq *wq)
+{
+	struct iaa_compression_mode *mode;
+	int i, ret = 0;
+
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
+		mode = iaa_compression_modes[i];
+		if (!mode)
+			continue;
+
+		ret = init_device_compression_mode(iaa_device, mode, i, wq);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void remove_device_compression_modes(struct iaa_device *iaa_device)
+{
+	struct iaa_device_compression_mode *device_mode;
+	int i;
+
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
+		device_mode = iaa_device->compression_modes[i];
+		if (!device_mode)
+			continue;
+
+		free_device_compression_mode(iaa_device, device_mode);
+		iaa_device->compression_modes[i] = NULL;
+		if (iaa_compression_modes[i]->free)
+			iaa_compression_modes[i]->free(device_mode);
+	}
+}
+
 /*
  * Given a cpu, find the closest IAA instance.  The idea is to try to
  * choose the most appropriate IAA instance for a caller and spread
@@ -162,8 +537,23 @@ static struct iaa_device *add_iaa_device(struct idxd_device *idxd)
 	return iaa_device;
 }
 
+static int init_iaa_device(struct iaa_device *iaa_device, struct iaa_wq *iaa_wq)
+{
+	int ret = 0;
+
+	ret = init_device_compression_modes(iaa_device, iaa_wq->wq);
+	if (ret)
+		return ret;
+
+	set_iaa_device_compression_mode(iaa_device, active_compression_mode);
+
+	return ret;
+}
+
 static void del_iaa_device(struct iaa_device *iaa_device)
 {
+	remove_device_compression_modes(iaa_device);
+
 	list_del(&iaa_device->list);
 
 	iaa_device_free(iaa_device);
@@ -318,6 +708,13 @@ static int save_iaa_wq(struct idxd_wq *wq)
 			del_iaa_device(new_device);
 			goto out;
 		}
+
+		ret = init_iaa_device(new_device, new_wq);
+		if (ret) {
+			del_iaa_wq(new_device, new_wq->wq);
+			del_iaa_device(new_device);
+			goto out;
+		}
 	}
 
 	if (WARN_ON(nr_iaa == 0))
@@ -548,14 +945,38 @@ static int __init iaa_crypto_init_module(void)
 		goto out;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_compression_mode);
+	if (ret) {
+		pr_debug("IAA compression mode attr creation failed\n");
+		goto err_attr_create;
+	}
+
+	ret = iaa_aecs_init_fixed();
+	if (ret < 0) {
+		pr_debug("IAA fixed compression mode init failed\n");
+		goto err_compression_mode;
+	}
+
 	pr_debug("initialized\n");
 out:
 	return ret;
+
+err_compression_mode:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_compression_mode);
+err_attr_create:
+	idxd_driver_unregister(&iaa_crypto_driver);
+
+	goto out;
 }
 
 static void __exit iaa_crypto_cleanup_module(void)
 {
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_compression_mode);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	iaa_aecs_cleanup_fixed();
 
 	pr_debug("cleaned up\n");
 }
-- 
2.34.1

