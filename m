Return-Path: <dmaengine+bounces-10669-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNjTLCUoD2rGHAYAu9opvQ
	(envelope-from <dmaengine+bounces-10669-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:43:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EB5A88D5
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C06DD333AF40
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC3D3D0B;
	Thu, 21 May 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvJCklfU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800A323417
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374886; cv=none; b=FMu8WsQESEh9nHumtp18EiC3wMg3ppbyJLRk3xgIlNrvaLYhDFblgnS5fAqO8jA/ESBGqoDrDADsPsdH2Y4A6PteojNn83g3Xipy1iJRZXephCoMjM8FY4pZlmMCF+/wpLfqJmnfkkvRhcJumzqIxIHWmRtX+K0e/wI8LeAGl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374886; c=relaxed/simple;
	bh=fbgf4rB9r0KXPx1Oc+/VkrmhBfp5gpn9s2sD43BntBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmKxa2beuvvD+qJiGCAPJGzEZg/cTHyqYjr3KqI+2Jo33k2PXTCTn8pLy7TeCfUgHRJuDq27aLhVpBRaCpG2QEp2EP6uYlEKLgUt7uNsDPe3cc/v9SlEBUEUP4ekjz3Re7WyCLoRBGVPukj46HCypbCQwjwstROb+8AH7yF7aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvJCklfU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36a3aff302aso997695a91.1
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374885; x=1779979685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz2OvYWMh0kl6XvmHG/s79tvFsmkhMkBBeYvzMmnnb4=;
        b=IvJCklfU1mDZXWVqLLRiUgYfm5PmKdEsALpqmJFTw0CiURs65uJ/TsYvOeEM4kZd+p
         SuqL3MFF5GGUFuC/1c9N2CddP5G2mQwoaWbeAJI6fWM1Zb4+qbdSz664afWRUpIDxH/w
         mY4+sKT0RYXnPssj0dYlFB/MWf0zPQ4ygjjXy27plKiwlWi8maR/uKxOsiLUOHLelIH9
         L2sN3zH1aIqGPOxmQyANMSGi59iOHMeL1g0KOgbUC1OXQTEwHjCRKTb8+x1TZY2mJkpR
         0+/iMa1ohPacptgGbFJ4M1lwR4FC/wBM+AU0bkmVgiJcrhUnL8/YrMd9VEnNFlUkhYee
         5lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374885; x=1779979685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nz2OvYWMh0kl6XvmHG/s79tvFsmkhMkBBeYvzMmnnb4=;
        b=pFMAXm2PJ2445/SwR+19VTcSNzOOGBSM7gFUDRNqYDEowU2UocS5ZF0ox7LHt5t9UD
         0RsTqZw/GxTSsmfP2EfFBt612XkpLUOuIA1HktrF28m85kbOic1hUdPXVqR+jBQBksMk
         2RGIFaTbW49iiVhy9MkYr4PEvAs1/Uw/hzhYWRNipvHAS+AJYCsUPiYg9hyg59K28JtJ
         pxsGALhXsd4N2ZF3mgpayuxEvzpejxYMldE+1ochX9hw07DnNOKHcqFA9p4fJ6tMgSdP
         mDiwWQHsJIvVyHn/8lOJUdb4D+/+9+h8Pk4CYu9Sot1SGbxlTQVHgzTf5+F6op703Bfg
         Je/A==
X-Forwarded-Encrypted: i=1; AFNElJ9QGMTPkm0flJ7Fhqs5Dsyn6Or8/U8oJdb6rn7oPojLRJdNGGKDV5R9aTyH3Xi62wLT5b9cdvSxmEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEp6YbJEKL3qkzDcH7vH9Zaj9+XZAofvDSfdYgCOPYSZlDpTRS
	QxR8XYkbazQ7Y5erjv0fDbNUB2bDQR9mopkOn77CkCFi/6T+o2mIuHd8OAAlWg==
X-Gm-Gg: Acq92OH5m1R3DmmTMFtnt4b6JLhJ3iNxJDeTk63oVBFY+JJn11EgAyg6OiXiL9YOMmK
	XkCiP/aE0J6bQDweZOTHMVqSxIc1aUwQEcGGYTuBsV242CumuXKqDRBocI5b4vsCyIRUn4CxKen
	OuZn22CZ0w2e4dHBNZxFbtrdVBm+es928M4hxiHHyoUwIGEseTd8Qnhs8jGHWol2SSHRoCMFs7Y
	3ViAWIcwABQvGB1FMxq0h+xiiKptbHItQy8ZbtzwGlKxmv9MuDqNGYqQvDRBK56kotySNyzGBvF
	vd+8kSfB+J2JREEMkbJbhkNg9+PQ9K3JO3PJBp8ExUV8kmTz3lKZgOBzds4mjbSh2fjgl7FKYmq
	qADJWPH/Gn5LrM+2yoSwS2I2ZBJTJgKwCqg+9QiQBy4bKAUDsPy5wNJR6wooFuj+4syLFMQaxmf
	sIGZukS/EgefLGwJZA5W+zFfqeZmFNLemfcyNtVr2U8LxUWFeSs216T99TpSM=
X-Received: by 2002:a17:90b:5685:b0:368:6ff3:6678 with SMTP id 98e67ed59e1d1-36a4561ca97mr3064735a91.20.1779374884646;
        Thu, 21 May 2026 07:48:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc5643dsm3773472a91.7.2026.05.21.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:48:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: rz-dmac: fix dead empty check in rz_dmac_chan_get_residue()
Date: Thu, 21 May 2026 22:47:55 +0800
Message-Id: <20260521144755.3476353-3-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10669-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D4EB5A88D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rz_dmac_chan_get_residue() reads channel->ld_active with
list_first_entry() and then tests the returned pointer against
NULL. list_first_entry() never returns NULL. On an empty list it
returns container_of(&channel->ld_active, struct rz_dmac_desc,
node), an aliased pointer derived from the list head. The "return
0" shortcut is dead code.

If ld_active is ever empty here, current_desc points at
&channel->ld_active. The subsequent cookie and status processing
then reads bogus values from the head's neighbouring memory.

ld_active can be empty when a residue query races with descriptor
completion on another path. The author intent was clear from the
existing comment on the next-following check, which already
acknowledges that the descriptor "could now be complete". The
empty case is the limit of that race.

Use list_first_entry_or_null() so the empty case returns NULL and
the existing "return 0" path runs.

The same shape has been cleaned up elsewhere, for example in
commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after list_first_entry()"),
commit c708d3fad421 ("crypto: atmel - use list_first_entry_or_null to simplify find_dev"),
and commit 10379171f346 ("ksmbd: use list_first_entry_or_null for opinfo_get_list()").
This site was missed by those cleanups.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 625ff29024de..3dd76615881f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	u32 crla, crtb, i;
 
 	/* Get current processing virtual descriptor */
-	current_desc = list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc = list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
 
-- 
2.34.1


