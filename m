Return-Path: <dmaengine+bounces-1715-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FE8962B5
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8DF1C2349F
	for <lists+dmaengine@lfdr.de>; Wed,  3 Apr 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668731B96B;
	Wed,  3 Apr 2024 02:55:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B81B946;
	Wed,  3 Apr 2024 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112943; cv=none; b=p2jtsAumUsTaUmEjyJum7ES7w+IsFlVU//dHxESV0b5HapQx1eI+R5QHjD9WdN9oTmYL27birmHZlF0Lhfa8BMMXyGBkTyXJLj3sLN5jXiKqIODmnTSyaulOkjcKrcKMpq3yTlteOkFjm8t88RsiusJEBTdsI/xnH3Zy8EoJB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112943; c=relaxed/simple;
	bh=il4nqRFU1y9a8If5bepbPc49nz6SPQfE5okWoBCtPIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIkj1TadSkMCfH428UYcX0Cw0PurH8hNG+3jYnGxFa+8+U7nPHUK4DfHGDNzDa1q249v+cfmNuvDFR3NuOAvdIP/Cq5xN8F+7hXNllAfA9AcwHVSCOqpCURYArGkHSpyddxd9gr+VaEzOQFQrCeoK2o43mpauOEEAxcd8VHgEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAnLwPSwwxmfIIcAQ--.5274S2;
	Wed, 03 Apr 2024 10:49:54 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dmaengine: idma64: Add check for dma_set_max_seg_size
Date: Wed,  3 Apr 2024 02:49:32 +0000
Message-Id: <20240403024932.3342606-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnLwPSwwxmfIIcAQ--.5274S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47XFWfGr43Kr4kWr4kJFb_yoWfWwc_KF
	17Zry5trnIkF4FyrnrKF1avFn0yryDZF1xua92y3WftFWDWFn8Jay7ZFn5Zw1UZa97AF9r
	Kw1qvrWSk3yUWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdnYwUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), it should be
better to check the return value of the dma_set_max_seg_size().

Fixes: e3fdb1894cfa ("dmaengine: idma64: set maximum allowed segment size for DMA")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dma/idma64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 78a938969d7d..58ac374efa3b 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -594,7 +594,9 @@ static int idma64_probe(struct idma64_chip *chip)
 
 	idma64->dma.dev = chip->sysdev;
 
-	dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	ret = dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&idma64->dma);
 	if (ret)
-- 
2.25.1


