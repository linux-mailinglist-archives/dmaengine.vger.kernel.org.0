Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61F63FAD3
	for <lists+dmaengine@lfdr.de>; Thu,  1 Dec 2022 23:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLAWrn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Dec 2022 17:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLAWrm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Dec 2022 17:47:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF855A1
        for <dmaengine@vger.kernel.org>; Thu,  1 Dec 2022 14:47:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v8so4314396edi.3
        for <dmaengine@vger.kernel.org>; Thu, 01 Dec 2022 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2kIVsQfN9yKH0DYGMpC0ApzZk7KmelbVN6aprGnz3wQ=;
        b=G8BEj3JH2fZS872/6ZTXfJz73rjPHbRTMO8k+5CSFm+fcAZuYGHbcvwjPp9YURHOvC
         9IIsh8RJ3zWJSAiftpVd6gSjNCzb8qZrEt1JzB7sha4C3q/2ozW98CYFXS1v+YKkEZEw
         cDXVwNGKUr0LRxZeYkYf1GjMDFzMriqErtgvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kIVsQfN9yKH0DYGMpC0ApzZk7KmelbVN6aprGnz3wQ=;
        b=p76V/SjzeOqPtWuRgRhjlaHPUtBDJJuVFjGsCoaBvGseRS0ajJNL44SHcjWwkTIR0B
         vbBk8lLkEZLNMpNy7OC1/3c7FEqEVOMzASR5dtxpB7c9/iMAeAuKO+vcluqp0DHdRZHo
         QJnx02nm9uLmWpNheGsiyYeSOvMWjuusJcJeN59Qb2u9Isfeax3NgJKB4kFPfi04x7SS
         R6GFwJiJa6VLjFn+PCTfIVmBFtC4jfGSnZhElsGzPYJxhj6vykde4EPNgv39Ar1NncQr
         Q8IWZoZSSUlUfCnjwJ5uw8MMIE2EDvoD77EoJh6/UmhOcYMWfdlqsfKFm/J/sWenPobU
         eAoQ==
X-Gm-Message-State: ANoB5plCONe9wD6R/1bw4CMulAB6bf2rsrFatO1an2zDe1mXmQ52m9sB
        r+WoOPqfaKMLOENpIYjAbLEFKRQwG84ExpV3
X-Google-Smtp-Source: AA0mqf4Gl93yWc+ePjQmzJFKYBGQDICdS/6nTAiXcmTiYLyyY9C7nO9a6psdnIO0HoOXHnqzDKoa4g==
X-Received: by 2002:a05:6402:528d:b0:468:dc9:ec08 with SMTP id en13-20020a056402528d00b004680dc9ec08mr47203800edb.17.1669934855776;
        Thu, 01 Dec 2022 14:47:35 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b00781d411a63csm2253018ejc.151.2022.12.01.14.47.33
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 14:47:34 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id u12so4224337wrr.11
        for <dmaengine@vger.kernel.org>; Thu, 01 Dec 2022 14:47:33 -0800 (PST)
X-Received: by 2002:a5d:4943:0:b0:242:3ca3:b7bd with SMTP id
 r3-20020a5d4943000000b002423ca3b7bdmr2729799wrs.583.1669934853656; Thu, 01
 Dec 2022 14:47:33 -0800 (PST)
MIME-Version: 1.0
References: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Dec 2022 14:47:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VWJvBU=uAPpyegxYz-k2sx=jBgiNm=qrso3cb3FXtqjw@mail.gmail.com>
Message-ID: <CAD=FV=VWJvBU=uAPpyegxYz-k2sx=jBgiNm=qrso3cb3FXtqjw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 4:20 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> As per GSI spec, link_rx bit is to be set on GO TRE on tx
> channel whenever there is going to be a DMA TRE on rx
> channel. This is currently set for duplex operation only.
>
> Set the bit for rx operation as well.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)

I don't feel qualified to actually give this a review since I don't
know anything about the details of GSI/GPI. It seems simple enough so
I'll just assume that Bjorn will land it. Ideally someone else at
Qualcomm would give you a Reviewed-by tag.

One drive-by comment, though, is that I would say that your patch
description lacks an answer to the question: "So what?"

In other words, what is broken today? Does everything work fine today
but some bit counter looked over your shoulder and told you that you
were a bad person for not setting that bit? Did the lunar lander catch
fire (despite the lack of Oxygen on the moon!) because it started
using the RX transfer mode to talk to its fuel valve system and the RX
transfer mode never worked? ...or maybe everything today works but the
super secret Qualcomm SDM9002 (shhhh!) chip needs this bit set? Help
people looking at your patch be able to decide if it's important for
them to pick to their kernel tree! :-)

-Doug
