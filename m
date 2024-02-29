Return-Path: <dmaengine+bounces-1201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7186D251
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F941C238F2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511DA7A143;
	Thu, 29 Feb 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iM5mHmPo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F7130AC1
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231425; cv=none; b=JVO18dvRX8MfwhUQ4CJO4EGFwikf+xF7Q+ALCEa1KUUO/+MSoK2VbXd9V5+lrs9edsSjxevAaRCuFnsITEqP2RKAwb4ucCMMqgO6+xSgvK5Eqkf+ANmw73nnBfqeyzfwF0rx/9IXfVE/IoT6+a3RniezDy7h2LzZf218sVR3ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231425; c=relaxed/simple;
	bh=8yy/4GV1yFJzF9sv2B95/iwZJPmwic5KkIWGzHyFdDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXajQnDeRQN8/UN5G1MotFMlIP2STEsELcpCxBP6QoGtp/MTV9RQRrQJILiv+ip6BuCM5imUGYXfsxNYNig/QffqRZklCl30gg3t2ejYc7tsmQPj1jwGSvaJyyyHSjcev1e0KoFjkf5wvxcfRu+LuopizdTHqaBvgXCuvsydfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iM5mHmPo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc09556599so11587635ad.1
        for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231422; x=1709836222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYbYLgN//LB6IKshdj2UFvVMq+97XOWcZTiyLMqD288=;
        b=iM5mHmPoziyBmXNKdfjG1EYs9RZkxqajHY0iJTm8qPwQw7XSYOaQmmExCBBqcpxL4k
         S1mlEu61ub7ABvinLlFMWO0Aet7chIuR4vUqHYZM4CGZESNe1dTYwittwTDQi0ewrRY1
         HPmeUJKQL/2H6rQa4zKQVPc1Z1ERlwwVXNLV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231422; x=1709836222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYbYLgN//LB6IKshdj2UFvVMq+97XOWcZTiyLMqD288=;
        b=HkFvJfGzuNdCDetVoF74KzNP9owNmw0iSHu4gBsIcNKMQJjPtVmLYH/dC9l8hY+k6p
         O8scO9ZbZ+DpB1tQY4q+4EGJM3P3jziCqHYAQ61YUq3qXgZxob1SXsF9ARdIq9XETrll
         Ze0MKSfz69fxJQTPhIUZXku22Otph86eaMesCEIclys78lPSZHGg8uBFJtJamvHRibaj
         7cK7DsKehqOZpxZJQK8z2h78+b4vNrPVqN3QQUQzOXk0TNw51N4uBc5wlxdzYQVUpiVm
         wPbl8F/nRd1YZCqWOyQRwQGEeqTPIhCPVwMRmhO8uBzO5Nb0Q9fxHSBBKWyxasqvILh1
         LL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzDV7K1i5G0jZ4zmhY/NxKXDs2fNExSt4G6d56APzEHW3J9umUbhoD4yLVGZjYZzjtZ3R+agSCxRi5dF+Ss0AXWTa40tOt+zwN
X-Gm-Message-State: AOJu0YwmVmNmURjyM00dplRiBau1sbWxLcy0mSOROsko74oKu1RvZvqS
	jTsc8JIb3caubtFA/9E0tlqrqCj4ZA1BUNtvjunz6j8nT9TG5eSK9/nOrKQU/g==
X-Google-Smtp-Source: AGHT+IFZ8jcrjcQAt+MQj+2B0Sj5fw+uvOzg9P3n+GwTvGaDLn2o9jX7lXUHTKfIFeYePsmaS46Yrw==
X-Received: by 2002:a17:902:d4c4:b0:1db:ea23:9ee6 with SMTP id o4-20020a170902d4c400b001dbea239ee6mr3615434plg.12.1709231421915;
        Thu, 29 Feb 2024 10:30:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b001d93a85ae13sm1803519plj.309.2024.02.29.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:30:21 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: (subset) [PATCH v4 1/8] overflow: Use POD in check_shl_overflow()
Date: Thu, 29 Feb 2024 10:30:14 -0800
Message-Id: <170923141241.775345.14051727895770192324.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 22:41:31 +0200, Andy Shevchenko wrote:
> The check_shl_overflow() uses u64 type that is defined in types.h.
> Instead of including that header, just switch to use POD type
> directly.
> 
> 

Applied to for-next/hardening, thanks!

[1/8] overflow: Use POD in check_shl_overflow()
      https://git.kernel.org/kees/c/4e55a75495b7

Take care,

-- 
Kees Cook


