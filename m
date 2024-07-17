Return-Path: <dmaengine+bounces-2714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3020933C4E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA322830F9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38217F393;
	Wed, 17 Jul 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptGh7WWU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5A12E48
	for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215869; cv=none; b=l9GPjGhKtAIxNobf6BZvmlwp8nI0VnJRoQN8vuk7EhQI1gcb0c7uFX4oDybavQHvWHkrcPrKKTISTs+L1zCm0amyLeSXDungyLOXXl+guIKohlsMnI7QQ60hzcHmxNiC9V1eKPQuGBb2QWDFTlqiVZPZW4+saopgfILuhfgNbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215869; c=relaxed/simple;
	bh=j/YRQeImIPhUV+MS4tTrxYdWgyGt1EoYQBbNU/W/Bbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSAbh5JeVplQfhh8sJC2+iTfgiOrjB/3FIHZ0kXHexRvYGqkmVZ2+iR1efBs5zTtmdNh0nwl61Bf5YZoPcFQhhmYeRoHfSY2OPyLWYN5/7xj5HPXD1Ex7QdgpR57n4gIy01Mzo5K8xil154+wGAmYZ0HSIyFMvQaEDtZ7YY0T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptGh7WWU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65fc94099a6so39798087b3.1
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721215866; x=1721820666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TjcbV6PRhjkqouO1Kr6u0vYUOeQPkLeQL8bm2L2+2n4=;
        b=ptGh7WWUHmj90IJx0LwL0g0OhsggtUc8UvVjRW5ijcn7cjlDMdzYB0mzYMv3hWABAQ
         XbKDgWBUFnBNU0JslpieEwuuMi61YADgV570z/uC11nOtb2/l/eYXrNA/Op0drjbjQQd
         +49fdyJLUyRSnDdyE1RCXooSLKeitEFT+2dLHOcekvjoFEczv4S8Avk6ldGdJZh6XlTn
         DK/HzueefrQ09gUVNqH+XlyxLsf+fZQnXmAP6HV7Ibz9w6yYe63KiJFdyFPJcIlTC26C
         PDGc5aVxNKzyZVedxIpaeb53U4MY2FRRXcJEP6C0ZjLmEwxAx/SYphKO9DIYYGLlkG0R
         rW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215866; x=1721820666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjcbV6PRhjkqouO1Kr6u0vYUOeQPkLeQL8bm2L2+2n4=;
        b=UTnucUMQDMlZD/Zo1xi745hQckzfYecYjYOAdyo8WuzwOOlW/B+AVMzPpKQPiN6Es1
         E+V9iwG/DOOPKMdgsxwAmLAmcaTm8aK1HWJuk14aEnp8DJqnOyoGzCQ1p+xqPyW6jiXw
         uK4fUEWnmtYwDej1xg+KeoN393s3UReYPmbkB7B/QQ9E120/AKRTuxgZd7zGcx8MvP48
         XlDE0F341/Um4WjL1UxJCA+IMAgl2XZqg+7Y8PfIaZRvsNheua7ifix69CSrj09HSZNV
         lAuKL8dIF3mG7MsB1kRbzfxc+xR3yEsoUwuDpBCtFONJONJuOxtO7yf6YEQ9rluO1Nhs
         XKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9azf0zwQoZd8YoHEVll4sMPa9NOyCwnNyu9tH18xsMRX1+0AlS3Igcnq0cknKrggF8B9uD5elsnCWLNiCTGYWTbsTGwPRVsZ
X-Gm-Message-State: AOJu0Yzjw+/jwOQsZ4aMlTho2jO12qU0WkVbNsS1GkctLAjT9uXzhJF6
	H8P92Mh0EL4p3DDu/2TurmYYjXL6mIQ6ZmZvGkIv4yMFBh4MmJpsdGCDeF4yMEw5ed1brFMETNK
	uOREAUSTWMAgEGncKRYXdOIjIZWZ7hLF+Tbo6eA==
X-Google-Smtp-Source: AGHT+IFe86geQlpQGKP7hmjpN4o42Eh67HJePPfk+Jd7pBA+Bpmq3c1TNuJm+qDK3OrLAQbeECL1dlE6i/C5QetSnf8=
X-Received: by 2002:a05:6902:154b:b0:e03:a939:22be with SMTP id
 3f1490d57ef6-e05ed69b9e3mr1672804276.10.1721215866554; Wed, 17 Jul 2024
 04:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717072706.1821584-1-nichen@iscas.ac.cn>
In-Reply-To: <20240717072706.1821584-1-nichen@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Jul 2024 13:30:29 +0200
Message-ID: <CAPDyKFrcGYocPKy-WB3EdB+Jx0=BztzXz1r=5y3JNTeXF84-7g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: pl330: Handle the return value of pl330_resume
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 09:29, Chen Ni <nichen@iscas.ac.cn> wrote:
>
> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.
>
> Fixes: a39cddc9e377 ("dmaengine: pl330: Drop boilerplate code for suspend/resume")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/dma/pl330.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 60c4de8dac1d..624ab4eee156 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2993,9 +2993,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       pm_runtime_force_resume(dev);
> -
> -       return ret;
> +       return pm_runtime_force_resume(dev);
>  }
>
>  static const struct dev_pm_ops pl330_pm = {
> --
> 2.25.1
>
>

