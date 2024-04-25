Return-Path: <dmaengine+bounces-1957-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E608B1DA1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7175EB266A5
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F368614D;
	Thu, 25 Apr 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7BOfxP3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667B85C51;
	Thu, 25 Apr 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036645; cv=none; b=QpWKPZ8YxlAzwilU16Y+FFvnYLTNSxdXgjwlCsdWFzwt98xDZEz02c8t22SLWooKbiXJJtfByi7QxAxwcZ1hpa6Hb82X429ez8ZSKtbduLiQonLzrLP/gwLhpsI1tVcNg6RiAxzSpyCJL/1YPpt0kRRIENw26Az/77NQJPbVnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036645; c=relaxed/simple;
	bh=em8J+dUfWAWKlivxuEVNwYnLaYAK5KlBXPpQm1EJZBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V1uc4F1hxWxHO1Tc66MRUMvrdKiQEs36z9Ky/27CPDs3/n4ubaVSKW5Y1c+27/JPhzPhZ3HaRnxCVg8IutovpAyiWS7Iuqgyuhd/jy3BdOb6FDIixc0DltHko/tVaDuQBYmLewWVXu7vzHzC0NLWYzMTrQxK0koK9aLEKLHkcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7BOfxP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1DFC113CC;
	Thu, 25 Apr 2024 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036645;
	bh=em8J+dUfWAWKlivxuEVNwYnLaYAK5KlBXPpQm1EJZBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W7BOfxP36tPZryMU1OzFDBztWlT6XuhFZ07T+ahopMIPLCxa07++we6YYatbeu+Kw
	 Nv2XLV49yHlcttKFkP7PXiS0MhXf3K7Qe0LSAbtpuPbjqqUA1p6JUK5yN9Qis22N6T
	 nXNQvEhsjYt/ubegoY7X/DQ1PsftCaqY12v/LQNt9DZKMwPEUV4qGVcaDAADdFYioD
	 yoA9uAWmL8wlL+m6wBgYTETsDSbAoH4fpUdKV5zxKuJqvd0EPPPH+zP9FjRCRoBAkH
	 QUbIxwKw53zb2zgpaXOCBeO3/wSrzJxp9jB2lt2Nir6mn2rxON8mjC4dMzzHx7E+NI
	 V5Giij1qUTRYQ==
From: Vinod Koul <vkoul@kernel.org>
To: frank.li@nxp.com, peng.fan@nxp.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Joy Zou <joy.zou@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240424064508.1886764-1-joy.zou@nxp.com>
References: <20240424064508.1886764-1-joy.zou@nxp.com>
Subject: Re: [PATCH v5 0/2] clean up unused "fsl,imx8qm-adma" compatible
 string
Message-Id: <171403664136.79852.6180905309072230541.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 24 Apr 2024 14:45:06 +0800, Joy Zou wrote:
> The patchset clean up "fsl,imx8qm-adma" compatible string.
> For the details, please check the patch commit log.
> 

Applied, thanks!

[1/2] dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
      commit: 77584368a0f3d9eba112c3df69f1df7f282dbfe9
[2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
      commit: 44177a586fe463150def993de0371f1a82d3465c

Best regards,
-- 
~Vinod



