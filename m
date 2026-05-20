Return-Path: <dmaengine+bounces-10588-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PXoHxZHDmpc9gUAu9opvQ
	(envelope-from <dmaengine+bounces-10588-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:43:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3F59CDC6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 042D33025D56
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0939355F2A;
	Wed, 20 May 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyJzSUdY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7F29C328;
	Wed, 20 May 2026 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779319841; cv=none; b=Qat1UuZ0zvwgkl+vIJ8vcFNdA9N+3zulEaxSzd6DESPH5ibW2KaTVE4KRBDHelK+5VwcLqL81oHX33xQN835IHkIVVJkbjXxzVdHIMZC2wqFI5AwZ68Y8wDAT1Y3DiRx6L3k96mjiD+RWS19pjslxQjxmd1vmdUkP0SSXJ7NMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779319841; c=relaxed/simple;
	bh=ijp6pU2joaXEp8/nLchRfu0rpFCdg4vEavyWAIdsxqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQzz0+slK3C3wG7gSMuLmbTiV0A4nqEG0zX67DVuUUIK5fX/4ONkIt7aU5LylpO2oiRmsAiKlqGDNp54KwLE5P3NeX0ONtbm7m73dSpVQFSewPb3jGAxVWfVjElqH2wrrX5WJz04wHv4A047MnTB60FhRCYcF1MrE3kut8rjE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyJzSUdY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A41F000E9;
	Wed, 20 May 2026 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779319840;
	bh=X0jNsFx+L8ehACylBrSQz0VKXOFNBX78N+yapB7A2j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyJzSUdYi4DU7aFFFKJ9FOlqHj+xp4Nx/oanESzWTWS1rOisUD1Chlx9/eTE33yMF
	 6fg5pAlxEnTTU2jXjU/rWjlDOSCO/qezVReJQf9WvOt3/cLBn++VzGDWdlaff0t27E
	 PqQMuJR9bbpe+RN9QvX6rRpNITSyqOd8XyGrNyj0BWtxqNh6Ir3me6OcH8UHLN2lUf
	 YT7HXSWcusF1O7WuYg8MF2z/6U8vhwmwizkT2t7zooZExWYj4KuCN0WSZB0EbS8QFJ
	 2sDgxCE+6v++RMim/U5eEkQP0zdvHestPsIdQB0SAYMyVVjcw7YfJlk3DPndbbbGzN
	 zFd9VN12vEtrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: bestcomm: Enable compile testing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, dlemoal@kernel.org, vkoul@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260520223704.39320-1-rosenp@gmail.com>
References: <20260520223704.39320-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 23:30:39 +0000
Message-Id: <20260520233040.100A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10588-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 8BD3F59CDC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Relaxing the dependency of PATA_MPC52xx causes a link failure on un=
supported PowerPC platforms under COMPILE_TEST due to an undefined referenc=
e.
--

commit 950d74a4a60c655a1252de12aa32ba4329c5e07c
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: bestcomm: Enable compile testing

Allow the BestComm DMA engine to be selected for PowerPC compile-test build=
s,
and update the PATA_MPC52xx dependency to rely directly on PPC_BESTCOMM.

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index fff305ec1e788..462cbb01567c3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -823,7 +823,7 @@ config PATA_MARVELL
> =20
>  config PATA_MPC52xx
>  	tristate "Freescale MPC52xx SoC internal IDE"
> -	depends on PPC_MPC52xx && PPC_BESTCOMM
> +	depends on PPC_BESTCOMM

[Severity: Low]
Will relaxing this dependency introduce a regression on unsupported PowerPC
platforms under COMPILE_TEST due to a link failure?

Because PPC_BESTCOMM now allows COMPILE_TEST on any PPC architecture,
PATA_MPC52xx can also be built on architectures other than MPC52xx or MPC51=
2x.

However, drivers/ata/pata_mpc52xx.c unconditionally calls
mpc5xxx_get_bus_frequency(), which is implemented in
arch/powerpc/sysdev/mpc5xxx_clocks.c.

Since mpc5xxx_clocks.c is only compiled when CONFIG_PPC_MPC512x or
CONFIG_PPC_MPC52xx is enabled, building this driver on other PowerPC
architectures (like PPC64) might result in an undefined reference to
mpc5xxx_get_bus_frequency() at link time.

>  	select PPC_BESTCOMM_ATA

[ ... ]

> diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
> index 5dd437295964d..153b5492c93c7 100644
> --- a/drivers/dma/bestcomm/Kconfig
> +++ b/drivers/dma/bestcomm/Kconfig
> @@ -5,7 +5,7 @@
> =20
>  config PPC_BESTCOMM
>  	tristate "Bestcomm DMA engine support"
> -	depends on PPC_MPC52xx
> +	depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
>  	default n
>  	select PPC_LIB_RHEAP

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520223704.3932=
0-1-rosenp@gmail.com?part=3D1

