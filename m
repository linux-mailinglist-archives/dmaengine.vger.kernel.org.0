Return-Path: <dmaengine+bounces-10254-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAEDAKj5+2kRJgAAu9opvQ
	(envelope-from <dmaengine+bounces-10254-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 04:32:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BE4E25B7
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 04:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6545E301DEF0
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4C2505B2;
	Thu,  7 May 2026 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNZiv+63"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5E1F09AD
	for <dmaengine@vger.kernel.org>; Thu,  7 May 2026 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778121124; cv=none; b=W73/XaOTjZ7cowhEqDBjZjSTiUgKiq3WR74tQEBM2wlXDuwmpcElv+XXLr0QOtc4EqqwIvHFWd1TvJgPOWJiyt5soOFVeXDudD6gdeDf5S43m7UeRHz3rnkxzGC+zNn2ElVWaOrJforoJrGf26zT/39DRNO0qCpW3UU7SEKM3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778121124; c=relaxed/simple;
	bh=Bp1Ne9pztzQm+KDDeFPK4yhQY40nfwo9TCOg/UXNpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSJPAgZMXu0zfx2hDmgYRZm86WOiOWUAVCTrJNeulgwRqRsmLxlW2EXF4yRJ1mj5bR3j2Rl2SX+Jzu0z3o3KbBAqzdFyTItzb8cM+H39ifFymgKUFzNdJycNnz0lGmsaW9kh+FJrSnAc8ooVqCzHkqqYxtPyfr9/qgsFn3pr2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNZiv+63; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so818035e9.0
        for <dmaengine@vger.kernel.org>; Wed, 06 May 2026 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778121121; x=1778725921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JyuLrRHCpFtoLYAmln27Ltny/JTBKMMaR/9tVT6S9rs=;
        b=NNZiv+636yh8UZvYVC9yoIxPeBGierG4Oz+NOyi1+7dyJAmwJXINQedLTEa3OjRFx0
         VeZgyJW1YzjiKCQEyAys50zPpPxd0O7KAZAoGXRXCu6PcNbpDNfeITjqs8QNgyxwy4eS
         l5SQFdKsMmR9csM27uh9rkqJr1VjQL45//QFtKVZqbpgQe1Ml+IrgoXuPK3DhN/jgJPb
         2uP1IdZVIM8l9IDpk+makY0umdSDtyt71ZKMFg5hwFQ1EtFix2B6+PS2Ei3i+w8xIir9
         nWB5nQ0AaAkziJ53v1Getc2NgCGlyQWGdp0/H1ECs4ONm7vqG03Egnv8rzUkmIbPVnww
         FksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778121121; x=1778725921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyuLrRHCpFtoLYAmln27Ltny/JTBKMMaR/9tVT6S9rs=;
        b=XPDRY9c2WHEJYp/wtcKAH7aGzoq5ARFPP+XeVQktLqv7cGxoED8F3hdvo6dnvaIju4
         z/K/a3vEYAFgEjEAxMnvm8QVHhVbO2ptye+gIxJp4nng1N8gVNmuXPAzzrEsH1pEeCnD
         Xr7kaWpXACSx1oLPS4xpJ86IB1Vr82KO5ES1QpTgcR34u1gFm6kGoOB4m4WJk6aBoTgh
         bqdTm4XTG8LqjrhzRj13MjkU5b9+8lZvo8MSOc44GKPKxz5nM3fuI8TXO/RfE61x0VZv
         fjdhdS8qUygguZ4mmz6yX7mW8brjsWlbl18Col8Px5BmAUNfycKjVxBBJDfeEA6ZFmnP
         SCSw==
X-Forwarded-Encrypted: i=1; AFNElJ+YCDpuiSgrgKpLALAA2UNN0I4mRtUvTPLUA5rKwi1U6OyFgjoJW6Z7wMmjLOq2xeAzM4PaODNVj5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzIclyAQPxlEF+yzD8dTS05gclAQn64I9FAoAjnR+T5pvNuoG
	4TPRXHVYjN0tT6xJgS01WXjJXbTr3vZxGC7U9q88AHj0XEW/EiSQV27Y
X-Gm-Gg: AeBDieuRFia+YKVmyPvqB4V4uPgINjMN69Ir7XUAA0WbnUexxYzrlfk9DkpIX4uC+2p
	lOqPz32YKN2iStoAunu4DhZMqKzyCgHOef8ScXe188btWful/r+8yrhwRuL8aa5vo9KuLRIwpRX
	+QRwKBCYxlom5/IZTfoT+HV/0KYF9ZnwPp208uD4YeDVbU8hdpF3ZPA+RUhgVBLPQjYAzh3DQm8
	d9WK3bKFFvMLVFDMwwVaT0d2voFoHfgOXdswPfsQRuyYXJYZr5W1Zne/aooVJkg7oj4bliWddn3
	fuhlj0iOfmAp3hql2gwkVP8brrmggJJg1doPUVFs5VKdwmFUrQO4xK2R7vGJ9AzBz0r/4BLRd0y
	1YoLEfJsvdHu4+NI/G7cHoXQE9c3jvQcD5Z2H8w6GrHTUfOmGcfRqlas64wBABRA0Ifsm7rrAN3
	NkJ7NZSDjhs7o0MhE4xRE8gKvYDYzaX/I+fjyYGRg0Ns7fxqU4YIOt+4BpxD9siUTQzrypZC+5
X-Received: by 2002:a05:6000:478a:b0:441:1c35:4b79 with SMTP id ffacd0b85a97d-4518c42051emr2746382f8f.8.1778121120953;
        Wed, 06 May 2026 19:32:00 -0700 (PDT)
Received: from LAPTOP-9UC0RPH4.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm16130737f8f.0.2026.05.06.19.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:32:00 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: zhoubinbin@loongson.cn
Cc: vkoul@kernel.org,
	Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] dma: loongson2-apb-cmc: fix NULL deref in residue computation
Date: Thu,  7 May 2026 07:31:53 +0500
Message-ID: <20260507023153.400-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 726BE4E25B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10254-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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

smatch flags this:

  drivers/dma/loongson/loongson2-apb-cmc-dma.c:516
  loongson2_cmc_dma_tx_status() error: we previously assumed
  'lchan->desc' could be null (see line 512)

Use the "desc" parameter, matching how the rest of the function
already accesses fields of the descriptor under inspection.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
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


