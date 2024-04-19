Return-Path: <dmaengine+bounces-1912-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 993978AB4A1
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D16B23E8F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA06213CF8F;
	Fri, 19 Apr 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTZGK4C1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0313C9A2;
	Fri, 19 Apr 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549458; cv=none; b=ZLOSIk4MQU1WG3xrABUaVn/9pKvwe8F71fzDmsga+Evg+YFN1KhJvOR09H0KuN4KzHXT9oq5iqnWS6GM7GOC+gCguJzPZcmQ+I48ht9Si08+pugBiRPcct6//E2kD7ZaBsH8hlNioJtc9QkBMLvJy1WvQv8ETpjhCKqo4Cktb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549458; c=relaxed/simple;
	bh=fQPhAal9u/RtGJ6B755rdrjV8QGkzP6TRnf7LTNG+vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoHEoQvj3mh+bxwKAsWWtFuHvFwXYtp9ihjzzS1wdV7dh9L52bRDxYPms1HCZjKY/4GtK6+JspOMg8b/VmsZMBpa9foxgDiwgCMrs1p+cnSf/cfzTOoaMbi+jViZVbTFfd/jv2V99qcAhggNSuG7LeVpQQ5MQRVaqd2Ed70CXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTZGK4C1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516ef30b16eso2837152e87.3;
        Fri, 19 Apr 2024 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549455; x=1714154255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=NTZGK4C1QoHSR29O5FDIf6S6O71HtgVJUYXvtzeL6kguiyeh45yYkSCGA9Hg0EbEXr
         c1CLvxITv9y57XmvLBahkPgpMafOrgLIXED7xMuv1dtOYQ2W1QoaT1ICLCzvBzaWi+w7
         h7nSKCz0/wQxORcr60iblVfqYsThCKJMLblE6nkyUTtu4wqRfNeTefOVMAsTv2egU0qH
         NFxDaQsxPrSfCr8bggf8IbQNkQ1UW3syZweKb84I946fwZVevQY89xaj/0pBb5VRFd/o
         pTMwySDVZ535nCdQUhyOsE1MqfU//CFOi0VET5ucUFAeyx4X5qo3jHJlaoe6YZObLQwH
         Q10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549455; x=1714154255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZfbnz/PwNgQkBbjrQGHnGTi9KvvR26owgXnJGMkSZg=;
        b=vyeZyfvwwaKc0M27Ef0sLXbdH8lbkvP6h7ROnoGAEjcbiOl8CUWESLFGmzPaVikQn7
         RivxPpAEicTyQ6hRt1FdgUVildhTHp00rnlnIWJKJEqGz1vNHDVKWzG2VDbFwtLMarnk
         RdZOjBOq8ZJ4vOZz0pHiLUbFIxfHP46nc6YKhZS86hG3H9bshg1eR5UcvppBsoE+JA6l
         1N2KSqBRi3R/H+SDLoarkm/WiTZ14YPX5bdx+h+JPDYnMkbx9cSaLXd4d+aIbwIGlx2+
         vgcWZQ3UaV7kfoDAWLr0RQItpbKiUPsyyGHn/FTPuahhLX7rvPhbiJ7/nWjy4Sv4WqaS
         AQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc1elkd+/vEvXfiqYeQHbMjE3ERzoG5x1sEl7KxrhSNdlVglaXtfoCnTqSWITzAxClpAvVL23avzdQuPmRDALIYGMKZR43b8mjR+faP6gnGO5Ciurg/Fyvd3ES+xj1Y7RTpMNqk64F8OCyhyAE/l3XtKWv704ICeZ3GW/vVdT+3JzkUdGU
X-Gm-Message-State: AOJu0YyeueQgni2Q6rxHY+RHl62hwWh8UkrmgLWrW2eGHwovufUOrVcg
	NbyasUzpFEInXDXeexaOw4SnAb3wvlusbbYiBvcKCgqah47MaFGP
X-Google-Smtp-Source: AGHT+IEEnvURxs2QdTCK310RXnDTi6plg6pypwKhKkrQeoddFmkN8evUSTH4VuUxKtETUoSANqPi5g==
X-Received: by 2002:a19:6a1a:0:b0:519:591d:45da with SMTP id u26-20020a196a1a000000b00519591d45damr1719000lfu.18.1713549455195;
        Fri, 19 Apr 2024 10:57:35 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id l4-20020ac25544000000b00513c253696csm795144lfk.187.2024.04.19.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:34 -0700 (PDT)
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
Subject: [PATCH v2 4/6] dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbacks
Date: Fri, 19 Apr 2024 20:56:46 +0300
Message-ID: <20240419175655.25547-5-fancer.lancer@gmail.com>
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


