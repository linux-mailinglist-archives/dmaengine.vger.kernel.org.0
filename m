Return-Path: <dmaengine+bounces-2776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9492B94593D
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CF41F23BDD
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892D1C2320;
	Fri,  2 Aug 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6yjKvpa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F11C2306;
	Fri,  2 Aug 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585091; cv=none; b=lYquS/CIHZX3RnSPP2PWry4o9PagbnWeVzqc3a8+K1ntWcYsOwbWcm9X/8itrdFXkrEfSAvUHWtlcyV/5M+WEO3QOaiDaB3wplFIAJh6QZdnbzNY2cLNT9QVsOk+hp92XuI5HtT4P8kF/p+F9kPgPQY+Rve8Eh3xRRBIiJiy09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585091; c=relaxed/simple;
	bh=fQPhAal9u/RtGJ6B755rdrjV8QGkzP6TRnf7LTNG+vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7+Yb4wnxVB+ujIYzgdvKaoUqMlfG8/wN6fNZeK/8qowJifn5sH+HN1apf/PqG4vBY+jKTLjXymbtrIWkUQ3vFGTPsINku4x102dL9Im56JPfWTlSaoQ/viH5Am5AbpY/njbQviHaf9tfIKEO8wUxrHAJXBTiWyE+xfbnwF2O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6yjKvpa; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso91494471fa.3;
        Fri, 02 Aug 2024 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585087; x=1723189887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=d6yjKvpa22cPKOu22dtatU/CKYkLKdE9ySNTi4U2EVbW/dAfpEWNfIGoQ8fBdBwo8i
         UcMpkvIXLzl01Z0mJkzuoPNj2glBuYJoXEDH2D74q2brX6iyTHIf+Azjou3dRBoqkPvH
         i+E/W6NmxMIgWXU/GmR1EFcs1QWHKkA9hCFtJl+Mlts5H/UiLdEAwrm6Soj0Y9ViVmlZ
         jVqc9nhJnUG5TMD2G7ANn8bqbFcpZZvc9O5lbHEL+eaj2w2ZCTB/1/bIfQvTncq69UUr
         hY7S4UsrXuxB5+um7vXUKfd3IQ9hLxFdCEgCxsbLzAbndMTeQ1oT5j6QENlihg/bFYqE
         X3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585087; x=1723189887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=AAQMKNKX+q/0SYlqjs79il8a9mVzFuUsNv7dRze1OrfTNEcWyM1z+ScLtlwNFcdWCY
         DocBIMtaSbaccefhYnGknjsb0dzshvDdNEYDJdeY6Aghr4UtzgIKzcImYaAIjP6Ox0su
         HKzYZbtvTJ4f6terXezz2z0zV89x6okka6DEE784s1ZuldBprqIzY9o2fu9obxbltLGk
         9ukyxy1IEBrJcdPUZc0QClOEIpbyHXI2UOWCxYGk+JcGhGdviaYrRbIt2V/aC9kxfP5e
         smFn3+zOyHbgQ5hWeM/2dUCLIJgdtStHNLPDbiKC60Voz38B7p2NpUCqblm/7PxpaZR9
         koVA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ne7ZcWjjZs663WmHICMoOTecR3kqBzsNLbwxspvk5rbFw5mGmVwN7llg8LF7ycoBq3yiVi3R4LsrGfZ65Nx7pVLlE00l3B73N8xH67OmSb0gxXqVTFXEkRPMLw5YXGDQ+ZWwx/pMp+7eOWBhRB4voBpkp/D1/1P0+KgNnqn6MzWwHAR+
X-Gm-Message-State: AOJu0YzG6CQBV3cJxqUr5/owYQq6e756LSR9oxdjsVjtOpqL2fY/ghXW
	87DTL0cK6IkbjBeWfuYepa93cMuR0u+z/VwZaP8TNvsjbVpWtZMOSoEtpGsl
X-Google-Smtp-Source: AGHT+IFJEZowBuHKNL/iNXFlICrfc6qivLp0nXS7RvbuoqoqpJnsZpWFBwUBIRyqGgkORUVZtcNcAQ==
X-Received: by 2002:a2e:804e:0:b0:2ef:22ad:77b5 with SMTP id 38308e7fff4ca-2f15aabce55mr18913741fa.29.1722585087119;
        Fri, 02 Aug 2024 00:51:27 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e25d43bsm973921fa.103.2024.08.02.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:51:26 -0700 (PDT)
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
Subject: [PATCH RESEND v4 4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
Date: Fri,  2 Aug 2024 10:50:49 +0300
Message-ID: <20240802075100.6475-5-fancer.lancer@gmail.com>
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

As a preparatory change before dropping the encode_maxburst() callbacks
let's move dw_dma_encode_maxburst() and idma32_encode_maxburst() to being
defined above the dw_dma_prepare_ctllo() and idma32_prepare_ctllo()
methods respectively. That's required since the former methods will be
called from the later ones directly.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- New patch created on v2 review stage. (Andy)
---
 drivers/dma/dw/dw.c     | 18 +++++++++---------
 drivers/dma/dw/idma32.c | 10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index e3d2cc3ea68c..628ee1e77505 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -64,6 +64,15 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return DWC_CTLH_BLOCK_TS(block) << width;
 }
 
+static void dw_dma_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
+{
+	/*
+	 * Fix burst size according to dw_dmac. We need to convert them as:
+	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
+	 */
+	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;
+}
+
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
@@ -88,15 +97,6 @@ static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 	       DWC_CTLL_DMS(dms) | DWC_CTLL_SMS(sms);
 }
 
-static void dw_dma_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
-{
-	/*
-	 * Fix burst size according to dw_dmac. We need to convert them as:
-	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
-	 */
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;
-}
-
 static void dw_dma_set_device_name(struct dw_dma *dw, int id)
 {
 	snprintf(dw->name, sizeof(dw->name), "dw:dmac%d", id);
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index e0c31f77cd0f..493fcbafa2b8 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -199,6 +199,11 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return IDMA32C_CTLH_BLOCK_TS(block);
 }
 
+static void idma32_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
+{
+	*maxburst = *maxburst > 1 ? fls(*maxburst) - 1 : 0;
+}
+
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
@@ -213,11 +218,6 @@ static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
 }
 
-static void idma32_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
-{
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 1 : 0;
-}
-
 static void idma32_set_device_name(struct dw_dma *dw, int id)
 {
 	snprintf(dw->name, sizeof(dw->name), "idma32:dmac%d", id);
-- 
2.43.0


