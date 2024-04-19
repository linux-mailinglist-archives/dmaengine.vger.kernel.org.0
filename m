Return-Path: <dmaengine+bounces-1911-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C688AB49D
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6192813BA
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543013C91F;
	Fri, 19 Apr 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTgz73vj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F313C69B;
	Fri, 19 Apr 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549457; cv=none; b=mhHkIpKNUTfDp0gIvGSUOweeCVsH6vETFt/Mj/vMuDoBcHf2ILsmXhHq1ICm3GcIUs0x4Khsu2PwVfUP1MjsvjNSkGoSCvGJou4HWqlzQgtysz53qs0LVpqD0CepseIvhsnaTqjLct8jdOKDVvGk2M9cWImljIvGAyuDGcoSg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549457; c=relaxed/simple;
	bh=klqYSawc9+NGO/zCAp0wyCL7LwvbZptI3bgjMK68bVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUzX+2xD4BxcBLM+h4a4m44BfAv05I84KJ8/VeVIGp6c2g+nCQjaXes3x7Eod+wsp32EnoLmclqlVOf18txuS+nvh2VcUzZMmVgZ0cKNUPR/nOsObxGqLW7FrYuC514L9ZP4KfhXVo+mJGjAmyb8dB6UL5XrYjul+E1awjFv5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTgz73vj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-519ab23dd06so2410788e87.1;
        Fri, 19 Apr 2024 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549454; x=1714154254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=hTgz73vjdtm++jWuUc5C2A77SjN5TU14HisLNLYq1JLJkvi6vv9ABJ/noCPuF/wQQc
         5R5kOX4YR+5/26b4qkhtvVEpg/z0OIfX+dcGko6ofPSQaLGpKK0nQrb1BwB/EO+vdfbA
         RH6c+NpAAu6nHkokKNYsqcQ6m2ynhCQxLbxB26NUlwRV3H+i3NM5+cl4ufehc4wvWjRh
         FJBxDm3EOF18n47VpWni3lEEhR7S9ViF3K9XxJB94iTseCIF1qP9vbHcLBBf2Diakjfj
         06NHfDQva4I3eMP/SDmTDark8YK49vDOBb1y+Fe/pP1XjIf/iMGEjUk5ewrD5gCKqrkr
         9GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549454; x=1714154254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=B7/qtFlanBH3Gyhst4zhaG4ejLWGOS+pdpjloxLg2zIjSkrtzYMNCwCx4fgjbV0hmI
         kFQyFJc+c/qlDVErzeDboOzq+WWR2CV8eDDiGeQNRUDRj6SqlRoqBHxGBk2cjJVQUteM
         nZYV1LycoHLdSDkWHXMzDRMzGVmegey3MzryepEtack6K8V609RrTzxT0M6DlvjbcxY+
         SEEiwivJUXVRcs6sHMSF5ZZdhPg0zGHc8egOg52TWWdxS0kN5MBXVpP2+/Nzsa2rNN4h
         UzGCVBUowB/wsNWyvvNv3vh+NlKlDtCOD+F9Uix4kHmNkH00kgmd1IybmhhjFhBAdWuY
         jX0w==
X-Forwarded-Encrypted: i=1; AJvYcCXjljBe44O1xvgoHo4ccoxDuDKMT8I6H10CqdfOU3UG+Oo7j6C9SuuqIGiyaAUNztaElQGInVSwseWhViMFy23Qj0PrV1G2FDC6gSHoRFcUPF485AwnCTGJ7GBf90TSXXNJD+sQFY5BnPTA4MdoIi4sm3ndsExHb1swAJamio6R7xw/oJYd
X-Gm-Message-State: AOJu0Yyi8Km8TOeV7iOHkMCM+uP3wbQqeimYTfywaOCVaGhC1df3hFHK
	kdBdEP2IfnLhemRONDVF0bvu7FdlLlK4MNbVQ164weiYU2TZvMgF
X-Google-Smtp-Source: AGHT+IEho6jhFePaoiRHmKVks6TKTeEeQyfQZxE4Zj8mttVQdbEe+Tj9h0GTE1ppw5/uNCx+Wk/e6w==
X-Received: by 2002:a05:6512:4809:b0:518:d4c3:4682 with SMTP id eo9-20020a056512480900b00518d4c34682mr1839155lfb.24.1713549453522;
        Fri, 19 Apr 2024 10:57:33 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id p7-20020a05651212c700b0051abb2bfc76sm415770lfg.304.2024.04.19.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:33 -0700 (PDT)
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
Subject: [PATCH v2 3/6] dmaengine: dw: Simplify prepare CTL_LO methods
Date: Fri, 19 Apr 2024 20:56:45 +0300
Message-ID: <20240419175655.25547-4-fancer.lancer@gmail.com>
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


