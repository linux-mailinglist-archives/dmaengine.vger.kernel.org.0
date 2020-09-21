Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C0271A8C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Sep 2020 07:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIUFy5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Sep 2020 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUFy5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Sep 2020 01:54:57 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F5C061755
        for <dmaengine@vger.kernel.org>; Sun, 20 Sep 2020 22:54:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o6so11319166ota.2
        for <dmaengine@vger.kernel.org>; Sun, 20 Sep 2020 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWN976Ajtxd3+H8pIu4MFwHLMi2ibiDA6yOKN3xtDDQ=;
        b=CX2O1UBcWwQCjV+lbUFrSps9X8Qb5OHzTCsOKTabZGsEubNpWM8qKIy57WqbgJ2SYS
         slb0B7VRlJFdVvD81uWwwEas/x44j1FXSZfbAd0KFIypkCYb4K2N3TQ8vJlzoCiVhemf
         3Mpry+QzVyB7kzCWGY7l7L9UqqOWqnvLVCWhSBqGBs27aP+quaENGnREtVc6sJrAusVC
         IfsB7SlTCT9IagKzDUZQ3yC07s7ypvZHWt+FznP/ket0xIRxziyg/9IndJhax0mT9+o7
         5W7rtAwHOElHmRSAWOttY6WGamanJ0NRuPXtJJSoPhWwgu58Orle05dImDRZhUr0EIFO
         kKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWN976Ajtxd3+H8pIu4MFwHLMi2ibiDA6yOKN3xtDDQ=;
        b=O58oxD03VjSaDLIV6A6sXDXbruBIhhdb+XCAWj8VzTV3X/JnqgL8xZ7232PPLqI5di
         I736I6//qHy/4oO2DWA8RCgjbwrjDDjwP+cpnWGvaJdS7PHt4VRe/rsV6rBvdNk2vrBw
         H1hyQ6by1BHLdGJW3ZNf+JNvRoRMegiK4Q8/sEmTFhkb2onQiaG6PFGc9bsku/fZYE3e
         EV0SobntjIy8HVEPACRYSB4SAJ39u3N40RcBxv9xG0kVoil0alLmvJoD2EZHWmiPob0D
         8kNYpbV05vwOQfsFICFT+5blvgmMCLxIcHD+dIhj1r7D4G1dgL7SHispsCb+hv0F+TuF
         enmQ==
X-Gm-Message-State: AOAM531rLANwZb9eAaJo+hw9paxUquQNQkKltHnBHc1hTI3/zXCOu6BF
        BRoEsQotXUYkX4c6ybImwHuinGK45ug/5C7D6js=
X-Google-Smtp-Source: ABdhPJwirpgM2Ghlq+ACAjIHwcuDaPUri07Hv8fZJ9nz3wwu65N0GpW9IotMrCvTr65YDnUrHaC7epObN8BYlp4W838=
X-Received: by 2002:a9d:5e8a:: with SMTP id f10mr29388881otl.242.1600667696208;
 Sun, 20 Sep 2020 22:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200831103542.305571-1-allen.lkml@gmail.com> <20200918065215.GE2968@vkoul-mobl>
In-Reply-To: <20200918065215.GE2968@vkoul-mobl>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 21 Sep 2020 11:24:44 +0530
Message-ID: <CAOMdWSJ9r+fJvFE-3Q+6E9+Us9kStcvZ8hRBG8gx74VGXbSTXg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] dmaengine: convert tasklets to use new
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, Logan Gunthorpe <logang@deltatee.com>,
        agross@kernel.org, jorn.andersson@linaro.org, green.wan@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > introduced a new tasklet initialization API. This series converts
> > all the dma drivers to use the new tasklet_setup() API
>
> Patch 'dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API' failed to apply for me, have skipped that.
>
> Applied rest except fsl one where I have picked the resend version.

Thanks. Will re-submit the patch.

-- 
       - Allen
