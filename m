Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7B51C0FA
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiEENmc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiEENmb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 09:42:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21721C902;
        Thu,  5 May 2022 06:38:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so6153065wrn.8;
        Thu, 05 May 2022 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6iP/5VZpBhs8GrSrq+JWfYd7dcuaN6AQJW+MLr1mLqc=;
        b=WqsJc0j/U68FILYVhlyIHvK1gGjiCFi6KChdi5GoeIkUpxEL05sWF+azuCSJAYwY+Q
         9oIF3SEnsII51sPyWfINQQdiKy61ip8ZKUq7mmA18J0mf9io+Qk3chIWVfcv7TiKvEPX
         5CTKmHMjBjRQDkkyz12URg5dRAwh6xkxShKf+mnOrlWpHATUw17kiNtot0QJrk6C7DvX
         yp/Ri+H8TW9kcRuMIId8ckcbfRnUtcjVzOjxCDVB+8jKJvPjg12avQaeqRr0bQXgYUTK
         3EU4QM7tc7afnrxGfAivf996boxgJ9Wjp+W2ajivMjDV8IaDnpDk1xTe772RkfuDRUfb
         o+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6iP/5VZpBhs8GrSrq+JWfYd7dcuaN6AQJW+MLr1mLqc=;
        b=O9Za47GFyNcYLBN0ciGGTiO04Ksb8Q0LNRQo/CFi9me81hi3ueE1RX/H9tqqXDJkEw
         Q7b7qX6DnTrmjfCWD4mogPfjl3Bayz6pD4ttdOn9gs9ouBOe1NUVIu3TlRrpkI4FzNPG
         9xXXm9IunzGZ6wfLwv35R5nW74ZDqkJrviVVayUHWlq7EvFctoeF9ZGnA4HN7hgG5MT9
         PQZWJU7X9FW0ldqgmWMoJvVQZ6xs0/3tLKRl5lNagS0t6U3qgwC8KGb+8vb74UCZW9Zt
         H6Uyq0rAhYGlq8lct2Y7HzElkDPIEvrFLW9Ovj8TFcrImZS0/s4E7rXTi9Q0gi+BXmr1
         eDkg==
X-Gm-Message-State: AOAM532Riv4vTOgivWcSiRQtdb6hXd0uKFLN9bv/mASLshMnKm7dGwqC
        BtL1ko9JHYPjHQFvsneuFMM=
X-Google-Smtp-Source: ABdhPJxHiTAJtuUJzeAB7DIZRB89tduLgSH1LgywNNVcabWqlfST+rYomb2rsABdK6aSOQEirMs+eQ==
X-Received: by 2002:a5d:66ca:0:b0:20c:6970:fb33 with SMTP id k10-20020a5d66ca000000b0020c6970fb33mr13939150wrw.100.1651757930401;
        Thu, 05 May 2022 06:38:50 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0020c5253d913sm1184160wru.95.2022.05.05.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:38:49 -0700 (PDT)
Date:   Thu, 5 May 2022 15:38:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        vkoul@kernel.org
Subject: Re: [PATCH] dmaengine: tegra: Use platform_get_irq() to get IRQ
 resource
Message-ID: <YnPTZ8KaDdxbgBKP@orome>
References: <20220505091440.12981-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ff3tln71Bbh07Q38"
Content-Disposition: inline
In-Reply-To: <20220505091440.12981-1-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--Ff3tln71Bbh07Q38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2022 at 02:44:40PM +0530, Akhil R wrote:
> Use platform_irq_get() instead platform_get_resource() for IRQ resource
> to fix the probe failure. platform_get_resource() fails to fetch the IRQ
> resource as it might not be ready at that time.
>=20
> platform_irq_get() is also the recommended way to get interrupt as it
> directly gives the IRQ number and no conversion from resource is
> required.
>=20
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Ff3tln71Bbh07Q38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJz02QACgkQ3SOs138+
s6GoeRAAo5Dj7TLanAzQmb2ECCbSMF+Tc84F8sUdHbbuf+Rfd9OXcNhN+zCFlXWt
3gDrtdcHLNQOf7qiu4s6X4N20NxIBQryzoUfIbPzbyYS2up5sCilt3j/k5b2/ZK+
NhUGVEcJLLdWipOzMwc+Ai2zNcZFZ6HLzhZTq0Pd0+iEmtQ6PEuyrQZQPX+fZCRA
azvXB+uxq9KzJ73pDnfGDzevKG+vVntyupGIkzXYZ5EmJCz00MwEcxeQQrZUdNYq
C5IfNjbdc+XLNKvQuIipKWrRRE1bOjoTacAuknhSy3sjFx8TP+8jgc2u3VRXuDga
1MMOqn3iz4WIa/KNOn7ndYpse8MabD8AIvRoRjIZt+/2mq8sm22Qvq3EOPpnqnyX
gjOk3nFpAqhaEzmuAL8AlR6XhPi5HskJyfBjoNdhh9ecSKiD7S2KK/NwwD3aQphg
t4FbJeDKsPv4OUya1zbvkSiQtR0kWUAW3lMjFNfixLLUFIYzvyIOspZT6a8zGeWR
XAW5FQV9zN3ZewWqR0e+AsPLijlcGNOf/8fUOW1HIMhRcX+cod2sE9VCYgqSbPh1
mYl2Yrou9fzvaDN6MZj6VXQeivRv6NesRAyuaII8wptjQhoDXqUZfS4+DEjKNovK
9NroiYZLAYTw/xI4ZVlUXQeP7Ap0XR16cm+//kMe7las54EzjoM=
=Sa9d
-----END PGP SIGNATURE-----

--Ff3tln71Bbh07Q38--
