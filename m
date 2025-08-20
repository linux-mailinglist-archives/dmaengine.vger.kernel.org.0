Return-Path: <dmaengine+bounces-6083-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95EB2E41A
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7099E1897A8A
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6002522A7;
	Wed, 20 Aug 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4PBjgTL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4038258CC1;
	Wed, 20 Aug 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711554; cv=none; b=F23z6O37QGAAn5jBWcWC3Ldcx0VHEjvdRenNYvLhRJwnCZLy/cruk5BVgah5zgq4KBvIAkrqbbN/W2M65C7aDSlYoqKr8zq5cwr+jM6heZ3z3xUmGp1p0jsx+na3Nz88fr4bP9cm9h6SR14EfdKjgh6MyEU7N/vNbdwOPoODh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711554; c=relaxed/simple;
	bh=VmLARSRZ3emeAhF8ETKiy5Sw/HbEJcOO7vCEichxxHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OKCC1a+fwmwyM7ayX8Gdumzf81TdAmAof65RCOvMNeSXe2TXC3oElgsar5Z7N7fOiL/FJHLAVsCSbf8jvgcTkgw8R7MA44H15fD4gEjfZru76u/tO0PUezjAPTHn1kFt8tJhxLTOY6E4fKIcM5PdxWm7+Cj0W2ahqPqPAfikSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4PBjgTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B18C113CF;
	Wed, 20 Aug 2025 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711554;
	bh=VmLARSRZ3emeAhF8ETKiy5Sw/HbEJcOO7vCEichxxHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u4PBjgTLb9AaFKW4dEDaCfaluABgXB0w7ED8NnvTtaddkAi0qworgH9jegHnLvgeI
	 l6ht6tS2J0dg6zYJknSoJrERAO8fd2BvhfBcn8MstGgCJYn1JvyQRUzFdSFQPRjL6F
	 mnZjimospDg9yilqP1KZIFaiEuhUei4Rlj8USAFq+1qgVTKJVpDl2NThYOfsB/73TT
	 QBS1EtZvFnuIeJ1fIyNGgNLZzlSFpQW5o34C5Un73vBzC0rQtFVtg3sUowj8W8b6cy
	 iQK2gkvq94nl+0wSxw0sh08kqZ+0xhE0t2cg6hR2PUv5MU1UO9n9vrm4z7A/E/DUby
	 99UgrZ7KuRKWA==
From: Vinod Koul <vkoul@kernel.org>
To: vinicius.gomes@intel.com, dave.jiang@intel.com, fenghuay@nvidia.com, 
 xueshuai@linux.alibaba.com, Yi Sun <yi.sun@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gordon.jin@intel.com
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>
References: <20250729150313.1934101-1-yi.sun@intel.com>
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and
 cleanup issues on module unload
Message-Id: <175571155143.80631.2976104483965927036.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:09:11 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 29 Jul 2025 23:03:11 +0800, Yi Sun wrote:
> This patch series addresses two issues related to the device reference
> counting and cleanup path in the idxd driver.
> 
> Recent changes introduced improper put_device() calls and duplicated
> cleanup logic, leading to refcount underflow and potential use-after-free
> during module unload.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: idxd: Remove improper idxd_free
      commit: f41c538881eec4dcf5961a242097d447f848cda6
[2/2] dmaengine: idxd: Fix refcount underflow on module unload
      commit: b7cb9a034305d52222433fad10c3de10204f29e7

Best regards,
-- 
~Vinod



