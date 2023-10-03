Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305E7B6CF2
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjJCPUe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjJCPUc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 11:20:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E35C6;
        Tue,  3 Oct 2023 08:20:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50573e85ee0so1247974e87.3;
        Tue, 03 Oct 2023 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346428; x=1696951228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6W20St9AUDpDFBNyugoMYR8+Qn4dlil3atLZEE5i40k=;
        b=Ua8+QRV3sZ99sRKlKC25DSkqwE23CHq+Eos3vQ8Ae08CB9YS7O6/ttrGAP3+/EA1wN
         XcrWIVxlzK6PntT06foDf8ZsO04PEdST1lIoowKqDngsEg6q78y51ZyT1jvZX3BrRx7I
         2Mb+TkjlqOIdxF4sHEYR/dsRspQsW/H/eHoZwHwyfphtYzWWixsIdVvoeRkJJ4ImgCbt
         yGbSlm9I5yygyAfnA7b05DhaLUkvtYHdbRzYltqcxq3KazZXXW8Dm/q2qoGMvLNO8sXX
         6c7bFat0cVHL9Dx/+75B8i+amoIjh5Y976/A9nEhQ9g/YbNUUjwpJO42ccyeM0SrGAjK
         9kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346428; x=1696951228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6W20St9AUDpDFBNyugoMYR8+Qn4dlil3atLZEE5i40k=;
        b=Y5nOnUKbUtyDgdeNORhs3VNIFqkpWd5ZSEpUW7VEzy0wunOiSDbGxHKG6EvpSi9SuT
         i4NfaNsuBC5Rec0JUt+mjwxScAX6iwbGJtbL/njzXBNCxSYI8i+PBxxZQDGpRvmygrPr
         qlWttRS5a1mvdWBRlpuyHvec9n+DSksNlHP/jnSkISlhcVsNXEN+fyfFQPDAEslkzYgj
         c4o571f+AtghwkaXuCNngVGRq0fxsra8zmLwXXJ/DbIKLzKrJvLGS942XKc3zER4dywm
         DqMuVrUhUBZl+Y7D2PReTjDqrASDMpAibuRf1b1yiR23tF4fa3VdAJIiGPxrbP9Fba5+
         MT/w==
X-Gm-Message-State: AOJu0YyZBt8nh5EF+VNAsdiBo9Vg2CO4lX2pbuUvZMdVm9m0A6ESFWUr
        AGL7Hv8pEyDvITPpI6ueEI4=
X-Google-Smtp-Source: AGHT+IHqPWs0sH1E101Rja23QIH+UT00iRKC9sEArefggB80uHbjbDH1bSl/u09z8I41ZW8fvH2Liw==
X-Received: by 2002:a05:6512:10cd:b0:503:5d8:da33 with SMTP id k13-20020a05651210cd00b0050305d8da33mr14322552lfg.20.1696346427546;
        Tue, 03 Oct 2023 08:20:27 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u25-20020ac248b9000000b0050318721b62sm223813lfg.6.2023.10.03.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:20:27 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:20:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 4/5] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <2yh3lus7qqhvewva6dr4p2g7azbgov4ls57xvzefbrw24h2t7m@cbx26pwj73zn>
References: <m6mxnmppc7hybs2tz57anoxq6afu2x63tigjya2eooaninpe4h@ayupt4qauq7v>
 <20231003121542.3139696-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003121542.3139696-1-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 03, 2023 at 02:15:42PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The Linked list element and pointer are not stored in the same memory as
> the HDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error can appears.
> In remote setup we can only use a readl to the memory to assured the full
> write has occurred.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Move the sync read in a function.
> - Add commments

Note you need to resubmit the entire series if any of its part has
changed. So please add these patches to your patchset (in place of the
4/5 and 5/5 patches I commented) and resend it as v3.

-Serge(y)

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 0cce1880cfdc..9109dd6c2e76 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -221,6 +221,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
> +	 * configuration registers and Application memory are normally accessed
> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the
> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -251,6 +265,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	/* Set consumer cycle */
>  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
>  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +
> +	dw_hdma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
> -- 
> 2.25.1
> 
