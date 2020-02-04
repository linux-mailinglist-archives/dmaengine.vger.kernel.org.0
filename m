Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE8151DB1
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBDPzJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 10:55:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBDPzI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 10:55:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so19166336ljg.3;
        Tue, 04 Feb 2020 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JZwaZAs4VPg+MZljM+SS0kMupA1fP3M0vka2FZtHyUs=;
        b=keuTsSrKE/2sGEZ/mCNFBtfA5/nM187MrzUuQuHvBMmn2K8XCXRwbE4Qd/r2UMIFFV
         h3JnXWcGCpHrRZwHIqf0ethN27sLiVG1o9ZYsC26dJpmv/z8C/RL9eXARiuUvm+/2p5V
         8oMMC4Munw/6fj9RtsfimU/AzN8AvGQ9BdGRhWzJLJQjbpSzCLLQeT2nF7gUfdl25TXY
         z2pBxogs5PUSvzyLaTZudiH75HrxrB+rUZXm3MFl8tFHa+Okjfcugglb1V2jXhPKKtA5
         tR//mSQjS0Z3wXRffaKwje4oWDEZQFJtc4pFHM+GRYHN3bVX2nwF4SZANs2/s9z7A4MP
         ay1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZwaZAs4VPg+MZljM+SS0kMupA1fP3M0vka2FZtHyUs=;
        b=eOygJrkwboHkKPfu+9anbZXpXi2D5A/VFWp8OMt2d7eK7XMDFquTKllc6jqjgVeWZj
         YKJwSX2zFIG/MaDwOzSka/APNVEg2rWNSuW/8SHpxIU10UC7+eGW4rpSj40IzsuPK6lW
         viaTlPqW4ky9c4b1/CP4sBmwy8zxF8vwwlO/ymNucpw+cK+HTUE/Sl3RZvJ2BL7//89R
         4t65P8C1mCqiYnM+P5ezo2aFPuY771wUdef/P98WmbRe00PDfWQdqpdZqtGtdz0X7Fkd
         VfAmQNshuq0aNdtqRjrLLEDm4LjE8oEvUyePcrLT78g7CfU+ln1DTCiI4FealRK3FqiM
         mp8w==
X-Gm-Message-State: APjAAAVfSGOyTc1X0jhQu0cYyPs+WfT4TGCOs4HdQb+K0vUpm3CpzdVa
        +X8BDvt5w3b17iO9It9YAo/qooy5
X-Google-Smtp-Source: APXvYqz9EywivV4SrY2+zghH9X/t0s+7ktKmSSPeAg5hYqrzXzJR9qDy2sP9teMcgdHvAfU0z97esg==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr17980763lji.92.1580831705084;
        Tue, 04 Feb 2020 07:55:05 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 126sm10695751lfm.38.2020.02.04.07.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 07:55:04 -0800 (PST)
Subject: Re: [PATCH v7 13/19] dmaengine: tegra-apb: Don't stop cyclic DMA in a
 case of error condition
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-14-digetx@gmail.com>
 <332e8e86-dca5-19f2-9ef1-6d89a55f3651@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ad86f2a4-6fa0-7958-aad7-1b18f02cabfe@gmail.com>
Date:   Tue, 4 Feb 2020 18:55:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <332e8e86-dca5-19f2-9ef1-6d89a55f3651@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.02.2020 15:02, Jon Hunter пишет:
> 
> On 02/02/2020 22:28, Dmitry Osipenko wrote:
>> There is no harm in keeping DMA active in the case of error condition,
>> which should never happen in practice anyways. This will become useful
>> for the next patch, which will keep RPM enabled only during of DMA
>> transfer, and thus, it will be much nicer if cyclic DMA handler could
>> not touch the DMA-enable state.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index c7dc27ef1856..50abce608318 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -571,9 +571,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>>  	 */
>>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>>  	if (!hsgreq->configured) {
>> -		tegra_dma_stop(tdc);
>> -		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
>> -		tegra_dma_abort_all(tdc);
>> +		dev_err_ratelimited(tdc2dev(tdc), "Error in DMA transfer\n");
> 
> While we are at it, a more descriptive error message could be good here.
> I believe that this condition would indicate a potential underrun condition.

Yes, this error indicates the underrun and indeed the error message
could be improved. I'll change it in v8.

>>  		return false;
>>  	}
>>  
>> @@ -772,7 +770,10 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>  	if (!list_empty(&tdc->pending_sg_req) && was_busy) {
>>  		sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq),
>>  					 node);
>> -		sgreq->dma_desc->bytes_transferred +=
>> +		dma_desc = sgreq->dma_desc;
>> +
>> +		if (dma_desc->dma_status != DMA_ERROR)
>> +			dma_desc->bytes_transferred +=
>>  				get_current_xferred_count(tdc, sgreq, wcount);
> 
> I am wondering if we need to check this here? I assume that the transfer
> count would still reflect the amount of data transferred, even if some
> was dropped. We will never know how much data was lost.

I'm wondering too.. stopping DMA in a error case removes this ambiguity
and that's why in my previous answer to v6 I suggested to drop this patch.

Do you think it's worth to keep this patch?
