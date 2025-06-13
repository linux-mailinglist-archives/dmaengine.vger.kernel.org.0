Return-Path: <dmaengine+bounces-5458-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EBAD96B7
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8743B198F
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB223D2A4;
	Fri, 13 Jun 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWrgLR1Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894424BD1F;
	Fri, 13 Jun 2025 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848359; cv=none; b=Y4m2BWWmiKqL3qwjgh1zy87iIpdouLOlZRbimFn8C4RkDDGmgqgssDjSZXTTv2yu/KcrVfU9PRfpJZySuQ8VAAoACkn1sTNEuH0RH8n7sbU+lVdIoE7JavfnN3jOnWjJZi9Lxys/93zui09BgSM7m7kazf4L3NMXl4PV5YtenM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848359; c=relaxed/simple;
	bh=9sNrDB0jmBUMVlARrvIUilvC+pD17hNc0WP/9/iWcNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwNY4EOFz8mTyxXElmb5L3aEH37A9ZC+x8wWH1U9lF22sIjL4o1Gd0laK7OOZBqCEI63VC3bG532uX9Igi4G3eLkmgueHXzeuRRaVtmkYHiUfGd3Xv1eug8EnBRQVmhedq6lYY72+j8MLemPIstgzjbcXVzAz4ANYxp6ula+PoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWrgLR1Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so6582018a12.0;
        Fri, 13 Jun 2025 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848356; x=1750453156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b/EXX2jmaRM6CzhqmZwzRo3HkKllhhYGwILo6M1gzM=;
        b=GWrgLR1YJuhb6sgqLHBXCSWvbTMo3pL2fQkSinbjIZ1abyIXsXHd1pOrZ1/wyeIQug
         FwHqSeakuhumvx3rqqimVXXN+6PBOxILglaQv7GFRD5y43xXY6RdRE+/czH7FItY1Z2k
         Q3BmobjTuZhAl4XA23P05L1/vxyo1OJP9EqtykYEqeDobxbHY5IVA0TojRaBBDw5NjU5
         sOaQnl84g57uOc8LNIZqNghHgojcedB7Aoi8Qjio1kQUt5EdZ7SBOIEjafSzUQkoJHkw
         TZuAqFihd0RC3O5hswL2/4HxBEm4yws9cdwuPCgi3XCW51SXRpCS3/PWYPFPGoX+IY0N
         px6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848356; x=1750453156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7b/EXX2jmaRM6CzhqmZwzRo3HkKllhhYGwILo6M1gzM=;
        b=DHMomGTkbsBdNLswfgGd3u0ffg8QTZD41KyHr5yb3W3Y1Pk1nQJpy6EiD+oBFt0ffa
         fNOz1B5EFYc7MvHZp3zPvJxHQ36tqtwRq8nqLN+YkqijN+dPDGb5XNV0hFrJTVIWBGYc
         +TPQ3DOv9FECKgjyOZBflZVDAeT8iI21KSeHdSjsQRsKNpB6YQ3EbuQYh3GATfvT0Q9F
         O9UpDN8E+GfOQklQlVMyDJ/e+6KnXZSaPD3gilyxyg7x7Qkuub8OvxNaKg7h/xMmK2+q
         BwMlCdYRXtd4V+gLF9y3LIGIqTNEz4+gp63wmEJm+sueDngHswJ4qw6qRDIm/YH6WbJ6
         HgVg==
X-Forwarded-Encrypted: i=1; AJvYcCUCqLnjdRUUtSj8dDSpCTw7RnLYSnLzeyKsmXthZ5rCbUAd4tlHJ/8QldOJg32g2JPSJPG7ehvEQo0=@vger.kernel.org, AJvYcCVD/gaTAzWXzcSHbx9/zTdKD3RQX6clZ/IshTACyETpLATxFI+HFc4U0c8qh2Lx56aOAO7XqmdypFSiMJKu@vger.kernel.org
X-Gm-Message-State: AOJu0YyJm3WwUwUFNl9eqguqEe2JjIuqy3dO1yyDqevLFFVnnySiV+Ek
	00avbwhj5d4xCEynTZWnrQhu4CZa6/Rm5M2yUxpqZQ9ZDb8bS2BzlFyWBltGfHiJIBhx2tF/ZjJ
	EQO8b04xvEO6UI9wnzH/6Vt60wDQ7cmQ=
X-Gm-Gg: ASbGncuISGnVjPdyvWI5+dB1Vp/ngrggBQPWSTGJ4anF6nKCfaVevafBVo5xqAZgKjS
	95AlyEQsjSfXgvYiyDJqbnJotqRO1Jqlwcl4sKbu+dUl2DZSBGfBmMv1NgGDNxCE6rBYFqL0F14
	4kslOhb+9eJjAbI4TpLOhlv/6VWjeLrfMOh4Jr9KWuvLs=
X-Google-Smtp-Source: AGHT+IHCwk5Rp9fyAOj1DE9bFxMs+f2euTc22CwFOZK2idkL0LVp4RLMmh2nVpyJu8MOt93cqgJ/9yySyQY7mBUwiA8=
X-Received: by 2002:a17:906:ef07:b0:ad8:93a3:29c2 with SMTP id
 a640c23a62f3a-adf9e2cdfdcmr106941566b.14.1749848355448; Fri, 13 Jun 2025
 13:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613143605.5748-1-al.kochet@gmail.com> <20250613143605.5748-2-al.kochet@gmail.com>
 <aExS9WB0Ussl4Lec@smile.fi.intel.com> <CAPUzuU1r2xmJyG_Ke8pAvoZjJdvFwnxUqv1XQH7PrW3e3PTZoQ@mail.gmail.com>
In-Reply-To: <CAPUzuU1r2xmJyG_Ke8pAvoZjJdvFwnxUqv1XQH7PrW3e3PTZoQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Jun 2025 23:58:37 +0300
X-Gm-Features: AX0GCFvdKl0e36ZNjYrjm7uI5HejcYS-x8P2hEkUg6NkcVrXlD7FTrJu-nT6PsM
Message-ID: <CAHp75VebsHinU=UwvSKeGkiwDymgfPKZpc+cwFm_KsRUvAcs2A@mail.gmail.com>
Subject: Re: [PATCH 1/1] dmaengine: virt-dma: convert tasklet to BH workqueue
 for callback invocation
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishad Saraf <nishads@amd.com>, Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Paul Cercueil <paul@crapouillou.net>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Andy Shevchenko <andy@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	=?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Amit Vadhavana <av2082000@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
	Casey Connolly <casey.connolly@linaro.org>, Kees Cook <kees@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:51=E2=80=AFPM Alexander Kochetkov <al.kochet@gmai=
l.com> wrote:

...

> > What about the driver(s) that use threaded IRQ instead?
> > Do you plan to convert them as well?
> >
> > I am talking about current users of virt-dma that do not use tasklets.
>
> I think, I've found all the users of virt-dma. Could you, please,
> provide example of such driver?
> Here is what I did to locate current users of virt-dma.
>
> I got list of drivers using following command:
> grep -r -e 'struct virt_dma_chan' -e 'virt-dma.h' . | sort | cut -f 1
> -d : | uniq

Side note, `git grep -lw 'struct virt_dma_chan'` will get you the list
much faster and easier to remember the command.
Same for virt-dma.h.

...

> ./drivers/dma/sh/rz-dmac.c
> ./drivers/dma/sh/usb-dmac.c

These, for instance, are not in the patch.

...

> After that I did following to find additional drivers, and found them
> inside misc.
> grep -r -e ae4dma.h -e ptdma.h -e qdma.h -e dw-axi-dmac.h -e
> dw-edma-core.h -e dpaa2-qdma.h -e fsl-edma-common.h -e hsu.h -e
> idma64.h -e sf-pdma.h -e st_fdma.h  . | sort | cut -f 1 -d : | uniq

Same side note as above :-)

> I've applied the following config to the kernel, to build all the
> drivers. I've modified some Kconfig files in order all options apply.
> And checked that every file in the above list builds successfully.
> Some drivers have compile errors, unrelated to virt-dma.

Any pointers? This needs to be fixed independently on your series.

> Some drivers
> produce link errors, but compile success. I checked that each .o-file
> has a reasonable size.

...

> # CONFIG_QCOM_ADM=3Dy - error: assignment to 'u32 *' {aka 'unsigned int
> *'} from incompatible pointer type 'phys_addr_t *'

Have you tried to check via `git log -p -- drivers/ ...` which commit
brought that?

...

> # CONFIG_FSL_DMA=3Dy - error: implicit declaration of function '__ilog2

This needs a log2.h?
However it seems this is defined in asm/bitops.h for PPC. And it's
only a single architecture which does this interesting trick. Perhaps
it needs to be fixed differently, i.e. making sure that code uses
ilog2() from log2.h directly.

--=20
With Best Regards,
Andy Shevchenko

