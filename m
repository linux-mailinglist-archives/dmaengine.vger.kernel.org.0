Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062C32AD189
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKJInu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 03:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgKJInu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 03:43:50 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D9021741;
        Tue, 10 Nov 2020 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604997829;
        bh=yaWVdXd6nLPOSk+0s2hrEtVFAxLiuqNEZ8pX8casxSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5o36w5ETEuwAzCMsQjNa+s5A0W9fO6Y3GTlhrTEcY9pxxjaW9bg2nWcvbkQn7PWI
         iOupPoRDZM5tZP9RXfs2rD5zHVY86YfvzLq6r+ixm3m0Vwp/6lk6LJw4JOXOkiO+21
         eq3dvzGjorqFd+KU4pTgywXtDO4ghjJrGl3ELMAA=
Received: by mail-ej1-f49.google.com with SMTP id i19so16301482ejx.9;
        Tue, 10 Nov 2020 00:43:49 -0800 (PST)
X-Gm-Message-State: AOAM530Chr36X9X8MnRVLNj+JbrEJn1J84nlTU+SnknO9i9W0dHXd/y5
        YAATue+HYflgWHOds0qUh98eGNveYP/QzDkvaiE=
X-Google-Smtp-Source: ABdhPJxTmGEeLjxqKr3BhSdK+jRebEFMA7yi5bPu8JW67PaPhe8uq4h+C7/0J+rMmIR0IwUAXAYYAv3O0pr2PkP7ZFc=
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr18656980ejq.381.1604997827541;
 Tue, 10 Nov 2020 00:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20201110040553.1381-1-frank@allwinnertech.com> <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com>
In-Reply-To: <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 10 Nov 2020 09:43:35 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
Message-ID: <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
Subject: Re: [PATCH 00/19] Second step support for A100
To:     Frank Lee <tiny.windzz@gmail.com>
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

On Tue, 10 Nov 2020 at 07:00, Frank Lee <tiny.windzz@gmail.com> wrote:
>
> It seems that sending too many e-mails at one time will cause some
> emails to fail to be sent out. I will try again.

Hi,

Instead please reduce the address list to relevant people, as pointed
out by scripts/get_maintainer.pl. Don't Cc irrelevant developers
unless a file is abandoned and you need to get as much audience as
possible... but sunxi is not abandoned.

Best regards,
Krzysztof
