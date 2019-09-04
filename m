Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF25AA7F86
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfIDJhj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 05:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfIDJhj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 05:37:39 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D571622CF7;
        Wed,  4 Sep 2019 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567589858;
        bh=r3VqyrQxk+gtMUS2YJ7/8h9C8SwQomEdAUB3SnNKTf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHbulSy1zXjtH3G2znQNpnQWw1iNRRQuLogPFfY5HS66APmHkFjM2ZhGU9cvz8yiO
         5gPrhBNe07zjJjwlsUPfJSYN+CV1KQyBO0Jt5ahXmSi6vncUcIYYXxaBMuNFU9Hcv+
         PMDBzKMrUybMPYu7lX8bK/l7HexNMTgDBkll5pH0=
Date:   Wed, 4 Sep 2019 15:06:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dmaengine: rcar-dmac: use of_data and add
 dma-channel-mask support
Message-ID: <20190904093629.GS2672@vkoul-mobl>
References: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-09-19, 17:24, Yoshihiro Shimoda wrote:
> This patch series is based on the latest slave-dma.git / next branch and
> merge the latest slave-dma.git / fixes branch. This is because this patch
> series depends on the following commit:

Well it should not depend on fix which is going for 5.3 and the rest for
5.4

Can you please rebase on next and send. This doesnt apply for me

Thanks

> ---
> commit cf24aac38698bfa1d021afd3883df3c4c65143a4
> Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Date:   Mon Sep 2 20:44:03 2019 +0900
> 
>     dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped
> ---
> 
> Changes from v1:
>  - Combine two patch series into this patch series.
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=166457&state=*
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=166457&state=*
>  - Remove a patch because updated patch is already merged into
>    the latest slave-dma.git / fixes branch as described above.
>  - Add Reviewed-by tags into all patches.
>  - Rename a member of rcar_dmac_of_data.
>  - Just ignore the return value of of_property_read_u32() for dma-channel-mask.
> 
> Yoshihiro Shimoda (3):
>   dmaengine: rcar-dmac: Use of_data values instead of a macro
>   dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
>   dmaengine: rcar-dmac: Add dma-channel-mask property support
> 
>  drivers/dma/sh/rcar-dmac.c | 47 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4

-- 
~Vinod
