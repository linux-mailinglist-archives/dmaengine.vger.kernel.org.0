Return-Path: <dmaengine+bounces-5517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068DADC924
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77263AF029
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688132DBF5A;
	Tue, 17 Jun 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhm595OM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF62D9EDC;
	Tue, 17 Jun 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158838; cv=none; b=kYWjfWRvk9bTVQTFHRChaDFF6KGF9FdPsZX+eIMRlvvZRI4dUalipJbmcl8guIVH/gN5yWXl5NprV3PEjpIRLpj5GZ49CX0R8xcyYZsEvXH6bAtkZBslQ7u+vcYU+ZgQSVk+sMniL9uF4vbvaT1mczCvUJdko53vYgq2/VisBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158838; c=relaxed/simple;
	bh=MaHmR1wGpP7LZPIK4valG9ewGY6JUMEQrt+gAuQR41M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3P3xUmAZIbtUGPsLW+s1an74UPLSu1h/8Av2C4K2fcgAZGgOn26uC+C7cgAdmqyHruwK9fUptIdAthmY+ckj2HKj9z+h+57dwJEK0mns1kunZJtL/wkT6ygEzr3M8kkjLWEAc4MabeKJWf2FdKY6ZhoDQay3UunRUH6U9xtItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhm595OM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so818381066b.0;
        Tue, 17 Jun 2025 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750158835; x=1750763635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaHmR1wGpP7LZPIK4valG9ewGY6JUMEQrt+gAuQR41M=;
        b=hhm595OMbstxJ285u8q/YOBbmdP+HJ8+QTGdhNMOJdNTWuVMojTP2DyIyQkePp7cmm
         kb2IJ2nU6ecr7PjkrbUQLABggbXF5FldLa+UwmG875UrG1R9Fwe3ivsXZfMFSfp5WRr4
         Nmk5GvInkSK4sPRyr0yz4AN0TTJ7wJXPGP746GBOoSA/+/qUU5Imdr/lNR3ZEgjNyF7n
         2v2J6mxOha6tQP0vw+S1Xa0ZqRPGFPzgMYv1uPyt/pY2qn/OonNPGVUmzgU0XbXREdXg
         J7Wx6559AKLEUemFRREFh9H+/LxwSjxb/uOn3dzSNXD8UvgeDv0wZlg9Tv2YJYeupqxy
         gn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750158835; x=1750763635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaHmR1wGpP7LZPIK4valG9ewGY6JUMEQrt+gAuQR41M=;
        b=LIVYKv6T7MRlzBTxHtSdzoEpaPaVCl5FxbLHIfe8tjHZDCQPvdA5UVEsbdcRa2BKyR
         PDkQFEmqS+3O6LJYrcGapaK5Um/C88o+3dYMU2b7ot5zu9tRONm06yKt8sw+Ko4qvJj6
         LUQPYyLX0dJ+evh0p+YKmtAbuNGRksw8i1DQ8tCwpr3qEcC0Qf/uBEsAL3zbfpE1St7e
         QocO255/SrK0or7hCLlp9EFIqYyyCYjrWr4hgPgWgZl/DSKiGmr9+6fS9jAMWXF00m0q
         VhasdyExLkmUuEpsXMX+DOUAH3DTwszYGvPVimK9RkBJnbvUumGbiFlQcmxgAfkTj1aO
         ymRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUSxM7ItKcuRh2H8lj7oq8W32UFZyJbQua3hJAcxwLyz91jBtPFqLJ2hDfdgTGK9kmnrkJ9kv4/dU=@vger.kernel.org, AJvYcCWg7g+CnAzJYxR68HEAhHtueUXWGO1fGNuRwSSromeUunMfDOD34ZYtZuylgpMnmUPP7VBu2wugzyJBShzY@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqeKWtpk+WcLhHC2ry7SgB5E2tLTle4xv8NACWhMPrTIQkq9E
	epZ34kJ64dvkHJ5QhtDd4nVSdsAxGF7ui3L3NBZkkm+I8ttBhmzpweDYVDPyaZ5e/AMH8ig2YkK
	OgK8ZuhqC+BdOsC6Wl7eoVxHikMSvDWg=
X-Gm-Gg: ASbGncv82HsLTF0Sh7957MXQxynEm2F5pZc+irNcfW1hn/xwUbXgZ49YVYVJBMn76Ch
	oqnsC/h1NQAJLE8OF69q1UwQPUqRnJQzRpvdhMEWnLVltSsh7QB/m78vOziiWDl0pVGkvHGnqC5
	2VTCW3WIcoXAAxj3wIb6yeSDpdAb6nqFHnz1pXzXdwaKs4Yg==
X-Google-Smtp-Source: AGHT+IESHeiyOiuhAWJZBcfbJCq8fYJ700zvlkUPWv8gjHXka8KHuvGg60SAZjr8jC7/RuWODDxV0uw0bcmTEwnc7Mo=
X-Received: by 2002:a17:907:7296:b0:adf:ac21:e2c5 with SMTP id
 a640c23a62f3a-adfad437e33mr1247802266b.35.1750158834632; Tue, 17 Jun 2025
 04:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616124934.141782-3-al.kochet@gmail.com> <202506171615.p1kpBZuQ-lkp@intel.com>
 <CAPUzuU1oqiOhKcV5e21rhjP_XcscGGLq9oZMvcK4DB_B2yZ7Jw@mail.gmail.com>
In-Reply-To: <CAPUzuU1oqiOhKcV5e21rhjP_XcscGGLq9oZMvcK4DB_B2yZ7Jw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 14:13:18 +0300
X-Gm-Features: AX0GCFsWlekhlsxSrFFDAh3-Xv_3Al_xyZTpMNIlXJ8nV6j3STJBSz9kLCimwY4
Message-ID: <CAHp75Vc0EF+9jrG+P_0GKOc30Ze=FAUrywYFsaVAOAq0o9j5Cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users
 on ARM64 platform
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>, 
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
	Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:16=E2=80=AFPM Alexander Kochetkov <al.kochet@gmai=
l.com> wrote:
>
> One more question. I can translate all other dma drivers to BH
> workqueue. I cannot test all of them, but I did this for sun6i and it
> works as usual. Fix straightforward. Is it a good idea?
>
> That happened because of this change and this driver doesn't compile on x=
64.
> Any action from me? Should I send v3 without this change?

I wouldn't do anything. You explained well what's going on beforehand
along with the proper subject. This was expected, so only if the
maintainer asks you to do something. But modern tools, such as `b4`,
allows to pick up the certain patch(es) from the series, hence it can
be done easily without any need of being re-sent.


--=20
With Best Regards,
Andy Shevchenko

