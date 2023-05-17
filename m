Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88FC705F5D
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 07:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEQF3s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjEQF3r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 01:29:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638573C32
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:29:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f42c865534so3163125e9.2
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684301384; x=1686893384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3F8/AW2YhS524kwApvlgE1HyyL1L1DLl+/WPH6DtX7A=;
        b=h9lCWonhhhnN+AX6OpIB6aZNqqvYduly1ePB/NfOSldi5Y6cEBxJTENZ/PpIkikAFb
         MPrKQpUSt4ll2TQ5bowzaFRCR/ljzToP1mdaXjf0t7p1aR2T0qcdUZuyat7zVjOxfxo8
         kxxHZ9d0N8opIM/YTMSyVPUNRS8qO9j2eyRy4TNMlUNSQAZEmr777IIrPbz9mILJ8rRg
         ULopXMrMNhtpjQ1liGjG/jvacQzLddsJ2Cc0Q/Mo8CEVp9ws1p5AKQmsyoT2yaMHuM6m
         yQ1ozpbAbtFiGWSc6EaK0QTWo3uutLwrP29h9c4Ahl4TiFRfCWaO/YgPWgRLqvsM3e7F
         6Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301384; x=1686893384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F8/AW2YhS524kwApvlgE1HyyL1L1DLl+/WPH6DtX7A=;
        b=a6E76fyERaLhyhDu18haDM58i1fXN/emoq5p4paQcBKQXKdJL6yfOmpCW6yfshzr3z
         h7jFYIbNaDL0T71tM27jUjKyvy5+BUKivyUQeOOLi1KzvkisaHh1F79HmdBgIhYY9AMA
         2FyXRyQmQYlmoQnPC29kH2L+E32LIb6arPhVA8WlKx8CTRk+mHNDam+O34FnF9m4DbCt
         1bl0x64WTR+iqV0Kj186z7LGweJTUTxBZDyOREVsRFI2BGSNdPWABOmQoxESBURrE+EQ
         CxtdxvGmkU9kDZE5n/NFrSxFUFk0rmacQfQFpxsxzVTfcsFnMB4yyZwNyY2htTHo8sSX
         qs+A==
X-Gm-Message-State: AC+VfDya/Y8/Q/yvy3axvX5VX9aLiNxnYMRBauLSbzfnYuLybYwZU3zO
        CgNyh3Qb2f/Th4EzRsy6QcyT
X-Google-Smtp-Source: ACHHUZ5ksGFQ1nf8hqH9xs6F/ZmG9c8Vw62ReSZJ3HBA5wVNxQV6WoALBJfqC5cZ6ajlEKSQASudnw==
X-Received: by 2002:a05:600c:228e:b0:3f4:2174:b28a with SMTP id 14-20020a05600c228e00b003f42174b28amr30103996wmf.15.1684301383767;
        Tue, 16 May 2023 22:29:43 -0700 (PDT)
Received: from thinkpad ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003f1957ace1fsm939977wmk.13.2023.05.16.22.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 22:29:43 -0700 (PDT)
Date:   Wed, 17 May 2023 10:59:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
Subject: Re: [PATCH RESEND v5 07/14] PCI: visconti: Convert to using generic
 resources getter
Message-ID: <20230517052931.GB4868@thinkpad>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511190902.28896-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 11, 2023 at 10:08:55PM +0300, Serge Semin wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

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
