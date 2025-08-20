Return-Path: <dmaengine+bounces-6084-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB5B2E41C
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F075A3F4C
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031E25BF18;
	Wed, 20 Aug 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqooQauY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146A247295;
	Wed, 20 Aug 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711560; cv=none; b=GZubX7gvj4K2YEekhUK5ayJjdHM+uOmJNb9zz7xPr0EilFDBDH3zxwY78MYdAUKO3Vswmj6YpDls1yqk66/Flk+kyAmsOmXroEHwxI2t6LUlL7S7976pcaUoOlNxfk2Dw8bgILNhoOHzOVlx8xghFoRrLe2X4lBAAgBDyABEimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711560; c=relaxed/simple;
	bh=EAfJm25eGSujztbJn7BQ2M+SczHpmn8LPSfP0jK8Ep0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=swK2G3CgsgrsWbBek5/2opMJvneDSsamsgznssNMAb0olmwWfi0cKuJhZZoyCJuWSJ8aSrFbpwmjZfgGJ736xhmjCxTgD+qHpjNBcdBpOXj4cpPIDH97lZiKCr4vYUs89Gat8bW7qaEiJvBVUn1G85egLX8lDAnAY5yoJtk8nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqooQauY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20445C113D0;
	Wed, 20 Aug 2025 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711558;
	bh=EAfJm25eGSujztbJn7BQ2M+SczHpmn8LPSfP0jK8Ep0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jqooQauYHYQZQa8pmYX6HGG2IGlx2gKYeq69wr2WEw9RqzAcgp52vCAuvMTuqsWBT
	 11SBxhGWya0jhhNiiw1Xgw1uBPChDVW+A7EwkIbbWQUm6K+6lzOXAIzaWJtQBDZJEb
	 eJDs8HBl1NHQvkA7T3H+Y1XsBJtlJVB+xqkYCWA+1fJBWNUSoLGqVjo1Tek1Vrw8qV
	 zhrTltP/SfgW2nuswBDlX9kKCJDODlfi5+Cb6DtTm3pEXuE6s8O6mTfZmXEr/pBFSV
	 mnCPu5h898pZjsGbWaWCWBuifRYELFowA5uvCudWi1hfv5Kru6dQBonfUZDaPx6Poo
	 E0kCmCCgVzj8Q==
From: Vinod Koul <vkoul@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aJnJW3iYTDDCj9sk@stanley.mountain>
References: <aJnJW3iYTDDCj9sk@stanley.mountain>
Subject: Re: [PATCH] dmaengine: idxd: Fix double free in idxd_setup_wqs()
Message-Id: <175571155469.80631.13707540161368362564.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:09:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 11 Aug 2025 13:43:39 +0300, Dan Carpenter wrote:
> The clean up in idxd_setup_wqs() has had a couple bugs because the error
> handling is a bit subtle.  It's simpler to just re-write it in a cleaner
> way.  The issues here are:
> 
> 1) If "idxd->max_wqs" is <= 0 then we call put_device(conf_dev) when
>    "conf_dev" hasn't been initialized.
> 2) If kzalloc_node() fails then again "conf_dev" is invalid.  It's
>    either uninitialized or it points to the "conf_dev" from the
>    previous iteration so it leads to a double free.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Fix double free in idxd_setup_wqs()
      commit: 39aaa337449e71a41d4813be0226a722827ba606

Best regards,
-- 
~Vinod



