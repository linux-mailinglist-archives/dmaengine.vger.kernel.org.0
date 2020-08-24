Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C200824F13E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHXCmW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Aug 2020 22:42:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:5563 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgHXCmU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 23 Aug 2020 22:42:20 -0400
IronPort-SDR: 8D/3RxoVzFBFVu2YZKNGPd56qibkc6VZbKUi+/96usPJlKRV/GlgZeBVgb4C7eRG5zdoAW9D1c
 TD7k94PXiLxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="153240806"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="153240806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 19:30:18 -0700
IronPort-SDR: 78yZGpL6UQoMLNzOgItJMz3EsvlyDaKSFl0afApAuwtrMH/loduPO5syiw1nPKcR9/PHBijSUN
 1EcKUuuIyCmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="498737679"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2020 19:30:16 -0700
Received: from [10.213.152.140] (mreddy3x-MOBL.gar.corp.intel.com [10.213.152.140])
        by linux.intel.com (Postfix) with ESMTP id 66B77580821;
        Sun, 23 Aug 2020 19:30:13 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, malliamireddy009@gmail.com
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
Date:   Mon, 24 Aug 2020 10:30:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,
Thanks for the review comments. Please see my comments inline..

On 8/18/2020 6:16 PM, Peter Ujfalusi wrote:
> Hi,
>
> On 14/08/2020 8.26, Amireddy Mallikarjuna reddy wrote:
>> Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
>>
>> The main function of the DMA controller is the transfer of data from/to any
>> DPlus compliant peripheral to/from the memory. A memory to memory copy
>> capability can also be configured.
>>
>> This ldma driver is used for configure the device and channnels for data
>> and control paths.
>>
>> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> ...
>
>> +static int ldma_chan_cfg(struct ldma_chan *c)
>> +{
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	u32 reg;
>> +
>> +	reg = c->pden ? DMA_CCTRL_PDEN : 0;
>> +	reg |= c->onoff ? DMA_CCTRL_ON : 0;
>> +	reg |= c->rst ? DMA_CCTRL_RST : 0;
>> +
>> +	ldma_chan_cctrl_cfg(c, reg);
>> +	ldma_chan_irq_init(c);
>> +
>> +	if (d->ver > DMA_VER22) {
>> +		ldma_chan_set_class(c, c->nr);
>> +		ldma_chan_byte_offset_cfg(c, c->boff_len);
>> +		ldma_chan_data_endian_cfg(c, c->data_endian_en, c->data_endian);
>> +		ldma_chan_desc_endian_cfg(c, c->desc_endian_en, c->desc_endian);
>> +		ldma_chan_hdr_mode_cfg(c, c->hdrm_len, c->hdrm_csum);
>> +		ldma_chan_rxwr_np_cfg(c, c->desc_rx_np);
>> +		ldma_chan_abc_cfg(c, c->abc_en);
> Each of these functions will lock and unlock the same lock, would it
> make sense to restructur things to have less activity with the spinlock?
Ok. Instead of lock & unlock at each function i will try to lock & 
unlock only once from here.
>
>> +
>> +		if (ldma_chan_is_hw_desc(c))
>> +			ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
>> +	}
>> +
>> +	return 0;
>> +}
> ...
>
>> +static void dma_free_desc_resource(struct virt_dma_desc *vdesc)
>> +{
>> +	struct dw2_desc_sw *ds = to_lgm_dma_desc(vdesc);
>> +	struct ldma_chan *c = ds->chan;
>> +
>> +	dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc_phys);
>> +	kfree(ds);
>> +	c->ds = NULL;
> Is there a chance that c->ds != ds?
No, from the code i don't see any such scenario, let me know if you find 
any corner case.
>
>> +}
>> +
>> +static struct dw2_desc_sw *
>> +dma_alloc_desc_resource(int num, struct ldma_chan *c)
>> +{
>> +	struct device *dev = c->vchan.chan.device->dev;
>> +	struct dw2_desc_sw *ds;
>> +
>> +	if (num > c->desc_num) {
>> +		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_num);
>> +		return NULL;
>> +	}
>> +
>> +	ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
>> +	if (!ds)
>> +		return NULL;
>> +
>> +	ds->chan = c;
>> +
>> +	ds->desc_hw = dma_pool_zalloc(c->desc_pool, GFP_ATOMIC,
>> +				      &ds->desc_phys);
>> +	if (!ds->desc_hw) {
>> +		dev_dbg(dev, "out of memory for link descriptor\n");
>> +		kfree(ds);
>> +		return NULL;
>> +	}
>> +	ds->desc_cnt = num;
>> +
>> +	return ds;
>> +}
>> +
>> +static void ldma_chan_irq_en(struct ldma_chan *c)
>> +{
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&d->dev_lock, flags);
>> +	writel(c->nr, d->base + DMA_CS);
>> +	writel(DMA_CI_EOP, d->base + DMA_CIE);
>> +	writel(BIT(c->nr), d->base + DMA_IRNEN);
>> +	spin_unlock_irqrestore(&d->dev_lock, flags);
>> +}
>> +
>> +static void dma_issue_pending(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	unsigned long flags;
>> +
>> +	if (d->ver == DMA_VER22) {
>> +		spin_lock_irqsave(&c->vchan.lock, flags);
>> +		if (vchan_issue_pending(&c->vchan)) {
>> +			struct virt_dma_desc *vdesc;
>> +
>> +			/* Get the next descriptor */
>> +			vdesc = vchan_next_desc(&c->vchan);
>> +			if (!vdesc) {
>> +				c->ds = NULL;
>> +				return;
>> +			}
>> +			list_del(&vdesc->node);
>> +			c->ds = to_lgm_dma_desc(vdesc);
> you have set c->ds in dma_prep_slave_sg and the only way I can see that
> you will not leak memory is that the client must terminate_sync() after
> each transfer so that the synchronize callback is invoked between each
> prep_sg/issue_pending/competion.
Yes, client must call dmaengine_synchronize after each transfer to make 
sure free the memory assoicated with previously issued descriptors if any.
and also from the driver we are freeing up the descriptor from work 
queue atfer each transfer.(addressed below comments **)
>
>> +			spin_unlock_irqrestore(&c->vchan.lock, flags);
>> +			ldma_chan_desc_hw_cfg(c, c->ds->desc_phys, c->ds->desc_cnt);
>> +			ldma_chan_irq_en(c);
>> +		}
> If there is nothing peding, you will leave the spinlock wide open...
Seems i misplaced the lock. i will fix it in next version.
>
>> +	}
>> +	ldma_chan_on(c);
>> +}
>> +
>> +static void dma_synchronize(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +
>> +	/*
>> +	 * clear any pending work if any. In that
>> +	 * case the resource needs to be free here.
>> +	 */
>> +	cancel_work_sync(&c->work);
>> +	vchan_synchronize(&c->vchan);
>> +	if (c->ds)
>> +		dma_free_desc_resource(&c->ds->vdesc);
>> +}
>> +
>> +static int dma_terminate_all(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	unsigned long flags;
>> +	LIST_HEAD(head);
>> +
>> +	spin_lock_irqsave(&c->vchan.lock, flags);
>> +	vchan_get_all_descriptors(&c->vchan, &head);
>> +	spin_unlock_irqrestore(&c->vchan.lock, flags);
>> +	vchan_dma_desc_free_list(&c->vchan, &head);
>> +
>> +	return ldma_chan_reset(c);
>> +}
>> +
>> +static int dma_resume_chan(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +
>> +	ldma_chan_on(c);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dma_pause_chan(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +
>> +	return ldma_chan_off(c);
>> +}
>> +
>> +static enum dma_status
>> +dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>> +	      struct dma_tx_state *txstate)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	enum dma_status status = DMA_COMPLETE;
>> +
>> +	if (d->ver == DMA_VER22)
>> +		status = dma_cookie_status(chan, cookie, txstate);
>> +
>> +	return status;
>> +}
>> +
>> +static void dma_chan_irq(int irq, void *data)
>> +{
>> +	struct ldma_chan *c = data;
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	u32 stat;
>> +
>> +	/* Disable channel interrupts  */
>> +	writel(c->nr, d->base + DMA_CS);
>> +	stat = readl(d->base + DMA_CIS);
>> +	if (!stat)
>> +		return;
>> +
>> +	writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
>> +	writel(stat, d->base + DMA_CIS);
>> +	queue_work(d->wq, &c->work);
>> +}
>> +
>> +static irqreturn_t dma_interrupt(int irq, void *dev_id)
>> +{
>> +	struct ldma_dev *d = dev_id;
>> +	struct ldma_chan *c;
>> +	unsigned long irncr;
>> +	u32 cid;
>> +
>> +	irncr = readl(d->base + DMA_IRNCR);
>> +	if (!irncr) {
>> +		dev_err(d->dev, "dummy interrupt\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	for_each_set_bit(cid, &irncr, d->chan_nrs) {
>> +		/* Mask */
>> +		writel(readl(d->base + DMA_IRNEN) & ~BIT(cid), d->base + DMA_IRNEN);
>> +		/* Ack */
>> +		writel(readl(d->base + DMA_IRNCR) | BIT(cid), d->base + DMA_IRNCR);
>> +
>> +		c = &d->chans[cid];
>> +		dma_chan_irq(irq, c);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +		  unsigned int sglen, enum dma_transfer_direction dir,
>> +		  unsigned long flags, void *context)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	size_t len, avail, total = 0;
>> +	struct dw2_desc *hw_ds;
>> +	struct dw2_desc_sw *ds;
>> +	struct scatterlist *sg;
>> +	int num = sglen, i;
>> +	dma_addr_t addr;
>> +
>> +	if (!sgl)
>> +		return NULL;
>> +
>> +	for_each_sg(sgl, sg, sglen, i) {
>> +		avail = sg_dma_len(sg);
>> +		if (avail > DMA_MAX_SIZE)
>> +			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
>> +	}
>> +
>> +	ds = dma_alloc_desc_resource(num, c);
>> +	if (!ds)
>> +		return NULL;
>> +
>> +	c->ds = ds;
> If you still have a transfer running then you are going to get lost that
> dscriptor?
No, please let me know if you find any such corner case.
>
>> +
>> +	num = 0;
>> +	/* sop and eop has to be handled nicely */
>> +	for_each_sg(sgl, sg, sglen, i) {
>> +		addr = sg_dma_address(sg);
>> +		avail = sg_dma_len(sg);
>> +		total += avail;
>> +
>> +		do {
>> +			len = min_t(size_t, avail, DMA_MAX_SIZE);
>> +
>> +			hw_ds = &ds->desc_hw[num];
>> +			switch (sglen) {
>> +			case 1:
>> +				hw_ds->status.field.sop = 1;
>> +				hw_ds->status.field.eop = 1;
>> +				break;
>> +			default:
>> +				if (num == 0) {
>> +					hw_ds->status.field.sop = 1;
>> +					hw_ds->status.field.eop = 0;
>> +				} else if (num == (sglen - 1)) {
>> +					hw_ds->status.field.sop = 0;
>> +					hw_ds->status.field.eop = 1;
>> +				} else {
>> +					hw_ds->status.field.sop = 0;
>> +					hw_ds->status.field.eop = 0;
>> +				}
>> +				break;
>> +			}
>> +
>> +			/* Only 32 bit address supported */
>> +			hw_ds->addr = (u32)addr;
>> +			hw_ds->status.field.len = len;
>> +			hw_ds->status.field.c = 0;
>> +			hw_ds->status.field.bofs = addr & 0x3;
>> +			/* Ensure data ready before ownership change */
>> +			wmb();
>> +			hw_ds->status.field.own = DMA_OWN;
>> +			/* Ensure ownership changed before moving forward */
>> +			wmb();
>> +			num++;
>> +			addr += len;
>> +			avail -= len;
>> +		} while (avail);
>> +	}
>> +
>> +	ds->size = total;
>> +
>> +	return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
>> +}
>> +
>> +static int
>> +dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	struct ldma_port *p = c->port;
>> +	unsigned long flags;
>> +	u32 bl;
>> +
>> +	if ((cfg->direction == DMA_DEV_TO_MEM &&
>> +	     cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>> +	    (cfg->direction == DMA_MEM_TO_DEV &&
>> +	     cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
> According to the probe function these width restrictions are only valid
> for DMA_VER22?
YES
>
>> +	    !is_slave_direction(cfg->direction))
>> +		return -EINVAL;
>> +
>> +	/* Default setting will be used */
>> +	if (!cfg->src_maxburst && !cfg->dst_maxburst)
>> +		return 0;
> maxburst == 0 is identical to maxburst == 1, it is just not set
> explicitly. Iow 1 word per DMA request.
This is not clear to me. Can you elaborate?
>
>> +
>> +	/* Must be the same */
>> +	if (cfg->src_maxburst && cfg->dst_maxburst &&
>> +	    cfg->src_maxburst != cfg->dst_maxburst)
>> +		return -EINVAL;
>> +
>> +	if (cfg->dst_maxburst)
>> +		cfg->src_maxburst = cfg->dst_maxburst;
>> +
>> +	bl = ilog2(cfg->src_maxburst);
>> +
>> +	spin_lock_irqsave(&d->dev_lock, flags);
>> +	writel(p->portid, d->base + DMA_PS);
>> +	ldma_update_bits(d, DMA_PCTRL_RXBL | DMA_PCTRL_TXBL,
>> +			 FIELD_PREP(DMA_PCTRL_RXBL, bl) |
>> +			 FIELD_PREP(DMA_PCTRL_TXBL, bl), DMA_PCTRL);
>> +	spin_unlock_irqrestore(&d->dev_lock, flags);
> What drivers usually do is to save the cfg and inprepare time take it
> into account when setting up the transfer.
> Write the change to the HW before the trasnfer is started (if it has
> changed from previous settings)
>
> Client drivers usually set the slave config ones, in most cases during
> probe, so the slave config rarely changes runtime, but there are cases
> for that.
Ok, got it. i will update in the next version.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +	struct device *dev = c->vchan.chan.device->dev;
>> +	size_t	desc_sz;
>> +
>> +	if (d->ver > DMA_VER22) {
>> +		c->flags |= CHAN_IN_USE;
>> +		return 0;
>> +	}
>> +
>> +	if (c->desc_pool)
>> +		return c->desc_num;
>> +
>> +	desc_sz = c->desc_num * sizeof(struct dw2_desc);
>> +	c->desc_pool = dma_pool_create(c->name, dev, desc_sz,
>> +				       __alignof__(struct dw2_desc), 0);
>> +
>> +	if (!c->desc_pool) {
>> +		dev_err(dev, "unable to allocate descriptor pool\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return c->desc_num;
>> +}
>> +
>> +static void dma_free_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c = to_ldma_chan(chan);
>> +	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>> +
>> +	if (d->ver == DMA_VER22) {
>> +		dma_pool_destroy(c->desc_pool);
>> +		c->desc_pool = NULL;
>> +		vchan_free_chan_resources(to_virt_chan(chan));
>> +		ldma_chan_reset(c);
>> +	} else {
>> +		c->flags &= ~CHAN_IN_USE;
>> +	}
>> +}
>> +
>> +static void dma_work(struct work_struct *work)
>> +{
>> +	struct ldma_chan *c = container_of(work, struct ldma_chan, work);
>> +	struct dma_async_tx_descriptor *tx = &c->ds->vdesc.tx;
>> +	struct dmaengine_desc_callback cb;
>> +
>> +	dmaengine_desc_get_callback(tx, &cb);
>> +	dma_cookie_complete(tx);
>> +	dmaengine_desc_callback_invoke(&cb, NULL);
> When you are going to free up the descriptor?
**
Seems i missed free up the descriptor here. i will fix and update in the 
next version.
>
>> +}
>> +
>> +int update_client_configs(struct of_dma *ofdma, struct of_phandle_args *spec)
>> +{
>> +	struct ldma_dev *d = ofdma->of_dma_data;
>> +	struct ldma_port *p;
>> +	struct ldma_chan *c;
>> +	u32 chan_id =  spec->args[0];
>> +	u32 port_id =  spec->args[1];
>> +
>> +	if (chan_id >= d->chan_nrs || port_id >= d->port_nrs)
>> +		return 0;
>> +
>> +	p = &d->ports[port_id];
>> +	c = &d->chans[chan_id];
>> +
>> +	if (d->ver == DMA_VER22) {
>> +		u32 burst = spec->args[2];
>> +
>> +		if (burst != 2 && burst != 4 && burst != 8)
>> +			return 0;
>> +
>> +		/* TX and RX has the same burst length */
>> +		p->txbl = ilog2(burst);
>> +		p->rxbl = p->txbl;
>> +
>> +		ldma_port_cfg(p);
>> +	} else {
>> +		if (spec->args[2] > 0 && spec->args[2] <= DMA_ENDIAN_TYPE3) {
>> +			c->data_endian = spec->args[2];
>> +			c->data_endian_en = true;
>> +		}
>> +
>> +		if (spec->args[3] > 0 && spec->args[3] <= DMA_ENDIAN_TYPE3) {
>> +			c->desc_endian = spec->args[3];
>> +			c->desc_endian_en = true;
>> +		}
>> +
>> +		if (spec->args[4] > 0 && spec->args[4] < 128)
>> +			c->boff_len = spec->args[4];
>> +
>> +		if (spec->args[5])
>> +			c->desc_rx_np = true;
>> +
>> +		/*
>> +		 * If channel packet drop enabled, port packet drop should
>> +		 * be enabled
>> +		 */
>> +		if (spec->args[6]) {
>> +			c->pden = true;
>> +			p->pkt_drop = DMA_PKT_DROP_EN;
>> +		}
>> +		ldma_port_cfg(p);
>> +		ldma_chan_cfg(c);
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
>> +				   struct of_dma *ofdma)
>> +{
>> +	struct ldma_dev *d = ofdma->of_dma_data;
>> +	u32 chan_id =  spec->args[0];
>> +	int ret;
>> +
>> +	if (!spec->args_count)
>> +		return NULL;
>> +
>> +	/* if args_count is 1 use driver default config settings */
>> +	if (spec->args_count > 1) {
>> +		ret = update_client_configs(ofdma, spec);
>> +		if (!ret)
>> +			return NULL;
>> +	}
>> +
>> +	return dma_get_slave_channel(&d->chans[chan_id].vchan.chan);
>> +}
>> +
>> +static void ldma_clk_disable(void *data)
>> +{
>> +	struct ldma_dev *d = data;
>> +
>> +	clk_disable_unprepare(d->core_clk);
>> +}
>> +
>> +static struct dma_dev_ops dma0_ops = {
>> +	.device_alloc_chan_resources = dma_alloc_chan_resources,
>> +	.device_free_chan_resources = dma_free_chan_resources,
>> +	.device_config = dma_slave_config,
>> +	.device_prep_slave_sg = dma_prep_slave_sg,
>> +	.device_tx_status = dma_tx_status,
>> +	.device_pause = dma_pause_chan,
>> +	.device_resume = dma_resume_chan,
>> +	.device_terminate_all = dma_terminate_all,
>> +	.device_synchronize = dma_synchronize,
>> +	.device_issue_pending = dma_issue_pending,
>> +};
>> +
>> +static struct dma_dev_ops hdma_ops = {
>> +	.device_alloc_chan_resources = dma_alloc_chan_resources,
>> +	.device_free_chan_resources = dma_free_chan_resources,
>> +	.device_terminate_all = dma_terminate_all,
>> +	.device_issue_pending = dma_issue_pending,
>> +	.device_tx_status = dma_tx_status,
>> +	.device_resume = dma_resume_chan,
>> +	.device_pause = dma_pause_chan,
>> +};
>> +
>> +static const struct ldma_inst_data dma0 = {
>> +	.name = "dma0",
>> +	.ops = &dma0_ops,
>> +};
>> +
>> +static const struct ldma_inst_data dma2tx = {
>> +	.name = "dma2tx",
>> +	.type = DMA_TYPE_TX,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data dma1rx = {
>> +	.name = "dma1rx",
>> +	.type = DMA_TYPE_RX,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data dma1tx = {
>> +	.name = "dma1tx",
>> +	.type = DMA_TYPE_TX,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data dma0tx = {
>> +	.name = "dma0tx",
>> +	.type = DMA_TYPE_TX,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data dma3 = {
>> +	.name = "dma3",
>> +	.type = DMA_TYPE_MCPY,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data toe_dma30 = {
>> +	.name = "toe_dma30",
>> +	.type = DMA_TYPE_MCPY,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct ldma_inst_data toe_dma31 = {
>> +	.name = "toe_dma31",
>> +	.type = DMA_TYPE_MCPY,
>> +	.ops = &hdma_ops,
>> +};
>> +
>> +static const struct of_device_id intel_ldma_match[] = {
>> +	{ .compatible = "intel,lgm-cdma", .data = &dma0},
>> +	{ .compatible = "intel,lgm-dma2tx", .data = &dma2tx},
>> +	{ .compatible = "intel,lgm-dma1rx", .data = &dma1rx},
>> +	{ .compatible = "intel,lgm-dma1tx", .data = &dma1tx},
>> +	{ .compatible = "intel,lgm-dma0tx", .data = &dma0tx},
>> +	{ .compatible = "intel,lgm-dma3", .data = &dma3},
>> +	{ .compatible = "intel,lgm-toe-dma30", .data = &toe_dma30},
>> +	{ .compatible = "intel,lgm-toe-dma31", .data = &toe_dma31},
>> +	{}
>> +};
>> +
>> +static int intel_ldma_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct dma_device *dma_dev;
>> +	struct ldma_chan *c;
>> +	struct ldma_port *p;
>> +	struct ldma_dev *d;
>> +	u32 id, bitn = 32;
>> +	int i, j, k, ret;
>> +
>> +	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
>> +	if (!d)
>> +		return -ENOMEM;
>> +
>> +	/* Link controller to platform device */
>> +	d->dev = &pdev->dev;
>> +
>> +	d->inst = device_get_match_data(dev);
>> +	if (!d->inst) {
>> +		dev_err(dev, "No device match found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	d->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(d->base))
>> +		return PTR_ERR(d->base);
>> +
>> +	/* Power up and reset the dma engine, some DMAs always on?? */
>> +	d->core_clk = devm_clk_get_optional(dev, NULL);
>> +	if (IS_ERR(d->core_clk))
>> +		return PTR_ERR(d->core_clk);
>> +	clk_prepare_enable(d->core_clk);
>> +
>> +	ret = devm_add_action_or_reset(dev, ldma_clk_disable, d);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to devm_add_action_or_reset, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	d->rst = devm_reset_control_get_optional(dev, NULL);
>> +	if (IS_ERR(d->rst))
>> +		return PTR_ERR(d->rst);
>> +	reset_control_deassert(d->rst);
>> +
>> +	id = readl(d->base + DMA_ID);
>> +	d->chan_nrs = FIELD_GET(DMA_ID_CHNR, id);
>> +	d->port_nrs = FIELD_GET(DMA_ID_PNR, id);
>> +	d->ver = FIELD_GET(DMA_ID_REV, id);
>> +
>> +	if (id & DMA_ID_AW_36B)
>> +		d->flags |= DMA_ADDR_36BIT;
>> +
>> +	if (IS_ENABLED(CONFIG_64BIT)) {
>> +		if (id & DMA_ID_AW_36B)
>> +			bitn = 36;
>> +	}
>> +
>> +	if (id & DMA_ID_DW_128B)
>> +		d->flags |= DMA_DATA_128BIT;
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(bitn));
>> +	if (ret) {
>> +		dev_err(dev, "No usable DMA configuration\n");
>> +		return ret;
>> +	}
>> +
>> +	if (d->ver == DMA_VER22) {
>> +		d->irq = platform_get_irq(pdev, 0);
>> +		if (d->irq < 0)
>> +			return d->irq;
>> +
>> +		ret = devm_request_irq(&pdev->dev, d->irq, dma_interrupt,
>> +				       0, DRIVER_NAME, d);
>> +		if (ret)
>> +			return ret;
>> +
>> +		d->wq = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
>> +						WQ_HIGHPRI);
>> +		if (!d->wq)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	dma_dev = &d->dma_dev;
>> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>> +
>> +	/* Channel initializations */
>> +	INIT_LIST_HEAD(&dma_dev->channels);
>> +
>> +	/* Port Initializations */
>> +	d->ports = devm_kcalloc(dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
>> +	if (!d->ports)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < d->port_nrs; i++) {
>> +		p = &d->ports[i];
>> +		p->portid = i;
>> +		p->ldev = d;
>> +	}
>> +
>> +	ret = ldma_cfg_init(d);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dma_dev->dev = &pdev->dev;
>> +	/*
>> +	 * Link channel id to channel index and link to dma channel list
>> +	 * It also back points to controller and its port
>> +	 */
>> +	for (i = 0, k = 0; i < d->port_nrs; i++) {
>> +		if (d->ver == DMA_VER22) {
>> +			u32 chan_end;
>> +
>> +			p = &d->ports[i];
>> +			chan_end = p->chan_start + p->chan_sz;
>> +			for (j = p->chan_start; j < chan_end; j++) {
>> +				c = &d->chans[k];
>> +				c->port = p;
>> +				c->nr = j; /* Real channel number */
>> +				c->rst = DMA_CHAN_RST;
>> +				snprintf(c->name, sizeof(c->name), "chan%d",
>> +					 c->nr);
>> +				INIT_WORK(&c->work, dma_work);
>> +				c->vchan.desc_free = dma_free_desc_resource;
>> +				vchan_init(&c->vchan, dma_dev);
>> +				k++;
>> +			}
>> +		} else {
>> +			p = &d->ports[i];
>> +			for (i = 0; i < d->chan_nrs; i++) {
>> +				c = &d->chans[i];
>> +				c->port = p;
>> +				c->data_endian = DMA_DFT_ENDIAN;
>> +				c->desc_endian = DMA_DFT_ENDIAN;
>> +				c->data_endian_en = false;
>> +				c->desc_endian_en = false;
>> +				c->desc_rx_np = false;
>> +				c->flags |= DEVICE_ALLOC_DESC;
>> +				c->onoff = DMA_CH_OFF;
>> +				c->rst = DMA_CHAN_RST;
>> +				c->abc_en = true;
>> +				c->nr = i;
>> +				c->vchan.desc_free = dma_free_desc_resource;
>> +				vchan_init(&c->vchan, dma_dev);
>> +			}
>> +		}
>> +	}
>> +
>> +	/* Set DMA capabilities */
>> +	dma_cap_zero(dma_dev->cap_mask);
> You just cleared the DMA_SLAVE capability you set earlier...
Yes correct. i will fix it.
>
>> +
>> +	dma_dev->device_alloc_chan_resources =
>> +		d->inst->ops->device_alloc_chan_resources;
>> +	dma_dev->device_free_chan_resources =
>> +		d->inst->ops->device_free_chan_resources;
>> +	dma_dev->device_terminate_all = d->inst->ops->device_terminate_all;
>> +	dma_dev->device_issue_pending = d->inst->ops->device_issue_pending;
>> +	dma_dev->device_tx_status = d->inst->ops->device_tx_status;
>> +	dma_dev->device_resume = d->inst->ops->device_resume;
>> +	dma_dev->device_pause = d->inst->ops->device_pause;
>> +	dma_dev->device_config = d->inst->ops->device_config;
>> +	dma_dev->device_prep_slave_sg = d->inst->ops->device_prep_slave_sg;
>> +	dma_dev->device_synchronize = d->inst->ops->device_synchronize;
>> +
>> +	if (d->ver == DMA_VER22) {
>> +		dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +		dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +		dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
>> +				      BIT(DMA_DEV_TO_MEM);
>> +		dma_dev->residue_granularity =
>> +					DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>> +	}
> So, if version is != DMA_VER22, then you don't support any direction?
> Why register the DMA device if it can not do any transfer?
Only dma0 instance (intel,lgm-cdma) is used as a general purpose slave 
DMA. we set both control and datapath here.
Other instances we set only control path. data path is taken care by dma 
client(GSWIP).
Only thing needs to do is get the channel, set the descriptor and just 
on the channel.
>
>> +
>> +	platform_set_drvdata(pdev, d);
>> +
>> +	ldma_dev_init(d);
>> +
>> +	ret = dma_async_device_register(dma_dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register slave DMA engine device\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_dma_controller_register(pdev->dev.of_node, ldma_xlate, d);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register of DMA controller\n");
>> +		dma_async_device_unregister(dma_dev);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Init done - rev: %x, ports: %d channels: %d\n", d->ver,
>> +		 d->port_nrs, d->chan_nrs);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver intel_ldma_driver = {
>> +	.probe = intel_ldma_probe,
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.of_match_table = intel_ldma_match,
>> +	},
>> +};
>> +
>> +static int __init intel_ldma_init(void)
>> +{
>> +	return platform_driver_register(&intel_ldma_driver);
>> +}
>> +
>> +device_initcall(intel_ldma_init);
>> diff --git a/include/linux/dma/lgm_dma.h b/include/linux/dma/lgm_dma.h
>> new file mode 100644
>> index 000000000000..3a2ee6ad0710
>> --- /dev/null
>> +++ b/include/linux/dma/lgm_dma.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2016 ~ 2019 Intel Corporation.
>> + */
>> +#ifndef LGM_DMA_H
>> +#define LGM_DMA_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/dmaengine.h>
>> +
>> +/*!
>> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
>> + *                                 int desc_num)
>> + * \brief Configure low level channel descriptors
>> + * \param[in] chan   pointer to DMA channel that the client is using
>> + * \param[in] desc_base   descriptor base physical address
>> + * \param[in] desc_num   number of descriptors
>> + * \return   0 on success
>> + * \return   kernel bug reported on failure
>> + *
>> + * This function configure the low level channel descriptors. It will be
>> + * used by CBM whose descriptor is not DDR, actually some registers.
>> + */
>> +int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
>> +			    int desc_num);
>> +
>> +#endif /* LGM_DMA_H */
>>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
