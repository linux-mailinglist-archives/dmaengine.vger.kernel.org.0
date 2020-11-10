Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76E2AD1D1
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 09:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKJIvW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 03:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJIvV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 03:51:21 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D78C0613CF;
        Tue, 10 Nov 2020 00:51:21 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so16354765ejm.0;
        Tue, 10 Nov 2020 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlTxhcApcg62vqX1M9f+2W2ckUK1QJqanSSJQGwPcCo=;
        b=V3v1WsO3FDfA8JB8roAezvpRaz97QWsjdUjXFjXUWaxLZH0neXUTx39sL7DJTU8RwA
         CoDwJ4Vprq0pitDQ3ea1B+R6KT5Xos+5qQmjDPlKyOZQR5/NtgcW2nFixSPppZmhfkEc
         v2j+SCc8kFWyU2hKLTUsd9jx5MWRbBCBLhL9KDijN4SDasX5c0ezFg/bSbl3uwgHvL5w
         Olehg5zZlLcn3GI2T6TmeHFxQYnHCXizKi795FDH30spBpE66Y5oiQJNI3t6Lrc2pF7u
         inZ8IiZWFy7xmVMsvdNxjNgZojc4HJrZQGhovwtXpX6JbH1DDsB2d/nu6aHWWfPxpryq
         HmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlTxhcApcg62vqX1M9f+2W2ckUK1QJqanSSJQGwPcCo=;
        b=Mt5HOoyVwTbiD4OwwFeZFMPGY7sDFwSpfijjl5KjSK+VBZnI73il60w4QA8STFw8d3
         /tqdxxZ7U/q6ou1E7z2aeDIsBgx/Ojg3A7wPluoX1KilSNp/1zTo2zs/s/H1DCkY1Yqi
         +oMB3EiTbZWEF0LWhdLTrBJuS741iX6HxNLeXNssU4EZP0m/GOOqxv5Dej2DAZON4YmH
         vO5PggUdDhsVTtKAFXhuc52qumgsdE1PimLM+QsWUbR9MbtDlPyQ51TqlBPfNaHyaKVr
         PnoM1XYkiqcm/9jusO6Pz9FcMXG4pMOXH3PtrtqNSoPaUznVmL8W77DqnIMSRjoVNS+j
         LZfQ==
X-Gm-Message-State: AOAM531FMKVPV2PZj8WXY6bkyu+1IUO3n5Y0k89BfUWyzmadFYt6RYwf
        Ye2pRFVGf5MM+w7gnHDDHLJBsaj/98EvkolhNbQ=
X-Google-Smtp-Source: ABdhPJyivmb3ngYrw4gtkNWPfiNQYExGOC3o066XQXDnsrHRenMS2oz3iAAHjo6Ogz8WiiePxqU6Aj0qnt+2EiVRZCs=
X-Received: by 2002:a17:906:c18c:: with SMTP id g12mr18851005ejz.334.1604998279995;
 Tue, 10 Nov 2020 00:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20201110040553.1381-1-frank@allwinnertech.com>
 <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com> <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
In-Reply-To: <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 10 Nov 2020 16:51:08 +0800
Message-ID: <CAEExFWv2o9aTfUVM5NzZz10kAO_Ya8VJvJrmyjh55=U_5G8RJw@mail.gmail.com>
Subject: Re: [PATCH 00/19] Second step support for A100
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Frank Lee <frank@allwinnertech.com>, vkoul@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com,
        wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        dan.j.williams@intel.com, Linus Walleij <linus.walleij@linaro.org>,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, Colin King <colin.king@canonical.com>,
        rdunlap@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 10, 2020 at 4:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 10 Nov 2020 at 07:00, Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > It seems that sending too many e-mails at one time will cause some
> > emails to fail to be sent out. I will try again.
>
> Hi,
>
> Instead please reduce the address list to relevant people, as pointed
> out by scripts/get_maintainer.pl. Don't Cc irrelevant developers
> unless a file is abandoned and you need to get as much audience as
> possible... but sunxi is not abandoned.

Thank you for the reminder. I resend the version in the afternoon,
only CC the relevant people. I'm not sure. Should the cover be copied
to everyone?

Yangtao
