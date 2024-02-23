Return-Path: <dmaengine+bounces-1092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873E86111A
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCCDB23331
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9917EEEC;
	Fri, 23 Feb 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe1X2Vnk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E57EEE4;
	Fri, 23 Feb 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690126; cv=none; b=QRcEywKjTCFSDpSTFFeDQPYdy9lEqQCGNLHODMFJgnBtsUZQr/bWO5cE08s93G+SccKtA2FZ5hzE4Ammpps0+thlGh599IYCKVa1wgYsC9tEuHI3ms2Moc4YkMQhNeH+2GyENraxDeVz1SkgojQV3xPdLd7RjpjWKbYzXXfWZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690126; c=relaxed/simple;
	bh=pnwte6BVSihupm1ca660EdyFvXH2XKLwlmdzPrJE7ms=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TnE7ciiSADBpUFPqJn6Bl06kmRqsGXdbkRSGKH7uKnPGKeosrjSXa2yy6aIFn1JgLVapsRN4b0M6lBKEU0YYJMDKEH3TM+UMYoc2+WkRlZB+nVj6BdATXkWbJdS3rM24liRXRE+N7PiDKLif+E3taAjQRVXTc0fS1k0LFqnSh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe1X2Vnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64589C433F1;
	Fri, 23 Feb 2024 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690126;
	bh=pnwte6BVSihupm1ca660EdyFvXH2XKLwlmdzPrJE7ms=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Fe1X2VnkXAgCVOYrFKouzbYmx14dgQIJ0UB+J6+WvegxSy1sE3Yh8+qEySRRelcZj
	 jkuJpUOAnqOueagAnTWSO3O4R6qmZi9k/KOGqA8MB59A6xc2TUY5ZBpeiQmjzL+Rds
	 qtrvcaASvsJcuSiLruAs0BcGsnPtU3rcED/pzQdFy12vtQQU+Tg7gCJaoanTw1eIt5
	 dxsoHvKIkB0BihfSTvE2hq1KD6oc9NgXFc+DywlgjKgYJNDcjZvMFZBsVV1QCKM5aw
	 7EPw+bTrA0bJSGua7pl8GDWjT2Num7rXERZOFlSaahnasW17enGOEvAvaSUlXlogr9
	 +IyN2p4plZ60Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
In-Reply-To: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
References: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH] MAINTAINERS: change in AMD ptdma maintainer
Message-Id: <170869012503.529520.12295824304569718892.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 22 Feb 2024 14:00:04 +0530, Basavaraj Natikar wrote:
> As 'Sanjay R Mehta' stepped down from the role of ptdma maintainer, I
> request to be added as the new maintainer of AMD PTDMA.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: change in AMD ptdma maintainer
      commit: 0edf25679f099a31b764db6a4ea3cd7687427c41

Best regards,
-- 
~Vinod



