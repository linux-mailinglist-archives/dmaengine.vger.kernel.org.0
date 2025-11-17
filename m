Return-Path: <dmaengine+bounces-7217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03DC65153
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80ABF365E7B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733792D061B;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iuj8TL14"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D652C3253;
	Mon, 17 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396005; cv=none; b=O++OsiuuzAxSnrrKDa9go1BZLF99MDLFLXneU7hMO00phgexcZLrJ6DK0ynuEw9WRPnNmgpe/cwJuns8SHiIte0zaCipMWxtboEWEk144PTOhywvQmXBYOpW4IEBrzcI6zimMZUqk37KQjmAYK4Wa5VWuhm0bJIXWBvCGHVDdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396005; c=relaxed/simple;
	bh=57X0vMwFUIqQbrllS7orgbHpnLFQpUEp5VAeLv1CHvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNJ3SKmQtwmj1RjAzdqr+8h6tHpVnyhmbYyOmB8yNj1+N1CtMhLKeDuB/gyaOtJ4nsEqJscT/JhYgPrCFQciijQ6QTg0jFwMtA5HzBefXO8iFjSBTST/mRiMkvKXYmrgKPbMCBH6y0UVjCmQDacl7GSkcc79ZJJPQBL8mQr6Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iuj8TL14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86A9C19424;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=57X0vMwFUIqQbrllS7orgbHpnLFQpUEp5VAeLv1CHvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iuj8TL14arYYbq8NEr3U4+gyjFK+kwE98EIQ3fkNUEMDICWIxEOqOia7bn+Ec7GJf
	 HD/rGRwiH3D6f0Gvj6YpAG3e3RXymu7a1xaT8aPFbBzDM+ELRbaZq6MZIGhdiJBtOJ
	 gT4pwNiyVfe5xQkimI43Y0IYf/4ohNWhuG6VHVteC9qEABv+cZX167XdOKuEfF3G+B
	 birWvyITejbLu188W2KkEJ95Iyu+0Qu1TJiliQrUEBDQqktPq7IHhwItVZ7agP3424
	 QxLNR/edSjs5Eon9HnnEhLIqhc142CPPuMCOiQCPnIOfgCQ2P0Dm7gQBygI7KMTWkZ
	 jDuLlxfnlGKFg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002ne-2h0W;
	Mon, 17 Nov 2025 17:13:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 04/15] dmaengine: dw: dmamux: fix OF node leak on route allocation failure
Date: Mon, 17 Nov 2025 17:12:47 +0100
Message-ID: <20251117161258.10679-6-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the DMA master OF node also on
late route allocation failures.

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Cc: stable@vger.kernel.org	# 5.19
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/dw/rzn1-dmamux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index deadf135681b..cbec277af4dd 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -90,7 +90,7 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	if (test_and_set_bit(map->req_idx, dmamux->used_chans)) {
 		ret = -EBUSY;
-		goto free_map;
+		goto put_dma_spec_np;
 	}
 
 	mask = BIT(map->req_idx);
@@ -103,6 +103,8 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 clear_bitmap:
 	clear_bit(map->req_idx, dmamux->used_chans);
+put_dma_spec_np:
+	of_node_put(dma_spec->np);
 free_map:
 	kfree(map);
 put_device:
-- 
2.51.0


