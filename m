Return-Path: <dmaengine+bounces-4073-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB99FBCB6
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3805161C8A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8B1D9334;
	Tue, 24 Dec 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIzZs3E5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78781D90DC;
	Tue, 24 Dec 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036954; cv=none; b=AVksOwrdJ2Jd+k1AoDKKhEqpNcvGHEd0ApKh2WqrZLnu7UPQaAFQ/fymmzwxJmFiIywYidTg7bIriiraJfWPjgSDE6i5o9ySlwVUdEdqWNBBBBUr9Hp+N4N8GKCTY0nX/LeNA/Z75GbGgclZ9G0J75p+cSy+YQ4HbPiJSq2hGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036954; c=relaxed/simple;
	bh=kNYVTH/x71NlFuE2AFIAUHXZk183eAz2Ar8U961InmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DGn+awgrWDyaw3Bh0+BPTEauJENpDsKUPAM0FxUhTRZ2Ctcbvjhs7VgrRfM+C/mnpsX94h/OM0l1YNjaBrzTrAoCoJG2g9ssV+JkRrzxRjN1gQPygvIb1850OmvT8qQDH+TE/qgP9UlHbssYHETnOD+VybVbwGoneiA9sv9USlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIzZs3E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2838DC4CED4;
	Tue, 24 Dec 2024 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036954;
	bh=kNYVTH/x71NlFuE2AFIAUHXZk183eAz2Ar8U961InmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OIzZs3E5IBpCfA2fplVYp6ezGTSK7/7omJkUcHe1TzK/q3t2KgwiEun3DXoGDrGhy
	 D+/H24gT4yMSvgCq+9epoIxEIPq+A+TSq/wLlKUNDq/GW63abw539z73+i5NMf6o8u
	 2vDqxpq6La7K35jfQwjS3hWqAhWn6fHQi20fSKrc5tdn9PI9ERciAURJ4wlpLyh/hf
	 SF9sj+Hw4LYubH3veNvfVnHF6VJRETLsQAUjWEoXiS5/02ZNwbVsvSFIiDvcgE3DT3
	 PgGpRE1OZJpfbh52g6fpdCyHDJ+LaNmm/frIYXP13DOM0S4DAFEM9C3TVXnZZ87wp4
	 3NkzOwI1hrXQg==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v2 0/5] Enable FLR for IDXD halt
Message-Id: <173503695278.903491.15460348301309550850.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 22 Nov 2024 15:30:23 -0800, Fenghua Yu wrote:
> When IDXD device hits hardware errors, it enters halt state and triggers
> an interrupt to IDXD driver. Currently IDXD driver just prints an error
> message in the interrupt handler.
> 
> A better way to handle the interrupt is to do Function Level Reset (FLR)
> and recover the device's hardware and software configurations to its
> previous working state. The device and software can continue to run after
> the interrupt.
> 
> [...]

Applied, thanks!

[1/5] dmaengine: idxd: Add idxd_pci_probe_alloc() helper
      commit: 087e89b69b5fe5529a8809a06b4b4680e54f87e2
[2/5] dmaengine: idxd: Binding and unbinding IDXD device and driver
      commit: 3ab45516772b813315324dc63a900703144e80c4
[3/5] dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers
      commit: 6078a315aec15e0776fa90347cf4eba7478cdbd7
[4/5] dmaengine: idxd: Refactor halt handler
      commit: 3e114fa0fd1506c9e75aa0e2eb6a9050eb16b2f8
[5/5] dmaengine: idxd: Enable Function Level Reset (FLR) for halt
      commit: 98d187a989036096feaa2fef1ec3b2240ecdeacf

Best regards,
-- 
~Vinod



