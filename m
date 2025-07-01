Return-Path: <dmaengine+bounces-5687-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F785AEEB8B
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5A01BC4D89
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0840153598;
	Tue,  1 Jul 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GElKI6bV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6363DDBC;
	Tue,  1 Jul 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331535; cv=none; b=kIz3BHGPbvTtlZBvLCI62yYVGjq7YbCEJoQgjCC2VP41L4j8QWPmiR8l0rRh7GhNPcHw3kBwQ0mboCROv21GfSnQVyYEdbe2/yH3clruKET7Jmv/zAPm22TKvpEVOTJrdIhZWZ64m2SjtBsQuama5s5NEXjyn2L6xMYDaqUffbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331535; c=relaxed/simple;
	bh=GG+kY8nWNii2hAxN8E2yTG+aazGKL4hdPC/qghYemgw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EvTLgA7erA+ZL7m0cQ3ZqkGfFnHOJzVdVsHzb3Z97JF6+y8ZQvjSggDNR5jmBr0KzQDcr3K8nJH5GG1bcWgfrRg/ywdkUW4gb10oMc/Gm4pojiLE3L/ineOxMhqaRqHNpDWuLzmE7B9RfJ5cZHkD8Hz5z4EiccgOyyZx7Kxl0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GElKI6bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E695C4CEE3;
	Tue,  1 Jul 2025 00:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331535;
	bh=GG+kY8nWNii2hAxN8E2yTG+aazGKL4hdPC/qghYemgw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GElKI6bVSMebLnmDaQgtzJfrCHnCmtDTKdHLrjkZHMnTA4vfPGxgw21C/6UKps32G
	 vm+W2jhMJVqhTa9Wavt8mPwvBBQaUgdf+YBVC/WYbrhGCZXvxKCbmhFAxhBghtDqaf
	 o7wHFmNjzLnlk/gP+qLEi3hvGs1FXT5wO6pmxZWykYeHl4hEIcFCQYbyl87y0y9rVE
	 AK5q0h2yxhlPqmsWSJqrVporXfgUjGbdd15xRH6K1KDW0tbeYWH+ProS9zhnNtRCiW
	 i7giukAIM0jjpZSXIAdZtuzKSGCmEozFZl8GK8HeS4VNosQGoFao5vSHbp+MNy9eXf
	 nx0G2/TI/AUag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:58:56 -0700
Message-ID: <175133153648.4372.1727886846407026331@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:08)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
>=20
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

