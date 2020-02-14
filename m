Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A15D91A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 15:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgBNONS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 09:13:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16233 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgBNONS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 09:13:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46aae00001>; Fri, 14 Feb 2020 06:12:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 06:13:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Feb 2020 06:13:17 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 14:13:15 +0000
Subject: Re: [PATCH v8 11/19] dmaengine: tegra-apb: Remove duplicated
 pending_sg_req checks
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-12-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <81d0f76a-8391-f8ee-c713-b699188d1856@nvidia.com>
Date:   Fri, 14 Feb 2020 14:13:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209163356.6439-12-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581689568; bh=Rh0gsvOb9X8sIihgsHGuy6sNYCz4koy1dG9PxBQP0qo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SvpVi1rmKJ5GQytWBi88Sc73RmCCn8V5h/rRWxUhTiNn+lsI4QqUhAHx/mSx6c0/v
         7zWwxFpY/pR3tBvc+7qxesirE2Sp0dN0crFPH8hWSmNl9QGuZoaUFuPETNt3jNFtir
         qSRKkFQ1h3Kt9nhyZHOPI8YcsLoDK9hHCgt6wdd7qrO07hRULIOqkshueTZ5yLb2+Y
         as8BFwQU8zMXH5Yid8GGLr5tLfANrq9dwi3saDT7HW5XuI0VrRP5Mo5PTipU7kTyPe
         FUDe5kV9z+9trGpTe4wQpiBSSyHUoLcy0mqc2R/e2cczCoW+n9XGN3v5TZM7XnlWQh
         I4g1TJQKYFjcg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/02/2020 16:33, Dmitry Osipenko wrote:
> There are few place in the code which check whether pending_sg_req list is
> empty despite of the check already being done. Let's remove the duplicated
> checks to keep code clean.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 22b88ccff05d..049e98ae1240 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -504,9 +504,6 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_sg_req *sg_req;
>  
> -	if (list_empty(&tdc->pending_sg_req))
> -		return;
> -
>  	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
>  	tegra_dma_start(tdc, sg_req);
>  	sg_req->configured = true;
> @@ -518,9 +515,6 @@ static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_sg_req *hsgreq, *hnsgreq;
>  
> -	if (list_empty(&tdc->pending_sg_req))
> -		return;
> -
>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>  	if (!list_is_last(&hsgreq->node, &tdc->pending_sg_req)) {
>  		hnsgreq = list_first_entry(&hsgreq->node, typeof(*hnsgreq),
> @@ -567,12 +561,6 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  {
>  	struct tegra_dma_sg_req *hsgreq;
>  
> -	if (list_empty(&tdc->pending_sg_req)) {
> -		dev_err(tdc2dev(tdc), "DMA is running without req\n");
> -		tegra_dma_stop(tdc);
> -		return false;
> -	}
> -
>  	/*
>  	 * Check that head req on list should be in flight.
>  	 * If it is not in flight then abort transfer as
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
