Return-Path: <dmaengine+bounces-3192-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D040197CDD6
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CE0B2272C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37791BC46;
	Thu, 19 Sep 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLurUU4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797F291E;
	Thu, 19 Sep 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771933; cv=none; b=JkNM2GDCyRamCcVCXY9apSVqeu0m69MRf1hxYr9AvpwrfFm58bduTP46WMmcBKevH544y8m+YUzN6nX7h4kDZMtazbkkWJ6+z2ZmSsvv9egyvzT/rV3hHrqtEFlnO8znip5u7MGYYu7BcfE2srgXfQRSpbMZsmhsPYUXFpOytOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771933; c=relaxed/simple;
	bh=gJ4IWCfyHQTyAa+Kg5oyCF1nbi/ZbieJ5/JWjqzNrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKrOyYcqGvdPJpQrV/ddpIv6dVngW0k3lPNZeV1OLiX6cfeSbQp6K5aGE6qPGdghzi4u/D3tUQykidESKp8OvAsz7rylllwByiYMWP3WqHHR9RLk/+4oO78CzgUCeSMAK/nP1gdDcmK/n6BZHYATeMd7zl2h578ZMPqii7jB5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLurUU4s; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso14237551fa.0;
        Thu, 19 Sep 2024 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726771930; x=1727376730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U1C4mUu4VDiFkBMlpROb2ZCYD26GbiPKZSxK9yppTk=;
        b=KLurUU4s4bldixsfCslZBwPbNckw1zblT5tVSMykrFspAhFq0FhuxDomtPiA4Sy1Ph
         E3+p6KqoDG2GrTHYeuX9xDfx9ZvW2GQE3DsjJfFym8GDf5AvA0jmRkBJyxEXA3AWdOs9
         D4T/oMgRoANhSiSDce8IutS2BxlTIw4DdF+qr4+kdnnBctQkrb2jAxmHy3LDI0NKDNl9
         N+Bfh0Tq0V9BLsJqKTBo8KU9lSM0Ih9onqNEDB/733joaB2+ceQfi3h2MRzJJT0raYPU
         vs3ngpOzOBeBntmg8n0Tku+9xH247Es6UheFkp+90qZH0ASLBYWADSGJhJPe2aOFnP9+
         hMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771930; x=1727376730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U1C4mUu4VDiFkBMlpROb2ZCYD26GbiPKZSxK9yppTk=;
        b=Mmo+pHoFzheJb9JHJpGOlSrEfS8m+UZQzmzexAlfcMLMTMjlYs+Zr8tvITFFt+V3vY
         SyTuwZ8QIhsGlcNtMFCF/mttPiTnw8x1RNVVeItmrUvlGewukeJ64YJeVBB4gPyxHAXs
         2tu0RrNcL2PZUfWtD4klb+vOd3BAQ8M6pX57NwZsflJAmZAJzRNTO7oiCJ8owgL+nD9W
         QaKvP88msEiVMM7GcznTG+6H8GQ3jybtas1r+3BU2wy3Sgh+McCRyRni+wMppvf7F+QH
         qSt8LKm1QI01E5Vac6iH/Bxok9etsi+OBmAPsFB/QG983I5m/AEzH8xqS1JWAe8ajlWq
         lhSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNVAbzcztGkRKEEa5969TawtieofCN9iCKN97VbYf8sa3Wrw1ank+gIkUZcZe1z6T9OqKpREZC0LI=@vger.kernel.org, AJvYcCUoJSCUNstjz3N1ule5d81wdGE6f0Og6TBqigLFg08TNwSzmuufK49Me140F+j/RG41f2ZjymlfRDVkabnz@vger.kernel.org, AJvYcCXF/ROJ7y0MNrxOTPzcmoZr9/kh4N1Tic4PqcHwg0hd/BAEV5eyXhZsOsrRwn4YNusD+aPxEmND@vger.kernel.org
X-Gm-Message-State: AOJu0YygnfMSd2J9VytoLBiSfHYp0Ujd3+KdkbmqWJEnqefuc+xcLiAc
	mtvLXWtvYixRDFLsKN5Ctq5sRVgC06c3eaoIQjcWzR0gWclR47Ez
X-Google-Smtp-Source: AGHT+IEwLSaQuYkgJI3L+iKFj+a62LBltSQOe/bdEeJFTU8ZeTslhYKgdz8G3ouvO2latWGRKJ8CnQ==
X-Received: by 2002:a2e:4a19:0:b0:2f3:fd6a:d170 with SMTP id 38308e7fff4ca-2f7cc5adbf8mr102801fa.36.1726771929935;
        Thu, 19 Sep 2024 11:52:09 -0700 (PDT)
Received: from localhost ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37f949sm16792061fa.93.2024.09.19.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:52:08 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ferry Toth <fntoth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ferry Toth <ftoth@exalondelft.nl>,
	Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: dw: Select only supported masters for ACPI devices
Date: Thu, 19 Sep 2024 21:51:48 +0300
Message-ID: <20240919185151.7331-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240919135854.16124-1-fancer.lancer@gmail.com>
References: <20240919135854.16124-1-fancer.lancer@gmail.com>
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

Link: https://lore.kernel.org/dmaengine/20240919135854.16124-1-fancer.lancer@gmail.com/
Changelog v2:
- Implement only the "fallback" conditional statement (@Andy)
- Fix incorrect NoF masters literal (@Andy)
- Drop redundant empty line (@Andy)
---
 drivers/dma/dw/acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..806620f5a406 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -8,6 +8,7 @@
 
 static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 {
+	struct dw_dma *dw = to_dw_dma(chan->device);
 	struct acpi_dma_spec *dma_spec = param;
 	struct dw_dma_slave slave = {
 		.dma_dev = dma_spec->dev,
@@ -17,6 +18,13 @@ static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 		.p_master = 1,
 	};
 
+	/*
+	 * Fallback to using a single interface for both memory and peripheral
+	 * device if there is only one master I/F supported (e.g. iDMA32)
+	 */
+	if (dw->pdata->nr_masters == 1)
+		slave.p_master = 0;
+
 	return dw_dma_filter(chan, &slave);
 }
 
-- 
2.43.0


