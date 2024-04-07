Return-Path: <dmaengine+bounces-1772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E70689B309
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F82A1C220B0
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530433BBCF;
	Sun,  7 Apr 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHURN42e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40A3BB4D;
	Sun,  7 Apr 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507938; cv=none; b=sYabxQqEwQ93CsH609n/xeXxEyS1XvcnBIubUMtlX41+d+/baeJLMduxlucIcdZNMAis4VlsE0MddT6WJgxml2CaCP8x1Kz2ndFeGegNp8CTFHVDf2rPg3n3WqSAKAD5oHh8iNJUgS54PfmUzZ5fvwXyWvIMfEUI8K6fWvmgRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507938; c=relaxed/simple;
	bh=DZx1AWIYf4Xb3DOn6yperFnhbIP5Oxh22bdPAy+WT8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o+5dI99//nUYeb8DOn7JOvNrqEKy6J5z5fZ/lcVgXDqtHz9eoMABlNYiMrpp+2igEMHUPvdhm4hB6qNIieyMcUM85rFsH0y1sIKaaa2aQ4VcO7JCxHZrC3ufWjzPVzgsJihen/eSI4Y173Hin5LgC8JkAfPVmtSNYgL00vkd2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHURN42e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A217C43399;
	Sun,  7 Apr 2024 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507937;
	bh=DZx1AWIYf4Xb3DOn6yperFnhbIP5Oxh22bdPAy+WT8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jHURN42eE4I32rBhiVqjuC4F7eVpM3B/4psqeEgp8OJH0KgKQJBSeMyzfkjgmPeca
	 zEWKVj+afPCRZjZU3i3CyDqGqmS6OFdMJP2AjdC54qktxlvwk/wfwwXzFYyWGTFRa4
	 Ao8HsmdJQCftirD9+CqlrI0vNdbMJgL103PGAPZfg4PCzG/VqvBex3fzn4ZUoQju92
	 zVRp43OLWIx2tq9pnOgWyVjsEvLlfNOfgdp75Fy02RfeB1g0aswQkmAPeOSdf8MbP8
	 y2ac0arb2L7mwrQk9MZNzDkqIFfVjD3fhhwd7SsdvyvsqB0bTrTx1XYIN52KJN5zay
	 3mHUL9T6aloIw==
From: Vinod Koul <vkoul@kernel.org>
To: andriy.shevchenko@linux.intel.com, Chen Ni <nichen@iscas.ac.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240403024932.3342606-1-nichen@iscas.ac.cn>
References: <20240403024932.3342606-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: idma64: Add check for dma_set_max_seg_size
Message-Id: <171250793580.435322.3147745413867845577.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 03 Apr 2024 02:49:32 +0000, Chen Ni wrote:
> As the possible failure of the dma_set_max_seg_size(), it should be
> better to check the return value of the dma_set_max_seg_size().
> 
> 

Applied, thanks!

[1/1] dmaengine: idma64: Add check for dma_set_max_seg_size
      commit: 2b1c1cf08a0addb6df42f16b37133dc7a351de29

Best regards,
-- 
~Vinod



