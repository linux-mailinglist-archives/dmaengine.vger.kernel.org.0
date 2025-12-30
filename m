Return-Path: <dmaengine+bounces-7984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748ACEA62F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB5D3025160
	for <lists+dmaengine@lfdr.de>; Tue, 30 Dec 2025 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADAD2FF65B;
	Tue, 30 Dec 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMPKVo3Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA62D3738;
	Tue, 30 Dec 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117748; cv=none; b=RqVfs0hAT/T603OVH+CRO6D1Hi0jWqbjbZ5O/iHkeCzGAz7BzxmluNCzMEKTvuqa1uAG/7SGKGVd2W12olHMeFjfxPr9xdzvgSDKPASrrT4b8VeLrzrXwcNU+nlTiwQtkyi3jtvc9sH3ChKXFEhp9FBy79BF2+EfzwWss5ZY000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117748; c=relaxed/simple;
	bh=CGJRvsvRqrY06eLsApGvbZjfhRGxGSz0nojzUjMmD2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh+RhqqwtbloNOzmSdapb/NBBBUx1I7oreWe9BbelsuF7jr8RfaMxx6PzMJXV7P6nn3B7N3sI2V+QEUgB6ap60LMEBSP6KHhvd3DYYuEpvIRmOjU0qTV9Pl+l3HH05M4t3izc8kjGB4k7DqAnWL2uceK8Ywt23G3cyo9PgA/Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMPKVo3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F49C116D0;
	Tue, 30 Dec 2025 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767117747;
	bh=CGJRvsvRqrY06eLsApGvbZjfhRGxGSz0nojzUjMmD2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMPKVo3Z+xWMyPuyX82WJfQIbBoB/bFGEx3nuaDAO13FEySFh4ZJ3ncIT6WUNvrwI
	 q90csKg3kXo4GmOAs7pqW2EpaZkvYHecNxGTXMe3BvCIDiBAcNwk+IZtHE1xAlO6fH
	 VOaXGYMJH22iYtSlAI7U20cFIYlQ2hzoXeflQCpMnslw1h4AUMCHMRJP1jUiTvF491
	 1bC1yZErK9kL1/sInbBJYMNxVQNeQXogwPOw71GhQVMHmn9LSYZ442gWgrB3hyiVwb
	 oX3krkojLWg8R+WTgGIMmuy331fwsM8XEkFodepGnv0Rcw2nKWgA77UYIaHgo/C2Zw
	 Fpt0N2aRpbL/A==
Date: Tue, 30 Dec 2025 12:02:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add
 compatible string for Agilex5
Message-ID: <176711774630.870949.13920707490957857831.robh@kernel.org>
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
 <dbc775f114445c06c6e4ce424333e1f3cbb92583.1766966955.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc775f114445c06c6e4ce424333e1f3cbb92583.1766966955.git.khairul.anuar.romli@altera.com>


On Mon, 29 Dec 2025 11:49:01 +0800, Khairul Anuar Romli wrote:
> The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
> will cause address truncation and translation faults. Hence introducing
> "altr,agilex5-axi-dma" to enable platform specific configuration to
> configure the dma addressable bit mask.
> 
> Add a fallback capability for the compatible property to allow driver to
> probe and initialize with a newly added compatible string without requiring
> additional entry in the driver.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v5:
> 	- No changes
> Changes in v4:
> 	- remove dma-ranges as it is no longer required
> Changes in v3:
> 	- Simple dma-ranges property with true and without description
> Changes in v2:
> 	- Add dma-ranges
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


