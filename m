Return-Path: <dmaengine+bounces-785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02904836D08
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309451C26C10
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40253819;
	Mon, 22 Jan 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXIy1ayH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5853818;
	Mon, 22 Jan 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940712; cv=none; b=P4ZmxU1dvTyaaIcsPwhYVJ7kWbmTEiTzgX5ZdG8zvuJ9QsAlmJbqFqH6I24hDUZHIjMFPikT8Wi/IHeiQl5WLlUWbbVjekqhG2rSBXnmoRFvvuuePD4unMZlcKMrrrEyIZrUMtwVfOUcwrXyGIpJbvMn94QiUYJzlHMoCk7F6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940712; c=relaxed/simple;
	bh=UadFVxmctqVr/nq53Nih9EBH1XgmG/zNaIvtkD5E3aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TdTWOR50fLK3qE8OjFvOJMob4QBS872H0hwa23tFUHG0hLip/IERm7bu7BU16IFtnoyHIgUTce2mn2kFoq5UXTvJ19jeq36v4E/COiMTk31ap4Zv0o3DXpzYHD0Eyjo/qRY5ZXtdU7wsNWH4SUv36W2XGhGQdSbde0ItLaugH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXIy1ayH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608DDC43394;
	Mon, 22 Jan 2024 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940712;
	bh=UadFVxmctqVr/nq53Nih9EBH1XgmG/zNaIvtkD5E3aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cXIy1ayHqvsdn7fzJhjOTxeUxgKG9Oj+t6zKISk5j5cXMuqoqDbreY+fF0QKnfjIS
	 J6kYUhnKlMuMjdYwXZym3kxmJZVN4AdWWsgdd5J8NoE2+4j0V4/r1Wd30bcmRLL+c5
	 b72LPZW68bu/gC4rOk9qXdywNEZMfIKsF9cpfIVne9m6WpWRk095O6PJ7mwpmyOtR6
	 6jTFapUWvIq5S3SDbXeP5Anb0n3IoTUWtJSpNFIr3HTEdodHu/LZSQ0LOa+xGCTdVJ
	 E2MTeml46U3whnaaTnFQdwD6X6fH6NzViZgWiA/5hRANxoiQ7fHrxGIiogeyC7zEVt
	 mwmtzrA7oRkPg==
From: Vinod Koul <vkoul@kernel.org>
To: jiaheng.fan@nxp.com, peng.ma@nxp.com, wen.he_1@nxp.com, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
References: <cover.1704621515.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/3] dmaengine: fsl-qdma: Fix some error handling paths
Message-Id: <170594071003.297861.1425725025349258769.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sun, 07 Jan 2024 11:02:02 +0100, Christophe JAILLET wrote:
> The first 2 patches are bug fixes related to missing dma_free_coherent() either
> in the remove function or in the error handling path of the probe.
> 
> They are compile tested only. So review with care.
> 
> The 3rd patch is only a clean up.
> 
> [...]

Applied, thanks!

[1/3] dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      commit: 968bc1d7203d384e72afe34124a1801b7af76514
[2/3] dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA
      commit: 3aa58cb51318e329d203857f7a191678e60bb714
[3/3] dmaengine: fsl-qdma: Remove a useless devm_kfree()
      commit: 0650006a93a2ce3b57f86e7f000347d9ae7737ef

Best regards,
-- 
~Vinod



