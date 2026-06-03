Return-Path: <dmaengine+bounces-11147-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yB2ECH5CIGqLzQAAu9opvQ
	(envelope-from <dmaengine+bounces-11147-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 17:04:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA13638EA4
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 17:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EMDlDgi9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11147-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11147-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D1A32D2B57
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBD3DA7EC;
	Wed,  3 Jun 2026 14:44:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6443D967A;
	Wed,  3 Jun 2026 14:44:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497887; cv=none; b=aRJHx06UbCFrgCr4bxS0FBIa2GF/50gjq5nUwj+13KMt0CHByxOrk45n69KQWxKswMPiTiE9C2WHZdSSp/wKP64YktetFnOMhfYtuE2eljelxlJyeNA8aGEfZwzg3jIFC7XQo5kw8w55FOT/fNkQafjs7Of8DcXIC4FojPUUuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497887; c=relaxed/simple;
	bh=H3omxgVqm8lKTgj38LJ/eVoVJgJBIEuZzN6+2zUFq6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmXDm0JUU/C07QdNfbmIGKxf69obziSCB9nim7/rLan5GHmligmx5eq7+HUxfOWyKzhsv8VsU04hizRCVqcIZC18BCJcT4iTqAHtcOkvpYqI5w0wUinFQTWP6bH4E8zLa7a/0ubZSxFxfNIfATaKnTdT7Tl8NEEC7JGKkQxB9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMDlDgi9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562521F00893;
	Wed,  3 Jun 2026 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497885;
	bh=o/txvbo10oOWk46rmPX2byw291k/GcboYzdUh5PUvh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMDlDgi9/71H7djf0DY8Rz4BTKPgPWHgLWEuIv0xIqfWQiF4beGePzR52enXtIkVH
	 tcwW68JQDParKqKevUXX1ccQJybAFEVWfWb9Vo4IJOZvLrqFAQOcyjpPAEL9+2MHmO
	 tVTzz4Ri0tSP0QqlTE+s82XG1G+A/Pgl+gGGcDl06Fps7g2hYUPaSL1ASxmugexZGi
	 NWjrGQDBezgFiywa7xSQuqbvfw9Ybr6o3c4+8m9gr+ECwLJikKdqpP9xzMyK/p7wyS
	 PHu/lV7J6btT/YDD8j6WuCM8uY0QpT/pc2DibSNF1Ul4Qdl8sl6Urn/rNNMe6EdUB2
	 N/a1bRmuDEGig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260603143158.3243500-1-devendra.verma@amd.com>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 14:44:44 +0000
Message-Id: <20260603144445.562521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:email,lists.linux.dev:replyto,smtp.kernel.org:mid];
	TAGGED_FROM(0.00)[bounces-11147-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DA13638EA4

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() cleanup on error paths in dw_edma_p=
cie_probe() leading to IRQ resource leaks.
--

commit a523468dbe7999a5962895c3e0d73662a2938006
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID

Add Device ID for AMD (Xilinx) CPM6 DMA IP to enable 64 Read and 64 Write
Channels. Adds the relevant dw_edma_pcie_data to use 8 Read and 8 Write
Channels for the initial commit.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..4ba368d18cb1d 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_tab=
le[] =3D {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
>  	  (kernel_ulong_t)&xilinx_mdb_data },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> +	  (kernel_ulong_t)&xilinx_cpm6_dma_data },

[Severity: High]
This is a pre-existing issue, but adding this new device ID exposes the new
device to an IRQ resource leak in dw_edma_pcie_probe().

When the device is probed, dw_edma_pcie_probe() successfully allocates IRQs=
 via
pci_alloc_irq_vectors(). However, several subsequent error paths return dir=
ectly
without calling pci_free_irq_vectors().

For example, if the pcim_iomap_table() lookup fails:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;
    ...
}

Or if the main eDMA probe fails later on:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
	err =3D dw_edma_probe(chip);
	if (err) {
		pci_err(pdev, "eDMA probe failed\n");
		return err;
	}
    ...
}

Does this code leak the allocated IRQ vectors in these error paths? Because=
 IRQs
are a strictly limited resource, repeated probe failures (such as deferred =
probe
or unbind/rebind cycles) could silently exhaust the system's IRQ capacity.=
=20

Would it make sense to ensure pci_free_irq_vectors() is called on all error
paths after successful allocation before enabling new devices?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603143158.3243=
500-1-devendra.verma@amd.com?part=3D1

