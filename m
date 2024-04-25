Return-Path: <dmaengine+bounces-1960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683748B1DAB
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FCD283B62
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4935126F06;
	Thu, 25 Apr 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OheZWlmx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBB127E1F;
	Thu, 25 Apr 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036658; cv=none; b=FsXJXBRpH6s7CAPNbdKzDEcEDmefpTRZxVzmyOPFkPn1YKALbbuNbF3abhWvhE2AbX5MvC7AiAQRVpvkBjsB7vKXJRmy7h4SgxTA1TMfQu5rPU+fbIYLKAlO0IttM2yxg616QbIgU2Hm6AmQl8UDvTQVJkVtwOH4gXPCjlp3bDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036658; c=relaxed/simple;
	bh=+X18uvKMw4jO18R9YLT81J6ZTIUpPc/7+UgzXyIMmcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fuj9v8aFeVqOC4kobVhU3o618dXrtCc5BMbQfNjSV5tlYyT6uQI/M07RtzrChdk68zmbFOEH+KsUN1u2B2uPQnjgZ8GbV4bUuyPz1/pJklKrmE6hcc3Lww4aM0LDozd73Tnd0+d/XtYMwFF6K1y4r4wGZkrbkQelqDC3t6cN5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OheZWlmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C24BC113CC;
	Thu, 25 Apr 2024 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036658;
	bh=+X18uvKMw4jO18R9YLT81J6ZTIUpPc/7+UgzXyIMmcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OheZWlmxzucZr5d/6ift/2iIgXbcb3InuJUvg9rvvYVJNDW90PjZv6n01uBSIqFTi
	 6GzOKlBOoVNDE6BQGMtXvy537VDPYRh56sVYogU5Y2g4SZTs7hFpmp8/bfZFXXVHSF
	 O/CSF2slTmi3niPqKC1R43JBSysJ69O2p8nhVQLD52/TfZqtF04ZmCOdQcPVDFdbDS
	 0m9qa5dajvYJLCaCA2eELSiMM+Yoz/QXYsAF26piQZ7bOf3bMssaDgWOQ5th2E6spg
	 MpRoVceUOKWLZUBk2dFtV91X+2lq+bDQkiAr43wcggTK2T4zlZywLpzBtZfRoXkWGO
	 BfYwuRhqE3H1w==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: 20240409185416.2224609-1-Frank.Li@nxp.com, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 linux-kernel@vger.kernel.org, pankaj.gupta@nxp.com, peng.fan@nxp.com, 
 shengjiu.wang@nxp.com, shenwei.wang@nxp.com, xu.yang_2@nxp.com
In-Reply-To: <20240417152457.361340-1-Frank.Li@nxp.com>
References: <20240417152457.361340-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: fsl-edma: remove 'clocks'
 from required
Message-Id: <171403665255.79852.5372763957317899753.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 17 Apr 2024 11:24:56 -0400, Frank Li wrote:
> fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
> required and add 'if' block for other compatible string to keep the same
> restrictions.
> 
> 

Applied, thanks!

[1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
      commit: 9c21bbfa30ec14f8dcf24e7f26fe72368960975c
[2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
      commit: 167ec660c247ea4c71a059290b50c100659d6e86

Best regards,
-- 
~Vinod



