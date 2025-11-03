Return-Path: <dmaengine+bounces-7045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F54C2A545
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D62348734
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA62BEC57;
	Mon,  3 Nov 2025 07:30:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD652BE037;
	Mon,  3 Nov 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155040; cv=none; b=jmvrLEYWvFg2mz6LgtI6xseG4hB/dfH7Br+zGKvBFHoxWqkwieTlgRiQ4TG9OXXkHtWfNJFuX1nkvqnQiFEG+Ei4/9Zl0reqpWeGViB98Yecdr0L/wNGPodC7q14Ax4vdEdC5Rl8DtQRpW1U6yXwaiBL8QHf3dg/fKOuNTVVxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155040; c=relaxed/simple;
	bh=yJpL0X0Cx00LFwvb4W5OA82y01xbuW8m07wo0UlQaJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nq3xwuCRe/YsozcvINdjAAt6njMvvHLmy5GXuCj+AEYsNlkqDQ2Bl9EXGJ8sh35zCkqEe0DLlPSgmBIdIoyGs+0hz7JznaJBlzGOP6bkJlwiUaw6MLPFkhKx14yTqgj8P7oKL+3f5wbhmSzq4LnPUzTsGcLrVqHXZxcLeFBdmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABXwvAXWghpYKwzAQ--.23123S2;
	Mon, 03 Nov 2025 15:30:32 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] omap-dma: fix dma_pool resource leak in error paths
Date: Mon,  3 Nov 2025 15:30:18 +0800
Message-ID: <20251103073018.643-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwvAXWghpYKwzAQ--.23123S2
X-Coremail-Antispam: 1UD129KBjvJXoWruryrGw15tr18KFWUGF1xXwb_yoW8JF4Upa
	nrG343K3yjqrW7K3yDJa1Y9FW3KF4aq3yav39rJwn3u348ZryfXFy5XasrCa1DArWrGF1f
	tFWDta4ruFZxJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU1T5dDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8PA2kIR2EHygABsB

The dma_pool created by dma_pool_create() is not destroyed when
dma_async_device_register() or of_dma_controller_register() fails,
causing a resource leak in the probe error paths.

Add dma_pool_destroy() in both error paths to properly release the
allocated dma_pool resource.

Fixes: 7bedaa553760 ("dmaengine: add OMAP DMA engine driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/dma/ti/omap-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8c023c6e623a..73ed4b794630 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1808,6 +1808,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
 			rc);
+		if (od->ll123_supported)
+			dma_pool_destroy(od->desc_pool);
 		omap_dma_free(od);
 		return rc;
 	}
@@ -1823,6 +1825,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_warn("OMAP-DMA: failed to register DMA controller\n");
 			dma_async_device_unregister(&od->ddev);
+			if (od->ll123_supported)
+				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
 		}
 	}
-- 
2.50.1.windows.1


