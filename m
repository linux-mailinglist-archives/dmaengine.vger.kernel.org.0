Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD283AE2DF
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 07:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFUFzL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFUFzK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Jun 2021 01:55:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BAC061756
        for <dmaengine@vger.kernel.org>; Sun, 20 Jun 2021 22:52:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p7so27989452lfg.4
        for <dmaengine@vger.kernel.org>; Sun, 20 Jun 2021 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvVLIkjY2BI+dv8+oCzZLh2KWK9nzy5kALZ0tBgTgmM=;
        b=OWh41pBG1J4S+aLNqN8FY1vGAKOVV0q8cLx0SnuOQVGkqNsSOZ83FJ5fuLi+ubVelR
         4WkFpbVlmdmn0DH11aP6ooZZE+k/uzmghMpqCwLH+nhYm/DkPSncwuOs+wOqujw4LSH/
         BzhX8IumdS4THN9ErkgjjNxMbBAMHrliXysss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvVLIkjY2BI+dv8+oCzZLh2KWK9nzy5kALZ0tBgTgmM=;
        b=SH0eWlJoky7y0+KleUOZe+54aTboAbIBtW300/pHvC3PV3//k3eJY7ir+HnyIBGhJF
         2NYJU2XOMtHBMxA9Ku4dpLAhrmq34+tufnqkwk3s9SFtOT0wNW+aY2PmksE/bp+SKpzg
         J+ptMjkIU30He5dfComViDglUO41ATEGGj8K0oTeeSN7K+pTlxXjb6svyF3u3FKEcoPd
         MHG4L6lEj4w4M/Lr7l0tpSF91udovhvTMkQIPdKyUOva8spWsLl9tCoMgkYxUUBaCIVz
         IA8YIDgRBNN6/ulIHrPlBVCoJda+YxflPabGUyViuB842SxtdioDpwYMcGst+ZGis1mI
         MlWQ==
X-Gm-Message-State: AOAM532nQAgcq+cJF3BNs8kv5PVvrsZjBtt+aOadvoXOTvrN7Qb1WVPV
        Wa4MqvxqNtv/GEwPP1Ql8auo9OtkzG2r6xwXTnCsew==
X-Google-Smtp-Source: ABdhPJxAPpJQjlpnjyn3YLrmWUJot6rk04KH2QgEsE4DP+8OOfnqFG1fFvwljBtxFszUAT/f7w1dADXRAMG6cRn/VGo=
X-Received: by 2002:a19:488e:: with SMTP id v136mr12811091lfa.647.1624254775065;
 Sun, 20 Jun 2021 22:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210617133229.1497-1-angkery@163.com>
In-Reply-To: <20210617133229.1497-1-angkery@163.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Jun 2021 13:52:44 +0800
Message-ID: <CAGXv+5Eb7oJ2db41K2vvSN84uAg-V5SjthnvCuuF7H7SfE1aaQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mediatek: Return the correct errno code
To:     angkery <angkery@163.com>
Cc:     sean.wang@mediatek.com, vkoul@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 17, 2021 at 9:35 PM angkery <angkery@163.com> wrote:
>
> From: Junlin Yang <yangjunlin@yulong.com>
>
> When devm_kzalloc failed, should return ENOMEM rather than ENODEV.
>
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Please add proper fixes tags:

Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
