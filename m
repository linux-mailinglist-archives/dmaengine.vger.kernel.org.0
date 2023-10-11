Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316C7C5088
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjJKKuV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJKKuU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 06:50:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB594;
        Wed, 11 Oct 2023 03:50:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435a9f800so8722136e87.2;
        Wed, 11 Oct 2023 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697021417; x=1697626217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE2zpzto2GbRl08daqLzWm48efnAm6lrfofQF2dIJkw=;
        b=AbnunS41VShV/Xz89QCc4Np6eO/kkKpANue0d6+O75tfgf+yU5Kv3IUtpYLV9Aw8hu
         wbvKBjvw2aLgUUnnS4C6iPfc3wECOx2tHs+L8sKQBnIZQI7fD0u6uFuGHLAk6WF0Fm2h
         aGZvkdd1VXT07RWoQgeL3/1rzJfmBuLNCpmULNWbalf3zxzpPyiO6CxK8nREzeFcB83i
         S3C34Af9re1SZv9Xes/MHFZU1S3S+WvWm8E20ksdMPXHPvuFSzbKOk322lL7l/xR0M6U
         Rkyd4C/sITJdhTYzXAPgE89CMt9kXbATvmRdRmBtfCFpamjNRCgmeg9zUt4fwV5bQTa6
         6ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021417; x=1697626217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE2zpzto2GbRl08daqLzWm48efnAm6lrfofQF2dIJkw=;
        b=F53l/Mzv8H2o7pP141fMeXTGhctg/OR5h/d2LOR+naeRbvEjEI9MyP3rfi1cIApHMz
         WoMk3WHBw3mDi3wYP1NLSOPP4kr7y7yg361gZbN65d+rsYde6MktsL/Lu0+7v5w8Wsbu
         XRIEhP/Vl/B6qMDHuYWBh46msqfRVqA4I4PdQ49e7uo4wiwbv0TmAdakHKseWeA9CCc7
         f1Ww8f+B9gw82Cbrhn5eMm/TD64g5gTYGpUafuCXJAwRUWHi/tv3vZgbfiDTbR311Q4/
         CHUnpCfxG4H6quq4AnidSr3wr/XGCf9nwOMpam3FxpNmVQX/uyLf85s+gbRK7pX5q1fq
         lorQ==
X-Gm-Message-State: AOJu0Yw05iZ8XvZdnkebldoA4otjtN83b1ctwdrzz6AnNJ8B04flkjyY
        BV5RQXK/efFl4ftKj8bzR1o=
X-Google-Smtp-Source: AGHT+IHEb2DixA8ZWXqnbsIEdObzFY47/WOMxB3AENZcKDTvSRUEpL/NHQ+KOQMqBNlfUET4KQ3mZQ==
X-Received: by 2002:ac2:510b:0:b0:500:94aa:739c with SMTP id q11-20020ac2510b000000b0050094aa739cmr15842283lfb.61.1697021416192;
        Wed, 11 Oct 2023 03:50:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j20-20020a19f514000000b00503098e1748sm2214383lfb.308.2023.10.11.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:50:15 -0700 (PDT)
Date:   Wed, 11 Oct 2023 13:50:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v3 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <o4h5rrfsfu5sipovexqrjl3jatfkh6ht3fycwv5vzh6bhxdygj@3jy3ns7ciglj>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
 <20231011-b4-feature_hdma_mainline-v3-5-24ee0c979c6f@bootlin.com>
 <6adlujxc4cnrxbl5fbqpg5fishq7jvk6w6chgjyktbwcxd2dvi@w4ayo5ooh7fq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6adlujxc4cnrxbl5fbqpg5fishq7jvk6w6chgjyktbwcxd2dvi@w4ayo5ooh7fq>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 11, 2023 at 01:47:49PM +0300, Serge Semin wrote:
> On Wed, Oct 11, 2023 at 10:11:44AM +0200, Kory Maincent wrote:
> > The Linked list element and pointer are not stored in the same memory as
> > the HDMA controller register. If the doorbell register is toggled before
> > the full write of the linked list a race condition error can appears.
> 
> s/can appears/may occur

It should have been: s/can appears/will occur

-Serge(y)

> 
> > In remote setup we can only use a readl to the memory to assured the full
> > write has occurred.
> 
> s/assured/assure
> 
> > 
> > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> -Serge(y)
> 
> > ---
> > 
> > Changes in v2:
> > - Move the sync read in a function.
> > - Add commments
> > ---
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 04b0bcb6ded9..13b6aec6a6de 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
> >  }
> >  
> > +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> > +{
> > +	/*
> > +	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
> > +	 * configuration registers and Application memory are normally accessed
> > +	 * over different buses. Ensure LL-data reaches the memory before the
> > +	 * doorbell register is toggled by issuing the dummy-read from the remote
> > +	 * LL memory in a hope that the posted MRd TLP will return only after the
> > +	 * last MWr TLP is completed
> > +	 */
> > +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		readl(chunk->ll_region.vaddr.io);
> > +}
> > +
> >  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> > @@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  	/* Set consumer cycle */
> >  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> >  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> > +
> > +	dw_hdma_v0_sync_ll_data(chunk);
> > +
> >  	/* Doorbell */
> >  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> >  }
> > 
> > -- 
> > 2.25.1
> > 
