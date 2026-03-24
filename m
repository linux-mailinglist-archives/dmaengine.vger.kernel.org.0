Return-Path: <dmaengine+bounces-9625-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKbjA9qVwmkXfAQAu9opvQ
	(envelope-from <dmaengine+bounces-9625-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:47:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DCC309AE4
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C2D93063BC5
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412293FCB2B;
	Tue, 24 Mar 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gNgOXKuN"
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A33F3FCB09;
	Tue, 24 Mar 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359374; cv=none; b=ZgNIBxzyntIshZCEQrh/WOzSRLH6YPBe9sAn8bsHpXog1/uYQAA8MyZpS2jmyntmWRW33R34c2eJYmvJM08YvLHBn/iHuIQeSRKSIyyzdmZ7HHjYijFEW1BpJKrZROmrKRtyY31nPS2G9rn5foljO6G3S2L/t9kg7qT4faECLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359374; c=relaxed/simple;
	bh=6Ki15S7l8XHPgNRBcqNoAGTGF7cTa367l+xsShVQxHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk0uznYSjp2KR+5kmS/jpSFfiafbVag2WJYmQRyMoI5F5odgUNYVbRpDNgVkbk59anIUciteDpKJeCUGJhpvHbi0ILXVt06hM5mQle5Em2F5yiLNoWIzBXz5BVVdVz37uPv1iqnx78uWxufesidL1CLsifI5FLTbP6xUEY8eFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gNgOXKuN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02931476;
	Tue, 24 Mar 2026 06:36:05 -0700 (PDT)
Received: from [10.57.76.67] (unknown [10.57.76.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F5B3F836;
	Tue, 24 Mar 2026 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774359371; bh=6Ki15S7l8XHPgNRBcqNoAGTGF7cTa367l+xsShVQxHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gNgOXKuNdMRBgb4secaHiXtf2czXw/iJ8jS8EV0omWiHC1pUpc1d9+L0HWMGwGkcR
	 N1YkeFBL9JagNz7itQgMZleszv1hcgbSmTTgH7REHuITcN4qxft1/mkbvkAOYwU1ty
	 O7LZY/a7MD5HOa48ZLjWiSonQJe51FGY/r4yyupk=
Message-ID: <77e54936-0d1b-452c-a9cc-36c6f03930f0@arm.com>
Date: Tue, 24 Mar 2026 13:36:06 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] dmaengine: arm-dma350: support combined IRQ mode
 with runtime IRQ topology detection
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260324120113.3681830-1-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260324120113.3681830-1-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9625-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10DCC309AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-24 12:01 pm, Jun Guo wrote:
> DMA-350 can be integrated with either one interrupt per channel or a
> single combined interrupt for all channels. This series adds support
> for the combined IRQ topology while keeping compatibility with the
> per-channel topology.
> 
> Patch 1 updates the DT binding to describe both interrupt topologies
> (1 combined IRQ or 8 per-channel IRQs).
> 
> Patch 2 updates the driver to detect IRQ topology at runtime via
> platform_irq_count(), handle both modes in one code path, and enable
> DMANSECCTRL.INTREN_ANYCHINTR only in combined IRQ mode.
> 
> Patch 3 adds the Sky1 DMA DT node using the combined IRQ topology.
> 
> Tested on CIX SKY1 with dmatest:
>    % echo 2000 > /sys/module/dmatest/parameters/timeout
>    % echo 1 > /sys/module/dmatest/parameters/iterations
>    % echo "" > /sys/module/dmatest/parameters/channel
>    % echo 1 > /sys/module/dmatest/parameters/run
> 
> Changes in v5:
> - Fix the formatting issue in the AI tag.
> - Remove the unnecessary "cix,sky1-dma-350".

Please don't churn reposts of a series so quickly. I've only just had 
time to finish the review of v3 that you posted only 3 working days ago, 
that I already moved over as a reply to yesterday's v4 for visibility...

Thanks,
Robin.

> Changes in v4:
> - Reword binding text to align with kernel style.
> - Revise the AI attribution to the standard format.
> - Remove redundant links from the commit log.
> 
> Changes in v3:
> - Rework binding compatible description to match generic-first model.
> - Keep interrupts schema support for both 1-IRQ and 8-IRQ topologies.
> - Drop SoC match-data dependency for IRQ mode selection.
> - Detect IRQ topology via platform_irq_count() in probe path.
> - Refactor IRQ handling into a shared channel handler.
> - Enable DMANSECCTRL.INTREN_ANYCHINTR only in combined IRQ mode.
> 
> Changes in v2:
> - Update to kernel standards, enhance patch description, and refactor
>   driver to use match data for hardware differentiation instead of
>   compatible strings.
> 
> Jun Guo (3):
>    dt-bindings: dma: arm-dma350: document combined and per-channel IRQ
>      topologies
>    dma: arm-dma350: support combined IRQ mode with runtime IRQ topology
>      detection
>    arm64: dts: cix: add DT nodes for DMA
> 
>   .../devicetree/bindings/dma/arm,dma-350.yaml  |  25 ++-
>   arch/arm64/boot/dts/cix/sky1.dtsi             |   7 +
>   drivers/dma/arm-dma350.c                      | 164 +++++++++++++++---
>   3 files changed, 161 insertions(+), 35 deletions(-)
> 


