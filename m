Return-Path: <dmaengine+bounces-900-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9588429F2
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD301283A3F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D93129A80;
	Tue, 30 Jan 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbqMd9Qh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71D1292F7;
	Tue, 30 Jan 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633464; cv=none; b=m94M4lGpq+u+kTxSvr/dPRwrLJRPiwJXNV1RRxHwvK41OuowxZL5gseGn+c3RD0VckDbW2UPekPf0AWsLxpbPqZXWCozbhmQTpEBleP/WmuyTPlON8DTjjO+kBaq9hmaNRT9qrLLpuF46N9d6UXbbL3sZ80lnto0JcAEbjmu4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633464; c=relaxed/simple;
	bh=MXZ00j2wi3QFt3jMQHy2QcCAAxpkpnqZuBUNZpd+L/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nYrlEX74bLvT/SCTXKETr3OzAB0MP6lNO1yIgnJ5Pb6oDU6kFR+G2AiTRa6shGFExnEAwhvOWMLUFNBhMa/lYmyQu3Pc60jFZwHj6ZlMvuvEY6CJhjkxCwh7LgAv+SPTWIaKLTELUOCfogy/43aQFY2UeBVfFFgfif/DgYffrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbqMd9Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DFEC43390;
	Tue, 30 Jan 2024 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633463;
	bh=MXZ00j2wi3QFt3jMQHy2QcCAAxpkpnqZuBUNZpd+L/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RbqMd9QhDh1R4SATEqvPBglBxR/+2QaFgfSou7nHsoJJGsYVLp/Gz+EWQaAD5jlnj
	 ITBsDuV+dNzr2SWPCNfqy67RwHPjulWErCA4ir58L2lNq2N5DUXNTfx2ybuY6/f+fS
	 ILMynHTrUDbj62MT3sOtecmAZsQ3iIeegtChWuDXuP0H6uE8qFgxAkLn9jlgVfYDSp
	 gonL00fRk/rLm7/efpqaQPy6RiWkxuABkyiBFkm1HO4cDUg8BI7NUe0QN0dKW0DUyu
	 LXcVSgyiJU+McinxQaOycrKTklLmzfntn8hN+b9Y+o71MUw4A/8pw94c8OmOFhhIno
	 RU29wR4P3FHhg==
From: Vinod Koul <vkoul@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124095502.480506-1-chentao@kylinos.cn>
References: <20240124095502.480506-1-chentao@kylinos.cn>
Subject: Re: [PATCH] dmaengine: bestcomm: Code cleanup for bcom_sram_init
Message-Id: <170663346213.658154.5421493238542155706.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 22:21:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 24 Jan 2024 17:55:02 +0800, Kunwu Chan wrote:
> This part was commented from commit 2f9ea1bde0d1 ("[POWERPC]
> bestcomm: core bestcomm support for Freescale MPC5200") in
> about 16 years before.
> 
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: bestcomm: Code cleanup for bcom_sram_init
      commit: 7510bf84c4e318bff63b13183929a4272e1d2b5d

Best regards,
-- 
~Vinod



