Return-Path: <dmaengine+bounces-2850-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045B9504BA
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 14:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332F11C22FE2
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B69199393;
	Tue, 13 Aug 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSR9/3rG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041F199238;
	Tue, 13 Aug 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551336; cv=none; b=XU0ZLt2HySo9bVF32zAYjoemL+G56X9slhYKzPfG7KK0yf2eD43GPvhsSccgBJEeDEO/2etgLGviz0Z+4bp0sA+1AsXJQxGbG60KqnmY49a+95twLAQxXc9HcZxejWe5aUuVCEKPIXYX1fvfQYDvOWA/wGlRE4vWboZimWgzr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551336; c=relaxed/simple;
	bh=hbeRrVh/SiaMC4JFosNc7lEIzxH+ImnQOcMEmvgeTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS3ysEZ5B1cYJlMgLMEsyJzRhc9Bo4dngrUuELBIRLcV+y4xlWPMK4VNxa6r5iBcK6HsqbxGxsRX9koWPKMfdBrzi6GBsjMH6LVR8xIDnokIYiMDmzIVBBtTIWD/YET/JLJYHILz67Y6N5toqq/n4gZUOSdHTIran52aUYgCo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSR9/3rG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D0C4AF0B;
	Tue, 13 Aug 2024 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723551336;
	bh=hbeRrVh/SiaMC4JFosNc7lEIzxH+ImnQOcMEmvgeTkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSR9/3rGXfW52UDhzO1W5hWS+KUisEfOSJxYQCWCfmFM05OJYrn1QlhUhHsAQHSxx
	 2zVaKHhOyr0dlrY+LIKNZPgjYMuGVovGtrSR1iYEGDsXwgIKMFcSsMnIf2tVYgo4T1
	 J8HgbGtWNfzAD6vc3RXO/oLApc6iQrZfdFeWUz6TjBW3Zzx9KZsMgtAwc+YhRSH6Y+
	 NuXxL0uWmUCfVI0PLJlOFKET14ttb4n8Utg+eBybpVVMezKsQ/A6BbMm1LVUEE4DC1
	 ryVtG3uxS7Ju6aQsISU73psZZifirUeNwoAP4sh0gVEzXvhYq4f0gtmND7QTsWWpeR
	 dbdOu0Kjv5p8A==
Date: Tue, 13 Aug 2024 17:45:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID: <ZrtOZIwszhJ9s8J2@matsya>
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495384C4A2F64AE100350BE7BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495384C4A2F64AE100350BE7BB842@IA1PR20MB4953.namprd20.prod.outlook.com>

On 11-08-24, 13:16, Inochi Amaoto wrote:
> The "top" system controller of CV18XX/SG200X exposes control
> register access for various devices. Add soc header file to
> describe it.

why define the full map and not just dma router offsets in a local dma
header?

-- 
~Vinod

