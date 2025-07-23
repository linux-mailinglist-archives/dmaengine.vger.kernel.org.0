Return-Path: <dmaengine+bounces-5845-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F728B0F17E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6BB18958E2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8E230268;
	Wed, 23 Jul 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEHQvoW/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08D2E4257
	for <dmaengine@vger.kernel.org>; Wed, 23 Jul 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270897; cv=none; b=BmnMW3ufkwlZBv93Y1/oweS6V/9iSXvs6dCx4aOXJ9FAojgf4OOryjEauxgGfU6reMAJVVGcRQytSwKJaqBx701/bfNAd7zD6gCfwtMTJNaa+AGSatcBHOmL4U8hESv2vG6qXxq1hxp+xJPceJ5E9gz3F6CbVnqbq2fu3YV3kKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270897; c=relaxed/simple;
	bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq26rMM2wTxPs2BIyLzkEC2FnfnbZL2WMrIDngH/msDp2JuRrpGKE8n4q72yoCGlWmqVE7xEhjcYS+u93gZiwvtFpv1sonWo2jfwlepAKH3o3NiEQD+O8aFv9bjPDsBvmYFzTeTFNZwp90k1tIHgfnYDVFVtNBfJSht0PExPY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEHQvoW/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7183fd8c4c7so71651047b3.3
        for <dmaengine@vger.kernel.org>; Wed, 23 Jul 2025 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753270895; x=1753875695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
        b=pEHQvoW/Jq3qdgWeXp4QgxCT6CcBzKrDrEu6RtHSxdNNzc29NiuQhDW1WVk38c8idu
         bx87q0BNnbJyfbni5t0mEg1mmAl1e8PNISVLtUIyYk3nYXajUsYFfnuOKhAJaV5myQ7a
         ieGzYAhuZo94Jqv48UTxG2XJNuf0lm868NsApneYVbPo2J44lANdUEtDD3gRrEWJbdUU
         f3107g46aaCseLHU4Mwp/TaNHFPp6GpaozNG23G2cqqDXGD3tS5LLPUSxoB8hrKfvypv
         rEwLnLF6pm0DnJdXyGCR0Stgm3hHzNLszAr0cr2xJ+IOIj7Y6t0DnK19cnzPeAnIBdN1
         4h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270895; x=1753875695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
        b=O1CeETvMwjRUhJRFcmXe7yLand0JuHWBNKsOx+sVflEBi3PnasznVQQFoq+hnRjF18
         IFRxpvQwgHjTQg3l3Q2zP431aAEdgz23MB7HKuUoHMyaZv0CbSdYD2/LVPhPl1DKjEGd
         XzYPX6RIxD1hxWqpu87ddXg6GdPFVBTNVW/W6oIs/9R4+pEvi7ZB4uq2JHvIY0P8rbbw
         gYUeQ/FeqDBKfNzzZfZHhFX9DauYqWeJ96yqdDoskyS2L+IMIhJrjLuLKaSUvKJAEIYH
         00LhpqHMwrCDEhJhE5SH7jTbmuPbh4tNIJOI4R3skCEWbmubzsvkSkh6/4xPMeUATTme
         fsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZpLvn+w/M1gOlARIH8nFczu/tjUaJdGxqLcLJAM7VnN/LS1adR33H+bpO8rHu9VRlz8k7Vcs1kwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEdxo0PesmJMrrE2t4xCOw4RK+mS89lSQjPYaU3pdInqiGWo+
	C/16N+aZ+WGIAeDlsVcxf60Zlb6sglj4G8MZKL6ADS+wsfPmDVQWm2WKZ+oX7FMf8zbMD5gvKrI
	F4HyzVUqLcAw4JHEvBk4HZyc7VnT58bYXhpdzhXzDgg==
X-Gm-Gg: ASbGncuXtdE5TL9bjnOlCsnPtr4hXhANXyY6kjLpPfCgSYkJWi+76dx7UBTpvxZa92+
	ojShdw+W9A+avok79L91J3tUah9DRg+Vn1L0ZnAuyBcs/QZxrHAdSy43iGQRHZFXsVijgNyK1wx
	CKqusBcT8Sw1OEPuzatd6/1gheGkQ7JAiE4Uzy5VfXQDlJ6NzK9KZjmXsftx2qPjVZnfdNu+0zC
	2gb7w4=
X-Google-Smtp-Source: AGHT+IGWcKhCVXkg1msIEVmGS/ymhKW5BdJC9jUDzoeyLepuP7cjRQ71PwnfgzcSt8CZwmzRfOwOfwnqwnX6XBuUIMo=
X-Received: by 2002:a05:690c:3347:b0:70e:1874:b914 with SMTP id
 00721157ae682-719b4133d40mr34871357b3.9.1753270895185; Wed, 23 Jul 2025
 04:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720022129.437094-1-yury.norov@gmail.com>
In-Reply-To: <20250720022129.437094-1-yury.norov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:41:21 +0200
X-Gm-Features: Ac12FXy4Emm7GHQ8mjHs2JHTJya8z2HMRXPPehvvRCGdC2DlowB6xUhZ-7S2d3A
Message-ID: <CACRpkdYuXuTx_JG_7Zd666v_5Axv2jWV9OYJO15DQEZ8AkftQg@mail.gmail.com>
Subject: Re: [PATCH] ste_dma40: simplify d40_handle_interrupt()
To: Yury Norov <yury.norov@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 4:21=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:

> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>
> Use for_each_set_bit() iterator and drop housekeeping code.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Neat, looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

