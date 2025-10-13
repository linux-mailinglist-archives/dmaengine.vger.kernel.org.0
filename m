Return-Path: <dmaengine+bounces-6826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B5BD607E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D00018A4013
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE922DCBF3;
	Mon, 13 Oct 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+M4Alen"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8852DA743
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386094; cv=none; b=PdGCA5Cur8ELywZyre5cLGehrHm/4pBrzeBgq9tswXtuDvmk6uCgemI71IIpER72EY5F5iKQXEOalkVoaUuUgCKEUe3d89tYjxiALSbezCXYLIbQMbXzq7SguuKKTJbLEF9qpYARRK2lZCc7tGoyT8UWQUcuKZnXPNOiZfaIKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386094; c=relaxed/simple;
	bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtNTn8qvir5Hnj0jKzH1YGuP3gqPT63LGy2Numq81mMuObH2zsflKkqG332Zt2x78/jc1FgXjyLPDdtSvRoiXDnKs3bTlzZsIbQfRh2500L9c2m0FiRGixcYUQfYTEsmHVY68hrCjn+W8KC2DgfBcWc1xqu4f4QsH8X/qpifvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+M4Alen; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b403bb7843eso990208166b.3
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760386091; x=1760990891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
        b=P+M4AlenvDBYl66gEuJKbC66DjRlVBhZ7xRZBMxWg8+1DtuSVff0vUi7qTgMjilaI2
         un0IoFj/gijG/XS0AWPP8dFcqOkIlEbMfRm23o0WqTRyrPC1TB0bHQky19lITzx/OpIw
         ej0CKLpWp9A6qke6rLzCa9liJUhwvI4st2Qr00wFzsL6SH9Q9H6CdCwHrTNUxG+rx4fP
         0cygwbu3YLaiHfSEYdVFEpyjGW9nXmSxPvenD8UH6ULjcS1U0v9ycVLdnKOnld3FgWN/
         s4LzIFn+BVyhZRsOiqjzlSEeh7Hp1YvErr8UDQkRB7Gwc/BK6h9Sj6U2SIfN5CeaQUUC
         Sl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760386091; x=1760990891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
        b=jH8rSFCXj7nszwHKQs2o3rQnvXeMJ6rH8LRcUTmV7VawVQXaHUz5mcuM6gZhLOphLY
         WIFUQofvladlbsto+Ixv81RdChJ95wx80Z8nEvVkcuKDQWRD91cPg+693WxTEa4E1N7C
         xjcSe8X8A2MMDEpDX6A4icoqQRbNUjTZG7iZhaXpRVsVWab+UB89WMF0zoHRWv+9DOlw
         sIzEvw/MLVre39r2HdarxZVKt9ozJraNqWIGhQkv3MYMs8ZKTMHNYwaytYu6nrBul1qG
         9D1fgQ+tMrwZTruOM1Q1ohsLhvjG0AqF58NwUt8lWk4gaxQUBkixRff6Pnq/Dk6gP6rX
         dpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVcbcSQCSyanzmQj1HP4nxDHJIQwq5jvcTxHgCvp3XTeB25uGZFyFGB5l1RVXyB0jSF4qfLqIXoxf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FE2i20GN7gNbZSVb0xLUdkKeLJu7PKCZy212PahjfAJQ+3hx
	g80ubgthnPaZrtuL1JDJWeO/rG4Fb5RWhGHHCYUiTcWYE28LL7wpu5qbSpm7vUaMiZCMME9/QDG
	Lh0RXnOha7slUMjVDX+RDr4kYCEfwKdQ=
X-Gm-Gg: ASbGncuIkoajPrLJ8YqylX2eijHwMk9DbwH/mKTXu4pecUQOC3bvvhKZnkRV5LxeTx0
	YQXZ5HMqpDEKWnCO++ix+O33bys9nGXLETMBTTX6pDXgYF79+LNaCzi/e0gNJDpjwuC2Tt/xhBI
	iB4vmsnozvM/MlMFGGU7t3zUCIPoup0Ag5IPcN7D6mwJSWcsuu0B9MnIR4Seb7XVEpALV2NL6fi
	aaPlsICydmwQIdc4gvcOjLmZSLX+elXJe2Y4F8aIA==
X-Google-Smtp-Source: AGHT+IGaOBiDAnkUof21+aHq5NOWhRzhwOoz/nzsettYzFgLEx+7+Ty6orvQvellFLzzr1bdUXMUgkNJat1TukbLgbU=
X-Received: by 2002:a17:907:26c8:b0:b3d:30d8:b8a0 with SMTP id
 a640c23a62f3a-b50ac5d1de5mr2440916766b.52.1760386091019; Mon, 13 Oct 2025
 13:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
 <20251012100002.2959213-3-a.shimko.dev@gmail.com> <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
 <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com> <06e7f7f23fb264e9db39441698b33c048d8192e3.camel@pengutronix.de>
In-Reply-To: <06e7f7f23fb264e9db39441698b33c048d8192e3.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 13 Oct 2025 23:08:00 +0300
X-Gm-Features: AS18NWCzd5nZy964L2prlJcgE13LQIh9M4J6dP4_QQwOGLFh6mQxszugWLdKR_8
Message-ID: <CAOPX746fn30c9zVk1Wrsgy86zccEHRGuhraUoS=qsFz11QSeWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Oct 13, 2025 at 6:41=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Mo, 2025-10-13 at 17:56 +0300, Artem Shimko wrote:
>
> [...]
> > dw_remove() has axi_dma_suspend() function, which is where the reset as=
sertion
> > occurs via reset_control_assert().
>
> It looks to me like dw_remove() is now missing a deassert before
> accessing registers, in case the device is removed while runtime
> suspended.
>
> regards
> Philipp

oh, I see, it looks like we have to insert reset_control_deassert(chip->res=
ets);
just after clk_prepare_enable(chip->cfgr_clk);...

You're absolutely right!

Just realized I may have been too quick with v2. Will wait for more
feedback and send v3.

Best regards,
Artem Shimko

