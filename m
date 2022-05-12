Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62F45253CD
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357113AbiELRin (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356959AbiELRim (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 13:38:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AD5DA7E;
        Thu, 12 May 2022 10:38:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p26so10333018lfh.10;
        Thu, 12 May 2022 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vZvTlrJYt+b8R7ehZmMqdHwToDN9FaTAo0nb7F19JWE=;
        b=QU3BtwylRmSLrk4v/VGxeLSkgCsMMGlmA5r2K4qPM0Wzt6sURVzXDprRsrWGiMqMQO
         XGO1WjSvN/dUlsnbZxXBjp4yO1Pe+yMdgE33W+Non+Cu2Z4gfFW2gd1g0NXIL3lCU2As
         GkzzWRpQtUekBVZHMZNaaAR2DgbUYZjwx4S1WUVbCKzdWmEBv+tqxLZGW/F+ObonyFx/
         39b5EOR5ruO8IMhHdfD5mpdTq5+Tcsy64UDrcnMFTsuRDMJsSh+H58X5xgMwnrh/Nae7
         YmecFrv2Mb1HAcvo+SpW0Xxr/xypXAtnYZ4C/IzHiqBROeofyk7uAE9gqfSx33UcxV7E
         XLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vZvTlrJYt+b8R7ehZmMqdHwToDN9FaTAo0nb7F19JWE=;
        b=ZrVSF2xrHJ0CLtIK8G69TgqPCPuTXWLEOHdosKTLI3M7gNRZL+WTz+sTSMN3mMS4V+
         UMMGzbsDIl8I4rYcWYtMbwVWCMf6Gj2Tmi/MYe5U2gAUBjQwFyWWbLOusVC7Btqmo9NG
         /RiVkNTENznVkBnSme9W9Wpku3ya/PvTvKKGIfVkRqD0uYLvbm/41jQwAPcemSp+WDZN
         VF+YEzatRo2MW3aSQORBtS915zrL+CajqWGFNbSMfy9pAQ3FvRJ1vbPNeavuj1a9i8ix
         VNhTfsUDghHagFYVJWce9zj9MJmouoKxd/AsGsAfqXlyJcgXOP1EYPWKuMIFhHyRmTsI
         saDQ==
X-Gm-Message-State: AOAM5313iCbEV3+k24WkoqmUqUYe+J/Gzez11L4yjE7VyVVps6jWwt5W
        cU0qKU/AHrq41VnBQ7GHTtY=
X-Google-Smtp-Source: ABdhPJyxmuiydmPxJbQNTIGcdclos+z6jvgx8M/o9YDj+8rLLVPMLo1zvWIGcOV6oUiNnHazYn1dTg==
X-Received: by 2002:a19:ae0a:0:b0:472:d3e:8312 with SMTP id f10-20020a19ae0a000000b004720d3e8312mr645513lfc.176.1652377119219;
        Thu, 12 May 2022 10:38:39 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e3008000000b00250664c906asm6673ljw.133.2022.05.12.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:38:38 -0700 (PDT)
Date:   Thu, 12 May 2022 20:38:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/26] dmaengine: dw-edma: Skip cleanup procedure if
 no private data found
Message-ID: <20220512173835.ffboven6wbtswkek@mobilestation>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-25-Sergey.Semin@baikalelectronics.ru>
 <20220512152354.GO35848@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512152354.GO35848@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 12, 2022 at 08:53:54PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 04, 2022 at 01:51:02AM +0300, Serge Semin wrote:
> > DW eDMA driver private data is preserved in the passed DW eDMA chip info
> > structure. If either probe procedure failed or for some reason the passed
> > info object doesn't have private data pointer initialized we need to halt
> > the DMA device cleanup procedure in order to prevent possible system
> > crashes.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 

> As I said in the previous iteration, I'm not sure we will hit this issue.

It's unlikely but still not impossible. Consider the case when your DW
PCIe controller has eDMA capability, but the platform code isn't ready
to have it properly utilized. In that case dw_edma_probe() will fail
at some point while the rest of the DW PCIe code will go on executing
ignoring that error. In that case calling the dw_edma_remove() will
cause the system crash since the dw_edma_chip.dw pointer will be left
uninitialized. For instance possible circumstances can be as follows:

dw_pcie_host_init()
+-> dw_pcie_edma_detect() FAIL ignored.
+-> pci_host_probe() FAIL goto err_stop_link
                      |
                      +-> dw_pcie_edma_remove() CRASH !!!

So to be on a safe side we need to make sure the DW eDMA descriptor
cleanup is skipped in case if it hasn't been properly initialized. The
proper initialization is indicated by having the dw_edma_chip.dw set
with the valid pointer to the private data.

> But I don't object the patch. So,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.

-Sergey

> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 908607785401..561686b51915 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1035,6 +1035,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  	struct dw_edma *dw = chip->dw;
> >  	int i;
> >  
> > +	/* Skip removal if no private data found */
> > +	if (!dw)
> > +		return -ENODEV;
> > +
> >  	/* Disable eDMA */
> >  	dw_edma_v0_core_off(dw);
> >  
> > -- 
> > 2.35.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
