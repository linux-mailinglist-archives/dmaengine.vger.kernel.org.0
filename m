Return-Path: <dmaengine+bounces-11205-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7vbNMRHI2ogngEAu9opvQ
	(envelope-from <dmaengine+bounces-11205-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804164B87B
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="snMMM9y/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11205-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11205-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC23D30425F8
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401723DFC8F;
	Fri,  5 Jun 2026 22:02:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52C3DD510
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696930; cv=none; b=a5IUL6JTZFho8iqPG23NzwurKcnVoc/57ufv+TopRm6cc7s2cZY9YxIkhgYTuDiyEgr08NT14FGUcCAGyW5+vLjCMKLQGMAGj/s325y8BhnHApV92yWgLnJLriXnTCK6D7idPu6TR0GtnY5RfJ1psUjG11Na3IPyCcdAKXe4msA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696930; c=relaxed/simple;
	bh=ZIbZrZAamM8DHdzetSAyNZ32dsZlWnuLa36YcV5UTMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeM2r7LpqbUGmTsY3oojX+6X40SOVoQpx/E0In7eOz4dPd1kkM64+/ptry/EoH2fAS+fVQIEYLAcdAwWMA7PjUHsZ0eWiqvLpf5Z6SWtA+hFh0EQt8JjxM4kA+6/0KC8wN3QnaLhJeOI4nl2lgX8LNyE69E6cqz2fYx11oSqSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snMMM9y/; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1631338b3a.0
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696928; x=1781301728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsujHfWeeEl/d7h28VlfSKrBHdpgYMwwQ54lzvrhDbE=;
        b=snMMM9y/tSQF3pOusN9Q61pLwqfZQgS2FSGQ4KqLpjk0VaR0IHPBfp2vpdEIC/v8ze
         kvl9ajCYCHzJeTRg9+W0GttU9jm6IDRwR80aBfJBlMSC+9n45g3NhBj+kMOyXL1ZUbin
         Xx7jfJGApCzeEjtVkilCmMAtOgXYcUKa4LVTJAJ6B03qEoCBU4Od4vowGt6iEmhVjXy+
         Oh+g+BXfJs9xVMYmw94XFhj7k222mltJm92RHc+9/J9jgHFIw3IurYe7wCMZy8yRxyRW
         d++AhMSSRtfifh/zF+aKHUdfhoj43zjAWsxGLUSUUv78SNFXBvBNrs/fPncD38lhXQLz
         G5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696928; x=1781301728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsujHfWeeEl/d7h28VlfSKrBHdpgYMwwQ54lzvrhDbE=;
        b=peXZ5KGnPs6/buTBR1DLEGICItAXH7KKle/mx9BJ80eG17WsPvkBNbB2A4ctaQEr3L
         /qFdQFLXriwc7x7NBWNhhfYS2XPAPiL/B4DMxCaSEQOdgGEFf2kf4EZkz7MLsuydg3uJ
         6fztrDAjBEn5fF89e/EapnCbTjvqLziOm3BDhlQD1sGDGsu6+EHd5bFsKkGDXwZ+Pffq
         8GQVFYnSBz13F68dJYu36C2GIKpdAg6m/TYAGRyZkoKS9e7anaEhTLfAYMSkFFi5YE1O
         lrrKrlH/G91KjfqE/0D5vKafiu5FTlFxQcBWLUrJM9w4mIxUmWlbYs138jK+w1EiZrY2
         M2ig==
X-Gm-Message-State: AOJu0Yxcp/3LDItYSidJkVbbyiQ4SrP7SjhHQQIwFFfGHEynI7V4GxHV
	Sv87JKne/Nec54dzh8sYZh0vFChpKOjOExtk6qEeA9HWMjz93Pth90td+BRBjw==
X-Gm-Gg: Acq92OFfvwutgc/nBVlU/ovqPTAh4/aXADxRFfd+ZUlWb8PZGCDXsWxy0mejMeGMRHH
	XIjEERhD4l7nHXCcoTJ+4qpCGHoVCjQoKhPMmnQ+eTqP+6DTv2kGtB7/Z85qrlirew5Mw0TpqrU
	nMjTh8AM+AqANX39aL/VWwARF8Bgvmsqizrz1j8iv50q8Cw3v1BT62gLuY7IHBKCMMyLFLKviUr
	hEBBp96boi0j532cOA38Szqmh0qn8hPs+xhlIhMcJZACWcoAI/sE4meL5qlViiwP7oy2Bgwo939
	BDIogtdGutqCR57dYHX3q+iWEgAkXTa1WzGMqbGUn0yhVDt9kU3zRj8k+JBm7JndnHd1/px40gI
	De8xIRdVMr0G0wemcEIa+9wzXH28zXNE5XFHVmve+wu7EZ3gMZwfyqSW+GOPu5uAfDF9p3maeWX
	HkRZZgb6zZ0Ysgny+nJA9f/8VW5OY4IvztOZlG2moBhDYz9KcC29bwu5rKMpvuHZfgCKUlt/m3H
	30J2s/LGxllXcqam0Q96+MdYFg8XrNkx52HGmolrR0UsQ==
X-Received: by 2002:a05:6a00:a13:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-842b0e3da19mr5756498b3a.32.1780696928113;
        Fri, 05 Jun 2026 15:02:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH 09/10] dmaengine: fsldma: convert to devm_request_irq
Date: Fri,  5 Jun 2026 15:01:33 -0700
Message-ID: <20260605220134.43295-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11205-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7804164B87B

Replace request_irq/free_irq with devm_request_irq, tying IRQ
lifetimes to the parent DMA device. This removes fsldma_free_irqs()
entirely, eliminates the out_unwind error unwind label, and drops
the explicit free_irq call from fsldma_of_remove.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 50 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 79a268139b9f..01c9cd27e795 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1027,26 +1027,6 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
 
-static void fsldma_free_irqs(struct fsldma_device *fdev)
-{
-	struct fsldma_chan *chan;
-	int i;
-
-	if (fdev->irq) {
-		dev_dbg(fdev->dev, "free per-controller IRQ\n");
-		free_irq(fdev->irq, fdev);
-		return;
-	}
-
-	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		chan = fdev->chan[i];
-		if (chan && chan->irq) {
-			chan_dbg(chan, "free per-channel IRQ\n");
-			free_irq(chan->irq, chan);
-		}
-	}
-}
-
 static int fsldma_request_irqs(struct fsldma_device *fdev)
 {
 	struct fsldma_chan *chan;
@@ -1056,9 +1036,8 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	/* if we have a per-controller IRQ, use that */
 	if (fdev->irq) {
 		dev_dbg(fdev->dev, "request per-controller IRQ\n");
-		ret = request_irq(fdev->irq, fsldma_ctrl_irq, IRQF_SHARED,
-				  "fsldma-controller", fdev);
-		return ret;
+		return devm_request_irq(fdev->dev, fdev->irq, fsldma_ctrl_irq,
+				       IRQF_SHARED, "fsldma-controller", fdev);
 	}
 
 	/* no per-controller IRQ, use the per-channel IRQs */
@@ -1069,34 +1048,19 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 
 		if (chan->irq <= 0) {
 			chan_err(chan, "interrupts property missing in device tree\n");
-			ret = -ENODEV;
-			goto out_unwind;
+			return -ENODEV;
 		}
 
 		chan_dbg(chan, "request per-channel IRQ\n");
-		ret = request_irq(chan->irq, fsldma_chan_irq, IRQF_SHARED,
-				  "fsldma-chan", chan);
+		ret = devm_request_irq(fdev->dev, chan->irq, fsldma_chan_irq,
+				       IRQF_SHARED, "fsldma-chan", chan);
 		if (ret) {
 			chan_err(chan, "unable to request per-channel IRQ\n");
-			goto out_unwind;
+			return ret;
 		}
 	}
 
 	return 0;
-
-out_unwind:
-	for (/* none */; i >= 0; i--) {
-		chan = fdev->chan[i];
-		if (!chan)
-			continue;
-
-		if (chan->irq <= 0)
-			continue;
-
-		free_irq(chan->irq, chan);
-	}
-
-	return ret;
 }
 
 /*----------------------------------------------------------------------------*/
@@ -1304,8 +1268,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	fdev = platform_get_drvdata(op);
 	dma_async_device_unregister(&fdev->common);
 
-	fsldma_free_irqs(fdev);
-
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
-- 
2.54.0


