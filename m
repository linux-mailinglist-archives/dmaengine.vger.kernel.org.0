Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC429C01E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816980AbgJ0RLa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 13:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1816978AbgJ0RL2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 13:11:28 -0400
Received: from localhost (unknown [122.171.48.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0562021D24;
        Tue, 27 Oct 2020 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818688;
        bh=+dksJcA1GwTAydwlqDLSAr9GPNqYcCR+FgtIECyK5qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4tXxfrmC6Xejp/E0ZIHThxb2EWuaSQEB/sc+HEySkD6P+PiymLLVzSttwg3gOM2r
         AVnJHA8hsABbZTw7GLKOp4C5lm4oJm0eOnExOfNdgqN/ghDF2BvfVEXRfh0nHScUwG
         kcdZ5pIUKi3PceHKSRspQMoJM+Mkyfmk+Yxuzvz0=
Date:   Tue, 27 Oct 2020 22:41:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: move enums in interface to use peripheral
 term
Message-ID: <20201027171123.GB3550@vkoul-mobl>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-2-vkoul@kernel.org>
 <84995bc9-9e77-1e4b-efc2-7284a25f292d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84995bc9-9e77-1e4b-efc2-7284a25f292d@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-20, 11:54, Peter Ujfalusi wrote:
> On 15/10/2020 10.31, Vinod Koul wrote:
> > dmaengine history has a non inclusive terminology of dmaengine slave, I
> > feel it is time to replace that. Start with moving enums in dmaengine
> > interface with replacement of slave to peripheral which is an
> > appropriate term for dmaengine peripheral devices
> > 
> > Since the change of name can break users, the new names have been added
> > with old enums kept as macro define for new names. Once the users have
> > been migrated, these macros will be dropped.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  include/linux/dmaengine.h | 44 ++++++++++++++++++++++++++-------------
> >  1 file changed, 29 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index dd357a747780..f7f420876d21 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -59,7 +59,7 @@ enum dma_transaction_type {
> >  	DMA_INTERRUPT,
> >  	DMA_PRIVATE,
> >  	DMA_ASYNC_TX,
> > -	DMA_SLAVE,
> > +	DMA_PERIPHERAL,
> >  	DMA_CYCLIC,
> >  	DMA_INTERLEAVE,
> >  	DMA_COMPLETION_NO_ORDER,
> > @@ -69,12 +69,14 @@ enum dma_transaction_type {
> >  	DMA_TX_TYPE_END,
> >  };
> >  
> > +#define DMA_SLAVE DMA_PERIPHERAL
> > +
> >  /**
> >   * enum dma_transfer_direction - dma transfer mode and direction indicator
> >   * @DMA_MEM_TO_MEM: Async/Memcpy mode
> > - * @DMA_MEM_TO_DEV: Slave mode & From Memory to Device
> > - * @DMA_DEV_TO_MEM: Slave mode & From Device to Memory
> > - * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
> > + * @DMA_MEM_TO_DEV: Peripheral mode & From Memory to Device
> > + * @DMA_DEV_TO_MEM: Peripheral mode & From Device to Memory
> > + * @DMA_DEV_TO_DEV: Peripheral mode & From Device to Device
> >   */
> >  enum dma_transfer_direction {
> >  	DMA_MEM_TO_MEM,
> > @@ -364,22 +366,34 @@ struct dma_chan_dev {
> >  	int dev_id;
> >  };
> >  
> > +#define	DMA_SLAVE_BUSWIDTH_UNDEFINED	DMA_PERIPHERAL_BUSWIDTH_UNDEFINED
> > +#define	DMA_SLAVE_BUSWIDTH_1_BYTE	DMA_PERIPHERAL_BUSWIDTH_1_BYTE
> > +#define	DMA_SLAVE_BUSWIDTH_2_BYTES	DMA_PERIPHERAL_BUSWIDTH_2_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_3_BYTES	DMA_PERIPHERAL_BUSWIDTH_3_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_4_BYTES	DMA_PERIPHERAL_BUSWIDTH_4_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_8_BYTES	DMA_PERIPHERAL_BUSWIDTH_8_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_16_BYTES	DMA_PERIPHERAL_BUSWIDTH_16_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_32_BYTES	DMA_PERIPHERAL_BUSWIDTH_32_BYTES
> > +#define	DMA_SLAVE_BUSWIDTH_64_BYTES	DMA_PERIPHERAL_BUSWIDTH_64_BYTES
> 
> Probably move the defines after the enum dma_peripheral_buswidth block
> as well?

Yes missed that, thanks for pointing

-- 
~Vinod
