Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2A7BC07C
	for <lists+dmaengine@lfdr.de>; Fri,  6 Oct 2023 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjJFUjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Oct 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjJFUjz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Oct 2023 16:39:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC584CE
        for <dmaengine@vger.kernel.org>; Fri,  6 Oct 2023 13:39:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bf1dde73fso31023527b3.3
        for <dmaengine@vger.kernel.org>; Fri, 06 Oct 2023 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696624792; x=1697229592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCCsvCjoztAYuiGh0Xey9xgcOmDlkIVfrEdnFUpQWQo=;
        b=qmMMSAtMV0KLM9RtwJ1oPScNfXITRyUkLad/AhjuEweUNldoN0AJeWyNTstvXzmeQ8
         gPagpsAknageqJ2nJkzj1ta1fJ0XCstDYqFU45yFywpi4tbZ9PIxxmiXc/JGDlzuoCCY
         PGYi3ppvhtoA1qOCMTA9FCqIf/deMf3VYK0t9K61OJIACuquQmKYrxD3lnzwrG2ohtk/
         Pw95MIx+DEwBJYHWkm+2yVyA9K84i4zSAu8wFowL3uJFmi5G+cgf7UengCnZeg06OmHC
         J/v33EpEEpX/CfrOF5KDjxdJs3ik4LGPL6KER0wrk3d2Zaa8I88NSs9sOf0LQy0HuEJC
         ViFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624792; x=1697229592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCCsvCjoztAYuiGh0Xey9xgcOmDlkIVfrEdnFUpQWQo=;
        b=XBa+zLEAouY9Xp0vHHiZFhhfFyalwJB5V4jxy5IkeZTfvZ1C0NLn61l/hlFRfD4fcB
         G46DngKUOKAEqvi9BVr/ZrGexHaGal1NJP9vK0u2Nj7Sp29wCqxqcYMb7PxSkC3s6Q2h
         9mnbg4T+mehkxAQxq3757VCTNObTlwh6vq50Q18LhsFtKTty2r/42OLTW9V/kArjqQZg
         0FFcmFp2R2mNre8jXc1gYANQ/+BdjquH0WaNB4JCi1QaS72LrDH/0LItixqaNXxIrWc3
         vJuyrGIVMeN963KdMDCJot4v0SzMLG1WfyPpn7lx4MdiCNBBomt787iMQ2FkLxTlqsJ1
         Zi6g==
X-Gm-Message-State: AOJu0YxIXV/Wsz5cvANsU6AZSWXGGbXFyEfUdlUF2TzxCv+YsbmF/bJW
        thPeiePxJ9GsYqsQl0nz1oSCrGbaQ0G+O83s4tocmA==
X-Google-Smtp-Source: AGHT+IFR8NVGwTdVcapVfJC8kRBUPD6L6tfpVRlQ1CZCYYO//rqZ3c7OWFya24qTOj/hY79e7ym8EazegWVwlW4BrEw=
X-Received: by 2002:a81:7cc5:0:b0:599:b59f:5280 with SMTP id
 x188-20020a817cc5000000b00599b59f5280mr9869580ywc.28.1696624792113; Fri, 06
 Oct 2023 13:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
In-Reply-To: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Oct 2023 22:39:40 +0200
Message-ID: <CACRpkdZtOdBYfHtAE-2QzqhUhELFm38TV93ek7bO1qLJMGiXLA@mail.gmail.com>
Subject: Re: [PATCH] maengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     vkoul@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 5, 2023 at 4:28=E2=80=AFPM Zhang Shurong <zhang_shurong@foxmail=
.com> wrote:

> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context.
> We fix it by calling pm_runtime_disable when error returns.
>
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Looks correct,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
