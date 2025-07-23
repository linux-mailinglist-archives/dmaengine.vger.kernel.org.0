Return-Path: <dmaengine+bounces-5851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E1B0F23E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD1FAA1C4E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647302E610E;
	Wed, 23 Jul 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edEDMIX2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E93210F4A;
	Wed, 23 Jul 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273772; cv=none; b=qrO+yEdw0XQvsCDyoUfuCWrKGuoRG/seVWx47jZHRdQwg5jotktD4IvUqqxeFrrz5shgnWPC5XKGeiJOwxGxQJRAdmhvqV/13Dc0TpSgtN5pI3R30iPvBymAvQYXSIqBNkYtk6ngaPS9Svldv8ZD6Nk8uBdo03axV0/LXoMpckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273772; c=relaxed/simple;
	bh=H6F5gXttlgPhOq8r2chWAjHRxUTZr7MdXRmPzdRcOAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dIW81TLneSbORMIm/xsZV+XgVRFleF2o/LGRD1/rVnpYE+lJlpWgy6PKNqOtrvkVRZmH+9HNBg0KGXnjrOHrwwBNGVW+0jHhPk/khsGmJNHWVijqzMKiPVvlpyS1PMzqz2GLeuW2XNEF6Lx2m9Dn96TYHyaNRnpupvHv1TKQM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edEDMIX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952DC4CEF5;
	Wed, 23 Jul 2025 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273771;
	bh=H6F5gXttlgPhOq8r2chWAjHRxUTZr7MdXRmPzdRcOAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=edEDMIX2ZkPn5lG+/a6IvQSzigNYqJgaVZN/MC3rues6KWkTHtN79AWtKopHBoR/s
	 S61sH3d3WfjtEjaJXnnpAbbjQCJUdaMj8hxuOvETm3GCnAxnIRyUki4ySELqan3JzE
	 fxQ4o3yiDsfMqqImoKcpg6hp050BrdEehZCsRSEq5YG3DhuVrmClORju56mSqOixgW
	 pis+0zWS4Kpu6YnnVVtZAsnQb8qS2ktz1c3zYxLRZ9MWOVr7SqiTkO/M//lCAr7+kd
	 6ls/6cE+mHDlW2Y96FnoNwJ8tb3/8jCy+62ZsEmiQICWBjQDJf7vWitbOUt1qJcA81
	 wmUM8YlY9dh3A==
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250702222616.2760974-1-robh@kernel.org>
References: <20250702222616.2760974-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: Convert brcm,iproc-sba to DT schema
Message-Id: <175327376877.189941.1348733436012583946.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 02 Jul 2025 17:26:15 -0500, Rob Herring (Arm) wrote:
> Convert the Broadcom SBA RAID engine binding to schema. It is a straight
> forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: Convert brcm,iproc-sba to DT schema
      commit: ec896de28c9ad1a4155c518588d9153c454abd39

Best regards,
-- 
~Vinod



