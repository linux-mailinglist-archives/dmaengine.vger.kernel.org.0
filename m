Return-Path: <dmaengine+bounces-4689-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BBA5A5A9
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD691892B45
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495A1E835F;
	Mon, 10 Mar 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO30AjlO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA41E834D;
	Mon, 10 Mar 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640817; cv=none; b=dNpnsEy27FYL9SNlhRhOQ4YSpQW2fYuys3LXgVDepqPpOHb4bIi9x+uKWPLF/3z58CG27iBuZJLiJVjpvEB3/qY0hA163EbgGD0qs0mTBb0Qihf89kNJKm9DgpLzvlEvgnCrpLBAHzt0ejl20oJrRHAz5kOnQWDocbirfHj40zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640817; c=relaxed/simple;
	bh=/Cb8ptmwMIhpf8UTMt3vZ3OTWJt/QQt1oC89oMjSrGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UBePNBGu+sfAXbrki0W9CAvSq22185sWPKafqTuX8gBrJuqpt54LpWjZZ/H1rRiqxJqvRQrJOGvgah6gulne5waE9HebKXDrZ5E041N0UiFUGyj03pwwlIJVjcecuOlftZ9ivxRS3ZxpPih7VVdKbYCfi/IE+d3oBndBXr6oduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO30AjlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9887CC4CEEF;
	Mon, 10 Mar 2025 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640817;
	bh=/Cb8ptmwMIhpf8UTMt3vZ3OTWJt/QQt1oC89oMjSrGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kO30AjlOUOlL06u662V4rvfriSBbRjGUaSV9VIAFMH3pwXEZTacbjB1/1jZ7ZSKjy
	 UItTXXDlgSXwN9dWFUS6V9pvd3521xZTBAzCv7rThxr5qVjczyf1Jngrev5U5fThnQ
	 RkpjMSmMy9YQI/WtOwQoGG23mkz5JH2K3k3pDI6PyWQhoh2RN7feWHmiO5Miz/0IPI
	 dlT+0ByxZbFWDl6as6AecjmTD+7vQ+unEQEIHSl5GjXs8BZC+tna5unwG0knFpvnp3
	 y++UUBw82UfH8y4F50kWuRCL6wUHLSf8F4teNgIixKQbPvAbehqGtpxoHHCQ1UkoU1
	 mpThRxEYQcGaQ==
From: Vinod Koul <vkoul@kernel.org>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250210-dmaengine-drop-imm-data-v1-1-e017766da2fa@amd.com>
References: <20250210-dmaengine-drop-imm-data-v1-1-e017766da2fa@amd.com>
Subject: Re: [PATCH] dmaengine: Remove device_prep_dma_imm_data from struct
 dma_device
Message-Id: <174164081612.489187.2965160654305537631.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 10 Feb 2025 17:29:11 -0600, Nathan Lynch wrote:
> The device_prep_dma_imm_data() method isn't implemented or invoked by
> any code since commit 80ade22c06ca ("misc: mic: remove the MIC drivers").
> 
> Remove it, shrinking struct dma_device by a few bytes.
> 
> 

Applied, thanks!

[1/1] dmaengine: Remove device_prep_dma_imm_data from struct dma_device
      commit: b9014a10bdb8e967d85819f5ef61e6f80d0b46c9

Best regards,
-- 
~Vinod



