Return-Path: <dmaengine+bounces-8659-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULlVAAM+gGkd5QIAu9opvQ
	(envelope-from <dmaengine+bounces-8659-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B3C870F
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 07:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFCA13001013
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765512F28EA;
	Mon,  2 Feb 2026 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKU7T6d7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C82F28F6
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012158; cv=none; b=NaKPgrHyzsdQ45ekD+OTFfrEWnb2MvaEhJQyRhmYGfziEWKlEd4DqX7zBfde//InIZc9/kbw6TlT36tT5t7ilZAQnK7BPXJ6I3mkjN0VdvmDmsC7xjgqza+AYSKxMWyhd8jisx0nx24z9jdSagA8P9igvqHJwiulT9tRDx6JfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012158; c=relaxed/simple;
	bh=AIZS6XquM3KKQ8mi4ZynCct+A3jH5Hynpx/Q4V5V/jI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwtXdD5H8eoiDOUPnlfx8wsF22diXRDKn0klvpgLeoqW7gL8MsDFDRJHNTqQaZkFtcnt4BZFiZzRCBKhcXlJcsa4fEgdw4WYHInaolIbqq5yaqKyfizRPolZSE52M/lygta+XhrcQrIWaTIBSeleWoAvPLTM3ber3+kxiIAD7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKU7T6d7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3163105a91.2
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 22:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012156; x=1770616956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggf2OvTgnHedycWgHUYuocKKN0MUpXmXtMRSz135Nzw=;
        b=QKU7T6d7MqgeWraHC6A7ZGSspA/sgbRxSV5WnRDooKXl7TMPGrEkGB3jx0DaoMekM/
         1+VAwEvysEJPe4U+aW8pohB3VjCmjpahD2QhfFv+9QT4zeEyKaeMH0Rxy+VYHLmiECOl
         buq8p3r2PaI3Ehy3pZVuz4vJ75wNA86qU+w5hYFvB/SP/CnD/4my5eVvqUesIOib9XOV
         1LI2xQnZb033SAWoKl49VifoDJf006HXXQDEUCx1e9hsn8gxUlWz7T6e5AZ7UfqjE4GX
         +QmtDQlf+FXx/m/JOkB9DB2+EPcr/U+4PrWiB60rZb+VFmaf+P6kGNNjeliySlBAZcAi
         YvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012156; x=1770616956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ggf2OvTgnHedycWgHUYuocKKN0MUpXmXtMRSz135Nzw=;
        b=t4eEr5WLQCENCMHIWpQcjwJVFswB027VTzvH0gQHfEmbwZaj0imFKJNtOl38llCjiv
         T9j6+H/NpTauWoqgA6af83k4hxpCwkXWOB1Y39qV1kO+ViY9j91+GPi3JL/pEwFImJlE
         vjcGyDOpGVAgoGjx6fmnyvHwo+zB9WcZ/FdNe+zgO/MKVm1zdPbKSVJBuoU2glD5jHX3
         ezGK5DM0zSP2GB8jfrJyvqRPGndAktnGB+sgCjYbQ8qH19gNjgZHDmKvp3qjwZt3phZd
         s1X2Nm96xv3eEcHImOsw6n7aTigHt/TQjHYHcEPSPKi7pUzCGbaHssOjvEfkBdhvDVEq
         fWSw==
X-Forwarded-Encrypted: i=1; AJvYcCV8si5T43mEZS/AdCiuLLDhb7OSYv71R/FTJ+AWa2NmzSMwS33F/wgZs07kKZAGiNthd6nZ2kmg1/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8z9XAKw9+03KYd02ch/0Fx+Mtooj5GE6YSpgaXcQOkg17GBJ
	hIRr2fhX+W2tq6ZjHuOCPht7O9nRQGS6WMwytbKk+bDH6ti5oE1QVJSE
X-Gm-Gg: AZuq6aJRWaQnC+D/EtTOdhngbcq9JoBYQiDwcJEf/VzQYPstLbDsLjBdHRu217yS2Zd
	eZv0UYjcUfy6s9fyPz0ic03EXOsY1/ZixOzT2MXmy8rSvNbEEc2WS2ehmOaiVbsYV2KfquS+deG
	Q60nD/xMpjRiQZN6Hocx5V0F8RWAZdA6x6cL5IH8ifbfB0YN4LeJi6YmFWHAxF3ISyLhnhVbiBX
	cItKaTSb2tlAHf9HsoU+m+GyabjLWxED4rre1AIYcaS2pn96DQLgO4bt/SBRgYRUmpubU62PzdN
	N0SxyqmtTEZqxIkg0+JGH0DyUaSRgcILQN9ecnuz+62JxewcJOupbdo7x8L/ocvgnX0zpGbSSG2
	1l2NHsgtRsFuqckm8lpllq1y0HEJykClpekCa6G6muUgfMQFWMMiJNkE9p/nd8XUYbMKhAOxtQj
	YReaEtAT6YiPiNoIYoON1kkKGJ68xDYB4Z9+49Z4qYeF3AaQ==
X-Received: by 2002:a17:90b:3bc6:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-3543b2e0022mr10257933a91.2.1770012156586;
        Sun, 01 Feb 2026 22:02:36 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm14212294a91.0.2026.02.01.22.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:02:36 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 3/3] dmaengine: dw-axi-dmac: Remove unnecessary return statement from void function
Date: Mon,  2 Feb 2026 14:02:19 +0800
Message-ID: <20260202060224.12616-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202060224.12616-1-karom.9560@gmail.com>
References: <20260202060224.12616-1-karom.9560@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8659-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: D24B3C870F
X-Rspamd-Action: no action

checkpatch.pl --strict reports a WARNING in dw-axi-dmac-platform.c:

  WARNING: void function return statements are not generally useful
  FILE: drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

According to Linux kernel coding style [Documentation/process/
coding-style.rst], explicit "return;" statements at the end of void
functions are redundant and should be omitted. The function will
automatically return upon reaching the closing brace, so the extra
statement adds unnecessary clutter without functional benefit.

This patch removes the superfluous "return;" statement in
dw_axi_dma_set_hw_channel() to comply with kernel coding standards and
eliminate the checkpatch warning.

Fixes: 32286e279385 ("dmaengine: dw-axi-dmac: Remove free slot check algorithm in dw_axi_dma_set_hw_channel")
Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
v6 -> v7:
    - Make slightly adjustment to the commit title to reflect exactly to
      what the patch is address.
    - Refine the details in the patch summary.
    - Move the commit that the patch try to fix to Fixes.

Reference to v6:
https://lore.kernel.org/all/20260201000500.11882-4-karom.9560@gmail.com/
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


