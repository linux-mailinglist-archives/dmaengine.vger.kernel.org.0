Return-Path: <dmaengine+bounces-7610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF14CBB1A5
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAA030469BF
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8C2E11C7;
	Sat, 13 Dec 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwzsPYFW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861C2D6E6A;
	Sat, 13 Dec 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765645208; cv=none; b=W7b1aNuskS57WPAkf4xS5lUNUKLS6nr2x17M8UGTC6FaLtqaI5qxCwYM0UsfBqExlraPv6T0Qxwp2t0s8doi629w6jp4c+Nx1vDdrfJhX/2HE+9YrG3kNyi/d5SkgfFVfVXfGmxak6V2pICPtSJZ/cy85WpXzXY3AdlF38enUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765645208; c=relaxed/simple;
	bh=VzKBYcoy1QLzHCut6+iKlDtsmmJak9U5g55kExj/JFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDuFPXgszTYzVwbJMXXIUOF45dM0q52mPtJZlH0Lxjt6kKDFyYsjakf1DV6Hz+5iuwYuwNJNxQqEJE0KG0DSdLuL2TNHUMF3KKDaeewdXB6h/fehxKMZYBet36eZlgDctSWN+nzypdJNHpI1bB5I9LBxG6T1gkkstjRq3i5hobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwzsPYFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96631C4CEF7;
	Sat, 13 Dec 2025 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765645207;
	bh=VzKBYcoy1QLzHCut6+iKlDtsmmJak9U5g55kExj/JFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwzsPYFWZct3fYDaSoH2MO8Pr6OmUerebApwD55CqIDmIjhoGYii118YuorwNlvqq
	 ScAULQd/58dFFaqTTbGQluGmGyWmjP197/lR0mEIj9eB+4T931oqm6bV+zZ3Dtp3UB
	 /3rEA58xa9OtbeLC8Sdoct2UoObIYuhaP3mRahKBMFr5MyUfu8A/UkiQKKb0hJJ052
	 XpUK03v0ZQVQ46uHO5Tv0MUUttfEsK/oQCNHvdjrmUt7X7j38m0kpVAalfiSZ9oRUU
	 sWgR/3U8XMRryBhIuoNjoTDFmxZ+oM6dTz94zalzS6WErXPW7Vhg3NOCfVaTboJchh
	 qJxB4vBT3+yhg==
Date: Sat, 13 Dec 2025 16:59:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Peter Rosin
 <peda@axentia.se>, Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-iio@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove unused includes
Message-ID: <20251213165949.4b51f7cb@jic23-huawei>
In-Reply-To: <20251212231203.727227-1-robh@kernel.org>
References: <20251212231203.727227-1-robh@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 17:11:52 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Remove includes which are not referenced by either DTS files or drivers.
> 
> There's a few more which are new, so they are excluded for now.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for-iio

Ideally we'll get a QC ack on those as well.

Jonathan
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --

