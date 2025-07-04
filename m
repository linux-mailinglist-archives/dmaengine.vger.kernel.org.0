Return-Path: <dmaengine+bounces-5741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C110AF8C7B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B913A52FC
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171042874E5;
	Fri,  4 Jul 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iW9lnZtw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3C28A3FA
	for <dmaengine@vger.kernel.org>; Fri,  4 Jul 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618481; cv=none; b=DxgnCXWVJHdPTOmx/qFuLgm5w/ZqZrV1agiELIEZi248qxYxUCdU35QXsnvGKgV2Am24Q58ISAdoOOT/tmUWjEs+pptrpbtxWOTDzHxCepkgQ6z9kHfeX/pQLCQ7VM4TDaV9rNcYwcYwT48N7co32XFX4CzPNq/P+dyByPw7i/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618481; c=relaxed/simple;
	bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyB6Nl5jpAm7KsikGwsiWn4SWB3AvwTd6w+fkULJPh8WNREPM81z/jKvvTiEu5R1U/PgXGDPMJ+/b97Ggcw9X8c044asK3j2r2bHAvB2fdJ9huwFANlOfPpv0Y+R7YCwOug5lA2zlcfoec4a6ILgqo53giiQYAG6qwLkNPsYEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iW9lnZtw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b435ef653so6528021fa.2
        for <dmaengine@vger.kernel.org>; Fri, 04 Jul 2025 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751618477; x=1752223277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=iW9lnZtwbzGhGmL6SK9Hwys4mO0RiShoGm7jSVjmc8/RygwBrfE7D+/cQ0ZUJqyo6W
         zLy25VY3nMnMT0hRksNaIEVv1I9SDshz+aIER2GUdHUHUBGmFxSbmSHnf+awm/ubCVz0
         60JNz/5srraSEaZ+AZNf/9CJ14z7oEAX1eJhg2RgEqhVCjsAkg8hL1EzXi0ioTjLwXQ8
         buTNc+3OqibXfPx5A5Q/ltfDnWypL6n+4DMHkPhLlWfegtPPcQvnw/1+v3rFv8nlCsEU
         lkR+dg/XYOm8S0N3XtH+ouSmoxB3IV5UC9M80Ru9B0NioJnv9lAWAN9Ui8yKdh99jXLS
         xQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618477; x=1752223277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=d7UezvOEPwKu15Sz2UGuKE4Bh4pcj4uhMm6m6DnU1dJNgsF1LbI4sSHT3CdEahUSDI
         iaH3PTxPZh6cjx92cIhfOoeZLEj1jG1Q1JH4v1sNw48eyzQ7gM0KRulZwaexh/IqsdwK
         UjznGMc7pMjH7CuS+GMWwwnUUagbnLxISGxCn7DrThI3GWfSgs18I9F0bXe58t5zog1u
         Ua2OrmuFawTTFDDRuzaJorPcMPNcGsiY5D6f6McVelbugS9xe0rWX6m4eU30irhMwmGH
         jJk0EFl+bx8ZpAt9O6j+NalLqbldfmxwoFpg1AKUCfdTERlwqBH7X9sMQYF59HvLvC36
         MA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTPyNh6dN1ry1Y22UW6BHudwVsVlcW8bNiAj32BvMHBO/76VniJbWtycYxy61Gk97Vl3kDcE5I8tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJO4gIeCBEKAEPw2SPHJLb3H1Z+dUiDdL9jPA2N0ksUJyeFWE
	0DvWQAz7O4cRh3jg0u5uRg9eMY2fQOzmgOXlteGrOXQ3bMwgpQwhL789Gluzhq9hrZEwPOjLW8x
	GY+wRCa0YHyo9Xn9f4TUcwROao4BylySvTP7xM9QbOQ==
X-Gm-Gg: ASbGncuJIUhPlubJ4ZYBhhVUTc6pEPGHFrzF+HINaUecEFk3aHetu4AoYTQwHbEvrZO
	HFTF03UdB2YK31JVVw7KloeQvkqlBVUA6RzgZ78R8/HXLkvsKxrbXmJUBymfOqctLRaokQOMF7b
	YoiDPUdnGY+sE7Ijkflytb7o+BYcFH+ddE5n1FkRONpXY=
X-Google-Smtp-Source: AGHT+IEjkMzfSLOYZgYGu/gC0rhugH3gtKCbGLeh9K4QRq1fR9qFAffWdxMFTkqp/Cs4KgSwpWDdcpA+BKTigHt31n0=
X-Received: by 2002:a05:651c:410e:b0:30b:d656:1485 with SMTP id
 38308e7fff4ca-32e5f61b6d5mr3915861fa.32.1751618477177; Fri, 04 Jul 2025
 01:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075405.3217535-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075405.3217535-1-sakari.ailus@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:41:06 +0200
X-Gm-Features: Ac12FXwSUe6_z6ImTsHNK6iIJFxrmJR6h51CXwInuWFdU4SXV4TvNlJsJxqlUJg
Message-ID: <CACRpkdZQGFEXU8iYreW1XHC6jbPB0v4JrqKAe5JDrOmD63hjgw@mail.gmail.com>
Subject: Re: [PATCH 12/80] dmaengine: ste_dma40: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 9:54=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

