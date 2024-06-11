Return-Path: <dmaengine+bounces-2352-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECEC9043AD
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA70B28A99B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332E156881;
	Tue, 11 Jun 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDdPztC5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110B156872;
	Tue, 11 Jun 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130514; cv=none; b=fwqcDf2JDcTswo9sR262JQ1mVGDFaG26DZT7RcaLyg1D7YLnKKted9mVDj7V+tUogyxUx4PLavT+OsqBtGZySbGGuOEK0TJGaa4lbtRTsQJGFriCI1t5ywp1OTrqVBbP+NSid+Zc6GyzAahnJR8X2ADPfTUZvSIPgtPZL51RHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130514; c=relaxed/simple;
	bh=j3EYgUxpMjgfmmR2THkxXKYiD0+fISTsMnZ5sXS6YPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QCBRmt9DP+x4lv6HkqmZcITLVx78Ig5/K89bgjsj7hPWJJkXpELB6H4rsE/X8HxlKHAy9Q6xXEnEt/gUQut3w+Y/rTGBV+ZapM62AhRuKWJ4SAc7PFOaS6PGSqnFNKr2luDTQYHMu9Dzu8TWXp2FtuXSszGm+DvhKALe18AOb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDdPztC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47895C2BD10;
	Tue, 11 Jun 2024 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130514;
	bh=j3EYgUxpMjgfmmR2THkxXKYiD0+fISTsMnZ5sXS6YPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mDdPztC5Q9KtE1SqqHauRE3BQg2MM2rrMDU4tC68RRnWORRZsLKH+2pPXe/3i47qv
	 56gI+s0U7nydon6CMJ2CYkFL08lmCDdO6C0io/g2ci5JOG+rqoqAW1CIERXEtYzUci
	 TcwQCAWNi9dXnRmGFecR88Dhl2PxtZ/nHm4Tg99Zio4suBuTDOjOI1xJH3vTzWcsxz
	 H+XoPVH/a1BGzTs1bNDNgwKreBDeFJSG+KyxgnFsulF+EGaU7fWIR00FRTuDOodGYz
	 nlfY/Jmg7bqfOlxVC8de7kuER5aLoKH7xjOH0IirfnvoGKRHU0IEzIamI2q7qULW6S
	 HiKBknUNLassA==
From: Vinod Koul <vkoul@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <8be473eb-65e0-42b4-b574-e61c3a7f62d8@moroto.mountain>
References: <8be473eb-65e0-42b4-b574-e61c3a7f62d8@moroto.mountain>
Subject: Re: [PATCH] dmaengine: qcom: gpi: clean up the IRQ disable/enable
 in gpi_reset_chan()
Message-Id: <171813051191.475662.11143295801968577894.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:31 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 09 May 2024 14:02:11 +0300, Dan Carpenter wrote:
> The calls write_lock/unlock_irq() disables and re-enables the IRQs.
> Calling spin_lock_irqsave() and spin_lock_restore() when the IRQs are
> already disabled doesn't do anything and just makes the code confusing.
> 
> 

Applied, thanks!

[1/1] dmaengine: qcom: gpi: clean up the IRQ disable/enable in gpi_reset_chan()
      commit: f8f530ba429a334fe1a28714787f8a98e90777ec

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


