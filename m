Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D66464AC
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFNQoN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 12:44:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39379 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNQoM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 12:44:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so2179111lfo.6;
        Fri, 14 Jun 2019 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9lLYU7jn518ojnFF4nYlS29/w9slDIZ2Qw8HKCiVkg=;
        b=dJCVqaYTv0Ezro7ql3iIqLgyKhuUvBpEh1thMHwh5XM7Jpe5oSbJp+g5Tmv6RIfn35
         ndwv2cYqQSWd1cZRp0l8px8y2O9OGXU80ro9JxbQBwEbmwPyx5tueqQcjOKeuAc03yYd
         8KVPG9MvvpsNSEH7xr/TagGHkiJnCu7+vAQUk9ZBv5XZZ1xa2YwHRnFg5goqC7Tr7Ir+
         gKx4D83LbUHPY2OlUM1CxbJiq/EkH3q0mwlkUp4cYg/A/1IFyCi/50IHVGYOyKrYNG+s
         8CwI4ahPhUHbnfl/bVWCzokJWSNGpaIc1PO9bI8U4V1xkFkn9+05U0UEYuGpAgK56AZP
         pbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9lLYU7jn518ojnFF4nYlS29/w9slDIZ2Qw8HKCiVkg=;
        b=pvhIJqh4bwDBYZZmCq94YNgUpfSftgIuHd7QeE3z/hlWxeFIe+XFuvu2hfiH8/B8QK
         HZnoi6xaKAVbU3CUVayNobExjxxYIHUy+nfJOrIEgoIYSjSnnc6dy6GQKXgFdai1+6cT
         tjaRgyElsRpySCL+J+SA1O/Z2rgYKlEWn0pWkA8jlldG7r271PAhlE6PDNkgymqtjDzL
         s+rYmIoFYyRgHm/dE00U0ms45zRFzNDU2CtM9a4k2ZjFuVxn56YzPRnDpiDoM7MCe9k3
         V7B11t9SoFbdGSAoMsCPyxidceXjXYOtboGmuv2ZfoT2eHJtaAK9ngFRC/SiQC2OslO1
         eXpQ==
X-Gm-Message-State: APjAAAXEeNbXBus5j2mC/SYIzqfjijaKMsUlsgChEw/N3sZoBj7k1yg2
        NI61ho86vwSPndT8DMavocPmjQEQ
X-Google-Smtp-Source: APXvYqyPAYvifKzpZ0d8kYngJqpcsskzy85z/YO/mz0OJmLmJbvLifzSPv2ay5136cNm6ILxJV71OA==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr20186797lfm.17.1560530648985;
        Fri, 14 Jun 2019 09:44:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id f10sm676257ljk.95.2019.06.14.09.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:08 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
 <5fbe4374-cc9a-8212-017e-05f4dee64443@nvidia.com>
 <7ab96aa5-0be2-dc01-d187-eb718093eb99@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <840fcf60-8e24-ff44-a816-ef63a5f18652@gmail.com>
Date:   Fri, 14 Jun 2019 19:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7ab96aa5-0be2-dc01-d187-eb718093eb99@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

14.06.2019 18:24, Jon Hunter пишет:
> 
> On 14/06/2019 16:21, Jon Hunter wrote:
>>
>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>> of data, hence it can report transfer's residual with more fidelity which
>>> may be required in cases like audio playback. In particular this fixes
>>> audio stuttering during playback in a chromiuim web browser. The patch is
>>> based on the original work that was made by Ben Dooks [1]. It was tested
>>> on Tegra20 and Tegra30 devices.
>>>
>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>
>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>> index 79e9593815f1..c5af8f703548 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>  	return 0;
>>>  }
>>>  
>>> +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>>> +					      struct tegra_dma_sg_req *sg_req,
>>> +					      struct tegra_dma_desc *dma_desc,
>>> +					      unsigned int residual)
>>> +{
>>> +	unsigned long status, wcount = 0;
>>> +
>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>> +		return residual;
>>> +
>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>> +
>>> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>> +
>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>> +		wcount = status;
>>> +
>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>> +		return residual - sg_req->req_len;
>>> +
>>> +	return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>> +}
>>> +
>>>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>  {
>>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +	struct tegra_dma_sg_req *sg_req = NULL;
>>>  	struct tegra_dma_desc *dma_desc;
>>> -	struct tegra_dma_sg_req *sg_req;
>>>  	enum dma_status ret;
>>>  	unsigned long flags;
>>>  	unsigned int residual;
>>> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>  		residual = dma_desc->bytes_requested -
>>>  			   (dma_desc->bytes_transferred %
>>>  			    dma_desc->bytes_requested);
>>> +		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc,
>>> +						     residual);
>>
>> I had a quick look at this, I am not sure that we want to call
>> tegra_dma_update_residual() here for cases where the dma_desc is on the
>> free_dma_desc list. In fact, couldn't this be simplified a bit for case
>> where the dma_desc is on the free list? In that case I believe that the
>> residual should always be 0.
> 
> Actually, no, it could be non-zero in the case the transfer is aborted.

Looks like everything should be fine as-is.

BTW, it's a bit hard to believe that there is any real benefit from the
free_dma_desc list at all, maybe worth to just remove it?
