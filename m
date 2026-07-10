Return-Path: <dmaengine+bounces-12310-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yAkqBBWvUGqt3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12310-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:36:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6E7388C3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ml1XVnXe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12310-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12310-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855763044C3A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18F3EEAE7;
	Fri, 10 Jul 2026 08:29:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DD3E0255;
	Fri, 10 Jul 2026 08:29:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672173; cv=none; b=ME4/V9iHTtVkFva2dH6PXneNOVIZI+yOzSROu2kQIJH6lfzC64C2T4rpbJvisRo+WqSmmvLIX0VrR3w/UkdvyzGP1eCV/3qfTMj3Vsgl+9ul/rAh0YibX+jjFCn7YZHP8/rq5LBss7rTppFx7ml9d6QtqJkXA8eJxYZ877k1zIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672173; c=relaxed/simple;
	bh=iT8xMWwHvgzRujoLuaEWU4s8yh5aAK5NmggJsd1NJF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nODvZ4sRRHvhexEedXarq25z0vIh+T/DXhQ1XEuUEPUWiHLKARWl9hwesK6oH8S5t1l8FpEjV1hPvv97Aq5P33wJ2DDJSlUau5eQnYZKm7sGfsHlrdqUvg8E9L8KEEZWF3m1aVpMDEnNEE0j78zxuOWfmFlQQ5aZLAYTqNBTxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml1XVnXe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7161F000E9;
	Fri, 10 Jul 2026 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672171;
	bh=qCRlnMCaLc7Fw9gWpQoyxlKA/AM49TaQZl8wZmT+oRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ml1XVnXedJLC/JBjsx85Ets5qYNVq3uRkHUxZGSCAbynivBK05kq4okwxljCFLW0+
	 3tx+JAY9IlYIgMBySED1Diy7jgpe2/3v6EUs23SKlb/EFHEuRzr3+vh6APm9RZdXqM
	 Ikwht8ga75kn5EprLmtZvwrEJ3kV3LCVXCvbACEeHG50DECa0xjsokKNARQFzfp0t/
	 1bwrq3GpbfSZQYfDwTpgREl7dFk23E9my93p6lqA8YNVv6aTZnV3G2Oy+GpAXQ+HLI
	 pAFahRXoRSlmhcIJEkhu0UDLiiJzVP2HXseJmgK4Hhkhp3ustxm2NjNX0vbNco4W7/
	 TlTV8dlrBjIpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260710082156.2395844-5-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:29:30 +0000
Message-Id: <20260710082931.5E7161F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12310-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,valinux.co.jp:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57B6E7388C3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The doorbell resource is incorrectly hidden and auxiliary resource=
 queries fail entirely when the eDMA provider is registered in non-LL mode,=
 contradicting the commit intent.
--

--- Patch [4]: [PATCH v4 4/6] PCI: dwc: Expose endpoint DMA resources ---
commit 14327ef69239f572929efa8665a21b5950efac88
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This patch exposes the DesignWare endpoint-integrated eDMA register window,
logical DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. It also handles the interrupt-emulation doorbell
when its register offset is valid.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..dd47537f390e5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -865,14 +897,34 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *=
epc, u8 func_no,
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct dw_edma_chip *edma =3D &pci->edma;
> +	int ret;
> +	int count =3D 0;
> =20
>  	if (!pci->edma_reg_size)
>  		return 0;
> =20
> -	if (edma->db_offset =3D=3D ~0)
> -		return 0;
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (edma->dw) {
> +		ret =3D dw_pcie_ep_check_edma_ll_regions(edma->ll_region_wr,
> +						       edma->ll_wr_cnt);
> +		if (ret)
> +			return ret;

[Severity: High]
The commit message states the doorbell remains reported, but if eDMA lacks
linked-list memory, dw_pcie_ep_check_edma_ll_regions() returns -EOPNOTSUPP,
which causes this function to return an error. Does this inadvertently hide
the doorbell resource and cause the entire query to fail in non-LL mode?

[ ... ]

> @@ -909,6 +962,76 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8=
 func_no, u8 vfunc_no,
>  	if (rsvd && rsvd->size < dma_reg_size)
>  		dma_reg_size =3D rsvd->size;
> =20
> +	count =3D 0;
> +	if (edma->dw) {
> +		resources[count++] =3D (struct pci_epc_aux_resource) {
> +			.type =3D PCI_EPC_AUX_DMA_CTRL_MMIO,

[Severity: High]
If dw_pcie_ep_get_aux_resources_count() is updated to ignore the eDMA
channels instead of returning an error, this unconditionally populates the
eDMA resources when edma->dw is true. Could this cause an out-of-bounds
write to the resources array since the array would have been allocated
based on the smaller count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D4

