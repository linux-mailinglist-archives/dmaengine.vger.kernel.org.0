Return-Path: <dmaengine+bounces-2537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45459917B3B
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013BA2816DF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261FA15FA7E;
	Wed, 26 Jun 2024 08:45:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5415F41F;
	Wed, 26 Jun 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391543; cv=none; b=o851s9tdU7i/+1HjC0AloOMXrcdpwWiwt9pBQLBo62ki4x/xxzfzmi0eYwB3+H7pSTjeEJuVJly/fJXJHw07wVA622ylTfRD2jNeDb7TtyRj22NWY20gqyLAXxFjoQ7FqZ9xx8/yML6ioS66O/jKfTOUvA0c0d48ybg0pGLzd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391543; c=relaxed/simple;
	bh=QCXtTQwQCTkr4Q+pZbpLZTqkGqQg9qNPN6tr95+ABNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4abWAWNqEgzARD6TtZGwHRj3tGTsY09xXASWC6wPLIk7pGyYfsIN2ZTmQnpQzVZ9MrLJfdv2qpAw4H9zVPZgUm1l7JtUHZQ7Eo5ARSIggiKvpvjz1Jl9sUYcd/OZot0SLVhNHMnYCIIZNIyOn27Dm10etipnJgTmJXjnHdjzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXXwMc1XtmtNbfEg--.48462S2;
	Wed, 26 Jun 2024 16:45:27 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size in mxs_dma_probe()
Date: Wed, 26 Jun 2024 16:45:15 +0800
Message-Id: <20240626084515.2829595-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXXwMc1XtmtNbfEg--.48462S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47Wr1UAF48Cw13KF18AFb_yoWDurg_Z3
	WUuF1fXFn8Wr4Fyw13KrnxCw4Iqr9IqF97uF13ta93try7WF1Sqr4DZr95Jry8ZanrCFWq
	vw1UXrWSvr4DujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUjiF4JUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), we should better
check the return value of the dma_set_max_seg_size().

Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/mxs-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index cfb9962417ef..90cbb9b04b02 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -798,7 +798,9 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.dev = &pdev->dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
-	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
+	ret = dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
+	if (ret)
+		return ret;
 
 	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
 	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
-- 
2.25.1


