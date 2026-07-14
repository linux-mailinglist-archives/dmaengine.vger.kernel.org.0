Return-Path: <dmaengine+bounces-12496-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gmozKH8tVmpS0wAAu9opvQ
	(envelope-from <dmaengine+bounces-12496-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:37:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A1754A11
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yz0KFj7s;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12496-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12496-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2E6312C503
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C19448D0B;
	Tue, 14 Jul 2026 12:32:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB739A047;
	Tue, 14 Jul 2026 12:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032348; cv=none; b=d6g92iVehoim7LunbSgnwdCY35FnJPAKjgUYaD+kTJ6wQEZvgv09ABM/onIrKiJrmwyoHk2ZX2WtidUQoLBwvulTfeH7CRO9MkY/j9c8O6ibS9TwCWNmRXAtn/JtLvOu11DLF9OveeyPQSA4a9TpxHpwCicijIkj24ySFMmJ4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032348; c=relaxed/simple;
	bh=DSENbsWlW/QzAXnqDYZWi9BO5ezJVxAgtnB/XGNyqsk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7e/MhsfuwnamuK1QMjmzsozIZ7CIcje5FkyaquzX5j8l6NbKL5lqJ8WrxwAA7N0thi1JNIfKMWaumi85rl89lpNHug7U+RsGNeQrXJc1tnG2uL6l9Md/seCx8APPA27XqYO94Txz7qwS0f8GPOHG8CH0Mm5n5vE+j6x1VJp52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz0KFj7s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8201F000E9;
	Tue, 14 Jul 2026 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032336;
	bh=iFRbmSU8P9+eMc7PXGWfTOOwr/3NGqJfOlOm1ioxEbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yz0KFj7svJkfBWdtnjieP3L3HRJR082cNmBCsDSko2om0410lYE/upkFcpZf0N5dl
	 mo1NfkCJIiz9Mr5A7PPOGHhxlLVjOcgCAyoVBoH+nqn9svvNVJ9HRGVJvkZ/F5nNEI
	 Dx9yaHDBUqzckIlgrGnX4ddpg5ICtoVGcppDQE8IAfpA14F86XgtW3BKRbvrd9r1U1
	 4iO2XyzVqkhYqjMDWm9nc/uuWwaKHOYYX9Ymk1VWicxqRE/2gNFSIoCQdwkhZ6g4b6
	 n71jjanOD3etDq/bKARfIqbtpY1FvcVzke406gah1WHwgqM4d394koMMbAlrQjYz8Z
	 +nSwop6ixHIgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async()
 to flush DMA read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260714-mhi-ep-flush-v2-3-b6a9db011e85@oss.qualcomm.com>
References: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
 <20260714-mhi-ep-flush-v2-3-b6a9db011e85@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:32:15 +0000
Message-Id: <20260714123215.AB8201F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12496-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D93A1754A11

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Deadlock / Infinite wait in pci_epf_mhi_edma_flush_async() when sy=
nchronizing globally shared DMA channels.

Pre-existing issues:
- [High] Pre-existing NULL pointer dereference on PCI link flap exacerbated=
 by unconditional cleanup dereference.
--

--- Patch [3]: [PATCH v2 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_asyn=
c() to flush DMA read/write ---
commit c83c3a93b470add22e521d4fb56e38b2a49dd98b
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write

The MHI core needs to make sure that all the current DMA transactions are
completed before removing the channels. So implement the
mhi_cntrl->flush_async() callback by first making sure all the in-flight
DMA operations are completed and then flushing the DMA workqueue.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
[ ... ]
> @@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_e=
p_cntrl *mhi_cntrl,
>  	return ret;
>  }
> =20
> +static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct pci_epf_mhi *epf_mhi =3D to_epf_mhi(mhi_cntrl);
> +
> +	dmaengine_synchronize(epf_mhi->dma_chan_rx);
> +	dmaengine_synchronize(epf_mhi->dma_chan_tx);
> +	flush_workqueue(epf_mhi->dma_wq);

[Severity: High]
Can this cause an indefinite hang if other channels on the same controller
are active?

If a user unloads an MHI client module (invoking mhi_ep_remove), it calls
this function to drain the DMA channel. However, because
epf_mhi->dma_chan_rx and dma_chan_tx are globally shared across the entire
PCI endpoint, and dmaengine_synchronize() polls until the channel is no
longer busy, continuous data traffic from a different independent MHI
client might prevent this from ever returning.

[Severity: High]
This is a pre-existing issue, but could this also lead to a NULL pointer
dereference after a PCI link flap?

When the PCI link goes down, pci_epf_mhi_link_down() calls
pci_epf_mhi_dma_deinit(), which frees the DMA channels and workqueue and
sets them to NULL.

When the link comes back up, pci_epf_mhi_link_up() unconditionally assigns
these EDMA callbacks but fails to call pci_epf_mhi_dma_init() to reallocate
the resources.

If the link goes down again (or a client device is removed), invoking this
new flush_async() callback will pass NULL pointers to
dmaengine_synchronize() and flush_workqueue(), causing a crash.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-mhi-ep-flu=
sh-v2-0-b6a9db011e85@oss.qualcomm.com?part=3D3

