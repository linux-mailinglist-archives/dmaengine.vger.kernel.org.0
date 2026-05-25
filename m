Return-Path: <dmaengine+bounces-10884-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPF2CV6PFGqrOQcAu9opvQ
	(envelope-from <dmaengine+bounces-10884-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 20:05:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11E5CD89E
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1064F3014107
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25C31E848;
	Mon, 25 May 2026 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+C1NYdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58814347C7;
	Mon, 25 May 2026 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732312; cv=none; b=DAfM28+BJHUvZPUvWffzIZyFG6wJP2Y6aCFgCUa8dBUIt1PiS3JKP7p9ddnx1aXcytR+xn3D7yCj6c9Z5MTQ0TjeyplT4KDUxN0b1ziPH1CTLnXNHdk5Jy/EaaFQZireO05xwzjsrNyS3d5jSd9RoMk40ZpGuF9Zq5WB9MLn6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732312; c=relaxed/simple;
	bh=EmfQ1yxbMEGRoizCR7X16Wqm+GBbblI/+aYBZGYvyx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF3Be/d12iTsB/wtYSMnJO3ma2NhzTBd14JluIOs0s0razuzzunejPvJUfOTUQN9z+gGQGFFh3MTQO7BbeMARMwL+Hf0MTae/e9DlB5vkerYaXqH87CVbUGIxDfHyHlHbHsgXZNPVLnERteVggWW9wRU7kM75iOH/MqsLIDPO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S+C1NYdp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8csN7nMG9tYLUa25VgCwIGRZ1Qs1kAYsX1P7s60cOCE=; b=S+C1NYdpjT4Kvjwgp5z5FP9evs
	WM2vXyxqmgscRgrhj4NIH37uOgF7GyepuJ2XharM9IdHRmn93G3AaZnDKW+SATK+oxrpbA85MaLxR
	Tac0HSqR1dfvRoRF7gcgS0HGKZDUouBsO9gV3ZARj96Q0wAU8RT+HOziU/bx4elZ5jhcwDyUt6ijN
	HHbIHQxjjKthUVWgFmQmtdKkODWekgVP9IiCL71yDabeLkwlUECkzo8F6O4MA+cbAMy66nhwCsxuN
	UJ1LmqBMZb7b4gH/qeg/LJHfNGR3kpFaS1/gCgh0G3BROEOvOhZ9mdymdEWQL+vBLh6kcwxgxDYW3
	bw8PuU9w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZfn-00000000Bpu-1Sjt;
	Mon, 25 May 2026 18:05:07 +0000
Message-ID: <98d30903-e456-4cb6-adaa-35b98ee7008b@infradead.org>
Date: Mon, 25 May 2026 11:05:05 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Documentation: PCI: Add PCI DMA endpoint function
 documentation
To: Koichiro Den <den@valinux.co.jp>, Manivannan Sadhasivam
 <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <20260525063456.3317509-4-den@valinux.co.jp>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260525063456.3317509-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10884-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D11E5CD89E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/24/26 11:34 PM, Koichiro Den wrote:
> Add a function description and a user guide for pci-epf-dma. Describe
> the BAR-resident metadata consumed by dw-edma-pcie, the configfs
> attributes, endpoint controller requirements and the host-side DMAengine
> usage model.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  Documentation/PCI/endpoint/index.rst          |   2 +
>  .../PCI/endpoint/pci-dma-function.rst         | 182 ++++++++++++++++
>  Documentation/PCI/endpoint/pci-dma-howto.rst  | 200 ++++++++++++++++++
>  3 files changed, 384 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst


> diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
> new file mode 100644
> index 000000000000..54caf4fafe00
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-dma-function.rst
> @@ -0,0 +1,182 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +PCI DMA Function
> +================
> +
> +:Author: Koichiro Den <den@valinux.co.jp>
> +
> +The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
> +to the PCI host as a PCI DMA controller.  A matching host-side driver
> +discovers the endpoint DMA metadata and registers the delegated channels with
> +the Linux DMAengine framework, so host DMAengine clients can submit
> +transfers.
> +
> +An endpoint Linux system can already use an endpoint-integrated DMA
> +controller locally through the normal DMAengine API, for example to transfer
> +data between endpoint memory and host addresses reachable over PCI.  The PCI
> +DMA function provides a different ownership model: it delegates selected
> +local DMA channels to the host, so a host DMAengine client can request and
> +program those endpoint-side channels through the host's DMAengine API.
> +
> +To make that possible, the endpoint function publishes the DMA controller
> +register window and descriptor memory layout to the host, reserves the
> +selected local DMA channels on the endpoint side, and lets the host program
> +those channels directly.
> +
> +Constructs Used for Implementing DMA
> +====================================
> +
> +The PCI DMA function uses the following endpoint-side resources and
> +configuration:
> +
> +	1) DMA controller register window
> +	2) DMA descriptor memory for endpoint-to-RC channels
> +	3) DMA descriptor memory for RC-to-endpoint channels
> +	4) MSI or MSI-X interrupt vectors selected through configfs
> +	5) One endpoint BAR used to publish metadata
> +	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
> +
> +The endpoint controller reports the DMA controller register and descriptor
> +resources through the endpoint auxiliary resource interface.  The PCI DMA
> +function uses those descriptions to build the host-visible metadata and to map
> +resources that are not already visible to the host.
> +

Most of the headings/titles in these 2 documentation files don't use ':' at the
end of the headings. I suppose that we don't have any explicit docs guidelines
for that[*], but these (below) stand out as unusual to me (mostly due to the overall
inconsistency but also because headings just don't typically end with a colon
IME.

> +DMA Controller Register Window:
> +-------------------------------
> +
> +It contains the DMA controller registers programmed by the host-side driver
> +to submit transfers, control channels and handle DMA interrupts.
> +
> +DMA Descriptor Memory:
> +----------------------
> +
> +It contains the descriptor memory used by the DMA controller.  The PCI DMA
> +function exposes descriptor memory for the delegated endpoint-to-RC and
> +RC-to-endpoint channels.
> +
> +MSI/MSI-X Interrupt Vectors:
> +----------------------------
> +
> +They are used by the delegated DMA channels to signal completion and error
> +conditions to the host-side driver.
> +
> +Metadata BAR:
> +-------------
> +
> +It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
> +bits.  The BAR remains stable while the endpoint function programs the DMA
> +windows.
> +
> +DMA Window BAR:
> +---------------
> +
> +It is the endpoint BAR used for DMA resources that are not already visible
> +through a fixed BAR.  The endpoint function may switch this BAR to subrange
> +mapping after the host-side driver has found the metadata BAR.

*: other than Documentation/doc-guide/sphinx.rst, where heading styles are listed
   without colons.

-- 
~Randy


