Return-Path: <dmaengine+bounces-5691-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F910AEEBA5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B047188EAE9
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8C1885A5;
	Tue,  1 Jul 2025 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXZnEojg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565627262D;
	Tue,  1 Jul 2025 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331551; cv=none; b=dLjICVZg2IpkSm5vbK2A9kj4TJXaZ5SypoCEVDfRp8b1upKPr87FgxYQ01yeicyhM+RM0mf85Lx0v/kHNHDMJRFgzdulQxXFdo4PIhdI5FYub40fcugNduBeNUw42N6FHjlvkwpzNoCUPp8H6cWj1Aq3qfgRnLxzzvn4K9seAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331551; c=relaxed/simple;
	bh=lqZ/d95kGaSLsl2/jzzMnDucrl5+IWgYTIBjwR8jwJ8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=h+ORfv1tTCYjTLqpEspPBwKQZsMW3wyjolzU5y0sKz9EO2oPWYyC7BrR6v0P+ibHG8tVtlZP/gShbbEfIJHryIl8U4ahOZ/GbbQ6ko7KwBq5Jy6HWmKrUlNZmsJo0doWZiZ1yG219NJli9/VLZw+v6imdcWqNCd41bd/b7KO9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXZnEojg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC21C4CEE3;
	Tue,  1 Jul 2025 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331551;
	bh=lqZ/d95kGaSLsl2/jzzMnDucrl5+IWgYTIBjwR8jwJ8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qXZnEojg2iPLqp84CW5486NOP+M1Uz/S3qIVHb5SrmdWZWr9vKljuwJJDEnu7xARR
	 nnW+/gBGPOPhra1sx2SbeblTA1uXOJHbirWLQYz+hqnsVtjelIGkHGSsQdLbl8/rhD
	 fLEC1CpsUQqd1ZuGuJuwcn6jT27ssZteB2QFndfiOuC1zYi+J/jO0+vYC4bK+bjB/D
	 g+bhM+dUf64WWsPqYyxr/BxNzZ8TF15u3a1MbaV1fLvLIuGGkFmVFPcM1BnZwi8KoA
	 wgw8ngHOfC878ktOUFDSYFjfqESYz7Bu3p+2ia7wTvlNpXZamkM8vrLCnQZ06t4f4X
	 H0wXqv0/SErRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-7-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-7-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 7/7] clk: clk-axi-clkgen: fix coding style issues
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:59:12 -0700
Message-ID: <175133155234.4372.4127844417653528795@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:12)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> This is just cosmetics and so no functional changes intended.
>=20
> While at it, sort header in alphabetical order.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

