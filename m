Return-Path: <dmaengine+bounces-11365-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MjTRMIqSKGqrGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11365-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:24:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46F6648C5
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:24:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=owsqGYc5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11365-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11365-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E2D3116B61
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53F3AB5DA;
	Tue,  9 Jun 2026 22:20:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE4480DEC
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:20:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043603; cv=none; b=V9MA7LiiyDzAqWODuu50wqwI0WLYaxSOE3lwVPAWsPzMcCNWbOEvqHvcKpgg2o9Gm6RBoIBFBHsetBSELsfcc+iXEZRW58PoKgGzbITo7qHK8FqXHKf3jaHjFwr96mrjpGV64O2cwFb/+q7T4yAuWQR5Zhr2mC1N8niM8u9XRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043603; c=relaxed/simple;
	bh=lAp8VELf1WIzDtTXvES1MckgNe5J8JcBQCSWSAEzxUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H++xiJHKArYdOfLaHuo6Jvk3gKX4dPS0WifQVRL7OHG0xDWtBwQKHp1hTtIGuJ4rWrFeF+VCz5JHiRWlLLW9jJ2pQeXZ1OwbYR+aOxaUvQ+wHd9+HhqAeBThQgNnf7Rq5G6qzhjxxfrngl9R+8IIONWNGdtUDLDjyH4tETHoMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owsqGYc5; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8629bed4e7so2117085a12.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043601; x=1781648401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txLeeHxUVUSX7wi9aUsbTgq6v6+yCgWQ3OKqqrJje5Y=;
        b=owsqGYc5F8l34VtY9R4ahiOF9KjV+lmV5S4ES9aqC6NcaemRsK3stk6WLfBsptNCL5
         DIZGW/TV+p2zlcvTQ+uQCiVTjJ93PrZOHKLRdQ03T/RsHCILpEaRhCCRQ1fprgz1PTYF
         39L0MrhRHaePtQvDZQpCQ0fWknNDJQjwzWBIebL/2PW/cGH6yPC15+kjrH6lS9FvBQqg
         mQjC8Y84dF5D/wOntevosTnOFEmbd1TWGIGpbSbcLJ9O9vbQ9V3Ue2BxLBouT7ReQ+F5
         TaHWb5p1CcR0AmjkUhGRiugR816AjLL2cYl6ZgxD5wLoFeq4tkCBaKum5fPxlIiKHeZV
         GRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043601; x=1781648401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txLeeHxUVUSX7wi9aUsbTgq6v6+yCgWQ3OKqqrJje5Y=;
        b=LNtYZdtpdQtdhyOEvydiPwJmzqMKOcp2E9vDOTQAuvQ5XUJ96MV6I62zBZCpD5WMVF
         v7l9P4fn2N6kQ9S4IrdWmfwA6HDQGvOahBtR5l/JD/LP3VmRXtvlOgjdEl7uf0hxNIGv
         ClsGqMsXD79fycUaN0AN31eV4pxfRM2/EoGinvOAYYS6hboRTmqle95reFy8ZWVJYaGU
         XqNqbXO5PxuI0Z45inB8Qzj45Ny+ILzcGpGNNlurKSjrN7hgrR6WB/Uo3qL+h7RYygqw
         zFwsiIiolmEMw1aizL+3CXwIhLvNcdLU5v+BO18qKJKhayFMWX1doQt9uZSeoTq5TzpR
         qRIg==
X-Gm-Message-State: AOJu0YxLKMOwxRuI++IkIOZXf8Tajvo3ldo0m3YVkMyRLQA2whvObBN+
	hQfV1ape26CY9z+Km+oP4RpijX8BlhSnjJuq9VA2iQiG/okzShnXXu52gfo35kgM
X-Gm-Gg: Acq92OF5faAfX2pXyRwCH6imlIiq5ZZJigRi8uZxP4mBDgnOxZaJ3EoWtRoo2jKkhfq
	+hXI7W/ZW1UoBfoJWeyMmEx3Q9xRBbMSasnB7iKgQBmqn/hY4N7bo+QxRScGp6JtqmCCUY2i8ic
	OVPV9TPJ359iuxegS0iuQZGX2Q8pCS7yQiNpe6i/hGxudPGcdCmJPk6TEIUfJKPU+87252b63zj
	gFip0tWQlitx4sf0aj1cZs3zG3Pw3ocNaMZRFx+ldjSyCFcg1xWMQkWPDs3Djg++dDBWR9ohUeD
	l2E6eiw2LcIpVOCyRT0Q7kZKrzOpQvSGdTr0lZrX6P6Im3/ht+/o9B69YxTHORlZrZ/xrtbIPx9
	hqGzGmPKcmnPUK0hwBzcn0xwvUJyyFM689D6jt1osC4Co9271tJc++pS346OG02YszP6VtZ9J1E
	amNbMAvwf+sqjgOJVxqadLHqTgY8d0OSRfu86tKHJ/52WiZXA4PwjTntREdjvNrBTHxeUGS6IIc
	qGUZQb33VaR8LoJrSUMFYUl7Cq7htKBLpp3jmlv2GOkpg==
X-Received: by 2002:a05:6a21:4c16:b0:3b4:8ad2:5ea8 with SMTP id adf61e73a8af0-3b4ccf81eebmr27631680637.30.1781043600819;
        Tue, 09 Jun 2026 15:20:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:00 -0700 (PDT)
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
Subject: [PATCHv3 08/15] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Tue,  9 Jun 2026 15:19:19 -0700
Message-ID: <20260609221926.35538-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11365-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F46F6648C5

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional -- when
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
index c04a7fbd2ed0..eba194d64105 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1213,7 +1213,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	spin_unlock_bh(&chan->desc_lock);
 
 	tasklet_kill(&chan->tasklet);
-	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
 	kfree(chan);
@@ -1248,7 +1247,14 @@ static int fsldma_of_probe(struct platform_device *op)
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
@@ -1317,7 +1323,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1353,7 +1359,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


