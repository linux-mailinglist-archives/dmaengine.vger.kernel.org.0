Return-Path: <dmaengine+bounces-10288-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHImBvt5AWqMagEAu9opvQ
	(envelope-from <dmaengine+bounces-10288-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:40:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78226508A3F
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B75300B77B
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ECA32B9B5;
	Mon, 11 May 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQRjZkB9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F2243951
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481637; cv=none; b=INP1xiD7NoV9KRHgtG7utE3+gM1ZRy9elbnTZ8wqp613miaPA3n4dgVFGOIphrnt3anIH9STBD/VF6jo1Erwq5APwxcgL3nPWEF51qbCSERa3Pha0HQ3OBitYe0AjiEpWmQJ5HpMB+1SXLeMorE+4Ex2ktjL3x+TS/tiOzgy4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481637; c=relaxed/simple;
	bh=NmkPyrRTIjWyClkVXUQzYwO7m/ITRKRWvNzOoU9dgQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DABalNwpXADHlcqlpxVV2691/Z7FVwsLOGI+D6qJDkcsJ7qolPTwMLCmNISG01Ah5x+y7wWSp2zYEMT7phffFm7J0eCqKSiaoiUYgAtjTFT2Zxg97BLFtKA0hIfXDk4JhzUWciCz1CjsOB65GXdYXh492D+ytfxTTLaLeCpT7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQRjZkB9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8025500cc7so2798577a12.1
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481636; x=1779086436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp1SzHVVQniSVO1ea05q69qwUsggmYx1Vtvah/rM9Og=;
        b=eQRjZkB9w5qI0rFyq8OHkUwXWRLwKcYIkrBEywihUBZfTgeEvk4yOxP7HKlcGegCMc
         LUf0Yech4r9d2HYyCMKL9hXWNhxUa686nnhHvxZ+Nceb9xEUubboDmXRJf2DWnYSWszy
         re53OVHCPtUav1Ws7OB0gh3TIHlvc/2El1U2QuNKosR5sNB2ZyJwVUbnz/H13GnDK8n+
         CRc1H+HgK6Sggkr0o7IYerPxuFidqBKq0og121Mriwh5FeFm/39FTXN/qI7TNeg3HugW
         /8m+N3K64UrD9qvIAmLVPXXb7QC+OTjYi+EbK2LmQ99ZcRrCpR+gOd+ShVWwvOoDVoLW
         L56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481636; x=1779086436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp1SzHVVQniSVO1ea05q69qwUsggmYx1Vtvah/rM9Og=;
        b=N70MQNXcHRb3mBLKnUIX1SnKFzALQ6ABmUhYtP+ZpU2BDzrtCS5rTFHT6QvH27MRRs
         FI91T9fPLox0omJ3QnsftQhtsgxglKjLpgpeaU+T+35wsr0YqSp+80vylMY2G7S4jcyY
         +oItVZdzgdYvZJIxovMY+Ye6KW+hCoTDa+fQ2U5MXUT2JhHAr6K6SP/HPCDJp05u/f7y
         kKT1FrGvO+IBnzwuo5hQXQgVPhXzteZaRJGL0GnkPTbhq59M2ApKGYxXp8EVhn8t+0WQ
         LnjTslOYZoy1pKE1MFaqV/vciPeSIk4HI/4mTCm9g+fyvhqgCAgZCuVAweoJy6nLuS1u
         iTtw==
X-Gm-Message-State: AOJu0YzFqdV82GT7cwWtTUsUGr3c2+Ifs8PXRp559OuqK5J6OZi7j9fp
	+yaSi4HFM9rIQhiig3eKM69AARYyDcYMAjMajB2V2gBfxiQYwuOYEfZj
X-Gm-Gg: Acq92OEDtQH7Q14o0kXuHPssWFf7k/MT5aHAXU2a80mptuFmPR5/Ax8JdG6chf6aTgg
	exWFSw3OLu1TR7oKnV0Z86/nh8S0asPLpiBZguBiLZlu+epMENeTUrVORP4JSd5ljn1vpTk3k/I
	EkQsAIHkMFar+6KL+kdj8qAVFublUEY9+tOXZ6X+kzhMuKZXliUNjbf23313HN7dJ9gLcSQCryU
	HJPkBU5YTMUf8v6coouXq2ULL+UYN/Oz+RnerlR8R1v6A/JZQMgDp7BWTbL+L0mMEvr0YJu/GgF
	ymJkTr7MYCSEh0kKpCPoAu+J0EWB/pDFbHjXPL2mq08XazgB96hkb7wZXhjnCo5304h7bRag0uN
	N3Oo0cteohf/h/kOPMnJPDmy3RxmEav0EFEvGyymM7AVhc4QgKhai1LVPFmUi+AHVFSDEVF6iuc
	MiMJ2+GYIJBaYwvsPQXhLe06Y=
X-Received: by 2002:a05:6a20:1582:b0:3a3:a6fd:7fc1 with SMTP id adf61e73a8af0-3aa5a8fc80dmr25500333637.14.1778481635951;
        Sun, 10 May 2026 23:40:35 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267689d76sm7967107a12.11.2026.05.10.23.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:40:35 -0700 (PDT)
Date: Mon, 11 May 2026 14:40:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Longbin Li <looong.bin@gmail.com>, 
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH 0/2] riscv: sophgo: allow DMA multiplexer set channel
 number for DMA controller
Message-ID: <agF5dRASi8ombhFM@inochi.infowork>
References: <20260511063719.460049-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511063719.460049-1-inochiama@gmail.com>
X-Rspamd-Queue-Id: 78226508A3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10288-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:37:16PM +0800, Inochi Amaoto wrote:
> As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> the SoC provides a dma multiplexer to reuse the DMA channel. However,
> the dma multiplexer also controlls the DMA interrupt multiplexer, which
> means that the dma multiplexer needs to know the channel number.
> 
> Change the DMA phandle args parsing logic so it can use handshake
> number as channel number if necessary.
> 
> This patch series add fallback compatiable according to the disscussion.
> 
> Link: https://lore.kernel.org/all/MA5PR01MB1250079A8884D4F6245B955B9FE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
> 
> Change from v5:
> - https://lore.kernel.org/all/20260426012921.673953-1-inochiama@gmail.com
> 1. Add dt-bindings patch for fallback compatiable
> 2. patch 2: Adapt the binding change.
> 
> Change from v4:
> - https://lore.kernel.org/all/20260225104042.1138901-1-inochiama@gmail.com/
> 1. drop patch 1 and patch 2 as they are merged
> 2. Add ABI break statement and clarification for this patch.
> 
> Change from v3:
> - https://lore.kernel.org/all/20260120013706.436742-1-inochiama@gmail.com/
> 1. rebase to v7.0-rc1
> 2. patch 1: Apply Conor's tag
> 3. patch 2: Apply Frank's tag
> 
> Change from v2:
> - https://lore.kernel.org/all/20251214224601.598358-1-inochiama@gmail.com/
> 1. patch 2: rename "AXI_DMA_FLAG_HANDSHAKE_AS_CHAN" to "ARG0_AS_CHAN"
> 
> Change from v1:
> - https://lore.kernel.org/all/20251212020504.915616-1-inochiama@gmail.com/
> 1. rebase to v6.19-rc1
> 2. patch 1: remove a comment placed in wrong place.
> 3. patch 2: fix typo in comments.
> 4. patch 2: initialize chan as NULL in dw_axi_dma_of_xlate.
> Inochi Amaoto (2):
>   dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for
>     CV1800B
>   riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
>     number for DMA controller
> 
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
>  arch/riscv/boot/dts/sophgo/cv180x.dtsi                      | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> --
> 2.54.0
> 

Please ignore this broken version, the right version is 
https://lore.kernel.org/all/20260511063818.463877-1-inochiama@gmail.com

Sorry for this noise.

Regard,
Inochi

