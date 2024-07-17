Return-Path: <dmaengine+bounces-2708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0393381E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6C91F2573E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A41BF3A;
	Wed, 17 Jul 2024 07:38:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E801B947;
	Wed, 17 Jul 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201883; cv=none; b=W7ZZS3WWh6Yo93ugXF1HlToyybd/roRQiXA6FuHxihd8xcL90nP8vbcKI1JwsvECUTyT8FXZaKwA8UxTGQ0mOTfBSbfiEUqLsepu1+OWGTpa8gy0+wWOFBTsAPn6WySwjnWZ2imFZWevmVTJG394PEL7OCwh0PovOAutoEcZLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201883; c=relaxed/simple;
	bh=t/UNyBQdwHSpMY0EdIe9rgdjk7mcgNPGGnqnPVKx+ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaF4yzj99mXaeXsEaTrCYkhER0WreleqNKTmUsyzj66Kty/kYoNcqBWgMJRprjMxa6YwE2+mnD6EZ6/R/SWE6NNcxaQp5QSGmfF4O9qyHxFI7+JR36EaqDvQjXr2PtZCwbkRMp1um/5GpxGCWsPysw4i6BTJtzgl1tDAppqaOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADHz+fSdJdmlm_DAw--.1201S2;
	Wed, 17 Jul 2024 15:37:54 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vkoul@kernel.org,
	konrad.dybcio@linaro.org,
	gustavoars@kernel.org,
	u.kleine-koenig@pengutronix.de,
	kees@kernel.org,
	caleb.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dmaengine: qcom: bam_dma: Handle the return value of bam_dma_resume
Date: Wed, 17 Jul 2024 15:35:53 +0800
Message-Id: <20240717073553.1821677-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHz+fSdJdmlm_DAw--.1201S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyfJrWkWr4ktF1rJrW8JFb_yoW3urX_KF
	45ZrWfJFsxAFn0kasIyFsxZry2gFyDuF4S9r1Sqay3XFy3tFs8JrWkZrn5A348Z3y8CrW7
	CF1YvFyIkF42vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUO38nUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

As pm_runtime_force_resume() can return error numbers, it should be
better to check the return value and deal with the exception.

Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dma/qcom/bam_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..d2f5a77dfade 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1460,9 +1460,7 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_force_resume(dev);
-
-	return 0;
+	return pm_runtime_force_resume(dev);
 }
 
 static const struct dev_pm_ops bam_dma_pm_ops = {
-- 
2.25.1


