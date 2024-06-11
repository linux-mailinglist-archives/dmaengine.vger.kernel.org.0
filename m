Return-Path: <dmaengine+bounces-2340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53990437D
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F583B257BF
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561B768F0;
	Tue, 11 Jun 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD7mBTeN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D7763F2;
	Tue, 11 Jun 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130470; cv=none; b=KLcOqh0iqRaU5oWKsdVMbKtEp3NZSon3r5vZaR1fuvmoOQGZr9Y8zyODmtwaq1D9g5+kL7MGOK175QCscmu1FwZZQfE26tYMXOd4bvX4xT94rgVONijlLSR/xfpEYWTLLZEuwwbOP9ZjydKMoIV9cIb8IA05TAe8TQaJIeHJqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130470; c=relaxed/simple;
	bh=OfEwrI9MC2KJSJ/sN3LkBsJtikvpOxRUSKnHAMpPAso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G1v4/mrTaXH0stlOgS54s3cKbNJojgC3fw0xcvlKHyHRMM7hRhn/pqMDhrlywRUVUT0XhTwQeK1WZZSoyeztCUJ5Jwziwabs+WRobqLq/wDFj8nPulZqhkee6TKGn/3vJ2MrjpUf4dDdstjCey+xEuXS+r3rZYcF3ZRREt+QS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD7mBTeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DFC32786;
	Tue, 11 Jun 2024 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130469;
	bh=OfEwrI9MC2KJSJ/sN3LkBsJtikvpOxRUSKnHAMpPAso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jD7mBTeNyOzd9Uq0YzXQ5KIMptOAroe/v/Bcc1CYpPaC3BvWVIE4ab8UMdCN4KVzk
	 ukuYaCRRUR8mP9aCnM1HmtB2XFkosnqlsRK+Ay8XWrVkCw9CCTMmYLsR4iS3X4T7pe
	 O3KxEAJvM1UXXQDqKESh34jrDnehM6LniH73XAk6dczhC3ZZtZH9R2Ff26Htn1lhTg
	 yU0LV8IQ9v+jjNOrQXyU6O0kmJ75NhZ0fsw+VmdTtv8LYxu8kmwoxsQqM6EdWOkimn
	 HEnUfwQMq5tInkS28bFX4pTh+tPt1TEUR1dU3yZGJ7GR46wnbdPhN0LTRNzB6dBoTq
	 5WEAXg6rZ1lEw==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Markus.Elfring@web.de, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240602013319.2975894-1-s-vadapalli@ti.com>
References: <20240602013319.2975894-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma-glue: Fix
 of_k3_udma_glue_parse_chn_by_id()
Message-Id: <171813046696.475489.4803165494511691062.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 02 Jun 2024 07:03:19 +0530, Siddharth Vadapalli wrote:
> The of_k3_udma_glue_parse_chn_by_id() helper function erroneously
> invokes "of_node_put()" on the "udmax_np" device-node passed to it,
> without having incremented its reference count at any point. Fix it.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()
      commit: ba27e9d2207784da748b19170a2e56bd7770bd81

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


