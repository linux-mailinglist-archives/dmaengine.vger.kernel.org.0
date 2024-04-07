Return-Path: <dmaengine+bounces-1777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB689B315
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CF2B22B82
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348843FB93;
	Sun,  7 Apr 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kATGixdl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071BB3FB90;
	Sun,  7 Apr 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507958; cv=none; b=Woi1rt4gsRDX2+AfhKq72K1afb4bVq9Gy6Z79mbz6hkid+BXtmQ+LjQ4XNmvkVzAYYz364xRRRluT5oPwIwveUUPbZQDAa8OIkyWqdXzueo5t48ZisStV0kU5O67B5kCs5mz7g9ThoZyYsypTzK/vcL2IA3y1zGSQdpxl7ZUN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507958; c=relaxed/simple;
	bh=3EnZEArLHaY7GVMqTk9kRxGVqFNkiaEhhfxqp5dYqxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ba52lbZuPKsKMDHRZ1ihIgR/iyMa5CXbUJI7gy7BHkYIfYDwhOpmRv4mt9uQGI5to4dD3vqopQchYOOXDCL7nx5yekmzRVZ4Aw+0JpmcvV6Pc8WZK0z3iHdvVZUFxHDcVpCS+tHR2zJNMjCZaOCtODn2eUEEQ0zWUg6K13RDckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kATGixdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6DC433C7;
	Sun,  7 Apr 2024 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507957;
	bh=3EnZEArLHaY7GVMqTk9kRxGVqFNkiaEhhfxqp5dYqxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kATGixdldVHBnmMIcZ5RfUahlv9GUuLEZgE+fiqXwa3ToOQ3YR1uDmNYkDsyn1rQG
	 meQT+1J1UuNgcJVNQgmaKhs4hDxt40Vj7epW+COy9NztVDsV7XMC/JMO57wIJ0U9vY
	 RS++a7x7gy2aUeJv4GgbL+79xkz0CNOo1Hc7G+onSfEGcagA0eUIDoZ2yiFQ+UAZZk
	 K1hRyD43dqTGx7lpIBodF+/W7zLNG/wyKtLq4cs1YZ7GGJAPlzJtOseItIJH3IM+CE
	 LuNlpqkhy6v0p+RGLQkLV+vjCjmB96IezpyX5bTzhtL/TTP+DJC9nZ0aN9eKuT7905
	 uqL9i8Jw1gm+g==
From: Vinod Koul <vkoul@kernel.org>
To: Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org, 
 Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Martin.McKenny@synopsys.com, linux-kernel@vger.kernel.org
In-Reply-To: <1711536564-12919-1-git-send-email-jpinto@synopsys.com>
References: <1711536564-12919-1-git-send-email-jpinto@synopsys.com>
Subject: Re: [PATCH RESEND] Avoid hw_desc array overrun in dw-axi-dmac
Message-Id: <171250795567.435322.8170668108281183858.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 27 Mar 2024 10:49:24 +0000, Joao Pinto wrote:
> I have a use case where nr_buffers = 3 and in which each descriptor is composed by 3
> segments, resulting in the DMA channel descs_allocated to be 9. Since axi_desc_put()
> handles the hw_desc considering the descs_allocated, this scenario would result in a
> kernel panic (hw_desc array will be overrun).
> 
> To fix this, the proposal is to add a new member to the axi_dma_desc structure,
> where we keep the number of allocated hw_descs (axi_desc_alloc()) and use it in
> axi_desc_put() to handle the hw_desc array correctly.
> 
> [...]

Applied, thanks!

[1/1] Avoid hw_desc array overrun in dw-axi-dmac
      commit: 333e11bf47fa8d477db90e2900b1ed3c9ae9b697

Best regards,
-- 
~Vinod



