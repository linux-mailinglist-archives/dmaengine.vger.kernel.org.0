Return-Path: <dmaengine+bounces-8888-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI3kI/2qjWkK5wAAu9opvQ
	(envelope-from <dmaengine+bounces-8888-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 11:27:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23912C782
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 11:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D60302E87A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A72DB797;
	Thu, 12 Feb 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9LOGN2v"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629420298D;
	Thu, 12 Feb 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892027; cv=none; b=hlOoLPVlJd4uFRm/b+ogr6KRDI5kpt8AlGq0GfdFu7xvjR1W4FH2W33UFjI1yFa97UvI78N//SSbBOHCGz+qsfI53sRPaTuKTwkz+tPvEhSeUju0AaUS8YO+bMdIinTkWFnsPEvV9sGZrPStal9/2H9x83rH9BzX0VtPH25wjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892027; c=relaxed/simple;
	bh=CPZNlVe4j32s7jBBuQXGtaBwyleYNvjm7bjZCGhp5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHdgfke+rdqG8u1lY0Ad7jt7QJ2PdPGxcuIzkoSbvoSZ2v2bnp5UHQWPQubNHZJDMGs6Z7PjRg/moClo1xIaI41NBjsqIeuPJDAhkIwuu2gdwbh1RotBx0Znbby8yV9AwcVh5yH2ynIHbWR7+bbgsp43glkSIQrZIHvu8M9d4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9LOGN2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C64C16AAE;
	Thu, 12 Feb 2026 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770892026;
	bh=CPZNlVe4j32s7jBBuQXGtaBwyleYNvjm7bjZCGhp5sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9LOGN2vVK4wVBgaXB/8h21Xf0nuhwbXcx04xOBj4pkmlAE2JiQy/KX8n+XH+bUjJ
	 wsKq3lfL06EKfXM0I9NrD00Igx3hNBwF8ZXw9xBwbPi3W/IASRiZb8WqUlqLSxr6Ly
	 jsTaD4WpyC7nerFpisXGWg3tk1rsI/d+Rss4znxuuOid0pe19qR2B2cGJ+onPF/woc
	 wGtah9MM10JtGI0ocR8pk2C0L1oL6TbN3CuYxOzpdXBM7mwK+Fib5ioeRZk4RK3oBB
	 MhdUwQcu2q7xEd8Z6UHCn6I02Tf4m6n488oTpw7NTelGbW7LhaTq0lAS9yqxsZCoUN
	 BnKbHkLZGPe3g==
Date: Thu, 12 Feb 2026 11:26:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aY2q80zeRKSRO21H@fedora>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
 <aYyz5WF_iJuNwA35@ryzen>
 <fblyz2hldxgqo2i7fywpgzuaqxzxsbavme7pfahj3uftgloeqq@pxeddjzm4sdj>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fblyz2hldxgqo2i7fywpgzuaqxzxsbavme7pfahj3uftgloeqq@pxeddjzm4sdj>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8888-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C23912C782
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:26:49PM +0900, Koichiro Den wrote:
> On Wed, Feb 11, 2026 at 05:52:53PM +0100, Niklas Cassel wrote:
> 
> Thanks for the additional context.
> Even if we introduce the distinction between BAR_RESERVED and BAR_DISABLED,
> as I understand it, we currently lack a way to describe what actually
> resides behind a BAR_RESERVED region.
> 
> Perhaps extending pci_epc_bar_desc to describe what a reserved BAR
> contains (e.g. DMA register block) might allow us to handle this in a
> cleaner and more generic way. It would at least be cleaner than treating it
> as a quirk and hard-code the reserved BAR+offset+contents.

Yes, you are absolutely right.

Improving struct pci_epc_bar_desc to be able give more information about a
BAR_RESERVED BAR would be a next logical step.

If we take RK3588 as an example:
BAR4 offset 0x0 is eDMA registers.
BAR4 offset 0x2000 is ATU registers.
BAR4 offset 0x4000 is MSI-X table.
BAR4 offset 0x5000 is MSI-X PBA.


Many different SoCs have the MSI-X table in one of the BARs.

pci-epf-test always puts the MSI-X table in BAR0 (test_reg_bar), after the
pci_epf_test_reg registers.

On RK3588, this mostly works fine, e.g. the MSI-X test case in the
pci_endpoint_test selftest passes with the MSI-X table in BAR0, however,
e.g. dw_pcie_ep_raise_msix_irq_doorbell() does not work when the MSI-X
table is in BAR0. If I hack the pci-epf-test code to have the MSI-X table
in BAR4 (as it is by default), then dw_pcie_ep_raise_msix_irq_doorbell()
works fine.


This would however require an EPF driver to be able to get an EPC drivers'
"desired" MSI-X table and MSI-X PBA location, so that it could call
pci_epc_set_msix() with these "desired" locations.


I guess we would just need to add a new "get desired MSI-X location" API
in epc->ops. However, I have been too busy to work on this, so right now it
is only an idea. (Anyone with some spare cycles are free to implement it.)

I know for a fact that many other SoCs with the DWC PCIe EP controller have
the MSI-X table in one of the BARs by default, so this would also allow
them to use dw_pcie_ep_raise_msix_irq_doorbell(). (And would also allow us
to no longer force disable these BAR_RESERVED BARs, as the PCI endpoint
currently has no way to make use for these BAR_RESERVED BARs.)


Kind regards,
Niklas

