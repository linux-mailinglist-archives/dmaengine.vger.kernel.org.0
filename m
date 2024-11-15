Return-Path: <dmaengine+bounces-3735-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1F9CD6C9
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 07:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0049D282C6A
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 06:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD313B284;
	Fri, 15 Nov 2024 06:03:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902536C
	for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650629; cv=none; b=szOIWESDjvPy3hOB/Fq/fADs4cZ3tLct8Ipv/kR+XQ1p6w983483IHQpgZJrydauoYgydWZmEU1YFHNbt1YDwyv2+EwRyN5lOmDclo07GmNuNm4DnbOtPS5dgi2FZ2NxPlMTV2M5kEMogFJfOgRPl630q5i+46W18VbjXYE/ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650629; c=relaxed/simple;
	bh=nUXT5rjcA6mbhj1k5Zjfp3REO8k3bVge/BAYHVuW4A0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tk5ASwLC4CtajfHY2ugc4lAw0f80QSxT6Bm1aRPLWRVUfkUC3v2r6kfJ/E0Fq7SfVOR+iwj+n+5IySqhWj6pQNTQgFVMaARSNJqXL8MMyI8iYvwFgkaHsIwPpRu+I+CjHlNcBAaRRYY/64bgaZESyW0nOn2d2kaOYXG/OkjhEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id LHS00139;
        Fri, 15 Nov 2024 14:03:39 +0800
Received: from localhost.localdomain (10.94.16.210) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 15 Nov 2024 14:03:38 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Add NULL check in udma_probe
Date: Fri, 15 Nov 2024 14:03:36 +0800
Message-ID: <20241115060336.3610-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20241115140339a3167ff424cff679143b38816dd06824
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value udma_probe() is not checked.
Add NULL check in udma_probe(), to handle kernel NULL
pointer dereference error.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b3f27b3f9209..e940753a8ab1 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5566,6 +5566,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
+		if (!uc->name)
+			return -ENOMEM;
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-- 
2.31.1


