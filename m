Return-Path: <dmaengine+bounces-11475-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnXQDtMjK2rA3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11475-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:08:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E546755F8
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fiuIf8MI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11475-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11475-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808B73111CCD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD337D10C;
	Thu, 11 Jun 2026 21:07:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285D3749E8
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212062; cv=none; b=eVJ/RB8tSD0Wk92vWpbz+IBv+vjGzizR50fNnt1NxLBVj4/zMdSuT7ZGqa9IdfnzjkIfDHbJ7+/95FrRtuMBtpCf9KK4vEd+PaFFNqVXGdcn7TLxKlkLoFWsJm5rcOGB+Wa0sYyOEpX8rWogyc8iQlVCrvECmk6V5w9w9OlYxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212062; c=relaxed/simple;
	bh=bCAYdfYisLrHd7l2kyeJDRlqTTZUQkqdz5xGrJJbarE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfto1f6/tauFJFWI9R/2rpb6Xfi5vLBRfdnx+b4G8JBCIcihnxZ9zpK8XqB/mbOV+oWaHoSwolY0K+1/my9rc78f3UZTNrtopTzEgK8sAJKm2W2EoBsxjmpcredm8LyER/7wMoGJfbh4rg6VW3svMtUNXu/38dACmlLkFdfnrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiuIf8MI; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso2544085ad.0
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212061; x=1781816861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRxRCTMYY1VAY8405F16m4eD5kL89X6DuJ4nJfgGyfE=;
        b=fiuIf8MIBqS8mEqSpBlcrvai6bbjzkgvLcnEJxADf+JX5APN0+xTp30tjK+yvDeATK
         gL+nCukOpiG7MVNl1GsnWyPziluSQoKAo/ozmKyU1cPPxYmTMy4r/4wiFWsDqYOa0jlF
         c9gU8Gmco3M2Al1XUQ2vXdBouj9px3ra2o70fk78QAbbFU2MVs5DzA1S8xk5n/KplSQ0
         JRnD+h5cHLC7X4e8DKH8fWQMIuRoSNPv/iDhhEQ5Gj2DfPf3FEukyNs3N3Wu0L2ZBBRE
         DlB/QtLahmaBITjsSg5ikMkuXU60P4/GtN02J5eloyavN5SG5mYYiKZlpDEDALViTgJ0
         LRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212061; x=1781816861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wRxRCTMYY1VAY8405F16m4eD5kL89X6DuJ4nJfgGyfE=;
        b=J23wzProXFVuEhNjFiCeZ/sq/1fh/P0fsy75ml8UukNG0ZQID4Gdxo58iZ55NUYdFH
         D/0o28EearCJCw3bn6jXB9p/XlBnXLzPL+g/jYudnmCtR3k9YtT/Kw4vdLH+k0bhrtyt
         g4fwAFLbMVobLhb5SJPP3+hJVBxBXYgzWbJ1QHTM/LtKYP9HRHighUi4HDWKs7v7VolI
         MAhqX5+vureiC4QTEdnDX2dgTayF68GLuS9aE/7wwIT1lw5N+VWX8O3rr2EIG4I8C/su
         ndf59dMi70DI/lgKO+BiaG707BMi53pWdTdQA08VOqOINJted2iL9+K6ZFOb7oQqH8uW
         6bgw==
X-Gm-Message-State: AOJu0YyQlqX+ZIn+aSyE6AYe/1SYqGi9Chwo7Dc/ROY9sMQqBYrM5nzx
	3yk2vtYsiCpYvFVcAj89MkoOISIst6McpG9o0KZcSmxZRdnlBoef2oq46dws1w==
X-Gm-Gg: Acq92OFFJ9z06UX5ydpzemRhjUwTbpOl+BGeLv40ECdhJ5S752gEgbjNA/k0d4cS1ia
	RVMwzBOeCnHuzLlD3Jq9D/ah4HtgzyhZgVeVwjdgIz1v949/sH6yMJ2yKHoPFoEvOGoSDIWQ0Bk
	2hlj4TpZuhMiC3B/D9AiPJ0U0U5j4j4xFZqh9g76DlvzLCF+B2s3UBgAiVN2rGafDvrEiGSTaJU
	sSgCex6jb4TJiUljxsXmMO+pTb6YGdVUn4cdq3UA8akisnvcAwQicKsogHUbUzpXe8hgdnvI0Si
	MLhlX3EqHfKwdA/GadEvtwKaIfhejh8stIrS0Vhzm+hil7B+6nlte9Lwbx230oIZtGgpEp1QwF4
	2VSch5SBSmlgBrot2mPw7rKQV4mbUUPcDjOSMzKMEoFWbadWeucPNoErC3fSU8iPzAeHwpEubG7
	RvTjN+/AL2RJl7A4uTqRajrTIiN8t3Ar81NQhjJj/Q9Cj/D91ZugqCCRm4QVQzeZdSeTRBU6zsM
	gz6fQCDWhnbmt7sUN65ta+FDcX84Ya9gTahuJEFUOn/yw==
X-Received: by 2002:a17:903:acf:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c41206984cmr923285ad.17.1781212061041;
        Thu, 11 Jun 2026 14:07:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/9] dmaengine: mv_xor: initialize chan state before requesting IRQ
Date: Thu, 11 Jun 2026 14:07:13 -0700
Message-ID: <20260611210721.81979-2-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11475-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: A7E546755F8

In mv_xor_channel_add(), the IRQ is requested and unmasked before the
channel's spinlock, descriptor lists, and cookie state are initialized.
If an interrupt fires immediately (e.g. from a shared IRQ or previous
bind/unbind cycle), the handler schedules the tasklet, which then
accesses the uninitialized spinlock and lists in mv_chan_slot_cleanup(),
resulting in undefined behavior.

Fix by moving spin_lock_init(), INIT_LIST_HEAD(), dma_cookie_init(),
and tasklet_setup() to immediately follow the basic struct field
initialization, before any DMA mappings or IRQ registration.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 25ed61f1b089..93a8e9f7c529 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1054,6 +1054,18 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->dev = &pdev->dev;
 	mv_chan->xordev = xordev;
 
+	spin_lock_init(&mv_chan->lock);
+	INIT_LIST_HEAD(&mv_chan->chain);
+	INIT_LIST_HEAD(&mv_chan->completed_slots);
+	INIT_LIST_HEAD(&mv_chan->free_slots);
+	INIT_LIST_HEAD(&mv_chan->allocated_slots);
+	mv_chan->dmachan.device = dma_dev;
+	dma_cookie_init(&mv_chan->dmachan);
+
+	mv_chan->mmr_base = xordev->xor_base;
+	mv_chan->mmr_high_base = xordev->xor_high_base;
+	tasklet_setup(&mv_chan->irq_tasklet, mv_xor_tasklet);
+
 	/*
 	 * These source and destination dummy buffers are used to implement
 	 * a DMA_INTERRUPT operation as a minimum-sized XOR operation.
@@ -1105,10 +1117,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		dma_dev->device_prep_dma_xor = mv_xor_prep_dma_xor;
 	}
 
-	mv_chan->mmr_base = xordev->xor_base;
-	mv_chan->mmr_high_base = xordev->xor_high_base;
-	tasklet_setup(&mv_chan->irq_tasklet, mv_xor_tasklet);
-
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
@@ -1124,14 +1132,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	else
 		mv_chan_set_mode(mv_chan, XOR_OPERATION_MODE_XOR);
 
-	spin_lock_init(&mv_chan->lock);
-	INIT_LIST_HEAD(&mv_chan->chain);
-	INIT_LIST_HEAD(&mv_chan->completed_slots);
-	INIT_LIST_HEAD(&mv_chan->free_slots);
-	INIT_LIST_HEAD(&mv_chan->allocated_slots);
-	mv_chan->dmachan.device = dma_dev;
-	dma_cookie_init(&mv_chan->dmachan);
-
 	list_add_tail(&mv_chan->dmachan.device_node, &dma_dev->channels);
 
 	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
-- 
2.54.0


