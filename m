Return-Path: <dmaengine+bounces-6520-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFCB58391
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC2E7A482D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7D27280A;
	Mon, 15 Sep 2025 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdflKAhq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D819E98C;
	Mon, 15 Sep 2025 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957111; cv=none; b=R9h6F9P2BKbXbms5ztYbeJdwcWZ9YeCvNC2GTunMwqGhOxv42q2SOAuMcqVEsJlpQUyjwQELM50JX9ObpY56NQQMGqVwrpbeh0+sZZR6AusQXLKP3/FAaGv2KSujdF/EhVO4q4J4UX8p4ZuLgps6+qIU4gTez6MQlCa3+pifBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957111; c=relaxed/simple;
	bh=Jf5RWJayJESZY4g7dSFy919Y+bqt+e1RITsLC74dFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RkQ/tEvGHxie+YZzn0KLYdRY0jygkefliDGzKldMVzp4DJUoSHxZeIWQEjgisuxGhg1XB2f6ZJITVWp21taLE65cUCRfYxSU/e3W9bYOFHr7jyDjrlzGw7nr9MEDBZAB/jtrbQfqlR7/v0rLsnmKmkwMiJX+V1/5XtaFZQMz4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdflKAhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9591C4CEF1;
	Mon, 15 Sep 2025 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957111;
	bh=Jf5RWJayJESZY4g7dSFy919Y+bqt+e1RITsLC74dFN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sdflKAhqWItisuUvcuxwe8i7G/ik/fs/lm4El9CpRO7FaCZ4bOQzC/E17JhPDyuGT
	 xU0y5Yt4P08RexR6oxGT3nA5YtyzCISQgOLrbG2/6ilZ7mLvi+yie3FhodNHU2bPbH
	 a5LZ+juaTarmMGCOZLxQsxBn+X9vVXFm06g79UC+Dl7tNCBa7YmXsycZkjgYWKXB32
	 OrZYvSR3blPU3bRYLqAsV9G2Ac522K7tPvxcdiX0nAemD2WR9x4hJxnPgDZZFXrNZq
	 dkPRkVfTsrPNurcKeGWFEJwyhjVO0tu8POsuMory+1+gQQvreWPodzVmw5EV65m1+d
	 p6vW+3fMO6VAA==
Date: Mon, 15 Sep 2025 12:25:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] PCI: Add SNIA SDXI accelerator sub-class
Message-ID: <20250915172509.GA1751399@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sdxi-base-v1-1-d0341a1292ba@amd.com>

On Fri, Sep 05, 2025 at 01:48:24PM -0500, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> This was added to the PCI Code and ID Assignment Specification in
> revision 1.14 (2021). Refer to 1.19. "Base Class 12h" of that document
> as well as the "SDXI PCI-Express Device Architecture" chapter of the
> SDXI specification:

Would prefer if this said:

  Add sub-class code for SNIA Smart Data Accelerator Interface (SDXI).
  See PCI Code and ID Assignment spec r1.14, sec 1.19.

so the antecedent of "this" is here instead of in the subject and
"1.19" doesn't get confused with a spec revision.

> """
>   SDXI functions are expected to be identified through the SDXI class
>   code.
>   * SNIA Smart Data Accelerator Interface (SDXI) controller:
>     * Base Class = 0x12
>     * Sub Class = 0x01
>     * Programming Interface = 0x0
> """
> 
> Information about SDXI may be found at the SNIA website:
> 
>   https://www.snia.org/sdxi

I don't think the SDXI spec material is really necessary.  The PCI
Code and ID spec is definitive for class codes.

> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6de3dcf82226a50d0e36af366e888e..ac9bb3d64949919019d40d1f86cd3658bfb1c661 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -154,6 +154,7 @@
>  
>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
>  
>  #define PCI_CLASS_OTHERS		0xff
>  
> 
> -- 
> 2.39.5
> 
> 

