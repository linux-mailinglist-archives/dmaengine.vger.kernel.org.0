Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDB2ADFFC
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgKJToZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 14:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJToY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 14:44:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C750C0613D1;
        Tue, 10 Nov 2020 11:44:24 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so10667864wrx.2;
        Tue, 10 Nov 2020 11:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2daIxpcLg8hMHGC3zssSTtccRqZ4pNz/pS6PMgYIGMk=;
        b=WOaXAM1CzPI351KQb92BW6RsAzWDbwE9uBsr84igNXZL34gKxrtH4XLs3xJ3lRP9VU
         pxZ1UluCXiE8swzVTBx2f9Ut2euxeZK1Np+rD4LVnAa0ZYEo8zVLeaZbstL/JkH6UjtC
         CkgYxRfWiHWb9PIefP9l7Pn24977leXo/X3nLB7VTih976YSY+I1uDrkIbBv+JAbyU3d
         5GxQ6kcnxWWSY/uV5LQu9FVOjf2JSgZxjyS1FepXDdOn1nhHXzDcRUhjqxkWbbu59Upq
         vju+T/5kT+ApEZriRr/OSTFfELKyxT1iQo6A85CSbUvyWCs40n4QiT03GG/wHfb6YGL/
         sk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2daIxpcLg8hMHGC3zssSTtccRqZ4pNz/pS6PMgYIGMk=;
        b=XlJXA5+L/HCVyM1wX979pumgDkUJ+vjwn6A3jL75fwqcngZikkhyhY5pc56UcXh+xF
         9+x4v8Meq39V2ABdfLzOGKQT9lWznjL4Y1hlwAzCauHqX5FKRGCsi3jniw1KExkg2+WX
         8IQ6bqvSd0Tzk03qD2V8+7lz1Gq/6kgnbrytLz2w0h0kciyl87yNyMxJ+AuDMcEI4MwP
         dT147w9IVsSEXF7GnhYY//+NYyKaiMEJlLnoj8BERzVS8AiCN66x0unJ3HgAoJvX47a8
         rnNp9fEMVHMEP/lUSVI2nHg3mh/zPoJ8asthir4R5qb6YviAfc8rg/o/MxASGbF+mdsI
         mvRQ==
X-Gm-Message-State: AOAM533zg62S/dhPEY9WT+b6Vo/OgH3jboXBHiAjR3+JYJvD4WzJsB1h
        u711icOvXeqsExYOnPgPYgkGUEAXUM4=
X-Google-Smtp-Source: ABdhPJyLbXcP75ATf7F3uuCKViQN8SfGD+n9mkN6xAlTvfWP03y4YIrvxM9G8rcomNt3yiwOuWHNNw==
X-Received: by 2002:adf:f00f:: with SMTP id j15mr21777692wro.102.1605037463179;
        Tue, 10 Nov 2020 11:44:23 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id k22sm3952213wmi.34.2020.11.10.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:44:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 20:44:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, vkoul@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: tegra: Rename ADMA device nodes for
 Tegra210
Message-ID: <20201110194420.GC2375022@ulmo>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
 <1604677413-20411-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <1604677413-20411-2-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 09:13:30PM +0530, Sameer Pujar wrote:
> DMA device nodes should follow regex pattern of "^dma-controller(@.*)?$".
> This is a preparatory patch to use YAML doc format for ADMA.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q7ZQACgkQ3SOs138+
s6H75BAAnSNDrhSXOY29l82vtouUacMJjlSXsHVHkckIugrAUdNJh8/vL622Tk3x
0VOl+xcg+sgIUaRFqDqYaErgXIjzLQKlz4PdqQflUD7Yg8w2rGCcQtSfv5BJDiuz
MguvnRLgNALUAQU0jP70bOXLLO9+FMLh01WS8XrlAM5sf31EBJBtCBp/iHdw5hCl
hOuigKHMuVsro+KVPTELHUh083naKZRExG8ZKCu4QQ0/ZWR8D2KzIwdc1IyiCBXa
ZCzBRL1KHJd/qdhojWF3kZB1sRZg9nn7+AO/YanaVFjksG0eAijrmpOxd8+gF12g
c530Yy4nNZS+MVyAqqFDZNucU3FXQA0ybQmRmkzN4R8OCzi+33E5/S8+SLvWXkKD
Mgli7V5cFLO5qtib7pxyKAVTP6weie/dgOeLrsf/ktJPWyx+slwIXbFRhQ+zLbNe
3Ih1w3whd/jGcr7o/qWcKlUCbs2xeBFKNgqOY4e8xXUoMcRjf2eqQxx+Ct+04WTd
ftnOXMHZWU6OKYTI2ecTZcjYGeakraw0o9wP39xKMDiuctJZ8KX/tS8VHmgzXsyV
4H0JCdPpr7mlG9S8nK4SNnriXIZQMkcLM+8cDOTXdbVCwudJPSGlipXaL1CUI61G
PCZrVG+yCr8vdbua10V0ZkChcmtV4tqFEBgB/F4uK1dLuaajvNA=
=yOB1
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
