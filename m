Return-Path: <dmaengine+bounces-8735-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN10DwJ/g2mHnwMAu9opvQ
	(envelope-from <dmaengine+bounces-8735-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:16:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A686EAEE5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC5403002928
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350133B97B;
	Wed,  4 Feb 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwI4fukI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504A3385A2;
	Wed,  4 Feb 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225150; cv=none; b=h+qvp+YSa5iBYcHsP7/DrkQ2bofqdmSfmc2PN/tgWp8F5J+eiRFyLPKzth/IRI386KNoGrQeqy0DcQnIE5Of2LKjPBykKVtCiVS62Ut1zDJtRx7DsUJzJhLXMYo4061Sw6mkfvLuV5zxJN1hpodhY6Jd7V/wDFgOKM+yrRgfac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225150; c=relaxed/simple;
	bh=TlFOCl5RoEeH2a2JYjkJuYQhNfV7w/aKiTljvj/cgS0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jwkKo9hqDR8u8pvm/HGEKTYJCFxyGEtUDU+UHbeHfh9nGyR9lLmNGzI4qlvsK+FKD0oVkMWPZc7Ouarvu52aelXcROLyureOKnM5cKOJSCJC4qkLegK+WivEYvRQ8lNWgaVzEMjbhQ+8gf4KyRDxXTV1KKhXxI6nSuHKZsyCWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwI4fukI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4983CC4CEF7;
	Wed,  4 Feb 2026 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770225150;
	bh=TlFOCl5RoEeH2a2JYjkJuYQhNfV7w/aKiTljvj/cgS0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JwI4fukIlzGuDIQ1RwqfKI5v42KKoJnT64/ghGDWEeoAMzAmjqfIvVXFB9jj+fQN0
	 vUBRLulQOBpzDuyU6WBkgAx5eUzy9AH4JtR+MIw+h2sTtXjjv1AaUwSx5x8S72mqAt
	 GuzldhYl5LTKQ91Ek+kVe+nVQOazphCWY1iH2jzTZer5hauPhCRFX2uc7+Uikt7F/O
	 1B9oW/tx/1OomSzu83D69p/5OTllHtnhwTNL2p3Z/PNAp0X9CjFCuktISZOSFsbpOP
	 JOpVfWSMTbdcyZGuDsHVxsTdu0NuwTGFaV+XjSTMQPCW7Aw/H20Mj1sWuxQ9g/cVy4
	 crOo4OeUeomWg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Alison Wang <b18965@freescale.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jingchang Lu <b35083@freescale.com>, 
 Jared Kangas <jkangas@redhat.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260113-fsl-edma-clock-removal-v1-1-2025b49e7bcc@redhat.com>
References: <20260113-fsl-edma-clock-removal-v1-1-2025b49e7bcc@redhat.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: don't explicitly disable clocks
 in .remove()
Message-Id: <177022514793.153503.544087297189278214.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 22:42:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8735-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A686EAEE5
X-Rspamd-Action: no action


On Tue, 13 Jan 2026 11:46:50 -0800, Jared Kangas wrote:
> The clocks in fsl_edma_engine::muxclk are allocated and enabled with
> devm_clk_get_enabled(), which automatically cleans these resources up,
> but these clocks are also manually disabled in fsl_edma_remove(). This
> causes warnings on driver removal for each clock:
> 
>         edma_module already disabled
>         WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1200 clk_core_disable+0x198/0x1c8
>         [...]
>         Call trace:
>          clk_core_disable+0x198/0x1c8 (P)
>          clk_disable+0x34/0x58
>          fsl_edma_remove+0x74/0xe8 [fsl_edma]
>          [...]
>         ---[ end trace 0000000000000000 ]---
>         edma_module already unprepared
>         WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1059 clk_core_unprepare+0x1f8/0x220
>         [...]
>         Call trace:
>          clk_core_unprepare+0x1f8/0x220 (P)
>          clk_unprepare+0x34/0x58
>          fsl_edma_remove+0x7c/0xe8 [fsl_edma]
>          [...]
>         ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: don't explicitly disable clocks in .remove()
      commit: 666c53e94c1d0bf0bdf14c49505ece9ddbe725bc

Best regards,
-- 
~Vinod



