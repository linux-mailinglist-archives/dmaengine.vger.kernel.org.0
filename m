Return-Path: <dmaengine+bounces-2666-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6892CF06
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B931F25952
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBA1922F2;
	Wed, 10 Jul 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2oATiEE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAE1922E5;
	Wed, 10 Jul 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606503; cv=none; b=CIn5GwxqBLwJN34MF2SQ6ug7yeVvS4vZwTzbyvLBVWdwrmKghqBldID554CZeQ0ovypZgDxUaq5vm5AlBrCFXkBMA1SwSRrFtRNo14vWvCzDzRtUe0KRcdtF33nrjLBDPgQRXdPGc4yLbOFgAsqOgOLc6QIbFmLjXSkO4lwhMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606503; c=relaxed/simple;
	bh=UTFqS6EkdxsAPjSqOfG7927Us3cuGKYGj0JdQC2HXKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nq91t8LhUb9W20M0c9SL/5uBqJcQmrdFdC5OjR9UlLBOHWaDgK4VrqeToQDYKSybAu6K8I1mGdte0MSyyUZ+M48HOkaiEA0gdhADTVNHO4LDtmEpCBx73lSIrdnuK6vsgS0CELEbU7n3fQ9X4S88AxmGqveqDvIMxeop6/0aIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2oATiEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E62C32786;
	Wed, 10 Jul 2024 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606503;
	bh=UTFqS6EkdxsAPjSqOfG7927Us3cuGKYGj0JdQC2HXKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m2oATiEEXpamFuKuTcQVvzNfBR6NRq03A9HAHEEg50ILgunVaNmfBwc1eQeFJmnya
	 iH7U8LmtytqXc8Kng4ajD4e23Q13jctr2+Z275dsts/VXz/q9B4pVIYgmnKmDqz9rr
	 nKvmJQZMbdi9s4J1Q9l37GIr2czveiA25QLqeCKW0QuD/8J6b3d7gVSP6gDHwgNVpi
	 4yw6UB2yeSbwN8u+jmTHrInHRoD/TBeKY2aoQefeCts8FJiyc18fh+h+dHOaX3MYWV
	 4aORFLIXQYi1CGBFNsBXNTRagVA5qBQiFUbtE8XAwPXihrZ32eEqtOmTKq21umjkrX
	 6bzZlR1cgwaLQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240701195717.1843041-1-Frank.Li@nxp.com>
References: <20240701195717.1843041-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl-qdma: fix interrupts 'if'
 check logic
Message-Id: <172060650068.379904.3242069237188980205.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 15:45:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 01 Jul 2024 15:57:16 -0400, Frank Li wrote:
> All compatible string include 'fsl,ls1021a-qdma'. Previous if check are
> always true.
> 
> if:
>   properties:
>     compatible:
>       contains:
>        enum:
>          - fsl,ls1021a-qdma
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: fsl-qdma: fix interrupts 'if' check logic
      commit: b8ec9dba02a74797421c52b1226b23a4302362a6

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


