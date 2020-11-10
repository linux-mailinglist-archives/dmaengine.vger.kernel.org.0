Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75642B1ED1
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 16:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKMPcX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 10:32:23 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39133 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbgKMPcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 10:32:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E042F58032D;
        Fri, 13 Nov 2020 10:32:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 13 Nov 2020 10:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:date:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=iQvsGPPa0tYF2NuoRivcownR9ft
        NLwLD3BYTJEqiN68=; b=lSysGwVB7uEO/OD640HhdDjd1HDZweo4kZul3xT9ZZb
        0QhyoL6zjbLQenu11bkjQ56NKvcFI9Vin1bBd06Uud3+PwXKy6qKeCQcaCiX3Nix
        TqBIn+WPVvZDm7sw6drhgyS+vbLOqc6pZ+KKyHPx4xGi3A/Y/+VcNYzG+y0uuovn
        5rWeeiiqERqhOAyiEo9akMy8TUZX4MQSkLMPkTCjY8kgFtCV5ssoWbVnXJlGmYXc
        FRSmpXdBhD0XhpoR69kEMXizqVKgjJafS27ff3o5CRM5X79G+ONZPXg3ydPFSfut
        6UtqsHXrQkJ6k4VqqCW68LFZLZ8z6wNmqdC7s/dPBYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iQvsGP
        Pa0tYF2NuoRivcownR9ftNLwLD3BYTJEqiN68=; b=EJEe7fiMO/W7hIRq1R4VkM
        Zit5RF0UHiDUTx6SfZKALDBAWTFgnK20cOfruzgTloS29toHAzz9N+GEz7rq/zx8
        yLPixecY5+AXwqbZ7sCzmo0LOcrfL29ODL89uzAJlA56HyssX9qrta4NPZnMoxbz
        I5q3M4mPKf0MwE9V4tdYhZRPJEikPDzVC5fdpaacyloLcIJOJyoKpti/64rdTwAj
        /Gv0s9sL1Qg5aK/CboQnGKNUvqEFnTN5B0fgsQHfGoUtsPl8nhnsBVKE6eQDVxXH
        SQ2rJ3EJVfbLNEFd3b+oFJvyjudcxqFG0onlp35JDRt7IALKPWoEbWk3YjcrD3gg
        ==
X-ME-Sender: <xms:AKeuXzhp5yOZuzx_8jABAGLEMIARQ5xo40fJkpSR4FuyWLt-6jzgAw>
    <xme:AKeuXwA5pgknbzpFZOXlJtT48gdkLWQj5Td8uDZtGkQWAl8sQgDry2t8w2V5qT_XX
    Eeuk1BzA1nEqMDoPDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpehmrgigihhm
    vgestggvrhhnohdrthgvtghhnecuggftrfgrthhtvghrnhephffffffgteejgeeiteelue
    dvkeffudekjeejheevleekgffggfekkedvhfeigefgnecukfhppeeltddrkeelrdeikedr
    jeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AKeuXzGdXPY-QZyakhb_12fR12Jd5ZHQl-EScwayMt7F4680Um_lDw>
    <xmx:AKeuXwRguMbGG6BXUiUDFA9shhP9V3h4cjovwPpd_fCwkqtq-yjcbg>
    <xmx:AKeuXww-uHpJSrMnSdsgyDrytpFfi7fDFWSH7WxmiJVs-U6ojPrIlw>
    <xmx:AqeuX9jrNtkIa69VlNHt4vbw5TVITyxF4-jAagikg_6BBmBDNV88dA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE0853064AAE;
        Fri, 13 Nov 2020 10:32:15 -0500 (EST)
From:   maxime@cerno.tech
Date:   Tue, 10 Nov 2020 13:55:36 +0100
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com,
        wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        dan.j.williams@intel.com, Linus Walleij <linus.walleij@linaro.org>,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, Colin King <colin.king@canonical.com>,
        rdunlap@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 00/19] Second step support for A100
Message-ID: <20201110125536.gxxbgzkh3tlmn2ze@gilmour.lan>
65;6201;1cFrom: Maxime Ripard <maxime@cerno.tech>
References: <20201110040553.1381-1-frank@allwinnertech.com>
 <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com>
 <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
 <CAEExFWv2o9aTfUVM5NzZz10kAO_Ya8VJvJrmyjh55=U_5G8RJw@mail.gmail.com>
 <20201110124829.GB161013@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dakuxhxxqpi2fsmh"
Content-Disposition: inline
In-Reply-To: <20201110124829.GB161013@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--dakuxhxxqpi2fsmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2020 at 06:18:29PM +0530, Vinod Koul wrote:
> On 10-11-20, 16:51, Frank Lee wrote:
> > On Tue, Nov 10, 2020 at 4:43 PM Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> > >
> > > On Tue, 10 Nov 2020 at 07:00, Frank Lee <tiny.windzz@gmail.com> wrote:
> > > >
> > > > It seems that sending too many e-mails at one time will cause some
> > > > emails to fail to be sent out. I will try again.
> > >
> > > Hi,
> > >
> > > Instead please reduce the address list to relevant people, as pointed
> > > out by scripts/get_maintainer.pl. Don't Cc irrelevant developers
> > > unless a file is abandoned and you need to get as much audience as
> > > possible... but sunxi is not abandoned.
> >=20
> > Thank you for the reminder. I resend the version in the afternoon,
> > only CC the relevant people. I'm not sure. Should the cover be copied
> > to everyone?
>=20
> Any reason why this should be a single series.. why not split it to
> bunch of chunks, one per subsystem like pinctrl, phy, dmaengine, etc...
> And then DTS parts and CC relevant list and maintainers. I do not think
> there is any dependency, right?

Yeah, I agree.

One series should be about one topic, so you should have at least:
  - One for the pinctrl fixes
  - One for the DMA controller and related DT patches
  - One for the MMC controller and related DT patches
  - One for the USB controllers and related DT patches
    * And for the PHY, the enable_pmu_unk1 and devm_* patches should be
      sent independently as well
  - One for the watchdog
  - And the PMU patch should be sent independently too

Maxime

--dakuxhxxqpi2fsmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6qNyAAKCRDj7w1vZxhR
xZhsAQDnDysv0PDMRF+pQ9Aae6T48f6wAJcVf1ozDJ6SaYxctQEAjoXFWWcwmX5u
DkWVsDJgDp4anqqJj/n9YqMwDCBJ9Q0=
=LbiZ
-----END PGP SIGNATURE-----

--dakuxhxxqpi2fsmh--
