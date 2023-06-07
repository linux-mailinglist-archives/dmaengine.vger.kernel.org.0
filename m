Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFD725FB1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjFGMik (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbjFGMiV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 08:38:21 -0400
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62222210D
        for <dmaengine@vger.kernel.org>; Wed,  7 Jun 2023 05:37:42 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:37:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686141460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbSUneRrpRRxgvHrGM+5p7hzn6yFPde2yVURyvjw+yM=;
        b=gpwpYYtQYX4mfxfajxMwBtmUfqXQinKqcnf4WX92FlEVVz/4anG+rYBf5QiI4T5lmblvd0
        Qc/KHUvmIPJMrF9+bUYvFZF+dV+T7GnsiUwN50df1B/FgxeWv/2vF+YyB0wCNmEVauwHst
        4WqvCzCzG2nzUw9IxEZEzkBl/3P/7M0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     vkoul@kernel.org, Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <ZIB6DsAtDk3W8HLq@chq-MS-7D45>
References: <20230520050854.73160-1-cai.huoqing@linux.dev>
 <20230520050854.73160-4-cai.huoqing@linux.dev>
 <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607095832.6d6b1a73@kmaincent-XPS-13-7390>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07 6月 23 09:58:32, Köry Maincent wrote:
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
> channels by doing the minimum between ll_wr_cnt and the ch_count callback.
> The hdma ch_count callback is counting the number of channels enabled by reading
> the number of ch_en registers set. At probe time there is no channels registers
> that has been set as it is done later in the dw_hdma_v0_core_start function.
> Then the dw_hdma_v0_core_ch_count will always return 0 at probe time and the
> number of channels will be set to 0 which is not what we want.

will check it

Thanks,
Cai-
> Could I miss something?
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
