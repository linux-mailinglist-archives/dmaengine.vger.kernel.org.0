Return-Path: <dmaengine+bounces-8642-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDhkLv+YfmltbQIAu9opvQ
	(envelope-from <dmaengine+bounces-8642-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:06:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20919C471D
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D95304CA62
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21B3EBF27;
	Sun,  1 Feb 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAgGc0TQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239F1B7F4
	for <dmaengine@vger.kernel.org>; Sun,  1 Feb 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904315; cv=none; b=hzuEAXWrxMeCq268td7ARAQ+o+T4zBHeEqb7nXi/ENA4uALWyvCj3cF++FYl0DETq4qX+nbREMtNkA9J2OloPmuD4N5gsPMmX4msI3kIdLTZX12O9fmpqFBDFSrEHgBTGq8fbRiFawbRZtWXn5hvUQs8cUZss1efTMEL4i3bDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904315; c=relaxed/simple;
	bh=Wmn1OS77B5Utn+OGRggASQf9Z4+YHyscRlfU5OrsMPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2kIz8zdaLGDPk8hV9Wt6D6R6uWXx9/PKms344oAByZsYaSqgh2OLQseE61Fj0W/TMALiYAp9wZ1Hq2aiKo4g0k8uIdeaYQGNZNo+mJzSgBTZk/scVDPoV3XdAdmF73r/nisDJ24HpO8GCFLCKruRppBTc+nQF0CrPZEBMkGft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAgGc0TQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c61342a69b9so1284018a12.0
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 16:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769904313; x=1770509113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w6PHHestXQ/cKC4pVHAjbDVmllOaCmbFXSvUHLBjYE=;
        b=NAgGc0TQlDQ5Q59sAEVmqD4ph4WcMo8MN9kvN/txqo1eHZvyorVT8kWjG97Q8uB2Ct
         gkwF2q6rQGzn+3BS3Q6oxFfxMJSrmogYHKfN2YlrllmMsrsjqEiStSZ67fatoEbiRuwR
         o1ZQ4ffla2/eWZTmUbUo9IXBo86r9bad0DyKS2WQgOqURQxsBdr+zzZbKqeTiP7mctqr
         Cl71DySl7Nnfy6+7yVUG7tPF/6LtEvuDh/VeIHtal8ZJhea33+CoKoymc/zAkQKR9y9t
         F+Z85C/MZyeUzCEpf8qG/2yVEAD0PEiXtiM6NYFIZokmn9wCfy2QhCiu562nDbt5raV1
         NGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769904313; x=1770509113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2w6PHHestXQ/cKC4pVHAjbDVmllOaCmbFXSvUHLBjYE=;
        b=XVumGjplMc++gQRHV8kiJ4q9zyYJilmz3Qf9x2Jynj6gla2ca3NGhn9pkVwjPi+YRi
         Y2IHqgNXpbr95mXbyjL5w0xewX/Szof6h4JoB85WeX3V4HZOut89i/JKUaNvg6Jnsewx
         IZ1PXNwg3yEEQUssUD/SfZOTk442FyZbGsiw5cY1Fhu9JqryosVR/63Zkvk076Vc+1FX
         w5PzteYSXXd3i1riydxpSfzzBuXc29RD7DetG85+BqABjHu2y8HNou9kOGrkOknqCSu9
         VTFeZIvmw+IMR7HHK2XjUhW2vnczjolFjDPFgvDuwvy7tivhJoE+jVJxUXut9MmEcgMB
         Jmnw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbfM1a8J9Wo8IrYXbrdX+Vg8WAmXM7rUHNlEpB5LLgnjzt3wgbaxRPjteJqC8RsdKj3fOc8l53R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8eMboP+3dZyGiqV2smNxJmfcKOb8sGb+UZRpzkxpnf21K0q5
	lXYB54zJ3bDO/OmTLIxTHT0+3P93K9jHgQ0hDrMquMsXUBJmKuz2m5Ac
X-Gm-Gg: AZuq6aIM53jD/S8iZU9LOgb4uIJLnxqfdn6F7njPaXUrd6KJeCmHaLap+OWQi1Y25Ve
	T538W0gkgBumCWQuurBEgQj56zF+lupYVz/YieE/BZJxId/Q5LeY/wfI+FmojKoJcz+ir4ofcTr
	NK7t6ccQDm/SaNz9nGe66Ys1Go6u+vp3IVKSOIVwE9LpADay012S5cq4IPa/v4y/UjMD5/+XfmO
	aMebzQwwqTnQ8a8DbZhHMsK6kxO9HRR+/5SQPIahsDg2pL8qly7S+5SnjiMCUKUt8D2b467ZyKl
	Dx3NfNrEei1RiRooYkZOHwn6ayZJVJxv4rldGx/FHdh+yjYSFmGnCxUZsZSOW3PpI3gY4DuFU37
	mF6SWfh/PfKPgaNfV3XoJUu0z61qQPOqveseQqWsY1LWxwxn4TxcNPaW3zLzKDyGJ7K3nTze9RO
	ab12IobCQYgoihdl306By9xmHw4C2GwfueAOo=
X-Received: by 2002:a05:6a21:6f12:b0:389:8f3f:50ce with SMTP id adf61e73a8af0-392e014ccbcmr6370464637.56.1769904313359;
        Sat, 31 Jan 2026 16:05:13 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm10295901a12.26.2026.01.31.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 16:05:13 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v6 3/3] dmaengine: dw-axi-dmac: Remove not useful void return function statements
Date: Sun,  1 Feb 2026 08:04:52 +0800
Message-ID: <20260201000500.11882-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201000500.11882-1-karom.9560@gmail.com>
References: <20260201000500.11882-1-karom.9560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8642-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20919C471D
X-Rspamd-Action: no action

The dw_axi_dma_set_hw_channel() function is declared as void, so an
explicit `return;` at the end is unnecessary. Control flow naturally
returns to the caller once the function ends. Removing it cleans up the
code and aligns with kernel style guidelines without changing
functionality.

This fix resolves a coding style issue introduced by
- 'commit 32286e279385 ("dmaengine: dw-axi-dmac: Remove free slot check
   algorithm in dw_axi_dma_set_hw_channel")'.

This unnecessary return were detected with the help of the checkpatch.pl
analysis tool with --strict --file option.

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


