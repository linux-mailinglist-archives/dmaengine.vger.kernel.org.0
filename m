Return-Path: <dmaengine+bounces-11456-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E/cuNPxyKmoIpgMAu9opvQ
	(envelope-from <dmaengine+bounces-11456-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:34:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463866FE6A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:34:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HT7cowPQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11456-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11456-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9653015A5C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3E2E6CC8;
	Thu, 11 Jun 2026 08:34:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10A33F5B4;
	Thu, 11 Jun 2026 08:34:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166842; cv=none; b=EPlMyNQLJUyoktfkZDc9KOwgaMOdApPwUdp8YKszPKY99H+gHHHmKD0bLWuC6CIi3sNaQVXuHJcV97jBwbWyY8N3Hvo4IESLQ8vXXwd/m9+XLietkhOtc1Gbha/d56Xze+2E8LqLCcDlJDN++s0k6qK128PPzfCamUQ2r4v35vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166842; c=relaxed/simple;
	bh=3CGN/Ux7Sk94mO3Rdpb0avzlgII2s++RCy/ySHECNFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juvIHrk8zer7n5Odw49ArmB0J2CeyWnYZ4hoAZrHwXYTAooRK1vTCG94DdFvXjfRLwzBSoJEmbhDlF+GqX4iLLCAD/PW4E35a7lnRxVt+AnT9urAFFfQIP6YtfpUm9m+3jI9RdHEcd05RnKwDwg8RPJMX7cWe+WXJ3hp17FvjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT7cowPQ; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781166842; x=1812702842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3CGN/Ux7Sk94mO3Rdpb0avzlgII2s++RCy/ySHECNFw=;
  b=HT7cowPQzLlH1mTS2vi6rlBAqnSNA0NckOHUrxGMy4LCGd+MU3qpjHfw
   LZiZwI5c0On2TEpgkrszijAoAGc9St8Pk0ArkbQdVrYj2WKYIAFmfJrj8
   mM8MdoLlvdnNIZWmPFgeWcUOvpXgk+VCN6nhLhg/bTrQn+F3GmCHxGSbN
   qYGPBPEsMykSd7j9oWmrC95pQ0MT4UXOV90wfyAuhzvw+91zIeublXZpQ
   7zRfRZuhcrU2QzZ/KXzNpvq0mHdh7iSQ/smRNm47Tr+SPmm8Y5cBf70Bn
   3xW8ib3oIcWbN8eO399/hdXzcdOz9m+tPdKlksJ50Q1BbEH1srEUH3E9f
   g==;
X-CSE-ConnectionGUID: Q6Hf7bb4TtOSnWmq3WYrwQ==
X-CSE-MsgGUID: WxA1ia57QEiQvvHoLSpzXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92539123"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92539123"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:34:01 -0700
X-CSE-ConnectionGUID: DuwDNvXGR4iBZ7oNWEKqcg==
X-CSE-MsgGUID: ysfWZ1iNTXWuUeA9xwNCRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="270092081"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:33:59 -0700
Date: Thu, 11 Jun 2026 11:33:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: Consistently define pci_device_ids
 using named initializers
Message-ID: <aipy9H6VUtDiK3fR@ashevche-desk.local>
References: <cover.1781161455.git.ukleinek@kernel.org>
 <c355276dd152ef312c29f7b9758a68f94aa77086.1781161455.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c355276dd152ef312c29f7b9758a68f94aa77086.1781161455.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11456-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:Basavaraj.Natikar@amd.com,m:vkoul@kernel.org,m:mani@kernel.org,m:vireshk@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,vger.kernel.org:from_smtp,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6463866FE6A

On Thu, Jun 11, 2026 at 09:45:10AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using named initializers is more explicit and thus easier
> to parse.
> 
> While touching these arrays, unify the list terminators to be just an
> empty struct with no trailing comma.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays, which was confirmed using x86 and arm64 builds.

...

>  static const struct pci_device_id pch_dma_id_table[] = {

This case is almost ready to use PCI_DEVICE_DATA() and I see no reason to not
go with it. The disadvantages of the proposed change here is that it makes
lines much longer without any good benefit.

So, just to state again: I disagree with changing this driver (pch_dma) in
the proposed way.

> -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> -	{ 0, },
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data = 8 },
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data = 8 },		/* UART Video */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data = 8 },		/* PCMIF SPI */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data = 4 },		/* FPGA */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data = 12 },	/* I2S */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data = 4 },		/* UART */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data = 4 },		/* Video SPI */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data = 4 },		/* Security */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data = 4 },		/* FPGA */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data = 8 },		/* UART */
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data = 4 },		/* SPI */
> +	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko



