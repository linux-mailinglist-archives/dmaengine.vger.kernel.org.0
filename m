Return-Path: <dmaengine+bounces-2991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD3962FA3
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7506528311C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891E1AB515;
	Wed, 28 Aug 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDBNoPut"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536E1AB50E;
	Wed, 28 Aug 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869016; cv=none; b=MPUNIknEtm4EFTJ/9crq9FX+QQEbMfE/oe0o3VdlQIcj865UgmTc5dQjqBAKCltPBJPBUh5oBLou+j4KphyWPGoj/zf2Eqn5K4OFEs/fSyk4L2/ClzYS2IK933KaEHnklEGuufYmbwB1d2Y53wuZInJ8Qjbh26hRL8UGQcSdXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869016; c=relaxed/simple;
	bh=VBNYQf8yzvsBfB6CtyatSlKwGAe+1xtnxVc8DJhLgR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dR/jy9P8NN13npZZ6bV7JDLWh+TrlP4puAKO+FUfgDUvIFMRSPM/QWXZm+tGvbI8NWZ48Px0iKPj2fkELFOnEBR7BOc4rciD0a1fM8ay2tv0Ez7qAPjnNcyNV0EqqfnMnZT5mDpS8jB1tjCUo1SkYCGLuqrGatezCVOO0f2vCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDBNoPut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D39BC4CEC1;
	Wed, 28 Aug 2024 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869016;
	bh=VBNYQf8yzvsBfB6CtyatSlKwGAe+1xtnxVc8DJhLgR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IDBNoPutePDe61V4lT8SRGHGv0ZoWUR0aUeR2oZWGdUOXz/V0C2cLKw+l/1En58VS
	 O2RN1FSP5d57X0YgpeNZDZTYhCeB3HstjY//V3acOGGbK8sfwemMGgbSVQwD34jp5F
	 /ACL2Pgh/8Xy6XYJiOT4cQE/om0qvVFHpaBp3nTTdZ6WrgCTY/8nywWZxY58frdQhC
	 zqU4GiY9jHZpRcwGAxHt0yA2AKXV+9WL1ali/z+nYLXBMWFFIS80h6qHXy5X2EAnAa
	 dhqtOM16SGF+v0r0UHQJbSQgOdawmqRyeeHrdGNRS2JphPSg1BrgXboVdODVfuuTPA
	 f4E2p+3icK2ug==
From: Vinod Koul <vkoul@kernel.org>
To: laurent.pinchart@ideasonboard.com, tomi.valkeinen@ideasonboard.com, 
 Vishal Sagar <vishal.sagar@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, 
 varunkumar.allagadapa@amd.com
In-Reply-To: <20240821134043.2885506-1-vishal.sagar@amd.com>
References: <20240821134043.2885506-1-vishal.sagar@amd.com>
Subject: Re: [PATCH v3] dmaengine: xilinx: dpdma: Add support for cyclic
 dma mode
Message-Id: <172486901387.320468.1137041998364669534.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:46:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 21 Aug 2024 06:40:43 -0700, Vishal Sagar wrote:
> This patch adds support for DPDMA cyclic dma mode,
> DMA cyclic transfers are required by audio streaming.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: dpdma: Add support for cyclic dma mode
      commit: 51c42ae3d76a16167abbde7dc19b7220c5786d35

Best regards,
-- 
~Vinod



