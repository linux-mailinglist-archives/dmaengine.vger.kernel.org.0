Return-Path: <dmaengine+bounces-2572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376491ADF0
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B197B2378E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6419B3CD;
	Thu, 27 Jun 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBGFKTo9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5C19AD63;
	Thu, 27 Jun 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508973; cv=none; b=liuCDZC1JLJt+7E/Vdg5nJj6O/LbYKMOW6yh1YNT2bbFdZI7ZXtN77W+KVnMyJDwjmMuhOj/QUCDHkr8DhF/7rBbfGm3UTInk6Y2BI0vTKgXmH4K3dT4c30fdfngkN3PrwnJBYiOS84hkB35PQ0Yk51DKJ4HFPQKz3h4UH/S48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508973; c=relaxed/simple;
	bh=fQPhAal9u/RtGJ6B755rdrjV8QGkzP6TRnf7LTNG+vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0VJVRGNByg9SJClH8XKK/zViXU3DndmXSHoAlDbq3wLIaXGXje6CQ/D11aaEjtFb3sG79rEgdA6hyxjVbhNg4jz/juNTzkGOahFAbLAy/1ncScuopCCaEIw1obaMvxp57Prf97CvjRJ3NkD6L3Tvk+M/pSh38pUhRLaGxHzQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBGFKTo9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so6536242e87.2;
        Thu, 27 Jun 2024 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508970; x=1720113770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=MBGFKTo9MQI333GodTY8pOYBIrWfwghQ1iFq8K8nhjg4tS7NcC2KXepGL1jqM9ez1V
         3FDLbER1vRcypimbqOcq+UXUscHqYQmV1qRaLWskk+h/LirRH7lFhFhZk0+OJdadf5WG
         xrpdYT43WToof+jHx6vL41mQR/2e5VTMe0W10zvfYhaT1i5QeDauTAdKUOf663RxZVB2
         mAx2PWcOqCWg4GP41mfekXgaT1QL8n7h+eV7MOr5boNODkHS1Wsyih8G0pCLMg1CF8/U
         gGPcjw3zXyBvfSC4IFT8sp//oGorInkFQGTCszpzxNaRou7E9qIby6zhaodnz5v9CEf7
         12Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508970; x=1720113770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=OEX+WjdB9jRQWgi/jc3Xy5rO1p1IJm0eb2FJvyGIcXhzms7ljTEFc5lrsvgp/WmG6E
         P8i9baypx7eqp+39I0T1tO0oyfboH/7mfMYkgrTDT4uQrujLvt9pdre1rhNb3WisfbSN
         xfke2s1Hz0ZGqG00wZF8oukS+msgKNhTir4iIIPCeUlTtZxJp+Vg0tEMFBWPBTTDL6IO
         3RFFawJV6Bfhjke6pxO/zbJNKFZlrcfAq5pw9N2RD+zqvqu8jSLDrN70U+dQ0+Y0AlT7
         SDn6TpFLYO0h75t+mGvzS8yjDLyE8+9qJL5gvcbYej2fTBi3n4PqmTFRHEYEMPyX29Ya
         rBCg==
X-Forwarded-Encrypted: i=1; AJvYcCU2qnl18Yb+UnDK8mhvSUvi++IRuWcdK2JwDgXHaEr5fRtLlbEFd3fW7cDYdD6SqsXnFC0/U+Cuz0neCAscT5yzdx6blWo35c4zAPKoTJJb2Q8vcXukhCglyvSjCDXFp3+/JhBQ+au13P4WERz0WrkygCFXDhCY47yxbJLDgeY4LqPLZzs2
X-Gm-Message-State: AOJu0YxkoMfYaw2AFp/wyllJAUO2zb0PqLS1bzVxiJVnxNW1lcK8Jb/V
	UUm7q6mf7IXIbzoEGkOK1zbGlr44V7Gciv9+4t2gLX9FC3tQYRI5
X-Google-Smtp-Source: AGHT+IH/skTxNTdJ77l9P9sERL7buslm8AqLFNbV1oIcAE/j5l1j3e9u138KdLde4k/rybo0E7eccA==
X-Received: by 2002:a05:6512:ad5:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52e7684a554mr773311e87.52.1719508969473;
        Thu, 27 Jun 2024 10:22:49 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71319ce7sm274550e87.221.2024.06.27.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:49 -0700 (PDT)
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
Subject: [PATCH RESEND v3 4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
Date: Thu, 27 Jun 2024 20:22:20 +0300
Message-ID: <20240627172231.24856-5-fancer.lancer@gmail.com>
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


