Return-Path: <dmaengine+bounces-7946-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B6CDD906
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2490D301D0E0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Dec 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD453164B1;
	Thu, 25 Dec 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caBCnPSr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD753161B8
	for <dmaengine@vger.kernel.org>; Thu, 25 Dec 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653673; cv=none; b=bcvyzIiHsto9Dx+5os5b2EJOET5vfOpUNIP7JRrMtaTFlPNK58J+AxsgP0so5SdOjIbAkMK0XJFFp1OD6V/QTNt20j40pJ3ZWWPF7ulCIPCTkE2BPvusadGq/kkFTRLJxHJlOpVrdaJDqGBeQrzNSyLSwn90I1TSj80OnEoIH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653673; c=relaxed/simple;
	bh=hZc1+DU7BxaZ0pHjHw8/tfR/Nq71rMC9Z07diFqHTEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve67gorMuUtf0nT/SbW5ePt6h0IEAeZ07yId74XRpeamZANFROrBVLJ9PKGvw9ID8+dRll/lSEST3Spl1Z57HWSDxR0evTb3VX5aYo9Uvym1KmkcfAWrIgNQ+F+NQnF2jr/Pk7YBN2ezXTmeNdQXpp80NdBF+RvKoX46CzYUv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caBCnPSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D8C2BCB2
	for <dmaengine@vger.kernel.org>; Thu, 25 Dec 2025 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766653673;
	bh=hZc1+DU7BxaZ0pHjHw8/tfR/Nq71rMC9Z07diFqHTEw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=caBCnPSrtJ32X2296HO3meZX1otJPRMu2wMIRegIwALIMzO0rNIdKPF9/ll5/fGfg
	 tdXLDY+eqDWvJEz4PEMpSgGR/LTyGW4Bg5vpmT4YiHvXXbnCyvH1qNtxtcKqGz++a9
	 7GuohHuJFJjudgAvRuYY2Bn9x+b8Lhv++VAjYpRDCUle403KSZ78am4pZGBOqIjBHg
	 ZP9xYPwyZC2O7hqDmuqmXGC3FRtQTxvHiCfEyKERyxJKu9BKhFFk+tKVuXk8thcXYs
	 Emsb6rG/ENWpdN1jfpFWFZ8sqf8XIyUwjb5HgUQ3OH1IBjFyuzsTjWyriCG+U/yvnc
	 dLt/Ge4Mx12yA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a2dced861so72818721fa.1
        for <dmaengine@vger.kernel.org>; Thu, 25 Dec 2025 01:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSrmNvYd/ScISlq+cJJ6u9GDwz2Lq5222gqxdHtP0p+t7CEq8XyewQ1QTbLdLe21wt737HHg11Vco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OSu0HMIS3etVjrMoRjVt/8TnvXZ8ceC7wZxKuMjfvtnsaGso
	XufzlzuiBhDr0d92A6G+ZHano+SyAtqlucmyOZFlccStKgQ89oRzqPnPcMphi8FCDzzpK3GdCxY
	DFhPuHEosWBYnPjcWJmn5eUU/ejPFDdQ=
X-Google-Smtp-Source: AGHT+IHfPWz1heWtm82AOh8ny5sgT9kzx+lyzDjyJcBgqVf6WZJpwpmEyZeQVabkjvt5oV4xlzU03UcKE5H1xk8UgF0=
X-Received: by 2002:a05:651c:1470:b0:378:e0f3:53c1 with SMTP id
 38308e7fff4ca-38113275820mr72648701fa.18.1766653671109; Thu, 25 Dec 2025
 01:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212231203.727227-1-robh@kernel.org>
In-Reply-To: <20251212231203.727227-1-robh@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 25 Dec 2025 17:07:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Pt=c7rNtE-u7j_=SbT4DLw03iOw=PFchbisPQenhOtg@mail.gmail.com>
X-Gm-Features: AQt7F2qwpZzDsTD1g9DqdU3xoJFe0KlIMNtkshCEa1nlt61s05fF43c85tHciK8
Message-ID: <CAGb2v65Pt=c7rNtE-u7j_=SbT4DLw03iOw=PFchbisPQenhOtg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove unused includes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Vinod Koul <vkoul@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Peter Rosin <peda@axentia.se>, 
	Linus Walleij <linusw@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-iio@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, imx@lists.linux.dev, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 7:12=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Remove includes which are not referenced by either DTS files or drivers.
>
> There's a few more which are new, so they are excluded for now.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  include/dt-bindings/clock/oxsemi,ox810se.h    |  19 --
>  include/dt-bindings/clock/oxsemi,ox820.h      |  29 --
>  include/dt-bindings/clock/qcom,mss-sc7180.h   |  12 -
>  include/dt-bindings/clock/xlnx-versal-clk.h   | 123 ---------
>  include/dt-bindings/clock/xlnx-zynqmp-clk.h   | 133 ---------
>  include/dt-bindings/dma/jz4775-dma.h          |  44 ---
>  include/dt-bindings/dma/x2000-dma.h           |  54 ----
>  include/dt-bindings/gce/mt6779-gce.h          | 222 ---------------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --
>  include/dt-bindings/memory/mt6779-larb-port.h | 206 --------------
>  include/dt-bindings/mux/ti-serdes.h           | 190 -------------
>  include/dt-bindings/pinctrl/mt6397-pinfunc.h  | 257 ------------------
>  .../power/allwinner,sun20i-d1-ppu.h           |  10 -

For this one, a node is present in the DT, but there are currently no
references to it, and thus no users of the header.

Also this chip hasn't seen a lot of interest after it was initially
brought up. None of the peripherals that have a separate power
domain have been enabled.


ChenYu

