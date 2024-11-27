Return-Path: <dmaengine+bounces-3806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF99DAA7C
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C6E166A18
	for <lists+dmaengine@lfdr.de>; Wed, 27 Nov 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E91FF7C0;
	Wed, 27 Nov 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqWfQAs8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178346447;
	Wed, 27 Nov 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720209; cv=none; b=Q//8KoJNg2p+6U8UFeNi9YxKbFr1KFhuPO86rxqZM9WaSOcEgv+SFLQ0iAMjp1gClojNyolN1WAUKBGKst5a/FEh42snj7ys34sV2RTeRCe0mCmo9jTQOO9IyPM7XDW9UB+OHT4fveUxgdAlfSHSgPNgJInwfs/3TpikhQ50LOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720209; c=relaxed/simple;
	bh=WoGXD03ddafXHjcNZ0Y8jWdp+s70nLU9DRtM3n7CvKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clsGUmegD1o3kfR/INrpzA4D9+ZUyZWh4v+fAkiUXOaAT4t469pRo7s5iRZ9nM1ez8SoIjxiMHRHhJkeOn2GJoUbiMXjObd32FejJOJ+5j2JcUOvavAivutjR1yUenBluZn0Ghak+RGE/cbWGrD1OI6IJDssURteRBfEDPEJlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqWfQAs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3911C4CECC;
	Wed, 27 Nov 2024 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720209;
	bh=WoGXD03ddafXHjcNZ0Y8jWdp+s70nLU9DRtM3n7CvKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqWfQAs8/YPVeHBTAfBZn/zhgGIaK6E3fZEGw4UI4/FNh8W8ABp+JioSD8wUVohDm
	 R5V+3VTfD9T9d/XIP8amLc5l/BcuWv5BC2z6G0zeA05sQLWWYlZqFLagrJEbcq+pI6
	 6mCAuY1WUYAa7AlUlra+R8GxeQz9ka0FEokqGMMdGq5bUFtlWONgiIC1l4bc54pvUb
	 +pyShsuGxmCDZRaDWQSf7hnnN8oZBBuw8re2rPYzOq1Sx9m+AL9gt/LDU0PwefoVBk
	 Ysl7eXMqhjzcX/0aJWiwVSTJTNmPlQxKYLiEoaV+YAVWOAASRkWz7BqjP7Mh9BvYLr
	 pcq7n39rFLrIA==
Date: Wed, 27 Nov 2024 09:10:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: dmaengine@vger.kernel.org, peter.ujfalusi@gmail.com,
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, j-choudhary@ti.com,
	vkoul@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vigneshr@ti.com
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI
 BCDMA
Message-ID: <173272020652.3515198.4029351537372259051.robh@kernel.org>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
 <20241127101627.617537-2-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127101627.617537-2-vaishnav.a@ti.com>


On Wed, 27 Nov 2024 15:46:26 +0530, Vaishnav Achath wrote:
> J722S CSI BCDMA is similar to J721S2 CSI BCDMA and supports both RX and TX
> channels but has a different PSIL thread base ID which is currently
> handled in k3-udma driver. Add an entry for J722S CSIRX BCDMA.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V2->V3:
>   * Added missing compatible entry missed in v2.
>   * Address Krzysztof's review comments to not wrap commit
>   message too early.
> 
> V1->V2:
>   * Address review from Conor to add new J722S compatible
>   * J722S BCDMA is more similar to J721S2 in terms of RX/TX support,
>   add an entry alongside J721S2 instead of modifying AM62A.
> 
>  Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


