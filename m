Return-Path: <dmaengine+bounces-5016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E4A9A080
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 07:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287B0189E93C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0E1AA1D8;
	Thu, 24 Apr 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urdTrlrx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A719ABC3
	for <dmaengine@vger.kernel.org>; Thu, 24 Apr 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472991; cv=none; b=s7y9ZlLm5rj8mJfpKENhoWKmgjt5dUwrGbino6jpSuzHbQsLtCty1wJFepb3hTkhPeNvcE2/kuidiGtFNCGKcwoSNQxOe7zTXVmdBaw1wYC6Eq7WHj4s+wECX8k5EApbaE4w30DvZMVj4ZG8kN5cDSrNR6LxaMd4QUBwcuXO5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472991; c=relaxed/simple;
	bh=auJScwy7GBr3wYHDOCv13ntb2VXfp3NelcBrBvOmcug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AesW2ScZYPo3NyL1lLDG3v5tYSBGmP4vjPEVsXj8sVXKNQrLg8uHDBBmwm6SOesutww5lgn6czNHdQSlTnMhZPqUWzkaBo0oZQPzeE8ancnZOYrM+O4DI3kAiUCyslmoGLTcO4OARGQgHqdyLnaslX542nUji66G7ifz+X1eb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urdTrlrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1FEC4CEEA;
	Thu, 24 Apr 2025 05:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745472990;
	bh=auJScwy7GBr3wYHDOCv13ntb2VXfp3NelcBrBvOmcug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=urdTrlrxTkSCQcHM+jlrrY+ImQOCgG8oY1nFatkavVQaX6wApCNzqCz3XjzEn7rXJ
	 hOOZJOdlkshzOoHa83UyCvkKz4IDXus/PWPn/hiQ28O01SsD+xVNJCGOp5i6Vlw/JN
	 vfcdtjFh28mC14DClPumN1e85JvAwJ6AdPf8VJisPhkZlxfH40bP0wnMK/ZmaGy96C
	 1cPd3c0UpCVvJvJZtFlPM5O4076TLf8+l3XL4mBYnxmbJJb9eZn622nl0qaSjtaBx5
	 G8+tJi8Fy8ZmjAuKpHir++7DBHZkTzTWn6kvXBbpiKB/7+UCqJ/szLJosR9rkqQ27C
	 9rmDvvvzXeyLQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dan.carpenter@linaro.org
In-Reply-To: <20250421114215.1687073-1-Basavaraj.Natikar@amd.com>
References: <20250421114215.1687073-1-Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v2] dmaengine: ptdma: Move variable condition check to
 the first place and remove redundancy
Message-Id: <174547298865.315671.4537618739775270955.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 11:06:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Apr 2025 17:12:15 +0530, Basavaraj Natikar wrote:
> The variable is dereferenced without first checking if it's null, leading
> to the following warning: 'Variable dereferenced before check: desc.'
> 
>      drivers/dma/amd/ptdma/ptdma-dmaengine.c: pt_cmd_callback_work()
>      warn: variable dereferenced before check 'desc'
> 
> Therefore, move the condition check for the 'desc' variable to the first
> place and remove the redundant extra condition check.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ptdma: Move variable condition check to the first place and remove redundancy
      commit: 305245a2e1d633e5f821178c98c6d6132cea2bdb

Best regards,
-- 
~Vinod



