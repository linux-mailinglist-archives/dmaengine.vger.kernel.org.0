Return-Path: <dmaengine+bounces-8064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B063CF7B30
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 11:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0430330754DA
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675230E830;
	Tue,  6 Jan 2026 10:11:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C04224B04;
	Tue,  6 Jan 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694278; cv=none; b=QH20iJl8L9udKUop2DPqJfeNAAku32IklG4dT/wUkiHJzUCLrgzjP0msWaNqcQZHanm7GEsoer4I5WTL9pvh+tEpwoUH0Xv3TXdeTICispRg4y2PX4nsl/BLxPG4ZK1VBTe8iD7sVd3l6DOnCIn9o5iJFF5Eu+ziycJKf7nz4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694278; c=relaxed/simple;
	bh=1LSUfXKMGcV0Lhy+tUOwzgJ0WaGax55UeE7E4SI3SJE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2XnRW2uo802bpBStISyz6mjMBNFJR82uFUMOd6NO95Oax0VdcrVKyAeVHgqxGeAbr3aMue3z2NP0UU+KotJ/V+AQR8ZRn890JwISm3TCBGdchHh0hFIc+UjjvY0qFrYKNXFzE6esVjbtAlco3OtWVPdgT9/rt9JYtvIIBbZ11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dln4W0mslzHnHW1;
	Tue,  6 Jan 2026 18:11:07 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 12CE340565;
	Tue,  6 Jan 2026 18:11:11 +0800 (CST)
Received: from localhost (10.48.149.114) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 10:11:08 +0000
Date: Tue, 6 Jan 2026 10:11:07 +0000
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
Subject: Re: [PATCH 03/11] ARM: exynos: Simplify with scoped for each OF
 child loop
Message-ID: <20260106101107.0000398f@huawei.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-3-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
	<20260105-of-for-each-compatible-scoped-v1-3-24e99c177164@oss.qualcomm.com>
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

On Mon, 05 Jan 2026 14:33:41 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---

A suggestion inline, but assuming you don't go with that, this is fine.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> Depends on the first patch.
> ---
>  arch/arm/mach-exynos/exynos.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 2e8099479ffa..18695076c34e 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -47,9 +47,7 @@ unsigned int exynos_rev(void)
>  
>  void __init exynos_sysram_init(void)
>  {
> -	struct device_node *node;
> -
> -	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
> +	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram") {
>  		struct resource res;
>  		if (!of_device_is_available(node))
>  			continue;
No idea how common this pattern is, but maybe worth
	for_each_compatible_available_node_scoped() ?
Bit of a pain as you'd need a of_find_compatible_available_node() helper.
So I'll let you assess if there are enough instances of this to make it worthwhile.


> @@ -57,15 +55,13 @@ void __init exynos_sysram_init(void)
>  		of_address_to_resource(node, 0, &res);
>  		sysram_base_addr = ioremap(res.start, resource_size(&res));
>  		sysram_base_phys = res.start;
> -		of_node_put(node);
>  		break;
>  	}
>  
> -	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
> +	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram-ns") {
>  		if (!of_device_is_available(node))
>  			continue;
>  		sysram_ns_base_addr = of_iomap(node, 0);
> -		of_node_put(node);
>  		break;
>  	}
>  }
> 


