Return-Path: <dmaengine+bounces-8067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D3CF7C09
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0B330CDCB9
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F5322B7F;
	Tue,  6 Jan 2026 10:17:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2B30F7FE;
	Tue,  6 Jan 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694663; cv=none; b=keA7XdjJleOdCsKEsjVYq24DnIFyqDcl2gDsLi6s5hencjsKQ510Ex+/ppW87oKo8uZCjNT7nw3yRXrBmwyr+s+kRaYzFob3RQ0Rw/3hcEqLx1ThCH+qPEtBAfR86gmQ5lYb9F3udGm1ZB28Qxx3tvnDT15R+TIaIXt5FdzybI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694663; c=relaxed/simple;
	bh=WQ8hmn+buMgJNRJVF+xXil3IKBQiymPevLTWOD3c11s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqaw0kUp9Pe3oyFForK9RAIitPUJIDY4TsFul7b40X5GkMCLilYKt7zjhxsC+x+o6KUXJQMkGkdxh7S4ky4itC8+pLnak2sRl7k+9uUpj9EfsB0Pc7/2GHohUEgBs66e8InE0UMG4pAKds4uDBm3mqpj0TO+i/mRqPuW5244fTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlnCz32yTzHnHX4;
	Tue,  6 Jan 2026 18:17:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D87E4056A;
	Tue,  6 Jan 2026 18:17:39 +0800 (CST)
Received: from localhost (10.48.149.114) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 10:17:37 +0000
Date: Tue, 6 Jan 2026 10:17:33 +0000
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
Subject: Re: [PATCH 06/11] cdx: Simplify with scoped for each OF child loop
Message-ID: <20260106101733.000059e9@huawei.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-6-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
	<20260105-of-for-each-compatible-scoped-v1-6-24e99c177164@oss.qualcomm.com>
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

On Mon, 05 Jan 2026 14:33:44 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
I'd be tempted to make one more tweak in this one to bring
it inline with the suggestions around not combining scoped cleanups
with gotos (see the comments in cleanup.h)

No bug here, just nice to have.
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/cdx/cdx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index b39af2f1937f..bbde529aaa93 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -608,7 +608,6 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  {
>  	struct cdx_controller *cdx;
>  	struct platform_device *pd;
> -	struct device_node *np;
>  	bool val;
>  
>  	if (kstrtobool(buf, &val) < 0)
> @@ -623,10 +622,9 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  	cdx_unregister_devices(&cdx_bus_type);
>  
>  	/* Rescan all the devices */
> -	for_each_compatible_node(np, NULL, compat_node_name) {
> +	for_each_compatible_node_scoped(np, NULL, compat_node_name) {
>  		pd = of_find_device_by_node(np);
>  		if (!pd) {
> -			of_node_put(np);
>  			count = -EINVAL;
>  			goto unlock;
break instead.
Or better yet a follow up patch to use guard() for the mutex allowing a
direct return here.


>  		}
> 


