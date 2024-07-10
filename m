Return-Path: <dmaengine+bounces-2664-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A4892CEFB
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2651C2125A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47F19047C;
	Wed, 10 Jul 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/07IlsR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEB18FC7C;
	Wed, 10 Jul 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606433; cv=none; b=IlmrpiWMdc+JlRyra43NYZfvxzfBN2s1IkZh7zvazhZKaf4NoDMBADyzCUneVzHbZ3OP6YZzoh3J/bK8FxgKFPSAnFZzui5cQqQ2vY+RqBQDqVMYn2lSIANIJ0XxsS6C8bYEPKtxyh+4qYh6cQtw0i5/lOqLk2k46bs5+HRoiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606433; c=relaxed/simple;
	bh=zTFVygvAGSMl+oycFDQQmtGdikhiOysuzBm67gnIJo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p65iq3bLVUTIbuaXIaIwEkh+wffJ2+gwZisKnJ47mWcjJ0e+5WjEZ9jwH0DWSb3oRr6xfDK/L3jUtAA26MzaV9CyAGvpTNlFKyf/6N5dOqEL4eArymXsIq6pLkRuDGW5kqIRmK/f4AXurRRumjQ41j5JXhCnmIdotch9J6TrV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/07IlsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ADEC32781;
	Wed, 10 Jul 2024 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606432;
	bh=zTFVygvAGSMl+oycFDQQmtGdikhiOysuzBm67gnIJo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/07IlsR3F1QUiLtp691sdjOiizMUKm7EwBiwzyQdUE+IRGSwXkBQCulQa+F2JpLL
	 ua3zCU0X5N15XEBZfCk1ZLc4FqwpqLacEREYzY7Aon9oZWKOuuyN67Tvaf/IOQl1cg
	 4DVe1gAegIcH6R77Yrqv0j/hk+Uyk+3MIX7L4hGqw8r6ZVrlVPs0gXnGooUhtnuAI3
	 ZZO8RmXkK6BPSKaj6kxBv7Ckl339PyL8I7HYl/AmNagDQYf2+d6hwLIs/GJtwkDB6j
	 /gv6fwvZNFQ+TlHee0/NtSX2+LikTAgDUou4xR2Gh6Ctvfkdod2yHrgePxIrrrPOTI
	 pxktiAfhSwtmA==
Date: Wed, 10 Jul 2024 15:43:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: fsl-qdma: allow compatible string
 fallback to fsl,ls1021a-qdma
Message-ID: <Zo5e3MiXkMDXHLGL@matsya>
References: <20240704020802.3371203-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704020802.3371203-1-Frank.Li@nxp.com>

On 03-07-24, 22:08, Frank Li wrote:
> The IP of QDMA ls1028/ls1043/ls1046/ is same as ls1021. So allow compatible
> string fallback to fsl,ls1021a-qdma.
> 
> The difference is that ls1021a-qdma have 3 irqs, and other have 5 irqs.
> 
> Fix below CHECK_DTB warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: dma-controller@8380000: compatible: ['fsl,ls1046a-qdma', 'fsl,ls1021a-qdma'] is too long

This fails for me, can you please rebase

-- 
~Vinod

