Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB521D9C75
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2020 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgESQZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 May 2020 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgESQZX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 May 2020 12:25:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA6C08C5C0;
        Tue, 19 May 2020 09:25:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so76658wrn.6;
        Tue, 19 May 2020 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nM06eYScX+XNokoAV7+9FvMc5yktmL9LEFe0oZB9L9Y=;
        b=KuOCfHiLtLqcY80YA+zJqExocYmA8ZcpYRP7snwL65qx/hbvURsliycG9heOxO/fV9
         3Fy8c4PR03P7tJFeX6QBgSkJqs9Ox3G8ZiJorzGDmj/Fm28CAqn80qZMPVt6IRhK5NnR
         XIz5wtA8TfBPLSt0N8XTk3m851XhAsb7wmGNNDnzxVgBLuv+uWSVQeCb4cFcPQmReL0o
         R4LqUkztD9SW7JXk6ISHBZnchT+LNFVEeoY62cVM18Yh08LQM52fQ8Amxaky1vH5WZgj
         kUgXE3/gIcS28w2cvagnv5hQjpJskXkFxORXhdE63CaThtyKjsF4N6l8RTMBv8P2LOmA
         ss4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nM06eYScX+XNokoAV7+9FvMc5yktmL9LEFe0oZB9L9Y=;
        b=qaGsh9aTlJbs21Dhzvzyg3LkSC9QHZszaOvZpYcOWM88laBfxBkR++crbVaa188DmI
         7qvmncPxpINhfqCqAnIN6/bCfZmwZ9KkslsZ7pQTr4XWO3theqpWpLTW6rQ/mG9A55+c
         139mLREEsCJoLZdMuyC3DtfENahMOkwlMOnr9ysp2wp0d03m0Ntny30kj1U7uId8SiGl
         XFEC4ARCxFSujDO91hF96l3+KYy2nKp7LbogZ2HodpyCvq01/vyOkU3kc572yFq5v+vQ
         ueHaPInQEGa3XWkc7EY9Fkl1avntFn66J+xYFhBgizKzN03O4AweEoLd/I7c4HzfHJt9
         /6xw==
X-Gm-Message-State: AOAM532mt5X0llN6pIzlKw6dGbdPRshdyB81sBh6ONfc+C0JTmj6SEek
        kf/7Td09/9wgbwtwVenh/RU=
X-Google-Smtp-Source: ABdhPJxag+JM0bTEClmR4Am4vtfn8gaUpVvbku+9BQ3YhxQkbmBNaa4vnCEDKCbL5TbA35D/8bJsOw==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr26271344wrm.126.1589905521923;
        Tue, 19 May 2020 09:25:21 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id l18sm206371wmj.22.2020.05.19.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 09:25:20 -0700 (PDT)
Date:   Tue, 19 May 2020 18:25:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix an error handling path in
 'tegra_adma_probe()'
Message-ID: <20200519162519.GE2113674@ulmo>
References: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20200516214205.276266-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2020 at 11:42:05PM +0200, Christophe JAILLET wrote:
> Commit b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
> has moved some code in the probe function and reordered the error handling
> path accordingly.
> However, a goto has been missed.
>=20
> Fix it and goto the right label if 'dma_async_device_register()' fails, so
> that all resources are released.
>=20
> Fixes: b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/tegra210-adma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7ECG8ACgkQ3SOs138+
s6HyGBAAtqw2Y28Sav7FpIgNdlgPeJGBIZ8WuLD4zojjs15UzXAuuHndZNzOR1xL
dJSZvlK1T2GFmmtHmzjJJUtng+A9GDFJD8J6UeKOdpy6eLlmvtRT6hCueljrJGOb
aKdGNRnFBoDZ/DqBArUILTkTgCdqHY66gacajY7p42DHGr7RxovPr/RNjzblE4Ae
7uA1CEY9Hqs3Xu7P5Aty3UhFh0cubPGCtMRnW9Y9hvyv6XSWIVnzAUwMiPJGBNLg
pn3D9WeK970Ef/QEvkRCWNW4mpM1dfiHmIjbjcFRwn1NvuTI4A1MukWzS3/Qbs9u
SrLIquFBkk+AtGNF5pPW/RmKOFTq+6eDaMEArLVuN6G6MNrS2xCE2mN2hb1arBAH
rV/7Sc+H/FfEWjXtRSnf0JwZmSKB/rObzOyPTAzERwKDNTVU1XDuCWSjlAv9A8e/
7TLFcFueYmMZO48jvdw1NL4u+v2kf0rWWzcyNBVeukTSHrlNvT+jI50fJ9omb0Bp
RqM5CktLjENleIelSb25TSFRjMB27w703QJdRb7Njr/iDw65wrasz+q8dqGCJLJQ
AFqb5peekfnhyQcHiYqd9cU+FYXnk+UJNUv3uh1T+JWZM+ec8NbDJe7v1JpTtWIY
2Yw4rtrkVHfL/mqnKkFzPLziFy72mrh7IQ1bHHx9CyTibg9B0dU=
=TqZK
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
