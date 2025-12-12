Return-Path: <dmaengine+bounces-7590-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF13CB99A6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB2E530138D5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F56309EE7;
	Fri, 12 Dec 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GatPC5fT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED8238C2A
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765565327; cv=none; b=BffbSVI7FKDgp5I3S2Ok/4owgHHBVR4hQC/ShazXlFKAkAlBnysCaSpNTs+7YCNVQt8Vl0vTFWwtLWX7EDLfs00XDo9h/gZTlE0y61hSLgReTf3eSWwLbdN8bFSF6iNu7PuyvDojaZRlXDM4QFWlbHbtoeWdElwpO/EN3Jo6uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765565327; c=relaxed/simple;
	bh=dVjh0U3UIiGWBr09A35mSxFYskTpyF7fOa/XhBzrgyI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pwFWfDtUGRBQilatNT+D20kTxRsQkUZjBt7f93foLOqW6/xSY/ydJpRVRlznuJOKP3YqxYcxS7TmtlXIv2aptpYVUElODRxkZNm9w0f4mL8YTVqmQl5Jn97lGHCDmYMBVk5LGj75uPaQsmx68FyBK2JOTgwknZHB5JKcOF2fHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GatPC5fT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47774d3536dso15058335e9.0
        for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765565325; x=1766170125; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws8si3q8m+pORfnElCi6zW3h1zosQU2jocpsY2hNquM=;
        b=GatPC5fTE4Wjv1wy/12k5cfLrcFBYLrBWJIPeCf0aS87pRTXICZzUVprfneRrpPWuj
         cemLgThQLiBP2EWUbBiNQcI2X+rvDqf+KCEjo0ZocC4VkbmR2rCgBVn5NvppGIwcN3WD
         XzuDop9t+ZrA+/yrArhVExCEcZaI124IxtSJTnswOJxTgMUeiKf2gIWB4v+8I5yU8BfO
         IpNpxAVjIeG03+CVd3ijBWqAubHNFoBgSSmeQeMK08/WONhVDmxARjm6KimSJvlYAoA+
         MJJ17E6TRPZAMh6Z5Jw7O+//Njm5Q3p5M4XaOvRcHkN4ZWk9apjdwWicYNbYeWJ4VYAp
         1VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765565325; x=1766170125;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ws8si3q8m+pORfnElCi6zW3h1zosQU2jocpsY2hNquM=;
        b=B08N/DT30ru/Gp8qovzCtk1G75VvussC5Ng/Wg6upp9NbGB8MxNdtpoYg8GHWsvU3S
         islyZOoC+VnqxbCtdghlDVA/UWAK+Vtbnv9gsa3lu7uFZlkbSkliHLOXRY1Bb2bR7iDb
         OBRysr2TREFjB18+8zq5Qes6rOw1+6B443PkdF9aOSBinEB5JFlciq9+FT93d+0Gjy7g
         52iypJSp3VfEl3/kqp0A7Idz4p8+3nlZum2YEmx+Wr8AdTWG5ANWGVIrhutx1hoPfA2P
         uXMWkZKvenSky6Lf0rPvAagoQDM/g3bZMR8Z2ibQp8xuxYzYMDzcFsXqKNj8DRDXE4Eu
         U12g==
X-Forwarded-Encrypted: i=1; AJvYcCW/ROmrhDIJjxWak2v7mYty6wOM77ubX0c7Rv8tFkhNhaq44VKlB+4i6K9YrQVtW5gsBE/KjTEbksM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPr1mFv59Qn4L24SgMb8fF6TrKyS6KoC56Wb/n0dnVhGc2ai4V
	IwIa9t52P7q4BYdNPsWBRslOjeVKW/RxgCxbcxrs1tMZQJ8N4OoDhzrg
X-Gm-Gg: AY/fxX7cXHheRzzxAdXs9UM/GlJo+7irDNQzUEB9HIEM1Yx68i+YElkY9A1XUY6DQQO
	7JO7Y02jxA1OROO3Yec4D13tmMjPXMS/SxsYPgC1382m9UKgLC5lLMl8VYRfvEuILxIKTOBM9OI
	Hypr2ZWZ/x8eNtquBwuXyTMdwOI3B5S+vQMuJl8WTw1junDE3d0JY1LdiuGUnLidBvq86Pd73Cq
	Cn3UGtZMoRjtbxyG4QUqyyQRx1r1pftI9ERhlK3FVzdVSwducHJNnj9gl/Y88gBMgZKtdMz7sbE
	q0byg8kmMAM267RRfPw5DLd9bQBfl6AO47HZpBlr9lcATE4p0ld9uX3pKZIxaGszr4t/Dw+akSf
	TNp4u5khwJR4YCSDc8kxk5ktlPI6hHVsGJRAaEmbwn3u8Ki48RUY7NIRhC5rcitzkuu3a64hBj8
	/XeTK+5jjwzKBi/aQ/iYhd6QpDeama6Y2/tFg4IgJnD1zbtOJWeWUYIX8vAT5UCTOlpRQ=
X-Google-Smtp-Source: AGHT+IEcsB4SsohMiuSMRBVsLyNXjKi7YpKhM33MGaetXAZYk3yBX6k/E4+lyPkq3E+DCl/tx3dVDg==
X-Received: by 2002:a05:600c:1c89:b0:479:3a8e:e490 with SMTP id 5b1f17b1804b1-47a8f2cb09dmr38671305e9.18.1765565324767;
        Fri, 12 Dec 2025 10:48:44 -0800 (PST)
Received: from smtpclient.apple (bba-86-96-93-57.alshamil.net.ae. [86.96.93.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3240fasm47202405e9.0.2025.12.12.10.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Dec 2025 10:48:44 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
From: Anton Stavinsky <stavinsky@gmail.com>
In-Reply-To: <20251212020504.915616-2-inochiama@gmail.com>
Date: Fri, 12 Dec 2025 22:48:29 +0400
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Chen Wang <unicorn_wang@outlook.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Longbin Li <looong.bin@gmail.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ze Huang <huangze@whut.edu.cn>,
 dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <A0AF03A6-1F0B-462D-A088-3B4DF6BA6292@gmail.com>
References: <20251212020504.915616-1-inochiama@gmail.com>
 <20251212020504.915616-2-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)


> The DMA controller on CV1800B needs to use the DMA phandle args
> as the channel number instead of hardware handshake number, so
> add a new compatible for the DMA controller on CV1800B.

Thanks a lot,  Inochi. I've tested on my Milk Duo 256M board. 
Seems to be working with the I2S driver, which I'm working on right now.
No issues with DMA interrupts anymore, DMA router used right channel. 



