Return-Path: <dmaengine+bounces-7139-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F7C5246D
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 13:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47E63ABE6D
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1413328F5;
	Wed, 12 Nov 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUInCZxA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940C331218;
	Wed, 12 Nov 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950690; cv=none; b=o9xUxwZRfmyH8LHFJObxFxZ7uzsV4wAdjU8L9ya9UmFwvXpi/S1j34WugfUhSOb9dqAuPjR4qKK4Tt364mlKbu6diIMQA7ZMj3U7XRXma3oCYpvYTiUQJoo3vI80cpZKn3fOfBbv0bJ35tOBHnZGq7DSH8fiuM1ZT8DVUo5Cn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950690; c=relaxed/simple;
	bh=GFIgkbh8zyxH+lroNfBGqOGojGkM4wtAAC30y5B+G7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCIwg1xmj/ZX3Frqp9dttp8/VIPOEJl041OG/KmYah24Gd4h78ANX+z37GqbF3J4KHXnQ7drmQ88eGQpVloS+NB/C0R4fHnJB2qSW8qG62OEj6TRJkuUd5nCbaHwhjLANn1JOdol0EkvFwtBE+KEv8UptMv7ljn5CGlqqF71wXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUInCZxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D40FC19421;
	Wed, 12 Nov 2025 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762950689;
	bh=GFIgkbh8zyxH+lroNfBGqOGojGkM4wtAAC30y5B+G7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUInCZxA0r2bB7/jsxmX9SGjQwYBp6nqHc083rgfLHwC6B0wLd1ee0o9m4zarsshf
	 zPYnOo10yac/rmTNmhgTmyNValEhNHJrIRCK79CuPCX4u2hXWDSJHQkSxZ3NobQYR5
	 3guO5Wtpq3uxnRGky8kbqnEAs/HBSrLlFj7QJZMwXdPhrzwxRYpiXvjOHSC3y5mdl9
	 2drACOZl509Cnb04R93liFxm8YMvTsb3EQjFpRY6mLizSbF81ftsWJ6eUd15xQKqgl
	 iqcnbCQ2cOBwWvFlxIwCsb8thEhmmcI1qEzxa1hEiAVtG17DeWDT9GNV55DeAry/5n
	 V31RGkJ2vpIiw==
Date: Wed, 12 Nov 2025 06:31:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Convert apm,xgene-storm-dma to DT
 schema
Message-ID: <176273672994.2489316.16085574040598987074.robh@kernel.org>
References: <20251013213037.684981-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013213037.684981-1-robh@kernel.org>


On Mon, 13 Oct 2025 16:30:35 -0500, Rob Herring (Arm) wrote:
> Convert APM X-Gene Storm DMA binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/dma/apm,xgene-storm-dma.yaml     | 59 +++++++++++++++++++
>  .../devicetree/bindings/dma/apm-xgene-dma.txt | 47 ---------------
>  2 files changed, 59 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/apm,xgene-storm-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
> 

Applied, thanks!


