Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6821ED69A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgFCTRU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTRU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 15:17:20 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1AEC08C5C0;
        Wed,  3 Jun 2020 12:17:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s18so3602292ioe.2;
        Wed, 03 Jun 2020 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6d7NwLsGT9XBwpif8ssbO5j7lS7Uj+B9cyPHxQfDOJc=;
        b=ADCpHKoU8KPg9vkQLXJpeR2WvdNX3yale3lmsNmB/MlAT85XGugfW6Lj0JQIuZBniy
         pQhMCZLP6wlhfgTC5gyglucH2XVir347K8atgenZhITjMWwV9H9/FwzDEgYd/1YM9O3e
         A/5oqkqKVDG+XvOnHRH4owoIxfCtewEsQ7GGcKqrkVYiBhThb0Q/wzmL+Xhr/MVq2CNd
         /lmNCqfogZR2eRo2oDHe2UGsyCbvTIH13ZQYfXGfDPdPnBu6L4wBqGJFfVIv7dXtGBEG
         8mbWK69KdDvbTbmX5/BgzPHcEdTQaYVxjxlVv+Id4Dzo3tsflxDTgn6MnBaoVQEfc4M+
         xvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6d7NwLsGT9XBwpif8ssbO5j7lS7Uj+B9cyPHxQfDOJc=;
        b=qpQ3viO/UlUZ/h620nVTWxGpZ7Q0w2kvkx7Tg2anAxBnG5MLcpPKE2bbcTv676iZlo
         7++xLy/xkt5bDVDmOYtZ7ZAkz1Np9WOajvb1niWwLelMuhpZj1ONSB/ZhYGGndbabZL8
         1SQvG/vckETrsOWxRpfQkOsVGrM932IvHvULek/Kz8LgaAnvP4h/v/IB1gZkFJe+7pBn
         C1zS18Qu6tYRAqOOKr7K6gV+m9EhpwrKRjFdKhNFF/FYKsUcM4UZCouQKiZV96AFgoog
         ToR6+mMuJgkLBKeWMOqoUqMpT0mdhZ01A3kOe1U35GAj7Dz0HJeT+hxQRymMOzfVUIzK
         Ed8g==
X-Gm-Message-State: AOAM532RmFYiZFyL4T3jK8pqg0VptaOTul0luYfOUvNnEaToc29p6brT
        QvylMvNkVFxbYrucrZH8Gko/wOJqRr1QhhyUfHQ=
X-Google-Smtp-Source: ABdhPJzEkWwXprp+yt91ZkoWfd2FIUCPSY9OM5q2dRIJlmJE+OxklnUcJjSB4jVOukPnhdXpz7ftkqgqD+u6aFWPSPM=
X-Received: by 2002:a02:dc8:: with SMTP id 191mr1279079jax.95.1591211839673;
 Wed, 03 Jun 2020 12:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
In-Reply-To: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 3 Jun 2020 14:17:08 -0500
Message-ID: <CAEkB2ET_gfNUAuoZHxiGWZX7d3CQaJYJJqS2Fspif5mFq4-xfA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 3, 2020 at 1:52 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
>
> Is it appropriate to copy a sentence from the change description
> into the patch subject?
>
> How do you think about a wording variant like the following?
Please stop proposing rewording on my patches!

I will consider updating my patches only if a maintainer asks for it.

>
>    The PM runtime reference counter is generally incremented by a call of
>    the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
>    Thus call the function =E2=80=9Cpm_runtime_put=E2=80=9D also in two er=
ror cases
>    to keep the reference counting consistent.
>
>
> Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messa=
ge?
>
> Regards,
> Markus



--=20
Navid.
