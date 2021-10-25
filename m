Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2921438F1E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJYGKb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJYGKa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 192F96023D;
        Mon, 25 Oct 2021 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142089;
        bh=S0lJo+0WYARShpgck+fjx8vwg1Y98meLycveJEAQKHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhzQjnAcBg6WpY3PmVcFJuaItfk3+8TSXVXSOrs7u9FspmpWaLOjb0lPnUjglZtUd
         m9AgC4LSSZRANradZ4FjA/27uSc2ue24z9zeF2NAqTyKNb7PG/vKrjQny9GVt2rF93
         rukEPiHgxlyBLcgOo7mQfBaoNltKhQ2uE0hJF/sYGYEitT6ooBsBK7GFQJG0R/UP8/
         XFiEUsVTTXQEhMyJoY/Gnu2KOMppkEUv7EzhJ9o8vKbrA4Cm3ZLkqTaq3xeVDW/pN8
         RKPrAmYyN1iYBmIo0z3wNeqb+7kw4SF+ZkE5Oa5i5aHaXfk0VCr5xioI92m6sRVaX8
         0BUuTDRRzwrFQ==
Date:   Mon, 25 Oct 2021 11:38:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     jonathanh@nvidia.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        rgumasta@nvidia.com, thierry.reding@gmail.com,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v9 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <YXZJxOTb+QGPIrtb@matsya>
References: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
 <1633438536-11399-3-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633438536-11399-3-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-10-21, 18:25, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/dma/Kconfig            |   12 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1297 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1310 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 80c2c03..2eb9062 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -654,6 +654,18 @@ config TEGRA210_ADMA
>  	  peripheral and vice versa. It does not support memory to
>  	  memory data transfer.
>  
> +config TEGRA186_GPC_DMA

that should be before TEGRA2xx

> +	tristate "NVIDIA Tegra GPC DMA support"
> +	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	select DMA_ENGINE
> +	help
> +	  Support for the NVIDIA Tegra186 and Tegra194 GPC DMA controller
> +	  driver. The DMA controller has multiple DMA channels which can
> +	  be configured for different peripherals like UART, SPI, etc
> +	  which are on APB bus.
> +	  This DMA controller transfers data from memory to peripheral FIFO
> +	  or vice versa. It also supports memory to memory data transfer.
> +
>  config TIMB_DMA
>  	tristate "Timberdale FPGA DMA support"
>  	depends on MFD_TIMBERDALE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 616d926..b701006 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
>  obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
> +obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o

that should be before TEGRA2xx

>  obj-$(CONFIG_TIMB_DMA) += timb_dma.o
>  obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
>  obj-$(CONFIG_UNIPHIER_XDMAC) += uniphier-xdmac.o
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> new file mode 100644
> index 0000000..d21aa07
> --- /dev/null
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -0,0 +-2,1294 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DMA driver for NVIDIA Tegra186 and Tegra194 GPC DMA controller.
> + *
> + * Copyright (c) 2014-2021, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/minmax.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/iommu.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/version.h>
> +#include <dt-bindings/memory/tegra186-mc.h>
> +#include "virt-dma.h"

do you need all these...? pls check and remove the headers not required


> +
> +/* CSR register */
> +#define TEGRA_GPCDMA_CHAN_CSR			0x00
> +#define TEGRA_GPCDMA_CSR_ENB			BIT(31)
> +#define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
> +#define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
> +
> +#define TEGRA_GPCDMA_CSR_FC_MODE		GENMASK(25, 24)
> +#define TEGRA_GPCDMA_CSR_FC_MODE_NO_MMIO	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 0)
> +#define TEGRA_GPCDMA_CSR_FC_MODE_ONE_MMIO	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 1)
> +#define TEGRA_GPCDMA_CSR_FC_MODE_TWO_MMIO	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 2)
> +#define TEGRA_GPCDMA_CSR_FC_MODE_FOUR_MMIO	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 3)
> +
> +#define TEGRA_GPCDMA_CSR_DMA			GENMASK(23, 21)
> +#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_NO_FC	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 0)
> +#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC		\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 1)
> +#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_NO_FC	\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 2)
> +#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC		\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 3)
> +#define TEGRA_GPCDMA_CSR_DMA_MEM2MEM		\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 4)
> +#define TEGRA_GPCDMA_CSR_DMA_FIXED_PAT		\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 6)
> +
> +#define TEGRA_GPCDMA_CSR_REQ_SEL_MASK		GENMASK(20, 16)
> +#define TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED		\
> +					FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, 4)
> +#define TEGRA_GPCDMA_CSR_IRQ_MASK			BIT(15)
> +#define TEGRA_GPCDMA_CSR_WEIGHT				GENMASK(13, 10)
> +
> +/* STATUS register */
> +#define TEGRA_GPCDMA_CHAN_STATUS			0x004
> +#define TEGRA_GPCDMA_STATUS_BUSY			BIT(31)
> +#define TEGRA_GPCDMA_STATUS_ISE_EOC			BIT(30)
> +#define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
> +#define TEGRA_GPCDMA_STATUS_DMA_ACTIVITY	BIT(27)
> +#define TEGRA_GPCDMA_STATUS_CHANNEL_PAUSE	BIT(26)
> +#define TEGRA_GPCDMA_STATUS_CHANNEL_RX		BIT(25)
> +#define TEGRA_GPCDMA_STATUS_CHANNEL_TX		BIT(24)
> +#define TEGRA_GPCDMA_STATUS_IRQ_INTR_STA	BIT(23)
> +#define TEGRA_GPCDMA_STATUS_IRQ_STA			BIT(21)
> +#define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
> +
> +#define TEGRA_GPCDMA_CHAN_CSRE				0x008
> +#define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
> +
> +/* Source address */
> +#define TEGRA_GPCDMA_CHAN_SRC_PTR			0x00C
> +
> +/* Destination address */
> +#define TEGRA_GPCDMA_CHAN_DST_PTR			0x010
> +
> +/* High address pointer */
> +#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
> +#define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
> +#define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
> +
> +/* MC sequence register */
> +#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
> +#define TEGRA_GPCDMA_MCSEQ_DATA_SWAP	BIT(31)
> +#define TEGRA_GPCDMA_MCSEQ_REQ_COUNT	GENMASK(30, 25)
> +#define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
> +#define TEGRA_GPCDMA_MCSEQ_BURST_2		\
> +					FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 0)
> +#define TEGRA_GPCDMA_MCSEQ_BURST_16		\
> +					FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 3)
> +#define TEGRA_GPCDMA_MCSEQ_WRAP1		GENMASK(22, 20)
> +#define TEGRA_GPCDMA_MCSEQ_WRAP0		GENMASK(19, 17)
> +#define TEGRA_GPCDMA_MCSEQ_WRAP_NONE		0
> +
> +#define TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK	GENMASK(13, 7)
> +#define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK	GENMASK(6, 0)
> +
> +/* MMIO sequence register */
> +#define TEGRA_GPCDMA_CHAN_MMIOSEQ			0x01c
> +#define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH		GENMASK(30, 28)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	\
> +					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 0)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16	\
> +					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 1)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32	\
> +					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 2)
> +#define TEGRA_GPCDMA_MMIOSEQ_DATA_SWAP		BIT(27)
> +#define TEGRA_GPCDMA_MMIOSEQ_BURST			GENMASK(26, 23)
> +#define TEGRA_GPCDMA_MMIOSEQ_BURST_SHIFT	23
> +#define TEGRA_GPCDMA_MMIOSEQ_BURST_MIN		1
> +#define TEGRA_GPCDMA_MMIOSEQ_BURST_MAX		16
> +#define TEGRA_GPCDMA_MMIOSEQ_MASTER_ID		GENMASK(22, 19)
> +#define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD		GENMASK(18, 16)
> +#define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT		GENMASK(8, 7)
> +
> +/* Channel WCOUNT */
> +#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
> +
> +/* Transfer count */
> +#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
> +
> +/* DMA byte count status */
> +#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
> +
> +/* Error Status Register */
> +#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
> +#define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	(8)
> +#define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	(0xF)
> +#define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
> +		((err) >> TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT) &	\
> +		TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK)
> +#define TEGRA_DMA_BM_FIFO_FULL_ERR		(0xF)
> +#define TEGRA_DMA_PERIPH_FIFO_FULL_ERR		(0xE)
> +#define TEGRA_DMA_PERIPH_ID_ERR			(0xD)
> +#define TEGRA_DMA_STREAM_ID_ERR			(0xC)
> +#define TEGRA_DMA_MC_SLAVE_ERR			(0xB)
> +#define TEGRA_DMA_MMIO_SLAVE_ERR		(0xA)

you dont need braces around these..

> +
> +/* Fixed Pattern */
> +#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
> +
> +#define TEGRA_GPCDMA_CHAN_TZ			0x38
> +#define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
> +#define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
> +
> +#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
> +#define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
> +
> +/*
> + * If any burst is in flight and DMA paused then this is the time to complete
> + * on-flight burst and update DMA status register.
> + */
> +#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
> +#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
> +
> +/* Channel base address offset from GPCDMA base address */
> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x10000
> +
> +struct tegra_dma;
> +
> +/*
> + * tegra_dma_chip_data Tegra chip specific DMA data
> + * @nr_channels: Number of channels available in the controller.
> + * @channel_reg_size: Channel register size.
> + * @max_dma_count: Maximum DMA transfer count supported by DMA controller.
> + * @hw_support_pause: DMA HW engine support pause of the channel.
> + */
> +struct tegra_dma_chip_data {
> +	unsigned int nr_channels;
> +	unsigned int channel_reg_size;
> +	unsigned int max_dma_count;
> +	bool hw_support_pause;
> +};
> +
> +/* DMA channel registers */
> +struct tegra_dma_channel_regs {
> +	unsigned long csr;
> +	unsigned long src_ptr;
> +	unsigned long dst_ptr;
> +	unsigned long high_addr_ptr;
> +	unsigned long mc_seq;
> +	unsigned long mmio_seq;
> +	unsigned long wcount;
> +	unsigned long fixed_pattern;
> +};
> +
> +/*
> + * tegra_dma_desc: Tegra DMA descriptors which uses virt_dma_desc to
> + * manage client request and keep track of transfer status, callbacks
> + * and request counts etc.
> + */
> +struct tegra_dma_desc {
> +	struct virt_dma_desc vd;
> +	int bytes_requested;
> +	int bytes_transferred;
> +	struct tegra_dma_channel *tdc;
> +	struct tegra_dma_channel_regs ch_regs;

should this be a descriptor property or channel..? sounds latter to me!


> +};
> +
> +struct tegra_dma_channel;
> +
> +/*
> + * tegra_dma_channel: Channel specific information
> + */
> +struct tegra_dma_channel {
> +	struct virt_dma_chan vc;
> +	struct tegra_dma_desc *dma_desc;
> +	char name[30];
> +	bool config_init;
> +	int id;
> +	int irq;
> +	unsigned int stream_id;
> +	unsigned long chan_base_offset;
> +	raw_spinlock_t lock;
> +	bool busy;
> +	struct tegra_dma *tdma;
> +	int slave_id;
> +	enum dma_transfer_direction sid_dir;
> +	struct dma_slave_config dma_sconfig;
> +};
> +
> +/*
> + * tegra_dma: Tegra DMA specific information
> + */
> +struct tegra_dma {
> +	struct dma_device dma_dev;
> +	struct device *dev;
> +	void __iomem *base_addr;
> +	const struct tegra_dma_chip_data *chip_data;
> +	struct reset_control *rst;
> +	unsigned long sid_m2d_reserved;
> +	unsigned long sid_d2m_reserved;
> +	unsigned long sid_m2m_reserved;
> +	struct tegra_dma_channel channels[0];
> +};
> +
> +static inline void tdc_write(struct tegra_dma_channel *tdc,
> +			     u32 reg, u32 val)
> +{
> +	writel_relaxed(val, tdc->tdma->base_addr + tdc->chan_base_offset + reg);
> +}
> +
> +static inline u32 tdc_read(struct tegra_dma_channel *tdc, u32 reg)
> +{
> +	return readl_relaxed(tdc->tdma->base_addr + tdc->chan_base_offset + reg);
> +}
> +
> +static inline struct tegra_dma_channel *to_tegra_dma_chan(struct dma_chan *dc)
> +{
> +	return container_of(dc, struct tegra_dma_channel, vc.chan);
> +}
> +
> +static inline struct tegra_dma_desc *vd_to_tegra_dma_desc(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct tegra_dma_desc, vd);
> +}
> +
> +static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
> +{
> +	return tdc->vc.chan.device->dev;
> +}
> +
> +static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
> +{
> +	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
> +		tdc->id, tdc->name);
> +	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x SRC %x DST %x\n",
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
> +	);
> +	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
> +	);
> +	dev_dbg(tdc2dev(tdc), "DMA ERR_STA %x\n",
> +		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
> +}
> +
> +static int tegra_dma_sid_reserve(struct tegra_dma_channel *tdc,
> +				 enum dma_transfer_direction direction)
> +{
> +	struct tegra_dma *tdma = tdc->tdma;
> +	unsigned int sid = tdc->slave_id;
> +
> +	if (!is_slave_direction(direction))
> +		return 0;
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		if (test_and_set_bit(sid, &tdma->sid_m2d_reserved)) {
> +			dev_err(tdma->dev, "slave id already in use\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		if (test_and_set_bit(sid, &tdma->sid_d2m_reserved)) {
> +			dev_err(tdma->dev, "slave id already in use\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	}
> +
> +	tdc->sid_dir = direction;
> +
> +	return 0;
> +}
> +
> +static void tegra_dma_sid_free(struct tegra_dma_channel *tdc)
> +{
> +	struct tegra_dma *tdma = tdc->tdma;
> +	unsigned int sid = tdc->slave_id;
> +
> +	switch (tdc->sid_dir) {
> +	case DMA_MEM_TO_DEV:
> +		clear_bit(sid,  &tdma->sid_m2d_reserved);
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		clear_bit(sid,  &tdma->sid_d2m_reserved);
> +		break;
> +	}
> +
> +	tdc->sid_dir = DMA_TRANS_NONE;
> +}
> +
> +static void tegra_dma_desc_free(struct virt_dma_desc *vd)
> +{
> +	kfree(container_of(vd, struct tegra_dma_desc, vd));
> +}
> +
> +static int tegra_dma_slave_config(struct dma_chan *dc,
> +				  struct dma_slave_config *sconfig)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	if (tdc->dma_desc) {
> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
> +		return -EBUSY;
> +	}

Well the assumption of this API is that config can be set anytime, it
will take effect on next descriptor submitted. So why should it not be
allowed here?
-- 
~Vinod
