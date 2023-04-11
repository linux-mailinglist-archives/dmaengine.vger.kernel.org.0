Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA86DD93A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 13:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDKLUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDKLUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 07:20:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD5A3596
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:19:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso10599175pjs.0
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBQKs0yhrvEAfRkMdCXLMJEOrscAPx9qxfkvCvvtvfA=;
        b=De8rEAx354hB6hCSAFG7oboildxqBheGwOenVHFkWMblMsEkD/+0eXo3/mG3rs50An
         kWw6C+C1M0ZQYjSdptI7/XL7b7De17BuGhpwihSva0I7dBeuWkopYTYE5YknBky9lh6V
         ZYPYPdkcmyCoZ2cpaG00j0m4uJVD7j/GBY62PsI0WbCEOLfOGRAd5wlMGbodFnIsUBB6
         LZgDClnNxNxLNRQD5aZTK9Y7wFJte8LGWQ3fFk5wg0M4DXT+7IBWF7Vz0HQKcQ1qaMjc
         ghgexkw/J/rpGBBEFFmi3kOC02bR2+0PlHaur/1EpYHt5InoQ74/wSO1TDtSZarYDx40
         qrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBQKs0yhrvEAfRkMdCXLMJEOrscAPx9qxfkvCvvtvfA=;
        b=OnmNV2QFg611yfiKTsorJ7DxSpq2wtkXcjplVeQdKIw9T0fBJQ2U3g/XJC0oCBcEBE
         ugiOnmKTMA2ix1zPOCzLQLPkjxXjXCkwEANnb50cy7wozt/4EPoPXw6TQRSPYFPyO8m9
         X48+ndE8/+EGQe2zOrOV3pmYqi3EJ0DL1lZa1G+nFm9LJAEU51fN93TfeRMZEzJzp2wQ
         wON5h1AXuPeFRhNwnNUUI02XZxEnjB6mFMo3RUmji3MwZQGfYZegTBRXBEdrXUnXNdZD
         Zn3jliBGmVfOZhuDSVTYXavF4XyXFMTwm7DRnxHceYyIg788qLZw2n9l8EmCEY74X2/0
         fNSw==
X-Gm-Message-State: AAQBX9eoUXMnXmA0gLl7Qq9OjUJ3mR9U6g2C6XBgkqZBeUwflWtYs6tm
        siHTbfrAJFOg3lRZkIAz1yP4
X-Google-Smtp-Source: AKy350ZLs5F0geBGQzE6rxmOTmSs4MmcKy9zI+Tw9XY3R2ci0J/2ubUrzPs0XDNuJTJil32p2+2knQ==
X-Received: by 2002:a17:902:cec1:b0:19e:ad18:da5c with SMTP id d1-20020a170902cec100b0019ead18da5cmr3463701plg.37.1681211999280;
        Tue, 11 Apr 2023 04:19:59 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b0019e60c645b1sm3539765plb.305.2023.04.11.04.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:19:58 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:49:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>, g@thinkpad
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v3 07/10] PCI: visconti: Convert to using generic
 resources getter
Message-ID: <20230411111947.GI5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:25AM +0300, Serge Semin wrote:
> The generic resources request infrastructure has been recently added to
> the DW PCIe core driver. Since the DT-bindings of the Toshibo Visconti
> PCIe Host controller is fully compatible with the generic names set let's
> convert the driver to using that infrastructure. It won't take much effort
> since the low-level device driver implies the resources request only with
> no additional manipulations involving them. So just drop the locally
> defined clocks request procedures, activate the generic resources request
> capability and make sure the mandatory resources have been requested by
> the DW PCIe core driver.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-visconti.c | 37 ++++++++++------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> index 71026fefa366..ae1517b52c58 100644
> --- a/drivers/pci/controller/dwc/pcie-visconti.c
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -29,9 +29,6 @@ struct visconti_pcie {
>  	void __iomem *ulreg_base;
>  	void __iomem *smu_base;
>  	void __iomem *mpu_base;
> -	struct clk *refclk;
> -	struct clk *coreclk;
> -	struct clk *auxclk;
>  };
>  
>  #define PCIE_UL_REG_S_PCIE_MODE		0x00F4
> @@ -198,6 +195,21 @@ static int visconti_pcie_host_init(struct dw_pcie_rp *pp)
>  	int err;
>  	u32 val;
>  
> +	if (!pcie->pci.core_clks[DW_PCIE_REF_CLK].clk) {
> +		dev_err(pci->dev, "Missing ref clock source\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!pcie->pci.core_clks[DW_PCIE_CORE_CLK].clk) {
> +		dev_err(pci->dev, "Missing core clock source\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!pcie->pci.core_clks[DW_PCIE_AUX_CLK].clk) {
> +		dev_err(pci->dev, "Missing aux clock source\n");
> +		return -ENOENT;
> +	}
> +

Looking at the driver, I could see no call to clk_prepare_enable() for these
clocks. So from kernel's PoV these are not used at all. So either these clocks
are not required (unlikely) or enabled by the bootloader so kernel just uses it.

In that case, the driver should handle these clocks properly.

@Nobuhiro-San, can you please comment?

- Mani

>  	visconti_smu_writel(pcie,
>  			    PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
>  			    PISMU_CKON_PCIE);
> @@ -242,8 +254,6 @@ static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
>  static int visconti_get_resources(struct platform_device *pdev,
>  				  struct visconti_pcie *pcie)
>  {
> -	struct device *dev = &pdev->dev;
> -
>  	pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
>  	if (IS_ERR(pcie->ulreg_base))
>  		return PTR_ERR(pcie->ulreg_base);
> @@ -256,21 +266,6 @@ static int visconti_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie->mpu_base))
>  		return PTR_ERR(pcie->mpu_base);
>  
> -	pcie->refclk = devm_clk_get(dev, "ref");
> -	if (IS_ERR(pcie->refclk))
> -		return dev_err_probe(dev, PTR_ERR(pcie->refclk),
> -				     "Failed to get ref clock\n");
> -
> -	pcie->coreclk = devm_clk_get(dev, "core");
> -	if (IS_ERR(pcie->coreclk))
> -		return dev_err_probe(dev, PTR_ERR(pcie->coreclk),
> -				     "Failed to get core clock\n");
> -
> -	pcie->auxclk = devm_clk_get(dev, "aux");
> -	if (IS_ERR(pcie->auxclk))
> -		return dev_err_probe(dev, PTR_ERR(pcie->auxclk),
> -				     "Failed to get aux clock\n");
> -
>  	return 0;
>  }
>  
> @@ -304,6 +299,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	dw_pcie_cap_set(pci, REQ_RES);
> +
>  	ret = visconti_get_resources(pdev, pcie);
>  	if (ret)
>  		return ret;
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
