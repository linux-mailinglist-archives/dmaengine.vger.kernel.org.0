Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C838530602
	for <lists+dmaengine@lfdr.de>; Sun, 22 May 2022 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbiEVU5x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 May 2022 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiEVU5w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 22 May 2022 16:57:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550F38DAE
        for <dmaengine@vger.kernel.org>; Sun, 22 May 2022 13:57:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o80so22337682ybg.1
        for <dmaengine@vger.kernel.org>; Sun, 22 May 2022 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NDRtCt5IKvrD75rRnXcuTW8iRXjJ/s5YNzt05pMQFc=;
        b=DtY/tZ/S/a4gtZJC3fElPoyFJfvl2m3F3LvHtQGgfyG623p97p9BSoIipaI8oQES9D
         hcGg4yM2FV+bvl0iHVBGzpt0u+ozsRBcY9EOzcCeUTcX4pQfmiWvJLjmO+HtWTei8iYQ
         uGO7+wYy5VNBlRN7TFauG7DzUXnu+uiFE6unoU6C5n+MJlriQxiCJnxjXbzbpQwf3HK3
         JKl8kj7l2fO6CFbnxHlfhSbfJqbFzWf/bg8E6RAEJixnfu4cYCdZdq7yMe9SyCHw+p0d
         1W5xLB9J8f/7EAf9dEWCDVeKEQfeIB13Wi0KwB8gAmU2uDkk+5fHaB3INM7dMOCEpfBG
         BfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NDRtCt5IKvrD75rRnXcuTW8iRXjJ/s5YNzt05pMQFc=;
        b=h83gCfU1ofCvm9iR3+2kHEedn67wNDsmnfi/gWx0TV6UpjbXNt9SdL31qnA6SYMYUb
         ySkL3WmVixty3OMgbTvm4UN1lLNwiLarRUgZtfFKW/wjoiSEhp5KSQIsOdiq5JgdmvIF
         vzFjJ0p46OkgZwQSYb1D9D7VIOGbavXdrAqtpBaBqb3k+ASz8HQSSXUR1YmyGr5bNg8Q
         whgM4MVCRPzm4MjDtvgA3fxcdROqpH7mUwA4M++W75Fr221E7pi2fo3o+rvPgCu15Chk
         tfHxp9hSuLDvm9kU3yhVoviQ7ulICrm+23mevOcIHUFddmOL4zIS/AcLbo47mOw8K6Cy
         00Ng==
X-Gm-Message-State: AOAM531tkG94HX9PjFRwsHRTp5txWx20ekakTMQ48NlfCGn7nIIFuDW9
        e69bAbuIYjtDN44pAAJyXDfI69mtCaJErR+iz2vlzsl0roI=
X-Google-Smtp-Source: ABdhPJx/ekEjROZtlx4zO2rTZDqWJXb55TJCuZIiQvSwU8m6RMcAhb++WSUaqowRDibkhPUXxwRZLb/YXDf6rORlip4=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr18769020ybq.533.1653253070562; Sun, 22
 May 2022 13:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-17-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-17-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 May 2022 22:57:39 +0200
Message-ID: <CACRpkdZBvfyCBzPsD1S2RWKy1eUhiQDeaFb2xuF5VgFnY3rGOA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, May 21, 2022 at 1:11 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
