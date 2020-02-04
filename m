Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8E151CA4
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBDOxc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 09:53:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9804 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgBDOxc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 09:53:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3985540000>; Tue, 04 Feb 2020 06:53:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 06:53:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 06:53:31 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 14:53:29 +0000
Subject: Re: [PATCH v7 11/19] dmaengine: tegra-apb: Remove pending_sg_req
 checking from tdc_start_head_req
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-12-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c2718527-0c0f-88e5-6901-f3df98460bb2@nvidia.com>
Date:   Tue, 4 Feb 2020 14:53:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202222854.18409-12-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580827988; bh=MfJF0InwjBbr/bLcfeZpR/Z7wsP41mpgM46lkuKQiwY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jdy6T5JqrtN4WW8Ck6OrAj7jAISSDj0QhlSxVacsiz9X1pHZmvx6gmgDLld3ygpxw
         AmaUo5peGA9Fc8uI3LhkrKP5woUtmI9qZsQeINc0CfU/ovLgtp7ygODa2V5NOm8FTa
         +DO5TjDo2P2jOqgOE1OlCiYZaApuHUiJFASFhDWtsWYgQgfD3p8DrLcP4E8jBqbxeP
         oqpwJidIhQbWOj8Be4hCq8eShN7mpF66hesKjpbWNrw+q3foZ1qEwE5PT0slx1LbFk
         coAH7cLpsXVty4QMpiSYx6ynCqYpSJQ4jSU1iDi4h0ciRKpq++OZNwKOfFfcbndr46
         Dg5FUxPld9j5Q==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/02/2020 22:28, Dmitry Osipenko wrote:
> There are only two places in the driver that use tdc_start_head_req()
> and both these places check whether pending_sg_req list is empty before
> invoking tdc_start_head_req().
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 22b88ccff05d..62d181bd5e62 100644
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
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
