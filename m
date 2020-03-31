Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9C199DCB
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCaSJR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 14:09:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41913 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCaSJR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Mar 2020 14:09:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id a63so14087692vsa.8
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2020 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UPJq6ZlTzB31AHhJ/+QZLwm1iSTlBLnX9zVCEY1D9+4=;
        b=oDuAK8ri3s9l8SoVYBHbDcZwEw9KgiiYf/MpM8+3UdjLAqFIF662mmjXuIXNyb/ez8
         IzuHflTQWAUV2pof4NIUTD9JmBz2toCJIihOcdaBy8zPUmiQ+oeh/2rFJagHTursEWcs
         4V6VYEYBBIaTCKTChOoTfPtT/NRaR/3u3mYkaI2hWqB3jPcxJF0cbe059XBt0KU6tm+z
         MkNSk2yUyXCVvluLjfLYhYMIQgTHlVY8AL4imdlsUmenfrAaWURjFzltEvV3DcDd8qTZ
         Nj7HLfHutH0+ZGOLDQ33x4GiMmNVJ1ka/xcvL+e0pdHMAA2DCXooIm7NmWSnhY3gVmk5
         iaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UPJq6ZlTzB31AHhJ/+QZLwm1iSTlBLnX9zVCEY1D9+4=;
        b=pdReSHXxgpufxRuzQT2PAu55KzrgYnlyM2gmd8oJuHiWELmZQvJ16OoOHT2CfJ+k1+
         E/e96EO5pMrBvSpk0xrsQBSk4WiBuynaSZjbplO5zzxqO0eEgje0YXWZuvUYRXXAIYoy
         9V/gSexRYBKcgkGkzrQSA4RyHu9NLO9XmOJDhXtaRjfhroInr51+Ie6qF49wAw0tCfqr
         1m+vgZna6iq3s6RnoxAZARymkgqWR7aEaKp2EB1aubZyGnNL9EbPbz12S6fC1NaFMAvv
         yaZwtIp6mjOaI1QP6Z5zTZ1wjvbOR5ZOEuj5iNWHnxs6CLJ6x6fCt0Joh8qzboL+9wOk
         8Kgg==
X-Gm-Message-State: AGi0PuYIyGEG/+bDlZfNUkPfvnoJ2lP2EHHAGzVPOCagtdP4lmCWwLY4
        fxa6Ubf6si1Suv6NuiwS1LPai4ik5rnfgJBoAbYKXA==
X-Google-Smtp-Source: APiQypKHYbxkIBOvGCboXv205msSO49ApFYBvgXnNfouHIfGDbCAyape1yuky1eiv5St/SnqpuMkCL9RRVhFK5wt3fQ=
X-Received: by 2002:a05:6102:72d:: with SMTP id u13mr2964354vsg.35.1585678155840;
 Tue, 31 Mar 2020 11:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
 <VI1PR04MB504097B40CE0B804FA60D67A90CF0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB5040FFADA4F780422E208AC390CC0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAPDyKFr_yOmZ2MMvp=1krHejCRDRfhC0B+1icYR5xuZfhKy_ag@mail.gmail.com> <2b2f1b1e-d186-e60f-baa9-3223ad4101f0@arm.com>
In-Reply-To: <2b2f1b1e-d186-e60f-baa9-3223ad4101f0@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 Mar 2020 20:08:39 +0200
Message-ID: <CAPDyKFoSeXsNOW4Defc_nLzfd5G8UvsTWUNMJNW6tAZ0gMV4Kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 27 Mar 2020 at 20:15, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-03-27 3:34 pm, Ulf Hansson wrote:
> > On Fri, 27 Mar 2020 at 04:02, BOUGH CHEN <haibo.chen@nxp.com> wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: BOUGH CHEN
> >>> Sent: 2020=E5=B9=B43=E6=9C=8826=E6=97=A5 12:41
> >>> To: Ulf Hansson <ulf.hansson@linaro.org>; Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
> >>> linux-kernel@vger.kernel.org
> >>> Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
> >>> Russell King <linux@armlinux.org.uk>; Linus Walleij <linus.walleij@li=
naro.org>;
> >>> Vinod Koul <vkoul@kernel.org>; Ludovic Barre <ludovic.barre@st.com>;
> >>> linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org
> >>> Subject: RE: [PATCH 0/2] amba/platform: Initialize dma_parms at the b=
us level
> >>>
> >>>> -----Original Message-----
> >>>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> Sent: 2020=E5=B9=B43=E6=9C=8825=E6=97=A5 19:34
> >>>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rafael J .
> >>>> Wysocki <rafael@kernel.org>; linux-kernel@vger.kernel.org
> >>>> Cc: Arnd Bergmann <arnd@arndb.de>; Christoph Hellwig <hch@lst.de>;
> >>>> Russell King <linux@armlinux.org.uk>; Linus Walleij
> >>>> <linus.walleij@linaro.org>; Vinod Koul <vkoul@kernel.org>; BOUGH CHE=
N
> >>>> <haibo.chen@nxp.com>; Ludovic Barre <ludovic.barre@st.com>;
> >>>> linux-arm-kernel@lists.infradead.org; dmaengine@vger.kernel.org; Ulf
> >>>> Hansson <ulf.hansson@linaro.org>
> >>>> Subject: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus
> >>>> level
> >>>>
> >>>> It's currently the amba/platform driver's responsibility to initiali=
ze
> >>>> the pointer, dma_parms, for its corresponding struct device. The
> >>>> benefit with this approach allows us to avoid the initialization and
> >>>> to not waste memory for the struct device_dma_parameters, as this ca=
n
> >>>> be decided on a case by case basis.
> >>>>
> >>>> However, it has turned out that this approach is not very practical.
> >>>> Not only does it lead to open coding, but also to real errors. In
> >>>> principle callers of
> >>>> dma_set_max_seg_size() doesn't check the error code, but just assume=
s
> >>>> it succeeds.
> >>>>
> >>>> For these reasons, this series initializes the dma_parms from the
> >>>> amba/platform bus at the device registration point. This also follow=
s
> >>>> the way the PCI devices are being managed, see pci_device_add().
> >>>>
> >>>> If it turns out that this is an acceptable solution, we probably als=
o
> >>>> want the changes for stable, but I am not sure if it applies without=
 conflicts.
> >>>>
> >>>> The series is based on v5.6-rc7.
> >>>>
> >>>
> >>> Hi Ulf,
> >>>
> >>> Since i.MXQM SMMU related code still not upstream yet, so I apply you=
r
> >>> patches on our internal Linux branch based on v5.4.24, and find it do=
 not work
> >>> on my side. Maybe for platform core drivers, there is a gap between v=
5.4.24
> >>> and v5.6-rc7 which has the impact.
> >>> I will try to put our SMMU related code into v5.6-rc7, then do the te=
st again.
> >>>
> >>>
> >>
> >> Hi Ulf,
> >>
> >> On the latest Linux-next branch, the top commit 89295c59c1f063b533d071=
ca49d0fa0c0783ca6f (tag: next-20200326), after add your two patches, I just=
 add the simple debug code as following in the /driver/mmc/core/queue.c, bu=
t seems still not work as our expect, logically, it should work, so can you=
 or anyone test on other platform? This seems weird.
> >
> > You are right, this doesn't work for platform devices being added
> > through the OF path.
> >
> > In other words, of_platform_device_create_pdata() manually allocates
> > the platform device and assigns it the &platform_bus_type, but without
> > calling platform_device_add().
> >
> > For amba, it works fine, as in that OF path, amba_device_add() is calle=
d. Hmm.
> >
> > I re-spin this, to address the problem. Perhaps we simply need to use
> > the ->probe() path.
>
> FWIW we already have setup_pdev_dma_masks(), so it might be logical to
> include dma_parms in there too.

Yep, thanks for the suggestion. This work fine.

[...]

Kind regards
Uffe
