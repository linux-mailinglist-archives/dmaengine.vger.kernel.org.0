Return-Path: <dmaengine+bounces-4928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743ACA955F7
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCC11687E6
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA271DF984;
	Mon, 21 Apr 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdOE2mT3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53B1519B8;
	Mon, 21 Apr 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260315; cv=none; b=lXHPnEcYaQS/BwlU9qM/235ERV7F7DNEB5hROnnCCuS2JYUYWFOMJWkMOR+WiE8Hoa/Q8u98J/myXwbAtFf0oxGKgSV/0en0Shlmva+2tOpMntUB9tai0f4fKdOYeTCzkakjAciA/i5ezFlGOVYrmkxCmp3UgcC/CGqehNRXQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260315; c=relaxed/simple;
	bh=wicyaJqiVMukIqnRJCiaxefV4JH/wYEBdQd4bFgOGqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXdu2VXg9zyJEPGYpP5GP1hnuB5Hw/6Or4JjZ6d0byrMoGPRMXZdZkRzBoneqzk/atPfXb6uR8caBq5asNKYuWVU18PPPpDTV4XR8XN6/JfwznLqpbMEUYk7lrgkm/chNrpxrI+PaxJ9U5S1d+0ped38Z/6meNbds2b9zNIrXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdOE2mT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD9C4CEE4;
	Mon, 21 Apr 2025 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260314;
	bh=wicyaJqiVMukIqnRJCiaxefV4JH/wYEBdQd4bFgOGqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdOE2mT32KAihVhmRy6GRyUIgIJ7aebHWicszH3zPESQRYtRzgOmdV4KqKNZjQJ1F
	 jM5TyjtJQjuPvcorYxregY2/NK8mrmEe0bBxeY3yNAg79WyxLgQxve7z2aStpc56gz
	 kBIoMBr8GWwTICBPOIpYLWUR3dccxgHG3hNIxQ1M3eM9TyYooXs+XjEkf4I/1a5Rxn
	 4PR+drtANHJqTo3krFEL8NhzuLZ35Nww053jwwT/sRZOWHXJq5/t+dO+EHRXOpKtXn
	 /ZvWBIKBfM4M4+e6XIZwdN3qpRFVYl785W0ko9O4Arus0DNTxRm30obkTSbJIdp6Tq
	 QxKouzf+2QRpw==
Date: Mon, 21 Apr 2025 13:31:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, agross@kernel.org,
	dmaengine@vger.kernel.org, andersson@kernel.org,
	conor+dt@kernel.org, vigneshr@ti.com, richard@nod.at,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/5] dt-bindings: mtd: qcom,nandc: Document the SDX75
 NAND controller
Message-ID: <174526031158.2584631.12243382230539274745.robh@kernel.org>
References: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
 <20250415072756.20046-2-quic_kaushalk@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415072756.20046-2-quic_kaushalk@quicinc.com>


On Tue, 15 Apr 2025 12:57:52 +0530, Kaushal Kumar wrote:
> Add new compatible for the QPIC NAND controller v2.1.1 used for SDX75 SoC.
> 
> SDX75 NAND controller has iommu support so define it in the properties
> section.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


