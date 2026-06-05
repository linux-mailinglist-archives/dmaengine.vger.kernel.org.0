Return-Path: <dmaengine+bounces-11199-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id evZ6CrZHI2oJngEAu9opvQ
	(envelope-from <dmaengine+bounces-11199-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF264B863
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cbB9pzGO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11199-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11199-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D767305AD04
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356B3CEB8F;
	Fri,  5 Jun 2026 22:01:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B33D4130
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696919; cv=none; b=ku4xYgk1hHKR4BSk1CuLYt2X78nEAoGboVpEg9RgeiUyS/nOU6IlS7Vf4vQ5amGxrhKkvQg60GZhWStsVHt1rofkk/RhtuzxN5QGG6hbhLXXRLnEacPeNVJNgOwx7cNau4oKIyvAJZPFSMdmbnRUJNQYsiO5spR5DD98ti/6r7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696919; c=relaxed/simple;
	bh=YUwtzio7DjFibcYHK1xR/I3InEukDqXu3lwj6BvlnHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8pqAh7vooRfsRSeMQTGV/usgTpixj3ni08emdmL6OK0TErkoKZfpWzrW8p4uurgOTIIHSlke4iqC064LX1kNfTFeyU9sEEM40VvVCKcvZ5R9jAyJQmeLpBkd2XrPA1yVpyxkd+9X/mwNyNilFDKZ408HbwgJxD9CEGiBXC4mEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbB9pzGO; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1311440b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696918; x=1781301718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFsQX2lLtec69DeOnNMYpEwpbYN8i05xT/hHGIXIjWY=;
        b=cbB9pzGOT/QY4YrdKAIt1lOG1ygioNMHPcSY8P8mYflPJSENNnHztC7GrJayUrw8Sq
         bD52tfhbJ9CuzOx7jZYq88zkiyLNHi8KZB5BudRLta+3sEnvRdfkyx1vwecOA5X2RM9S
         ZNIO0kwbCAD2vI5JPuu1r5tB65bRcLMpt/UdZR2/n8c2fsS1KOnUp04ulbLvNN56qEDo
         PbwQmwLVqZV9gbbm5OdtTxcwyb1jx6Ow953ENC7B4VwtSPtFNXdeh9guFVhFZAiuFXzk
         Y74RZLf+w60NxH3Oyk6mTjs8Bi2XuzuC3S7lEIW9n1zEhrNNUuwtINcVCWB1rL0wE+1+
         Mwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696918; x=1781301718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFsQX2lLtec69DeOnNMYpEwpbYN8i05xT/hHGIXIjWY=;
        b=MhwdUw25mLUQ4atR0BnOyvM2Gn6jdr4RarJwT/zof6tQZ9YfnOMSX7PB57kpEkzLv7
         er9Pww05x/IqrlLUaUn0T8c/NxL3ahtgsNh9niQiv86Cd4SN4+MMNly6ONP5ZSXrQbz2
         p1Dji8s9E8o9JumB2ujWsJeuO7IVRULQGDw+ZO/RMKzhdPEaGzJShAi6JgJxqIOK4kdz
         q9aQD0J56iEcHKs2GZOtj+EyAr0cJolMDb1IVWCf3uQRsmGd3vQdCMU+9SNAVps7sGRD
         5AkSv6zebIvCE4vMEjGomQnoSGbe4qF20oH8r+H6w2G4lWk68M8V0zhQKRkdcZq6NghQ
         gv1g==
X-Gm-Message-State: AOJu0YwH7xMsdWEpW6YHBgf8/fB0EB1uePeceqWDTURq68sC0Vi2IUCC
	/1JSuD54PRJ3f4Vf+ecVTMVo5qWkOQej5YvRZi/7h0w/FxFZarE4WEISZtRNNw==
X-Gm-Gg: Acq92OHULYpyppALx0oJI5531WQXIlODywa4GGo4mT9EMLEYsYNxfW+Z0pragtpOVOB
	f0IjslZVoYhzRxuDsNant5O7bIzQ6C4ZEer+khFbuFG4iWgbhPNW5YDLlowTsvsT/6Dn5c3KY0m
	XnEVtsPfRWlGyMsO8Sw+mqWj947PyQ63tVtRB1QD9KUZ6/f1nKpvdReWVGP6oLhBc3Kk3zOH2HE
	Fuoex5b4P82398gNxT0HDWvvLMB6YySXBUQvQvmiIk10cwqPM9G7sHP7VCYZKYTvwC9of2WMhu5
	vJEEFVf5qzst56so43cx4dW2GL/GKOXLfrMBofDucqGd4HSVtEg1XSzAydLOdV+gRnJEzNfdGM1
	B9RucuZNLYhxeexuhqn7aj5pZvSOZu52T0Vfc8gQRaoEOdvemYsqgcc8kyStB0/IBLRnYhzaGkD
	pc27ic77bPEz9FbWHiP4bMgfQS9twCbsm3/2e/f3UYpKfNcB2Hj+Uay7GXX1R2Sxp0Fx8N1ZKXu
	SaNw15rgEwhpiP15xuA1k6FyC9biLVM8Pn5K92EpUZ0gw==
X-Received: by 2002:a05:6a00:4510:b0:842:8500:95f1 with SMTP id d2e1a72fcca58-842b0fb6d77mr5329246b3a.40.1780696917721;
        Fri, 05 Jun 2026 15:01:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:57 -0700 (PDT)
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
Subject: [PATCH 03/10] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Fri,  5 Jun 2026 15:01:27 -0700
Message-ID: <20260605220134.43295-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-11199-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBDF264B863

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional — when
absent (-ENXIO) the driver falls back to per-channel IRQs. Any other
error is treated as fatal. The corresponding irq_dispose_mapping()
calls in the probe error path and remove function are removed.

The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
device_node rather than the platform device's of_node, so it is not
converted here.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 89b88447be1b..0d28f8299bf8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1206,7 +1206,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
 	tasklet_kill(&chan->tasklet);
-	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
 	kfree(chan);
@@ -1239,7 +1238,14 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = platform_get_irq_optional(op, 0);
+	if (fdev->irq < 0) {
+		if (fdev->irq != -ENXIO) {
+			err = fdev->irq;
+			goto out_iounmap;
+		}
+		fdev->irq = 0;
+	}
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1305,7 +1311,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1327,7 +1333,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


