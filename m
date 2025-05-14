Return-Path: <dmaengine+bounces-5172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29511AB6ED7
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390AA4A6C14
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E127E7F0;
	Wed, 14 May 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/O/94ew"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5027E7E1;
	Wed, 14 May 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234997; cv=none; b=scPbDA4skmjUEd4eba8HcFiv8lUs2XAp7aH8Poxe9S8wAqpvc83QC5DBYhNmjHPFXMp5LUWcSX8wHY5N4wfFD/XLG5O8peZtC/b2EJJDDPa81FcOvSOt5jE8SB23AT751hjnw/vIWc8hjWAaixBMLhUEcnCIpDBBMM7J7oqRQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234997; c=relaxed/simple;
	bh=Z78YSJN+IWWPJ0bfBj+aErgKm7RTh/KAvugv2nrC6fc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A1bu0aHFyFI4QoeAPU19m2jM1XX+LwkTtuzI2VY+aI5w7jP24WVrUZ1v51Svy9Ik6Pq4fQ0BIvyofG8uHe2fBIEUIFW0whL1vXTR/xhjSP8co3+1h27lTrmu03DbjhubzJFM3UJkRbahzQLVVQ0/cqnkyupAHFhM/QM4ND34KME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/O/94ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43220C4CEF2;
	Wed, 14 May 2025 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234997;
	bh=Z78YSJN+IWWPJ0bfBj+aErgKm7RTh/KAvugv2nrC6fc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=C/O/94ewXIRjGpfknkJIX5awpbklqivu6h/iBL26ueiZz8kO9uiGBxZ3Tfrqdpe8G
	 1GXLHJM6A82ELrudAvAafLTLz099pcpgRxGAbkGTgOSJOC59Y+m3oc3u+vzRO55xUo
	 gDn1C43bRc876JYhOFD49li0onXWuOHMOOnHvS+NAMKB9J0v/l0xA+YhkBND/vEvXD
	 rG5OAjXeTlp3eBvRpQg4abdxTxTpg98M+HlnToYQYF2ZavmYClh4eWcT1FNWzMa4SM
	 YiTshVzcuZ9CY0L+6GRoatD9R4cGoim14vPUOvERBWlKdiy3OsQyEGtnMwLJBnO/AV
	 TL35K15VrSfEg==
From: Vinod Koul <vkoul@kernel.org>
To: vinicius.gomes@intel.com, dave.jiang@intel.com, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Eder Zulian <ezulian@redhat.com>
In-Reply-To: <20250408173829.892317-1-ezulian@redhat.com>
References: <20250408173829.892317-1-ezulian@redhat.com>
Subject: Re: [PATCH] dmaengine: idxd: Remove unused pointer and macro
Message-Id: <174723499596.115803.4880566184817408236.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:15 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 08 Apr 2025 19:38:29 +0200, Eder Zulian wrote:
> The pointer 'extern struct kmem_cache *idxd_desc_pool' and the macro
> '#define IDXD_ALLOCATED_BATCH_SIZE 128U' were introduced in commit
> bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
> accelerators") but they were never used.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Remove unused pointer and macro
      commit: 3c018bf5a0ee3abe8d579d6a0dda616c3858d7b2

Best regards,
-- 
~Vinod



