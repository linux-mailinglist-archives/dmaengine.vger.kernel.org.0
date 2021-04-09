Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B7359D80
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDILd1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDILd1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Apr 2021 07:33:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D290C061760;
        Fri,  9 Apr 2021 04:33:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p19so2758631wmq.1;
        Fri, 09 Apr 2021 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=goQdzeJjJr8DcKUAFQmgInMOHFDCEBHvhVv3cGUH6c0=;
        b=jsR3HZJ7EnnfRnTXfuKFcQ/leSS/4ZBmClTEZYviDj8+V4AX1awRQs3A4EvL9rrtcm
         dkihyje7nFcm0Ei6xigNFmL9XvFAQtyPWhnVX6cDbf7LU2nrl3GzK6zM9cN8nR1+aCIV
         LzFyTcbTexhBTs5lJKsDDlqvAsHPYQCozaIGyRL878zwMn5Ktd19JSvM62b/bdj2dq1U
         kiEzHXt5tC09jbBR+wCmI//UA9g3qYuUJsBukR5L/HhSTVlLBgzkH5gqX8iT8NkyMZSU
         Lx6gUMpQgLn7FupvGDVtUAUkKIueIUeQcoFtriUwLE1qv/NBjTrtBEZPlKWRHa8MyyNt
         +L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=goQdzeJjJr8DcKUAFQmgInMOHFDCEBHvhVv3cGUH6c0=;
        b=WJOTVPtqr4N4fe9sQU6i7RK+VfJpKUxrv2VoOVf4et71BIeakLLl2Lew9rGFHIWU4S
         Gp4vVVuHvMfqZlCw5bKZfH9zpq3GY48qDjOALoS2OBPTyl7xca1NCss0PINp29aso/W6
         hijBr9Z2ZIZZeL/glbDC1bW+bk2LI0ZhBCA47rHmw5LzXl60CoencX532+qZps59WS5a
         LbWBaMc5nfPZXZozNMxWuCJewnbE73DRxahnFEqhQMDQNuhKZt2dPzda+DFD95Z8h8e9
         qlTWm3Zrtg8ztGg8krXNOMDzV2/Df16qIFrbrsjF22rdg9I51HIancA6jXykFQGM2d3o
         qi2g==
X-Gm-Message-State: AOAM532hBDj3Qhi20nxm0pjwxXkWF/MMt9gSmScAZq5O6/+ZVH4iNE0I
        C/Dbx0bnX9beAKkg+8Xo9ByyMcaAlFg=
X-Google-Smtp-Source: ABdhPJwV26fPfpaHepLj3aAzlxUkj/SKn+tRcvBR42PcRXQWMGlewwtMEPHHWMC2UlLi64bQ+lCCzA==
X-Received: by 2002:a1c:2587:: with SMTP id l129mr13277135wml.135.1617967993264;
        Fri, 09 Apr 2021 04:33:13 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id c8sm4635949wrd.55.2021.04.09.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:33:11 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:33:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: tegra20: Fix runtime PM imbalance on
 error
Message-ID: <YHA7m3U1LsU3iKFZ@orome.fritz.box>
References: <20210409082805.23643-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VC5y8KNu2JhZfYaC"
Content-Disposition: inline
In-Reply-To: <20210409082805.23643-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--VC5y8KNu2JhZfYaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 04:28:05PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>=20
> Changelog:
>=20
> v2: - Fix another similar case in tegra_dma_synchronize().
> ---
>  drivers/dma/tegra20-apb-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good:

Acked-by: Thierry Reding <treding@nvidia.com>

--VC5y8KNu2JhZfYaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwO5sACgkQ3SOs138+
s6Esrg/+JE/EsuV4zBy5yvjs9DvWN14VjfsR1vMV5/yCwXPuXhP3qh1sgT+2TpKh
TGkSo8wl2QRZprRFsk1nx+fp453dXYqZZnrBCLJysCr+yWuFGMrTf6vHFsSeVC02
ODwFpOlDsbQLygpL4OzYESaecRh8uKfiqlVq8RTFhh+eSUW8pYcGn7cDRvSCgRf/
06NI+LfpI61JOICaMn9FD5AYEN8lhlMPUB0VxgP6H3FSw2kjJTwAD6UHTlWjDNdY
daMskGXzPyL1Ids3KK14oRgVSkB22qwBxBEBrEqayv9XrZ6yewuBfvRb+0VeArD2
B/gmrNXoOMxdZXQ8ZQWfjB58zxkMF9b3UeXjneSwqwfMqtz7YUHPvMBnVWqM30B4
BVQTYuVoekiz1LEFxwXVmJxizsrJWhyOG7oyrfAwzewWdi6Hbf/B4h2p0bOJMAps
nMgn4RoIS0W9fuVI0B8ZjXDLpQ3RhA0eO7Tvg8qljaYOek/dFyMyv9gnAW1twv9r
rUNeEqUBA9nTz/ZA/fFaLcwt9evaRgqqCL2OaGU+Fyu2+Mm9pBRzp084Zb5uBfpO
7pNH5pIcaYb2rbox+5TsxLAjRdAQ5fjZMq5Ke6SPl4GmzAT+mRYcGSJN+HnXvt3j
bAD1EflM/CMQTGVQcmwLcDqj7RQKVCGARwpoq0r0XC5CYsUa4gw=
=j5Y6
-----END PGP SIGNATURE-----

--VC5y8KNu2JhZfYaC--
