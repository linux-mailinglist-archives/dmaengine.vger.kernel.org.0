Return-Path: <dmaengine+bounces-567-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E2817C36
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B6C2839CA
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6EF760A9;
	Mon, 18 Dec 2023 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Phkd6X+L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C77609F;
	Mon, 18 Dec 2023 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702932443; x=1734468443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/k2cTzSR0pOb1jdaif8MCfX4AFDnVlRKFPQm0DqF9zk=;
  b=Phkd6X+LL31vJ4gNPQRwztsdDkLLRyL2w0ZEkQCRZev+sTE+7O+mQ12m
   KKEb5c9LIrMzq90kPwJNMErXTSWTVhhN+uc8DYHDrwmlkMMxqceGgqqvB
   76RPLHrHKYYT9dqWu7CvNNaTp+QJC+7IUwMftiKyUfCQdB28VHuxMgg09
   HgP8sHc0hYBtPIHO9A9n/4w18FSODmKkd4rjFukTnyxB90s9cn/I1LupC
   2psebwCX8q1LZpujx0Br3zdUC0Ea0mENlxlgGzMDS4qWe1D434juxienw
   TP4IKL+ORNgGg5M1F6j48xrnQ9g8g/no5BUQcWLer4ruoGOT/BBYI8BdV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="462015879"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="462015879"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899101508"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="899101508"
Received: from ssomasun-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.116.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:21 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	jacob.jun.pan@intel.com,
	christophe.jaillet@wanadoo.fr,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/2] crypto: iaa - Change desc->priv to 0
Date: Mon, 18 Dec 2023 14:47:14 -0600
Message-Id: <20231218204715.220299-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order for shared workqeues to work properly, desc->priv should be
set to 0 rather than 1.  The need for this is described in commit
f5ccf55e1028 (dmaengine/idxd: Re-enable kernel workqueue under DMA
API), so we need to make IAA consistent with IOMMU settings, otherwise
we get:

  [  141.948389] IOMMU: dmar15: Page request in Privilege Mode
  [  141.948394] dmar15: Invalid page request: 2000026a100101 ffffb167

Dedicated workqueues ignore this field and are unaffected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index eafa2dd7a5bb..5093361b0107 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -484,7 +484,7 @@ static int decompress_header(struct iaa_device_compression_mode *device_mode,
 
 	desc->decompr_flags = mode->gen_decomp_table_flags;
 
-	desc->priv = 1;
+	desc->priv = 0;
 
 	desc->completion_addr = idxd_desc->compl_dma;
 
@@ -1255,7 +1255,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		IDXD_OP_FLAG_RD_SRC2_AECS | IDXD_OP_FLAG_CC;
 	desc->opcode = IAX_OPCODE_COMPRESS;
 	desc->compr_flags = IAA_COMP_FLAGS;
-	desc->priv = 1;
+	desc->priv = 0;
 
 	desc->src1_addr = (u64)src_addr;
 	desc->src1_size = slen;
@@ -1409,7 +1409,7 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
 	desc->opcode = IAX_OPCODE_DECOMPRESS;
 	desc->decompr_flags = IAA_DECOMP_FLAGS | IAA_DECOMP_SUPPRESS_OUTPUT;
-	desc->priv = 1;
+	desc->priv = 0;
 
 	desc->src1_addr = (u64)dst_addr;
 	desc->src1_size = *dlen;
@@ -1495,7 +1495,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->opcode = IAX_OPCODE_DECOMPRESS;
 	desc->max_dst_size = PAGE_SIZE;
 	desc->decompr_flags = IAA_DECOMP_FLAGS;
-	desc->priv = 1;
+	desc->priv = 0;
 
 	desc->src1_addr = (u64)src_addr;
 	desc->dst_addr = (u64)dst_addr;
-- 
2.34.1


