Return-Path: <dmaengine+bounces-8476-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OATtEhp4dWnDFQEAu9opvQ
	(envelope-from <dmaengine+bounces-8476-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:55:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64697F790
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF803032673
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 01:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA01DE8B5;
	Sun, 25 Jan 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THgiepw3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F51ACEDE
	for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769306062; cv=none; b=Q4Cszt2m85d51ng4sGpw6MEzbMx2eMk//FPzkec8nsUgprgHky2Z//L0j9EzKDoTqewnv1Kg5xJJfMPWRNfOybFD6SbKaYQG6rdk/VIYhmFeQoST+y/dOc4REGN5ar+MVuonWg7fknU+OwOllkX+9Yv/3QE5f/9Yx5uCnAk6LVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769306062; c=relaxed/simple;
	bh=J2oPvC8eMWp67ikOTbm8Y+w5I3HNuEiOFsP9rTAr8Js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TugA44NHAWTB5WrcG/un8cmr2EXDbgxYeN50H9dKnnKOmktiYe+bhNn30/ddSqej+NDyBVK4J8rGTAo57Nse/CRZTidZYXGqKfC00/HDTgDzC6u0PJaf8czecHB4Csmpu7Pam97mMU2EJYDLCLhZ9mjUu2BcMLX/eJKASOmvoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THgiepw3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so2433828a91.1
        for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769306060; x=1769910860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAGAp1Qq4UQ5LVcSqIgIlNi4IHdq+nJHFOVDhle83d8=;
        b=THgiepw3xdO6BK0M5hows7gWx57OYUJ3g03Mf0HijSokC1XVhZ7PzUwryekVMUlS2b
         bEyR7rdYfWuRQjOKaT3sGWhPbwKaDZKMoU/6C6cpAAVYm1rrhGoKW9ABlVdIOJESJjbG
         kmwiYBrO1lyM592Kib9/ZC28KAdmI7EuJ0Q59BKXDt2o+et8gjgTqIeAyQH5vU/WBYIF
         A9KbmMhewBC13GkA4pAitA36qSpzBTisGSDkIn4+Ea4DT+oChczWqbXpanlLQJkIlUB+
         ELR/qqO5ecNjJzOFjbMQIxLk6h/5X+cMGKWTE4LU2vPRoyBsrTKyh4znwloPVACLCYC/
         fJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769306060; x=1769910860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JAGAp1Qq4UQ5LVcSqIgIlNi4IHdq+nJHFOVDhle83d8=;
        b=QwYuXzniHEMoVmNI5QOL8qQtOfdv9fcoQiqIMIzKfegxb03+sAcc2UcFYj80cqDKD3
         Ibs3Nq4qhmxTXzDLod7f3C/lAAliLJUXXD8EeOhdekm2Wv9JpJKQSSgckWYMgyYSbTqX
         eMQI1wPZIN9RKBh3S9Yb/PCr/Uueajsn/FLjNF6JuW19MO645vtzppc8ufbTbEnvfG1a
         1eTZsn8kGDetg/VUxNEpW1cEGkhpgGP8CBVbRuwTAKuj2GpvdViRzWWmBTPjbGuQCcM4
         9DIxPEFdWLkWdlt/kpWkkBawoh1gceKQmYGk68UlnoNylcZV5RioR6eUrILIkBDtJ4lC
         6/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUvkWUroZeTgx7EEltc/DEDJ1dUzhXOWIfZPpe8uO9sEwHr7+I9MZRAjDFbJhUej6Qe5btbZVoeGG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26siy5dN8tQ+PS/qwL4KCLfeX6TqQZz2Y3OSu4JfkfpurfbGM
	oyr/fZDIjw8XVFW34PdyMrJ3YIIVmeoaTRxFti2jiXF6LLuc0wytawbLvJ1H+WsK
X-Gm-Gg: AZuq6aLP0K24oHGkyYDhG/xQsXaroMwrB31gcuPWFPgfOSGrWFvJwlFfvN8UvpJBCCd
	3SeeK7DflMSCnYKRrsWOTzka4zNvODVnFtvLINT4bwo0DyotTEcJL44gXLC+ieKxKf0n5g0AdMb
	fENPodNCNKDBbpfpfA3hS/JeivktasVfkzfogZeXm5kU7f4hgaw6IX+HQFxg0jLK650T11qYr6I
	9v1Q/mNj9ybXzruESiJD9rmCclNTYvTVswhgGD2Us9nmMD+//RmvN4Jl/M/3gu/PpeVVn2yHitj
	KlFdti0O2E+4w0P7GIX5UIyxfqg9PeqIxR5iVL1gvWMNF/FxBWzlRlyBJ4LH8Akjjuojm78QdCy
	Q6kdx+ZoSdBByUcodQ66Tw4E/bkH3mzml3UZTl5mtz77pG2S6+WDX6wfYy1R7tZmL4uf+xyQM5J
	tIx5tOn7rxGcKBtDczC8TBXXuN7SHKiCm1s7I=
X-Received: by 2002:a17:90b:4c8b:b0:353:100:2f20 with SMTP id 98e67ed59e1d1-353c40e6493mr340020a91.10.1769306060190;
        Sat, 24 Jan 2026 17:54:20 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536b0300fcsm2689584a91.1.2026.01.24.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 17:54:19 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v4 3/3] dmaengine: dw-axi-dmac: Remove not useful void return function statements
Date: Sun, 25 Jan 2026 09:54:07 +0800
Message-ID: <20260125015407.10544-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125015407.10544-1-karom.9560@gmail.com>
References: <20260125015407.10544-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8476-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E64697F790
X-Rspamd-Action: no action

Remove an unnecessary `return` statement from a
dw_axi_dma_set_hw_channel(). This resolves a coding style issue introduced
by 'commit 32286e279385 ("dmaengine: dw-axi-dmac: Remove free slot check
algorithm in dw_axi_dma_set_hw_channel")' and ensures proper function
semantic.

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e59725376f8e..c124ac6c8df6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -593,8 +593,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-
-	return;
 }
 
 /*
-- 
2.43.0


