Return-Path: <dmaengine+bounces-3857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE29E09EF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B548A282CBF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4C1DBB13;
	Mon,  2 Dec 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvuOuqYI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FC1DBB03;
	Mon,  2 Dec 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160647; cv=none; b=Uk/F9fytOgk7RKJ1W00bZKpa7BGH037+Vhse1i71aBamBsune58Eue6nXTjrGuhuypebiulMD+8Hzu9XvBxvqiYOAddGTxW/hQHv9+D/tgRRYCPn1y4hStVx5LbuB1pjqzwilrJRcxLrjBdzfSKoraxyFV482hh9xo6eokRtdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160647; c=relaxed/simple;
	bh=q9QZqJPLHBsLGFs7AMkUGXhtrCb26YJPdoo82cbD7q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FwGbCgn/lxM7ildNSdRfVGg7lV12HZTeRT9b/hH7M4mMXwomev3XlVRT467DMf1jO6DIAka+B92c6KdpEehFgaoNUTtj/3F+ExpSDfVMBGQv4PWSBGgz9JoKfTe9zy8YgZN024YP4JmlfMZHzlQsZKGlN1lRc1cX1UOvWtRZK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvuOuqYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3042EC4CED2;
	Mon,  2 Dec 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160647;
	bh=q9QZqJPLHBsLGFs7AMkUGXhtrCb26YJPdoo82cbD7q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fvuOuqYIZGKGKakdAazhJlFADPz+qdn+upCqP5xLxnzgTb4VuZ2vQtM2iBSW0xfg/
	 PrdJbQWfoorQnNznIml04e3MNCXbPUWdI7mbgJNzoIFU+czT2YsPmFT/A/pjzbbExB
	 yLcCiBpfr7glv79yxR83zQMd+O9khQhj47zBsDvulZxAfpA/2dJdYeJh+LNNkuNR52
	 JP4srKQ4nSQNMMK2KxTQmdKFjPZYeGpLJ2oXxDkPubRLBN74iJw35DxzAhzbIHdgA0
	 ZN+znxKfklq4pVmkpvas8g0r8/eEVVpX0jhSAtyMlj+4eOMylu73+CejiN2HnVQc/b
	 WWQUXeH48Uncg==
From: Vinod Koul <vkoul@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, dmaengine@vger.kernel.org, 
 Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20241028093413.1145820-1-zhoubinbin@loongson.cn>
References: <20241028093413.1145820-1-zhoubinbin@loongson.cn>
Subject: Re: [PATCH] dmaengine: loongson2-apb: Change GENMASK to
 GENMASK_ULL
Message-Id: <173316064473.537992.14469341770092720378.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:00:44 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 28 Oct 2024 17:34:13 +0800, Binbin Zhou wrote:
> Fix the following smatch static checker warning:
> 
> drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
> warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'
> 
> The GENMASK macro used "unsigned long", which caused build issues when
> using a 32-bit toolchain because it would try to access bits > 31. This
> patch switches GENMASK to GENMASK_ULL, which uses "unsigned long long".
> 
> [...]

Applied, thanks!

[1/1] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL
      commit: 4b65d5322e1d8994acfdb9b867aa00bdb30d177b

Best regards,
-- 
~Vinod



