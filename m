Return-Path: <dmaengine+bounces-3861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921AE9E09FB
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E2A163A49
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E121DE2B5;
	Mon,  2 Dec 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpGSM3Xr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C018784A;
	Mon,  2 Dec 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160678; cv=none; b=oXfzp7mpodaCYCre92Eh5c3vdB9GNzbevs9JM3a2NtQAzvDkjVttz6oM7C8eJARFIxgfW99GaRlkX5ZTGZ/6KPWCt/zKpOuFL9pd1+djP22vcnNQhfXIcWB9l6kS6DyGiCrSYO4OnCcB5hXq3Drg1uzphjarV7Hk2+VOqSMhBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160678; c=relaxed/simple;
	bh=L/oZvplMWyjYBTTB3dGyV8dscK2uL6BBwnEFQQl+ZXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bgMQO8qJ4Hp5DT5etODSzfVrzyCT+RTc9QTAkYpzTM4Ku8pDuZ7Osnz2MhElpLWY+ufdJDGhO9bkZxPyNYJnZSB03j1YsdpUwSEaTtPqH8/w2IB8Y1jyl9FYtx63QOXiF4Lb+s1Z/EnOnTKzf5VrBFr99iB6uBHJ+rCVqeeU8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpGSM3Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7305C4CED1;
	Mon,  2 Dec 2024 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160678;
	bh=L/oZvplMWyjYBTTB3dGyV8dscK2uL6BBwnEFQQl+ZXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YpGSM3Xra2ozAuzs8ny8KKPd0JrUMqMNXJqLfrCrrsb/HxMW2NyNUSk+4SMzaxM4A
	 Q5CcAigbgxl/lATHtWVlqHv7ZYzfaXX6efhUeZhNIdlzUq3Usp6DdkZt0B7z6iTpHK
	 xvaU7TAWQhDZ1p+I+YFU8P0dn1ceFfjCMvaN7WCKAqDXN7id/zbQ/yGBn+LYCTl70K
	 l6t4w56FSE/lyXgREkAlYwdNl2TlrmO/OevmUjL4k3X/AvTryYj6Skvb6RQQ3Rn0ID
	 WS33NFReBiCnkrDXq0dLiksoyJT+fwLxlIT0nmBjAVTsNTb/ilSORU9V9QSa+j6o8M
	 B8o+LPQxQQDWw==
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107114656.17611-1-colin.i.king@gmail.com>
References: <20241107114656.17611-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] dmaengine: xilinx: xdma: remove redundant check
 on ret
Message-Id: <173316067527.538095.8720061974027462596.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 11:46:56 +0000, Colin Ian King wrote:
> The variable ret is being checked for an error and returning ret
> and the following statement returns ret too. The if check is
> redundant, and remove it. Just return the value returned from
> the call to regmap_write.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: remove redundant check on ret
      commit: 0f31c0912286f84b34b15e39b286db8f4765ced8

Best regards,
-- 
~Vinod



