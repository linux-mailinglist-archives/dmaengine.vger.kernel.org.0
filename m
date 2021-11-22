Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA4458AA4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 09:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhKVIsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 03:48:31 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45763 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238841AbhKVIs3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Nov 2021 03:48:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D3EFE3200E91;
        Mon, 22 Nov 2021 03:45:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Nov 2021 03:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=F44KrvcvGUuA+pebqxc+PW7CgP4
        M7zEHojCNTsaH//4=; b=isWq5Q5qDtTe9rEVOzNg8+80EV2j/EoCgo+vSe25sJO
        ZawzXgS3sRhCmvAPhjHoLW3/SOMa7RxsuS0BQDL+kU+xTbEf0A72IDiH9IUvhemk
        rw3+6eAuQBW/80+Ba9D4R0JORkYAhFo7q8naK6OLs9v7jDT3O0p+iBozEwMhV5HT
        P/oAe6F7v22hlW9rV2x66ZiXm5WBGyBPa138QPbeg+CF4mUwomMP9kNzP/TQAaBC
        g3eV9YmGPysdpNi67BzTvz0nG/3XJ/GL1nHxdi6I10QsaMMzcsXhkKUS4CG2eihF
        2Q3Do2h9OLDrsVk8iHPHM7DShWw1rb/6DI+qmXwycHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=F44Krv
        cvGUuA+pebqxc+PW7CgP4M7zEHojCNTsaH//4=; b=Yr5mOGpP8NmK11EVRBsFNS
        53yjxw7xM5p93j2T8Qp7si95h7AvlHOa1clTUs/waUEOcxrsa6B2Q9YvW91t/VQo
        YFHs/xRYy0MgNb+VoJMkJMFZy6b7OlCKXe166ZCaAVpPIzKqHQ3lxJdBcQ8Y1yIN
        ddNziJu6XKiyMe0Lsm1BcO9dplRRR1CfguBUj1sjWWEUFULW5Ek84WyPBglxqETu
        bCb0+D2IeAU9RQdU8Gkaf/YBtbuMG7tDAYTu1uFxCecUVtdyzmn1pmTlahnO91YP
        h2QclJ+fyB7efXHQntGmLX0Q042dwCiCt28LKWsMSjxfwjiRscy+eGKBY9z5EDhg
        ==
X-ME-Sender: <xms:olibYa4zuBiFVQesLCjaqRtORt2f97KZgyrZwDobsXEzK5R5tEkhsw>
    <xme:olibYT5xOtWIWZ7kl7-YgW16Geu5bk5BaCkcRBdhdxs5kIFeFfItifXvr4gXVJ3Go
    aguMUnqRYV18QRdXJ8>
X-ME-Received: <xmr:olibYZdDKGz0fZDhtyM5stFhkAg6kP0IuwR8tUKUuGYioOhe5iYm7GWyTiFapMfup_2MAQrmuWvvqbPs2rKSYneTov9dLGSiJE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:olibYXLd9b_kfpIU7TrWslzvrmnVh3Abw3CX7EneS8_tQOJX9NhkaQ>
    <xmx:olibYeJ5_93Ov0lu9O8_z6BPY-CyJNNQpqk6FvTqNX3KtWxZhyHYrA>
    <xmx:olibYYyNhubgSIH5e6LmB6mL3ox9ZhQomMcFBOHL5GCMAxNS0elm6A>
    <xmx:olibYW_gcQ2wyCmp7qS2Cv7kU9G6vi-ptPzr2-jl89X2JYscU3QDbQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 03:45:21 -0500 (EST)
Date:   Mon, 22 Nov 2021 09:45:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: sun6i: Allwinner D1 support
Message-ID: <20211122084520.zy3cij7cazd22eyj@gilmour>
References: <20211119052702.14392-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5n3awswhwzyah63"
Content-Disposition: inline
In-Reply-To: <20211119052702.14392-1-samuel@sholland.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--w5n3awswhwzyah63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 18, 2021 at 11:26:57PM -0600, Samuel Holland wrote:
> D1 is a new RISC-V SoC that uses mostly the same peripherals as
> existing ARM-based sunxi SoCs. This series adds dmaengine support for
> D1, after fixing an issue where the driver depended on architecture-
> specific behavior (patch 2) and resolving a TODO item (patch 3).

With the comment on patch 3 fixed,

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--w5n3awswhwzyah63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYZtYoAAKCRDj7w1vZxhR
xXPeAP9KzA7Aann9BSzn6mFst2keC9v1BPrDeEuHthn6c1m+8QEAlqMIa/xzm2Ki
qh9qjvAtYEJpsu8SUkZlHZQ9gPtl6A4=
=EaYm
-----END PGP SIGNATURE-----

--w5n3awswhwzyah63--
