Return-Path: <dmaengine+bounces-1884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B28A924B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 07:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6B281749
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6C56455;
	Thu, 18 Apr 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfVqpF8i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23A55E58;
	Thu, 18 Apr 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417205; cv=none; b=lu/pVYsehId+v5FUKSzuwcFoJjQlbuKD23EpN4fyGjDjRTgSdH6Pww+qGOqJDNANsBWQwZMfAYiPKFhdBWbfgKltcVcH4fCveScnnd1DRKd/ZB37aVqKMwfSi5glCIzFVW0Zxce52MXPm/sByMYDkZOKUU0BflJ57h9S1VtmG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417205; c=relaxed/simple;
	bh=wt4v4yz4RpD1kbyQ2uLs2n9zoO67/WtUUQnN1rD2Ywc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iZZZsud7gjn0jROf1rUS+NKbtsy+/iDTHHnQBBlovmxPH0BV84DfjxNYYPY/OVZ839EUW33BnEKP0ts1JujJ7yZqKjT1CLpUlXX9CmXdsGZv4KKS55++lKsQhgVJv5a0fRpjddkL8ZXn1dgy9eR9oIB+j+50dPh9GBv2uCZUsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfVqpF8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0C6C113CE;
	Thu, 18 Apr 2024 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713417205;
	bh=wt4v4yz4RpD1kbyQ2uLs2n9zoO67/WtUUQnN1rD2Ywc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jfVqpF8iO1rT62yeQx6MIotLei04Imud/e8AkAxEnUqo6MLH5wm0mFlimUVzyZ1VI
	 G1aYC8M8e+ParDSI33Qn5KZL2YUs6H2Z+hszKE9MuiMCygMC9fiMoMBKdMCZqj9oiC
	 ucbhFzbqmm9OdjpQTM53ySRMIH5XY2UA5He7wqpBYo6YBD00LNcjgKo2WPnVqXrOQd
	 01ZFtBSmS5/Nc5d/xLXiHjazP+tA1rAvcfGMNVI+tFNuTaUoZA/l68jA6Q7ULl60L6
	 UNRqb/ceNvCp+05ai4cXnMAqHOrTjXC0UTnphQOqis3VenEeC+bl27yrr0G1MqomNL
	 afDEX3A3HTHCg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240409163630.1996052-1-Frank.Li@nxp.com>
References: <20240409163630.1996052-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-dpaa2-qdma: Update DPDMAI
 interfaces to version 3
Message-Id: <171341720353.758041.14140862360528869658.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 10:43:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 09 Apr 2024 12:36:30 -0400, Frank Li wrote:
> Update the DPDMAI interfaces to support MC firmware up to 10.1x.x, which
> major change is to add dpaa domain id support. User space MC controller
> tool can create difference dpaa domain for difference virtual environment.
> DMA queues can map to difference service priorities.
> 
> The MC command was basic compatible original one. The new command use
> previous reserved field.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces to version 3
      commit: bd2f66bc0ba08a68c7edcd3992886d1773c18cf2

Best regards,
-- 
~Vinod



