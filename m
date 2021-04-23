Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C57368D35
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhDWGea (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 02:34:30 -0400
Received: from www381.your-server.de ([78.46.137.84]:33706 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGea (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Apr 2021 02:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=REwpFT4yEkvfF+vOdoBEKDL3h1PPEpQl2J0avEzhUv0=; b=etHwIJGgrEgmPAzTR6x+KneGer
        Vn6O0E4vloq7H+tjr/070nl0x1VpNpVpFhgnW896AZy0V4vXt9+28pRAfGoJ4fe2sOFXZ7Pk78oOT
        D6ptVI4iTxW+d92GrpeJ+rRT9azm5TXgHKYuEnXTqvRiGfdJxx0EFKBKjsXcq1/HiwtYBz9SRA5hJ
        0VFfHblJsrUZMUWbCl4EbNntnjV/HrelV0RA0h6FfT+s8pzFInDKNdRLfDR7iAlsThnMEI7jHBVBF
        ZOChXwXgH9n5W5A/NNb3upRUThHz8BxxlbAEm97eEWaivDzcUg6bB2hTSDW2QYeVVoZA4uy+G26+G
        D/Pb9C/w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lZpNw-0009ky-46; Fri, 23 Apr 2021 08:33:52 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lZpNv-000J5L-Vh; Fri, 23 Apr 2021 08:33:51 +0200
Subject: Re: [PATCH 4/4] dmaengine: xilinx_dma: Add device synchronisation
 callback
To:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <20210423011913.13122-5-adrian.martinezlarumbe@imgtec.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4f286de6-ab91-ffd1-1119-cd94e5805aa9@metafoo.de>
Date:   Fri, 23 Apr 2021 08:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423011913.13122-5-adrian.martinezlarumbe@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26148/Thu Apr 22 13:06:46 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/23/21 3:19 AM, Adrian Larumbe wrote:
> This was required as an answer to a very unusual race condition, whereby a
> thread waiting on a completion signaled in a callback triggered by
> dmaengine_desc_callback_invoke might immediately attempt to release the
> DMA channel whilst the channel lock was still free. This would cause the
> remaining descriptors to be deallocated, and xilinx_dma_chan_desc_cleanup
> to perform an invalid memory access when attempting to traverse the rest
> of the channel's done_list.
>
> Now, when releasing a DMA channel, it will wait until the tasklet has
> finished.
>
> Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>

Hi,


Patch looks good, but basically the same got already applied a few weeks 
ago.

See 
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next&id=50db2050faf854cbaf4b6557a7a8ca21bff302ae

- Lars

> ---
>   drivers/dma/xilinx/xilinx_dma.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 40c6cf8bf0e6..d4bad999e7f9 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -942,6 +942,13 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
>   
>   }
>   
> +static void xilinx_dma_synchronize(struct dma_chan *dchan)
> +{
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> +
> +	tasklet_kill(&chan->tasklet);
> +}
> +
>   /**
>    * xilinx_dma_get_residue - Compute residue for a given descriptor
>    * @chan: Driver specific dma channel
> @@ -3235,6 +3242,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>   	xdev->common.device_tx_status = xilinx_dma_tx_status;
>   	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
>   	xdev->common.device_config = xilinx_dma_slave_config;
> +	xdev->common.device_synchronize = xilinx_dma_synchronize;
>   	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>   		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
>   		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;


