Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31481251C0E
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYPTL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:19:11 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41787 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgHYPTK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:19:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CE53EA0E;
        Tue, 25 Aug 2020 11:19:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OBxOGGBFkE5rMst9VNEuQF1EGr1
        29olkk+P1Mg8wVnY=; b=jYuRBqw3Zolz44RFw9hdZKQtJmd2RU18WUbkepnqhCg
        pRnZ+Zzvj6UktFoaYG+sBRTL2z6/PIwpWjp7hV7CixrI645v0bslL6CkUjbIWveV
        4I3r1BXL+PyhnRhrQ4sIGfXOoQjBmcihXXSOqkfgyLmfg/aM6xWVp0bzUSuRPYsb
        /IDJpbPE0HHMNeTVZrRo3tfw2RL3mRi9qarNqPYGn8DE7P4e1TjxGquSMXfbvvZs
        p6aqsGzIPaW3cpS1omwzciqHqhv2NAymhvUOTQoXmdCblFVdiqbArEtQ9I+DgrA+
        b0u4Jv5fxj+1Po7MPzRPWRKUlqik3Aw/xGWzojOpqJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OBxOGG
        BFkE5rMst9VNEuQF1EGr129olkk+P1Mg8wVnY=; b=tdvj8Td5c+VkGL49H1vPTJ
        EddjRspMuB6zIxazD+5qNw72ZQkzOcF5LHmGRnTdDEgbxtrZjwru0PugD7qf3933
        m8nUm/dZiHnij6Cqx+ciFW+Euao9Ya5vqaovevbY5WwxZ5et8qzyT6oLrKdvIqR7
        uXUVzzV94DOLwQLoMOBbPeTzqL7naf8SE9MNV+61e43WBZg1ivX8Ie+zDSg5q6u5
        iNsKjw3RI9IlVZatTH0Ewx+5hqTLwvuQof8j0Qnjqn6gFPzBuoEViYic/NtcYnOq
        8hNNI3VUqbmkEOC5omLTaTjE81V2I7V9oDP1/tPd29aw42A626BXEKyFG2daeY0Q
        ==
X-ME-Sender: <xms:6itFX-LnwhmFo5wineG_E_JQWvQZYEc8Bp5prlcr2AZ7WadeSTKk6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6itFX2LjnxyhASeuQA9w2AMLv4fSTfcCuNt3Op8s3ZdnUSs3YiMmXw>
    <xmx:6itFX-s0FmjbqT0idUDA7sYRmEsm_YpWcNX58KX7iYaqkWJnxVj8rg>
    <xmx:6itFXzYWhxywVMRwMy5xNYrj7Ps6X6vXy4HxcxJiTqfRNsfPM2TXew>
    <xmx:6ytFX4yRTt2K29pDZOHdWh1kHjF8kdKE7hOxqOMhUrVwndDlgyiMaw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF064328006F;
        Tue, 25 Aug 2020 11:19:05 -0400 (EDT)
Date:   Tue, 25 Aug 2020 17:19:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     robh+dt@kernel.org, wens@csie.org, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] ARM: dts: sun8i: r40: Enable DMA
Message-ID: <20200825151904.ah4ca6pwrvnm4py7@gilmour.lan>
References: <20200825100030.1145356-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3qulwx76gswnravp"
Content-Disposition: inline
In-Reply-To: <20200825100030.1145356-1-jernej.skrabec@siol.net>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3qulwx76gswnravp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 12:00:28PM +0200, Jernej Skrabec wrote:
> Allwinner R40 contains DMA engine similar to that in A64.
>=20
> Following two patches enable it so DMA users can be added later.
>=20
> Please take a look.

Applied both, thanks!
Maxime

--3qulwx76gswnravp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0Ur6AAKCRDj7w1vZxhR
xW1YAQCrR65GLd/64vPy0s43xP0TxYum7QY5N9Lzpaddtj7zjwD+Lu09Ymbzf7HH
F+aWuNXaMURm/mQdOgonsReFTePooAM=
=madG
-----END PGP SIGNATURE-----

--3qulwx76gswnravp--
