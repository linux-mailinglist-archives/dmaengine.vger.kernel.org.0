Return-Path: <dmaengine+bounces-10119-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMtFM9aq62nfQAAAu9opvQ
	(envelope-from <dmaengine+bounces-10119-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1F4620B4
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031EB3010D83
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1D3E639C;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOO4rcZl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C93CF04A;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052364; cv=none; b=H/14qEd26b6q3k86bM9VEVN9pjmyo81d313z8TluGslQT2a/8KwpaAX9yUVaUnMtc9fc5aobAG62ekp8hjSyHsro5mnhUK/Pywo7EodSW3495qBXoLv3i5j58OK1nojTSvKZQW2nH0n5ytwWXwe3ZyP1yNWOg3ALIbuOkwd1Q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052364; c=relaxed/simple;
	bh=ATIsTMqdeRfyKk2ZBacXgt30GuntU9GUOCjTQBtcVsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2yl0cuDKj/IdgQjRvxVxeZhNqlRyngoeIAWlPvlGlpOdvE9bNlxxA7fYwORI3ON+fl2vdulfVAzcByHO2Msc+87rzWpjZS8vehabABJIqfxyAYM+dxYLtsldBlGH7ksOymZpjexeO9OBV75SgcFBu/PmHNGT8rckB7/C6dXQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOO4rcZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25C85C4AF0B;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052364;
	bh=ATIsTMqdeRfyKk2ZBacXgt30GuntU9GUOCjTQBtcVsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kOO4rcZlI3mjL1o4NYci4VUESvXxAKFc/tRE7sHU9J1MjJ68TLsXgS3XT4sBGSB/p
	 Io7jL2RiEYTiqCQRUExSn/yN5CVpyKpRzqEm/asqcBHfZdXUE+nC+iQj09aoSR3AaL
	 Dyx9CFF2NZyyoYWlWkkgzoIQRKmP26QwO8ezI25zMIhLiA+aWtzzNG1xGlRVjfOqAZ
	 W6PFDQ+CuBB1k4m0JQg1zo+eQ32svXJ97xmexjEMBAfiuAZvDQRU0HhWiYw3SklT4j
	 f5bYe+lhx2Gp3idQq6IWBDAZcXBc2j0SfEKwdl+0mN5bYbPNiIMmCDK+eKbgdb6qM3
	 OXTGCx/hl/HKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119E6FED3F8;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 24 Apr 2026 18:40:16 +0100
Subject: [PATCH v4 3/4] dmaengine: dma-axi-dmac: Drop struct clk from main
 struct
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-dma-dmac-handle-vunmap-v4-3-90f43412fdc0@analog.com>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777052415; l=1284;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=avj+T9/jVLfgsfiQ0Hqoh1jSjrsgZ56l2nwqP+AgXzg=;
 b=fSwwqjk8vDZtsatGLIsHto8HKM7xiaTE7tEO55lTxXvgcvgnhSVuZaaAUw2Wu/RaNhHloD+Hw
 1m0yOEazeO3DON0nTtKgvVVzeX6yt6+vzFKT2mKIj33Yrsh61qfKtgk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: 70F1F4620B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10119-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com]

From: Nuno Sá <nuno.sa@analog.com>

There's no reason to keep struct clk in struct axi_dmac. Hence, use a
local clk variable in .probe() and drop it from struct axi_dmac.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 127c3cf80a0e..41898d594be7 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -170,8 +170,6 @@ struct axi_dmac {
 	void __iomem *base;
 	int irq;
 
-	struct clk *clk;
-
 	struct dma_device dma_dev;
 	struct axi_dmac_chan chan;
 };
@@ -1198,6 +1196,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 {
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
+	struct clk *clk;
 	struct regmap *regmap;
 	unsigned int version;
 	u32 irq_mask = 0;
@@ -1217,9 +1216,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	dmac->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(dmac->clk))
-		return PTR_ERR(dmac->clk);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
 

-- 
2.54.0



