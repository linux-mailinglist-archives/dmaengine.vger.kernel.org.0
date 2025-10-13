Return-Path: <dmaengine+bounces-6817-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B013BD40E8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451FB4226AB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E62FD7A5;
	Mon, 13 Oct 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm4LZ0lc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD330DEB6
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367408; cv=none; b=sU5kybFFMZtKPh37HR2cLmCnIE+5bcEvaBUuZioV2zK3l4z01FuWTcHXpvMlmLtpwqRCrQ+udeZw786Zs2SocyQyh9xfvdNVl4P+Q9oJ6phmsUR90bSvVJ1wW0ULtf/DSO8c9+CPXXv0lz5lPBLIRnMbuBgnB+sIxLKvQMePbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367408; c=relaxed/simple;
	bh=AehrbhclTtoUDRENr/Bm8ZihfIN/oseRDAuymqWxuE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nleNb+WEjy19QSl4Zi75PPfzRf1uVpSV7WZwzifD9oNEtYlAOEPSKjIlmy+1PCjqCvYR1jD5S9OHxxLRt/gADBfiHATahioMXC5Kfq9xAc5GOTs0UCMtayVYDMeq4xmiaDerLYSKqY99s/+3yMyfdirmR3FXOtbyvSZns5Te0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm4LZ0lc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so802848166b.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367405; x=1760972205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aiSy7SPQKxnXOFRglf0lpkGWBCc1QdWRr3Gsnj2XNY=;
        b=Jm4LZ0lcQYdJ9ZHsG/wCiTD6Pfh4EIP1BhafH61PTSBE/1vudWTeMWI/6dq0xMgfe7
         qRk4PnXUIpeKgPtAgXn1w4qx8tdPaH74ppZ/G6XmUPjXrPSOpTteeCd6M+XGVMA8l+s6
         KzL6MLH9o/VU9qCOB3u5vn9xGCR2U87yUJHnnM8FxW5fR/U3zCK0qfscxII/BkJ+OI5p
         gUfZT0B/r3JQ+jqBsb4vvHgHN9F9kj4bAcoJ7rBBrgonqMO1QQ8yzPnWQrORLpyoQQqi
         oqgT1KtKcdLyZBr2k7TLqib5ki+78a00ixoKWijIKtwt+e7yT6fH9TDk2bP3GQPE3X87
         I9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367405; x=1760972205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aiSy7SPQKxnXOFRglf0lpkGWBCc1QdWRr3Gsnj2XNY=;
        b=K4TKIVfqW2XRPheP0Q/4hmQj8tiEaOfeodoq924lBXwBV0Gepj54QCtmxBoesNCmZx
         ytiS/sHNgZv2ZlUrrc7rg23SfhZxHclwaGmpAHsl+sTBcHfP/F4XjHEP3i94INiNIpI8
         xkL1I0Fj42lWxEkB912rQfe+wAl5MnqMUO5Nfg0TmZHUfPF1nOXTK2V5TSk1eDGWN70w
         sg8Yrs6BOyMM1Hei5TQpOQt37GU2CltiEgTKtHDgAwAdUpC02dtRizQeW1o7WGdVOp9u
         ePldJHKby7vraO0ih+WukUAF5A7pQrIosb5euzJTT0h6r0VyfuWr+vuu16R8RAGWtwuG
         p02w==
X-Forwarded-Encrypted: i=1; AJvYcCVRR7dDetBkzZnNQ75FPpAeS++Sqxv44+fvslViqfFkAzy8Z89O+S7AHf2Iuvc5+me2DKGtoxg/+jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1V/fRQX7YNsiuXEfZnq1jU3DPrv8XdR6HMhwlreqoWS8mnDfo
	rFWQyYmt1udAVotCys1ZcEUbwWQnlr3f21cjE9eLlSetkBOC3EO6wJFmFvy3OT4UBuvNfS6pTgG
	Kd1uS5qx2d2LrAcXnzScADBQZWy1vs8LpPBCL
X-Gm-Gg: ASbGncv3jpICZwmr8oX90RROL8+nLgeGpLlkd9NIryFhJE5g0vl3UNGB6YYXaUudcTQ
	a/pnSNACRE0l4nK+d/7PoAZWcPioM0VFIb7ccjJwXHPdh2iUxl9WxVSYi1r5HQVvfecbkBjKWpn
	gnRcctwmoEgAzhmN9P69s0hnJlU2xWCLQZeZMzPapKHQwMrijMRPFPTC4SGnwUB7nfEN9puLXy9
	Pdu9Pc/Sg/xH+aM7WcXw4fNWfuqwh8=
X-Google-Smtp-Source: AGHT+IEn4BipHFdFQpty90yZnHdtDve94da1wmgcnb4VcuDQTWpdAlFenmdB0falhANu5gpidPUxD2j+WgGCDLtnHLE=
X-Received: by 2002:a17:907:6d1f:b0:b41:6ab2:bc69 with SMTP id
 a640c23a62f3a-b50aaa97cf5mr2140703066b.22.1760367404418; Mon, 13 Oct 2025
 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
 <20251012100002.2959213-3-a.shimko.dev@gmail.com> <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
In-Reply-To: <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 13 Oct 2025 17:56:33 +0300
X-Gm-Features: AS18NWAykio0w701fbhEeHmzQJfNFnnKmOciJx4yZvvqyOgcP50A65S9gxbvyXk
Message-ID: <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Oct 13, 2025 at 11:41=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
> reset_control_assert/deassert() handle NULL pointers, so you could drop
> the chip->has_resets flag and just
>
>         reset_control_assert(chip->resets);
>
> unconditionally.

Thanks, I'll fix that

> Why is this moved down here?

Reset operations typically require clock signals to be available. By
moving reset after clock
acquisition (devm_clk_get), we ensure that the clock is ready to
operate when reset is performed.

> If it is ok to keep the module in reset, shouldn't the reset control be
> asserted on device remove() as well?

dw_remove() has axi_dma_suspend() function, which is where the reset assert=
ion
occurs via reset_control_assert().

Best regards,
Artem Shimko

