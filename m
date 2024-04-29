Return-Path: <dmaengine+bounces-1966-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BE8B5029
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 06:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9C1C2183B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 04:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0107A8F6C;
	Mon, 29 Apr 2024 04:14:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CD257B;
	Mon, 29 Apr 2024 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714364042; cv=none; b=TAb0Ik6dspMML49lOuNlSMSs/GbojoFJRU6/lbIEfCDhnut0HUyDkOJAe7TDxb2jpnLy6IEDSLQ6SDG3bzaTY185l+6bTkoP6dkFkt/YzxSBGTF+zoaSFIonEBIdyJACh6oatLKWSWWoJvPGCTazNeyx3HcLNoLqKKTtj/e3+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714364042; c=relaxed/simple;
	bh=fkct8DlcB0+AY4VI9C2Otfh8ZXG+Tr5978Hi039MS5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SeCHSoEOMO6LDa60YZBJhwY3k7Fs5k3k0Q2aGZdHHQaJTciza1C6uzSBbuVKNvbi/G740j6GHb6ykAKwmvZ/4zolhYyGPuXsGU7JAmlo6o+IbENRVezZyWbgw4ODDlyHxck6UMlBAgeUQxYGLg0Xg8tLaJC0H5I2cqrieCSotzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAnGJl4Hi9m+W8SAQ--.23177S2;
	Mon, 29 Apr 2024 12:13:45 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vkoul@kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dmaengine: bcm2835-dma: Add check for dma_set_max_seg_size
Date: Mon, 29 Apr 2024 12:13:12 +0800
Message-Id: <20240429041312.2150441-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnGJl4Hi9m+W8SAQ--.23177S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryfXw1UKr4xCF1xtF1DWrg_yoWfJFb_tr
	48uFWfWr1kGF40y3s0krWSvrWSvFZ0gr4rWr1xtaySq34UCwsxJrW7Zr1kZF4UZa48AFWD
	Ar15urWfCr15CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUe89NUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of dma_set_max_seg_size() and return
the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dma/bcm2835-dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..d1e775a2f6b3 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -899,7 +899,11 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	if (!od)
 		return -ENOMEM;
 
-	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
+	rc = dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
+	if (rc) {
+		dev_err(&pdev->dev, "Unable to set dma device segment size\n");
+		return rc;
+	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-- 
2.25.1


