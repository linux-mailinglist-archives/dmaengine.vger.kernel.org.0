Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31452583F
	for <lists+dmaengine@lfdr.de>; Fri, 13 May 2022 01:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359455AbiELX2T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 19:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354671AbiELX2S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 19:28:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1726D31907;
        Thu, 12 May 2022 16:28:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c24so2206697lfv.11;
        Thu, 12 May 2022 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpfA97nDV4SiW2VW+i5FVHsx+t3FCKmVLBmZii44FdE=;
        b=kqBM6iNykm6TWh3OPtN3KNUqyw5Azl0zC+bz2Ms66O6sKoN0kw9HPHK7MEl25ZBQ9L
         L8CRer3B1+tD6pZKaure8nj8d0GueAO/QsDzbrjXRLcTmLmZTA1q+V0aLQk4KJVG5V1J
         VfF3Pir7FBeGVLVVt8JElNUM90239qH+if7wVSg3Gm9GlDnI1bNPHPIw6cDrL7dFVjqd
         9apTJ1uVsRpixTJaPz8daNI4kRjjhvNTPUuANFkQ4jVRfrKNwdF+Dp3mvgugQDaovRW+
         Hge5USiWx0kOowRq0KnkLp2ADdbQo8qW9kMAg2OtQJUw1oSA5LiBIhlft1FDabsbL6Ce
         L78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpfA97nDV4SiW2VW+i5FVHsx+t3FCKmVLBmZii44FdE=;
        b=URQqQMvQLOjhkcxiYp7834yB/qL5ksdNQ5t4ucfq60oSD/7MhjmUeChusMWdMnYqSB
         qKn7lellySLGSD/BNHw4Uc9wYO/j3uURuW++DMkEdYaP66kyIldsYEjxuUaTt0CmVGTz
         XaIzi3mjQuVFTJ3rxLGW0jPMPpVOh1hcw2Rm8SJTp7UG+vkGUogYrzTjLdRAOSc2LeK2
         HWtyvyWV6XqyFQCjLGxAajCkrGfp929lU1XAnmZK8XQFDgMv5r2TyZOOmDHTFIVSl3wk
         MaPScQTUcqdPPn2S5n+CPNLn9rH1+7TExHF/Tmnn6RXFxrscNvIMUsf9LP3yXKphPBsW
         TvDA==
X-Gm-Message-State: AOAM530zLwccaQI6ICk0YKW7U+YHw73xNyhBJlIXXvXdYOdlUr+VPvRf
        kWzpB3eNiYsw/zTgeeMMbvM=
X-Google-Smtp-Source: ABdhPJwmqcj7YqvF8NValKykWtMU500lUt5tUdBLW712+Zaujy4N8cbSQS3/q4FBv9Z1peRo/Q5rXw==
X-Received: by 2002:a19:4f55:0:b0:472:1f2b:6d12 with SMTP id a21-20020a194f55000000b004721f2b6d12mr1434763lfk.388.1652398095274;
        Thu, 12 May 2022 16:28:15 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id r18-20020ac24d12000000b0047255d2111csm131806lfi.75.2022.05.12.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:28:14 -0700 (PDT)
Date:   Fri, 13 May 2022 02:28:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 01/26] dma-direct: take dma-ranges/offsets into
 account in resource mapping
Message-ID: <20220512232811.6epllnb3ivb7vegq@mobilestation>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-2-Sergey.Semin@baikalelectronics.ru>
 <20220509061552.GA17190@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509061552.GA17190@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 09, 2022 at 08:15:52AM +0200, Christoph Hellwig wrote:
> So I think the big problem pointed out by Robin is that existing DTs
> might not take this into account. 

I'd say that the biggest problem isn't in the DT part but in the
drivers using the dma_map_resource() method since they don't expect
the non-uniform DMA-direct mapping can be available.

> So I think we need to do a little
> research and at least Cc all maintainers and lists for relevant in-tree
> DTs for drivers that use dma_map_resource to discuss this.

Right. I'll send the next patchset revision out with all possibly
interested maintainers and lists in Cc of this patch.

-Sergey

> 
