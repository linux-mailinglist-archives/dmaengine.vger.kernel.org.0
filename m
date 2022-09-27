Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9150F5ECAAC
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiI0RVh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiI0RVg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 13:21:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0FEF0BD;
        Tue, 27 Sep 2022 10:21:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so11657793ljr.10;
        Tue, 27 Sep 2022 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Y1H5sQw1pB57hlTStlx7yu2qnClPknyxb90LREDOfJM=;
        b=UVWz/KfeGp0cOYxIOpGvpl6qI1R8pPOVRUwVvgjN1yqWCeHoN7ejEhBI92+5CUOkc5
         IP1g4satFGhiRRznF9pB1colfYEbGJJI8IkOzNYf5iGplVIaiE9QG8DRgNUW3fUY2J6E
         uUlxvxVinfrFkfSv3Wo2loA1OUiT1srMby0etFxIBxYwZhSVgOh4HZ9pZ542D3AANHMP
         /S3FEUD0or50fF9rnH9phXgHsUVA+i9v9yJrBgzgDmmXYXF8wDnFnS6zm9votKF+XrtY
         IZZ92Cl/lfQ+KI3svh0YpO64wMeZAmIa9HQkIXHhqlyeXpdl2L+/3oW8VEZrB8az4IOT
         V2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y1H5sQw1pB57hlTStlx7yu2qnClPknyxb90LREDOfJM=;
        b=aBkOCYeJLUlnGDKyDhM4IZMh2S3i+GBMObPBCdcYoZ4YGmE9b9mmwTyndzLzqAsbfX
         q0t1158D1rSgvzfS0BO80SCHU2uWmFz8blC/3ByyR3sanPViHW/i3VDIr36mvAv6E1of
         fjSFIhClfhyZnjjDmAtEb7brk14DckTVKkTecpfcT7w1J0IWF22LBWUySNgJ+jN3E+U4
         e3D9LOjEYXjnS24RCtHjZjwGZ769glLv19MvdfJ128VCtaT5Svj4bqwMBelRTBhnZcKK
         1FYJmeWDz/RDqVu4a+gJp2ZAieX6f1ewcBElv1QoZJ+xmaWsZqhXJaSvKYm48IohWuds
         m5JQ==
X-Gm-Message-State: ACrzQf1ojgJ6cuBsZ4r94nfph4UEy6bIfkuJKgSVxLXYVQFyhRC4xNng
        +j6NLhlxBMHQjHwb4uBeFoc9px1Z30tdfg==
X-Google-Smtp-Source: AMsMyM5EMDAfdCgT3bXJLqU/0O3iq+aMoyCBq5ABOgKS4zM9naWYwBFBa0rAVvkmDXt6tv1hY7sPLg==
X-Received: by 2002:a2e:a547:0:b0:26c:6b98:6b2e with SMTP id e7-20020a2ea547000000b0026c6b986b2emr9672366ljn.90.1664299293781;
        Tue, 27 Sep 2022 10:21:33 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea608000000b002618e5c2664sm209507ljp.103.2022.09.27.10.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 10:21:33 -0700 (PDT)
Message-ID: <541337f7-1c0d-3ea4-d959-cd5aed83e615@gmail.com>
Date:   Tue, 27 Sep 2022 20:21:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/3] dma/ti: enable udma and psil to be built as modules
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <cf3194ec-0952-fa7a-cc05-6a60e7e66cf0@gmail.com>
 <7h7d1pg7c4.fsf@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <7h7d1pg7c4.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 27/09/2022 00:21, Kevin Hilman wrote:
> Hi Péter,
> 
> Péter Ujfalusi <peter.ujfalusi@gmail.com> writes:
> 
>> On 9/26/22 21:18, Kevin Hilman wrote:
>>> Enable the UDMA driver & glue and PSIL maps to be built & loaded as modules.
>>>
>>> The defauilt Kconfig settings are not changed, so default upstream is
>>> still to be built in.  This series just enables the option to build as
>>> modules.
>>
>> I can finally drop the half backed stuff I roll on top of -next ;)
>>
>> Do you plan to convert the ringacc also? It is straight forward, like:
>> https://github.com/omap-audio/linux-audio/commit/01f9290c1c61e8bbc0fbdd877382672883ba7e73
> 
> Yes, my colleague Nicolas (cc'd) was planning ringacc shortly, but we
> didn't realize you had already don it.  Your version looks fine to me.
> Any reason not to submit yours?

It can only be sent after the UDMA is able to be built as a module.
When I did the module support there were also a tisci dependency which 
for some reason took too long for me to be able to send these.

I can send my version later if it is OK, but if Nicolas have a better 
take on it, I don't mind.

-- 
Péter
