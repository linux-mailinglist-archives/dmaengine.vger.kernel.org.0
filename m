Return-Path: <dmaengine+bounces-2571-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE691ADEC
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62198B22BA2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F919AD54;
	Thu, 27 Jun 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrQXA5ac"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC919AA70;
	Thu, 27 Jun 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508971; cv=none; b=bgvLo0hKwwCGc0MYLnWYUKxcvy8WkI8wAJTtpkg267ECQbSCjfCmbIaw3upQojrHehFdoLDd4Amzf13sEBQKrGWf1+Q9IWC1JrHteG7bL8dUlUBe8e+jLW1WM9ig+hTL3CM5nZThWLO4aduq8a+4ad++pDkJ6TY+XDHl3Z6mZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508971; c=relaxed/simple;
	bh=klqYSawc9+NGO/zCAp0wyCL7LwvbZptI3bgjMK68bVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8SyQMRvbTPJ5nQgpq4SzT/WkG3KEVNQ8ys0hm2Q9YbBYC76Ut6rB/kw1DZmBaIeFBISZyaEYWy1AHohEdZOeGYdxgclUx006D+GDANad9UnDPhx8P93uxz3Odm08A8eXciL/s7rvOtTJSEPeEwTRCPQYP4meFPm6rSsrRWgtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrQXA5ac; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce674da85so5290543e87.2;
        Thu, 27 Jun 2024 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508968; x=1720113768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=jrQXA5achsyVcn5eE910YHsDuwnlBOtTKlYq9ffIYnn9CzBm3sfOYMbViRwWZ+lJeJ
         dFAcDIZP/qjfjdkZ+R+rCniRbzeTRU7x7AkhDb3hC20y9RALmHkQUC0if7dSTI7mQ1NA
         RV+c8wZdxHcG2c+22gAuMXfPjASruNRMGnbAXodI4+fqp1/q+QvH77Oaygo6RSF3WaYu
         jmpYfT3G7TVCthwPXe2smOpnIbnkbLwiJL0nm5C1gw/nu3RcBPDCFpIApdBMFKAtEdHd
         v75mgDIzlgYwLaySZ3St7s4DjiVp9uRpSnnqBqh9RwtllwT8pfrLZ3YBAMCXbVVVd2XD
         xqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508968; x=1720113768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=Eup/PuRd5WBWr2yWcplocwaJXleRV5P07EnBbqGkIm2Lsc2k6zy+Jz36obZd8IJae7
         eaU9HJuowvBY1kLLYUa7uXVaKONsS6tJhuHJLdeHcsYm+eaS7d0R7IY278oB2dVCcIis
         fNxuoiMVWxvto5+iABUwfQvPKLwpzFHuHyHAn0IbNTgob9GoJ++NE0CiioRgP6PeWlY/
         E+uipx5jAHscR68FxnYhBQO2hJtRc8M2Bb43ScDnCdg8x4hNTQgXtkKAGmcawS57tawh
         iycusl2lWL1LDbsRfzsKiBQbj/ZwNM8LRyNfnEKOc8JNbRJQVWKUoEplLh/fGHqDqUER
         m2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHv2AHGIoH8fA5NQVoLvzgKWNHUTzDpj/IIng+cLSf0dOOMezH7Iv7C4c/YyixYo6psZl7nKQdX0LJb+FmG15TTIp1HzBoGg6VnetHKJzNUgGrEThb32Ipotc29QJ0u+k92ZL0/2keFNLaMqkyA+qfSTAVrItS1xeXE2VLSvsh/j+YJigE
X-Gm-Message-State: AOJu0YzZmEWYATjILkginUg0NFdKKcNFTkPdnnmfgBuF/bjdL7JGAYqR
	0c6y7XXkB5hm/bgK4cSuBCmEx7Z9wt3BA7lbv2/no0YreAsZQLIW
X-Google-Smtp-Source: AGHT+IGh4XkamlP40fuEKOV4BaBgP/JJzsUdce1nGRPuSvsATQK0RszJNSwTndBnKq6e2kHeOW7/gg==
X-Received: by 2002:a05:6512:acf:b0:52c:8c4d:f8d6 with SMTP id 2adb3069b0e04-52cf50fbcb7mr5778741e87.45.1719508967656;
        Thu, 27 Jun 2024 10:22:47 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71305d6esm267170e87.167.2024.06.27.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:47 -0700 (PDT)
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
Subject: [PATCH RESEND v3 3/6] dmaengine: dw: Simplify prepare CTL_LO methods
Date: Thu, 27 Jun 2024 20:22:19 +0300
Message-ID: <20240627172231.24856-4-fancer.lancer@gmail.com>
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
Intel DMA32 core driver for the sake of the driver code unification.

Note besides of the effects described above this update is basically a
preparation before dropping the max burst encoding callback. The dropping
will require to call the burst fields calculation methods right in the
prepare_ctllo() callbacks. It would have made the later functions code
even more complex should they were left in the original state.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Group sms+dms and smsize+dmsize variables initializations up. (Andy)
- Move the zero initializations out to the variables init block. (Andy)
---
 drivers/dma/dw/dw.c     | 21 +++++++++++++++------
 drivers/dma/dw/idma32.c |  8 ++++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index a4862263ff14..e3d2cc3ea68c 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -67,12 +67,21 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
-	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
-	u8 p_master = dwc->dws.p_master;
-	u8 m_master = dwc->dws.m_master;
-	u8 dms = (dwc->direction == DMA_MEM_TO_DEV) ? p_master : m_master;
-	u8 sms = (dwc->direction == DMA_DEV_TO_MEM) ? p_master : m_master;
+	u8 smsize = 0, dmsize = 0;
+	u8 sms, dms;
+
+	if (dwc->direction == DMA_MEM_TO_DEV) {
+		sms = dwc->dws.m_master;
+		dms = dwc->dws.p_master;
+		dmsize = sconfig->dst_maxburst;
+	} else if (dwc->direction == DMA_DEV_TO_MEM) {
+		sms = dwc->dws.p_master;
+		dms = dwc->dws.m_master;
+		smsize = sconfig->src_maxburst;
+	} else /* DMA_MEM_TO_MEM */ {
+		sms = dwc->dws.m_master;
+		dms = dwc->dws.m_master;
+	}
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize) |
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index 58f4078d83fe..e0c31f77cd0f 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -202,8 +202,12 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
-	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
+	u8 smsize = 0, dmsize = 0;
+
+	if (dwc->direction == DMA_MEM_TO_DEV)
+		dmsize = sconfig->dst_maxburst;
+	else if (dwc->direction == DMA_DEV_TO_MEM)
+		smsize = sconfig->src_maxburst;
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
-- 
2.43.0


