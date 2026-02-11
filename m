Return-Path: <dmaengine+bounces-8886-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id beOsD++zjGmPsQAAu9opvQ
	(envelope-from <dmaengine+bounces-8886-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 17:53:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD727126556
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5908E3010D87
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848A3101B2;
	Wed, 11 Feb 2026 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmULYB3l"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1CF2DB7AD;
	Wed, 11 Feb 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828780; cv=none; b=t3S26sjk4VGw8qngQ5kMSrGqkv+DYK8jM7mRjqyoW5OOOrG+9gYbu7BZJSXK8LXI48pZBdYuWAEJyvDKCjez50a3oBF0VlxzMzJ4ILm+OohxK205xGP7QCxzRmYOwrh0OtElcXzmQguBiUwEVEEV2ZBjd5p+ghdIis0NAnZImiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828780; c=relaxed/simple;
	bh=uKGGO9qLVypn3QZ/+crQkh3WW4pRGi13JWgjd+P/5Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGplhU4kt50o0NSlo34KPU82z3pSAlRuOveAmaG8sDQaH2B6tyhR6ln2pu2qkybNpw3dDXkG2ocsBFN3hL4cR40T5O/fxmdBttyVHq3u5eS4mRrwSxR9hvCyVG1SDzd4KI/xhVmo/zWGFJVqqisGBZfEQzvJM1lUpmebB/s7AWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmULYB3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3562C4CEF7;
	Wed, 11 Feb 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770828779;
	bh=uKGGO9qLVypn3QZ/+crQkh3WW4pRGi13JWgjd+P/5Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmULYB3lnfRgAtcAZEMYWaKRgVp6jHzl0rl/2cNSnT9YmhUCKEKQbE6GhqjvBODbT
	 ykx2GnZQMqUFS6BB+VLrbyNi3dlLefq0yzcuFDMy9CqCyrXKAfAwQhRp04yXXqvyam
	 l5/qmBBaUEWgZf6+9AZ3/gRqNbiOkW/+W7tHlySIqpK4pGVIh1RPn8u6f4DWoEoj5U
	 ZVErRORRUbVs1bkLqnqinNlYv+HqcHAdmo8/j7tx/Nq49+MkDXEFfTEYtgocoVNlXP
	 TikquGef5hi9VmnPO/gT7wBizZe6f/l1G3gP9JnAGDZUrV96E+1EVya9oelv1v5F7r
	 XofoGnRRoykxw==
Date: Wed, 11 Feb 2026 17:52:53 +0100
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
Message-ID: <aYyz5WF_iJuNwA35@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8886-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD727126556
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:57:52AM +0900, Koichiro Den wrote:
> Could you try a quick experiment on the Rock 5B EP side?
> 
>   devmem 0xa403800a0 32 1
>   devmem 0xa403800a0 32 2
>   devmem 0xa403800a0 32 4
>   devmem 0xa403800a0 32 8

Here it goes:

# cat /proc/interrupts | grep edma
 53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          0          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
# devmem 0xa403800a0 32 1
# cat /proc/interrupts | grep edma
 53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          1          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
# devmem 0xa403800a0 32 1
# cat /proc/interrupts | grep edma
 53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
# devmem 0xa403800a0 32 1
[  104.217632] pci_epf_test_doorbell_primary
# cat /proc/interrupts | grep edma
 53:          1          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
# devmem 0xa403800a0 32 1
# cat /proc/interrupts | grep edma
 53:          1          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
 54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
 55:          1          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
 56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep


Seems very random if you ask me.

Same randomness is observed when I write other values, e.g. 2.


Could this randomness be because I do not have:
https://lore.kernel.org/dmaengine/20260105075904.1254012-1-den@valinux.co.jp/

Or do you think that is completely unrelated?



> > RK3588 (pcie-dw-rockchip.c) exposes the DMA registers in BAR4 by default.
> > If I hack pci-epf-test on top of your patch to unconditionally return BAR4 with
> > offset 0xa0, it works. So my best guess is that the fixed inbound translation
> > in BAR4 (to the eDMA registers) somehow messes with the inbound translation if
> > another BAR tries to use an inbound translation to the eDMA registers as well.

Adding Manikanta to CC.

RK3588 is not the only SoC that has the eDMA registers exposed via a BAR,
some other SoCs like Tegra234 also has the eDMA registers exposed via a BAR.

Me and Manikanta were discussing this a few days ago:
https://lore.kernel.org/linux-pci/aYsQu9lQi4IzfBiP@ryzen/


> 
> Thanks a lot for letting me know that. I see two possible ways forward:
> 
>   (a) extend PCI_EPC_AUX_DMA_CTRL_MMIO to optionally describe that the DMA
>       MMIO window is already mapped to a fixed BAR and should be reused, so
>       EPFs avoid creating a second mapping to the same target. I guess it
>       could be treated as a quirk for "rockchip,rk3588-pcie-ep".

I do like the idea that an EPC driver can somehow provide the BAR number
which the eDMA registers are already exposed in, together with the offset
and the size within that BAR. After that pci-epf-test could still work with
the emulated doorbell (only difference is that it would not program the iATU).

(This would also require Manikanta suggestion of having both a BAR_RESERVED and
a BAR_DISABLED type, and support in pci_endpoint_test to ignore RESERVED BARs.)


> 
>   (b) alternatively, clear the default BAR4 mapping on RK3588 at least
>       temporarily when using the pci-epf-msi doorbell fallback.

So for these SoCs like RK3588 and Tegra234, it appears that the option to
expose the eDMA registers in one of the BARs is a Synopsys DWC config that
you set when you synthesize the DWC core.
When you do this, it appear that that BAR will always some kind of fixed
inbound address translation (i.e. even when you disable all inbound iATUs
this translation for BAR4 to eDMA registers is still there).


Kind regards,
Niklas

