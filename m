Return-Path: <dmaengine+bounces-5167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBFAAB6ECF
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301381BA33DA
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18480278161;
	Wed, 14 May 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGPK7f7j"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331C25E823;
	Wed, 14 May 2025 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234987; cv=none; b=Yv2yohvV1hQepH3vYbnERh8Q0FbX9fYlqRpYpORvg1RStHashkR71PmPCY7fcYKtSEPiI7nDmB7NY6/NYzYQO3C9PcPTnRAFSAz4fxHgMhFT0gOpIiFJEdFDkvNti6q3vTr0b3PKKcT2PRKZUYHy5RrFItf8mjtscC1S+pbHe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234987; c=relaxed/simple;
	bh=A1sqiCPQnrY/PLmGTga51GjQvJB5JyIxcRDZDO39ZqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kq75E9LmgGnXmBgAkqZH1tOZIisJcgOrHnvpFOYcTvSa5ErSRFhyAE7hBqW92W4DV5+fBZMTQmgf2TUcB1YCKf1OGl7Ta7/F78N9YrPZLXYDvjNMJEJo5zHv45tEg4fYMTcgENJvJ7olx/GxPlnMldacNayD3QFj+5NqqRDHuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGPK7f7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B55C4CEE9;
	Wed, 14 May 2025 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234986;
	bh=A1sqiCPQnrY/PLmGTga51GjQvJB5JyIxcRDZDO39ZqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qGPK7f7jNpevc7KUvJ7sEzeRATKwMFrswg8wJANFo085bTqM2C3Mo47YzLbleFlZV
	 +v7PtR+bmmT7isGfd3OOPDWOBpt0LEFdeH1skOvZs33TKJgbYaWsWWEtGeYjYQya35
	 FSh61K+AEhrKyvNx70Eg82y16WioL7Qm0a5JnRSyFcbaS1QxNm9YmLdJa60XGXbktP
	 d2WdESqpG4RHE1K3W6iGSYRspAZoPuk5DL87W2MQ26c6SBV27IfJ6ZhTCVtOir3O/U
	 +cVhEzK8bDaZKl7PBp+rjSav6GmoGzzKb3Qpy2dqp5z4pNeDlcdF5+uG/EgUJsKJz5
	 XzL+vjxxRRmcw==
From: Vinod Koul <vkoul@kernel.org>
To: dave.jiang@intel.com, vinicius.gomes@intel.com, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>
Cc: anil.s.keshavamurthy@intel.com, gordon.jin@intel.com
In-Reply-To: <20250509000304.1402863-1-yi.sun@intel.com>
References: <20250509000304.1402863-1-yi.sun@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Check availability of workqueue
 allocated by idxd wq driver before using
Message-Id: <174723498418.115803.4603053071326943266.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:04 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 09 May 2025 08:03:04 +0800, Yi Sun wrote:
> Running IDXD workloads in a container with the /dev directory mounted can
> trigger a call trace or even a kernel panic when the parent process of the
> container is terminated.
> 
> This issue occurs because, under certain configurations, Docker does not
> properly propagate the mount replica back to the original mount point.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using
      commit: 17502e7d7b7113346296f6758324798d536c31fd

Best regards,
-- 
~Vinod



