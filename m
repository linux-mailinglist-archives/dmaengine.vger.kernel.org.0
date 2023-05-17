Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D36706070
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEQGuw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEQGuv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 02:50:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55F10C6
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:50:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a1462f9f6so2478827b3.3
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684306247; x=1686898247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poHrvY/Mj7upONPUEFj3MugSQ2bj/7VrwwgqmAb8Rzs=;
        b=FwCuDgjksJXiqv2EyN/Q5hmvDF9UZySUJ+lMxaccGm2LJiWhU6eCC1OWU6NhqDJv8u
         /I7Ygw47/BbcdZ+im7Fhot1rrnGIjAbXzajzWPUyo/aXH/5tKEwa59qwLUKZA0YuKPhC
         Q8sugr4L3WehywMZboYrFPJXXWZah1/kK3BLTOn4xDlgI9xK62W/cHVDXdeTr3NktRUo
         aeH+P0diPT45/7yQFBWCnULVsG6TdcWA8tIYBAWgcUUw98OpyEwJINk3EUHFoc7frPsh
         4MPXc31689qiJjrhc9G/ZeHcYFrFm1znu25nADwmj2PuwZ9jk/VDnHwkttb8fY6eKBiB
         Jr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306247; x=1686898247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poHrvY/Mj7upONPUEFj3MugSQ2bj/7VrwwgqmAb8Rzs=;
        b=jRkcXyO+bOU1JQjr07ybLVNj/t9KYCl2+IicmcCdLmwpH8A1qPvzZoFOWK0uto6Zy9
         0B7TbaE21yTI/1TarQSZtrCpUUGYkD/c4zAKtcksskvf752UUiJEmx+b8i3G+2M0hw4i
         9yysZkDmLGs7ewC4+sv20mjBFUQQ8zzPtboaYw1cG/uUTysK0UytQJYct4/rDEt5Wqh3
         x42SHAD9Sm3NPU2JaatKy2pY6auOZ7YfP+suHIy49tbkoQ1N2XzXgQp8VDo99Zc6kBzC
         69SR1Uto8+Pv5dWRKFjPc9XKlmT4dfN8bB3TbKKh1eCtHXh1mmE3YgdVIThNbZUwYmsB
         tNVQ==
X-Gm-Message-State: AC+VfDzf8UYVC/oPX0tUIsjxIHrDB8y758HHJz37CKbEpv4aFYo2Jf05
        Xxl3Rp6kP0IQlxINmLp5MHsNfvPnOgafNB8MLqzQxQ==
X-Google-Smtp-Source: ACHHUZ58xhBHJRCqJdUxKHC6CR08+l9VkEip2r1BLVub+zR0B7Sh0isr5A48/XKf7i8+6zC6phS17hPfME/JUy/FilA=
X-Received: by 2002:a81:c214:0:b0:561:8c48:c288 with SMTP id
 z20-20020a81c214000000b005618c48c288mr3509309ywc.31.1684306247259; Tue, 16
 May 2023 23:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230517064434.141091-1-vkoul@kernel.org>
In-Reply-To: <20230517064434.141091-1-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 08:50:35 +0200
Message-ID: <CACRpkdbrgPQqpM0USA7fKaXQ2Jj15C35g+i+=0wZjcX_ZzEKVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: ste_dma40: use correct print specfier for resource_size_t
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 17, 2023 at 8:44=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:

> We should use %pR for printing resource_size_t, so update that fixing
> the warning:
>
> drivers/dma/ste_dma40.c:3556:25: warning: format specifies type 'unsigned=
 int'
> but the argument has type 'resource_size_t' (aka 'unsigned long long') [-=
Wformat]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5a1a3b9c19dd ("dmaengine: ste_dma40: Get LCPA SRAM from SRAM node"=
)
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Sorry for missing this.

Yours,
Linus Walleij
