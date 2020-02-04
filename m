Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D9151A3F
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBDMCl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 07:02:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2251 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMCl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 07:02:41 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e395d480000>; Tue, 04 Feb 2020 04:02:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 04:02:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 04:02:40 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 12:02:38 +0000
Subject: Re: [PATCH v7 13/19] dmaengine: tegra-apb: Don't stop cyclic DMA in a
 case of error condition
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-14-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <332e8e86-dca5-19f2-9ef1-6d89a55f3651@nvidia.com>
Date:   Tue, 4 Feb 2020 12:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202222854.18409-14-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580817737; bh=YSg/qbG14MiZuAToLwQ5blhK1Nmrg/mcf5vl0/afAAw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=m9UTLUIIId235cw0ULyX13ftzhjrj7wY3MNr02uOYo/bYdhFXACVE6u1Mixfm5Vsy
         J4xZxviKZO3uqBG+E+k2sSH2jo+hJYvY//4L/TeESJLMT7bCXURsyaAzwOtt5j/FvC
         ZqRGusEcuqN59AuMLczl02u5dEBJy+O3RamTUMQCGCOt+70ZlFp89sz4UmuCOZn5g6
         5WlQ1mabejQS3P1G60Hz4yhih334IRDrM3VhVNG6ZycJLqx6eOkDFZLkRP2K8/Fb7H
         oL0sQgiidNP0jA9izYnhiZqtuTIPANqe3V79D5a4RvYuxOq8FGIYdQY4i/IRYhHdLN
         pjvlLol1T+6vQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/02/2020 22:28, Dmitry Osipenko wrote:
> There is no harm in keeping DMA active in the case of error condition,
> which should never happen in practice anyways. This will become useful
> for the next patch, which will keep RPM enabled only during of DMA
> transfer, and thus, it will be much nicer if cyclic DMA handler could
> not touch the DMA-enable state.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index c7dc27ef1856..50abce608318 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -571,9 +571,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  	 */
>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>  	if (!hsgreq->configured) {
> -		tegra_dma_stop(tdc);
> -		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
> -		tegra_dma_abort_all(tdc);
> +		dev_err_ratelimited(tdc2dev(tdc), "Error in DMA transfer\n");

While we are at it, a more descriptive error message could be good here.
I believe that this condition would indicate a potential underrun condition.

>  		return false;
>  	}
>  
> @@ -772,7 +770,10 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	if (!list_empty(&tdc->pending_sg_req) && was_busy) {
>  		sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq),
>  					 node);
> -		sgreq->dma_desc->bytes_transferred +=
> +		dma_desc = sgreq->dma_desc;
> +
> +		if (dma_desc->dma_status != DMA_ERROR)
> +			dma_desc->bytes_transferred +=
>  				get_current_xferred_count(tdc, sgreq, wcount);

I am wondering if we need to check this here? I assume that the transfer
count would still reflect the amount of data transferred, even if some
was dropped. We will never know how much data was lost.

Jon

-- 
nvpublic
