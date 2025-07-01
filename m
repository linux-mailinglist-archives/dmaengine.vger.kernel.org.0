Return-Path: <dmaengine+bounces-5689-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6EAEEB9C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D1E189937E
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E33153598;
	Tue,  1 Jul 2025 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBC6Qtza"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361351684AC;
	Tue,  1 Jul 2025 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331544; cv=none; b=s0dQNa5lmOXSG5JKXy92LfgIDaa7oGsdD+6HVsd1HmS3CYrSYvwAKe73cKH8xf57brm0rjNaYF6k68ca3iWMPGVoNguPTlGnlolpbLSXajLXhyTVrFxqtyXKLJGLvPNL1H2GZQKRjvqmiu2iJPhjnyaWHCg5srIvHvoTAjSX3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331544; c=relaxed/simple;
	bh=uJ8nDMHPMr4I+65BQ6fB6/nR5XWuWvvQC2RSpJG+m5w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=eRJM45R3rTXTihQKRlBfPYOs5LfVVm2NX7/Y/aovudWjYSXG+8CefqkvE+KDPHVg5hPahnawV/KWIMk+iZSrKipQcR/f+Vy5sfdgteCv4uK9ziJvhQa8tD8iwHHlNW3GaR0sk93ihzXbXJAbKH1QevQw7XEh2KggzLcy/z7tzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBC6Qtza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC9CC4CEE3;
	Tue,  1 Jul 2025 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331543;
	bh=uJ8nDMHPMr4I+65BQ6fB6/nR5XWuWvvQC2RSpJG+m5w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BBC6QtzaTmB8pPJ3/GMXkMEa31ZHa/3a/LuUksiJxLhgaBGwwmF88cJxHCwiljrjS
	 r564i8WSosXnis5iImzFybYz6posx8nU8KRIffytvQSwUkB8eWQ6Vuu3BZHtFJVylW
	 Eif1vQgmFhsd0JgkzMTimCCtUj2iDLCuh31GgnosKao1GdUcf03oA2k0fpuGToSnxA
	 eH9ss5GWU9Tfw+gaTDNaheu9kbOJK7ZKdj3qjYzLuAM9zdEbWwXEhXPAjpFtNE3VmQ
	 vOoWcjwE1p6bxG8JvFgX2br9XpKVhaozv6iVsbwvVtJsIo4StUtwNzT1ZzilmyBLD/
	 LJTOHvTHEJt5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-5-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-5-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:59:05 -0700
Message-ID: <175133154512.4372.17885342063380520018@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:10)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> This patch adds support for setting the limits in struct
> axi_clkgen_limits  in accordance with fpga speed grade, voltage,
> technology and family. This new information is extracted from
> two new registers implemented in the ip core that are only available
> for core versions higher or equal to 4.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

