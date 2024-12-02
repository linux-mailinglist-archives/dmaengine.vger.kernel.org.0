Return-Path: <dmaengine+bounces-3859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2429E0B0B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22237B31A08
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7841DDA2F;
	Mon,  2 Dec 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffkzetkO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECB18784A;
	Mon,  2 Dec 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160671; cv=none; b=a1oplAuBwR35fGwDBfKdWklTdwVBAQtlUL5w8DrIX5ueBJwWSbKjXWkYXHEh2MySV0XOl1jMRLnhChPXa6+WhL3kzL7j3j2dSnbUagHw5kUPm5YqJ6gYVY/vxg3lMEEketWL6emADVsJTmXwke+YRpJXIyo60jeCQhdhtXysiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160671; c=relaxed/simple;
	bh=pm8/JtE2qxH2uHVxC9uBEXrcttrGr0oPHGOqDOug9sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W+fU7lGeJqUMH8pPPiiSXwmhE43h/ptz2Wq5BIL0kfQ4Q9ds/LUAi2z0dvpB+T43yUFBVua2IFiI6DYe/BP6a+vLnS82287TJiBgUuDyAYo6O32VFnVmS45ec6hPSFVBgT9cKAe90Qi0Q6H8M1oON0PiosijiqbFHz4I9KBvdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffkzetkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A82C4AF09;
	Mon,  2 Dec 2024 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160670;
	bh=pm8/JtE2qxH2uHVxC9uBEXrcttrGr0oPHGOqDOug9sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ffkzetkO1MJiix/YI8k9LR3/2INNH+3QAm6Ocu38eZjwJj0Nml3V/jb2DGsLLS1N9
	 jSa/t1pKcSEYhrELTWoXNJa3SuGolT1GTw0IEVJDkJADB+krbezjBkARG3bYuK+cd7
	 FmfYN/QuuxEya50IOp4+s39JupW8BFxmOIJMWBbRZZ91XMIe544Ulnwo3GP04kAMsl
	 bjn3mIk7WZDoKmoaM56qaAitv3AF3OCO227kxM2KxPvkzsxoEb4k7AST+wU9cMUg1q
	 Ozvrmqiz6lhyoRTdy+K6zmMTvL74LsmaXU8ddsLhuaZFmJqFUOSGbGE7f2zRcW6dyV
	 llsUqyJnMVFQg==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
In-Reply-To: <20241112041252.351266-1-quic_vdadhani@quicinc.com>
References: <20241112041252.351266-1-quic_vdadhani@quicinc.com>
Subject: Re: [PATCH v1] dt-bindings: dma: qcom,gpi: Add QCS8300 compatible
Message-Id: <173316066707.538095.17958666090065947600.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 12 Nov 2024 09:42:51 +0530, Viken Dadhaniya wrote:
> Document compatible for GPI DMA controller on QCS8300 platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Add QCS8300 compatible
      commit: 794dae89874c6be76b46ae90e0c78c76a80175c3

Best regards,
-- 
~Vinod



