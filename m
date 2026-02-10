Return-Path: <dmaengine+bounces-8880-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDZmGWhdi2mYUAAAu9opvQ
	(envelope-from <dmaengine+bounces-8880-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 17:31:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C323A11D31D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2613068BC2
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09ED2D979C;
	Tue, 10 Feb 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUAL34mu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95478283C89;
	Tue, 10 Feb 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741016; cv=none; b=otlMAEiHVwOjMmFW6ARHiftrAb0bRTCsBptnosM6MQBCQ0NNHOtnf5d53YfIiVpc5k1V9Pz6OfrmOwSESaL5Us1bZiYIjrhkvAJ9T8KN7Rbx0pNiXAh7qelr+l15ctemUXCWbkXyQLEaP+D5C/RB3D5VSZT/cPwmH4pcDWTO0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741016; c=relaxed/simple;
	bh=SQSIBRF8RgnCHZnc0WIK4l3+PaDqumSEoXhF3Q+r67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlRZ504IYJR3rJYvUqeMPk8JRuCBdOG3Sy/4Cw7Vx0QSH/OddsCJcyb8qXGHb68YysVrjiu4w5flLE2q6EezycRQ6Fgi5Q8MD0CifHjNayh6Me84Izkzwoxgydp75nYbPAqjrxc4gr9+sC754zl+EAEmC0jI7084CNzi4qUIU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUAL34mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFDDC116C6;
	Tue, 10 Feb 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741016;
	bh=SQSIBRF8RgnCHZnc0WIK4l3+PaDqumSEoXhF3Q+r67o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUAL34muUDzanBqL4aRDcCr/OMF8OdU7Y4phHZU1AtQE2mNhuoTFgYkHz3JDSyLNe
	 OB8NOIwt9FWx0G4YCnOevuyn9cTSHUF2c4oN5ey3MxuTEHhevfKXRiXgBCLpnVHC9d
	 FRGN+L1Q6HYOLAZp7XvvH7/apuh2raoGujSuG7/tzbCuNR654rma7SuDYPj68v7hS8
	 iQHLdRvDoSjAZ9rSX6XPUfXIHi5mkX1AiPdag5TJI50zEgAWAinzDIIO8UJpIUTJ8Z
	 0/zR6iloKQRmPbkA5vzbYFJdHLIav2CZjSBu5Sd1JlQl/D23kXUo1xbKsmZJ5vxc6q
	 vGU6bK0QC3C5A==
Date: Tue, 10 Feb 2026 17:30:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aYtdEnZM5mnmcgtY@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8880-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C323A11D31D
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:07:16PM +0900, Koichiro Den wrote:
> On Tue, Feb 10, 2026 at 01:24:29PM +0100, Niklas Cassel wrote:
> > On Mon, Feb 09, 2026 at 09:53:08PM +0900, Koichiro Den wrote:
> > > Tested on
> > > =========
> > > 
> > > I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
> > > R-Car Spider boards:
> > > 
> > >   $ ./pci_endpoint_test -t DOORBELL_TEST
> > >   TAP version 13
> > >   1..1
> > >   # Starting 1 tests from 1 test cases.
> > >   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > >   #            OK  pcie_ep_doorbell.DOORBELL_TEST
> > >   ok 1 pcie_ep_doorbell.DOORBELL_TEST
> > >   # PASSED: 1 / 1 tests passed.
> > >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > 
> > > with the following message observed on the EP side:
> > > 
> > >   [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > > 
> > > (Note: for the test to pass on R-Car Spider, one of the following was required:
> > >  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
> > >  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)
> > 
> > I applied this series on top of branch pci/controller/dwc
> > on Rock 5B (pcie-dw-rockchip.c).
> > 
> > On EP side:
> > [   39.218533] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
> > [   39.219125] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > 
> > On RC side:
> > #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > [   40.297892] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> > # pci_endpoint_test.c:279:DOORBELL_TEST:Expected 0 (0) == ret (-22)
> > # pci_endpoint_test.c:279:DOORBELL_TEST:Test failed for Doorbell
> > 
> > # DOORBELL_TEST: Test failed
> > #          FAIL  pcie_ep_doorbell.DOORBELL_TEST
> > not ok 23 pcie_ep_doorbell.DOORBELL_TEST
> > 
> > Any suggestions?
> > 
> > (All BARs in pcie-dw-rockchip.c is marked as BAR_RESIZABLE.)
> 
> Thank you for testing.
> 
> If the failure was observed in a scenario other than a plain
> `./pci_endpoint_test -t DOORBELL_TEST`, could you please try again with [1]
> applied as well?
> 
> [1] https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/

I applied that series, but I got the same problem.

I added debug, and the EP side does use the correct address for the eDMA:
[   26.279457] msg_addr: 0xa403800a0
[   26.279898] phys_addr: 0xa40300000 offset: 0x800a0


If I write to the msg_addr directly on the EP using devmem, I do see the print
that I added in the IRQ handler:
# devmem 0xa403800a0 32 0
[  155.861989] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  158.809160] dw_edma_interrupt_emulated:696
[  158.809543] pci_epf_test_doorbell_primary:729
# [  158.809986] pci_epf_test_doorbell_handler:703
# devmem 0xa403800a0 32 0
[  161.241326] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  163.466054] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  167.378662] dw_edma_interrupt_emulated:696
[  167.379045] pci_epf_test_doorbell_primary:729
# [  167.379512] pci_epf_test_doorbell_handler:703
# devmem 0xa403800a0 32 0
[  168.880179] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  170.492176] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  171.729154] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  173.481271] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  174.985787] dw_edma_interrupt_emulated:696
# devmem 0xa403800a0 32 0
[  176.517131] dw_edma_interrupt_emulated:696
[  176.517511] pci_epf_test_doorbell_primary:729
# [  176.517963] pci_epf_test_doorbell_handler:703

But not on every write....

I'm not sure, but could this perhaps be because we are missing this patch:
https://lore.kernel.org/dmaengine/20260105075904.1254012-1-den@valinux.co.jp/

# dmesg | grep eDMA
[    1.243339] rockchip-dw-pcie a40000000.pcie-ep: eDMA: unroll T, 2 wr, 2 rd

# cat /proc/interrupts | grep edma
 53:          8          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          7          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:         15          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          7          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep



Anyway, I was still curious why this did never worked when writing from the
host side, even when running the test case many, many times.
AFAICT, the inbound translation looks correct.

RK3588 (pcie-dw-rockchip.c) exposes the DMA registers in BAR4 by default.
If I hack pci-epf-test on top of your patch to unconditionally return BAR4 with
offset 0xa0, it works. So my best guess is that the fixed inbound translation
in BAR4 (to the eDMA registers) somehow messes with the inbound translation if
another BAR tries to use an inbound translation to the eDMA registers as well.


Kind regards,
Niklas

