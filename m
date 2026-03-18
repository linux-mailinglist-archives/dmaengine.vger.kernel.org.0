Return-Path: <dmaengine+bounces-9513-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MMVGpDaummfcgIAu9opvQ
	(envelope-from <dmaengine+bounces-9513-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 18:02:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5332BFD49
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1429334BBC88
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EF330B2E;
	Wed, 18 Mar 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBJ/cV6b"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CE2BDC2F
	for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852489; cv=none; b=AWoGOaIjU0/6eKj8fb4YYvbxnurJgjRAhANt5TQM1rc58E1fGfgBj7oYF7EZwI/cRDjw+JsAVEJNfXSq6VGgPiD7HYRBDDZQ+2Ut7lIK/b1IlWtPS0m0z0vG9dFw+MUjty+ET91q0ox5D2NBzl1rYkAqJzb+vUsMcqgEYgNgXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852489; c=relaxed/simple;
	bh=/O1PKW0L6llEilKfOZWfVaU+Et5UNzTSKi6mhZOaZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0DfMOT7JGkdl3z8OcDeOjobaPbXozMYffcWR60Z712oejiML5BAydSOGLHuLFh2HjRV7uR5P3q5G6kwaBd0g1VLOZk6ozNrHlOTbGbpACoo1KW3FaxTCnsgXx7pOj6293cLkmudGwwLN8NsKQpeYTNi8Gm3STZUwpsKeINvnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBJ/cV6b; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so608325e9.2
        for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773852486; x=1774457286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vSQKqx5ovXKn98lQU5Bj5tW5n+VoVpdWli+lGVZHY8=;
        b=XBJ/cV6baJ1AF3W0Ijyhrqrj2SjejcI4RU9BelMGXL+v891/Fjz3FVZqiyGclNq6oT
         1dRmlEcUscpL71Gn7hcIjWUi2mjVdxq2HCL2BCSejcpXtCUdiiCDhatEVgBPH9vEVvYb
         spKf87ksLUQElSlQ0WA3KmRi8SGMjpxXx1BAoCfuc4MPjKoz3IYajXZVn+nUu14fyzmf
         h04tXdYW+Mgr0cYpMW9yQp4oSZjTH83G7fZr3yLxnWM+b36EaVjgkA053lpghbbW7V+g
         kWYI5umZ3xEvdgnea35MBoKh/B0KTCiuftmX4n32PaG/EV+PBJVWhKgqScILLZRWEMg4
         2q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852486; x=1774457286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vSQKqx5ovXKn98lQU5Bj5tW5n+VoVpdWli+lGVZHY8=;
        b=TTTpzBmTnL0ALd85zpSa7eSsDwUDIE+8zV73G2x2LXX13mKTlmK9ELycKQblCFrgZB
         RAKdek7NvFc9cEbpuX/ukiZ5XVtbndxyKTRsXraucdKu4UyBX1+JpeLVo6Sze+M8qt+n
         /wEC65Pd/ODizdeZegRn1iSarGN9tMoLKxgHQQyz56PuNefTiVlxuW4Lva3wFfCDZ3hn
         8myue5FPDnLs4KJCJpYMdrqzFLpWMyP8rQ/poyXyzcHTEql40IXM0rJPIUJDife26WgU
         4iJCL9SxA5uLYe74roSDZREsEpV8sJS2EAlwklhsVWYg3WA0cTgX5Atinjvi1iPHrlMr
         pg4g==
X-Gm-Message-State: AOJu0YyyLzz1D5AhMRf3rkKji0RIuoUUqZuqphT4Dfs7Vk9DU2J1IL4X
	vBo7Ah5BVqIjRPOrNo8LUdJGb+pCziJwM6NeuIwbapWWZC3ysiy8O9yVFTaPOnKz
X-Gm-Gg: ATEYQzweY2dWyat3/sqzJ8Stw+ulzf7Lc+mx2XbJoDDqXWzz3JvvcOocXHxxUNXwOF0
	9DFeHc8wzhjZZ5IPJbxvx2xsf8UuoHJpzuRBQvLdy/ZJo5pj4PSv4rahYWbdY6NjG2tFz9chaJJ
	HmKca6AaWtQLkTRaHjtIiAM8ecLsbqBMZRBFEDCyAPds7o3S+HxfUUkDMIH4AyhPUOVmR68xHje
	69AcY6dWYqFIOTJsWZJ2fsLUf4L6+wYzZpcW3aJzTV7cy57JHGysIZS4pRyGXSdSFnpu9MRAH7I
	qbuyLMe7Et5c1B9+CtBdKrRIL0DygXqQIYrOegS/3CtRlCtKc0Xmag8hM++DE1FBWCaxHroMUT4
	48bnBpcoTKRAhrsNUztClJQo81nz5cV8x9hx57Lb0Vhq/xCSi3YOpqfW8SO6yNINlbITqVBhguy
	YFOXze/BZCYt67wr2ePa8VWLPNJHXmQ5/qTfKD9EajHS96+eMF+wDLwDIScPTvUpptk1V/ZTZ+n
	ucfMHS+UrKrG83EW3PrwGk=
X-Received: by 2002:a05:600c:4c95:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486f446d013mr46192455e9.21.1773852485819;
        Wed, 18 Mar 2026 09:48:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm2812185e9.2.2026.03.18.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:48:05 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Yingkun Meng <mengyingkun@loongson.cn>
Cc: dmaengine@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] dmaengine: loongson: loongson2-apb: fix broken bus width validation in ls2x_dmac_detect_burst()
Date: Wed, 18 Mar 2026 16:48:03 +0000
Message-ID: <20260318164803.14351-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9513-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.962];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B5332BFD49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bus width validation check in ls2x_dmac_detect_burst() compares raw
enum dma_slave_buswidth values (e.g. 4, 8) directly against
LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
(BIT(4) | BIT(8) = 0x110). Since 4 & 0x110 == 0 and 8 & 0x110 == 0,
the condition is always false for valid bus widths, making the
validation dead code.

Additionally, the logic was inverted: it rejected configurations where
both widths matched valid values, rather than rejecting when neither
width is supported.

Fix by wrapping the enum values with BIT() before masking (matching the
pattern used in sun6i-dma.c) and inverting the logic to reject when
neither width is supported by the hardware.

Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/dma/loongson/loongson2-apb-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index aceb069e71fc..102c01f993ef 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -220,8 +220,8 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
 	u32 maxburst, buswidth;
 
 	/* Reject definitely invalid configurations */
-	if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
-	    (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
+	if (!(BIT(lchan->sconfig.src_addr_width) & LDMA_SLAVE_BUSWIDTHS) &&
+	    !(BIT(lchan->sconfig.dst_addr_width) & LDMA_SLAVE_BUSWIDTHS))
 		return 0;
 
 	if (lchan->sconfig.direction == DMA_MEM_TO_DEV) {
-- 
2.53.0


