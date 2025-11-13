Return-Path: <dmaengine+bounces-7143-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21FC56BDF
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 11:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE84E75D6
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581529BDB0;
	Thu, 13 Nov 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FFz+VPhT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E7280A5A
	for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028147; cv=none; b=MTb4t82/BBdQUS4sHrl22JkPrTrz8NwNSpUu5RqBbUjKJZkAO22KRNzke9kiaM7puMKmucgQ9V8dBLhKrrKVNwi8AgIloPfWnr4YLCoRrTYV1wMhmMiILPFiKeS2bhAtNIIf98c1JTli3aqxUQReuDeISR3viCJ/eoEFnU1nFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028147; c=relaxed/simple;
	bh=347InnF7w0TQGwF3LKDpkxoBP63o1pAQwc45OEGOOng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RL1X+oTS+d7FlPjD0aBj/AKiD7z/nRZcx6rSxuOsnlxKIjhSoZPDJtjnM31mJaaqSAnpPS3ovXDhimQpph259MOJQVE4S/FU/mpBe0CF6w+W8eXgPiwGmNHvXdJVSslCc6j6MROzBojWdmP7YqrbxP05U6XNUz7kt2UNMnNK3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FFz+VPhT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37b9728a353so5653601fa.0
        for <dmaengine@vger.kernel.org>; Thu, 13 Nov 2025 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763028144; x=1763632944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=347InnF7w0TQGwF3LKDpkxoBP63o1pAQwc45OEGOOng=;
        b=FFz+VPhTnQolSJSmG4FCu3Xt4fES5kBKLCd+GhIneSTYDKRGfPN8zyn3eUMQLuodD/
         H2z3dbJ9PxXXRjIXTypnTv7fD5q3Rd/ke6LsB+xiLQUaKflb+Wnx1eYs1wITzu/OVP9b
         aiQMqhgD8S012hXS5cNwQrhvYHpCByonyFcXG3j7AOXGG6rN+GampPrA0sRvyyGO/3vz
         zjd8sdAl75JUdv+8J4VnsuXD3OZ/I0yGFVt/xMOhgUO+SwPyJp5Y8RUtnSDToJOGyxYb
         XKLGpelNvpUjvGQhJA54sg7e1sOfozlMiFDTN9BV6FpwmJcpSPfww6fSimPKkmYoJLsd
         p9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028144; x=1763632944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=347InnF7w0TQGwF3LKDpkxoBP63o1pAQwc45OEGOOng=;
        b=LPj+th+z8M3cS1nXpldsPSLUNVcoMthvp5ZtSDPiMWba/FwT4ol8TJjIa+pKmrJbPB
         0sgfn+pnhdlN+hKt9V21YoadNxD32lSiLLfd9o8HWR818YvJfpcI9lli/PlaH8oZlupk
         Zj3vXWQY7yIwXnqDZTqhZYhd3NYIsnZkzQbM+/rWAXjCYD0CRx475pCxVPC4xa7Phb4F
         /D2hiDPdugPp+gBVn6mK39MUezecUC0GR9+QQapMtjJ9HaGJmILSDG9BvkCs1d/Xu/U7
         Lvh0h1AhGZcWa0/tCO/Ua9qZ7vrdP7zPVU8wyHWv5Ndc7Zn9FiVEsawPgkg7sm+OQruJ
         Np5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf3u/Efg6Uw93vln7wBbePaz/dAjCuoJlpXncJao95hZdtS2B8H1i7Fn+6vuqCBKlgj9la8u5wMLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCDGnlyA9PwgTrgWCPoL0SCaO1x4CG+6sJpfrz6lAxARAWuPf
	Ldin5/XFtVPRMP44vr2zlngq83wJ+S63K9Y/ICYZNZYBa7OPqjZI9B3OgcdJ5Wa6JHUMysxl0u4
	R6ln16f3OUbYtxgLW+z8Ez3OUrIx+fIHdvU5UlZUejA==
X-Gm-Gg: ASbGncuWJh+sKvnUsst/0Ur2ayFOHlqSqV5SZuDiU7Et+HH+5KdFl6xlZbs1ijNhj2J
	iH3LaG2Nq+ld/0AbZ3m48Ug+0bOQRwHekJJr2GrtG7s5FRP9ZKjX8aGgy5r/+5ndn4TNoaBFFHS
	8jhhvPu98Rbco1Yyt6FLysHUDkPtvmPuhoy3bBCUZAusQDsPGxVAmTkjrUbIq6L8YDl4KqNK6PQ
	dzH8Ttx6SOQUZDSg6Weo7e3W4jdlINWqFj6ZAAnwCZefk7cq+2KjDZhYVePDumT6m6BDXDEN4xi
	mUDOhMmqzJUFlGlN9PlSbszMUho=
X-Google-Smtp-Source: AGHT+IF80BtPctM9eC4e7ij+kECyiSMuMR8eaI6A5q1UsvTkOe0o1G32eF/kAIX8FZ3UAPGxB2FJF3dPMAqvlpNwJF4=
X-Received: by 2002:a05:651c:4191:b0:378:e055:3150 with SMTP id
 38308e7fff4ca-37b8c2e1512mr16366071fa.5.1763028143794; Thu, 13 Nov 2025
 02:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org> <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
In-Reply-To: <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 11:02:11 +0100
X-Gm-Features: AWmQ_bk-LstuhQR3H10ukwySBYZfpE2zb40DoLXgGCclIQAg4lhk-Zsk676Qpb0
Message-ID: <CAMRc=MdC7haZ9fkCNGKoGb-8R5iB0P2UA5+Fap8Svjq-WdE-=w@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK flags
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:30=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Some DMA engines may be accessed from linux and the TrustZone
> > simultaneously. In order to allow synchronization, add lock and unlock
> > flags for the command descriptor that allow the caller to request the
> > controller to be locked for the duration of the transaction in an
> > implementation-dependent way.
>
> What is the expected behaviour if Linux "locks" the engine and then TZ
> tries to use it before Linux has a chance to unlock it.
>

Are you asking about the actual behavior on Qualcomm platforms or are
you hinting that we should describe the behavior of the TZ in the docs
here? Ideally TZ would use the same synchronization mechanism and not
get in linux' way. On Qualcomm the BAM, once "locked" will not fetch
the next descriptors on pipes other than the current one until
unlocked so effectively DMA will just not complete on other pipes.
These flags here however are more general so I'm not sure if we should
describe any implementation-specific details.

We can say: "The DMA controller will be locked for the duration of the
current transaction and other users of the controller/TrustZone will
not see their transactions complete before it is unlocked"?

Bartosz

