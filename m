Return-Path: <dmaengine+bounces-11805-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mjorEsU5PmoNBwkAu9opvQ
	(envelope-from <dmaengine+bounces-11805-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:35:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45CA6CB634
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:35:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DLkaMOoe;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11805-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11805-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B9D315A378
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7E3ED5B2;
	Fri, 26 Jun 2026 08:21:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CF3E1696;
	Fri, 26 Jun 2026 08:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462114; cv=none; b=blBsEee2j92gRf+Uv7CeWnDVNFiT14GF5FTJ1P93O8+SIFCu3gm1QCZ0r5tn4EcV1YaR2l2CssfAOtNE3f0R8cwYVu23XtAvuvir44b+gTvLCjPTT+zYqP8lHg4tkkCYOfC2d3oVR9YpoWCRldg5cq6PkZNaQIUnOnGI1wY+OK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462114; c=relaxed/simple;
	bh=/4mtzQsCbxNw+zby24mrqKFAWlXw3OO99jVq6qbqJHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7UCXmfpqRRnQ0FV9n2VmXE+DT8iSoo+pQWTO50LFQh0QoAz9m+PpVsycnWRl0IiRRXQbXWlGHOSh6IM0wMaQZhg15tCS4pIU+SyyrMhBMX2xpyzQrhm4oJeOp2LkYfgPQjL8e7Lrmm/g0MwE6gjKiOr9KdRP9auSkiuBtOqTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLkaMOoe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDAC1F00A3A;
	Fri, 26 Jun 2026 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462112;
	bh=7N6xFs6HldNaJtHXB+1so7kMQ4CsatgFOfKvzUpfQ6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DLkaMOoe7jjLq0zrWVM7g5T3weWBVn0GKvdUrsWL1NS6Qs/YGb/jSI/OCz0xvfzqS
	 Qaym8bn+YQ7Yv3mFvqa3JZPMQyeTT1JkI61/DRV2mqoJOQ6RCZahCcrN/sZ0P41GxN
	 lQMkVEyzffwbljfjI4cRAmJFH6TA/MXXocYqdJ0r2fyaFbY7MUFYbzOT2mQ1bO9ESQ
	 aXENlZ4+KidZLyWpFEQCN/4TQ2SdvjPzYQw0gZqKyFHWnTN9MR5o7FqI9NLTieKhiJ
	 eEE7hw/g70YQVjdOMlBaDUGyYwudw/LY4An0H/3ioGWkJoeS59H947CE7rYTKgUHWr
	 baMoIKRFCt04w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D639389E8;
	Fri, 26 Jun 2026 08:21:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/9] driver core: Fix some race conditions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246209959.3816447.5329631417058038374.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:39 +0000
References: <20260406232444.3117516-1-dianders@chromium.org>
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, stern@rowland.harvard.edu, aik@ozlabs.ru,
 johan@kernel.org, edumazet@google.com, leon@kernel.org, hch@lst.de,
 robin.murphy@arm.com, maz@kernel.org, aleksander.lobakin@intel.com,
 saravanak@kernel.org, akpm@linux-foundation.org, Frank.Li@kernel.org,
 jgg@ziepe.ca, alex@ghiti.fr, alexander.stein@ew.tq-group.com,
 andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch,
 andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 astewart@tektelic.com, bhelgaas@google.com, brgl@kernel.org,
 broonie@kernel.org, catalin.marinas@arm.com, chleroy@kernel.org,
 davem@davemloft.net, david@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, driver-core@lists.linux.dev, gbatra@linux.ibm.com,
 gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev,
 jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org,
 kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com, maddy@linux.ibm.com, mani@kernel.org,
 miko.lenczewski@arm.com, mpe@ellerman.id.au, netdev@vger.kernel.org,
 npiggin@gmail.com, osalvador@suse.de, oupton@kernel.org, pabeni@redhat.com,
 palmer@dabbelt.com, peter.ujfalusi@gmail.com, peterz@infradead.org,
 pjw@kernel.org, robh@kernel.org, sebastian.hesselbarth@gmail.com,
 tglx@kernel.org, tsbogend@alpha.franken.de, vgupta@kernel.org,
 vkoul@kernel.org, will@kernel.org, willy@infradead.org,
 yangyicong@hisilicon.com, yeoreum.yun@arm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11805-lists,dmaengine=lfdr.de,linux-riscv];
	FREEMAIL_CC(0.00)[lists.infradead.org,linuxfoundation.org,kernel.org,rowland.harvard.edu,ozlabs.ru,google.com,lst.de,arm.com,intel.com,linux-foundation.org,ziepe.ca,ghiti.fr,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,eecs.berkeley.edu,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,linux.ibm.com,bootlin.com,gmail.com,jms.id.au,8bytes.org,lists.ozlabs.org,kvack.org,armlinux.org.uk,samsung.com,ellerman.id.au,suse.de,redhat.com,dabbelt.com,infradead.org,alpha.franken.de,hisilicon.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dianders@chromium.org,m:linux-riscv@lists.infradead.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:stern@rowland.harvard.edu,m:aik@ozlabs.ru,m:johan@kernel.org,m:edumazet@google.com,m:leon@kernel.org,m:hch@lst.de,m:robin.murphy@arm.com,m:maz@kernel.org,m:aleksander.lobakin@intel.com,m:saravanak@kernel.org,m:akpm@linux-foundation.org,m:Frank.Li@kernel.org,m:jgg@ziepe.ca,m:alex@ghiti.fr,m:alexander.stein@ew.tq-group.com,m:andre.przywara@arm.com,m:andrew@codeconstruct.com.au,m:andrew@lunn.ch,m:andriy.shevchenko@linux.intel.com,m:aou@eecs.berkeley.edu,m:ardb@kernel.org,m:astewart@tektelic.com,m:bhelgaas@google.com,m:brgl@kernel.org,m:broonie@kernel.org,m:catalin.marinas@arm.com,m:chleroy@kernel.org,m:davem@davemloft.net,m:david@kernel.org,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:driver-core@lists.linux.dev,m:gbatra@linux.ibm.com,m:gregory.clement@bootlin.com,m:hkallweit1@gmail.com,m:iommu@lists.linux.dev,m:jirislaby@k
 ernel.org,m:joel@jms.id.au,m:joro@8bytes.org,m:kees@kernel.org,m:kevin.brodsky@arm.com,m:kuba@kernel.org,m:lenb@kernel.org,m:lgirdwood@gmail.com,m:linux-acpi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-aspeed@lists.ozlabs.org,m:linux-cxl@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pci@vger.kernel.org,m:linux-serial@vger.kernel.org,m:linux-snps-arc@lists.infradead.org,m:linux-usb@vger.kernel.org,m:linux@armlinux.org.uk,m:linuxppc-dev@lists.ozlabs.org,m:m.szyprowski@samsung.com,m:maddy@linux.ibm.com,m:mani@kernel.org,m:miko.lenczewski@arm.com,m:mpe@ellerman.id.au,m:netdev@vger.kernel.org,m:npiggin@gmail.com,m:osalvador@suse.de,m:oupton@kernel.org,m:pabeni@redhat.com,m:palmer@dabbelt.com,m:peter.ujfalusi@gmail.com,m:peterz@infradead.org,m:pjw@kernel.org,m:robh@kernel.org,m:sebastian.hesselbarth@gmail.com,m:tglx@kernel.org,m:tsbogend@alpha.franken.de,m:vgupta@kernel.org,m:vkoul@kernel.org,m:will@kernel.org,m
 :willy@infradead.org,m:yangyicong@hisilicon.com,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D45CA6CB634

Hello:

This patch was applied to riscv/linux.git (fixes)
by Danilo Krummrich <dakr@kernel.org>:

On Mon,  6 Apr 2026 16:22:53 -0700 you wrote:
> The main goal of this series is to fix the observed bug talked about
> in the first patch ("driver core: Don't let a device probe until it's
> ready"). That patch fixes a problem that has been observed in the real
> world and could land even if the rest of the patches are found
> unacceptable or need to be spun.
> 
> That said, during patch review Danilo correctly pointed out that many
> of the bitfield accesses in "struct device" are unsafe. I added a
> bunch of patches in the series to address each one.
> 
> [...]

Here is the summary with links:
  - [v5,7/9] driver core: Replace dev->dma_coherent with dev_dma_coherent()
    https://git.kernel.org/riscv/c/3e2c1e213ac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



