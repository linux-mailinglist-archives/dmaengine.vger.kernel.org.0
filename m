Return-Path: <dmaengine+bounces-783-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B9836D02
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F60328CF9B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB0524D2;
	Mon, 22 Jan 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7OomzB3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71F524C9;
	Mon, 22 Jan 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940707; cv=none; b=MctFX7XZD4gDAu+k0BQ6vIywWG1dvFxegnC5RyRuI/GIQk7emXLwKhG48eKCtBS4iGxG2m4yhLiYftzRD10o4SVTB/zJCv9cp7z2jROhTcaIaPAskWHAs0N6aOAIniyG1vDFdiEeE1bZlKTw4mCCG43Wnsw6jGDje5j0B5PGLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940707; c=relaxed/simple;
	bh=ntY0pIqUsfyCKunsliPOebBGD32kUOIt4M78JdLJE9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LVI8X4eot6rIjhdQYQEWbJOxfnAkayvyXDYIPrDQN4j4dxTPzds7lWnFWKQXk3aOjKxWb6VZtBkf0LFSHbsrd6ZoBh82m9MYChvUt3lX/PGYB7YQmHDZ06y/0Qr7rdEl2Rocd2opOZYChwHX4O/ylDXIUePy94HAS1G6ByV6TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7OomzB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB164C433C7;
	Mon, 22 Jan 2024 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940707;
	bh=ntY0pIqUsfyCKunsliPOebBGD32kUOIt4M78JdLJE9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T7OomzB3c7WGSnox/dtOZ+zf+iQwjnuzJzGQbe4/lGf9S5XrPPUJ1ZyGKpjxd9b1E
	 3KYNEMoD9nsywl5+wwHlawvWPvwK1p02LH7MtU3x5WRnAyEL9TSVxdBzXGGYRPRbfR
	 UzzQykk8cs1RDkI1Gx9TxXHCoUleGycVu89owWqzI/MdAx3vyjDKyjnSBc1QHW5jKU
	 aT4HWxxDuIjLjfgU/K3d6gGTGSFSRxmarm64At5GjAHny+Ai+7+qvAlMTDL4eu5Izf
	 CIgOUDIQLexgCalxe/VaYOz7973K5cUHEl6jaejOArmbhWAt0wcPAWbDDaThMlgVL3
	 dCE+IxEC20pdA==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Kunwu Chan <chentao@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240118031929.192192-1-chentao@kylinos.cn>
References: <20240118031929.192192-1-chentao@kylinos.cn>
Subject: Re: [PATCH] dmaengine: ti: edma: Add some null pointer checks to
 the edma_probe
Message-Id: <170594070534.297861.9253452446019870921.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 18 Jan 2024 11:19:29 +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
      commit: 6e2276203ac9ff10fc76917ec9813c660f627369

Best regards,
-- 
~Vinod



