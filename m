Return-Path: <dmaengine+bounces-12221-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URPeCn+0T2osnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12221-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:47:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5A732725
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:47:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=PUzFH9mS;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12221-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12221-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15480319BA68
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E233507C;
	Thu,  9 Jul 2026 14:26:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2744331EDB
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:26:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607198; cv=none; b=IyRzZI4RqEYH3OsPl6o/0QfJPGyJfbTJEspzRW9X7BnUWRSYgEiVX1VPNIydS1EysZE6QFjJWvJCX8B8t+Azs8FGYQe+LliooepBxDxHUOD28Zuws8y4joa8gfwivIlrxJwX3dkI6V88NK+AOGwHpi3iiSP23qSWrqebU8KaUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607198; c=relaxed/simple;
	bh=h1ju3EVqaKp6EYSTzX8YR5qdeLvUidypMDyLlo7QjJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBIedRFpb+qJqZ+FhydF8FLKhR2AhS7pK7C+7XaAbUwHUkXljFMPsG70lqKSpuS45FNf3ZZJii6z4VUrz+wQINuHX7gMXBMJZ9I3ArNjsdM8xZERYy/a7SfdLsDL003b9/f91cxoi0tGE1zC983knMat+xcZ/IdIrQ36BT/B5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PUzFH9mS; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ULW9
	VBv4cRlM6iC85iVcPrTJ/RUoBanK7j5g1mX7o9s=; b=PUzFH9mSrFXR0BT7bcHZ
	Edu7cwpTc+qJ+OrNpmfIGFDVhxIXkWvuhCfoFDFMwIRDsg61YTEhJsUS9CVKi6az
	P6v9kZs22j7OxfFuONh4fL96A7/4aZXTeYEKXEFLvDnbaWjtQMvRU/sqEcZFKEHD
	8CbLj3eD9wSCrMFlNxTu44NT6Nq72wdBYP4Zha/eGHVeKZZ2hJbbBLrepfix+5y8
	wPbx7qBDvD10x4wZ1uvqlRfiKPJQNDeM6c9wbZwAjaetlqpPufip7tXqIrrtvEGv
	yj/byiXXftAa0kvhgazHR8mM/mwB9T9fZRFwzl2sGHwDRyxeR+oELM4DKsYB1m8w
	Vg==
Received: (qmail 1163672 invoked from network); 9 Jul 2026 16:26:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jul 2026 16:26:26 +0200
X-UD-Smtp-Session: l3s3148p1@Of/AaC5WFLZQT+F6
Date: Thu, 9 Jul 2026 16:26:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS/LOONGSON1 ARCHITECTURE" <linux-mips@vger.kernel.org>,
	"moderated list:MEDIATEK DMA DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:MEDIATEK DMA DRIVER" <linux-mediatek@lists.infradead.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	"open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
	"open list:ARM/RISC-V/RENESAS ARCHITECTURE" <linux-renesas-soc@vger.kernel.org>,
	"moderated list:STM32 DMA DRIVERS" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/26] dmaengine: Remove redundant error messages on IRQ
 request failure
Message-ID: <ak-vkQ8g_ePdY15f@shikoro>
References: <20260709135846.97972-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-12221-lists,dmaengine=lfdr.de,renesas];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:keguang.zhang@gmail.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:afaerber@suse.de,m:mani@kernel.org,m:daniel@zonque.org,m:haojian.zhuang@gmail.com,m:robert.jarzmik@free.fr,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:orsonzhai@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:patrice.chotard@foss.st.com,m:amelie.delaunay@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:ldewangan@nvidia.com,m:jonathanh@nvidia.com,m:thierry.reding@kernel.org,m:vigneshr@ti.com,m:hayashi.kunihiko@socionext.com,m:mhiramat@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:andersson@kernel.org,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:claudiu.beznea.uj@bp.renesas.com,m:biju.das.jz@bp.
 renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:john.madieu.xa@bp.renesas.com,m:thomasandreatta2000@gmail.com,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-actions@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:linux-tegra@vger.kernel.org,m:keguangzhang@gmail.com,m:matthiasbgg@gmail.com,m:haojianzhuang@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:zhanglyra@gmail.com,m:mcoquelinstm32@gmail.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,gmail.com,mediatek.com,collabora.com,suse.de,zonque.org,free.fr,sifive.com,glider.be,linux.alibaba.com,foss.st.com,nvidia.com,ti.com,socionext.com,oss.qualcomm.com,iscas.ac.cn,quicinc.com,bp.renesas.com,renesas.com,lists.linux.dev,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shikoro:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sang-engineering.com:from_mime,sang-engineering.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2C5A732725

On Thu, Jul 09, 2026 at 09:58:04PM +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10 ("genirq/devres: Add
> error handling in devm_request_*_irq()") added automatic error logging
> to devm_request_threaded_irq() and devm_request_any_context_irq() via
> the new devm_request_result() helper. The helper prints device name,
> IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this automatic
> logging.
> 
> This series removes the now-redundant dev_err() and dev_err_probe() calls
> in dmaengine drivers that follow these devm_request_*_irq() functions,
> as the core now provides more detailed diagnostic information on failure.
> 
> Pan Chuang (26):
>   dmaengine: fsl-edma-main: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: fsl-qdma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: loongson-loongson1-apb-dma: Remove redundant
>     dev_err()/dev_err_probe()
>   dmaengine: mediatek-mtk-cqdma: Remove redundant
>     dev_err()/dev_err_probe()
>   dmaengine: mediatek-mtk-hsdma: Remove redundant
>     dev_err()/dev_err_probe()
>   dmaengine: mmp_pdma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: moxart-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: owl-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: pxa_dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: qcom-gpi: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sf-pdma-sf-pdma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sh-rz-dmac: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sh-shdmac: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sprd-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: st_fdma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: stm32-stm32-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: stm32-stm32-dma3: Remove redundant
>     dev_err()/dev_err_probe()
>   dmaengine: stm32-stm32-mdma: Remove redundant
>     dev_err()/dev_err_probe()
>   dmaengine: sun4i-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: sun6i-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: tegra20-apb-dma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: ti-edma: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: uniphier-xdmac: Remove redundant dev_err()/dev_err_probe()
>   dmaengine: xgene-dma: Remove redundant dev_err()/dev_err_probe()

One patch per subsystem for such trivial changes, please.


