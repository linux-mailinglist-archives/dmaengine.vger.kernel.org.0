Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB95C2EACB1
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jan 2021 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbhAEOEc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jan 2021 09:04:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:56872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbhAEOE0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Jan 2021 09:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 715C8AE63;
        Tue,  5 Jan 2021 14:03:42 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 04/10] spi: txx9: Remove driver
Date:   Tue,  5 Jan 2021 15:02:49 +0100
Message-Id: <20210105140305.141401-5-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105140305.141401-1-tsbogend@alpha.franken.de>
References: <20210105140305.141401-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CPU support for TX49xx is getting removed, so remove support SPI driver
for it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/spi/Kconfig    |   6 -
 drivers/spi/Makefile   |   1 -
 drivers/spi/spi-txx9.c | 477 -----------------------------------------
 3 files changed, 484 deletions(-)
 delete mode 100644 drivers/spi/spi-txx9.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea052f51..7e9d91bbb996 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -885,12 +885,6 @@ config SPI_TOPCLIFF_PCH
 	  This driver also supports the ML7213/ML7223/ML7831, a companion chip
 	  for the Atom E6xx series and compatible with the Intel EG20T PCH.
 
-config SPI_TXX9
-	tristate "Toshiba TXx9 SPI controller"
-	depends on GPIOLIB && (CPU_TX49XX || COMPILE_TEST)
-	help
-	  SPI driver for Toshiba TXx9 MIPS SoCs
-
 config SPI_UNIPHIER
 	tristate "Socionext UniPhier SPI Controller"
 	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea5821662e..9578b40e7800 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -122,7 +122,6 @@ obj-$(CONFIG_SPI_TLE62X0)		+= spi-tle62x0.o
 spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
 obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
-obj-$(CONFIG_SPI_TXX9)			+= spi-txx9.o
 obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
deleted file mode 100644
index 3606232f190f..000000000000
--- a/drivers/spi/spi-txx9.c
+++ /dev/null
@@ -1,477 +0,0 @@
-/*
- * TXx9 SPI controller driver.
- *
- * Based on linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- *
- * Convert to generic SPI framework - Atsushi Nemoto (anemo@mba.ocn.ne.jp)
- */
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
-#include <linux/spi/spi.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/gpio/machine.h>
-#include <linux/gpio/consumer.h>
-
-
-#define SPI_FIFO_SIZE 4
-#define SPI_MAX_DIVIDER 0xff	/* Max. value for SPCR1.SER */
-#define SPI_MIN_DIVIDER 1	/* Min. value for SPCR1.SER */
-
-#define TXx9_SPMCR		0x00
-#define TXx9_SPCR0		0x04
-#define TXx9_SPCR1		0x08
-#define TXx9_SPFS		0x0c
-#define TXx9_SPSR		0x14
-#define TXx9_SPDR		0x18
-
-/* SPMCR : SPI Master Control */
-#define TXx9_SPMCR_OPMODE	0xc0
-#define TXx9_SPMCR_CONFIG	0x40
-#define TXx9_SPMCR_ACTIVE	0x80
-#define TXx9_SPMCR_SPSTP	0x02
-#define TXx9_SPMCR_BCLR		0x01
-
-/* SPCR0 : SPI Control 0 */
-#define TXx9_SPCR0_TXIFL_MASK	0xc000
-#define TXx9_SPCR0_RXIFL_MASK	0x3000
-#define TXx9_SPCR0_SIDIE	0x0800
-#define TXx9_SPCR0_SOEIE	0x0400
-#define TXx9_SPCR0_RBSIE	0x0200
-#define TXx9_SPCR0_TBSIE	0x0100
-#define TXx9_SPCR0_IFSPSE	0x0010
-#define TXx9_SPCR0_SBOS		0x0004
-#define TXx9_SPCR0_SPHA		0x0002
-#define TXx9_SPCR0_SPOL		0x0001
-
-/* SPSR : SPI Status */
-#define TXx9_SPSR_TBSI		0x8000
-#define TXx9_SPSR_RBSI		0x4000
-#define TXx9_SPSR_TBS_MASK	0x3800
-#define TXx9_SPSR_RBS_MASK	0x0700
-#define TXx9_SPSR_SPOE		0x0080
-#define TXx9_SPSR_IFSD		0x0008
-#define TXx9_SPSR_SIDLE		0x0004
-#define TXx9_SPSR_STRDY		0x0002
-#define TXx9_SPSR_SRRDY		0x0001
-
-
-struct txx9spi {
-	struct work_struct work;
-	spinlock_t lock;	/* protect 'queue' */
-	struct list_head queue;
-	wait_queue_head_t waitq;
-	void __iomem *membase;
-	int baseclk;
-	struct clk *clk;
-	struct gpio_desc *last_chipselect;
-	int last_chipselect_val;
-};
-
-static u32 txx9spi_rd(struct txx9spi *c, int reg)
-{
-	return __raw_readl(c->membase + reg);
-}
-static void txx9spi_wr(struct txx9spi *c, u32 val, int reg)
-{
-	__raw_writel(val, c->membase + reg);
-}
-
-static void txx9spi_cs_func(struct spi_device *spi, struct txx9spi *c,
-		int on, unsigned int cs_delay)
-{
-	/*
-	 * The GPIO descriptor will track polarity inversion inside
-	 * gpiolib.
-	 */
-	if (on) {
-		/* deselect the chip with cs_change hint in last transfer */
-		if (c->last_chipselect)
-			gpiod_set_value(c->last_chipselect,
-					!c->last_chipselect_val);
-		c->last_chipselect = spi->cs_gpiod;
-		c->last_chipselect_val = on;
-	} else {
-		c->last_chipselect = NULL;
-		ndelay(cs_delay);	/* CS Hold Time */
-	}
-	gpiod_set_value(spi->cs_gpiod, on);
-	ndelay(cs_delay);	/* CS Setup Time / CS Recovery Time */
-}
-
-static int txx9spi_setup(struct spi_device *spi)
-{
-	struct txx9spi *c = spi_master_get_devdata(spi->master);
-
-	if (!spi->max_speed_hz)
-		return -EINVAL;
-
-	/* deselect chip */
-	spin_lock(&c->lock);
-	txx9spi_cs_func(spi, c, 0, (NSEC_PER_SEC / 2) / spi->max_speed_hz);
-	spin_unlock(&c->lock);
-
-	return 0;
-}
-
-static irqreturn_t txx9spi_interrupt(int irq, void *dev_id)
-{
-	struct txx9spi *c = dev_id;
-
-	/* disable rx intr */
-	txx9spi_wr(c, txx9spi_rd(c, TXx9_SPCR0) & ~TXx9_SPCR0_RBSIE,
-			TXx9_SPCR0);
-	wake_up(&c->waitq);
-	return IRQ_HANDLED;
-}
-
-static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
-{
-	struct spi_device *spi = m->spi;
-	struct spi_transfer *t;
-	unsigned int cs_delay;
-	unsigned int cs_change = 1;
-	int status = 0;
-	u32 mcr;
-	u32 prev_speed_hz = 0;
-	u8 prev_bits_per_word = 0;
-
-	/* CS setup/hold/recovery time in nsec */
-	cs_delay = 100 + (NSEC_PER_SEC / 2) / spi->max_speed_hz;
-
-	mcr = txx9spi_rd(c, TXx9_SPMCR);
-	if (unlikely((mcr & TXx9_SPMCR_OPMODE) == TXx9_SPMCR_ACTIVE)) {
-		dev_err(&spi->dev, "Bad mode.\n");
-		status = -EIO;
-		goto exit;
-	}
-	mcr &= ~(TXx9_SPMCR_OPMODE | TXx9_SPMCR_SPSTP | TXx9_SPMCR_BCLR);
-
-	/* enter config mode */
-	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
-	txx9spi_wr(c, TXx9_SPCR0_SBOS
-			| ((spi->mode & SPI_CPOL) ? TXx9_SPCR0_SPOL : 0)
-			| ((spi->mode & SPI_CPHA) ? TXx9_SPCR0_SPHA : 0)
-			| 0x08,
-			TXx9_SPCR0);
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		const void *txbuf = t->tx_buf;
-		void *rxbuf = t->rx_buf;
-		u32 data;
-		unsigned int len = t->len;
-		unsigned int wsize;
-		u32 speed_hz = t->speed_hz;
-		u8 bits_per_word = t->bits_per_word;
-
-		wsize = bits_per_word >> 3; /* in bytes */
-
-		if (prev_speed_hz != speed_hz
-				|| prev_bits_per_word != bits_per_word) {
-			int n = DIV_ROUND_UP(c->baseclk, speed_hz) - 1;
-
-			n = clamp(n, SPI_MIN_DIVIDER, SPI_MAX_DIVIDER);
-			/* enter config mode */
-			txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR,
-					TXx9_SPMCR);
-			txx9spi_wr(c, (n << 8) | bits_per_word, TXx9_SPCR1);
-			/* enter active mode */
-			txx9spi_wr(c, mcr | TXx9_SPMCR_ACTIVE, TXx9_SPMCR);
-
-			prev_speed_hz = speed_hz;
-			prev_bits_per_word = bits_per_word;
-		}
-
-		if (cs_change)
-			txx9spi_cs_func(spi, c, 1, cs_delay);
-		cs_change = t->cs_change;
-		while (len) {
-			unsigned int count = SPI_FIFO_SIZE;
-			int i;
-			u32 cr0;
-
-			if (len < count * wsize)
-				count = len / wsize;
-			/* now tx must be idle... */
-			while (!(txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_SIDLE))
-				cpu_relax();
-			cr0 = txx9spi_rd(c, TXx9_SPCR0);
-			cr0 &= ~TXx9_SPCR0_RXIFL_MASK;
-			cr0 |= (count - 1) << 12;
-			/* enable rx intr */
-			cr0 |= TXx9_SPCR0_RBSIE;
-			txx9spi_wr(c, cr0, TXx9_SPCR0);
-			/* send */
-			for (i = 0; i < count; i++) {
-				if (txbuf) {
-					data = (wsize == 1)
-						? *(const u8 *)txbuf
-						: *(const u16 *)txbuf;
-					txx9spi_wr(c, data, TXx9_SPDR);
-					txbuf += wsize;
-				} else
-					txx9spi_wr(c, 0, TXx9_SPDR);
-			}
-			/* wait all rx data */
-			wait_event(c->waitq,
-				txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_RBSI);
-			/* receive */
-			for (i = 0; i < count; i++) {
-				data = txx9spi_rd(c, TXx9_SPDR);
-				if (rxbuf) {
-					if (wsize == 1)
-						*(u8 *)rxbuf = data;
-					else
-						*(u16 *)rxbuf = data;
-					rxbuf += wsize;
-				}
-			}
-			len -= count * wsize;
-		}
-		m->actual_length += t->len;
-		spi_transfer_delay_exec(t);
-
-		if (!cs_change)
-			continue;
-		if (t->transfer_list.next == &m->transfers)
-			break;
-		/* sometimes a short mid-message deselect of the chip
-		 * may be needed to terminate a mode or command
-		 */
-		txx9spi_cs_func(spi, c, 0, cs_delay);
-	}
-
-exit:
-	m->status = status;
-	if (m->complete)
-		m->complete(m->context);
-
-	/* normally deactivate chipselect ... unless no error and
-	 * cs_change has hinted that the next message will probably
-	 * be for this chip too.
-	 */
-	if (!(status == 0 && cs_change))
-		txx9spi_cs_func(spi, c, 0, cs_delay);
-
-	/* enter config mode */
-	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
-}
-
-static void txx9spi_work(struct work_struct *work)
-{
-	struct txx9spi *c = container_of(work, struct txx9spi, work);
-	unsigned long flags;
-
-	spin_lock_irqsave(&c->lock, flags);
-	while (!list_empty(&c->queue)) {
-		struct spi_message *m;
-
-		m = container_of(c->queue.next, struct spi_message, queue);
-		list_del_init(&m->queue);
-		spin_unlock_irqrestore(&c->lock, flags);
-
-		txx9spi_work_one(c, m);
-
-		spin_lock_irqsave(&c->lock, flags);
-	}
-	spin_unlock_irqrestore(&c->lock, flags);
-}
-
-static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
-{
-	struct spi_master *master = spi->master;
-	struct txx9spi *c = spi_master_get_devdata(master);
-	struct spi_transfer *t;
-	unsigned long flags;
-
-	m->actual_length = 0;
-
-	/* check each transfer's parameters */
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (!t->tx_buf && !t->rx_buf && t->len)
-			return -EINVAL;
-	}
-
-	spin_lock_irqsave(&c->lock, flags);
-	list_add_tail(&m->queue, &c->queue);
-	schedule_work(&c->work);
-	spin_unlock_irqrestore(&c->lock, flags);
-
-	return 0;
-}
-
-/*
- * Chip select uses GPIO only, further the driver is using the chip select
- * numer (from the device tree "reg" property, and this can only come from
- * device tree since this i MIPS and there is no way to pass platform data) as
- * the GPIO number. As the platform has only one GPIO controller (the txx9 GPIO
- * chip) it is thus using the chip select number as an offset into that chip.
- * This chip has a maximum of 16 GPIOs 0..15 and this is what all platforms
- * register.
- *
- * We modernized this behaviour by explicitly converting that offset to an
- * offset on the GPIO chip using a GPIO descriptor machine table of the same
- * size as the txx9 GPIO chip with a 1-to-1 mapping of chip select to GPIO
- * offset.
- *
- * This is admittedly a hack, but it is countering the hack of using "reg" to
- * contain a GPIO offset when it should be using "cs-gpios" as the SPI bindings
- * state.
- */
-static struct gpiod_lookup_table txx9spi_cs_gpio_table = {
-	.dev_id = "spi0",
-	.table = {
-		GPIO_LOOKUP_IDX("TXx9", 0, "cs", 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 1, "cs", 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 2, "cs", 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 3, "cs", 3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 4, "cs", 4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 5, "cs", 5, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 6, "cs", 6, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 7, "cs", 7, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 8, "cs", 8, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 9, "cs", 9, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 10, "cs", 10, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 11, "cs", 11, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 12, "cs", 12, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 13, "cs", 13, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 14, "cs", 14, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("TXx9", 15, "cs", 15, GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
-static int txx9spi_probe(struct platform_device *dev)
-{
-	struct spi_master *master;
-	struct txx9spi *c;
-	struct resource *res;
-	int ret = -ENODEV;
-	u32 mcr;
-	int irq;
-
-	master = spi_alloc_master(&dev->dev, sizeof(*c));
-	if (!master)
-		return ret;
-	c = spi_master_get_devdata(master);
-	platform_set_drvdata(dev, master);
-
-	INIT_WORK(&c->work, txx9spi_work);
-	spin_lock_init(&c->lock);
-	INIT_LIST_HEAD(&c->queue);
-	init_waitqueue_head(&c->waitq);
-
-	c->clk = devm_clk_get(&dev->dev, "spi-baseclk");
-	if (IS_ERR(c->clk)) {
-		ret = PTR_ERR(c->clk);
-		c->clk = NULL;
-		goto exit;
-	}
-	ret = clk_prepare_enable(c->clk);
-	if (ret) {
-		c->clk = NULL;
-		goto exit;
-	}
-	c->baseclk = clk_get_rate(c->clk);
-	master->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
-	master->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	c->membase = devm_ioremap_resource(&dev->dev, res);
-	if (IS_ERR(c->membase))
-		goto exit_busy;
-
-	/* enter config mode */
-	mcr = txx9spi_rd(c, TXx9_SPMCR);
-	mcr &= ~(TXx9_SPMCR_OPMODE | TXx9_SPMCR_SPSTP | TXx9_SPMCR_BCLR);
-	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
-
-	irq = platform_get_irq(dev, 0);
-	if (irq < 0)
-		goto exit_busy;
-	ret = devm_request_irq(&dev->dev, irq, txx9spi_interrupt, 0,
-			       "spi_txx9", c);
-	if (ret)
-		goto exit;
-
-	c->last_chipselect = NULL;
-
-	dev_info(&dev->dev, "at %#llx, irq %d, %dMHz\n",
-		 (unsigned long long)res->start, irq,
-		 (c->baseclk + 500000) / 1000000);
-
-	gpiod_add_lookup_table(&txx9spi_cs_gpio_table);
-
-	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
-
-	master->bus_num = dev->id;
-	master->setup = txx9spi_setup;
-	master->transfer = txx9spi_transfer;
-	master->num_chipselect = (u16)UINT_MAX; /* any GPIO numbers */
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->use_gpio_descriptors = true;
-
-	ret = devm_spi_register_master(&dev->dev, master);
-	if (ret)
-		goto exit;
-	return 0;
-exit_busy:
-	ret = -EBUSY;
-exit:
-	clk_disable_unprepare(c->clk);
-	spi_master_put(master);
-	return ret;
-}
-
-static int txx9spi_remove(struct platform_device *dev)
-{
-	struct spi_master *master = platform_get_drvdata(dev);
-	struct txx9spi *c = spi_master_get_devdata(master);
-
-	flush_work(&c->work);
-	clk_disable_unprepare(c->clk);
-	return 0;
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:spi_txx9");
-
-static struct platform_driver txx9spi_driver = {
-	.probe = txx9spi_probe,
-	.remove = txx9spi_remove,
-	.driver = {
-		.name = "spi_txx9",
-	},
-};
-
-static int __init txx9spi_init(void)
-{
-	return platform_driver_register(&txx9spi_driver);
-}
-subsys_initcall(txx9spi_init);
-
-static void __exit txx9spi_exit(void)
-{
-	platform_driver_unregister(&txx9spi_driver);
-}
-module_exit(txx9spi_exit);
-
-MODULE_DESCRIPTION("TXx9 SPI Driver");
-MODULE_LICENSE("GPL");
-- 
2.29.2

