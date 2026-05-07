Return-Path: <dmaengine+bounces-10277-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI8ZEjzf/GlFUwAAu9opvQ
	(envelope-from <dmaengine+bounces-10277-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:51:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 444594EDA37
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7D233006829
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A43421A1A;
	Thu,  7 May 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoXyJNNS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116603B8D5C
	for <dmaengine@vger.kernel.org>; Thu,  7 May 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179894; cv=none; b=kWBhAwn5a4KNrjzJ2xJ659rHwZeR6Rrc9ih2ZmfU7WDbpjUzF7mZJo8ZQ3UB0aUv1V17PVvhRm2f4UOHA12h+OHf2Tbf/quyO3BuIOMYv9AXPO5pKUBvgedU/oehjbxcA0ePZUF62d5B0YiptIuXfBIlIJbxkyKg6MrRHHr5iH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179894; c=relaxed/simple;
	bh=SPljrVad3SfHOMV6CoDc+b6SoToalM1kLwKQ3HCcS5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2TOnx7TFvjH1pnrfEC96pMmsE1j9CCMFYez7bMNPjpqTgsE/FgFE6/iwHWQbQW1ZbJQMLX63F1bQhFj2GI6HHNQxX7ADv/vgG1r9rLCOBT1i7CxhVcQW9Xmum8VX71GS03KzP+gnllg2koOO5u8e1Rvo8vnpq0lBFWgdsVt+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoXyJNNS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449cdc12a8aso134188f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 07 May 2026 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179889; x=1778784689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsCgDB2SeUmpLesfortnurxRDaLmMTCCnWudo37xq5s=;
        b=ZoXyJNNSk49/PnDLRtdSvV8MXSRPxNryIqnL5tJ7kFxBTReJehwvpnse8UHiQ3vWjG
         KuyH7A3VN6RBDp0qxJsgZcaIGr2v1Au81mMCDKQB2AVLdG2sWb+/oFlP6zgkRY7XJubS
         k47zIvN3w8ZH2eZuLYkyj40eWE3mQsY3Arw8JQO9kxo9fJ6M/rFMb8R03MvtPr9nndEl
         9o6zsBkjPt4W6suNI+b2YDtj4h3Ec4ZXJyhgVr49pi/gUlcixHJrTFAaJ7JQguONZWlb
         TCce4vubEXd2TfbSe6eUOVBhaycW//zxiwPvirK3IoBcm0kHWEXgVT7JYLsz/vB55SrR
         FKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179889; x=1778784689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsCgDB2SeUmpLesfortnurxRDaLmMTCCnWudo37xq5s=;
        b=hSj0tqEXoXklUFrMJB8HUny4CLhinrNc1toZINRO4erI7KuosX+J/MwKGLgjgvTvRx
         AvRGfCLqzduDsRRcsZL388Y5YqefHHt3iNvu2FION4YwLQqpuPcCBXvnGj25q1BAZOi6
         WVNagj1FMZgijbwGsmvD8kUfnf4+rk1nntcZhwct8bWCqXik/0YHWPiIwcwJvitoR1ot
         +aaCoqG9NuEVZ/TWzTFK8bxy5AWtYWPZ0QJYMl+znDycttoo937DTU7Bo0+RAOM5ox/g
         559BnF3gC9U1F+3LyyPb6V9J3OiixSBae9GZjBrbgG4Y1FeCVAe/qc+LEGDnKIB8X6PO
         UOgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MED6RBZPDDA184oXywS2w14Gi1Zq8MXFhR52ZHXccpEAowk9uJCtDdS/JnLG7qLNEg1Z30ihK6hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3ZM6Z5W7yE848JNmcWLCvVmGGo6aruwHnM2N+bEQd6+UXAhy
	tdxvFKPcx1gC0MTTYb5IKNOGRf5qVmc6C1c/GhBInLoiO1v+eDmGSGj5VEQgzMxe74nkaA==
X-Gm-Gg: AeBDieuJy7Sz3cCZFK3SN25RsrCa/Wi0q1DnGDIId3BZFXGMw7grWiGib69H426CxQX
	yTbBIUn34wKrmn91Hsqme0SQXVz5c2JgFL9FhdklPaEEB3dc8ri1c8Bx56JxyA9koTXS+g3DFr1
	XZIFG+AJS1Fo2CWxFM5xHoHJpJQH29WcVoK8i4vJslwcuqOeOlyOWCT1JaRVGft14U3c14ar+M8
	IuWHoKFy02V0It2fZ7kxl3u1zpG7fTRaJKUafhbndSkWGZhvSMaxQSHEG/HtwtDALKp9vm6Fva+
	Cm7TOpqpSS2JLcG0GMPwL7uU60YEBIJ+XXV7bzx0N/3KDghKGsS+6MiQ1QWSYWp2RPlx6v9GuGn
	trzNaKTQlP3GA81Ak/AkPdfpnm1yU70/0s5nreBUzAL6/n88OGf6O1MG/P4ifhIX9/fxde/FJOx
	PUq9X+vd85yop5hi9jrpM+FRyQzvNX1XdQWcKohNAKAm97
X-Received: by 2002:a05:600c:a0b:b0:48a:5391:8424 with SMTP id 5b1f17b1804b1-48e532a4dfamr68507655e9.6.1778179888852;
        Thu, 07 May 2026 11:51:28 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45416a67bdfsm910506f8f.23.2026.05.07.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:51:28 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: zhoubinbin@loongson.cn
Cc: vkoul@kernel.org,
	Frank.Li@nxp.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH v2] dma: loongson2-apb-cmc: fix NULL deref in residue computation
Date: Thu,  7 May 2026 22:50:52 +0500
Message-Id: <20260507175052.9711-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260507023153.400-1-sozdayvek@gmail.com>
References: <20260507023153.400-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 444594EDA37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10277-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

loongson2_cmc_dma_desc_residue() takes a "desc" parameter that is the
descriptor whose residue should be computed. The body uses it
correctly via "desc->num_sgs" and "desc->sg_req[i].len", but the
cyclic check incorrectly looks at the channel's stale current
descriptor instead:

	if (lchan->desc->cyclic && next_sg == 0)
		return residue;

This breaks when the function is called from the vdesc fallback path
of loongson2_cmc_dma_tx_status():

	if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
		state->residue = ...desc_residue(lchan, lchan->desc, ...);
	else if (vdesc)
		state->residue = ...desc_residue(lchan, to_lmdma_desc(vdesc), 0);

The else-if branch is taken precisely when "lchan->desc" is NULL or
points to a different descriptor than the one being queried, so
dereferencing "lchan->desc->cyclic" inside the helper either NULL-
derefs or reads the wrong descriptor's flag.

smatch flags the inconsistency:

  drivers/dma/loongson/loongson2-apb-cmc-dma.c:516
  loongson2_cmc_dma_tx_status() error: 'lchan->desc' could be
  null (see line 512)

Use the "desc" parameter, matching how the rest of the function
already accesses fields of the descriptor under inspection.

Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop "we previously assumed" from the smatch quote (Frank Li).
- Add Fixes: tag.

 drivers/dma/loongson/loongson2-apb-cmc-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542ed..3b02bcd75 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -487,7 +487,7 @@ static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lcha
 	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
 	residue = ndtr << width;

-	if (lchan->desc->cyclic && next_sg == 0)
+	if (desc->cyclic && next_sg == 0)
 		return residue;

 	for (i = next_sg; i < desc->num_sgs; i++)
--
2.43.0

