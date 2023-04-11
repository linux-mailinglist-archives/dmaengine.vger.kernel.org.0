Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0B6DE1EE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDKRKm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKRKh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 13:10:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3101B0;
        Tue, 11 Apr 2023 10:10:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i26so11682205lfc.6;
        Tue, 11 Apr 2023 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681233034; x=1683825034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGizEsw3sJWfijdGwZY6mnVMilXLlUOHXy9YhsHlUGE=;
        b=Jy0sZt+9aCxhlmrgogjm1w1D1lzn4DzCHCcxXSgCbwEAB1IR/m6ykT7AYqeWjzaTOG
         BB8pYP+Fw9dG/pOAQRUHliVux19dMEcuwCjoM9lbUS+aTgwK0mvJeSSUB8n2OjuSFmRW
         0GVveDs8REUj1WRfbhwuMwqtCO6JKwnDD1B7Gyj7TKdymfgeUvb1mUZpkrfddgYgR87p
         VHUlWbLH3mBdEFoLOZDDrIlQnc0lgHPY5xEsL4KkArIyKwLjbGJRc226kj8RM2v2hrzK
         g4jfo765GYwdyAg5UTzHaZz5vxK20Uk/Bhvqt5sDED8Hh7LJcURuq6RA7eTkk3qS5OtZ
         klMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233034; x=1683825034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGizEsw3sJWfijdGwZY6mnVMilXLlUOHXy9YhsHlUGE=;
        b=qujTMfNDNPXkV7HNxnar6R9gys7XywJ/Ew6OD5Gk2uTudw5q9d5P4Th0P6vH+CUoFN
         S97rTjbnpkX0M99UGqOv3FWXNYzl+qAaVA4GRQHsmSADskD1FJkeh//A86izLUCvGbBU
         TC8QwU4edzo491udE3AWKBHZ5Xtwm+A/EToc1vXekvZoOB1XqOAKlcoaxlGw0IQEzhDM
         zTR2R0tfjJbIY1+lQZuAiSMAuYIg1LpWpLSOiPFb8mSy7EEQbwD4MTUro+H2ge8qrEr9
         0mDdUIAx7I1bDchTKzJ9PyYB6wp9VEeqqCxh6B93vG9WzejNGVI8COF5dvd61MLlDbQN
         g3KA==
X-Gm-Message-State: AAQBX9c9ZQuvZG1D7j2dezj7nx7wFzyPGLj1b4zQJ5igeT6HDJR3d+8/
        UM2nPvW+RGHYJou1Aifh9Oo=
X-Google-Smtp-Source: AKy350av0PRJeqs9sxWDSY7X+R5lmkQbWYkcOyM5ZwFuSFEZujQJmVEaDYiik8NSwxsT+zjPDl+lTA==
X-Received: by 2002:a05:6512:74:b0:4dd:ce0b:7692 with SMTP id i20-20020a056512007400b004ddce0b7692mr2950205lfo.46.1681233033766;
        Tue, 11 Apr 2023 10:10:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id r15-20020ac25a4f000000b004e848782e2esm2645007lfn.57.2023.04.11.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:10:33 -0700 (PDT)
Date:   Tue, 11 Apr 2023 20:10:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>, g@thinkpad,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v3 07/10] PCI: visconti: Convert to using generic
 resources getter
Message-ID: <20230411171030.jsyvwovlqeq7pplw@mobilestation>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-8-Sergey.Semin@baikalelectronics.ru>
 <20230411111947.GI5333@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411111947.GI5333@thinkpad>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 04:49:47PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 11, 2023 at 06:39:25AM +0300, Serge Semin wrote:
> > The generic resources request infrastructure has been recently added to
> > the DW PCIe core driver. Since the DT-bindings of the Toshibo Visconti
> > PCIe Host controller is fully compatible with the generic names set let's
> > convert the driver to using that infrastructure. It won't take much effort
> > since the low-level device driver implies the resources request only with
> > no additional manipulations involving them. So just drop the locally
> > defined clocks request procedures, activate the generic resources request
> > capability and make sure the mandatory resources have been requested by
> > the DW PCIe core driver.
> > 
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pcie-visconti.c | 37 ++++++++++------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> > index 71026fefa366..ae1517b52c58 100644
> > --- a/drivers/pci/controller/dwc/pcie-visconti.c
> > +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> > @@ -29,9 +29,6 @@ struct visconti_pcie {
> >  	void __iomem *ulreg_base;
> >  	void __iomem *smu_base;
> >  	void __iomem *mpu_base;
> > -	struct clk *refclk;
> > -	struct clk *coreclk;
> > -	struct clk *auxclk;
> >  };
> >  
> >  #define PCIE_UL_REG_S_PCIE_MODE		0x00F4
> > @@ -198,6 +195,21 @@ static int visconti_pcie_host_init(struct dw_pcie_rp *pp)
> >  	int err;
> >  	u32 val;
> >  
> > +	if (!pcie->pci.core_clks[DW_PCIE_REF_CLK].clk) {
> > +		dev_err(pci->dev, "Missing ref clock source\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (!pcie->pci.core_clks[DW_PCIE_CORE_CLK].clk) {
> > +		dev_err(pci->dev, "Missing core clock source\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (!pcie->pci.core_clks[DW_PCIE_AUX_CLK].clk) {
> > +		dev_err(pci->dev, "Missing aux clock source\n");
> > +		return -ENOENT;
> > +	}
> > +
> 
> Looking at the driver, I could see no call to clk_prepare_enable() for these
> clocks. So from kernel's PoV these are not used at all. So either these clocks
> are not required (unlikely) or enabled by the bootloader so kernel just uses it.
> 
> In that case, the driver should handle these clocks properly.
> 
> @Nobuhiro-San, can you please comment?

I will easily update the patch with a code enabling these clocks in
the visconti_pcie_host_init() method if @Nobuhiro-San are ok with
that.

-Serge(y)

> 
> - Mani
> 
> >  	visconti_smu_writel(pcie,
> >  			    PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
> >  			    PISMU_CKON_PCIE);
> > @@ -242,8 +254,6 @@ static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
> >  static int visconti_get_resources(struct platform_device *pdev,
> >  				  struct visconti_pcie *pcie)
> >  {
> > -	struct device *dev = &pdev->dev;
> > -
> >  	pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
> >  	if (IS_ERR(pcie->ulreg_base))
> >  		return PTR_ERR(pcie->ulreg_base);
> > @@ -256,21 +266,6 @@ static int visconti_get_resources(struct platform_device *pdev,
> >  	if (IS_ERR(pcie->mpu_base))
> >  		return PTR_ERR(pcie->mpu_base);
> >  
> > -	pcie->refclk = devm_clk_get(dev, "ref");
> > -	if (IS_ERR(pcie->refclk))
> > -		return dev_err_probe(dev, PTR_ERR(pcie->refclk),
> > -				     "Failed to get ref clock\n");
> > -
> > -	pcie->coreclk = devm_clk_get(dev, "core");
> > -	if (IS_ERR(pcie->coreclk))
> > -		return dev_err_probe(dev, PTR_ERR(pcie->coreclk),
> > -				     "Failed to get core clock\n");
> > -
> > -	pcie->auxclk = devm_clk_get(dev, "aux");
> > -	if (IS_ERR(pcie->auxclk))
> > -		return dev_err_probe(dev, PTR_ERR(pcie->auxclk),
> > -				     "Failed to get aux clock\n");
> > -
> >  	return 0;
> >  }
> >  
> > @@ -304,6 +299,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
> >  	pci->dev = dev;
> >  	pci->ops = &dw_pcie_ops;
> >  
> > +	dw_pcie_cap_set(pci, REQ_RES);
> > +
> >  	ret = visconti_get_resources(pdev, pcie);
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.40.0
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
