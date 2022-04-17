Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D15049E1
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 00:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiDQXCL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Apr 2022 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDQXCK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Apr 2022 19:02:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26275186DF;
        Sun, 17 Apr 2022 15:59:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so21804201lfa.12;
        Sun, 17 Apr 2022 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ROVpwKBOGufZnUhrFjDPYpbkcctk8UV5TfBk27pyiU=;
        b=NJlluwkowcUnCAKhM2F46usS0bm6ZeGMD52J98Rb6kPIUUNXrQ8tIpLc84J7b6mng1
         OsGYvZGMIsZIcnMfEgwmxycr0EpZD4r+d6jNlJ9g7+8lBryEcuKL7xIaC4UlDVAVN4uf
         VqFwkA+bee1K8gwZKIpb68C9/cwEvup9AiqVKp8MpcK/V5/7POMeQcv5tMchUr9o9lJg
         qV3NIf8+gsGYG3yxWw9aBNFQac5F1V1AVMdvs9K21ywhBWX36Chq31V1yOqRwm7KPJyB
         CiDctPfJcq5TKqjTZy2x0MZdfhNP5gKmCgZE6EF1v0LE34/I0666CEzef20giu/Wz++9
         zlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ROVpwKBOGufZnUhrFjDPYpbkcctk8UV5TfBk27pyiU=;
        b=jVftZJiPsMjcmpcIikWmT8XO6A49u+0RirlAiI84pUYKG96HlyL224vV6wmMT3yOgX
         xKFhnUfL0X08cv9w4CJD6SSyGGUELVR7VuwPuy9n2PAxoRQ8FTKfauHY0+orm4Z6Ok6/
         2zomm/0PSgsex1FL/3YvMjOR0rpR84s+fpbZEWmAgN7F4hebT0P+9kO0bnfCs5G5gtOU
         lBYq2UgMbOYif6t45/ZOLPXZkAzTAfnyd9QmJWKNPaNr4aaqRazYXpQ20vgEqdUAjjJX
         de7TslXdrhnfxwbRJkPINNZPd6ZFCXacBCH9a0mgSyFCtAq0Jt6vrgMQQKIi0VnOAIK8
         +3Tg==
X-Gm-Message-State: AOAM5317M12uVRoNuyag+h4qvrLQRbb0OK2KYHKHZ7BUvn2w9xxLQdaX
        kpe3DXbR/B1Yjm883JpINzs=
X-Google-Smtp-Source: ABdhPJxM/LTwQ8WZm8NMx6Nz2gw5KBeesGpwkCCcMEKYQbc6pK26vsCoBy7Ne776TgV6fCVPBMrr9A==
X-Received: by 2002:a19:da12:0:b0:46b:926f:d34b with SMTP id r18-20020a19da12000000b0046b926fd34bmr6111288lfg.646.1650236371270;
        Sun, 17 Apr 2022 15:59:31 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id 10-20020a2e080a000000b00247f82bbc6fsm995697lji.54.2022.04.17.15.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 15:59:30 -0700 (PDT)
Date:   Mon, 18 Apr 2022 01:59:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] dmaengine: dw-edma: Don't permit non-inc
 interleaved xfers
Message-ID: <20220417225928.fx7ihadz6mg2xthg@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-8-Sergey.Semin@baikalelectronics.ru>
 <20220324171512.GQ2854@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324171512.GQ2854@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 10:45:12PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:18AM +0300, Serge Semin wrote:
> > DW eDMA controller always increments both source and destination
> > addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
> > flags set may lead to unexpected behaviour for the device users. Let's fix
> > that by terminating the interleaved transfers if at least one of the
> > dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
> > value. Note in addition to that we need we need to increase the source and
> > destination addresses accordingly after each iteration.
> > 
> 

> Can you please point me where this gets documented in databook?

10.3.1 Source and Destination Address Registers (SAR, DAR)
"...  You program the start of the local and remote data buffers using
these registers, and the DMA increments the SAR and DAR as the DMA
transfer progresses. ..."

[1] DesignWare Cores PCI Express Controller databook, v4.70a, March 2016,
    p. 882.
[2] DesignWare Cores PCI Express Controller databook, v5.40a, March 2019,
    p. 1110.

-Sergey

> 
> Thanks,
> Mani
> 
> > Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 2010d7f8191f..f41bde27795c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -386,6 +386,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  			return NULL;
> >  		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
> >  			return NULL;
> > +		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
> > +			return NULL;
> >  	} else {
> >  		return NULL;
> >  	}
> > @@ -485,15 +487,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  			struct dma_interleaved_template *il = xfer->xfer.il;
> >  			struct data_chunk *dc = &il->sgl[i];
> >  
> > -			if (il->src_sgl) {
> > -				src_addr += burst->sz;
> > +			src_addr += burst->sz;
> > +			if (il->src_sgl)
> >  				src_addr += dmaengine_get_src_icg(il, dc);
> > -			}
> >  
> > -			if (il->dst_sgl) {
> > -				dst_addr += burst->sz;
> > +			dst_addr += burst->sz;
> > +			if (il->dst_sgl)
> >  				dst_addr += dmaengine_get_dst_icg(il, dc);
> > -			}
> >  		}
> >  	}
> >  
> > -- 
> > 2.35.1
> > 
