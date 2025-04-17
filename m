Return-Path: <dmaengine+bounces-4917-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55CA92140
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9598D8A2C01
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA55E253B6D;
	Thu, 17 Apr 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpPjCYRw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F50253947;
	Thu, 17 Apr 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903135; cv=none; b=HRRBEIiejpHn9ciXsGnMjgfuzSTlGb3Sv2RuOBvrh1czrJ7ME8kqPUZkz67QokzPk08taGvPDLfvGp39yvx0fg6nuUcsAnFTGRUiqjMzm/OeIViMBIxR3kZh1NkDrOjgkIb0hMaG6ZmY0kqrlN6QUslYFuwZ4u7C2reGltXPmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903135; c=relaxed/simple;
	bh=WMM/wu4EpPKC2gJkP++OcdA6brqyyvoMdvoYCiUQdTI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=om8PVfd59kNJ41u9Mnl+kHAPglGSCOxH51Pu7AP79S8RTBsEqPEb2e5YAYL76EPf2OTbtoGFofnhaFGndsERN3dbQ7ItEIKGnmdzra3Z+FzmrDPnQFKKskuSuh4HtRIZ9015XuSKMuVyvJY/XQNLyKGwijKGpLuhU08gKeJiuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpPjCYRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B0FC4CEEC;
	Thu, 17 Apr 2025 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903135;
	bh=WMM/wu4EpPKC2gJkP++OcdA6brqyyvoMdvoYCiUQdTI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jpPjCYRw6U3tWJrG5joqrwpMmYtMHZdqo9V8xNSR7Z3lpSPF37VWydUfRqoQIVl/A
	 gbP/up5TDmxcv28s5Vupijx0tg+FMSBzxOgcz1L55Oy9Osqk2BClRb9q+YBGgCFR4o
	 nuYoJoI7sTI8yIM+QQBkT3COfEVHf5abo3O2/irfTM8KXLjm0Jg3MA6UWqm66yclYy
	 +dQ/O7AnCq37sQxWQTwkQpzaVqr0I5nWlqb0F7cY1X5YpkANc2GagfCCpZMa4Q7AoN
	 vaGChrySP15z6+EYqzshBP1MX4jfTDlIxQJJJEpVVrp/6htVAv5Pg6yKlXYR2a+pee
	 H9o+R5V2YcVww==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 wangzhou1@hisilicon.com, liulongfang@huawei.com, 
 Jie Hai <haijie1@huawei.com>
In-Reply-To: <20250402085423.347526-1-haijie1@huawei.com>
References: <20250402085423.347526-1-haijie1@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Maintainer change for hisi_dma
Message-Id: <174490313350.238725.16561551295448743454.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 02 Apr 2025 16:54:23 +0800, Jie Hai wrote:
> I am moving on to other things and longfang is going to
> take over the role of hisi_dma maintainer. Update the
> MAINTAINERS accordingly.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Maintainer change for hisi_dma
      commit: 1c398492b2e8d5daf83773684699f03b06af44ce

Best regards,
-- 
~Vinod



