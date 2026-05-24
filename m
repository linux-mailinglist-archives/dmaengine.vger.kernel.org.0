Return-Path: <dmaengine+bounces-10777-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FUcJdJlEmoJzAYAu9opvQ
	(envelope-from <dmaengine+bounces-10777-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 04:43:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D875C1250
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 04:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7E1B30041CA
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A97260D;
	Sun, 24 May 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXuhCOT7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16210238171
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590607; cv=none; b=YbJO+nhWbsWHABskrfMGeEgYCRNZwX9YthYldKMdk5N1tpNkHG3hZCzB4uih4G21bhzrCVM+c8fs4hQ1+hsequ/yL/rAg60kpOa/8BxshJyXHRL186Vr/W9zpY0cs6sqeBgFNRlWlV/JNp62jI11IF0MOD+VnMDSzhYKO3qJlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590607; c=relaxed/simple;
	bh=eOAhUb4StqW0LTJELpjCzMzIP8Xi+emvII4kiJKsSYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDGlnNFX7uN6tDadSCaGS0MlR3N+9uqZ+O06q06EJYZzhG52faCgyVQUMYogYqKyWgK140c0ywlahF52J3uEuZu4lt3GYHJJjIuMnGM1EBXlqnAjSsf6ufQkksvo6533B7eEt8DfWQ8m4Qtld5es4RuXZDgXzpDD03i90mYIwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXuhCOT7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so4327280b3a.3
        for <dmaengine@vger.kernel.org>; Sat, 23 May 2026 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590605; x=1780195405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYPU5BRO43oVkm1oDn9VG3+6AXXKThoy75aC+MplqHo=;
        b=PXuhCOT7a49l7RdXoX/NvX/JdrKnnQrwSs9ZlIrx9UkvC//IiTEE6W+0nbklgtKGiH
         qZbJpwR1ElZ1e7jUAUQmGfQKCxCY4nNhTrL2B+u2E6UaNLPVc1bJHc/rJVtxKsZ6YKWn
         S9pVLVdnKu5HMQeONeqe7dLm5tuFgQWfljZ4h+dCtR4k97sSFGVg3zJ/6IWSW6cTDheb
         sRvL1+4UsUg0y3Vv2KN9CIvcZ5molmLgN6qsex6n3srgpMCFNVwpei/VyhXvGLYtguJj
         GLCwEmS14TcRt1q8TzK6t/bIZIWvUUOKOrYaBeFd3hG/tGbHFBhStPHFkfI0XjBOFUvx
         jKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590605; x=1780195405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYPU5BRO43oVkm1oDn9VG3+6AXXKThoy75aC+MplqHo=;
        b=AplLW5lrHTzuzn7r+rA9gKLhmS5nVRS7+V7OwLymN/pudMpUeo9xR1lAjYwGlfqbRg
         h4WFM0wV7okwjDGwne6XrrjAwWq4auDpn7QQoAEpjh2RsA5jezJnSAvZ+RiVvuI7EPZp
         0dg+8LwT4et2TWd357io48BN8CtX7WmdvyEclWSdhRWamdi5eaDJv1XswZII2GRkG0AB
         dU5SEIdy1+B7quuE/7EaV4CgBWgZOuoRTF2wgH5u+aU/XQSrUXgIjHiJt0LLE93ddJiL
         Mn6PwFp0Jqb79vE3Rz2jDVOJnu+KURnx8AF3zP0EvcuOzl/SJK59ltf1B3q7V58XehbV
         y+zQ==
X-Gm-Message-State: AOJu0YwVbtIwU7+EyO08Fhsdn/q0XkddtmQqVmpNSK8Y1to2xTsbv+Uk
	ZqsE+YmADBAf4ANVKnQ98aa9pYGxnPDsnuYCleethKxWJndIkWyPSfy5sn5hBw==
X-Gm-Gg: Acq92OEVyGVPVXUjVToRkOFw/dUtOxaoMQoa23uxHtuRo8HqpbEauds5WNj0vPitLWV
	nITRGeW4LMGKvEBpvu8wdXhvXIVfCvEX+HlIB/qi/RGuXxyfifiBNmqVZZnH57hKfmUAR1HebWU
	/SAm2zB50S8EsgJh9nZkMEjkjyrUM6Lxapk4ZuGmJY6dL611G73us2DbbLl2rIfWmO0eX3WcbNk
	wJ5/7RdIQyO0xFuvMsbwjLElOtEa4QdrjXgXXH0MEKTshj3YOE9R4vEiR7h4jBC+j45hbtaFeLX
	BS7V8jPWZ0ISArlexTQ9nqxva+xXWoI/dIKIJL2/ntLZGrPAuKpuaSCoR8/e0DkH/W1GgobhTr0
	EGpiSwXVtvrW9owlxVIZzjPsi7WBziut+fwXHAqp+7+kvIaAARC8ru2VrcNxhr3cM3yJq7jqhyH
	9BDKEWhNN2uB9pE9MFmVKHun92oA7f1VtnRQmDIRu87hKWgySz6jFL0NoGcpfJE49QAgZ/9xW2K
	BibAwiRAJtxaU597HnXuk9JVMnuEk3oApDiybZSXUwKzw==
X-Received: by 2002:a05:6a00:2ea7:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-8415f32318emr8923998b3a.13.1779590605102;
        Sat, 23 May 2026 19:43:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff7d80sm6418984b3a.56.2026.05.23.19.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:43:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linusw@kernel.org,
	Frank Li <Frank.Li@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] dmaengine: bestcomm: ata: drop unused inc local
Date: Sat, 23 May 2026 19:43:07 -0700
Message-ID: <20260524024307.181634-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10777-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 52D875C1250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bcom_ata_init() declared and assigned a struct bcom_ata_inc *inc that
was never read, tripping clang -Wunused-but-set-variable:

  drivers/dma/bestcomm/ata.c:58:23: error: variable 'inc' set but not
  used [-Werror,-Wunused-but-set-variable]
     58 |         struct bcom_ata_inc *inc;
        |                              ^

Drop the declaration and the bcom_task_inc() call that fed it.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/ata.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/bestcomm/ata.c b/drivers/dma/bestcomm/ata.c
index 502a45d76adc..40126f3f189e 100644
--- a/drivers/dma/bestcomm/ata.c
+++ b/drivers/dma/bestcomm/ata.c
@@ -55,7 +55,6 @@ bcom_ata_init(int queue_len, int maxbufsize)
 {
 	struct bcom_task *tsk;
 	struct bcom_ata_var *var;
-	struct bcom_ata_inc *inc;

 	/* Prefetch breaks ATA DMA.  Turn it off for ATA DMA */
 	bcom_disable_prefetch();
@@ -69,7 +68,6 @@ bcom_ata_init(int queue_len, int maxbufsize)
 	bcom_ata_reset_bd(tsk);

 	var = (struct bcom_ata_var *) bcom_task_var(tsk->tasknum);
-	inc = (struct bcom_ata_inc *) bcom_task_inc(tsk->tasknum);

 	if (bcom_load_image(tsk->tasknum, bcom_ata_task)) {
 		bcom_task_free(tsk);
--
2.54.0


