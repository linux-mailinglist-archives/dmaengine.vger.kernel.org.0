Return-Path: <dmaengine+bounces-5745-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA5AFADDC
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9621B1893D3B
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A7276024;
	Mon,  7 Jul 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7CbttIo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BE285CBD;
	Mon,  7 Jul 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875108; cv=none; b=ezhosZ9MkyI+r29nn+nzAgkTki+98MF4McTzaTz/r9YlB3dJ6TWqYUXrgFD/FGDAA5bUWKFj/kj8cyPMV3HOvt1rvslOFK4zWJezxjuWJpZ4S81tIjVSaIM5LBb9wpxKuj6hD5CvIbKjofKEfOupgIFlcctbfln+tnmoNXWjOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875108; c=relaxed/simple;
	bh=vG8OgBoIJAJ/fjHrQBxrQUOlAhQ0jCVXyx811UfAhiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ry3lVCZwTpgIWyMWwB/Pxm2OguXtdccnofPPol+8K4JPVQgrS5pRXLZ2R93SHMWwi6g4cCqHAVvFVfyhucqEDw6weFol3UQaGE85Fp4PdSXB59XWbG6hfxYmGA9JJZy1+DJVZ/qVMlpvUmdXcNIYrsnw6im735WSEEP+D/a4hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7CbttIo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so377374f8f.3;
        Mon, 07 Jul 2025 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751875105; x=1752479905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjyVxs/Q2vcmJ8jiHHHzlw00PcDAeYgQ5mh7+BGVK9M=;
        b=K7CbttIoa+ywuWLEsfAKfETQhDZowAEyLxIUINNl/ChX9KnHeZpmTAjqCMMZNZX/Il
         zdpNGO1Qt9uAsUSojq+N5knwV91DTPxOl3J04jyhT4wgweY9Mwx9h9Vrk2amm/ZpkLvy
         ityUwZkahNxPr78YPqclvgL4Si0SXaTypfJyScdRcE4leEjfiTkLaWPFDWfZygafR2fG
         FNoYJJAMaYOfmU6XwzETRElSn7uxYs/kdr5WcVHS/No2W5WdsPizUFONf4p5HGOQvBuK
         AIyeABXmHKfrUogBMbzWMB4xSe48WHPwSl/IUjoCz29Ex9Vx7xoYORjVcH32vLTQwlvl
         jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875105; x=1752479905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjyVxs/Q2vcmJ8jiHHHzlw00PcDAeYgQ5mh7+BGVK9M=;
        b=vAP/zWIOPiI12Sw4c1hQ1XgaT/pES3Cti1LyEDzcaNYLY94hVXRbV1EyWsq8lmwjgH
         K4yfCYyIpCEoNBcgtYpg6nK+CPCUrgUw/TFnv2QgcaKozIgiofULPAh5wAfao7Q/jpDC
         N8jM09U+NFpVCcF5O9Cq8yl9pQiZOdd1RPuEBLt+k/TpkGkQD1B53F30WeFT+ZV0SbpB
         /JMmAf1X/ymuxHkmaywuNq04OQt/JVxTlCQGtHPnEFIuxEivsHiud3lHPo+NN7oqOixj
         JaKCmmhZxpqmectkUP238GnX3CPJCom688p6BlGlszm9vML64atVgMrr15kW4YPtxH+/
         5b8w==
X-Forwarded-Encrypted: i=1; AJvYcCUoUihqcTmEnkPdOBbCuL2Boq6MiNu7Rf9rW+jJ+A4FacEaSgcN8BfPXYD7WgN7rvFNLour4BKEDYkj5RTB@vger.kernel.org, AJvYcCWz9k9dip8aIMHkI2YWNMF6Y9bYmPq+Pl47sTmwshHSkjsbk1OTuNaSd16+fcQ2liiJ9vUiRtZIAus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlC8OUuZkiIB7nZcUg50fgX+qeepzFIXHzAjn0Zyg19OLeUKnn
	75xkRYAUAOyv7EWCh6v2tdm61ZayLSqVrJ7kiNd4ZjxWFN4swma2ENBd
X-Gm-Gg: ASbGncvt+QIwfEj8YT6kIALdMJHyZmlQawocCAEikhbih+IzYwqId7s5I/f9NMavOo/
	UrGvjSm8T3HPXTXiWSVjNKsOpjbskB94JJUvzbETZYl5soDx3+sOzkqgnc0agOWrIoDSVIFX6uJ
	x/xALPXRwLcTWmHuLGQYxPmErP5nnhL+sX6QTfnNvXO/EAi/Xj+LOuE8ctV8cPaGzLDkB+rArDJ
	u8Ch0YdDTnVadQdrt8Dk8yWuo+3ki0kg7RbInxnP7pwtGUxwVi1oKJrtUXSWZvKYl1W48whn7Cb
	BEaXprq45UY8a660W35Kl62fsQYml/sSQR0Py83UlEZGsRocvnximp1o96W2S1+nxcki6qjcMre
	sdwsBMVfxQXQXu0M=
X-Google-Smtp-Source: AGHT+IHwm8Gdrskiq/cenUe/LEOWyTv78WZl0qrMv0bnz/VYixW0Yr6bvqo4POjXw6MoNAT2xogSYQ==
X-Received: by 2002:a05:6000:3105:b0:3a4:dd00:9ac3 with SMTP id ffacd0b85a97d-3b496624ed0mr3467144f8f.12.1751875104591;
        Mon, 07 Jul 2025 00:58:24 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:ef01:c9dd:1349:ddcf])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b46d4c8619sm9311904f8f.0.2025.07.07.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:58:24 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: nbpfaxi:  Add missing check after DMA map
Date: Mon,  7 Jul 2025 09:57:16 +0200
Message-ID: <20250707075752.28674-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.
If the mapping fails, unmap and return an error.

Fixes: b45b262cefd5 ("dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/dma/nbpfaxi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 0d6324c4e2be..0b75bb122898 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -711,6 +711,9 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 		list_add_tail(&ldesc->node, &lhead);
 		ldesc->hwdesc_dma_addr = dma_map_single(dchan->device->dev,
 					hwdesc, sizeof(*hwdesc), DMA_TO_DEVICE);
+		if (dma_mapping_error(dchan->device->dev,
+				      ldesc->hwdesc_dma_addr))
+			goto unmap_error;
 
 		dev_dbg(dev, "%s(): mapped 0x%p to %pad\n", __func__,
 			hwdesc, &ldesc->hwdesc_dma_addr);
@@ -737,6 +740,16 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 	spin_unlock_irq(&chan->lock);
 
 	return ARRAY_SIZE(dpage->desc);
+
+unmap_error:
+	while (i--) {
+		ldesc--; hwdesc--;
+
+		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
+				 sizeof(hwdesc), DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static void nbpf_desc_put(struct nbpf_desc *desc)
-- 
2.43.0


