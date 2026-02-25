Return-Path: <dmaengine+bounces-9063-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCXEJ9bRnmkJXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9063-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:41:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C156B195E69
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F115530200E6
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB73939A4;
	Wed, 25 Feb 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znj+e3ib"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50882392C4E
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016075; cv=none; b=nHhS6zXB2gMiYIaSyIJN42s2R8oS0l73IvMHrJ77I5tvDdVx+oMINMfKExC3dPDnC2NhUp5pRNvVYO1ZWU07dFYHQl2qZ32W216S+4lAYuDqTynMILxs0I18hKpqlvX8Sr97omqlR9SujHKlYGaOyhrPgV1fKoaCVyqBIWwtoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016075; c=relaxed/simple;
	bh=p0pJb4wR6PRU+wXa5zMbGWI2UmzpUtuLQnTO26ezUMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Ke2ixF4MIqnF2v+16H92aLaSypdvGBjczATAQUvVBsrisomtYTbeXr9jjBrPoE7aCaydl5uCE2cX/BfFZwhQUYayrlgCOF3a+9uBY/xWWStxsjkXeXIx7w2+8tb1N8KE9d5trRvCFBTaTkC5E0AqGYNNmiFFamcKnw6Uces2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znj+e3ib; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a962230847so62713055ad.3
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 02:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772016074; x=1772620874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5peVG9Q2XYh9oaZWaeVmzNFFF3WeNUswB5+Or4VvBI=;
        b=Znj+e3ibmYiafoE46A1UNJTQj7VGce5NnLZU3P1BgKRFQ1FtoxzIq9m2DaNHBwAbVh
         DeOyfAm59JYoYf2XuQ0brXd8hcD+FPuwpG3773yF7I4KuG1Q/xnFwQZZrYOM0E4O6TSw
         Zcnrma/+0talgzXvef2Mnu9EbP9lkjs0F4JMpsPTjCrxFqTIA4QPHXJNaQwgt5pvLvvA
         clYTMffTm1WrOIr23R6UJwmBNcieyt6HYNnW2AduINIimMQIPIny/sbmHojDV/QHa6Lx
         G21izo1o15t4bnO+3OZ1+oK8CMm26THRd590+KbUQHyQIQU6hhMqmbQhsEvE19s053Yh
         b4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016074; x=1772620874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5peVG9Q2XYh9oaZWaeVmzNFFF3WeNUswB5+Or4VvBI=;
        b=kWkWxxoXTywVCnMpxzh9iZIMjnf9J1ZXdott6fzBQBJf3Rh9Ahnycy2ip3MAJ45YDF
         9yfL9cLk/myZ1z/CxSGJ2m38pJrwVCGLyCn3MAKfAGaY+fe78/BoFDaDCfYuPmx6ADkq
         uGPgJobkDn3XmNscgPsqk5/R+g1ERYvEhledwT2Oxw86t1HTWI+Hvc3QoSnVnGAYqpIh
         k/3OuJARcsvs1Yc3wVW6yxyjxLvErDhiQMUr7OswSMU8zzjsHI6xUAqbGtKHaf7CMDpk
         579bo5zaes7ieGnpaXfyj8V93sW5NFq8HFw2KZ0SpzE55JrUe3R+jW8r/DQ4eadoTeOm
         g4LA==
X-Gm-Message-State: AOJu0Yz1sSAKM7+ckCiEjpMV+5yznvYkZpz7jClWVVTOJOS5vWPch+HI
	mwdiU41AfA4G4FFT3Ji8m5ysT25XbE6zhf+aWabjmUl2/EPaeCbq/oUA
X-Gm-Gg: ATEYQzxM3PmW0DwdX2wzxC/VqDDQZKJUCIfar798f2+eJplw8fF5jX89hXeTlLxmU+u
	T/th8cLKY9h93ixO4FdB15STj7rsGf6BYIoBZOjMtmwnS3Vp8X3qc7T4A2ctl6EbZYkr0NTXSuD
	P+Eu04561lJYDPBK+4YLJEXW7+y5Up1rnHSIqeCDDyHL2WL6UMxXmSbGNYJ2GXuwcVb6PXAg9hK
	S6N61ZTOtBw6xc/5ael0ZI/kU/WHQzuR0d7i2Bii6Ufp3xTpdPkbL9cm4erQpswcYpGUzuOByTo
	FDk3pLssUVi9CFdVr+TLwzBKjKatQo4Pj5IfsdJvQs0B/RKKvpXl2o+4HHv6r91WoivlxNv2DdS
	Xa2bym1K9U+1/AsBbpA7+BknJpDxogPRCDsr6ZGyFw08adoeH45pzFVNXSQJP05qsBuPyYwcecb
	N6TDFMeb1THHYTuwrc3hCsJQ==
X-Received: by 2002:a17:903:1aa8:b0:2aa:d1e1:29d5 with SMTP id d9443c01a7336-2ad74556f97mr158162195ad.50.1772016073682;
        Wed, 25 Feb 2026 02:41:13 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dba7sm133070865ad.26.2026.02.25.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:41:13 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Ze Huang <huangze@whut.edu.cn>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
Date: Wed, 25 Feb 2026 18:40:40 +0800
Message-ID: <20260225104042.1138901-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225104042.1138901-1-inochiama@gmail.com>
References: <20260225104042.1138901-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9063-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,whut.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C156B195E69
X-Rspamd-Action: no action

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Allow the driver to use DMA phandle args as the channel number, so the
DMA multiplexer can route the DMA interrupt correctly.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 5d74bc29cf89..ada6dfc9b673 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -50,6 +50,7 @@
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+#define AXI_DMA_FLAG_ARG0_AS_CHAN	BIT(3)
 
 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
@@ -1358,16 +1359,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
+	unsigned int handshake = dma_spec->args[0];
 	struct dw_axi_dma *dw = ofdma->of_dma_data;
-	struct axi_dma_chan *chan;
+	struct axi_dma_chan *chan = NULL;
 	struct dma_chan *dchan;
 
-	dchan = dma_get_any_slave_channel(&dw->dma);
+	if (dw->hdata->use_handshake_as_channel_number) {
+		if (handshake >= dw->hdata->nr_channels)
+			return NULL;
+
+		chan = &dw->chan[handshake];
+		dchan = dma_get_slave_channel(&chan->vc.chan);
+	} else {
+		dchan = dma_get_any_slave_channel(&dw->dma);
+	}
+
 	if (!dchan)
 		return NULL;
 
-	chan = dchan_to_axi_dma_chan(dchan);
-	chan->hw_handshake_num = dma_spec->args[0];
+	if (!chan)
+		chan = dchan_to_axi_dma_chan(dchan);
+	chan->hw_handshake_num = handshake;
 	return dchan;
 }
 
@@ -1506,6 +1518,8 @@ static int dw_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_ARG0_AS_CHAN);
+
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1661,6 +1675,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "intel,kmb-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
+	}, {
+		.compatible = "sophgo,cv1800b-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_ARG0_AS_CHAN,
 	}, {
 		.compatible = "starfive,jh7110-axi-dma",
 		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..67cc199e24d1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
 	bool	use_cfg2;
+	bool	use_handshake_as_channel_number;
 };
 
 struct axi_dma_chan {
-- 
2.53.0


