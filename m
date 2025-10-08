Return-Path: <dmaengine+bounces-6791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7ABC53D2
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4944F8F36
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F5285C83;
	Wed,  8 Oct 2025 13:37:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED134BA44;
	Wed,  8 Oct 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930641; cv=none; b=MkySk+ty+H3zGktCEAhBuqj7bMmNpgZJ+0FWr+F6RbjcCVyjzqtMYorwSD6cwLoEG+WXmRjD+oQWj/IF4bqUkHNucRp+4pAaR3duo/7CUHTm/5PoWToBFEQruoB/sGY2+lamSI3WGMKwXEOwUKJ0/xxnMmLtJxbC6y9rqTU5/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930641; c=relaxed/simple;
	bh=2++gi+3fbP2waS3+p89+F+/Sm7MsrHb0KRMpSa7Niw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEnrdvFQKHg/lMQKCOLw7xYox5ejB6dkaf62FIlyVFXvSAAhKIIm2E6FlsFBX6HN7EsEMbwcaf6qlSvDhFSbff6Up0D3K8+jg6VkE4hHiYxCNDwhmf08LaXq2Ntu8Z6dJcTfOBrMXA4wQtRE06b0QymhT6kauowOc/Pz1GQVA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 598DZFiu019619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 21:35:15 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Wed, 8 Oct 2025 21:35:15 +0800
Date: Wed, 8 Oct 2025 21:35:15 +0800
From: CL Wang <cl634@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	<gg@swlinux02.smtp.subspace.kernel.org>
CC: Conor Dooley <conor@kernel.org>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tim609@andestech.com>,
        <cl634@andestech.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <aOZokztqpHHX0JPq@swlinux02>
References: <20251002131659.973955-1-cl634@andestech.com>
 <20251002131659.973955-2-cl634@andestech.com>
 <20251002-absolute-spinning-f899e75b2c4a@spud>
 <aOUIfaZY7-eUYoOS@swlinux02>
 <734de17e-a712-4eb5-96fa-b7e75f86d880@kernel.org>
 <aOXW7HUMeOyABuUG@swlinux02>
 <dcd14886-f2cc-41ec-8bb5-9cb5ed50c452@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd14886-f2cc-41ec-8bb5-9cb5ed50c452@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 598DZFiu019619

Hi Krzysztof,

Thanks for the clarification, and sorry for the earlier confusion.

To elaborate on the rationale:
"andestech,atcdmac300" is the IP core name of the DMA controller, which serves
as a generic fallback compatible shared across multiple Andes SoCs.

Primary compatible (SoC-specific):
andestech,qilai-dma refers to the DMA controller instance implemented on the
Qilai SoC, following the SoC-specific recommendation.

Fallback compatible (IP-core specific):
andestech,atcdmac300 represents the reusable IP block used across different
Andes SoCs that share the same register map and programming model.

Keeping andestech,atcdmac300 as a fallback helps avoid code duplication and
allows a single driver to support future SoCs using the same hardware IP.

This approach follows the DeviceTree binding guideline:

“DO use a SoC-specific compatible for all SoC devices, followed by a fallback
if appropriate. SoC-specific compatibles are also preferred for the fallbacks.”
— Documentation/devicetree/bindings/writing-bindings.rst, line 42

Please let me know if this aligns with your expectation.

Best regards,
CL

On Wed, Oct 08, 2025 at 05:04:53PM +0900, Krzysztof Kozlowski wrote:
> [EXTERNAL MAIL]
> 
> On 08/10/2025 12:13, CL Wang wrote:
> > Hi Krzysztof,
> >
> > Thank you for pointing this out.
> >
> > "ATCDMAC300" is the IP block name of the DMA controller used in Andes SoC.
> > According to your suggestion, I have updated the binding to use SoC-specific
> > compatibles with "andestech,atcdmac300" as a fallback, as shown below:
> >
> > -  const: andestech,atcdmac300
> > +  items:
> > +    - enum:
> > +        - andestech,qilai-dma
> > +    - const: andestech,atcdmac300
> > ...
> >    dma-controller@f0c00000 {
> > -      compatible = "andestech,atcdmac300";
> > +      compatible = "andestech,qilai-dma", "andestech,atcdmac300";
> 
> That's exactly the same code as you pasted before. Please do not repeat
> the same as argument to my comment.
> 
> Best regards,
> Krzysztof

