Return-Path: <dmaengine+bounces-8582-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK1WIw6We2nOGAIAu9opvQ
	(envelope-from <dmaengine+bounces-8582-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 18:17:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B49B2BBC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 18:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E8D304CA55
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48B346A01;
	Thu, 29 Jan 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN4zAYJX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512726CE32;
	Thu, 29 Jan 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706842; cv=none; b=SR9NI1J05eroZp3qGP5HaHzY2voPajiFcZCZN3OYKIk4M0nZ4Jk/7TOyio4Rhp0P+2DuKrAXxlDFuC4IwKieduZLR26QzxOn8kEqouBhEKf2v7Ypyr7I6swqACJOpq/gkojct8lth7ngqx2zNCpH6CLQXOz6UfNJMYSkZpjJAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706842; c=relaxed/simple;
	bh=27kNKSKigZ302oO4twnPMLC0uG5HbWa0Z1KJS0oe/D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4ETeOWKNtVc1UST6z0dnxEZ8a+p4vqDBFRmLzMuPnTT0TDUZQaOcRP9/AXhGGdVptnQM90At+X2QVhXIgqd97IUgWyhudAcuf0A4RvkWv/uPIx3uKuzJqhy3mrWQVnIanZt/zCAW4F96C8gkX++l0ZcJ9NSZ4ffx3MUPXzCdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN4zAYJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B720BC4CEF7;
	Thu, 29 Jan 2026 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706841;
	bh=27kNKSKigZ302oO4twnPMLC0uG5HbWa0Z1KJS0oe/D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN4zAYJXAZpEy3d6ProYbKGSY739oMbmdfcn5NU4TuOi72e2duwvu2H4xBEsLEWiC
	 +JfvZeFm2UoEdMRZd47svwmODAxX4pi3zeaF22UV2W/nuE39wNgGsFhdZlmYMie1ta
	 Nx/EhbK+wOMQoo6E+UtPTGBdAU+fTt5ml2q7wY8+UX2f35E1r04rmfWgxcV1rW4H0s
	 q2/gPbIS54mC4uNOSqn1qmQZyZzuBAZEE6VlKzYlw5CsXsJoYKtAcDPJPCQ4gB16cp
	 foi/HCKIAOHR6emQmWYkoPwzBE2XfhY7zv2hG+EzWGi58mMWxeiYd7rERf/JO/Mpv6
	 wDcR4TVpKurRA==
Date: Thu, 29 Jan 2026 11:14:00 -0600
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 00/12] of/treewide: Simplify with
 for_each_compatible_node_scoped()
Message-ID: <20260129171400.GA1287342-robh@kernel.org>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,armlinux.org.uk,microchip.com,bootlin.com,tuxon.dev,samsung.com,linux.ibm.com,ellerman.id.au,amd.com,nxp.com,baylibre.com,pengutronix.de,linaro.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,lists.ozlabs.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-8582-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 38B49B2BBC
X-Rspamd-Action: no action

On Fri, Jan 09, 2026 at 05:57:44PM +0100, Krzysztof Kozlowski wrote:
> Dependencies/merging
> ====================
> 1. First patch is a prerequisite for entire set, so either everything
>    goes via same tree, the further patches wait a cycle or stable tag is
>    shared from DT tree.
> 
> 2. The last media patch depends on my earlier cleanup.
> 
> Changes in v3:
> - New patch: cdx: Use mutex guard to simplify error handling
> - Collect tags
> - Link to v2: https://patch.msgid.link/20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com
> 
> Changes in v2:
> - Update also scripts/dtc/dt-extract-compatibles (Rob)
> - Collect tags
> - Link to v1: https://patch.msgid.link/20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com
> 
> Description
> ===========
> Simplify for_each_compatible_node() users with a new helper -
> for_each_compatible_node_scoped().
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (12):
>       of: Add for_each_compatible_node_scoped() helper
>       ARM: at91: Simplify with scoped for each OF child loop
>       ARM: exynos: Simplify with scoped for each OF child loop
>       powerpc/fsp2: Simplify with scoped for each OF child loop
>       powerpc/wii: Simplify with scoped for each OF child loop
>       cdx: Simplify with scoped for each OF child loop
>       cdx: Use mutex guard to simplify error handling
>       clk: imx: imx27: Simplify with scoped for each OF child loop
>       clk: imx: imx31: Simplify with scoped for each OF child loop
>       dmaengine: fsl_raid: Simplify with scoped for each OF child loop
>       cpufreq: s5pv210: Simplify with scoped for each OF child loop
>       media: samsung: exynos4-is: Simplify with scoped for each OF child loop

I applied all but the last patch which did not apply for me. Send it 
next cycle.

Rob

