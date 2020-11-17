Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A12B5A9C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKQH5k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 02:57:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49616 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQH5k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 02:57:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AH7valM085077;
        Tue, 17 Nov 2020 01:57:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605599856;
        bh=sg2xRQFEMvHLLp6cbYdmySM0juqNCRrZWDDw50C7XvE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PZPh/hLCb5Gxv9k5GMQGilYV7J4oILyfe4rl9yPjvFes7yuk4+evvbschlOzEXfUI
         WU8rsH6u0Id2DjuAegMHEgO/lGkudLBfsKNhgHKe9hQWWn5Mx0izsn/cCMWKhMgJKz
         pltCIlysSCa+dR4Hgxsau1OTCS77drJYT18U+szY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AH7vaCT124967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 01:57:36 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 01:57:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 01:57:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AH7vXlS111458;
        Tue, 17 Nov 2020 01:57:34 -0600
Subject: Re: [PATCH v6 3/3] dmaengine: qcom: Add GPI dma driver
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201109085450.24843-1-vkoul@kernel.org>
 <20201109085450.24843-4-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <52e67897-d4bd-3bcd-4648-8f2a5be48f48@ti.com>
Date:   Tue, 17 Nov 2020 09:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201109085450.24843-4-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 09/11/2020 10.54, Vinod Koul wrote:
> This controller provides DMAengine capabilities for a variety of peripheral
> buses such as I2C, UART, and SPI. By using GPI dmaengine driver, bus
> drivers can use a standardize interface that is protocol independent to
> transfer data between memory and peripheral.

There is something I don't quite follow regarding to tracking the issued
and in progress transfers...

...

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> new file mode 100644
> index 000000000000..d2334f535de2
> --- /dev/null
> +++ b/drivers/dma/qcom/gpi.c

...

> +/* process DMA Immediate completion data events */
> +static void gpi_process_imed_data_event(struct gchan *gchan,
> +					struct immediate_data_event *imed_event)
> +{
> +	struct gpii *gpii = gchan->gpii;
> +	struct gpi_ring *ch_ring = &gchan->ch_ring;
> +	void *tre = ch_ring->base + (ch_ring->el_size * imed_event->tre_index);
> +	struct dmaengine_result result;
> +	struct gpi_desc *gpi_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	u32 chid;
> +
> +	/*
> +	 * If channel not active don't process event
> +	 */
> +	if (gchan->pm_state != ACTIVE_STATE) {
> +		dev_err(gpii->gpi_dev->dev, "skipping processing event because ch @ %s state\n",
> +			TO_GPI_PM_STR(gchan->pm_state));
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&gchan->vc.lock, flags);
> +	vd = vchan_next_desc(&gchan->vc);

you take the first entry from the desc_issued list.
The one you actually started is the last one from the list.

> +	if (!vd) {
> +		struct gpi_ere *gpi_ere;
> +		struct gpi_tre *gpi_tre;
> +
> +		spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
> +		gpi_ere = (struct gpi_ere *)imed_event;
> +		dev_dbg(gpii->gpi_dev->dev,
> +			"Event: %08x %08x %08x %08x\n",
> +			gpi_ere->dword[0], gpi_ere->dword[1],
> +			gpi_ere->dword[2], gpi_ere->dword[3]);
> +		gpi_tre = tre;
> +		dev_dbg(gpii->gpi_dev->dev,
> +			"Pending TRE: %08x %08x %08x %08x\n",
> +			gpi_tre->dword[0], gpi_tre->dword[1],
> +			gpi_tre->dword[2], gpi_tre->dword[3]);
> +		return;
> +	}
> +	gpi_desc = to_gpi_desc(vd);
> +	spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +
> +	/*
> +	 * RP pointed by Event is to last TRE processed,
> +	 * we need to update ring rp to tre + 1
> +	 */
> +	tre += ch_ring->el_size;
> +	if (tre >= (ch_ring->base + ch_ring->len))
> +		tre = ch_ring->base;
> +	ch_ring->rp = tre;
> +
> +	/* make sure rp updates are immediately visible to all cores */
> +	smp_wmb();
> +
> +	chid = imed_event->chid;
> +	if (imed_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
> +		if (chid == GPI_RX_CHAN)
> +			goto gpi_free_desc;
> +		else
> +			return;
> +	}
> +
> +	if (imed_event->code == MSM_GPI_TCE_UNEXP_ERR)
> +		result.result = DMA_TRANS_ABORTED;
> +	else
> +		result.result = DMA_TRANS_NOERROR;
> +	result.residue = gpi_desc->len - imed_event->length;
> +
> +	dma_cookie_complete(&vd->tx);
> +	dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> +
> +gpi_free_desc:
> +	spin_lock_irqsave(&gchan->vc.lock, flags);
> +	list_del(&vd->node);
> +	spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +	kfree(gpi_desc);
> +	gpi_desc = NULL;
> +}
> +
> +/* processing transfer completion events */
> +static void gpi_process_xfer_compl_event(struct gchan *gchan,
> +					 struct xfer_compl_event *compl_event)
> +{
> +	struct gpii *gpii = gchan->gpii;
> +	struct gpi_ring *ch_ring = &gchan->ch_ring;
> +	void *ev_rp = to_virtual(ch_ring, compl_event->ptr);
> +	struct virt_dma_desc *vd;
> +	struct gpi_desc *gpi_desc;
> +	struct dmaengine_result result;
> +	unsigned long flags;
> +	u32 chid;
> +
> +	/* only process events on active channel */
> +	if (unlikely(gchan->pm_state != ACTIVE_STATE)) {
> +		dev_err(gpii->gpi_dev->dev, "skipping processing event because ch @ %s state\n",
> +			TO_GPI_PM_STR(gchan->pm_state));
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&gchan->vc.lock, flags);
> +	vd = vchan_next_desc(&gchan->vc);

you take the first entry from the desc_issued list here as well.
The one you actually started is the last one from the list.

> +	if (!vd) {
> +		struct gpi_ere *gpi_ere;
> +
> +		spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +		dev_err(gpii->gpi_dev->dev, "Event without a pending descriptor!\n");
> +		gpi_ere = (struct gpi_ere *)compl_event;
> +		dev_err(gpii->gpi_dev->dev,
> +			"Event: %08x %08x %08x %08x\n",
> +			gpi_ere->dword[0], gpi_ere->dword[1],
> +			gpi_ere->dword[2], gpi_ere->dword[3]);
> +		return;
> +	}
> +
> +	gpi_desc = to_gpi_desc(vd);
> +	spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +
> +	/*
> +	 * RP pointed by Event is to last TRE processed,
> +	 * we need to update ring rp to ev_rp + 1
> +	 */
> +	ev_rp += ch_ring->el_size;
> +	if (ev_rp >= (ch_ring->base + ch_ring->len))
> +		ev_rp = ch_ring->base;
> +	ch_ring->rp = ev_rp;
> +
> +	/* update must be visible to other cores */
> +	smp_wmb();
> +
> +	chid = compl_event->chid;
> +	if (compl_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
> +		if (chid == GPI_RX_CHAN)
> +			goto gpi_free_desc;
> +		else
> +			return;
> +	}
> +
> +	if (compl_event->code == MSM_GPI_TCE_UNEXP_ERR) {
> +		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
> +		result.result = DMA_TRANS_ABORTED;
> +	} else {
> +		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
> +		result.result = DMA_TRANS_NOERROR;
> +	}
> +	result.residue = gpi_desc->len - compl_event->length;
> +	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
> +
> +	dma_cookie_complete(&vd->tx);
> +	dmaengine_desc_get_callback_invoke(&vd->tx, &result);

If you had two descriptors in the list, you have started the last one
and here you would complete the first one, which is not even started...

> +
> +gpi_free_desc:
> +	spin_lock_irqsave(&gchan->vc.lock, flags);
> +	list_del(&vd->node);
> +	spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +	kfree(gpi_desc);
> +	gpi_desc = NULL;
> +}
> +
> +/* process all events */
> +static void gpi_process_events(struct gpii *gpii)
> +{
> +	struct gpi_ring *ev_ring = &gpii->ev_ring;
> +	phys_addr_t cntxt_rp;
> +	void *rp;
> +	union gpi_event *gpi_event;
> +	struct gchan *gchan;
> +	u32 chid, type;
> +
> +	cntxt_rp = gpi_read_reg(gpii, gpii->ev_ring_rp_lsb_reg);
> +	rp = to_virtual(ev_ring, cntxt_rp);
> +
> +	do {
> +		while (rp != ev_ring->rp) {
> +			gpi_event = ev_ring->rp;
> +			chid = gpi_event->xfer_compl_event.chid;
> +			type = gpi_event->xfer_compl_event.type;
> +
> +			dev_dbg(gpii->gpi_dev->dev,
> +				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
> +				chid, type, gpi_event->gpi_ere.dword[0],
> +				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
> +				gpi_event->gpi_ere.dword[3]);
> +
> +			switch (type) {
> +			case XFER_COMPLETE_EV_TYPE:
> +				gchan = &gpii->gchan[chid];
> +				gpi_process_xfer_compl_event(gchan,
> +							     &gpi_event->xfer_compl_event);
> +				break;
> +			case STALE_EV_TYPE:
> +				dev_dbg(gpii->gpi_dev->dev, "stale event, not processing\n");
> +				break;
> +			case IMMEDIATE_DATA_EV_TYPE:
> +				gchan = &gpii->gchan[chid];
> +				gpi_process_imed_data_event(gchan,
> +							    &gpi_event->immediate_data_event);
> +				break;
> +			case QUP_NOTIF_EV_TYPE:
> +				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
> +				break;
> +			default:
> +				dev_dbg(gpii->gpi_dev->dev,
> +					"not supported event type:0x%x\n", type);
> +			}
> +			gpi_ring_recycle_ev_element(ev_ring);
> +		}
> +		gpi_write_ev_db(gpii, ev_ring, ev_ring->wp);
> +
> +		/* clear pending IEOB events */
> +		gpi_write_reg(gpii, gpii->ieob_clr_reg, BIT(0));
> +
> +		cntxt_rp = gpi_read_reg(gpii, gpii->ev_ring_rp_lsb_reg);
> +		rp = to_virtual(ev_ring, cntxt_rp);
> +
> +	} while (rp != ev_ring->rp);
> +}

...

> +/* rings transfer ring db to being transfer */
> +static void gpi_issue_pending(struct dma_chan *chan)
> +{
> +	struct gchan *gchan = to_gchan(chan);
> +	struct gpii *gpii = gchan->gpii;
> +	unsigned long flags, pm_lock_flags;
> +	struct virt_dma_desc *vd = NULL;
> +	struct gpi_desc *gpi_desc;
> +	struct gpi_ring *ch_ring = &gchan->ch_ring;
> +	void *tre, *wp = NULL;
> +	int i;
> +
> +	read_lock_irqsave(&gpii->pm_lock, pm_lock_flags);
> +
> +	/* move all submitted discriptors to issued list */
> +	spin_lock_irqsave(&gchan->vc.lock, flags);
> +	if (vchan_issue_pending(&gchan->vc))
> +		vd = list_last_entry(&gchan->vc.desc_issued,
> +				     struct virt_dma_desc, node);

You take the last entry from the desc_issued and start it.
vchan_next_desc() should be used here as well?

I think it is fine to leave the desc in the issued list after they are
given to the HW, but I prefer to delete it and save a pointer to the
channel as the curerntly running one.
The desc_issued then contains the descriptors which are issued, but not
yet submitted to the DMA.

In the completion one can just check if the gchan->desc (or whatever you
call it) is not NULL to catch spurious events.

Then in completion I take a look at the vchan_next_desc() to see if I
have another issued transfer pending and if there is then I start it
right away.

> +	spin_unlock_irqrestore(&gchan->vc.lock, flags);
> +
> +	/* nothing to do list is empty */
> +	if (!vd) {
> +		read_unlock_irqrestore(&gpii->pm_lock, pm_lock_flags);
> +		return;
> +	}
> +
> +	gpi_desc = to_gpi_desc(vd);
> +	for (i = 0; i < gpi_desc->num_tre; i++) {
> +		tre = &gpi_desc->tre[i];
> +		gpi_queue_xfer(gpii, gchan, tre, &wp);
> +	}
> +
> +	gpi_desc->db = ch_ring->wp;
> +	gpi_write_ch_db(gchan, &gchan->ch_ring, gpi_desc->db);
> +	read_unlock_irqrestore(&gpii->pm_lock, pm_lock_flags);
> +}
> +
> +static int gpi_ch_init(struct gchan *gchan)
> +{
> +	struct gpii *gpii = gchan->gpii;
> +	const int ev_factor = gpii->gpi_dev->ev_factor;
> +	u32 elements;
> +	int i = 0, ret = 0;
> +
> +	gchan->pm_state = CONFIG_STATE;
> +
> +	/* check if both channels are configured before continue */
> +	for (i = 0; i < MAX_CHANNELS_PER_GPII; i++)
> +		if (gpii->gchan[i].pm_state != CONFIG_STATE)
> +			goto exit_gpi_init;
> +
> +	/* protocol must be same for both channels */
> +	if (gpii->gchan[0].protocol != gpii->gchan[1].protocol) {
> +		dev_err(gpii->gpi_dev->dev, "protocol did not match protocol %u != %u\n",
> +			gpii->gchan[0].protocol, gpii->gchan[1].protocol);
> +		ret = -EINVAL;
> +		goto exit_gpi_init;
> +	}
> +
> +	/* allocate memory for event ring */
> +	elements = CHAN_TRES << ev_factor;
> +	ret = gpi_alloc_ring(&gpii->ev_ring, elements,
> +			     sizeof(union gpi_event), gpii);
> +	if (ret)
> +		goto exit_gpi_init;
> +
> +	/* configure interrupts */
> +	write_lock_irq(&gpii->pm_lock);
> +	gpii->pm_state = PREPARE_HARDWARE;
> +	write_unlock_irq(&gpii->pm_lock);
> +	ret = gpi_config_interrupts(gpii, DEFAULT_IRQ_SETTINGS, 0);
> +	if (ret) {
> +		dev_err(gpii->gpi_dev->dev, "error config. interrupts, ret:%d\n", ret);
> +		goto error_config_int;
> +	}
> +
> +	/* allocate event rings */
> +	ret = gpi_alloc_ev_chan(gpii);
> +	if (ret) {
> +		dev_err(gpii->gpi_dev->dev, "error alloc_ev_chan:%d\n", ret);
> +		goto error_alloc_ev_ring;
> +	}
> +
> +	/* Allocate all channels */
> +	for (i = 0; i < MAX_CHANNELS_PER_GPII; i++) {
> +		ret = gpi_alloc_chan(&gpii->gchan[i], true);
> +		if (ret) {
> +			dev_err(gpii->gpi_dev->dev, "Error allocating chan:%d\n", ret);
> +			goto error_alloc_chan;
> +		}
> +	}
> +
> +	/* start channels  */
> +	for (i = 0; i < MAX_CHANNELS_PER_GPII; i++) {
> +		ret = gpi_start_chan(&gpii->gchan[i]);
> +		if (ret) {
> +			dev_err(gpii->gpi_dev->dev, "Error start chan:%d\n", ret);
> +			goto error_start_chan;
> +		}
> +	}
> +	return ret;
> +
> +error_start_chan:
> +	for (i = i - 1; i >= 0; i++) {
> +		gpi_stop_chan(&gpii->gchan[i]);
> +		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
> +	}
> +	i = 2;
> +error_alloc_chan:
> +	for (i = i - 1; i >= 0; i--)
> +		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
> +error_alloc_ev_ring:
> +	gpi_disable_interrupts(gpii);
> +error_config_int:
> +	gpi_free_ring(&gpii->ev_ring, gpii);
> +exit_gpi_init:
> +	mutex_unlock(&gpii->ctrl_lock);
> +	return ret;
> +}
> +
> +/* release all channel resources */
> +static void gpi_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct gchan *gchan = to_gchan(chan);
> +	struct gpii *gpii = gchan->gpii;
> +	enum gpi_pm_state cur_state;
> +	int ret, i;
> +
> +	mutex_lock(&gpii->ctrl_lock);
> +
> +	cur_state = gchan->pm_state;
> +
> +	/* disable ch state so no more TRE processing for this channel */
> +	write_lock_irq(&gpii->pm_lock);
> +	gchan->pm_state = PREPARE_TERMINATE;
> +	write_unlock_irq(&gpii->pm_lock);
> +
> +	/* attempt to do graceful hardware shutdown */
> +	if (cur_state == ACTIVE_STATE) {
> +		gpi_stop_chan(gchan);
> +
> +		ret = gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
> +		if (ret)
> +			dev_err(gpii->gpi_dev->dev, "error resetting channel:%d\n", ret);
> +
> +		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
> +	}
> +
> +	/* free all allocated memory */
> +	gpi_free_ring(&gchan->ch_ring, gpii);
> +	vchan_free_chan_resources(&gchan->vc);
> +	kfree(gchan->config);
> +
> +	write_lock_irq(&gpii->pm_lock);
> +	gchan->pm_state = DISABLE_STATE;
> +	write_unlock_irq(&gpii->pm_lock);
> +
> +	/* if other rings are still active exit */
> +	for (i = 0; i < MAX_CHANNELS_PER_GPII; i++)
> +		if (gpii->gchan[i].ch_ring.configured)
> +			goto exit_free;
> +
> +	/* deallocate EV Ring */
> +	cur_state = gpii->pm_state;
> +	write_lock_irq(&gpii->pm_lock);
> +	gpii->pm_state = PREPARE_TERMINATE;
> +	write_unlock_irq(&gpii->pm_lock);
> +
> +	/* wait for threads to complete out */
> +	tasklet_kill(&gpii->ev_task);
> +
> +	/* send command to de allocate event ring */
> +	if (cur_state == ACTIVE_STATE)
> +		gpi_send_cmd(gpii, NULL, GPI_EV_CMD_DEALLOC);
> +
> +	gpi_free_ring(&gpii->ev_ring, gpii);
> +
> +	/* disable interrupts */
> +	if (cur_state == ACTIVE_STATE)
> +		gpi_disable_interrupts(gpii);
> +
> +	/* set final state to disable */
> +	write_lock_irq(&gpii->pm_lock);
> +	gpii->pm_state = DISABLE_STATE;
> +	write_unlock_irq(&gpii->pm_lock);
> +
> +exit_free:
> +	mutex_unlock(&gpii->ctrl_lock);
> +}
> +
> +/* allocate channel resources */
> +static int gpi_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct gchan *gchan = to_gchan(chan);
> +	struct gpii *gpii = gchan->gpii;
> +	int ret;
> +
> +	mutex_lock(&gpii->ctrl_lock);
> +
> +	/* allocate memory for transfer ring */
> +	ret = gpi_alloc_ring(&gchan->ch_ring, CHAN_TRES,
> +			     sizeof(struct gpi_tre), gpii);
> +	if (ret)
> +		goto xfer_alloc_err;
> +
> +	ret = gpi_ch_init(gchan);
> +
> +	mutex_unlock(&gpii->ctrl_lock);
> +
> +	return ret;
> +xfer_alloc_err:
> +	mutex_unlock(&gpii->ctrl_lock);
> +
> +	return ret;
> +}
> +
> +static int gpi_find_avail_gpii(struct gpi_dev *gpi_dev, u32 seid)
> +{
> +	struct gchan *tx_chan, *rx_chan;
> +	unsigned int gpii;
> +
> +	/* check if same seid is already configured for another chid */
> +	for (gpii = 0; gpii < gpi_dev->max_gpii; gpii++) {
> +		if (!((1 << gpii) & gpi_dev->gpii_mask))
> +			continue;
> +
> +		tx_chan = &gpi_dev->gpiis[gpii].gchan[GPI_TX_CHAN];
> +		rx_chan = &gpi_dev->gpiis[gpii].gchan[GPI_RX_CHAN];
> +
> +		if (rx_chan->vc.chan.client_count && rx_chan->seid == seid)
> +			return gpii;
> +		if (tx_chan->vc.chan.client_count && tx_chan->seid == seid)
> +			return gpii;
> +	}
> +
> +	/* no channels configured with same seid, return next avail gpii */
> +	for (gpii = 0; gpii < gpi_dev->max_gpii; gpii++) {
> +		if (!((1 << gpii) & gpi_dev->gpii_mask))
> +			continue;
> +
> +		tx_chan = &gpi_dev->gpiis[gpii].gchan[GPI_TX_CHAN];
> +		rx_chan = &gpi_dev->gpiis[gpii].gchan[GPI_RX_CHAN];
> +
> +		/* check if gpii is configured */
> +		if (tx_chan->vc.chan.client_count ||
> +		    rx_chan->vc.chan.client_count)
> +			continue;
> +
> +		/* found a free gpii */
> +		return gpii;
> +	}
> +
> +	/* no gpii instance available to use */
> +	return -EIO;
> +}
> +
> +/* gpi_of_dma_xlate: open client requested channel */
> +static struct dma_chan *gpi_of_dma_xlate(struct of_phandle_args *args,
> +					 struct of_dma *of_dma)
> +{
> +	struct gpi_dev *gpi_dev = (struct gpi_dev *)of_dma->of_dma_data;
> +	u32 seid, chid;
> +	int gpii;
> +	struct gchan *gchan;
> +
> +	if (args->args_count < 3) {
> +		dev_err(gpi_dev->dev, "gpii require minimum 2 args, client passed:%d args\n",
> +			args->args_count);
> +		return NULL;
> +	}
> +
> +	chid = args->args[0];
> +	if (chid >= MAX_CHANNELS_PER_GPII) {
> +		dev_err(gpi_dev->dev, "gpii channel:%d not valid\n", chid);
> +		return NULL;
> +	}
> +
> +	seid = args->args[1];
> +
> +	/* find next available gpii to use */
> +	gpii = gpi_find_avail_gpii(gpi_dev, seid);
> +	if (gpii < 0) {
> +		dev_err(gpi_dev->dev, "no available gpii instances\n");
> +		return NULL;
> +	}
> +
> +	gchan = &gpi_dev->gpiis[gpii].gchan[chid];
> +	if (gchan->vc.chan.client_count) {
> +		dev_err(gpi_dev->dev, "gpii:%d chid:%d seid:%d already configured\n",
> +			gpii, chid, gchan->seid);
> +		return NULL;
> +	}
> +
> +	gchan->seid = seid;
> +	gchan->protocol = args->args[2];
> +
> +	return dma_get_slave_channel(&gchan->vc.chan);
> +}
> +
> +static int gpi_probe(struct platform_device *pdev)
> +{
> +	struct gpi_dev *gpi_dev;
> +	unsigned int i;
> +	int ret;
> +
> +	gpi_dev = devm_kzalloc(&pdev->dev, sizeof(*gpi_dev), GFP_KERNEL);
> +	if (!gpi_dev)
> +		return -ENOMEM;
> +
> +	gpi_dev->dev = &pdev->dev;
> +	gpi_dev->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	gpi_dev->regs = devm_ioremap_resource(gpi_dev->dev, gpi_dev->res);
> +	if (IS_ERR(gpi_dev->regs))
> +		return PTR_ERR(gpi_dev->regs);
> +	gpi_dev->ee_base = gpi_dev->regs;
> +
> +	ret = of_property_read_u32(gpi_dev->dev->of_node, "dma-channels",
> +				   &gpi_dev->max_gpii);
> +	if (ret) {
> +		dev_err(gpi_dev->dev, "missing 'max-no-gpii' DT node\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(gpi_dev->dev->of_node, "dma-channel-mask",
> +				   &gpi_dev->gpii_mask);
> +	if (ret) {
> +		dev_err(gpi_dev->dev, "missing 'gpii-mask' DT node\n");
> +		return ret;
> +	}
> +
> +	gpi_dev->ev_factor = EV_FACTOR;
> +
> +	ret = dma_set_mask(gpi_dev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(gpi_dev->dev, "Error setting dma_mask to 64, ret:%d\n", ret);
> +		return ret;
> +	}
> +
> +	gpi_dev->gpiis = devm_kzalloc(gpi_dev->dev, sizeof(*gpi_dev->gpiis) *
> +				      gpi_dev->max_gpii, GFP_KERNEL);
> +	if (!gpi_dev->gpiis)
> +		return -ENOMEM;
> +
> +	/* setup all the supported gpii */
> +	INIT_LIST_HEAD(&gpi_dev->dma_device.channels);
> +	for (i = 0; i < gpi_dev->max_gpii; i++) {
> +		struct gpii *gpii = &gpi_dev->gpiis[i];
> +		int chan;
> +
> +		if (!((1 << i) & gpi_dev->gpii_mask))
> +			continue;
> +
> +		/* set up ev cntxt register map */
> +		gpii->ev_cntxt_base_reg = gpi_dev->ee_base + GPII_n_EV_CH_k_CNTXT_0_OFFS(i, 0);
> +		gpii->ev_cntxt_db_reg = gpi_dev->ee_base + GPII_n_EV_CH_k_DOORBELL_0_OFFS(i, 0);
> +		gpii->ev_ring_rp_lsb_reg = gpii->ev_cntxt_base_reg + CNTXT_4_RING_RP_LSB;
> +		gpii->ev_cmd_reg = gpi_dev->ee_base + GPII_n_EV_CH_CMD_OFFS(i);
> +		gpii->ieob_clr_reg = gpi_dev->ee_base + GPII_n_CNTXT_SRC_IEOB_IRQ_CLR_OFFS(i);
> +
> +		/* set up irq */
> +		ret = platform_get_irq(pdev, i);
> +		if (ret < 0) {
> +			dev_err(gpi_dev->dev, "platform_get_irq failed for %d:%d\n", i, ret);
> +			return ret;
> +		}
> +		gpii->irq = ret;
> +
> +		/* set up channel specific register info */
> +		for (chan = 0; chan < MAX_CHANNELS_PER_GPII; chan++) {
> +			struct gchan *gchan = &gpii->gchan[chan];
> +
> +			/* set up ch cntxt register map */
> +			gchan->ch_cntxt_base_reg = gpi_dev->ee_base +
> +				GPII_n_CH_k_CNTXT_0_OFFS(i, chan);
> +			gchan->ch_cntxt_db_reg = gpi_dev->ee_base +
> +				GPII_n_CH_k_DOORBELL_0_OFFS(i, chan);
> +			gchan->ch_cmd_reg = gpi_dev->ee_base + GPII_n_CH_CMD_OFFS(i);
> +
> +			/* vchan setup */
> +			vchan_init(&gchan->vc, &gpi_dev->dma_device);
> +			gchan->vc.desc_free = gpi_desc_free;
> +			gchan->chid = chan;
> +			gchan->gpii = gpii;
> +			gchan->dir = GPII_CHAN_DIR[chan];
> +		}
> +		mutex_init(&gpii->ctrl_lock);
> +		rwlock_init(&gpii->pm_lock);
> +		tasklet_init(&gpii->ev_task, gpi_ev_tasklet,
> +			     (unsigned long)gpii);
> +		init_completion(&gpii->cmd_completion);
> +		gpii->gpii_id = i;
> +		gpii->regs = gpi_dev->ee_base;
> +		gpii->gpi_dev = gpi_dev;
> +	}
> +
> +	platform_set_drvdata(pdev, gpi_dev);
> +
> +	/* clear and Set capabilities */
> +	dma_cap_zero(gpi_dev->dma_device.cap_mask);
> +	dma_cap_set(DMA_SLAVE, gpi_dev->dma_device.cap_mask);
> +
> +	/* configure dmaengine apis */
> +	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
> +	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
> +	gpi_dev->dma_device.device_tx_status = dma_cookie_status;
> +	gpi_dev->dma_device.device_issue_pending = gpi_issue_pending;
> +	gpi_dev->dma_device.device_prep_slave_sg = gpi_prep_slave_sg;
> +	gpi_dev->dma_device.device_config = gpi_peripheral_config;
> +	gpi_dev->dma_device.device_terminate_all = gpi_terminate_all;
> +	gpi_dev->dma_device.dev = gpi_dev->dev;
> +	gpi_dev->dma_device.device_pause = gpi_pause;
> +	gpi_dev->dma_device.device_resume = gpi_resume;
> +
> +	/* register with dmaengine framework */
> +	ret = dma_async_device_register(&gpi_dev->dma_device);
> +	if (ret) {
> +		dev_err(gpi_dev->dev, "async_device_register failed ret:%d", ret);
> +		return ret;
> +	}
> +
> +	ret = of_dma_controller_register(gpi_dev->dev->of_node,
> +					 gpi_of_dma_xlate, gpi_dev);
> +	if (ret) {
> +		dev_err(gpi_dev->dev, "of_dma_controller_reg failed ret:%d", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id gpi_of_match[] = {
> +	{ .compatible = "qcom,sdm845-gpi-dma" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gpi_of_match);
> +
> +static struct platform_driver gpi_driver = {
> +	.probe = gpi_probe,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = gpi_of_match,
> +	},
> +};
> +
> +static int __init gpi_init(void)
> +{
> +	return platform_driver_register(&gpi_driver);
> +}
> +subsys_initcall(gpi_init)
> +
> +MODULE_DESCRIPTION("QCOM GPI DMA engine driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
> new file mode 100644
> index 000000000000..f46dc3372f11
> --- /dev/null
> +++ b/include/linux/dma/qcom-gpi-dma.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020, Linaro Limited
> + */
> +
> +#ifndef QCOM_GPI_DMA_H
> +#define QCOM_GPI_DMA_H
> +
> +/**
> + * enum spi_transfer_cmd - spi transfer commands
> + */
> +enum spi_transfer_cmd {
> +	SPI_TX = 1,
> +	SPI_RX,
> +	SPI_DUPLEX,
> +};
> +
> +/**
> + * struct gpi_spi_config - spi config for peripheral
> + *
> + * @loopback_en: spi loopback enable when set
> + * @clock_pol_high: clock polarity
> + * @data_pol_high: data polarity
> + * @pack_en: process tx/rx buffers as packed
> + * @word_len: spi word length
> + * @clk_div: source clock divider
> + * @clk_src: serial clock
> + * @cmd: spi cmd
> + * @fragmentation: keep CS assserted at end of sequence
> + * @cs: chip select toggle
> + * @set_config: set peripheral config
> + * @rx_len: receive length for buffer
> + */
> +struct gpi_spi_config {
> +	u8 set_config;
> +	u8 loopback_en;
> +	u8 clock_pol_high;
> +	u8 data_pol_high;
> +	u8 pack_en;
> +	u8 word_len;
> +	u8 fragmentation;
> +	u8 cs;
> +	u32 clk_div;
> +	u32 clk_src;
> +	enum spi_transfer_cmd cmd;
> +	u32 rx_len;
> +};
> +
> +enum i2c_op {
> +	I2C_WRITE = 1,
> +	I2C_READ,
> +};
> +
> +/**
> + * struct gpi_i2c_config - i2c config for peripheral
> + *
> + * @pack_enable: process tx/rx buffers as packed
> + * @cycle_count: clock cycles to be sent
> + * @high_count: high period of clock
> + * @low_count: low period of clock
> + * @clk_div: source clock divider
> + * @addr: i2c bus address
> + * @stretch: stretch the clock at eot
> + * @set_config: set peripheral config
> + * @rx_len: receive length for buffer
> + * @op: i2c cmd
> + * @muli-msg: is part of multi i2c r-w msgs
> + */
> +struct gpi_i2c_config {
> +	u8 set_config;
> +	u8 pack_enable;
> +	u8 cycle_count;
> +	u8 high_count;
> +	u8 low_count;
> +	u8 addr;
> +	u8 stretch;
> +	u16 clk_div;
> +	u32 rx_len;
> +	enum i2c_op op;
> +	bool multi_msg;
> +};
> +
> +#endif /* QCOM_GPI_DMA_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
