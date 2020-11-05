Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F322A7FE6
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKENsj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 08:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKENsj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 08:48:39 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37EC0613CF
        for <dmaengine@vger.kernel.org>; Thu,  5 Nov 2020 05:48:38 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id b1so2359195lfp.11
        for <dmaengine@vger.kernel.org>; Thu, 05 Nov 2020 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fVeXIJ0876AEfr9hIKe+DXuB9n1FMNqvYDL5m03TSw=;
        b=SxOVA+TBJpL1xCpTZUu8dNY0KGk0MQXvOP4ST3EmrSDZciLFq78pE0zHOuXxTqANbb
         5uslBzv5xQiwqNtpRMHSh4/pDauV/VsA3YBWAE28d7c7cZaR1c6ZIEa9otrx21/Adwrt
         KxzxCOaWFecAgzWhJ53j0P11RBREjdUEah9dc6iAqNtHMS2M/tT1TMjGkS86aqHIGvgf
         GuJcQQEgI3Hu2pvjf2Emyl72vOB6UHkaSWSq7Xe3Ur5V0tTFPcC3wfexMEVwVI+U8hFm
         +MKS3SoS1Q5mFhOgAw60z57rRFo/Pw3w7BTR28q6dQOFMVlaBsY6nqQlH5iludv6zzYE
         95Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fVeXIJ0876AEfr9hIKe+DXuB9n1FMNqvYDL5m03TSw=;
        b=p4yBZE0WX3lzlR6mHXN9Xq6IgokveTeanwqyyhg1NIjyfOZc095D8P48vydF9yRh48
         3CTJxC3vTC6onfdkumswrwzxhImqKIR2iWiP8Ng0/n17MxiupqRMlO1sRk4ZtzfbDuRh
         TzTdPumiv6DfuoyHIOL3mDhHXiNunXUOuIbD4hVsB2YUaW1rkd+V+eyCjzYpVgGlaCdz
         VtE2y4eCzsaiMstuYOpRbmmhBhF+qrV/NebwJq6hLh6IEMIG2PTqCadgIZIGZSKrtbK3
         enzsKqoVwkz8xXwpO5lUhKy0ZcR9KppQvmAKZ44ntJpwuEhmOulnumVVNBDnSFcVLqq3
         3EHw==
X-Gm-Message-State: AOAM530DhG+lEbc/NywQw538MDVUk9Luc0ip/baJIorf8oRrw4mcdw8O
        l35UntONLVVZ7fb801UEHTmffGeO0j6iy1NJeQuKHA==
X-Google-Smtp-Source: ABdhPJwzjs5syk0dfgzFhFDFIHEl82EjRYEROHavZW2jlq8edIhNPMsAJQtKh4SOBOD3NAEGz/2ZCWsFEbGDYhrkygU=
X-Received: by 2002:a19:824f:: with SMTP id e76mr964964lfd.572.1604584117393;
 Thu, 05 Nov 2020 05:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20201027215252.25820-1-song.bao.hua@hisilicon.com> <20201027215252.25820-10-song.bao.hua@hisilicon.com>
In-Reply-To: <20201027215252.25820-10-song.bao.hua@hisilicon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 14:48:26 +0100
Message-ID: <CACRpkdZKdtiJA4aDYhRfZBXhFeVfZEnoZfQ+xA+pSQtjMOfbGQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] dmaengine: ste_dma40: remove redundant irqsave
 and irqrestore in hardIRQ
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 27, 2020 at 10:57 PM Barry Song <song.bao.hua@hisilicon.com> wrote:

> Running in hardIRQ, disabling IRQ is redundant since hardIRQ has disabled
> IRQ. This patch removes the irqsave and irqstore to save some instruction
> cycles.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
