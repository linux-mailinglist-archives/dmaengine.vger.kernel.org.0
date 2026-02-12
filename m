Return-Path: <dmaengine+bounces-8899-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK6BNIj3jWlw8wAAu9opvQ
	(envelope-from <dmaengine+bounces-8899-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:53:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1312F211
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CA630432CC
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACA17C220;
	Thu, 12 Feb 2026 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="aWDBL94p"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550A4A21;
	Thu, 12 Feb 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911621; cv=none; b=q0F/zR/opbEXFI4OtT7kQyLC9D+zTIfpnxwoDvr21eMS0dILrTuhmO1tdVOJYDMos57X6dgliNmJ+Jmgre+JKosZexfYB6DiZisNAxxruHC/RefKwICVW99yY3TJ9YJvvPAs1GPpS/Q+4fqLbaAdS5WX2jhXs2MXVMIfZsuGSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911621; c=relaxed/simple;
	bh=jAMNABpc9UUDOujXV5IS7s+RU6Lxa17KFA1XyY/C9wk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GY4tPL9s7NhCLu7CQlox/zB8ZpB7EtOXgvzsUutW+65lRWdkbsx/y8VS3wBF5+bY2kHO8NcxVC0QA4SiXqbNktfuIU04QukireYsLcDHw4+IrSXJESioxjfGd2bAvWKD2lU7Mi6WqafVY/qSUs+85KxfJ2hRXlHC3mvWpudqJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=aWDBL94p; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id F301E4326E;
	Thu, 12 Feb 2026 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1770911611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNACE6+Hol33I7jrQNVMHpR4ZMYpWR2iwsgQkhdPOPI=;
	b=aWDBL94p/puKTNn62lJ+Od5rzTOLdZMtAl+IcBNEzGvEXdsMd4nCHVbno+Hfphw5d3f2Mo
	Guvq2XnpwxR53D3O0kEC8AqCZQnNu/Dg4baDMdfFrmH7TcbP0z59KvcxJ8m/XBxRYsgEKw
	vjLpEpzi+laeYDQe9js7nf5ObCoqVD2JB+ihBRClso2AlRRWc1kyJF/k53KVbjCQW/c/vM
	c+1y6t0p1k6BxEqSkIVUCpf6sCLDiiL1bY0aeDQk+ZIfOeVbbUggY2L+fsOP0OQQ77/vrI
	Bxb1T0klo39lMqOCOKcf6opheVhcU0PLebxJUkyEtT7spZiiONBbyOMQMb4Eyg==
Message-ID: <941806a6-0deb-415d-8af3-e78d6104da1c@yoseli.org>
Date: Thu, 12 Feb 2026 16:53:16 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [RFC] omap2-mcspi: periodic zero TX in target mode - debugging help
 needed
Content-Language: en-MW
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org, peter.ujfalusi@gmail.com, vkoul@kernel.org,
 dmaengine@vger.kernel.org, vigneshr@ti.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfhffuvfevtgfgsehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepueevgfejiefhleelgeeiffejgefftefhgeefkeejueeigeeigeegfeffjefhtdegnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmedvrgegtdemfhefrggrmeejudejvgemudefsgdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemvdgrgedtmehffegrrgemjedujegvmedufegsvddphhgvlhhopeglkffrggeimedvrgdtudemvgdtrgemudeileemjedugedtmedvrgegtdemfhefrggrmeejudejvgemudefsgdvngdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpqhhiugephfeftddugfegfedviefgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghro
 hhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhhujhhfrghluhhsihesghhmrghilhdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[yoseli.org:s=gm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8899-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[yoseli.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,ti.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yoseli.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yoseli.org:mid,yoseli.org:dkim]
X-Rspamd-Queue-Id: 20E1312F211
X-Rspamd-Action: no action

Hi,

I'm seeing a puzzling issue with omap2-mcspi in target mode on AM64x
and could use some help understanding what might be happening.

Here is my setup:
- AM64x as SPI target, external controller at ~1 MHz, 1 Hz frame rate
- Target mode, DMA enabled (k3-udma, not legacy EDMA)
- Fixed 64-byte transfers (matches MCSPI FIFO depth)
- Full-duplex, using spi_async() for continuous operation
- Kernel 6.12.y (also tried mainline, same behaviour) + PREEMPT_RT

Periodically, MISO outputs all zeros instead of the prepared TX buffer.
The pattern is surprisingly regular: every 42 or 43 transfers.
If transfer #10 fails, then #52 or #53, #94 or #95, etc.

This number (~42) doesn't obviously match any power of 2 or buffer
size I'm using, which makes it more puzzling.

I have verified a few things:
- TX buffer is correctly filled before spi_async() returns
- Added debug check: buffer is NOT zeros at submit time when failure occurs
- RX works fine (master data received correctly)
- System is mostly idle (basic Yocto, systemd, no heavy load)
- Logic analyser confirms: zeros on MISO, correct clock/CS from master
- Forcing single CPU (maxcpus=1) does not change behaviour

This suggests the data is correctly prepared but doesn't make it to
the FIFO in time. The issue seems to be in omap2-mcspi or k3-udma,
not in my slave protocol driver.

DMA configuration:
- Using k3-udma (AM64x UDMA subsystem)
- Single DMA descriptor per transfer (not cyclic)
- DMA-coherent buffers allocated with dma_alloc_coherent()

Questions:
1. Are there known timing constraints for target mode DMA that
    could explain this periodic behaviour?
2. Could this be related to k3-udma descriptor recycling or
    ring management around ~42 iterations?
3. Is there recommended tracing/debug I should enable to
    investigate the DMA/FIFO timing?
4. Has anyone seen similar periodic failures in target mode?

I can provide more details, traces, or test patches if helpful.

Thanks for any pointers!
Jean-Michel

