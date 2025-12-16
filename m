Return-Path: <dmaengine+bounces-7709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A2CC49B2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AD3B3016F96
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9204328B69;
	Tue, 16 Dec 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd77r7CV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EF72602;
	Tue, 16 Dec 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905309; cv=none; b=LnuBWAAjmNS2H98DgxXyYO0++R/7z6nfVFFmOBNxnmRrzJO4YbXJ3UzLvKgXYTaYKuzM4KQ0XghUM0VymuD4mYmdBnSPH7tynXhqwB3tIbpa+pZxfBb8qkIuscPTn9De8dk61UpXIeDtAYiqlJUl0Np+hUBNBxPfkpeWXrOtUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905309; c=relaxed/simple;
	bh=mcmdjoIeQ8dVaydge/S3sCXDOzpTarcOqio6eoFh39k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrHXTHMM8940VyGS/oFtYGMoLc0inKaEen3gfFSjzRe7hxDv+h6CXG8f1C6j1EL+GVsg7SXXRfTic0i4cDAjJGllioKn/CEVIYo3k65J38YH6pkjVC/jeOovTFpI04ejlhHffXEJJeIDMx5eZzfHHNIrto//AQQ7DGmtaBDR07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd77r7CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79985C4CEF1;
	Tue, 16 Dec 2025 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765905308;
	bh=mcmdjoIeQ8dVaydge/S3sCXDOzpTarcOqio6eoFh39k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd77r7CVON1lRH0b5ILmf5Gy/OkXnk169H1lioS5jyy9elisWdT1B/13wKfu+8pZc
	 MMVtqqxS56r1V01p+Q85v7lwRhImLwUnIJJ0vwO75aAuzEyDngWY8pLjYM79dfY8f+
	 5hyuQnh96NvBdqQApeIyRFLfbs6yW4Y4LKCn8Aw/RrfYIIobxDskLwKUX6wRtVGBKw
	 R2zpsoAI2i5/AFYKvFT2N8twQh/qnJ6umnF7PnanyQvjDYoEksoloEXlTs+/elMEY/
	 PTZGiL02hNPhdY5Gtl8RycZ9WpmAyen3c6YEpedvcyXnwPyXz276eehtsd3P+/npXv
	 IAcWNiEQ0WdfQ==
Date: Tue, 16 Dec 2025 11:15:05 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Peter Rosin <peda@axentia.se>, Linus Walleij <linusw@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-iio@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove unused includes
Message-ID: <20251216171505.GA2641341-robh@kernel.org>
References: <20251212231203.727227-1-robh@kernel.org>
 <20251213165949.4b51f7cb@jic23-huawei>
 <695ca5d2-b713-4838-8427-a9d31751c0cf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695ca5d2-b713-4838-8427-a9d31751c0cf@oss.qualcomm.com>

On Tue, Dec 16, 2025 at 01:02:52PM +0100, Konrad Dybcio wrote:
> On 12/13/25 5:59 PM, Jonathan Cameron wrote:
> > On Fri, 12 Dec 2025 17:11:52 -0600
> > "Rob Herring (Arm)" <robh@kernel.org> wrote:
> > 
> >> Remove includes which are not referenced by either DTS files or drivers.
> >>
> >> There's a few more which are new, so they are excluded for now.
> >>
> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > 
> > Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for-iio
> > 
> > Ideally we'll get a QC ack on those as well.
> > 
> > Jonathan
> >>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
> >>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --
> 
> Those are being moved to dts/qcom:
> 
> https://lore.kernel.org/linux-arm-msm/20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com/
> 
> and will hopefully be in use later in this cycle.
> 
> Krzysztof and the submitter agreed on that outcome since they represent
> hw constants and aren't "real" bindings (connecting sw to sw)

Okay, I'll drop those 2 when applying.

Rob

