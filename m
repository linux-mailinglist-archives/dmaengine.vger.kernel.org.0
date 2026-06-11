Return-Path: <dmaengine+bounces-11476-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rrn7DfAjK2rF3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11476-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809696755FC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ORgnfMGD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11476-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11476-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AEDF31CAECD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC437CD45;
	Thu, 11 Jun 2026 21:07:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72B37D11A
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212064; cv=none; b=K0pGgZlqIkCLDp41A2MovCeXlwQ24ka1PnZYds0dDiXN8ARe52d1YI+zWfEeH1BL259o/L4xKMrhGZ5VLsxUCAqVqg1+l+u4NFvFLA1q+ke9lSKqPCNXB3646BRc9vt0WO8vdDEwyhanxLdANn/AhylrarFwXiO7nR/NCp/50v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212064; c=relaxed/simple;
	bh=dvghOKohcwH9SQXQhzetTaGzQZyJKhQFENn2jnpf5Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI4YHG3GctjGOHPB7Ry5sbKt09HphcGHPnnJR5r1yEjCVdjIqhvvyD3fy1TMZY9YRD1qW73R2MOclEuGtP0rGEA9Pl7ZuM/sL7RmSHQn+kaZtoHQsHxQyJXyAcp4irJShT98mjb14pjPmMyIqjc7KOiKeLr69NZcIjrhAvy98w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORgnfMGD; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2a68d01so2224075ad.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212062; x=1781816862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSrH0lq4ZkY0zoCN4rUUp0rFDR/1U//2WaeJaO1SWbc=;
        b=ORgnfMGDBROhpComVbgnIuAaw+kqU4cElcuFcbehPWUk/sel/5FmbyPBubN+zD2fkY
         c9t/U/qsJX5taZ+OqdU9Rvsa6vDlqWc+65w8JqnUsPmr5KVY6f0JVlfyG7RsnA0aDpMa
         KaxpJpqQZCC5GLSZbXkOQ7DbT6jjNnu06MRaBRYLaz6r2Id8tZ1ASTY8q3y9Yah82rk5
         67NZB7w4hZPqIOxuLPQ0/hk4zIplYT7J3VYFxKCPNcA4K4bm0cLBvf02S70bH2/sLeep
         LvFqwgbngUoLDOUlDWKetAt3mo9nfbPnLjCX8F3eQ53pXMD8FbapoLV0PUiDOjBFy8NR
         Sf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212062; x=1781816862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSrH0lq4ZkY0zoCN4rUUp0rFDR/1U//2WaeJaO1SWbc=;
        b=cCstp2eeD3/E3tOWiWLDjx9ZJHo/G6z7yW95kl7lvPDIhUguN7NPMgKMmBM8nZiqzM
         M82qBpzn1Jq3PaLoITzeMjyiLdSLh78PIWvg3ksyu+SXYiOt4KGCvt2702OsQ2PQngaU
         cCvuxzJTWBAq1KuSAqdwLRt/h7OVoBjrx/k5sqG1vgGEOK00trkefsVaTKMg4lz5yCie
         3ipPNdZSJAYtf6jkRQmbKypezOtKtLQmVVGsmuL60lxyZn5nGU/KZduQcPIUe7tdVSlp
         vqOD9miBUApOyJOg54ubKf2RwnjNiamx1v8X94urDQn1f+TW8GpmyncxPa3yd3vZ/Jsx
         wabQ==
X-Gm-Message-State: AOJu0YyuX4qJZzRa8AUBer1QXudSDPNMHAoYEJEv4wDouKPE3GKAfdoM
	Y0APktxaUjeVdwCjblHKgYvptv7p9AbwSMVcHxVV+xzBvDFCc+K6qvriETWC3A==
X-Gm-Gg: Acq92OFORM+lIy1UfKvg/g/98epuqvjyuPUM4py/ScU/BQIzezIVnlCVcQlGtIb+GOm
	DCAEGo1piuqJqqcBJO6T81bXPybFaR2UbQthlZA1ghsKQfx4RfnxZ7pSfdavOVSUwehbkHvkDez
	DiCLFN6etxLeexIvffbbXnOE+IlFxnFWZ7MEV23HlRa6rXOOL1Q0bVynHR2x38KGbxSwpVnvH8G
	Y/pJ5tJP/OTFlwLGLwF3m+KNEmDzyQzHQNCyGvIaInvz4xwgYkxNAn3qctTi0TKPybpbjfbQ81v
	clQqn13iDDswj1pQ83zBp0RvJ+i1mgh7G+b1TkocJ+whZQIHHvwsAdxhO6hatHxpmvjFN/Uqq6Z
	XWYu/gUyfVe5fk+1Bq4xLiaGT10eZDRIo3iXN5KsveMOrufzT/j65+qhyE4kbn75gUZ1HGO4+65
	c+SgR+SmI++IItI4c7VDpZVpWXCuAfcI+kNMVV4Ac0qQzaSE3gX9bcxYuylIzYs4YkkAZ5dbM7M
	v1Plc3ML3SK+vqoQSdkzau5Nr5vCeLLY2g=
X-Received: by 2002:a17:903:3bc5:b0:2b4:6080:d4d0 with SMTP id d9443c01a7336-2c41188b6f9mr1128075ad.22.1781212062393;
        Thu, 11 Jun 2026 14:07:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/9] dmaengine: mv_xor: fix use-after-free in probe error path
Date: Thu, 11 Jun 2026 14:07:14 -0700
Message-ID: <20260611210721.81979-3-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11476-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 809696755FC

mv_xor_channel_remove() does not call tasklet_kill() to cancel
mv_chan->irq_tasklet.  In the probe error path (err_channel_add) the
channel structure is devm-allocated, so it is freed automatically when
the probe function returns.  If an interrupt fires and schedules the
tasklet during teardown, it can execute after devres has freed mv_chan,
resulting in a use-after-free.

Fix this by masking hardware interrupts on the channel and then calling
tasklet_kill() at the start of mv_xor_channel_remove(), ensuring no
new interrupts can schedule the tasklet and any already-running
instance has completed before the rest of the channel is torn down.

Assisted-by: opencode:big-pickle
Fixes: a6b4a9d2c106 ("dma: mv_xor: split initialization/cleanup of XOR channels")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 93a8e9f7c529..ef29e8be1db6 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -106,6 +106,14 @@ static void mv_chan_set_next_descriptor(struct mv_xor_chan *chan,
 	writel_relaxed(next_desc_addr, XOR_NEXT_DESC(chan));
 }
 
+static void mv_chan_mask_interrupts(struct mv_xor_chan *chan)
+{
+	u32 val = readl_relaxed(XOR_INTR_MASK(chan));
+
+	val &= ~(XOR_INTR_MASK_VALUE << (chan->idx * 16));
+	writel_relaxed(val, XOR_INTR_MASK(chan));
+}
+
 static void mv_chan_unmask_interrupts(struct mv_xor_chan *chan)
 {
 	u32 val = readl_relaxed(XOR_INTR_MASK(chan));
@@ -1011,6 +1019,9 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 	struct dma_chan *chan, *_chan;
 	struct device *dev = mv_chan->dmadev.dev;
 
+	mv_chan_mask_interrupts(mv_chan);
+	tasklet_kill(&mv_chan->irq_tasklet);
+
 	dma_async_device_unregister(&mv_chan->dmadev);
 
 	dma_free_wc(dev, MV_XOR_POOL_SIZE,
-- 
2.54.0


