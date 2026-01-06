Return-Path: <dmaengine+bounces-8068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60274CF7C93
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7798D30041BC
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDC31ED6E;
	Tue,  6 Jan 2026 10:21:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940A31B815;
	Tue,  6 Jan 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694915; cv=none; b=X0wlP4ydXEB07B2cTnGgV60kw/hMDXPjZqOyX3waPnvlWm9kQ2KZO2TIgkQQPoq+SAUP2F63AiarpLmyvsicv8Sgbei/J1srkPtQ2ZZtH9cNTG/ZaAfWKDN5VyrQ/qIw9QYdYM/IJ0VCkW26U73s4qQQlytXnUWiiXbX0BwFpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694915; c=relaxed/simple;
	bh=7Xx+0iwbRindj1ZupjQwR4wGNm7qkHz7BPNgzMJcmtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQwKmAf9IDyFkeUsF6W0w9dHXDKpsAuQKSW1iACNehuhQgQt6MTYJuy0DVZItt9MSp16JFrj/gcFt1pfSL/P3CoWHwduHGl5CVSwkcUK93AazR991BvSKnLiQqfWYJT/NA5U88JvxxkEkBFk3rN7BLidsjzH8NjBrB3tE5G8Oo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlnJs33ywzJ46sy;
	Tue,  6 Jan 2026 18:21:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CBDD740570;
	Tue,  6 Jan 2026 18:21:50 +0800 (CST)
Received: from localhost (10.48.149.114) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 10:21:48 +0000
Date: Tue, 6 Jan 2026 10:21:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Russell King
	<linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Krzysztof Kozlowski <krzk@kernel.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Abel Vesa
	<abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael Turquette
	<mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<llvm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
	<dmaengine@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 07/11] clk: imx: imx27: Simplify with scoped for each OF
 child loop
Message-ID: <20260106102146.00005bfb@huawei.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-7-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
	<20260105-of-for-each-compatible-scoped-v1-7-24e99c177164@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 05 Jan 2026 14:33:45 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
This is one that had me thinking for a (short) while about what pattern
required this double match was there for.  A comment would have been useful!

Ah well, nothing to do with your patch which is good.

Jonathan

> 
> ---
> 
> Depends on first patch.
> ---
>  drivers/clk/imx/clk-imx27.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
> index 99618ded0939..f2f0d3fe5c52 100644
> --- a/drivers/clk/imx/clk-imx27.c
> +++ b/drivers/clk/imx/clk-imx27.c
> @@ -171,17 +171,14 @@ static void __init _mx27_clocks_init(unsigned long fref)
>  
>  static void __init mx27_clocks_init_dt(struct device_node *np)
>  {
> -	struct device_node *refnp;
>  	u32 fref = 26000000; /* default */
>  
> -	for_each_compatible_node(refnp, NULL, "fixed-clock") {
> +	for_each_compatible_node_scoped(refnp, NULL, "fixed-clock") {
>  		if (!of_device_is_compatible(refnp, "fsl,imx-osc26m"))
>  			continue;
>  
> -		if (!of_property_read_u32(refnp, "clock-frequency", &fref)) {
> -			of_node_put(refnp);
> +		if (!of_property_read_u32(refnp, "clock-frequency", &fref))
>  			break;
> -		}
>  	}
>  
>  	ccm = of_iomap(np, 0);
> 


