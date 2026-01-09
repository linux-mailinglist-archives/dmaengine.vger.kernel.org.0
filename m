Return-Path: <dmaengine+bounces-8179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE92D0B9F9
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4CCE3046A26
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86156365A1A;
	Fri,  9 Jan 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz6KMZGO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060C3644AD;
	Fri,  9 Jan 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979355; cv=none; b=QjGTV+u2gDfV2cQyzxeUe7Nd1fVP1mX3PCC1rWsA35+BJsAVN0wbm1yPM36HWpVyYsbJ0xWOzuSNTT0NgukSWHt1T0nf2ZYLPvpFWrMtXrUpYKBJt1JKFWeXVB6RG1sHVy5yLgl2uPiXp/WE3yXar4Fq4ori6M/Q9khTgRrBHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979355; c=relaxed/simple;
	bh=ANMtR/alobtcTc1B2UvZS7tSAS69B3p/g2Gc9BywPbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4gt1OqfNr0Y1ix5RAf8n4wMAiF6XMUvBn7axw3+5SF2EL/l1UOn6iGWZn5MagBnxgk8h0EDM2xH8D007dzLQna5mRVhnX35U1rtL96alv2W56lZDV+DdlJJ6CUr1fnl34FmNzOWjcWhJKdtVUOXVfULFulwoWjqOG9sOBfqr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz6KMZGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C9C4CEF1;
	Fri,  9 Jan 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979355;
	bh=ANMtR/alobtcTc1B2UvZS7tSAS69B3p/g2Gc9BywPbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nz6KMZGOR0IWeqrcGkzHUWt15KFX1u57rcmSi142rXY6IhUKCMxco2rLIZciMuJnl
	 8C/7D0f76zWMgRMyECqecQl4ck15bMVM1MqXCsEZb1sxZJ6OIzyjehuEjlzJkpqTck
	 YiVe26cVIund+DnlSquBzSPDjh6jAN/rxXUUdiUy6ekbqqe8KgbmBs/tVJIe+Nt0me
	 qvflVUseSsHMdKcTfYR7LjeuoyiYfx5oIfzugwKuNs7aNAVRmOlYijDCMm44nuzmeH
	 DAlajjQtAGsjWT5V+opkAbTE4Og3VhHVlxqHfo9CzeLphrWbyGDlxk+ssLxsfX+sU7
	 7dn2GxNm+sSIA==
Message-ID: <a6b5cf84-454e-4a43-b52f-d607c648864e@kernel.org>
Date: Fri, 9 Jan 2026 18:22:20 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] powerpc/wii: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
 <20260109-of-for-each-compatible-scoped-v3-5-c22fa2c0749a@oss.qualcomm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-5-c22fa2c0749a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/01/2026 à 17:57, Krzysztof Kozlowski a écrit :
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> 
> Depends on the first patch.
> ---
>   arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> index b57e87b0b3ce..1522a8bece29 100644
> --- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> @@ -201,11 +201,10 @@ unsigned int hlwd_pic_get_irq(void)
>   void __init hlwd_pic_probe(void)
>   {
>   	struct irq_domain *host;
> -	struct device_node *np;
>   	const u32 *interrupts;
>   	int cascade_virq;
>   
> -	for_each_compatible_node(np, NULL, "nintendo,hollywood-pic") {
> +	for_each_compatible_node_scoped(np, NULL, "nintendo,hollywood-pic") {
>   		interrupts = of_get_property(np, "interrupts", NULL);
>   		if (interrupts) {
>   			host = hlwd_pic_init(np);
> @@ -215,7 +214,6 @@ void __init hlwd_pic_probe(void)
>   			irq_set_chained_handler(cascade_virq,
>   						hlwd_pic_irq_cascade);
>   			hlwd_irq_host = host;
> -			of_node_put(np);
>   			break;
>   		}
>   	}
> 


