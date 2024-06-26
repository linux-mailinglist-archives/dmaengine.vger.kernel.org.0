Return-Path: <dmaengine+bounces-2536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B430917AE7
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0380B281832
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C614885C;
	Wed, 26 Jun 2024 08:27:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95621144D1D;
	Wed, 26 Jun 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390450; cv=none; b=dhN4l4i1lQ8QICfeTKFJLUCQL0ev2yImbjPsxvKBP+xRe2Nbl96mpIj+WHIi5POYYqhYvXroFYwLp83hT9hLm/Z4Ns6Ucq2OrLvNS0dZFge+2BIw2Xq+pml6LkGtimOzT8x4ltuSUL2zHd5laCED3ZCNNgpWcDmt/7ikJqRhbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390450; c=relaxed/simple;
	bh=mdv0TmLV1ze3/djWQYZsX5TiYv15RDFGrFFWQopYT80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZQOwIMeio2lMUHGEDn9aPJMqxUPZpvXen/OqOiGTFKmvwyihiANdCuXDHVYrv8hM4TpPDiscxXCgBHjKhzTQuDyV9c03bM1mBw1vYoS9byyvXYs7RJxbKmayxArQE/CnZ/4Gzo+xfKDHn0bk8YVKv+R9ssbbRUwIsUXxTF0N7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADnjRDg0HtmWzvfEg--.45984S2;
	Wed, 26 Jun 2024 16:27:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	make24@iscas.ac.cn,
	andriy.shevchenko@linux.intel.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: hsu: Add check for dma_set_max_seg_size in hsu_dma_probe()
Date: Wed, 26 Jun 2024 16:27:11 +0800
Message-Id: <20240626082711.2826915-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnjRDg0HtmWzvfEg--.45984S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4xAF1DCr47JrW8Xw4Utwb_yoW3Kwb_KF
	47urZ8Xrn8Gr48Aw10krWakr90vFWkXF1fWF97tan3t3y8CFnxXrWjvFn5Z3y8ZFW7ZFWD
	G3s8ZrWS9r12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0PfJUUUU
	U==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), we should better
check the return value of the dma_set_max_seg_size().

Fixes: 17b3cf4233d7 ("dmaengine: hsu: set maximum allowed segment size for DMA")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/hsu/hsu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index af5a2e252c25..9d02277fa923 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -479,7 +479,9 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 
 	hsu->dma.dev = chip->dev;
 
-	dma_set_max_seg_size(hsu->dma.dev, HSU_CH_DxTSR_MASK);
+	ret = dma_set_max_seg_size(hsu->dma.dev, HSU_CH_DxTSR_MASK);
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&hsu->dma);
 	if (ret)
-- 
2.25.1


