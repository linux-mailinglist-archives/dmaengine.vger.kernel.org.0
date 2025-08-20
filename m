Return-Path: <dmaengine+bounces-6088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A7B2E437
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B747BAFB6
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA782765E6;
	Wed, 20 Aug 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn8O+ziN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983512765E3;
	Wed, 20 Aug 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711754; cv=none; b=EzIPAn0TYDi1UhPsrG08r3hcMwcLnAj1J8WQGaebI4Zf9u3bx1jphSoNizD9o9tMxdeuFxfHiQiMqxdrRBUcQm4DDEArMYIt0numswr0ROTGaWuvNIh+ufg0kF0NHr2KQivsjv6os0iO23buuEVQ15MvRdJauCPoMR69d9KX4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711754; c=relaxed/simple;
	bh=Xy0bu3vQAEGmTyNEoI30KC+Xj+Gjlxb6czl2aL3y4WQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rjxlTq+GXw8raEzYoeOuTCQ1nPzjgnbZ87vBKs7A3Ub9DrNW0QtUgvWJ/tVRFP2sw0hPctRDBpOH9yyw7pIa70Sos657VZ2yuGPewyOjz/3Cl3xIfNbah4jY6opekNdOVA+Qb7cmxT7/0gzpktpQtisJ20XqrbNTlgc3ddMJrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn8O+ziN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344AC116B1;
	Wed, 20 Aug 2025 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711754;
	bh=Xy0bu3vQAEGmTyNEoI30KC+Xj+Gjlxb6czl2aL3y4WQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mn8O+ziNQTrcb0dkGA1Ju1lIaGKs1IfFjbXWmjmlPs1KuWho2LuamxajVQPUzc7cr
	 V44i9ZWtK/WYfPY15tnfIlEedV11BjOC0Nx9D7O3/9LOQACUWePB9UwZ8tVYSLE44J
	 BlXkYM1gioXW5uUtFiTZ7Jk6u8q+98jqYdDyLiRIGitqkgYeWTrDxnzH7xsP94TMzQ
	 sekRoNFW632XvpNGRSv/ia9GbQm2+JuubyLG0xoHn7NhFvl6bVf/D0v3Rn5PLes28u
	 uaaUo+p9hRoB5rJI47zGT7Kl1wSmVwuXxzds4SCn1+k7MfNkwWd3HONChIThsXp7ds
	 S8hFP5gs1j89w==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250801215936.188555-1-vinicius.gomes@intel.com>
References: <20250801215936.188555-1-vinicius.gomes@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Add a new IAA device ID for Wildcat
 Lake family platforms
Message-Id: <175571175221.87738.9485571234240893975.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:12:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 01 Aug 2025 14:59:35 -0700, Vinicius Costa Gomes wrote:
> A new IAA device ID, 0xfd2d, is introduced across all Wildcat Lake
> family platforms. Add the device ID to the IDXD driver.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Add a new IAA device ID for Wildcat Lake family platforms
      commit: c937969a503ebf45e0bebafee4122db22b0091bd

Best regards,
-- 
~Vinod



