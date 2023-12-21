Return-Path: <dmaengine+bounces-624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DE81BC17
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24FC1F26C8C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AC627FB;
	Thu, 21 Dec 2023 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0F3lHrS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202035993F;
	Thu, 21 Dec 2023 16:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F601C433C9;
	Thu, 21 Dec 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176228;
	bh=qiAu0Z0L+6zSRjJdFQmQuvjQA8bxbqa0s5rr0Z170HM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d0F3lHrSa+1DC/9Cm0Rhwa/iDr/wKJJ2fuL7brT8jdw+qWk3INt1jQ09ILPWcrZXy
	 yHNp3DfbRZdom05U9fHKwjcelmFLtbbgeiXlwgv7lEXHYU1wjRkevRpwSakjh1PxGU
	 DvWS601C6poivsiShGCsqdMTzxnrX2N/pZPBWcVylpflCBw4FHH6LVZkOsgfzW7dlu
	 2mDpSG0iga3nO0V9JlIkugR7VupNVnZlG8pncf7UXd0/21QljV8a0FZ073Rwesoffj
	 /mkjtjE97ncDK5Wq6omFq+5eV+1Hn5GWwMZOENrJs0h/hYs9QIv+geb/75AFFVDETE
	 cPEe1H4Qyauiw==
From: Vinod Koul <vkoul@kernel.org>
To: p.zabel@pengutronix.de, Bumyong Lee <bumyong.lee@samsung.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231219055026.118695-1-bumyong.lee@samsung.com>
References: <CGME20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3@epcas2p4.samsung.com>
 <20231219055026.118695-1-bumyong.lee@samsung.com>
Subject: Re: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
Message-Id: <170317622670.683420.3881501030324253538.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 19 Dec 2023 14:50:26 +0900, Bumyong Lee wrote:
> According to DMA-330 errata notice[1] 71930, DMAKILL
> cannot clear internal signal, named pipeline_req_active.
> it makes that pl330 would wait forever in WFP state
> although dma already send dma request if pl330 gets
> dma request before entering WFP state.
> 
> The errata suggests that polling until entering WFP state
> as workaround and then peripherals allows to issue dma request.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pl330: issue_pending waits until WFP state
      commit: d114d3a096194fb2a9c3bedd7be6587b97610625

Best regards,
-- 
~Vinod



