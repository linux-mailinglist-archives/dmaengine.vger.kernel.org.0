Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D11254729
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH0OmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 10:42:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:30837 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgH0OmN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Aug 2020 10:42:13 -0400
IronPort-SDR: g0B/lrO8XC4nUCF7L9r/BMB+8UWKKd7lu586ARFS+s7IWtsR9MVxWy6uVq+BexJort/bgxkFMu
 y2pRHgtd+8dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="157517387"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="157517387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 07:42:04 -0700
IronPort-SDR: TSK2eamrWixdw/WnI2sTYgtS40Fv1KZDmH+JKzBEDuGQZVrH5smMBqrCOmJv6Z+09dDv4tfVo2
 8XZ2hb6+G7sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="280650437"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2020 07:42:03 -0700
Received: from [10.249.72.63] (mreddy3x-MOBL.gar.corp.intel.com [10.249.72.63])
        by linux.intel.com (Postfix) with ESMTP id 2E9D75805ED;
        Thu, 27 Aug 2020 07:41:59 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, malliamireddy009@gmail.com
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
 <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
 <3aea19e6-de96-12ba-495c-94b3b313074d@ti.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <51ed096a-d211-9bab-bf1e-44f912b2a20e@linux.intel.com>
Date:   Thu, 27 Aug 2020 22:41:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3aea19e6-de96-12ba-495c-94b3b313074d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,
Thank you very much for the review and detailed explanation, i will take 
the inputs and update in the next patch.
My comments inline..

On 8/24/2020 7:24 PM, Peter Ujfalusi wrote:
> Hi,
>
> On 24/08/2020 5.30, Reddy, MallikarjunaX wrote:
>
>>>> +static void dma_free_desc_resource(struct virt_dma_desc *vdesc)
>>>> +{
>>>> +    struct dw2_desc_sw *ds = to_lgm_dma_desc(vdesc);
>>>> +    struct ldma_chan *c = ds->chan;
>>>> +
>>>> +    dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc_phys);
>>>> +    kfree(ds);
>>>> +    c->ds = NULL;
>>> Is there a chance that c->ds != ds?
>> No, from the code i don't see any such scenario, let me know if you find
>> any corner case.
> The desc_free callback is used to _free_ up the memory used for the
> descriptor. Nothing less, nothing more.
> You should not touch the c->ds in this callback, just free up the memory
> used for the given vdesc.
>
> More on that a bit later.
Ok.
>
>>>> +}
>>>> +
>>>> +static struct dw2_desc_sw *
>>>> +dma_alloc_desc_resource(int num, struct ldma_chan *c)
>>>> +{
>>>> +    struct device *dev = c->vchan.chan.device->dev;
>>>> +    struct dw2_desc_sw *ds;
>>>> +
>>>> +    if (num > c->desc_num) {
>>>> +        dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_num);
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
>>>> +    if (!ds)
>>>> +        return NULL;
>>>> +
>>>> +    ds->chan = c;
>>>> +
>>>> +    ds->desc_hw = dma_pool_zalloc(c->desc_pool, GFP_ATOMIC,
>>>> +                      &ds->desc_phys);
>>>> +    if (!ds->desc_hw) {
>>>> +        dev_dbg(dev, "out of memory for link descriptor\n");
>>>> +        kfree(ds);
>>>> +        return NULL;
>>>> +    }
>>>> +    ds->desc_cnt = num;
>>>> +
>>>> +    return ds;
>>>> +}
>>>> +
>>>> +static void ldma_chan_irq_en(struct ldma_chan *c)
>>>> +{
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    unsigned long flags;
>>>> +
>>>> +    spin_lock_irqsave(&d->dev_lock, flags);
>>>> +    writel(c->nr, d->base + DMA_CS);
>>>> +    writel(DMA_CI_EOP, d->base + DMA_CIE);
>>>> +    writel(BIT(c->nr), d->base + DMA_IRNEN);
>>>> +    spin_unlock_irqrestore(&d->dev_lock, flags);
>>>> +}
>>>> +
>>>> +static void dma_issue_pending(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    unsigned long flags;
>>>> +
>>>> +    if (d->ver == DMA_VER22) {
>>>> +        spin_lock_irqsave(&c->vchan.lock, flags);
>>>> +        if (vchan_issue_pending(&c->vchan)) {
>>>> +            struct virt_dma_desc *vdesc;
>>>> +
>>>> +            /* Get the next descriptor */
>>>> +            vdesc = vchan_next_desc(&c->vchan);
>>>> +            if (!vdesc) {
>>>> +                c->ds = NULL;
>>>> +                return;
>>>> +            }
>>>> +            list_del(&vdesc->node);
>>>> +            c->ds = to_lgm_dma_desc(vdesc);
>>> you have set c->ds in dma_prep_slave_sg and the only way I can see that
>>> you will not leak memory is that the client must terminate_sync() after
>>> each transfer so that the synchronize callback is invoked between each
>>> prep_sg/issue_pending/competion.
>> Yes, client must call dmaengine_synchronize after each transfer to make
>> sure free the memory assoicated with previously issued descriptors if any.
> No, client should not need to invoke synchronize between transfers,
> clients must be able to do:
> dmaengine_prep_slave_single/dmaengine_prep_slave_sg
> dma_async_issue_pending
> * handle the callback
> dmaengine_prep_slave_single/dmaengine_prep_slave_sg
> dma_async_issue_pending
> * handle the callback
>
> without any terminate_all_sync() in between.
> Imagine that the client is preparing/issuing a new transfer in the
> completion callback for example.
>
> Clients must be able to do also:
> dmaengine_prep_slave_single/dmaengine_prep_slave_sg
> dmaengine_prep_slave_single/dmaengine_prep_slave_sg
> ...
> dmaengine_prep_slave_single/dmaengine_prep_slave_sg
> dma_async_issue_pending
>
> and then the DMA will complete the transfers in FIFO order and when the
> first is completed it will move to the next one. Client will receive
> callbacks for each completion (if requested).
Thanks for the detailed explanation peter.
>
>> and also from the driver we are freeing up the descriptor from work
>> queue atfer each transfer.(addressed below comments **)
>>>> +            spin_unlock_irqrestore(&c->vchan.lock, flags);
>>>> +            ldma_chan_desc_hw_cfg(c, c->ds->desc_phys,
>>>> c->ds->desc_cnt);
>>>> +            ldma_chan_irq_en(c);
>>>> +        }
>>> If there is nothing peding, you will leave the spinlock wide open...
>> Seems i misplaced the lock. i will fix it in next version.
>>>> +    }
>>>> +    ldma_chan_on(c);
>>>> +}
>>>> +
>>>> +static void dma_synchronize(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +
>>>> +    /*
>>>> +     * clear any pending work if any. In that
>>>> +     * case the resource needs to be free here.
>>>> +     */
>>>> +    cancel_work_sync(&c->work);
>>>> +    vchan_synchronize(&c->vchan);
>>>> +    if (c->ds)
>>>> +        dma_free_desc_resource(&c->ds->vdesc);
>>>> +}
>>>> +
>>>> +static int dma_terminate_all(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    unsigned long flags;
>>>> +    LIST_HEAD(head);
>>>> +
>>>> +    spin_lock_irqsave(&c->vchan.lock, flags);
>>>> +    vchan_get_all_descriptors(&c->vchan, &head);
>>>> +    spin_unlock_irqrestore(&c->vchan.lock, flags);
>>>> +    vchan_dma_desc_free_list(&c->vchan, &head);
>>>> +
>>>> +    return ldma_chan_reset(c);
>>>> +}
>>>> +
>>>> +static int dma_resume_chan(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +
>>>> +    ldma_chan_on(c);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int dma_pause_chan(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +
>>>> +    return ldma_chan_off(c);
>>>> +}
>>>> +
>>>> +static enum dma_status
>>>> +dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>>>> +          struct dma_tx_state *txstate)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    enum dma_status status = DMA_COMPLETE;
>>>> +
>>>> +    if (d->ver == DMA_VER22)
>>>> +        status = dma_cookie_status(chan, cookie, txstate);
>>>> +
>>>> +    return status;
>>>> +}
>>>> +
>>>> +static void dma_chan_irq(int irq, void *data)
>>>> +{
>>>> +    struct ldma_chan *c = data;
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    u32 stat;
>>>> +
>>>> +    /* Disable channel interrupts  */
>>>> +    writel(c->nr, d->base + DMA_CS);
>>>> +    stat = readl(d->base + DMA_CIS);
>>>> +    if (!stat)
>>>> +        return;
>>>> +
>>>> +    writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
>>>> +    writel(stat, d->base + DMA_CIS);
>>>> +    queue_work(d->wq, &c->work);
>>>> +}
>>>> +
>>>> +static irqreturn_t dma_interrupt(int irq, void *dev_id)
>>>> +{
>>>> +    struct ldma_dev *d = dev_id;
>>>> +    struct ldma_chan *c;
>>>> +    unsigned long irncr;
>>>> +    u32 cid;
>>>> +
>>>> +    irncr = readl(d->base + DMA_IRNCR);
>>>> +    if (!irncr) {
>>>> +        dev_err(d->dev, "dummy interrupt\n");
>>>> +        return IRQ_NONE;
>>>> +    }
>>>> +
>>>> +    for_each_set_bit(cid, &irncr, d->chan_nrs) {
>>>> +        /* Mask */
>>>> +        writel(readl(d->base + DMA_IRNEN) & ~BIT(cid), d->base +
>>>> DMA_IRNEN);
>>>> +        /* Ack */
>>>> +        writel(readl(d->base + DMA_IRNCR) | BIT(cid), d->base +
>>>> DMA_IRNCR);
>>>> +
>>>> +        c = &d->chans[cid];
>>>> +        dma_chan_irq(irq, c);
>>>> +    }
>>>> +
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static struct dma_async_tx_descriptor *
>>>> +dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>>> +          unsigned int sglen, enum dma_transfer_direction dir,
>>>> +          unsigned long flags, void *context)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    size_t len, avail, total = 0;
>>>> +    struct dw2_desc *hw_ds;
>>>> +    struct dw2_desc_sw *ds;
>>>> +    struct scatterlist *sg;
>>>> +    int num = sglen, i;
>>>> +    dma_addr_t addr;
>>>> +
>>>> +    if (!sgl)
>>>> +        return NULL;
>>>> +
>>>> +    for_each_sg(sgl, sg, sglen, i) {
>>>> +        avail = sg_dma_len(sg);
>>>> +        if (avail > DMA_MAX_SIZE)
>>>> +            num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
>>>> +    }
>>>> +
>>>> +    ds = dma_alloc_desc_resource(num, c);
>>>> +    if (!ds)
>>>> +        return NULL;
>>>> +
>>>> +    c->ds = ds;
>>> If you still have a transfer running then you are going to get lost that
>>> dscriptor?
>> No, please let me know if you find any such corner case.
> This is the place when you prepare the descriptor, but it is not yet
> commited to the hardware. Client might never call issue_pending, client
> might prepare another transfer before telling the DMA driver to start
> the transfers.
ok
>
>>>> +
>>>> +    num = 0;
>>>> +    /* sop and eop has to be handled nicely */
>>>> +    for_each_sg(sgl, sg, sglen, i) {
>>>> +        addr = sg_dma_address(sg);
>>>> +        avail = sg_dma_len(sg);
>>>> +        total += avail;
>>>> +
>>>> +        do {
>>>> +            len = min_t(size_t, avail, DMA_MAX_SIZE);
>>>> +
>>>> +            hw_ds = &ds->desc_hw[num];
>>>> +            switch (sglen) {
>>>> +            case 1:
>>>> +                hw_ds->status.field.sop = 1;
>>>> +                hw_ds->status.field.eop = 1;
>>>> +                break;
>>>> +            default:
>>>> +                if (num == 0) {
>>>> +                    hw_ds->status.field.sop = 1;
>>>> +                    hw_ds->status.field.eop = 0;
>>>> +                } else if (num == (sglen - 1)) {
>>>> +                    hw_ds->status.field.sop = 0;
>>>> +                    hw_ds->status.field.eop = 1;
>>>> +                } else {
>>>> +                    hw_ds->status.field.sop = 0;
>>>> +                    hw_ds->status.field.eop = 0;
>>>> +                }
>>>> +                break;
>>>> +            }
>>>> +
>>>> +            /* Only 32 bit address supported */
>>>> +            hw_ds->addr = (u32)addr;
>>>> +            hw_ds->status.field.len = len;
>>>> +            hw_ds->status.field.c = 0;
>>>> +            hw_ds->status.field.bofs = addr & 0x3;
>>>> +            /* Ensure data ready before ownership change */
>>>> +            wmb();
>>>> +            hw_ds->status.field.own = DMA_OWN;
>>>> +            /* Ensure ownership changed before moving forward */
>>>> +            wmb();
>>>> +            num++;
>>>> +            addr += len;
>>>> +            avail -= len;
>>>> +        } while (avail);
>>>> +    }
>>>> +
>>>> +    ds->size = total;
>>>> +
>>>> +    return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
>>>> +}
>>>> +
>>>> +static int
>>>> +dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    struct ldma_port *p = c->port;
>>>> +    unsigned long flags;
>>>> +    u32 bl;
>>>> +
>>>> +    if ((cfg->direction == DMA_DEV_TO_MEM &&
>>>> +         cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>>>> +        (cfg->direction == DMA_MEM_TO_DEV &&
>>>> +         cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>>> According to the probe function these width restrictions are only valid
>>> for DMA_VER22?
>> YES
> Right, hdma_ops does not have device_config specified.
>
>>>> +        !is_slave_direction(cfg->direction))
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Default setting will be used */
>>>> +    if (!cfg->src_maxburst && !cfg->dst_maxburst)
>>>> +        return 0;
>>> maxburst == 0 is identical to maxburst == 1, it is just not set
>>> explicitly. Iow 1 word per DMA request.
>> This is not clear to me. Can you elaborate?
> You handle the *_maxburst == 1 and *maxburst == 0 differently while they
> are the same thing.
ok, got it. i will fix it in next version.
>
>>>> +
>>>> +    /* Must be the same */
>>>> +    if (cfg->src_maxburst && cfg->dst_maxburst &&
>>>> +        cfg->src_maxburst != cfg->dst_maxburst)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (cfg->dst_maxburst)
>>>> +        cfg->src_maxburst = cfg->dst_maxburst;
>>>> +
>>>> +    bl = ilog2(cfg->src_maxburst);
>>>> +
>>>> +    spin_lock_irqsave(&d->dev_lock, flags);
>>>> +    writel(p->portid, d->base + DMA_PS);
>>>> +    ldma_update_bits(d, DMA_PCTRL_RXBL | DMA_PCTRL_TXBL,
>>>> +             FIELD_PREP(DMA_PCTRL_RXBL, bl) |
>>>> +             FIELD_PREP(DMA_PCTRL_TXBL, bl), DMA_PCTRL);
>>>> +    spin_unlock_irqrestore(&d->dev_lock, flags);
>>> What drivers usually do is to save the cfg and inprepare time take it
>>> into account when setting up the transfer.
>>> Write the change to the HW before the trasnfer is started (if it has
>>> changed from previous settings)
>>>
>>> Client drivers usually set the slave config ones, in most cases during
>>> probe, so the slave config rarely changes runtime, but there are cases
>>> for that.
>> Ok, got it. i will update in the next version.
> Thanks
>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int dma_alloc_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +    struct device *dev = c->vchan.chan.device->dev;
>>>> +    size_t    desc_sz;
>>>> +
>>>> +    if (d->ver > DMA_VER22) {
>>>> +        c->flags |= CHAN_IN_USE;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (c->desc_pool)
>>>> +        return c->desc_num;
>>>> +
>>>> +    desc_sz = c->desc_num * sizeof(struct dw2_desc);
>>>> +    c->desc_pool = dma_pool_create(c->name, dev, desc_sz,
>>>> +                       __alignof__(struct dw2_desc), 0);
>>>> +
>>>> +    if (!c->desc_pool) {
>>>> +        dev_err(dev, "unable to allocate descriptor pool\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    return c->desc_num;
>>>> +}
>>>> +
>>>> +static void dma_free_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +    struct ldma_chan *c = to_ldma_chan(chan);
>>>> +    struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
>>>> +
>>>> +    if (d->ver == DMA_VER22) {
>>>> +        dma_pool_destroy(c->desc_pool);
>>>> +        c->desc_pool = NULL;
>>>> +        vchan_free_chan_resources(to_virt_chan(chan));
>>>> +        ldma_chan_reset(c);
>>>> +    } else {
>>>> +        c->flags &= ~CHAN_IN_USE;
>>>> +    }
>>>> +}
>>>> +
>>>> +static void dma_work(struct work_struct *work)
>>>> +{
>>>> +    struct ldma_chan *c = container_of(work, struct ldma_chan, work);
>>>> +    struct dma_async_tx_descriptor *tx = &c->ds->vdesc.tx;
>>>> +    struct dmaengine_desc_callback cb;
>>>> +
>>>> +    dmaengine_desc_get_callback(tx, &cb);
>>>> +    dma_cookie_complete(tx);
>>>> +    dmaengine_desc_callback_invoke(&cb, NULL);
>>> When you are going to free up the descriptor?
>> **
>> Seems i missed free up the descriptor here. i will fix and update in the
>> next version.
> This is the place when you can do c->ds = NULL and you should also look
> for entries in the issued list to pick up any issued but not commited
> transfers.
>
> Let's say the client issued two transfers, in issue_pending you have
> started the first one.
> Now that is completed, you let the client know about it (you can free up
> the descritor as well safely) and then you pick up the next one from the
> issued list and start that.
> If there is nothing pending then c->ds would be NULL, if there were
> pending transfer, you will set c->ds to the next transfer.
> c->ds indicates that there is a transfer in progress by the HW.
Thanks peter. I will take your inputs and address the not committed 
transfers in the next patch.
>
>>>> +
>>>> +    dma_dev->device_alloc_chan_resources =
>>>> +        d->inst->ops->device_alloc_chan_resources;
>>>> +    dma_dev->device_free_chan_resources =
>>>> +        d->inst->ops->device_free_chan_resources;
>>>> +    dma_dev->device_terminate_all = d->inst->ops->device_terminate_all;
>>>> +    dma_dev->device_issue_pending = d->inst->ops->device_issue_pending;
>>>> +    dma_dev->device_tx_status = d->inst->ops->device_tx_status;
>>>> +    dma_dev->device_resume = d->inst->ops->device_resume;
>>>> +    dma_dev->device_pause = d->inst->ops->device_pause;
>>>> +    dma_dev->device_config = d->inst->ops->device_config;
>>>> +    dma_dev->device_prep_slave_sg = d->inst->ops->device_prep_slave_sg;
>>>> +    dma_dev->device_synchronize = d->inst->ops->device_synchronize;
>>>> +
>>>> +    if (d->ver == DMA_VER22) {
>>>> +        dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>> +        dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>> +        dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
>>>> +                      BIT(DMA_DEV_TO_MEM);
>>>> +        dma_dev->residue_granularity =
>>>> +                    DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>>>> +    }
>>> So, if version is != DMA_VER22, then you don't support any direction?
>>> Why register the DMA device if it can not do any transfer?
>> Only dma0 instance (intel,lgm-cdma) is used as a general purpose slave
>> DMA. we set both control and datapath here.
>> Other instances we set only control path. data path is taken care by dma
>> client(GSWIP).
> How the client (GSWIP) can request a channel from intel,lgm-* ? Don't
> you need some capabilities for the DMA device so core can sort out the
> request?
client request channel by name, dma_request_slave_channel(dev, name);
>
>> Only thing needs to do is get the channel, set the descriptor and just
>> on the channel.
> How do you 'on' the channel?
we on the channel in issue_pending.
>
>>>> +
>>>> +    platform_set_drvdata(pdev, d);
>>>> +
>>>> +    ldma_dev_init(d);
>>>> +
>>>> +    ret = dma_async_device_register(dma_dev);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Failed to register slave DMA engine device\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = of_dma_controller_register(pdev->dev.of_node, ldma_xlate, d);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Failed to register of DMA controller\n");
>>>> +        dma_async_device_unregister(dma_dev);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    dev_info(dev, "Init done - rev: %x, ports: %d channels: %d\n",
>>>> d->ver,
>>>> +         d->port_nrs, d->chan_nrs);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver intel_ldma_driver = {
>>>> +    .probe = intel_ldma_probe,
>>>> +    .driver = {
>>>> +        .name = DRIVER_NAME,
>>>> +        .of_match_table = intel_ldma_match,
>>>> +    },
>>>> +};
>>>> +
>>>> +static int __init intel_ldma_init(void)
>>>> +{
>>>> +    return platform_driver_register(&intel_ldma_driver);
>>>> +}
>>>> +
>>>> +device_initcall(intel_ldma_init);
>>>> diff --git a/include/linux/dma/lgm_dma.h b/include/linux/dma/lgm_dma.h
>>>> new file mode 100644
>>>> index 000000000000..3a2ee6ad0710
>>>> --- /dev/null
>>>> +++ b/include/linux/dma/lgm_dma.h
>>>> @@ -0,0 +1,27 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (c) 2016 ~ 2019 Intel Corporation.
>>>> + */
>>>> +#ifndef LGM_DMA_H
>>>> +#define LGM_DMA_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/dmaengine.h>
>>>> +
>>>> +/*!
>>>> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t
>>>> desc_base,
>>>> + *                                 int desc_num)
>>>> + * \brief Configure low level channel descriptors
>>>> + * \param[in] chan   pointer to DMA channel that the client is using
>>>> + * \param[in] desc_base   descriptor base physical address
>>>> + * \param[in] desc_num   number of descriptors
>>>> + * \return   0 on success
>>>> + * \return   kernel bug reported on failure
>>>> + *
>>>> + * This function configure the low level channel descriptors. It
>>>> will be
>>>> + * used by CBM whose descriptor is not DDR, actually some registers.
>>>> + */
>>>> +int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t
>>>> desc_base,
>>>> +                int desc_num);
>>>> +
>>>> +#endif /* LGM_DMA_H */
>>>>
>>> - Péter
>>>
>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
