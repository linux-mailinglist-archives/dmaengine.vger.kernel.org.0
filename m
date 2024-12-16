Return-Path: <dmaengine+bounces-3980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04179F2D04
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D767A03DE
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A8201253;
	Mon, 16 Dec 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEmTDgw7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377A1BCA11;
	Mon, 16 Dec 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341457; cv=none; b=QrN4f0p0NmovrhaUZnzDYGHU74Nq+4cW1Mn//e4xePMfsQcSEGVXNUKqzGfrPDqHyEwIWyhGnA68nkzpf8TTYQadSb8BS96lqLbJjghLHMFE8UaEzZ8woP0lXAwl2+KDLRRuZ9iU5elPDZbxg4wZJ+/j79yMZPm5dhWev7UCwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341457; c=relaxed/simple;
	bh=n+Q9WKFcumC330vXhqPiRFjwN1teujk5gp9FOZUhxsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY1Y348z0Zk+t5EWFgjPHXJxT1ox6hX2wbpysTIIu3M1nb4l3HttoOvgLDqnelU90i9cIUZtBImEzgFzt8wJqGcNltcArSar7VAUCCnHX780sKDAClgr/Nt9J2LsdcJwj3V6/+QVElQSjRznxExSm9dFc9zwzz4VJjeAXFkHXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEmTDgw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB4C4CED0;
	Mon, 16 Dec 2024 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341456;
	bh=n+Q9WKFcumC330vXhqPiRFjwN1teujk5gp9FOZUhxsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEmTDgw79wyxu8oF+iuFw+Yj4J7i0JnIC5B5BUKaZL32nWHPruWpDKeIZOxWzx2Wl
	 4lhEEjAnhPiohnq1nRu6Hc/Tf/8EUcU/TVFoWUfLvUQOe0wrZvnNLmjTuWLGlsH/4F
	 FrHDG8zGom/RHq2NxUVRncVRBMEd6ciEWBt6OrlHNSmmWiOBGswfy5EDbltDbWdgF/
	 jQRDTgNnuBRHhx7QAOpzCiViWz86jZagkDkxdyIxM4b80/Zin6z0K1JlsKG70pFfQL
	 zMO+GPvPkhBAv0PDrbyWwQaWZS7f5Nzbz9COiBPqArgrpbjjwKYiwksuH99nntNIqr
	 YWn1Rm/Bh4GuA==
Date: Mon, 16 Dec 2024 10:30:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, spujar@nvidia.com
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: Support channel page to
 nvidia,tegra210-adma
Message-ID: <x3cp6ho3ovwwarj3767ryoufvcqh5fe5fabtsjvrsg6ek6gjqz@iezeaqtav77o>
References: <20241213103939.3851827-1-mkumard@nvidia.com>
 <20241213103939.3851827-2-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213103939.3851827-2-mkumard@nvidia.com>

On Fri, Dec 13, 2024 at 04:09:38PM +0530, Mohan Kumar D wrote:
> Multiple ADMA Channel page hardware support has been added from
> TEGRA186 and onwards. Update the DT binding to use any of the
> ADMA channel page address space region.
> 
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---

This is v2 but no changelog, no explanation whatsoever... I assume
feedback was not implemented, so please go back to previous version and
address the feedback and then send proper new version with changelog.

See submitting patches.

Best regards,
Krzysztof


