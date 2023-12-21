Return-Path: <dmaengine+bounces-615-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296F81BC01
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAEC1F2699B
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525059906;
	Thu, 21 Dec 2023 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVEMAgwX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382859902;
	Thu, 21 Dec 2023 16:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E9C433C7;
	Thu, 21 Dec 2023 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176201;
	bh=X0qSBvf7Mbhm4GVx+NgoSROHhDHP4ul/RH27a/ieHP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WVEMAgwXCgJyR2kjyQOg0mEcMxty6AQpfqaof6j2BxOy66KvhpWSqP9RMmVHbRaMc
	 +C+ZcJsIAXS9SfPrQ22RFek286AZ9IjuC4skdhQ/ODgE0AcNsNCRvTrT77jzmnqy0V
	 PZ8M4VC6RhXwO3iZZ5M6pdFSUxwYMVWc7o2WO0Q1tHcLKkOIncZgiAkJKNh7H6zjFU
	 D7ULZHI0MHddCGhurzuLDWxWxzywqyJKevXKHCmj5Uur2SsvFt5wXR0x2eH4tbhhcY
	 UfPGvO8XkY/T+7wYBs+sZlTJ5Lmrl5dEMyTFIiFHPxQCvSpGoEGSdaSB9DIn8tlw0K
	 cJnpWzGK2g0BQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: kernel test robot <lkp@intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
In-Reply-To: <20231218060834.19222-1-rdunlap@infradead.org>
References: <20231218060834.19222-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: std_dma40: fix kernel-doc warnings and
 spelling
Message-Id: <170317619891.683420.428561244511510954.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 21:59:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sun, 17 Dec 2023 22:08:34 -0800, Randy Dunlap wrote:
> Correct kernel-doc warnings as reported by kernel test robot:
> 
> ste_dma40.c:57: warning: Excess struct member 'dev_tx' description in 'stedma40_platform_data'
> ste_dma40.c:57: warning: Excess struct member 'dev_rx' description in 'stedma40_platform_data'
> 
> Correct spellos as reported by codespell.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: std_dma40: fix kernel-doc warnings and spelling
      commit: 71a5197e2b872afeef8ade3099ffc4050466b542

Best regards,
-- 
~Vinod



