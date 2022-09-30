Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EFB5F03FD
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 07:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiI3FDL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3FDK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 01:03:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104A163B4B
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 22:03:09 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1434041472
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 04:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664513075;
        bh=ux33z7H02aeUKz+r07uUOZtr3NLmpYkTJn7m+ajiqak=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QDLwRbLkoAhn9dPVgk24XjJQN7TeqsQ3urioQBeJkRfz4e7EutXdBuE42w35Jgxkf
         yyBF3wjPDiyI1WaeCpOQCSeWymRy0dAZvWHwPCHgexfHrQPlyVgvXgikB5Vhyz0RYM
         JKxOxqsW5Peq1RFxmeZmnlpcYidOkeEEMUWGzcDnPblBFYGi1LFzczh99JJkHx17vJ
         Ci+zlEQvlAmMB0q+qnwMq3Tp+Xi3sPaLn0w6isaKk3CA/2rztjKneT90Wtn5vdUg1V
         DZ08N32x+EMtHCFLXwcJ/ufPlsEfGRvdIfgrtvOlbONXYEGBKK+OzuS5JfBSNDl1Ra
         TU0w2PcmsIgOg==
Received: by mail-pl1-f198.google.com with SMTP id b11-20020a170902d50b00b0017828988079so2436251plg.21
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 21:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ux33z7H02aeUKz+r07uUOZtr3NLmpYkTJn7m+ajiqak=;
        b=lK6g86NLwYKLz/CjcB3s3jn4002s3EcCwQzYlyVoBxkF84KI+9wfkqQELKIftWn3Ih
         Ak9N1qNoA8xzmo3G5uUDX+9EaBnRDbFNx5UnXJxKxRWpa05ArNVg+GCqSULc0v1KI9Tw
         GsxRLmbjOK1pj2d5Y1CS/+bdUO/Zh3w4InvDejmwbMEy9bqC5KEUHxYgpRKGo7kcL0Ky
         kmzl3Xm01ffQK3myZxOmxE8vM6ddg5PqD0wmnPkciSXatMsPtpur/cRvP5DDodG7f+Jd
         cWpeYz0KJx/zomKdjbk3d6gH4selSohad+XI0PpB2apAwBUlFojvE5VfmgSjvedJzw61
         IjEQ==
X-Gm-Message-State: ACrzQf03qIvVI1xAC2Se5n7UrCtUgGobJIRhBZHw2fROuPVI6mL17Yw9
        N6nNiBqYoOmZOrwNhomW6vrgHIGAdUUatci2ZoefPyXOYjOfWO91j5Pxiq9wqh7tvWxs2Rng2yy
        hUOwWeZKSbp7GCY2+TDXTS4JoELC8e2AMR1w0CUxXdU2P2C++q5mE7Q==
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id r11-20020a65498b000000b0041208e42842mr5994921pgs.71.1664513073461;
        Thu, 29 Sep 2022 21:44:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7o+zURSqlabmjLr1RsgQuhoRn0j1PHFVEdM97/h6usvgfHP0rrcUpv5yIS+xoCLI8bzmxVyC7qwjdvS34EuNM=
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id
 r11-20020a65498b000000b0041208e42842mr5994912pgs.71.1664513073191; Thu, 29
 Sep 2022 21:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya> <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
In-Reply-To: <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 30 Sep 2022 12:44:22 +0800
Message-ID: <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more incorrectly.
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 30, 2022 at 1:26 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> > On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> >
> > >
> > > Hi Vinod,
> > >
> > > Any thoughts on this patch? We recently came across this issue as
> > > well.
> >
> > I have only patch 3, where is the rest of the series... ?
> >
>
> I never found anything else when I looked at this earlier.
> The one thing I can think of is perhaps Koba was seeing multiple
> issues at time when he found this, like:
>
> https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canonical.com/
>
> That was also being seen by an engineer here that was looking
> at client_count code.
>
> Koba, was this meant to be part of a series, or by itself?
>

Jerry, you're right, it's a part of the series.

>
> Regards,
> Jerry
>
