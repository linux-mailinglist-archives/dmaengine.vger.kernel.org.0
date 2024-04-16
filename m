Return-Path: <dmaengine+bounces-1848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2748A7164
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE7284999
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAA13342A;
	Tue, 16 Apr 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZTl3mK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD913328B;
	Tue, 16 Apr 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284960; cv=none; b=lXId5QB5Js7KP5ZFCN9PNwJoBv+K1Xyv76qGv9RSIGYzsKQJKUFHw/Qelquz8IOHdt5452iPbnokLEMrJIoSGi+oFp0pGmGpCC8mlV+X0C5VxZMQJ+2Lr/uANNec2EHSuF/7NWLQKRuNSaUhu7a1Vf6uYn3SQI8ZqLedPiMAYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284960; c=relaxed/simple;
	bh=QEwzQy4hq0flQyUiPAaECkev0IJ3+RmQQ2iYPOnd8YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8VH7yrYXHN3UIy36+HEH746fFp07liwe+s8GqygokcYsyc43Prj5PHBETCVZetNzyvJza5C3fK1M5pqgspHjvYuwNE6VKRzEl0lAozSJoDcR9HcY10NST7K/MZnsUUzCQFCA/EMJGrooehXaHyczgRURsc48kRMnhavL9KjyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAZTl3mK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d3776334so5983749e87.1;
        Tue, 16 Apr 2024 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284957; x=1713889757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+iM86l8TbMCs++JnytXC9niCPvo0pgTAJ4DYQyJ6t0=;
        b=hAZTl3mK8eJa842V0ZNy9b7brorVbGPYVI7W7of7dgXfi+xDUseTaUl7hCC+qTRadr
         ff7XrCzTAvyuTcg6ddYfzQH0hvmsCWteTyudN9+Gh1DKi9JFzzEpx4xUi/xVJfAb/kGm
         Dkqge4jBolWNVdfg6/e6WFI98hkMN03NHDq0ZXPnYtCdKusKky/w7UKVkr8MAGnC1Zax
         9/10hFjMUDXHKvaI1Q5wfmyQWNeBqSmUMnjYnElsDvgNeg+6KYNgb+bbMIkoaKdfUmBi
         fZ0Svdng+bczmnuHWQjW5t+gDgRq81UcKwhrAo3XKlaGammcR4F0+pcievmKpOz5lNwc
         7iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284957; x=1713889757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+iM86l8TbMCs++JnytXC9niCPvo0pgTAJ4DYQyJ6t0=;
        b=sips36LczQy4Tv/WCenJTFHNVxuLLvV3Jm7U/5pd9ZLQBzfeubSFuDbbviiYZheYQ5
         aNlU3B8n7Wk+0KFULEGeLoqegxt+ZWug+0K2Celw3rpD4gZt6ChLSGL/1XhjhsuQRDpH
         lwSwvqQqWIa5svKEVP6Eb9mABGlHV6Kw8odAXwrvwtklfAYc4n5r9d2H5GZx3HqSfwXI
         aZwnc5FQ5I6jZgpgiHt24KK0MOaKlhmQwwb6FdzC7DWMJX57NNxwK6ocQvj/nSeVaQpS
         Oh9tTUcLt6KeUGgJqnLNHFItQUlgrI4RbN1iPtHY5gvW4E35578LIGkaULW6fXAeIZL2
         04PA==
X-Forwarded-Encrypted: i=1; AJvYcCUf5VOKQAl+VLI45WkGsFGfw5us0Nh7un7+x7/d3XLxnedwHqpWdkJw5aNKImmCv5BwdBawi4B6XRbmbvttMyFsH2AD6VlUmG+Lhs1+x6Zt4XF08CuOmraauCMZdlcJgIJpTkdm8EW8vsK+ZMInxolID81aJ5/iuj7Q3cjljkjHu4vVGF0m
X-Gm-Message-State: AOJu0Yw4ALFO+9NrseXo24k2is26wpVMBAStde+tkVqKVDOHofmsEsyD
	buTL2WnsqJOAAJE6GQLVPTTJ0js7yQvhc3U6/bfyfrRt93oCuTil
X-Google-Smtp-Source: AGHT+IGNEyR2lUrnboOQWsBT/5PQIlRhzBj46Qht3EE3SMLnHiDnAPhnJbOHcl367zY5XbJPrkB7rA==
X-Received: by 2002:a05:6512:3e23:b0:519:29a2:d4b3 with SMTP id i35-20020a0565123e2300b0051929a2d4b3mr1892299lfv.15.1713284956976;
        Tue, 16 Apr 2024 09:29:16 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id l21-20020a056512111500b0051901751d0esm486618lfg.126.2024.04.16.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:29:16 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Date: Tue, 16 Apr 2024 19:28:56 +0300
Message-ID: <20240416162908.24180-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416162908.24180-1-fancer.lancer@gmail.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in case of the DEV_TO_MEM or MEM_TO_DEV DMA transfers the memory
data width (single transfer width) is determined based on the buffer
length, buffer base address or DMA master-channel max address width
capability. It isn't enough in case of the channel disabling prior the
block transfer is finished. Here is what DW AHB DMA IP-core databook says
regarding the port suspension (DMA-transfer pause) implementation in the
controller:

"When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
still be data in the channel FIFO, but not enough to form a single
transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
disabled, the remaining data in the channel FIFO is not transferred to the
destination peripheral."

So in case if the port gets to be suspended and then disabled it's
possible to have the data silently discarded even though the controller
reported that FIFO is empty and the CTLx.BLOCK_TS indicated the dropped
data already received from the source device. This looks as if the data
somehow got lost on a way from the peripheral device to memory and causes
problems for instance in the DW APB UART driver, which pauses and disables
the DMA-transfer as soon as the recv data timeout happens. Here is the way
it looks:

 Memory <------- DMA FIFO <------ UART FIFO <---------------- UART
  DST_TR_WIDTH -+--------|       |         |
                |        |       |         |                No more data
   Current lvl -+--------|       |---------+- DMA-burst lvl
                |        |       |---------+- Leftover data
                |        |       |---------+- SRC_TR_WIDTH
               -+--------+-------+---------+

In the example above: no more data is getting received over the UART port
and BLOCK_TS is not even close to be fully received; some data is left in
the UART FIFO, but not enough to perform a bursted DMA-xfer to the DMA
FIFO; some data is left in the DMA FIFO, but not enough to be passed
further to the system memory in a single transfer. In this situation the
8250 UART driver catches the recv timeout interrupt, pauses the
DMA-transfer and terminates it completely, after which the IRQ handler
manually fetches the leftover data from the UART FIFO into the
recv-buffer. But since the DMA-channel has been disabled with the data
left in the DMA FIFO, that data will be just discarded and the recv-buffer
will have a gap of the "current lvl" size in the recv-buffer at the tail
of the lately received data portion. So the data will be lost just due to
the misconfigured DMA transfer.

Note this is only relevant for the case of the transfer suspension and
_disabling_. No problem will happen if the transfer will be re-enabled
afterwards or the block transfer is fully completed. In the later case the
"FIFO flush mode" will be executed at the transfer final stage in order to
push out the data left in the DMA FIFO.

In order to fix the denoted problem the DW AHB DMA-engine driver needs to
make sure that the _bursted_ source transfer width is greater or equal to
the single destination transfer (note the HW databook describes more
strict constraint than actually required). Since the peripheral-device
side is prescribed by the client driver logic, the memory-side can be only
used for that. The solution can be easily implemented for the DEV_TO_MEM
transfers just by adjusting the memory-channel address width. Sadly it's
not that easy for the MEM_TO_DEV transfers since the mem-to-dma burst size
is normally dynamically determined by the controller. So the only thing
that can be done is to make sure that memory-side address width can be
greater than the peripheral device address width.

Fixes: a09820043c9e ("dw_dmac: autoconfigure data_width or get it via platform data")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw/core.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index c297ca9d5706..61e026310dd8 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -622,12 +622,10 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dw_desc		*prev;
 	struct dw_desc		*first;
 	u32			ctllo, ctlhi;
-	u8			m_master = dwc->dws.m_master;
-	u8			lms = DWC_LLP_LMS(m_master);
+	u8			lms = DWC_LLP_LMS(dwc->dws.m_master);
 	dma_addr_t		reg;
 	unsigned int		reg_width;
 	unsigned int		mem_width;
-	unsigned int		data_width = dw->pdata->data_width[m_master];
 	unsigned int		i;
 	struct scatterlist	*sg;
 	size_t			total_len = 0;
@@ -661,7 +659,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
 
-			mem_width = __ffs(data_width | mem | len);
+			mem_width = __ffs(sconfig->src_addr_width | mem | len);
 
 slave_sg_todev_fill_desc:
 			desc = dwc_desc_get(dwc);
@@ -721,7 +719,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			lli_write(desc, sar, reg);
 			lli_write(desc, dar, mem);
 			lli_write(desc, ctlhi, ctlhi);
-			mem_width = __ffs(data_width | mem);
+			mem_width = __ffs(sconfig->dst_addr_width | mem);
 			lli_write(desc, ctllo, ctllo | DWC_CTLL_DST_WIDTH(mem_width));
 			desc->len = dlen;
 
@@ -813,6 +811,31 @@ static int dwc_verify_p_buswidth(struct dma_chan *chan)
 	return 0;
 }
 
+static int dwc_verify_m_buswidth(struct dma_chan *chan)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	u32 reg_width, reg_burst, mem_width;
+
+	mem_width = dw->pdata->data_width[dwc->dws.m_master];
+
+	/* Make sure src and dst word widths are coherent */
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
+		reg_width = dwc->dma_sconfig.dst_addr_width;
+		if (mem_width < reg_width)
+			return -EINVAL;
+
+		dwc->dma_sconfig.src_addr_width = mem_width;
+	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
+		reg_width = dwc->dma_sconfig.src_addr_width;
+		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
+
+		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
+	}
+
+	return 0;
+}
+
 static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
@@ -822,14 +845,18 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
 	dwc->dma_sconfig.src_maxburst =
-		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
 	dwc->dma_sconfig.dst_maxburst =
-		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
 
 	err = dwc_verify_p_buswidth(chan);
 	if (err)
 		return err;
 
+	err = dwc_verify_m_buswidth(chan);
+	if (err)
+		return err;
+
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
 
-- 
2.43.0


