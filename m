Return-Path: <dmaengine+bounces-10896-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LoVN6RZFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10896-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:28:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751C5D2776
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F593019BAA
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F83C3C0E;
	Tue, 26 May 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKuEXGos"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9F3451A7;
	Tue, 26 May 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784095; cv=none; b=Bq/9tCfetgubNFXu+DAtK8ENSzHLfAqv+fyDNSspLCwOQSml8bX7VBIROU8AOG2nlCirq8x2g+gqpCrzv47/3GS1Hvf3uv7s55YKuwV3/tvDvvQzQdUBAZzxyEhLqty1/APJF9svoSoka7oIOJ1CuoNt10Qd6NJiAvVjFOJWA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784095; c=relaxed/simple;
	bh=789CkO4abUnWovDkP2BY7XJfp5tN4S/x1EX3kh83RhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBt+ZpkQY7JLR/rS+HRGQspnKEuvPwrxHzjDxj2OKhkfbybvWy+/cJYQWN+d7YdfkB4Dt+y1ceETgXbzv19+g70Cf8dNb7aM+N7fgmGcCI2WiHMxVA02adfABDVj5eogIkY3dYazxMWB8H9CKuDpOIQ/jF8s73jvnmYNiNsj8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKuEXGos; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B851F000E9;
	Tue, 26 May 2026 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779784093;
	bh=LT5Q0GcrI3IDVOP/iwdLProaGoCzh8gCBMqgxT/KQJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GKuEXGosoZPcQB0Bio3ESczf16muO3sgtFDuLtbJBRGqyHFxNeC3YCvjmZ58Xdhag
	 CXP+CGVVhETUa3XmaLRR+YYtuMnuA/UMipJh99IR5EIOuwKkjkpMv/jdogKqS5Z7Uu
	 ArqnhxusbbJQmEm7gB5vj62fI96Lz4gx2zNKCELyfD/W8NJgU2eEe6/gHZEM/m/SZ0
	 TTUdPt2UqQc5mmviJImcT9ga35q0J9BLn1WUrnsvjcws5Zr/ONlSAZY9luPaJXDM1f
	 G4Fi+F1N7QjFSZKysllhI+hCQjx6N7tc2/UuUZPWEnka4CPkw5eTjFm7DDFr5fPJCG
	 JRCVwGTug8BqQ==
Date: Tue, 26 May 2026 10:28:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <ahVZl6YRlBB_OBlz@ryzen>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
 <ahQJ4kuaBKMhj52L@ryzen>
 <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
 <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org>
 <ll76isrjb62ieiz4vhn3u3upp46vnzed3slpqxnni5hymsc4mw@avbx7k473uo4>
 <F8664D81-EABE-4E36-B0C9-2B0C7FA36DC0@kernel.org>
 <b5qre4rphbq4datwi3apyh5jy5b7obz4aj3pfn2gzmke6znmib@gpdbheezoi2z>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5qre4rphbq4datwi3apyh5jy5b7obz4aj3pfn2gzmke6znmib@gpdbheezoi2z>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10896-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4751C5D2776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:23:57PM +0900, Koichiro Den wrote:
> On Tue, May 26, 2026 at 07:35:06AM +0200, Niklas Cassel wrote:
> 
> Yes, I also think the architecture of this series is much cleaner. The option 2
> series may look like it overloads and complicates vNTB a bit too much, and the
> auxiliary device created from ntb_hw_epf only for the channel delegation purpose
> may look awkward to some.
> 
> The coverage concern is a real downside of this direction though. This is a
> trade-off between a cleaner PCI/DMA model and broader EPC coverage. On my side,
> R-Car Gen4+ is the main target, so the multi-function requirement is acceptable.
> In that sense, I am also curious whether future DWC-based SoCs will typically
> support more than one function or not.

It seems that the number of supported physical functions is controlled by
the configurable PCIe IP-core synthesize parameter CX_NFUNC.


Looking at the code, if the device tree property 'max-functions' is missing,
it will set epc->max_functions to 1:

$ git show f8aed6ec624f

It has been like this since the initial EP support in the DWC driver, added
in 2017.

However, a missing 'max-functions' device tree property does not necessarily
mean that the IP-core was configured with CX_NFUNC == 1.


Right now, I don't see any register to get CX_NFUNC.

Perhaps it is possible to write some code that figures out CX_NFUNC, by
writing different values to the iATU registers, somewhat similar to how we
detect the number of inbound and outbound iATUs:
https://github.com/torvalds/linux/blob/v7.1-rc5/drivers/pci/controller/dwc/pcie-designware.c#L998-L1001



I added EP mode support for the pcie-dw-rockchip driver, but I don't know
the CX_NFUNC parameter value, so I could not add a 'max-functions' property.

While it is possible that some DWC-based PCIe endpoint controllers are
configured with CX_NFUNC == 1, it is also possible that some people simply
did now add a 'max-functions' property, because they did not know the CX_NFUNC
value, just like me.


Shawn Lin, do you perhaps know the CX_NFUNC value for rk3588 and rk3568 ?


Kind regards,
Niklas

