Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B644D152248
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDWRh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 17:17:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDWRg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 17:17:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so272883ljl.9;
        Tue, 04 Feb 2020 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OMnQ0aho9hVBXoHkw9xlZzqlNYr0sDiGuRFANK6I7Ws=;
        b=l3e9dDsNbimyYI+HcnwDopd0zhHkC2U9diKtxcOoxySzKqCtcYYAvSsKCoRJnfl6b2
         xbEphyBQJU0CwjAu81sC5Mjk8eIhpcdDEFYIcR7Ir7gI/pIo8XH+RoIbg2iGuuFxpYSp
         QyfIRNdYPJbo+bIousQ/Ak6kx3SIkT9iC15mLgp4mmFBH2MRfa9tgxF6611esth0/7BA
         OwsE7DJWjzXP8OYKn0PeumQywchtvjJMR/CtXaovHPDhjq07b/KURZoNJ3/8g4QKQYGU
         B+lzRaokfUTm+bnD2kHkx+euy/VN+91NlABOSEHITa7VbD0k28h86uY4tkdI7cM26UFA
         8pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMnQ0aho9hVBXoHkw9xlZzqlNYr0sDiGuRFANK6I7Ws=;
        b=MDRlnkl7KTbQIRkdo0mK5Mh1fhSgLelX1HMycrlRrRgkhDOUryvqw4eyeETrm2mx/B
         tqmXZzKw1cH9G8nsH96VTCtgVL1DZNlczbxMifJh5ryW7Cvut0Kqg/MmZuScH2f2EtDF
         orLYNxsEtn7Q7KGpeYkcH6DFvA9z6PMLYcxd6I+bZPEquyKq3w8sJ84ZQo2hl5v7aDaG
         v2NG0T8zp6Iz8OdHsyAgGVbv+OqJIAWBg9/Zo9doFpMVbNr3F8N1RygMb4AwVAGx2OvO
         ddCUBXJvf+PIj2P/GbE57YmwL6jtveU2ZE8oeUe/NTU3U3VZDM5dgdYp9iZxU7bdG826
         RnwQ==
X-Gm-Message-State: APjAAAWIOJXc6So6+CzVfnAzINHt1N3rpi6zivVQTVDcRwaD4L7Wo+U1
        HTfLWz7jat/UYPfJh/9ZmeHizIJK
X-Google-Smtp-Source: APXvYqwVB+ckkMTuJHrbL+3XrfRf0KN6xTDOjLSiqZ1gk92dkj0kiUZrTFSCehELuFI/y51nqp56Mw==
X-Received: by 2002:a2e:990d:: with SMTP id v13mr19304487lji.47.1580854652656;
        Tue, 04 Feb 2020 14:17:32 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i4sm12254131ljg.102.2020.02.04.14.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:17:31 -0800 (PST)
Subject: Re: [PATCH v7 12/19] dmaengine: tegra-apb: Remove handling of
 unrealistic error condition
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-13-digetx@gmail.com>
 <b2461a42-5939-b2b1-01fe-6f18c860dbd9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e89b7319-74c6-4a88-4634-f127aca86851@gmail.com>
Date:   Wed, 5 Feb 2020 01:17:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b2461a42-5939-b2b1-01fe-6f18c860dbd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.02.2020 14:52, Jon Hunter пишет:
> 
> On 02/02/2020 22:28, Dmitry Osipenko wrote:
>> The pending_sg_req list can't ever be empty because:
>>
>> 1. If it was empty, then handle_cont_sngl_cycle_dma_done() shall crash
>>    before of handle_continuous_head_request() invocation.
>>
>> 2. The handle_cont_sngl_cycle_dma_done() can't happen after stopping DMA.
> 
> By this you mean calling terminate_all?

Yes, and also the handle_continuous_head_request() itself because it
stops DMA on error, which clears interrupt status, and thus, ISR handle
returns IRQ_NONE without handling next interrupt.

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 62d181bd5e62..c7dc27ef1856 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -564,12 +564,6 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>>  {
>>  	struct tegra_dma_sg_req *hsgreq;
>>  
>> -	if (list_empty(&tdc->pending_sg_req)) {
>> -		dev_err(tdc2dev(tdc), "DMA is running without req\n");
>> -		tegra_dma_stop(tdc);
>> -		return false;
>> -	}
>> -
>>  	/*
>>  	 * Check that head req on list should be in flight.
>>  	 * If it is not in flight then abort transfer as
>>
> 
> There is also a list_empty() check in tdc_configure_next_head_desc()
> which is also redundant and could be removed here as well.

Good catch :) I'll squash all these list_empty() removals into a single
patch.
