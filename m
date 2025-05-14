Return-Path: <dmaengine+bounces-5159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41448AB6EB4
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D237A8051
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414F1A83F4;
	Wed, 14 May 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO/wYWsO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0219341F;
	Wed, 14 May 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234957; cv=none; b=FNLh8RYnsCaN6pOvrOQnZkcKbTOHo4jdtLE5t3D7zGcPw7hKzyk/ZvFNsMP7woEpzMHn19Ihkdk1fQcCQmdKeEFnECiitG6DdoT41mkMIIW32s2Zi6e56wA+XVarySWOZyQL17mRHXYyG8+Lyi+g1QnVubgRmyD1o4Z+kBYXbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234957; c=relaxed/simple;
	bh=AXLEn+E72riVcK5RHPMZaYj09Q8Ur6tzg/POyTHnvzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EHiFEDvB/RO85cE5KDpfXzLqgx8lNqfuo2CzKREnQtcPeuvKplu2ZADr9497ykrbICHD/cuCUai0URxnGLdmQd7WGYL7WMeBiW+OVU3V7FPraf8teaDBKsrAm1SdIe6INEIozMUV7hrbNyHzzuNWj8qf/z0WTqPfBuJd4MUYdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO/wYWsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E7C4CEE3;
	Wed, 14 May 2025 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234956;
	bh=AXLEn+E72riVcK5RHPMZaYj09Q8Ur6tzg/POyTHnvzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DO/wYWsOZBR44lIoV2JoctsJiR+HbsW9HDWI1hgfxcJsslSlJBmF3Xsb38XPpLCpx
	 jW2RGa2yzoHw32KsK/o8xjMQUJwfwzYRB+fTwXgOB+NYPeSEhlBtewVMDLb1J9kGPh
	 zmxXrGxpPVJ1wOiFNJMA+PyWEd6e9ImYVIIGQBXrJTqh9zdCPvSFAOa4i9dmaPeWaW
	 4GThPBz05H3r9TM+NNqnHNogxkbekg6bBCnWTlktRmmcmFlA4GrMImGmEGnPoDIjKu
	 j0VY0EX3UplQXcPHfBBuoeFdWikuoXGF7uABY6RzbQLxZ7FyncHzEXIVgwN6MkNCE0
	 XPWeuWPQg4E5g==
From: Vinod Koul <vkoul@kernel.org>
To: vinicius.gomes@intel.com, dave.jiang@intel.com, fenghuay@nvidia.com, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 0/9] dmaengine: idxd: fix memory leak in error
 handling path
Message-Id: <174723495468.115648.3407728742931342425.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Apr 2025 20:02:08 +0800, Shuai Xue wrote:
> changes since v3:
> - remove a blank line to fix checkpatch warning per Fenghua
> - collect Reviewed-by tags from Fenghua
> 
> 
> changes since v2:
> - add to cc stable per Markus
> - add patch 4 to fix memory leak in idxd_setup_internals per Fenghua
> - collect Reviewed-by tag for patch 2 from Fenghua
> - fix reference cnt in remove() per Fenghua
> 
> [...]

Applied, thanks!

[1/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
      commit: 3fd2f4bc010cdfbc07dd21018dc65bd9370eb7a4
[2/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
      commit: 817bced19d1dbdd0b473580d026dc0983e30e17b
[3/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
      commit: aa6f4f945b10eac57aed46154ae7d6fada7fccc7
[4/9] dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
      commit: 61259fb96e023f7299c442c48b13e72c441fc0f2
[5/9] dmaengine: idxd: Add missing cleanups in cleanup internals
      commit: 61d651572b6c4fe50c7b39a390760f3a910c7ccf
[6/9] dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
      commit: 46a5cca76c76c86063000a12936f8e7875295838
[7/9] dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe
      commit: 90022b3a6981ec234902be5dbf0f983a12c759fc
[8/9] dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
      commit: d5449ff1b04dfe9ed8e455769aa01e4c2ccf6805
[9/9] dmaengine: idxd: Refactor remove call with idxd_cleanup() helper
      commit: a409e919ca321cc0e28f8abf96fde299f0072a81

Best regards,
-- 
~Vinod



