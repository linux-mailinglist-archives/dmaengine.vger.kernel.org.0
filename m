Return-Path: <dmaengine+bounces-8029-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E4CF3FFE
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E146C317FA9C
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A6283FD4;
	Mon,  5 Jan 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vytZmFC1"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69879254B19;
	Mon,  5 Jan 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620517; cv=none; b=SXFcVHYiil8Ot3x38aSLX4bcX4CD+HOGSlG76O7u5mpesom2xwTVgLUiImWSE48ZsMrc3TiZ7fxQt63Obhe2loqS0H5rU3LBpiiCS83sajnwT7+/7oam5DqBfJ0CTtsCIs+MJqXp28aL5O5yKfpG7thRwa9DhubEAJDki1GhHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620517; c=relaxed/simple;
	bh=a3Sj0a26r3lVQlAJmFwNu/sL9HQAEQqcEw3msVeSpzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fcl+jfEMe/mNUFn6zmJq9yVULWGvO/XBC7yWTd6Arrgtdv3dchWYqSC0QwAmrN97Ka1Iltejqt3US6youl0vze6DHP7VqHh2ayS8FnFxu9P2T04IVh0FSaqR7uyO62EuM/p9niW2pnmSTPeVi7zCS8tyTR+UCfmHp1WqGCNKI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vytZmFC1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1767620514; x=1799156514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a3Sj0a26r3lVQlAJmFwNu/sL9HQAEQqcEw3msVeSpzM=;
  b=vytZmFC1inOCa0CmBOTec6lCQHktGHtYs0j1yF+KbGznCOoobE9c0mb5
   qbsf3pFBLtO7dpMx13/+g9lRkX5viZWKLpDIHKWUTencZzfXW0WWR2W2t
   9SnCJu4av6vtKJ1HwGwPpeCT8+OlH4gFOiohUb5uMtIyq8I6JU6hte+Cg
   PwSdeCtCbF5rBKYj9aTRZu+sArpltNL1v2ynSYOAXQuUgzAVeVf25gp5Y
   1BKgmvPbJvqIVc/JvlFZBim05Hjqj+YCxpr7YChpQ/GpNN/S0iBquzoro
   xaKjXC/fSCf5RztQgM8+G2G0yb9QTK3sXjad6g44c5rNmF7cptvFZ/Ta9
   w==;
X-CSE-ConnectionGUID: HBkZ5l8JRtWI55dHimVviw==
X-CSE-MsgGUID: JZGd2c01Rd6FFUdxsxi0Mw==
X-IronPort-AV: E=Sophos;i="6.21,203,1763449200"; 
   d="scan'208";a="58252843"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2026 06:41:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 5 Jan 2026 06:41:52 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 5 Jan 2026 06:41:43 -0700
Message-ID: <49ebaa9d-cad9-42cd-8bb9-5210fe18eeb5@microchip.com>
Date: Mon, 5 Jan 2026 14:41:47 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] ARM: at91: Simplify with scoped for each OF child
 loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Miguel Ojeda
	<ojeda@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Russell King
	<linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Krzysztof Kozlowski
	<krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<llvm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
	<dmaengine@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Krzysztof,

On 05/01/2026 at 14:33, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks for handling this!
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
> 
> Depends on the first patch.
> ---
>   arch/arm/mach-at91/pm.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 35058b99069c..68bb4a86cd94 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -982,15 +982,12 @@ static void __init at91_pm_sram_init(void)
>          struct gen_pool *sram_pool;
>          phys_addr_t sram_pbase;
>          unsigned long sram_base;
> -       struct device_node *node;
>          struct platform_device *pdev = NULL;
> 
> -       for_each_compatible_node(node, NULL, "mmio-sram") {
> +       for_each_compatible_node_scoped(node, NULL, "mmio-sram") {
>                  pdev = of_find_device_by_node(node);
> -               if (pdev) {
> -                       of_node_put(node);
> +               if (pdev)
>                          break;
> -               }
>          }
> 
>          if (!pdev) {
> 
> --
> 2.51.0
> 


