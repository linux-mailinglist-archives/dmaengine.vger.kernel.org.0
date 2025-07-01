Return-Path: <dmaengine+bounces-5686-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E8AEEB86
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176311664A2
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C6187554;
	Tue,  1 Jul 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my66lDzs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C3DDBC;
	Tue,  1 Jul 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331530; cv=none; b=KuB4fn9rf2+d8dzEwUkBipO6lz+jmgaZyWRgCj3zVPwKI2g8fCXB4GuYHTUFdLHXB0ph349KtbmitmBYIIwi6wsqlSoJtmtRCiWKMdU/r8VbhtxtIcM1J7+yhOAVty4CxL1XakwFL6DfZlztFxMwtsJHTES866JLm3F5+WZYei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331530; c=relaxed/simple;
	bh=it1ARNC/9H99eswFK96Vl0+2NiR+TwXIzmq2daI0BdQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=YtXWzxrTbg18i0AjtTVkx+mFtg99lT5NgskU45UPYzOw2odUionOZ7V6P3uyjCgDQKopAKnLUwctYwBcHUDZEx4bLOFYV/tq5b+wXoyrOx3Cm40r9J3y+1EcESJCSsbhH2O9/f+IgcwmbL3I0LqJY+rTe3Du/xwee6xNWlfTCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my66lDzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D480FC4CEE3;
	Tue,  1 Jul 2025 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331530;
	bh=it1ARNC/9H99eswFK96Vl0+2NiR+TwXIzmq2daI0BdQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=my66lDzsZ3e1w/zfoqG37xqO4hLqIv7nyjO76pKCmPIZvrxrPZ2ZnJSm02IPhBogI
	 JFR9kSX6R0d5qq+vc9Z3u/xt8ma23AtDHOM4t+B31G8/55qafudt3krF4AvnQAMidu
	 UzEEKLBrKtopnpSnbhxXUXwax+eRYI4lkCMb82WUHnNmpiLQw2dzturS0kVzBqcqMq
	 6L2UZOU3saZuw+nOb3NYVSQt0zSYhcKmhAiYHkh6v7wxVpAl/a0q2+yAfYCYgl7KfT
	 W+2T1JxImxLIvp10zl5pJikBf0kiY7GV5BjtC0PF4jvPJamD9N9oD8lCvyw8pvAEyY
	 gZS/mpN4yx40g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-2-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-2-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:58:51 -0700
Message-ID: <175133153127.4372.10141481123281690961@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:07)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The mod_devicetable header is the one to be used for struct
> of_device_id.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

