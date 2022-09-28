Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691995EDE39
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiI1NyX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1NyU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 09:54:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0398598;
        Wed, 28 Sep 2022 06:54:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu25so18596152lfb.3;
        Wed, 28 Sep 2022 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pJaOmlDhm2J/Qv/9jO+uJFLo/xFaMO8ypgUu9QLNXjQ=;
        b=FQjoFIH0M+6s8FrYI/bYP7fabSnsu/OgjzEb1aVrl5++pl8CMC+Jjf4lDvCX5XJpzb
         YU2uBA+Bf9CmTn+vaDEgIcSV/RwxzLeowKUKZ06qsqVSLtWeTBazJ9U18yVs/OR3gkos
         4S30CiySj9soED9Q74EjKR7piBbNtFJ6AMiQJQkrq3jKAdRU7G0NKClGqhGj0FJmHSqj
         TZyVD2RDYvNTMKiCq50irtJ2f87xPG6pY+C9qBQ3L2cf15fdSRqB6G8NvbUqRoWSXn3V
         CyqbGVsBSkN1/VuT5BvBfCMZ6NFDjqabc92L7N2r7BWuhBMIdE8ZWj0me4ZRa+0+gKc/
         m7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pJaOmlDhm2J/Qv/9jO+uJFLo/xFaMO8ypgUu9QLNXjQ=;
        b=zagGA5oWRaD7S7OEaUuug9dvIWn67sF2cwyK3DmzcmumOPIhhtIigg1i95dFpfuJaJ
         th23HalrifbsSoD1IHlTtcs0UuhSEAgyMAvSmSEicZmiPzKJwLzc6QtS3LIQu2/t6iQ8
         pYjgB/AiLhbm5fdAiwKPzcWBA0741HVflZZBS+dWDjPmwnjZ5gEIMeV+qlE7U3M/rWQ6
         PH6tsOKfuLx+/KCkdb7Fj7fv01kpMw7EAnBDCy7YdZ2z54GT6PyEoX2W8X21RF3GeMdo
         OArUwEeJpwz/EPMnM242+LEmUe5nH3SeBFQAJe9vfUdl7v9iaoj4DMTBZ9g6ZI2nI51k
         Nzow==
X-Gm-Message-State: ACrzQf0LAYWA76NCg3X48iTUJ/rrNAtzT9fnKU/k9p1VqqsEEGt1nBb5
        O1Wl67y1JoB9yc2RlT3jRx8=
X-Google-Smtp-Source: AMsMyM52L82ePjStOypgNj+CtqLqDyXMXbCIl4plBUXZUHXjcAtcth2MnLXLqw+8XWKoY7AYVYnGVQ==
X-Received: by 2002:a05:6512:31c8:b0:49c:db9d:bb97 with SMTP id j8-20020a05651231c800b0049cdb9dbb97mr12881483lfe.12.1664373255370;
        Wed, 28 Sep 2022 06:54:15 -0700 (PDT)
Received: from ?IPV6:2001:999:270:b554:a1b6:ee54:d32:c388? ([2001:999:270:b554:a1b6:ee54:d32:c388])
        by smtp.gmail.com with ESMTPSA id d28-20020ac25edc000000b0049462af8614sm479500lfq.145.2022.09.28.06.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 06:54:14 -0700 (PDT)
Message-ID: <007480c6-890d-a5c4-8b36-9aeb95de690b@gmail.com>
Date:   Wed, 28 Sep 2022 16:54:35 +0300
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
 <541337f7-1c0d-3ea4-d959-cd5aed83e615@gmail.com>
 <7hfsgcxvl3.fsf@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <7hfsgcxvl3.fsf@baylibre.com>
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



On 28/09/2022 02:10, Kevin Hilman wrote:
>> When I did the module support there were also a tisci dependency which
>> for some reason took too long for me to be able to send these.
>> I can send my version later if it is OK, but if Nicolas have a better
>> take on it, I don't mind.
> 
> We've got a handful of other conversions coming for a fully modular
> kernel, so I'm sure Nicolas would be happy if you took care of
> ringacc. :)

Sure, I will send it when the UDMA part is merged.

-- 
Péter
