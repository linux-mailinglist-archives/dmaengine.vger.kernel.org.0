Return-Path: <dmaengine+bounces-4171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7DA18C56
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D84188AB0B
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 06:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E42199384;
	Wed, 22 Jan 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaeUxPM6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596F1BD9C1;
	Wed, 22 Jan 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528715; cv=none; b=cLYVtHbVzC7YS+OCeqeOrG+A3nxef4kBtIPbn2N1o7wtNS9KvMwNBbL7tgow+LALbqgzFEJ+/z5GALir8u3kfNZ70T3uzicZSkXzGOgmmVEQGuzbJRdWKpquAUaN7pOpKrW641IioP3KoJMd7dddieNKmFNKvB/czMg2QL0kxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528715; c=relaxed/simple;
	bh=M5TsB2kRkMdI/QhPZr3eIwgqd5/GvYJFuMgIQPgKk0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTxlnpYtFEot7tVMLbiRkUNRus8X0w/FML8vATRQlKLJgCs1SOeNOvNYtUnpVSzZze0x3ti2hROt7WuV8XWjoPH0Q4+7Sr93P1RtRKOToYXUoTZi/v9gE9qUuvrkPW+ulGq3HtUc+o8ws62mEBdDzYFs8tkAbXG4zbn4ckVQsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaeUxPM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E2C4CED6;
	Wed, 22 Jan 2025 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737528714;
	bh=M5TsB2kRkMdI/QhPZr3eIwgqd5/GvYJFuMgIQPgKk0U=;
	h=From:To:Cc:Subject:Date:From;
	b=VaeUxPM6Gp19fVKV3SOmotzWiid0l1RmpzqLI2xK10sZJmXPTR2RN1XXO2a+9qFDY
	 Mwr6abp8OhSWJUhDI2R9f/SsL3U644lgKCm+QWSdmX/ZBVqNNcMd7pfAFu6e/ZYtSy
	 uaLF/MnN77Fpzlla5iKVe4/zdq9UCvd7V71rXJNyebVIdAw0+EZE6vrKhmHumqkRCC
	 Z13FygMf644uobBu+ISK4VtupmyO67M9TFJ+6vQyOYBXFYYiFccDjH4ZzTvfimjlq0
	 LpwWW1Voy1ba7cGNCiBySOyu87T1ABE82Qqbe+7sUouo6WS9hl+DNYbu1icQ58cakC
	 vBx1j3luu2oPA==
From: Arnd Bergmann <arnd@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mohan Kumar D <mkumard@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra210: avoid broken division
Date: Wed, 22 Jan 2025 07:51:36 +0100
Message-Id: <20250122065150.1352906-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When build testing on 32-bit targets with 64-bit resource_size_t,
the new probe logic causes a link failure:

arm-linux-gnueabi-ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
tegra210-adma.c:(.text+0x122c): undefined reference to `__aeabi_uldivmod'

In addition, it seems that the same division can trap when running
on tegra210, which sets .ch_base_offset=0.

Avoid both using the div_u64() helper and an added zero-check.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/tegra210-adma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index d80a60de0160..fd339f10151c 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -913,8 +913,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			return PTR_ERR(tdma->ch_base_addr);
 
 		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
-		if (res_base) {
-			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
+		if (res_base && cdata->ch_base_offset) {
+			page_no = div_u64(res_page->start - res_base->start,
+					  cdata->ch_base_offset);
 			if (page_no <= 0)
 				return -EINVAL;
 			tdma->ch_page_no = page_no - 1;
-- 
2.39.5


