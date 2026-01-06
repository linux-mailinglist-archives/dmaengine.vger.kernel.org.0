Return-Path: <dmaengine+bounces-8069-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3DBCF7F59
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542C430E4A01
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4D32FA22;
	Tue,  6 Jan 2026 10:23:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893E32F749;
	Tue,  6 Jan 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695033; cv=none; b=GyfmDgAa9IPz4a3HMktMSPnQ4tm8Pk2S18chYvm430a4SWq9HKpaK2bdzhUhae9xrl8Ij461P/2IUnmZ8WD+acZzW8Pw/KdPU/w3jHzTE597TTUISGnch7OVM/EGvHqaNc4GIvG+5qbsbUVHN91M9/aT9iPdnf3IKstINpGZ8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695033; c=relaxed/simple;
	bh=kWEr6KRd8QtmW6gX41iN9OsDNbx6l3BZrOL5rcpiSjA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHul35KT6JMc3LtiKAqSU4xhEFf3Js7ND5J/9tJokhSJc3iLrjqzG/IpMmd33QZKmm1etH1PMXNgc0k/HIXYDADCJIA9wV44aG1CwuKKn7lMmztENa5Tj1mujC7mkEeg3M2ZMnXrlFSQofBYUNKeSc4AdkuCLaSjXVKGHoiMh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlnM661F0zJ4703;
	Tue,  6 Jan 2026 18:23:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D53640570;
	Tue,  6 Jan 2026 18:23:48 +0800 (CST)
Received: from localhost (10.48.149.114) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 10:23:45 +0000
Date: Tue, 6 Jan 2026 10:23:44 +0000
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
Subject: Re: [PATCH 08/11] clk: imx: imx31: Simplify with scoped for each OF
 child loop
Message-ID: <20260106102344.00003201@huawei.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-8-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
	<20260105-of-for-each-compatible-scoped-v1-8-24e99c177164@oss.qualcomm.com>
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

On Mon, 05 Jan 2026 14:33:46 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I guess this is papering over similar compatibility issues with old DT
as the previous one (so fsl,imx-osc26m which may or may not have fallback
compatible to fixed-clock).

Jonathan

> 
> ---
> 
> Depends on first patch.
> ---
>  drivers/clk/imx/clk-imx31.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
> index 4c8d9ff0b2ad..962eccac63ce 100644
> --- a/drivers/clk/imx/clk-imx31.c
> +++ b/drivers/clk/imx/clk-imx31.c
> @@ -123,18 +123,15 @@ static void __init _mx31_clocks_init(void __iomem *base, unsigned long fref)
>  
>  static void __init mx31_clocks_init_dt(struct device_node *np)
>  {
> -	struct device_node *osc_np;
>  	u32 fref = 26000000; /* default */
>  	void __iomem *ccm;
>  
> -	for_each_compatible_node(osc_np, NULL, "fixed-clock") {
> +	for_each_compatible_node_scoped(osc_np, NULL, "fixed-clock") {
>  		if (!of_device_is_compatible(osc_np, "fsl,imx-osc26m"))
>  			continue;
>  
> -		if (!of_property_read_u32(osc_np, "clock-frequency", &fref)) {
> -			of_node_put(osc_np);
> +		if (!of_property_read_u32(osc_np, "clock-frequency", &fref))
>  			break;
> -		}
>  	}
>  
>  	ccm = of_iomap(np, 0);
> 


