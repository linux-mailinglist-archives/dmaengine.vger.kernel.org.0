Return-Path: <dmaengine+bounces-621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D997981BC13
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9744028553C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9A64A84;
	Thu, 21 Dec 2023 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaGQVq7h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3364A86
	for <dmaengine@vger.kernel.org>; Thu, 21 Dec 2023 16:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365AC433C8;
	Thu, 21 Dec 2023 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176220;
	bh=002BtuHnXNbFRgp/XMvxo487ywxKCGB4j1qIDdm78R0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PaGQVq7hTqIAFPg5z6SFl3s4gk1e7Kco7FAtoN7YXgVxb2LBdQy4sZbUM/lwrScFs
	 2DRZdVO7ddYDUGHtBIAtZofkUlXbBdWKS3VvEpP7PJrxaqRKY6rgJwG2YaljSM03Pu
	 HD6FN1UNrnILHFk5i0SBVhdUSTveNAUVuFocTzMjMOe5lUdhDgqKd5LuVpZjuhUXCu
	 5wyNllxKfBMEjGsPMpf8nchH7cgGK026SKN+0iumTLLUQFsSeT5CN1CXnJeUk1LMIi
	 I/b9m9Fm1QZ/wR8ah4FQlbP26BafhcN6UfResSqhXup/nMbfSiyglN5BNefmx9w9JP
	 DSThrOIm5YxAg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rex Zhang <rex.zhang@intel.com>
Cc: dave.jiang@intel.com, fenghua.yu@intel.com
In-Reply-To: <20231212022158.358619-2-rex.zhang@intel.com>
References: <20231212022158.358619-1-rex.zhang@intel.com>
 <20231212022158.358619-2-rex.zhang@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Move dma_free_coherent() out of
 spinlocked context
Message-Id: <170317621828.683420.16623455086024041056.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 12 Dec 2023 10:21:58 +0800, Rex Zhang wrote:
> Task may be rescheduled within dma_free_coherent(). So dma_free_coherent()
> can't be called between spin_lock() and spin_unlock() to avoid Call Trace:
>     Call Trace:
>     <TASK>
>     dump_stack_lvl+0x37/0x50
>     __might_resched+0x16a/0x1c0
>     vunmap+0x2c/0x70
>     __iommu_dma_free+0x96/0x100
>     idxd_device_evl_free+0xd5/0x100 [idxd]
>     device_release_driver_internal+0x197/0x200
>     unbind_store+0xa1/0xb0
>     kernfs_fop_write_iter+0x120/0x1c0
>     vfs_write+0x2d3/0x400
>     ksys_write+0x63/0xe0
>     do_syscall_64+0x44/0xa0
>     entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Move it out of the context.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Move dma_free_coherent() out of spinlocked context
      commit: e271c0ba3f919c48e90c64b703538fbb7865cb63

Best regards,
-- 
~Vinod



