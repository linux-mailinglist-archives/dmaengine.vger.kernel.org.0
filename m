Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B109C262DDD
	for <lists+dmaengine@lfdr.de>; Wed,  9 Sep 2020 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIILbF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Sep 2020 07:31:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:38879 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgIILay (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:54 -0400
IronPort-SDR: rKcx0y7cYVy9M2+Ka/FshFo1uIqUtP9aiD3brluUZKjBKRu60mCdzTn64MrPaMRbjwbhv3LEeM
 wPvIt4832xIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="243123889"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="243123889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 04:14:30 -0700
IronPort-SDR: 9hcr/6B970iyS99yEjRXwg+YFLEXOZaH8D3Iz4hZnwlLNmBZSekeUnNQYLgVpsfx+loEpEGYYt
 X0wl91zIAZ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333786622"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 04:14:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kFy3U-00FQL4-AW; Wed, 09 Sep 2020 14:14:24 +0300
Date:   Wed, 9 Sep 2020 14:14:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v6 2/2] Add Intel LGM soc DMA support.
Message-ID: <20200909111424.GQ1891694@smile.fi.intel.com>
References: <cover.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <748370a51af0ab768e542f1537d1aa3aeefebe8a.1599605765.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748370a51af0ab768e542f1537d1aa3aeefebe8a.1599605765.git.mallikarjunax.reddy@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 09, 2020 at 07:07:34AM +0800, Amireddy Mallikarjuna reddy wrote:
> Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
> 
> The main function of the DMA controller is the transfer of data from/to any
> DPlus compliant peripheral to/from the memory. A memory to memory copy
> capability can also be configured.
> 
> This ldma driver is used for configure the device and channnels for data
> and control paths.

...

> +config INTEL_LDMA
> +	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Enable support for intel Lightning Mountain SOC DMA controllers.
> +	  These controllers provide DMA capabilities for a variety of on-chip
> +	  devices such as SSC, HSNAND and GSWIP.

And how module will be called?

...

> +struct ldma_dev;
> +struct ldma_port;

+ blank line

> +struct ldma_chan {
> +	struct ldma_port	*port; /* back pointer */
> +	char			name[8]; /* Channel name */

> +	struct virt_dma_chan	vchan;

You can make container_of() no-op if you put this to be first member of the
structure.

> +	int			nr; /* Channel id in hardware */
> +	u32			flags; /* central way or channel based way */
> +	enum ldma_chan_on_off	onoff;
> +	dma_addr_t		desc_phys;
> +	void			*desc_base; /* Virtual address */
> +	u32			desc_cnt; /* Number of descriptors */
> +	int			rst;
> +	u32			hdrm_len;
> +	bool			hdrm_csum;
> +	u32			boff_len;
> +	u32			data_endian;
> +	u32			desc_endian;
> +	bool			pden;
> +	bool			desc_rx_np;
> +	bool			data_endian_en;
> +	bool			desc_endian_en;
> +	bool			abc_en;
> +	bool			desc_init;
> +	struct dma_pool		*desc_pool; /* Descriptors pool */
> +	u32			desc_num;
> +	struct dw2_desc_sw	*ds;
> +	struct work_struct	work;
> +	struct dma_slave_config config;
> +};

...

> +		struct {
> +			u32 len		:16;
> +			u32 res0	:7;
> +			u32 bofs	:2;
> +			u32 res1	:3;
> +			u32 eop		:1;
> +			u32 sop		:1;
> +			u32 c		:1;
> +			u32 own		:1;
> +		} __packed field;
> +		u32 word;

Can you rather use bitfield.h?

> +	} __packed status;
> +	u32 addr;
> +} __packed __aligned(8);

...

> +struct dw2_desc_sw {
> +	struct ldma_chan	*chan;

> +	struct virt_dma_desc	vdesc;

Make it first and container_of() becomes no-op.

> +	dma_addr_t		desc_phys;
> +	size_t			desc_cnt;
> +	size_t			size;
> +	struct dw2_desc		*desc_hw;
> +};

...

> +ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
> +{
> +	u32 old_val, new_val;
> +
> +	old_val = readl(d->base +  ofs);

> +	new_val = (old_val & ~mask) | (val & mask);

With bitfield.h you will have this as u32_replace_bits().

> +
> +	if (new_val != old_val)
> +		writel(new_val, d->base + ofs);
> +}

...

> +	/* Keep the class value unchanged */
> +	reg &= DMA_CCTRL_CLASS | DMA_CCTRL_CLASSH;
> +	reg |= val;

No mask? Consider u32_replace_bits() or other FIELD_*() macros.

...

> +static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
> +				  int desc_num)
> +{
> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&d->dev_lock, flags);
> +	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
> +	writel(lower_32_bits(desc_base), d->base + DMA_CDBA);

> +	/* High 4 bits */

Why only 4?

> +	if (IS_ENABLED(CONFIG_64BIT)) {

> +		u32 hi = upper_32_bits(desc_base) & 0xF;

GENMASK() ?

> +
> +		ldma_update_bits(d, DMA_CDBA_MSB,
> +				 FIELD_PREP(DMA_CDBA_MSB, hi), DMA_CCTRL);
> +	}
> +	writel(desc_num, d->base + DMA_CDLEN);
> +	spin_unlock_irqrestore(&d->dev_lock, flags);
> +
> +	c->desc_init = true;
> +}

...


> +	dev_dbg(d->dev, "Port Control 0x%08x configuration done\n",
> +		readl(d->base + DMA_PCTRL));

This has a side effect. Better to use temporary variable if you need to read
back.

...

> +static int ldma_chan_cfg(struct ldma_chan *c)
> +{
> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
> +	unsigned long flags;
> +	u32 reg;
> +
> +	reg = c->pden ? DMA_CCTRL_PDEN : 0;
> +	reg |= c->onoff ? DMA_CCTRL_ON : 0;
> +	reg |= c->rst ? DMA_CCTRL_RST : 0;
> +
> +	ldma_chan_cctrl_cfg(c, reg);
> +	ldma_chan_irq_init(c);

> +	if (d->ver > DMA_VER22) {

	if (d->ver <= DMA_VER22)
		return 0;

	?

> +		spin_lock_irqsave(&d->dev_lock, flags);
> +		ldma_chan_set_class(c, c->nr);
> +		ldma_chan_byte_offset_cfg(c, c->boff_len);
> +		ldma_chan_data_endian_cfg(c, c->data_endian_en, c->data_endian);
> +		ldma_chan_desc_endian_cfg(c, c->desc_endian_en, c->desc_endian);
> +		ldma_chan_hdr_mode_cfg(c, c->hdrm_len, c->hdrm_csum);
> +		ldma_chan_rxwr_np_cfg(c, c->desc_rx_np);
> +		ldma_chan_abc_cfg(c, c->abc_en);
> +		spin_unlock_irqrestore(&d->dev_lock, flags);
> +
> +		if (ldma_chan_is_hw_desc(c))
> +			ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
> +	}
> +
> +	return 0;
> +}

...

> +	/* DMA channel initialization */
> +	for (i = 0; i < d->chan_nrs; i++) {
> +		if (d->ver == DMA_VER22 && !(d->channels_mask & BIT(i)))
> +			continue;

for_each_set_bit() ?

> +		c = &d->chans[i];
> +		ldma_chan_cfg(c);
> +	}

...

> +		for (i = 0; i < d->port_nrs; i++) {
> +			p = &d->ports[i];
> +			p->rxendi = DMA_DFT_ENDIAN;
> +			p->txendi = DMA_DFT_ENDIAN;

> +			if (!fwnode_property_read_u32(fwnode, "intel,dma-burst",
> +						      &prop)) {

How this is not invariant inside the loop?

> +				p->rxbl = prop;
> +				p->txbl = prop;
> +			} else {
> +				p->rxbl = DMA_DFT_BURST;
> +				p->txbl = DMA_DFT_BURST;
> +			}
> +
> +			p->pkt_drop = DMA_PKT_DROP_DIS;
> +		}

...

> +	if (d->ver == DMA_VER22) {
> +		spin_lock_irqsave(&c->vchan.lock, flags);
> +		if (vchan_issue_pending(&c->vchan)) {
> +			struct virt_dma_desc *vdesc;
> +
> +			/* Get the next descriptor */
> +			vdesc = vchan_next_desc(&c->vchan);
> +			if (!vdesc) {
> +				c->ds = NULL;

Nice! Don't you forget something to do here?

> +				return;

> +			}
> +			list_del(&vdesc->node);
> +			c->ds = to_lgm_dma_desc(vdesc);
> +			ldma_chan_desc_hw_cfg(c, c->ds->desc_phys, c->ds->desc_cnt);
> +			ldma_chan_irq_en(c);
> +		}
> +		spin_unlock_irqrestore(&c->vchan.lock, flags);
> +	}

...

> +	irncr = readl(d->base + DMA_IRNCR);
> +	if (!irncr) {

> +		dev_err(d->dev, "dummy interrupt\n");

I could imagine what happens in case of shared IRQ...

> +		return IRQ_NONE;
> +	}

...

> +	/* Default setting will be used */
> +	if (cfg->src_maxburst != 2 && cfg->src_maxburst != 4 &&
> +	    cfg->src_maxburst != 8)

This is strange. Caller should have a possibility to set anything based on the
channel and device capabilities. This one is hidden problem for the caller. Are
you going to customize each peripheral driver for your DMA engine
implementation?

> +		return;

...

> +	if (!sgl)
> +		return NULL;

Is it possible?

...

> +static int
> +dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
> +{
> +	struct ldma_chan *c = to_ldma_chan(chan);
> +
> +	if ((cfg->direction == DMA_DEV_TO_MEM &&
> +	     cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
> +	    (cfg->direction == DMA_MEM_TO_DEV &&
> +	     cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||

Why?

> +	    !is_slave_direction(cfg->direction))
> +		return -EINVAL;
> +
> +	/* Must be the same */

Why?

> +	if (cfg->src_maxburst && cfg->dst_maxburst &&
> +	    cfg->src_maxburst != cfg->dst_maxburst)
> +		return -EINVAL;

> +	if (cfg->src_maxburst != 2 && cfg->src_maxburst != 4 &&
> +	    cfg->src_maxburst != 8)

Why?

> +		return -EINVAL;
> +
> +	memcpy(&c->config, cfg, sizeof(c->config));
> +
> +	return 0;
> +}

...

> +static void dma_work(struct work_struct *work)
> +{
> +	struct ldma_chan *c = container_of(work, struct ldma_chan, work);
> +	struct dma_async_tx_descriptor *tx = &c->ds->vdesc.tx;
> +	struct virt_dma_chan *vc = &c->vchan;
> +	struct dmaengine_desc_callback cb;
> +	struct virt_dma_desc *vd, *_vd;
> +	LIST_HEAD(head);
> +
> +	list_splice_tail_init(&vc->desc_completed, &head);

No protection?

> +	dmaengine_desc_get_callback(tx, &cb);
> +	dma_cookie_complete(tx);
> +	dmaengine_desc_callback_invoke(&cb, NULL);
> +
> +	list_for_each_entry_safe(vd, _vd, &head, node) {
> +		dmaengine_desc_get_callback(tx, &cb);
> +		dma_cookie_complete(tx);
> +		list_del(&vd->node);
> +		dmaengine_desc_callback_invoke(&cb, NULL);
> +
> +		vchan_vdesc_fini(vd);
> +	}
> +	c->ds = NULL;
> +}

...

> +static int
> +update_client_configs(struct of_dma *ofdma, struct of_phandle_args *spec)
> +{
> +	struct ldma_dev *d = ofdma->of_dma_data;
> +	struct ldma_port *p;
> +	struct ldma_chan *c;
> +	u32 chan_id =  spec->args[0];
> +	u32 port_id =  spec->args[1];
> +
> +	if (chan_id >= d->chan_nrs || port_id >= d->port_nrs)
> +		return 0;
> +
> +	p = &d->ports[port_id];
> +	c = &d->chans[chan_id];
> +	c->port = p;
> +
> +	if (d->ver == DMA_VER22) {
> +		u32 desc_num;
> +		u32 burst = spec->args[2];
> +
> +		if (burst != 2 && burst != 4 && burst != 8)
> +			return 0;
> +
> +		/* TX and RX has the same burst length */
> +		p->txbl = ilog2(burst);
> +		p->rxbl = p->txbl;
> +
> +		desc_num = spec->args[3];
> +		if (desc_num > 255)
> +			return 0;
> +		c->desc_num = desc_num;
> +
> +		ldma_port_cfg(p);
> +		ldma_chan_cfg(c);
> +	} else {
> +		if (spec->args[2] > 0 && spec->args[2] <= DMA_ENDIAN_TYPE3) {
> +			c->data_endian = spec->args[2];
> +			c->data_endian_en = true;
> +		}
> +
> +		if (spec->args[3] > 0 && spec->args[3] <= DMA_ENDIAN_TYPE3) {
> +			c->desc_endian = spec->args[3];
> +			c->desc_endian_en = true;
> +		}
> +
> +		if (spec->args[4] > 0 && spec->args[4] < 128)
> +			c->boff_len = spec->args[4];
> +
> +		if (spec->args[5])
> +			c->desc_rx_np = true;
> +
> +		/*
> +		 * If channel packet drop enabled, port packet drop should
> +		 * be enabled
> +		 */
> +		if (spec->args[6]) {
> +			c->pden = true;
> +			p->pkt_drop = DMA_PKT_DROP_EN;
> +		}
> +
> +		/*
> +		 * hdr-mode: If enabled, header mode size is ignored
> +		 *           If disabled, header mode size must be provided
> +		 */
> +		c->hdrm_csum = !!spec->args[8];
> +		if (!c->hdrm_csum) {
> +			if (!spec->args[7] || spec->args[7] > DMA_HDR_LEN_MAX)
> +				return 0;
> +			c->hdrm_len = spec->args[7];
> +		}
> +
> +		if (spec->args[10]) {
> +			c->desc_cnt = spec->args[10];
> +			if (c->desc_cnt > DMA_MAX_DESC_NUM) {
> +				dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
> +					c->nr, c->desc_cnt);
> +				return 0;
> +			}
> +			c->desc_phys = spec->args[9];
> +			c->flags |= DMA_HW_DESC;
> +		}
> +
> +		ldma_port_cfg(p);
> +		ldma_chan_cfg(c);
> +	}
> +
> +	return 1;
> +}
> +

Can you split all these kind of functions each to three:

foo_vXXX()
foo_v22()

foo()
{
	if (ver = 22)
		return foo_v22()
	return foo_vXXX()
}

?

...

> +	d->rst = devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(d->rst))
> +		return PTR_ERR(d->rst);
> +	reset_control_deassert(d->rst);

Shouldn't be devm_add_action_or_reset() for assert reset?

...

> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		if (id & DMA_ID_AW_36B)
> +			bitn = 36;
> +	}

if (a) { if (b) { ... }} ==> if (a && b) { ...}

...

> +	if (d->ver == DMA_VER22) {

Split?

> +		ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +					   &d->chan_nrs);
> +		if (ret < 0) {
> +			dev_err(dev, "unable to read dma-channels property\n");
> +			return ret;
> +		}
> +
> +		ret = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
> +					   &d->channels_mask);
> +		if (ret < 0)
> +			d->channels_mask = GENMASK(d->chan_nrs - 1, 0);

of_property*() are leftovers? Shouldn't be device_property_*()?

> +
> +		d->irq = platform_get_irq(pdev, 0);
> +		if (d->irq < 0)
> +			return d->irq;
> +
> +		ret = devm_request_irq(&pdev->dev, d->irq, dma_interrupt,
> +				       0, DRIVER_NAME, d);
> +		if (ret)
> +			return ret;
> +
> +		d->wq = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
> +						WQ_HIGHPRI);
> +		if (!d->wq)
> +			return -ENOMEM;
> +	}

...

> +	for (i = 0; i < d->port_nrs; i++) {
> +		p = &d->ports[i];
> +		p->portid = i;
> +		p->ldev = d;

> +		for (j = 0; j < d->chan_nrs && d->ver != DMA_VER22; j++)
> +			c = &d->chans[j];

What's going on here?

> +	}

...

> +	for (i = 0; i < d->chan_nrs; i++) {
> +		if (d->ver == DMA_VER22) {

Split...

> +			if (!(d->channels_mask & BIT(i)))
> +				continue;

...and obviously for_each_set_bit().

> +			c = &d->chans[i];
> +			c->nr = i; /* Real channel number */
> +			c->rst = DMA_CHAN_RST;
> +			snprintf(c->name, sizeof(c->name), "chan%d",
> +				 c->nr);
> +			INIT_WORK(&c->work, dma_work);
> +			c->vchan.desc_free = dma_free_desc_resource;
> +			vchan_init(&c->vchan, dma_dev);
> +		} else {
> +			c = &d->chans[i];
> +			c->data_endian = DMA_DFT_ENDIAN;
> +			c->desc_endian = DMA_DFT_ENDIAN;
> +			c->data_endian_en = false;
> +			c->desc_endian_en = false;
> +			c->desc_rx_np = false;
> +			c->flags |= DEVICE_ALLOC_DESC;
> +			c->onoff = DMA_CH_OFF;
> +			c->rst = DMA_CHAN_RST;
> +			c->abc_en = true;
> +			c->nr = i;
> +			c->vchan.desc_free = dma_free_desc_resource;
> +			vchan_init(&c->vchan, dma_dev);
> +		}
> +	}

...

> +static int __init intel_ldma_init(void)
> +{
> +	return platform_driver_register(&intel_ldma_driver);
> +}
> +
> +device_initcall(intel_ldma_init);

Each _initcall() in general should be explained.

...

> +#include <linux/dmaengine.h>

I don't see how it's used

struct dma_chan;

should be enough.

> +/*!
> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
> + *                                 int desc_num)
> + * \brief Configure low level channel descriptors
> + * \param[in] chan   pointer to DMA channel that the client is using
> + * \param[in] desc_base   descriptor base physical address
> + * \param[in] desc_num   number of descriptors
> + * \return   0 on success
> + * \return   kernel bug reported on failure
> + *
> + * This function configure the low level channel descriptors. It will be
> + * used by CBM whose descriptor is not DDR, actually some registers.
> + */
> +int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
> +			    int desc_num);

-- 
With Best Regards,
Andy Shevchenko


