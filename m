Return-Path: <dmaengine+bounces-10593-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD+GCSBpDmok+gUAu9opvQ
	(envelope-from <dmaengine+bounces-10593-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 04:08:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE959DE69
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 04:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34D72302735C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 02:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B8324B1F;
	Thu, 21 May 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdRGtJhs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2D3264DC;
	Thu, 21 May 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329301; cv=none; b=Osh7Zbg0ixlIUi1uwsYor/7PnBRzYRvsC43xsICn+ra20xKBAd6fj9skMnATvfl62t8jJfKC09U8L7v9mSIAIh4B7o/mKqfqzjfXybvzTibakZ6fsY+3022zLIn95ZKkGGTHJLCdPIuJPYOLE3noI/tAmuK+BRCsxyS4G8L6z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329301; c=relaxed/simple;
	bh=811PzO2FOqQVhVukOnWVHZi6XF1qFSFmJFm1KRN6yds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lAtll5jlkkLkgRzm4JgyIdnP5jvcIpuU5WsQNBftH7n2yhKoZf/+CzggzYJLakFewz6zjSV9pRpcBZXTdXR+w4RRzr7tL+eLniZBh8S7HfDXYU0utIg6tbi6Z1zo7rKoRFvBWMD0X7F7wu4mkS5fgFjqkxouMOqxI72IuXbz9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdRGtJhs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ACC1F000E9;
	Thu, 21 May 2026 02:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329294;
	bh=p+KPjtvGz5c9j1/K5JB/Ty0+hqRQF4WXFZ/pH3yvw7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SdRGtJhs+oh5JCIlwW0sl0bCc5/DuU81pZ4GXWbjQd4Hmd4VJC3pY+lH/lIWGMjaI
	 tNPuUGUnGQ0nbCKvk6b2Gcp9HawesXNJQH3jqNXxXs6t332+QPWQpRohEV2SNfq48T
	 CScMZpjw/tWL0HQNjuuSTLzGnSzmsdzauVgJaYRYwvcaq9uWo/NrYektw8prX/YfyU
	 qlLasSfWKHR1mUSx0eiF6x10eMPWiQkfUIHV2fWgkvn1BuG/kz2aVczLqXAh4R8SJD
	 ki5coRgKlR4qoDLoccn9h6Q5gaeo2b3JR7eC0E0OgwfpvN9YS5vpwD8lxuk63JuWGI
	 OVeLx4sPz5EKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single()
 to simplify code
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260520-dma_prep_config-v6-8-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-8-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:08:13 +0000
Message-Id: <20260521020814.53ACC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10593-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,nxp.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 8ECE959DE69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The DMA workqueue is destroyed before pending DMA transfers are ex=
plicitly terminated, which can lead to a Use-After-Free if a DMA callback e=
xecutes late.
--

commit 01fd36b3138418658a89651874d85c30619199e8
Author: Frank Li <Frank.Li@nxp.com>

PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code

This commit replaces dmaengine_slave_config() and dmaengine_prep_slave_sing=
le()
with a single call to dmaengine_prep_config_single() in the EDMA read and w=
rite
paths. The change aims to simplify the code without introducing any functio=
nal
differences.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> index 7f5326925ed54..c3e3b58fb86cd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
[ ... ]
> @@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep=
_cntrl *mhi_cntrl,
>  	config.direction =3D DMA_DEV_TO_MEM;
>  	config.src_addr =3D buf_info->host_addr;
> =20
> -	ret =3D dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	dst_addr =3D dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_FROM_DEVICE);
>  	ret =3D dma_mapping_error(dma_dev, dst_addr);
> @@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep=
_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
> =20
> -	desc =3D dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc =3D dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how th=
ese
asynchronous DMA transfers are cleaned up.

In pci_epf_mhi_dma_deinit(), the DMA workqueue is destroyed before pending =
DMA
transfers are explicitly terminated:

static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
{
	destroy_workqueue(epf_mhi->dma_wq);
	dma_release_channel(epf_mhi->dma_chan_tx);
	dma_release_channel(epf_mhi->dma_chan_rx);
	...
}

Does this sequence lead to a use-after-free if a DMA callback executes late?

If a transfer is physically still running in the DMA engine hardware when t=
he
deinitialization begins, destroy_workqueue() will flush existing queued work
but cannot stop the hardware itself.

If the hardware completes the transfer a moment later, the DMA engine
interrupt will fire and invoke pci_epf_mhi_dma_async_callback(), which
blindly calls queue_work(epf_mhi->dma_wq, ...).

Should dmaengine_terminate_sync() be called to abort pending asynchronous
DMA transfers on all active channels before destroying the workqueue?

>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret =3D -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D8

