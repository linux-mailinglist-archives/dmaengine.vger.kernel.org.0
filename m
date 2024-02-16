Return-Path: <dmaengine+bounces-1031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512C857CB6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541E289189
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB9129A83;
	Fri, 16 Feb 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbvU/Ry5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC3129A77;
	Fri, 16 Feb 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086909; cv=none; b=NXQ0ulMx0yBYn0krhiGhB/BGJ1KlvChhoxEQg3ZcUutj7tq6LVfdQ/pOmKLOXkDxJGtqvYyAjWLkS0lBoT+y+HcJqtVkqNxUfEHgiu0UJDFFf+UJm1nCSLq+J8DRVb4fw3G/prLbcEu5wtS+Zs9f4hJgsFL/s876Vno1S1zd0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086909; c=relaxed/simple;
	bh=riZV/gkwObqh/32FznqVlHkFGhQ6oMb4j7nisfi+Pj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O6D4bN9k82Y3QzuRjURl54DixTOCjIXFaT9zybyTLATnCWAbj/2zqvsmtSshJQ2egbGRcEmxJISBfIkphjRGcfZ79fDm07HU9je7Mhh0ORprtl+U7t/SwgnZeSe8TZpeU2JC/NjA99CaJX0rJiyjk+1vDMldfMRd/gkbL+6qrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbvU/Ry5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F96C43390;
	Fri, 16 Feb 2024 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086909;
	bh=riZV/gkwObqh/32FznqVlHkFGhQ6oMb4j7nisfi+Pj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GbvU/Ry5/vrxGXr+/cJ3ce+0WWNod37nCHhivKlwvOvOdU5rB51aeeuNiEHWGi+8U
	 TXcgT9qIiajvxhmUVcdq9QiyvNJO934lWk/dSBK1mHGl1qC52TivCDJiNA3gjEkbOK
	 Jujz3PrRMuF3/zL1pp1CFwJdkmJu+dQ9Gl/6h22lnW0l/yY6H6QSrS+VpCo7YWm/bT
	 lMZfmM73SdV1EKg7JQYCsf8aadyoODC1NHPcwbSRF0ag4mDj9WmJ+iT6fbdS4LMrnp
	 OiHS+V5j/x/7KZw/4N6vqdOTXTkXo9IhSr0aJNQyCwXOneWWbM0qaL2814yyhoK2fU
	 wEBhPlEo4mgjA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240213063919.20196-1-zajec5@gmail.com>
References: <20240213063919.20196-1-zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: convert MediaTek High-Speed
 controller to the json-schema
Message-Id: <170808690375.369652.1439304081643409723.b4-ty@kernel.org>
Date: Fri, 16 Feb 2024 18:05:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3


On Tue, 13 Feb 2024 07:39:19 +0100, Rafał Miłecki wrote:
> This helps validating DTS files. Introduced changes:
> 1. Adjusted "reg" in example
> 2. Added includes to example
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: convert MediaTek High-Speed controller to the json-schema
      commit: fa3400504824944ec04bd3f236fd5ac57c099fd5

Best regards,
-- 
~Vinod



