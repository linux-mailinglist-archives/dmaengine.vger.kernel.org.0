Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D86ACD3D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCFSzI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCFSyN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:54:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D74BE92;
        Mon,  6 Mar 2023 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128796; x=1709664796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJpqELhw+jvd5hGy7AG+RytE6z5raCmAekjOLSm7cWs=;
  b=Jhb9nMW7taB+VkkGqwdjHlpjBUeSQ1rXTZ6BLC8rkfn/lYNafl818RNs
   bl4OMe1ROgko2ajJz4zrGJqBNUk/cuusiuduUghSEwfzPwmC7O347nZqJ
   hU96IGKQe83mob4JB8e2LiRshIv5798ygrOWxs7ONydygPZU63A3NSoq4
   88BX09NjFWTkRN/Mk/ey59RUHx5Puzllrf5K5B1umBQGKJ7YHT53VUWG+
   p8Zmq+s08Kh0JkaihA5oYUYuJKfZgvtTPztBX4janU6eSU/KIQD5pUryh
   eIPQRJMTyYJ7sTLyPFAxn6msqCSU9LVNymBPEUPs1s31+44e4Ba3hOpxU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227816"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255937"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255937"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:04 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 14/16] crypto: iaa - Add support for iaa_crypto async deflate compression algorithm
Date:   Mon,  6 Mar 2023 12:52:24 -0600
Message-Id: <20230306185226.26483-15-tom.zanussi@linux.intel.com>
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

Add support for the iax_crypto async deflate algorithm, so that the
IAA crypto hardware can be used with facilities that require it, such
as zswap.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/iaa/iaa_crypto_main.c | 169 +++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
index cf7c0169cd7b..39f72eda43ff 100644
--- a/drivers/crypto/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/idxd.h>
 #include <linux/highmem.h>
 #include <linux/sched/smt.h>
+#include <crypto/internal/acompress.h>
 
 #include "idxd.h"
 #include "iaa_crypto.h"
@@ -1411,6 +1412,159 @@ static struct crypto_alg iaa_comp_deflate = {
 	}
 };
 
+static int iaa_comp_acompress(struct acomp_req *req)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	u32 compression_crc;
+	struct idxd_wq *wq;
+	struct device *dev;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not compressing\n");
+		return -ENODEV;
+	}
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+	iaa_wq = wq->private_data;
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
+			   &req->dlen, &compression_crc, false);
+	if (ret == -EINPROGRESS)
+		goto out;
+
+	if (iaa_verify_compress) {
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static int iaa_comp_adecompress(struct acomp_req *req)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	struct device *dev;
+	struct idxd_wq *wq;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not decompressing\n");
+		return -ENODEV;
+	}
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+	iaa_wq = wq->private_data;
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+			     dst_addr, &req->dlen, false);
+	if (ret == -EINPROGRESS)
+		goto out;
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static struct acomp_alg iaa_acomp_deflate = {
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.base			= {
+		.cra_name		= "deflate",
+		.cra_driver_name	= "iaa_crypto",
+		.cra_module		= THIS_MODULE,
+		.cra_priority           = IAA_ALG_PRIORITY,
+	}
+};
+
 static int iaa_register_compression_device(void)
 {
 	int ret;
@@ -1421,12 +1575,27 @@ static int iaa_register_compression_device(void)
 		return ret;
 	}
 
+	ret = crypto_register_acomp(&iaa_acomp_deflate);
+	if (ret) {
+		pr_err("deflate algorithm acomp registration failed (%d)\n", ret);
+		goto err_unregister_alg_deflate;
+	}
+
+	return ret;
+
+err_unregister_alg_deflate:
+	crypto_unregister_alg(&iaa_comp_deflate);
+
 	return ret;
 }
 
 static int iaa_unregister_compression_device(void)
 {
+	if (refcount_read(&iaa_acomp_deflate.base.cra_refcnt) > 1)
+		return -EBUSY;
+
 	crypto_unregister_alg(&iaa_comp_deflate);
+	crypto_unregister_acomp(&iaa_acomp_deflate);
 
 	return 0;
 }
-- 
2.34.1

