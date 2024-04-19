Return-Path: <dmaengine+bounces-1910-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642F8AB49A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CD41F228BE
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC613C825;
	Fri, 19 Apr 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW8t5eqI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59D13BAFC;
	Fri, 19 Apr 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549455; cv=none; b=IrWYNdlgTLB6OBPSU7TeWxFro6N+UumC4QaBjQjSRFxfobxyNl2o4HC6J05M6daeLexgE3UdLiAqZnD/YN0bbRG3MDJeo3GDQ+sw3UYIbKRzqk61MZITJuXnh0f1Ck/2WUVZnw15zoDr0XWhr3oF8QNR60bsemg03LaVom0I8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549455; c=relaxed/simple;
	bh=fpQL+2Ui54/50vZusa3FnI4hmiiTnnsXAfE1S+7AyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh2g44BvZwJDBMfyZr5Bqublc/KEPUSWMHhCgR/XxDzNZLBfPN1Kft86TnnDX33ANS6v4QuxxxTcVWmLbYp485qtXowJrBiqHTX+pLWz8aRxpB4MpSz7NI+uAGNwd4MOyqYWzHtcfTPjknyTi2pz9xxDtD1XLKtP5MD1p5ZMV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW8t5eqI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d715638540so29017281fa.3;
        Fri, 19 Apr 2024 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549452; x=1714154252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qshpIny+GIJeG9aHZTifG+SU7u9xJlQ4LhmZoe7c33c=;
        b=HW8t5eqIEMQQ4Chc8IWOtt/sjjivSpQXctiJjimelWo2Fag6/HF46gzgPFLmMKRqaD
         kKee3cNHgnWWWcNei2uOwmdjnosNWjNH2b9R3AErfZ899qbOPlNSIQcmHKmHxVSt2v5S
         3yxrbt2pQk17mtE8If6cX2ydIPH46BZ9jLiTRboW636y7wWmLJ4DVSbkHzT46zrVEGu2
         y872VNMfhkOvtOMO3YsbHt5BAu1jrdGNs7uuAyFx1LrsdpiDDzYFf2JyWSHFN4jmS4K1
         2MaX3BSsIYAUjk3OiYwlw8KDDODDkSv+A4brUDmmoAK52wxQb7Av96QLXiysnlaT8WLc
         ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549452; x=1714154252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qshpIny+GIJeG9aHZTifG+SU7u9xJlQ4LhmZoe7c33c=;
        b=Os5JWFCEPcx9AOsRjNvByNKZv9SFCTdjRY5moZeiKv0viNgdRWHZztQ/5bTINFMoOu
         CWBppeQRt12e6/99MCFyRV6bdNBMqSJ4YbzjBO/ntwWHVAt0eOyknSXi/mlT+5qDPtKw
         BZ6gmsz6pdFkzMY2TmdA/WtbljzveM1IRvRti6uxcCH9j/8RnSXu3S/7lpgQ495enu5f
         TesLXH2FKtzSYao6uEarTO3bksJjU4vBkrlJagooHlv8z3vcC8c8vT5O+nzKJzqn3h7Q
         iPrMox7FuK8NV++Lf7HnLRcMWSGPMMREF68cncB7E11ECCAzk62uJImCLRr/jrleozfR
         rv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX17ZBToa7Reuwsmf1y1FCipnNYSbe8xJKXmFy6SWeQe6nnSPLPkNkaIk98/hbbjRxrfERQq4CyDOq+CgnH1NNP9LhAmg6lgmwtFmZtLdGqyw09pY8ija0kjc+P9Jnb0j3y/usaCQoYuZiaghBb07uwT3b14qYCQ+wibfqfBJhpj5t9B/xL
X-Gm-Message-State: AOJu0YxbZt/ehDLFSU/8kXG+EpsFQfuJ0eEdhTv8S2O6lg3FD2eP0HM9
	sajYceAKkg8uxXzRmPZ58TdunYF+fKnpi96i+ScuA7RUMeS8XQUs
X-Google-Smtp-Source: AGHT+IHRF+3swaF7UDaRKycmT22eW8m4nji9gvBFswSwTy1cRwP/d9yc91zlPXJqX6Q3ikZaKnaLbA==
X-Received: by 2002:a2e:95d4:0:b0:2d8:8368:e22d with SMTP id y20-20020a2e95d4000000b002d88368e22dmr1818488ljh.42.1713549451778;
        Fri, 19 Apr 2024 10:57:31 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id a14-20020a05651c010e00b002d6a778816asm683738ljb.9.2024.04.19.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:31 -0700 (PDT)
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
Subject: [PATCH v2 2/6] dmaengine: dw: Add memory bus width verification
Date: Fri, 19 Apr 2024 20:56:44 +0300
Message-ID: <20240419175655.25547-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419175655.25547-1-fancer.lancer@gmail.com>
References: <20240419175655.25547-1-fancer.lancer@gmail.com>
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
that can be done is to make sure that memory-side address width is greater
than the peripheral device address width.

Fixes: a09820043c9e ("dw_dmac: autoconfigure data_width or get it via platform data")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Add a in-situ comment regarding why the memory-side bus width
  verification was required. (Andy)
- Convert "err" to "ret" variable. (Andy)
---
 drivers/dma/dw/core.c | 51 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 11e269a31a09..b341a6f1b043 100644
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
 
@@ -813,6 +811,41 @@ static int dwc_verify_p_buswidth(struct dma_chan *chan)
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
+	/*
+	 * It's possible to have a data portion locked in the DMA FIFO in case
+	 * of the channel suspension. Subsequent channel disabling will cause
+	 * that data silent loss. In order to prevent that maintain the src and
+	 * dst transfer widths coherency by means of the relation:
+	 * (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH)
+	 * Look for the details in the commit message that brings this change.
+	 *
+	 * Note the DMA configs utilized in the calculations below must have
+	 * been verified to have correct values by this method call.
+	 */
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
@@ -822,14 +855,18 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
 	dwc->dma_sconfig.src_maxburst =
-		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
 	dwc->dma_sconfig.dst_maxburst =
-		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
 
 	ret = dwc_verify_p_buswidth(chan);
 	if (ret)
 		return ret;
 
+	ret = dwc_verify_m_buswidth(chan);
+	if (ret)
+		return ret;
+
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
 
-- 
2.43.0


