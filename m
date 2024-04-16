Return-Path: <dmaengine+bounces-1847-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0268A7161
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82520284958
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D374133285;
	Tue, 16 Apr 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQkFot6c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF62132C17;
	Tue, 16 Apr 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284958; cv=none; b=fYzi0tLHeDIN9TF82uohNGkZ8R5OHUkIdXdZS1M6FeriGF+WaCMPPUIXUY1Wo3iZY/OYYFYf1xzCQ0Xywp+Om8jCZax/qvfkHg+ONFlM/L525WXceGEX2+mHX5/+ciN8bhH26GWipHNRG1RsBfgGwfJzfZswMaPYCo3LvdD5qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284958; c=relaxed/simple;
	bh=wbXPipj1z/yiZ0qViyUkJmUEI/KeyS2lZ3XgWX9qBW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgcpGhUN+gXEn9dPTOVOO5vM367bW94wPighjRnAk9Z6FpyBrbgAcRp7gSDmGIHoK5OOsnwR8Y16FD2jwKIt7qPEUnEtUIQNscgKaHaburm7r4m6nL+Zxkad3yAw6RjgB07smT8/GJElyCz2Esz0bJ9NruXRaSpJBB1De3YZws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQkFot6c; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0c004b1so6125281e87.2;
        Tue, 16 Apr 2024 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284955; x=1713889755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTFL+T9JUZzbZhTh3cZoXr6hKv9MUPaKo7eqvocdq/Y=;
        b=WQkFot6cZqg52El95cJDYPNTt1tdlkt/m4GvUaMRfDmEnRhn7lb9xYolW2X4ZEzOOE
         5ox9aDBQA6lWj68fUhR0g3ZrrV583toK4jyGflDONviOyUJOeH1ifzToSrpS/mFHHMh4
         0y3Bc4u+fFcqvzrzSn1DTMr1PdiXr3L9mGqhlooDAFdUCA1Vn0EbOmg234oWl7dQQLib
         S9ruLRfXGHoQ0TLABG5bHlZRoRDdpx3vXI+5FkScRI41IRK1YU3RQsIoVuGkdnG6H9Ad
         Eg9HCcFf98HkC7i4F3NSRp4LADC74WeheaBaScS3POzIw+f5r0f+lj+qxAkZZgzuQK6Y
         tCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284955; x=1713889755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTFL+T9JUZzbZhTh3cZoXr6hKv9MUPaKo7eqvocdq/Y=;
        b=CLtOXGqiUcqV018okeS/+K3HsqY6Ol7cw1ZFYD4RW9jkoowSFuA3NO5NQ6UNpIZ2se
         TK2A97b5l9OnsShMkTNyAJpy2x9JPFfZx05F9d5nceJTJJNR+z0r46D01chXupsGZC1q
         QgZ622Rka50567U2ga0xAnEjn0oOoEDYIFSNbyvyn5MLxLLdGAF6MxwtejcqLPzcvU/x
         r7mpEDh+ERnMBUvKicExGVRC9XALxps+QB6OZJyTMowBt0y+Ew8v777qXFBQEZM2rwnZ
         zxGmhSGxq201PItpuDsaCkZ+FKfH90wW1uljQXwsoF1r4b7+VAg7mVXoetokHBe0p/J9
         MNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGElPjrlwyCUIu9FnOxoQInD1tyAXoXP773oZNbqZ2KDjJ7/0/TBjbXarNhzHgcUjWznN44QY1IbgnBjhjCSLYQ6J2mkPv6TXSSI0h2/Tm/t9O1V9zhwuxUU2oaD+MbE8fAsz9i4gbfdCagEnr/nke52U+RT9fsg0sw1V1Roo1hTP63BOc
X-Gm-Message-State: AOJu0Yw5FtNen2kVsQl5tV8h6S//NF4di8aMLu90rANhF/n2qUE4vr0o
	p/3CJkO0mnwE+W/+xwKBiOJZMfi8k5HI0PvMpQAJefNpyb+gsoht
X-Google-Smtp-Source: AGHT+IEDTIxDjYIModNCTtD1DEKQhvCj8CjYHuU5aeiXZCwa1LbzClWr6ebERdhjFUsZmBpf6Sgpmg==
X-Received: by 2002:a05:651c:b0b:b0:2d8:3e07:5651 with SMTP id b11-20020a05651c0b0b00b002d83e075651mr12850954ljr.34.1713284955355;
        Tue, 16 Apr 2024 09:29:15 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e98da000000b002d9f3bed88dsm1515023ljj.77.2024.04.16.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:29:15 -0700 (PDT)
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
Subject: [PATCH 1/4] dmaengine: dw: Add peripheral bus width verification
Date: Tue, 16 Apr 2024 19:28:55 +0300
Message-ID: <20240416162908.24180-2-fancer.lancer@gmail.com>
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
method which would make sure that the passed source or destination address
width is valid and if undefined then the driver will just fallback to the
1-byte width transfer.

Fixes: 029a40e97d0d ("dmaengine: dw: provide DMA capabilities")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5f7d690e3dba..c297ca9d5706 100644
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
+	/* Fall-back to 1byte transfer width if undefined */
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
+	int err;
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
@@ -792,6 +826,10 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	dwc->dma_sconfig.dst_maxburst =
 		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
 
+	err = dwc_verify_p_buswidth(chan);
+	if (err)
+		return err;
+
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
 
-- 
2.43.0


