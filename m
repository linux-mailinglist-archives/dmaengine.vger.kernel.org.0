Return-Path: <dmaengine+bounces-617-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8D81BC06
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B791C239A7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163541C8C;
	Thu, 21 Dec 2023 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp5e5FmG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1B539E1;
	Thu, 21 Dec 2023 16:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF84FC433C9;
	Thu, 21 Dec 2023 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176207;
	bh=83451ZJNa2oE8B4jg2S6tz3gXgTpBh6IzXZ1MYdeve4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fp5e5FmG/k6dg01M2cMcPX7q3Nm5Vg1C5X12e8JJ8X2Y97CXJsnGaRot/UWYNz9Qx
	 e93q75aswpuTqQiz50c1MeTCq8AvzQFtAhkI2gCXlxU0LdaLDw3wlGT2Fh8ps6fKT7
	 LDyumijcqHh6kLWPmd0e9teJHQ6+GEXIZzyKDBwouVWEDP4isR53ctFvssj/3uUlSD
	 2qrlNvwcdwBFaOmfCqOJkHjH6fR9ZFWGIwwIGb/jds9579XjCjzSXQ2H+fgT9JmCkE
	 CcLrNtOZNRcXF1kv/RiUnFsV5uhPUFcoZlvaIoN/LKUziZY/ADDi8hqR+fv7iWMOAH
	 ovymRRc85B4zQ==
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231215131313.23840-1-paul@crapouillou.net>
References: <20231215131313.23840-1-paul@crapouillou.net>
Subject: Re: [PATCH v2 0/5] axi-dmac: Add support for scatter-gather
Message-Id: <170317620531.683420.14062668423937258500.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 15 Dec 2023 14:13:08 +0100, Paul Cercueil wrote:
> V2 of my patchset which introduces scatter-gather transfers support to
> the axi-dmac driver.
> 
> I updated patch [1/5] with your feedback. Patch [4/5] was updated as
> well, so that cyclic transfers are restarted properly in the EOT. This
> was a bug in my V1, but it was fixed here just for bisectability, as the
> new patch [5/5] will improve cyclic transfers by linking the last
> descriptor to the first one in a SG chain, which means that the EOT IRQ
> only needs to call the callback associated with the cyclic transfer, and
> the EOT IRQ can be masked if there is no callback associated with it.
> 
> [...]

Applied, thanks!

[1/5] dmaengine: axi-dmac: Small code cleanup
      commit: a2ab7045389feab1c26ebab105a8ad6bce74a4a7
[2/5] dmaengine: axi-dmac: Allocate hardware descriptors
      commit: 3f8fd25936ee5f52596f10d420f650c5b5e3285f
[3/5] dmaengine: axi-dmac: Add support for scatter-gather transfers
      commit: e97dc7435972d28ac7d96d199d4aedb868d04fd8
[4/5] dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather
      commit: 238f68a08e19a612b8912c8697901e9982f97811
[5/5] dmaengine: axi-dmac: Improve cyclic DMA transfers in SG mode
      commit: f60dfe0c561a8f1b8e30d3770997cbaa636f57f9

Best regards,
-- 
~Vinod



