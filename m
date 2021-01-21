Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B42FE547
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAUIml (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 03:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAUIm0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jan 2021 03:42:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E28C0613D6
        for <dmaengine@vger.kernel.org>; Thu, 21 Jan 2021 00:41:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a8so1394263lfi.8
        for <dmaengine@vger.kernel.org>; Thu, 21 Jan 2021 00:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4Ur7uejEis62r1h02HTSFCNj1UtMoW8pgWn2VYhOr8=;
        b=NAQNFpqFLDRhTju5fWH5J5g6zV78HecVvFhDMl+IrwEFSva5ttvLLjlblTebF2haV8
         gltDa/Kifpxr7+kjQLl5EqSWQNXPv7/QXEVaxJqmtsTTA9tnuUHjQjI1KRjIsFmaQZ0Y
         f9bxBCa6KBaP7nheT7D6TML/Yq3jOkdJXxGOaQ1xCtx1q+W55SnjTPY2vKTLih5fwvAp
         YnYPqmexJmAuNp9kuOiUSztJZ3xwtBL4m0/CtaAj0vN3IRpb6Pzn4QWbDmocFE6UPxw9
         UBKIARRk2DJRNMu2tk1wMjmQ7ZkTXnrhE/jGXhIjBImEeSrsVCNInzpEffa3GCMj4l9Y
         IttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4Ur7uejEis62r1h02HTSFCNj1UtMoW8pgWn2VYhOr8=;
        b=fuxEfLRG8jzeRRl+btQbRQinE8/lLHG1LY2SB1cPiCKUSbdjFrNh8O9OZ6l2C/t8jk
         2hQG5Dk+LKk9hB7k8DJihVpRojglKcB2DyByFfew8f39xD7OCx0lLPCIn8b9TZFPe1Hx
         8QY8rkbBi0jSZ781KM1YgEisQAA1og7SRuD7RnJelGNYclJfs71mGquSPcK2fpqxIjT+
         kvthIfZ/WeepUqC8XRRhVJUn/78GZIyx6WP3bgAoqIfIWWfWOF9gO0VQf6XHhTHHZZoJ
         eY0pTNqqRFUH5RkI0h4eP0jalhu46MrOUTJ2zjJVmqN8hpMJ9z1fjcnsAhgSKbnKiS19
         +eKQ==
X-Gm-Message-State: AOAM531dxU8/45aJsmWtmKsR76+trnQ4mX4SYZp28SQfQRLC6Z5qePij
        y2TutgNheGggFY55lA0QAYvDhv0aY5VxmmJqr8+TYw==
X-Google-Smtp-Source: ABdhPJx3oYCu6IEIa2cM3DmV0hFuobbIzq+JKqIQS2zmgt4Tj4taSGT43w7fqtuXFyfamL84a4raKwGpyzkwtWthNz4=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr5794597lfg.649.1611218494357;
 Thu, 21 Jan 2021 00:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20210120131859.2056308-1-arnd@kernel.org> <20210120131859.2056308-4-arnd@kernel.org>
In-Reply-To: <20210120131859.2056308-4-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:41:23 +0100
Message-ID: <CACRpkdYQz=Nw-shfwcydyMqFkx3bc+MN8jEEzQ3OFcZKSTypmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: remove coh901318 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 20, 2021 at 2:19 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The proper work that would have needed to get done would be
to integrate it with the PL08x driver since it is obviously a
derivative of that hardware. Oh well, now we need not worry
about it.

Yours,
Linus Walleij
