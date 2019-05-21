Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB54C246EF
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfEUEiM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUEiL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:38:11 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ADB216B7;
        Tue, 21 May 2019 04:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558413491;
        bh=4XX4rftcytXAmMV6UJKvOiyXZ94mgRgAhcGdMVSOYYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUh+oiXpbm38TqLjIBnHnx97cGR+QEtHqrbEvcNlVtydTwJ8TmXVMG6VoRF5UMmL0
         cytkPrj9S83s3Gz4AiqjY9HGxxgGyGORnMNQCJnrw+uqvgJiL2Kggl1vuwL7p6zfcT
         wMJzOQ36Rt41lGzEWPIxULTVMbZR6eKOdJwopdDg=
Date:   Tue, 21 May 2019 10:08:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dmaengine: fsl-edma: support little endian for edma
 driver
Message-ID: <20190521043807.GN15118@vkoul-mobl>
References: <20190506090344.37784-1-peng.ma@nxp.com>
 <20190506090344.37784-3-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-3-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 09:03, Peng Ma wrote:
> improve edma driver to support little endian.

Can you explain a bit more how adding the below lines adds little endian
support...

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 680b2a0..6bf238e 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -83,9 +83,14 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  	u32 ch = fsl_chan->vchan.chan.chan_id;
>  	void __iomem *muxaddr;
>  	unsigned int chans_per_mux, ch_off;
> +	int endian_diff[4] = {3, 1, -1, -3};
>  
>  	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
>  	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
> +
> +	if (!fsl_chan->edma->big_endian)
> +		ch_off += endian_diff[ch_off % 4];
> +
>  	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
>  	slot = EDMAMUX_CHCFG_SOURCE(slot);
>  
> -- 
> 1.7.1

-- 
~Vinod
