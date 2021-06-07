Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAFF39D797
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFGInk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 04:43:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59509 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGInj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Jun 2021 04:43:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8873D5C009A;
        Mon,  7 Jun 2021 04:41:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 07 Jun 2021 04:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lwHWKCOkyXBnvnkruLCzGRsucQQ
        +eQ3CViVtR94CBwU=; b=NJsBttidDc/0fES2Qi2+VZn0g82F8hncbfLBLGRVtRM
        41islXDggk9IhDHLnTfLsktLt0IMknpyehKp7YtX+Olgy5wF5boRqWbrexg9Bruh
        3N91tMJyQRiuFfsUguTXHdZnr+gHNkdvFo/YNh7ZVU+nCtF/vFkrv73Y7RR45thv
        XN2mK5ofWxcBwp4Yl72QHGNGLl0TdXmDg0RWdqzFGE77CKejh9X/nDdJr5A52gez
        F1x6SLn3xtuBIZ7s2HuFzKvEHzQTieo81+pINsaw23sAHbDKLzsqLbIwIh1FNYPc
        KLX4rQymUpqg8KhJ2G2dMCjoGMRAT0gXL40fYXBENTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lwHWKC
        OkyXBnvnkruLCzGRsucQQ+eQ3CViVtR94CBwU=; b=YKHYWhg8fTZW28aqc/Am12
        a62kebb39qxupyEIhntY9FRb1vvOMwOqBu6s+v8fEdMOuMHOMWNHL1w+9RPVLwjn
        JBhBCAJ5b77ld6pEs7QMfPe6roc/WJ3V4pn7XbT/krazyMGqRF2tRWz1WmsevbTV
        dhY2p30Caay/1foJara3gRttwz3flJiv7bVUs/rA6qexJh56m2uN7OS8zCFJljc1
        31cqZz1Rcedr7QEw3wJgGW8QtS6YL41/3+qT2Gx0oVQRUpw/W4nEfOJOs/e1X8iN
        nJDAreZsqBkEVpERqpaB+iu8/nuozR9Y0Y3xdDH+q0OK5IB1zXpJzCwWvJRTwyZQ
        ==
X-ME-Sender: <xms:y9u9YEAbI9f8QlqYd6EF6IsD3zzCxeEIg7_MCuz3pc2s8CdM4XE0Lg>
    <xme:y9u9YGg2ZAu9vLhJEZakvUAdMJUfzZjZQLGksZJfFtfilixgdTEYQa9AcBXmLC9Dp
    eySBm-OXIfHxijj6N8>
X-ME-Received: <xmr:y9u9YHnyzDHk77cv0IVZKs-HP2k3IvzKjC7-5G9HzxOEWb8m29BrYnx-50xAT7BMISqQspsi-Wk-47h1X-QyXV9zyogazm53za65>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:y9u9YKxfixCPNJl3fUkpO-qyscjHkW_V1CnLClngo3KRA0IxqTdCEw>
    <xmx:y9u9YJQIINpf6a1MXnBdADb9mqBrhYU70x8W_YdSWgr7gTm8yciOCw>
    <xmx:y9u9YFY7r2gYhJiSdEtSGP1wIxzNK3z3jFaMHGz0EwhgWSbtPXFD8Q>
    <xmx:zNu9YIHQjerxiCWcH04qO3jykkh5UlvIscL9ERBkvMqhZjbim-WbhA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 04:41:47 -0400 (EDT)
Date:   Mon, 7 Jun 2021 10:41:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     vkoul@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: sun4i: Use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <20210607084144.v3a5rx5ecqnussgk@gilmour>
References: <1623036035-30614-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ayy252ovvkwrpgk"
Content-Disposition: inline
In-Reply-To: <1623036035-30614-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--5ayy252ovvkwrpgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 11:20:35AM +0800, Zou Wei wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--5ayy252ovvkwrpgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYL3byAAKCRDj7w1vZxhR
xe0EAQDf8GYmovI5HNv9dg6tOjLWlJowFr9dCaNvoq37fSRTeQD+Peb5aGORlfDl
LgXaRSNY0zoh5hcqNkBz+SaO7BgYJAk=
=ghSl
-----END PGP SIGNATURE-----

--5ayy252ovvkwrpgk--
