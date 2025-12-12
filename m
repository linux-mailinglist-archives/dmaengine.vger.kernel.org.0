Return-Path: <dmaengine+bounces-7579-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4ECB79E4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA39C304FE97
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B829A326;
	Fri, 12 Dec 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVl+CVqu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CB2989BF
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505174; cv=none; b=ll8PXPonnzg3RcEgp36Rj0226VGK7FD/1eGgpxYOEeuXRocf3D/GACg6VHWdeMns1UG6cGwEGYY1zfHFxeFmrOcAmslR3Ca8V4IkISWuHDpQb8I5SWE/kn6/85XbDUPnX6QmeKGkQDyUO7hAto9yaXJOMZkN9LtpGqfoxKo+V/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505174; c=relaxed/simple;
	bh=QFEtmeMBLNwpIlTTBASnNTvXw+NZAPd8troy031bRC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa/06d/gxKmfIY12hC324YrfYPY+A+C02ZsUFh18UGOJcifYHIzFDcRZtMdDt8AxD78+IuEYF3n1dRdsr0BaEspth87WEM5hfzKBn/cVh18fxcpR4sYPNG1zer0CzaODRjFkt5r8l6JfJuNe13RVZU/t8wBhSBtAa3YSbw27rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVl+CVqu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso639401a91.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 18:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505171; x=1766109971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UW8ta2pE4L/+9Yv6ju5XY9TcpGvPkrqtEfI1VIl2bA=;
        b=nVl+CVquZJodZy7OVG2iVajNHoURUCN0ifpVuf7XGzQ01n8ZL7lvLRxs/ywRunSMmV
         hTrn+etH6yS+1JQo5oL6fqtFGqeIGfEKWovcLIpiQBhl4aMa8FbYpnmIBL6ZTqB3uYFD
         hl43K3w+bvJKXa8nV7v9H+ZIKgi5xJqJwOD9LnuWBKrZy+63PTAENge72fG0Q7A2p1o5
         RucVAER4+VHGhgcCKXv0mq3J3LMlv5bsOvMB25gKNt0FhSMLI1KedApcmwhBf7NuA1bB
         dFEYZ/4WQlq4rvqxV9+ll6gmMpwQ9aXwTMi6DybKQ1S6U51ngW0/Bqf/u0lrWL3B8xsJ
         er3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505171; x=1766109971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UW8ta2pE4L/+9Yv6ju5XY9TcpGvPkrqtEfI1VIl2bA=;
        b=qM4aMvTxFvjiUx26Z5MkSDdOWYItqgZ/4ruSSW8SWJU2LGvjvD9nHEmukcjFGU/gae
         KRt6vdAcKKHrdYtwlisWoDBiGUpmFm647xZpVsq3Hd9F8RiKOJTXuW91FfIEnbPzh/3C
         e08E9NcL6x4pYBfoP0QLz9gaAd8dMwayGTtX3lZ59jnjowPgPndSo+yii/50CLRGbH+q
         0lKpwWTRpo5Nk7ODJnevC+CRn8YzHjbHVnHypqO+6khF1kyPhAP82tvPhCBQuuVJvtjq
         k8UiULwUqoKrxU3snZ0u/WDglGyn01FTHAkLfn2TDTxe1o5eC18DH72icw3qK9MzxfSM
         Y/QA==
X-Forwarded-Encrypted: i=1; AJvYcCUdqdaiSjAlsROoVkq5u87toDGdyz3PPIxXMSSTW0y80s9dofzVQHG23v6u/4Srlb+yF4ewQV8VGAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wSjopcM34Wyuqsak9pxAmMegPGjRroruXy2cr+sdZyKmHA9v
	TN8Ej41+Hn0fo0frkxQbGts76vSTSXJTDY0lA/VSeB9UHT7SOODcasQK
X-Gm-Gg: AY/fxX65pK0DdBy7RdM0EW4aKcd0sMQdf/0xgpvp58uen/3urlYeW5zbuxOsFjw1Nc0
	mBmFWx2EIMMqlanRPPaBcrCD1QY7ky8bYQuq2yEt1HMZAEvM0mbvnTYDfPyWG833S0ntc75oPxg
	XQADqKuAwvxCcKUx7i2oX5j3aQPBzhQyIovIJ1ASg+dYhHu36h32iQh+rQER3IfXKid+7ngWq7G
	4qeVBEHxIlrFSjz5LjJJpqEWki+uN3VuzO7psB7tEAUjSGctXfh7QSak/bMlfOuGt9WB0Cz4UJz
	3u24RJN9DIgE8SG92fCYyt8D420GpKemelYbILdaS3Ij6r5vs5xUTAJe1EvEjab8SCkE02NC7g5
	yUR7FsfdBmI91RjKTLMpKkJsbZIgiH5NyjMEJwI/RxL6aY7reHLgyHyFBtl7c7d749PQJIIZvIH
	CUS3q/cXf+ZHfNVao3BYN2
X-Google-Smtp-Source: AGHT+IGSWde9J7Z1CP0kykXZdi8BkMxbnhMLXy73Xa4qFfGp95pPa1k3E1/AVaVXLlBhIIxrLowN/A==
X-Received: by 2002:a05:7022:f303:b0:119:e569:f610 with SMTP id a92af1059eb24-11f349a1991mr358648c88.9.1765505171307;
        Thu, 11 Dec 2025 18:06:11 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb3b4sm12959928c88.4.2025.12.11.18.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:06:10 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
Date: Fri, 12 Dec 2025 10:05:02 +0800
Message-ID: <20251212020504.915616-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212020504.915616-1-inochiama@gmail.com>
References: <20251212020504.915616-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Allow the driver to use DMA phandle args as the channel number, so the
DMA multiplexer can route the DMA interrupt correctly.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 23 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..62bf0d0dc354 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -50,6 +50,7 @@
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+#define AXI_DMA_FLAG_HANDSHAKE_AS_CHAN	BIT(3)

 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
@@ -1361,15 +1362,26 @@ static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
 	struct dw_axi_dma *dw = ofdma->of_dma_data;
+	unsigned int handshake = dma_spec->args[0];
 	struct axi_dma_chan *chan;
 	struct dma_chan *dchan;

-	dchan = dma_get_any_slave_channel(&dw->dma);
+	if (dw->hdata->use_handshake_as_channel_number) {
+		if (handshake >= dw->hdata->nr_channels)
+			return NULL;
+
+		chan = &dw->chan[handshake];
+		dchan = dma_get_slave_channel(&chan->vc.chan);
+	} else {
+		dchan = dma_get_any_slave_channel(&dw->dma);
+	}
+
 	if (!dchan)
 		return NULL;

-	chan = dchan_to_axi_dma_chan(dchan);
-	chan->hw_handshake_num = dma_spec->args[0];
+	if (!chan)
+		chan = dchan_to_axi_dma_chan(dchan);
+	chan->hw_handshake_num = handshake;
 	return dchan;
 }

@@ -1508,6 +1520,8 @@ static int dw_probe(struct platform_device *pdev)
 			return ret;
 	}

+	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_HANDSHAKE_AS_CHAN);
+
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);

 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1663,6 +1677,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "intel,kmb-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
+	}, {
+		.compatible = "sophgo,cv1800b-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_HANDSHAKE_AS_CHAN,
 	}, {
 		.compatible = "starfive,jh7110-axi-dma",
 		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..67cc199e24d1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
 	bool	use_cfg2;
+	bool	use_handshake_as_channel_number;
 };

 struct axi_dma_chan {
--
2.52.0


