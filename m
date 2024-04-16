Return-Path: <dmaengine+bounces-1849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423598A7167
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C1C1C2180A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506F1339B5;
	Tue, 16 Apr 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtRzuXP9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF113341E;
	Tue, 16 Apr 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284962; cv=none; b=RXdFmao+bxP05U9dfzwGcAw8NumqmZqcTfjGUfOQjEWufJEq6zYAJpaES4ZvHtEL64wQ7vkJNnictIMuj3hcUn98S6ZRCi0Rf+XTCGpCWBeDY1wOpUfX517AF9PG8XJd0BU2fglAQgs0viHRmyFYvA25p4irFkDSzqKl02zDm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284962; c=relaxed/simple;
	bh=9TZDexUWMrvyNTz945MyInpdtCzKkNOQXNDF6Q4i2sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H08i3afyLzC5pfg+kMafLluD1KX7NsHLYQm4bDKUYrtjkTCQjhzqZIT9BqCSbpBTjjQojWkJSC0OKFDpriZDcLqmrXELUEYPX2N2DYw3DNpm4GCr8GLF1+Xw7MwLibon09eouk5OKndIB8v1mXxfcRFe0U6Xzqe6rvGOE27dxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtRzuXP9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d727074eso5973349e87.0;
        Tue, 16 Apr 2024 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284959; x=1713889759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fryuWq8aUUJjTuLOMY39ltR5o86CjDEksNCZ9CfWDGA=;
        b=XtRzuXP9J3fGiHK0yq0ZB1wcy6cwdRhqPDArY8WKbRRSbpyK+ckaPM6udK2D8+jON2
         AiGzIgwdqnbtR27Ed5VaDUOtkDYm8GBoeg83FHOLAQU30yz2K9DvEVFJvUQloGNiuisc
         nSPL8+vU6PdyIl0wxtci3sFzhsOWzOmAt8dRNGX06Twqv/XVdkEJM+eXcLoV972G+NMI
         9l2/hpgP3AsnPi5R8rkyQ6FWaag20sNgupictjodVI8upHIDV7mKQCOTrClnGEKYbts4
         Nh6QLKI1vRIxSkVrHYekhrqpXbidQuYadqJthvPFcVrEYshJdnyEiwspur+6IQds29iB
         Js3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284959; x=1713889759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fryuWq8aUUJjTuLOMY39ltR5o86CjDEksNCZ9CfWDGA=;
        b=OJV9qkmKI3HpfSqW3nPzr7ZNXJZRBaZB7JCLeFjACv5qhTEFDu1w7t3f1yrD0mpGPH
         FME7nOKyJeZHOL3u7wB099F00RFzUm2VWhQ0F8IlOaqU29TD3DaijHbE6y13i2HtWlzc
         JoARfJ/afK9SxVfcQ1uqCgJ3ZzHctSBJJWHzWv7eOGwsz0YWV+lVeqzfQA4/iuCaF1g3
         J/iUPZdpjLQuNSRdTgoV9kkKj5tldl0fykM8ZdZiHVaVuyXSGAw/6UWHM3xY+/K0BOph
         n1TU4SuzQaHWdhE2PzX5xJxlRbIFhH28R26LS9sjDzVVsUSD9gdGCtL8+pr7y5JmCAmO
         qkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8I9LlGRwKMMHBoCAtKtdIuX1/PY8Jk56dKwIg1R5IuMbleIY6ZV8dBbLP/E37A0fqbG0J/HJXL0jDodBLFjcL0uou7FoEjW9GciIolUcUcPwUaJtt23W5za55ho5ckpi1jYdG3SOn7b2nbTjqTQsep+BFrxj1X4F/7+iS61oukYQ/Jvum
X-Gm-Message-State: AOJu0YwzgR8qtUYFAM1t8F+Vo2tYbM/Qp7Er7FJKlsHpKhzOiy76gfyi
	8iqRDbHZfy8YyfTqzoqM9BfYu1VQnECDA4AClOR05C8buA6o38ro
X-Google-Smtp-Source: AGHT+IE5q9vXkq/lF2ntfeN2wCfL4chOLtmupmo4LAw8TRx87/kDOCdcT/vFJOFqmygagbos6Mwugg==
X-Received: by 2002:a19:3806:0:b0:518:758f:2610 with SMTP id f6-20020a193806000000b00518758f2610mr7554152lfa.48.1713284958800;
        Tue, 16 Apr 2024 09:29:18 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id p8-20020a056512328800b00516d123f3b8sm1630127lfe.59.2024.04.16.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:29:18 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Date: Tue, 16 Apr 2024 19:28:57 +0300
Message-ID: <20240416162908.24180-4-fancer.lancer@gmail.com>
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

Currently the CTL LO fields are calculated on the platform-specific basis.
It's implemented by means of the prepare_ctllo() callbacks using the
ternary operator within the local variables init block at the beginning of
the block scope. The functions code currently is relatively hard to
comprehend and isn't that optimal since implies four conditional
statements executed and two additional local variables defined. Let's
simplify the DW AHB DMA prepare_ctllo() method by unrolling the ternary
operators into the normal if-else statement, dropping redundant
master-interface ID variables and initializing the local variables based
on the singly evaluated DMA-transfer direction check. Thus the method will
look much more readable since now the fields content can be easily
inferred right from the if-else branch. Provide the same update in the
Intel DMA32 core driver for sake of the driver code unification.

Note besides of the effects described above this update is basically a
preparation before dropping the max burst encoding callback. It will
require calling the burst fields calculation methods right in the
prepare_ctllo() callbacks, which would have made the later function code
even more complex.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw/dw.c     | 24 ++++++++++++++++++------
 drivers/dma/dw/idma32.c | 14 ++++++++++++--
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index a4862263ff14..c65438d1f1ff 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -67,12 +67,24 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
-	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
-	u8 p_master = dwc->dws.p_master;
-	u8 m_master = dwc->dws.m_master;
-	u8 dms = (dwc->direction == DMA_MEM_TO_DEV) ? p_master : m_master;
-	u8 sms = (dwc->direction == DMA_DEV_TO_MEM) ? p_master : m_master;
+	u8 sms, smsize, dms, dmsize;
+
+	if (dwc->direction == DMA_MEM_TO_DEV) {
+		sms = dwc->dws.m_master;
+		smsize = 0;
+		dms = dwc->dws.p_master;
+		dmsize = sconfig->dst_maxburst;
+	} else if (dwc->direction == DMA_DEV_TO_MEM) {
+		sms = dwc->dws.p_master;
+		smsize = sconfig->src_maxburst;
+		dms = dwc->dws.m_master;
+		dmsize = 0;
+	} else /* DMA_MEM_TO_MEM */ {
+		sms = dwc->dws.m_master;
+		smsize = 0;
+		dms = dwc->dws.m_master;
+		dmsize = 0;
+	}
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize) |
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index 58f4078d83fe..3a1b12517655 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -202,8 +202,18 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
-	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
+	u8 smsize, dmsize;
+
+	if (dwc->direction == DMA_MEM_TO_DEV) {
+		smsize = 0;
+		dmsize = sconfig->dst_maxburst;
+	} else if (dwc->direction == DMA_DEV_TO_MEM) {
+		smsize = sconfig->src_maxburst;
+		dmsize = 0;
+	} else /* DMA_MEM_TO_MEM */ {
+		smsize = 0;
+		dmsize = 0;
+	}
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
-- 
2.43.0


