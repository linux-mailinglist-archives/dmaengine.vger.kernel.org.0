Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881146B642
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhLGIop (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 03:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGIop (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 03:44:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C957C061746;
        Tue,  7 Dec 2021 00:41:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso1629622wmr.5;
        Tue, 07 Dec 2021 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epZ7mVCQBBKdcnfQSHCIYXAMlF3XUVoAAwD3l/pIzA4=;
        b=VLWZOCZvt0Yeoe4B/XgxzHhAvC0UZEAvQcsEQhJhi8rc1lf8ZYWLrWwgWslG/UpKsr
         0oeqqOcE5UnmR6sWHNsQUwLEOr3j/wzR5UwRqUQYL4E9eRQh5S8Nf2eSyS0iE4ZjV568
         x84HasluSaFdd3VB1w+0tN/XbW1FZW0LsJAUQ8QAMyOmkJk64guC7xODyhxEy6/xZOE1
         fWWC1p77wOCbxyYVf69kcRW4lxoJOgBzyHQYd8iUlwGMFR283y0wXX7koloA4Y7w8ovn
         xvNqYawaCOKeyBypRQGp1qQSwiWM/0JyE+C82nb3CfaVXsZknSjA2LsGhCrvxenoPxzS
         Hnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epZ7mVCQBBKdcnfQSHCIYXAMlF3XUVoAAwD3l/pIzA4=;
        b=zDVbkvHR5QczRn10Z1188x2V+kSm84spsZWfS81vWqE6ogjFGW5D1jQTxjC7q0oqL1
         KQamrt8gI9Fv7I/zHT4uXO2xq8UfujALTbyyS+VPG7LP8d3bNSHeC6YuVF2ZZ/BOe28y
         hcqxiT9HtTMdqSYLaR4eXs2YbTI1dqY63u8wj1gTDwZMtIdj05RM1zn454h/EA2QUme3
         EHSIlgqmJejs6yUYZfdoyGN1H2glDD8167We7SGvg3xkBOgjWwjYzr/RoDFGKucyGk/p
         VAoV02AQqyG/82UZJBiUdyCjafXsZYFmIZj/XON2ZH5HeZIrYFNHVy5uSGYK8L5SZNrq
         o3lg==
X-Gm-Message-State: AOAM531sm/i+ovHXcc/aGOzJ2sc2hGicPROyJehR/BGte9s2Do9IbOCT
        WbVrrRpSaN+gDE+AdB/mm0UpJJJaEN5OiA==
X-Google-Smtp-Source: ABdhPJwkr2k/LEq0QWcZJ3Cbcg78zTLZ6eD905w3QO8UkrVMKGziSKshMBKn0WNTMq75l3/OpxhfSA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr5230735wmh.104.1638866473754;
        Tue, 07 Dec 2021 00:41:13 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id f3sm13737702wrm.96.2021.12.07.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:41:12 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:41:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: pl08x: Fix unevaluatedProperties
 warnings
Message-ID: <Ya8eJjPMLwqBUFD/@orome.fritz.box>
References: <20211206174231.2298349-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="toi56B7oyc04/PA5"
Content-Disposition: inline
In-Reply-To: <20211206174231.2298349-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--toi56B7oyc04/PA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:42:31AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the example has
> warnings on primecell properties and 'resets':
>=20
> Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml: dma-cont=
roller@67000000: Unevaluated properties are not allowed ('arm,primecell-per=
iphid', 'resets' were unexpected)
>=20
> Add the missing reference to primecell.yaml and definition for 'resets'.
>=20
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--toi56B7oyc04/PA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvHiYACgkQ3SOs138+
s6E7gg/+OZndKVWvLb1pAMyft4NJh4m8IKfJVNuOY0UiJIoJj7/0Pznme3pc0KES
U6A9e0Pnx383LIBQGJOOEu0nVYoAOWgawYtTPIOjiu9lY/yCS9sHTErWgWRb/4mo
0VQ8Xx3+oy2haQlFbzDi0708dBydPkiSWcmjvVbtSdQ+lDCRjsJ+q/n9Qyi63SqZ
q1jN8A7lC437JjkxiXSQk6k2YnzEfmvugaQYqWyG7J8pI/d2sG8sKPzb/OAEsz1i
B7ypZtt1QJFq5j1cR2C3FSXjvLLRT10PyE+FJGu98xDf8jbR5V7Ck7E6NzMgjgHK
syTZUCSxh5Pp0xIM4+qY1E+FBiBM/McbtQ9ewysPiS2uDL80/J75cm3q04VUpY5X
n3L6OiieWqOOtjqTFUHYqDIrSKpzkccEZJMmLcxoQAmUU53rIjxUGdhkmHGYEd1H
Pyz2uuFcUjWRa3/n2qlsvQloRfIKB3NubU0ocrSyXmKtC6nOfzxJUwLxn5wSAlL/
DubeVh8uZoUHZFUk6KeZv+X1qm7NNPdnTelYvYlV/v9OZKTzRzqkcDWP77IljKBz
Fv6OeDvRpe3UdMqCe42tUfzHjTvAmS0ddBdt66YYXqkh4SMcVEH8PDbhBRu3xnb6
MTZpoJ6mpc+PFvMalDNBboSrdfxKRgMZsc/8N+bv8DNLTJNdnKw=
=tfi7
-----END PGP SIGNATURE-----

--toi56B7oyc04/PA5--
