Return-Path: <dmaengine+bounces-12139-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UnLlHqybTmo+QgIAu9opvQ
	(envelope-from <dmaengine+bounces-12139-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:49:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56DA729B18
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:49:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nyWAK+Po;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12139-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12139-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32F6304C960
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36B3C2782;
	Wed,  8 Jul 2026 18:46:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE63BB106;
	Wed,  8 Jul 2026 18:46:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536386; cv=none; b=cEhQvsfsY1GW7+ofWmqbY1HTOrLdXiBV9PvwsSAzy10KaOIocOLknikkoaXY/oU/O4thSjljoC93r57Kcqn/Mi782aFzgnR9WoCgu4wIADGcJ2MG1S8bJ/AnUTZM5TvHvZLhAXro8/Mz0spscYZSjfq/Mu4NufRpicQ/z7t671g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536386; c=relaxed/simple;
	bh=+AaJZDGVUrO+DzRD9lN02cyx2j2JjI54VI1gu72PifY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CL+5GIBgUBRV25VNzL7awN+6liSZajnsIfaj9MUPIm7KssIcMUSDa4hnMjOzFggc26ffXa/fy7wM2mq3ymDUMdPW5wVdKjEEeF9jrjMSnLHQtBOuITPUUX7LtayY7/3CfcFDd6APzui1dCXvVWacMxc+YV+zjoQkteX1nO4lFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyWAK+Po; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E0E1F000E9;
	Wed,  8 Jul 2026 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536384;
	bh=6RDtGPOLJFBuQgboHKf5T5EV2TfqHkgKbyRkPcS7FaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyWAK+Po8wAPeEB8u66XSGiZ4bslZexetdYX7c9pH/6So1zCS20C3jlCsNSFPbCPy
	 fwg9KblADbj1IXLrYdK6zGbI/9a2JmPhJMFa2vRV2W5X/e1q72s1XKrqnOqOpkaqsS
	 vtYnblTk4pFuAata/fqYI4Tz+R6Kh9AyOuU7Wow3B6jAr6jZ2EFwub/pITpW/YZzFh
	 dkV+s2ArN5SdG0tk+UFvviKQJ2HH5G1DtemUl+9xbLKtq3xctkcrWDQy7L0HkjKV6y
	 1GwSLEYW+8wzQr+MIAulBd7nfXafKGgb7LFye6Oaa6iweacwr1sQpTc2dv1yZbuZzs
	 T1ii5t9IIF4+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708-edma_ll-v4-3-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-3-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:46:24 +0000
Message-Id: <20260708184624.88E0E1F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12139-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sashiko.dev:server fail,smtp.kernel.org:server fail,lists.linux.dev:server fail,sea.lore.kernel.org:server fail,valinux.co.jp:server fail,nxp.com:server fail,vger.kernel.org:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C56DA729B18

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dw_edma_device_resume() accesses and modifies channel states and c=
alls dw_edma_start_transfer() without holding the channel lock.
--

--- Patch [3]: [PATCH v4 03/10] dmaengine: dw-edma: Move ll_region from str=
uct dw_edma_chunk to struct dw_edma_chan ---
commit 1e85ecaff6d1547be3e5049908d131f91651e11f
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_e=
dma_chan

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 53469c8c8b82e..2652ad8e7a8f6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

While reviewing this file, I noticed a pre-existing issue in dw_edma_device=
_resume():

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
	} else if (chan->request !=3D EDMA_REQ_NONE) {
		err =3D -EPERM;
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}

	return err;
}

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
dw_edma_device_resume() modifies the channel state and calls
dw_edma_start_transfer() without holding the channel lock.

The vchan_next_desc() function, which is called by dw_edma_start_transfer(),
explicitly asserts lockdep_assert_held(&vc->lock). Modifying channel state
and manipulating virt-dma lists without holding chan->vc.lock can cause data
races and list corruption.

Any client driver triggering a channel resume will consistently hit the
lockdep splat and risk kernel panics from list corruption.

Could we acquire chan->vc.lock before updating chan->status and calling
dw_edma_start_transfer() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D3

