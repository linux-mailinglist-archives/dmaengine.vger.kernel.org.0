Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E999700525
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjELKXY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbjELKXT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 06:23:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F212E;
        Fri, 12 May 2023 03:23:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac82b07eb3so98657001fa.1;
        Fri, 12 May 2023 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683886995; x=1686478995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z23Yys1p+WjW6kez7AKqzscsQbDlp8fVQx68w5qJUf0=;
        b=QLxxlk7MAaNJPed+IR4tg9xzx6vEcv8gKoLQ6ByxBWOcNZ9jyZ30AS++w3IpXEGLoR
         fRsPFHc1ruZI15eGdoeG3wMZxlAwlijYfl+2ZW/JaGUwmqne1y7+EHzOlD+WGcq3GSdP
         Cnf6R1q30GjdiH0o9r1gzP+JceFDwLmUIMg4fRJLAXY9qyncDjkGgUqVrhOiXQNkaWdC
         sxDoqzeSXepMiqWuUb/LdYSjVQ0ocITH/GiIVFGXEh+Mp0QwXzROvF99IS3Htxv2PlLO
         MlaHTilNWlMSN0cPjactSPfSy7+Z15kkiKpRoWIQC77P53yfvfT6hnAaGxyG4HK1WcaV
         Ww8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886995; x=1686478995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z23Yys1p+WjW6kez7AKqzscsQbDlp8fVQx68w5qJUf0=;
        b=DWCgwlVQ6y3IopMWUZo6a6LrYdhL+/vaRvjWxpnLIuty46IG05tXsqhtY9oLoiLUCf
         DX07Onn8xawh+XcUAfhJEZtRmlXnGPyvB3k4YACjOHiCtymAgAvNu4VZrhz9GCTrmqJ4
         HN4LVZCqNnCkD8olHFGkpE+/yg9J8NOd7UXIUIiLof0VsEV1eSiG4wwru9l+8Y01vF2M
         7fwD1jswOQPztfaN6gijrPbY+9EVyiCUb1Tu6xRwt0rMoiRyD3cu4rpNyg92XlOPWH43
         CVo8X0hfVoJ9RwHzq1oWd68IKI3b6TxcoU9QM3rjE2jCzThKdjyBcF+q7Q3sCG+ouFFq
         T5KQ==
X-Gm-Message-State: AC+VfDwh18X8orLll2DbuAhWFXTwuiCyFFv2WZEFF+mOaAPdMYC1lA1P
        pZasvMpqpfCAHxlqkr3o7ofnfynd9pBYvg==
X-Google-Smtp-Source: ACHHUZ5K0zQw3IvYCqgKgG7ihj2MX8VyXEJ28EGTiVj+V+XjGCuXuPDxUGlINZ4EwJUydXsHR99biA==
X-Received: by 2002:a2e:9f14:0:b0:2a8:d103:dc8 with SMTP id u20-20020a2e9f14000000b002a8d1030dc8mr3596263ljk.2.1683886995331;
        Fri, 12 May 2023 03:23:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o6-20020a2e90c6000000b002adaacdb900sm1299548ljg.42.2023.05.12.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:14 -0700 (PDT)
Date:   Fri, 12 May 2023 13:23:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v5 01/14] PCI: dwc: Fix erroneous version type
 test helper
Message-ID: <20230512102312.urrh2gwagopizn44@mobilestation>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-2-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB53411830C969326CDA5E9DF5D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53411830C969326CDA5E9DF5D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Yoshihiro

On Fri, May 12, 2023 at 09:55:42AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Friday, May 12, 2023 4:09 AM
> > 
> > Due to an unfortunate mistake the macro function actually checks the
> > IP-core version instead of the IP-core version type which isn't what
> > originally implied. Fix it by introducing a new helper
> > __dw_pcie_ver_type_cmp() with the same semantic as the __dw_pcie_ver_cmp()
> > counterpart except it refers to the dw_pcie.type field in order to perform
> > the passed comparison operation.
> > 
> > Fixes: 0b0a780d52ad ("PCI: dwc: Add macros to compare Synopsys IP core versions")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I'm not sure whether my review is useful or not, but anyway,
> 
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

It's always useful. Thanks for looking into it.

Regards
-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 79713ce075cc..adad0ea61799 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -37,17 +37,20 @@
> >  #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
> >  	((_pci)->version _op DW_PCIE_VER_ ## _ver)
> > 
> > +#define __dw_pcie_ver_type_cmp(_pci, _type, _op) \
> > +	((_pci)->type _op DW_PCIE_VER_TYPE_ ## _type)
> > +
> >  #define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
> > 
> >  #define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
> > 
> >  #define dw_pcie_ver_type_is(_pci, _ver, _type) \
> >  	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> > -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
> > +	 __dw_pcie_ver_type_cmp(_pci, _type, ==))
> > 
> >  #define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
> >  	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> > -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
> > +	 __dw_pcie_ver_type_cmp(_pci, _type, >=))
> > 
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
> > --
> > 2.40.0
> > 
> 
