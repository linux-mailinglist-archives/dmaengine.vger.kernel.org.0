Return-Path: <dmaengine+bounces-7733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1FFCC563D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 209663030C9A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BB2E92B3;
	Tue, 16 Dec 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSDMHNou"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475433F8DA
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925122; cv=none; b=iqoV7vNtCwyAy6wZxUeLsmbtmkgRQxjx07ebrO56MmmI5xC67FP3T35Vh+NvYd6lVb4qCjM1h8vTcvw+AAIX83QRlGeHOU4IL00CpSr++cb24T20vR1ixCQoPsOC2BLZGqPi7LjpfQ7VQl5NYYuqW8hoHQ9VxTPJiGoZdDDcx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925122; c=relaxed/simple;
	bh=/ns1Rp/WSyMte8FAqNCkjuzh1ej9BUVs0MBSnMXCYb8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJceywnn9y4FouDobO3Dbh6E1jIR8LGMs1cJEqU+xROwSYvu31pahsrbdmRpmYnijTdCe2h7sIbNRhwgpyPFK6v7IFY5UmLMgr2wk2Q7hEfk4DD7fnMDhhePMbSNBH7HMnETAVeeU7sCfbWhSIPnNwjNoUpurbG+TrchvLyAFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSDMHNou; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso4224700a91.1
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 14:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765925120; x=1766529920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7nXoigv9/yz61HlMjawiCb2Rzy4kdcjqDMu4uuBc3o=;
        b=QSDMHNouoA2fawUtmLZ1VYKaGkG+nInPQxh/AaPvaySs743dgzj9E0A6Y2Pj22BPDN
         uOnSayhn010iDB1TuKqugonExPyoGLUq/iEbRpuILHOhsjC5EcF7evV2AvwtqKPLyHr2
         Z50gC8FgWCYtaiM1NfMkVOokpA0DyleWumEvbhWGY/3ZjvrZgrBDv2Fv6tOzndM5CP6v
         7PTkx5BO6EpocdlrIOoJyTvBguOG98Jm9+Yr5vZy5E0D6CIJNMIs52IW/vZglZyke8Dz
         JnYQfyQS0WOTr8lnYGef6kg2qVQoj9Dq7GofofMePTuiepDE+joyjVmNaVuzOeES1HVS
         A2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925120; x=1766529920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7nXoigv9/yz61HlMjawiCb2Rzy4kdcjqDMu4uuBc3o=;
        b=HfYJsmoHXad6aSn0u7fB1BQLDbR8g5l6BOO+stBJ1OheFr6BNC1/PfbuByvf5OHb//
         02rM9A/f6EBjI5zEFtw37KmRHoSzHNgLej6V2wqn5yZLkl+gAtymqoyrQ/ymRYZqqLaP
         S1PlzJj3qvf9wlpmyIpfcfgWaH0HQXz6II0HdAdM6eq2FXtQGtKMW1/GHnODcc33Fw4Q
         7xi57Shtwwa4fawjDb9cd9FvCIXiv7VKcYNEeOWelAnEqC7RYpB5hC9AsED4uNIpLNpm
         CGXYIBt6SxG7owRhJT0ckKg2TrvMIPGk6DYloNn9tKORPdYJ1wT7oRStwewR5ZiGcOXj
         3qVA==
X-Forwarded-Encrypted: i=1; AJvYcCWp/XDLtaf5dhTmsStyuuF7agvm8s8KkqprbSmoBzU+ZsJ6AesqmQvgs5bDlLQBEyUHoPc9NAZPYzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9LdwyvzfLCYUHusTiMBHYAJ05b3burTA7wTxJVBOZIutr7qw
	j7NrjVf7ZwnrAjba7HwFOqly5KvisvoEHeSmLTWIz5u6OvykL72ecew4
X-Gm-Gg: AY/fxX4QXH1b+rbWwoxE6O1FaXvpd1B2xTgBl39H7bzKOzjvo5QpEYB9KyNKGJmo4On
	kzTdXQDICfb2ytYsHQXaslWwDzYc1K1R4BsRttUErJZ0yZz1SOcTEegKTuldDvr5qLZu5n4ZBbv
	8jw/otBdi+N3Yie/pRHLXdlQSSatsF4l4L2SIyjq5kh5RKcjKPcPh6yhGREyy/9r9T+WOjjyMCd
	X3StWUoRrmYFTm+mOHzaujB/7g6h9mjfm5yNxFSKbP10qoN2m67sYcOBQWegskxNiZeqr75a6/x
	3XS3XA7ROSyT+owZNx+k5bpPpBFF00zWqqxHZ/0SYfqB3J4iggFuHiRbJ8+Wwuir1APM4kgVEiu
	DfGlFJU6dhhkRNaUEeZm2d5iv5ouKceI8xrRk2Fg5RqbY6K3K2RhyCoTmNZhznRMfwVuxGuw1XY
	49O3YqhFTgOw==
X-Google-Smtp-Source: AGHT+IE9nIlDHsFmfYsacNR6G1ZVOO+zgg/tDfoQF+xuebBoHAyCLps0J4BtB+5eml9RBwlgxvUP1Q==
X-Received: by 2002:a05:701b:2719:b0:11b:c4ee:66b with SMTP id a92af1059eb24-11f354dd89amr8447143c88.37.1765925120396;
        Tue, 16 Dec 2025 14:45:20 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm57479374c88.2.2025.12.16.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:45:19 -0800 (PST)
Date: Wed, 17 Dec 2025 06:44:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 0/3] riscv: sophgo: allow DMA multiplexer set channel
 number for DMA controller
Message-ID: <aUHgt8caOoo1gsES@inochi.infowork>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <aUE9hDtflXpcgGnX@inochi.infowork>
 <aUF4w9sO5lmU9T6v@anton.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUF4w9sO5lmU9T6v@anton.local>

On Tue, Dec 16, 2025 at 07:25:06PM +0400, Anton D. Stavinskii wrote:
> On Tue, Dec 16, 2025 at 07:09:16PM +0400, Inochi Amaoto wrote:
> 
> > Hi Anton,
> > 
> > Since you have tested this patch before, could you give a Tested-by?
> > 
> Done. V2 works fine with Milk Duo 256M with 2 channels RX and TX working
> simultaneously.
> 
> 
> Tested-by: Anton D. Stavinskii <stavinsky@gmail.com>

Thanks

Regards,
Inochi

