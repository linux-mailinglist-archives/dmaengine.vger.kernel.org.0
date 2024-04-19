Return-Path: <dmaengine+bounces-1909-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3F8AB498
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA75B235FC
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530913BC0E;
	Fri, 19 Apr 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLZ8T2sc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0E13B28A;
	Fri, 19 Apr 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549453; cv=none; b=fwztCN+RPaU3/+LZnfX34ecuErh+cizCGpkB5EstpqYqpjSXS8cWlvbd2oTiYwwu87xQEcca/wlrQYuWQkdq8JvvKX3L6G1AyiavVxxiawuqy3pFHGvjNYKSjyy2lj2sh+YblBIPDQnOkPO5eLV/UvPLXnH3vD5gJLaGrklyt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549453; c=relaxed/simple;
	bh=HE/gBLYoq3YOFcYSah+Q4/Z07EhWJT3vDtkUn+oRy0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alXE2aK2O3y+Ld+f6Zl2m9XujjlFZ+bVdRhtU2t2DFycZ6WqbMGIXMgFFQ/wEhtAqDUz1/3czpltKNZ/z/pEdAf0wZYz9fiqYYMZRhOdpUxY3I4LAAaJ/ClOiH+qQUS7QSCPT7+NklpTQUMi8DbD5z3ZhKmkLqtquh5WXXmlg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLZ8T2sc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5194a2cf7c2so2506164e87.0;
        Fri, 19 Apr 2024 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549450; x=1714154250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lS5bTkP1B6ljd2Myp+Kpm68dJUaLMTKGqzv1HIMuo8=;
        b=eLZ8T2scAUNHl/BWVlFFxpAqHZt4hjl8YB9bwN35T39jZYCfwlEHMJcmug3jz4AX69
         KFhTm4v2xsdRZ38LTXGEWkys9GKaFSDO4vuVuQcrqmbxaKvpRIYiZP/tk/GNe2Cm5Qwh
         8MpeT0jefupr5iEqrTQ0leZ4hLJ3scXGFz88qzScOYRXMEUbOLx6CwF0wmoGshNGYDdO
         fv7gZs5LCXYTXiD1MzlHA37HNHuET2MRv6xCwVy2bh5fCmChlyhDJ3e7aGF0Sr7piFTe
         YtR94LNNTcUw3qq1dkusEA/hByQ2NNBqEELOCTJfSFgQqiqKJEjvsgA96fzRt5NezR2h
         KIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549450; x=1714154250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lS5bTkP1B6ljd2Myp+Kpm68dJUaLMTKGqzv1HIMuo8=;
        b=uXBaPplsIRo5EPkms51kjbgA6q43Clh5ZXiPh3tSJTOyaep2nDQAnRhPzOnI9NEipS
         TY3EtrjKY51RHJoOBGboUpHImzey32kthIvUr2xOYq93ViL4R/fKTyeoo3eTSFNIuYpJ
         98MI7kTDTZ5Fo/rKJwoShOrO2tQFpQqbsZQDCXy6YKtiwmat+b0thRepsEon4v4dx080
         HveelSg9/LIBIPVOeA7F4elH4AM57i5erkDF2Yygl1vp5JuXLpVgcyZI8OjaRHt1gpxo
         yYhcgkpiAEJhoIsRdcxRQaoPBOAa6a+gLMznXYhZw9e4gHSu1dgUlbPGNjfGqtNObrDg
         3MZA==
X-Forwarded-Encrypted: i=1; AJvYcCWPdXtFCAK9i1Dtm6t3U0CkZz8Um+y2Rj4yli1OXzHaw2jXyszCyTqVm9Gz/KvFG/4aR3MYdICHehXovRuyFR0m6BdO7nyN6zbHRmKknmSv88FJIYyUbe5XiVv0LdY2tb49Yx+OQW5ePs/fG6KUroezeekODbNCNWzE2m49IXtFUJdedqjJ
X-Gm-Message-State: AOJu0YxW4vDKfsSqRCAkfwPG9hSWooEhyDgEyjxC0ufgzEkaCXaoZjFC
	0O9GohjyJjPtVSfeW/LRMo5mlX1Tl8qz9IdQZ7tyNKpHEVoly1tY
X-Google-Smtp-Source: AGHT+IFpPfWg/MhO4KX+/nNymQMbITdg/rC/UF2KkDxHhPNNzaFslWO4x+v8DDYXiMLipR9yJzRwpA==
X-Received: by 2002:ac2:596d:0:b0:518:bc7c:413a with SMTP id h13-20020ac2596d000000b00518bc7c413amr1713710lfp.69.1713549449891;
        Fri, 19 Apr 2024 10:57:29 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id o8-20020a05651205c800b0051901751d0esm796047lfo.126.2024.04.19.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:29 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dmaengine: dw: Add peripheral bus width verification
Date: Fri, 19 Apr 2024 20:56:43 +0300
Message-ID: <20240419175655.25547-2-fancer.lancer@gmail.com>
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

Currently the src_addr_width and dst_addr_width fields of the
dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
properly aligned data passed to the target device. It's done just by
converting the passed peripheral bus width to the encoded value using the
__ffs() function. This implementation has several problematic sides:

1. __ffs() is undefined if no bit exist in the passed value. Thus if the
specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
unexpected value depending on the platform-specific implementation.

2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
bus-width out of that constraints scope will definitely cause unexpected
result since the destination reg will be only partly touched than the
client driver implied.

Let's fix all of that by adding the peripheral bus width verification
method and calling it in dwc_config() which is supposed to be executed
before preparing any transfer. The new method will make sure that the
passed source or destination address width is valid and if undefined then
the driver will just fallback to the 1-byte width transfer.

Fixes: 029a40e97d0d ("dmaengine: dw: provide DMA capabilities")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Add a note to the commit message about having the verification
  method called in the dwc_config() function. (Andy)
- Add hyphen to "1byte" in the in-situ comment. (Andy)
- Convert "err" to "ret" variable. (Andy)
---
 drivers/dma/dw/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5f7d690e3dba..11e269a31a09 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -780,10 +781,43 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(dw_dma_filter);
 
+static int dwc_verify_p_buswidth(struct dma_chan *chan)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	u32 reg_width, max_width;
+
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
+		reg_width = dwc->dma_sconfig.dst_addr_width;
+	else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM)
+		reg_width = dwc->dma_sconfig.src_addr_width;
+	else /* DMA_MEM_TO_MEM */
+		return 0;
+
+	max_width = dw->pdata->data_width[dwc->dws.p_master];
+
+	/* Fall-back to 1-byte transfer width if undefined */
+	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (!is_power_of_2(reg_width) || reg_width > max_width)
+		return -EINVAL;
+	else /* bus width is valid */
+		return 0;
+
+	/* Update undefined addr width value */
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
+		dwc->dma_sconfig.dst_addr_width = reg_width;
+	else /* DMA_DEV_TO_MEM */
+		dwc->dma_sconfig.src_addr_width = reg_width;
+
+	return 0;
+}
+
 static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
 	struct dw_dma *dw = to_dw_dma(chan->device);
+	int ret;
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
@@ -792,6 +826,10 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	dwc->dma_sconfig.dst_maxburst =
 		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
 
+	ret = dwc_verify_p_buswidth(chan);
+	if (ret)
+		return ret;
+
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
 
-- 
2.43.0


