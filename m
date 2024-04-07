Return-Path: <dmaengine+bounces-1760-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7689B0B9
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546B0B2129C
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77822075;
	Sun,  7 Apr 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="digTxJZX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346C1E862;
	Sun,  7 Apr 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492469; cv=none; b=VaJ2pswVX00wqxwkBGAbmhO9iXpTpr/hM5Wz1OL3VwPHIKCRHFmWFh7l4Aof6KjuVrOjZ9UmlLwaMtLDfOBSH8vTCTMwZ2yFgi1lQut6md+/Lcnz5uqySDsgGP3Hdmd+vP97dshmzFw/mds9AsHGqBHX2RR9ikyGStFtLXRB4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492469; c=relaxed/simple;
	bh=7DOFi2fnurQNLN4V2jJEOCiROTiLjYbQ2ek4Rfdwj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMWkJ3WBzS1yr6OQHCxuObzbP0QeD/6Tfy+bl/MNz1M4XhvUUvUiOGp8Bl0U11Nw3wYb1AOM0GnG0HIZ4i2KUJ21AbpEv2EKf9eZ1end6S7JHcBL/Vwg2qn0qaRqg5zsB0lXSkiqdtiuxEjxgRVCIOQor0eKFKcXV3b49ZW4Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=digTxJZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3833CC433C7;
	Sun,  7 Apr 2024 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712492469;
	bh=7DOFi2fnurQNLN4V2jJEOCiROTiLjYbQ2ek4Rfdwj60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=digTxJZX6THbHJrUm/U3uNT9f5OvnSOKpeLRmCmwnshIcdwzie+iOTwnugXRpDxgw
	 +FzxWj5YFoXw0VgoqvISOnZ87KotIDXp9ymxNxQCKFrLrfUO+uNxjxr3GfjU5tJTaw
	 9I2SlN8wO99YFOBj07yvxoAdVMn0Hl2s1jQN9svZ6Ks1iZUxdYyFiaDQOycqpfno+y
	 uLiDBe4gtsZ9daVDRI32r5B0nC+sVkjXABoxAsJVdmQWiw5P3IQObLeWEic94FW55Q
	 2tBpbFoayxt/JU3CvuTu/zyGCcjehJrUMd4UblD1YSWqrGtU1qszJRzCZRKfbr6i8+
	 cEBXKTsnWzoZw==
Date: Sun, 7 Apr 2024 17:51:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kelvin Cao <kelvin.cao@microchip.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	logang@deltatee.com, George.Ge@microchip.com,
	christophe.jaillet@wanadoo.fr, hch@infradead.org
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZhKPsKFyaXFliJP4@matsya>
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163313.236948-2-kelvin.cao@microchip.com>

On 18-03-24, 09:33, Kelvin Cao wrote:
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
> 
> Implement core PCI driver skeleton and DMA engine callbacks.

can you please split the two, pci parts and dma parts for review

> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> ---
>  MAINTAINERS                 |    6 +
>  drivers/dma/Kconfig         |    9 +
>  drivers/dma/Makefile        |    1 +
>  drivers/dma/switchtec_dma.c | 1546 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1562 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aabf1c15bb3..03b254487a3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21156,6 +21156,12 @@ S:	Supported
>  F:	include/net/switchdev.h
>  F:	net/switchdev/
>  
> +SWITCHTEC DMA DRIVER
> +M:	Kelvin Cao <kelvin.cao@microchip.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/switchtec_dma.c
> +
>  SY8106A REGULATOR DRIVER
>  M:	Icenowy Zheng <icenowy@aosc.io>
>  S:	Maintained
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e928f2ca0f1e..578a1d7fabba 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -608,6 +608,15 @@ config SPRD_DMA
>  	help
>  	  Enable support for the on-chip DMA controller on Spreadtrum platform.
>  
> +config SWITCHTEC_DMA
> +	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
> +	depends on PCI
> +	select DMA_ENGINE
> +	help
> +	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
> +	  These are exposed via an extra function on the switch's upstream
> +	  port.
> +
>  config TXX9_DMAC
>  	tristate "Toshiba TXx9 SoC DMA support"
>  	depends on MACH_TX49XX
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e408..bdfb25d49dba 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_STM32_DMA) += stm32-dma.o
>  obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
>  obj-$(CONFIG_STM32_MDMA) += stm32-mdma.o
>  obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
> +obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> new file mode 100644
> index 000000000000..3eced3320f9a
> --- /dev/null
> +++ b/drivers/dma/switchtec_dma.c
> @@ -0,0 +1,1546 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip Switchtec(tm) DMA Controller Driver
> + * Copyright (c) 2023, Kelvin Cao <kelvin.cao@microchip.com>
> + * Copyright (c) 2023, Microchip Corporation

2024

> + */
> +
> +#include <linux/circ_buf.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "dmaengine.h"
> +
> +MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
> +MODULE_VERSION("0.1");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kelvin Cao");
> +
> +#define	SWITCHTEC_DMAC_CHAN_CTRL_OFFSET		0x1000
> +#define	SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET	0x160000
> +
> +#define SWITCHTEC_DMA_CHAN_HW_REGS_SIZE		0x1000
> +#define SWITCHTEC_DMA_CHAN_FW_REGS_SIZE		0x80
> +
> +#define SWITCHTEC_REG_CAP		0x80
> +#define SWITCHTEC_REG_CHAN_CNT		0x84
> +#define SWITCHTEC_REG_TAG_LIMIT		0x90
> +#define SWITCHTEC_REG_CHAN_STS_VEC	0x94
> +#define SWITCHTEC_REG_SE_BUF_CNT	0x98
> +#define SWITCHTEC_REG_SE_BUF_BASE	0x9a
> +
> +#define SWITCHTEC_DESC_MAX_SIZE		0x100000
> +
> +#define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
> +#define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
> +#define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> +#define SWITCHTEC_CHAN_CTRL_ERR_PAUSE	BIT(3)
> +
> +#define SWITCHTEC_CHAN_STS_PAUSED	BIT(9)
> +#define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
> +#define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
> +
> +static const char * const channel_status_str[] = {
> +	[13] = "received a VDM with length error status",
> +	[14] = "received a VDM or Cpl with Unsupported Request error status",
> +	[15] = "received a VDM or Cpl with Completion Abort error status",
> +	[16] = "received a VDM with ECRC error status",
> +	[17] = "received a VDM with EP error status",
> +	[18] = "received a VDM with Reserved Cpl error status",
> +	[19] = "received only part of split SE CplD",
> +	[20] = "the ISP_DMAC detected a Completion Time Out",
> +	[21] = "received a Cpl with Unsupported Request status",
> +	[22] = "received a Cpl with Completion Abort status",
> +	[23] = "received a Cpl with a reserved status",
> +	[24] = "received a TLP with ECRC error status in its metadata",
> +	[25] = "received a TLP with the EP bit set in the header",
> +	[26] = "the ISP_DMAC tried to process a SE with an invalid Connection ID",
> +	[27] = "the ISP_DMAC tried to process a SE with an invalid Remote Host interrupt",
> +	[28] = "a reserved opcode was detected in an SE",
> +	[29] = "received a SE Cpl with error status",
> +};
> +
> +struct chan_hw_regs {
> +	u16 cq_head;
> +	u16 rsvd1;
> +	u16 sq_tail;
> +	u16 rsvd2;
> +	u8 ctrl;
> +	u8 rsvd3[3];
> +	u16 status;
> +	u16 rsvd4;
> +};
> +
> +enum {
> +	PERF_BURST_SCALE = 0x1,
> +	PERF_BURST_SIZE = 0x6,
> +	PERF_INTERVAL = 0x0,
> +	PERF_MRRS = 0x3,
> +	PERF_ARB_WEIGHT = 0x1,
> +};

Does this represt HW values, or a SW enum? can this be sorted?
Why PERF_ARB_WEIGHT and PERF_BURST_SCALE have same values?

> +
> +enum {
> +	PERF_BURST_SCALE_SHIFT = 0x2,
> +	PERF_BURST_SCALE_MASK = 0x3,
> +	PERF_MRRS_SHIFT = 0x4,
> +	PERF_MRRS_MASK = 0x7,
> +	PERF_INTERVAL_SHIFT = 0x8,
> +	PERF_INTERVAL_MASK = 0x7,
> +	PERF_BURST_SIZE_SHIFT = 0xc,
> +	PERF_BURST_SIZE_MASK = 0x7,
> +	PERF_ARB_WEIGHT_SHIFT = 0x18,
> +	PERF_ARB_WEIGHT_MASK = 0xff,

This look like register bitfields? Consider using GENMASK for defining
and drop the shifts, use FIELD_PREP, FIELD_GET instead

> +};
> +
> +enum {
> +	PERF_MIN_INTERVAL = 0,
> +	PERF_MAX_INTERVAL = 0x7,
> +	PERF_MIN_BURST_SIZE = 0,
> +	PERF_MAX_BURST_SIZE = 0x7,
> +	PERF_MIN_BURST_SCALE = 0,
> +	PERF_MAX_BURST_SCALE = 0x2,
> +	PERF_MIN_MRRS = 0,
> +	PERF_MAX_MRRS = 0x7,
> +};
> +
> +enum {
> +	SE_BUF_BASE_SHIFT = 0x2,
> +	SE_BUF_BASE_MASK = 0x1ff,
> +	SE_BUF_LEN_SHIFT = 0xc,
> +	SE_BUF_LEN_MASK = 0x1ff,
> +	SE_THRESH_SHIFT = 0x17,
> +	SE_THRESH_MASK = 0x1ff,
> +};
> +
> +#define SWITCHTEC_CHAN_ENABLE	BIT(1)
> +
> +struct chan_fw_regs {
> +	u32 valid_en_se;
> +	u32 cq_base_lo;
> +	u32 cq_base_hi;
> +	u16 cq_size;
> +	u16 rsvd1;
> +	u32 sq_base_lo;
> +	u32 sq_base_hi;
> +	u16 sq_size;
> +	u16 rsvd2;
> +	u32 int_vec;
> +	u32 perf_cfg;
> +	u32 rsvd3;
> +	u32 perf_latency_selector;
> +	u32 perf_fetched_se_cnt_lo;
> +	u32 perf_fetched_se_cnt_hi;
> +	u32 perf_byte_cnt_lo;
> +	u32 perf_byte_cnt_hi;
> +	u32 rsvd4;
> +	u16 perf_se_pending;
> +	u16 perf_se_buf_empty;
> +	u32 perf_chan_idle;
> +	u32 perf_lat_max;
> +	u32 perf_lat_min;
> +	u32 perf_lat_last;
> +	u16 sq_current;
> +	u16 sq_phase;
> +	u16 cq_current;
> +	u16 cq_phase;
> +};
> +
> +enum cmd {
> +	CMD_GET_HOST_LIST = 1,
> +	CMD_REGISTER_BUF = 2,
> +	CMD_UNREGISTER_BUF = 3,
> +	CMD_GET_BUF_LIST = 4,
> +	CMD_GET_OWN_BUF_LIST = 5,
> +};
> +
> +enum cmd_status {
> +	CMD_STATUS_IDLE = 0,
> +	CMD_STATUS_INPROGRESS = 0x1,
> +	CMD_STATUS_DONE = 0x2,
> +	CMD_STATUS_ERROR = 0xFF,

lower case hex please

> +};
> +
> +struct switchtec_dma_chan {
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_chan dma_chan;
> +	struct chan_hw_regs __iomem *mmio_chan_hw;
> +	struct chan_fw_regs __iomem *mmio_chan_fw;
> +
> +	/* Serialize hardware control register access */
> +	spinlock_t hw_ctrl_lock;
> +
> +	struct tasklet_struct desc_task;
> +
> +	/* Serialize descriptor preparation */
> +	spinlock_t submit_lock;
> +	bool ring_active;
> +	int cid;
> +
> +	/* Serialize completion processing */
> +	spinlock_t complete_lock;
> +	bool comp_ring_active;
> +
> +	/* channel index and irq */
> +	int index;
> +	int irq;
> +
> +	/*
> +	 * In driver context, head is advanced by producer while
> +	 * tail is advanced by consumer.
> +	 */
> +
> +	/* the head and tail for both desc_ring and hw_sq */
> +	int head;
> +	int tail;
> +	int phase_tag;
> +	struct switchtec_dma_desc **desc_ring;
> +	struct switchtec_dma_hw_se_desc *hw_sq;
> +	dma_addr_t dma_addr_sq;
> +
> +	/* the tail for hw_cq */
> +	int cq_tail;
> +	struct switchtec_dma_hw_ce *hw_cq;
> +	dma_addr_t dma_addr_cq;
> +
> +	struct list_head list;
> +};
> +
> +struct switchtec_dma_dev {
> +	struct dma_device dma_dev;
> +	struct pci_dev __rcu *pdev;
> +	struct switchtec_dma_chan **swdma_chans;
> +	int chan_cnt;
> +	int chan_status_irq;
> +	void __iomem *bar;
> +	struct tasklet_struct chan_status_task;
> +};
> +
> +static struct switchtec_dma_chan *to_switchtec_dma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct switchtec_dma_chan, dma_chan);
> +}
> +
> +static struct device *to_chan_dev(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return &swdma_chan->dma_chan.dev->device;
> +}
> +
> +enum switchtec_dma_opcode {
> +	SWITCHTEC_DMA_OPC_MEMCPY = 0,
> +	SWITCHTEC_DMA_OPC_RDIMM = 0x1,
> +	SWITCHTEC_DMA_OPC_WRIMM = 0x2,
> +	SWITCHTEC_DMA_OPC_RHI = 0x6,
> +	SWITCHTEC_DMA_OPC_NOP = 0x7,
> +};
> +
> +struct switchtec_dma_hw_se_desc {
> +	u8 opc;
> +	u8 ctrl;
> +	__le16 tlp_setting;
> +	__le16 rsvd1;
> +	__le16 cid;
> +	__le32 byte_cnt;
> +	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
> +	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */
> +	__le32 daddr_lo;
> +	__le32 daddr_hi;
> +	__le16 dfid;
> +	__le16 sfid;
> +};
> +
> +#define SWITCHTEC_SE_DFM		BIT(5)
> +#define SWITCHTEC_SE_LIOF		BIT(6)
> +#define SWITCHTEC_SE_BRR		BIT(7)
> +#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
> +
> +#define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
> +#define SWITCHTEC_CE_SC_UR		BIT(1)
> +#define SWITCHTEC_CE_SC_CA		BIT(2)
> +#define SWITCHTEC_CE_SC_RSVD_CPL	BIT(3)
> +#define SWITCHTEC_CE_SC_ECRC_ERR	BIT(4)
> +#define SWITCHTEC_CE_SC_EP_SET		BIT(5)
> +#define SWITCHTEC_CE_SC_D_RD_CTO	BIT(8)
> +#define SWITCHTEC_CE_SC_D_RIMM_UR	BIT(9)
> +#define SWITCHTEC_CE_SC_D_RIMM_CA	BIT(10)
> +#define SWITCHTEC_CE_SC_D_RIMM_RSVD_CPL	BIT(11)
> +#define SWITCHTEC_CE_SC_D_ECRC		BIT(12)
> +#define SWITCHTEC_CE_SC_D_EP_SET	BIT(13)
> +#define SWITCHTEC_CE_SC_D_BAD_CONNID	BIT(14)
> +#define SWITCHTEC_CE_SC_D_BAD_RHI_ADDR	BIT(15)
> +#define SWITCHTEC_CE_SC_D_INVD_CMD	BIT(16)
> +#define SWITCHTEC_CE_SC_MASK		GENMASK(16, 0)
> +
> +struct switchtec_dma_hw_ce {
> +	__le32 rdimm_cpl_dw0;
> +	__le32 rdimm_cpl_dw1;
> +	__le32 rsvd1;
> +	__le32 cpl_byte_cnt;
> +	__le16 sq_head;
> +	__le16 rsvd2;
> +	__le32 rsvd3;
> +	__le32 sts_code;
> +	__le16 cid;
> +	__le16 phase_tag;
> +};
> +
> +struct switchtec_dma_desc {
> +	struct dma_async_tx_descriptor txd;
> +	struct switchtec_dma_hw_se_desc *hw;
> +	u32 orig_size;
> +	bool completed;
> +};
> +
> +#define SWITCHTEC_INVALID_HFID 0xffff
> +
> +#define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
> +#define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
> +
> +#define SWITCHTEC_DMA_RING_SIZE	SWITCHTEC_DMA_SQ_SIZE
> +
> +static int
> +wait_for_chan_status(struct chan_hw_regs __iomem *chan_hw, u32 mask, bool set)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = readl_poll_timeout_atomic(&chan_hw->status, status,
> +					(set && (status & mask)) ||
> +					(!set && !(status & mask)),
> +					10, 100 * USEC_PER_MSEC);
> +	if (ret)
> +		return -EIO;

it can be timeout too, doesnt it make sense to propagate that?

> +
> +	return 0;
> +}
> +
> +static int halt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int unhalt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	u8 ctrl;
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	ctrl = readb(&chan_hw->ctrl);
> +	ctrl &= ~SWITCHTEC_CHAN_CTRL_HALT;
> +	writeb(ctrl, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void flush_pci_write(struct chan_hw_regs __iomem *chan_hw)
> +{
> +	readl(&chan_hw->cq_head);
> +}
> +
> +static int reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writel(SWITCHTEC_CHAN_CTRL_RESET | SWITCHTEC_CHAN_CTRL_ERR_PAUSE,
> +	       &chan_hw->ctrl);
> +	flush_pci_write(chan_hw);
> +
> +	udelay(1000);
> +
> +	writel(SWITCHTEC_CHAN_CTRL_ERR_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int pause_reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +
> +	/* wait 60ms to ensure no pending CEs */
> +	mdelay(60);
> +
> +	return reset_channel(swdma_chan);
> +}
> +
> +static int switchtec_dma_pause(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int switchtec_dma_resume(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(0, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +enum chan_op {
> +	ENABLE_CHAN,
> +	DISABLE_CHAN,
> +};
> +
> +static int channel_op(struct switchtec_dma_chan *swdma_chan, int op)
> +{
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct pci_dev *pdev;
> +	u32 valid_en_se;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	valid_en_se = readl(&chan_fw->valid_en_se);
> +	if (op == ENABLE_CHAN)
> +		valid_en_se |= SWITCHTEC_CHAN_ENABLE;
> +	else
> +		valid_en_se &= ~SWITCHTEC_CHAN_ENABLE;
> +
> +	writel(valid_en_se, &chan_fw->valid_en_se);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int enable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, ENABLE_CHAN);
> +}
> +
> +static int disable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, DISABLE_CHAN);
> +}
> +
> +static struct switchtec_dma_desc *
> +switchtec_dma_get_desc(struct switchtec_dma_chan *swdma_chan, int i)
> +{
> +	return swdma_chan->desc_ring[i];
> +}
> +
> +static struct switchtec_dma_hw_ce *
> +switchtec_dma_get_ce(struct switchtec_dma_chan *swdma_chan, int i)
> +{
> +	return &swdma_chan->hw_cq[i];
> +}
> +
> +static void switchtec_dma_process_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct device *chan_dev = to_chan_dev(swdma_chan);
> +	struct dmaengine_result res;
> +	struct switchtec_dma_desc *desc;
> +	struct switchtec_dma_hw_ce *ce;
> +	__le16 phase_tag;
> +	int tail;
> +	int cid;
> +	int se_idx;
> +	u32 sts_code;
> +	int i;
> +	__le32 *p;
> +
> +	do {
> +		spin_lock_bh(&swdma_chan->complete_lock);
> +		if (!swdma_chan->comp_ring_active) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		ce = switchtec_dma_get_ce(swdma_chan, swdma_chan->cq_tail);
> +
> +		/*
> +		 * phase_tag is updated by hardware, ensure the value is
> +		 * not from the cache
> +		 */
> +		phase_tag = smp_load_acquire(&ce->phase_tag);
> +		if (le16_to_cpu(phase_tag) == swdma_chan->phase_tag) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		cid = le16_to_cpu(ce->cid);
> +		se_idx = cid & (SWITCHTEC_DMA_SQ_SIZE - 1);
> +		desc = switchtec_dma_get_desc(swdma_chan, se_idx);
> +
> +		tail = swdma_chan->tail;
> +
> +		res.residue = desc->orig_size - le32_to_cpu(ce->cpl_byte_cnt);
> +
> +		sts_code = le32_to_cpu(ce->sts_code);
> +
> +		if (!(sts_code & SWITCHTEC_CE_SC_MASK)) {
> +			res.result = DMA_TRANS_NOERROR;
> +		} else {
> +			if (sts_code & SWITCHTEC_CE_SC_D_RD_CTO)
> +				res.result = DMA_TRANS_READ_FAILED;
> +			else
> +				res.result = DMA_TRANS_WRITE_FAILED;
> +
> +			dev_err(chan_dev, "CID 0x%04x failed, SC 0x%08x\n", cid,
> +				(u32)(sts_code & SWITCHTEC_CE_SC_MASK));
> +
> +			p = (__le32 *)ce;
> +			for (i = 0; i < sizeof(*ce) / 4; i++) {
> +				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
> +					le32_to_cpu(*p));
> +				p++;
> +			}
> +		}
> +
> +		desc->completed = true;
> +
> +		swdma_chan->cq_tail++;
> +		swdma_chan->cq_tail &= SWITCHTEC_DMA_CQ_SIZE - 1;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			return;
> +		}
> +		writew(swdma_chan->cq_tail, &swdma_chan->mmio_chan_hw->cq_head);
> +		rcu_read_unlock();
> +
> +		if (swdma_chan->cq_tail == 0)
> +			swdma_chan->phase_tag = !swdma_chan->phase_tag;
> +
> +		/*  Out of order CE */
> +		if (se_idx != tail) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			continue;
> +		}
> +
> +		do {
> +			dma_cookie_complete(&desc->txd);
> +			dma_descriptor_unmap(&desc->txd);
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +			desc->txd.callback = NULL;
> +			desc->txd.callback_result = NULL;
> +			desc->completed = false;
> +
> +			tail++;
> +			tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +
> +			/*
> +			 * Ensure the desc updates are visible before updating
> +			 * the tail index
> +			 */
> +			smp_store_release(&swdma_chan->tail, tail);
> +			desc = switchtec_dma_get_desc(swdma_chan,
> +						      swdma_chan->tail);
> +			if (!desc->completed)
> +				break;
> +		} while (CIRC_CNT(READ_ONCE(swdma_chan->head), swdma_chan->tail,
> +				  SWITCHTEC_DMA_SQ_SIZE));
> +
> +		spin_unlock_bh(&swdma_chan->complete_lock);
> +	} while (1);
> +}
> +
> +static void
> +switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
> +{
> +	struct dmaengine_result res;
> +	struct switchtec_dma_desc *desc;
> +
> +	if (!force)
> +		switchtec_dma_process_desc(swdma_chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +
> +	while (CIRC_CNT(swdma_chan->head, swdma_chan->tail,
> +			SWITCHTEC_DMA_SQ_SIZE) >= 1) {
> +		desc = switchtec_dma_get_desc(swdma_chan, swdma_chan->tail);
> +
> +		res.residue = desc->orig_size;
> +		res.result = DMA_TRANS_ABORTED;
> +
> +		dma_cookie_complete(&desc->txd);
> +		dma_descriptor_unmap(&desc->txd);
> +		if (!force)
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +		desc->txd.callback = NULL;
> +		desc->txd.callback_result = NULL;
> +
> +		swdma_chan->tail++;
> +		swdma_chan->tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +	}
> +
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
> +{
> +	int rc;
> +
> +	rc = halt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	return pause_reset_channel(swdma_chan);
> +}
> +
> +static void switchtec_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	int rc;
> +
> +	switchtec_dma_abort_desc(swdma_chan, 1);
> +
> +	rc = enable_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = reset_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = unhalt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->head = 0;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = true;
> +	swdma_chan->phase_tag = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +	swdma_chan->cid = 0;
> +	dma_cookie_init(chan);
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_desc_task(unsigned long data)
> +{
> +	struct switchtec_dma_chan *swdma_chan = (void *)data;
> +
> +	switchtec_dma_process_desc(swdma_chan);
> +}
> +
> +static void switchtec_dma_chan_status_task(unsigned long data)
> +{
> +	struct switchtec_dma_dev *swdma_dev = (void *)data;
> +	struct dma_device *dma_dev = &swdma_dev->dma_dev;
> +	struct switchtec_dma_chan *swdma_chan;
> +	struct chan_hw_regs __iomem *chan_hw;
> +	struct dma_chan *chan;
> +	struct device *chan_dev;
> +	u32 chan_status;
> +	int bit;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		swdma_chan = to_switchtec_dma_chan(chan);
> +		chan_dev = to_chan_dev(swdma_chan);
> +		chan_hw = swdma_chan->mmio_chan_hw;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +
> +		chan_status = readl(&chan_hw->status);
> +		chan_status &= SWITCHTEC_CHAN_STS_PAUSED_MASK;
> +		rcu_read_unlock();
> +
> +		bit = ffs(chan_status);
> +		if (!bit)
> +			dev_dbg(chan_dev, "No pause bit set.");
> +		else
> +			dev_err(chan_dev, "Paused, %s\n",
> +				channel_status_str[bit - 1]);
> +	}
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> +			size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(c);
> +	struct switchtec_dma_desc *desc;
> +	int head;
> +	int tail;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +
> +	if (!swdma_chan->ring_active)
> +		goto err_unlock;
> +
> +	tail = READ_ONCE(swdma_chan->tail);
> +	head = swdma_chan->head;
> +
> +	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
> +		goto err_unlock;
> +
> +	desc = switchtec_dma_get_desc(swdma_chan, head);
> +
> +	if (src_fid != SWITCHTEC_INVALID_HFID &&
> +	    dst_fid != SWITCHTEC_INVALID_HFID)
> +		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
> +
> +	if (flags & DMA_PREP_FENCE)
> +		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
> +
> +	desc->txd.flags = flags;
> +
> +	desc->completed = false;
> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> +	desc->hw->byte_cnt = cpu_to_le32(len);
> +	desc->hw->tlp_setting = 0;
> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> +	desc->hw->sfid = cpu_to_le16(src_fid);
> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> +	desc->orig_size = len;
> +
> +	head++;
> +	head &= SWITCHTEC_DMA_RING_SIZE - 1;
> +
> +	/*
> +	 * Ensure the desc updates are visible before updating the head index
> +	 */
> +	smp_store_release(&swdma_chan->head, head);
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &desc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(swdma_chan->submit_lock);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
> +				       flags);
> +}
> +
> +static dma_cookie_t
> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		to_switchtec_dma_chan(desc->chan);
> +	dma_cookie_t cookie;
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);

I was expecting desc to be pushing to pending list?? where is that done

Also consider using virt-dma for desc management, you dont need to
handle that on your own

> +
> +	return cookie;
> +}
> +
> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> +					       dma_cookie_t cookie,
> +					       struct dma_tx_state *txstate)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	switchtec_dma_process_desc(swdma_chan);

This is *wrong*, you cannot process desc in status API, Please read the
documentation again and if in doubt pls ask

-- 
~Vinod

