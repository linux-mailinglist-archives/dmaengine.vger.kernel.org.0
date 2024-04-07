Return-Path: <dmaengine+bounces-1773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65689B30D
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243AEB22A38
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E83BB50;
	Sun,  7 Apr 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/V892qu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D83B781;
	Sun,  7 Apr 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507942; cv=none; b=lrDDRFmg9bJjmi33AnD+XmVHgLeHfkcJx4MCeWRJfXRqDzGW/LDv8A60pYugqDrjzYY9JXBgoENfFn8lbUMiRGooCcUd5MANi1OJwGpJTvsMhPYRDoIWTHEtKjFuoDISz+PmvAsIyH/su6OArVLZWV68TnQHoqO2iy64pnbYsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507942; c=relaxed/simple;
	bh=lR3fA0ZLEMf0cmBwQN6NPD/wYmo6JGFOWLAZy6B2+ME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mh7pgP6nfrkOIGkNRxQg8oE38sgXIYLaVJYb2oKXsOnWRA6to7Psw+mF25McYQt/J0xIzutKcslYVNqV3vnNgIv7jU25UWAm77XyRebL9YPn91Ddt3vSIpGM6ROBbvgxo32mQbRrmI4NFypChph8B/B2rMMMwXeEGKFzTzVbeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/V892qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B04BC433A6;
	Sun,  7 Apr 2024 16:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507941;
	bh=lR3fA0ZLEMf0cmBwQN6NPD/wYmo6JGFOWLAZy6B2+ME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K/V892quFgKEKE96KvvkyzpeO4gaknCiTzhEB3MORk8AiQZHenGJwVEuxkXhRh986
	 ul6m5TylWeciuqIhTwRanHj9uPS0NyyaJTCD1Zp/ULVb+QYptJImMEmtzOsZMBV0pM
	 CPvoAML/UGr2QpYdTFc2Evqj5OefIiOJ+uxJmKy5AYqxwmk1VjSzQbDZWQDUJsPNMv
	 EA2+HGX4s/UWftpbX33DoT5/Pgvw8MgjUFIPYfBoUPTBi11LyNQ16gmBHykQk7v+9n
	 6kf5pGn/xcB0gAaJyexmtNrHF+QVArEswXKgPgbV8V4oVTCErlXjATcdbErKk1JdGw
	 WhjrNsnkdiZaQ==
From: Vinod Koul <vkoul@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240401204354.1691845-1-robh@kernel.org>
References: <20240401204354.1691845-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: dma: snps,dma-spear1340: Fix
 data{-,_}width schema
Message-Id: <171250793798.435322.4956287929359019593.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 01 Apr 2024 15:43:53 -0500, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema
      commit: 7eccb5a5b224be42431c8087c9c9e016636ff3b5

Best regards,
-- 
~Vinod



