Return-Path: <dmaengine+bounces-10404-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H4xDxb2A2o7BQIAu9opvQ
	(envelope-from <dmaengine+bounces-10404-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:55:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77852D0BF
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA163006143
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB343803E9;
	Wed, 13 May 2026 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLOY+Hp/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52B375F7C;
	Wed, 13 May 2026 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644472; cv=none; b=VVrkpfAcFiOYgf+0qUfK3teHiCzZg1sFrlKqGAhaF7Ym9hr9floeYaoCz5C2CJF28gGa88rSZYCh6QCXTP3CO0bT6pKMFueikqwKsHRBgwyw0ZSqBCFcQn1Tch9W1yYc7RoKVDMp/yKjfTo8DuQbM1qISQBYoLAm5S7w4hZBuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644472; c=relaxed/simple;
	bh=p4u93eZYM7ImmEMVxoOiAAqCgTpTSRI042sRxK1qoek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+hvmhxLfntk+WbmY/7aD0VknEDwsdA4V0xTG9Ca/+Y5swrqIyA8mrVB5SroHFNZZNfEDSnQXM/tmpZhE9xrhD0ujqzzXMk5mz1OY3Yla0u++CywdbReZ3OVakxjFYUcdEA9PZd1LqEt4mH69rt1xgC3PO84bUKPiAXOkrQ6H/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLOY+Hp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FEFC2BCC7;
	Wed, 13 May 2026 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644471;
	bh=p4u93eZYM7ImmEMVxoOiAAqCgTpTSRI042sRxK1qoek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FLOY+Hp/LYnNHfJh86CHnyGWTG0G8wwrWyPrCavpinVbn2kYpTPxKC3gvXgh/CqdU
	 qRb4tpfvd/KXzloBIzYfWaacxcg7Xbe4C6mzmsRIXYjOFc16PU2wK9ViOAAL6WYWzd
	 SCCnhoVSg+DgPehJBUSU6g7cTWMzTuI02RkyyP9iqIChuklRhJd7J6T69X9eePXgJO
	 626du6/d1rMV0x6QtWBnXQyCtXafAY8e0ge24Ns6Wv10miwfuvHudoqFzfbYG1B/sv
	 2z1vKLPKic3j1PVuXz+OdjzCoR7vzrCTCcx6woCLnW5jrxAwOoSBrVoMZeCGNo+DP7
	 fAeil9AVNnhMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/23] dmaengine: sdxi: Complete administrative
 context jump start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-10-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-10-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:54:30 +0000
Message-Id: <20260513035431.41FEFC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: AD77852D0BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10404-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using a non-atomic 64-bit fallback for a hardware doorbell registe=
r causes torn writes and device state corruption on 32-bit architectures.
--

commit 1c8a47b1b7cac23ca82b3d7ffe7b54c6cf98827e
Author: Nathan Lynch <nathan.lynch@amd.com>
dmaengine: sdxi: Complete administrative context jump start

This commit completes the SDXI administrative context initialization by
writing to its doorbell once the function is placed in the active state.
It introduces a new helper function for pushing the doorbell, which will
be used across all descriptor submission paths.

> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 65b773446ba31..8dd6beb7a6424 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -7,6 +7,7 @@
>  #define DMA_SDXI_CONTEXT_H
> =20
>  #include <linux/dma-mapping.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

Does including linux/io-64-nonatomic-lo-hi.h in a shared header risk
polluting the compilation unit? It appears this might blindly convert all
missing 64-bit I/O operations into non-atomic fallbacks for any file that
includes context.h.

>  #include <linux/types.h>
> =20
>  #include "hw.h"

[ ... ]

> @@ -58,4 +59,9 @@ struct sdxi_cxt {
> =20
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
> =20
> +static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 inde=
x)
> +{
> +	iowrite64(index, cxt->db);

On 32-bit architectures without native 64-bit I/O, the non-atomic fallback
splits this 64-bit write into two 32-bit writes (lower 32 bits, then upper
32 bits).

Since this is a doorbell register that triggers hardware actions, could a t=
orn
write expose a transient, invalid index to the device before the upper bits
are written?

For example, if the index crosses a 32-bit boundary, the hardware might
observe a corrupted index and begin processing an invalid ring state.

Should the driver depend on CONFIG_64BIT if atomic 64-bit writes are
mandatory, or use a safe, hardware-specific 32-bit doorbell mechanism
instead?

> +}
> +
>  #endif /* DMA_SDXI_CONTEXT_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D10

