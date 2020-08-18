Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C742482B5
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 12:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHRKPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 06:15:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45354 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRKPM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 06:15:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07IAF4MB064627;
        Tue, 18 Aug 2020 05:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597745704;
        bh=3jmRefH4cT0IAnHR+TiQe4w67xrqSSAOEcCIRa71pVc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=INE8Rf8HcvilMP51/61zbAMisQoom9xopCifiz+r3qcnDvklJb6JV7Y8yZrkqtUQy
         nXYpZPOLMbl33qmyATXS4LtLARIt0zFQlZLRiF4P+s/nVAEG7sU0rFi9sCGxWV219/
         y0C0oELBq2ORYx6/j44RCgEOBvmwnf5LLHVaNIAo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07IAF2aQ102835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 05:15:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 18
 Aug 2020 05:15:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 18 Aug 2020 05:15:03 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IAF0YU080724;
        Tue, 18 Aug 2020 05:15:00 -0500
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>,
        <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>,
        <chuanhua.lei@linux.intel.com>, <malliamireddy009@gmail.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
Date:   Tue, 18 Aug 2020 13:16:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 14/08/2020 8.26, Amireddy Mallikarjuna reddy wrote:
> Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
>=20
> The main function of the DMA controller is the transfer of data from/to=
 any
> DPlus compliant peripheral to/from the memory. A memory to memory copy
> capability can also be configured.
>=20
> This ldma driver is used for configure the device and channnels for dat=
a
> and control paths.
>=20
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.i=
ntel.com>

=2E..

> +static int ldma_chan_cfg(struct ldma_chan *c)
> +{
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	u32 reg;
> +
> +	reg =3D c->pden ? DMA_CCTRL_PDEN : 0;
> +	reg |=3D c->onoff ? DMA_CCTRL_ON : 0;
> +	reg |=3D c->rst ? DMA_CCTRL_RST : 0;
> +
> +	ldma_chan_cctrl_cfg(c, reg);
> +	ldma_chan_irq_init(c);
> +
> +	if (d->ver > DMA_VER22) {
> +		ldma_chan_set_class(c, c->nr);
> +		ldma_chan_byte_offset_cfg(c, c->boff_len);
> +		ldma_chan_data_endian_cfg(c, c->data_endian_en, c->data_endian);
> +		ldma_chan_desc_endian_cfg(c, c->desc_endian_en, c->desc_endian);
> +		ldma_chan_hdr_mode_cfg(c, c->hdrm_len, c->hdrm_csum);
> +		ldma_chan_rxwr_np_cfg(c, c->desc_rx_np);
> +		ldma_chan_abc_cfg(c, c->abc_en);

Each of these functions will lock and unlock the same lock, would it
make sense to restructur things to have less activity with the spinlock?

> +
> +		if (ldma_chan_is_hw_desc(c))
> +			ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
> +	}
> +
> +	return 0;
> +}

=2E..

> +static void dma_free_desc_resource(struct virt_dma_desc *vdesc)
> +{
> +	struct dw2_desc_sw *ds =3D to_lgm_dma_desc(vdesc);
> +	struct ldma_chan *c =3D ds->chan;
> +
> +	dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc_phys);
> +	kfree(ds);
> +	c->ds =3D NULL;

Is there a chance that c->ds !=3D ds?

> +}
> +
> +static struct dw2_desc_sw *
> +dma_alloc_desc_resource(int num, struct ldma_chan *c)
> +{
> +	struct device *dev =3D c->vchan.chan.device->dev;
> +	struct dw2_desc_sw *ds;
> +
> +	if (num > c->desc_num) {
> +		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_num);
> +		return NULL;
> +	}
> +
> +	ds =3D kzalloc(sizeof(*ds), GFP_NOWAIT);
> +	if (!ds)
> +		return NULL;
> +
> +	ds->chan =3D c;
> +
> +	ds->desc_hw =3D dma_pool_zalloc(c->desc_pool, GFP_ATOMIC,
> +				      &ds->desc_phys);
> +	if (!ds->desc_hw) {
> +		dev_dbg(dev, "out of memory for link descriptor\n");
> +		kfree(ds);
> +		return NULL;
> +	}
> +	ds->desc_cnt =3D num;
> +
> +	return ds;
> +}
> +
> +static void ldma_chan_irq_en(struct ldma_chan *c)
> +{
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&d->dev_lock, flags);
> +	writel(c->nr, d->base + DMA_CS);
> +	writel(DMA_CI_EOP, d->base + DMA_CIE);
> +	writel(BIT(c->nr), d->base + DMA_IRNEN);
> +	spin_unlock_irqrestore(&d->dev_lock, flags);
> +}
> +
> +static void dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	unsigned long flags;
> +
> +	if (d->ver =3D=3D DMA_VER22) {
> +		spin_lock_irqsave(&c->vchan.lock, flags);
> +		if (vchan_issue_pending(&c->vchan)) {
> +			struct virt_dma_desc *vdesc;
> +
> +			/* Get the next descriptor */
> +			vdesc =3D vchan_next_desc(&c->vchan);
> +			if (!vdesc) {
> +				c->ds =3D NULL;
> +				return;
> +			}
> +			list_del(&vdesc->node);
> +			c->ds =3D to_lgm_dma_desc(vdesc);

you have set c->ds in dma_prep_slave_sg and the only way I can see that
you will not leak memory is that the client must terminate_sync() after
each transfer so that the synchronize callback is invoked between each
prep_sg/issue_pending/competion.

> +			spin_unlock_irqrestore(&c->vchan.lock, flags);
> +			ldma_chan_desc_hw_cfg(c, c->ds->desc_phys, c->ds->desc_cnt);
> +			ldma_chan_irq_en(c);
> +		}

If there is nothing peding, you will leave the spinlock wide open...

> +	}
> +	ldma_chan_on(c);
> +}
> +
> +static void dma_synchronize(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +
> +	/*
> +	 * clear any pending work if any. In that
> +	 * case the resource needs to be free here.
> +	 */
> +	cancel_work_sync(&c->work);
> +	vchan_synchronize(&c->vchan);
> +	if (c->ds)
> +		dma_free_desc_resource(&c->ds->vdesc);
> +}
> +
> +static int dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&c->vchan.lock, flags);
> +	vchan_get_all_descriptors(&c->vchan, &head);
> +	spin_unlock_irqrestore(&c->vchan.lock, flags);
> +	vchan_dma_desc_free_list(&c->vchan, &head);
> +
> +	return ldma_chan_reset(c);
> +}
> +
> +static int dma_resume_chan(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +
> +	ldma_chan_on(c);
> +
> +	return 0;
> +}
> +
> +static int dma_pause_chan(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +
> +	return ldma_chan_off(c);
> +}
> +
> +static enum dma_status
> +dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> +	      struct dma_tx_state *txstate)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	enum dma_status status =3D DMA_COMPLETE;
> +
> +	if (d->ver =3D=3D DMA_VER22)
> +		status =3D dma_cookie_status(chan, cookie, txstate);
> +
> +	return status;
> +}
> +
> +static void dma_chan_irq(int irq, void *data)
> +{
> +	struct ldma_chan *c =3D data;
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	u32 stat;
> +
> +	/* Disable channel interrupts  */
> +	writel(c->nr, d->base + DMA_CS);
> +	stat =3D readl(d->base + DMA_CIS);
> +	if (!stat)
> +		return;
> +
> +	writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
> +	writel(stat, d->base + DMA_CIS);
> +	queue_work(d->wq, &c->work);
> +}
> +
> +static irqreturn_t dma_interrupt(int irq, void *dev_id)
> +{
> +	struct ldma_dev *d =3D dev_id;
> +	struct ldma_chan *c;
> +	unsigned long irncr;
> +	u32 cid;
> +
> +	irncr =3D readl(d->base + DMA_IRNCR);
> +	if (!irncr) {
> +		dev_err(d->dev, "dummy interrupt\n");
> +		return IRQ_NONE;
> +	}
> +
> +	for_each_set_bit(cid, &irncr, d->chan_nrs) {
> +		/* Mask */
> +		writel(readl(d->base + DMA_IRNEN) & ~BIT(cid), d->base + DMA_IRNEN);=

> +		/* Ack */
> +		writel(readl(d->base + DMA_IRNCR) | BIT(cid), d->base + DMA_IRNCR);
> +
> +		c =3D &d->chans[cid];
> +		dma_chan_irq(irq, c);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		  unsigned int sglen, enum dma_transfer_direction dir,
> +		  unsigned long flags, void *context)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	size_t len, avail, total =3D 0;
> +	struct dw2_desc *hw_ds;
> +	struct dw2_desc_sw *ds;
> +	struct scatterlist *sg;
> +	int num =3D sglen, i;
> +	dma_addr_t addr;
> +
> +	if (!sgl)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sglen, i) {
> +		avail =3D sg_dma_len(sg);
> +		if (avail > DMA_MAX_SIZE)
> +			num +=3D DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
> +	}
> +
> +	ds =3D dma_alloc_desc_resource(num, c);
> +	if (!ds)
> +		return NULL;
> +
> +	c->ds =3D ds;

If you still have a transfer running then you are going to get lost that
dscriptor?

> +
> +	num =3D 0;
> +	/* sop and eop has to be handled nicely */
> +	for_each_sg(sgl, sg, sglen, i) {
> +		addr =3D sg_dma_address(sg);
> +		avail =3D sg_dma_len(sg);
> +		total +=3D avail;
> +
> +		do {
> +			len =3D min_t(size_t, avail, DMA_MAX_SIZE);
> +
> +			hw_ds =3D &ds->desc_hw[num];
> +			switch (sglen) {
> +			case 1:
> +				hw_ds->status.field.sop =3D 1;
> +				hw_ds->status.field.eop =3D 1;
> +				break;
> +			default:
> +				if (num =3D=3D 0) {
> +					hw_ds->status.field.sop =3D 1;
> +					hw_ds->status.field.eop =3D 0;
> +				} else if (num =3D=3D (sglen - 1)) {
> +					hw_ds->status.field.sop =3D 0;
> +					hw_ds->status.field.eop =3D 1;
> +				} else {
> +					hw_ds->status.field.sop =3D 0;
> +					hw_ds->status.field.eop =3D 0;
> +				}
> +				break;
> +			}
> +
> +			/* Only 32 bit address supported */
> +			hw_ds->addr =3D (u32)addr;
> +			hw_ds->status.field.len =3D len;
> +			hw_ds->status.field.c =3D 0;
> +			hw_ds->status.field.bofs =3D addr & 0x3;
> +			/* Ensure data ready before ownership change */
> +			wmb();
> +			hw_ds->status.field.own =3D DMA_OWN;
> +			/* Ensure ownership changed before moving forward */
> +			wmb();
> +			num++;
> +			addr +=3D len;
> +			avail -=3D len;
> +		} while (avail);
> +	}
> +
> +	ds->size =3D total;
> +
> +	return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
> +}
> +
> +static int
> +dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	struct ldma_port *p =3D c->port;
> +	unsigned long flags;
> +	u32 bl;
> +
> +	if ((cfg->direction =3D=3D DMA_DEV_TO_MEM &&
> +	     cfg->src_addr_width !=3D DMA_SLAVE_BUSWIDTH_4_BYTES) ||
> +	    (cfg->direction =3D=3D DMA_MEM_TO_DEV &&
> +	     cfg->dst_addr_width !=3D DMA_SLAVE_BUSWIDTH_4_BYTES) ||

According to the probe function these width restrictions are only valid
for DMA_VER22?

> +	    !is_slave_direction(cfg->direction))
> +		return -EINVAL;
> +
> +	/* Default setting will be used */
> +	if (!cfg->src_maxburst && !cfg->dst_maxburst)
> +		return 0;

maxburst =3D=3D 0 is identical to maxburst =3D=3D 1, it is just not set
explicitly. Iow 1 word per DMA request.

> +
> +	/* Must be the same */
> +	if (cfg->src_maxburst && cfg->dst_maxburst &&
> +	    cfg->src_maxburst !=3D cfg->dst_maxburst)
> +		return -EINVAL;
> +
> +	if (cfg->dst_maxburst)
> +		cfg->src_maxburst =3D cfg->dst_maxburst;
> +
> +	bl =3D ilog2(cfg->src_maxburst);
> +
> +	spin_lock_irqsave(&d->dev_lock, flags);
> +	writel(p->portid, d->base + DMA_PS);
> +	ldma_update_bits(d, DMA_PCTRL_RXBL | DMA_PCTRL_TXBL,
> +			 FIELD_PREP(DMA_PCTRL_RXBL, bl) |
> +			 FIELD_PREP(DMA_PCTRL_TXBL, bl), DMA_PCTRL);
> +	spin_unlock_irqrestore(&d->dev_lock, flags);

What drivers usually do is to save the cfg and inprepare time take it
into account when setting up the transfer.
Write the change to the HW before the trasnfer is started (if it has
changed from previous settings)

Client drivers usually set the slave config ones, in most cases during
probe, so the slave config rarely changes runtime, but there are cases
for that.

> +
> +	return 0;
> +}
> +
> +static int dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +	struct device *dev =3D c->vchan.chan.device->dev;
> +	size_t	desc_sz;
> +
> +	if (d->ver > DMA_VER22) {
> +		c->flags |=3D CHAN_IN_USE;
> +		return 0;
> +	}
> +
> +	if (c->desc_pool)
> +		return c->desc_num;
> +
> +	desc_sz =3D c->desc_num * sizeof(struct dw2_desc);
> +	c->desc_pool =3D dma_pool_create(c->name, dev, desc_sz,
> +				       __alignof__(struct dw2_desc), 0);
> +
> +	if (!c->desc_pool) {
> +		dev_err(dev, "unable to allocate descriptor pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	return c->desc_num;
> +}
> +
> +static void dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct ldma_chan *c =3D to_ldma_chan(chan);
> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
> +
> +	if (d->ver =3D=3D DMA_VER22) {
> +		dma_pool_destroy(c->desc_pool);
> +		c->desc_pool =3D NULL;
> +		vchan_free_chan_resources(to_virt_chan(chan));
> +		ldma_chan_reset(c);
> +	} else {
> +		c->flags &=3D ~CHAN_IN_USE;
> +	}
> +}
> +
> +static void dma_work(struct work_struct *work)
> +{
> +	struct ldma_chan *c =3D container_of(work, struct ldma_chan, work);
> +	struct dma_async_tx_descriptor *tx =3D &c->ds->vdesc.tx;
> +	struct dmaengine_desc_callback cb;
> +
> +	dmaengine_desc_get_callback(tx, &cb);
> +	dma_cookie_complete(tx);
> +	dmaengine_desc_callback_invoke(&cb, NULL);

When you are going to free up the descriptor?

> +}
> +
> +int update_client_configs(struct of_dma *ofdma, struct of_phandle_args=
 *spec)
> +{
> +	struct ldma_dev *d =3D ofdma->of_dma_data;
> +	struct ldma_port *p;
> +	struct ldma_chan *c;
> +	u32 chan_id =3D  spec->args[0];
> +	u32 port_id =3D  spec->args[1];
> +
> +	if (chan_id >=3D d->chan_nrs || port_id >=3D d->port_nrs)
> +		return 0;
> +
> +	p =3D &d->ports[port_id];
> +	c =3D &d->chans[chan_id];
> +
> +	if (d->ver =3D=3D DMA_VER22) {
> +		u32 burst =3D spec->args[2];
> +
> +		if (burst !=3D 2 && burst !=3D 4 && burst !=3D 8)
> +			return 0;
> +
> +		/* TX and RX has the same burst length */
> +		p->txbl =3D ilog2(burst);
> +		p->rxbl =3D p->txbl;
> +
> +		ldma_port_cfg(p);
> +	} else {
> +		if (spec->args[2] > 0 && spec->args[2] <=3D DMA_ENDIAN_TYPE3) {
> +			c->data_endian =3D spec->args[2];
> +			c->data_endian_en =3D true;
> +		}
> +
> +		if (spec->args[3] > 0 && spec->args[3] <=3D DMA_ENDIAN_TYPE3) {
> +			c->desc_endian =3D spec->args[3];
> +			c->desc_endian_en =3D true;
> +		}
> +
> +		if (spec->args[4] > 0 && spec->args[4] < 128)
> +			c->boff_len =3D spec->args[4];
> +
> +		if (spec->args[5])
> +			c->desc_rx_np =3D true;
> +
> +		/*
> +		 * If channel packet drop enabled, port packet drop should
> +		 * be enabled
> +		 */
> +		if (spec->args[6]) {
> +			c->pden =3D true;
> +			p->pkt_drop =3D DMA_PKT_DROP_EN;
> +		}
> +		ldma_port_cfg(p);
> +		ldma_chan_cfg(c);
> +	}
> +
> +	return 1;
> +}
> +
> +static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
> +				   struct of_dma *ofdma)
> +{
> +	struct ldma_dev *d =3D ofdma->of_dma_data;
> +	u32 chan_id =3D  spec->args[0];
> +	int ret;
> +
> +	if (!spec->args_count)
> +		return NULL;
> +
> +	/* if args_count is 1 use driver default config settings */
> +	if (spec->args_count > 1) {
> +		ret =3D update_client_configs(ofdma, spec);
> +		if (!ret)
> +			return NULL;
> +	}
> +
> +	return dma_get_slave_channel(&d->chans[chan_id].vchan.chan);
> +}
> +
> +static void ldma_clk_disable(void *data)
> +{
> +	struct ldma_dev *d =3D data;
> +
> +	clk_disable_unprepare(d->core_clk);
> +}
> +
> +static struct dma_dev_ops dma0_ops =3D {
> +	.device_alloc_chan_resources =3D dma_alloc_chan_resources,
> +	.device_free_chan_resources =3D dma_free_chan_resources,
> +	.device_config =3D dma_slave_config,
> +	.device_prep_slave_sg =3D dma_prep_slave_sg,
> +	.device_tx_status =3D dma_tx_status,
> +	.device_pause =3D dma_pause_chan,
> +	.device_resume =3D dma_resume_chan,
> +	.device_terminate_all =3D dma_terminate_all,
> +	.device_synchronize =3D dma_synchronize,
> +	.device_issue_pending =3D dma_issue_pending,
> +};
> +
> +static struct dma_dev_ops hdma_ops =3D {
> +	.device_alloc_chan_resources =3D dma_alloc_chan_resources,
> +	.device_free_chan_resources =3D dma_free_chan_resources,
> +	.device_terminate_all =3D dma_terminate_all,
> +	.device_issue_pending =3D dma_issue_pending,
> +	.device_tx_status =3D dma_tx_status,
> +	.device_resume =3D dma_resume_chan,
> +	.device_pause =3D dma_pause_chan,
> +};
> +
> +static const struct ldma_inst_data dma0 =3D {
> +	.name =3D "dma0",
> +	.ops =3D &dma0_ops,
> +};
> +
> +static const struct ldma_inst_data dma2tx =3D {
> +	.name =3D "dma2tx",
> +	.type =3D DMA_TYPE_TX,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data dma1rx =3D {
> +	.name =3D "dma1rx",
> +	.type =3D DMA_TYPE_RX,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data dma1tx =3D {
> +	.name =3D "dma1tx",
> +	.type =3D DMA_TYPE_TX,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data dma0tx =3D {
> +	.name =3D "dma0tx",
> +	.type =3D DMA_TYPE_TX,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data dma3 =3D {
> +	.name =3D "dma3",
> +	.type =3D DMA_TYPE_MCPY,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data toe_dma30 =3D {
> +	.name =3D "toe_dma30",
> +	.type =3D DMA_TYPE_MCPY,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct ldma_inst_data toe_dma31 =3D {
> +	.name =3D "toe_dma31",
> +	.type =3D DMA_TYPE_MCPY,
> +	.ops =3D &hdma_ops,
> +};
> +
> +static const struct of_device_id intel_ldma_match[] =3D {
> +	{ .compatible =3D "intel,lgm-cdma", .data =3D &dma0},
> +	{ .compatible =3D "intel,lgm-dma2tx", .data =3D &dma2tx},
> +	{ .compatible =3D "intel,lgm-dma1rx", .data =3D &dma1rx},
> +	{ .compatible =3D "intel,lgm-dma1tx", .data =3D &dma1tx},
> +	{ .compatible =3D "intel,lgm-dma0tx", .data =3D &dma0tx},
> +	{ .compatible =3D "intel,lgm-dma3", .data =3D &dma3},
> +	{ .compatible =3D "intel,lgm-toe-dma30", .data =3D &toe_dma30},
> +	{ .compatible =3D "intel,lgm-toe-dma31", .data =3D &toe_dma31},
> +	{}
> +};
> +
> +static int intel_ldma_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct dma_device *dma_dev;
> +	struct ldma_chan *c;
> +	struct ldma_port *p;
> +	struct ldma_dev *d;
> +	u32 id, bitn =3D 32;
> +	int i, j, k, ret;
> +
> +	d =3D devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	/* Link controller to platform device */
> +	d->dev =3D &pdev->dev;
> +
> +	d->inst =3D device_get_match_data(dev);
> +	if (!d->inst) {
> +		dev_err(dev, "No device match found\n");
> +		return -ENODEV;
> +	}
> +
> +	d->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(d->base))
> +		return PTR_ERR(d->base);
> +
> +	/* Power up and reset the dma engine, some DMAs always on?? */
> +	d->core_clk =3D devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(d->core_clk))
> +		return PTR_ERR(d->core_clk);
> +	clk_prepare_enable(d->core_clk);
> +
> +	ret =3D devm_add_action_or_reset(dev, ldma_clk_disable, d);
> +	if (ret) {
> +		dev_err(dev, "Failed to devm_add_action_or_reset, %d\n", ret);
> +		return ret;
> +	}
> +
> +	d->rst =3D devm_reset_control_get_optional(dev, NULL);
> +	if (IS_ERR(d->rst))
> +		return PTR_ERR(d->rst);
> +	reset_control_deassert(d->rst);
> +
> +	id =3D readl(d->base + DMA_ID);
> +	d->chan_nrs =3D FIELD_GET(DMA_ID_CHNR, id);
> +	d->port_nrs =3D FIELD_GET(DMA_ID_PNR, id);
> +	d->ver =3D FIELD_GET(DMA_ID_REV, id);
> +
> +	if (id & DMA_ID_AW_36B)
> +		d->flags |=3D DMA_ADDR_36BIT;
> +
> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		if (id & DMA_ID_AW_36B)
> +			bitn =3D 36;
> +	}
> +
> +	if (id & DMA_ID_DW_128B)
> +		d->flags |=3D DMA_DATA_128BIT;
> +
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(bitn));
> +	if (ret) {
> +		dev_err(dev, "No usable DMA configuration\n");
> +		return ret;
> +	}
> +
> +	if (d->ver =3D=3D DMA_VER22) {
> +		d->irq =3D platform_get_irq(pdev, 0);
> +		if (d->irq < 0)
> +			return d->irq;
> +
> +		ret =3D devm_request_irq(&pdev->dev, d->irq, dma_interrupt,
> +				       0, DRIVER_NAME, d);
> +		if (ret)
> +			return ret;
> +
> +		d->wq =3D alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
> +						WQ_HIGHPRI);
> +		if (!d->wq)
> +			return -ENOMEM;
> +	}
> +
> +	dma_dev =3D &d->dma_dev;
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +
> +	/* Channel initializations */
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	/* Port Initializations */
> +	d->ports =3D devm_kcalloc(dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
> +	if (!d->ports)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < d->port_nrs; i++) {
> +		p =3D &d->ports[i];
> +		p->portid =3D i;
> +		p->ldev =3D d;
> +	}
> +
> +	ret =3D ldma_cfg_init(d);
> +	if (ret)
> +		return ret;
> +
> +	dma_dev->dev =3D &pdev->dev;
> +	/*
> +	 * Link channel id to channel index and link to dma channel list
> +	 * It also back points to controller and its port
> +	 */
> +	for (i =3D 0, k =3D 0; i < d->port_nrs; i++) {
> +		if (d->ver =3D=3D DMA_VER22) {
> +			u32 chan_end;
> +
> +			p =3D &d->ports[i];
> +			chan_end =3D p->chan_start + p->chan_sz;
> +			for (j =3D p->chan_start; j < chan_end; j++) {
> +				c =3D &d->chans[k];
> +				c->port =3D p;
> +				c->nr =3D j; /* Real channel number */
> +				c->rst =3D DMA_CHAN_RST;
> +				snprintf(c->name, sizeof(c->name), "chan%d",
> +					 c->nr);
> +				INIT_WORK(&c->work, dma_work);
> +				c->vchan.desc_free =3D dma_free_desc_resource;
> +				vchan_init(&c->vchan, dma_dev);
> +				k++;
> +			}
> +		} else {
> +			p =3D &d->ports[i];
> +			for (i =3D 0; i < d->chan_nrs; i++) {
> +				c =3D &d->chans[i];
> +				c->port =3D p;
> +				c->data_endian =3D DMA_DFT_ENDIAN;
> +				c->desc_endian =3D DMA_DFT_ENDIAN;
> +				c->data_endian_en =3D false;
> +				c->desc_endian_en =3D false;
> +				c->desc_rx_np =3D false;
> +				c->flags |=3D DEVICE_ALLOC_DESC;
> +				c->onoff =3D DMA_CH_OFF;
> +				c->rst =3D DMA_CHAN_RST;
> +				c->abc_en =3D true;
> +				c->nr =3D i;
> +				c->vchan.desc_free =3D dma_free_desc_resource;
> +				vchan_init(&c->vchan, dma_dev);
> +			}
> +		}
> +	}
> +
> +	/* Set DMA capabilities */
> +	dma_cap_zero(dma_dev->cap_mask);

You just cleared the DMA_SLAVE capability you set earlier...

> +
> +	dma_dev->device_alloc_chan_resources =3D
> +		d->inst->ops->device_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources =3D
> +		d->inst->ops->device_free_chan_resources;
> +	dma_dev->device_terminate_all =3D d->inst->ops->device_terminate_all;=

> +	dma_dev->device_issue_pending =3D d->inst->ops->device_issue_pending;=

> +	dma_dev->device_tx_status =3D d->inst->ops->device_tx_status;
> +	dma_dev->device_resume =3D d->inst->ops->device_resume;
> +	dma_dev->device_pause =3D d->inst->ops->device_pause;
> +	dma_dev->device_config =3D d->inst->ops->device_config;
> +	dma_dev->device_prep_slave_sg =3D d->inst->ops->device_prep_slave_sg;=

> +	dma_dev->device_synchronize =3D d->inst->ops->device_synchronize;
> +
> +	if (d->ver =3D=3D DMA_VER22) {
> +		dma_dev->src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +		dma_dev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +		dma_dev->directions =3D BIT(DMA_MEM_TO_DEV) |
> +				      BIT(DMA_DEV_TO_MEM);
> +		dma_dev->residue_granularity =3D
> +					DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	}

So, if version is !=3D DMA_VER22, then you don't support any direction?
Why register the DMA device if it can not do any transfer?

> +
> +	platform_set_drvdata(pdev, d);
> +
> +	ldma_dev_init(d);
> +
> +	ret =3D dma_async_device_register(dma_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register slave DMA engine device\n");
> +		return ret;
> +	}
> +
> +	ret =3D of_dma_controller_register(pdev->dev.of_node, ldma_xlate, d);=

> +	if (ret) {
> +		dev_err(dev, "Failed to register of DMA controller\n");
> +		dma_async_device_unregister(dma_dev);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Init done - rev: %x, ports: %d channels: %d\n", d->ver=
,
> +		 d->port_nrs, d->chan_nrs);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver intel_ldma_driver =3D {
> +	.probe =3D intel_ldma_probe,
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.of_match_table =3D intel_ldma_match,
> +	},
> +};
> +
> +static int __init intel_ldma_init(void)
> +{
> +	return platform_driver_register(&intel_ldma_driver);
> +}
> +
> +device_initcall(intel_ldma_init);
> diff --git a/include/linux/dma/lgm_dma.h b/include/linux/dma/lgm_dma.h
> new file mode 100644
> index 000000000000..3a2ee6ad0710
> --- /dev/null
> +++ b/include/linux/dma/lgm_dma.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016 ~ 2019 Intel Corporation.
> + */
> +#ifndef LGM_DMA_H
> +#define LGM_DMA_H
> +
> +#include <linux/types.h>
> +#include <linux/dmaengine.h>
> +
> +/*!
> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t d=
esc_base,
> + *                                 int desc_num)
> + * \brief Configure low level channel descriptors
> + * \param[in] chan   pointer to DMA channel that the client is using
> + * \param[in] desc_base   descriptor base physical address
> + * \param[in] desc_num   number of descriptors
> + * \return   0 on success
> + * \return   kernel bug reported on failure
> + *
> + * This function configure the low level channel descriptors. It will =
be
> + * used by CBM whose descriptor is not DDR, actually some registers.
> + */
> +int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_bas=
e,
> +			    int desc_num);
> +
> +#endif /* LGM_DMA_H */
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

