Return-Path: <dmaengine+bounces-8389-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5CD3BD03
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 02:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1AF3048EF4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79031E3762;
	Tue, 20 Jan 2026 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSsIpIOY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7E248886
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873046; cv=none; b=seartlWHwyovjDxYgs0bKBKYFY89RPDjbqk2xAej5YZG1dxC+aWVwCmyRF2vafx/9PLrEWnDO+gb2xbkDqxxxuS/zvEmWoZ+xX31GkCSndyuZn/Pluj6HTET4sNQKX5pD9SHNDVMgPiDaMs61KdKxLcBs4tGRGWCPV0vXp3qSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873046; c=relaxed/simple;
	bh=m30+RpDNnkg8xHt7cNwbdu7n3SlrHrGfQYim0hkdS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnWk19Be5r6rG0in6JKeTFumDBoB/HJ2oTuoclPeZfzBhGqRbgfWOLk65P76I3D54kxqkb1960ZTN09bEBvhiOis0d86s/06+YlM5BIGR2HBG42csnSwXdogw/gIbi43h5BgB+MVtih2Jt1AP88HBf3LEJx8ky6+skJT2gC4BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSsIpIOY; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae5af476e1so2317138eec.1
        for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 17:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873044; x=1769477844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH82B8wM8CiGczLPrX3tBjZxmPDBBF0WQaYSUsGab4s=;
        b=ZSsIpIOYFTJsLe+qFjI0W5cIkmHH6YAQipC8Mep+ZL4uB3CpU6pGLNwPsyGSxJeCCg
         9nMD3JHKDYiEjNGZhH6KuD/JZMCtC+M0T0KCW+l2TEj8CjgROwt02rlckpBcNsDQVmFx
         g28oJhS7C+ddRk7YsmyKx1Rf2drF4zXOwCHEU/cDoFKofk39vNVXGRpoxM+eNSZigffp
         1+LHS/ew7I4NcVtmmSwBuKjy4gArRak/v8HU9braJjr+6zurCspuJTA3hhRsDmpasjUQ
         3DsOdQCCE877XLnjmJ+ajmT6MGNtkkBbmCFa08t1OTYquZtWBuk8GGSi8zCwpo2Rl5t+
         JrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873044; x=1769477844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gH82B8wM8CiGczLPrX3tBjZxmPDBBF0WQaYSUsGab4s=;
        b=IalaHGGyfRcmnkMlnB6eQToxDUsxfClpNVZ3zIqcW0Pvxc7B4kJP9LGa82rtdfx42m
         EcyvEwQc2+E6e1HCxj4D0+20mU6vwuQ17goc0cZ4qdVzhdj1FyaDmVVTnYQnowP1MZPg
         Hvf1vm4WVZlzSbdLW2W3fZ8r+BVyvdHFW/aai8Bhx3sqUOeaKK+VK/pXhwXtsBg1KCeB
         1ujBr0YlGBaH+7OsGwAzhyvMr2XrXYk8TEmwXMW+hnn3qGD4Uv28w1ajwLbmNX+NoTOv
         iOSQ6GlFM71rTXBzGtx67tpbI+T+rOCtTtBKLtBLlJoWsmocrzCTeIGV4Bey4golgsET
         cjSg==
X-Gm-Message-State: AOJu0Yxlpi71EaoJOlzZTwSZLTI9jV9zoEQpmnTK+W96Tr/8Kymd6EpC
	FwbWjGD2ZsTs6boqov4lFWNr8f3zPv81rzvH/Pm9CnDZVBorbR2NQzU3
X-Gm-Gg: AZuq6aL0FLuHfmOsH7eQNdWwwYFr5Ph9U9YKaOQnDXUdh8DDfghOfBdUv11GHwRokI1
	uJr6vJV3h98OxJEuSv1FGOx5/zpAHa+V9/S/CRrgzBm1cl1zqGmglUIAHoTkjXymFI76BKIZPIQ
	+mfCXDYB1BG4Jq53WJnkgH8LKyL09u+9c+RwuYHfSt4ZhRFzFRF/Ga52B274pCqpObsndHFaSJq
	dqX7NcgDsVOjxKzUvfMMa6nLGCLefa+UCQbDe5q6i/nV0oDGNn5ICjNqNTV22VVRyMZatnXJFkI
	XMe1VuFzsW1JgsIr/Ks97sr3BaWXenuDGw4NkPhgod/j7dU0zoKjYbGsivs4MGSZlWnGzGLXPfN
	jeMYlqc1P2GWzu/G8lYoBS3DW6HwGuJv4eIWxdrOJ34CSpWv0/bcJhBd6HxmEIfk3Zdl5z3fYi4
	Lx8LPqPMXqww==
X-Received: by 2002:a05:693c:6097:b0:2b6:b9c2:7b48 with SMTP id 5a478bee46e88-2b6b9c27beemr9582735eec.20.1768873042756;
        Mon, 19 Jan 2026 17:37:22 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm15297558eec.10.2026.01.19.17.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:37:22 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
Date: Tue, 20 Jan 2026 09:37:04 +0800
Message-ID: <20260120013706.436742-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013706.436742-1-inochiama@gmail.com>
References: <20260120013706.436742-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Allow the driver to use DMA phandle args as the channel number, so the
DMA multiplexer can route the DMA interrupt correctly.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..89ded0207832 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -50,6 +50,7 @@
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+#define AXI_DMA_FLAG_ARG0_AS_CHAN	BIT(3)
 
 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
@@ -1360,16 +1361,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
+	unsigned int handshake = dma_spec->args[0];
 	struct dw_axi_dma *dw = ofdma->of_dma_data;
-	struct axi_dma_chan *chan;
+	struct axi_dma_chan *chan = NULL;
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
 
+	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_ARG0_AS_CHAN);
+
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1663,6 +1677,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "intel,kmb-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
+	}, {
+		.compatible = "sophgo,cv1800b-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_ARG0_AS_CHAN,
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


