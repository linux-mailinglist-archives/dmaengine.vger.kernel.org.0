Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6B705F6B
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEQFcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 01:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjEQFcE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 01:32:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2711E124
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:32:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso353868a91.2
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684301522; x=1686893522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGuspT1W7D1jog7sXk+6IkrbZk498Sh01jg8Jjbsh1c=;
        b=FH4+qcQ0jfsKxAFv8m17JLsLXPJmuhZBgkhFJDox0xmNt/zBrAjBxcQRlcLJzsEtG5
         Ec4UFojzZqp/i/2ssHtOrN9fYR4I613QrHd76WJy81iUzqW7+zmYSlxDLCGyH7yUnTvp
         FTX3mnRbAEYY9JHtyrmFykrXe5LbJrMXdnlXUi6igbebbrScxsdSPsCE3HL78CLCjhf6
         9pfRiV3jRyrd4DuZtxgTcSSi/4SuEQbvoQ3T4/DYkFNcagPq7HCqTtkOat2x/6tL74m6
         L4Eih+ENYf/GPiGmR4r3Fk8l4Wv73j9tu1WYDGsS4+vfQIsmXugN29hzYi8+x1W2op2c
         68Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301522; x=1686893522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGuspT1W7D1jog7sXk+6IkrbZk498Sh01jg8Jjbsh1c=;
        b=OTnN4xHr+PwPqUqLJprSilbptgXw7ltejdP/0pKq53A0l1AA8wcLgYL/xTqNq4xOND
         Cj7a9bW0/eVBnvoZcpH44eNcU6PHtXTrXH0iql9+1uC8SvabpM7F5hz8LHW+YeT68V1i
         JTASr9P/DGuFroaaTTFMrxFcKiQFrRv+YzrASO8ClRXtQXBYGVmWDn1LQbEq5E+v2JPF
         QkK+316KQP28Q3+MxSoNOu9tEHdIrBgH8gwPHTglzPqY61TQpZxEdaM9szRRPeD8YUzI
         U24vK3vhFPbR3ygiU3TLquaN9FUwNizUqvk8/h4HuCvEfvZI1BtfbM6bIZykW3tiSbBZ
         N/iw==
X-Gm-Message-State: AC+VfDx/Obv3Cx9KsDJd/m2wTlbnIF2uSJSEKVHm+NucdCapabkRZ2UQ
        49WguIxfRXHsLyxPPEvtb5ZW
X-Google-Smtp-Source: ACHHUZ5hE15MhhN0nI9O9WPO0+fchTcERkvmi7kprLVLSKFQd5bLUM2Zm9b+YcoBw0tSXQ1dJkEfIQ==
X-Received: by 2002:a17:90b:3804:b0:250:5377:5ede with SMTP id mq4-20020a17090b380400b0025053775edemr37094127pjb.24.1684301522579;
        Tue, 16 May 2023 22:32:02 -0700 (PDT)
Received: from thinkpad ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id q65-20020a17090a17c700b0024e49b53c24sm628663pja.10.2023.05.16.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 22:32:02 -0700 (PDT)
Date:   Wed, 17 May 2023 11:01:54 +0530
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
Subject: Re: [PATCH RESEND v5 12/14] MAINTAINERS: Demote Gustavo Pimentel to
 DW EDMA driver reviewer
Message-ID: <20230517053154.GE4868@thinkpad>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511190902.28896-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 11, 2023 at 10:09:00PM +0300, Serge Semin wrote:
> No maintaining actions from Gustavo have been noticed for over a year.
> Demote him to being the DW eDMA driver reviewer for now.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cd2e42110d5..b49a3f0e6dde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5885,7 +5885,7 @@ S:	Orphan
>  F:	drivers/mtd/nand/raw/denali*
>  
>  DESIGNWARE EDMA CORE IP DRIVER
> -M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/dw-edma/
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
