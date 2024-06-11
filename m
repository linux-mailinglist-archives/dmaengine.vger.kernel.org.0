Return-Path: <dmaengine+bounces-2339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEB90437C
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529C22809DF
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DF7581B;
	Tue, 11 Jun 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7B8+us9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50375805
	for <dmaengine@vger.kernel.org>; Tue, 11 Jun 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130467; cv=none; b=cycSWeuuo6aVl7GNU0eHrxaFWyVk3Cf24O72cDxTATZJvWAIsnPyuAvcwGWFTb6G+BpGLrU4h4NlDxtKevM8dKG+e9JjTEVNModZKZ0Nnhs/byQDMX9NFy7/tkrH0TYAxkF5l7N/X0+g/hl9B7TvznpJtUUJh853j4ocSyhQTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130467; c=relaxed/simple;
	bh=jMlovZ7vC5VNGKyywKf1UiVj2CtMqUjE98epOSm4TcE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G2UA4bvqSRVwSuXIpjlFvYINJ87Xd62+IDrH5RUJf/08PZVIzKWkFusA4yizEYs5Ho9Ql8kDkKuZ0mMbAcoQ1Y2HZEAjYBt5xaiKFQb1Q2+mfJK8lWJkQt4o3pvX0Xu9FDUM2Psd5o2K7tyyXrFss33e6/djt6WNG0cH0mRscEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7B8+us9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F16DC2BD10;
	Tue, 11 Jun 2024 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130466;
	bh=jMlovZ7vC5VNGKyywKf1UiVj2CtMqUjE98epOSm4TcE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Z7B8+us9YWL5QsBsGzonAoMpTP1eQ3TmGH8hfzV/CrlOUSfvRjbcuJHxzVHvmnTAw
	 ktv65Lvlv9yRbwBHM+Kplwpe2TGpWUO0jdOIkqTmDjsWePamjbtzO7nJnh8VBvv0xK
	 H0rgN4ALhT2KDCX5TT2fMNVjy52a0BKXnyWgse0ZWSIid9P69Pf6WUafoJn/c8HVRI
	 qsDCFvb055J1dN4MYzfu2dWe0CgXymw+l2kycbtWYneYghkhajFqaMwrdghrTS9gz5
	 TOwe9v+0ff98Ult/EPXBwrbbtxfc5KX2OykJo8pVNq4GVa2tVcdaSnlkAW4//o56xV
	 bY1hsjp11PxoA==
From: Vinod Koul <vkoul@kernel.org>
To: fenghua.yu@intel.com, dave.jiang@intel.com, dmaengine@vger.kernel.org, 
 Li RongQing <lirongqing@baidu.com>
In-Reply-To: <20240603012444.11902-1-lirongqing@baidu.com>
References: <20240603012444.11902-1-lirongqing@baidu.com>
Subject: Re: [PATCH][v4] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
Message-Id: <171813046508.475489.7956630639104516674.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Jun 2024 09:24:44 +0800, Li RongQing wrote:
> Use list_for_each_entry_safe() to allow iterating through the list and
> deleting the entry in the iteration process. The descriptor is freed via
> idxd_desc_complete() and there's a slight chance may cause issue for
> the list iterator when the descriptor is reused by another thread
> without it being deleted from the list.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list
      commit: e3215deca4520773cd2b155bed164c12365149a7

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


