Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C763614CC75
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2ObL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 09:31:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38532 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2ObL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 09:31:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so12027984lfm.5;
        Wed, 29 Jan 2020 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R91c9ntZBlaQPLyZ3wJ8nBbTe0YSkDQN97EOOHvSD+8=;
        b=qm5WLSTVvRQQw9NA8BW6L1l7nF8NSOarFCXgMoxmpB2VVJqt198tbokl4Doj6RjaX2
         zu2jABl64d6IgDGQkeuuq9IkrHBmZkgzVPxb2hX8NVYMD+6T1niUF2fv5nn/3r005psU
         jcH66osAbyof6mdWpU8e/vHTlXXVuUkRQeDQPK+T3F7WfjsjvkWlYFVk0Brj8pBSz/fM
         NFYMNTaqDN7OUwENhNCOZGrgBFdP5RjfrHaXlInEw20sZ2mKePpTtmJ92AJXXBbJi0WQ
         O9L+ljA4I1SsqdJvagSzgnD7bIO8QFjZ47oY5G77DKU2F1aik0sYeL08phAOxPCbaZns
         A+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R91c9ntZBlaQPLyZ3wJ8nBbTe0YSkDQN97EOOHvSD+8=;
        b=twCVGhR7io4efdSDtc7rZdVbfWWH06ztaXDFtecq1KBeW6gVxTF7B/tQyhHeeBrrsv
         mSdgSyWiQ7MVd//+zfMBrNA2D8T49oCDhOffBqJ5sO4JzI8+ZDSfskcd2hsKkS002ud/
         vGkdaSnjJisbt/KW3inqMlimQeC7feA6E07P+vUbACeUxWlH0yHQlRbLw/jH2SLj8Cyb
         06QRqiycH3JkA2kLtt3E/BuMFngAFHyVg+WiUZqSZiY/XveHuYWjGMXQISNu/0kuNSwy
         hpW6y6yLd1fPEhOyu8SV43pr0ghIvbm/AH8nwqRoj5SpDElzRnSi6GSbSqSI5MZ3s+0p
         HnVA==
X-Gm-Message-State: APjAAAX0U1gEljef+Zz0Kbu+x4+uNE+Dz/Vaity2i3cbcMXWQ0dZdnWV
        BhWOTRLdlWvPCoCxctXaooWzfjTZ
X-Google-Smtp-Source: APXvYqzz2jPA2pFPn9WN/J9pcbI/wLvRYdPhKymxgZi3LpG4PWstlzWJpvg8L3XrcDw/Wwo6bhQg7A==
X-Received: by 2002:a19:ee1a:: with SMTP id g26mr5710270lfb.147.1580308268269;
        Wed, 29 Jan 2020 06:31:08 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l64sm1164871lfd.30.2020.01.29.06.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:31:07 -0800 (PST)
Subject: Re: [PATCH v5 08/14] dmaengine: tegra-apb: Fix coding style problems
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-9-digetx@gmail.com>
 <f724fd45-aa91-face-a267-5ea4caf6d8d5@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5f540eb8-07ab-eb42-b5de-e198d5439cbd@gmail.com>
Date:   Wed, 29 Jan 2020 17:31:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f724fd45-aa91-face-a267-5ea4caf6d8d5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

29.01.2020 14:03, Jon Hunter пишет:
> On 23/01/2020 23:03, Dmitry Osipenko wrote:
>>  	ahb_seq = TEGRA_APBDMA_AHBSEQ_INTR_ENB;
>> @@ -1269,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>>  	int ret;
>>  
>>  	dma_cookie_init(&tdc->dma_chan);
>> -	tdc->config_init = false;
> 
> Please put this in a separate patch. It is easily overlooked in this big
> change.

Somehow I missed context of yours reply to the v4 of this patch and was
thinking that you were talking about the "unsigned int".. sorry :)

I'll factor out this change into a separate patch in v6.
