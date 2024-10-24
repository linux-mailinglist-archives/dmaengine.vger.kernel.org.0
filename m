Return-Path: <dmaengine+bounces-3548-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827729AF2E7
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8292A1C21445
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE26198826;
	Thu, 24 Oct 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep1wi1et"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD322B67F;
	Thu, 24 Oct 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799484; cv=none; b=uQnK48KURck/ztB1AKVfo87dO+WBw12bnV//dE3v0XnsuLQ8TrF7CKGbiOmkOXhxj64ju4BT4PeFAqr8HGoKtylqLGiG1jLvXp7JNtPaphVDsVChxHIvIuHUo9sUkzhn2qC6Q8klMbp1u/Rsb1hrKnes97E/82O4I3YFtzbXnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799484; c=relaxed/simple;
	bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6hw1Q7M0yjwfme4JBk/M1qbdYt8mLWyRzG5fYW65180go8eXtje05g2xA+xigFHTWLckvxNsX04YYvNl04QE/Je5a1GFmqN+TAlP9X3t8ccqkS8g+j3JhTIl5kmNJYbnoCW048UFsQYZFofWStEokP5h8ALS6XXTk6F9L1sKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep1wi1et; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso240640a91.1;
        Thu, 24 Oct 2024 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799482; x=1730404282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
        b=ep1wi1eta+l+PYvFNy/JYBui3GRMGZuXJguftfCpdBtgh/1GJTCsPQABlVCW7iao67
         +bjvTlAUVrYJNfoLBmuNqPJI7TDvMAt79VtX86DuiSi4TG0d353v5YnZpO/YuIbNWfZ9
         NZzXYJu7A9Z1YqqP+A9UUZAXEKQwNq6Q0Kf+UpvfFZmSfoYsDXWiTtiLlNU6gGBeuU46
         tea2fUKSe6DrH36BiDgRjz1qXNRlpkwYC+eqpZsXBmLRTxud0bYmVzB8HRllef7IkYFk
         Ozez585n1U3TEKPI7S3Bv8DDqDd8WB4VFbdt61p5AJQPXmHmZnUrSFyzOVIyeyTNfH6m
         q82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799482; x=1730404282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
        b=Hbyp81VfVDreNAAjGK9/niURO/d8Rz4XNlLJWQArYxti2heR8jUT2171I5QexCxCyg
         X97NPf3jmC2uxvhwVzD/B3gBzaEtYZLaA+91CpWSpFjexLqtxvmN97duS8eNyiv6H2ga
         Z4T7ydkpW4BlTAS4MBsRarF5j0rfrQOfn+g7llgkTOFlcpw/PgePoZEHPfL99oMsE0Dt
         cHb01MuTCsA4oGo3b1b4ge3ixkhQs41E2IIN7cJAJYxqq/9GzZHAlKRfoHZUnyB0Qg1R
         CjNi96sn6bREamgQ6cPwEJ58zGe7rn/Wdok/A2pPG3u8xOuLllllNrn3CA2P+GP6hhN/
         Yhcw==
X-Forwarded-Encrypted: i=1; AJvYcCUBWbiL/8jZs5Ovu4DLmqj/gJwfSdyB4lPpD7ne1bppRkVzwgZkzUQj6fbc7HlzNxBA3qshxLYHMHY=@vger.kernel.org, AJvYcCUPDxHNQ9ubQU8CYry1xcRPWYSqFdohbWpmf5mXj99sjLxBJzs66lYyqwdAXRYIuTMFQCgvilM0AipJvQ==@vger.kernel.org, AJvYcCUZqEZam9zLHfLFng7dAl2YgzsXF24dboGobLhYxYsLV5HIQ26jE0WgQDoF4q9fOtDNuLLZyvwuBQh2Mkg=@vger.kernel.org, AJvYcCVBRDoscOkpbAc1WQq3uG0XetnkEUY1BxWHsA3UgfX1JeAXxRoOH1PRGM8SP3qSQgRWIHiXfabo@vger.kernel.org, AJvYcCVKskCkYrSLzI6Tagu6TWjdeLN+7AMfDXn9AKiagXVZuidzRIvDQ4BzTPtD6XOXAD/Joha2C86H5aHm@vger.kernel.org, AJvYcCVM5214y1bsTeE06g4SdunCf7DR+uq9ZoCnFdV2bSRm9a4QoLyebx5D2GBHoOwMGMFvUknCLpdWyvFNhcSA8IBNw1o=@vger.kernel.org, AJvYcCVY+uffYgR0/r0o6Ai6i04387SWOKv/wZdsRSVx3VB4IY0sCpVhfZxiIx5Lgkfwot7jm5O5Q6YzrEoN@vger.kernel.org, AJvYcCVZ5YVhGhxdaRFEIZC3HpPR1KHVNdNyQYMst+x4msPEdM3kjjbg9NunMEWSqc4GGaukhG3Yrvuvxbzcv946@vger.kernel.org, AJvYcCWvh1dzfEKfqhen2zHpIlwafrNIkBfwWkNeY/cYJekLlGH7xiIBFjnz3mxIgc4QEUFiyIVFslKv08JR@vger.kernel.org, AJvYcCXN0ziCfta1Wss7n6p5cLWq41eJ
 dEpELSW7H+6WbZ/LeK9u537tRnDXrSrpibtQhJOOWFZrWlLMTUBOTg==@vger.kernel.org, AJvYcCXlbuzLXP32lw9P06EqGsIWzyRonanmYYFyE9D5RhBcglEzeBwEUunGWvhbQiCwOYFEzkLPB9oBGXWggQr7@vger.kernel.org
X-Gm-Message-State: AOJu0YwAB3sDOH706QuuKPx+UJsNjoXlUj5RDl1F17yMwGA8CV+elIl4
	TJKzxnuPJ9jqeeNMs+VSiy1GW8HwwWcjzxqVZQkz3ktu1dGc7QhHw0l2AtjK8cNBS83YiKzJpci
	K0H+o0ctUcv48jVDir6vonYKJ2do=
X-Google-Smtp-Source: AGHT+IFLn362eXA2alAIz2ois1hme8vmMzAr/A4Q67tgGIjhwo4c/Uwrf7x2Y1gjJusyhIkVGgJ2HbVgUBZrDoJcR7M=
X-Received: by 2002:a17:90b:4a83:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e76b6c3194mr3396949a91.4.1729799482088; Thu, 24 Oct 2024
 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj> <20241024185246.315631-1-elfy.ua@gmail.com>
In-Reply-To: <20241024185246.315631-1-elfy.ua@gmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 21:51:10 +0200
Message-ID: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Oleksiy Protas <elfy.ua@gmail.com>
Cc: fancer.lancer@gmail.com, ajhalaney@gmail.com, allenbh@gmail.com, 
	andrew@lunn.ch, andriy.shevchenko@linux.intel.com, andy@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, broonie@kernel.org, 
	cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net, 
	dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru, 
	jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com, 
	kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org, 
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net, 
	manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org, 
	nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev, 
	olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org, robh@kernel.org, 
	s.shtylyov@omp.ru, sergio.paracuellos@gmail.com, shc_work@mail.ru, 
	siyanteng@loongson.cn, tsbogend@alpha.franken.de, xeb@mail.ru, 
	yoshihiro.shimoda.uh@renesas.com
Content-Type: text/plain; charset="UTF-8"

> It's quite apalling that this needs to be broken down to adult people.
>
> Take care and consider rethinking your life choices.

Does the same apply for Raytheon, Boeing etc employees?

