Return-Path: <dmaengine+bounces-7722-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084DCC4DCE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 19:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5679A303D93E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1823451BB;
	Tue, 16 Dec 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzic8FCr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8B3451BF
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908320; cv=none; b=Dcq/j9fNIkvtzRTEr45FXtqyf0KxrIeIDwP2eLzR0zl7RtGQTLCRoLz9QJq+hPMEJcyIInZvTt/1hRkVjINUJjxr+BnjGZVOO8ZktIDte2B5RrmB/wc92BpnN2ieNdu6qcQ4YWKWUwyXwDWBVlai+/OIOl6f6Oewiy8jAFWDrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908320; c=relaxed/simple;
	bh=G11yOThvw8ivZMg6xvJnmxWZPCz5hKcyxYMZzb8fEaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upF4kBCbpJqhfRY0SflAXnhcDVAm3U2okCC4b4Pp6MyMT4LpMI2kP/EsgfYrK4TbpUMB5slgPFFp13oR6wztC71c5ykvVDWhwZeFGtl8EYlj/m/uJHZsYLyC737haW5YutGhdddkiqeLFgoIgRP5qhsbCyIT1z4s9YvxOyqhjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzic8FCr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso31900955e9.1
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765908317; x=1766513117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOVTvVNdR1FG9BDCa9ncqVORVzbhxwnhnkEQ2N326Mo=;
        b=Nzic8FCrZFHDVfMCu32HLPMF/Z+bNeerHI1t7uewzMpOAMyF3HDdrHK2vVLUuuV3h2
         CYx/bZ7ALePqduluYTeraCreqx4dv5dG8bgyqwrzr02QTkuFBINuo3DkYHyrWo0tXiM2
         8UTKmTYh24dFei5DS1YZr5OUU6tb6bm/+nuZwVGgWRIw/ybc2IVledgQTFhBsA8vlYoA
         J4cZKitYoL5CoP9kIyIGUPWTue/LXbiiYOcRx0PB6MiZHh/QzktX636Fv1trvB+NxSQP
         w4YEeqt3uG+9vxqC+wYmyRJ99ORYvE8WkqdoXI+v9b2UuVJxwVxVyGh/NBeS4j+Ugghn
         LO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765908317; x=1766513117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOVTvVNdR1FG9BDCa9ncqVORVzbhxwnhnkEQ2N326Mo=;
        b=xA1MItSxnZlxVYiwjSz8BxAYqKFXYyiWUIom4DfU4OAwqBdaDjVyVtBRoppcrzVVkL
         wIgxyUFGMiDUZXrZinzheBEpIc5uhutS6tD6++llAMKnX4+zhj4fIuoNXD9pUsQ/jQ4K
         +WoK74vBSKvLhFMGxCxri//sZ7T8ha5Elj4RY88ff/3yFlzsxKCtkOwDeOneBe49SvxR
         70Gvjodty3d06P7jJoWHlO9lJ30axdNfNZhTyHbr+vuqaEhJ8Ru2WCP7qKeT8gIpViVv
         aNOr3szzK5UG/YweCbPSaJ95Pse1p4FZhkQkepfK5aq8cNDz5mveLFua5Gm/2COunVw+
         Cj/w==
X-Forwarded-Encrypted: i=1; AJvYcCUVKui93XJz8p1U/6t2xXB6lm5KRhqRtak1mPvf039ZZg/nSwCY5hDekwKaNRhrPzU1lcxNtYaoumY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsJ6QC1O1xgWlkUuq8KGM+yHmAtFe+1rJ2gak+iu8uCKXpZPf
	NYgl94gpRhHQ5JvcnWDvnq+J40L66lkd/uRqNNSE+nEYOLknyHUVUySL
X-Gm-Gg: AY/fxX7b74y4zrP1w+mLmb/F3gMLl2DtxOo71XxW7uUefci09oNR5YhUr3clOsPiXEk
	0oOteKNODwwc4Kqpo0a9VSI5pcc9zocp+3v/BdBZQCWs57FOsBmef3Kih6xlY6N84w9+/L3QLHC
	Tan3A6Sr4YFw/wYTe5FAJ8Dw86aO6JJlvv2drwNmyTc+rVKIY77OzpmD7SUI1tLt/AyM5PgNQzF
	j7tLdTUaZo36byDGIjZn7AL8h3vS9OthCmrUlpAHWrVEXyoq3nh+EHg7BQAzAiGKatT1dfxY17z
	nlLMz3yrsHh17A9FHWrFsGRfymgioCNM/w/K7Yh6d7BEAuamlf2Sz1a35i7tJHZM/wNW/T0BXpN
	dFwefPaI42/Y8tFFVXx5qJAl+0RAnuKQfA/YmOcwKquSOU7zO1tdq2/YsJLVPrxWLHUQEoXrSkE
	CYZ0anow61KkPR98fbirwHI200Y3qXjORnbTqB0CAz4bECT/KqEo8z
X-Google-Smtp-Source: AGHT+IHcp2kh+mNII7OE1JHRsuXQc+60t2y2lkbG7uOLLemuoRbIqLfM/QxfUUFPTPf2nXNDwVnhkQ==
X-Received: by 2002:a05:600c:4f90:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47a8f905680mr161568895e9.17.1765908317137;
        Tue, 16 Dec 2025 10:05:17 -0800 (PST)
Received: from anton.local (bba-92-98-207-67.alshamil.net.ae. [92.98.207.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1e1ebasm1784605e9.8.2025.12.16.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:05:16 -0800 (PST)
Date: Tue, 16 Dec 2025 22:05:12 +0400
From: "Anton D. Stavinskii" <stavinsky@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@gentoo.org>, 
	Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
Message-ID: <aUGels35MP_BNjRC@anton.local>
Mail-Followup-To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@gentoo.org>, 
	Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
References: <20251212020504.915616-1-inochiama@gmail.com>
 <20251212020504.915616-2-inochiama@gmail.com>
 <A0AF03A6-1F0B-462D-A088-3B4DF6BA6292@gmail.com>
 <PN6PR01MB11717B13B2AE78DDD36D2F0BBFEAFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN6PR01MB11717B13B2AE78DDD36D2F0BBFEAFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>

On Sat, Dec 13, 2025 at 08:53:34AM +0400, Chen Wang wrote:
> 
> On 12/13/2025 2:48 AM, Anton Stavinsky wrote:
> > > The DMA controller on CV1800B needs to use the DMA phandle args
> > > as the channel number instead of hardware handshake number, so
> > > add a new compatible for the DMA controller on CV1800B.
> > Thanks a lot,  Inochi. I've tested on my Milk Duo 256M board.
> > Seems to be working with the I2S driver, which I'm working on right now.
> > No issues with DMA interrupts anymore, DMA router used right channel.
> 
> Thank you, Anton. Could you also add a "Tested-by" signature?
I've tested the v2 https://lore.kernel.org/all/aUF4w9sO5lmU9T6v@anton.local/ Hope this will help. 
Thanks for pointing me. 
> 
> Chen.
> 
> 

