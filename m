Return-Path: <dmaengine+bounces-10446-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBrSKGn0BGoTQwIAu9opvQ
	(envelope-from <dmaengine+bounces-10446-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:00:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998153B359
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77A43030B3A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44E3CA4B6;
	Wed, 13 May 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP5iX2g8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E73CA491
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709607; cv=none; b=oMUk0reL5ophJFXwq2ldsALdwM530pDG3LB677cRHfMrd6QR/LNAu+sODg2/uUMt2lP285sSIg51Ssy3NpndyxGTdk4t+KdoAohfFC9bGlf5Ntwu5y5Kg7BzWfdVa7O/F0Y1SV8KK8e55o1ZfuPl1286LeKoVllVWToLu1RCC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709607; c=relaxed/simple;
	bh=thXbI+Qg3i7kPd7ZMNuFEGpoSW9eUuB1V1DEqFPe0RM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQM1B5airVeTm/DZeMY34rX2rWCPIpnSwD29o6aNq+FGwK1nMe9P4Zq1h+HADUmPgQ9ZoVUzJDq+XPawKNaBR6bPUhxD2vFNykJ0BJyILwiwsJRcls/Krwyig7d6XTw118zFhqH1tPVDmoUmXstizhmlb4ejT4Fg1KqsHfdcl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP5iX2g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80A4C19425;
	Wed, 13 May 2026 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778709606;
	bh=thXbI+Qg3i7kPd7ZMNuFEGpoSW9eUuB1V1DEqFPe0RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AP5iX2g82c/9zami1uyIloMcn34tmzEuDY3xkJgcwrOzNcY7AoRoyHbXHGKSPcOTD
	 GxVw+DKTZjOmvsgH5gWZAv/QSA1Fyy4M79AFNZ55IJmXOE+FHYxoQeO5O1XbyXrEB2
	 AobOEvIodY+rzKMyoQUbJ+0HSiyVqPHtwvn3STVimIWA6n5wOsQLftwx+pDIejkl62
	 G/qUXSp0pv1A6Cq9k+yUJU9PsPAwH5fRrJRC1IC+ybb/iEwUyVkON83NEI3k6w6sFA
	 ImMHuhBfZqWQkstABKj90sn5rdlBusXXVO2+2wbwvCh822JiQcQOPYej2+bA2SqvaB
	 8kLCC9Z26w3kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL
 check on list_first_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org
In-Reply-To: <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:00:06 +0000
Message-Id: <20260513220006.A80A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0998153B359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10446-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,renesas.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Prematurely returning 0 when `ld_active` is empty skips searching =
`ld_queue`, falsely reporting queued descriptors as `DMA_COMPLETE`.
--

commit e2ab802dbc50a8c1bda80f9138ff1923d4e471e9
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()

This commit replaces list_first_entry() with list_first_entry_or_null()
when retrieving the active descriptor to avoid dereferencing invalid
memory when the list is empty.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 9f206a33dcc6b..6d80cb668957f 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
>  	u32 crla, crtb, i;
> =20
>  	/* Get current processing virtual descriptor */
> -	current_desc =3D list_first_entry(&channel->ld_active,
> -					struct rz_dmac_desc, node);
> +	current_desc =3D list_first_entry_or_null(&channel->ld_active,
> +						struct rz_dmac_desc, node);
>  	if (!current_desc)
>  		return 0;

If a client queries the status of a pending transfer before it starts,
channel->ld_active will be empty.

Does returning 0 here bypass the subsequent search of channel->ld_queue?

If the search of channel->ld_queue is skipped, will rz_dmac_tx_status()
erroneously override the status and report it as complete for an unstarted
transfer?

Could this regression cause clients to prematurely free memory buffers and
lead to a use-after-free when the hardware later executes the transfer?

Prior to this patch, the out-of-bounds pointer from list_first_entry()
bypassed the early return, resulting in a garbage cookie value that typical=
ly
didn't match the requested cookie.

The logic would then safely fall through, correctly search channel->ld_queu=
e,
and return desc->len for pending transfers.

Commit 42ad33b3ab87bf57f49fbcb8d0351a26fc1ff69d ("dmaengine: sh: rz-dmac: U=
se
virt-dma APIs for channel descriptor processing") later refactors descriptor
processing and handles the residue calculation via vchan_find_desc(), which
resolves this issue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D2

