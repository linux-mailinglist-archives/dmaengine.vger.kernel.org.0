Return-Path: <dmaengine+bounces-10566-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGxbI560DGrClAUAu9opvQ
	(envelope-from <dmaengine+bounces-10566-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 21:06:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13307583FF7
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 21:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25311300B064
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7C39B48E;
	Tue, 19 May 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bet8Qz6m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420703F1ABA
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217491; cv=none; b=RsCCgaDkw/5jNRvv7OhH6mUDm9+j3MjzBC811aTXXTRQQVQ7nvDAQnD1+65ToSGmFY1XrH3MYt6TmL7YuUvr4Gm9pO66+S/Wc7pvfhR11eSgZ0IjZaQmsJqS2qQu/nuoJurkn1pnVQoVQh+k7XTzHJ5oPph+25JryGpi+9OQdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217491; c=relaxed/simple;
	bh=ClGiD7Br2FRvKa7NIj3NIRbaGiCBSYKP0ikEdtKtThA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dE+VmV/duM9AjQM0ETBb6QQHfiIeDG805nV/JcRe3i2utXMo7iM+qoUJd4O1q55bOMfzzPQgugjZHZPEdomBlVb7skgT6m9iG621SmDfQ/BBlvD66WE/Guebp52uECK6AS3Fw4/5CxPh5cxxJ7kyNuZlvcWJMPRjgaLSaaOeEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bet8Qz6m; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1600745a12.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217486; x=1779822286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt4E8/DsuDzGzbJ8IpIkgEnn/bBtXFj50NFYiiBCCoc=;
        b=bet8Qz6mLJZkQhRiQ6ClI5X5+FaACWevEv8HK96i3nHF1yAGmEcw7OlJaSwhIj+DCA
         N64NaZIxluUa2q3k9Q5AnHI6CFbzSmQHstj1JLaViJF5Yc1tR+obQYealfOVxxTLWM4u
         /wfF1MP83Qr7vOo+P1OvYyiv5tj1ozdN+dVdcaHB64cPxwiPqKS/j3Z7hDZnoMXz1RYW
         UzIcBaZ5+jLVjHpKsQWHtqOeXyuk4SvQQP+MxrocRg3tyY3ryVFtwZjh3lf8BiOnoKim
         iGj6vR4UijHyyyNk5lTZjOo3dxFC+P8ftmTRHIOAdofVFISb3Kg44SrM8RG4yUgMzbbr
         54Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217486; x=1779822286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt4E8/DsuDzGzbJ8IpIkgEnn/bBtXFj50NFYiiBCCoc=;
        b=mUv1BCJz6w36STioE2CaLgAKKzIEjPb1fkaXZqxDB0PE9dRTUdTUQ05tM6vTiz3xgN
         m0TpL/aLG+eS8Y+oPtVcjJI3rB4RkIw+MUl4otlGrndcvU8fP0yJ2Vp5q4I25zbN0/dQ
         qVSfbz0/SVV6Jd0H5SrlgxTMvJzXS+6AhXc0FO4Mb+DE4fWxCrXiYFMt3zYzNMmi2hXm
         amxkEdj6jBopHSJEx+vLjdZEFExmx6TK6SRiKocH6iQGobrVmiM09dzKiiIH4n1Mrw9V
         vztLLMy+VEtLu8U2qT4r3sUFjnrSwPOQfYC2/dJ+EFrZXTaL5NYByNWO8OqP2MUjMfca
         6jsg==
X-Gm-Message-State: AOJu0Ywr9bjbifAgmkcXRQgZkXk23gIXNHLyaFvJ/GaO1v1j/dhgh2EE
	WbniLyq7KXhMRGDuYxKmwzuc8BUCcVXzuTGeCT8EpvuKOfd1jYwtJkgE
X-Gm-Gg: Acq92OGr3G9jDuBAJgMsfBf0ZmdUJ2SqOvoo9B1wch3mWXezCMP9wNHMgxjjd+ncE8G
	ZQHbIa5kfx14Ud7LpzrclsrG8GY/+P5kMAIU6b1mWni4xehGdgB4gtestfjEQaHsQ3xtxwglp0W
	Ks+HuqxZDHp/BqTH5ejqker1sPwETsbG8lf+pDHtxO4iL5kIZvepssdRemIQhymvN7gA7pYIxrO
	R5+TE6USiHSOmKC+UrnXojvNDXv6ee8yUuhUHnTMGOZVI6YySHLlsvKsYg4ymQK5T2xZEYpwr6w
	pSCFCDsTvaBJi97RzRuWWvBgbP5+DkiOZ4ptnrJYS+gRdUD6YwHWnkW198XkmlDubA3oulH1CSN
	mEpgc2GYoQyoQnlFjjCE080bgFnIVoeOnj1r5NCKjH2pV5LUFh1g2l9Xaro6JRDQbhOKfIrbT/h
	p00H+PrYg25KGNIaLGerPXy0u48WiBv8iXbr50UXJUyzkiO7lXPUoWbIhZmHM=
X-Received: by 2002:a05:6a20:9153:b0:3a3:171f:6b23 with SMTP id adf61e73a8af0-3b22e14de52mr23831258637.0.1779217486164;
        Tue, 19 May 2026 12:04:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm17317550a12.11.2026.05.19.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:04:45 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: dmaengine: dead empty checks in mpc512x and rz-dmac descriptor pickup?
Date: Wed, 20 May 2026 03:04:42 +0800
Message-Id: <20260519190442.2382986-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10566-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maoyixie.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 13307583FF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

While auditing list_first_entry callsites, I noticed two places in
drivers/dma where the developer wrote a NULL check for an empty
list case but used the unsafe API. The check is dead code. I
would appreciate it if you could take a look and let me know
whether these are worth fixing.

Site 1, drivers/dma/mpc512x_dma.c mpc_dma_prep_slave_sg()
(linux-7.1-rc1, around line 709):

    mdesc = list_first_entry(&mchan->free,
                                    struct mpc_dma_desc, node);
    if (!mdesc) {
            spin_unlock_irqrestore(&mchan->lock, iflags);
            mpc_dma_process_completed(mdma);
            return NULL;
    }

    list_del(&mdesc->node);

list_first_entry() returns container_of(&mchan->free, struct
mpc_dma_desc, node) when the free list is empty, never NULL. The
recovery path (drop lock, scan completed list, return NULL) is
dead code. With an empty free list, the fall through pointer
aliases &mchan->free. The subsequent list_del() then corrupts
the head's next and prev links.

Site 2, drivers/dma/sh/rz-dmac.c rz_dmac_chan_get_residue()
(linux-7.1-rc1, around line 726):

    current_desc = list_first_entry(&channel->ld_active,
                                    struct rz_dmac_desc, node);
    if (!current_desc)
            return 0;

Same shape. ld_active can be empty while a residue query races
with descriptor completion. The `return 0` shortcut never runs,
and current_desc is then dereferenced for status processing.

A candidate fix in both cases is a one liner. Switch the API to
list_first_entry_or_null so the existing NULL guard runs as the
author intended.

Similar dead empty checks after list_first_entry have been
cleaned up in the same shape, for example commit fbb8bc408027
(net: qed: Remove redundant NULL checks after list_first_entry),
commit c708d3fad421 (crypto: atmel: use list_first_entry_or_null
to simplify find_dev) and commit 10379171f346 (ksmbd: use
list_first_entry_or_null for opinfo_get_list). The qed commit
message describes the exact shape we observe here. These two
sites appear to be missed by those cleanups.

If this is intentional or already known for either site, please
disregard. Otherwise I am happy to send a [PATCH] series or to
leave the fix to you.

Thanks,
Maoyi Xie
https://maoyixie.com/

