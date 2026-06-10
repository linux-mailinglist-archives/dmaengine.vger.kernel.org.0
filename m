Return-Path: <dmaengine+bounces-11392-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dBfHFwILKWr+PAMAu9opvQ
	(envelope-from <dmaengine+bounces-11392-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 08:58:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50EE6666D8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 08:58:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="FRCMr/oS";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11392-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11392-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B397303429A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7638331C;
	Wed, 10 Jun 2026 06:58:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB1383313
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 06:58:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074683; cv=none; b=H3RRe9Bbk/cTVy1FagBoVghmRmuo3/1uZO4Tf3lrEDZ4JRtgPKGUD64+AgpG1tIxxPCicYvqdTZzhJRjCFrnQCgN0kZK8zqtoHEzNF22j+65txvNu9YoWCfPm2av0iK9wJj6kCHFIWN1PFAlWSNHlHvZHb206KBF0awEK28FGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074683; c=relaxed/simple;
	bh=PFSOUWErGrM0gyP5DWUOL09xlM7SxLQPjCGI+uexi2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdKBYz6LK5uUKhC3no9MM2ckWZl0ET2Hax15xPyp64tqhX1KvyQ1g/9G81/zFXjSavC/rbC1HrTfOIuN0W0YDrK3Epv+cFGPRUjRhKJyVuPlgKqGbkDkw32ZOHUMY0DDADZ71n5BTrb19vFz/gPlA9uKG96xQ9atZUQEpJ9+pPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRCMr/oS; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so3812030a91.1
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781074680; x=1781679480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQGlGPeEYvzRxu/p0mp37wOG4b2KqwAVkIGl7gSwHWg=;
        b=FRCMr/oScs6ZPS3Vg2DFmBqL0HlP9XPvyhTe2IT1wP0qIhfZC4jbnHRWqTkYB13KFh
         xnpKIJ6tvbwAcMjQuy2Sw+tat1l7SfdM/1VjHhn9lOeQ0m8xVMIjT6PsYJYo8tUAbjlR
         ML3ZK4TLP9ynskUv7pIKnBTbzxjAnhiCA6jyYhC2eN/X6ARhqbWwomcuYuwliFLymdXC
         HzERkQJ8WIZwfg9eUOrakbhebgwBa3K46+/sAyXkD+YFv/MbHVe3NikBEwA1kloiskzn
         NmyyMt8KJB2bseRS0s0UziEtmOYGdJvOBdgrMohcum/yU71Wlq4bJpvdU+YOOz3qywNq
         lqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074680; x=1781679480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQGlGPeEYvzRxu/p0mp37wOG4b2KqwAVkIGl7gSwHWg=;
        b=idrKXonmdoDPckSVGHKTDA4xi+BWDTOGlnW1JVgPHspT/CrY82LvOwU1nVihsWK43A
         D3aKN/38pDzWmjSLzITflUKEUbYCp8s2XgVcgCboQW+cumv1e9EQ5hYVbqQrBijqWOrf
         jUMgiU9cULVzUjrUWOXAebg3ADzbnCWSIUFVEE6AMXeWEiZjCpEzPlRA0NiIaNctJssn
         i16qXm6WTmQYyrR3oSEXIhWgEO1YeWyFmoL2gWs15ofBEIFCV5+twm8TCtdQ9OAcmKXL
         gF6L6FDTaJ9THh1V6KHRV4u7snRNgjF/OShCxj/UOCnThRaT2CbtltJ3o50TkZfZ6kgL
         wORQ==
X-Gm-Message-State: AOJu0YzBi9/7DU3mylKhzITzL9oeeJJ2AaJp87FH70hkXXAe0snZjWBF
	AaNXZdUnU1LiFw2TP6UI49JlCpNTyx9OE1B4KfnysTmyhA2I7G70AYcFWFOePQVs
X-Gm-Gg: Acq92OF8v+SPTLFqjZMf1e4fChBcZz5EPhJdGp5X0Ter0Y/km41mXzLHl90cTH7I78+
	21rM7d5dzozM5j6MqmUSSeF9NzYxZoKtbW7BDZPjgmlaMM8DR0ZjEFt02xBc2dHvl0zerLPcSG9
	CCod1M7v0325cwCLjK6CFscVFU0cgpTQ2JXgBzVZ3Bo2I1EglE8xMa/NE/A0gklZ9MT2YpoSHJf
	RONzAjr4grJS3olTHpsruqLhe0Woxn1HlDsndHFTalqfqUBEsVJijoZRjMkYWjEWyFPy39jalct
	gc7sB5IZAWpmhyvPxhcARHYy3Jv47dZH36rukKNLDtsLIilHmA8R9V8H17cvQGPEQzAePpXnmuu
	XklNwvITVansEDF86NQ2Rx5AFMyVe0/1T5AG0r/Kr9bqud4eSXNPPXr/8+Yh/EoY6bCIbxft7hG
	FigQmnL1lkhjF/BJCSSB3h65ocP3XeRSKb9g2ZB9NFVLgvr/cFQYwo92DTkkJdfHk31boWsDAVv
	2sNtyYp1IGwbIlJsCvlY243MQYkxT8tZfHWA6Qj0+Mzig==
X-Received: by 2002:a17:90b:1fc3:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-370f0c521b9mr28534032a91.23.1781074679793;
        Tue, 09 Jun 2026 23:57:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm20064781a91.4.2026.06.09.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:57:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] dma: mv_xor: use devm for dma pool and irq
Date: Tue,  9 Jun 2026 23:57:37 -0700
Message-ID: <20260610065737.118211-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610065737.118211-1-rosenp@gmail.com>
References: <20260610065737.118211-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11392-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C50EE6666D8

Replace dma_alloc_wc with dmam_alloc_attrs and request_irq
with devm_request_irq. This eliminates the need for
manual cleanup of the dma pool and irq in both the channel
remove function and the channel add error labels, removing
the err_free_irq and err_free_dma labels entirely.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3fc39cca7cbd..2ac7f01155fe 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1013,8 +1013,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_wc(dev, MV_XOR_POOL_SIZE,
-			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	dma_unmap_single(dev, mv_chan->dummy_src_addr,
 			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mv_chan->dummy_dst_addr,
@@ -1025,8 +1023,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
-	free_irq(mv_chan->irq, mv_chan);
-
 	return 0;
 }
 
@@ -1077,8 +1073,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
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
@@ -1112,10 +1108,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
-	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq, mv_xor_interrupt_handler,
 			  0, dev_name(&pdev->dev), mv_chan);
 	if (ret)
-		goto err_free_dma;
+		goto err_unmap_dst;
 
 	mv_chan_unmask_interrupts(mv_chan);
 
@@ -1138,14 +1134,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
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
@@ -1156,15 +1152,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
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


