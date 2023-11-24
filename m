Return-Path: <dmaengine+bounces-223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8587F752C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2812817D2
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D38128DDA;
	Fri, 24 Nov 2023 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMMXuX3r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33728DD4;
	Fri, 24 Nov 2023 13:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20953C433CA;
	Fri, 24 Nov 2023 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832768;
	bh=OxPdX1D49J4pS6uUVVoVupQV69O05wbnXnjZfPVmrN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pMMXuX3rxCt1aOpK7pkVyWhmOptJlp+1aBC/1VjS8cJDzAmBSol3SYNEw/7Ea18+o
	 SIjTYjMkDHBBOcwCST12EApvPlcKY24pbZiEc3QyJp8a9JyrjPXL8s4dtTobMd/Oxf
	 akG7oZp/6raKjFLrgKwA1UmCAl3UjkXEyTYpnFUurAGA39cMo2xhCZ9FAJb+JXBpDM
	 /yXKmyoAgA+oPcWm1nI0kFDJsFx32naFpvBvhyX4Qn746bRL0uU2m77pHqW4+wRnCa
	 jNbCwO+hUvVdkXVTmbbJ5sGyOnWDOqqGZ3WIE/li+i1ChDQstn8kYh+QTs+OnfZltC
	 jnP6ewlqCYMPw==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@nxp.com, Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
References: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
Subject: Re: [PATCH v2 0/2] Fix two exceptions after the introduction of
 edma v3
Message-Id: <170083276674.771401.18274352641814833239.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:02:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 14 Nov 2023 06:57:11 +0800, Xiaolei Wang wrote:
> In the v2 version, I updated the commit that introduced these two issues.
> 
> Xiaolei Wang (2):
>   dmaengine: fsl-edma: Do not suspend and resume the masked dma channel
>     when the system is sleeping
>   dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
> 
> [...]

Applied, thanks!

[1/2] dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping
      commit: 2838a897654c4810153cc51646414ffa54fd23b0
[2/2] dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
      commit: 3448397a47c08c291c3fccb7ac5f0f429fd547e0

Best regards,
-- 
~Vinod



