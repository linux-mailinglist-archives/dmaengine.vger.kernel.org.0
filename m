Return-Path: <dmaengine+bounces-2707-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD039337FD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294241C22530
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970A182B5;
	Wed, 17 Jul 2024 07:28:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E011CA1;
	Wed, 17 Jul 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201324; cv=none; b=aXZzR4keb2AviYuJtcp30xasH+d/Vw4DhnxHGnOXZ5n1e5A5DUGYar399sxRADqGSa6mxBai+6AstZDsNB6ooZ8XbjIjA44Jw7M6ZTpFoir1O5pSHbBmvSK1h0Qgv6NizWchVlYD+PRpLms2lf4JIiwVNzawrI69pe9l+HOYNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201324; c=relaxed/simple;
	bh=+3UZKBIwVeex79+Nu/APBA+T9WPWou0WA6c5A7yRVzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cdn5GW5sYkhNMvhet9UYsfTXm2D7ZZoKpQ8tBnn4lHzMuMLS50DtgzRKRN0iyNTrc7ve5lEmV/9HEFTvd1RwTQbKwDfHtIT18ttTD20FcRxpvtkoXlM69tx8p/rOvpJFj5MMu8jXr31Xcmg6NDzLKsv1Xs8Nd6jYJ+G+M/ggrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABXQyCicpdmPBvDAw--.1559S2;
	Wed, 17 Jul 2024 15:28:35 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vkoul@kernel.org,
	ulf.hansson@linaro.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dmaengine: pl330: Handle the return value of pl330_resume
Date: Wed, 17 Jul 2024 15:27:06 +0800
Message-Id: <20240717072706.1821584-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXQyCicpdmPBvDAw--.1559S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyfJrWkWrWDtFyDKw13twb_yoW3Arb_C3
	WxZFW7CFsIyF909anIyFsxZFyS93W5WF48uryvqay3A345Gwn0qrs8Zrn8G3ykXr48CF43
	GF17uryxCFsI9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbOJ55UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

As pm_runtime_force_resume() can return error numbers, it should be
better to check the return value and deal with the exception.

Fixes: a39cddc9e377 ("dmaengine: pl330: Drop boilerplate code for suspend/resume")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dma/pl330.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 60c4de8dac1d..624ab4eee156 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2993,9 +2993,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_force_resume(dev);
-
-	return ret;
+	return pm_runtime_force_resume(dev);
 }
 
 static const struct dev_pm_ops pl330_pm = {
-- 
2.25.1


