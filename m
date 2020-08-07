Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B889923F065
	for <lists+dmaengine@lfdr.de>; Fri,  7 Aug 2020 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgHGQDJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Aug 2020 12:03:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16539 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGQDI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Aug 2020 12:03:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2d7b2e0000>; Fri, 07 Aug 2020 09:02:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Aug 2020 09:03:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Aug 2020 09:03:08 -0700
Received: from [10.26.73.183] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 16:03:02 +0000
Subject: Re: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>, <ldewangan@nvidia.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a1b9f491-39c4-253e-ba89-f29ab8184cfe@nvidia.com>
Date:   Fri, 7 Aug 2020 17:03:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596816174; bh=IVGky6nLxDkiBaaxwKtT2L98g021B3TbNVb8iaX+a2o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E3DUFXe2pxHisbdIwV064pYOFGdAw6mnlEJkWxAQ85aIX47ja5/IP8Xhv0Ec994PI
         ZDoY2gg66kN/PS+7jgSsANnVuVS3K1XQJnY5RYEVgLNTbog2pb+wDSwF2d03u+u786
         wmHBVbPzdpCYy9nxCaYtF21OF5YhGxPNBnmHri8cfltygKf1+MKC2XUcHJDzWwnRex
         MQC0reaONUHiXKyH6ZEszDimpVGE1f9C0EOkfdavFnKtkTWDzCheWoll0THA3qYj9m
         3+WOeHN8naScraT8fe6rhIaLq26g5l1550Ot+NRupYeCC5pHwJAOSMkkK1Zwd4bXH+
         V/CnwGhLW+2Sw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/08/2020 08:30, Rajesh Gumasta wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> ---
>  drivers/dma/Kconfig         |   12 +
>  drivers/dma/Makefile        |    1 +
>  drivers/dma/tegra-gpc-dma.c | 1472 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1485 insertions(+)
>  create mode 100644 drivers/dma/tegra-gpc-dma.c

...

> +static void tdc_start_head_req(struct tegra_dma_channel *tdc)
> +{
> +	struct tegra_dma_sg_req *sg_req;
> +	struct virt_dma_desc *vdesc;
> +
> +	if (list_empty(&tdc->pending_sg_req))
> +		return;
> +
> +	if (tdc->is_pending)
> +		return;
> +
> +	vdesc = vchan_next_desc(&tdc->vc);
> +	if (!vdesc)
> +		return;
> +	list_del(&vdesc->node);
> +	tdc->dma_desc = vd_to_tegra_dma_desc(vdesc);
> +	tdc->is_pending = true;
> +	tdc->dma_desc->tdc = tdc;
> +	sg_req = list_first_entry(&tdc->pending_sg_req,
> +				  typeof(*sg_req), node);
> +	tegra_dma_start(tdc, sg_req);
> +	sg_req->configured = true;
> +	tdc->busy = true;
> +}


I really don't understand this. First we get a descriptor for the
vchan_next_desc and then we get a sg_req from another list. I really
don't see why we need to have two lists here. Seems overly complicated.

Jon

-- 
nvpublic
