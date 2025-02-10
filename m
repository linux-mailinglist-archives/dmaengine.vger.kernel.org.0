Return-Path: <dmaengine+bounces-4393-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E7A2EFDC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37333A58DE
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E71F8BD0;
	Mon, 10 Feb 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNOMVhLa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73B25290C;
	Mon, 10 Feb 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198091; cv=none; b=Za6lfJSbfH7GkOq1XZ6QT4a4cFaZVO+lchJnZkyAHdyHwiQgaeByL0yveq8yjGT/sXU4Q4YotFE1sjAp9aEPUckgwkQ7mCzSuCCHheIw6IVpuOuLSMtgHYRl9frG0cIpxA2gPvdUlZYVTp3DYrjwjsI/qatsf+caBr7w0KW6JzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198091; c=relaxed/simple;
	bh=tDjPJHR/FM+Ud6e1K8JfsVLttPQgDVQmMj6Kl13WXZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CqMjSiuFSdfr2yguSO0NFK/t1moq43oQsdDNt2zcIg0sZ4y3yTWzHLkUGHzvVHF5ib4UY6xJGpoP2ZEdQmxvtLet1kRFSJjA9LUyW8zUjCtGw9lKCJvfCD6DE5kZs3Nc3+RvaEAVFdPd6rrtwMLBSs48umhQQgPStF9vHO1hBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNOMVhLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E70AC4CED1;
	Mon, 10 Feb 2025 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198091;
	bh=tDjPJHR/FM+Ud6e1K8JfsVLttPQgDVQmMj6Kl13WXZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BNOMVhLa/QoPtZfK4KaAx+Ev+jTPW4gyUWvolg7VX5Cpu32MoL401pYxGxd+8THeA
	 oUcwv4Ezm4/SpUD+jeZJquPuaCn+/+jQIzJEYvj2AgoDtO1w6jYNYzt+OuYjoIRSZ/
	 i3L38axhitsQEmS/91H5UIS+jQYSycgx/m8OEGj4t6aZ+YSU1pwfqDGfH7XCReXySG
	 1RXKcxY4BYHUbZARWIOteL8UDRjTna5EnDCDSUvoj6b9JMvESrspzG6/POQBfsI5ob
	 JqZmaFpCOUFW/F0vLT9Jmf0o/jwxb8jKQdfkUxsd5MjARNeGeHeRs7YxoBVlO63uKN
	 lkkLF2P5PIjDw==
From: Vinod Koul <vkoul@kernel.org>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, 
 Mohan Kumar D <mkumard@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250210135413.2504272-1-mkumard@nvidia.com>
References: <20250210135413.2504272-1-mkumard@nvidia.com>
Subject: Re: [PATCH v5 0/2] Tegra ADMA fixes
Message-Id: <173919808866.71871.6186093781331522645.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:04:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 10 Feb 2025 19:24:11 +0530, Mohan Kumar D wrote:
> - Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Fix build error by using div_u64()
> 
> - Additional check for adma max page
> 
> Changelog
> =========
> 
> [...]

Applied, thanks!

[1/2] dmaengine: tegra210-adma: Use div_u64 for 64 bit division
      commit: 17987453a9d997c4d0749abc52f047bfa275427a
[2/2] dmaengine: tegra210-adma: check for adma max page
      commit: 76ed9b7d177ed5aa161a824ea857619b88542de1

Best regards,
-- 
~Vinod



