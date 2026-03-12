Return-Path: <dmaengine+bounces-9394-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHgnNFfbsmlMQQAAu9opvQ
	(envelope-from <dmaengine+bounces-9394-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:27:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3532746B3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2BCB30154BE
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617133F5A7;
	Thu, 12 Mar 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZonUpNG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7B31F996;
	Thu, 12 Mar 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328619; cv=none; b=UesGsHWaHdutEXMx2zIlQwx9jcx1N2j9dkN+Zv/Is3SNLfI8dI0oKvdKKJpHgOE/vtdXh6kXjXLwMRAvlcVIVQ6Q+0obpcMjJQVeXNg/IykScyYDqgLfBQr3VePz1kPf+bhjr8fqjM5PjQInP7Cd5yWrJo3cqgD+OjJkj0vySAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328619; c=relaxed/simple;
	bh=RBNqncS6RC7Y+TZL/EQyfROxqo/Ml0jF+bxN4+ojSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYJ0KAK8SVsLm0VHfFWBcjjxaOHptf0uH1e8lM0sf6ItpchJX4AJ+1p8cBI2YDBb+rBgSGeOED35oUFvbI955vOdbjQ/masZicaCQwdabspzTO4K6BjOh2eZmV7JwhiWPJ9HtH4s42O+Yp4BjODf2U9Q5rIYq6DwaK67iRSoViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZonUpNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FCBC4CEF7;
	Thu, 12 Mar 2026 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328619;
	bh=RBNqncS6RC7Y+TZL/EQyfROxqo/Ml0jF+bxN4+ojSKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZonUpNGjmkG/C408szBXBPt3JUPOMO/aIqQN54AfKBB4E0l/PQhjbYY7xJyTelc6
	 1mqfODbRLJjeRue4TvruNPTgdv2xrnj6VfPhr3gn0glq34d+I4B4x+Kxtuk766ho+p
	 68lMNgEDZST99X4Kg0FyMRh4TpfzATkDS0RjhnhCmxgNQQvhXJG6DGGaE0kVA4liQR
	 gsqLb11Cp8fB30Jo33ZpF4yrKEygmCAXIxvIX1LzTGJyUOIqW2p9wPUGqG9/t3B+k4
	 v6o8Vw8lwa0uxk6NF4LOmZcAY2JcN7zMfw41aqgW6+UZIXBVem8bM/eugElna5ZfTI
	 nxDA6jFig/JjQ==
Date: Thu, 12 Mar 2026 10:16:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	radhey.shyam.pandey@amd.com, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH v5] dt-bindings: dma: xlnx,axi-dma: Convert to DT schema
Message-ID: <177332861768.3154388.13563344241435238840.robh@kernel.org>
References: <20260309033444.3472359-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309033444.3472359-1-abin.joseph@amd.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9394-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F3532746B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Mar 2026 09:04:44 +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA.
> No changes to existing binding description.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
> 
> v5:
> -> Use > instead of | for description
> -> Use unevaluatedProperties: false because ref to dma-controller.yaml
> -> Reorder the properties in the example
> 
> v4:
> -> Fix the dt_binding_check error
> 
> v3:
> -> Update the subject heading
> -> Remove examples for cdma and mcdma
> -> Fix the syntax issue for the clocks
> -> Squash the interrupt use case for axistream
> connected cases.
> -> Reorder the list as per the writing bindings
> 
> v2:
> -> Add examples for each compatible
> -> Remove the note added
> -> Use 'enum' rather than 'anyOf' and 'const'
> -> Wrap 80 char per line for descriptions Add dma-controller yaml
> -> reference Add -| for paragraph separation Remove labels from the
> -> examples
> 
> ---
>  .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
>  .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 299 ++++++++++++++++++
>  2 files changed, 299 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


