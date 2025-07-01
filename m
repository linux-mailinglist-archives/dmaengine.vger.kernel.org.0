Return-Path: <dmaengine+bounces-5690-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9EAEEBB0
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2611442D88
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BB189BB0;
	Tue,  1 Jul 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtRAO8PM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02B7262D;
	Tue,  1 Jul 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331547; cv=none; b=ZKxOv3nER47asAjRXJCb3TB/FtFfWf44GBhRMme15R1TEElcMMh1KQyxzL983XPVB8545B+UG1y30IRwRHON5aLp1qgpVpIQKiOIgZeIVJOZ/KxChd/qNTiFutQYj6u0nKypqmwYU3ph92GxA6RwmQUrI243eqs4YcIr04ha4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331547; c=relaxed/simple;
	bh=KQnkxi7SHtAn7Z7GBmmvBSrW7R4CEglF6+vVrJZY2/U=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NhnCcyTgoobkFNeDlAWiSdswHmseK0js2NWCC7ArlD/2qSerutf74Go7K0p0FAbJMnytem+xXy1hHCkVVZAwrsSDHhBQo1q6BVd8QGPcBRR5APMQzQ91WfRc1+9gl04ZVkOWPkc/dYjX2DiFcILBsJMKtQELCT3ZB4BEjSuHsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtRAO8PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379D5C4CEE3;
	Tue,  1 Jul 2025 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331547;
	bh=KQnkxi7SHtAn7Z7GBmmvBSrW7R4CEglF6+vVrJZY2/U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mtRAO8PMZSzWbTbbcfavBAFt+SJ9pbF3rboT14uMG1b3Awscoz3ZEEdk/Jf5bHaG6
	 FOUVuhCKyJ1/ykDwAF0YaZG1BWezDEM77g0DThgW4h2vpssoBlae1kn28RXDoDIsHC
	 qUlLUG93R8N4iRGdYl+mhLXUATvI1OKZpt5SA67pQtYyt8Yxd/xQurTeN5YLlLWDdp
	 aL2tuWIxlOU1IalHzwdhkK/CwdZuv5y8k5+/yH2pobgU19HzcINAR6tKgxIi7jh2nH
	 qvpdgBpZoyOjKXj4Zhz/FdlxIMFeuJt1Af4LfM0ZGUb6D48JjZZTgYgUd0MNtSksIa
	 AXwZxqXjedlfw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-6-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-6-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 6/7] clk: clk-axi-clkgen move to min/max()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:59:08 -0700
Message-ID: <175133154858.4372.13012568029100641421@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:11)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Instead of using the type versions of min/max(), use the plain ones as
> now they are perfectly capable of handling different types like
> unsigned and non negative integers that are compiletime constant.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

