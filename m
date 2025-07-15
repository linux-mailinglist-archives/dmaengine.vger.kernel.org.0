Return-Path: <dmaengine+bounces-5818-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08734B04EFD
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 05:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0141AA7337
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496B2D29C8;
	Tue, 15 Jul 2025 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVK29GIJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBE2D0C99;
	Tue, 15 Jul 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550142; cv=none; b=eGnRcxfpCB3WI+iq0Ur0wfm7cLJT1430PorZ1lXieraYQs9UFReUrSVzl4b/7tDk33ySTAeClnS4qAy8t803s+9lDpeQggf2HFkNtktrmuuy9imYHMd1ubKVwi2bylG3uoEYKlS5j+OmMTsKDCvdgSFMKWL9oFth1TmkTyKp1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550142; c=relaxed/simple;
	bh=OqSL6o8XLKZ7o6mDDJ9Dkj0z/7Mo30BcptyzbVfNxbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqth3qUgSz1BdIqsuaY9X+c/QdhHpF1/qnJcmZCpVsZcUtSjaHwcIiqBgJmblZRXrxCe5Z+alm6izO+4AwcLtQRxeMLu2aQo7K5eEuA313exiv9ZYFkRNiQeGDEjYZ8Ner9T/ZmIfYayPems0DUZetyXezlG8BJiiDzebDogcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVK29GIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE21C4CEED;
	Tue, 15 Jul 2025 03:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550141;
	bh=OqSL6o8XLKZ7o6mDDJ9Dkj0z/7Mo30BcptyzbVfNxbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVK29GIJfQFd400woxXrFFfAlvZiAPSd7Mh03QuBC/iBY7NUYlO73a6B3tQvKo+zL
	 JjQl9usaYQ60m4AMsPiLeagDDzIoEFjwW4ilK7i6fZXhSdnKvvfEyfAPWfBWO/vIon
	 OAaN4QB9qE7MRc4jStTAicRvlIjFkB2YsaNk4NSSyzqgyXifpZmtoM1v5Y5roQpG9X
	 h38ulFXdOTboNhgUT+ReZXemu/SUQTfv0kr9d0nLouWQeCVlZXgFWUgwqTehyp6gZo
	 Wbm2n/ikAMJ5vPieDQuje9ZsbffviXAuXSteXQVVcnB2h/V0sKeyCaU9Pzr/u+ZSsD
	 T+G489dNRGDYg==
Date: Mon, 14 Jul 2025 22:29:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: dmaengine@vger.kernel.org, Das Srinagesh <quic_gurus@quicinc.com>,
	~postmarketos/upstreaming@lists.sr.ht,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-mmc@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Vinod Koul <vkoul@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
	linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 09/15] dt-bindings: dma: qcom,gpi: document the Milos
 GPI DMA Engine
Message-ID: <175255013986.4171175.13096534892650762212.robh@kernel.org>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-9-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-sm7635-fp6-initial-v2-9-e8f9a789505b@fairphone.com>


On Sun, 13 Jul 2025 10:05:31 +0200, Luca Weiss wrote:
> Document the GPI DMA Engine on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


