Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DEB5ECA79
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 19:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiI0RHX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiI0RHC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 13:07:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614127F126;
        Tue, 27 Sep 2022 10:07:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so16637937lfp.11;
        Tue, 27 Sep 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BaEFTF84Sq9es7HLhqX2u2yUo9a+LYXjNYWykwUDGuI=;
        b=ieRIRTzg5cPUgSPupmXj6itXG2BPhwAkJ4XIFPNoHaJm4diHLiZmi3TUCIb9Lr9r1X
         2kp5lnGmm+a9YravKvDSZXcSkyNUL63aXdZzEpLWB8JwqasokAwViNnT6gwiZwkWXwOm
         jJpG1aseCosvIPcWQEbolBXukZRZe8cr660Zctf7gIreX2JKz+1luCmNV87xz2m51dXZ
         7VBQ4g8vL2WWiiK6fr0WraQliPXPE4rD88RSG14hpAiAElrmzSYcy1JPHkeJOeqERLRf
         xVU9fA/xCbZfWXDTsth55mHqeJx6CYXG35l8ZqPslq3h0yrfErkdgAh0zQxkdqoGzjPQ
         jYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BaEFTF84Sq9es7HLhqX2u2yUo9a+LYXjNYWykwUDGuI=;
        b=T+j2T9xP3U5u29ddNnsKApyk58/GMh39UkE5QZKofdw7DXuGGE80I+nbFbEot4nNfP
         K2unmD8W2JNreHQwnFzs8hIJT3wrOnhq4UrKDeWr02LC0ljxwtzfkfOG9pQMMZy8IOH9
         bI6h5JfJG8Vzgb4TcHx37d2RRo1AwuofyHJj4P7SDLj8sA9aEZDpf2agEns8+ihApRF6
         P6x8MSoSucKW++MbgdcQwq1K54XgD768F1Sc+1aXE9abbulymQ/q/G3OQOxA0hrwqy/z
         zxKwmMVEkoUDE4CaZ29s93fMg+I0vjydm4TpSg3oSQJUkUxqh2ua+oGdjwYQr06pV3X5
         LdZA==
X-Gm-Message-State: ACrzQf3eUWa7ledcbSTGzK10FtqwiL8WnWDMLhLkqiNagDp0Jd2n2tuq
        DmeEOIsvJHYSEI4YrLfpQAdrD4UPKb3x2Q==
X-Google-Smtp-Source: AMsMyM6DCoL7ElzUr0JSiL4FuAECxj7Iz3V0niMElOla8pFSXPXxil2ys5+8+ptHFLNdO6Mt9VoCDg==
X-Received: by 2002:a05:6512:311a:b0:498:f5dc:799d with SMTP id n26-20020a056512311a00b00498f5dc799dmr11249789lfb.501.1664298419426;
        Tue, 27 Sep 2022 10:06:59 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b004a031805c8bsm213873lfr.106.2022.09.27.10.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 10:06:58 -0700 (PDT)
Message-ID: <7fcb754f-2067-38b7-3224-f5e2cd12165a@gmail.com>
Date:   Tue, 27 Sep 2022 20:07:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] dma/ti: convert k3-udma to module
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-3-khilman@baylibre.com>
 <11cf284c-d0d6-0687-b70b-2245ff8d6fcd@gmail.com>
 <7hczbhg7ij.fsf@baylibre.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <7hczbhg7ij.fsf@baylibre.com>
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



On 27/09/2022 00:17, Kevin Hilman wrote:
> 
>> I did liked the 'hack' that the dev_* prints contained the actual type
>> of the DMA (udma/bcdma/pktdma), but it is not working via modules,
>> unless the driver init parts are split out and the bulk is kept as a
>> library.
>>
>> I had this half way implemented in my wip, but never got the chance to
>> finalize it.
> 
> I guess that could always be done as a second path if needed, but I
> wanted to keep this module conversion as simple as possible at first.
> 
>> But, one can get the info via the address, so...
> 
> Shall I take this "so..." as an acked-by?  ;)

For this patch, definitely:

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Kevin
> 
> 

-- 
Péter
