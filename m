Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E3E525115
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355847AbiELPRp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355520AbiELPRo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 11:17:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A15F5BD2D
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:17:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so4899247pgc.1
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zLE6fSdSxLnDJ3meWIHVOLC962B0UFWV9yzj2ggJ6qo=;
        b=I4S+tB2IUWwWqZAi3ahyn6RaaYyd40WhZU90C0RgyEl5IyZph82dZYS974NEEWeXHM
         vIkrwmIwjYtNYjG5xq/kSEqCnp3ZrGvsC5vXb64lYkETOSPYsAc0DjlsP6vDwsZG/aJG
         Fdi/bL1aysODmrvq/5H2mL3HUk8Pldmzs3u549pGiHU1cTGo1ufNfuj54QL53NoFolUL
         HMMnr7FHrIyQVDLsShQAXgCSXJqF4SAIXoIvIs64SLOq9etLdBa71KzJl79fr51QDZqZ
         x+e6UxbNP7+N7kYFAIy1nzhqFp2W9CRkwcccqhoHNyK5AqF9r2oPq/eK0DRepyGsCs43
         z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zLE6fSdSxLnDJ3meWIHVOLC962B0UFWV9yzj2ggJ6qo=;
        b=LQasPd9bwG8SSHdH+F3cArLtacN2n1j2qLpzxOK+UPLEHH6Uy3BT8mlGMhXlWBIqH6
         DkZNmDDTUDxpWi7Igk6iuKTT7zzo+aoyNJ6vu+JCTndBNwpqjj/0wsO8u2oyEtOKIM5w
         QiZX49SHjWhvBGshFI18FxOrHZGVX7q/PX4m87cb3ao5wye6qombxCvZvf5+dVaUC69r
         eOWjLoypQF5fPnueQFd6OoNiQjFyZ79oB8roafuEP4cnPHjxiZKdC3t2KfkIvGEao/mR
         mQacSmpYWkkA8UYi2nQYQgDxl0pvXyuRAK9f1XJ4bBu7usTPJ0ZqwbUs64K2WAHO95if
         HUUQ==
X-Gm-Message-State: AOAM533VYEYCiaSdHqUJceX95gZgBCQhZw+tdlghlWCKnbc42/X+QAsg
        sw0EtpsFVPRgqhBE5jyRWtjn
X-Google-Smtp-Source: ABdhPJyQUmi1bOsHXBprA74Ze9KvjwGgickZ93cHeBjF4UY4RaonFMNKHHz/satakCKOaMvnOxqpPQ==
X-Received: by 2002:a63:9141:0:b0:3c6:270f:cec2 with SMTP id l62-20020a639141000000b003c6270fcec2mr165647pge.182.1652368662639;
        Thu, 12 May 2022 08:17:42 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id p10-20020a1709026b8a00b0015e8d4eb2c1sm4072420plk.267.2022.05.12.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:17:42 -0700 (PDT)
Date:   Thu, 12 May 2022 20:47:34 +0530
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
Subject: Re: [PATCH v2 14/26] dmaengine: dw-edma: Convert DebugFS descs to
 being kz-allocated
Message-ID: <20220512151734.GK35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:52AM +0300, Serge Semin wrote:
> Currently all the DW eDMA DebugFS nodes descriptors are allocated on
> stack, while the DW eDMA driver private data and CSR limits are statically
> preserved. Such design won't work for the multi-eDMA platforms. As a
> preparation to adding the multi-eDMA system setups support we need to have
> each DebugFS node separately allocated and described. Afterwards we'll put
> an addition info there like Read/Write channel flag, channel ID, DW eDMA
> private data reference.
> 
> Note this conversion is mainly required due to having the legacy DW eDMA
> controllers with indirect Read/Write channels context CSRs access. If we
> didn't need to have a synchronized access to these registers the DebugFS
> code of the driver would have been much simpler.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Changelog v2:
> - Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
>   definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 2121ffc33cf3..78f15e4b07ac 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -53,7 +53,8 @@ struct dw_edma_debugfs_entry {
>  
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
> -	void __iomem *reg = data;
> +	struct dw_edma_debugfs_entry *entry = data;
> +	void __iomem *reg = entry->reg;
>  
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
>  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
> @@ -94,14 +95,22 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
>  
> -static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
> +static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
>  				       int nr_entries, struct dentry *dir)
>  {
> +	struct dw_edma_debugfs_entry *entries;
>  	int i;
>  
> +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> +			       GFP_KERNEL);
> +	if (!entries)
> +		return;
> +
>  	for (i = 0; i < nr_entries; i++) {
> +		entries[i] = ini[i];
> +
>  		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> -					   entries[i].reg, &fops_x32);
> +					   &entries[i], &fops_x32);
>  	}
>  }
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
