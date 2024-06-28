Return-Path: <dmaengine+bounces-2590-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DD91BC43
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A950C1F23C8B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084415667B;
	Fri, 28 Jun 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lODX88X9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFB15666F;
	Fri, 28 Jun 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569420; cv=none; b=B8I+Gw99Ud3uQL1ZXYx3ROgysYk0MQax0yX98Tumvofz91884Kg1pxBjDntTeUfSdE0qKkH1d9ixnoIyg2UX2WW8IrEPhuTnkM/142sD2E9IA+3o7+MC+EYhdevc7N8UrXPh3zW63vViD1iK/305JSPuMPSCkPP7iTQuqyW1ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569420; c=relaxed/simple;
	bh=2Ezlsi7lSaId51E27Yp2/8I5MqLIwdfwgUVWoK8bKdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jRKsBvVXwDHoMQEbJhpNGVIBm52pgyxYc2pCr3x+uRI3i5EL0k7v8CwBdMEzF7Ol+gGmevYfgqdY+V9B2iXomlMGiL/eVCj4zdNdjueZ5htgN62mgZZhg1NC77ciBnid4VygP8sc7Qm3A6h0qTvqWADzO/6W8onEEnD90EHrXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lODX88X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A0CC32781;
	Fri, 28 Jun 2024 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569419;
	bh=2Ezlsi7lSaId51E27Yp2/8I5MqLIwdfwgUVWoK8bKdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lODX88X9ulXGoEqCxJjnVBoZ4La1imjLQIvPY+BFvIymRyIfH0I9vsI3VShaMzZT6
	 kvkwHpR9LETNMy3mDxmshW7ckfUo521FZr45v689K59k1bzmDtjPjP8PhyzGXQy6VL
	 1GSk5JFcze4Q24plywXmn9MtdVQbqllXM1j5MhDHMtOa2fsrk8DMrvWkz5TGuYMaKH
	 zsSjdJ4FAc5T6aTnTb19dRTUKPryRGjqh6yxB6fU+joycvZdo9fXtKj+dPKWr5F6nZ
	 kSkmX+Zy5AfD38/C5ruwiccsk2B43dMZiNihEwZWRmJzsmQ4CuN+NDCzKoIHJcnnpU
	 NxVcuTZFKa8vA==
From: Vinod Koul <vkoul@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240613-md-arm64-drivers-dma-fsl-dpaa2-qdma-v1-1-815d148740e6@quicinc.com>
References: <20240613-md-arm64-drivers-dma-fsl-dpaa2-qdma-v1-1-815d148740e6@quicinc.com>
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: add missing
 MODULE_DESCRIPTION() macro
Message-Id: <171956941749.519169.18034339537628493813.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Jun 2024 11:57:14 -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/fsl-dpaa2-qdma/dpdmai.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-dpaa2-qdma: add missing MODULE_DESCRIPTION() macro
      commit: 316d1225b1126286952d1e1a3da9da911cc00dd6

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


