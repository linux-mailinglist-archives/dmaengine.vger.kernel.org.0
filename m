Return-Path: <dmaengine+bounces-4396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C377EA2EFE3
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC23A3106
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74542236FC;
	Mon, 10 Feb 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3MYC9rS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8B221DBF;
	Mon, 10 Feb 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198111; cv=none; b=JhBj5O1bUDSDm4iZqOafbJiLBn6nrjKVSy/TWno5ZcvL5VMcm5gGWgOBAb8Cnj+VaF5pjYPn8IEqp7RCBKWEU7Xp2rMJKm7hHKbnMbpUu8YmCx4+F7904R1bETaLShz0EGLIp4pYvvui/rWE4CIcC5PRwDBiZJubAR/xG35KJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198111; c=relaxed/simple;
	bh=4MQF+duV3Z6GyqMReLLQ/7muGG1r298coZ8wUK0yw+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AgiC4itDGw3j0/NCs7EGX1Ad4ntcIPBUI7Zb5GFhSlETsvf3ACbIkRNO1eVE9DNycIETe6Je3nI5zU2dT58OnbBhVCQGeg/q6C2NFJVTBGrNCUf/bxxGZ51aljN+5/TgM4GgC9/vXDl3ZUrAlzdLq/qXG5gwE5N4roPlBecBo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3MYC9rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074B0C4CED1;
	Mon, 10 Feb 2025 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198111;
	bh=4MQF+duV3Z6GyqMReLLQ/7muGG1r298coZ8wUK0yw+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s3MYC9rSDnFSp7lkxZJlHWDHcSbdcADd94W13WlhfeHkOjSmAkOAptF0CneJIDnG3
	 MvSIf6oWqquQcXqmf92AxfO1Ds8MNPE8V9lgQTMx6K52GX3q2ZbiN2Tq3Nfwgjulh3
	 9ma1c5gd6uKvPlVxdIdu5DHeFryGi4cp39GWNw3cgsm6ltJ0IHCqsEtl3DZTebiCO9
	 G3PNZ3/JxZFISL2/vvuvXB9A9wUEQRhKcKx4bdw+J7VVdviC7q75MRRS4EjM4SMET6
	 soBI2DwLdZBL9u/C7lUMsgXiKIvz4MQDOry3NnVGv41laXoGRsIbSpSojTACHYvp4j
	 7zZQvslkOXJlQ==
From: Vinod Koul <vkoul@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>, 
 Frank Li <Frank.Li@nxp.com>, Paul Cercueil <paul@crapouillou.net>, 
 Randy Dunlap <rdunlap@infradead.org>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
References: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/4] dmaengine: dma_request_chan*() amendments
Message-Id: <173919810764.71959.6637536991455894544.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 16:57:08 +0200, Andy Shevchenko wrote:
> Reduce the scope of the use of some rarely used DMA request channel APIs
> in order to make the step of their removal or making static in the
> future. No functional changes intended.
> 
> In v3:
> - rebased on top of v6.14-rc1
> 
> [...]

Applied, thanks!

[1/4] dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
      commit: 31d43141d13aa63587f140884b1f667800ce4e1d
[2/4] dmaengine: Use dma_request_channel() instead of __dma_request_channel()
      commit: 1c83d3dfa0905590408595560629627cba4f9261
[3/4] dmaengine: Add a comment on why it's okay when kasprintf() fails
      commit: 1722fb4a1307748f983c1345c4c24178d8e0be47
[4/4] dmaengine: Unify checks in dma_request_chan()
      commit: 91d8560c15918c7d44e4f665fac829ba8057a2f3

Best regards,
-- 
~Vinod



