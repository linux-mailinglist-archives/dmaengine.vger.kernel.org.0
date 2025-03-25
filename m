Return-Path: <dmaengine+bounces-4780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD401A701D3
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CE619A304C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C6193062;
	Tue, 25 Mar 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa7uX92K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688361A5B8F;
	Tue, 25 Mar 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907865; cv=none; b=NcBurtNqoM/qxXT0whZgpPoq07GNX+KvRVwu03VPhGuwo1yVwk6aNvgM2UHchqlJ4LZFdLf2FGQkuY7tp2xyxphVDFxSqRYwkuR1+hXIWgILfVqHcbFgX1X3Ic0FvHYbhsioe2hYJLdFfEkVziVABfrqRSA606u+stZugwTWZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907865; c=relaxed/simple;
	bh=ytAAvQ7JGlkRy9+sQoqDV7MKxsmXX7OMGSm/op62KLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDAvPioHe+yfrF3qxiPEMfbKHpZnkn5DRQpgn9YurPzTceEioiUaOBNXx2jdsAaJS+U4hHjewCm6AovzXGqFoXMHvJdVYGptj/bye46MJt+w1fb0qt0h9fnfTw78KA1PdFM1+pMhwmQUOGLapg81obmtTKhe4uuoj07FHLcy5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa7uX92K; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso46900146d6.1;
        Tue, 25 Mar 2025 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742907862; x=1743512662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytAAvQ7JGlkRy9+sQoqDV7MKxsmXX7OMGSm/op62KLs=;
        b=Wa7uX92KMW9yeIwtesJ1tHzSvA9Fpxlb0073hs2XCM8AUfasnOcY+MlL8ipzW07ueE
         vfDHM+SXGg8DJgtMGxDxSqoKypqAwxpgRqw2vM4BMb5x/+XyckezWZuo6d/eIA2PXKAb
         OCs1IKgeyyFEhAOBfrTqSxhPEGaPeoTM0M0vFHAKghjrTrIwbvKQAlJgKp/lto1PEZFy
         PLphP9yiA8oIE4XAP6ZMrFJ4S1QLV7+JM1YN5yv/25Rqh0JLfO6MKkt8POAN3W1SNgHB
         IuW+sKWtIahM3dLWx0y4xFVpOCh/eHtXYu1SkEqHTTW3ezylKuZN8/CNd+4iodrqgf1o
         phog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907862; x=1743512662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytAAvQ7JGlkRy9+sQoqDV7MKxsmXX7OMGSm/op62KLs=;
        b=ck+Lzr75Cennnt//VrWb73S3porp6LNPrMMBrGx1YHbHiy6jsiA3tkSduw7nFY6CF0
         Y+nwXiLVC5IIm5K0TLdLgcfAQxc0A+yjHidniZapimUn7Cd4CjTsfMv539rUNsNXxfcc
         AcA0Cx8bhjzBzNJyWe6rfYwX+b8Ekes82fBQHG232wiSsgClH+4eia3tNsovgsYDonax
         33nbquexz188SoDU1Gi/Pln7qZ+FFWwJN3N7RISDtzHeq4QvbCBJyAAZP9SdpejHrJUn
         5iJYD+TmhBuOPBdH+pFiuT5We90Jt4vQksTCiIhv0UbOZPbf3tq4/e64qLQRi27mTKZE
         0evA==
X-Forwarded-Encrypted: i=1; AJvYcCUD9NIumMLp9u2/Fkw8qzmsPnessDrno8L2vk+E1rDpvhuqVBueIrHkvFcZJXqia+/NIWsHbUqfNik=@vger.kernel.org, AJvYcCUmuc6kQZdgesDCfUnS2ftY2xgT/4hK+P0BcmqutXSO35C5dzSWiQkrKqkCvn6LSCVTl0KNjN4BVS1Geqhk@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgNvNO+PG42ym6Eme1DB897YBkAf2IRSmxkqGt3/MeQCeOOjG
	rK7vV0mmHc/+6BmTZ2zNSc037cjrDNQCU7LFBFzWgZ9I9zsuv4ybghtrQ0ER4fh88gjzZxFmhjC
	k4ZwrNQy+fk68obGo5WPUXX63vh0=
X-Gm-Gg: ASbGnctawtGd4xbIPpBUyN2Qpckh5JXmbFu1pYaoYvhcHYef7SYk/PnYIkeEVqKlqVR
	wFnc6qM1pdDnYSXvJNPJNh6vde7CUlRCXYn/jRH9F+7VIi7qNY2uqeOl93nZUPAgXaCLrP7xXtT
	Pn46WqxYriQtomrGWCnS2qWtBTvNZm430XH/yy1JPN0A==
X-Google-Smtp-Source: AGHT+IE51PXGLgkSnQJ98M/ddGNci74PQXWvqk0kA+jVT/PXCPMy/JwdbENsPVcSNY10HlA73yPF/yQqtOeqqz2rqvE=
X-Received: by 2002:a05:6214:2607:b0:6e6:61a5:aa57 with SMTP id
 6a1803df08f44-6eb3f2937ccmr297309616d6.14.1742907862103; Tue, 25 Mar 2025
 06:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de> <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de> <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
 <26e36378-d393-4fe1-938a-be8c3db94ede@web.de> <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
 <bd7b31d8-be25-4dbc-9a81-4b0cccd64798@prolan.hu>
In-Reply-To: <bd7b31d8-be25-4dbc-9a81-4b0cccd64798@prolan.hu>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 26 Mar 2025 00:04:10 +1100
X-Gm-Features: AQ5f1JoI1ggKA9Gw7ELv7T2TUC8A9SzwWIQijK61-mP9ZJ-R-qeFWsNR8IL_vmU
Message-ID: <CAGRGNgVcPRJB+sx_5g-+CLJih4vTWU-FrqiRbvVQ07219WBZPA@mail.gmail.com>
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bence,

On Tue, Mar 25, 2025 at 11:39=E2=80=AFPM Cs=C3=B3k=C3=A1s Bence <csokas.ben=
ce@prolan.hu> wrote:
>
> Hi Julian,
>
> On 2025. 03. 25. 13:20, Julian Calaby wrote:

[snip]

> > Bence Cs=C3=B3k=C3=A1s, (I hope I've got the order of your names correc=
t)
>
> Either order works, Bence is the given name, and Cs=C3=B3k=C3=A1s is the =
family
> name (surname). Hungarian and Japanese order follows the scientific
> "Surname, Given Name(s)" order, but commas broke many tools, including
> Git < v2.46, and b4, so I switched to the germanic "Firstname Lastname"
> format.

Thanks for that, I'll try to keep that in mind!

[snip]

> Lastly, to all other adressees, sorry for the spam. So let's end this
> meta-discussion here and keep the rest of the conversation professional,
> reasoning about the technicals.

And this is why I was so hessitant to step in here.

Getting back to that, your patch looks good to me and it's awesome how
the devm_ functions and their frends can simplify things.

I'm going to point out that this does swap the clock enable and reset
deassert, but I'm assuming that is harmless.

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

