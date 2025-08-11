Return-Path: <dmaengine+bounces-5978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C544DB20505
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBB84211FD
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5C226CF4;
	Mon, 11 Aug 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5dC8xkT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D91F4180
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907385; cv=none; b=Vr2KmpkK1rH4zM6PsJu+7V99uO0lU8/mrF7VFhkAhiz3I1is0RgnmG7uELzHnCcArcwLuphhRsM7xnzzeQunm2zjwC4wcqeZZc6YeAMJt7iUVnvGHEbO4fZqpD1gAxZcmtV0j+hjdBPOetGbNRjKEuZEbCDnkyz1jaSgASx0cO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907385; c=relaxed/simple;
	bh=lhpccEjV4JvXC3iJXVnLG/g4BG5pKPBfPXPY7b7oLTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrkPFsWJzu4wpUqSV5DHMwqFaP+/pHSL9m8wSQ1q6dyvQ+gxWnu0MJupo0shJ/kFvr4eU5x30Arrf0KPgj+s306p5uUSJ1RQtNTObKsypyZcsHCYja8Z31w5s6AIYKcfoWqvLFnve+riAmaAx1pcABUehh6unltqAHQLzChjDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5dC8xkT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b7886bee77so3153802f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754907382; x=1755512182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSpiiISpNVr4gQnCfkPUN2zjFrHk7VxPQMyKo4/lvmI=;
        b=D5dC8xkTcp3nFS538JH/hhv3krHlFCGwSBKAPtiByLb0kp+h8+Ll+BSqGkQbb0kEhu
         N9DpzYFtK94ABxbbbVGGw+jYDO2zgDpZhyA38ocwDE9mqk6PNoC6DOZ8SLnIu8U3MVfq
         kDb/qP7Y1SiPm581VJypfLvf07WKiqVafH5qjDTh50jZAqo0JGsidTpWi72V58sPlIjv
         dWUkjqUnQI8dGD2nFNYinpn28TfrvR/QRwlEq2ZQ2dt0ywi/eax/Pe6W1HyyIKYIGGy3
         crHLykKA6MfN7NCckrcv/M+B/HjsIGOP8nFtDGXqtS37k2o8mhyz2MSjp1C7qoq6tOig
         d4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907382; x=1755512182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSpiiISpNVr4gQnCfkPUN2zjFrHk7VxPQMyKo4/lvmI=;
        b=b3h1+Bxgxh4dmgT6yvSHekXroRHkR7WP5cZf8eIHZy0dV8rq8NXkj3uH2eikm9Oqdr
         /Jnz1Ie0IssWqgs6/bscEVkQrMxvfoue4YMjpjhdN+pelSn7/wcTgRurmgzOsL4ZCYNB
         Dx25t+Qd41Un2uXfrzIortayQGQe0Gz/uqmcDZwfGdqrHgXw43/m4maa+JwsuoJ4Jq5O
         cDsUqiloWGRq7SscF4Zc19T3G4BjLCelU7yxAJiITcPj/IWA6+NSL1UjqHCb5LsioTpN
         GikajWIOW6Y0Vn58KwvzkMgDUWOaCaRr9vnIy5Ah+HtEUkgtW1bD49wCACv8FLtQBSHW
         FhFg==
X-Forwarded-Encrypted: i=1; AJvYcCVok1yF0Qe35OfnaQioC04wj/lHOIqolRLH+82XeN6jtiVpiYsGGvkuQCxNpG2GoKY1rGii/lB1Sag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA60vKQjRDrbjLMDBIEvQQl106WOzwf9VzMOWZ0tEP7X5EJsom
	5tY5yxFpJsK+DD9H0oLemvBNHIoBsbmmRLLEz2Wc/f3i8nppIogBZ18LCEC6eeVXeXo=
X-Gm-Gg: ASbGnctGoswlDp9jSSTKd4pXXnTE96KUtmU0+kgwRHmC947x4wzBQh235ZKdC2JsFRl
	bkRFdrISiDnzj+chixyyf+o2nJDk/55uftNYuoRSF+a219oIW5L8BjkC43NB3hAz6Gc+20g17O2
	HA2B5Q5iqMKlau9vcGOF2jZ48EJ31+UWNlin3u36/SLmm0IQbGjQ5TqO/2/yDTSCIMUkiCVYVCR
	VAJQuir+rFdjPxi490UeZEZbKRasFB6EiSzQaSjqre1FqMexBIRCtu0AJa9k1V+MLbEcLoBxTYr
	IV6qOXSVfwjbsYCAK5nlxpiq7CPZIlHBJ2R1JmF4O6Y+BGzAS+7SILVSoGBv0J3nl5PiYnhlVrG
	ZVFhigTHqNi7Kbcc8QNKoPDRMgO8WBnDq
X-Google-Smtp-Source: AGHT+IG9ux2smHHV5RyT3jUtDRzIFajNvscvOmDcbzXkqY+4Xp89HRJqljXFsBnzKFxpMyuKABzgxQ==
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr9878088f8f.31.1754907381530;
        Mon, 11 Aug 2025 03:16:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b8aab8c0sm382668595e9.19.2025.08.11.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:16:21 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:16:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized
 pointer conf_dev
Message-ID: <aJnC8CLkQLnY-ZPr@stanley.mountain>
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811095836.1642093-1-colin.i.king@gmail.com>

On Mon, Aug 11, 2025 at 10:58:36AM +0100, Colin Ian King wrote:
> Currently if the allocation for wq fails on the initial iteration in
> the setup loop the error exit path to err will call put_device on
> an uninitialized pointer conf_dev. Fix this by initializing conf_dev
> to NULL, note that put_device will ignore a NULL device pointer so no
> null pointer dereference issues occur on this call.
> 
> Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

No.  This isn't the right fix.  I basically wrote out the correct fix
in my bug report:
https://lore.kernel.org/all/aDQt3_rZjX-VuHJW@stanley.mountain/
Shuai Xue sent a fix as well but that patch wasn't right either but I
didn't review it until now.

It's easiest if I send the fix and give you Reported-by credit.

regards,
dan carpenter


