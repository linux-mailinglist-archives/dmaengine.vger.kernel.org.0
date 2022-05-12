Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D2524FCA
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiELOSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355228AbiELOST (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 10:18:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794673576
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:18:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv2so5281016pjb.4
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7iZZodcw2kcYl7DcsgXoMrjWgWmUo2hoVmfbC2enldQ=;
        b=f0iav4TX9MWlsCmY6kc9xgrGJbCfS5isN6BM1Z6iWUxV5R949SvxIHYuhyNXGq/LbV
         iAVEe/k5sttQeWMaw8UJeNzTt7nM8mgs/GC29uCwzVviZ9UmUBlRI+Yz4RUEq3Dnpjdu
         2s0PTjvqcKHLtt7RtJpqsNMesXKMwyhVVaDQmx0ZS2gv/W14tS7b3di51NdIdSkN/LgV
         XzQIgrd3IqcQpA9t8nnDLybJ7SAHI7TXsGvLN72OpLgWmloZOd2HbrLfE11Ys9oztA22
         585mp7uatbKavu7kiketYuGxOhssXwkcveNeYR6yEJEx5D8busxanwG2Ez59YvnJLBGT
         vRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7iZZodcw2kcYl7DcsgXoMrjWgWmUo2hoVmfbC2enldQ=;
        b=L8YUgFTGQmMF9NNvMAF+/1cNXVFMHvPvGvD8fm4d1s8Dc0HtNxOOaVV1vnGMinSKps
         7Svu/UngKWbxenrWg82Brd7j3ubIgiFPMuHc+t513zM9pCsWn3TN/DS8Umpz+8+32t3U
         feOWMOt5EPQKL9TU2bCSveCdJmS0bRbo8yxaTAo8O158xo7XZuGgIlDfvTx/21Q0og1K
         0xUQ+iJYm/e6hTNQBsaqeLyAuQkosD9oG0v5b5c5Ot7ZWVPEHoq5AuGNF/6iKaQy7lGb
         0cXzVtQXiP0I2JCg0AfQH7eNlhLr4Q21p36Tf9CPcaobT0oEQnW4A9SVSR8c5h4LTTG7
         mYGQ==
X-Gm-Message-State: AOAM531ULh9dZ8e/DKnrK/dYXJSV3yqaPdzr4SEEDqDcg1xVoUhph+dF
        3S9KpYAWhJZHDRcmZBL09Zx5
X-Google-Smtp-Source: ABdhPJy0b5z0NMw6JCWSQ6xCOd3R5EJ290CTQnJbuWRxW4kXTEznCyVtk2LbYi8JPVi2vsroZVZbrg==
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id z12-20020a17090a170c00b001dc20c46354mr11089713pjd.113.1652365093661;
        Thu, 12 May 2022 07:18:13 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0015e8d4eb1f2sm3997428plh.60.2022.05.12.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:18:13 -0700 (PDT)
Date:   Thu, 12 May 2022 19:48:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/26] dmaengine: Fix dma_slave_config.dst_addr
 description
Message-ID: <20220512141806.GG35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:40AM +0300, Serge Semin wrote:
> Most likely due to a copy-paste mistake the dst_addr member of the
> dma_slave_config structure has been marked as ignored if the !source!
> address belong to the memory. That is relevant to the src_addr field of
> the structure while the dst_addr field as containing a destination device
> address is supposed to be ignored if the destination is the CPU memory.
> Let's fix the field description accordingly.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 842d4f7ca752..f204ea16ac1c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -395,7 +395,7 @@ enum dma_slave_buswidth {
>   * should be read (RX), if the source is memory this argument is
>   * ignored.
>   * @dst_addr: this is the physical address where DMA slave data
> - * should be written (TX), if the source is memory this argument
> + * should be written (TX), if the destination is memory this argument
>   * is ignored.
>   * @src_addr_width: this is the width in bytes of the source (RX)
>   * register where DMA data shall be read. If the source
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
