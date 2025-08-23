Return-Path: <dmaengine+bounces-6163-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B7B329FD
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F51F1BC3036
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01C2E975A;
	Sat, 23 Aug 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM3k5ucP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F92E9746;
	Sat, 23 Aug 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964657; cv=none; b=ersHHJl6FDwumu1wem9t4/3BJuTQ8/gZwFosat3mMF/jn6qgXbAnLWzuW9qlMwTXFRdoLuQK5bhEgUI5yWHkJ3prbkY5slkzOM6pwg8OKN1imp1xIWcoakm/vwSv3wPGK/NHbDox6bZbRhIEP0nUwYXu8tF92xukZxuR4XITbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964657; c=relaxed/simple;
	bh=Zfl9ZZXjm6An0uUR0To5lSMsxmxg8ZEzVzG4zWVYhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzQu0J+JxKWSQH7V17AACcd7NaHBKQBAHYfEmDwMZimZOjLvEA/3Vzd/hgrlmaT4hxf/aI5GJNyrRTPJtRja6pgn0zkFoCSP6zz08X2q51xBlS5//ArKVM2FzBPw8kQ28L3VUzKl8BZ2Ycm1ZToOfLdJdGDIC+BLbZjy/8ZH5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM3k5ucP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF9C4CEE7;
	Sat, 23 Aug 2025 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964657;
	bh=Zfl9ZZXjm6An0uUR0To5lSMsxmxg8ZEzVzG4zWVYhDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM3k5ucPnOzynMqVL3YGtLdH/EtayFQWggN/8VKlg7jvTAQjjDDRraeV8LOy3ow2z
	 xJglU4cN2L2IcIghFU0HELbyhflNHTLBwCGZ/gkeAq/QB2k9awwyPXD3DIsy8pCytK
	 nKlqJohWqQogPlzegr1N2WFlwtocnGe7PXs/rQdT+JvBKbdWiGTsW9fdRzPHKSRVYI
	 6+GdsIX2C6iTaaudAcJJCzscYaIGdtHLI3xhsn9uSyEzcobHs0Z01UuSfYzW8CjYUT
	 SCRk80MzKIB7bGJr4/ZO5ljfZdg7YZzqp6XryYX31YTpGSIZYT4/OPZ8X97r2cvWDx
	 wH8hDxX5Yuv6A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] dmaengine: dma350: Add missing dch->coherent setting
Date: Sat, 23 Aug 2025 23:39:57 +0800
Message-ID: <20250823154009.25992-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dch->coherent setting is missing.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index bf3962f00650..24cbadc5f076 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -587,6 +587,7 @@ static int d350_probe(struct platform_device *pdev)
 	for (int i = 0; i < nchan; i++) {
 		struct d350_chan *dch = &dmac->channels[i];
 
+		dch->coherent = coherent;
 		dch->base = base + DMACH(i);
 		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
 
-- 
2.50.0


