Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAA69A8F8
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBQKTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBQKTT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 05:19:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417660A57;
        Fri, 17 Feb 2023 02:19:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g16so1123446lfv.4;
        Fri, 17 Feb 2023 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCndEDoUtknwHJxWtOqquHmn6BtbW8GdekGsNECVWdg=;
        b=e+/CjwXji5eHjM7/meT9aSSjK0hOM9rnqj+8V8sDd5od3GlQSIZ/7z/7QktdAhdxjF
         VI0Ll5TNsvoFnNSGE5lFMvRT/QVfrQ1aN9CXUY4H99sWK/VrjNfABIfEfhkc6/lJvzXE
         jV+e6OtWkSTDLL4vh77hh747QwFMlkGN+Apx/FoYSwNkb6tB8GDPCaa5gm2UDHG8z/MD
         1cI67UjAvjZk01XComsdqloJR8qFlENfINxuq7lBIp0X/wdAHTIIdoMd07g1i6SHj1Fu
         N1qdM9VuoaPyK/5BHuiyBKZztRa0jtt+mgjQSEiW/NGRn71bWj/ELfZsQeojXW6nV4TR
         /pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCndEDoUtknwHJxWtOqquHmn6BtbW8GdekGsNECVWdg=;
        b=nc8KWvOJEY2Iypy7CN2YnGpiimXE+EXVsL3DU1MCqspi+3nTSr4ZlQ/+NtV7MD6J3B
         ZrEyxZ62IXlYI+hjhmS+DJs5tUTGlSkQzPaS9GLQbdwJJz29BZiOd+JZyco3uq5LS6Mz
         Y6JP3IdBn1lGLxRDJE1y539eHvH9/oafz/zDiNbPAza0CP/qIt/sjxiTxWHLl0HH9WOj
         tAEIS7Bej2lM42pZvd++WLqYw0bcNPvckKBb/MU/qfS5X4v8zOmNhB5M9R8BNPv/R0Wd
         WY6luLfv9/wmwUsfdwx5iy5OQP1nlk3f35F9VjfwwvM+JWY2qQoRI7NCrc2yCpw6CkS7
         Dt9Q==
X-Gm-Message-State: AO0yUKWa/yRwDSUHRfzsqRNO8kPKhtNgjwiH5IybAZYaaVHUExeV5huf
        at8qHtgyR7HIqwL1Z19LGT4=
X-Google-Smtp-Source: AK7set/KoPJ9iPu3vao4Dqv+7Ti4VzcdsvVWT9rrj+iUyGdqbOCgEq2dY6aOQQ9TccDkUjqrysyK/w==
X-Received: by 2002:ac2:5544:0:b0:4d7:2e11:d075 with SMTP id l4-20020ac25544000000b004d72e11d075mr2655581lfk.45.1676629156788;
        Fri, 17 Feb 2023 02:19:16 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004dc4d26c324sm633413lfh.143.2023.02.17.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:19:16 -0800 (PST)
Date:   Fri, 17 Feb 2023 13:19:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: dwc: Fix port link CSR improper init if CDM
 check enabled
Message-ID: <20230217101913.vomgrcwj7mv5apjq@mobilestation>
References: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
 <20230217093956.27126-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217093956.27126-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Feb 17, 2023 at 12:39:46PM +0300, Serge Semin wrote:
> If CDM_CHECK capability is set then the local variable 'val' will be
> overwritten in the dw_pcie_setup() method in the PL_CHK register
> initialization procedure. Thus further variable usage in the framework of
> the PCIE_PORT_LINK_CONTROL register initialization must imply the variable
> re-initialization. Alas it hasn't been taken into account in the
> commit ec7b952f453c ("PCI: dwc: Always enable CDM check if
> "snps,enable-cdm-check" exists"). Due to that the PCIE_PORT_LINK_CONTROL
> register will be written with improper value in case if the CDM-check is
> enabled. Let's fix this by re-initializing the 'val' variable with the
> PCIE_PORT_LINK_CONTROL CSR content before link-mode initialization.
> 
> Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

The same fix was submitted by Yoshihiro a bit earlier:
https://lore.kernel.org/linux-pci/20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com/
I've preserved my version of the patch in the series to ease the merge
procedure since the later patch in this patchset may cause conflicts.

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d5d619ab2e9..3bb9ca14fb9c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	}
>  
>  	/* Set the number of lanes */
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>  	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val &= ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
> -- 
> 2.39.0
> 
> 
