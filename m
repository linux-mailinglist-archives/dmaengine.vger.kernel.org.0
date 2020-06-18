Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1C1FFBD4
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFRTc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 15:32:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13996 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRTc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Jun 2020 15:32:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebc1170000>; Thu, 18 Jun 2020 12:31:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 12:32:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jun 2020 12:32:26 -0700
Received: from [10.26.72.215] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 19:32:20 +0000
Subject: Re: [PATCH] [v3] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200618105727.14669-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9f7684d9-7a75-497d-db1c-75cf0991a072@nvidia.com>
Date:   Thu, 18 Jun 2020 20:32:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618105727.14669-1-dinghao.liu@zju.edu.cn>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592508695; bh=Y+el/msl5X9o1BlFounYqeYclLOqf6T/QsJDITBZXqk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=deWdH0miSgiOPdDQJ4OdfEkBzZtj5uvIgYtqy0VRrej0fpBcWv4OgSSNsAkXZ44cZ
         sQwLVUR0zOQG0C9Ni7x2gjlXCC2QqO7QxhmEC0ELlZ6nfNogu7aqat97o7AMLLveUB
         WF9z1HKm5RI9OgPjua0UjGpfD12GDfPcfT3IFss1/Y+sa32zgXo4moxutyDc9AtEne
         BTedBct5s/uHjZB7xuM/UiYciUloab81OHgAxc0UqAgCWTUEB08FXYn7wtW901TqLV
         QuKBruUbzVr+W3PlKxIsF8PqarvyqGWdUWePMhKU79xqHpsOUrOcBFl5sihmEbnrW3
         EGuIBEezjmI3Q==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 18/06/2020 11:57, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Merge two patches that fix runtime PM imbalance in
>       tegra_adma_probe() and tegra_adma_alloc_chan_resources()
>       respectively.
> 
> v3: - Use pm_runtime_put_noidle() instead of pm_runtime_put_sync()
>       in tegra_adma_alloc_chan_resources().
> ---
>  drivers/dma/tegra210-adma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index db58d7e4f9fe..bfa8800dfb4c 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>  
>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>  	if (ret < 0) {
> +		pm_runtime_put_noidle(tdc2dev(tdc));

Why noidle?

Jon

-- 
nvpublic
