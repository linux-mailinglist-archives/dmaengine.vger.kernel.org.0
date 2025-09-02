Return-Path: <dmaengine+bounces-6324-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18EB3FB2F
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5803BD665
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A602F362A;
	Tue,  2 Sep 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DItEqcQP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC602ECE8C;
	Tue,  2 Sep 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806600; cv=none; b=CnFwHby0xsntxuo9yBVg0bP6audHYKeCorJ3d09xOuA6G3RDmy7v7giFM6UvW6c4Y6qeOltlJBpHxP7y79/fSQ4Pokh2saezfibyZfDnVA2t/NU/SNheTmz9Y0sJIu+dNcdNUVztKjVqrrhqcSkTPVHkIWObsFuH8cF6un0Reeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806600; c=relaxed/simple;
	bh=8DvXbPFnI4+n7hHxbxXgOGqvAp5g/qxDSdMttlnJd5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jsS4yoRg9eHiUbvcQ5Lll4VNDb9oI99lf3cIU1re0HMUAHWdgvdNfv4gmzWR103YsTcpf9FthJWQJJG6f3+KeAPO6GoAV82HTicLiqxZd4lcFQqZGO1bmhN64K1ipGk9bnu8aiOOT0iDp8zuLFKt2FUBGJ2MNzfrcrx1fFKi2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DItEqcQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7957DC4CEFC;
	Tue,  2 Sep 2025 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806600;
	bh=8DvXbPFnI4+n7hHxbxXgOGqvAp5g/qxDSdMttlnJd5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DItEqcQPAEKKBmNhaurvDktBCHmT4CxXYPQrpqnvvYXk2r0RBKOm83KnoAEDAwv3f
	 M+prW8UAbGCbx0WoabkpX+LsWr8thXEGRllDEA03z8xd+6qJUTowAq3bBw4HylU5+k
	 rJtnUhVHR93a0PTH5cD61Bj6EunKByj7bbyA262xogNu+FrHa/P6nYPAMO0uoNeN9O
	 wtrCD8yU/JSKvMMo+DZs4uq4VzUqMFalJj8DuwYCk4WIYPpEt+ogQE6wioQoUGasjh
	 0OXbh1cKAFPZ1a99p8faURKF94Zrsk4jDWZpjMiiMQ75nI5YCh6rqUKLgV7kh14VK7
	 fQvGPlTVVl1xw==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 michal.simek@amd.com, radhey.shyam.pandey@amd.com, 
 Abin Joseph <abin.joseph@amd.com>
Cc: git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825130423.5739-1-abin.joseph@amd.com>
References: <20250825130423.5739-1-abin.joseph@amd.com>
Subject: Re: [PATCH RESEND] dt-bindings: dmaengine: xilinx_dma: Remove DMA
 client properties
Message-Id: <175680659600.246694.18044016578906182085.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:19:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 25 Aug 2025 18:34:23 +0530, Abin Joseph wrote:
> Remove DMA client section mentioned in the dt-bindings as it is
> not required to document client bindings in dmaengine bindings.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dmaengine: xilinx_dma: Remove DMA client properties
      commit: d5df661c9c76cb36d90527349ac6197a4baf2aba

Best regards,
-- 
~Vinod



