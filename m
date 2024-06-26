Return-Path: <dmaengine+bounces-2538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BF917B6E
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD141F24457
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEFC166310;
	Wed, 26 Jun 2024 08:54:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DD16131C;
	Wed, 26 Jun 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392076; cv=none; b=DSzTUdvqebInhZJ6qdUvNAucSM9V/YBYzXU0C3JmWeGGGcqKPOXqQt3x99IbATHZyRjPPY/XUZPnJw+rZKsdsHBlvaHwLwtEJk9Roazarc9pbNDqP38o0lj3SpKxGeAXhd3d3DJUuX3jFwJ8gDAK3Lc6Nu734xhZXPF6N2nOUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392076; c=relaxed/simple;
	bh=3dWHKSrnh8Hisl7GmZ4i/i76w/yg3I9uybuB1lceG/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+b9J6DDwhLXqHOqXxGjvv2gBIKJWl6g7B7eT8dfZ6DbyWfVdZbNpumAf2zqS4NEPjQPiHKnaRlKL34GAjy/UJrnGIgAvic8NE12OfbFM6KwKQFoK5i3tgBoTEpPximervoOLfB1lGCXTm7Zj9LsRfvQHzy6O/KdNg3/2e88aEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXXeU+13tmtSfgEg--.47148S2;
	Wed, 26 Jun 2024 16:54:24 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jee.heng.sia@intel.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] dmaengine: dw-axi-dmac: Add check for dma_set_max_seg_size in dw_probe()
Date: Wed, 26 Jun 2024 16:54:16 +0800
Message-Id: <20240626085416.2831017-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXXeU+13tmtSfgEg--.47148S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw45uFW8ur1rXrW8Kw47twb_yoWDKrc_C3
	WUWF45tr4kW3yktrs0kF1SvrW09rykAr42gF4xtFZ2y3y5Gr4DXw4kZFWkArn8Z3yrCFWj
	kFsrWrWfC3ZxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUm2NtUUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), we should better
check the return value of the dma_set_max_seg_size().

Fixes: 78a90a1e489e ("dmaengine: dw-axi-dmac: Set constraint to the Max segment size")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index fffafa86d964..689667e10928 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1579,7 +1579,10 @@ static int dw_probe(struct platform_device *pdev)
 	 * Therefore, set constraint to 1024 * 4.
 	 */
 	dw->dma.dev->dma_parms = &dw->dma_parms;
-	dma_set_max_seg_size(&pdev->dev, MAX_BLOCK_SIZE);
+	ret = dma_set_max_seg_size(&pdev->dev, MAX_BLOCK_SIZE);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_enable(chip->dev);
-- 
2.25.1


