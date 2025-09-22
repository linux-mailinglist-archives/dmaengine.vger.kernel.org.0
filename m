Return-Path: <dmaengine+bounces-6676-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BDCB926CB
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151C11905FE9
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BF313E3A;
	Mon, 22 Sep 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrkJtioE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE91313E2B;
	Mon, 22 Sep 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562125; cv=none; b=gksBgWb6hmooOAsLT3YKOTp56EvEA+1l1Jk1UyuakpL8OcUpD/lzSWwsMux6r65aOEPVdvdVCYRPwBHnq3bs1EIOMgoq0IqVEEFJircQHMtKHpC5PnoP72RBPtjtyssyKOOMyU7BvRa1eXmT6F2qdfp5esb8stwgdn1tXQ/v+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562125; c=relaxed/simple;
	bh=xWh/GvAqWRCKj0KUUTfyKjrVO33OOAVo1h4s/cBrpZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNL6GJDMHfXX7fr+rkfq8blkoZktS2b+IVDsk35031USHG5jWCWDssANeeJYFJSIR5QiaV1coIR1gbPuom9j34BDnSx9yMuYyra3iYq9hwtagKMS0xWCNmC3fb8qLG4ez15N9tJo1C/6FRH9dk8ZURHsUW7xRrRx5b4ty1wltNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrkJtioE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44439C4CEF0;
	Mon, 22 Sep 2025 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562125;
	bh=xWh/GvAqWRCKj0KUUTfyKjrVO33OOAVo1h4s/cBrpZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrkJtioEOSYPoyVx1rybJ+uzDR/Q6UPnelJGrJNQ7Lu+C+w8AZIG2lCISQIzyGP+q
	 gnJ9OD1dKzjh8yIi7pXFHfm9CLJJ0/LO5b7bTAxjABA98SKzDSQbiNTGl3hN7noL1B
	 6g1JSyYB4f3pdWN+zSgb3UJ6u9IVcAwt0yeRfDVQb+C7RXt9FGDu+E9F5EbcKbJSFh
	 LQ3A6bQMnydcpjeIdstajPFi1LW/sDmpMWKDj9eTg8dRN29GJUHm+F+Q2vr6uAPvPV
	 /RchmYnOJT7r4x1CSjl/qugKvgKuOMDc97b9dhqliSRJ4yYb/IIc0rB5Kqp15X07sN
	 7nco7eUhZ50zw==
Date: Mon, 22 Sep 2025 12:28:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	konradybcio@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, vkoul@kernel.org,
	quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
	andersson@kernel.org, dmaengine@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Message-ID: <175856212403.505378.6554973184588982018.robh@kernel.org>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918094017.3844338-2-quic_mdalam@quicinc.com>


On Thu, 18 Sep 2025 15:10:09 +0530, Md Sadre Alam wrote:
> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
> the one found in IPQ9574. So let's document the IPQ5424 compatible and
> use IPQ9574 as the fallback.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


