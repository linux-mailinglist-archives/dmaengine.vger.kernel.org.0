Return-Path: <dmaengine+bounces-11031-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JhmJtWQGWrVxggAu9opvQ
	(envelope-from <dmaengine+bounces-11031-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 15:12:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3D602B85
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 15:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8494F3022690
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D11DDC1D;
	Fri, 29 May 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItE31+GM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE342E62AC
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060183; cv=none; b=AZHDysO7qqn3YJW/gJ7HQhgzsG/LgGgjk8i7zEFUWKGFSMJfnXbmzm74pyhI0nhcwbfm8nai7xoDmtbrK2QVEGK5b0hUk1A0fAzVeS4VoS2/DTa6IJk1mkPku2i3k/nQwZ000mrEIV0q7MyhFHf6tU1aUzRXED/vhvh7sz1n/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060183; c=relaxed/simple;
	bh=Q6R1Bpf8i7HXSMEbcGZX+ocgnDVl8lalvz88uHrKSKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TA0RWE4mFu8fE6OyOGelyQ4Jyk6ib4FlbfiDlrS6UZLfB+ieoHsismVX+IRhwfyGfLg2Z3JUaaEckPGVg0thWyxSAr5qZpMOEUYiIuraMbaD4viecYHQTvhW/+Fv4hSuMXTw4XgQXlCixCgrg7qU52zLVGxvSztZevdoH8+D/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItE31+GM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07AF1F00893;
	Fri, 29 May 2026 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060181;
	bh=L6Ix847vSgQXpyLM6kwfABopTxeSngcXz9tKUoKEncg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItE31+GMCtt3MMxVudsEWfus/PR/jQQPyY+6fUDv8KDhBUsXljU9oDUL4h4IGrV07
	 5ZwogEgcbf9qiMtau33HzXRhgONUs8DdrT4dS7rgrUOq+UqQFTxgtOpe/7JdJJ1/nZ
	 bj3UR6VCAT571GfFm/a+mpc592RoqTJMsIJjUIyj48149PSrXorD6oVE9A718m/PT9
	 dyMCa/2XMXzBJUkptmDZ1UHzF11J4f7Vd5Qn0xb9DWv9PBje9+y9Dm8GK50bIslvQl
	 tBHOy6KAJkXpzkjUKTZgWyvoEjHd9RhUgv9/Z5UzMrPJD7xU7o1wJgBXtCMhlq6C6g
	 U2cLJES27ReMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260529122104.2533048-1-devendra.verma@amd.com>
References: <20260529122104.2533048-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 13:09:41 +0000
Message-Id: <20260529130941.A07AF1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11031-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F3B3D602B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unbounded iteration in `dw_hdma_v0_core_off()` causes out-of-b=
ounds MMIO writes to unmapped register space.
- [High] DesignWare PCIe controller glue driver bounds checks were not upda=
ted to support the new 64-channel limits.
- [Medium] Hardcoded channel limits in the PCIe endpoint driver prevent uti=
lizing more than 8 channels.
--

commit 5d2bdaca2c92c95288275a3210f192b8e7094b9e
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This commit adds support for up to 64 read and write channels in the
Designware HDMA controller driver, as per the hardware specification. It
introduces HDMA-specific macros and updates the initialization flow to use
the appropriate channel limits based on the IP version.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..79f653da8e0fd 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -61,11 +61,11 @@ struct dw_edma_pcie_data {
>  	/* eDMA registers location */
>  	struct dw_edma_block		rg;
>  	/* eDMA memory linked list location */
> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
>  	/* eDMA memory data location */
> -	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		dt_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		dt_rd[HDMA_MAX_RD_CH];

[Severity: Medium]
Will this update actually allow utilizing more than 8 channels, or do the
static configuration structures still restrict it?

While these data structures are updated to support 64 channels, the static
configuration structures like xilinx_mdb_data and snps_edda_data are left
hardcoded to 8 and 2 channels, respectively.

During probe, dw_edma_pcie_get_xilinx_dma_data() computes the channel count
using min(pdata->wr_ch_cnt, FIELD_GET(...)). Since the initial
pdata->wr_ch_cnt is capped at 8, the driver will silently restrict the numb=
er
of channels to a maximum of 8, even if the underlying IP reports support for
up to 64 channels.

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/=
dw-hdma-v0-regs.h
> index 7759ba9b4850f..48e40efceb2ea 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -11,7 +11,7 @@
> =20
>  #include <linux/dmaengine.h>
> =20
> -#define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_MAX_NR_CH			64

[Severity: Critical]
Does increasing this constant cause out-of-bounds MMIO writes during teardo=
wn?

Looking at dw_hdma_v0_core_off(), the code unconditionally iterates up to
HDMA_V0_MAX_NR_CH to disable channels, rather than using the dynamically
configured dw->wr_ch_cnt and dw->rd_ch_cnt.

Since each channel occupies 512 bytes, iterating 64 times writes to 32 KB of
register space. Existing endpoint devices like Xilinx MDB map only 8 KB of
register space.

Writing to MMIO offsets outside the mapped region can cause a translation f=
ault
or an unhandled kernel paging request, resulting in a regression.

> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e3153..da7a5cc93ad43 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
> =20
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64

[Severity: High]
Are there missing updates in the DesignWare PCIe controller glue driver
to support these new limits?

The function dw_pcie_edma_find_channels() in pcie-designware.c enforces a h=
ard
limit of EDMA_MAX_WR_CH. If a device is configured for more than 8 channels,
the check pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH will trigger and return
-EINVAL, causing initialization to fail.

Additionally, dw_pcie_edma_irq_vector() returns -EINVAL if the IRQ index
nr is greater than or equal to EDMA_MAX_WR_CH + EDMA_MAX_RD_CH, breaking
interrupts for higher channels.

This prevents the newly added feature from functioning on native host
controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529122104.2533=
048-1-devendra.verma@amd.com?part=3D1

