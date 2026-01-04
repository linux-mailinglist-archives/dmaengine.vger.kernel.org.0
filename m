Return-Path: <dmaengine+bounces-8005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA71CF0D52
	for <lists+dmaengine@lfdr.de>; Sun, 04 Jan 2026 12:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE676300C6FE
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jan 2026 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745228640C;
	Sun,  4 Jan 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSrmBejJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC22116F6
	for <dmaengine@vger.kernel.org>; Sun,  4 Jan 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767526686; cv=none; b=uz25EevLgXn/K06RpcJERDYAStGYwIkfZZwkATSsqzSiHGuAZkq5iRqrGuA4MP2L4Grloq+bLSFqqssbIXHLHI62g2zbw0p+e8TmGJs9JetYmJAi5j5AYH8GRJc0sIaGcPiQ/LLd/pAC3SKTd6sxGpZ18/vAEWjJH14zLOOb6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767526686; c=relaxed/simple;
	bh=zzt8nsTReCOrFFimHSYnuwYVhyLibD7TXrGiySpB+f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf3t88EDvMwVVpVQrVEs4f/bUAzWiI1m2PYF2Yl2sC9n1ejAyH/AhFDaiyOfdZcQS9eGCZEtijN0BPIHtUAIp5zKLDZku+7cgJsA5sZD8Jx89klPAx2R5C1l3fZvVcvFaZdIYj6cfp+juMXYSRkDN3I6RZtK4LgsAAOdjpUA+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSrmBejJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD41C4CEF7
	for <dmaengine@vger.kernel.org>; Sun,  4 Jan 2026 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767526686;
	bh=zzt8nsTReCOrFFimHSYnuwYVhyLibD7TXrGiySpB+f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSrmBejJxZP8gHrW1lt8qLoXx5i5yIr8c9JjAw76JwT4w2DU5Bw/V3A8ds+61J9gA
	 qrA1BD0oGFxFt5TGFqAv6/RSxsC53w/k7B87GXnPPGu5JyBIFEy/k2xW5XqJfBLQwZ
	 s7To43MM/23LrjwnT2MHsbj2v+MNR3gch8pFv9yPYQDYuMjuaAik+CInCYu5+ZmfZA
	 x9Du36muqnYdgEnwcEtBPGE0Q2krb+xtqRR3x8L+34PJR5hQ5QQvm7VmmsMrN+wnM9
	 I2UaQA0Jag3f/lobO/fONtZhnVUHsQ9680OTtldkoKQt1MckmCleLVqFj0F055vXis
	 sgoDnkXq9m56w==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-644715aad1aso1219220d50.0
        for <dmaengine@vger.kernel.org>; Sun, 04 Jan 2026 03:38:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFkH5LhfUMjXxXmvNCMC84LVm+EuVY2osSqkQmhpK79EEmqTgTCdeMP7jFYY2EUBn6BgHVxUD4Nqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORHBOtcgYCo8l3B7iqMIRgI4Cs+1Xs+2baqDAcHnRw5iWTnVY
	0cqn5ptNnBMXnA1WwSoE5Hx/pd3aBm78UT4a4oy7P7yHg+B5ksX+VnrLIyWCvvrpw4D9aCL586i
	osL9vujzKh24PSPawOM+5IX51WnshzAY=
X-Google-Smtp-Source: AGHT+IF4Orabbp+U3oU6DE4mJfK9KKnbEOxrcm3UcvoG3IBBIUd0oK3DmWjwYq82sAXiIcIbWSh2iznA2Fvf8inAirk=
X-Received: by 2002:a05:690e:b4d:b0:645:591a:cb5c with SMTP id
 956f58d0204a3-646e341a6cdmr3638468d50.23.1767526685648; Sun, 04 Jan 2026
 03:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212231203.727227-1-robh@kernel.org>
In-Reply-To: <20251212231203.727227-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 4 Jan 2026 12:37:54 +0100
X-Gmail-Original-Message-ID: <CAD++jLkAaAH9_YdTGqHUcOp8PfW+1P=ZLZzS_QseVYWxA4kiWw@mail.gmail.com>
X-Gm-Features: AQt7F2qijkDXeXovdHRRQ5QEL33UZBQlEMiEIzun3p2-rj7cwfnP7kAmQfWhUyg
Message-ID: <CAD++jLkAaAH9_YdTGqHUcOp8PfW+1P=ZLZzS_QseVYWxA4kiWw@mail.gmail.com>
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
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Sat, Dec 13, 2025 at 12:12=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Remove includes which are not referenced by either DTS files or drivers.
>
> There's a few more which are new, so they are excluded for now.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Good.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

