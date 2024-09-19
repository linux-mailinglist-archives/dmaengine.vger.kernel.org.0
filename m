Return-Path: <dmaengine+bounces-3188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978697CA93
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BDFB231F4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5C19E83E;
	Thu, 19 Sep 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccOWF4xC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9E19D8BB;
	Thu, 19 Sep 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754344; cv=none; b=K9yGfMmxS8PpN5tnJ2ob5RzT+EmhPBQMpSLPFhM4Rz/6bRMBUst1N7pjh9AqhKOzISX+xQQqiMeR6Kj+1pBLGOqsm7ZZmLmrFs60b/yVq4C/5RpAbi8mZgl0CGG9OQTlaNPcGIdcLZ6S5wOveExgGE4EvDJQuUu6IzFxZviTqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754344; c=relaxed/simple;
	bh=srnK6yLEvtox5NfJs7v7fOjIgfyIoFIDJY/8Rw2mEJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=konf8KYGeQV+j0imBRIa/FP5eQu0OE0/Y3jVWm9afKebCctu/61FegIgrl9ZbVBeHfAOYQ8lm1Ox7MX9KmyH6nWd5PheabdY0q2Tx8fvMBpSfnaP8eka3XR4TItV7cUaxowDvNqryOz7ZLFJ2B+IVOpu9nmsbxRpa8RAzMHec4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccOWF4xC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so9864761fa.2;
        Thu, 19 Sep 2024 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754341; x=1727359141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dl3OjrsVMZv+aA568NjTJEOVVfeESkGFa9253qsbzQ=;
        b=ccOWF4xCiRG41JY8JUrPPWx73cSdIQb8ShOO71rSVOFFxAyqx7PVbk2ObvBxMK1fin
         tkzvVRL3kw5XuHpPVJ4OzK9ymmpuxJZkmwzcFdOX+4JpcYtu/tE+E/Lek0iua7W0Ird4
         nP4n+g51uPOVJm4MjKypeHIlYGHGRmg/cVXpWEVuzuQLyDCbMOMLktdio+hPwJp/cmSw
         I7+lkdeZBF5L2oMdmOifna6+oiDLsyQGG2WQjVkVaXrqTUHmxzs5fErPgWRRqEPhF4AS
         kFCRJzjpACmSlcKOiXe0Xgl+WXmpWvJR3foicF9Z/qBIvyNHJmLAoVfqhJIENJGqz8Oz
         /Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754341; x=1727359141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dl3OjrsVMZv+aA568NjTJEOVVfeESkGFa9253qsbzQ=;
        b=uMlsKVFLW/OY/cBmgPK3zaiAMZrRfpBzm0668K14armMVK9nxi0lLEvU9VRtLi8ofj
         nSqCPIB6Iodj4gzHqFwE8C5JuiT8IcpVHHFPCqRZd644lyo4THNw/MbFCdPPF/ZKDtw2
         n3dGrRSoWzQCmnABRRbYrs3LuGkv1vuxcq2SUI7B/4Dh7yuACStKHrRsAN3yNiiI0jnU
         ljyyBBvYYTeAUkgTwMRXbz2u1rs51vh1VHGacPpJsLBhxSIKilS76BjATrCCWpEJhF+9
         ObBEscmF+JxHLpk6nbbFQhhod28xhdbPHzY4wyuqCdBtFCzcg+B4ewbLtI0n4NAXbGao
         g2aA==
X-Forwarded-Encrypted: i=1; AJvYcCVHUp7sIIUndT73iFeXjAg9UqllL9x2y66vPve/OVhB4ghsYpFZ1cbisdOfFEeedmhn74R496nyef40YDQ3@vger.kernel.org, AJvYcCWAmYTP8d+C+RNyQk0hujXQXR0cdsEf6+AM6TQvlqqnvwCufwRqyucIwY3g6N6TLmNZXvh1X4ym@vger.kernel.org, AJvYcCXwJfHOr/Iuu6mqym0wqg5ykJkusCt04wCoEdTcAh8LBHsbt7Xen8p7LYWHvRCbJhR9T05mxpT0CUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhN62NPLBO0x8BzmU6Z3dwzXsyWrzCqQMtsvwbuiUj6HL4NLc0
	x+Oro89UzKPoiy9IFwuqs5OfoxGLPtayjg7qsDQBEaD/w2LbkAy4
X-Google-Smtp-Source: AGHT+IH/PH5CDFn2ze7amXvKo4RYRc0NY7vDJsTWy5InZjVmIkrJ03PVI3LDq/+/zAU6zVIBsrYcNw==
X-Received: by 2002:a05:651c:504:b0:2ef:2555:e52f with SMTP id 38308e7fff4ca-2f787f2e66fmr153794481fa.35.1726754340638;
        Thu, 19 Sep 2024 06:59:00 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d4861f5sm16359541fa.119.2024.09.19.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:58:59 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ferry Toth <fntoth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dw: Select only supported masters for ACPI devices
Date: Thu, 19 Sep 2024 16:58:14 +0300
Message-ID: <20240919135854.16124-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently submitted fix-commit revealed a problem in the iDMA32
platform code. Even though the controller supported only a single master
the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
0 and 1. As a result the sanity check implemented in the commit
b336268dde75 ("dmaengine: dw: Add peripheral bus width verification") got
incorrect interface data width and thus prevented the client drivers
from configuring the DMA-channel with the EINVAL error returned. E.g. the
next error was printed for the PXA2xx SPI controller driver trying to
configure the requested channels:

> [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16

The problem would have been spotted much earlier if the iDMA32 controller
supported more than one master interfaces. But since it supports just a
single master and the iDMA32-specific code just ignores the master IDs in
the CTLLO preparation method, the issue has been gone unnoticed so far.

Fix the problem by specifying a single master ID for both memory and
peripheral devices on the ACPI-based platforms if there is only one master
available on the controller. Thus the issue noticed for the iDMA32
controllers will be eliminated and the ACPI-probed DW DMA controllers will
be configured with the correct master ID by default.

Cc: stable@vger.kernel.org
Fixes: b336268dde75 ("dmaengine: dw: Add peripheral bus width verification")
Fixes: 199244d69458 ("dmaengine: dw: add support of iDMA 32-bit hardware")
Reported-by: Ferry Toth <fntoth@gmail.com>
Closes: https://lore.kernel.org/dmaengine/ZuXbCKUs1iOqFu51@black.fi.intel.com/
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/dmaengine/ZuXgI-VcHpMgbZ91@black.fi.intel.com/
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note I haven't got any device with the Intel Merrifield iDMA32 + SPI
PXA2xx pair to test out the solution. So any tests are very welcome. But
based on Andy' (see the reported-by links) and my investigations the fix
seems correct.
---
 drivers/dma/dw/acpi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..efbe8baeccbc 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -8,15 +8,25 @@
 
 static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 {
+	struct dw_dma *dw = to_dw_dma(chan->device);
 	struct acpi_dma_spec *dma_spec = param;
 	struct dw_dma_slave slave = {
 		.dma_dev = dma_spec->dev,
 		.src_id = dma_spec->slave_id,
 		.dst_id = dma_spec->slave_id,
 		.m_master = 0,
-		.p_master = 1,
 	};
 
+	/*
+	 * Fallback to using a single interface for both memory and peripheral
+	 * device if there is only one master I/F supported (e.g. iDMA32)
+	 */
+	if (dw->pdata->nr_masters == 0)
+		slave.p_master = 0;
+	else
+		slave.p_master = 1;
+
+
 	return dw_dma_filter(chan, &slave);
 }
 
-- 
2.43.0


