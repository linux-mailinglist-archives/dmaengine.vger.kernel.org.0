Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56FD15D92E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 15:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgBNOQM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 09:16:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14253 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNOQL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 09:16:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46ab680000>; Fri, 14 Feb 2020 06:15:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 06:16:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Feb 2020 06:16:10 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 14:16:09 +0000
Subject: Re: [PATCH v8 18/19] dmaengine: tegra-apb: Remove unused function
 argument
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-19-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d9a1bd6a-bd26-36ad-7d94-57801a2aa616@nvidia.com>
Date:   Fri, 14 Feb 2020 14:16:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209163356.6439-19-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581689704; bh=7zDhnIkodVLZV3Ofe3E4a0TAG7Gfs65r3CwFy1IpAxk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AKnTi8jbS6H5VeCmONAUjst2HfxW3NTTtMyhrk9hCdyuFpNKvGBYOEmec4CZpO4hK
         +Mc6+uLQcl0lgltyUjG4VWZeR8f7HZqgsIXaxnw9+KyXReahcSOO2jgb41cVlgnxpL
         kLTBfAzgRb+tnsjm6EUyK92Z3h0w73iFcFIEwEW9z2fAIauFxrsq2fw9nW0ZfI8yKL
         R9cwGdU5hDLEXtVq0xaLw6ladNIsvKaRqe8Hp/b9ple8BHDYgMLZgeYToEwK5Kwc/s
         3JNp6HghVLzEK+bOq/8dIobTF8D3551FIhdsXaF8wFAMoLivEWDkd0Bs1EE89mW+t4
         B9FkIPeN5Czgg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/02/2020 16:33, Dmitry Osipenko wrote:
> Remove unused function argument from handle_continuous_head_request().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 7b9d59bbd2c1..3e0373b89195 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -553,7 +553,6 @@ static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
>  }
>  
>  static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
> -					   struct tegra_dma_sg_req *last_sg_req,
>  					   bool to_terminate)
>  {
>  	struct tegra_dma_sg_req *hsgreq;
> @@ -638,7 +637,7 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
>  		sgreq->configured = false;
> -		st = handle_continuous_head_request(tdc, sgreq, to_terminate);
> +		st = handle_continuous_head_request(tdc, to_terminate);
>  		if (!st)
>  			dma_desc->dma_status = DMA_ERROR;
>  	}
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
