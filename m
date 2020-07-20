Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E2225B96
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGTJ0C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgGTJ0B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jul 2020 05:26:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FEFC061794;
        Mon, 20 Jul 2020 02:26:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d16so12230659edz.12;
        Mon, 20 Jul 2020 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CiLttDBw7yOBmSO3iZK+sga3eBgEOoGVcIYrCjxc/YE=;
        b=NAXXdHCpbKeZWffm7h6Q9EzaAYdJ4rr5s5qJ7Awj8r7YID3I6nc22/CBjjVnoYiUmy
         EQh9VQWbtomDr/ogMBDFJEA8R+gkxI4f1gPLEY8drpPXQgODbtb1rN4qdN2pudpV/3Kj
         mosD0Y/tMqtCKUJKpCkTMUIA3n6ggLv8Snd9lr2RbRiN4qJOl+Kq8WlDsTOHRSOkF+sB
         cbYIJZENLpdPnrv3Zs9b7jCmuoW55YCuTWLju4TY1HMTEMuyy5ehrz1a2Pbv+bcpMGjx
         esoVktDBwEhZh8FCJlOhKxXmMRGu+NMHXyy9LtqQb4trgdWcHyVyPhlPA2c3fkyEx2tw
         2V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiLttDBw7yOBmSO3iZK+sga3eBgEOoGVcIYrCjxc/YE=;
        b=eZbgxXkp8Tu8uU/zSRJTpCRw/unI18p8gy+S+UR6ss1x9/JzzatX4YkhbD+boz1BxA
         b/av50g1jR8W1WYTLOQHuSi61Cg3kBgFmzvWFmtLffzuNy+0UpVFUyFPuKKdlj3S+M8U
         S989VRPMgFU2WHjlVurd4Udum0+H4/Kj7ei+k/OJ+/NMuYdtlw+aO91bvCJyrfLVGZJl
         bywDZy4esV1ssKs1/XwhuN5ndsOylVZ8mqVQz794CZ5HV1i4It640OyxCHCbYpE5voFt
         oNSPluwkapY+VDfOFAXvMaB56ye+xRzFgC6zWsc8rjKj4B5piJ/f9fkaSHkc8May4zAP
         W6WQ==
X-Gm-Message-State: AOAM531yMFiEXrGxCSfrIF2PZqcR45fGCrDFZmquSxZxmXukhfpr8+hT
        ESIRG38fBaceGEiSHpe/B+s=
X-Google-Smtp-Source: ABdhPJzXt9R4tT48JqmdVSedCQBJigP8+gs00JQAmUN1UUFQasyJneEZ1Jy2WKkykbwmoPDITj+jrw==
X-Received: by 2002:aa7:d848:: with SMTP id f8mr20354162eds.329.1595237159980;
        Mon, 20 Jul 2020 02:25:59 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z22sm15246250edx.72.2020.07.20.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:25:58 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:25:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rajesh Gumasta <rgumasta@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        dan.j.williams@intel.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com
Subject: Re: [Patch v1 0/4] Add Nvidia Tegra GPC-DMA driver
Message-ID: <20200720092556.GA2141917@ulmo>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 12:04:12PM +0530, Rajesh Gumasta wrote:
> Add support for Nvida Tegra general purpose DMA driver for
> Tegra186 and Tegra194 platform.
>=20
> Patch 1: Add dt-binding document for Tegra GPCDMA driver
> Patch 2: Add Tegra GPCDMA driver
> Patch 3: Enable Tegra GPCDMA as module
> Patch 4: Add GPCDMA DT node for Tegra186 and Tegra194
>=20
> Rajesh Gumasta (4):
>   dt-bindings: dma: Add DT binding document
>   dma: tegra: Adding Tegra GPC DMA controller driver
>   arm64: configs: enable tegra gpc dma
>   arm64: tegra: Add GPCDMA node in dt
>=20
>  .../bindings/dma/nvidia,tegra-gpc-dma.yaml         |   99 ++
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/dma/Kconfig                                |   12 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/tegra-gpc-dma.c                        | 1512 ++++++++++++++=
++++++
>  8 files changed, 1719 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gp=
c-dma.yaml
>  create mode 100644 drivers/dma/tegra-gpc-dma.c

Hi Rajesh,

can you provide instructions on how to test that this driver does what
it's supposed to? I could probably figure out how to run this with the
kernel's built-in dmatest module, but if you could provide a set of
parameters that you've used or other instructions on how to validate
this it would greatly help.

Thanks,
Thierry

>=20
> --=20
> 2.7.4
>=20

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8VYxcACgkQ3SOs138+
s6HStBAAl7MTbsKWtMWdKW2SWSsxw6tyr1UuYJ1uhnbPdtFnBsmk41jHmQ28PUCC
qaA5Vqrge9tK4CMvblYQWyZ0hCfa/19A0fq4S9naRX0JlyQuNgZlnBfTWdBdVof+
kVTiTgJFmZ750fGEXR37aA3un0nXPrpai/Xn6ILBXxx0pyb6H1b5NaKbRAVys5lR
9BwP72HAgbs9yAQmc3oo1Id0Uh2FJdUoLk2ZldVIbWcTLBzefGZxNQOaZyMQuE3d
7yyzgQA6278biQhQjwKYfp6zdmEXl61BJKl8Jf5L99vgCLPvIw2+cLtlhGLX6svm
kgICSknw1s+M7/f5Nh+6LqhgOVv/rMrMcSMwMGrLtaSIBLOHwGnmH/7/JFjGBEL6
jZ91eo2XVZbRkNv73fp1xkbI6BKfgaFdZcLcjZPYIss3ZBfXCUiyAHPlE2B819cB
fnDg1n71Vo99WKdt4OA79bE8TEIsAhnl3Kgl2KHzZaETmbKMblbZms7BguvcQbp9
r3XNu0ZjNdRtMNm63wuHpKq8KsWgVGp5AMJnmygSQya6RmxtBbmVc5STVoDawQGu
ffYfHXg8oBULPkqfSnIU4kUgi222MJ9SgtW9Rz5gGdtzafBWuzZyl+ivl/Y+/cYa
QDLODVGYrtGhhmhIYeAfswQ0gx7U7yUrn8OZMqzIb3fkYCELC14=
=sOy/
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
