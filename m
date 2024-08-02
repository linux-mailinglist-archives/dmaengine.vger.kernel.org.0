Return-Path: <dmaengine+bounces-2775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A1945939
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF0286DB1
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357811C2304;
	Fri,  2 Aug 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiPcVYt5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0701C0DE9;
	Fri,  2 Aug 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585089; cv=none; b=ZbcBNsRx6vG3ohByutYcnRfNdEKT1t/g+y4eqdJQF82caXGCv6lS7diZx5cvTfmjujUufKOzV+goXlFSbjCFUmtN2CtaAaNeCk29momXQSUAu5a1xxyrT7663PBIf0DR/f6e47LuqcQU4E48/kz7rl5dpIX27K5bDd16iWuzaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585089; c=relaxed/simple;
	bh=klqYSawc9+NGO/zCAp0wyCL7LwvbZptI3bgjMK68bVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+6vWMMU2KV8L+Oa7V9olGmsxUIVGHZBCk7ojFsuduRDtGDH25M6/kAP55HKUnTC44AcnE9b+LCRxjww/zfLpCcKA957XI0FC+i31iWZ8E/MMv2TdUJ1KVh2NWjcJHmdIFU3uhh/7qMnO45j6y/dnbibPQandqQo0KduEHJBiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiPcVYt5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso4806841fa.0;
        Fri, 02 Aug 2024 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585085; x=1723189885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=RiPcVYt5h3FmGIGJik9SKPbguR5gzgQJfoZXEqD6lnugcjtTCPsS4Rn6TVHxNgDXFR
         I6H3Z4cC1Qg08fUDjOJM9WD4t3FpcwdYD8gg+ZnKaYWKwcS/ZEY87F+A7nYlPHy8jyA3
         5KG/mp6e3cnG2CyhOQrSRATYBuWc5Wy0bJw4HWRH3n7zud2osXq631Uk1ENUNUY/KZWh
         1vecby7Ai6qRhRVdAfJCfqV6ZWHkCS+eKYnN3YcOgZ/6Lo5SaU1vyV8vPiaDgY7WbPfU
         rLY3OhpyJV2PQNOmq26D/BQCdKKep/pLDEk+3EusTwN5D/rHRH46V0t96R0nuR3npoUg
         h8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585085; x=1723189885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siZ4YVoVvwl35AmLdBXelRcytxkQs25RUWuyPVhPzww=;
        b=YsYO03FqFHl5ncbpo3MGonQfDaf9XNA2e3FsVOvt+D0iGh4qcqHeMURARwu0A9yFdH
         ODgjpDK4VFfOFbJceeCyLllTCH2i/CEkf0RkoYyaDNp0OINZH9Rklm1i0fXIwRLYs8KI
         9y2IF41hQMGaVzDq0Lv27udI1mU6ddl1bfIeP0fiM7SgYxNer9VP/RWZ/oAfeBHddRsE
         NrrXnoXNgMy6y2vLgRGdM/nqmmBtoSHXO292/Jmjhv90qW83sf0uF9moKEt82Ho0o1Cw
         nTvPhJUggbvQMUy3tNr9Nr96N96E97WOTgoXu29FOOcJh4zS2G18rf+BjDeieX0ltZT1
         TFTA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0JjGFeBAZw7Tj3EKqgiIMXOF90+gzr6tytufnfl9Bjh53LPVVQuIK8HXLrR5JQvq0RNQjvSInoPVIb+omf7GOermxvsC8O7W2eM4iWwkv+Ps/pAIIs+CbXvOI/Mv+oeCuOApnT5UnWJvFIJuTHk6/AbOnmFSDn3Mq79pN+92cRKoeTPT
X-Gm-Message-State: AOJu0YxBHsFyS14EX4M4TQEuz/R9XKJ93sxTLslEvsQUqaThZsyO0Dl6
	zoghfpaSJ1XIbaiIisU4DT1Vtc0ytLPqq6zXYmTSCH9U9hhOd3QL
X-Google-Smtp-Source: AGHT+IE9ieFKrmQbUBm03fELy4/L4/UYsyPPjac6AfLjP4ArKLR2C1GqAysj5HhVJI96L/G0sc9oig==
X-Received: by 2002:a2e:3019:0:b0:2ec:4acf:97dc with SMTP id 38308e7fff4ca-2f15aa9112dmr17763071fa.11.1722585085148;
        Fri, 02 Aug 2024 00:51:25 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e184f73sm992281fa.13.2024.08.02.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:51:24 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 3/6] dmaengine: dw: Simplify prepare CTL_LO methods
Date: Fri,  2 Aug 2024 10:50:48 +0300
Message-ID: <20240802075100.6475-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802075100.6475-1-fancer.lancer@gmail.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
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


