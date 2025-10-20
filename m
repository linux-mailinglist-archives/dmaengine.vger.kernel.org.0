Return-Path: <dmaengine+bounces-6909-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FACBF2D79
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 20:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B652E34E320
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA81EDA3C;
	Mon, 20 Oct 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRlIXWdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DE332ED8
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983215; cv=none; b=fipY73DOTnzIgh+4CpAU6R/h1CpEQ9ktL5dSVRFye+cpUOZoxE3fWZDspCQ+0ixDQi5m2K2ML1YnV55wc1TrcAadsxpkzaBW/qKdeGVf/qj9+fpZCvT6oBQ1Ptpljatbdu557Dg16z9pMkLJxoo38I+MQMb4eWwrYSpIvcVviHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983215; c=relaxed/simple;
	bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b04Bdyh6+ZJI8nBVXpNuR+tlLySR1qYVhjeG6SU2OuJtFXs3GxdcCzdDt38GDUU7XDvfWE6JJ2Ap73v+4yPnBJGfXMF9cA7G8zRRNUB4x1xk87kEWDTIJQPsSHl78l5l8YOc+oTLe4X9MdFFPsmaK3YW8lzzE4XpzHInkSdVxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRlIXWdp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471075c0a18so49158835e9.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983211; x=1761588011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
        b=YRlIXWdpXZZky1S+VQYFWxgAgiquk2WWTh/sda9oeCfMLuXyqlS+0yqkVULqXq1cPV
         HXdf5ySp//CweUuNbjJpvU/jD5Tick/tuagMhLeLRIEh7Gy+x3EKRK6fnHmc2VcHxlbk
         /axAyceLgkAZRBrVLX0FSSH73ctUd6tNZvBEP6UiA9ULz6ipykI5qNINmnLS2slp243G
         BwvmlA8qv1C8Ow5JumRFcs8RuMr9exUZZnVrWZdd6IEBtiOXvAqUJ/iO+DAXFQ0g05Od
         NCwHy9Y1aR8STwfPfi/u9PNn91Wujmm2u2mWfCsdXRhf/fJuZIZamXkYtsE1TDTS2Kw/
         8v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983211; x=1761588011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
        b=aAvDlC+ZW9YY6pwXuSpSNSBcbbdFuzVZwGufoq4xNXwAuVTpyu/SE3BmYa6VkdkLLM
         6C44l8omWdtB1UIqqXqx7N8KJjG7JLbcJLzBjlFVI6c4C9ORqvYkhVledxy7Vv3uBj+c
         GH+xiVhE/E2us2kzNt3qGdqc8WyGbM0qSM615RINsEraSS3BxN0TnsigChPUBLEw1cUp
         zLuYYlOwhARUMUuYoA7teysIvdP8HhR5jBgVaZn5TX4giDeYU0qYnnInl0FB2SNwlGeG
         gFFlhi3krU+FJOzqbDdQRD6QXUOqGtSo7wpjfsWWxaZ0uUyxP07isZHAwCcggOF5JUse
         dEXw==
X-Forwarded-Encrypted: i=1; AJvYcCVuoSWJc7BudQRJTHgS9/4fY3Apg5gPDqcMRujhD13TQBUEJhGOIMTbM2NkIfGBw/fVPKhOccz3FMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPqFnhDEGIvKyy/jKNTt6MvhYjSVfXsnSHrYJmVf4/qVsqTOe
	MMAlU0B9v8Yw6/wNEcw9YXGGBn7E7bUz1M/J6kFL6mSacA5sIa+pp1sX
X-Gm-Gg: ASbGnctmbzuqEGPTY+dY2bB33rlRZn+FKth1Dv10KzKohJSrnMbsR/yqF0q9ffKbYGB
	hYgpxBk6dDnMJYYLKJnOjjgWYZAJir+ZaxZr+VenK7a0hNjJ9mtXymzZebERtEMaw/ryKCchRER
	iLTJhnYvNia045xcqp8uDuABNH5EPkejmG/6j6KGrhT+ru+RX1l5sj4JlGXhnKJK5FjPt0/+w/+
	bhVBNxCUIyEL77nwd26IT8eE18WVGzP7aUnOu+xCt18fi7UB2Ro/mJuJo9t0JBq6troKXAur7YM
	SL5Meh1YObNYtr3AD8jL3MRaPK1SYmbZjz0VGaojfJ+dQ9jjTZUZkrGrqU/WaRKFbe4uDu6Xlsn
	JB1/lZ2/rnLtCNsFRQOcI9k2h9iQtyW6yboi2XW2BeUE45cTvMaXg4il0r77u+fSeu0qI4faz43
	W/rqjPVIeQCZyN3DKBuZsfkmdk1BTscF9Xh/q7hPW+iK+SVyvbTY8E++0aTAFUhYYp1yI=
X-Google-Smtp-Source: AGHT+IGVeYcgA+CwUr1r7hUy/8iCaT15cDHaEmoGMtDm9YvbEjOd+dz5rkW55YdwDONL4X5PTcG3yg==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr126637915e9.32.1760983210516;
        Mon, 20 Oct 2025 11:00:10 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144238easm248496085e9.4.2025.10.20.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:00:10 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 10/11] arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
Date: Mon, 20 Oct 2025 20:00:08 +0200
Message-ID: <9520278.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20251020171059.2786070-11-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-11-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:56 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The Radxa Cubie A5E exposes I2S2 through the PI pin group on the 40-pin
> GPIO header.
>=20
> Add a pinmux setting for it so potential users can directly reference
> it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



