Return-Path: <dmaengine+bounces-4029-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A69F77F4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A81162412
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B21FC0F7;
	Thu, 19 Dec 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUEPwfRT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E2149DF4
	for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599274; cv=none; b=ErNd/EHihMAAef7oS7dtN3Ugx55niGaVNi5DHpKLgucFZWoWIsilqxNKqnPru0uZiziIuZ5ZWjEhpu3fZfsfeH5i6LMtuc7tgt+ndFpk8N+ng09Ryia+p6EA3GHTlFohWQpb/aZ3+oMVrmuz6oeH/hVUU5Sd2QiF+ZNvRFQdd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599274; c=relaxed/simple;
	bh=0y2kM214vZcjhFqe4afPZIIydMUdGqqvllBo/6aKdpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkThO9a9edG3h1Pl59NtiF4NufO23NsppfUJ3EghxuDhPl+1xAeuZQ0RIGlcEPZE45AOp7bZSi5rtUl+BCfySVg6uowIf+1re82azD48nkyTEEaXVYvd7YwGhnRsVyu/atKAEusso2ZBb6juHX0TmTfB5U6l+XsX6nBN/aCk6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUEPwfRT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so835433a12.0
        for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734599270; x=1735204070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie5k7Pqtfx2bYGTVzB4dEQo9rfq1uwmFEWeYiRCy1Yw=;
        b=pUEPwfRTGsiZQoOr+UqtC3whOX3lpdynnLvXFb6dItsC5FgIDZbgM/dhDUU+/pWfso
         3O1FVzMtNBPStfY92qBZQPee1Ht1qdR6y/xPBxwzgDdHx2xTUHLhRST+76VZHFEycBCG
         nj41czVLTVz/OOyWKVln6ZbDxXA5PIA3i/eU+3AdpSLI95Ew0e2cYcBRl8Njy4z1ddHO
         EVzhIYeoqpiIecVkVycxtsC6Bo4NIzpW4T7x+v0VCd6LyVpJw73AXLgDPFDiT5UOW3uQ
         BeFFycMoIGomEuBo4o/NM7al+GLmW0Hi72LhK7lLoD4GzQswYgC+T58+t3IIqom9rLCS
         1o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734599270; x=1735204070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie5k7Pqtfx2bYGTVzB4dEQo9rfq1uwmFEWeYiRCy1Yw=;
        b=sbcNjOV8XEcpOhLh0V/XKCsj1GKOSg4N5xI7h4BLpPXOrG0JQ/At7XPnMtpeZBZ1rh
         QZ7tbNp5/pFFN6cR4InrnZfuXwkyig72pI6YzNdyfE9O39ynPZzCymWdvEGxXjR+l9re
         OGLlKcictU9u9uKpiGo96Kayb0yCgPT8ZTFk2sxNR9Lze9OJdHpnhcO9iy4XeE89giTg
         fMz029Q4FHRAL3nHTeuUy+rPP3cg0qrnvlM+Mo+xbJFfDtk4Pwl45xJpuU/QL4hlCHuZ
         OPqhvMoYmqz8x+PTMx+0vp41WTHoF3aEj8la8YRUrNKRfxCbid76qBoljNIfmgnCXx1h
         ZM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvYWur4PuBgZgpRrfNcKfpE6oHlBO37YU+WHnvvgQaYjn2OjfB/x1uolOyxo0fjujXyJ9u9VYSmAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9J/cUvUlVbBVwcJnL10ty75GxHqaOPiwTBHj+pFMfVZrq6m4i
	MLOUYM3PTZsg/tcqVfOmUYLUFCG7Z7bOWXiGVdA4+FAEBSzJzG5+0GMAkTQhk0g=
X-Gm-Gg: ASbGncuu4nko6cTDhiyoimij8kQ92dseSu8+xs6H+IjsUwpC1oO4po1EZoW0aau/0Uw
	uYxsgbdqlvEfCLDKTUg3oXFSQKfzQwkldR89OVT/Aq8J08yrWuyGgHu2RRW7yBpYlKuBF4qKSzH
	nEANNqWkWhMNc40T+1SGALROfC8qstYVa1WrDtqgL18mCmWC+ioC8dw+o8Z68MQ5U7KSHX1DyZj
	xVE4xqxkUaY79XsAKHHWrwBsWHdT5uQaTqWbBra3xIaPCkQ6ULnqj/Pv+iIUQ==
X-Google-Smtp-Source: AGHT+IHJu/uwFHdSXv0Y84FLMZbH3yGx9h7cUBwzbp7Ad88FvC4jrP3S9hBuPbIq5BT+zLPRasV9lg==
X-Received: by 2002:a05:6402:4304:b0:5d6:37e5:792a with SMTP id 4fb4d7f45d1cf-5d7ee3771e1mr5138669a12.2.1734599270337;
        Thu, 19 Dec 2024 01:07:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f9acsm432187a12.31.2024.12.19.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 01:07:49 -0800 (PST)
Date: Thu, 19 Dec 2024 12:07:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: ti: edma: fix OF node reference leaks
 in edma_driver
Message-ID: <9e9381f3-03e4-4aea-949a-fdfc2e503b45@stanley.mountain>
References: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241219020507.1983124-3-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219020507.1983124-3-joe@pf.is.s.u-tokyo.ac.jp>

On Thu, Dec 19, 2024 at 11:05:07AM +0900, Joe Hattori wrote:
> The .probe() of edma_driver calls of_parse_phandle_with_fixed_args() but
> does not release the obtained OF nodes. Thus add a of_node_put() call.
> 
> This bug was found by an experimental verification tool that I am
> developing.
> 
> Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


