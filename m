Return-Path: <dmaengine+bounces-2569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99491ADE6
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6422EB21D42
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47619AA47;
	Thu, 27 Jun 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVcuIahr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9C19A2A2;
	Thu, 27 Jun 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508967; cv=none; b=WeOSM8LXpbu9mT5uRGw+ih7z63wcBeL+DKTtdwJnU3KuI1XR7uUXiF7h9hMvS/NrwL55LrMtd+Fvt9DcIQQx75RYTB29Ko9VyNLlnMx+/ijDm8MttbwzDLwCpU9/lLYHbxMn5Gjnkp7EGGNrrxcK6e8EnFOmmHkr0av2io5yxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508967; c=relaxed/simple;
	bh=HE/gBLYoq3YOFcYSah+Q4/Z07EhWJT3vDtkUn+oRy0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXajP8RLkA45eQ1QIIXA4k1Hv7e1JCtz0kxdyJ8e99D8pG4ThthXGwUm0xUIiBzE2flWgPCXgBluPRMhfFPxLbGwNk16ukh+fV/quBZ+lEsEjrof7ckfpm2E0Yix4PHMEYn+Pb4tnw6LJwI6spMNtkjoeX6ZROUhsXOFF0tbRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVcuIahr; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so92297121fa.3;
        Thu, 27 Jun 2024 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508964; x=1720113764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lS5bTkP1B6ljd2Myp+Kpm68dJUaLMTKGqzv1HIMuo8=;
        b=IVcuIahrW5FysDwob8C3hqDFZxauvijI/uLRSeVKPfF32H587X3i28t3EduZyKqIaE
         62JFHGciJrqPGDvjLhjD5sJ5xenniFI6uphySrhUrwwr66DB7Ne57AU+JUHkC6fX6e1g
         2JviHeWQ6pDQW9yNzq/C2d7ukDOwXRPXl37/Lgo2T4u/GKLMJ1PFdjKKVUCesKt1y3Ka
         daejJlPTkX6gU/zI41I3jSAuDnlj+BbNg54JAW0Ff4xtgskxg/XSDd79JEaN9LGYaF8Y
         LtdSDi9wbl2TDPIzD6SCv4i6jKjB2V8kg5Rary72Fm/z3HN62Ck1J60Tj8W3/zLobcj7
         epGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508964; x=1720113764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lS5bTkP1B6ljd2Myp+Kpm68dJUaLMTKGqzv1HIMuo8=;
        b=QcEUC85jG65I8RXRxxgjzOlDbiFG2TF5Luc3ZvNATF7mQ/4gp79PkATsPMUwGHLgIy
         aB0Z5bYY+vR8n+KuLW8+2UXGkw/ZUrg6L1s8KQOUJHXMXUsv3kgSW4RCXC3/SdZwp8T0
         CdyTalJcN34eCf7WBDbtiIyutP1Ub+u5DnIt+7CuCrPK/cNyl2jAQUpG48475kZD2avT
         KDCU6jBfv7xg36A1udGnrU3/V81Gm2jM/DD8KIJrrjtW2IlRUjbXsld99eIkqNkbGmjk
         zKF/jTL809eLEIhuBWhCb/QXAuPb8AnaTc4TGHNO7xV+kLWXmSG9oTo5jtEKq4cxYoXk
         fLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW64ih6JJE7Q1QQ3If5RC53iHE4uvR78Vzb26CJJDfTsfdcX7r5s86nBV7h3YJ2X2VjRi3gd7Z9/p3zQ8qF47rGnkvJmFa+IhjMkAUFk386L5mZJDZMq/5rl/j3ZWM7z80RWtRT3JkDtvwizGSvdrtDhYw3kjbrByps0kHSmJsM5GChmnzJ
X-Gm-Message-State: AOJu0Yzrnuhapu/jwMPvt9e3sERZrxWg2+50VJXBKUo9VvMkMgAL3jWy
	Jrl/Fg5x9f0X7ohce3JfRnRbxjmJUsKITiXPlh0unsnEJmD8cmNL
X-Google-Smtp-Source: AGHT+IFNXyS68nJnNNwmjV8K/ycrg0Vr3BgzCcFhyV7FSPm9Lg+BaOc1kIvM/q279/yI5ycWn1cAew==
X-Received: by 2002:a2e:90d0:0:b0:2ec:541b:4b4e with SMTP id 38308e7fff4ca-2ec5b3d47c0mr83087041fa.32.1719508963802;
        Thu, 27 Jun 2024 10:22:43 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4bf077sm3182271fa.119.2024.06.27.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:42 -0700 (PDT)
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
Subject: [PATCH RESEND v3 1/6] dmaengine: dw: Add peripheral bus width verification
Date: Thu, 27 Jun 2024 20:22:17 +0300
Message-ID: <20240627172231.24856-2-fancer.lancer@gmail.com>
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


