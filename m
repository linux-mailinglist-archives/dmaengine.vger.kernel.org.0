Return-Path: <dmaengine+bounces-2587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C191BC38
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2CB23021
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035ED155337;
	Fri, 28 Jun 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYaVOtHV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8D155301;
	Fri, 28 Jun 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569412; cv=none; b=FVuVc2zdNz0XEa5IBPD4LOe5RUOym1Bwp1FtMulRZOKyWb4VjPoAJlvPzh5inEah1DEEo3ndS1WYo36LrAtNvYfbVKM9nwfs0Bzn3sE7UgjZXJTOCpEuvzqgD0oheZgORRqe/EJ3IEEF0Q0tzogobtRfWOf6Av7fWXpW2SIqhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569412; c=relaxed/simple;
	bh=OroG6pdH/6QXLAWN6YlD5OiJY99xV8IlY1RY26myn2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UvlqXUmid5sc3YRt5qVfI6lNWcc+i5BHlMrRtrmpVCay2M0yPQFBolhiSNeC5umfO011/dvqNzherNOTAp5OWxSpNG/0/KZWruXEvTHkEQycNM1yG0jWYn10a4ZcIiwMoohHur/SD2hFC9yxv1mjKas707X+sU3PTq+Rmm7/LHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYaVOtHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DDAC116B1;
	Fri, 28 Jun 2024 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719569412;
	bh=OroG6pdH/6QXLAWN6YlD5OiJY99xV8IlY1RY26myn2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WYaVOtHVjBRFcyigiPm8K5/iV5AMZarYISrukxAjpPNDecik+dTmZwNdTD0nOZQXl
	 qY8DzUWBDw00XjqyTKu5d0b2sx42+leSC8dO3a81fzVuD67t97LikrK81/1MdUGP59
	 vMGkN+00o0T8lGYc/hU0/hwU08HrK8aMl6DZwKpmZGhFXbbfyl3CagfCY8inEJOOaY
	 sM/lIakNpxwkoQBFmssK7BLaJNTmwauWOD+kySIzK7sf5B4IEeKZKsKS8LojGrGGZ9
	 C6dIrhLzCnSlWL+OJCHW23BGHd+1U3j4Hv1Tdl4wPXhJxFx0/FqaW4nxr4fb2xkomF
	 8MZMxGVmw5nmw==
From: Vinod Koul <vkoul@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240616-md-loongarch-drivers-dma-virt-dma-v1-1-70ed3dcbf8aa@quicinc.com>
References: <20240616-md-loongarch-drivers-dma-virt-dma-v1-1-70ed3dcbf8aa@quicinc.com>
Subject: Re: [PATCH] dmaengine: virt-dma: add missing MODULE_DESCRIPTION()
 macro
Message-Id: <171956941039.519169.6146310436484618615.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:40:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 16 Jun 2024 17:58:33 -0700, Jeff Johnson wrote:
> With ARCH=loongarch, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/virt-dma.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] dmaengine: virt-dma: add missing MODULE_DESCRIPTION() macro
      commit: 4db6b030257283166a11de3731a39f4f7ab9656e

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


