Return-Path: <dmaengine+bounces-3855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F79E09ED
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D03280C80
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69C70818;
	Mon,  2 Dec 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMPE6N/F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5227713
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160642; cv=none; b=EgOvc8EWVB1lJkXH8SrJxsI2s2gosoaxsMYhomZaekVVj6fJ2Wxl9Sq1EZcdGwqIveWypfNF75+JGn67vwecNOZQaoDgicze6nCZWqvr9xxpaVv9cw5LzRYoHBMf9XntVFzlxT41MKrhkikXkBMf5B9t/tb4qEm+smsCiE5NxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160642; c=relaxed/simple;
	bh=9t0leaS86rWqt3K/XDpj7l3zbrInJ4E1oiE9CI0vFTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CBoD8Ic3XJ7ie/wTInEZJtnzvTud/VfYNQ2Wz4da59PGd7iM1+2eXeebbzdyeoZgHzCIOhv66VkDe9sAGLiCU8GqqOftphHNSEAmJfd19MtfkFpM7WdKQlb0DhX55eg6b8lfcGcacgbAEjq6slf0+IJPaPYEKCBgaoExF7ir+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMPE6N/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7376EC4CED1;
	Mon,  2 Dec 2024 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160641;
	bh=9t0leaS86rWqt3K/XDpj7l3zbrInJ4E1oiE9CI0vFTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AMPE6N/F4na0vxF7bUAB61asl3DqTUp4smImlJGg1xjcmJ4C4MPYjtZcoSZ9JGuH9
	 bUGrVR86PaDvuxheuOJJIh9gA2rHvI7pqEAgVWXnl6ZZhdNUmNTTEKe8qgbobueFZN
	 gLTq5Z9FzeRXgiAir8UXDoeI1ZMHyf/LyNgtn7cyrOiY7Eh4gLyk6u1AU5jERfFQEY
	 d4L1zfDOJokC90osA96acFpC5d1Kdtf/ijn0VH5j29dWfm+YbQ7D/wtVOwxS/Ph5mB
	 eBzbCTaCR6xvPGySUFVx2UVc8upIlgkoDplnZg81cerK0jPb5oasKMwAwVWl1QSNkK
	 RqtHo8XdzuKOQ==
From: Vinod Koul <vkoul@kernel.org>
To: ludovic.desroches@microchip.com, mripard@kernel.org, 
 Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 chenridong@huawei.com, wangweiyang2@huawei.com
In-Reply-To: <20241029082845.1185380-1-chenridong@huaweicloud.com>
References: <20241029082845.1185380-1-chenridong@huaweicloud.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: avoid null_prt_deref in
 at_xdmac_prep_dma_memset
Message-Id: <173316063896.537992.16601132301793620749.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:00:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 29 Oct 2024 08:28:45 +0000, Chen Ridong wrote:
> The at_xdmac_memset_create_desc may return NULL, which will lead to a
> null pointer dereference. For example, the len input is error, or the
> atchan->free_descs_list is empty and memory is exhausted. Therefore, add
> check to avoid this.
> 
> 

Applied, thanks!

[1/1] dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      commit: c43ec96e8d34399bd9dab2f2dc316b904892133f

Best regards,
-- 
~Vinod



