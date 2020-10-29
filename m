Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E10429EDF0
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJ2OLA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Oct 2020 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ2OK7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Oct 2020 10:10:59 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF2C0613CF
        for <dmaengine@vger.kernel.org>; Thu, 29 Oct 2020 07:01:23 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y184so1477032lfa.12
        for <dmaengine@vger.kernel.org>; Thu, 29 Oct 2020 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95HeKCn+TfhWEiTegQHXoVSM/UiLgPAdPOfyVlofGBU=;
        b=TDtQqBoOQ68czQwv//+iamNfo75F/MXJDYym4U25MS87Yq6AsJtZi97nAT635wXrKW
         3Zw2Vaje0DgL5Zq/qltYuuXMChJx+3ihTnXaSZAGzZltxaUL8ukdkfEF1DZpfQTgIyGJ
         4EEQpmTeOtEBlRr2M1bZCA1YYW78vOhZHJ01V/TvJKInXcckRfePr04EYErSi/VpHKHK
         Ucq3oxOx2T0coPTOkbvW7YZ6RpjFnRxVtjTriWXEF9nnF1xF4dqbMdq0DdK5rwb2Tzlh
         V1j1HpYxwNOUr6nz94ZEn0PwQAD1QVW7nhDh4Xb/l2ZamWR/jjqGkZ9Bpv1NoaHrYIQj
         hyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95HeKCn+TfhWEiTegQHXoVSM/UiLgPAdPOfyVlofGBU=;
        b=Ps9JXAvYIeg1ONqouH18rTrGQS1sSyWXV5Y6vlG7OpwST7A8zxOfSzXbf6jWfZ9gMl
         vjy/EkZd86cdmR2EGZzTGcLfBkUr3sXekgl5TbtYxSlQhCcmFJM60JOb37oCCSVn2Wic
         abmAwbG/Lli7nbg80bMPEnbSZRjmtEzCfGOONvIxOe8hLu1H1X46poR3gzCujDePdP20
         6vYcvsSHp4ZT79lwphVOkT2ChHMn/DwgpaSxf+8njI95l0vYPebnfqLGR2NZazd1YB/H
         nBlNrwLS32IrWeoXTDLDZlwopaxKOiqxv8QamERyGvT5mLI/jpDgDLiessSRkGXudH6q
         eIWg==
X-Gm-Message-State: AOAM532puVlqx3Pg6Ea/n2hslXXhThvuM3/q17xBcSLiWMiCAS8MCeOO
        bmR5CGW6bnkeEM7/U4Bzy/Rc9de7H2fx8HXurS9CTQ==
X-Google-Smtp-Source: ABdhPJy3Qfa6BNrx80kSw90r8AxDR1WwJkenII0MpeFrhEsGEiAHS2cGc2iwLtElj5Km8A1uVl/lll4gH9htM8/Cd8k=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr1544531lfe.441.1603980082022;
 Thu, 29 Oct 2020 07:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com> <20201015235921.21224-10-song.bao.hua@hisilicon.com>
In-Reply-To: <20201015235921.21224-10-song.bao.hua@hisilicon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Oct 2020 15:01:11 +0100
Message-ID: <CACRpkdYObFW77kCv5sRb+Dx_Gxfvw+YkPB5joYXTw_i-ag34kQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] dmaengine: ste_dma40: remove redundant irqsave and
 irqrestore in hardIRQ
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Oct 16, 2020 at 2:03 AM Barry Song <song.bao.hua@hisilicon.com> wrote:

> Running in hardIRQ, disabling IRQ is redundant.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

That's right!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
