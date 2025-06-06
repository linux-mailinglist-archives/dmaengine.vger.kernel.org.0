Return-Path: <dmaengine+bounces-5318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11EACFEF8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED7166D3D
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD7286413;
	Fri,  6 Jun 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9iUY/T+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E8286410;
	Fri,  6 Jun 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201256; cv=none; b=h2hUc30h87REUFMTOC+9McJY+HM6a/YxUqT/yAJLjmfG0shlUiCpaUZ173w1AJPRfuRMWT6H4IHQkB1rVxtlFpxHHfz0g+gy6Q85g5U1NeU5nyBEUPCu67+G6yKa9MtHKKX6az6tf6/5f1CH0i1k+OCGztExqRF0KBgOmDsWG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201256; c=relaxed/simple;
	bh=Fz822FN5H/+n8My5Ek051DCerU7On02pfaR6UCl949I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3cjrLD6HgJRNM8yQuv3C//w8/ZnesA04mtd/Jj4dFheRjNrEvsJDoZ01K68mow8hNyttF2KwZYVkqQw1ebHp2umWyw8MgDbbQwmq1i1LZI8jbujU2KaNrxfV4lEVYbJYO24/+S9P2u/C/tUZ5/oQHkVG5CE7MBITgOOrtUmG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9iUY/T+; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6069d764980so5766478a12.0;
        Fri, 06 Jun 2025 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749201253; x=1749806053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz822FN5H/+n8My5Ek051DCerU7On02pfaR6UCl949I=;
        b=G9iUY/T+L7VCJMrFmRdN9vVOvf1y1hJaL9dmt30uiGhnEruVR7dC6ZSH/uiZqgYGLu
         4SfrVF87JiEzUm8wdAcH7I0zgj6UkxzNSBjY8iLQbKXJHDQE5sc1oKvGiuxvy3q1Yw+g
         chQUanz+NgryD+QnFA7JsMqsm3HLvq1qE/ZzpgKqbBrgiaXa7ziovKZZ0fxBqQHky1u3
         Q/4n8xr1ZIMK9DCcc5/GuWOt0vDsB1b3Ttbt7f7FLspV0wn2ghW9A2eiUGCvn40iqYdl
         1RyEomMLmRtpECCzqpCJCvVmNkuM2ZY7oC9b2dmUjOpa0RXDz/s6y8Zgt30qBse6huCh
         JDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749201253; x=1749806053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz822FN5H/+n8My5Ek051DCerU7On02pfaR6UCl949I=;
        b=gAlZwtyLuUYe0vrdcO8pVxmKFqyBT2OtnZBM9rZY0aR8qn9Wssbqv0671lwJb1nIKE
         FAyj5B222/PQS2ZxcFpRZ+5BOvxyVom9cy7fZnBh/3yyqfTfNEFbwC21u5VjOscGXvOW
         UAte147d3n5Dgkl7v2ef9VTfggWqEHyPnx9SoqGsC+DvDHjFnLK6wZ/cXiElsxdYwGAm
         LXiwONJoJ1MvO8EaYVY6cAX2OrHBP/cM4vOlRwJeVPlTMdTDxqRt9Vc0qF/g6HXOXMjA
         zp/kUPxFn29t+cuyeL/sb6bHHe/HwnPcECH5rGm4d59dac6ja/dIwvFI4WbFCYQ4dQxE
         0aPw==
X-Forwarded-Encrypted: i=1; AJvYcCU2wOmMw/OYSSI9iw3YSvHqFIWAHJ58uCSWqFAteQdc8Ybzy5espQuLXIRAJSzcOZqZxnL8LvNuxCM=@vger.kernel.org, AJvYcCW+LzPFG6M6ho3IKoz9o22lqiAR+MjnPSiec33tt7Zw/NPCANYXYiyeMw4cicKYxW09no1RKq4+v93q96L5@vger.kernel.org, AJvYcCXAp4T/tIWAJN1k/qy9DpyoK29w+WB+dAfCMaYQ8lRQsUVhMM78tmbwVMY5HYU38vYRCF7H6VJu@vger.kernel.org
X-Gm-Message-State: AOJu0YxMp/oFOEL4GD4nHy2JPaZ/Lzs6K+mV3+E8JaAjiOYuR+rA00wj
	CUwanzq6BjakaB99Wdbqib3HGYO81wJX/r6PSLeGpdwxZxly8uhbf7vbcSXAQJlO7swteikh6ZN
	7DwiwtH+FRHS4a3jGTQqDwe51cpG5mgorAx/qxfIhrcb4
X-Gm-Gg: ASbGnctF+GnJsrjpEuTv5qKDmerrtqPHDGUCLfuxBwVPqeraXdN0eijugsK9BuJlxiV
	uIkbQgm9nTDyw0FEsAG7gcHXarL4NQ2n0SDcTSDpgDm/iyfsEKu8EsWElpgAaVUr3n5ojXQVKln
	cJtkk2q5LJztiVkXrnIQ5LWqmxsl5u9qH+t3UJkxkjY2Q=
X-Google-Smtp-Source: AGHT+IEeX2nFYgTt+0+rebDEi2e2f4O2bF7FhHfmP7KwHgiTlO9eS0XJCmIiwJM3RRdB3UVl7gDAKbNxKQYbrHeSUYg=
X-Received: by 2002:a17:906:9f8c:b0:ad5:a122:c020 with SMTP id
 a640c23a62f3a-ade07634c33mr697878766b.16.1749201252792; Fri, 06 Jun 2025
 02:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606071709.4738-1-chenqiuji666@gmail.com> <ff77f70e-344d-4b8a-a27f-c8287d49339c@linaro.org>
In-Reply-To: <ff77f70e-344d-4b8a-a27f-c8287d49339c@linaro.org>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Fri, 6 Jun 2025 17:14:00 +0800
X-Gm-Features: AX0GCFsmeBUhD5E-WjTAKSUhstkUhcRejJPPS78zNv2KUGTIKC47m2fIc770YIw
Message-ID: <CANgpojXWk1zvu32bMuGgkVGVNvPw+0NWmSUC62Sbc3WcUXAd3A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

> On 6/6/25 10:17, Qiu-ji Chen wrote:
> > Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> If the first spin_lock_irqsave already saved the irq flags and disabled
> them, would it be meaningful to actually use a simple spin_lock for the
> second lock ? Or rather spin_lock_nested since there is a second nested
> lock taken ?
>
> Eugen
>

Hello Eugen,

Thanks for helpful suggestion. The modification has been submitted in
patch v2 as discussed.

Best regards,
Qiu-ji Chen

