Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D67725DA6
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjFGLuC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjFGLt4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 07:49:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351071BD7;
        Wed,  7 Jun 2023 04:49:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1a653b409so6314701fa.0;
        Wed, 07 Jun 2023 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686138593; x=1688730593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KHzjjhm6r+h0VB7DbPCBL5uQXvRdaAwiHw841rXLOhs=;
        b=H5BZzFhlox4FWGfl+SZhG9qWIsg1SZHq/vKqdazna/kU7ws/KktaZgpCZy/GnxdisL
         vNfmX3n/cQGAGn/EIiEt5Q9j+rb5BrGkJovajm5B43LQi7EtyiJB4Ud5cgLU6PdGDQ2u
         6ZbKnqhH0uwxg5ctbUxUBcdG11eKTY4+gaWsF6GIH4/JkJMjYhSBVA9uX1IXcG5rqjJW
         ava9FTYQ/dlNCXz0cTsgN/T3fk7W0Xt86GeW+Va4HHTzrKK/K/O7DklyUh+YkmkR5v5s
         427wWajyVxTzPkJvUHymfylsGAAIMvvO8SyQxJRac9K/VkeWIK+9KSu+O86MSMN1YWYo
         HBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138593; x=1688730593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHzjjhm6r+h0VB7DbPCBL5uQXvRdaAwiHw841rXLOhs=;
        b=Ea35DETL29/bzHbwVSII6HlebMZx/zC4SOtOUXAWmlRSv5MBnXsJF1HzvyZ2lOWMnT
         p9BblXg1vOeINJpN2pb4tqBqogr+2usnRdumFTcUofvYDMN33EJCt72LwHC9PItknhIa
         XaDTvmWT7sYOEdhHTW4duUPVz+6YxPcDyY1QIkB3Ptx7/8/sm+ovA+sGp6uRn5noT8lS
         BHmnPubM29pVWi5phJbn9I0hRI3ADEt5HSkIAtBWZdPon7xAKoTNMCxzgadPn2jzSe2u
         TPii7R7hWGwSzYdM+5Wz+MsBtxCTEsuv0YvJsjeFhvrK2x0ds+kSYwta/PamuSY7WJLp
         BWbQ==
X-Gm-Message-State: AC+VfDyvTUyiMhjvz118iFOVs9KzF0P4NKKTFFZ5LQeSJgHrzE4660Up
        u5p3tLBci9JW7iU0TKUy504=
X-Google-Smtp-Source: ACHHUZ7ZvYRI7NquPD+zBHJhdDx5+k5OgD0smliQDH+Sp7Ez/u6SSSx4n39KTyDKPHfnZI23KTk4FA==
X-Received: by 2002:a2e:b548:0:b0:2b1:b594:4675 with SMTP id a8-20020a2eb548000000b002b1b5944675mr4749264ljn.7.1686138593224;
        Wed, 07 Jun 2023 04:49:53 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e9609000000b002ad5f774579sm2241854ljh.96.2023.06.07.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:49:52 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:49:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, vkoul@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v11 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230607114950.zml4l2rs77cbeesy@mobilestation>
References: <20230520050854.73160-1-cai.huoqing@linux.dev>
 <20230520050854.73160-4-cai.huoqing@linux.dev>
 <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Köry

On Wed, Jun 07, 2023 at 09:58:32AM +0200, Köry Maincent wrote:
> On Sat, 20 May 2023 13:08:51 +0800
> Cai Huoqing <cai.huoqing@linux.dev> wrote:
> 
> > Add support for HDMA NATIVE, as long the IP design has set
> > the compatible register map parameter-HDMA_NATIVE,
> > which allows compatibility for native HDMA register configuration.
> 
> I know the patch has been merged in dmaengine tree but something seems weird on
> my side.
> 

> The akida_dw_edma_probe function is selecting the minimum read and write

First of all. What is akida platform you are referring to? I failed to
find any mention in the mainline kernel repo.

> channels by doing the minimum between ll_wr_cnt and the ch_count callback.
> The hdma ch_count callback is counting the number of channels enabled by reading
> the number of ch_en registers set. At probe time there is no channels registers
> that has been set as it is done later in the dw_hdma_v0_core_start function.
> Then the dw_hdma_v0_core_ch_count will always return 0 at probe time and the
> number of channels will be set to 0 which is not what we want.
> Could I miss something?

Based on the HDMA patches content you are right. The channels must be
pre-enabled in order to have the dw_hdma_v0_core_ch_count() procedure
to work correctly otherwise you'll indeed end up with an empty list of
channels. I don't have any device with the HDMA engine embedded so I
couldn't have possibly tracked that peculiarity on review. Anyway
AFAICS Cai just implemented a method which seemed to work for his
hardware setup.

If you think it doesn't work correctly or it isn't portable enough
then you are free to provide your own implementation of the method and
submit a patch. I hope Cai will be willing to test it out to make sure
that it works correctly for you and his platforms.

As for me if I were on your place I would have implemented a loop
which would walk over all possible HDMA channels (HDMA_V0_MAX_NR_CH)
and counted all channels which could be enabled. If the ch_en CSR is
writable (that is the channel could be enabled) then it shall be
considered as existent. Of course before that I would have made sure
that the non-existent channels had non-writable ch_en CSR.

-Serge(y)

> 
> See the functions bellow:
> 
> > int akida_dw_edma_probe(struct dw_edma_chip *chip)                         
> > {                                                                          
>  ...                               
> >         dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,                        
> >                               dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));  
> >         dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);         
> >                                                                            
> >         dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,                        
> >                               dw_edma_core_ch_count(dw, EDMA_DIR_READ));   
> >         dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);         
> >                                                                            
> >         if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)                              
> >                 return -EINVAL;            
> ...
> }
> 
> 
> > +static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> > +{
> > +	u32 num_ch = 0;
> > +	int id;
> > +
> > +	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > +		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> > +			num_ch++;
> > +	}
> > +
> > +	if (num_ch > HDMA_V0_MAX_NR_CH)
> > +		num_ch = HDMA_V0_MAX_NR_CH;
> > +
> > +	return (u16)num_ch;
> > +}
> 
> 
> 
> > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > +{
> > +	struct dw_edma_chan *chan = chunk->chan;
> > +	struct dw_edma *dw = chan->dw;
> > +	u32 tmp;
> > +
> > +	dw_hdma_v0_core_write_chunk(chunk);
> > +
> > +	if (first) {
> > +		/* Enable engine */
> > +		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> ...
> > +}
> 
