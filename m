Return-Path: <dmaengine+bounces-4777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538EA6FC6C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 13:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC22189DF88
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD125A64D;
	Tue, 25 Mar 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvA7D/2P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9225A634;
	Tue, 25 Mar 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905248; cv=none; b=SrE+QlEU/UaZnOPZUXQdwu0nTL6x4Edfd964WflhF8N5GcCL1HKAjFSVHwjJ0ZEfxyWGnBifflR/RgzwQBT67b3jHTsdLfGqkPgflBRu3fXhUB60GvubuidVDKhWHFMpocRRPH6hABthnXIkWTvwTipbb/VdBQwrrBTutGByPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905248; c=relaxed/simple;
	bh=+Q6Q8jost6RR+L6/1WQaoG8urBg7K9/rNabjNfsQh20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIeIoNzVkuOcAmUfrdmCbU3lVIHQahIokaNmuPZ9iXg6hZLxHNC/lqJWWevoltXjWJ/5kiDbqodzFeBtspYxJqm2rvKVmTV6kIvu1W9P9ee0X+PZoE10DBkGtaBadp0JpR0vSScq2rifhredoOXGEMNDOKDKwjLWRx6KmzRhEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvA7D/2P; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f05acc13so65875006d6.2;
        Tue, 25 Mar 2025 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742905245; x=1743510045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q6Q8jost6RR+L6/1WQaoG8urBg7K9/rNabjNfsQh20=;
        b=lvA7D/2P1kyd3seOssn0go2hS35d/CRgd6nf4/nIZIzUeicZRqR0XIkciCwLkfJNqd
         o2XQDNpO+sIF2yNHKBbLwdlkt9dU/MfVQg50SoCIQKyNpS3/KXyVw8n/FKQSFLhaKOFr
         Qzf8zrfsPoMh5Z2yzIP44a+ujQyxTVK4LpLSWwHWK8pVlT9DoceptsHsVqVkFAc8UL3G
         tXdp4dkadq5DEuQHNUb3WM0pupv8CN4zDHUiY1/43mA8BySwB/LxHXGVJxh8+qVHd+c3
         9aI/YPUIjWbqAqH0P/QXpxTmtxWhdJRKaPeaBODZx8k7qWUwp7jMtmPAr7u7IUDxIe05
         uveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905245; x=1743510045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q6Q8jost6RR+L6/1WQaoG8urBg7K9/rNabjNfsQh20=;
        b=J0HyZOsW9r3lQqfI53mrTBXhoT0X4FB8hGifHdFLBLiVESLLjdXbfLGEru26onG2GZ
         0qyQO7UMS8HUHs8q5bxVrYptWkYccIsKI0v/Wsiwm8BDF1RXn1bqPXQHCgb1UcgiunYg
         gTy2BQYpg7vXZlfchoFiQK+oYyIAZKlJi4VAUQJ7ckaaYOsbjtxxiynkkHaYX4Tx+4KI
         hGQboY8g8iZ62tWyEJyyMlLYVIOBvhrKky8qXu4MzH7GJByZa++grH8Ox5YSLqXM5iwm
         yKbmAEQoqPlEvmg+ONh0IQQ3CSI857AppRxAMF3ZBXKsLqcYN6+1y2d3JVGacQQMStl9
         fRtA==
X-Forwarded-Encrypted: i=1; AJvYcCVDtzXQ0wwE9JVJ2FjbirBvmE0GVd/jrGikx//UyTyuFZEUGkB/G939GQql+4p3qgGc30HDkSinyQ0=@vger.kernel.org, AJvYcCW4eONknek35N+KmpGkZT7U9zlZwDqrHzM6CLOcmabt48VdC0s1G4ftbAbw1tKqbMt6BDaxAnQZ1r3IZM8c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//p5CFQSohO2lvB+xQvvwh2kJHMAFzvpElVWFpdVwH5hA0hCW
	Am6dhUCpEcxC3Qvcgz/ye/WG5Hy/6Hn6HbVZKPeeyNqFOsFeqza7A9YFrauoZg/hvAvOiLHEHwM
	7jgA93H1VSeaIjhx+87yr3lzVoxLxdZM+
X-Gm-Gg: ASbGncta7olvi8q30lzmpSyFZGipK0QY91WZYRt8l0RXWHXkfLMrXohYM8orEJpMN4N
	utQ5RhYrItP4rBIg6ogXyCDGLTWCUc7BYmtdRWknFm/f6+8oWtP9kMT95qJqn5Czb/HNi9VWmNg
	7akBpzz1djV2nhYj6KMUT1aphcUsJbEqBNK/AvIbY5FA==
X-Google-Smtp-Source: AGHT+IHzPCRF5SOBl5uX+I45ItuIcu7yYqv1UpwkBeNgwvJPwNXZIu0GAxVrZtFs9aKbKMtvCsG5QpWp0f/ADoOZEd0=
X-Received: by 2002:a05:6214:c64:b0:6e8:f17e:e00d with SMTP id
 6a1803df08f44-6eb3f2b884amr196473756d6.14.1742905245447; Tue, 25 Mar 2025
 05:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de> <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de> <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
 <26e36378-d393-4fe1-938a-be8c3db94ede@web.de>
In-Reply-To: <26e36378-d393-4fe1-938a-be8c3db94ede@web.de>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 25 Mar 2025 23:20:34 +1100
X-Gm-Features: AQ5f1JqJR8vf390EC146ON7d6-teBUeT_TrrTXamjUUZoP5Hfz81vyeOiEOgepg
Message-ID: <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
	dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

I really wanted to keep out of this, but...

On Tue, Mar 25, 2025 at 8:14=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> Implementation details are probably worth for another look.
> >
> > What don't you like in the implementation? Let's discuss that then.
>
> I dare to point concerns out also for the development process.

You're "concerned" about patch granularity, but this is not the sort
of thing that some random person would raise, this is the sort of
thing a maintainer asks for when patches are doing too many things or
are unreviewable. This is neither. It is a very simple cleanup of a
probe function as it says in the patch subject.

Futhermore, this already has an ack from the maintainer of this file.
This indicates that they're happy with it and no significant changes
are required. This is also version 6 of the patch, if the maintainer
was concerned about this, they'd have already provided some clear
guidance on this. If you check previous versions of this patch, no
such requests have been made.

Your only other "concern" had already been addressed as has already
been pointed out to you.

> >> Please distinguish better between information from the =E2=80=9Cchange=
log=E2=80=9D
> >> and items in a message subject.
> >
> > What do you mean? The email body will be the commit message.
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.14#n623

The email and patch structure are following the format outlined in the
document you link to _exactly_.


Once again your comments are just noise, and your insistence on
repeating them over and over and over and over and over again is
borderline harassment.

You have been told to stop this nonsense many many times, here's a
link to the most recent one:

https://lore.kernel.org/all/92d1a410788c54facedec033474046dda6a1a2cc.camel@=
sipsolutions.net/

Please stop sending these emails and go do something constructive with
your life.

* * * * *

Bence Cs=C3=B3k=C3=A1s, (I hope I've got the order of your names correct)

Please block or ignore Markus, at best he's a nuisance and at worst a troll=
.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

