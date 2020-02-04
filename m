Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF6151A1F
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBDLwq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 06:52:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19437 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgBDLwq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 06:52:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e395aff0000>; Tue, 04 Feb 2020 03:52:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:52:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 03:52:45 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:52:43 +0000
Subject: Re: [PATCH v7 12/19] dmaengine: tegra-apb: Remove handling of
 unrealistic error condition
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-13-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b2461a42-5939-b2b1-01fe-6f18c860dbd9@nvidia.com>
Date:   Tue, 4 Feb 2020 11:52:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202222854.18409-13-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580817151; bh=FpvHZ4w/sU6nKdxXINEARx9AtomCkzk2I9Ho6chDmac=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Mq9ZDQWDOswmryWzsLZ9BzAF2jlwhLzZvnH6CgxYQX2ERfUGBpRQg86ymxmW5Jc3F
         vA2g/OhfgnzZf4yCUtZJ9f7OCoPwnU8vmodudOJS99TqDW3mZkNBIjjeFCUOTa29HL
         4zt0xJfmDsvOON6FYqO9iV5Cetl58bORwSBJ0AME927UlDEAthtm0Uz9DnQK2O17l4
         7EgoW54OK+OyEgX51ShyO4Um/4E0IsmOuwgaFlleObKP9e0LzPNfgvOa8dWx9kL9zB
         HWzA+R7QEkMGQ/yNLsccNJMQR06gzZD0t6D5VI3sF4I6dJmWdli2soLvFsSIeK00jF
         vitAnQaoLQLHQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/02/2020 22:28, Dmitry Osipenko wrote:
> The pending_sg_req list can't ever be empty because:
> 
> 1. If it was empty, then handle_cont_sngl_cycle_dma_done() shall crash
>    before of handle_continuous_head_request() invocation.
> 
> 2. The handle_cont_sngl_cycle_dma_done() can't happen after stopping DMA.

By this you mean calling terminate_all?

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 62d181bd5e62..c7dc27ef1856 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -564,12 +564,6 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
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

There is also a list_empty() check in tdc_configure_next_head_desc()
which is also redundant and could be removed here as well.

Jon

-- 
nvpublic
