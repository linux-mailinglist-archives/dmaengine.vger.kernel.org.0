Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C41D099F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgEMHM0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgEMHM0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 03:12:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E1C061A0F
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2020 00:12:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so888370ljj.1
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2020 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRFk30OEdsBaX3lNynkWDdT0LAUKPWkllb6vWrvUfFU=;
        b=K5pzuy/Q0DbKRQJhtwBbIhHrErl3UFCylyh40MxEmVKtgp7yEA96J6jzDlnp1Z9lX3
         L0095lu9fUxrCVlwBbN8u7k/YjU5gQNhOooEFNtUQuKet6vVAPI48KqdvwDDSoWxkmNw
         +PylWBmbq3ADzq9SmaUFmuSSxZT6qEFLq+V/2QzC90vcKfu7ZAw7q1+eCKk985st/+rD
         L0WnmVbg1Zay9q2IAo3SswAhLrVPrbQyjbJyS5GnZ/rQoLHTPXPjoZLTn/MHOb9BorNj
         TxoihN27LfVVuTTxxgi5ohtgAfasA7G6w5fuCLWotsAmKVh4quhdqPwl8wkOmMx30QtM
         4TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRFk30OEdsBaX3lNynkWDdT0LAUKPWkllb6vWrvUfFU=;
        b=SpmjFN8AEqStTF0k9nJrjRVeRaXsXWjnuh9+TvJurXORFpYjDEopkevpTXKYqGytcg
         O2VGfpl1Dsv4ND2nNy0npTK0pVBGlQlcc0vcJtPNICKDfUGh6rnhuo1tzZGS2ix/W1HM
         Tzh00XvYgHLEfgc8kvWJC4WLF2H9MGSl4f7GMdreLVBJtkyrDMxJr9/z9gfvLE+BCMp3
         2lg4LuHNsWJ4WfS1qi7Y0XwDFlFEp1L56ju3r+jI+8YrMq4J3YkzvHxT2Wrvr1mtRD2u
         629I4P3qGz8YN3Vd1km5Lf/K9khqAMDfFu6GHuCnkCH03LJbHa8Wy1aKdIcIZI7YxB0G
         cQdQ==
X-Gm-Message-State: AOAM530eNuvbrGEdUb4M4+aAFXwEx8B6BxMZexpZ4TdZ+6Uu49TM0Spu
        lc+Gm7ef4mNFCrPH+ImSpjqM4Reua3mqMXw0t2LzDQ==
X-Google-Smtp-Source: ABdhPJxOVv0j3JItO5IlLO900Ue/XycQksnMkwQAPd8Io9f7MPELoXRwn0ku6xHMSL2Omjmun1aVBi7/j3xnmT3aaQ4=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr16710225ljk.134.1589353944120;
 Wed, 13 May 2020 00:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-4-git-send-email-yibin.gong@nxp.com> <20200513060525.GJ5877@pengutronix.de>
In-Reply-To: <20200513060525.GJ5877@pengutronix.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 13 May 2020 09:12:13 +0200
Message-ID: <CANh8QzxJg05nXasHfN2kC-G7TOKZ8trJkOP_v0KXvcy6S4df4Q@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 03/13] Revert "dmaengine: imx-sdma: fix context cache"
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 13 May 2020 at 08:07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, May 12, 2020 at 01:32:26AM +0800, Robin Gong wrote:
> > This reverts commit d288bddd8374e0a043ac9dde64a1ae6a09411d74, since
> > 'context_loaded' finally removed.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
>
> I think this can safely be folded into the next patch which makes it
> more clear what is happening.
>

Agreed,
not only that but having 2 separate patches also means that the bug
that was fixed by the commit being reverted could reappear during
bisection.

More generally I think reverts should be reserved for commits that
later turn out to be wrong or unneeded (ie should never really have
been applied).
If they were OK at the time but later become unnecessary due to other
code changes I think all the related modifications should be done in a
single normal non revert patch.

Martin
