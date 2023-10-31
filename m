Return-Path: <dmaengine+bounces-34-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B935F7DC95F
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9951C20B6E
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B931802E;
	Tue, 31 Oct 2023 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyPIPUcW"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7417741
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 09:23:14 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FAF9;
	Tue, 31 Oct 2023 02:23:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507ad511315so7867936e87.0;
        Tue, 31 Oct 2023 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698744187; x=1699348987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83hI3IthXitVFJn8u476FdqBHYxtbPhy7jmETDS38UE=;
        b=LyPIPUcWNad0hyT5TaErM8JFFE3hQ3SQzJWAPj7HUYAuBiJ8PcNZbeEEArabdrIJEK
         i4PP4E66BsvraFZiG2Ie0C+MNRpHL8n+g3YT3koA3DI2VG34UJO/XorC5HQRVdeaaxhY
         ZhDsYEz79tuEk/z+LFTBM1bNTADjIH2NZloHfEkge2xZOgLgzm80rzDx/YqICUczGDCT
         +rQ0H8ffWHzCGyEOCDFarGlfolan2xCXec5QNJ/Ah6C/CaM1YF/ADC40qKBnZZgw6V56
         Np+FMvpfBStDAfrD7adC4sLby7wC0C7pY+qnYAHPwtgkGe3t8hhd+ewC9A668oVsFbGT
         Vnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744187; x=1699348987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83hI3IthXitVFJn8u476FdqBHYxtbPhy7jmETDS38UE=;
        b=fOxG/FKqBs8dWtAp81jr2ZKRf+KhKdB4qNkw3KnfoMvWKOhIZStEGUroKrOuOi52oz
         VOM6miLfV8LlQHNiqtXkWHAXMmZrxVJa8wouWCpBszXKa/GW0aRlZjfe9Uh5+b+eP1Kl
         YJAFnPUaIsMLw4nxfhOHWn7N7ipUhBnNtYAb6d13L2BwyAGdAE7kn810a/up/XrVaUkB
         ahYSOULmMX+IRW+Yq71Wjil4uXJ1exBp9CdiGBl/MKkkqY/V9TtnKghPbSAlB0IQBoWm
         a+inlUhv+tPyfS/OVElxp03myYiwo3rXM/x5lN2klc6xlOY1NnIi2Ps0zgUPZFJKkWmj
         DmyQ==
X-Gm-Message-State: AOJu0YymRCjtD79G8D0WZUplhOA66NNgOgdif3mNd8jFUa+u0riR2BQA
	kbGAcWFbfzG8byLruafxkSeIcjWLKtdS6Z79
X-Google-Smtp-Source: AGHT+IHLDywNZOner6h9PzKWR5lzyJQL2hcpMOxfeFXTLCb5fL9Ib3Ha88oCiIzSfZS97LeJGZubNw==
X-Received: by 2002:a19:ae08:0:b0:507:a58d:24ba with SMTP id f8-20020a19ae08000000b00507a58d24bamr8756733lfc.63.1698744186954;
        Tue, 31 Oct 2023 02:23:06 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id r6-20020ac252a6000000b004ff725d1a27sm149316lfm.234.2023.10.31.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:23:06 -0700 (PDT)
From: Sergey Khimich <serghox@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: dw-axi-dmac: Fix inconsistent indenting
Date: Tue, 31 Oct 2023 12:23:03 +0300
Message-Id: <20231031092303.129351-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Khimich <serghox@gmail.com>

Fixed a wrong indentation before axi_dma_iowrite64 in 2 places.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231733.tM3xW1hV-lkp@intel.com/

Fixes: 495e18b16e3d ("dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16")
Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index f2587159bf5a..723620d0d816 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1236,7 +1236,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
 			}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
@@ -1283,7 +1283,7 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
 			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
 		}
-			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
 		if (chan->chip->dw->hdata->reg_map_8_channels) {
 			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-- 
2.30.2


