Return-Path: <dmaengine+bounces-8063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954CCF7AC4
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 11:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15F16300B69E
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B630EF8C;
	Tue,  6 Jan 2026 10:06:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8523A1E96;
	Tue,  6 Jan 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693998; cv=none; b=l+fgvwZOyHkfzFYAwuIU33E6Dy19pKPMMt7a1XbuseVuVf7b7e1fB0O5IcSX5wVPusiguVMZtg9Ge8nri+xe0WTw0Cg3lSsMSVDP3kmphB3Yp2vPtCTVeZdxRp0ASTRx4rr8OXA8JxLKFsJdkVBmKQr0kVNUaBQplZr/SLu5Xb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693998; c=relaxed/simple;
	bh=Zxb5JIv4WQfFSQmQlGyJqOvczI1NrVdfoGBC5hMq+e4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo+dkJBlEjscT+wsqIAWrByedvs/JzvKTmYY6O7DHneZBI82moJUysaSLghOAmOjQzp3uuO0Ma62iQy/vYta5GHXzCgxSQwh/gSsCGTL3puyGmHwSWTfLC10v0DyFJWEtC4y3dirt0QwktWqo7i5+qJPpKoYPeSWc1baIIF7lOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlmzD5H6QzJ4722;
	Tue,  6 Jan 2026 18:06:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2015740565;
	Tue,  6 Jan 2026 18:06:34 +0800 (CST)
Received: from localhost (10.48.149.114) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 10:06:31 +0000
Date: Tue, 6 Jan 2026 10:06:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Russell King
	<linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Krzysztof Kozlowski <krzk@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Abel Vesa
	<abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<llvm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
	<dmaengine@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 02/11] ARM: at91: Simplify with scoped for each OF child
 loop
Message-ID: <20260106100630.000073b6@huawei.com>
In-Reply-To: <20260106100429.00001852@huawei.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
	<20260105-of-for-each-compatible-scoped-v1-2-24e99c177164@oss.qualcomm.com>
	<20260106100429.00001852@huawei.com>
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

On Tue, 6 Jan 2026 10:04:29 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Mon, 05 Jan 2026 14:33:40 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > Use scoped for-each loop when iterating over device nodes to make code a
> > bit simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>  
> Interesting bit of code. I guess there is some history here that didn't
> get captured as a comment?
> 
> > 
> > ---
> > 
> > Depends on the first patch.
> > ---
> >  arch/arm/mach-at91/pm.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> > index 35058b99069c..68bb4a86cd94 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -982,15 +982,12 @@ static void __init at91_pm_sram_init(void)
> >  	struct gen_pool *sram_pool;
> >  	phys_addr_t sram_pbase;
> >  	unsigned long sram_base;
> > -	struct device_node *node;
> >  	struct platform_device *pdev = NULL;
> >  
> > -	for_each_compatible_node(node, NULL, "mmio-sram") {
> > +	for_each_compatible_node_scoped(node, NULL, "mmio-sram") {
> >  		pdev = of_find_device_by_node(node);
> > -		if (pdev) {
> > -			of_node_put(node);
> > +		if (pdev)
> >  			break;
> > -  
> 		}
> I'm curious if there are DT out there that ever causes the code to get to 
> here?  There might be multiple mmio-sram nodes but if there were seems unlikely
> the driver wants which ever one has a pdev at a given point in time.
> That feels like a weird race condition. So in practice I'd expect this to
> always either get the first one, or none.
> e.g. Why this can't just be
> 
> node = of_find_node_by_name("mmio-sram);
ah. Not name obviously.  Need more coffee.
of_find_compatible_node()

> if (node) {
> 	pdev = of_find_device_by_node(node);
> }
> 
> or something along those lines.
> 
> Given risk of a regression maybe better to do what you have here.
> So with that in mind
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> >  	}
> >  
> >  	if (!pdev) {
> >   
> 


