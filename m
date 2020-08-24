Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90024FC73
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXLWk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 07:22:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40050 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHXLWf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Aug 2020 07:22:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OBMT26010265;
        Mon, 24 Aug 2020 06:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598268149;
        bh=07e3w5KW/4HH8Wli20NVRSK7c3CpiwpGnArVP2dyp7o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nt5Lyj8xlKiZdssOPqfQT1XwKT+lSPzOeu7/gy2WgEE6pAr8By2S37w9FJXLVaNJR
         a5cdPaRQ9ZRgNhDgyQF59MTuWQGwLnKZnLfGWGXjkwjMn4hlO4rEl8cGmcAWfUQZDJ
         gf5UVCrWK18UZNJyaCn9bzgkT/YJdAzSHYg279Ao=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07OBMTZx056266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 06:22:29 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 06:22:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 06:22:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBMQkZ119913;
        Mon, 24 Aug 2020 06:22:26 -0500
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>,
        <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>,
        <chuanhua.lei@linux.intel.com>, <malliamireddy009@gmail.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
 <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <3aea19e6-de96-12ba-495c-94b3b313074d@ti.com>
Date:   Mon, 24 Aug 2020 14:24:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 24/08/2020 5.30, Reddy, MallikarjunaX wrote:

>>> +static void dma_free_desc_resource(struct virt_dma_desc *vdesc)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct dw2_desc_sw *ds =3D to_lgm_dma_desc(vdesc)=
;
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D ds->chan;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc=
_phys);
>>> +=C2=A0=C2=A0=C2=A0 kfree(ds);
>>> +=C2=A0=C2=A0=C2=A0 c->ds =3D NULL;
>> Is there a chance that c->ds !=3D ds?
> No, from the code i don't see any such scenario, let me know if you fin=
d
> any corner case.

The desc_free callback is used to _free_ up the memory used for the
descriptor. Nothing less, nothing more.
You should not touch the c->ds in this callback, just free up the memory
used for the given vdesc.

More on that a bit later.

>>> +}
>>> +
>>> +static struct dw2_desc_sw *
>>> +dma_alloc_desc_resource(int num, struct ldma_chan *c)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D c->vchan.chan.device->dev;=

>>> +=C2=A0=C2=A0=C2=A0 struct dw2_desc_sw *ds;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (num > c->desc_num) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "sg num %d e=
xceed max %d\n", num, c->desc_num);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ds =3D kzalloc(sizeof(*ds), GFP_NOWAIT);
>>> +=C2=A0=C2=A0=C2=A0 if (!ds)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ds->chan =3D c;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ds->desc_hw =3D dma_pool_zalloc(c->desc_pool, GFP=
_ATOMIC,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ds->desc_phys)=
;
>>> +=C2=A0=C2=A0=C2=A0 if (!ds->desc_hw) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "out of memo=
ry for link descriptor\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(ds);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 ds->desc_cnt =3D num;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ds;
>>> +}
>>> +
>>> +static void ldma_chan_irq_en(struct ldma_chan *c)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&d->dev_lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 writel(c->nr, d->base + DMA_CS);
>>> +=C2=A0=C2=A0=C2=A0 writel(DMA_CI_EOP, d->base + DMA_CIE);
>>> +=C2=A0=C2=A0=C2=A0 writel(BIT(c->nr), d->base + DMA_IRNEN);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&d->dev_lock, flags);
>>> +}
>>> +
>>> +static void dma_issue_pending(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (d->ver =3D=3D DMA_VER22) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&c->vch=
an.lock, flags);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vchan_issue_pending(&=
c->vchan)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct virt_dma_desc *vdesc;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Get the next descriptor */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
desc =3D vchan_next_desc(&c->vchan);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!vdesc) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 c->ds =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ist_del(&vdesc->node);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
->ds =3D to_lgm_dma_desc(vdesc);
>> you have set c->ds in dma_prep_slave_sg and the only way I can see tha=
t
>> you will not leak memory is that the client must terminate_sync() afte=
r
>> each transfer so that the synchronize callback is invoked between each=

>> prep_sg/issue_pending/competion.
> Yes, client must call dmaengine_synchronize after each transfer to make=

> sure free the memory assoicated with previously issued descriptors if a=
ny.

No, client should not need to invoke synchronize between transfers,
clients must be able to do:
dmaengine_prep_slave_single/dmaengine_prep_slave_sg
dma_async_issue_pending
* handle the callback
dmaengine_prep_slave_single/dmaengine_prep_slave_sg
dma_async_issue_pending
* handle the callback

without any terminate_all_sync() in between.
Imagine that the client is preparing/issuing a new transfer in the
completion callback for example.

Clients must be able to do also:
dmaengine_prep_slave_single/dmaengine_prep_slave_sg
dmaengine_prep_slave_single/dmaengine_prep_slave_sg
=2E..
dmaengine_prep_slave_single/dmaengine_prep_slave_sg
dma_async_issue_pending

and then the DMA will complete the transfers in FIFO order and when the
first is completed it will move to the next one. Client will receive
callbacks for each completion (if requested).

> and also from the driver we are freeing up the descriptor from work
> queue atfer each transfer.(addressed below comments **)
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
pin_unlock_irqrestore(&c->vchan.lock, flags);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
dma_chan_desc_hw_cfg(c, c->ds->desc_phys,
>>> c->ds->desc_cnt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
dma_chan_irq_en(c);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> If there is nothing peding, you will leave the spinlock wide open...
> Seems i misplaced the lock. i will fix it in next version.
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 ldma_chan_on(c);
>>> +}
>>> +
>>> +static void dma_synchronize(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * clear any pending work if any. In that
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * case the resource needs to be free here.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 cancel_work_sync(&c->work);
>>> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&c->vchan);
>>> +=C2=A0=C2=A0=C2=A0 if (c->ds)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_free_desc_resource(&c=
->ds->vdesc);
>>> +}
>>> +
>>> +static int dma_terminate_all(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +=C2=A0=C2=A0=C2=A0 LIST_HEAD(head);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&c->vchan.lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 vchan_get_all_descriptors(&c->vchan, &head);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&c->vchan.lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 vchan_dma_desc_free_list(&c->vchan, &head);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ldma_chan_reset(c);
>>> +}
>>> +
>>> +static int dma_resume_chan(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ldma_chan_on(c);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int dma_pause_chan(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ldma_chan_off(c);
>>> +}
>>> +
>>> +static enum dma_status
>>> +dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_tx=
_state *txstate)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 enum dma_status status =3D DMA_COMPLETE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (d->ver =3D=3D DMA_VER22)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D dma_cookie_sta=
tus(chan, cookie, txstate);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return status;
>>> +}
>>> +
>>> +static void dma_chan_irq(int irq, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D data;
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 u32 stat;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Disable channel interrupts=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 writel(c->nr, d->base + DMA_CS);
>>> +=C2=A0=C2=A0=C2=A0 stat =3D readl(d->base + DMA_CIS);
>>> +=C2=A0=C2=A0=C2=A0 if (!stat)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d-=
>base + DMA_CIE);
>>> +=C2=A0=C2=A0=C2=A0 writel(stat, d->base + DMA_CIS);
>>> +=C2=A0=C2=A0=C2=A0 queue_work(d->wq, &c->work);
>>> +}
>>> +
>>> +static irqreturn_t dma_interrupt(int irq, void *dev_id)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D dev_id;
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long irncr;
>>> +=C2=A0=C2=A0=C2=A0 u32 cid;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 irncr =3D readl(d->base + DMA_IRNCR);
>>> +=C2=A0=C2=A0=C2=A0 if (!irncr) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(d->dev, "dummy in=
terrupt\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_NONE;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for_each_set_bit(cid, &irncr, d->chan_nrs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Mask */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(readl(d->base + DM=
A_IRNEN) & ~BIT(cid), d->base +
>>> DMA_IRNEN);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ack */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(readl(d->base + DM=
A_IRNCR) | BIT(cid), d->base +
>>> DMA_IRNCR);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D &d->chans[cid];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_chan_irq(irq, c);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
>>> +}
>>> +
>>> +static struct dma_async_tx_descriptor *
>>> +dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int =
sglen, enum dma_transfer_direction dir,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=
 flags, void *context)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 size_t len, avail, total =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 struct dw2_desc *hw_ds;
>>> +=C2=A0=C2=A0=C2=A0 struct dw2_desc_sw *ds;
>>> +=C2=A0=C2=A0=C2=A0 struct scatterlist *sg;
>>> +=C2=A0=C2=A0=C2=A0 int num =3D sglen, i;
>>> +=C2=A0=C2=A0=C2=A0 dma_addr_t addr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!sgl)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for_each_sg(sgl, sg, sglen, i) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D sg_dma_len(sg);=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail > DMA_MAX_SIZE)=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
um +=3D DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ds =3D dma_alloc_desc_resource(num, c);
>>> +=C2=A0=C2=A0=C2=A0 if (!ds)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 c->ds =3D ds;
>> If you still have a transfer running then you are going to get lost th=
at
>> dscriptor?
> No, please let me know if you find any such corner case.

This is the place when you prepare the descriptor, but it is not yet
commited to the hardware. Client might never call issue_pending, client
might prepare another transfer before telling the DMA driver to start
the transfers.

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 num =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 /* sop and eop has to be handled nicely */
>>> +=C2=A0=C2=A0=C2=A0 for_each_sg(sgl, sg, sglen, i) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D sg_dma_address(s=
g);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail =3D sg_dma_len(sg);=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total +=3D avail;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
en =3D min_t(size_t, avail, DMA_MAX_SIZE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds =3D &ds->desc_hw[num];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
witch (sglen) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ase 1:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.sop =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.eop =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
efault:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (num =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.sop =3D=
 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.eop =3D=
 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (num =3D=3D (sglen - 1)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.sop =3D=
 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.eop =3D=
 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.sop =3D=
 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw_ds->status.field.eop =3D=
 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=

>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Only 32 bit address supported */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds->addr =3D (u32)addr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds->status.field.len =3D len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds->status.field.c =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds->status.field.bofs =3D addr & 0x3;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Ensure data ready before ownership change */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
mb();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
w_ds->status.field.own =3D DMA_OWN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Ensure ownership changed before moving forward */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
mb();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
um++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ddr +=3D len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
vail -=3D len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (avail);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ds->size =3D total;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_C=
TRL_ACK);
>>> +}
>>> +
>>> +static int
>>> +dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg=
)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_port *p =3D c->port;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +=C2=A0=C2=A0=C2=A0 u32 bl;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if ((cfg->direction =3D=3D DMA_DEV_TO_MEM &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->src_addr_width=
 !=3D DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cfg->direction =3D=3D DM=
A_MEM_TO_DEV &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->dst_addr_width=
 !=3D DMA_SLAVE_BUSWIDTH_4_BYTES) ||
>> According to the probe function these width restrictions are only vali=
d
>> for DMA_VER22?
> YES

Right, hdma_ops does not have device_config specified.

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !is_slave_direction(cfg->=
direction))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Default setting will be used */
>>> +=C2=A0=C2=A0=C2=A0 if (!cfg->src_maxburst && !cfg->dst_maxburst)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> maxburst =3D=3D 0 is identical to maxburst =3D=3D 1, it is just not se=
t
>> explicitly. Iow 1 word per DMA request.
> This is not clear to me. Can you elaborate?

You handle the *_maxburst =3D=3D 1 and *maxburst =3D=3D 0 differently whi=
le they
are the same thing.

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Must be the same */
>>> +=C2=A0=C2=A0=C2=A0 if (cfg->src_maxburst && cfg->dst_maxburst &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->src_maxburst !=3D cf=
g->dst_maxburst)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (cfg->dst_maxburst)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg->src_maxburst =3D cfg=
->dst_maxburst;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bl =3D ilog2(cfg->src_maxburst);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&d->dev_lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 writel(p->portid, d->base + DMA_PS);
>>> +=C2=A0=C2=A0=C2=A0 ldma_update_bits(d, DMA_PCTRL_RXBL | DMA_PCTRL_TX=
BL,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(DMA_PCTRL_RXBL, bl) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(DMA_PCTRL_TXBL, bl), DMA_PCTRL);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&d->dev_lock, flags);
>> What drivers usually do is to save the cfg and inprepare time take it
>> into account when setting up the transfer.
>> Write the change to the HW before the trasnfer is started (if it has
>> changed from previous settings)
>>
>> Client drivers usually set the slave config ones, in most cases during=

>> probe, so the slave config rarely changes runtime, but there are cases=

>> for that.
> Ok, got it. i will update in the next version.

Thanks

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int dma_alloc_chan_resources(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D c->vchan.chan.device->dev;=

>>> +=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0 desc_sz;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (d->ver > DMA_VER22) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->flags |=3D CHAN_IN_USE=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (c->desc_pool)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return c->desc_num;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 desc_sz =3D c->desc_num * sizeof(struct dw2_desc)=
;
>>> +=C2=A0=C2=A0=C2=A0 c->desc_pool =3D dma_pool_create(c->name, dev, de=
sc_sz,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __alignof=
__(struct dw2_desc), 0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!c->desc_pool) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "unable to a=
llocate descriptor pool\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return c->desc_num;
>>> +}
>>> +
>>> +static void dma_free_chan_resources(struct dma_chan *chan)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D to_ldma_chan(chan);
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.=
device);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (d->ver =3D=3D DMA_VER22) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_pool_destroy(c->desc_=
pool);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->desc_pool =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vchan_free_chan_resources=
(to_virt_chan(chan));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldma_chan_reset(c);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c->flags &=3D ~CHAN_IN_US=
E;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void dma_work(struct work_struct *work)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ldma_chan *c =3D container_of(work, struct=
 ldma_chan, work);
>>> +=C2=A0=C2=A0=C2=A0 struct dma_async_tx_descriptor *tx =3D &c->ds->vd=
esc.tx;
>>> +=C2=A0=C2=A0=C2=A0 struct dmaengine_desc_callback cb;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dmaengine_desc_get_callback(tx, &cb);
>>> +=C2=A0=C2=A0=C2=A0 dma_cookie_complete(tx);
>>> +=C2=A0=C2=A0=C2=A0 dmaengine_desc_callback_invoke(&cb, NULL);
>> When you are going to free up the descriptor?
> **
> Seems i missed free up the descriptor here. i will fix and update in th=
e
> next version.

This is the place when you can do c->ds =3D NULL and you should also look=

for entries in the issued list to pick up any issued but not commited
transfers.

Let's say the client issued two transfers, in issue_pending you have
started the first one.
Now that is completed, you let the client know about it (you can free up
the descritor as well safely) and then you pick up the next one from the
issued list and start that.
If there is nothing pending then c->ds would be NULL, if there were
pending transfer, you will set c->ds to the next transfer.
c->ds indicates that there is a transfer in progress by the HW.

>>> +
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_alloc_chan_resources =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->inst->ops->device_allo=
c_chan_resources;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_free_chan_resources =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->inst->ops->device_free=
_chan_resources;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_terminate_all =3D d->inst->ops->d=
evice_terminate_all;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_issue_pending =3D d->inst->ops->d=
evice_issue_pending;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_tx_status =3D d->inst->ops->devic=
e_tx_status;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_resume =3D d->inst->ops->device_r=
esume;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_pause =3D d->inst->ops->device_pa=
use;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_config =3D d->inst->ops->device_c=
onfig;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_prep_slave_sg =3D d->inst->ops->d=
evice_prep_slave_sg;
>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_synchronize =3D d->inst->ops->dev=
ice_synchronize;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (d->ver =3D=3D DMA_VER22) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->src_addr_widths =
=3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->dst_addr_widths =
=3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->directions =3D B=
IT(DMA_MEM_TO_DEV) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(DMA_DEV_TO_=
MEM);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->residue_granular=
ity =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_RESIDUE_GRANULARITY_DES=
CRIPTOR;
>>> +=C2=A0=C2=A0=C2=A0 }
>> So, if version is !=3D DMA_VER22, then you don't support any direction=
?
>> Why register the DMA device if it can not do any transfer?
> Only dma0 instance (intel,lgm-cdma) is used as a general purpose slave
> DMA. we set both control and datapath here.
> Other instances we set only control path. data path is taken care by dm=
a
> client(GSWIP).

How the client (GSWIP) can request a channel from intel,lgm-* ? Don't
you need some capabilities for the DMA device so core can sort out the
request?

> Only thing needs to do is get the channel, set the descriptor and just
> on the channel.

How do you 'on' the channel?

>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, d);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ldma_dev_init(d);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D dma_async_device_register(dma_dev);
>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to r=
egister slave DMA engine device\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D of_dma_controller_register(pdev->dev.of_n=
ode, ldma_xlate, d);
>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to r=
egister of DMA controller\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_async_device_unregist=
er(dma_dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dev_info(dev, "Init done - rev: %x, ports: %d cha=
nnels: %d\n",
>>> d->ver,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->port_nrs, d->cha=
n_nrs);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static struct platform_driver intel_ldma_driver =3D {
>>> +=C2=A0=C2=A0=C2=A0 .probe =3D intel_ldma_probe,
>>> +=C2=A0=C2=A0=C2=A0 .driver =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D DRIVER_NAME,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table =3D intel=
_ldma_match,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static int __init intel_ldma_init(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return platform_driver_register(&intel_ldma_drive=
r);
>>> +}
>>> +
>>> +device_initcall(intel_ldma_init);
>>> diff --git a/include/linux/dma/lgm_dma.h b/include/linux/dma/lgm_dma.=
h
>>> new file mode 100644
>>> index 000000000000..3a2ee6ad0710
>>> --- /dev/null
>>> +++ b/include/linux/dma/lgm_dma.h
>>> @@ -0,0 +1,27 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (c) 2016 ~ 2019 Intel Corporation.
>>> + */
>>> +#ifndef LGM_DMA_H
>>> +#define LGM_DMA_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/dmaengine.h>
>>> +
>>> +/*!
>>> + * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t=

>>> desc_base,
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int desc_num)
>>> + * \brief Configure low level channel descriptors
>>> + * \param[in] chan=C2=A0=C2=A0 pointer to DMA channel that the clien=
t is using
>>> + * \param[in] desc_base=C2=A0=C2=A0 descriptor base physical address=

>>> + * \param[in] desc_num=C2=A0=C2=A0 number of descriptors
>>> + * \return=C2=A0=C2=A0 0 on success
>>> + * \return=C2=A0=C2=A0 kernel bug reported on failure
>>> + *
>>> + * This function configure the low level channel descriptors. It
>>> will be
>>> + * used by CBM whose descriptor is not DDR, actually some registers.=

>>> + */
>>> +int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t
>>> desc_base,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int desc_num);
>>> +
>>> +#endif /* LGM_DMA_H */
>>>
>> - P=C3=A9ter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

