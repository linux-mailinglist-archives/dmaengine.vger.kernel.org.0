Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1946B63E
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhLGIoT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 03:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGIoS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 03:44:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975FC061746;
        Tue,  7 Dec 2021 00:40:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o13so27784699wrs.12;
        Tue, 07 Dec 2021 00:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gVQ5ivebKkFTDN+GiImUqMsGHtYhlp7FMILxklM1yxE=;
        b=UuoocO8fjbCxDmiQTlF03fmNJjxI+aQBaQfGhX1nz6cpmVoxQOH7P0PtjQo111GyLI
         WP6FOtXbIhFAZnlBvsGrMSI5UJoLI6ytM3XzlGn5bsPPqh2gghzXws6R9aedd/Pfw1Rd
         hAZoxlY69iBa9WNZ8LDLcbVL8WoQ1mrhxYdIHrC7aC3xLV9CyzakoEsVZn7fe57JFjH8
         JppTqEEDTeuFU9gT24RvnbGe0MyR2kB6eHse9Oz3tn6Zdo12hu9lqTvAP7tp0NDNrrxe
         2MlpjSkIkHABjNUBcYM8VVOGl06FbmpclnN7myKNyElRm9vdZnxfcGQUaRwW4yq0IBM9
         wKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVQ5ivebKkFTDN+GiImUqMsGHtYhlp7FMILxklM1yxE=;
        b=2s0OLEJHfdO0u6GbHbp8GKKOJbQ/kiZP3CuztHYBlNoBxi270Pi61hziXKOiCZvxZq
         taYgPXPM9vLWeSKXlTYBD7UGwAKQLqvLO0jOfI92u4IwRjJRs5I/SGqtF647NBBKIkck
         FzooinGMlikzbVpRpcqA7wQfmQBmglgcPyZNzyWdreTxZbBtSNPTPYtZzLt7YynUaAkt
         2bmF9jPtGsEt1YrCwAerX4ab5OX1q+UY2OgxLfgN5pDM7+srnTpA9TBc3xlNMCYJ/RN4
         mZ7zAa/s1Yq0PxiOxLWrZFHS4s3AV45oO9eZClWeM4A/tsYE79tF4MFR8pD/s+++k7dV
         UV9w==
X-Gm-Message-State: AOAM530w8DQGcnR65BtFeEL9m8q2yp8WpsmSuObklk++P4ZlAZUKIkZo
        wVR7iddvbzDL/3bgRw+kVz0Vg7iSQmTgsQ==
X-Google-Smtp-Source: ABdhPJw8BDGVI++nXd2cGBwn7DrlslAcZaTcov63U/GSa+xj7WezlzNuXwGeB1r4f3v/aTjmT0oU8w==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr49534060wrd.572.1638866447266;
        Tue, 07 Dec 2021 00:40:47 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id y6sm14198319wrh.18.2021.12.07.00.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:40:46 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:40:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml
 reference
Message-ID: <Ya8eC9UkwMZaNozs@orome.fritz.box>
References: <20211206174226.2298135-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LVXP2jlz97STXdKu"
Content-Disposition: inline
In-Reply-To: <20211206174226.2298135-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--LVXP2jlz97STXdKu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:42:26AM -0600, Rob Herring wrote:
> The TI k3-bcdma and k3-pktdma both use 'ti,sci' and 'ti,sci-dev-id'
> properties defined in ti,k3-sci-common.yaml. When 'unevaluatedProperties'
> support is enabled, a the follow warning is generated:

s/a the following/the following/

Otherwise looks good:

Reviewed-by: Thierry Reding <treding@nvidia.com>

One question below...

>=20
> Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml: dma-co=
ntroller@485c0100: Unevaluated properties are not allowed ('ti,sci', 'ti,sc=
i-dev-id' were unexpected)
> Documentation/devicetree/bindings/dma/ti/k3-pktdma.example.dt.yaml: dma-c=
ontroller@485c0000: Unevaluated properties are not allowed ('ti,sci', 'ti,s=
ci-dev-id' were unexpected)
>=20
> Add a reference to ti,k3-sci-common.yaml to fix this.
>=20
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml  | 1 +
>  Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Doc=
umentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index df29d59d13a8..08627d91e607 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -30,6 +30,7 @@ description: |
> =20
>  allOf:
>    - $ref: /schemas/dma/dma-controller.yaml#
> +  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#

Out of curiosity: is the # at the end necessary, or do you just use it
as a convention? I've seen a mix of both and there also seems to be a
healthy mix of quoted and unquoted paths. Do we want to settle on one
going forward or do we not care enough?

Thierry

--LVXP2jlz97STXdKu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvHgsACgkQ3SOs138+
s6GV/xAAnkLEYIsiBhmYRGP7rje1CG7qon2FShpoXJM0mOAuYrcp2/jcVBZAksdy
iG+5yQtgA28IHm0Rg0xRwJCovCxeQTaxlbSFshdxrPYPOmwHSx0t1qdPot7yOv9b
KK5QJ0Ne1qidbe484gypyM3Q9yo0laWAGkCU/fx7SCDeE//pt0pXg6SA5C3KUsGG
J8GASsSr2iXgXlOiG5tc2emHWcPCMo1SUoXueDOjpBOIZAunUdlMelPnOXRzxaxk
X3iGbTIhY2UZAzQqnrAf58ZTsLPN+/nIKKW4UJH0z7vPL/S16C2pzW5TjC0xsQcP
dfNw0nS2pRU12P7Z16js5SvqjG8YYWrmkTuGKrHVg9B7UwP5dfmNYucWb8kauuF6
mjw97Ve5AlriTthLUbFR1DJqW3aKRzPlP++cpXpFCgwJlszprJHfjx5oCsJbic0w
wwvxEg1K5HpR9Tb9IPffq74HJutyOFttZjkW66+EnMZ3G4vfeH0bPB65Y7jQRQYT
AB/mNgMLjAi/1TEi5MvNukuyGkKoYYV0ME79B2c3ANWfNwHrYIk1XUsWMFm1G75Y
fsUZ+2c4Y3AjRZbq3lAYSiALYIOFbxnVAvM2X7VFD/DLYgopbtcE4tkUqaTcsodZ
6ru5Sy2Is2YyaOZQjObMK1A9zCFGI155aQHBbg9zqSx4qXLDhag=
=Mqh2
-----END PGP SIGNATURE-----

--LVXP2jlz97STXdKu--
