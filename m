Return-Path: <dmaengine+bounces-10668-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEd6DyUoD2rGHAYAu9opvQ
	(envelope-from <dmaengine+bounces-10668-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:43:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE35A88CF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 475BB307D788
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3A319601;
	Thu, 21 May 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcdbmhcp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EF2F7EF3
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374885; cv=none; b=Rorb2SbijWncdWTAt73m65eVvuRR207eYuJb8RCjYGSNR8NLRdPzYKhUzOveGTW4xXviUrP0NqmB94H2HPD5K/1faiHbmRtlJSJXWjx8fzBsWr3D1JMfH8xhmVPXt/GoxNvPtW75GoOLWHP9dg3p7QZo9jY0lJUN9imLT0icQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374885; c=relaxed/simple;
	bh=EX9iuFe2HivKCwOTaxCINsh3UzE2ULn9Ke1iwK2Idbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9ePkJJ2COcml0BnqwF9Lgrb99od0iTqoAUDdBq1P54L4j9vq3nLbp6lOJWX24B0L6pgKfJj8cdh2pXKjBpNtLGNOWMi5nm6clV1yT5bQwEeSndbrweciXgjSnIGEzolgsbNmeizbWEMM5WVy8r/n3MkjxsSbzjnnqK57HT97Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcdbmhcp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36a35e4eefeso992046a91.1
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374882; x=1779979682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mtwRPah/bLATx6RFt0C3QCf1Zldq1D4z7+HKhDsfT0=;
        b=BcdbmhcpIg3BmHtFuL7hjmv3fUftzTae5zUPCgAjfG7w50/w9iAjCu/lBYzHSyS4r2
         Vo285i6VJox1jj2g5ISCHMDFCNgUBCl4EMRZvdAFQEzmBigDGFNdtHePLP77YNRCOh3C
         PI0kSc50VYIHnRYpdWkfKaYZzgRal2I6SH6WrR9YE6pAoxLg71dYYvTFZkRNo/1VHtZm
         oqLednpGUpGL/E/2yxJUDkM8eydNVenVl3zv3+7W5QEH9UwcO1hKOndIHbKxQPQnDIPg
         fTCSEiRK4b85wFgjWhEZ+pK6xBQswzwG8Yv2K6Gp532LGAQTv/ioTx9MOAklyvT43wem
         3S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374882; x=1779979682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mtwRPah/bLATx6RFt0C3QCf1Zldq1D4z7+HKhDsfT0=;
        b=aIWL7wVrxnGQGFBG2yW5iU6YdlVA5elUdVgstcEv35YC8PvPz/6lZmC330SmP2wEW/
         jdgArTyrK/Bud4uHuCdLP1QzlBfzqQGfpWghQWpM7ZHIWnl5DJM40hOzTtaYl09oIJD4
         IrVH1uV3WzPN1NzPeIFnYBi+XGaSiDt6QuT2QpqfARXCRfh9q6VKwKzjYjBFilZpG0Lz
         ai+RzS1NONcg0kIxqvB3CxnEqLDpolz9IxdYjb/3F/dt9V7FVOCbwTTvzPjGicxa0RJm
         +xfgvx7TEproJySEspvI7Yl9ruM0nIF41J8EwA+V2LU03wjZ3XF0eor3lgBxN097mPyN
         9Peg==
X-Forwarded-Encrypted: i=1; AFNElJ/mUWraXWbwjvIC0UnAZ0BulZY0sjXDfq12sLdt06Cf34/6YCjnmnwqoQOjr+sQ7aoyjFXUhDTpgz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuFEVsfXZpnLOF3lY764PZEa05smR0v5zr9z0RWC2eZcVwcId
	mrZI2ff42pVe3ZTfL3Lg1x7ErkWRwu9qX0r602DryRSiEJa5emOepky/ty8kVA==
X-Gm-Gg: Acq92OFLwzcPQSGJhYZIhIvz07JQI2VFvlhm10FbL5Q9HVRnVwaXvGbtHsoyS+zCezD
	6ufRYPMLCPlggb1Oz9ztikl/2KBp3Tf3HE5hT7K9HRVD61c/hl9IINTpX+JpTjtDPV9cOQ8huxi
	dyIi6pYjcD6GXatYhgKg/x5jRqUSmdFiKkiXyf9VKGd7SG8tbQJSp+K/Wwe2Ya5Ayy9Bi0tfMeP
	VS+HWQVPpbVJxQMHvFO7ZqgsuhOBIe16p4C2jnronJsm6X44/yIsf7ukf+ujBwJ1x0eSHXetpEI
	ADsKqpzVT5Qz2akzXQ6dcGqGG2uFZ+wedkPr1UXU/mRWmo4RcPD+X6uhKL/NjMFgsOsaZHQh1qn
	KxsRQYbDrT7ZHfoOrn0+tWkTDsPH/1l26xRChkHn3J6DiqELIeAfPue74zvIgSjaPjRISt5U+hf
	6zzVGkJMhDiWjxJsXpdPXe45PRa6U5mtQY8JlbbWyY3THnt8GE8n/l4a+J/9Y=
X-Received: by 2002:a17:90b:2f8d:b0:36a:31c2:d402 with SMTP id 98e67ed59e1d1-36a451592edmr3478966a91.10.1779374882162;
        Thu, 21 May 2026 07:48:02 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc5643dsm3773472a91.7.2026.05.21.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:48:01 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: mpc512x: fix dead empty check in mpc_dma_prep_slave_sg()
Date: Thu, 21 May 2026 22:47:54 +0800
Message-Id: <20260521144755.3476353-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521144755.3476353-1-maoyixie.tju@gmail.com>
References: <20260521144755.3476353-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10668-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EACE35A88CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpc_dma_prep_slave_sg() reads mchan->free with list_first_entry()
and then tests the returned pointer against NULL. list_first_entry()
never returns NULL. On an empty free list it returns
container_of(&mchan->free, struct mpc_dma_desc, node), an aliased
pointer derived from the list head. The recovery path (drop lock,
scan completed list, return NULL) is dead code.

If the free list is ever empty here, the aliased mdesc points at
&mchan->free. The list_del(&mdesc->node) that follows then runs on
the head itself, corrupting mchan->free.next and mchan->free.prev.

The free list is reachable empty when the descriptor pool is
exhausted. The author intent was clear from the recovery path:
release the lock, scan the completed list to free descriptors, and
return NULL so the caller can retry.

Use list_first_entry_or_null() so the empty case returns NULL and
the existing recovery path runs as intended.

The same shape has been cleaned up elsewhere, for example in
commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after list_first_entry()"),
commit c708d3fad421 ("crypto: atmel - use list_first_entry_or_null to simplify find_dev"),
and commit 10379171f346 ("ksmbd: use list_first_entry_or_null for opinfo_get_list()").
This site was missed by those cleanups.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/dma/mpc512x_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 0adc8e01057e..f5934136efc4 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -706,8 +706,8 @@ mpc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	for_each_sg(sgl, sg, sg_len, i) {
 		spin_lock_irqsave(&mchan->lock, iflags);
 
-		mdesc = list_first_entry(&mchan->free,
-						struct mpc_dma_desc, node);
+		mdesc = list_first_entry_or_null(&mchan->free,
+						 struct mpc_dma_desc, node);
 		if (!mdesc) {
 			spin_unlock_irqrestore(&mchan->lock, iflags);
 			/* Try to free completed descriptors */
-- 
2.34.1


