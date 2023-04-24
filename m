Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563646ED528
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDXTPS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Apr 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXTPR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Apr 2023 15:15:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D459C0;
        Mon, 24 Apr 2023 12:15:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so47031061fa.2;
        Mon, 24 Apr 2023 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682363714; x=1684955714;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6n9xZ3Im8z9nJ4jY7b8gL+RDR1D2YAMLUav6Vnkki4=;
        b=RpB5PLaDKL/QSNgL9IWtSeNvmyCnrd5PI5CN2P//xnsrxWZecxOMEmwt0FP/b66wk3
         1eNohbg7s2j1IYVk2o5MbgSMhIPu/lvyZmBycVMxlHHwWVz+BA5g1QRGWYDbKYsXxqRd
         +KB6Oz10uG+daPujGB40K8dowtuZ53FW8XbS78s5Fat4iOWLHlTdijak7XFP2XuNWOJp
         HnXKFv/xrHe+LPe9y+oBFH7qYULfFuENZ6giSWs78B67OhcnVp5pEFfDahY3+je7WUX8
         m6Zs/QijmuYTXdf/Dwdv1bkUGZfH/YzyfyXvfriGLVME4+1g7kUECHloqcjFTeNhPo4N
         6KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682363714; x=1684955714;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6n9xZ3Im8z9nJ4jY7b8gL+RDR1D2YAMLUav6Vnkki4=;
        b=kgz2KgUC1V0WB1Q2xedicC4GUiW5/l0g7ALsNI82sjh0JOjVQC++EVt5QJCNaY6AYu
         d05Dh/+y6ftA7qSvR1auOpZy/CCq82TQ54PO+Q+fyMrayRIwaMjVsdnsFo++3LJQCsrk
         uxM/nwqHLgS5zjjZKWr8XSkcTWBxTbXQqPgqzK5Z+m2EOr6AQeIdzfKAIrm1ddoK1dGk
         wojWZxV1g5lHR/XZVDBT/WbE+5jbGvRNsHY98t4jJkibwjJtlVTSYyWCbT2hFOUsHnxB
         0uWKFTVmYcm0X78NPE0JLpDGW1OrUTo8iGjqXrSl+QLYlzUmhHqp23nefP1+AmpgwvbP
         4T5g==
X-Gm-Message-State: AAQBX9c4mGUCJHaKrksfKgLsSczilPTmeGP6IGTFPbq3a16PWa7+Yi0T
        xnKXW3W9D1n6+tMh+tWn6ZHX5NQkZEsxPg==
X-Google-Smtp-Source: AKy350ZApTJD+Uiv8ZW5yZ6na/BxqZexSxuAsTWeIQKPAY9lHs3sQogBH0Mqk0v/6Bl1N9AAchZPqA==
X-Received: by 2002:a2e:9a88:0:b0:2a9:ef05:8b7a with SMTP id p8-20020a2e9a88000000b002a9ef058b7amr2759589lji.52.1682363714070;
        Mon, 24 Apr 2023 12:15:14 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c008900b002a776dbc277sm1825989ljq.124.2023.04.24.12.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 12:15:13 -0700 (PDT)
Message-ID: <d5a29b90-4fdc-9cd3-70cc-2f3ad40bf145@gmail.com>
Date:   Mon, 24 Apr 2023 22:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Vaishnav Achath <vaishnav.a@ti.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        "J, KEERTHY" <j-keerthy@ti.com>, u-kumar1@ti.com,
        Jayesh Choudhary <j-choudhary@ti.com>,
        "Menon, Nishanth" <nm@ti.com>
References: <291807c9-8d1c-56f0-ee39-4d221e18bd1a@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: Question: dmaengine: dma_request_chan_by_mask() and DMA
 controller probe order
In-Reply-To: <291807c9-8d1c-56f0-ee39-4d221e18bd1a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 4/19/23 11:27, Vaishnav Achath wrote:
> Hi,
> 
> In dma_request_chan_by_mask() , the probe defer logic returns -EPROBE_DEFER if
> there are no DMA devices registered yet. But in case of multiple DMA controllers
> in an SoC and when only one(or a subset) of the controllers have finished probe
> dma_request_chan_by_mask() can return -ENODEV incorrectly since the first DMA
> device probed might not support the particular mask requested.

That change was added by
ec8ca8e3b4809 ("dmaengine: dma_request_chan_by_mask() to handle deferred
probing")
Which apparently only works if we have a single DMA controller or
multiple with similar capabilities.

> What is the recommended solution to avoid situation like these?

I would say, that in case of dma_request_chan_by_mask() it might be
reasonable to return -EPROBE_DEFER if the mask cannot be satisfied with
the probed DMA controllers.
With the dma_request_chan() we know which DMA we are waiting for while
with the give me any channel which can do this, we don't.

On the other hand we have users where they fallback to CPU memcpy or PIO
mode if a DMA channel is not available, returning -EPROBE_DEFER would
break them for sure.

Probably a notification system of some sort or deferred channel request
with a callback?

> Consider the following scenario for example:
> 
> SoC has two DMA controllers, one instance of system DMA, one dedicated for
> Camera subsytem which does not support DMA_MEMCPY and has lesser number of channels.
> 
> * Camera subsystem DMA is probed first.
> * Another peripheral requests dma_request_chan_by_mask(DMA_MEMCPY)
> * dmaengine returns -ENODEV for above as the controller with DMA_MEMCPY support
> is not ready yet.
> * System DMA is probed later but peripheral driver failed to start with DMA.

A while ago I have sent a series to add support for 'dma-domains':
https://lkml.kernel.org/lkml/20190906141816.24095-1-peter.ujfalusi@ti.com/

That would handle this use case fine. Looks like I did not had time to
update (or rewrite?) it based on the comments...

-- 
Péter
