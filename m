Return-Path: <dmaengine+bounces-4400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684AA2EFEA
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D78E1888CCB
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0123E236;
	Mon, 10 Feb 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5n1kwBZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B523E22D;
	Mon, 10 Feb 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198122; cv=none; b=nOz1Rrd6yWx+wLgXG2Rf5k/wj030Ls/B6isJ+GMF5DN3nDOKIzCB0Q/Iogzo5kpEgx9ooDU/rYbGYCOXMUvTZYTgUcDS2WxdOd6P3vUPPsH9TkFS08CZZ378vr8E2NB5mf1f/gYwpw8/m4LmSV0sRpI40cTmieog/w1dwB1b5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198122; c=relaxed/simple;
	bh=WLk7NJc1mCWQv3hAJK8S8rieEXIXo+DF8ykZnpO3J0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RUt15d2P5nfat9ao6zOV6LD4+2cUcIJAsHDCthnW0tzQbQ4Qh2eTPXJHsw3hkmnx6aWtwddWL/jKrC0h9KNsi0PnSJcZfQjyeCVpdieJ/VY1BW8+hmmCjD+AbjOemgyYmr0RNMo4JcfOhLGoRMB5cvfCyTpFeVkeEYhsdegqafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5n1kwBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDE5C4CED1;
	Mon, 10 Feb 2025 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198122;
	bh=WLk7NJc1mCWQv3hAJK8S8rieEXIXo+DF8ykZnpO3J0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I5n1kwBZ7DsLMEcEYTnXO0qPqDIIRaKNyOdc5VYmtgBghWIUbRUIfcl0VG9A0xs8J
	 X8DzyKf+D6Q8MBKUxWxyrQ3IVEcodA6uzGOKL25WE8NZEUtuD6CFcL/Ko97OpFkSX4
	 UW2CwOhteypLczWvaKo7YPciPjWrRPAEQ6f2l2aePZJa820HuEe+RWXiJ13aicg07p
	 5w3PDSdaLlVxOPBuac3MZdsOCWeJhS5hBr3nygNgaeUzy1t0yauGa9D3E0qkw7Gs7P
	 IqP1PsC3PvpBwtF382yGMQSMIn3J+HWesbcq0XPYVZk3kVoJvD9kX5TAG7rOEOzsrX
	 blHnB3VD527xg==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20250131173551.3979408-1-fenghua.yu@intel.com>
References: <20250131173551.3979408-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Change maintainer for IDXD
Message-Id: <173919812032.71959.15536098941892635356.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 31 Jan 2025 09:35:51 -0800, Fenghua Yu wrote:
> Due to job transition, I am stepping down as IDXD maintainer.
> Vinicius will take over maintainership responsibilities moving forward.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Change maintainer for IDXD
      commit: 753f324c4caa154e57b6dfff8fba7769dd76a0f5

Best regards,
-- 
~Vinod



