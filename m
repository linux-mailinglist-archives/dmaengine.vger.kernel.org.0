Return-Path: <dmaengine+bounces-8033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2FCF5DB1
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABE3308C8ED
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653B2DECDF;
	Mon,  5 Jan 2026 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmbHwuIs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033D2D7802;
	Mon,  5 Jan 2026 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652606; cv=none; b=CKMFXpmwbo6gsGoffpgz2NJVp+vDgXbUOhIPC1zwd+sSTYLiujRDWoRI2aYdFj9Lq98Z2s0op51f8bL5LznF3K1fq4z/2mZVJLU/PtOsKkRcfw01SthnsepXRwQZeYcBECxlIoNCxcOzvU4T3T+L2f7HZuO/EKR08QAU/h7fvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652606; c=relaxed/simple;
	bh=kzkUocZGzbldAqL7H+ZbDJj1W7al0AimC+VuLG+yvHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJLFygb0USqQfTS6wZQRAehzfJJPwW8wU0lX1PTY0XandKY8GS15TquxWZOSvQoG4XSp5e018JntgMsah1QtqfRtrwCmNyhg/XvEjfXIJEeC8OtMSJmYYcrZlfuNl8rVuux2uJnT9nI5xpDO2kDeV+w+i+lhwPvq4EJxMm/5Ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmbHwuIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47434C116D0;
	Mon,  5 Jan 2026 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767652605;
	bh=kzkUocZGzbldAqL7H+ZbDJj1W7al0AimC+VuLG+yvHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmbHwuIs+Jus28fsK5wm0xq/ylwPIKhkr5dyCyT/XQL2ulRMOn63qz9aCdKiEaCov
	 Jd9a57EMPcFXqJhga7Fp0ZIjS73JKd5dOkHRg2dEcMidwoO77HKO1vriP/dsVzHPfA
	 dzPOnbxH4z4WVGzGyN2Nr4qg2ODsudK2C4wa2JDGQ0ENC81eHPfEfU/stMY7zXBjiK
	 hvO+GP6m++TN9SO+Pnmaf14Kg/z0dcI+Z+ggkx97EtvnNELUIPfS8uHdbyyFT1OCs6
	 RzPiRnzPyb2M/xb2uU6ERe6nlnPwbEx5h/c8oyr8ufiJP2RVk6dBGg0wT0ctIQs++l
	 kUKgFhWdsrlYw==
Date: Mon, 5 Jan 2026 16:36:44 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 01/11] of: Add for_each_compatible_node_scoped() helper
Message-ID: <20260105223644.GA3633916-robh@kernel.org>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>

On Mon, Jan 05, 2026 at 02:33:39PM +0100, Krzysztof Kozlowski wrote:
> Just like looping through children and available children, add a scoped
> helper for for_each_compatible_node() so error paths can drop
> of_node_put() leading to simpler code.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Prerequisite for all further patches.
> ---
>  .clang-format      | 1 +
>  include/linux/of.h | 7 +++++++
>  2 files changed, 8 insertions(+)

You need to update scripts/dtc/dt-extract-compatibles

> 
> diff --git a/.clang-format b/.clang-format
> index c7060124a47a..1cc151e2adcc 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -259,6 +259,7 @@ ForEachMacros:
>    - 'for_each_collection'
>    - 'for_each_comp_order'
>    - 'for_each_compatible_node'
> +  - 'for_each_compatible_node_scoped'
>    - 'for_each_component_dais'
>    - 'for_each_component_dais_safe'
>    - 'for_each_conduit'
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 9bbdcf25a2b4..be6ec4916adf 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1485,6 +1485,13 @@ static inline int of_property_read_s32(const struct device_node *np,
>  #define for_each_compatible_node(dn, type, compatible) \
>  	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
>  	     dn = of_find_compatible_node(dn, type, compatible))
> +
> +#define for_each_compatible_node_scoped(dn, type, compatible) \
> +	for (struct device_node *dn __free(device_node) =		\
> +	     of_find_compatible_node(NULL, type, compatible);		\
> +	     dn;							\
> +	     dn = of_find_compatible_node(dn, type, compatible))
> +
>  #define for_each_matching_node(dn, matches) \
>  	for (dn = of_find_matching_node(NULL, matches); dn; \
>  	     dn = of_find_matching_node(dn, matches))
> 
> -- 
> 2.51.0
> 

