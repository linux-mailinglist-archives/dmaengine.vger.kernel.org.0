Return-Path: <dmaengine+bounces-5747-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96526AFB2D1
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2BB4A23BE
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0229A332;
	Mon,  7 Jul 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9MwD51h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880D29AB18
	for <dmaengine@vger.kernel.org>; Mon,  7 Jul 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889753; cv=none; b=SgP8Odn21zN/3cmigdItNXkha0zsiKBq6UXltntYbAvzAVKElkZIhd783HUUK5bF6kjIUX+8LtHR1dzp0vC18IuQBgcseqs7/jv102p6l/PrbMsDpJJFfZN35KriyWjsSkM2mk0Crc8GmUcRKLzMIcAPaw+gyNj0UMlAsj1wB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889753; c=relaxed/simple;
	bh=YoAzARs6ZN2E1vPt5s+AtNGdTJKmdhpSHxNEUsLMdjE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDQxHvedQfjCxQdfDhARTHRbhaxX18WaZsSlFeHMZOWt57ssx2pEFo08+15mpIaE76X+xHnA20uzBT3qDldABBOYyO3KQGr75Yv7Sl7Actfvmnx1eBfaZyePOYpHJnq3uKG+SASn2TGtsvtx2Xn4TDSElsKccP4BZq1Cfj0dpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9MwD51h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso16950825e9.0
        for <dmaengine@vger.kernel.org>; Mon, 07 Jul 2025 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751889750; x=1752494550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YoAzARs6ZN2E1vPt5s+AtNGdTJKmdhpSHxNEUsLMdjE=;
        b=d9MwD51hl8AVCfqRLIGt4fthBygyn6SX69qpIlEuULB83NDRRBheIeqm6f9/cTIRuL
         aLcFM3rg5M9aiK0LvVZ1HGy7ybic+fZG5ElPcG/mnKP0og+bVGu0kJlE2qqB2xSOzoJS
         2Ht1lUQwFGGwRjnYi7E0kPCmjJQz3R/XKj9rynvOi6xg+PvyVoG7qRq457MBv1V9ZMeW
         xIkfWlgZMXJAuf7xgh9/tIr1z4GfKPkLIhXCaU7piBW4SkqQz9HIbgkayYlRivQE0Vho
         lZdAgYWb3NM4v5D1G2z5Ef4YyVyvMn2uvFVG6DhqO2SsFVLmjtl177EV/X6OOsR27oeO
         VMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889750; x=1752494550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoAzARs6ZN2E1vPt5s+AtNGdTJKmdhpSHxNEUsLMdjE=;
        b=G2zU+RZgUBwmAEDtjTVSTn0uAayJl7NaqhZPE5OyI78f5SQO7sdh8alPsjI9O1/FTw
         +kmAD7RIKSic0q/Gh7kpOuC4ZZ8eB4y77gJ7iarBobCABq0fmFOHYURDgLIRLogeEsd9
         yUsjqH34BJG6ztABB5yOAYRhMIyyRUAQ44wNtoyI6xqRFTSv9Q3nvzft722Nmt8zBkOI
         jPoGBNrRxsOIbB4gVLYBH/MKsNfYWO8W+JKkngLgKTDPcl+yS/raDeMk9E1lrnV48NT6
         Z36xDzfEnXB36tWpUsChg5RIO64Jo+XsvBbOMEunVwxLmp/rJRMtnpeOqyTCWfccjf1D
         EgCg==
X-Forwarded-Encrypted: i=1; AJvYcCW0+WB9wjZY2VMurz8Xs6/2+CIc/t9mH/pooJfA+IOp0yU6wpSldeINPD+nTx0VR49GOFzGNw9ZNXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AxteH88NPV3vJKfM1fLM4IQZcJ1FKWO2cLe0VJrWD3Esllq0
	+y6/uatILjBR5kud53bEj3HYFE/CXR8zytp1Nvf/jIFZbjeBsaXeZJEo
X-Gm-Gg: ASbGnctCkvlW/R3A4Jd4vQ5chZia5+moFvdpwTsG2T/arQHhJ0u6VZf8/z3js3Q6T0J
	PEFXlBM83ZRcmiE2WSCyYD8M4FBOFxoA4fYH7znR6aJoWZz0eWxiSQDiDxse2L4wNH+WSkGvepj
	uh2SfKn9KRyxscQerxqzyCh619joW6/UjJ9B03Iu6b3PTFeVHBpwclNGu47wuklYs5eeXdr4gPj
	J86aCQD8Af4V3YYgmH4Rf3fpj9hbgZKE9sdTnBcHmrUDvirdhKWID+Pdb+QPx14gGPd6TkIAwPt
	IpfW1B7OseTWhmyria0Crvt4mFkljwW0c8D9/ZpMXMeKU9XmA4Pbw/tyKcivtKt2oVE31w==
X-Google-Smtp-Source: AGHT+IGP4c/Im6iwNctVlSt0RglkZr8bsFS0K7kNOj60BbDqUFD5DDjffxcabElSITawU55e317/kQ==
X-Received: by 2002:a05:600c:c087:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-454b929f080mr60381625e9.0.1751889749912;
        Mon, 07 Jul 2025 05:02:29 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225afd4sm9779856f8f.83.2025.07.07.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:02:29 -0700 (PDT)
Message-ID: <39a5397b3c027a42b5a6bbe02dc9b87fa0432ce0.camel@gmail.com>
Subject: Re: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: nuno.sa@analog.com, dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>,  Vinod Koul <vkoul@kernel.org>
Date: Mon, 07 Jul 2025 13:02:40 +0100
In-Reply-To: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
References: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-27 at 16:00 +0100, Nuno S=C3=A1 via B4 Relay wrote:
> This series adds some fixes to the DMA core with respect with cyclic
> transfer and HW scatter gather.
>=20
> It also adds some improvements. Most notably for allowing bigger that
> 32bits DMA masks so we do not have to rely on bounce buffers from
> swiotlb.
>=20
> ---

Hi Vinod,

Any chance to look at this? Just trying a ping before resending again.

Thanks!
- Nuno S=C3=A1
=20
> Nuno S=C3=A1 (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: fix SW cyclic transfers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: fix HW scatter-gather n=
ot looking at the queue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: support bigger than 32b=
its addresses
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: simplify axi_dmac_parse=
_dt()
>=20
> =C2=A0drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++----=
----------
> -
> =C2=A01 file changed, 33 insertions(+), 15 deletions(-)
> ---
> base-commit: 3c018bf5a0ee3abe8d579d6a0dda616c3858d7b2
> change-id: 20250520-dev-axi-dmac-fixes-41502e41d982
> --
>=20
> Thanks!
> - Nuno S=C3=A1

