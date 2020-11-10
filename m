Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68F2AE010
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 20:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgKJTqx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 14:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTqx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 14:46:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9AC0613D1;
        Tue, 10 Nov 2020 11:46:51 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so4344660wmh.4;
        Tue, 10 Nov 2020 11:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WTBG2ZdbukfpbLAFWod/tzgmxRQ21477bkwpPdT+kkA=;
        b=ejYAtvp/QgXqcSWt5piAvD3gUGUypce+ToGLgTBeYb3kQrDx4QDdJ7n/kfuJU1oUEm
         46DqkyD5bGBhqsidJejsK6VOq1ivrdI2kAQiiLkIeclJVpQVw7dV3Xj3VN+YRw35KN9+
         dXF9S1MrC9XtShsceO7GRVzdsxadFv1UBqO5ugjjTDAdmn3L0xqKI6xX3xwYHeDlTIcU
         ohz9uwjsIJyUjuq2hecrjlFf+NW+KwYtZsY3K5IYOL7h0Hk+sKiVQJdCo22RfW0YJ17L
         wZgU5XWNDL5RWRRDxzpYnQkjqW0AtUHDNc6MR8CuTSE+i2mB+4FIqRKT8/fYh9Xnzji8
         8OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WTBG2ZdbukfpbLAFWod/tzgmxRQ21477bkwpPdT+kkA=;
        b=DcpcgjjIEUe7AOKadknm7Hb0sRyvvBiufuZHD6EMCx5IEJv8oy1xyeZyWa+99JPb15
         sFFBYy7tC2rEF7HF4GtMTZWtczYOTkrG59kcXAZ6q9hFOTTyjhOzQFq7YrHmCSuCDQdd
         kNGbvSAfXeYuO71yQHkxE5EE4L8NDIFL+CsIiqfzPkhmDHp1qMAVZraOxxECHsQkXYiX
         qZ4M3ub/omk6c7P2joS4115Q0tZ68z4rHZ3RTY6lQWRBhv2fqS6gWZ0wcx2UMhF9wJ4a
         ww/SFIBHTjRPVPOHhWNb80L/SxfiUHKFu+98TmHRiUiG9PBxHlmkllnDrLJEOjD8vJ3Y
         vwmg==
X-Gm-Message-State: AOAM532RMweNM8WMknzeK6ZBkviu3gLlk3c19D3FrgMSaCl8XWQEl6B1
        dw+niz0AiDqQURncfDKF6cs=
X-Google-Smtp-Source: ABdhPJz6ClNJXWYzdMmkrWoo+e61xxaZ26dNP24KcXtgegEXwhKlheKjzqMYIiu7+SgEJctp/Kjixw==
X-Received: by 2002:a1c:6654:: with SMTP id a81mr851164wmc.104.1605037610202;
        Tue, 10 Nov 2020 11:46:50 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id f2sm19470517wre.63.2020.11.10.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:46:49 -0800 (PST)
Date:   Tue, 10 Nov 2020 20:46:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, vkoul@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Message-ID: <20201110194647.GD2375022@ulmo>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
 <1604677413-20411-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <1604677413-20411-3-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 09:13:31PM +0530, Sameer Pujar wrote:
> Move ADMA documentation to YAML format.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra210-adma.txt          | 56 ------------
>  .../bindings/dma/nvidia,tegra210-adma.yaml         | 99 ++++++++++++++++=
++++++
>  2 files changed, 99 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210=
-adma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210=
-adma.yaml

Applied, thanks.

Thierry

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q7icACgkQ3SOs138+
s6HywQ/6A5vikJVE4mHLrHgH7Qk0o+iL7yHxSHaWvUyeQn31pqBxV/kvmX4OecwF
DMiWmtIX4pGOKsMYZwZVrSrwBcpeOSFHQJDogLN74dnWjUGTnUhZub9bsiU3M8d1
fMJryvFCJoG7MGUU0bLYEZTZkU5IjQMCA5hWA5/zNLPmlxhxDFtd/hKinYjdGkvu
2ChX3XL0ySIu3ZhzA6bMOizpxvKwgXN4Z80+KwY7uA7Jahp48X1a711pKUSXCAVU
89tyOmvgAcjnFsoXcHJ9bhAX1FEbP1QhOtMBtGHKKrY0NCdLdh53tdWf0yJZK8iY
mY2acuGUoJZzUoEqlN7rGTLWJw/TyOZ1qCgRdQT7cfgpE0s1ioHDFjOXtdA2mjhY
E6b5ySHmwmCqqrFLAo2rcwWuAkeygNcpG7TMkhRSySV+AYrgwlYYkIKEFiy4E4nI
09SQmNap12K6hO0KVm34DFO00FSx7kx/uyTZ/aMQTBiUHFJZ4XXqCHrOcVTaqg+/
cLAd3+/wq2ZySYOM5ezS1sEbUNxivuQqdltWIA6gqhs1iNpxLDBIgAp8eMk0jZtV
na2ZkK5n20/pKe0HsmP0wvXNke7KY8dnk/1ybFLlsXmN4v3IVOyvvDLck4OK9eC6
+X3ju5PCWiEhttC85ohdBRdZdKNggQYrghEzkQTuCf8/8EAs4Ps=
=rKPV
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
