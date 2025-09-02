Return-Path: <dmaengine+bounces-6328-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32876B3FC08
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929E11B22CC4
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EC27FD78;
	Tue,  2 Sep 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jru7JPJ3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E42BD11;
	Tue,  2 Sep 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808311; cv=none; b=ES1nHpTjorOZWxo95XhMslvM5E8/EbH4gSKZeGn+U0h7GouVZXhxTEkCsFMu6kXVq+nrUrUppFooWsZ5+SbIvyCCVfu4OtRlNwkLm5G6XbRl/BZH20ZK+7Se3GoXWdOIZWnlLMGRt6KYfPhypS5+0iGZN9Y7fGE3+QQqq52ppKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808311; c=relaxed/simple;
	bh=PjXtNs4YC0h6LPa+dDz9PICK9+YC6sQvJndGnb44ANo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPZc6ptezg8K9d7TQlkhrFEyF3bNwnmFKXWYvgnOaUxn076sUv6wW5VmLtw7EnvSxOi6Uofd+Q6FoeP/3o4V73NUPZOsUaZHVsFCQGzmYhX8ZLCzFdsqp+fikFDOPi79E2Fjq66QnPzDuYhFb3P2Z8JPfsW3aSMjIY6UncUMlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jru7JPJ3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cceb749d7so2285859fac.2;
        Tue, 02 Sep 2025 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756808309; x=1757413109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjXtNs4YC0h6LPa+dDz9PICK9+YC6sQvJndGnb44ANo=;
        b=Jru7JPJ3Utm5elfuE8rhx8E1ClcWiikuV40Qx4G6zGv3WklZxLNF2MOrGMQBqLisDh
         +rl2H+gWBuythGQEuc3uTVZDEVmdIIecjJ1dCPLG9jGe0IVZMq5z5pp86gtxTWLcnNlt
         wINNPEgxJY92lraLQSVBqA+lDTixo8ZgEJaKC4wkWHOFM0XpucVTWAatQc57GpNxDj7J
         lFNZvo6xYr3LimfBl/3n3NSVUssQKpYP+a0Ih7Gr5vA8DOz+13j8fKkx/p6rJWASwEDQ
         wMAw21K3Kl6NMCY4FxOTIyuYdfTTjo3eNVv4Yj6ae2Q+v4BIL2AOxpdN5f3B5TXeVfuR
         ChAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808309; x=1757413109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjXtNs4YC0h6LPa+dDz9PICK9+YC6sQvJndGnb44ANo=;
        b=lwc5+tloXd31OoR/XqKS+Jye12HZgT12zOjbR7y0mF14BwgQlawvCZ7TvjzBuoSYEi
         8ZtsMiB0bM++qlnUsVUf1QgxQWuMptcbKnRif2OueP+uk0gIp9Zq9NNd4MmRTkw2dMbZ
         6Dki8SvfK3jMd7+I3GxOjoDq8BlaZ5zxpGBuIusOq6N38O2HB45M95503eQv6mepvCzk
         zywl2eaheyMdZoXwmGxhZ4+BaAT1iI0lezcREjB5Ds3Dn8NK8LVM1S9PXmN4xgneP8DK
         D927A7HDpFkoZuqq0M2YAXYC3YRlQ3EZMjJoSVhZHH1reHvyHUAWtLHjIJS2CIGQMnhd
         WzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDheCmRzPsQuI0S7Dh13LZ1goD4zfs4X67TgnONg/wKcaaE7rgmrwwSyHLQkcYylCW8EA085MnSno=@vger.kernel.org, AJvYcCWag/YSGFlx5qLNIQA05YkoWKGa7M/ksyc7au6pHXJQUiqRCYydFTg2oxzw61TZdCAg+Vphq8uE@vger.kernel.org, AJvYcCX77irr1op/cPU/JF+ui+bsSsfx740YfDnPnkw77mPBPShBEXpuX2Spfh+mm2rZR9ROwJGcAoTZa641RcXJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64JNe1sqcxiXvNxjHgFmAunTTdJCV5Iqf+JC/AYOwquGzC4Ms
	htKDO2FXQ6FTB1YZbYVi6M956u1FRpSJthr6XVbpS6ZkQRq8rupWkS9+kuxhb9kE8aJQWOXiIkD
	b32qO6r95Tz3RMxewzjwOoeb26/EzGIkjpqzd5pG57AeV
X-Gm-Gg: ASbGncuwYWuT2vGCh+U40+lZqaVT3bIiyxe5DF0BYWoOmCo5qapdrrZ9NQ3glITu3Y/
	pG72UrIpKwiU7VWxQiP75Fy/z2Hgg5XLXsxNBv3Qf+cEy/w9QKO2BZkY0DWcg8axRbjVhge9MzU
	yubNwpj7y5cn6IXZKp3dCliQQnKOk9I4tCEKwrh60RM8n36K3jRn9iN52z6DGWdnaLdr+326+4U
	K25D9yaF2IPMNbk3ostOyhlwZD4IiHSWU5m3zA7r6Qd4COjyezBVJSiy1kA
X-Google-Smtp-Source: AGHT+IHoluS49sv2nmukgbWP7b6FwLDU80XzZNqePYwnL4R81omyy7ZLB04xXF8Z11RXpv00FnASkGTMAGF/3on9KEQ=
X-Received: by 2002:a05:6808:1c0e:b0:437:b10d:3b41 with SMTP id
 5614622812f47-437f7cd6015mr6495068b6e.11.1756808309372; Tue, 02 Sep 2025
 03:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902090358.2423285-1-linmq006@gmail.com> <aLa65t3j1tmyEMnp@smile.fi.intel.com>
In-Reply-To: <aLa65t3j1tmyEMnp@smile.fi.intel.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Tue, 2 Sep 2025 18:18:18 +0800
X-Gm-Features: Ac12FXxIvP7QcAjSDmmTAhRVGtyVzkXNIVP0hqYtHKZDRDb4VQaUEK2qgFnAeco
Message-ID: <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E4=BA=8E2025=E5=B9=B49=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=8C 17:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 02, 2025 at 05:03:58PM +0800, Miaoqian Lin wrote:
> > The reference taken by of_find_device_by_node()
> > must be released when not needed anymore.
> > Add missing put_device() call to fix device reference leaks.
>
> How is this being found? Do you have a stacktrace or kmemleak reports?

This was found through static code analysis.
The of_find_device_by_node() documentation states that it
"takes a reference to the embedded struct device which needs to be
dropped after use."

I cross-referenced other of_find_device_by_node() usage patterns to
check the correct usage,
then audited this code and found the problem.

I don't have a stacktrace or kmemleak reports.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

