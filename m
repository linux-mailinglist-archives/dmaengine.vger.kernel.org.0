Return-Path: <dmaengine+bounces-4397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42FA2EFE4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C073A32EB
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F123CEEF;
	Mon, 10 Feb 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMH+kbYW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9323CEE4;
	Mon, 10 Feb 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198114; cv=none; b=MF+cCNxNw0vgk/f171DGLZx/tR78X932vCdBmOOZy6iWnnwjtcrp9uahZ6t+uJy3Qv+C+WatdbEqdqZ2ccDwfD2kPr+T15XoYtVSqALW6wsUvQ+Gkpk4c4hhb6NprzhFtf2SPFRbkg6WdER5CXWia40IfgUaAq6EEEbotCCf3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198114; c=relaxed/simple;
	bh=OJOFnEKDLLSgrZyYdo04UuBZdfbUpa0T01ocFaTx8WE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AVPb0uFDGJ+xD+JjZU0/y7JH0jluW3I1lkdP60KB1g+/drfUnsvKiIvFqBZXNz6XHJMczYcGQEQSQQNY6W2jhvt+FM4bhfVIw5oRMaKUSbVtCfDDRgsjUE6MuAP143IQ4+9AwlPiltEBXcPpvFxeg7v7+DEZ3ZP8q9yffzrAGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMH+kbYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21972C4CEE7;
	Mon, 10 Feb 2025 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198113;
	bh=OJOFnEKDLLSgrZyYdo04UuBZdfbUpa0T01ocFaTx8WE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mMH+kbYWHsYH57zm1fcBsgn2zncOLmFjknqYtB3z7yoxv6l/vO54pZBW3w+v5/jUe
	 QKLkA6Gl2+KKvv9md9sAQOdRa1JhZUEBQ0/b6AwGQvFkqJChBOk1VXlHosQnxA+v5P
	 w6htlNnxmRlDZ05qMzkNmKkrXmXvVgw98rglnpIyLAXQcN+2QBMl3p7wRdAjm//1xn
	 mLMZgGiif89hUcWbC7wEOL4zE87bh+yc9Sl6ezuDY5T2g3baqvcmD2cnstcC7aYrpW
	 GWsDGvTYq7Jc4daLo9SIYqsXcZkHKz7+tML17EfZvyr9kBHtWeZDnpKTcIX8wnWfCR
	 a34zSj+Kt3DQQ==
From: Vinod Koul <vkoul@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <20250205150701.893083-1-andriy.shevchenko@linux.intel.com>
References: <20250205150701.893083-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Switch to
 LATE_SIMPLE_DEV_PM_OPS()
Message-Id: <173919811175.71959.7722754951089018756.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:11 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 17:06:48 +0200, Andy Shevchenko wrote:
> SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
> LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
> the driver's pm routines. We can now remove the ifdeffery
> in the suspend and resume functions.
> 
> 

Applied, thanks!

[1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
      commit: 1e137d53e8471b45257d937e9773b61a88807fe7

Best regards,
-- 
~Vinod



