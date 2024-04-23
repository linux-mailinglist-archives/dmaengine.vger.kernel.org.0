Return-Path: <dmaengine+bounces-1934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D98AE99B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0986F1C2390F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6A1B94F;
	Tue, 23 Apr 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YHarZTkS"
X-Original-To: dmaengine@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B719470;
	Tue, 23 Apr 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882782; cv=none; b=jIivSPu8ndYGoB3ZYhV/IIc5Ytk3Hrmp/rcJtHgfG5o6wUFrA4nSqryfInFwJYl1jR5Ejh3pGDsbH3TCmagGzRy9jkjKLt6I2FsZOOtXq21sAkWAFeQ4dzyKGt7CHWU8hqH0HUkJCFFzwj7XMMvNG98gSkjNuNcEfrYlm24uQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882782; c=relaxed/simple;
	bh=rhanHVe3z+7fCFfPykj623sG54XyU9274IQHaPm11Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpIwSRwgl1snTRKbLDRqL0w7ra7kAc1yEOWsXw7ZnolNer6SQ3a23DCYuW7QtliicAiHvsjy7o/wPh4nlcueiACiGr8ZP2fjBKzpLcTAfmwXFASXj9mompXIY401TlZul0JzdYt68M5DJzO+zzxZ+818chY4eoEBvFU9O3JziC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YHarZTkS; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ARYwg
	qGlUlLRaTcXZttU9ahIzTed8W0mvg6q9Al2vLc=; b=YHarZTkSNPVFAAlOYA/VX
	hz/5+Eg9eOOB/qA9I5n9lhnyqWS7VbTbE4bLK9Q5LjV/ftbFm90jSXAUU0wRRMZh
	G7LZcOohnXtzOfX6MkMBadDP0ZXohHWhP4xo+MvhGEfEY//Fu1raOf9eTJ6fKIb9
	qlkwU/ODkqDcAL7IBZM1nE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3P65oxidmlQBkCA--.58334S4;
	Tue, 23 Apr 2024 22:32:17 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: vkoul@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size()
Date: Tue, 23 Apr 2024 22:32:05 +0800
Message-Id: <20240423143205.1420976-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P65oxidmlQBkCA--.58334S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw43ZF43Xw47Xw4kAF4rAFb_yoWfKFX_Z3
	WUurn3XFn8Wr4rtw13KrsxAw4IqF9IgFZ7uF13tayftr17uFnaqr4DZrykXry8Za17CFWq
	934UXrWSvr4DujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNkucJUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRLJC2V4G40UqwAAsp

To avoid the failure of dma_set_max_seg_size(), we should check the
return value of the dma_set_max_seg_size().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
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
2.37.2


