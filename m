Return-Path: <dmaengine+bounces-12312-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s20iIj+vUGq63QIAu9opvQ
	(envelope-from <dmaengine+bounces-12312-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:37:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E397388E0
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HF3Slxm+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12312-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12312-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDADD30179CF
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF63EFFDB;
	Fri, 10 Jul 2026 08:32:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80C3CDBC0;
	Fri, 10 Jul 2026 08:32:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672328; cv=none; b=dC85us03zi9uqD42mouwDV1a3UIb2ww1/mgL3DAePZ3iYr4+Y/74b/iEbxvh3gVukaDuBCmhGMZFya5AkUFT0C4F63h11rpJ0mb3hSN2D8CwllJS12SWmECOwgtyfJULGVBMJOD9YIwUt3IVhdJynVfzIEjw4tTtye2aInw+5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672328; c=relaxed/simple;
	bh=zsmqvjIGE+kIwi3lbXc2APYHOfB6GvWHuZe2vwFm5TY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtZM8+U5jkUEwWn+WA7zRl8MLl5Gh+XHy1TznnSRq9GbAXIbzp7mFaUWYt5knBJSL0NhIsKUg830JPpQ36PWnnBaIWJPZAM5YrCfPAtuLhqN6Rpt7mw36eC5fFPDfsXZu8GhUlokHEYSimaGbSZq4JwELTjt4i160e0rRSn/ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF3Slxm+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D31F000E9;
	Fri, 10 Jul 2026 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672326;
	bh=KoUaYJJJTzCLwsRsrwobIDFPW2BtE6yXrfgQODLamYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HF3Slxm+htk8FW3C2nRm1+NbQsN1yziBZy5P16NKsLjK+s5bKc6SZujpGGckFgc8q
	 cjbrPV0LzbUoF2jpk1vOVVy0vp0kjrPafI4WfWSxRtrouwebK47VbE+Jqb+ichV0xk
	 L/UqwwL36/8RUpm8X9KRDyUT0AHOKH6QTZs+be1ZAb5wkQh+0RRXzWfDrS7sGm8rP0
	 /KFMGdw7buCPezx1wGFAndiUkhl+DL2YxGcfOQ6PSAhUg/bsCMChe/8hg3tj9oCJMa
	 KSTcfCRV9LbIoW+u383YU5lKAwcSIrq8s/pf0SD0uc8GZnOLE6JC7tDB1l2WUVROA9
	 7NGqXhDq6Sh+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-4-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:32:05 +0000
Message-Id: <20260710083206.198D31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12312-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,valinux.co.jp:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27E397388E0

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but pre-existing API=
 functions `pci_epc_get_aux_resources()` and `pci_epc_get_aux_resources_cou=
nt()` unconditionally dereference `epc` before checking if it is an `ERR_PT=
R`.
--

--- Patch [3]: [PATCH v4 3/6] PCI: endpoint: Add API to delegate EPC DMA ch=
annels to the host ---
commit 1d374b51cba0f1ce466c2d806368e6604aa12539
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add API to delegate EPC DMA channels to the host

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function should not need to know the backend-specific
mechanism used to reserve a channel locally and hand its programming
interface to the host.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 831b40458dcd8..9c908051aa235 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c

[ ... ]

> @@ -236,6 +243,101 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, =
u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> =20
> +/**
> + * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to th=
e host
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @dir: DMA channel direction relative to the endpoint
> + * @hw_ch: hardware channel number
> + * @chan: output delegated-channel handle
> + *
> + * Some EPC backends integrate DMA channels that can be exposed to the h=
ost.
> + * This helper asks the backend to reserve the specified channel locally=
 and
> + * place it in a state where the host driver may program it through the =
exposed
> + * register window.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA=
 channel
> + * delegation, or another -errno on failure.
> + */
> +int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> +			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +			      struct pci_epc_dma_chan **chan)
> +{
> +	struct pci_epc_dma_chan *epc_chan;
> +	void *data =3D NULL;
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but while you correctly call
pci_epc_function_is_valid() here first to avoid dereferencing an error
pointer, could the pre-existing pci_epc_get_aux_resources() and
pci_epc_get_aux_resources_count() functions be crashing for the same
reason?

Looking at pci_epc_get_aux_resources() in drivers/pci/endpoint/pci-epc-core=
.c:

	if (!epc || !epc->ops)
		return -EINVAL;

	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
		return -EINVAL;

If epc is an ERR_PTR, the !epc NULL check passes, and it crashes when
dereferencing epc->ops before reaching pci_epc_function_is_valid().

Does it make sense to update these sibling functions as well to ensure they
safely handle an ERR_PTR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D3

