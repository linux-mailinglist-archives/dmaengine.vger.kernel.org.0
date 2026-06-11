Return-Path: <dmaengine+bounces-11414-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o1whGSUxKmpUjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11414-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63B66E099
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gLPCZfKg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11414-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11414-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49F46301E7DE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93833A9D1;
	Thu, 11 Jun 2026 03:53:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB03321B1
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149986; cv=none; b=J8D3vVrW09M4xQ68GYX/gQOtdeAItp27loiVxAGaZl3VUPtrFscs3F/ellzwiILSzLsRIt6xtWD2ZAp2TYnBzXB2Lr2ILtLkrzA7aySzWvJz8LCYswCP5eASzkKPpq0dRaHhsqusynX8P7Xl81T1d9LC6no4wJBU3oVSLnU5/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149986; c=relaxed/simple;
	bh=aPbMoowg2EuPBMdzYXozwY+p7f4ETcRMlcmaGgXeXec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQGmpinqnS9AMesSJh3Yo/2lqsq1dNpKbjJG0icw0SFLO0FenSlPbk8tgv6Eu05fk5LCbaI5yr0be403fzll9ERHYGEB8WyFMammpE8Ez5vxtvHtlMro9dQ/P5Rz+EK9ppSxXiZHEHQ4PLamvhY+AWZP0chxW5/AF3DXJ3ZKviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLPCZfKg; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9d265355so4594455a91.2
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149985; x=1781754785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn+zKrxqRiv/1m18H+iH3XPWY8WSKvkkOnHkQbRgV6Y=;
        b=gLPCZfKgc3MKEghbxJc1PO8S0o/E73aDcDV1GwUGOu+3bdoqOJpXBncuUusdshCJM7
         v9XwIT85XuHFVL6AFYLbf5DzkJ7ZgBIMDkxd7Gz1btHS3s4DPw35ZT7v0Sh/sYvZHeo7
         Rmqw22Fb9Vyd2gyGcynlFFI1ogYWQhHeynMqCdYVE3dgEcj+PDEZtW3KiCK6Z98res7V
         2aoJTtIgl3SvnGXN4z+X0qzTUS8UW2Nx+9JSKnCzqsIy4zWfq1BhuxVSUgLz87m2wnpQ
         SljsN+R0P3a4FF/ceQw41rRTNJKhCfiwHxfMHwJRfYXJAHrkJPPmjJRP63rkfRerUy1J
         unqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149985; x=1781754785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kn+zKrxqRiv/1m18H+iH3XPWY8WSKvkkOnHkQbRgV6Y=;
        b=D/qLko1Ety62c8J4XUfGY7/EBfxNNCZnhEPbJ3V8XpLE9G5lzxOmJHNzu8R291n6L0
         u8u/xqKbqX2Sr2LrFXqOXv1uoU1vbi6PoXcfVtao8a4OOTclQZBbnQP/lzBikhudQCJt
         h/ybjawZcdQCwBCRCOANtlVWC2bpjc9K7/q3uPgeVgqcFX3MxaikycWklwFwPvkOvQu2
         YCunqoyYbUhKiQoBlVMfpyjGhrDs5T4XMi8ljLFrlRq6UC5nrEZKfvTbBkb/yIHXpfx8
         cVl3Nr84yaofONr90RFH4gKhm2SoGiSc/GNj0aI8GNAmFuzmgOAkeMxOMYaxBKFNem/L
         2xhQ==
X-Gm-Message-State: AOJu0YwcPg8J6xlXW7AG8/hwJ2uHUBGIU2TfiLtlTSaUpm6ZtJJsJpPG
	0vhiLwMFMMouKMb3DPYo8Z/kKsYLiixTvcPfjI7J+hQOrYS41mZ+y4Nxzl4j2A==
X-Gm-Gg: Acq92OHibtBi7rEiJN7LZea10tVtnHNILs9bAhU4t6BLR4kF/1SGjT0G1K+RpbtBbry
	tFZNHwrK5LWPR4CpHXTWYhojlVKzS86nulwZjEZ/X2lz9M2Ai+zFwx5bFLWtCY0clbUaNJpxhrt
	6NTXeO6Tg0kgIDq7OWl/yqsQcGpHEJxnFtahVtrNrXogQbCuCipAxyaHLLmaFmkl791XfiiyFkZ
	RyBDtEjIWjpVYNLOeUI4MXakaXSzy4G+EV07ZiaYjw67jOnySCi6Xgt/HqvoS14e13nR0gQQoZB
	Ax4KnrAFRO5RSGT0vGv+uygdhCvHeQAu+jEWR41bEmEXuaLrzvcVGYnn8dWzq97K7zlvSonaz6K
	XZO+qg3zl8Gq5yPEU0SmWBNLPLZa0Mph5VbGExbMTGb//EMDbtF+hP8FdvIZpuurWI2Jc7C8oKS
	+4BrP0bslKu4pRPhJn5n1ibyhBxVY/zwuEM00A2SAGVnc4FrM1+EMwev0fyd8K2IAqJGimb/USh
	qmb6597ekJH/6AQLe3j85iBg30AmXKmUMCmFWtSDlBmng==
X-Received: by 2002:a17:90b:5867:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-3779d2d7c32mr1202152a91.6.1781149985147;
        Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:04 -0700 (PDT)
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
Subject: [PATCHv4 01/15] dmaengine: fsldma: kill tasklet before removing channel
Date: Wed, 10 Jun 2026 20:52:31 -0700
Message-ID: <20260611035245.13439-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11414-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA63B66E099

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..0e2f84862261 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.54.0


