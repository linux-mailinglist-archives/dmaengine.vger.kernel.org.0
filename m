Return-Path: <dmaengine+bounces-3628-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B39B2F19
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 12:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE421C2164C
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FF1D86ED;
	Mon, 28 Oct 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlBi5E3o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8821D63F9
	for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115872; cv=none; b=CoF5nr8N8qua0jwajda5PeOHggox9naUFiiD/lGRaRw0jT+sorMYmZYZtDMV5NYskap6m+1ZF2bKMqB7lh81CioPjrkDDYqAYxTqoe35HL7nqCUOOgjlvGY+T8KjsZ7VoY4ybFuDv5FGlIgWlQyW+XYeoC9+zhB70nbONw0cQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115872; c=relaxed/simple;
	bh=v3yjuR/if/Qk08YvHm7Za9TOJuneF2XX7j+JN5TSp+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdRAc55i5KGgae38iqIw8M4Mlw2xE2IrFUE7NfDNZ5CYVyJSysT54I+DQZnoK8zyhOOSgJ/fAKo+AOvqvaj2ySkqvBXSjdKo1nIkhQ7PlSt70XVRju795QtFc2eRvcTc3bbSBnlYfKF7SGbPjaV8hGzVaYNsy2E6uojdA43lfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlBi5E3o; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea02c39211so909077b3.2
        for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2024 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115870; x=1730720670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w67vg9M/PUfllFizpdXiSM7HQlThvR5jg0fvSeOpX5U=;
        b=rlBi5E3o8u6RF9xXcM4Z/PtRZdaq6cPNZhPayq1E2gt/1SBrbUzkzRoVDp3HmUkQe9
         vBSDU1dflKbs5F7uE83P3kQBgD3gCmemVfpeF2QA0n8DObk8UAcNMuckD5hUNIsz7B/B
         8sEOyuGs00Cku/0OePjAwlu2DI2lFoTYF6SkiyjEGFxvRLM4aJOHD/ZRnNuSjOvx4D6Z
         C1stew0KywHJnQFMXouD83txW8tqiFxBvNKGjmeSy3t+BX7TLEwPGJZDt61/wBUg0cOp
         42YDZ1HSs97BAeFaCZ0tXvzJeVgZnW9fuzpR6LWJDkSV7Y0naOWaJ3ZUv083naGlTfPv
         OOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115870; x=1730720670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w67vg9M/PUfllFizpdXiSM7HQlThvR5jg0fvSeOpX5U=;
        b=gNkC5hO+KusJOKjKCxKSYsSg1SMG3/IVVf7NkjKW5HUov8jcMbzBp+bHmOAABjSIjb
         iJkh8TNe7E8xY175PJ57K+9u4wyYwFuLVH4jFhBnTa+HnCNFxiUG5O/nIKMHJBRDXDSp
         GGHEk9foRddQfOjh5U0tR0T+I5Vtqn0jcv+9JPtKGfPzyJrjYptUWw/GTfnkkB2af5LP
         1MTfhnDy8RAJNsrR/BMTz+ZSTvhDt1u7GAIYnGq9t9FHKYmNA6pdjOg48SvDlakUpnLl
         twiGRVZhKMIkXl+0ebGRJT4gdOy0dnzUZEuB2b5arG7a3zqUGZHIum+waJq1QIBr9iRA
         8/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1SGHg7mQHR5PuQ4B5vB9NWvgsW36dvQPu0XHCXp5WN2z0JWjqBJPmSJowo2AyYEXA/m+C4KdOKUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7VwWEos4YkOH7Cr4p75Fh8R8Ra1hbLxvaSnpMzcZV7H/qDew
	uV6EHBHrCFiYpNQyY81GiOzJPEZmNgUKQLtnpQ+MTwO0Sx7QUsrMRF5ycnIw056054IirC109Si
	N9eIpDNr0sFBq2QwZgE8iwSQQnpIMNRSiBxtKlQ==
X-Google-Smtp-Source: AGHT+IF26G/KW53BnVmsufrZN4oEUN/Y3tFfc1+XSv54Nwo/CrFvFba9ljoAEAfzBRZISL4FpyAIkN8L5k8Ymwv2dPg=
X-Received: by 2002:a05:690c:46c6:b0:6e5:a431:af41 with SMTP id
 00721157ae682-6e9d8ad6cf4mr74632897b3.38.1730115869914; Mon, 28 Oct 2024
 04:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025103621.4780-1-wahrenst@gmx.net> <20241025103621.4780-4-wahrenst@gmx.net>
In-Reply-To: <20241025103621.4780-4-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:43:54 +0100
Message-ID: <CAPDyKFr7mJPWPkTrtB9ORdQw0TtBDKM=B9g6QsKvUHRx1zDNxQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/9] mmc: bcm2835: Fix type of current clock speed
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>, 
	"Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 12:36, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The type of mmc_ios.clock is unsigned int, so the cached value
> should be of the same type.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 35d8fdea668b..3d3eda5a337c 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -150,7 +150,7 @@ struct bcm2835_host {
>
>         struct platform_device  *pdev;
>
> -       int                     clock;          /* Current clock speed */
> +       unsigned int            clock;          /* Current clock speed */
>         unsigned int            max_clk;        /* Max possible freq */
>         struct work_struct      dma_work;
>         struct delayed_work     timeout_work;   /* Timer for timeouts */
> --
> 2.34.1
>

