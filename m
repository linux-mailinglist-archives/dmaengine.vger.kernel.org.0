Return-Path: <dmaengine+bounces-5768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8826B02BFD
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 18:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F416179B30
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jul 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F52750FB;
	Sat, 12 Jul 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GI0JVNek"
X-Original-To: dmaengine@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E590283121;
	Sat, 12 Jul 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339128; cv=none; b=oWsHbmFjX0ecYyDSifxRNTj1cGNwzSf//Wmy7QnRnXz8S6X5a8XzjIpFCnyEiHQfetRxCCiNnn8IA9uwgbZdH28Peu4zvRKs2zLZDWeoocHj8hu3LYwfxyEz8bY/sxr9nGdoZGEAqcqj7VKHmlFgxBiqJDGrdBBLCRvc95LgSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339128; c=relaxed/simple;
	bh=Q0O7HWg8AE63MEU1vWFgt8bEuGjTs9rXdujwwW+pLno=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tfQt3XV+bvy1ftOGtcYBIWx6e/TO3R9pplBb/hXVWcc8bO7JYm9CiSUZl2Uc2jV0Un/eNkq1FVeUE1wHLFfdpfhzqvG0c3bO+nxJAFnuwApExAQle5QRR+gC1YdhrXugoSEhQqICaTyCJwUoTY98FiU9oMl/rzTzyCWtqDheTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GI0JVNek; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752339115;
	bh=aSzg8YlR1AUMQ2In+T6QsIXueXNuaVIOpJQUm73O8/Q=;
	h=From:To:Cc:Subject:Date;
	b=GI0JVNekrVGbDVutx6X4aaknvEt1JPolXbSE0S9TTBczB/v+9dJNyiFqYKaByhoib
	 4zEReczfXoqb/wMtoTu7sewOKhwvp+yz90bsbUAU3OVcaWz4eSYH/qFVy9yM9aBqI0
	 6LQ4lCY1pZ4YP3i3oKVeZD2oo74Tlg9G5PD7qU6s=
Received: from KernelDevBox.byted.org ([115.190.40.15])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id CF51420E; Sun, 13 Jul 2025 00:51:53 +0800
X-QQ-mid: xmsmtpt1752339113t8vmo3pw7
Message-ID: <tencent_891450514525826E2E6AD3B6ECC0B83C7209@qq.com>
X-QQ-XMAILINFO: NVe3Dal9ycbTsSDqaYWgwOUbfXkskS8uGgYICxCMQR6sFNwa/kQ6ONLQybiFVJ
	 eNeSTc1G3AMFDek2KcSZFk/qi3FJnA6FZ2qP81JJR9GBmubVkmJ8bqZu68l0TYK6BECeDsj5xCtD
	 pREVWWmfKSMPvhVnCSlHXMbvAs5fMKH0H3p2m2Bak2X0t6QeCJbSEQ1VVoqeiS2bhZvkz/29gCMT
	 mcv1z3XJY4fEwfhhCVWTtP3j7nI6WpK4MBQXAV4enbeG2Sypm3Qy1C6JRePKbHIRkkQ8W1HLwyWH
	 toctIes91/AJdDGfOH8HnwkjISVa/ipKBk2+0HzkiOWJtRJCrhynEzmOYstQsFLHxcnKVrEzxMfh
	 c/YzqQYxBs+DdJske9vBYFuspKfw8qJHYEFHZfGs5KqmrhX5WSS2ZKn+hFPqSz3cYI/j5owPUFkl
	 RnF2g2WJN31oaVr+Gw7rm4joIP2i5XtYbQ8FuCa4AyjgV+gZFLGTcZkF+stuIixcMHwUpEULRRrF
	 kiHKOq9Yv4Bh/OHXfRZDBkt3szGvxHS0ssKK9WX1kUyLSpUB6iFG6ITm/1YVNIpogaKDj7Wgn1m2
	 Tx42UeEsYMdACToj6ikTryXzZlfDt76LQ+opKDD8FLqHbXSrMCvKP++HAVyrdVNn/SEEDkREV7dK
	 pyHUs+ghkXjclAXhCqvNbtZgZTBgUPnAsrBujP87JHtX8IC6SIfJ/ZxlKsc4LNZoNNZeddy4dmMm
	 UZNo90NRa31TCRR4SFKWvOkWWGy7B0qENv8KykQojv0VsrEOcZ7QsTmITVHOoPcc82Lb8AUikFNc
	 WfcsfdFKzBZl0n8ZcLt4F6vNZwGw0Wc88kZtbXu+QFVoJyIMqQil7MwYahuIMVh4IzxBPkBd2fHG
	 bwdCqKheDm4Dw0cCGARzhDXbRNmoTUrYOynbqATR2Nias79s1/B48WRmCxPRgz82V6+80hOKm11f
	 4kl7scxj9OpjcWtfBpkFym8b4tSrblUu2P1HNnEs6Z6DfD+0C+ny2zorkQoN/Uyb9P8TuryNP+J6
	 RLax+CKocvp1CbNGHg3rTvUDJemlicMOVCe6NAqw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: vkoul@kernel.org
Cc: yanzhen@vivo.com,
	u.kleine-koenig@baylibre.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] dmaengine: usb-dmac: Fix PM usage counter imbalance
Date: Sun, 13 Jul 2025 00:51:52 +0800
X-OQ-MSGID: <20250712165152.1883037-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync will increment pm usage counter
even it failed. Forgetting to putting operation will
result in reference leak here. We fix it by replacing
it with pm_runtime_resume_and_get to keep usage counter
balanced.

Fixes: 0c1c8ff32fa2 ("dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/dma/sh/usb-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 7e2b6c97fa2f..6ced61c9feed 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -393,7 +393,7 @@ static int usb_dmac_alloc_chan_resources(struct dma_chan *chan)
 		uchan->descs_allocated++;
 	}
 
-	return pm_runtime_get_sync(chan->device->dev);
+	return pm_runtime_resume_and_get(chan->device->dev);
 }
 
 static void usb_dmac_free_chan_resources(struct dma_chan *chan)
-- 
2.39.5


