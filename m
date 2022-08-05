Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E558A4B8
	for <lists+dmaengine@lfdr.de>; Fri,  5 Aug 2022 04:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHECaK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Aug 2022 22:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiHECaJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Aug 2022 22:30:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3376E891
        for <dmaengine@vger.kernel.org>; Thu,  4 Aug 2022 19:30:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so1757850edi.8
        for <dmaengine@vger.kernel.org>; Thu, 04 Aug 2022 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qTWkeFlRZnqwpCI34+5joMnqgdb8MiarGI8X4TrBXY4=;
        b=hbFZSme/BYq0JK0mDEuehPSBM0egDecgUHj3R5Uf4Z6RC33hTa4k1teKJF6K4jvz8l
         sQFHsgqMgz2E7So+KhXZLjyJQcPuEoiONyYM72BQ/HMRlk6YSdAOfEqZ8ZeedunZioPC
         LFnZMCaqn4piDHrgj0BqrfPOSm4Ay1y8ytT0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qTWkeFlRZnqwpCI34+5joMnqgdb8MiarGI8X4TrBXY4=;
        b=3KaN4q8CsH5skwcLCHvUEj8Wmq8ZZ3qiKqjjFlqvccCQysWJYRKr0naMpQBTtg6U/i
         cxwqj4Rne+XMsbiho2KjkHSI76mJ3qoBM7c9S0YPaRRFKE6X9kufaSR00sRluJKfzF7V
         K2kuE3gTc16azEZpj3Jweoizr81GIUB9AIjJdoVritAtF2UBy3eZIfAOnp4K6NOZvJKh
         iADEzUYZCQKxQpsCLkuCd+zSYz1RFv28egUvEdMk05/AhZXh3gST16uwcU3++76z7rxO
         I59ha3G8RVtmvGN6Vh7+NdcwAqqNRruwJi1iNASFR9HLBPko7S2z+FAjHLW2hpuKwOZc
         6bJQ==
X-Gm-Message-State: ACgBeo3wuYmZGe9trOcWhIUi4vNW5fCSCkWxTO8L7+24PU28C8yVoRKv
        1ijs0T7TWyrbLxWI5w6kg8tHPzF8D05ocTLa
X-Google-Smtp-Source: AA6agR5YMr/aEjP4tyISYo6UiGoWhOrHKU87YcJsFjbPJg+fC+hr3JL8FdBO7PxVD0fjQIm0Ncqx9g==
X-Received: by 2002:a05:6402:3509:b0:43e:d80b:44a8 with SMTP id b9-20020a056402350900b0043ed80b44a8mr3359244edd.255.1659666606997;
        Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906684400b0073080c22898sm1036646ejs.15.2022.08.04.19.30.06
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id l22so1726201wrz.7
        for <dmaengine@vger.kernel.org>; Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
X-Received: by 2002:a5d:64c1:0:b0:220:8590:3809 with SMTP id
 f1-20020a5d64c1000000b0022085903809mr2919665wri.97.1659666605721; Thu, 04 Aug
 2022 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <YuuJNJ7/3AXzKMF7@matsya>
In-Reply-To: <YuuJNJ7/3AXzKMF7@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 19:29:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=0TfDnDhaxsbS83yrrhXFmROu94pNLUgPAYuc9OSBjA@mail.gmail.com>
Message-ID: <CAHk-=wi=0TfDnDhaxsbS83yrrhXFmROu94pNLUgPAYuc9OSBjA@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v6.0-rc1
To:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 4, 2022 at 1:54 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Please pull to receive dmaengine updates for v6.0-rc1. One thing which
> might interest you is the Apple ADMAC driver which should be for your
> shiny new laptop :)

I can confirm that my M2 laptop boots with this version of the driver too.

Which I guess should surprise nobody, since it seems to be a slightly
newer version of the one in the Asahi branch, and the differences seem
to be mainly a few updates and cleanups.

Thanks,
            Linus
