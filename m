Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C402711B93F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfLKQzD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 11:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLKQzC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 11:55:02 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945C3214AF;
        Wed, 11 Dec 2019 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576083302;
        bh=uiy+c3OW5H/SA+I7Cjaglj3+jSQybqFy415N64mpZs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTnk7wXu4g2FR69RGSAO6fzwD6rRN0b/33mQSieSER7mZuUl1hRGcsEUiVbMwPr65
         EZO26xnBgUCZh7JjCSNlFxa8RHwq2RHEfRhx/Vd3KNp3FxTbSriCj5r9LFCFjt0hqt
         +sIEmBR0My/ACp3/hURZTMMP2DAXsvYpsxl12vjs=
Date:   Wed, 11 Dec 2019 22:24:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linuxarm@huawei.com, Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Subject: Re: [PATCH v2] dmaengine: hisilicon: Add Kunpeng DMA engine support
Message-ID: <20191211165458.GJ2536@vkoul-mobl>
References: <1575943997-164744-1-git-send-email-wangzhou1@hisilicon.com>
 <20191211105234.GG2536@vkoul-mobl>
 <5DF0D666.6060908@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DF0D666.6060908@hisilicon.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-12-19, 19:43, Zhou Wang wrote:
> On 2019/12/11 18:52, Vinod Koul wrote:
> > On 10-12-19, 10:13, Zhou Wang wrote:

> >> +static int hisi_dma_terminate_all(struct dma_chan *c)
> >> +{
> >> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> >> +	unsigned long flags;
> >> +	LIST_HEAD(head);
> >> +
> >> +	spin_lock_irqsave(&chan->vc.lock, flags);
> >> +
> >> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
> >> +	if (chan->desc) {
> >> +		vchan_terminate_vdesc(&chan->desc->vd);
> >> +		chan->desc = NULL;
> >> +	}
> >> +
> >> +	vchan_get_all_descriptors(&chan->vc, &head);
> >> +
> >> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >> +
> >> +	vchan_dma_desc_free_list(&chan->vc, &head);
> >> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);
> > 
> > pause on terminate? Not DISABLE?
> 
> here this function just aborts transfers on specific channel.

yeah and I would expect the channel to go into disable state right!

> >> +static struct pci_driver hisi_dma_pci_driver = {
> >> +	.name		= "hisi_dma",
> >> +	.id_table	= hisi_dma_pci_tbl,
> >> +	.probe		= hisi_dma_probe,
> > 
> > no .remove and kconfig has a tristate option!
> 
> Use devres APIs in probe, so seems nothing should be done in remove :)

who will de-register from dmaengine, you have dangiling chan_tasklet
which needs to be killed and you have isr which is still enabled, yeah
what could go wrong!

Please, deregister from dmaengine, kill the vchan tasklet and make sur
irq is disabled and tasklets killed

-- 
~Vinod
