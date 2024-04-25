Return-Path: <dmaengine+bounces-1961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3718B1DAD
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF56E1C232CE
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3716127E29;
	Thu, 25 Apr 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRTKxTFh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14C127E20;
	Thu, 25 Apr 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036662; cv=none; b=HVHcKzrmCd2bu8xaY85S1aUyZM6JmmLr1UvB8WqLtLqQJOY8cyIfGIWQmm9CQI8ScfLCZKwJjzWBfn8OjFC4mb253eq1qw/dJzTSQR/A5lwdTnsjgZT/o92M7/++FyfZ3A93woFi6o6xx9dnNNioTrpv58cmEY2LgB745h8Fzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036662; c=relaxed/simple;
	bh=bCXuKuGaX/Eqpf63C5cnAkZiVSiMv9NfH/mO1PmDlvk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QJVENREz+ppOqpRIUyBft0y3pu5Hh2Lh2bIbcGUqdsRuWbcL+JcQAXzmx7s8nFGzSbO+UtrQMkvGLrRWwNiu3nFcy0h5oSloI75e2KMV1MUuNV2YI6mWVJRkBU+7urjeT/1a4j+5d6BCVxu/9zSwzWOWKld7p6GtkGec2gWPOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRTKxTFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD40AC32781;
	Thu, 25 Apr 2024 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036662;
	bh=bCXuKuGaX/Eqpf63C5cnAkZiVSiMv9NfH/mO1PmDlvk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MRTKxTFhmvMyf18fSAgmlEeTl0YsfFXQ1aZw15pOK8YIgg5CekFQmh8dlPSkhZ2F1
	 QSUwrlM60hCyN0n/yv7v7RL9fVJfl1a4bVq0YnSBs/5BqFitpY/lVb1vol48ASB996
	 FeMvLDZC52kzfYC2Xz+VOQAgNKFlPOsbfAquX2YbppqCFLbD27F7AEiqUhIlaL5hqy
	 lhS6fJSO4eBj8Jg2ib6+vO5j6a9zxF05ZvYijIU7mMvyXiu4D7R5lnH6N2INnysU5R
	 v3LtUfmVNbGARlb+sAQB5Aqg7Il9o/U7z5XXu17xGszhv6uzGA+Qc93cT4k2vuk9BP
	 zArbmEIpKuVig==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410170317.248715-1-krzk@kernel.org>
References: <20240410170317.248715-1-krzk@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dmaengine: ti: k3-udma: fix module
 autoloading
Message-Id: <171403665837.79852.8945776501825971994.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Apr 2024 19:03:16 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[2/2] dmaengine: xilinx: xdma: fix module autoloading
      commit: 700b2e1eccb4490752227d4339c3d2c3d52d06a7

Best regards,
-- 
~Vinod



