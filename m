Return-Path: <dmaengine+bounces-1781-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A289B31E
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B012819B4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FB3B289;
	Sun,  7 Apr 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHkxVe6T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6144364;
	Sun,  7 Apr 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507969; cv=none; b=SYinlx1Ni8i5aMLBQpWHrT4aT3aY6ysg9MKF+gvjNnRHzFNsB5Ln45DqihsA6hTRM0U7CYZGrm5gzrI7TlzxktBv96fPT2ZdDbdejsav9S+lbyBv4rCTTl9G7vVx921Q8bqfAbRkNnOImTMNTQz0eXvJp0qi5UI+KTb9YaWeGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507969; c=relaxed/simple;
	bh=b7JGOO4nA4qvxws98Kohvmcz2G0+8kVdEecptP2DllY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WxJboTKfCYLpHOUKuHp3C3cZn1IBkEkZlOGV5buzM4bbn9v63F+NOpG3IXpEPMmVCRSDK19gKr7kQDKEWhXoDMI/BbyXBUIRVmv8MW0oJ21HdG+znaFqtgF7j1r05YX4XYuMA1q1dZA5xMJhGdovHrpQmzykrziJqmek4bMvrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHkxVe6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2E2C43394;
	Sun,  7 Apr 2024 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507969;
	bh=b7JGOO4nA4qvxws98Kohvmcz2G0+8kVdEecptP2DllY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VHkxVe6ToCyilEFZS4tAVxEfcxwIInqruytSyuLo/nROp6mLjedBj7jFNWmJ68oLd
	 omMOXJsqOgZxmqHOSxqbO1/RaFU61i6juZCc/w0ec4BLXt1Gg7sSTBf8CmLWnEc5Gu
	 Ls8D5qjqoTQPnW/aAVxugGo4WIe01b47j2hJIl2TzQH424TA2X5Aa66xa85TnCVCZv
	 QYLKCjrhahvWHF417g5DVvqeBrxzk/SkSdSWJkTxpCFs/E4na3thKDzOjrPY+fzUbP
	 bV9o6dijgV6i5WRLtA64E1M9vINGUaxf3Z11BZi/TOX7ekt0bphqzkBKs+ssW/YzHf
	 s9lh5W/HnZ98g==
From: Vinod Koul <vkoul@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240311222522.1939951-1-robh@kernel.org>
References: <20240311222522.1939951-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix
 data{-,_}width schema
Message-Id: <171250796621.435322.14423205149243824027.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 11 Mar 2024 16:25:22 -0600, Rob Herring wrote:
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



