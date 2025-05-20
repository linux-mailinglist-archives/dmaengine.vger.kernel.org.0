Return-Path: <dmaengine+bounces-5222-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2DABE751
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103421B648DC
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523B25F964;
	Tue, 20 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HH5/mGrE"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561ED254852;
	Tue, 20 May 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780762; cv=none; b=padU7hA3TdzqBLveD2ZMDjMYNWxpq6IccE8FxgfkHHLyIp6udh2rSeKGSiwbkrMckXxhE1HAkzfZe5vO+OowwpP0aM3/L4n9pknwIJxbp1CSGqKt26nANkgSG3KB3x0e6OuCD02dekVGRlfMtPM82IZ1wPP+lfi4o/Vjwids7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780762; c=relaxed/simple;
	bh=65dHJuig6Xc09FeCjANQYLWLrjIQwQ/KDf+eiInMvuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHIVyL2HVeb1pzEMA70ZaMy9MhSf11u3e4UyBU+Bzi295v12bmVfSRNNlxnneU5fIjyQ7hkttx7HWH/2tKsCAea8J46hfI3CV2xvjtuogMM+3ZNhHjVrdYtXj+ei8uZRqEtMPpr7ukjlCC4JN78CqxA/vsAf3Ge0PvwU5UDRu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HH5/mGrE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lFuaiLgn9f656U1Jyjdt1AHxduwwtq8xY1xmWGyvM9g=; b=HH5/mGrE1UHBZKXVrTY9T2F15q
	PbRQFeWX3/4O5rDCkQopdUuvy495K+2KLCv3g2PuBiCyi+k6l7SF7hlSlEfKBgqWR5WxaS5Ka4TtS
	NhqMVsFVEYh1bq5c6zKOqDNYs/b4YQHotfEjTLo/6Z2BA8+rugP5BdsBh3hJc5/x/6g3pJyInwQFh
	Mx0FeVkROW6O3uhY/kZFlrA8zMrZ8hi5spRdlm8lNLEMfpp+25F8bkEfJASBHgsBPZ/pq4WH3lNlO
	wz21TMGZ6LjryO1SBL1RjA2ujq6vu6dj1vUrlpasiLKHsDQypV+JUSV3IH6r6LFqY6Vfqu96gyAlK
	x9ltFGBw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIMJ-1Jrw;
	Tue, 20 May 2025 22:39:14 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: vkoul@kernel.org,
	chenxiang66@hisilicon.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leon@kernel.org,
	jgg@nvidia.com,
	alex.williamson@redhat.com,
	joel.granados@kernel.org
Cc: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 5/6] dma-mapping: benchmark: move validation parameters into a helper
Date: Tue, 20 May 2025 15:39:12 -0700
Message-ID: <20250520223913.3407136-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223913.3407136-1-mcgrof@kernel.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Before we run the benchmark we validate the input parameters. Move
this into a helper so we can also use this for other type of DMA
benchmark tests. This will be used in a subsequent patch for another
type of DMA benchmark.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/dma/map_benchmark.c | 99 +++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index cc19a3efea89..b54345a757cb 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -196,6 +196,55 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	return ret;
 }
 
+static int validate_benchmark_params(struct map_benchmark_data *map)
+{
+	if (map->bparam.threads == 0 ||
+	    map->bparam.threads > DMA_MAP_MAX_THREADS) {
+		pr_err("invalid thread number\n");
+		return -EINVAL;
+	}
+
+	if (map->bparam.seconds == 0 ||
+	    map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
+		pr_err("invalid duration seconds\n");
+		return -EINVAL;
+	}
+
+	if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
+		pr_err("invalid transmission delay\n");
+		return -EINVAL;
+	}
+
+	if (map->bparam.node != NUMA_NO_NODE &&
+	    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
+	     !node_possible(map->bparam.node))) {
+		pr_err("invalid numa node\n");
+		return -EINVAL;
+	}
+
+	if (map->bparam.granule < 1 || map->bparam.granule > 1024) {
+		pr_err("invalid granule size\n");
+		return -EINVAL;
+	}
+
+	switch (map->bparam.dma_dir) {
+	case DMA_MAP_BIDIRECTIONAL:
+		map->dir = DMA_BIDIRECTIONAL;
+		break;
+	case DMA_MAP_FROM_DEVICE:
+		map->dir = DMA_FROM_DEVICE;
+		break;
+	case DMA_MAP_TO_DEVICE:
+		map->dir = DMA_TO_DEVICE;
+		break;
+	default:
+		pr_err("invalid DMA direction\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
@@ -207,54 +256,13 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 	if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
 		return -EFAULT;
 
+	ret = validate_benchmark_params(map);
+	if (ret)
+		return ret;
+
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
-		if (map->bparam.threads == 0 ||
-		    map->bparam.threads > DMA_MAP_MAX_THREADS) {
-			pr_err("invalid thread number\n");
-			return -EINVAL;
-		}
-
-		if (map->bparam.seconds == 0 ||
-		    map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
-			pr_err("invalid duration seconds\n");
-			return -EINVAL;
-		}
-
-		if (map->bparam.dma_trans_ns > DMA_MAP_MAX_TRANS_DELAY) {
-			pr_err("invalid transmission delay\n");
-			return -EINVAL;
-		}
-
-		if (map->bparam.node != NUMA_NO_NODE &&
-		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
-		     !node_possible(map->bparam.node))) {
-			pr_err("invalid numa node\n");
-			return -EINVAL;
-		}
-
-		if (map->bparam.granule < 1 || map->bparam.granule > 1024) {
-			pr_err("invalid granule size\n");
-			return -EINVAL;
-		}
-
-		switch (map->bparam.dma_dir) {
-		case DMA_MAP_BIDIRECTIONAL:
-			map->dir = DMA_BIDIRECTIONAL;
-			break;
-		case DMA_MAP_FROM_DEVICE:
-			map->dir = DMA_FROM_DEVICE;
-			break;
-		case DMA_MAP_TO_DEVICE:
-			map->dir = DMA_TO_DEVICE;
-			break;
-		default:
-			pr_err("invalid DMA direction\n");
-			return -EINVAL;
-		}
-
 		old_dma_mask = dma_get_mask(map->dev);
-
 		ret = dma_set_mask(map->dev,
 				   DMA_BIT_MASK(map->bparam.dma_bits));
 		if (ret) {
@@ -263,6 +271,7 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		}
 
+		/* Run streaming DMA benchmark */
 		ret = do_map_benchmark(map);
 
 		/*
-- 
2.47.2


