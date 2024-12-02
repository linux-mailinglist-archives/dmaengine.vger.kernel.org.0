Return-Path: <dmaengine+bounces-3858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85D9E0AA8
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BC4B3E99F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3261DBB03;
	Mon,  2 Dec 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abvbe3+T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD381DB548;
	Mon,  2 Dec 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160667; cv=none; b=YJiGo/S9o3dJKx5knm+u0NQ7OPQTYQdO907gzGm2dSancHXhBN/+uTlFYIn5D7srusbaHR0rZtkY2bAIgdVArSzEvjAmsv4+2atBywWiRugGuuZjAL7Guxmprg+bDWYZe7IUnh+SP6pjtgjV83vgXZKYYG9YZ9qrQQ3961GKUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160667; c=relaxed/simple;
	bh=27hbzCnEIwzOJ0IGzzylVzuWfUp7oqVpT0YFWxcLVsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eEimQnOQnJGnRuv/w0BOIMWdJzcW7rCgJ3nM3772tKUKgEFShx/iPQu1Kdy5iufofhi/lCpUjvxdphTsKrfH1zeCMd61lUrl6hl7Z5eJmbtIH6mW6mDo7sxovHvvkN8j+qAOMrW23ZOYZkeeNIncU41NpJ4KKWX9UczdZP9ZQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abvbe3+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC0C4CED1;
	Mon,  2 Dec 2024 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160666;
	bh=27hbzCnEIwzOJ0IGzzylVzuWfUp7oqVpT0YFWxcLVsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Abvbe3+T9OICU0YToDA+15POVSCNlTQPhv0L/gb1zWq9gMrmMkDwedpIvo0yo4jg3
	 XnctuyOpcU3YiHFViBXg4iNG8msrmEpjW5outJn5uC1QguV72RkJuInPE5gmj71fQa
	 q9uo5YteQyX7kpZtbWnYT3ZmQsGkOFLnkhgGG8s7IyrNUNDFliMSMAoJxpWuqyBbeh
	 sA7mMQ6N9gOi45nF+eqo3oaQMffhsoxa8kRhBHZ9FKcOVA+5laQ2+/kGGt9phy7wC8
	 ianbSwBs0hy4b52nDYO4mlpZ02/aA/ubP5+UOth9wrj+Ifx2/6MRnE6AGOtX1NfAXg
	 E9sLIfNPvnRqQ==
From: Vinod Koul <vkoul@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241115092854.1877369-1-quic_vdadhani@quicinc.com>
References: <20241115092854.1877369-1-quic_vdadhani@quicinc.com>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: Add QCS615 compatible
Message-Id: <173316066288.538095.7308879081334615310.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 15 Nov 2024 14:58:54 +0530, Viken Dadhaniya wrote:
> Document compatible for GPI DMA controller on QCS615 platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Add QCS615 compatible
      commit: c841f9909b0d947ae7593040cc59646dc9f14455

Best regards,
-- 
~Vinod



