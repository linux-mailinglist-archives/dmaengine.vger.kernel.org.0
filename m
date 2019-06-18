Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5114AEB9
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 01:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfFRX12 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 19:27:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34217 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX11 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 19:27:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so1313367wrl.1;
        Tue, 18 Jun 2019 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g2iclNRm6nOMmZXFGD4OtiWDNdKbrsf3t1qVWTSiVUM=;
        b=Kui+rX/6e7ebcrgx9MsYhrQj/u3swgQ6QAAaFjAE4SWWBiFe9VlOyWD/AJNOKnMInH
         GHFmjN6619Wxj+Ru+LHHjol6RWKlI9WYEjKqaI3DsBgMyZ2Vs56Zr/sJxb2nTNiRqvwF
         AZdDD1piEuNGSe+tyfrZaBXq2nVVf1cPOdNoa0TLs2x3yEuDnHwzfWKLFMFqSrRO4Nn9
         nUTm2YwPc6MKxvnsAwA0bHZ6JOL9trwFLkYseMdiyCs6TSjRfW0S5zQnmhVtZoqiYm5F
         1pi3SPWpeyMjwOAPRm2X9Enr4P5ZuT2CeotPSbbjgHkfa0DTRWSnqumZXP/apunzq9uP
         dmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2iclNRm6nOMmZXFGD4OtiWDNdKbrsf3t1qVWTSiVUM=;
        b=X/uq+LipXQJImvFyusRAerYctZWEfudNNHZTT7stYuzHbMtvf9C5C2LBhLDKdCzI2s
         koV7QiwgEnTx86mCJLr0nhqlaoiR01qrhNXlys9KdUlADiRuNnSrll3qlr4wVl0icC7O
         ResVGlWBfvoBgyVOn0xLT+jSsv7xnSrLI5CV1+1oj4rqRPOmOzb8p9Boxk6xC2/SpK/y
         CRyZ6TzP15zNleTo0X7zDKYHVSg8oJLfK5rxv506phtJl3UdTnQLe7HAm/LsMHIx6UV7
         5phtaf8zNxntc80gZnL6yENFUyCdAEjosvj3JS1GeCU6QXN6v7DbCmp4ieLzMfuFvKsB
         C9dg==
X-Gm-Message-State: APjAAAWRshnhK/zW31J37iUHz7TaqMk6pUtOd9XJ1zH3HCM++nRAQnl8
        vQURTUCGasK6LD1P+u1RRk6QwXox
X-Google-Smtp-Source: APXvYqzV7LbifgtgWOxEqVifLCW2MPR/Z8RSbTw5Vs6aqu0hg5TE5aQuqKSDg0Y+5wsLBFzxqY0csg==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr2469511wrw.279.1560900445101;
        Tue, 18 Jun 2019 16:27:25 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id x8sm3625627wmc.5.2019.06.18.16.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:27:24 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
 <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
Date:   Wed, 19 Jun 2019 02:27:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

19.06.2019 1:22, Ben Dooks пишет:
> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>> Tegra's APB DMA engine updates words counter after each transferred burst
>> of data, hence it can report transfer's residual with more fidelity which
>> may be required in cases like audio playback. In particular this fixes
>> audio stuttering during playback in a chromiuim web browser. The patch is
>> based on the original work that was made by Ben Dooks [1]. It was tested
>> on Tegra20 and Tegra30 devices.
>>
>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>
>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 79e9593815f1..c5af8f703548 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>       return 0;
>>   }
>>   +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>> +                          struct tegra_dma_sg_req *sg_req,
>> +                          struct tegra_dma_desc *dma_desc,
>> +                          unsigned int residual)
>> +{
>> +    unsigned long status, wcount = 0;
>> +
>> +    if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>> +        return residual;
>> +
>> +    if (tdc->tdma->chip_data->support_separate_wcount_reg)
>> +        wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>> +
>> +    status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>> +
>> +    if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>> +        wcount = status;
>> +
>> +    if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>> +        return residual - sg_req->req_len;
>> +
>> +    return residual - get_current_xferred_count(tdc, sg_req, wcount);
>> +}
> 
> I am unfortunately nowhere near my notes, so can't completely
> review this. I think the complexity of my patch series is due
> to an issue with the count being updated before the EOC IRQ
> is actually flagged (and most definetly before it gets to the
> CPU IRQ handler).
> 
> The test system I was using, which i've not really got any
> access to at the moment would show these internal inconsistent
> states every few hours, however it was moving 48kHz 8ch 16bit
> TDM data.
> 
> Thanks for looking into this, I am not sure if I am going to
> get any time to look into this within the next couple of
> months.

I'll try to add some debug checks to try to catch the case where count is updated before EOC
is set. Thank you very much for the clarification of the problem. So far I haven't spotted
anything going wrong.

Jon / Laxman, are you aware about the possibility to get such inconsistency of words count
vs EOC? Assuming the cyclic transfer mode.
