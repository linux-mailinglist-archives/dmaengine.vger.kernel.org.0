Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D47B6844
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJCLs7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJCLs6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 07:48:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70100A6;
        Tue,  3 Oct 2023 04:48:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503f39d3236so996973e87.0;
        Tue, 03 Oct 2023 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696333734; x=1696938534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m6tHL69a/PWxjome3u44isF/AAc7d6tUD65N4GlVjME=;
        b=XjNI/vs2w0juS/HSLsTNncKh/dxigZKM9dCWZFLBikXGr9ojIccSBgZC87tWyr9cEP
         s7R1hDbrBWlPXcRgEGg2XIAtD0NCSYLFDc0qrpNf9uGwIzXHNwG+YLKAhSPY0BsWZBGU
         wmbd6ArhiM+BxcK6W49BWT8glkUV0VsGI9ffxfdSPTmlU82rLFIvQrDES0+Hzf112aYL
         cwe2jPsEu4v1pzGjL3XMhp9LwnywCAWJE0rsmGFUWQlA3i5nNSDkLCyM+kCKHTz6fgYH
         kMvB2Gh/4zZ8kikNFJKUioOfheq3+NyCDVHprN0Ow0UC+PQff4OUIfkRgMSQ9uDIuEGd
         l6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696333734; x=1696938534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6tHL69a/PWxjome3u44isF/AAc7d6tUD65N4GlVjME=;
        b=ZePo7979Qjn9o99iFR2r5Jmj80h4S13PxYsxSaoK81gsU6bkzMcwR+QMvvU1qT/D0R
         q+sxUWW76SSaUsph2lnq8H3Tedua0gjumEsvhvhuZiF/TDYkB6vtAjk5GIB9PEyB72dv
         cEi3CA1f48lah/2clcXycORZ0LkHzdwCZFdXTdn1Ak1g/cT/ph8pQdASJ0DyAIbacqYr
         26ECTJXlnD0SH0uCCOEPvVGERUgkiltFnpFEGTuPeibiSygKcGoe0j/ggD7aJMV3u8pI
         bvM4BMyzH/h4cxT03H7BaGP/k7Hfs+H/GDTT5bwdUwqM2sMuZs+apw8egmyUWuQqLyEL
         ghgQ==
X-Gm-Message-State: AOJu0YwKIyM6ob7CkejuKmylJFfhV0ucXZyuwKozGzyzlncGK8F8UdUE
        nHp1g0nunEWNSgwhgA/tD2M=
X-Google-Smtp-Source: AGHT+IG0Bwm/NctqmFLWTNkm5va2FY1nJXTwB7VfDaYg1ys+9hRVreTuZR1ScnEOpwy6Yus8bv5T4g==
X-Received: by 2002:a05:6512:2521:b0:4f8:6abe:5249 with SMTP id be33-20020a056512252100b004f86abe5249mr11772250lfb.3.1696333733469;
        Tue, 03 Oct 2023 04:48:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t18-20020ac243b2000000b00500829f7b2bsm162581lfl.250.2023.10.03.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:48:53 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:48:49 +0300
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
Message-ID: <m6mxnmppc7hybs2tz57anoxq6afu2x63tigjya2eooaninpe4h@ayupt4qauq7v>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-5-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-5-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 03:17:48PM +0200, Köry Maincent wrote:
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
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 0cce1880cfdc..26b5020dcc2a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -221,6 +221,25 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +/**
> + * dw_hdma_v0_sync_ll_data() - sync the ll data write
> + * @chunk: dma chunk
> + *

> + * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
> + * configuration registers and Application memory are normally accesse

accessed

> + * over different buses. We need to insure ll data has been written before
> + * toggling the doorbell register.

1. Please replace "We need to insure ..." with "Ensure LL-data reaches
the memory before the doorbell register is toggled by issuing the
dummy-read from the remote LL memory in a hope that the posted MRd TLP
will return only after the last MWr TLP is completed".

2. Please move this comment to being above the if-statement. The
driver doesn't use kdoc at all. Having it for just a single function
doesn't look well, especially seeing it's static and isn't take part
of the kernel API.

> + */
> +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))

> +		/* Linux memory barriers don't cater for what's required here.
> +		 * What's required is what's here - a read of the linked
> +		 * list region.
> +		 */

1. The comment isn't that much informative. If it wasn't required then
why would have this been needed in the first place? Anyway just drop it since
you'll move the kdoc detailed comment to being above the if-statement.

2. Note the preferred style for the multi-line comments is:
   /*
    *...
    */
except for the networking subsystem. It's DMA so normal format should
be utilized. I know there are several comments in this driver which
are defined in the net-format. Just ignore them. These are legacy code
which should be eventually fixed to comply with the preferred style.

-Serge(y)

> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -251,6 +270,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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
