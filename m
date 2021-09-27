Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87B3418EFE
	for <lists+dmaengine@lfdr.de>; Mon, 27 Sep 2021 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhI0GWO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhI0GWO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Sep 2021 02:22:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9EC061570;
        Sun, 26 Sep 2021 23:20:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c1so14805376pfp.10;
        Sun, 26 Sep 2021 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sfSEj0rPTEPzDgHuDRfdjsrWWUd62H1Qho/VgRutNCc=;
        b=ZVavvd5COvh92fVFt9Ny1h+tUDBlW+Hqf/R0vAWycANQYfEvbpdeJ2tOFvkfSjkb2h
         4y0B9B4GeDozKDHAelVYN/IwEvVSbpcr3ggnn3TFD6C/n1wA6+0YSzg5FA8jTMWxMsGT
         csSMpCUpdBRkkJRwRu5ENci4EjnThArA/nMxUu2lzUD/tJstxL30Ph7pi5Z+KEBcd3fM
         hdbTQq8khCyAMe4pr9M5q8Hh8/Qo+FOIcrVNq6b1vC/+wAOa+24vvdPz4o4AMqjQ0W3a
         /jzx7lQvn5RoS0lg6HnQJC4LO/hs7hhD9k96oi7tGHPwmNo0SVyL7/0wyCGgCd1IvL0G
         suaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sfSEj0rPTEPzDgHuDRfdjsrWWUd62H1Qho/VgRutNCc=;
        b=NxjaaT+0TJIV0TklNkeI7qlA/W5X0vKR2C7jh7kX5m0VKwjKOEDZLp6Am/bsy5uTcY
         FtCoQ17AZCsmfsNN2LkngWxf96tkiE1fbukKFbLw5IcIcoO3JdsMrSJipvaWfP94v83Z
         cJ455o9blMwWDZe5RIxlxNiXKFm2GlJmS4pJIOAVK3KfGKxVCF/csDJ1O7w2vGmJ0feM
         QIwb7DoJaxbZUyLtTbmAsTRch1boYFkP3wmOdXFFNKVNFhHpejc5dYuAZCymOuc2LnlQ
         sEgj5wWlXFQyZzt7q/vkVefICC9JhRxnrJk3oiWQ7qfFSpH92RuqXX8zzlvFA0DAUAT7
         /sUw==
X-Gm-Message-State: AOAM530uQmU8KAeCD1oNV85IoDHNDhictx/Yn5qHVv+Io6ntsNw5AkOg
        479FTxqWZsiVSog/1ucPAMKwkidWlz0tUQ==
X-Google-Smtp-Source: ABdhPJxXOGWGzHfJnQT7RMuBoTczdFaJNEW/z+shmzXticZPPQ2NvrHWmrVitqCiFdJpoY7iBXzxpQ==
X-Received: by 2002:a62:31c5:0:b0:447:cd37:61f8 with SMTP id x188-20020a6231c5000000b00447cd3761f8mr21940939pfx.29.1632723635903;
        Sun, 26 Sep 2021 23:20:35 -0700 (PDT)
Received: from [10.25.99.123] ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id w6sm16639261pfj.179.2021.09.26.23.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 23:20:35 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/3] Few Tegra210 ADMA fixes
To:     Sameer Pujar <spujar@nvidia.com>, vkoul@kernel.org,
        jonathanh@nvidia.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <dev.spujar@gmail.com>
Message-ID: <e4ad015e-464b-0445-07f5-1d77728b880c@gmail.com>
Date:   Mon, 27 Sep 2021 11:50:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,


On 9/15/2021 9:37 PM, Sameer Pujar wrote:
> Following are the fixes in the series:
>   - Couple of minor fixes (non functional fixes)
>
>   - ADMA FIFO size fix: The slave ADMAIF channels have different default
>     FIFO sizes (ADMAIF FIFO is actually a ring buffer and it is divided
>     amongst all available channels). As per HW recommendation the sizes
>     should match with the corresponding ADMA channels to which ADMAIF
>     channel is mapped to at runtime. Thus program ADMA channel FIFO sizes
>     accordingly. Otherwise FIFO corruption is observed.
>
> Sameer Pujar (3):
>    dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
>    dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
>    dmaengine: tegra210-adma: Override ADMA FIFO size
>
>   drivers/dma/tegra210-adma.c | 55 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 38 insertions(+), 17 deletions(-)

Can you please pick up these changes?


Thanks,
Sameer.
