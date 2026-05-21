Return-Path: <dmaengine+bounces-10707-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGMQCU1ID2r5IgYAu9opvQ
	(envelope-from <dmaengine+bounces-10707-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:00:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F55AAB71
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E2A306E651
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E003DF00F;
	Thu, 21 May 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7v2z8ZR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8903D9036;
	Thu, 21 May 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384662; cv=none; b=nAp4ImNR41GarK2aMU0rN3xdxJAJkVaY/J4LymHQwzlkG1fIbhLRouddKHfpGD2NUPqaqbW1qziwqHKZqVF0+4Ux4Sv9Ug6PNkuuJUkmrmrL6kJYVaVuuj+VqA/mGrpHabOS1CBDd2PCaL3OOXdxNHb0uE0t9QrzamW/WvgfqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384662; c=relaxed/simple;
	bh=9XJdbfgv4z9kk1tnll5YqOQVu2RhWQi9Uybxyermr78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RkqV12WfpieWndm7tux27I5lAG/ggwJBoRIBRH+83RHrrlryHwCbuaqadz+cE5TYOFRZFqljm6bT/c/mTJyPv3+bWHrPql3wajiDMpppcT8aG9+2tV2fe6H8NX56VkW/+Ksu1AYhJVGOqAFDs4YfZrxjVJpzKvwSPemZ7oFh9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7v2z8ZR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7131F000E9;
	Thu, 21 May 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779384661;
	bh=8njoPscqTq937OjwscNew/6YWYe+q4Hky/XitnHgDjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7v2z8ZRmoeQ7KtOjeJ55ogR0hqmrxP9Q7Hd/l0Mdfz7asL+6KeXcC+w37tgQAmmQ
	 ql146zABwqAqsNx5hTB02yul/BS7YQBdoyNp/PO4U5VfVZ8fzl/BjhZO7O862SmiJd
	 hiRVb5SKKh7eFahRL5zhpSyunmvckgNsHiEheeq9P90wHOzF0foWKsww8dxoNa6of5
	 JNGDIKodtTJ/mgbFEu7d2Q+BvBizdbuMYvtB1J+0djv72dHgbCj10/PFZU9f62Mrxx
	 awQHh8isG7KV9T4gufh40gr8K0w6xFgvfNb7YjbrX1eNlRUQhOhaLI0FYb+pgnftK3
	 /V1FW544/QA1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 17:31:00 +0000
Message-Id: <20260521173101.0A7131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10707-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,nxp.com:email,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 907F55AAB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated `size` from PCIe test registers leads to arbitrarily l=
arge `kzalloc` allocations, potentially triggering kernel warnings or panic=
s.
--

commit a2e73aaa3ad55ca4f65ceeb2cf567d9f9ac1f014
Author: Frank Li <Frank.Li@nxp.com>

PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify=
 code

This commit simplifies the DMA configuration code by replacing
dmaengine_slave_config() and dmaengine_prep_slave_single() with a single
call to dmaengine_prep_config_single().

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf=
_test *epf_test,
>  		else
>  			sconf.src_addr =3D dma_remote;
> =20
> -		if (dmaengine_slave_config(chan, &sconf)) {
> -			dev_err(dev, "DMA slave config fail\n");
> -			return -EIO;
> -		}
> -		tx =3D dmaengine_prep_slave_single(chan, dma_local, len, dir,
> -						 flags);
> +		tx =3D dmaengine_prep_config_single(chan, dma_local, len,
> +						  dir, flags, &sconf);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how the
len parameter is handled by the callers of this transfer code.

The functions pci_epf_test_copy(), pci_epf_test_read(), and
pci_epf_test_write() read a 32-bit size value directly from the memory-mapp=
ed
reg->size register, which is controlled by an external PCIe host.

This raw size is then passed directly to kzalloc() without any bounds check=
ing
or validation.

Could this allow a malicious or misconfigured PCIe host to pass an arbitrar=
ily
large size to kzalloc(), triggering a page allocator warning and stack trace
that might remotely crash the endpoint kernel if it is configured with
panic_on_warn?

>  	} else {
>  		tx =3D dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
>  					       flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D3

