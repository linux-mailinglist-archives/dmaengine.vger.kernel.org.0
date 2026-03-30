Return-Path: <dmaengine+bounces-9747-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKCdG4LnymkkBQYAu9opvQ
	(envelope-from <dmaengine+bounces-9747-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 23:13:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0F3614FB
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFECD3040238
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEB39FCC8;
	Mon, 30 Mar 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvQsICV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591513A0E85
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905109; cv=none; b=WwnDk7dXb61wI5YekZjNppzS+ypNFk1/Fdrv4r4ylIp0BE3tu9m2I7PVEVhCco6wttzZpU4tlMDQBC+hepBVuOas7BEHrivMrAlf6MhnNyGpFOr381F15SoPw/mKtIlmc/6wR2ZtrJOc7JYSHOTCZUENYvqVVVEQGlphcCPwjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905109; c=relaxed/simple;
	bh=6srCrUIunOESXdde9Lcj4hv+k+VDJuR+qMStPX5yZE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0ATyUoUNfD8Jx+rg13nb0lixQ5OprfGdfuKSu2FaRG8BllPpBewxBW745CmpzHRm3xTBe7e3ugVJpVCokkNBLwTbnzmLSammpnxCsPEBkMgQhGO0lc1AlCfTH4mA+d6YIA5h8B3NDokrcohhCL1YeFeEfzvmndh0RSRyj7DMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvQsICV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so1283447a91.2
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905107; x=1775509907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEFkVMqVEgbf9JZ2fPYwngkknCV8f3b0OBCU5bCk5wc=;
        b=WyvQsICVhBz2bM+xo9DmlcWba0+frcevY/kEZ5RJE8orzF/fGVbW6m/u8I4SpP17at
         piSWoVd/DN1Ln6dZspqJwaDyWqP6f7SDX6/JGH2sDJPOtufR//twSliCXlg/WqJas/mP
         wV2ePpy2XPhHY2j820yjy4H2fYdlX3WfTxwCibOKiovgB25/SCR721u7bF1g5LXL958z
         gURUR/oyKGvzHebXuqMz4qtg14gLhIhK/G1k5pbt72UpmrFxAdNQqOyYaRGZSTthY6k4
         IR1sUSlIXE6i05huirrOtE91DRU2TABY/rXfNkYgnX+y5aV4SW+F38V0PISFfQ8A9VFD
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905107; x=1775509907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEFkVMqVEgbf9JZ2fPYwngkknCV8f3b0OBCU5bCk5wc=;
        b=DMjCNFZAwQd7CcyrnaJ5F9Wjr5jLRcAaasb5nNq5cSlkoi/rRTV9to2tJDnE9VzJ7c
         bp07tcvuQUjYZKaxn/AwfWOvarhrhQl4W/Ex5E77y6YjsWU7cN2wcL7IxDoTExzAZHiU
         poPUyY77EyVcpsEKVobE17L6HfO7CwtsNnvoAuT5KojlmVi6smgZEmaSUJkb1uwoONzv
         spO7uSalZyx4mK8TdUttUXEzi3PPyKjYNXDfJ0a1BuZF2bpqKIZ+SQi8gkvuDADxJD3q
         ad2jgpmCEXJy4CrERPv6zx30/RAukS/iCx8Gl6ipoaUdFp5WHSJyt0KvK3H7vjk+xCXD
         BQ+A==
X-Gm-Message-State: AOJu0YzZPj32tkk3DPiS5LiChAzpVzQv3X4SOmlPuT48AAs6GkEnzO88
	yCuM6aCipvOQLifCL1+Dc8AbvUCKrdrR5WRNKnSNy7wj02kQfQh43xsGzlPUrQ==
X-Gm-Gg: ATEYQzwxoOUbx/urwUh4nAkZDJ9Tt9VHNnkLaQHrRYbmQ3j7SJ0H1Li5BLRGjtmqK+S
	+4hjYGzs+hVBD8DguSKhYN8XaOg499Xkkd2+igbJvG+N4vpWgFfqSZPYd1n+L7wQnCgwhECYcgW
	IwGz+4gAecAHkdvvzZbF+rwHFdGyRck2nnlJBtlnFE2dbAcNxpP3oYblg3QOXd6mh5ZChzZrAlF
	N19gAEBor5a52l4Qd6FQmCDYsg9/cShDQZdBvcxaNfFiwMnk0FsmI7qJdtd377akn4/6pNOZGRf
	5WhHxzDi4k/85hERHn2VZLF/xjCrC0StTUPFsWUr5nR85KAv1hHLPgnjKxsH3oEhCGCJvPjL/UB
	sDho+9zp3+gk1yqPO9VJo5/Fzf/THF5t9Qd5Rbs9MR6LpyhxqvVRdoIwyiBxTjKGITiVuf9Jh+f
	fPa5oNbsLUf3cRS29C1PjH0YWFS8Y2j3Mg+Xud/ltdlphPBNG5P8+ByzXzPMFi30MERg==
X-Received: by 2002:a17:90b:1dc9:b0:35d:a8d9:3a8 with SMTP id 98e67ed59e1d1-35da8d9096bmr4974583a91.16.1774905106962;
        Mon, 30 Mar 2026 14:11:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm17632936a91.3.2026.03.30.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: dw-axi-dmac: simplify allocation
Date: Mon, 30 Mar 2026 14:11:28 -0700
Message-ID: <20260330211128.12319-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9747-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3A0F3614FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member with kzalloc_flex to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..d3ca202dc478 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 {
 	struct axi_dma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
-	if (!desc->hw_desc) {
-		kfree(desc);
-		return NULL;
-	}
 	desc->nr_hw_descs = num;
 
 	return desc;
@@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
-	kfree(desc->hw_desc);
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 67cc199e24d1..a04a4e03eb3d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
 };
 
 struct axi_dma_desc {
-	struct axi_dma_hw_desc	*hw_desc;
-
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+
+	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
 };
 
 struct axi_dma_chan_config {
-- 
2.53.0


