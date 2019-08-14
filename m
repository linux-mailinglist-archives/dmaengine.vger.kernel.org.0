Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D078CE97
	for <lists+dmaengine@lfdr.de>; Wed, 14 Aug 2019 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHNIgO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Aug 2019 04:36:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36020 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfHNIgO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Aug 2019 04:36:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so24723081lfp.3
        for <dmaengine@vger.kernel.org>; Wed, 14 Aug 2019 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9m/ClKWZBZ4cKiuiDXlzmOAFeeYlFwcr35QV9Gd9YOo=;
        b=lQCO0wdj4cBFymMjPac0TynRfsXFyNg+5yMGu9feG0KP+a+4yM8+eM1GfChG8bkqS8
         05JUSJJ88TvTBcqRbNosmozevJ/uITH1hLF7YI+YkMwa9/ScmTrCq2YNeJ19lCyikFfn
         tMEf3nfpQhwXTU6RRxbsZahJdyuPCNibAKpol0j247AOOgoch4G85EQ5whTQ5eIM18mv
         3cYYVZGdbgWLw1FISkT4XIy37uU2dIJI8SVzU1cBeNEELWQ13/oNRMPTK+/BMtxO65m9
         15l4ZrXz4powXzJMgqlbddMyAVwOYPN9jEU0duoewvy83pwOvWWDd0wNzuySdh3ooTpX
         PkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9m/ClKWZBZ4cKiuiDXlzmOAFeeYlFwcr35QV9Gd9YOo=;
        b=eCo3vfRHyGj42iUz4MU5PlhvhPRrzXcccrhjuLqQVRCTPJ620Tlc0vYto4QvjLVCxK
         hK0HeSlCGfdBvBRiOfjxFjoRC5zXlIa3fxo53Y/vcgifPzeYnQ7PaAtfK544bNv7p7ar
         bljj6cnebYyIKPsPWm+u/E+u/mEDncmh9gBnXO9LkcUjENkiq05Rqej+tIo0lseqRFAF
         vaT+82oletDiPuKLy/pKTNMT+jB96lJKLbgvAQLp/0/xuMeoahqQYbNEF2u2Eww+Qx9F
         ckyBkJdEPN7fT8UbLbdjtUYojoVSuLXRU0F9dIBrR4iu7a2vZdrXP85aZfcNY0Si8z6w
         s2yw==
X-Gm-Message-State: APjAAAXte+/iYmIuM59PTu6MSo6qB7Dwc9W+EIleb1iJeGdAd3fnrYqz
        RDTzUaM5VTtV9AraOVOlj1LEa0aR5HG8arWMPqk19A==
X-Google-Smtp-Source: APXvYqznbmtSAAQS/LW5nR9i4yrmWUGYLkBCD0/kjsmr5yLyxGjMyWL3WMpAlXpxiLeD6i4k4a5/J5sHITEp2/ghPp4=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr24953593lfy.141.1565771772948;
 Wed, 14 Aug 2019 01:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com> <20190812094456.GI10598@jirafa.cyrius.com>
In-Reply-To: <20190812094456.GI10598@jirafa.cyrius.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:36:01 +0200
Message-ID: <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
To:     Martin Michlmayr <tbm@cyrius.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Peter Teichmann <lists@peter-teichmann.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 12, 2019 at 11:45 AM Martin Michlmayr <tbm@cyrius.com> wrote:

> As Arnd points out, Debian used to have support for various iop32x
> devices.  While Debian hasn't supported iop32x in a number of years,
> these devices are still usable and in use (RMK being a prime example).

I suppose it could be a good idea to add support for iop32x to
OpenWrt and/or OpenEmbedded, both of which support some
pretty constrained systems. I am personally using these
distributions to support elder ARM hardware these days.

Just my =E2=82=AC0.01
Linus Walleij
