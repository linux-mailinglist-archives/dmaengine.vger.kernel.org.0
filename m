Return-Path: <dmaengine+bounces-10235-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBENNm1U+2n+ZQMAu9opvQ
	(envelope-from <dmaengine+bounces-10235-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:47:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AEF4DC887
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D11B3037DFD
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F14657CE;
	Wed,  6 May 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG7Kq/4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F813F0ABA;
	Wed,  6 May 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077939; cv=none; b=L/aSe1tyTN8o37NguAZ8KjAJQq83L6k+1BUW3Y2UYBo+prO4k0mhG19F6RTzyFEY9GBNWYwsd10+eQlnoU/jHZ4u/m9bkIak6xDmIpK6Yg44+LOQMLo9sswEKlyPp5c5YjKcPeXSD7e8Om996TW1oCtuBn8K+yAkS2xggY5+XM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077939; c=relaxed/simple;
	bh=AqWk/gJ5hqvNp1Kqlei525mUSD0PPb1ErEKjbefLrZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1GqrRuSAnJ498iYSIvBiBzzVDOM/HhlUzgjjck/DEfA9of8xcrYrM6fLed123AL56qflmiaPWi+lTKO30JeQ194YOqAubT83VV55Gd9ype96Mzt47YO32RIffdvca9Qub0ZGe8gfQJSI8BAN4Mewt2cHr0YDLU2mPIurr65OVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG7Kq/4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04608C2BCB0;
	Wed,  6 May 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778077939;
	bh=AqWk/gJ5hqvNp1Kqlei525mUSD0PPb1ErEKjbefLrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HG7Kq/4sbv3k644MoiN65Tkll1t2azZNRjO+ntFHMkOA0OnoZ/Y3RHJ0gH+7yFJQn
	 bBcSX7FQTkgY+ZDL/WzPV6VPkrthYNo5Gp53UnBkE52VdIuhH2zPJK+U3ztO0Pw5LZ
	 7cSx3hARFb0AFj0Il/TRkfOGJVi85KvtQ6q1MERgxeB1o7qXI+gexK3M1hiunhMV7g
	 36H+kO3WfeAVJuNlv6D98zTzkAAd79pEJJsAtbxCswSruDLTGsEvCSX0YCAQozQGPX
	 9gLSVxWC5UCVE8x5xAz9JpKTl33xGxz4ieE0Je7YbYgshZPH9zdGOecxJVgSA6simL
	 nEiLtZzYWujnQ==
From: Greg Ungerer <gerg@kernel.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	dmaengine@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	adureghello@baylibre.com
Subject: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Date: Thu,  7 May 2026 00:26:48 +1000
Message-ID: <20260506142644.3234270-8-gerg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506142644.3234270-2-gerg@kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80AEF4DC887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux-m68k.org,gmail.com,baylibre.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10235-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

From: Greg Ungerer <gerg@linux-m68k.org>

Remove the local ColdFire definitions of readb()/readw()/readl() and
writeb()/writew()/writel() and use the asm-generic versions of them.

The implementation of the readX()/writeX() family of IO access functions
is non-standard on ColdFire platforms. They either return big-endian (that
is native endian) data, or on platforms with PCI bus support check the
supplied address and return either big or little endian data based on that
check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are currently broken because they are implemented
using the readX()/writeX() functions.

The change to use the asm-generic versions of readX()/writeX() itself is
quite strait forward, just remove the ColdFire local versions of them.  But
this of course has implications for any remaining drivers that use any of
these IO access functions. A number of drivers can be independently fixed,
before this final fix to readX()/writeX() for ColdFire. A small number of
drivers cannot easily be independently fixed and remain in a working
state. Those drivers are fixed here as well:

drivers/dma/mcf-edma-main.c
  Supports big-endian access by setting the big-endian flag of
  the drivers struct fsl_edma_engine. But locally should be using
  ioread32be() and iowrite32be() instead of ioread32() and iowrite32().

drivers/net/can/flexcan/flexcan-core.c
  Setting the driver quirks flag for big-endian access will force
  driver to use correct access functions.

drivers/spi/spi-fsl-dspi.c
  Setting the regmap format_endian flags to use native endian will
  force driver to use appropriate big or little endian access on
  whatever platform it is built for.

These drivers have only been compile tested.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/io_no.h          | 68 +++-----------------------
 drivers/dma/mcf-edma-main.c            | 14 +++---
 drivers/net/can/flexcan/flexcan-core.c |  1 +
 drivers/spi/spi-fsl-dspi.c             |  2 +
 4 files changed, 16 insertions(+), 69 deletions(-)

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 4f0f34b06e37..2f12f4ed0da5 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -3,15 +3,10 @@
 #define _M68KNOMMU_IO_H
 
 /*
- * Convert a physical memory address into a IO memory address.
- * For us this is trivially a type cast.
- */
-#define iomem(a)	((void __iomem *) (a))
-
-/*
- * The non-MMU m68k and ColdFire IO and memory mapped hardware access
- * functions have always worked in CPU native endian. We need to define
- * that behavior here first before we include asm-generic/io.h.
+ * Historically the raw native endian IO access macros for non-MMU m68k and
+ * ColdFire have accepted any integral value as the address argument.
+ * The asm-generic versions of these expect "void __iomem *" for the address,
+ * so define local permissive versions here.
  */
 #define __raw_readb(addr) \
     ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
@@ -45,66 +40,15 @@
  * applies just the same of there is no MMU but something like a PCI bus
  * is present.
  */
-static int __cf_internalio(unsigned long addr)
+static inline int __cf_internalio(unsigned long addr)
 {
 	return (addr >= IOMEMBASE) && (addr <= IOMEMBASE + IOMEMSIZE - 1);
 }
 
-static int cf_internalio(const volatile void __iomem *addr)
+static inline int cf_internalio(const volatile void __iomem *addr)
 {
 	return __cf_internalio((unsigned long) addr);
 }
-
-/*
- * We need to treat built-in peripherals and bus based address ranges
- * differently. Local built-in peripherals (and the ColdFire SoC parts
- * have quite a lot of them) are always native endian - which is big
- * endian on m68k/ColdFire. Bus based address ranges, like the PCI bus,
- * are accessed little endian - so we need to byte swap those.
- */
-#define readw readw
-static inline u16 readw(const volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		return __raw_readw(addr);
-	return swab16(__raw_readw(addr));
-}
-
-#define readl readl
-static inline u32 readl(const volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		return __raw_readl(addr);
-	return swab32(__raw_readl(addr));
-}
-
-#define writew writew
-static inline void writew(u16 value, volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		__raw_writew(value, addr);
-	else
-		__raw_writew(swab16(value), addr);
-}
-
-#define writel writel
-static inline void writel(u32 value, volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		__raw_writel(value, addr);
-	else
-		__raw_writel(swab32(value), addr);
-}
-
-#else
-
-#define readb __raw_readb
-#define readw __raw_readw
-#define readl __raw_readl
-#define writeb __raw_writeb
-#define writew __raw_writew
-#define writel __raw_writel
-
 #endif /* IOMEMBASE */
 
 #if defined(CONFIG_COLDFIRE)
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 9e1c6400c77b..4ed0ce644e37 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	unsigned int ch;
 	u64 intmap;
 
-	intmap = ioread32(regs->inth);
+	intmap = ioread32be(regs->inth);
 	intmap <<= 32;
-	intmap |= ioread32(regs->intl);
+	intmap |= ioread32be(regs->intl);
 	if (!intmap)
 		return IRQ_NONE;
 
@@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 	struct edma_regs *regs = &mcf_edma->regs;
 	unsigned int err, ch;
 
-	err = ioread32(regs->errl);
+	err = ioread32be(regs->errl);
 	if (!err)
 		return IRQ_NONE;
 
@@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 		}
 	}
 
-	err = ioread32(regs->errh);
+	err = ioread32be(regs->errh);
 	if (!err)
 		return IRQ_NONE;
 
@@ -203,8 +203,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
 	}
 
-	iowrite32(~0, regs->inth);
-	iowrite32(~0, regs->intl);
+	iowrite32be(~0, regs->inth);
+	iowrite32be(~0, regs->intl);
 
 	ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
 	if (ret)
@@ -248,7 +248,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	}
 
 	/* Enable round robin arbitration */
-	iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	iowrite32be(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..a682f02d2c43 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -296,6 +296,7 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
+		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
 };
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9f2a7b8163b1..964ca6baf32f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -203,6 +203,8 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.volatile_table	= &dspi_volatile_table,
 		.rd_table	= &dspi_access_table,
 		.wr_table	= &dspi_access_table,
+		.reg_format_endian = REGMAP_ENDIAN_NATIVE,
+		.val_format_endian = REGMAP_ENDIAN_NATIVE,
 	},
 	[S32G_DSPI_REGMAP] = {
 		.reg_bits	= 32,
-- 
2.54.0


