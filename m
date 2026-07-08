Return-Path: <dmaengine+bounces-12145-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bi3cKCicTmp8QgIAu9opvQ
	(envelope-from <dmaengine+bounces-12145-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:51:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CC729B7D
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:51:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UpFnsD9l;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12145-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12145-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCC8303CF35
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80736439350;
	Wed,  8 Jul 2026 18:51:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2226059D;
	Wed,  8 Jul 2026 18:51:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536678; cv=none; b=Tf7a22XktbllvcEZlsYlXFzXWOTT0Fa/v0dfVVyGdrdSRLhgGnBYaQfe3BUDe1/1TDbl20LAbygyNhQNzUkOVCLcOfq+Pxy4BWPv/FqZ09jZdJIz0xS3UJLKEn1gApqPZ8NSHlPOSADdMJ3Caqgay9wmNOD3N+4W3F88cReTp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536678; c=relaxed/simple;
	bh=FTJ5G32JBnNT7a3yyZz5bo9gwKK/YObMpnPfCmZuUTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oekIsnMvvU3rKjSRIxgxYs3TOqCRkWUiFMex6sl0slq8uMGooglKYCUmWBT8rUV/Po4+QJwaEfCNHZ3872yZIHvN7ogYSu0ONy2EEwYR4JS5WXrYhD86TQzSKLIJXE51G+nMbL2g0TL4oq+0wHeRd+OC/CeUbE5UgTzcJ4KkK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpFnsD9l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D08B1F000E9;
	Wed,  8 Jul 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536676;
	bh=IuE4tREelb9ER6RBZZ5Wd+EWbetWLiRX4zWRj82hRHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpFnsD9lUPsrLzowBF7YTikbpnvUvuyz3RSjjgZhOKHheuuIwDZExn/yfjO7nqY+6
	 nU9o5rSqm31lTToBEMGfUeMyoWNeULvCGz8vI7KzZ45HLNM9cK/DKbaQDDMxOCLFcc
	 1uJ6+w2sLVGJ+nyMxvUvWXLcfyj6ROokYx0myubmm9nA5hnTaNcQxWSmXmeKzCJSol
	 iYxqoZAStM6h0XSlOu0DrkznA7zLPyznA784P4LjMDXyF1Tgr0/XBTXBDa1Yew/Vps
	 E5Oz0v0gTV6PPPhA7KCwzsRl58YQQJRl/QQ9BeRDFqqynz09dY/kGqCOItrG2/p3Gh
	 Olh5dX2iqfzhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260708-edma_ll-v4-6-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-6-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:51:16 +0000
Message-Id: <20260708185116.7D08B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12145-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A4CC729B7D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The first burst of the initial chunk is populated but skipped duri=
ng hardware descriptor programming, leading to silent data loss.
--

--- Patch [6]: [PATCH v4 06/10] dmaengine: dw-edma: Add callbacks to fill l=
ink list entries ---
commit 8217e6927a330e1d9e36c8d3201ab9c4807b55cf
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Add callbacks to fill link list entries

This commit introduces four new callbacks to fill link list entries in
preparation for replacing the existing core start routines. The abstraction
allows the code to be cleanly shared between eDMA and HDMA implementations.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 8d38867cd9983..c0746e5351410 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
[ ... ]
> @@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	}
>  }
> =20
> +static void
> +dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst =
*burst,
> +			u32 idx, bool cb, bool irq)
> +{

[Severity: High]
This isn't a bug introduced by this patch, but since this new callback is
being introduced to handle filling link list data entries, does the existing
driver logic silently drop the first data segment?

Looking at dw_edma_device_transfer() in dw-edma-core.c, it allocates and
populates the first burst directly into chunk->burst:

dw_edma_device_transfer()
    ...
    burst =3D dw_edma_alloc_burst(chunk);
    if (unlikely(!burst))
        goto err_alloc;

    if (xfer->type =3D=3D EDMA_XFER_CYCLIC)
        burst->sz =3D xfer->xfer.cyclic.len;

However, the hardware descriptor programming loop in dw-edma-v0-core.c trea=
ts
chunk->burst->list as a dummy head rather than a data element:

dw_edma_v0_core_write_chunk()
    ...
    list_for_each_entry(child, &chunk->burst->list, list) {
        ...
        dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
                                 child->sar, child->dar);
    }

Since list_for_each_entry() starts from head->next and skips the head itsel=
f,
will this skip programming the first burst entirely and cause silent data l=
oss
for scatter-gather, cyclic, or single block transfers?

> +	u32 control =3D 0;
> +
> +	if (cb)
> +		control |=3D DW_EDMA_V0_CB;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D6

