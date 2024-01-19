Return-Path: <dmaengine+bounces-751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699748329AE
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE931F2236C
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A35103F;
	Fri, 19 Jan 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoOZmLdP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBB4C3D2
	for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668592; cv=none; b=U44ArKI5tKiW1fgrirl9YqmnrhGGI05HB1MWsnP25E97hb2IuuZ5j5EZynS5vzbl9ExqfrZRLrk34zptaY6t/A493ChiD2p/YxcUQBLwIJaJpZm2I6yc0IKJH1QWHTPhjQxLcN63TXfLH57VMxnFH6Oyjib51nmi8x0ddavf/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668592; c=relaxed/simple;
	bh=uag77kOUfM7/xRJI0XxCWxVSc8DQqTt4Lm71qZYhdqw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tKNtThMszaP6+t0rN6LcDlFwuILNe8+9uCiMWrAAros4R0IEImJl4ulZfbBJiVKocREGYbLSPHwEutkAGeCP0LEnrSIjc2IxC+8EilN83+JOBc1HKb5/eFYTHGMjjZWqsf4jM7Xm+lJNJa4M5MiLWSxMVa72b3a7WpV1fFP8hKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoOZmLdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC88FC433F1;
	Fri, 19 Jan 2024 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668591;
	bh=uag77kOUfM7/xRJI0XxCWxVSc8DQqTt4Lm71qZYhdqw=;
	h=From:To:Subject:Date:From;
	b=OoOZmLdPMMcQIJ/HqHpbqidySSDSB0KG+vJpdF+QB780S0osJ5r3jURD8gjLMnJi7
	 wrqlhg9v90Hq0MVIjth+pmSrqjGJxml+OW3uFWIptw75H5Jy9X+w9YJyG+WL6lEHUQ
	 ESCPFHvb301GsijZYSYY9j/V0/VpEmdS66NLfTmjiRiTDIlSGw3FXkQoEYwOpy/Ukd
	 eJ8bV27PrT4Stp4mBzyijthxs4gRa6vnk8WX/JyVYtFu1lkLXksTx3dJhNWWt1N1Mi
	 zx5e8fvjo1Hc+/HXqlEil/gUFJAn5/VULhDnPf5RO2lfCm0lEgcWbPH+OxsjtHupBW
	 I/TDcs1tFKtpw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/3] dmaengine: shdma: increase size of 'dev_id'
Date: Fri, 19 Jan 2024 18:19:42 +0530
Message-ID: <20240119124944.152562-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We seem to have hit warnings of 'output may be truncated' which is fixed
by increasing the size of 'dev_id'

drivers/dma/sh/shdmac.c: In function ‘sh_dmae_probe’:
drivers/dma/sh/shdmac.c:541:34: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                                  ^~
In function ‘sh_dmae_chan_probe’,
    inlined from ‘sh_dmae_probe’ at drivers/dma/sh/shdmac.c:845:9:
drivers/dma/sh/shdmac.c:541:26: note: directive argument in the range [0, 2147483647]
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                          ^~~~~~~~~~~~~~
drivers/dma/sh/shdmac.c:541:26: note: directive argument in the range [0, 19]
drivers/dma/sh/shdmac.c:540:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
  540 |                 snprintf(sh_chan->dev_id, sizeof(sh_chan->dev_id),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/sh/shdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 9c121a4b33ad..f97d80343aea 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -25,7 +25,7 @@ struct sh_dmae_chan {
 	const struct sh_dmae_slave_config *config; /* Slave DMA configuration */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	void __iomem *base;
-	char dev_id[16];		/* unique name per DMAC of channel */
+	char dev_id[32];		/* unique name per DMAC of channel */
 	int pm_error;
 	dma_addr_t slave_addr;
 };
-- 
2.43.0


