Return-Path: <dmaengine+bounces-2570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D206A91ADE9
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DC628685E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71819AA68;
	Thu, 27 Jun 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtSv0QrV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80519AA41;
	Thu, 27 Jun 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508969; cv=none; b=Ng2A81CAbgy5HVNTjgVi5Vw4luNq2jTmE+4wRZwUfZUszZV7cG84I4G0zg0GC4Nuuevja1D0rrsXicMMFLadNr7gS1fkhIyxXCnabmKYBgjI+vBv4BuHhQ1Y1MAtusW2SJAnqNyUPduwhrx6amNQiyjoet1rSA4JwOoq/WNmwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508969; c=relaxed/simple;
	bh=fpQL+2Ui54/50vZusa3FnI4hmiiTnnsXAfE1S+7AyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTKhPfAnejmP0G2FMxwzPCXwpYbZN1eLYcoI5p9Y7fC3UoLvi8U3vC39a/dwg572feRaJ2fq27c2BSEQc+Oc+5Q16fotce0jRfXcXfetHXhHnVInxAK1z+fyAUna9gFffo8DB5R0jOKc+a8Oc1ldb7yH/78nCg2MHJtTvSxtIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtSv0QrV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso65157401fa.1;
        Thu, 27 Jun 2024 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508966; x=1720113766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qshpIny+GIJeG9aHZTifG+SU7u9xJlQ4LhmZoe7c33c=;
        b=RtSv0QrVJJtSD8r49B4/JTxiQdWF6yJCOuSESwtGHbrvSNXuWvR8Qbu/zGr/WxGgBU
         CLqMdpsQ0Wytk2h9+SDa1pGYoW3XgHT1qmL3B6+fAahgp9bfw8VThnI7tE8i1c2zFm7Z
         BSeblUmqIzMby52vtalSEtjBeE7Xr5rr8LKO+OJ0h9IpFXLqfg34GPevBc0+KZBQmYU6
         PWw8c0mrYE+r7XpO5DAOs6I7a55xldvHiqlOKRlx0QLEhnfj7i7xDP8A2A6TUrt94Uby
         oUUf5miLXFzjqtY1fup1RxAolw2V8BVwE45eRk9WGAYiCWMxX1meLDUMz51UPm7OTmCo
         deFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508966; x=1720113766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qshpIny+GIJeG9aHZTifG+SU7u9xJlQ4LhmZoe7c33c=;
        b=nknLjfd5k066rBrGx3yVvZgc4N/Yv4P4+XWfiq/m+Zl+gObScxUoGY/hcXklxo5f46
         2N7uw+5ygr5pvsShyYXzZHBSVJeFLHicCACTYpDiHQlOp0Cst4C0/4qodojGSbwpBQGm
         n7vRerI1l618cGqlSlpQ8IoslFCtaL13xK9nbnKwapANB/AXQcuxyUaVCe1E2prAsOM1
         Yqd+c536SvY+44VqHr56+qARGUIUB6nj5rTtFCL0fdi0MwaPpeH65DVG2uXhZ0sPNRhC
         Y7MRyTmAbIH8CbApBtMWxtNO1GZAYLIRxQtFNzhmsonjiFTck3Pk8GCdgEQHtNiawVXh
         syow==
X-Forwarded-Encrypted: i=1; AJvYcCXjgCibjoOsEVdH+KldWbA1cRb1mz7MCiesqDVSuw1sLdnFK/iO/3R0QKPukwsMQrd5+nR0aKCP4wDBG6u/75jN5hLfXoJ5JUDooDJh1vjoeyOoWTh/rifaMUijbwDUchlyRh1mTTZG5gnnqUp2ov+HT4bb4OTsv6E+Knboj5f/+ar0q7ck
X-Gm-Message-State: AOJu0Yz8KfG+dD9fecGtlduA07lMhZ7cGys41nXyqJkAL6mQXo+rMQQd
	pUx7rwB5la8z5G67S0kveAAAdfMV4j+y/z0i/PZEiIap/WIk5mrd
X-Google-Smtp-Source: AGHT+IHx46h+d8fbVwKoHa+U98hTA2A4hQgJw2PrEQQzJfYoKJ34aUUvdUmXcD1626dI7Ee3kJTb+A==
X-Received: by 2002:a2e:9596:0:b0:2ec:55b5:ed50 with SMTP id 38308e7fff4ca-2ec5b2fd2d0mr101924481fa.5.1719508965834;
        Thu, 27 Jun 2024 10:22:45 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34f67fsm3253931fa.31.2024.06.27.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:45 -0700 (PDT)
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
Subject: [PATCH RESEND v3 2/6] dmaengine: dw: Add memory bus width verification
Date: Thu, 27 Jun 2024 20:22:18 +0300
Message-ID: <20240627172231.24856-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627172231.24856-1-fancer.lancer@gmail.com>
References: <20240627172231.24856-1-fancer.lancer@gmail.com>
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


