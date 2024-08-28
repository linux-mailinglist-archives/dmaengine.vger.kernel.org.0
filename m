Return-Path: <dmaengine+bounces-2993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C405962FAB
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBFC286004
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FEA1AB531;
	Wed, 28 Aug 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxZp07sM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA331ABEC8;
	Wed, 28 Aug 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869021; cv=none; b=R5+f6kqPh1TqOwa8xcnPiT4pJzF3q54MCsHQDalWIq/OphL+xCV8fXeA4ogxwMGjAsl9z26tBqu90B91irj7Ip1iD3DSgl9An61vhyXo/ShxHU9vDU3WTftQ5Ve6yF081d9XAeFel79WjVqcFqbVsbCu3zvgEaCZQx0Pq6a4U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869021; c=relaxed/simple;
	bh=GjdvHR8ssaUVlCsdLyBrvVmYXedIq0bW8cip4iykxYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g3dwjDuBrf5ksSoTAFFSbskaXkm1MoCmBv2vk4ZYCJBILpkRx+jkL3maUqAsut16w/Kl4PgSRjogkhOFbfUj7ZRFqVscNn7a8XocdhPVjBetm29lcGV4Js0HDnzq7X/FMlg+j1t+T8ovIuoAKNNoiCCI7RfY6ihIT8/4FYhIulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxZp07sM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6170EC4CECA;
	Wed, 28 Aug 2024 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869020;
	bh=GjdvHR8ssaUVlCsdLyBrvVmYXedIq0bW8cip4iykxYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nxZp07sMMoNvXs/ku8LSGTG5HtKIeB9fax4JbdR9VKvdh6l4hVhUkgZJDN8YARPL0
	 Elhw+65K8cRBKMcsRAnODfAbPoEuE6sdimmCT7HesyfFyqbgW4q1VOKfzCenhFCUYA
	 6OfcOaiRbYVI5+hcbFhUvPJGZIGPe//puLh46KH/QNix4p9ritOh7eHCyNUMIvUTsq
	 IvOHA4pBJ4/DN4H1OlKmdkh7lu71gQdaeTNoIWgjcktza2yima7Ll5IjHk3bD77cC/
	 A76S5c7hEGvo2V4oEao91qNhLgXiKISAUNgWPK9+14+72FVzj14jcxWH+KB1x5WST9
	 A7wzFB4KezmAA==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, s-vadapalli@ti.com, 
 Yue Haibing <yuehaibing@huawei.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240810094540.2589310-1-yuehaibing@huawei.com>
References: <20240810094540.2589310-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: Remove unused
 declarations
Message-Id: <172486901902.320468.6914210573269380819.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:46:59 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 10 Aug 2024 17:45:40 +0800, Yue Haibing wrote:
> Commit d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
> declared but never implemented these.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Remove unused declarations
      commit: 4bb59323450db610b06c549fa4d5936e94fb9a36

Best regards,
-- 
~Vinod



