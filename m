Return-Path: <dmaengine+bounces-12513-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IdO5CWWoVmpH/wAAu9opvQ
	(envelope-from <dmaengine+bounces-12513-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:21:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80091758F2E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=YbVMRSmn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12513-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12513-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67273170244
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B142BE99;
	Tue, 14 Jul 2026 21:20:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96C429CF2;
	Tue, 14 Jul 2026 21:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064026; cv=none; b=f7lcn4XEufCS+HRy6LluF4irai7zhzRsyXihbxmlFiMU8XzNw8MdGEbHUF083FmFUerQqz3sK1ZsXvUjUvwPDJyAmkPLD4Z0z+M0UZpO1NxkWVNkA77m8sVz88sSfZU7K9b8Q9q7f5Ol95GEWnI0lOb6BeP/Y339ckyhkcZV2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064026; c=relaxed/simple;
	bh=/X1H+k2YxZZWlyV3x4QI4UZPgomuKoqSmyFjtJcNupk=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=W+fj5cR+ckDcwLXRZYl9RIAqwd08YbZlZ95NnJbzyPTQd3cu8Isdskdo+P7Lwuz9GQpwM2CTrtZprUKh54nJx6prCJi29OGW8eSXs74U5hnPVgsUhU/+6bWS/zBPB94W6sDVIFoOorIYw2tkCm/TebajNuEEROJtZdqv7ydoBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=YbVMRSmn; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=rFUhiFfx0i2Cwm3JEEH4ABXaQvgSg13H3UWRN2dUQvQ=; b=YbVMRSmn97vwCjVrjQceuKrIox
	KVd+4ZzawoIe+Gv8msfE0q72zgHLkyW+qH8olbsDqeZzfMgR+U32EshiQird6ZSZl848LlRbMKTIl
	LD91t6KKcSWRCyaKck2HlbhNtBludVSw8WNJzgk8/VUjhBtfxAtI1e86lJvNTrp1ir9aMTwGk7VJl
	i2DH/MxsrvPtcERmKn3x/xcbHXLOO7sVG2ecSTPNu75kbuhOEFaJA18piVEIF6aTdruQWS4mAzrqA
	74RxJKcgSjjhcE7RgRHt3aCZfk1PCj93QCEq83ICuaytU+7xZuq9aKK9pNR7v0/OiXTd0I7+g3Sqn
	0I4GSvKA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY3-00000006f2P-14u5;
	Tue, 14 Jul 2026 15:20:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY1-00000000xzl-2uU9;
	Tue, 14 Jul 2026 15:20:13 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jul 2026 15:20:07 -0600
Message-ID: <20260714212010.230606-1-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 0/3] switchtec: add new device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12513-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:bhelgaas@google.com,m:Frank.li@nxp.com,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[deltatee.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,deltatee.com:from_mime,deltatee.com:dkim,deltatee.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80091758F2E

This little patch set adds some new device IDs for switchtec hardware
to the PCI driver, the DMA driver and the PCI quirk needed for NTB.

I originally included this in a patchset I'm working on for
switchtec-dma but the Sashiko bot reminded me I need to add it to the
PCI management device and the quirk used for NTB. So I've respun three
patches here.

I'm open to options, but I might suggest if everyone is okay with it
these three patches could just go through the PCI tree together.

These three patches are based on v7.2-rc3.

Thanks,

Logan

Logan Gunthorpe (3):
  dmaengine: switchtec-dma: Add PCI1008 device ID
  PCI/switch: switchtec: Add PCI1008 device ID
  PCI: Add PCI1008 to switchtec NTB DMA alias quirk

 drivers/dma/switchtec_dma.c    | 1 +
 drivers/pci/quirks.c           | 1 +
 drivers/pci/switch/switchtec.c | 1 +
 3 files changed, 3 insertions(+)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.47.3


