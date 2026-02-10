Return-Path: <dmaengine+bounces-8881-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOkLKx9fi2msUAAAu9opvQ
	(envelope-from <dmaengine+bounces-8881-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 17:38:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5E11D595
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9CC4300F10D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC130EF94;
	Tue, 10 Feb 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2LI7R6A"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5A30CD80;
	Tue, 10 Feb 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741505; cv=none; b=JVjm1fDcC9huOWWcp22Ooupwx0ow3GB+g1HIuhkTR3GvVeyRnoIUrxZS3SI4renRvT0a0KH/zlzqaaJPg78g43D1MDbjdpjJYXqkr4zmGmIJZztcmApFcXpLhH9R4YnBaOBTmCdM0biW2QIFZTHRCMfyV0u8vpbjapDA5PblUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741505; c=relaxed/simple;
	bh=ee9fB6bIjiVMrs4NtEF4Te4n44P3upDDcYNINlYRaXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4aREGuMaLxBBnezDkUy7HfTfnx8RTFft1Q83t7EjQLdv2DQAkeYfxPkJ2h4vFjd3TzK7WI2tnwuNRnt9OvCL1O6kv2GV/FhCALbVoky87G42DScdL6Zm6c1EL6FhIyjVwl6GGH93xY1cq5DbBOkvVIbNbNgqGDeXS3YA6zO3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2LI7R6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7D9C116C6;
	Tue, 10 Feb 2026 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741505;
	bh=ee9fB6bIjiVMrs4NtEF4Te4n44P3upDDcYNINlYRaXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2LI7R6AU7iLNsiFgF6B1QPKsM5HrW5y6elh1V5WaTnkEVzoixNq+sugTsZ0BmClL
	 b1ZgVQ6XsmZwx+49hFJUvyHmGQT/n/Tyv1QYflQO1zwwwB20x1vnMRCVsR9NN0KkJi
	 AlS9msH4zbk1r2Rq1oYnhHHmLvfeEEuS6xlLWD3Pu1EKekJTzdcAUjhjced1NPpQYs
	 nPYn4xSlbwyweoPMeaWpUPTJ7a4603/ue9AeIt8/MLAo9MEHfQNdD4qu2YgqqU0jW+
	 5MdRNiEdY4PN0ufKmKMQhh8mm2lj7gGYTBPnech0onVxiLEIzNYfFIC/LGN7u1kUQh
	 N2olMWyd4MHnA==
Date: Tue, 10 Feb 2026 17:38:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <aYte-7hTxb7kXNlQ@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
 <aYsmTbSmn94J6uN0@ryzen>
 <uvuugqkiaravp6gmn6o7x5koyvo5zkmbwwbhdq6ctvvdtdhoyd@rnxwhlysqs7d>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uvuugqkiaravp6gmn6o7x5koyvo5zkmbwwbhdq6ctvvdtdhoyd@rnxwhlysqs7d>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8881-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 8DE5E11D595
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:54:20PM +0900, Koichiro Den wrote:
> On Tue, Feb 10, 2026 at 01:36:29PM +0100, Niklas Cassel wrote:
> > On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> > > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > > the interrupt handler with request_threaded_irq(). On failures before
> > > the IRQ is successfully requested (e.g. no free BAR,
> > > request_threaded_irq() failure), the error path jumps to
> > > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> > > 
> > > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > > warnings when the IRQ was never requested.
> > > 
> > > Track whether the doorbell IRQ has been successfully requested and only
> > > call free_irq() when it has.
> > > 
> > > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 6952ee418622..23034f548c90 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -86,6 +86,7 @@ struct pci_epf_test {
> > >  	bool			dma_private;
> > >  	const struct pci_epc_features *epc_features;
> > >  	struct pci_epf_bar	db_bar;
> > > +	bool			db_irq_requested;
> > >  	size_t			bar_size[PCI_STD_NUM_BARS];
> > >  };
> > >  
> > > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> > >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> > >  	struct pci_epf *epf = epf_test->epf;
> > >  
> > > -	free_irq(epf->db_msg[0].virq, epf_test);
> > > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > > +		free_irq(epf->db_msg[0].virq, epf_test);
> > > +		epf_test->db_irq_requested = false;
> > > +	}
> > >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> > >  
> > >  	pci_epf_free_doorbell(epf);
> > > @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > >  	if (bar < BAR_0)
> > >  		goto err_doorbell_cleanup;
> > >  
> > > +	epf_test->db_irq_requested = false;
> > > +
> > >  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> > >  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> > >  				   "pci-ep-test-doorbell", epf_test);
> > 
> > Another bug in pci_epf_test_enable_doorbell():
> > 
> > Since we reuse the BAR size, and use dynamic inbound mapping,
> > what if the returned DB offset is larger than epf->bar[bar].size ?
> > 
> > I think we need something like this before calling pci_epc_set_bar():
> > 
> > if (reg->doorbell_offset >= epf->bar[bar].size)
> >     goto err_doorbell_cleanup;
> 
> Right, I remember this coming up in another thread.
> 
> If there are no objections from either of you, I'm happy to include a fix
> patch for this in v7.

No objection from me.


Ideally I would also like:

	if (!(test->ep_caps & CAP_DYNAMIC_INBOUND_MAPPING))
		return -EOPNOTSUPP;

and that the pci_endpoint_test selftest would return skip on -EOPNOTSUPP,
since the doorbell test currently relies on CAP_DYNAMIC_INBOUND_MAPPING,
but that might make your series too big.


Thus, I'm happy if you add a safety check for:
reg->doorbell_offset >= epf->bar[bar].size


Kind regards,
Niklas

