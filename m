Return-Path: <dmaengine+bounces-3030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D190964CD4
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 19:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603261C22232
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E901B86F8;
	Thu, 29 Aug 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL4RcIP+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538881B86F0;
	Thu, 29 Aug 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952645; cv=none; b=JNqVpCPb/vp+nC5Pvyfp6QutaaqMP+nFrZhjKAdEvU5GVla6zEtSmvkyhB6efMDt9kKrq3pEAuYpTbidd7bGkKK1JdD5Esdbd2EwhLjyR8WK5+zb3hpTfwrLbaZqbF0+UH1jdxTglTHX2pHi4d1YgA6X2ux5v0rm0GPABrFpVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952645; c=relaxed/simple;
	bh=1NqKTp67p+4uOv1kjD9wwNV3Q/Vhr9+DdWiRxFEMj/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O+w/bPKcSPBnAop4xHie3ORDpevXl9cPhe+A/Skcp5QNnzfrhRpcJ62ux9xsLeMPjGceVrqlnl1mDzc1sLGfVa2bA686ai6PJ34TNtOFwVRdXE/tNirdDIUtA/b+uq0vV5S/Gxn6durYCSACnhsJ6SUbMKOk611UOL007zxMMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL4RcIP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8C5C4CEC5;
	Thu, 29 Aug 2024 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952644;
	bh=1NqKTp67p+4uOv1kjD9wwNV3Q/Vhr9+DdWiRxFEMj/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eL4RcIP+lkEjmZ+plfp2GzAbCaEP0rIQ+ZEdQ7FHOFe/d53fPOZ/fjh8nTbF5NxyL
	 hmSu8OrOJvnU7G3ATtjfbdS8BLvXKkPG5GmFKvD0tX1CbPDO3pQ7ivOSLVAf32sP4Z
	 rX08sA6jTn7j88WlXCxgIHoJVl5l8pqafmJ0OAPRvr5Ljn+I/avWTizLMTW71JLQgg
	 BI/WbAafV7Z49S6p9wdvlRN9VWE2uIFFWijTScB0UZMrfp8bhx0n3dWIGUUx5EccPt
	 h63eGlqvlHcbrB+MdH0cI+hygJd7EkoDri0uBK7By74pjaS3pP5ILUqFSOuXTXHXNJ
	 eOvhJDh8EuPDQ==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@nxp.com, Joy Zou <joy.zou@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701070232.2519179-1-joy.zou@nxp.com>
References: <20240701070232.2519179-1-joy.zou@nxp.com>
Subject: Re: [PATCH v2 0/2] add edma src ID check at request channel
Message-Id: <172495264308.385951.16211392531581038291.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 01 Jul 2024 15:02:30 +0800, Joy Zou wrote:
> For the details, please check the patch commit log.
> 
> Changes in v2:
> 1. modify the dev_err() log description.
> 2. add review tag.
> 
> Joy Zou (2):
>   dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
>   dmaengine: fsl-edma: add edma src ID check at request channel
> 
> [...]

Applied, thanks!

[1/2] dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
      commit: 90d21f6e57a898ef02810404dd3866acaf707ebf
[2/2] dmaengine: fsl-edma: add edma src ID check at request channel
      commit: 9542961494bf747a73413f925f8ea9ac410a4aec

Best regards,
-- 
~Vinod



