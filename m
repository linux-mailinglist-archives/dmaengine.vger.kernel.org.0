Return-Path: <dmaengine+bounces-6125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE9B30C39
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3002C1D00C94
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C026FA53;
	Fri, 22 Aug 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MQiYRw6w"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD426F462
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832021; cv=none; b=uj0HuXaWY5AnuGR2kHF6xS5fV0P9K9ezpRNdZehRW7lgakAgYCwIRENfaq2j8IiY0YlSdNTPTXotnX+7WSVao5mepTWKaXoTmNu6PAdNIm03+lvFXDN1aruCa9+GqAz1ZAd61gaZRIZzF7tu99MXWz2pAw4irnHzv7HOIFAx8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832021; c=relaxed/simple;
	bh=JP0Sw65EOT4NHCK35qrtENIdh4sdphX+d8qoRvIjZfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGygoGovClCvog198C4HW4W8nHhyrn1ZT96o4WK3bteTuO7D4P7ogdGX4ojhM7/Y3gvIlX4RF57CnHqIUhLIOpYMw6lIK2atrLcC6NQ29MyWjpHt44mNACu7XsEGVb9bzkV7ZMe96gmaagqwdKdWQjK+8M8XfrYZoX84uIw2ILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MQiYRw6w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso1217705b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832019; x=1756436819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtQvt8lm8/UHHNz+8CMXd5C/9rKefGZFh5EhUafS5gg=;
        b=MQiYRw6wDJ3Y124qd4SBPUb8Wpkprab56WT4U/0w8TqivGWQmKQPn0G7OsOPN3vox0
         GmrZSqZsDGcJu56Zvjn9T4u5N7BXSSbbIWwg0oQx7gIVx9S76gUv6+lL2LDK3xxL0bZ2
         LeAOKA9wMTqhfC8DrlAXdp+0sllSeOWsgSzwsqWZve42JZx9nXX002cWUna6UnmldMGY
         /I4OuOKw4Mvl1m06ubXUc6ymtqys/t65pp/igLSadyAbFrCGwNdVHo1vsm6pFN4Yq5e5
         qbWrSB80kGc2fUvMwdmW51bsQSHukLduOIV/Cy1u8Du/W2LhANh1GIFDMn58u+GK1Nn1
         XITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832019; x=1756436819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtQvt8lm8/UHHNz+8CMXd5C/9rKefGZFh5EhUafS5gg=;
        b=C01UU6R29uFNdtS7scjncXxDYwjdDUiAsEU9P9YLPriFx/SYQi662R2dTTIu+j+sQp
         mWhiuoT+v2Syt5tDFMvGa9LuWWm6aUYXHC3LeZg9NL3jlLPSvltWKRS7lF17O8r3kwjm
         LmzNkXLgM2vIq9QZR+MLqIg0UuLZ32fwF0WgSoLc8BPkRxJUkUdDEWPvK2ccArtJTTpJ
         SrvLP6juzh2i8ic/qPgbnYqovbpPui6RtcfOEZ2wBwf/DWAYTZ3JSAq6NLLBVGDFUW94
         4BwUnYz3a8q0P3+mAwkwUHo9tvhC+QfsLaXBQa22jRxZs4G5F9cK12wEby4M8SY9F+Dw
         n/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUGtIrOUOuXzGlksFT2h7v8C5IFKz6jmXfJeYBoF/ehVEMJIxZmCVqkqcLYJHrt/NxVp7sIWFmb2WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8RmLZELsu6IXRxRDL4Bw3VB5b6YCwwdKlVWSyTz0tiBzw/Eu
	2lbu99zE7cOwOXSMGAOA/yvX7e7uGVAJYTReAvDKMsBfPCd0T57GhzeYuze522+7evg=
X-Gm-Gg: ASbGncvaea0CjPCxjb/F4epjuFYmotNLYRU20h+ZfGUyk/7HhHjsiM8QogJdl2gBmYk
	KaAxZfugC2Ty8e6lxIwqukfxwKOuKGSBFJ1WVHKDnkuuIIchwNyj9rAWxNFfatu/1mW5QcpsJoM
	rSwA+1BpJnIMacKv8oygThySjueLjKJ9BY2HVCnd2nuqhDwTUANdGvWIGZZcCJXVTtF+Lkf3nEZ
	tW+O7ZhiK4kFIpoYIazFe0bM7h21sATyGbwxalxuqppcMXEJYWKjDKmFs4hCeLuTpLI3EfYwR2a
	l1svmzSr5zxUhCcU7QSbXiivlwS0T0SnsGGPN6yzlSo7JBkQLPrwe8+CopAQ/dLVxoaGRji0UAb
	EjyN3y3sePV+86Q+ZHWX/rirFiclaSSbccQ==
X-Google-Smtp-Source: AGHT+IFy0F1It4YMiy66wNzMrVWGW3rtyeZwnA2Mto2V1Iiq0zsuEd/8gIg4XCp3DGmUoishTl063A==
X-Received: by 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr2292745637.14.1755832019211;
        Thu, 21 Aug 2025 20:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:06:58 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:31 +0800
Subject: [PATCH v5 5/8] dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support
 with 64-bit addressing
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-5-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add support for SpacemiT K1 PDMA controller which features 64-bit
addressing capabilities.

The SpacemiT K1 PDMA extends the descriptor format with additional
32-bit words for high address bits, enabling access to memory beyond
4GB boundaries. The new spacemit_k1_pdma_ops provides necessary 64-bit
address handling functions and k1 specific controller configurations.

Key changes:
- Add ARCH_SPACEMIT dependency to Kconfig
- Define new high 32-bit address registers (DDADRH, DSADRH, DTADRH)
- Add DCSR_LPAEEN bit for Long Physical Address Extension Enable
- Implement 64-bit operations for SpacemiT K1 PDMA

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change.
v4: No change.
v3: No change.
v2: New patch.
  - Implement 64-bit addrssing support to mmp_pdma
  - Add support for SpacemiT K1 PDMA
  - Extend the MMP_PDMA entry in Kconfig to depend on ARCH_SPACEMIT
---
 drivers/dma/Kconfig    |  2 +-
 drivers/dma/mmp_pdma.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 05c7c7d9e5a4e52a8ad7ada8c8b9b1a6f9d875f6..b8a74b1798ba1d44b26553990428c065de6fc535 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -450,7 +450,7 @@ config MILBEAUT_XDMAC
 
 config MMP_PDMA
 	tristate "MMP PDMA support"
-	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
+	depends on ARCH_MMP || ARCH_PXA || ARCH_SPACEMIT || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the MMP PDMA engine for PXA and MMP platform.
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 38d1a4cdfd0e92e53c77b61caa1133559ef40dbd..d07229a748868b8115892c63c54c16130d88e326 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -28,6 +28,9 @@
 #define DDADR(n)	(0x0200 + ((n) << 4))
 #define DSADR(n)	(0x0204 + ((n) << 4))
 #define DTADR(n)	(0x0208 + ((n) << 4))
+#define DDADRH(n)	(0x0300 + ((n) << 4))
+#define DSADRH(n)	(0x0304 + ((n) << 4))
+#define DTADRH(n)	(0x0308 + ((n) << 4))
 #define DCMD		0x020c
 
 #define DCSR_RUN	BIT(31)	/* Run Bit (read / write) */
@@ -44,6 +47,7 @@
 #define DCSR_EORSTOPEN	BIT(26)	/* STOP on an EOR */
 #define DCSR_SETCMPST	BIT(25)	/* Set Descriptor Compare Status */
 #define DCSR_CLRCMPST	BIT(24)	/* Clear Descriptor Compare Status */
+#define DCSR_LPAEEN	BIT(21)	/* Long Physical Address Extension Enable */
 #define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
 #define DCSR_EORINTR	BIT(9)	/* The end of Receive */
 
@@ -76,6 +80,16 @@ struct mmp_pdma_desc_hw {
 	u32 dsadr;	/* DSADR value for the current transfer */
 	u32 dtadr;	/* DTADR value for the current transfer */
 	u32 dcmd;	/* DCMD value for the current transfer */
+	/*
+	 * The following 32-bit words are only used in the 64-bit, ie.
+	 * LPAE (Long Physical Address Extension) mode.
+	 * They are used to specify the high 32 bits of the descriptor's
+	 * addresses.
+	 */
+	u32 ddadrh;	/* High 32-bit of DDADR */
+	u32 dsadrh;	/* High 32-bit of DSADR */
+	u32 dtadrh;	/* High 32-bit of DTADR */
+	u32 rsvd;	/* reserved */
 } __aligned(32);
 
 struct mmp_pdma_desc_sw {
@@ -222,6 +236,57 @@ static u64 get_desc_dst_addr_32(const struct mmp_pdma_desc_hw *desc)
 	return desc->dtadr;
 }
 
+/* For 64-bit PDMA */
+static void write_next_addr_64(struct mmp_pdma_phy *phy, dma_addr_t addr)
+{
+	writel(lower_32_bits(addr), phy->base + DDADR(phy->idx));
+	writel(upper_32_bits(addr), phy->base + DDADRH(phy->idx));
+}
+
+static u64 read_src_addr_64(struct mmp_pdma_phy *phy)
+{
+	u32 low = readl(phy->base + DSADR(phy->idx));
+	u32 high = readl(phy->base + DSADRH(phy->idx));
+
+	return ((u64)high << 32) | low;
+}
+
+static u64 read_dst_addr_64(struct mmp_pdma_phy *phy)
+{
+	u32 low = readl(phy->base + DTADR(phy->idx));
+	u32 high = readl(phy->base + DTADRH(phy->idx));
+
+	return ((u64)high << 32) | low;
+}
+
+static void set_desc_next_addr_64(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->ddadr = lower_32_bits(addr);
+	desc->ddadrh = upper_32_bits(addr);
+}
+
+static void set_desc_src_addr_64(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->dsadr = lower_32_bits(addr);
+	desc->dsadrh = upper_32_bits(addr);
+}
+
+static void set_desc_dst_addr_64(struct mmp_pdma_desc_hw *desc, dma_addr_t addr)
+{
+	desc->dtadr = lower_32_bits(addr);
+	desc->dtadrh = upper_32_bits(addr);
+}
+
+static u64 get_desc_src_addr_64(const struct mmp_pdma_desc_hw *desc)
+{
+	return ((u64)desc->dsadrh << 32) | desc->dsadr;
+}
+
+static u64 get_desc_dst_addr_64(const struct mmp_pdma_desc_hw *desc)
+{
+	return ((u64)desc->dtadrh << 32) | desc->dtadr;
+}
+
 static int mmp_pdma_config_write(struct dma_chan *dchan,
 				 struct dma_slave_config *cfg,
 				 enum dma_transfer_direction direction);
@@ -1110,10 +1175,26 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
 	.dma_mask = 0,			/* let OF/platform set DMA mask */
 };
 
+static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
+	.write_next_addr = write_next_addr_64,
+	.read_src_addr = read_src_addr_64,
+	.read_dst_addr = read_dst_addr_64,
+	.set_desc_next_addr = set_desc_next_addr_64,
+	.set_desc_src_addr = set_desc_src_addr_64,
+	.set_desc_dst_addr = set_desc_dst_addr_64,
+	.get_desc_src_addr = get_desc_src_addr_64,
+	.get_desc_dst_addr = get_desc_dst_addr_64,
+	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
+	.dma_mask = DMA_BIT_MASK(64),	/* force 64-bit DMA addr capability */
+};
+
 static const struct of_device_id mmp_pdma_dt_ids[] = {
 	{
 		.compatible = "marvell,pdma-1.0",
 		.data = &marvell_pdma_v1_ops
+	}, {
+		.compatible = "spacemit,k1-pdma",
+		.data = &spacemit_k1_pdma_ops
 	}, {
 		/* sentinel */
 	}

-- 
2.43.0


