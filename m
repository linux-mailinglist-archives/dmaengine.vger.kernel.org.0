Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE96250FC
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfEUNrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 09:47:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39192 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfEUNrV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 May 2019 09:47:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so15943174ljf.6;
        Tue, 21 May 2019 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=In5PRp85Hdp7mJFze1AHQkeVW9zdgNgdDH3L4mddjfI=;
        b=VUnf2o+ViCCTsf9a7aQEus8kSVExtQxa2qJjTwk++BreeX0+tlkonkHafflrc2y0fB
         1rHXxl/zAK4hq1UyWtGk0jEoSeLbn6+vvGibilMBecXBuhFBbrjuiiToz/ZISMLHnKcH
         IACydUqrVt18rQggUf27Dz3vV6T1XLI+h8cdTWe/VsLGdB1kntXnaiBxuvnFRvNQBvLt
         SbIRp6CMl9m82GbIMCmHULKrv+pz8qyCf5fH5qNRSSaOziJH4Vad8ft/jxhEHeXZAY5Z
         am9v3E4Zlbc9PIVVt4mRzGXOZqPLJwRczdLa58G9y/d1lkfdi058ZOJZvQq8E3YCP++x
         55Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=In5PRp85Hdp7mJFze1AHQkeVW9zdgNgdDH3L4mddjfI=;
        b=CluZ5x+rLdaNyyo5T2ebvBYlYcuxVRSm2NJLMEOi0geOVwgie6ZCLCqJlWjj88UDLk
         aHj0KJxlZuJg0PhnYQ+FaPvBwwq7Num3YllvP2CO5KXGvtgEkZVa4iUajqjmXYyFxBFE
         w+iKYak+7KIr0YPKK54ECjjRgjLYVl+uNXzzzG8ptRceaIy7P1jkDo27G49ArvE3XD4X
         x3b/JVsZHqTYWqAXU25/iYhejw4jmjG/xI/fVkxi9fJ2RRNaAEzCuNt+dewRb2Q/H+6C
         Mvq0yv+jRatmg1V0uimH/uzRzS2LWt1A4aoAbzyV12Ij6VZSOMChBTwjIvi+4tqtP5Hv
         iIaA==
X-Gm-Message-State: APjAAAXePh2TEom58JMUJsmUWSbyHh6E1FOhm3g3Owb+Qf+vh4QZjOHm
        MFXqkv/tfW5ww7te56BiITPPuhPb
X-Google-Smtp-Source: APXvYqy/MngDy/oMQUQBSli0p3w5nw/8PnfFEKecb2nSAakgxPyzjNmCOnf8QHRDDe7bp2cQVFO/ww==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr39365811ljc.61.1558446438471;
        Tue, 21 May 2019 06:47:18 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.32.140])
        by smtp.googlemail.com with ESMTPSA id z6sm4601722ljh.61.2019.05.21.06.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:47:15 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Handle DMA_PREP_INTERRUPT flag
 properly
To:     Vinod Koul <vkoul@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190505181235.14798-1-digetx@gmail.com>
 <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
 <20190521045545.GP15118@vkoul-mobl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <973513f9-0d87-4c39-6b29-f98a1d9dc00c@gmail.com>
Date:   Tue, 21 May 2019 16:46:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521045545.GP15118@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

21.05.2019 7:55, Vinod Koul пишет:
> On 08-05-19, 10:24, Jon Hunter wrote:
>>
>> On 05/05/2019 19:12, Dmitry Osipenko wrote:
>>> The DMA_PREP_INTERRUPT flag means that descriptor's callback should be
>>> invoked upon transfer completion and that's it. For some reason driver
>>> completely disables the hardware interrupt handling, leaving channel in
>>> unusable state if transfer is issued with the flag being unset. Note
>>> that there are no occurrences in the relevant drivers that do not set
>>> the flag, hence this patch doesn't fix any actual bug and merely fixes
>>> potential problem.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>
>> >From having a look at this, I am guessing that we have never really
>> tested the case where DMA_PREP_INTERRUPT flag is not set because as you
>> mentioned it does not look like this will work at all!
> 
> That is a fair argument
>>
>> Is there are use-case you are looking at where you don't set the
>> DMA_PREP_INTERRUPT flag?
>>
>> If not I am wondering if we should even bother supporting this and warn
>> if it is not set. AFAICT it does not appear to be mandatory, but maybe
>> Vinod can comment more on this.
> 
> This is supposed to be used in the cases where you submit a bunch of
> descriptors and selectively dont want an interrupt in few cases...
> 
> Is this such a case?

The flag is set by device drivers. AFAIK, none of the drivers that are
used on Tegra SoC's make a use of that flag, at least not in upstream.
