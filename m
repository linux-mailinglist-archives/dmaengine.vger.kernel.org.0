Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94842F7A8A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 19:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKSL3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 13:11:29 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42812 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfKKSL3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Nov 2019 13:11:29 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iUE9v-00016C-J6; Mon, 11 Nov 2019 11:11:28 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-6-logang@deltatee.com>
 <20191109174047.GH952516@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <746371aa-b3f6-aaca-35f2-0f815294dc71@deltatee.com>
Date:   Mon, 11 Nov 2019 11:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191109174047.GH952516@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,LR_URI_NUMERIC_ENDING autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 5/5] dmaengine: plx-dma: Implement descriptor submission
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-11-09 10:40 a.m., Vinod Koul wrote:
>> +static dma_cookie_t plx_dma_tx_submit(struct dma_async_tx_descriptor *desc)
>> +	__releases(plxdev->ring_lock)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(desc->chan);
>> +	struct plx_dma_desc *plxdesc = to_plx_desc(desc);
>> +	dma_cookie_t cookie;
>> +
>> +	cookie = dma_cookie_assign(desc);
>> +
>> +	/*
>> +	 * Ensure the descriptor updates are visible to the dma device
>> +	 * before setting the valid bit.
>> +	 */
>> +	wmb();
>> +
>> +	plxdesc->hw->flags_and_size |= cpu_to_le32(PLX_DESC_FLAG_VALID);
> 
> so where do you store the submitted descriptor?

The descriptors are stored in a ring in memory which the DMA engine
reads. The ring is at (struct plx_dma_dev)->hw_ring. plxdesc->hw is a
pointer to the descriptor's specific entry in the hardware's ring. The
hardware descriptor is populated in plx_dma_prep_memcpy(). Once the
valid flag is set, the hardware owns the descriptor and may start
processing it.

>> +
>> +	spin_unlock_bh(&plxdev->ring_lock);
>> +
>> +	return cookie;
>> +}
>> +
>> +static enum dma_status plx_dma_tx_status(struct dma_chan *chan,
>> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>> +	enum dma_status ret;
>> +
>> +	ret = dma_cookie_status(chan, cookie, txstate);
>> +	if (ret == DMA_COMPLETE)
>> +		return ret;
>> +
>> +	plx_dma_process_desc(plxdev);
> 
> why is this done here..? Query of status should not make you process
> something!

When descriptors are submitted without interrupts, something has to
cleanup the completed descriptors and this is the only sensible place to
do that. This is exactly what IOAT does[1] (but with a different name
and a bit more complexity).

>> +
>> +	return dma_cookie_status(chan, cookie, txstate);
>> +}
>> +
>> +static void plx_dma_issue_pending(struct dma_chan *chan)
>> +{
>> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
>> +
>> +	rcu_read_lock();
>> +	if (!rcu_dereference(plxdev->pdev)) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Ensure the valid bits are visible before starting the
>> +	 * DMA engine.
>> +	 */
>> +	wmb();
>> +
>> +	writew(PLX_REG_CTRL_START_VAL, plxdev->bar + PLX_REG_CTRL);
> 
> start what? 

The hardware processes entries in the ring and once it reaches the end
of the submitted descriptors, then it simply stops forever. Setting this
bit will start it processing entries again (or, if it is already
running, nothing will happen).

Logan

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/dma/ioat/dma.c#L962
