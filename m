Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345E705F68
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 07:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjEQFbh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 01:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjEQFbf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 01:31:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC73C32
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:31:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so501156a12.1
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684301493; x=1686893493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bX/WRJYWneJhbdMkwu/1JkZHaAZFt8S2ckCbRbU3oKU=;
        b=ULZTfiP0d3vAbVVPg8dLAndWYJO37EPrD8TG81Ry4E+S/Ni+obZ1ZEby6QV9Ap0I8v
         rGb45xxIu6b714Sg2aCSwLEhxKHlnFdlfa90rRr16vsLt2tA0RIj4ZoQQc0zzs5bgQMJ
         aAy4SX8Mr4QjyShu72H3GRSLhqvyEv7jMnZtKB2R0qrt3rnL8GhH4hVoJXLqtve5d9J4
         MIozfZRHLaq09BjgqV6zxmc+NBcnJXTnv6CfwEuyLL2T8fEhMfskchyuGyDA5/zLlIdQ
         y2JhbjjZQaYr2y9xbNYWYjF6AqltuqMBwmCbBadpUMCUB83JlyfL2lr9+c+1jbDCthVS
         J5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301493; x=1686893493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bX/WRJYWneJhbdMkwu/1JkZHaAZFt8S2ckCbRbU3oKU=;
        b=U52meV/zHROtNlClMHVu+7vGKwz/EPT1vqpgpCKGztZ4NPEbBuNbk3slvhTWbHt9uR
         HmeozkhpM8SeULGZlDzRWMdUfoXF1EE/NMthKAtS1p0lfjd78iCBjnFibud/aacyvfeJ
         lEDISzdutRTKUJNBI7xnkKwJJRi73X6ZKasvpvqhI6DXksY2dSWUSA4fU/iVXXltGzZq
         duaCiSUL2Sir1uyoMt3j7DAgfvlhryw4pGxwdVorqFwYKHe7bcmKbyPNWhW3SG0O7coc
         ByHBnfqGTO/ENwoKpwN43Dlteca9tYYeEynJ3DCaiKn+WVSanQU/U2Uk+sbHaS+7bn4R
         N92w==
X-Gm-Message-State: AC+VfDyL7D6/URPOfazjFEo84K5pHKYXhIlncztiN0l1u4UncrwRgbiU
        Rm5m5pBnEnPHwFYrNbm6vINW
X-Google-Smtp-Source: ACHHUZ4UYNe4laTCtCWLXHZUeL9sNgiqFsWy01NYF8rfPeBheQUoWsi7snrrYsT9+dOhVwCZVedlfA==
X-Received: by 2002:a17:907:7207:b0:96a:937c:5608 with SMTP id dr7-20020a170907720700b0096a937c5608mr16424757ejc.53.1684301492957;
        Tue, 16 May 2023 22:31:32 -0700 (PDT)
Received: from thinkpad ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id bz1-20020a1709070aa100b00969e316d8dbsm11504929ejc.225.2023.05.16.22.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 22:31:32 -0700 (PDT)
Date:   Wed, 17 May 2023 11:01:21 +0530
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
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 10/14] MAINTAINERS: Add Manivannan to DW PCIe
 core maintainers list
Message-ID: <20230517053121.GD4868@thinkpad>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511190902.28896-11-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 11, 2023 at 10:08:58PM +0300, Serge Semin wrote:
> Manivannan has been very active in reviewing and testing the bits coming
> to the DW PCIe RP/EP core driver. Let's add him to the driver maintainers
> list.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d93e1e4e776..dc1a5164c93c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16166,6 +16166,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
