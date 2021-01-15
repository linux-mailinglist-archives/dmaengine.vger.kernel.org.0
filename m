Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2062F7C6B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbhAONVj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 08:21:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5606 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAONVj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Jan 2021 08:21:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600196cc0000>; Fri, 15 Jan 2021 05:21:16 -0800
Received: from [10.26.73.78] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 13:21:10 +0000
Subject: Re: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rajesh Gumasta <rgumasta@nvidia.com>, <ldewangan@nvidia.com>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kyarlagadda@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <2a99ca73-a6e8-bf7d-a5c1-fa64eee62e23@nvidia.com>
 <20210115055658.GD2771@vkoul-mobl>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <87869e8d-43a3-b8dc-69b0-3c8a488eea4a@nvidia.com>
Date:   Fri, 15 Jan 2021 13:21:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115055658.GD2771@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610716876; bh=hDBUDa/GAyOa7dsscGkoZ3S3ljUyZcRcn5vrkxGu2IA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hJ1W6KK+WMf47MDNwqCl2xAbCBJ52DELsEJMpAfOWUWNMf1cpa5tFVRXz3QBbjRw8
         WxacQlf24Zh1hC4xzYIw2gDhkYrqnDzJvNWz+9WATWKLNc/dAcm62aNIsNKsvHvHju
         Ps1kRPeEdeZNQ+DQyGcSf/HT+hDrYT7G2Q9/u1DQ5lJCz6WDi7Y1o3kVTOzXN0U09P
         1Nn0GXOwMfa6HSSo/2pULZL9TfJ7CN4GyRHz6ZoZD78fu7wry4ScMbuvan7gUocYzZ
         RfvIzFiirXk9EIMCj79GHdxwEPgZCaHpjaCbA/cApa+IaxnZlZio25D+ptft5wyZQj
         kh/umvh9RhBHw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 15/01/2021 05:56, Vinod Koul wrote:
> On 14-01-21, 10:11, Jon Hunter wrote:
>>
>> On 06/08/2020 08:30, Rajesh Gumasta wrote:
>>> Changes in patch v2:
>>> Addressed review comments in patch v1
>>
>>
>> Is there any update on this series? Would be good to get this upstream.
> 
> Not sure why, this is is not in my queue, can someone please resend this
> to me

Sorry, this question was meant for Rajesh. This series is not ready yet.
There are still some items that need to be addressed.

Thanks
Jon

-- 
nvpublic
