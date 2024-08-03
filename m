Return-Path: <dmaengine+bounces-2790-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640D946B12
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2024 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640F41C20FD2
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E31CD2C;
	Sat,  3 Aug 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMfzklke"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A71B94F;
	Sat,  3 Aug 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722713895; cv=none; b=NWobYaz2nmtaJIM3g3/T3iwMz5bnWj5pdSy5Zs4S/8Ic6/rL7uUaOypX666Xu730IaNWP3SGlFXGNLn1nqszCS/rLghAr+hmDjc3acvhB1etTenh2Imqqr/SEkC1gU325hw73a/+4C502Pe6SXXpTxb30rseEn7OAYpcteWnuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722713895; c=relaxed/simple;
	bh=M8wmT3Hj/d4mZ30K6pG2bL5IEgPs6BS5FDfdQ5691rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJP0/o8qDo0oh5t853CCWwGoIyYQFTnicWmELRm5Twx1rAbU5PYUdKrP98tND/2wzBheisNRD3khu6FWD+VE78rUKNUo5C2XJ2Jbp1CfX31svxMhfcGWIIHyQEiWhHqjhZvCdRRfMPlVys0nsOS6pkHxtuNOIWZ4ocU5/+GkCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMfzklke; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso299838166b.0;
        Sat, 03 Aug 2024 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722713892; x=1723318692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8wmT3Hj/d4mZ30K6pG2bL5IEgPs6BS5FDfdQ5691rw=;
        b=LMfzklke64aTuRW1wLNwt2/FpopHsQYTZakRafWCRrwCVBVecsDTxZgXIAxGHe3QSM
         5WRqnrfDKdfk+72LXL89UpJHpzJzqDr2P9z4HY36ZLOdVQ+CWUJcHydQCMbqXVBs6Nbd
         PbCER73Ogrz8JPWjEz6BuUNo7TshmC8HOgOyHIZVkPSWvOVP7rAEINAHvuagpwCgN58k
         wWJZXouVYWkl9aUt9UJFlbtNtri8umfagJUlyUXatpCMAPgkmqKvuWllwUBfNFHTk5bF
         tFajiwmEnipk49TWCEMzHQfxX8ojdgTVxzJF0fMHfQbhWMW+8Ux7nS8WJ69H8jqXJr+m
         9r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722713892; x=1723318692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8wmT3Hj/d4mZ30K6pG2bL5IEgPs6BS5FDfdQ5691rw=;
        b=tq7xBbKUBDBI1ypOPCleBnzscFMa/WSBvhh3AsgxCJ0UNBAqtMyidM1NwQpSW/YeM3
         aIl4F+f+JEkj+qSkzcjnxlgnS8nVEueN6bqjxr1i+Y+2mvzpIngzDjmQv7A1AoRRHaUm
         t+0A7mZk3yCWRT6wKZ7SsCcGMrcLr88qUjzLgSbtIjaJ044yJ19tpOuK3a6hrgKVInPQ
         Q6eMn5vRG9E5h8WeWBwDvUcGcGf22jLn1NU4LP1dEOzIx4mW0dV3q6dw0LaBYNU5hUiR
         UKqonSgUg550r40B/+th0XSsRUC+Thn67/sN+YfumpDXzDyBOn8oyVqEP6p3Pt8pvOaH
         ufFA==
X-Forwarded-Encrypted: i=1; AJvYcCXxjfMGKp9qJoIgMoaIdkBx8CBbmAvqmRhS2MSHd3aZ9aI3VOVCulDRP49uuCpOUHbRjQ9ZQ86YX3WF9qp38kRqurHuJ5bs7vkfZm6WZQBB9IdVc78UwsZ3/6Pu6/iPjEhCaP+FL2Q3KusvVtDQmgVqdX+TsrkdCVI8cFxCPN8qCzoHdy/3
X-Gm-Message-State: AOJu0YxwvmyU7bZCsxqfB6lgOGav1xSN/l0oypho2bRNrTHxpGunoxDl
	IdizcCfVIO32T9ToTbRP5TNFqvcnPDfqtZYRXZN2Kusv8Mxfjq6fZ01h4wGCZnkPRpqcg3ESaRq
	V9IrRbTs5NTqU/+f0AAO0g0MVQ0M=
X-Google-Smtp-Source: AGHT+IFsPQZtiMZ+VsLS7QJ/ykDRwVYs/Y7Ewu52DgtrN2YMGJfg1Nk344Z3K9UTuIXHA59MfRt01eZVXwA4wAkRttg=
X-Received: by 2002:a17:907:98b:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a7dc507f325mr438376466b.35.1722713892095; Sat, 03 Aug 2024
 12:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
In-Reply-To: <20240802075100.6475-1-fancer.lancer@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Aug 2024 21:29:54 +0200
Message-ID: <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width misconfig
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:51=E2=80=AFAM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> The main goal of this series is to fix the data disappearance in case of
> the DW UART handled by the DW AHB DMA engine. The problem happens on a
> portion of the data received when the pre-initialized DEV_TO_MEM
> DMA-transfer is paused and then disabled. The data just hangs up in the
> DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> suspension (see the second commit log for details). On a way to find the
> denoted problem fix it was discovered that the driver doesn't verify the
> peripheral device address width specified by a client driver, which in it=
s
> turn if unsupported or undefined value passed may cause DMA-transfer bein=
g
> misconfigured. It's fixed in the first patch of the series.
>
> In addition to that three cleanup patches follow the fixes described abov=
e
> in order to make the DWC-engine configuration procedure more coherent.
> First one simplifies the CTL_LO register setup methods. Second and third
> patches simplify the max-burst calculation procedure and unify it with th=
e
> rest of the verification methods. Please see the patches log for more
> details.
>
> Final patch is another cleanup which unifies the status variables naming
> in the driver.

Acked-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

