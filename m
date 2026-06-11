Return-Path: <dmaengine+bounces-11481-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3EmCkgkK2rT3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11481-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:10:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E3675628
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RaWG+YRm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11481-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11481-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04F43395E61
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C93812F4;
	Thu, 11 Jun 2026 21:07:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8D37DE8A
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212072; cv=none; b=k5SnIKD34RXa5Bx/qNSxqFT7bbibAbQoD23EMTdOmsNLJRksk40FXdFRukxTAFFS2vvn1OhEU0ekumuQkvL80GRPpNj5ccMt4jJLjKZSJBu4Hlu2Avt+Z2tUWU1DOweZ9xmsJqfn6gMw1/kNnpDVEgEyK4kijjxCr9ssVFTlwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212072; c=relaxed/simple;
	bh=X3GHHzQiXolVBZGJOotQLn6GzW+Ej2xce3P1rijrIvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps5VOaDKg9NU3LAOb1/nm4IX4629ckNNW28s+Ddew4MoVMy3YhQ/Yw0oZbQ0EBuPwz2rPXZQIgHyTwsJyRBrgHCEGYo6y1/4yA+YdABMfiPGK0gV9lZV+uKjzIz9mnLBRhf6ttkL4DJswa8X11EJTHaWzOykmZxHd01KNnf89nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaWG+YRm; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3315c5dso3052185ad.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212069; x=1781816869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys5UJ/WwrYe3TB8RrDwao+Tj7L5Jf+C0k9gyBQvDgjs=;
        b=RaWG+YRmnij9nEMpUnp0uM32jinxFHzzDnGMHZHEM//1IXtoXnEab/+uxRq/d0Y/oc
         stuKEZmJXz9VC+CC0HBnZVDcDgdpy9pkmXlg/CXk6MrEuwvTtydIDFvFIf07DBTILmgI
         Q/IuW4yMWH2o2QeKThWI4urRn2wWDRSfJcCbWPzaVI0R0atXLGfOJlX6LIM7SoNnk+n8
         YI4vMZTh+twGd6QkEeTaIDD1ZsjeG+ivKNkSbROIxykiahApSgpFDi6FNGF+UStz6IAD
         yktUJMU37i5Es/QBATmuB0vilzRmyfbUwlkr0xqCQ0/fnAd58Wltd9b6acIspzXRUZjH
         cmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212069; x=1781816869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ys5UJ/WwrYe3TB8RrDwao+Tj7L5Jf+C0k9gyBQvDgjs=;
        b=iz/P2KDi281USwW+dYw7bXizP7ZNb3KJi5hgUbZ+SSXtg0IlrPtIvdnX2BsUtmt6Xx
         OzaoNN9/6ySZxe7eetCQtrb+4USQSoU7r4wLU5jqpJ00W/3Trf4mUI5AUW8f5Y9KSr+b
         bdRhZaeNcO7JcCZe7w2xy8vpa64qYyosQrmO9Rk8UEbCjlGWFQC4uTJYPWF/JSHHQLJb
         Z2cKdfYOkoMi/61givtAtxhsUK6hhrGj3HAXZVdDspSyyZekpUphtlCiAX8P4O2G+fhQ
         BqmHctseDWCcp9wnkBygtY0aksrsgBtTOBBKedpNKYcGPjn1TAl/gVaRIig4TnPPu94U
         mIsg==
X-Gm-Message-State: AOJu0YwSGD0Ia89s2dfnuwMsXvEFsPn9Htf8Pi3SjD3aCJe9l9ZQeYCI
	ZtnUwFqL59FkuslVfyBBy/DxTFjWxCOLuSfwzAydbdMOp1vuYErzbca2qV333w==
X-Gm-Gg: Acq92OE3CxW2oOii5FxWL9Al4oWst7aJQFnGK29YvjT7DxjOh4pWXJenERoJu/M2Izi
	Ph1etZXBuKiUVr0YZcRgmkAs4LJ5pKYS7p35bMgK/OIsFLESRmjqKzJUcZ25ESpC7xD5dlI3HEU
	7Hv3AUGEI1kMyP2YY9f5sik6guCPjiV4CjuRMtsZDQHC/SUMw2+LVIFWHwsozGjnvM9lRRJppmx
	HsrsqCLMOnb7C1CbrOVr7GhcVz69y+0RFxVpc3Rcghrmj2FVcxh5UROtG/svWaRfuV/atZrtlR0
	ZrzBwTklU66u2oPg+tFGrJvG++F0HAnbHAObLzK1lIOvcqu2fmWbRBLVl2DTzbeuucl3Mx5gB1b
	l7SSkZLeTNzjuyvplQ/fWgfMEuctc6ftPsK12OVNhuig1rBUSpQxoADRrEQhtbZ5qrUryWwqnN5
	EOxLY+RgcT1/nRFSO5qbPBmN/C3T3Di6Zhg50f5bQvCRnUxBxIDESEFub7d3NfYTBq/7uQy+3KJ
	jqbKI/epAjPjqhufZ4hr4ytqOh5BUY53Xg=
X-Received: by 2002:a17:903:1aef:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c412653828mr920385ad.31.1781212069157;
        Thu, 11 Jun 2026 14:07:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 7/9] dmaengine: mv_xor: use devm for dma pool and irq
Date: Thu, 11 Jun 2026 14:07:19 -0700
Message-ID: <20260611210721.81979-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611210721.81979-1-rosenp@gmail.com>
References: <20260611210721.81979-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11481-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A07E3675628

Replace dma_alloc_wc() with dmam_alloc_attrs() and request_irq() with
devm_request_irq(). This eliminates the need for manual cleanup of the dma
pool and irq in both the channel remove function and the channel add
error labels, removing the err_free_irq and err_free_dma labels entirely.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index eefc8f22bec6..0c159b9e9216 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1037,8 +1037,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_wc(dev, MV_XOR_POOL_SIZE,
-			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	dma_unmap_single(dev, mv_chan->dummy_src_addr,
 			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mv_chan->dummy_dst_addr,
@@ -1049,8 +1047,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
-	free_irq(mv_chan->irq, mv_chan);
-
 	return 0;
 }
 
@@ -1113,8 +1109,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 * requires that we explicitly flush the writes
 	 */
 	mv_chan->dma_desc_pool_virt =
-	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
-		       GFP_KERNEL);
+	  dmam_alloc_attrs(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
+			   GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
 	if (!mv_chan->dma_desc_pool_virt) {
 		ret = -ENOMEM;
 		goto err_unmap_dst;
@@ -1144,10 +1140,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
-	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq, mv_xor_interrupt_handler,
 			  0, dev_name(&pdev->dev), mv_chan);
 	if (ret)
-		goto err_free_dma;
+		goto err_unmap_dst;
 
 	mv_chan_unmask_interrupts(mv_chan);
 
@@ -1162,14 +1158,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		ret = mv_chan_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_unmap_dst;
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		ret = mv_chan_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_unmap_dst;
 	}
 
 	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
@@ -1180,15 +1176,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_unmap_dst;
 
 	return mv_chan;
 
-err_free_irq:
-	free_irq(mv_chan->irq, mv_chan);
-err_free_dma:
-	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
-			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 err_unmap_dst:
 	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
 			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
-- 
2.54.0


