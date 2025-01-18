Return-Path: <dmaengine+bounces-4150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72082A15C39
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A371888FF5
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC48175D5D;
	Sat, 18 Jan 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCutRdJH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE77170A37;
	Sat, 18 Jan 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737193810; cv=none; b=bN+n5rcX2+sjOwJJn7QYrr2kdkskTbn6ZBD4iuPtOFVPtFfvWztGgVkYrVmVxb7SWUKsMftISpCvYhQMAFxZ8m8ByXb+LIdl2kaQys7m01b2dcHt40r9nDZ1izgzpeASiBY5OaIoKnYjo3GU7K2tWuPdDnpip5finiHHdA147kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737193810; c=relaxed/simple;
	bh=FhhPsyyyRSLm26HDZBn+CWRZFfO6+xG+OhBZMJX9T5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdAh1ShBccFe2xBTzOVqWtNbAKH3Xg/96grDZJ9TC54bstv+zlteTReOfKiyj1DuGVsNxVwOuSeN0ZBuW8kPzNMe/lLdr50jIioNZcZSy+zdxlwj5Ux72lkPxXxKHylPWqoy2O60w+igDm0YS+9DERsNz9/t16BeTgof3KxQ97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCutRdJH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so495494866b.2;
        Sat, 18 Jan 2025 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737193806; x=1737798606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhhPsyyyRSLm26HDZBn+CWRZFfO6+xG+OhBZMJX9T5g=;
        b=YCutRdJHZ+vhq9CBjmKf+2hNCHBrgwHb1ajOpsErau+WGQlLU8CNbEE+XaEML4401f
         akEXe5QtOI+tgSSklfGjuQIlPnc9hXQ/Ur3okA9pag5VXhDz3bJTlwXueee49wyhEyAU
         WPIMKMzCo13JmkJH1b4BnQ5u+LY5E0ivvrDFl2Evc3Lel2Q8e3RNFzhQRcB6QnpST6bl
         ieW5vEJwhAL+tcjlaDO/hXLDzt/7n3lSIsCHSFI6etxyKppcLNVwkyId5C48ry/xuvUC
         DukdC6geshMlTC56KHMG+42CjlMuVwLUW56nrlPJyNcAwxTHBx+lHxIA5UhJpgcFQgy5
         btAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737193806; x=1737798606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhhPsyyyRSLm26HDZBn+CWRZFfO6+xG+OhBZMJX9T5g=;
        b=Dq01seEWdagw7FZNsrYhQ49Ie4XD4ZjJeFPY+GtXI0TKjXGaD1j0vHlfDRhwx7GCT4
         HwxPfAZwESpKKUcW77RTRrtQR+1n8JLGeMauiMkUYC1Y8YVJngfELVXlj/gctiJiDE8J
         OJFA+GOonniHmdUxfT4yD+YaiQYlWijkAqhW0rb50oIPV4coTGrfl+Z2hZ8PmwVGRlEz
         p33yZ3YIZjcjCvGpsNMj4rQ0YINhh5pSH0bFoMY7gqbh5pus+5q7Qrhgf8/rcfv75pNq
         ie3RCS+hmJ8AeLgZLA2OFWJODjhjSmYuDsuW2e+kq6SzlWml7ZaW9kTIl5o8Gow9+eYc
         84Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXlgHAtuASdp1/hRPPym1LgUdAn/mUMvxozxxOc4SXEu7CXtcWbnZzKr/myvp8jNIkyCrmgDDyXZAhEbY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUwUDwjhDPPlx/iv27n+uYiFGaaMQNmdgsB/+5CidvyQDBk2T
	QlJTrUW49/7iS3WyO1Ez2Ij4jsH+fqJZDgutfaNM54wsDL0I7/mJjaWZOA==
X-Gm-Gg: ASbGncun06r0cCRKEzQvGv+w0W0UPpJUIhid9xS2S86q2cwV4/PYkEIgpTppDa7rGgx
	UtbItTGHsovoOhempahPE1U2pRJ9KHVCV/m8e3OAEWrMm1f6NSFIVphFmpVpQCDNbcUbHausjiI
	QI+cLSvYdeLDsqvs1dGXTwj31SY2Cqn3YQOrAtKL6DLEvKxaEfd4nIad/fuemDbx7HWi6DDXnrK
	wDxY/rJmDiLxQLVok+5roUlolCpDwuoAqeYjfGopwI/ScGV0uMVMTx80sLm0FIX3FJTBdiGRLmz
	CyHS8zQsOt+PfFk=
X-Google-Smtp-Source: AGHT+IHaNlcsc4OEmrt7TiQegOYBfODCrIraAE0UV1fgtoWTxbEJfDVj44pe49R0MuM+IUWNGY0pXw==
X-Received: by 2002:a17:906:fd85:b0:aa6:becf:b26a with SMTP id a640c23a62f3a-ab38b0a13e6mr479360966b.9.1737193805433;
        Sat, 18 Jan 2025 01:50:05 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm306520966b.79.2025.01.18.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 01:50:05 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bence =?UTF-8?B?Q3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: Bence =?UTF-8?B?Q3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 Chen-Yu Tsai <wens@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] dma-engine: sun4i: Use devm functions in probe()
Date: Sat, 18 Jan 2025 10:50:03 +0100
Message-ID: <2217419.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20250114100505.799288-2-csokas.bence@prolan.hu>
References: <20250114100505.799288-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 14. januar 2025 ob 11:05:05 Srednjeevropski standardni =C4=8Das =
je Bence Cs=C3=B3k=C3=A1s napisal(a):
> Clean up error handling by using devm functions
> and dev_err_probe(). This should make it easier
> to add new code, as we can eliminate the "goto
> ladder" in probe().
>=20
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



