Return-Path: <dmaengine+bounces-3450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504089AD4B7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC78EB21A98
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B921D89E3;
	Wed, 23 Oct 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MawCphqa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C81D1756
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711552; cv=none; b=c3rt8xkB/Tg1Da/6S5pLlRJxlqcSYMmbv5rTt3HPgNZphMI3ReRUKzSrC8Bu9KuzHxq6t/etxLFo6GvL5QmpVAl8Ks6vWg9W+y8/ITSrg4uTDB0DMzAdzfiPGenRjzk9KHW1syPxZHeOhBIj3us3FzZ1skCpRrsgwQRiwuHzotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711552; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkywgfHOrSF6C0y4DKNn9nmutV67QGp9bRch6dLNdA8gyxDfZNr8BYELH8o6PXjdoLOhEZwnPWy5odTIPbMSqj+N+YpabIMn/egdvHVwmbHhB4qH1Ay2i1avp1hM7SwHjL3X/441hOR4sPtZQzZWyzGr2taxirjUcZmhWa+foq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MawCphqa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9aa8895facso11017666b.2
        for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711549; x=1730316349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=MawCphqajk9d7yohizlNIbpvTfdE8QARclbxs6VF1FgF02PvZ5iFWI2STEBtUBkCV1
         Nh0nky/RtUnSAmpdWW3ac6BQGWB0c6bW2SwDBPNkXHJwqv6lkUptKZqhdymku8OxadEh
         XnBZIiLwKxu/GXJIeJyW2mG44xy3wwtl7SGrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711549; x=1730316349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=V+50HnY2rfeoQi3848H0ci0ssnPvcHbc/vLFL+SeYDG/McuHZaaCwSoPxKmDWV3B4+
         sW8fJ4qub2xc0k7rhlH4TdBDP70mtVrLXGFJnvX2jLHXaNtSMLAaatksEECnIVgGmWZB
         U8AF37Y2pbfO7liP6FKLT7UuZB4wyphAn4Pww6kBUJuDm+mhgXepW90bIeeFA6u71oFo
         miR6aFbOOKpfG0E1js3kldJwRW/KLQYHHX/d52l/gH1V9OdYO4nnO8WBeXQWutQZOblQ
         2rwZMSzMQX0zN3RGo0MeZm2833AxvKQCxxISXZgF+y22AqGrqSF5EM7nzr8ReN74QBgM
         F6sA==
X-Forwarded-Encrypted: i=1; AJvYcCWnNJjrUByLlnXwnF0qMyfn9NSDd2Y5nfho9c0PUnt9JORSEfBuh8Z2DKFc1Kn/hvA0hFoeI5R80sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnnPIYbvTt4MZfS1JgND+9jdxnxrouTuZm9xYwHbJqO9uZEp1f
	x3lfVFL380NlO3gRgIvJQIY7jiUvb5nlGazjDpV89alZBcshPbAY6Se1vXSHkqYR2eXQQuk4CsO
	eMG/vvw==
X-Google-Smtp-Source: AGHT+IHlqwvUkXRfXbNudXus60k+m1AfYwR3EPQNd5QSmjV3jx80QQKRGyIwJNbpLsfbM91lJPF1Tw==
X-Received: by 2002:a17:907:940b:b0:a9a:1739:91e9 with SMTP id a640c23a62f3a-a9abf86af8emr343282966b.24.1729711548837;
        Wed, 23 Oct 2024 12:25:48 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d641esm516130966b.3.2024.10.23.12.25.48
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:25:48 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9aa8895facso11013266b.2
        for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkD/x/FWoICKhSiqPo13ZKf97lcLMtZsoRGep5j0DVlu6mqJzcA1FLEHE+EWySbTZAh28bOwmje1c=@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus

