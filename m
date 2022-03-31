Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E434ED7F7
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiCaKw2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 06:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiCaKw1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 06:52:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79DA1BD821
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 03:50:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so23673317pjb.3
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TFELa/BZuowaDfyw6gLBEGWo6cMiLelNfLx1iN1T5dc=;
        b=xRUfPHjylfqLEN+GuozHZIJyZSu8beHyqGl0lThSL2k+CIVh326KQ7XLznpBpIYXVy
         nJkX2+7K1qmc6LWIdV+7Eef7yJN0apSodE4yKQZCyIS4Z/Y8n632+DgD/WNtA2xMGnty
         lhxbFHyGkGUsoBYuDAt3UzwO3KpjbCmyK0arjpZJ2313PYXEEdiCM745LNy0oFwJ9C+o
         iVLI6vrZ/3EnmLAGDVNFUY0fAQqL1WkwV7QRgRyDkjL1yixINjhPYGvc9Z3tYgB/kZR5
         WrIy526oG2wvYyUoT9J8wkp8A+Cr0vmPUA6AWlYPiVaBpYrYxWjVUIplpxGq5H9zktAK
         aIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TFELa/BZuowaDfyw6gLBEGWo6cMiLelNfLx1iN1T5dc=;
        b=uyVMj8Qy1oxD6AaCsc737vYNsLpaRDoTugXqm0x3k2GMlODbYco9rAW/HEv3OTwd6L
         1xJNzXNxnonNtM83ysJ0zl18O31UvcrKPsqvQ9R9oZH3JbxO7OJnjQ7sdYcPp5Fusei8
         sc+2IDp0+I67aOHKTCTsxV2jv+mU7Q1m9fQNZOKY6LEncjOu008aoSktb1JPe0ld0Ghw
         q6shBGiNbZ+r5NV6IwW2krxQE6LKVUCAyIjtfKjMJrso2CDez3jZzkLitqgrUgxb5T7k
         W2s9zUTYm7np8Ma6ymsPkiZVkFzeyL/joT+K6X81cJiRfWoTetfS1KaObpqxlljUwch0
         TnvQ==
X-Gm-Message-State: AOAM5328AoWHrUV2avDI+H49iUANwm8q9dx5y+nlQtyNA8m11Kmwdloj
        j444+K40TjFwQHk/qPT1wk8D
X-Google-Smtp-Source: ABdhPJwUUVxU0eN0GZxw3u2enZxMyHOLpRn++pTKQ1RQI4MCgLEuOovkVsLaARG0uoZ++MAPnjssgQ==
X-Received: by 2002:a17:90b:3851:b0:1c7:80f9:5306 with SMTP id nl17-20020a17090b385100b001c780f95306mr5326698pjb.207.1648723839269;
        Thu, 31 Mar 2022 03:50:39 -0700 (PDT)
Received: from thinkpad ([117.202.187.183])
        by smtp.gmail.com with ESMTPSA id kb13-20020a17090ae7cd00b001c7de069bacsm10163825pjb.42.2022.03.31.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:50:38 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:20:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
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
Subject: Re: [PATCH 04/25] dmaengine: Fix dma_slave_config.dst_addr
 description
Message-ID: <20220331105031.GA104799@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
 <20220324140806.GN2854@thinkpad>
 <YkU+PupmoR/zkHxn@matsya>
 <20220331071343.eitijsfuzufh6blc@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331071343.eitijsfuzufh6blc@mobilestation>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 31, 2022 at 10:13:43AM +0300, Serge Semin wrote:
> On Thu, Mar 31, 2022 at 11:08:06AM +0530, Vinod Koul wrote:
> > On 24-03-22, 19:38, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 24, 2022 at 04:48:15AM +0300, Serge Semin wrote:
> > > > Most likely due to a copy-paste mistake the dst_addr member of the
> > > > dma_slave_config structure has been marked as ignored if the !source!
> > > > address belong to the memory. That is relevant to the src_addr field of
> > > > the structure while the dst_addr field as containing a destination device
> > > > address is supposed to be ignored if the destination is the CPU memory.
> > > > Let's fix the field description accordingly.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > One suggestion below.
> > > 
> > > > ---
> > > >  include/linux/dmaengine.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > > index 842d4f7ca752..f204ea16ac1c 100644
> > > > --- a/include/linux/dmaengine.h
> > > > +++ b/include/linux/dmaengine.h
> > > > @@ -395,7 +395,7 @@ enum dma_slave_buswidth {
> > > >   * should be read (RX), if the source is memory this argument is
> > > >   * ignored.
> > > >   * @dst_addr: this is the physical address where DMA slave data
> > > > - * should be written (TX), if the source is memory this argument
> > > > + * should be written (TX), if the destination is memory this argument
> > >
>  
> > > Should we rename "memory" to "local memory" or something similar?
> > 
> > what do you mean by local memory :)
> 
> Most likely Manivannan just confused the whole eDMA device specifics
> with this patch purpose. This commit has nothing to do with "local"
> and "remote" device memory. Such definitions are relevant to the DW
> eDMA setups (whether device is integrated into the PCIe Host/End-point
> controller then the CPU memory is a local memory for it, or it's a
> remote PCI End-point, then the CPU memory is a remote memory for it).
> 

Ah, yes indeed. While I was reviewing the eDMA patches I just went with that
context. Sorry for the noise.

Thanks,
Mani

> Guys. Regarding the patchsets review procedure. I notice all the
> comments. Just didn't have time to respond so far. Will do that till
> the end of the week.
> 
> -Sergey
> 
> > 
> > -- 
> > ~Vinod
