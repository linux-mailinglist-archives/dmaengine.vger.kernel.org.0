Return-Path: <dmaengine+bounces-614-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A481BBFE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188071C22DDA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295D58212;
	Thu, 21 Dec 2023 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYioqI4K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FD5820C;
	Thu, 21 Dec 2023 16:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B5AC433C8;
	Thu, 21 Dec 2023 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176198;
	bh=U3RUFSniU347sPhJd99D0lKyyS41ROfCrLn86vMGlC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sYioqI4KzjldEdIHKQoqLYPjSktXwI7SSauGnyN6LLrgN+u9/ypayE+DtHrI7GHNw
	 nLeC9HB4Fo4yPNIc0NcjMT7QkV9TMcwdmb8oVS3AR6Neyq6vcYxtYhysIXAEiPRUp3
	 PL2Ak7G0Dawk2bcwmPPa3n+aurZEkpB7Ryp3HcMcmI47UGW+3cEhncfhXTGk8SbMPv
	 +nKcniO/vylvKMieP8+06payYeCi3nIQ/YKQndRFxcygThY0LZy33td9eyPpUW+9R+
	 GAPF1WkviVnz7di6a7DjzURD1PubwYC9VLyu6+OG76O+ILVFVbJ/fVe80Dk9dQJAZP
	 bmylyf3gaaOjw==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 dmaengine@vger.kernel.org
In-Reply-To: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
References: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] dmaengine: idxd: Remove usage of the deprecated
 ida_simple_xx() API
Message-Id: <170317619628.683420.9023964494393917924.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 21:59:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 19 Dec 2023 20:33:50 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. Sothis change allows one more device.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
      commit: 1075ee66a8c19bfa375b19c236fd6a22a867f138

Best regards,
-- 
~Vinod



