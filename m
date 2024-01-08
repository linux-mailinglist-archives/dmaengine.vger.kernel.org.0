Return-Path: <dmaengine+bounces-704-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC8827AE5
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 23:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DFB20DF5
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC141A85;
	Mon,  8 Jan 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKzhqWVh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC586D6C0;
	Mon,  8 Jan 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704754431; x=1736290431;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=L+DcvWu6H9/l/ND3QdWxSY5uAb6MVFiqorsFj9zCCUo=;
  b=hKzhqWVheIJNCjmv14PIg5hWpjLptC0wWOuE1OjUzDWKTMPrLHrREDSP
   YnrC9iS21cLEf1G2qiKK4mjuuI2o0ARC8AQS7yDG3qUJJXNMXJwM03nTz
   Ew7aN8HA1CVDPySHk9X7/8Ck6E7cPab4L7i7LngdHm4dTct/XodFD3JAQ
   aKk/72KNp5uFZe339joTnv0hsqrrPq1BSbkhxWMe4pKmtd4FoGqvZnaZC
   zoZY0ijxSlOYhUq7YcGL6TdrfcBd7hlLgaiMq3nAroq9cPm4O/YGJ/iir
   LxhmNFuYO1+JSg1DFIV/NLccOEeRyCJ355rr4ENExd7Rl4D6ZwhCj/Ca1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5109892"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5109892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781572685"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="781572685"
Received: from psross-mobl4.amr.corp.intel.com ([10.212.89.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:53:49 -0800
Message-ID: <8bde35bf981a1e490114c6b50fc4755a64da55a5.camel@linux.intel.com>
Subject: [PATCH] crypto: iaa - Remove header table code
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, fenghua.yu@intel.com
Cc: dan.carpenter@linaro.org, dave.jiang@intel.com, tony.luck@intel.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org
Date: Mon, 08 Jan 2024 16:53:48 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The header table and related code is currently unused - it was
included and used for canned mode, but canned mode has been removed,
so this code can be safely removed as well.

This indirectly fixes a bug reported by Dan Carpenter.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-crypto/b2e0bd974981291e16882686a2b9b1=
db3986abe4.camel@linux.intel.com/T/#m4403253d6a4347a925fab4fc1cdb4ef7c095fb=
86
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h         |  25 ----
 .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   1 -
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 108 +-----------------
 3 files changed, 3 insertions(+), 131 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/i=
aa/iaa_crypto.h
index 014420f7beb0..2524091a5f70 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -59,10 +59,8 @@ struct iaa_device_compression_mode {
 	const char			*name;
=20
 	struct aecs_comp_table_record	*aecs_comp_table;
-	struct aecs_decomp_table_record	*aecs_decomp_table;
=20
 	dma_addr_t			aecs_comp_table_dma_addr;
-	dma_addr_t			aecs_decomp_table_dma_addr;
 };
=20
 /* Representation of IAA device with wqs, populated by probe */
@@ -107,23 +105,6 @@ struct aecs_comp_table_record {
 	u32 reserved_padding[2];
 } __packed;
=20
-/* AECS for decompress */
-struct aecs_decomp_table_record {
-	u32 crc;
-	u32 xor_checksum;
-	u32 low_filter_param;
-	u32 high_filter_param;
-	u32 output_mod_idx;
-	u32 drop_init_decomp_out_bytes;
-	u32 reserved[36];
-	u32 output_accum_data[2];
-	u32 out_bits_valid;
-	u32 bit_off_indexing;
-	u32 input_accum_data[64];
-	u8  size_qw[32];
-	u32 decomp_state[1220];
-} __packed;
-
 int iaa_aecs_init_fixed(void);
 void iaa_aecs_cleanup_fixed(void);
=20
@@ -136,9 +117,6 @@ struct iaa_compression_mode {
 	int			ll_table_size;
 	u32			*d_table;
 	int			d_table_size;
-	u32			*header_table;
-	int			header_table_size;
-	u16			gen_decomp_table_flags;
 	iaa_dev_comp_init_fn_t	init;
 	iaa_dev_comp_free_fn_t	free;
 };
@@ -148,9 +126,6 @@ int add_iaa_compression_mode(const char *name,
 			     int ll_table_size,
 			     const u32 *d_table,
 			     int d_table_size,
-			     const u8 *header_table,
-			     int header_table_size,
-			     u16 gen_decomp_table_flags,
 			     iaa_dev_comp_init_fn_t init,
 			     iaa_dev_comp_free_fn_t free);
=20
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c b/drivers/cry=
pto/intel/iaa/iaa_crypto_comp_fixed.c
index 45cf5d74f0fb..19d9a333ac49 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
@@ -78,7 +78,6 @@ int iaa_aecs_init_fixed(void)
 				       sizeof(fixed_ll_sym),
 				       fixed_d_sym,
 				       sizeof(fixed_d_sym),
-				       NULL, 0, 0,
 				       init_fixed_mode, NULL);
 	if (!ret)
 		pr_debug("IAA fixed compression mode initialized\n");
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/in=
tel/iaa/iaa_crypto_main.c
index dfd3baf0a8d8..39a5fc905c4d 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -258,16 +258,14 @@ static void free_iaa_compression_mode(struct iaa_comp=
ression_mode *mode)
 	kfree(mode->name);
 	kfree(mode->ll_table);
 	kfree(mode->d_table);
-	kfree(mode->header_table);
=20
 	kfree(mode);
 }
=20
 /*
- * IAA Compression modes are defined by an ll_table, a d_table, and an
- * optional header_table.  These tables are typically generated and
- * captured using statistics collected from running actual
- * compress/decompress workloads.
+ * IAA Compression modes are defined by an ll_table and a d_table.
+ * These tables are typically generated and captured using statistics
+ * collected from running actual compress/decompress workloads.
  *
  * A module or other kernel code can add and remove compression modes
  * with a given name using the exported @add_iaa_compression_mode()
@@ -315,9 +313,6 @@ EXPORT_SYMBOL_GPL(remove_iaa_compression_mode);
  * @ll_table_size: The ll table size in bytes
  * @d_table: The d table
  * @d_table_size: The d table size in bytes
- * @header_table: Optional header table
- * @header_table_size: Optional header table size in bytes
- * @gen_decomp_table_flags: Otional flags used to generate the decomp tabl=
e
  * @init: Optional callback function to init the compression mode data
  * @free: Optional callback function to free the compression mode data
  *
@@ -330,9 +325,6 @@ int add_iaa_compression_mode(const char *name,
 			     int ll_table_size,
 			     const u32 *d_table,
 			     int d_table_size,
-			     const u8 *header_table,
-			     int header_table_size,
-			     u16 gen_decomp_table_flags,
 			     iaa_dev_comp_init_fn_t init,
 			     iaa_dev_comp_free_fn_t free)
 {
@@ -370,16 +362,6 @@ int add_iaa_compression_mode(const char *name,
 		mode->d_table_size =3D d_table_size;
 	}
=20
-	if (header_table) {
-		mode->header_table =3D kzalloc(header_table_size, GFP_KERNEL);
-		if (!mode->header_table)
-			goto free;
-		memcpy(mode->header_table, header_table, header_table_size);
-		mode->header_table_size =3D header_table_size;
-	}
-
-	mode->gen_decomp_table_flags =3D gen_decomp_table_flags;
-
 	mode->init =3D init;
 	mode->free =3D free;
=20
@@ -420,10 +402,6 @@ static void free_device_compression_mode(struct iaa_de=
vice *iaa_device,
 	if (device_mode->aecs_comp_table)
 		dma_free_coherent(dev, size, device_mode->aecs_comp_table,
 				  device_mode->aecs_comp_table_dma_addr);
-	if (device_mode->aecs_decomp_table)
-		dma_free_coherent(dev, size, device_mode->aecs_decomp_table,
-				  device_mode->aecs_decomp_table_dma_addr);
-
 	kfree(device_mode);
 }
=20
@@ -440,73 +418,6 @@ static int check_completion(struct device *dev,
 			    bool compress,
 			    bool only_once);
=20
-static int decompress_header(struct iaa_device_compression_mode *device_mo=
de,
-			     struct iaa_compression_mode *mode,
-			     struct idxd_wq *wq)
-{
-	dma_addr_t src_addr, src2_addr;
-	struct idxd_desc *idxd_desc;
-	struct iax_hw_desc *desc;
-	struct device *dev;
-	int ret =3D 0;
-
-	idxd_desc =3D idxd_alloc_desc(wq, IDXD_OP_BLOCK);
-	if (IS_ERR(idxd_desc))
-		return PTR_ERR(idxd_desc);
-
-	desc =3D idxd_desc->iax_hw;
-
-	dev =3D &wq->idxd->pdev->dev;
-
-	src_addr =3D dma_map_single(dev, (void *)mode->header_table,
-				  mode->header_table_size, DMA_TO_DEVICE);
-	dev_dbg(dev, "%s: mode->name %s, src_addr %llx, dev %p, src %p, slen %d\n=
",
-		__func__, mode->name, src_addr,	dev,
-		mode->header_table, mode->header_table_size);
-	if (unlikely(dma_mapping_error(dev, src_addr))) {
-		dev_dbg(dev, "dma_map_single err, exiting\n");
-		ret =3D -ENOMEM;
-		return ret;
-	}
-
-	desc->flags =3D IAX_AECS_GEN_FLAG;
-	desc->opcode =3D IAX_OPCODE_DECOMPRESS;
-
-	desc->src1_addr =3D (u64)src_addr;
-	desc->src1_size =3D mode->header_table_size;
-
-	src2_addr =3D device_mode->aecs_decomp_table_dma_addr;
-	desc->src2_addr =3D (u64)src2_addr;
-	desc->src2_size =3D 1088;
-	dev_dbg(dev, "%s: mode->name %s, src2_addr %llx, dev %p, src2_size %d\n",
-		__func__, mode->name, desc->src2_addr, dev, desc->src2_size);
-	desc->max_dst_size =3D 0; // suppressed output
-
-	desc->decompr_flags =3D mode->gen_decomp_table_flags;
-
-	desc->priv =3D 0;
-
-	desc->completion_addr =3D idxd_desc->compl_dma;
-
-	ret =3D idxd_submit_desc(wq, idxd_desc);
-	if (ret) {
-		pr_err("%s: submit_desc failed ret=3D0x%x\n", __func__, ret);
-		goto out;
-	}
-
-	ret =3D check_completion(dev, idxd_desc->iax_completion, false, false);
-	if (ret)
-		dev_dbg(dev, "%s: mode->name %s check_completion failed ret=3D%d\n",
-			__func__, mode->name, ret);
-	else
-		dev_dbg(dev, "%s: mode->name %s succeeded\n", __func__,
-			mode->name);
-out:
-	dma_unmap_single(dev, src_addr, 1088, DMA_TO_DEVICE);
-
-	return ret;
-}
-
 static int init_device_compression_mode(struct iaa_device *iaa_device,
 					struct iaa_compression_mode *mode,
 					int idx, struct idxd_wq *wq)
@@ -529,24 +440,11 @@ static int init_device_compression_mode(struct iaa_de=
vice *iaa_device,
 	if (!device_mode->aecs_comp_table)
 		goto free;
=20
-	device_mode->aecs_decomp_table =3D dma_alloc_coherent(dev, size,
-							    &device_mode->aecs_decomp_table_dma_addr, GFP_KERNEL);
-	if (!device_mode->aecs_decomp_table)
-		goto free;
-
 	/* Add Huffman table to aecs */
 	memset(device_mode->aecs_comp_table, 0, sizeof(*device_mode->aecs_comp_ta=
ble));
 	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_tab=
le_size);
 	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_=
size);
=20
-	if (mode->header_table) {
-		ret =3D decompress_header(device_mode, mode, wq);
-		if (ret) {
-			pr_debug("iaa header decompression failed: ret=3D%d\n", ret);
-			goto free;
-		}
-	}
-
 	if (mode->init) {
 		ret =3D mode->init(device_mode);
 		if (ret)
--=20
2.34.1



