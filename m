Return-Path: <dmaengine+bounces-9825-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJfLAvYszmnIlQYAu9opvQ
	(envelope-from <dmaengine+bounces-9825-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 10:46:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA53863FF
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779A43058DE5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD238AC78;
	Thu,  2 Apr 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxcGY1KB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6978F59;
	Thu,  2 Apr 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119226; cv=none; b=LpIAczz+0DawxAHrBPAInd0ttUwlQvyiCxFMGsBA6yTTjpERxMQnB41+KCcd/cur5JG+ei5ikuCNQeh5R2I0sPAVF0p1J8oQvOU7Myyt0OFh5aQzeHke4Tcy7A7ruVFzfU4x1JrSFqfvtigVs5Sra4VLdhbcJxy1oXLJmE/fQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119226; c=relaxed/simple;
	bh=cKu/jCB9ioOWzqhlmJ618JPe0TN1anLKMrkWDWFbf/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETBoKxMC/svucmfOd0hvP79rEbAQ8W86G0v5cpBg3H71z1FqJPnqaHwt5ovDy2ZrgLPhy3APdIdMs+IPZaLW9phPZN4i2JRsgnEbuaj3iOlkM7lgfCXirzg2Y7eihPttIxZbma0lzyVJAAzCzpNx5bi+viMYGeHEQoHdAU9OkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxcGY1KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277D6C116C6;
	Thu,  2 Apr 2026 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775119225;
	bh=cKu/jCB9ioOWzqhlmJ618JPe0TN1anLKMrkWDWFbf/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxcGY1KBS6HNodyt8aAkyRLe3Gj/9VwON4RP9Y5AzwpXOx2HOzcNT43bkNQkG2fyi
	 mXSgDdKxiVnHbxp79ieY6Q9a9CYosTfkvhDWFpzo/bzPmkl8Xl6vojHQRg2ID2GuQD
	 r/hFnYQNIOkCAwnDW/tahfL3O080nsUzmY3r7ua+cI2Crk+8nZPJ4Ee8XWzxKvsWjV
	 suvuJjcTNuOup3cQUQcWtvt7Snph6mBO5QgC5Vizki8iQd+FtovUvg8SbuWUa0A5Y0
	 I5Dehj7pYua2V7ejyGimhiLHz/HObAo65NvvJWjLIpUhjCGfnDnz3+FXfVm5QW8h9r
	 ADZVEioTANpww==
Date: Thu, 2 Apr 2026 10:40:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xueyao An <xueyao.an@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for
 Hawi SoC
Message-ID: <20260402-attractive-bug-of-experiment-c932e1@quoll>
References: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9825-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84FA53863FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 06:10:28PM +0530, Mukesh Ojha wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>
> 
> The Hawi GPI DMA engine follows the same programming model and
> register interface as previous generation of Qualcomm SoCs like
> kaanapali, glymur, and is fully compatible with earlier GPI DMA
> implementations.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


