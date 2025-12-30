Return-Path: <dmaengine+bounces-7982-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C7CEA5AB
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 244773016EED
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E1254B03;
	Tue, 30 Dec 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHq7+OQn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D17225779;
	Tue, 30 Dec 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767116844; cv=none; b=Zu+xRmAlqm9z+Juo+cNPOpxGugPN8oyrpbhyUbcNj024WfP86BCmlVjkQkQycQgJE+LP6269uvOPigakU4SLzfM5Owhs5k5MP/LYTF3yiiVsrqWQqAwdHXpu7FAbKNHW2wnZCgZwC1RFPnZcFUZB/3PqYRFwP4IahZW7BePePrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767116844; c=relaxed/simple;
	bh=9Tzt1v79UocLdfoE8Ziycc0C4ZzVCqV9HIYQnpWxpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxyHh++/Do+5ZNLx4K2fNq3zncoF3QqRcENTV64bwLdqhPTxGBoQNRroLXjkVzAseP5AWVk6GlU23q4N1eEMO2pjgMh6l2K3YNVed/zeACZjKvVrCgS0tVQxrgvuSL0bQlmyk19fEhjyDmiOQGBynCqTJaaqDv56P7ZmXRwttxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHq7+OQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB36C4CEFB;
	Tue, 30 Dec 2025 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767116844;
	bh=9Tzt1v79UocLdfoE8Ziycc0C4ZzVCqV9HIYQnpWxpKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHq7+OQnPfCkUwLu951WCbcS3KJQPaoDiMRREFKZDKIfzLTEsgptaXBiJMTqj9j5b
	 Sw0rIcQ12u/AVJF9pqNPw81RA1RX/9ZCVwWwwehQfFj0z4tvJS+WK455q2eek944AT
	 RKSYO02c623QJvQmIv+0ogsaiiAKvoEuaIQz4XdPSp/QatNgxE9lLZpZksyPN9d+jH
	 IU/mqk2WfO9vSYPnXOGNVr7RIVTuDnWDSFf/6WN3m8GT1KGUONr+9dFFA8BfIc5+Qg
	 VWt+aucwZ1VFnkXRu/2pCzqciD265evGRtn/Qe/WhdayUR/b8JJqfc8uH6VwS8suv1
	 f7qdKAL/EdLpw==
Date: Tue, 30 Dec 2025 11:47:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: pl08x: Do not use plural form of a
 proper noun PrimeCell
Message-ID: <176711684252.854117.1334721306263110697.robh@kernel.org>
References: <20251225181519.1401953-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225181519.1401953-1-vz@mleia.com>


On Thu, 25 Dec 2025 20:15:19 +0200, Vladimir Zapolskiy wrote:
> As a proper noun PrimeCell is a single entity and it can not have a plural
> form, fix the typo.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


