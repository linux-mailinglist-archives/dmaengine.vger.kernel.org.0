Return-Path: <dmaengine+bounces-5685-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED21AEEBA1
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E053AC3D3
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6B15A87C;
	Tue,  1 Jul 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMZxU7R9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3F339A1;
	Tue,  1 Jul 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331527; cv=none; b=SyLuuEUJq1hF97kGedlTSufPNIc72WWkfPgcXUkVFqumtDCwjwKDIOwRm+Yo/RC0oRAKWdymnW2vuaNZrSxKd/a1BJdijDN6IbZ71vMFtOBVxoekvKWs5kPtNYqJTjUpSKnF1qGBf8Y+X1QMdqWEw1tSjuPypopONR/QheclELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331527; c=relaxed/simple;
	bh=9oprfdI1sJ+15xAulHIwRy8N2QDKD6U7CpCIKxB4YHQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=H3hpoOs0iWwkkBFJpKwd3Mp/Q0zJsdvVBs0GFZlZpiWoLlXRtjBG6CaPvih2540wVuC8x0SLGc6arrgK9lMNIXIZqfAaeApi8Uy8c1o9iELIaPziP81pylEkdwQ+7HLQad8YsjnEW6fhQnQR4KvGe78KXUaSADs1UrboRYiQJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMZxU7R9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA380C4CEE3;
	Tue,  1 Jul 2025 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331525;
	bh=9oprfdI1sJ+15xAulHIwRy8N2QDKD6U7CpCIKxB4YHQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tMZxU7R9gOk+G0ojtOyWmYbdMU5k2Js1MA7HZJXzVaxotkMIabWdO07r2g/4ob7sl
	 XCxij+o9e10E4vPy2qWR+yIdkcomKjZNabTa9s7wGisQ7+R0UNSD2k1Kvzfpx1GFxY
	 jS0t+qPsrKevD/bAI2sB5Pd/joLuKZxZ3+LdemlEJr8A7b1MJC3eOJvhWBqplY+JXT
	 B9m0EwJKdrvagWX/nM2V9+6mhVCAAOzIMXKRe7gY7HaJ5bQRrrQV8r3R2PDcBHKRiK
	 jA0veSn6sxj6u8dt6JQbNvxT3XmQWYFgVU+XvE1MHg7UwF0muq+fAtQt/VgQnecP+V
	 Jq9/KPQf5tgOw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-1-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-1-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:58:45 -0700
Message-ID: <175133152558.4372.13862908191934557493@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:06)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The fpfd_max frequency should be set to 450 MHz instead of 300 MHz.
> Well, it actually depends on the platform speed grade but we are being
> conservative for ultrascale so let's be consistent. In a following
> change we will set these limits at runtime.
>=20
> Fixes: 0e646c52cf0e ("clk: Add axi-clkgen driver")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

