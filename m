Return-Path: <dmaengine+bounces-9118-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF6RBSB0n2mgcAQAu9opvQ
	(envelope-from <dmaengine+bounces-9118-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 23:13:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5E19E34F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 23:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12BCB301EF18
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8938319870;
	Wed, 25 Feb 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJWsU4sq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C53002D1
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057629; cv=none; b=pNZj2oAjI4p2QGZgGGijGEr1eBOc+YbkTolEkfzAO4IVTCgM5PN3mhzhZXKBb6DGzj6t9/dFematxiu89ABUv9qd49L56UInHuLjm83eNaG+2VIOgm181YYOoWW4Glu4pilJJx4Q0c3lmJk3OWLGPVNfvQQCBWUbYqTsXPuEmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057629; c=relaxed/simple;
	bh=TOgbNBbKU9iPOcuckC2IVjsArS+79bW2WQ2DfWtt9Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVfq9F7n0V82F3STW6XekCCR94W4pvfzmATHtWXbpYXQzQOSqcXaF139KdBWnm6ueuDn1N85HEvswADD04f16aqeN6AyRSNjjZp3B0wxrYDrtpVL66idwtGpgNDre9pIULjXbsC8lYohv1Dz7LhG2MnbIqodLXSTYpW8ffzF48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJWsU4sq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824b05d2786so190625b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772057628; x=1772662428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aiKwhpHaGzJ3DICfSZzF0PjdBtray3xMHDXBsERpgo=;
        b=SJWsU4sqxHWs4GZAiT9mNCVOf7tsuhKmxNyn46NGnlceY/2z8TErE4PUDQh8uZjtLv
         r40fgWVm6/n3SSPGPSrtL3Jmo6to11r25ASS+rQ80W3loeg/bra0T4h6imBqCskWrtLd
         xyDgR4xJKHZWkTPDciKeTajWmbFJFQexXJLgziwpuhk0vaOC9ng+Do250dWwOCeS6QYt
         4NRDz7+5ZNr2A0vWFLu+NR5Y9slqEjQEpleqD3yC6i3ll6mzW39Gytin7NyGnFb65q1c
         08vqbbtyOKwsR6vqeWVa1+mx2KbWMH9Sz4URtox2QuIhMNL2eevhDanm2vAFnXwAaLIQ
         SSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057628; x=1772662428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aiKwhpHaGzJ3DICfSZzF0PjdBtray3xMHDXBsERpgo=;
        b=iNvv/fDL9sKIj2WvL5yhSfQOE8bKxYaICN3eOKQbbDs0w7/pVaRWxOb2UbojdMITop
         XE8HcpOEWlLAEO5RD5O8AiBqXgXE+gFqBa/GaTtk4pEiB96djtdPvhS3Jhfaua5eoLxY
         VhTeVU++c0vKNTqt4dRBltMufqjpsoqUGOOaXJAnEBCaiVsc7EYFrsIPuk2tJDbfXplK
         V0w6pNaaCfWe5ZuNtS93LubDHwrudUrz302Lv7Rqd/1ocj19kM1EnPpFO5+0YI4SbnMQ
         ko2aNZ0T4S8Cdpf95GdnsRSLJd93gcqE9aEm3bd2B1reaYkHUK+4xSm3mjtFqurwWcj1
         e5WQ==
X-Gm-Message-State: AOJu0Yyj8/9VnW6XgXMRsX6aH/DKp623dnFveymCuI7VcrFHb9D78apS
	QycVd0QjKs0PEKTZVnLbtNjylbx5isqlWwTXV8BEUHPPXmJN359yFeZC
X-Gm-Gg: ATEYQzxMvQPKmsstOrCJhc+qFpLRY79HDv3LFgopF54WN4x6dTUrK5NbdJVqBYZcQeB
	U68J9WRHagT2+AeS3HmKK3RfS3jtKzIYHMR0DBWATDxfzm5ZoMR3RGjL5od4koYoIUntjxQvgLg
	S6rQDj+tFbtbEUxplo5rFeqBTZvSxkFDn/MvfO6Zivd4UVf2J//Zwr/VFFoY6IAaV1ZzW48RMr8
	aJuO5gltFuzgEMEqjPHfAHIGcCRne0jTFT6J/ksBvkluqKCHcfuAIUf55A1UHf31bq/CJiwJsU1
	EvkHIxvdeAvvE0mgK6MTVLwQrpJcn7ccJBrt4Bp+JdEFAbzOGPgbFeh5m8CK3JKiTnp295O9d9v
	ogrMZxshaR1ue+c/ANVf0YzrmM56m99nnWUbYSPGt83QJ+CmlMuSq5Eb42LmTL1ba/x3cMI6D0c
	+pz/TP5ak1ED8TtccwrpieuQ==
X-Received: by 2002:a05:6a21:4910:b0:34d:d030:6739 with SMTP id adf61e73a8af0-395b482d1e6mr88993637.31.1772057627939;
        Wed, 25 Feb 2026 14:13:47 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130719a3sm1267511a91.8.2026.02.25.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:13:47 -0800 (PST)
Date: Thu, 26 Feb 2026 06:13:25 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@kernel.org>
Subject: Re: (subset) [PATCH v3 0/3] riscv: sophgo: allow DMA multiplexer set
 channel number for DMA controller
Message-ID: <aZ9z0gV8ZrfpL2JG@inochi.infowork>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <177201865381.93331.6104381063514168222.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177201865381.93331.6104381063514168222.b4-ty@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9118-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inochi.infowork:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABD5E19E34F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:54:13PM +0530, Vinod Koul wrote:
> 
> On Tue, 20 Jan 2026 09:37:02 +0800, Inochi Amaoto wrote:
> > As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> > the SoC provides a dma multiplexer to reuse the DMA channel. However,
> > the dma multiplexer also controlls the DMA interrupt multiplexer, which
> > means that the dma multiplexer needs to know the channel number.
> > 
> > Change the DMA phandle args parsing logic so it can use handshake
> > number as channel number if necessary.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
>       commit: 5eda5f42d2fee87127b568206a9fcc07a2f6eab6
> [2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
>       commit: 02a380ea7ed2d737a42693d7957ec8c33a92d9fd
> 
> Best regards,
> -- 
> ~Vinod
> 
> 

Hi, Vinod

I guess you applied the version 4, but replied to the version 3?

Regards,
Inochi

