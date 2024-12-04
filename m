Return-Path: <dmaengine+bounces-3889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDF9E3B25
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE52282F9E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD111F4734;
	Wed,  4 Dec 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2wFXqAH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898F1F426E;
	Wed,  4 Dec 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318350; cv=none; b=UPkVWhWE+4yjvUBsstcjUoHB+Y2JmlfQnIfCivn46CHNtq3DA21Q5b59Z59sbPqJdMg62mWpj4E9K4P3YGswy2vrJ3HDksKIPTs2nxYxMRirKuRVuedooUgN/fsR6Gp8+BaCp5SK307kOo28yG1zVwV8S+i5+NdIglkINCKmFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318350; c=relaxed/simple;
	bh=5R4kncImUOrkCKvGwYDIT+t7PruSStNbC5xtmwPD0qo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WxdT8slE1DqFkhk2dE9C78itWDeQGyyXfgDIU4Wi5dIjmo5ZZsPjSEvYu/A7a6I8ZvH5WReUCen30Q0xgcFLiTm2Cn7AWy2rG9fCb7VRm+VLUv2wRIkmIUWnaoSWLpyXUQw7XV1w4DVY59BM9TCC3a5N31b0oC5nZU39+5tl2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2wFXqAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7228EC4CED1;
	Wed,  4 Dec 2024 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318349;
	bh=5R4kncImUOrkCKvGwYDIT+t7PruSStNbC5xtmwPD0qo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T2wFXqAHcjMxcEeEnX3B1Brg9tuuiycz9mIvlHgQuurStrY3ULGHyR01VycpCx1fB
	 dyhiEhSFRm4UKo4zA9IL0VNtWnTXp8zXBQRDMUWcZ3eKRQ5bF37wjcrowskCyvrW+U
	 4IEenp6rSFAjOXw//MrFZ9Duumb9XCcC2PK+pJ+/S8bIIioj7QdA+KziN5TjO4xitk
	 IzgBO/d975ZDyNEoswV9OSnrMd2+7ejmfCb0K99nToTKRal7L9+IgTbsAGZsfgpQOY
	 nBQFYrisqt57146K34/DX8uhCARg4efRIQBXczRcohMnlPgVcWQ/w6nNlPW1jjFwbJ
	 ONzNYzx/RjRLA==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20241024183500.281268-1-fenghua.yu@intel.com>
References: <20241024183500.281268-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Add a new IAA device ID on Panther
 Lake family platforms
Message-Id: <173331834808.673424.7296798631514975953.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:49:08 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 24 Oct 2024 11:35:00 -0700, Fenghua Yu wrote:
> A new IAA device ID, 0xb02d, is introduced across all Panther Lake family
> platforms. Add the device ID to the IDXD driver.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Add a new IAA device ID on Panther Lake family platforms
      commit: c76d3daaa0928d4edc49703f7c9c2505ccff4369

Best regards,
-- 
~Vinod



