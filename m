Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130C64F29E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLPUu7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 15:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiLPUu5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 15:50:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C72F013
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 12:50:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id tz12so8867156ejc.9
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 12:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ty4Q6pmKGBdcK+JvghcaxT3SktTZCwT4+BsAt6gEM58=;
        b=K281Hjcnge0R86zglG2H9v4Gt/ejUenfiXW6UYj7GNr4X2YogLbL9zN80GvGkEXpLF
         bAscjiNEWAXJvdbmAen53eXH+PgSzU4jrBtGIts4eu+BzaMaTF5Zcp+/cIJ6ooacQEeD
         7p18N6vnCNtUjS6nqN27cydZ6JYP9JpNOQr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty4Q6pmKGBdcK+JvghcaxT3SktTZCwT4+BsAt6gEM58=;
        b=U9L0F3k3sV+IDF7f+sVu/hUk0nd3GProTNJJQWrBBtU1LabBIEo/sak1+eLCr0T8VB
         UnqYqpb5AiOqG86RLIiuIR2Ar2DG4TaVTCR9RfSt8Ic2btb8QUjaljNO3+jn+GnjrGbS
         KsIABSQeIaSFPZLIPzhMZ5kUVuXKT8d9cWLTn9sESvAeLoT2tSyy2CnYTIw4lUXWdlKw
         ERsrnhbhH4tNYh/qzI4AMMZE8cvxzoz3iese1+HjvzPI9tAGA1ic0X9QhqpgkqgHyHWd
         rROUso9R9LverZM65ajr87NEVWv8Aj4CVGnbdTULDT7XH3PpFXYnBxqq80FUkYZTD77q
         t/Qw==
X-Gm-Message-State: ANoB5pnAD1wX3bkaACYySvmDUupRnHU6YUOrqlWu3fRad5kQYEB3p9Ko
        sfJ3xI61jOn7aW5uJx57DBCNvWhu9rh81eFZd40=
X-Google-Smtp-Source: AA0mqf6BT0PXIxolwLfsf44ffgi7F3b+Qt5LNJN+XKuKhWd0l/TtV1tU+E4KWKZAliP33rhSWJk4kw==
X-Received: by 2002:a17:906:7751:b0:7ae:df97:c020 with SMTP id o17-20020a170906775100b007aedf97c020mr27653374ejn.13.1671223853269;
        Fri, 16 Dec 2022 12:50:53 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402045a00b004610899742asm1262583edw.13.2022.12.16.12.50.51
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 12:50:51 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id o5so3673872wrm.1
        for <dmaengine@vger.kernel.org>; Fri, 16 Dec 2022 12:50:51 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr26993001wrs.405.1671223850700; Fri, 16
 Dec 2022 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Dec 2022 12:50:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UH_K+oyKOxk88_3zcYTB8C8JHAJVqFwLdO4DE0_wtvBg@mail.gmail.com>
Message-ID: <CAD=FV=UH_K+oyKOxk88_3zcYTB8C8JHAJVqFwLdO4DE0_wtvBg@mail.gmail.com>
Subject: Re: [V2] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
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

On Fri, Dec 16, 2022 at 9:38 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Rx operation on SPI GSI DMA is currently not working.
> As per GSI spec, link_rx bit is to be set on GO TRE on tx
> channel whenever there is going to be a DMA TRE on rx
> channel. This is currently set for duplex operation only.
>
> Set the bit for rx operation as well.
> This is part of changes required to bring up Rx.
>
> Fixes: 94b8f0e58fa1 ("dmaengine: qcom: gpi: set chain and link flag for duplex")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v1 -> v2:
> - updated change description
> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)

Without knowing anything about how the hardware actually works, I can
say that the change looks OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
