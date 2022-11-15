Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCA62ADF8
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 23:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiKOWNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiKOWNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 17:13:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16183134D
        for <dmaengine@vger.kernel.org>; Tue, 15 Nov 2022 14:13:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n12so39613874eja.11
        for <dmaengine@vger.kernel.org>; Tue, 15 Nov 2022 14:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oszHsFFE64O3GGqZX1N530+OJ1fJJrhcmuHRo6+aD8U=;
        b=q6HsmlbPu0FJ05cy4XK7SE9slmFFX0IHgA/Bdoss+9dUzOK+KCMr02pRTdhQhCGWDm
         cgVwF/QuRGOwwus5GyYn6U5PpANbW0rXeU4LMHuvIsfhNZL8ohZbnswDFAnH9vpVIPWw
         VRoXrJfSWuVjRqTj/nmxj+tuokM65jhB9a1yVEb9PLYO8tVWut4bFyhRSnpMExk8RgPA
         W+yqVDQmrxwdydcFr2LUJIGYhZ39vmVotRt8TCM02IFXm/6f6oZUHRjYAFPHqJgIi0Ak
         s0uCUo1mJmX67pS1RFrDE3Amm9ETyHh93787lXglHKugPP3BxcQjyAXCSvawgG6SeN8k
         gH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oszHsFFE64O3GGqZX1N530+OJ1fJJrhcmuHRo6+aD8U=;
        b=vOtLNHWsXWU/m8nIuTRlhACbJODYRdzmFWh5ZuBoZkolohyY4V+EhB51G7XfWz/LoH
         kvrPOKpEi09lqLLWX14GqC8l52EEKfijWJpAfBowcOGqFcdQvhXjBHzNzWil1DEp2Mxk
         9hVI0QGCqs5LsXn0Bu4UleNDgCgsgQmjj7F/s+efRmQNueJGcW3h0+xODIuNyy5MkVWY
         HhptOMWTycrzXOU1Ti2Lopb3RLf51jze5A5OolA+o/dzmGUX+m6JdZlA9hX3OP5JoRkK
         VYYxvLCQ8HKCOqVSlRvtHelZ/r8EQMZpd61ZiE/0M2/zCW+PbJh6zNkLfVpLGrqxsRai
         k/ww==
X-Gm-Message-State: ANoB5pkgk828U30nwTuyPdVgfGhdS1MbuXJ90TEu4NLydmdU5db39NZB
        z50o6ZVTucetrl8eFgdnP6rfs8sZe1BJ61npEd1g1Q==
X-Google-Smtp-Source: AA0mqf4kMvrHOK43t8V+2ZHWkbiLmbgTKCirDbfJ6K9J37j0nnaumPpL65blVgNo9gj0LPU8kdUbPsmcDdsK4VeN6Lo=
X-Received: by 2002:a17:906:4911:b0:7ad:9891:8756 with SMTP id
 b17-20020a170906491100b007ad98918756mr15961432ejq.203.1668550392299; Tue, 15
 Nov 2022 14:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20221115081546.2389164-1-ruanjinjie@huawei.com>
In-Reply-To: <20221115081546.2389164-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Nov 2022 23:12:58 +0100
Message-ID: <CACRpkdbeCqb6v==ygtTHpiUXpfsYbmOKwvXH39k-GUgWtbqFEg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: add missing free_irq() in error path
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 15, 2022 at 9:19 AM ruanjinjie <ruanjinjie@huawei.com> wrote:

> free_irq() is missing in some cases of error in d40_probe(), fix that.
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Correct, but ... please just convert it to use
devm_request_irq() instead. Less lines of code.

Yours,
Linus Walleij
