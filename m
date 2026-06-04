Return-Path: <dmaengine+bounces-11166-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UEfiGwCeIWo1KAEAu9opvQ
	(envelope-from <dmaengine+bounces-11166-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 17:47:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B930A6418E5
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 17:47:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kVq3TPF1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11166-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11166-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535BC3006B70
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBE2882BE;
	Thu,  4 Jun 2026 15:35:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC029AAFA;
	Thu,  4 Jun 2026 15:35:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587344; cv=none; b=XHnx18FyTK4Wbf/QEwhDutq520zyhqaKTkRiObkN0IaCWswrkVvLUSFanK7xrcisZi4JaDw1YKQrPtVF+/2NZsdEUeVbQ3FrYztNSNDeyr8I7FjkoS2lE3aADSfiHkcp7NMhInyAKGCtQwgrx/CFrzF5sLr/Ro8GwdfWafCTDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587344; c=relaxed/simple;
	bh=mS9MMrnaL4n025Ve3v+9xL4XFnfNGJ72ZQACgSgL22A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9NEUcJMGQBs3FRMwvCL2wbAqZF6VKBzF+PpVyK0l0Scwf3k1BH6iw64CavOmmtfPV916ODPJ/C+EeJXlkqFLTbY6OD5tOhiusY+35xj6vdL/0X3hGbB7CMIJC+mc+On0IsGT0itwz55zgqvq+lonylHipOs7snx7q3h1bAWLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVq3TPF1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1D71F00893;
	Thu,  4 Jun 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587342;
	bh=US2ll7hbhiZHgqyxcw43ERfVS7KfsrMuZAMTBwoHr3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kVq3TPF1M2rG32l/VTGDPN/ALksdgEnsJbRqpPgKgZ+i2FFKpas2fqHqvsaV96hD4
	 FZ/pCdW28rasD6ZFtul3GCszvRaBmzR6T0oMuItvP6x2TeeXptuJu870vmdDlwClNk
	 BOzZAw5sGGtiNiaNvXsIvPg1CIfQvziUKOyeOBjaonLw4VN1P2HOsD4IaCyatMJSvf
	 CFHkAZl6CZ1WjExiRqW5VSG/MWvNioOd0FSKJcvHNmV800rmLrzDSXMyI8boTG3wfc
	 i/G4R8IaqWSrmrp3/JA+2WeM05gkidbedsd8+91q+RHmv/IEJvvLbJ6ZAyJYrtqdmB
	 h6zloBXneE5LQ==
Date: Thu, 4 Jun 2026 21:05:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Message-ID: <aiGbShotOS4usSdm@vaman>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
 <20260603144445.562521F00893@smtp.kernel.org>
 <BL4PR12MB948277305F69CC4A87F0D1F695102@BL4PR12MB9482.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL4PR12MB948277305F69CC4A87F0D1F695102@BL4PR12MB9482.namprd12.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Devendra.Verma@amd.com,m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11166-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:email,sashiko.dev:url,vaman:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B930A6418E5

On 04-06-26, 12:12, Verma, Devendra wrote:
> Public

Pls do _not_ Top Post!

> 
> The pre-existing issues need to be taken up in a separate series.
> The changes require separate testing which is not related to the
> current patch.

While I agree to that and it wont block the review but would be good if
you can fix that as well. Sure affects your users...

> 
> Regards,
> Devendra
> 
> > -----Original Message-----
> > From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> > Sent: Wednesday, June 3, 2026 20:15
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: dmaengine@vger.kernel.org; vkoul@kernel.org; Frank.Li@kernel.org;
> > linux-pci@vger.kernel.org
> > Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA
> > DeviceID
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s)
> > to consider:
> >
> > Pre-existing issues:
> > - [High] Missing pci_free_irq_vectors() cleanup on error paths in
> > dw_edma_pcie_probe() leading to IRQ resource leaks.
> > --
> >
> > commit a523468dbe7999a5962895c3e0d73662a2938006
> > Author: Devendra K Verma <devverma@amd.com>
> >
> > dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
> >
> > Add Device ID for AMD (Xilinx) CPM6 DMA IP to enable 64 Read and 64 Write
> > Channels. Adds the relevant dw_edma_pcie_data to use 8 Read and 8 Write
> > Channels for the initial commit.
> >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 0b30ce1385036..4ba368d18cb1d 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> >
> > [ ... ]
> >
> > > @@ -547,6 +561,8 @@ static const struct pci_device_id
> > dw_edma_pcie_id_table[] = {
> > >     { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > >     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > >       (kernel_ulong_t)&xilinx_mdb_data },
> > > +   { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> > > +     (kernel_ulong_t)&xilinx_cpm6_dma_data },
> >
> > [Severity: High]
> > This is a pre-existing issue, but adding this new device ID exposes the new
> > device to an IRQ resource leak in dw_edma_pcie_probe().
> >
> > When the device is probed, dw_edma_pcie_probe() successfully allocates
> > IRQs via pci_alloc_irq_vectors(). However, several subsequent error paths
> > return directly without calling pci_free_irq_vectors().
> >
> > For example, if the pcim_iomap_table() lookup fails:
> >
> > drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
> >     ...
> >       chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> >       if (!chip->reg_base)
> >               return -ENOMEM;
> >     ...
> > }
> >
> > Or if the main eDMA probe fails later on:
> >
> > drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
> >     ...
> >       err = dw_edma_probe(chip);
> >       if (err) {
> >               pci_err(pdev, "eDMA probe failed\n");
> >               return err;
> >       }
> >     ...
> > }
> >
> > Does this code leak the allocated IRQ vectors in these error paths? Because
> > IRQs are a strictly limited resource, repeated probe failures (such as deferred
> > probe or unbind/rebind cycles) could silently exhaust the system's IRQ
> > capacity.
> >
> > Would it make sense to ensure pci_free_irq_vectors() is called on all error
> > paths after successful allocation before enabling new devices?
> >
> > >     { }
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260603143158.3243500-
> > 1-devendra.verma@amd.com?part=1

-- 
~Vinod

