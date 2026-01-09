Return-Path: <dmaengine+bounces-8178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE11D0BA74
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F198F317402C
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0AB368288;
	Fri,  9 Jan 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMWxy9I1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949643659EF;
	Fri,  9 Jan 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979321; cv=none; b=q4/8T4Q05WrjQm9EnLa2Raz+DgJ9RxLVUVkPDMFQWnMEelvsJ/zNuO4mkjfJpQPq2RJxHdnECdG6x4D2JJWqzTVCB/t703CKSktYHSFwfBfncr0/grT5mSUaqB683VNxWMyjLFkWdGJFvAATfoMe0gVb/9ulj+5kclrbamqMcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979321; c=relaxed/simple;
	bh=G0CdK1BbKzMKU+qqbitcHl4o9Pf/LHQ1vf98qGeQbYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFUaBIpcmHwjwasjaEuto3g/MeetL5WXz1gS7eMXHclT6lcx2pHE9/LES0wK011h13SfS5loShbtrf5deWwBt7rmq/YJUL5ipOJ8xAFS3SBPCT2TFFLMiPLmXpnF6N++jl/mrKExgRsMdsYQH9UBVjD0ITzxPkkO0UiDU4qA80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMWxy9I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1AC4CEF1;
	Fri,  9 Jan 2026 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979321;
	bh=G0CdK1BbKzMKU+qqbitcHl4o9Pf/LHQ1vf98qGeQbYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fMWxy9I1T3LHdLmPtdMUL88DS3wYXB71qViQVOCn0+8QCbajTFBrfCs8mqRUXy+Y4
	 4E+eBYsitwzT/qE/4+xLri8dA5feTyUtep33ImpFVLB2+Wxssd+JDlhKBMSAEgTwgb
	 jnchWeKlErbxlJm9dPOlSzhoP46/HA2MEdAQR6j1cvUjT1Z48s7+DCjf3C8gGAwNSr
	 BUXYSgbI6w2J7+HijlF38X8OoLlcZ7PktPyZMuYV6gFQjkfwBvlk7LRC/7Nd22e6Z+
	 gB/+xmfzZzhw6BchvPsR2Qael3H05SiSbrl7pdb++/DLGljx6tybl/LamhByeVke5T
	 r+n5loRskMeeA==
Message-ID: <48faa7b1-d486-406a-a8c4-a1c9609e7fc6@kernel.org>
Date: Fri, 9 Jan 2026 18:21:47 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] powerpc/fsp2: Simplify with scoped for each OF
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
 <20260109-of-for-each-compatible-scoped-v3-4-c22fa2c0749a@oss.qualcomm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-4-c22fa2c0749a@oss.qualcomm.com>
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
>   arch/powerpc/platforms/44x/fsp2.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
> index f6b8d02e08b0..b06d9220844c 100644
> --- a/arch/powerpc/platforms/44x/fsp2.c
> +++ b/arch/powerpc/platforms/44x/fsp2.c
> @@ -199,16 +199,14 @@ static irqreturn_t rst_wrn_handler(int irq, void *data) {
>   
>   static void __init node_irq_request(const char *compat, irq_handler_t errirq_handler)
>   {
> -	struct device_node *np;
>   	unsigned int irq;
>   	int32_t rc;
>   
> -	for_each_compatible_node(np, NULL, compat) {
> +	for_each_compatible_node_scoped(np, NULL, compat) {
>   		irq = irq_of_parse_and_map(np, 0);
>   		if (!irq) {
>   			pr_err("device tree node %pOFn is missing a interrupt",
>   			      np);
> -			of_node_put(np);
>   			return;
>   		}
>   
> @@ -216,7 +214,6 @@ static void __init node_irq_request(const char *compat, irq_handler_t errirq_han
>   		if (rc) {
>   			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
>   			      np, rc);
> -			of_node_put(np);
>   			return;
>   		}
>   	}
> 


