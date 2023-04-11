Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C566DD8D0
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDKLFV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 07:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjDKLFU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 07:05:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E3244A3
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:04:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p8so7521371plk.9
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nFXSqQEvm7WLdQYFLs/odUV6nM3s17jTlqmzGXgnsF8=;
        b=Mv6PhdV9pezPBL2JvF7UN8LNkuRUTjH/rvz6xm1Zq7XP3k/jPnyD1uP3jdkYy8YOCi
         oLP9t3Cl2IhSsaqGNr7lfjmBV5hmSsdn5LLjAAWamK3vfCQM35/KMEC2lbFFgBCM8Vm8
         7XMMG7KgllQUyUNfUE+TMSjg4IFwsOAmDylKiaoFQ02wBisqtupXkRK0x5zpYhCh0wWK
         d6UuLzn+x3Yu9wBAeINXV/zUUj6YWFZdg920y949OpmKAPFk3HdRqv/pniIX+UDFUqyZ
         fsOUEBRscUW5M7BHVPjVssyjRqrch53BjK4OUdy0d0UyVj7byvLPxFnKePzTKgkrfoJo
         ffdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFXSqQEvm7WLdQYFLs/odUV6nM3s17jTlqmzGXgnsF8=;
        b=4qUpehvYaR0TAfuC5FfKx33QxhR6SWJaLf+iKr0CGvgNhQ7f7gxjOuzXeFOXwWgDMG
         4JGh9aSeU2Dvs2esmPQWzhuXJZ+59cMehCR3jCO+UGiPAseY1biaUa7mu6M7E06m06F5
         nBS3LsKVJb2gd8Cy5LmGwiaQfD83lvkPNLLhgbYIviWD21Ut0HizY6tQBx1v5U5KZjQR
         6O9DG+SIl1uSR76rh9l+SwnAtXFcr5eIfpVd+Jpqkq5dVBIBySMtRQVPRPIenGp/fiLA
         F9ZxlEPmY0INMULO/BKA6SDh7h1bw/VXul9a/3ZHGDjYb2xFLJgkuJo2SyUQ9ZYc6cPg
         OwkQ==
X-Gm-Message-State: AAQBX9fKPo9qekjMLHKd46F1/0h6JK3IUaWfGGyxfC5C1t7u6ijGBQpq
        hBHgiZ6e8XxG7MscwQMyDk91
X-Google-Smtp-Source: AKy350b8YyM+gWZG9+maoSfUuO7Xh5vZ26HQrArMHUvOh+sEsQOeZFwbyYyjKo1HI2/YQAWqY85NTQ==
X-Received: by 2002:a05:6a20:6d09:b0:da:5084:2764 with SMTP id fv9-20020a056a206d0900b000da50842764mr12933079pzb.24.1681211069983;
        Tue, 11 Apr 2023 04:04:29 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id k24-20020aa78218000000b005921c46cbadsm9794338pfi.99.2023.04.11.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:04:29 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:34:19 +0530
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
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 01/10] PCI: dwc: Fix erroneous version type
 test helper
Message-ID: <20230411110419.GC5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:19AM +0300, Serge Semin wrote:
> Due to an unfortunate mistake the macro function actually checks the
> IP-core version instead of the IP-core version type which isn't what
> originally implied. Fix it by introducing a new helper
> __dw_pcie_ver_type_cmp() with the same semantic as the __dw_pcie_ver_cmp()
> counterpart except it refers to the dw_pcie.type field in order to perform
> the passed comparison operation.
> 
> Fixes: 0b0a780d52ad ("PCI: dwc: Add macros to compare Synopsys IP core versions")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..adad0ea61799 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -37,17 +37,20 @@
>  #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
>  	((_pci)->version _op DW_PCIE_VER_ ## _ver)
>  
> +#define __dw_pcie_ver_type_cmp(_pci, _type, _op) \
> +	((_pci)->type _op DW_PCIE_VER_TYPE_ ## _type)
> +
>  #define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
>  
>  #define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
>  
>  #define dw_pcie_ver_type_is(_pci, _ver, _type) \
>  	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
> +	 __dw_pcie_ver_type_cmp(_pci, _type, ==))
>  
>  #define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
>  	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
> -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
> +	 __dw_pcie_ver_type_cmp(_pci, _type, >=))
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
