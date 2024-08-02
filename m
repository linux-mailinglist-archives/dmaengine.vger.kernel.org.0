Return-Path: <dmaengine+bounces-2773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB399945934
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B69286D4E
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01071BF338;
	Fri,  2 Aug 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz5hHvgX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF7482CA;
	Fri,  2 Aug 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585084; cv=none; b=S4oT1QstwMxv7nvZsZLcYqjlvQg/g1B4nN2XREtslE8pdXxsDgFY64tWycQNczimMWaVdZI/PkK6Fz+tO51nXJ6/jJt8GWs+JL+2lIO6bKJnpuTAZBBlYNwANqZoz3GvCVbZGEyX66ZNbzjeIa+qBysXOe8dC+PUl7cct/3ycJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585084; c=relaxed/simple;
	bh=gHCKjCduWlIWT/non4Jh/16B92XbiyU7HRu7hficrIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXI6cD3EQGvzsJM2Gie/luMqWbHpNi0E2EtzPlRSZ7qsmtqbQGQFBoJBGjZa+VLkVpCkEuGpbSGakVUC+ON81aKnIjI9PTWQD7Df6QSbwY6YiI/h/d/Kph7cT9+9SJcjsvtYanlzJmxF471mNDs04tHDkAlCnIC8pznIXhQu//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz5hHvgX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efbb55d24so12107877e87.1;
        Fri, 02 Aug 2024 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585081; x=1723189881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH7gguDxauVR/+lFwFlaZvvSUlE4xotzmc2VnxLvB0A=;
        b=dz5hHvgXdHT5FJMwKqI/byGCyHDUwZvHLi7+10OZCaGC3PnZiPUU5kJNCe+HrQb5an
         i8WEqaP8dCYuIR7I+B2WK9gPqMk7fKx4JQqmqbalj9w+FHrkppbftDgCH2LfeME463CT
         6wyH3sMCYVjIqshezvi2Z1N9DDe0Z5NqlvVU3iFrpdNst3Kn9N5ZM4VA+Pb3ri9oRCLS
         Sj9ESabhZnbJuadEKgMyyK3clt28qvzkVDFD0ZcOwcPF1GyHbiVLNtRRtIL1IAPnpT6L
         S9pIrR4Sm4+La/7/so/4DGljP0IH9yppbXQAI6nSL1Mv3c+0GRfpbyb59EdB2MIykfBN
         f3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585081; x=1723189881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EH7gguDxauVR/+lFwFlaZvvSUlE4xotzmc2VnxLvB0A=;
        b=JRsmF8pdwf2a8IpJ1BrJBnY8bJzZQRyyj/0nnaGp+oqceiaNCmOtWJBHHKU9r2m5H/
         YsXZ9xOg4Wh9GTXMF9lwuNWv4A2Z6HZ5ZR4z20qWCzf6g4Kq3KpNT3cLtZnAWkreqtVe
         jatF9ok5NPbpPIa4Mnw4mWaiC8wgveFHzDs+H/HpKCbQYCcCdUBE5v6bcp5mW90Qzk6V
         5mR9AAlhI23mOwA7o8uZAmrJwLiciIdoX2ALkbbDJ8Ycb4SxahKZ6r+sp1yp17Kp8KuI
         NCFRZi4BnWtvHsULjIF8Wdq3OTQxboeC+ii11h7QVOLmu47+G5ZOA4+wRVQjOc7ImsEJ
         sAyg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/RcZGvuA4EI/zbh0MwSJ56OBf+dTAGeCa4llrvDoOE5/E37ixWMzNxXijfj/gp6XhuqWMCakxdh02xB+y7F1S+HMlunjKPBtX/O6Xk1PX/3vpDFMUo9T1JW1cIFGZ2FAMEFAMA/DOv050m0pVL/3PhWHbTVU4+RacWppFFz+QP4rvOAA
X-Gm-Message-State: AOJu0Yx03p/mPdfw8ZyWAW20CGXlPVJQD1Wb1S1in3sU0pflr3rnKUSJ
	zAGWIxEu8SPmAD5agRu0n2suWuB5D9l55l2fyUUoVk9z0Y6nxKtq
X-Google-Smtp-Source: AGHT+IGEm4zE4UPkMmXTH+bd99NeO8FpAm8PC+ClREIiGsK4zEsN4I8gs7lE0rmDljbgEYd23uuFLg==
X-Received: by 2002:a05:6512:104b:b0:52e:932d:88ab with SMTP id 2adb3069b0e04-530bb38c968mr2173824e87.23.1722585080786;
        Fri, 02 Aug 2024 00:51:20 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba1108asm161636e87.113.2024.08.02.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:51:20 -0700 (PDT)
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
Subject: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width verification
Date: Fri,  2 Aug 2024 10:50:46 +0300
Message-ID: <20240802075100.6475-2-fancer.lancer@gmail.com>
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
index 4b3402156eae..d4c694b0f55a 100644
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


