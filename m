Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BF5F04C4
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiI3GZi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3GZg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 02:25:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B91005DA
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 23:25:28 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 83ADC41473
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664519124;
        bh=mIFcZhK8ZUBJ0g/1ZYnXxPqzkbqqbN8zmRF4D0To6pA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AGAXy5RlLePs+XcFb6qHDvACgG8NYYl8nN6ERQn7cAzYyYHxPqJO/QnScbv9nRzfk
         dXFwzgtkzxIAmEZihMjxdp0j5jleejYGBlymOlKcpLvHdZnNznp7G+rkHHdSVs0fEp
         HONf5vYcafc630xPAC/G73TPRosBRF4BEqMcYr9B4pVvGhFHRAXm6o2TLMbGxIzhHS
         ikp46HRgiGzQzgw+IohWxkK2+LVfdGWEaOqVJnLD8TQRI33LC6jNm8bWuC4lSVYOCl
         Yg03lDVrwzbJG8J3agvHpsonSkm5bgbz7igv0Imb1sEHU/9jaGgoBR5c14hqeLY68y
         4a+iMdRuxu3hA==
Received: by mail-pj1-f69.google.com with SMTP id m2-20020a17090a158200b002058e593c2bso2110676pja.2
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mIFcZhK8ZUBJ0g/1ZYnXxPqzkbqqbN8zmRF4D0To6pA=;
        b=l23yCD0dCtVyYN4yleANH6syRbdMxp67sjHfV8uTBzvan3Ec4s0O/eFG3ejNYkmFcQ
         sGuMvUVl5QUwQwqp2A0+bChCXuJ7xnlzx00Xu+0GOYFFR+4sSc2NIZs0rZb7SOJEpOAi
         f5nEeTapf46eYMistUIk4QNK/6Btimbw2Tj5xyzknBLRWvYvInr2hs4W82dWcGUCL255
         q8KMwVy2HuFCTgfuLrF5gRLnrfvN3p2lVY82NVaasR0Pd1nieeISMwMG3dYrUsWByiwy
         V1s+9prT/EeZv40W2iJPhhuhtwaG5BZQ1AWowebUSHa8yxHB8aEM/8tH+yT91RgixUFk
         S7qg==
X-Gm-Message-State: ACrzQf3+qIgzTCxlSkCBhQPyvRda4GTG2De6Tq+XZ8QiH56n7+c0AZ08
        Hd3FjPfw2+INJsbJIjiQovK01p/Q3cPZzrc3KuX/0/fsq3OiVF3mGOAWNsUy4826HssYp3zwVk5
        TuJQUy6cCoc/F0KrR8Gr/3zdrSfDUMMc399hTh50kd5tkaFRBCvfIKA==
X-Received: by 2002:a05:6a00:c91:b0:540:f165:b049 with SMTP id a17-20020a056a000c9100b00540f165b049mr7309731pfv.76.1664519122751;
        Thu, 29 Sep 2022 23:25:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5viB0fw/TcC4CcBv6b+cvcUaw/MgPAfU0zY+JZCa9EzRQJr7cH0UsTUFmK1jF2LRBJSGPpiigqfIpYQpxC8us=
X-Received: by 2002:a05:6a00:c91:b0:540:f165:b049 with SMTP id
 a17-20020a056a000c9100b00540f165b049mr7309716pfv.76.1664519122476; Thu, 29
 Sep 2022 23:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya>
 <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
 <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com> <20220930055619.ntgr2yobc5euzz6y@cantor>
In-Reply-To: <20220930055619.ntgr2yobc5euzz6y@cantor>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 30 Sep 2022 14:25:11 +0800
Message-ID: <CAJB-X+X2k_TCvocoiFsPr=ehSMOHZkBkOv_P540q=_jmxXgYTw@mail.gmail.com>
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

On Fri, Sep 30, 2022 at 1:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Fri, Sep 30, 2022 at 12:44:22PM +0800, Koba Ko wrote:
> > On Fri, Sep 30, 2022 at 1:26 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > >
> > > On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> > > > On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > > > > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> > > >
> > > > >
> > > > > Hi Vinod,
> > > > >
> > > > > Any thoughts on this patch? We recently came across this issue as
> > > > > well.
> > > >
> > > > I have only patch 3, where is the rest of the series... ?
> > > >
> > >
> > > I never found anything else when I looked at this earlier.
> > > The one thing I can think of is perhaps Koba was seeing multiple
> > > issues at time when he found this, like:
> > >
> > > https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canonical.com/
> > >
> > > That was also being seen by an engineer here that was looking
> > > at client_count code.
> > >
> > > Koba, was this meant to be part of a series, or by itself?
> > >
> >
> > Jerry, you're right, it's a part of the series.
>
> Hi Koba,
>
> If it is meant to be part of a series, where are patches 1 and 2?
> The ccp patch has already been applied by the crypto maintainers if that
> was meant to be part of a series with this patch.
>
> Regards,
> Jerry

Sorry, I misunderstood. actually, there's a mistake on the [3/3] part.
I created patches for the mainline kernel before sending them to the upstream.
Then I found the first has existed on the patchwork, so removed the
[2/3] part for ccp patch and forgot to modify for this.
Should I fix this and re-submit v2(also add those review-by)?

>
> >
> > >
> > > Regards,
> > > Jerry
> > >
>
