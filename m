Return-Path: <dmaengine+bounces-10023-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNxUOh5h4WnbsgAAu9opvQ
	(envelope-from <dmaengine+bounces-10023-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2026 00:22:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE441537C
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2026 00:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC11C3015E29
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2026 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB9374E6F;
	Thu, 16 Apr 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+UTotIs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC952D1931
	for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378003; cv=none; b=idq3bdibRPVwLeNIMEfhGPjSbEQfaGY0i6yDFp61SNjFtc8/Cqlxx469gHR5oYdLd/vtSEnUZJVuMdn/X5krFOpGTTBcyxcYauBaffGeXoaHT/BH46LXyYBbrCV3aBfcEcJFeqYrF6Sln+8c4ollQ4piKapqPUTlYtbqFWOjGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378003; c=relaxed/simple;
	bh=g04gVYoYQ5qLQ0HXn+BkXJNgKoX3hhS4uYX1Ju698og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cf3Uic6IoAgj6+cwvdvwWqbbU6kdDwTJi3qyF+mcZeyoD2AnjN05so72lO+UfSJPvwA5IP2yyXSW3FK2A5fKFSZtk0dux+FhpH2/8SCmmXRKxIsyakufH7qdtNTJm6q49V03l0y5iTrmT5JRV5wGMQzgyp3QtxlHYhYKFkXIsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+UTotIs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a032383008so220696d6.1
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2026 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776378001; x=1776982801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqLnb5CKsaCaiuJFzjJfnkJy5snz88dDy+uDsxyQCTM=;
        b=g+UTotIsjWXzYJ90lz7eEu+fvwTnH64XP0k5FE3QSiZOcp2O9SjhwalY4ngwOqbaqL
         05fG2NcHQ/MvIMgU7rtnovvz2uCj1TE0LyqkNmNDm9oavC34kF+NLVwwQKaZm06gUt/o
         Yn7ry1bZnw7y1+ZF+uxMsykfqGDj8NcRCm0pGVrcPj8cmp9YKiskBgTb8nvT2tXWKtX9
         xp86iformhEAO0ljfutfjzKcE5/umDUhqWQbTdLy/3SJ6VXpkrch4JsTqf2fCK1UZR9R
         YacjKdo8ugTPl54upxL/N+G3yS54rTR8Mn7RkwMZs3zROyvskVCIQLklAdglvPn8f36D
         kjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776378001; x=1776982801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqLnb5CKsaCaiuJFzjJfnkJy5snz88dDy+uDsxyQCTM=;
        b=j0ftPm8Mgn1Bdmp8WH+EZoJ64y2t3p421ZatgElzxJX7g8eOZK4W8/F1iU0isfXyPI
         5DswRX9CpKMeRBkiAKJQbZbWMtnffAoepG8OMZTf+4ufUemkBesIsaCrJpq3H8GwVHBS
         InxoMiGGmnp23v0BnIZMQLkdqjyT5FmdUmvXh7oq++UhescV78lWuS6JgrNe9F9TM3jT
         tJ4xNEZboUBYzOOYZIqqzSVxEqnZqThuNnpIkKntkCBK+STXhF6wfccaVH/s5zKZXAZe
         oMh4gjGRfIahlljjRSxiI4594B1lXlThAjzAemBvoq0F/zt9BKnZmfRP+GAxLqiRuhEj
         EJ+w==
X-Forwarded-Encrypted: i=1; AFNElJ8c4RS/w2whs4iIx6pwbQr2ROt2YS6Pr0suwSzp/BXK8i+ECQfPvFY7iU82VD9OQKi1BxDwKvW2qy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9G/h1i3bMeRYYe8a7+kIVwbhQanmoXTAAlpH5gxa8y1ElNr/
	Sohowy+E9BKdJCNHTIDKk+Rm4zf7POXDT2mXmdvgndUEP9MnRjOdxpFj
X-Gm-Gg: AeBDieuiCh7p8w9m34ZSDowc1CXbUehFMBBSWE5saypiu8s0yLhdNBJm6BgFT/9c78U
	2Yp0nE3EUsqOCxuWMG9HQxjC8hDInhQPqVN2wyw9QxuWSsA8Xj80q8CscWumBiW89DMw+fPonn+
	B/oa64l10dmkxImz5QNFXd5d3oreUvMQ3HJzBwRdmTM0z3wAc0HvaPOYdMom4/tZO9ft667pzeo
	txIkdU7XUpuvxl37rdTgFimEzDi652OOnLcbIcWa/33e0zp9Dxz8MuTupdw4zhoBMWKP7ZZIyHo
	EpuoD/3Tl205fYilm5JL065ZQFBEnTHVDRyV4khIv1K8FweqDUa1j5rBdUciXS/vnNEBb1xzdj7
	rYznflPFVOKSdyR0VMvtAXLB5vO2DoyNV+UWvHxT2ezANrXmxe6dw7CxT48MuWqRB9CZSutniWo
	SRB4pHO+hXLC0uGHmPckFh1HiFTJwz+V19dolrBBvVKKP/qJ6zgdX3WrdfERKP
X-Received: by 2002:a05:6214:2587:b0:8ac:ab13:8f0a with SMTP id 6a1803df08f44-8b02804d2afmr7367476d6.11.1776378000666;
        Thu, 16 Apr 2026 15:20:00 -0700 (PDT)
Received: from localhost.localdomain ([104.39.116.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9ee20sm46224366d6.26.2026.04.16.15.19.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 15:19:59 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] dmaengine: idxd: fix deadlock and double free in idxd_cdev_open()
Date: Thu, 16 Apr 2026 18:19:57 -0400
Message-ID: <20260416221957.51250-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10023-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DDE441537C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
call put_device(fdev) while still holding wq->wq_lock. This triggers
idxd_file_dev_release() synchronously, which calls
mutex_lock(&wq->wq_lock) — deadlocking on the same mutex.

Additionally, the original code fell through from failed_dev_add and
failed_dev_name to the failed: label, which called kfree(ctx) a second
time after idxd_file_dev_release() had already freed it. The subsequent
idxd_xa_pasid_remove(ctx) then uses the freed pointer.

Fix both issues by releasing wq_lock before put_device(fdev) and
returning immediately, so the release callback acquires the lock without
contention and no further cleanup is attempted on the freed context.

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/dma/idxd/cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0366c7cf35020..19a449333782b 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -307,7 +307,9 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 failed_dev_add:
 failed_dev_name:
+	mutex_unlock(&wq->wq_lock);
 	put_device(fdev);
+	return rc;
 failed_ida:
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
-- 
2.50.1 (Apple Git-155)


