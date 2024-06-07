Return-Path: <dmaengine+bounces-2310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E5900B17
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09FD1F233F5
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B4F19ADA2;
	Fri,  7 Jun 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0xc0I85"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245219AA66;
	Fri,  7 Jun 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780554; cv=none; b=CtMjvZJpJDoGBqU5ck/F2/2bnPxcOBhNQfowejQ4wh4KLieNXoO4WToeZzrZ1F+r/RvvVreefXlmOQINBQjevsnh0kWq8Qm7RZILiMR5N0S6HO/RUwAxTyQd1Bs53YMXz+kUSpOzk6U5femqceoZN7NL7xVaALLFZ6mKMRpfWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780554; c=relaxed/simple;
	bh=3XYeD6IP8Z0vF8HLIMKW0yAmSge/3jtKexVmbtdSwsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7hBOb365SZo/CCENZIC2HUeQC2fEVqsHxNp9/c8kASa3Uvfoe/C4Aj1HPL+/AOpjdJpWkmY8mCMPo8E+tu7PxNWxiDm45a9sVlWfw/odxPSwCJ72CpcsmebkC8cRvd80FbAHvqvdIIPw26F8WU+TmsmxwVi8MPZhTmlEOem2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0xc0I85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70CDC2BBFC;
	Fri,  7 Jun 2024 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717780553;
	bh=3XYeD6IP8Z0vF8HLIMKW0yAmSge/3jtKexVmbtdSwsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0xc0I85TuSJ95cq4edqPXW9BPSXEG4M6aY7VreDWcRbE5R0JL/EtVBL8WlLwdj8Y
	 DrzI/soOlN/jYH8CS7R/6giJ5yc6TKvMAEehrhflTHJ3zol2D0QNVfqXjYd0+Q859i
	 17m74fg1luA9t/OtIyOJPOUerI+ugiF6aP6fEdLCKOJu0rbuhnSn9C1WIlBJu8npf0
	 umUwoqbGdnLOazgSyUGeeIhOsA7zYAiQ5q1xxIxHrLRrHlRFwqe73j1bFxBr/IMVZN
	 RpocuNtWHywOGCFwR8nkxbvkE3jC83RepqAM1SV7wKa0mERe8rEAlU/4hv5jATp6Gg
	 iitwqYuJ39Bcw==
Date: Fri, 7 Jun 2024 22:45:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
	Simon Horman <horms@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] dmaengine: ti: k3-udma-glue: clean up return in
 k3_udma_glue_rx_get_irq()
Message-ID: <ZmNARRlVwU6hLelB@matsya>
References: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>

On 06-06-24, 17:23, Dan Carpenter wrote:
> Currently the k3_udma_glue_rx_get_irq() function returns either negative
> error codes or zero on error.  Generally, in the kernel, zero means
> success so this be confusing and has caused bugs in the past.  Also the
> "tx" version of this function only returns negative error codes.  Let's
> clean this "rx" function so both functions match.
> 
> This patch has no effect on runtime.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

